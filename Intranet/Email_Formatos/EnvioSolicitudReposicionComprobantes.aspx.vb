Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class EnvioSolicitudReposicionComprobantes
    Inherits System.Web.UI.Page

    Public EMAIL_LOCALE As String = "es"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Not Request.QueryString("id") Is Nothing Then
                Me.lblId.Text = Request.QueryString("id")
                Me.lblTipo.Text = Request.QueryString("t")
                Me.CargaFormulario(Request.QueryString("r"))
            End If

        End If
    End Sub

    Private Sub CargaFormulario(rechazo As String)
        Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Dim url_base As String = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()

        Dim ds As DataSet = solicitud_reposicion.RecuperaEmail(Convert.ToInt32(Me.lblId.Text))
        Dim dt As DataTable = ds.Tables(0)
        Dim dtTotales As DataTable = ds.Tables(1)

        If dt.Rows.Count > 0 Then
            Dim dr As DataRow = dt.Rows(0)
            If dr("id_empresa") = 12 Then
                EMAIL_LOCALE = "en"
            End If
            txtIdEmpresa.Value = dr("id_empresa")

            If rechazo = "1" Then
                lblTitulo.Text = TranslateLocale.text("Sus Comprobantes de Gastos han sido rechazados:", EMAIL_LOCALE)
            ElseIf rechazo = "2" Then
                lblTitulo.Text = TranslateLocale.text("Solicitud de Reposicion rechazada:", EMAIL_LOCALE)
            Else
                lblTitulo.Text = TranslateLocale.text("Solicitud de Autorizacion de Comprobantes de Gastos con la siguiente información:", EMAIL_LOCALE)
            End If

            If rechazo = "1" Or rechazo = "2" Then
                lblNombre.Text = dr("empleado_solicita").ToString()
            Else
                If Me.lblTipo.Text = "J" Then
                    lblNombre.Text = dr("comprobacion_jefe").ToString()
                Else
                    lblNombre.Text = dr("comprobacion_conta").ToString()
                End If
            End If


            lblFolio.Text = dr("folio_txt").ToString()
            lblEmpleadoSolicita.Text = dr("empleado_solicita").ToString()
            lblEmpleadoDeudor.Text = dr("empleado_viaja").ToString()
            lblComentarios.Text = dr("comentarios").ToString()
            lblAutorizaJefe.Text = dr("comprobacion_jefe").ToString()
            lblAutorizaConta.Text = dr("comprobacion_conta").ToString()
            lblAutorizaOperaciones.Text = dr("comprobacion_operaciones").ToString()
            lblAutorizaMateriales.Text = dr("comprobacion_materiales").ToString()
            lblAutorizaComidasInternas.Text = dr("comprobacion_comidas_internas").ToString()

            If solicitud_reposicion.RequiereAutorizacionDeOperaciones(Me.lblId.Text) = True Then
                trAutorizaOperaciones.Visible = True
            End If
            If solicitud_reposicion.RequiereAutorizacionDeMateriales(Me.lblId.Text, False) = True Then
                trAutorizaMateriales.Visible = True
            End If
            If solicitud_reposicion.RequiereAutorizacionDeComidasInternas(Me.lblId.Text) = True Then
                trAutorizaComidasInternas.Visible = True
            End If
            lblEmpresa.Text = dr("empresa").ToString()
            lblDepartamento.Text = dr("departamento").ToString()
            lblEstatus.Text = TranslateLocale.text(dr("estatus").ToString(), EMAIL_LOCALE)

            If rechazo = "2" And Not IsDBNull(dr("estatus_comentarios")) Then
                trMotivoRechazo.Visible = True
                lblMotivoRechazo.Text = dr("estatus_comentarios")
            End If

            If rechazo = "1" Or rechazo = "2" Then
                lnkDetalle.Visible = False
                lnkAutoriza.Visible = False
                lnkRechaza.Visible = False
            Else
                lnkDetalle.HRef = url_base & "SolicitudReposicion.aspx"

                Dim valores As String = "&id=" & Request.QueryString("id")
                If Me.lblTipo.Text = "J" Then
                    valores += "&t=3&ida=" & dr("id_autoriza_jefe")
                Else
                    valores += "&t=4&ida=" & dr("id_autoriza_conta")
                End If

                lnkAutoriza.HRef = url_base & "SolicitudReposicionAutoriza.aspx?auth=1" & valores
                lnkRechaza.HRef = url_base & "SolicitudReposicionAutoriza.aspx?auth=0" & valores

            End If

        End If

        If dtTotales.Rows.Count > 0 Then
            Me.lblPesos.Text = Format(dtTotales.Rows(0)("MXP"), "###,###,##0.00")
            Me.lblDolares.Text = Format(dtTotales.Rows(0)("USD"), "###,###,##0.00")
            Me.lblEuros.Text = Format(dtTotales.Rows(0)("EUR"), "###,###,##0.00")
        End If

        Me.CargaConceptos()
    End Sub

    Protected Sub CargaConceptos()
        Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim ds As DataSet = solicitud_reposicion.RecuperaConceptos(Me.lblId.Text, EMAIL_LOCALE)
        Dim dt As DataTable = ds.Tables(0)

        If dt.Rows.Count > 0 Then
            Me.gvConceptos.DataSource = dt
            Funciones.TranslateGridviewHeader(gvConceptos, EMAIL_LOCALE)
            Me.gvConceptos.DataBind()
            Me.divDetalleCombrobantes.Visible = True
        Else
            Me.divDetalleCombrobantes.Visible = False
        End If
    End Sub


    Private Sub gvConceptos_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvConceptos.RowDataBound

        If e.Row.RowType = DataControlRowType.Header Then
            If Me.txtIdEmpresa.Value = 12 Then
                e.Row.Cells(10).Text = "Total USD"
            End If
        End If

    End Sub


End Class
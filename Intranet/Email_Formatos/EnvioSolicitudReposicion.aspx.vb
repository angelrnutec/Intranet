Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class EnvioSolicitudReposicion
    Inherits System.Web.UI.Page

    Public EMAIL_LOCALE As String = "es"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Not Request.QueryString("id") Is Nothing Then
                Me.lblId.Text = Request.QueryString("id")
                Me.lblTipo.Text = Request.QueryString("t")
                Me.CargaFormulario()
            End If

        End If
    End Sub

    Private Sub CargaFormulario()
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

            lblTitulo.Text = TranslateLocale.text("Solicitud de Autorizacion de Comprobantes de Gastos con la siguiente información:", EMAIL_LOCALE)

            If Me.lblTipo.Text = "J" Then
                lblNombre.Text = dr("comprobacion_jefe").ToString() & "(" & TranslateLocale.text("JEFE DIR", EMAIL_LOCALE) & ")"
            ElseIf Me.lblTipo.Text = "O" Then
                lblNombre.Text = dr("comprobacion_operaciones").ToString() & "(" & TranslateLocale.text("OPERACIONES", EMAIL_LOCALE) & ")"
            ElseIf Me.lblTipo.Text = "M" Then
                lblNombre.Text = dr("comprobacion_materiales").ToString() & "(" & TranslateLocale.text("MATERIALES", EMAIL_LOCALE) & ")"
            ElseIf Me.lblTipo.Text = "CI" Then
                lblNombre.Text = dr("comprobacion_comidas_internas").ToString() & "(" & TranslateLocale.text("COMIDAS INTERNAS", EMAIL_LOCALE) & ")"
            Else
                lblNombre.Text = dr("comprobacion_conta").ToString() & "(" & TranslateLocale.text("CONTABILIDAD", EMAIL_LOCALE) & ")"
            End If

            lblFolio.Text = dr("folio_txt").ToString()
            lblEmpleadoSolicita.Text = dr("empleado_solicita").ToString()
            lblEmpleadoDeudor.Text = dr("empleado_viaja").ToString()
            lblAutorizaJefe.Text = dr("comprobacion_jefe").ToString()
            lblAutorizaConta.Text = dr("comprobacion_conta").ToString()

            lblAutorizaOperaciones.Text = dr("comprobacion_operaciones").ToString()
            If solicitud_reposicion.RequiereAutorizacionDeOperaciones(Me.lblId.Text) = True Then
                trAutorizaOperaciones.Visible = True
            End If
            lblAutorizaMateriales.Text = dr("comprobacion_materiales").ToString()
            If solicitud_reposicion.RequiereAutorizacionDeMateriales(Me.lblId.Text, False) = True Then
                trAutorizaMateriales.Visible = True
            End If

            lblAutorizaComidasInternas.Text = dr("comprobacion_comidas_internas").ToString()
            If solicitud_reposicion.RequiereAutorizacionDeComidasInternas(Me.lblId.Text) = True Then
                trAutorizaComidasInternas.Visible = True
            End If

            lblEmpresa.Text = dr("empresa").ToString()
            lblDepartamento.Text = dr("departamento").ToString()
            lblComentarios.Text = dr("comentarios").ToString()
            lblEstatus.Text = TranslateLocale.text(dr("estatus").ToString(), EMAIL_LOCALE)

            lnkDetalle.HRef = url_base & "SolicitudReposicion.aspx"


            Dim valores As String = "&id=" & Request.QueryString("id")
            If Me.lblTipo.Text = "J" Then
                valores += "&t=1&ida=" & dr("id_autoriza_jefe")
            ElseIf Me.lblTipo.Text = "O" Then
                valores += "&t=5&ida=" & dr("id_autoriza_operaciones")
            ElseIf Me.lblTipo.Text = "M" Then
                valores += "&t=6&ida=" & dr("id_autoriza_materiales")
            ElseIf Me.lblTipo.Text = "CI" Then
                valores += "&t=7&ida=" & dr("id_autoriza_comidas_internas")
            Else
                valores += "&t=2&ida=" & dr("id_autoriza_conta")
            End If

            lnkAutoriza.HRef = url_base & "SolicitudReposicionAutoriza.aspx?auth=1" & valores
            lnkRechaza.HRef = url_base & "SolicitudReposicionAutoriza.aspx?auth=0" & valores
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
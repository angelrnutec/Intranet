Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class EnvioSolicitudCancelacionVacaciones
    Inherits System.Web.UI.Page

    Public EMAIL_LOCALE As String = "es"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Not Request.QueryString("id") Is Nothing Then
                Me.lblId.Text = Request.QueryString("id")
                If Not Request.QueryString("auth") Is Nothing Then
                    Me.lblAuth.Text = Request.QueryString("auth")
                End If

                Me.CargaFormulario()
            End If

        End If
    End Sub

    Private Sub CargaFormulario()
        Dim solicitud_vacaciones As New SolicitudCancelacionVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Dim url_base As String = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()

        Dim dt As DataTable = solicitud_vacaciones.RecuperaEmail(Convert.ToInt32(Me.lblId.Text))

        If dt.Rows.Count > 0 Then
            Dim dr As DataRow = dt.Rows(0)
            If dr("id_empresa") = 12 Then
                EMAIL_LOCALE = "en"
            End If

            If Me.lblAuth.Text = "1" Then
                lblTitulo.Text = TranslateLocale.text("Se ha autorizado la siguiente cancelación de vacaciones:", EMAIL_LOCALE)
                lblNombre.Text = TranslateLocale.text("Estimado(a)", EMAIL_LOCALE) & "&nbsp;" & dr("empleado_solicita").ToString()
            ElseIf Me.lblAuth.Text = "2" Then
                lblTitulo.Text = TranslateLocale.text("Se ha autorizado la siguiente cancelación de vacaciones:", EMAIL_LOCALE)
                lblNombre.Text = ""
            ElseIf Me.lblAuth.Text = "0" Then
                lblTitulo.Text = TranslateLocale.text("Se ha rechazado la siguiente cancelación de vacaciones:", EMAIL_LOCALE)
                lblNombre.Text = TranslateLocale.text("Estimado(a)", EMAIL_LOCALE) & "&nbsp;" & dr("empleado_solicita").ToString()

                If Not IsDBNull(dr("estatus_comentarios")) Then
                    trMotivoRechazo.Visible = True
                    lblMotivoRechazo.Text = dr("estatus_comentarios")
                End If

            Else
                lblTitulo.Text = TranslateLocale.text("Se ha generado una cancelación de vacaciones con la siguiente información:", EMAIL_LOCALE)
                lblNombre.Text = TranslateLocale.text("Estimado(a)", EMAIL_LOCALE) & "&nbsp;" & dr("autoriza_jefe").ToString()
            End If

            lblFolio.Text = dr("folio_txt").ToString()
            lblEmpleadoSolicita.Text = dr("empleado_solicita").ToString()
            lblAutorizaJefe.Text = dr("autoriza_jefe").ToString()
            lblEmpresa.Text = dr("empresa").ToString()
            lblNomina.Text = dr("nomina").ToString()
            'lblDias.Text = dr("dias").ToString()

            'If dr("fecha_registro") > New DateTime(2015, 9, 21) Then
            '    lblDiasProporcionales.Text = "0"
            '    lblDiasDisponibles.Text = (dr("dias_disponibles") + dr("dias") - dr("dias_en_proceso")).ToString()
            'Else
            '    lblDiasProporcionales.Text = (dr("dias") * 0.2).ToString()
            '    lblDiasDisponibles.Text = (dr("dias_disponibles") + (dr("dias") * 0.2) + dr("dias") - dr("dias_en_proceso")).ToString()
            'End If

            'lblDiasFinal.Text = (dr("dias_disponibles") - dr("dias_en_proceso")).ToString()

            lblComentarios.Text = dr("comentarios").ToString()
            lblEstatus.Text = TranslateLocale.text(dr("estatus").ToString(), EMAIL_LOCALE)
            lblFechaInicio.Text = dr("fechas").ToString()
            'lblFechaFin.Text = Convert.ToDateTime(dr("fecha_fin").ToString()).ToString("dd/MM/yyyy")


            divAcciones.Visible = False
            If Me.lblAuth.Text = "" Then
                lnkDetalle.HRef = url_base & "SolicitudCancelacionVacaciones.aspx"
                Dim valores As String = "&id=" & Request.QueryString("id") & "&ida=" & dr("id_autoriza_jefe")
                lnkAutoriza.HRef = url_base & "SolicitudCancelacionVacacionesAutoriza.aspx?auth=1" & valores
                lnkRechaza.HRef = url_base & "SolicitudCancelacionVacacionesAutoriza.aspx?auth=0" & valores

                divAcciones.Visible = True
            End If

        End If
    End Sub


End Class
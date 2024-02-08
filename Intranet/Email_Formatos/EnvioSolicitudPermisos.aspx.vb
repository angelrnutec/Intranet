Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class EnvioSolicitudPermisos
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
        Dim solicitud_permisos As New SolicitudPermiso(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Dim url_base As String = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()

        Dim dt As DataTable = solicitud_permisos.RecuperaEmail(Convert.ToInt32(Me.lblId.Text))

        If dt.Rows.Count > 0 Then
            Dim dr As DataRow = dt.Rows(0)
            If dr("id_empresa") = 12 Then
                EMAIL_LOCALE = "en"
            End If

            If Me.lblAuth.Text = "1" Then
                If Request.QueryString("nom") Is Nothing Then
                    lblTitulo.Text = TranslateLocale.text("Se ha autorizado la siguiente solicitud de permisos:", EMAIL_LOCALE)
                    lblNombre.Text = TranslateLocale.text("Estimado(a)", EMAIL_LOCALE) & "&nbsp;" & dr("empleado_solicita").ToString()
                Else
                    lblTitulo.Text = TranslateLocale.text("Se ha autorizado la solicitud de permisos de", EMAIL_LOCALE) & ": " & dr("empleado_solicita").ToString()
                    lblNombre.Text = TranslateLocale.text("Estimado(a)", EMAIL_LOCALE) & "&nbsp;" & dr("nomina").ToString()
                End If
            ElseIf Me.lblAuth.Text = "2" Then
                lblTitulo.Text = TranslateLocale.text("Se ha autorizado la siguiente solicitud de permisos:", EMAIL_LOCALE)
                lblNombre.Text = ""
            ElseIf Me.lblAuth.Text = "0" Then
                lblTitulo.Text = TranslateLocale.text("Se ha rechazado la siguiente solicitud de permisos:", EMAIL_LOCALE)
                lblNombre.Text = TranslateLocale.text("Estimado(a)", EMAIL_LOCALE) & "&nbsp;" & dr("empleado_solicita").ToString()

                If Not IsDBNull(dr("estatus_comentarios")) Then
                    trMotivoRechazo.Visible = True
                    lblMotivoRechazo.Text = dr("estatus_comentarios")
                End If

            Else
                lblTitulo.Text = TranslateLocale.text("Se ha generado una solicitud de permiso con la siguiente información:", EMAIL_LOCALE)
                If Request.QueryString("tipo") = "J" Then
                    lblNombre.Text = TranslateLocale.text("Estimado(a)", EMAIL_LOCALE) & "&nbsp;" & dr("autoriza_jefe").ToString() & " (" & TranslateLocale.text("Jefe Directo", EMAIL_LOCALE) & ")"
                ElseIf Request.QueryString("tipo") = "D" Then
                    lblNombre.Text = TranslateLocale.text("Estimado(a)", EMAIL_LOCALE) & "&nbsp;" & dr("director").ToString() & " (" & TranslateLocale.text("Director de Area", EMAIL_LOCALE) & ")"
                ElseIf Request.QueryString("tipo") = "G" Then
                    lblNombre.Text = TranslateLocale.text("Estimado(a)", EMAIL_LOCALE) & "&nbsp;" & dr("gerente").ToString() & " (" & TranslateLocale.text("Gerente", EMAIL_LOCALE) & ")"
                End If
            End If

            lblFolio.Text = dr("folio_txt").ToString()
            lblEmpleadoSolicita.Text = dr("empleado_solicita").ToString()
            lblAutorizaJefe.Text = dr("autoriza_jefe").ToString()
            lblEmpresa.Text = dr("empresa").ToString()
            lblNomina.Text = dr("nomina").ToString()
            lblDirectorArea.Text = dr("director").ToString()
            lblGerente.Text = dr("gerente").ToString()
            lblDias.Text = dr("dias").ToString()

            lblConcepto.Text = dr("tipo_permiso") & " (" & IIf(dr("con_goce"), TranslateLocale.text("Con Goce de Sueldo", EMAIL_LOCALE), TranslateLocale.text("Sin Goce de Sueldo", EMAIL_LOCALE)) & ")"

            If dr("id_tipo_permiso") = "2" Then
                Me.trViajeProlongado.Visible = True
                Me.lblFechasViajeProlongado.Text = "Del " & Format(dr("fecha_viaje_prolongado_ini"), "dd/MM/yyyy") & " al " & Format(dr("fecha_viaje_prolongado_fin"), "dd/MM/yyyy")
            End If

            lblComentarios.Text = dr("comentarios").ToString()
            lblEstatus.Text = TranslateLocale.text(dr("estatus").ToString(), EMAIL_LOCALE)
            lblFechaInicio.Text = Convert.ToDateTime(dr("fecha_ini").ToString()).ToString("dd/MM/yyyy")
            lblFechaFin.Text = Convert.ToDateTime(dr("fecha_fin").ToString()).ToString("dd/MM/yyyy")


            divAcciones.Visible = False
            If Me.lblAuth.Text = "" Then
                lnkDetalle.HRef = url_base & "SolicitudPermisos.aspx"

                If Request.QueryString("tipo") = "J" Then
                    Dim valores As String = "&id=" & Request.QueryString("id") & "&ida=" & dr("id_autoriza_jefe")
                    lnkAutoriza.HRef = url_base & "SolicitudPermisosAutoriza.aspx?t=1&auth=1" & valores
                    lnkRechaza.HRef = url_base & "SolicitudPermisosAutoriza.aspx?t=1&auth=0" & valores
                ElseIf Request.QueryString("tipo") = "D" Then
                    Dim valores As String = "&id=" & Request.QueryString("id") & "&ida=" & dr("id_empleado_director")
                    lnkAutoriza.HRef = url_base & "SolicitudPermisosAutoriza.aspx?t=2&auth=1" & valores
                    lnkRechaza.HRef = url_base & "SolicitudPermisosAutoriza.aspx?t=2&auth=0" & valores
                ElseIf Request.QueryString("tipo") = "G" Then
                    Dim valores As String = "&id=" & Request.QueryString("id") & "&ida=" & dr("id_empleado_gerente")
                    lnkAutoriza.HRef = url_base & "SolicitudPermisosAutoriza.aspx?t=3&auth=1" & valores
                    lnkRechaza.HRef = url_base & "SolicitudPermisosAutoriza.aspx?t=3&auth=0" & valores
                End If

                divAcciones.Visible = True
            End If

        End If
    End Sub


End Class
Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class EnvioAutorizacionArrendamiento
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
        Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Dim url_base As String = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()

        Dim dt As DataTable = arrendamiento.RecuperaEmail(Convert.ToInt32(Me.lblId.Text))

        If dt.Rows.Count > 0 Then
            Dim dr As DataRow = dt.Rows(0)
            Dim idUsuario As Integer = 0
            If dr("id_empresa") = 12 Then
                EMAIL_LOCALE = "en"
            End If

            If Me.lblAuth.Text = "0" Then
                lblTitulo.Text = TranslateLocale.text("Se ha rechazado el siguiente arrendamiento:", EMAIL_LOCALE)
                lblNombre.Text = TranslateLocale.text("Estimado(a)", EMAIL_LOCALE) & "&nbsp;" & dr("empleado_solicita").ToString()

                If Not IsDBNull(dr("rechazo_msg")) Then
                    trMotivoRechazo.Visible = True
                    lblMotivoRechazo.Text = dr("rechazo_msg")
                End If

            ElseIf Me.lblAuth.Text = "1" Then
                lblTitulo.Text = TranslateLocale.text("Se solicita su autorización para el arrendamiento siguiente:", EMAIL_LOCALE)
                lblNombre.Text = TranslateLocale.text("Estimado(a)", EMAIL_LOCALE) & "&nbsp;" & dr("usuario_auth_rh").ToString()
                idUsuario = dr("id_autoriza_director_rh")
            ElseIf Me.lblAuth.Text = "2" Then
                lblTitulo.Text = TranslateLocale.text("Se solicita su autorización para el arrendamiento siguiente:", EMAIL_LOCALE)
                lblNombre.Text = TranslateLocale.text("Estimado(a)", EMAIL_LOCALE) & "&nbsp;" & dr("usuario_auth_negocios").ToString()
                idUsuario = dr("id_autoriza_director_negocio")
            ElseIf Me.lblAuth.Text = "3" Then
                lblTitulo.Text = TranslateLocale.text("Se solicita su autorización para el arrendamiento siguiente:", EMAIL_LOCALE)
                lblNombre.Text = TranslateLocale.text("Estimado(a)", EMAIL_LOCALE) & "&nbsp;" & dr("usuario_auth_finanzas").ToString()
                idUsuario = dr("id_autoriza_director_finanzas")
            ElseIf Me.lblAuth.Text = "4" Then
                lblTitulo.Text = TranslateLocale.text("Dir. RH dio su autorización para el arrendamiento siguiente:", EMAIL_LOCALE)
                lblNombre.Text = ""
            ElseIf Me.lblAuth.Text = "5" Then
                lblTitulo.Text = TranslateLocale.text("Dir. Negocio dio su autorización para el arrendamiento siguiente:", EMAIL_LOCALE)
                lblNombre.Text = ""
            ElseIf Me.lblAuth.Text = "6" Then
                lblTitulo.Text = TranslateLocale.text("Dir. Finanzas dio su autorización para el arrendamiento siguiente:", EMAIL_LOCALE)
                lblNombre.Text = ""

            End If

            Me.lblNumero.Text = dr("numero").ToString()
            Me.lblEmpleadoSolicita.Text = dr("usuario_registro").ToString()
            Me.lblAsignado.Text = dr("asignado")
            Me.lblAutorizaRH.Text = dr("usuario_auth_rh").ToString()
            Me.lblAutorizaFinanzas.Text = dr("usuario_auth_finanzas").ToString()
            Me.lblAutorizaNegocio.Text = dr("usuario_auth_negocios").ToString()
            Me.lblEmpresa.Text = dr("empresa").ToString()
            Me.lblEstatus.Text = TranslateLocale.text(dr("estatus").ToString(), EMAIL_LOCALE)

            Me.lblDepartamento.Text = dr("departamento")
            Me.lblCategoria.Text = dr("categoria_arrendamiento")


            If dr("id_categoria_arrendamiento") = 1 Then
                Me.trAutorizaNegocio.Visible = True
                Me.trAutorizaRH.Visible = True
            Else
                Me.trAutorizaNegocio.Visible = False
                Me.trAutorizaRH.Visible = False
            End If

            divAcciones.Visible = False
            If Me.lblAuth.Text = "1" Or Me.lblAuth.Text = "2" Or Me.lblAuth.Text = "3" Then
                lnkDetalle.HRef = url_base & "ArrendamientoDetalle.aspx?id=" & dr("id_arrendamiento")
                Dim valores As String = "&id=" & dr("id_arrendamiento") & "&ida=" & idUsuario & "&t=" & Me.lblAuth.Text
                lnkAutoriza.HRef = url_base & "ArrendamientoAutoriza.aspx?auth=1" & valores
                lnkRechaza.HRef = url_base & "ArrendamientoAutoriza.aspx?auth=0" & valores

                divAcciones.Visible = True
            End If

        End If
    End Sub


End Class
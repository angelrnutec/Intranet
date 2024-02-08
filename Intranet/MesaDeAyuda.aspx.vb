Imports IntranetBL

Public Class MesaDeAyuda
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then

            Dim ruta As String = System.Configuration.ConfigurationManager.AppSettings("LINK_MESA_AYUDA")
            Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            ruta = ruta & "?u=" & seguridad.RecuperaUsuarioEncriptado(Session("idEmpleado")) & "&locale=" & Funciones.CurrentLocale
            'Me.iFrame.Attributes("src") = ruta
            Me.iFramex.Attributes("src") = ruta

        End If

    End Sub

End Class
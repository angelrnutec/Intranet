Imports IntranetBL

Public Class HorasHombre
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then

            Dim ruta As String = System.Configuration.ConfigurationManager.AppSettings("LINK_HORAS_HOMBRE")
            Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Me.iFramex.Attributes("src") = ruta

        End If

    End Sub

End Class
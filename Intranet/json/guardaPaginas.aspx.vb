Imports IntranetBL

Public Class guardaPaginas
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim id_perfil As Integer = Request.Form("id_perfil")
        Dim paginas As String = Request.Form("paginas")

        Response.Clear()
        Try
            Dim cc As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            cc.EliminaPaginasPerfil(id_perfil)
            cc.GuardaPaginasPerfil(id_perfil, paginas)
            
            Response.Write("Datos guardados correctamente")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        Response.End()
    End Sub

End Class
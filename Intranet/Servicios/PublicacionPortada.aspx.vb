Imports IntranetBL

Public Class PublicacionPortada
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Request.QueryString("id") Is Nothing Then

            Dim publicacion As New Publicacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Dim stringBuilder As New StringBuilder("")
            Dim dtDocumentos As DataTable = publicacion.RecuperaPorId(Request.QueryString("id"))
            For Each drD As DataRow In dtDocumentos.Rows
                stringBuilder.AppendLine(drD("liga_banner"))
            Next

            Response.Clear()
            Response.ExpiresAbsolute = DateTime.Now
            Response.Expires = -1441
            Response.CacheControl = "no-cache"
            Response.AddHeader("Pragma", "no-cache")
            Response.AddHeader("Pragma", "no-store")
            Response.AddHeader("cache-control", "no-cache")
            Response.Cache.SetCacheability(HttpCacheability.NoCache)
            Response.Cache.SetNoServerCaching()

            Response.Write(stringBuilder.ToString())
            Response.End()

        End If

    End Sub
End Class
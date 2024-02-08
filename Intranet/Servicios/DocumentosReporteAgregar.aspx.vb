Imports IntranetBL

Public Class DocumentosReporteAgregar
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Request.QueryString("anio") Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            reporte.GuardaReporteEjecutivoComentariosArchivo(Request.QueryString("anio"), Request.QueryString("periodo"), Request.QueryString("tipo"), Request.QueryString("nombre"))

            Response.Clear()
            Response.ExpiresAbsolute = DateTime.Now
            Response.Expires = -1441
            Response.CacheControl = "no-cache"
            Response.AddHeader("Pragma", "no-cache")
            Response.AddHeader("Pragma", "no-store")
            Response.AddHeader("cache-control", "no-cache")
            Response.Cache.SetCacheability(HttpCacheability.NoCache)
            Response.Cache.SetNoServerCaching()

            Response.Write("")
            Response.End()

        End If

    End Sub

End Class
Imports IntranetBL

Public Class DocumentosReporte
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Request.QueryString("anio") Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Dim stringBuilder As New StringBuilder("")
            Dim dtDocumentos As DataTable = reporte.RecuperaReporteEjecutivoComentariosArchivo(Request.QueryString("anio"), Request.QueryString("periodo"), Request.QueryString("tipo"))
            For Each drD As DataRow In dtDocumentos.Rows
                stringBuilder.AppendLine("<span>" & drD("archivo") & "</span><div class='linkMultimedia'><a href=" & Chr(34) & _
                                         "javascript:AgregarDocMinuta('/uploads/','" & drD("archivo") & "');" & Chr(34) & _
                                         ">(Agregar a la Minuta)</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a href=" & Chr(34) & _
                                         "javascript:AgregarDocResumen('/uploads/','" & drD("archivo") & "');" & Chr(34) & _
                                         ">(Agregar al Resumen)</a></div><br />")
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
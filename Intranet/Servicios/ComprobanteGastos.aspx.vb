Imports IntranetBL

Public Class ComprobanteGastos
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Request.QueryString("id") Is Nothing Then

            Dim solicitud As New SolicitudDocumento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Dim stringBuilder As New StringBuilder("")
            Dim dtDocumentos As DataTable = solicitud.RecuperaSolicitudDocumento(Request.QueryString("id"), Request.QueryString("tipo"))
            Dim id_detalle_ant As Integer = -1
            For Each drD As DataRow In dtDocumentos.Rows
                If id_detalle_ant <> drD("id_solicitud_detalle") Then
                    stringBuilder.AppendLine("##divDocs_" & drD("id_solicitud_detalle") & "||")
                End If
                stringBuilder.AppendLine("<div class='linkMultimedia'><a href='/uploads/" & Server.UrlEncode(drD("documento")) & "' target='_blank'>" & drD("documento") & "</a>&nbsp;&nbsp;" & _
                                         "<a href='javascript:EliminarDocumento(" & drD("id_documento") & ")'>(Eliminar)</a></div>")

                id_detalle_ant = drD("id_solicitud_detalle")
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
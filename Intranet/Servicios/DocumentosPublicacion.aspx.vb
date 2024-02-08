Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class DocumentosPublicacion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Request.QueryString("id") Is Nothing Then

            Dim publicacion As New Publicacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Dim stringBuilder As New StringBuilder("")
            Dim dtDocumentos As DataTable = publicacion.RecuperaPublicacionDocumento(Request.QueryString("id"))

            If Not Request.QueryString("t") Is Nothing And Not Request.QueryString("l") Is Nothing Then
                For Each drD As DataRow In dtDocumentos.Rows
                    stringBuilder.AppendLine("<a href='/uploads/" & drD("documento") & "' target='_blank'><img src='/uploads/" & drD("documento") & "' style='max-width:200px;' border='0' /></a><br /><br />")
                Next
            ElseIf Not Request.QueryString("t") Is Nothing Then
                For Each drD As DataRow In dtDocumentos.Rows
                    stringBuilder.AppendLine("<img src='/uploads/" & drD("documento") & "' style='max-width:200px;' />&nbsp;<a href='#' onclick='javascript:EliminarDocumento(" & _
                                             drD("id_documento") & ")'>(" & TranslateLocale.text("Eliminar") & ")</a>" & UsarComoPortada(drD("documento"), drD("id_documento")) & "<br /><br />")
                Next
            Else

                For Each drD As DataRow In dtDocumentos.Rows
                    stringBuilder.AppendLine("<span>" & drD("documento") & "</span><div class='linkMultimedia'><a href='#' onclick=" & Chr(34) & _
                                             "javascript:AgregarDocumentoALaPublicacion('/uploads/','" & drD("documento") & "');" & Chr(34) & _
                                             ">(" & TranslateLocale.text("Agregar a la publicación") & ")</a>&nbsp;&nbsp;&nbsp;&nbsp;<a href='javascript:EliminarDocumento(" & _
                                             drD("id_documento") & ")'>(" & TranslateLocale.text("Eliminar") & ")</a>" & UsarComoPortada(drD("documento"), drD("id_documento")) & "</div><br />")
                Next
            End If

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

    Private Function UsarComoPortada(archivo As String, id_documento As Integer) As String
        Dim extension As String = System.IO.Path.GetExtension(archivo).ToLower()
        If extension = ".png" Or extension = ".jpg" Or extension = ".jpeg" Or extension = ".bmp" Then
            Return "&nbsp;&nbsp;&nbsp;&nbsp;<a href='#' onclick='javascript:UsarComoPortada(" & Chr(34) & archivo & Chr(34) & ");'>(" & TranslateLocale.text("Usar como portada") & ")</a>"
        End If

        Return ""
    End Function

End Class
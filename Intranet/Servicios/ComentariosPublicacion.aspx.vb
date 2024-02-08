Imports IntranetBL

Public Class ComentariosPublicacion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Request.Form("t") Is Nothing Then
            Dim publicacion As New Publicacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim stringBuilder As New StringBuilder("")

            If Request.Form("t") = "1" Then
                Dim id As String = Request.Form("id")
                Dim idt As String = Request.Form("idt")
                Dim comentario As String = Request.Form("comentario")
                publicacion.GuardaComentario(idt, id, comentario)
            Else
                Dim dtComentarios As DataTable = publicacion.RecuperaComentarios(Request.Form("id"), Request.Form("idu"))
                For Each drD As DataRow In dtComentarios.Rows
                    stringBuilder.Append(drD("id_comentario") & "|" & _
                                             drD("id_empleado") & "|" & _
                                             drD("comentario") & "|" & _
                                             drD("fecha_registro") & "|" & _
                                             drD("empleado") & "|" & _
                                             drD("fotografia") & "||")
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

End Class
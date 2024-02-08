Imports IntranetBL
Imports System.IO

Public Class ComprobanteGastosAgregar
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Request.QueryString("id") Is Nothing Then

            Dim ruta As String = Server.MapPath("\") & "uploads\"
            Response.Clear()

            If Path.GetExtension(Request.QueryString("nombre")).ToUpper() = ".ZIP" Or Path.GetExtension(Request.QueryString("nombre")).ToUpper() = ".RAR" Then
                Response.ExpiresAbsolute = DateTime.Now
                Response.Expires = -1441
                Response.CacheControl = "no-cache"
                Response.AddHeader("Pragma", "no-cache")
                Response.AddHeader("Pragma", "no-store")
                Response.AddHeader("cache-control", "no-cache")
                Response.Cache.SetCacheability(HttpCacheability.NoCache)
                Response.Cache.SetNoServerCaching()

                Response.Write("No se permite cargar archivos comprimidos")


            Else
                Try
                    Dim solicitud As New SolicitudDocumento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                    solicitud.AgregaDocumento(Request.QueryString("id"), Request.QueryString("id_solicitud_detalle"), Request.QueryString("nombre"), Request.QueryString("tipo"), ruta)

                    Response.ExpiresAbsolute = DateTime.Now
                    Response.Expires = -1441
                    Response.CacheControl = "no-cache"
                    Response.AddHeader("Pragma", "no-cache")
                    Response.AddHeader("Pragma", "no-store")
                    Response.AddHeader("cache-control", "no-cache")
                    Response.Cache.SetCacheability(HttpCacheability.NoCache)
                    Response.Cache.SetNoServerCaching()

                    Response.Write("OK")
                Catch ex As Exception

                    Response.ExpiresAbsolute = DateTime.Now
                    Response.Expires = -1441
                    Response.CacheControl = "no-cache"
                    Response.AddHeader("Pragma", "no-cache")
                    Response.AddHeader("Pragma", "no-store")
                    Response.AddHeader("cache-control", "no-cache")
                    Response.Cache.SetCacheability(HttpCacheability.NoCache)
                    Response.Cache.SetNoServerCaching()

                    Response.Write(ex.Message)

                End Try
            End If



            Response.End()


        End If
    End Sub

End Class
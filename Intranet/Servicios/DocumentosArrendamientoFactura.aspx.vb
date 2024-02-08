Imports IntranetBL
Imports NutecArrendamientos


Public Class DocumentosArrendamientoFactura
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Response.Clear()
        Response.ExpiresAbsolute = DateTime.Now
        Response.Expires = -1441
        Response.CacheControl = "no-cache"
        Response.AddHeader("Pragma", "no-cache")
        Response.AddHeader("Pragma", "no-store")
        Response.AddHeader("cache-control", "no-cache")
        Response.Cache.SetCacheability(HttpCacheability.NoCache)
        Response.Cache.SetNoServerCaching()

        If Not Request.QueryString("tipo_factura") Is Nothing Then
            Try
                Dim tipo_factura = Request.QueryString("tipo_factura")
                Dim nombre = Request.QueryString("nombre")
                Dim p As New ProcesarFactura()

                Dim fileName As String = Context.Server.MapPath("/UploadsArrendamientos/") & nombre

                Dim mensajes As List(Of String) = p.Procesar(tipo_factura, fileName, System.Configuration.ConfigurationManager.AppSettings("CONEXION"), Session("idEmpleado"))


                Dim htmlRespuesta As New StringBuilder
                If mensajes.Count > 0 Then
                    htmlRespuesta.Append("<ul>")
                    For Each m As String In mensajes
                        htmlRespuesta.Append("<li>" & m & "</li>")
                    Next
                    htmlRespuesta.Append("</ul>")
                Else
                    htmlRespuesta.Append("OK")
                End If


                'Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                'arrendamiento.AgregaDocumento(Request.QueryString("id"), Request.QueryString("nombre"), Session("idEmpleado"), Request.QueryString("idTipoArchivo"))

                Response.Write(htmlRespuesta)
            Catch ex As Exception
                Response.Write("Error: " & ex.Message)
            End Try

        End If
        Response.End()

    End Sub

End Class
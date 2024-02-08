Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class DocumentosArrendamiento
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Request.QueryString("id") Is Nothing Then

            Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Dim stringBuilder As New StringBuilder("")
            Dim dtDocumentos As DataTable = arrendamiento.RecuperaArrendamientoDocumento(Request.QueryString("id"))


            stringBuilder.AppendLine("<table border='1' cellpadding='0' cellspacing='0' style='border-collapse:collapse;'>")
            stringBuilder.AppendLine("<tr>")
            stringBuilder.AppendLine("<th>Tipo de Archivo</th>")
            stringBuilder.AppendLine("<th>Archivo(s)</th>")
            stringBuilder.AppendLine("<th>Cargar Archivo</th>")
            stringBuilder.AppendLine("</tr>")
            If dtDocumentos.Rows.Count = 0 Then
                stringBuilder.AppendLine("<tr><td colspan='3'>Este arrendamiento no cuenta con archivos</td></tr>")
            End If

            Dim tipo_anterior As String = ""
            Dim imprime_row As Boolean = True
            Dim id_tipo As Integer = 0
            Dim tipo_archivo As String = ""

            For Each drD As DataRow In dtDocumentos.Rows

                If tipo_anterior <> drD("tipo_archivo") Then
                    imprime_row = True
                Else
                    imprime_row = False
                End If


                If imprime_row And tipo_anterior <> "" Then
                    stringBuilder.AppendLine("</td>")
                    stringBuilder.AppendLine("<td style='padding:4px;' align='center'>")
                    stringBuilder.AppendLine("<a href='javascript:MuestraBotonUpload(" & id_tipo & ", " & Chr(34) & tipo_archivo & Chr(34) & ")'>" & TranslateLocale.text("Subir Archivo") & "</a>")
                    stringBuilder.AppendLine("</td>")
                    stringBuilder.AppendLine("</tr>")
                End If

                id_tipo = drD("id_tipo")
                tipo_archivo = drD("tipo_archivo")

                If imprime_row Then
                    stringBuilder.AppendLine("<tr>")
                    stringBuilder.AppendLine("<td style='padding:4px;'>")
                    stringBuilder.AppendLine(drD("tipo_archivo"))
                    stringBuilder.AppendLine("</td>")
                    stringBuilder.AppendLine("<td style='padding:4px;'>")
                End If

                stringBuilder.AppendLine(drD("nombre"))
                If drD("nombre") <> "" Then
                    stringBuilder.AppendLine("<a href='/UploadsArrendamientos/" & drD("nombre") & "' target='_blank'>" & TranslateLocale.text("Ver") & "</a>")
                    If Session("idEmpleado") = drD("id_usuario_registro") Then
                        stringBuilder.AppendLine("&nbsp;&nbsp;&nbsp;<a href='javascript:EliminarDocumento(" & drD("id_archivo") & ")'>" & TranslateLocale.text("Eliminar") & "</a>")
                    End If
                End If
                stringBuilder.AppendLine("<br/>")

                'If imprime_row Then
                '    stringBuilder.AppendLine("</td>")
                '    stringBuilder.AppendLine("<td style='padding:4px;' align='center'>")
                '    stringBuilder.AppendLine("<a href='javascript:MuestraBotonUpload(" & drD("id_tipo") & ", " & Chr(34) & drD("tipo_archivo") & Chr(34) & ")'>" & TranslateLocale.text("Subir Archivo") & "</a>")
                '    stringBuilder.AppendLine("</td>")
                '    stringBuilder.AppendLine("</tr>")
                'End If

                tipo_anterior = drD("tipo_archivo")
            Next
            stringBuilder.AppendLine("</td>")
            stringBuilder.AppendLine("<td style='padding:4px;' align='center'>")
            stringBuilder.AppendLine("<a href='javascript:MuestraBotonUpload(" & id_tipo & ", " & Chr(34) & tipo_archivo & Chr(34) & ")'>" & TranslateLocale.text("Subir Archivo") & "</a>")
            stringBuilder.AppendLine("</td>")
            stringBuilder.AppendLine("</tr>")
            stringBuilder.AppendLine("</table>")


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
Imports IntranetBL

Public Class RepPivoteGastosNS_xls
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim id_empresa As Integer = Request.QueryString("e")
        Dim mon As String = Request.QueryString("mon")
        Dim fecha_ini As DateTime = New DateTime(Request.QueryString("a"), 1, 1)
        Dim fecha_fin As DateTime = New DateTime(Request.QueryString("a"), 12, 31)

        Dim gastosNS As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dt As DataTable = gastosNS.RecuperaGastosExcel(id_empresa, fecha_ini, fecha_fin, mon, Session("idEmpleado"))




        Dim fileName As String = "ReporteCompleto"

        Dim excel_text As New StringBuilder("")

        excel_text.AppendLine("<table border='1'>")


        excel_text.AppendLine("<tr><td><b>Empresa</b></td>" _
                               & "<td><b>Centro Costo</b></td>" _
                               & "<td><b>Centro Costo Desc</b></td>" _
                               & "<td><b>Tipo Costo</b></td>" _
                               & "<td><b>Denom Tipo Costo</b></td>" _
                               & "<td><b>Monto</b></td>" _
                               & "<td><b>Clasificacion</b></td>" _
                               & "<td><b>Descripcion</b></td>" _
                               & "<td><b>Cta Comp</b></td>" _
                               & "<td><b>Denom Cta Comp</b></td>" _
                               & "<td><b>Fecha</b></td>" _
                               & "<td><b>Num Documento</b></td>" _
                               & "<td><b>Texto Cabecera</b></td>" _
                               & "<td><b>Denominacion</b></td></tr>")


        For Each dr As DataRow In dt.Rows
            excel_text.AppendLine("<tr>")
            excel_text.AppendLine("<td>" & dr("empresa") & "</td>" & _
                                    "<td>" & dr("centro_costo") & "</td>" & _
                                    "<td>" & dr("centro_costo_desc") & "</td>" & _
                                    "<td>" & dr("tipo_costo") & "</td>" & _
                                    "<td>" & dr("denom_tipo_costo") & "</td>" & _
                                    "<td>" & dr("monto") & "</td>" & _
                                    "<td>" & dr("clasificacion") & "</td>" & _
                                    "<td>" & dr("descripcion") & "</td>" & _
                                    "<td>" & dr("cta_comp") & "</td>" & _
                                    "<td>" & dr("denom_cta_comp") & "</td>" & _
                                    "<td>" & dr("fecha") & "</td>" & _
                                    "<td>" & dr("num_documento") & "</td>" & _
                                    "<td>" & dr("texto_cabecera") & "</td>" & _
                                    "<td>" & dr("denominacion") & "</td>")

            excel_text.AppendLine("</tr>")
        Next


        excel_text.AppendLine("</table>")





        Response.Clear()
        Response.ContentType = "application/force-download"
        Response.AddHeader("content-disposition", (Convert.ToString("attachment; filename=") & fileName) + ".xls")
        Response.Write("<html xmlns:x=""urn:schemas-microsoft-com:office:excel"">")
        Response.Write("<head>")
        Response.Write("<META http-equiv=""Content-Type"" content=""text/html; charset=utf-8"">")
        Response.Write("<!--[if gte mso 9]><xml>")
        Response.Write("<x:ExcelWorkbook>")
        Response.Write("<x:ExcelWorksheets>")
        Response.Write("<x:ExcelWorksheet>")
        Response.Write("<x:Name>Report Data</x:Name>")
        Response.Write("<x:WorksheetOptions>")
        Response.Write("<x:Print>")
        Response.Write("<x:ValidPrinterInfo/>")
        Response.Write("</x:Print>")
        Response.Write("</x:WorksheetOptions>")
        Response.Write("</x:ExcelWorksheet>")
        Response.Write("</x:ExcelWorksheets>")
        Response.Write("</x:ExcelWorkbook>")
        Response.Write("</xml>")
        Response.Write("<![endif]--> ")
        form1.InnerHtml = excel_text.ToString()
        ' give ur html string here
        Response.Write("</head>")
        Response.Flush()





    End Sub

End Class
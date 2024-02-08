Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class ArrendamientoInventarioExcel
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim id_empresa As String = Request.QueryString("id_empresa")
        Dim id_categoria As String = Request.QueryString("id_categoria")

        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Dim data As DataTable = reporte.ReporteArrendamientoInventario(id_empresa, id_categoria)

        Dim fileName As String = "InventarioArrendamientos"

        Dim excel_text As New StringBuilder("")



        excel_text.AppendLine("    <style type='text/css'>")
        excel_text.AppendLine("        body {")
        excel_text.AppendLine("            font-family:Arial,Tahoma;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        td {")
        excel_text.AppendLine("            border-style:solid;")
        excel_text.AppendLine("            border-color:#dedcdc;")
        excel_text.AppendLine("            border-width:1px;")
        excel_text.AppendLine("            padding-left:1px;")
        excel_text.AppendLine("            padding-right:0px;")
        excel_text.AppendLine("            padding-top:0px;")
        excel_text.AppendLine("            padding-bottom:0px;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .titulos {")
        excel_text.AppendLine("            font-size:15px;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .subtitulos {")
        excel_text.AppendLine("            font-size:12px;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .datos {")
        excel_text.AppendLine("            font-size:12px;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .datos3 {")
        excel_text.AppendLine("            font-size:12px;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .negativo {")
        excel_text.AppendLine("            color:red;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .negritas {")
        excel_text.AppendLine("            font-weight:bold;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .rep2Dato {")
        excel_text.AppendLine("            float:left;")
        excel_text.AppendLine("            display:inline-block;")
        excel_text.AppendLine("            width:40px;")
        excel_text.AppendLine("            text-align:right;")
        excel_text.AppendLine("            font-size:12px;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .rep2Porc {")
        excel_text.AppendLine("            float:right;")
        excel_text.AppendLine("            display:inline-block;")
        excel_text.AppendLine("            width:25px;")
        excel_text.AppendLine("            text-align:right;")
        excel_text.AppendLine("            font-size:11px;")
        excel_text.AppendLine("            border-width:0px;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .titulos2 {")
        excel_text.AppendLine("            font-size:13px;")
        excel_text.AppendLine("            color:#000;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .subtitulos2 {")
        excel_text.AppendLine("            font-size:12px;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .datos2 {")
        excel_text.AppendLine("            font-size:12px;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .rep4Dato {")
        excel_text.AppendLine("            float:left;")
        excel_text.AppendLine("            display:inline-block;")
        excel_text.AppendLine("            width:41px;")
        excel_text.AppendLine("            text-align:right;")
        excel_text.AppendLine("            font-size:12px;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .rep4Porc {")
        excel_text.AppendLine("            float:right;")
        excel_text.AppendLine("            display:inline-block;")
        excel_text.AppendLine("            width:20px;")
        excel_text.AppendLine("            text-align:right;")
        excel_text.AppendLine("            font-size:11px;")
        excel_text.AppendLine("            border-width:0px;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        ul")
        excel_text.AppendLine("        {")
        excel_text.AppendLine("            list-style-type:circle;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        ul a {")
        excel_text.AppendLine("            color:#1b6d9c;")
        excel_text.AppendLine("            text-decoration:none;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .linkCopias a {")
        excel_text.AppendLine("            text-decoration:none;")
        excel_text.AppendLine("            color:#1b6d9c;")
        excel_text.AppendLine("            padding-left:20px;")
        excel_text.AppendLine("            font-size:14px")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        ul a:hover {")
        excel_text.AppendLine("            color:#324f5e;")
        excel_text.AppendLine("            text-decoration:underline;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .tblLinks td {")
        excel_text.AppendLine("            border-style:none;")
        excel_text.AppendLine("            border-width:0px;")
        excel_text.AppendLine("            padding-left:0px;")
        excel_text.AppendLine("            padding-right:0px;")
        excel_text.AppendLine("            padding-top:2px;")
        excel_text.AppendLine("            padding-bottom:2px;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .colorSel {")
        excel_text.AppendLine("            color:#324f5e;")
        excel_text.AppendLine("            text-decoration:underline;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("    </style>")






        Dim colAlterna As Boolean
        Dim columnas As Integer = 14
        If Request.QueryString("r") = "1" Then
            columnas = 13
        End If

        Dim dtRep As DataTable = data
        Dim trimestre = 3


        excel_text.AppendLine(" <table id='tblReporte_1' border='1' cellpadding='0' cellspacing='0'>")
        excel_text.AppendLine(" <tr class='filaTotales'>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Número") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Arrendadora") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Empresa") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Tipo de Arrendamiento") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Contrato Maestro") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Folio") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Flotilla") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Fecha Inicial") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Fecha Final") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Parcialidades") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Periodicidad") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Categoria") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Descripción de los Bienes") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Valor/Costo del Bien (Sin IVA)") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Comisión apertura/Costo de Originación") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Deposito en Garantía") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Arrendamiento Neto") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Valor de Rescate") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Valor Residual") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Tasa Calculada Mensual") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Tasa Anualizada") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Tasa") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Pago Mensual Arrendamiento") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Pago Mensual Seguro") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("IVA") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Pago Mensual Total") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Moneda") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Dia de Pago") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Departamento") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Asignación") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Aseguradora") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("No. de Poliza") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Prima Financiada") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Fecha Inicial Seguro") & "</b></td>")
        excel_text.AppendLine("     <td align='center' class='titulos'><b>" & TranslateLocale.text("Fecha Final Seguro") & "</b></td>")
        excel_text.AppendLine("</tr>")

        For Each dr As DataRow In dtRep.Rows
            colAlterna = False



            excel_text.AppendLine("<tr>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("numero") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("arrendadora") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("empresa") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & TranslateLocale.text(dr("tipo_arrendamiento")) & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("contrato_maestro") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("folio") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("flotilla") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("fecha_inicio") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("fecha_fin") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("numero_parcialidades") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("periodicidad_arrendamiento") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & TranslateLocale.text(dr("categoria")) & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("descripcion_de_bienes") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & Convert.ToDecimal(dr("importe_total")).ToString("#,###,##0.00") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & Convert.ToDecimal(dr("comision")).ToString("#,###,##0.00") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & Convert.ToDecimal(dr("deposito_garantia")).ToString("#,###,##0.00") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & Convert.ToDecimal(dr("arrendamiento_neto")).ToString("#,###,##0.00") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & Convert.ToDecimal(dr("valor_rescate")).ToString("#,###,##0.00") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & Convert.ToDecimal(dr("valor_residual")).ToString("#,###,##0.00") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & Convert.ToDecimal(dr("tasa_calculada_mensual")).ToString("#,###,##0.00") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & Convert.ToDecimal(dr("tasa_calculada_anual")).ToString("#,###,##0.00") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & Convert.ToDecimal(dr("tasa")).ToString("#,###,##0.00") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & Convert.ToDecimal(dr("importe_parcialidades")).ToString("#,###,##0.00") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & Convert.ToDecimal(dr("monto_parcialidad_seguro")).ToString("#,###,##0.00") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & Convert.ToDecimal(dr("iva")).ToString("#,###,##0.00") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & Convert.ToDecimal(dr("pago_mensual_total")).ToString("#,###,##0.00") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("id_moneda") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("dia_pago") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("departamento") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("asignacion") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("aseguradora") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("num_poliza") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & Convert.ToDecimal(dr("prima_financiada")).ToString("#,###,##0.00") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("fecha_inicio_seguro") & "</td>")
            excel_text.AppendLine("<td align='center' class='datos3'>" & dr("fecha_fin_seguro") & "</td>")

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
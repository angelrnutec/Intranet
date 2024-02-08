Imports IntranetBL

Public Class ResumenOperativoExcel
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim anio As String = Request.QueryString("a")
        Dim mes As String = Request.QueryString("m")





        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Dim data As DataTable = reporte.RecuperaReporteEjecutivo_ResumenOperativo(anio, mes).Tables(0)

        Dim fileName As String = "ResumenOperativo_" & anio & "_" & mes

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
        excel_text.AppendLine("            background-color:#9de7d7;")
        excel_text.AppendLine("            color:#000;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .subtitulos {")
        excel_text.AppendLine("            font-size:12px;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .datos {")
        excel_text.AppendLine("            font-size:12px;")
        excel_text.AppendLine("            background-color:#FFFFFF;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .datos3 {")
        excel_text.AppendLine("            font-size:12px;")
        excel_text.AppendLine("            background-color:#FFFC99;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .columnaAlterna {")
        excel_text.AppendLine("            background-color:#FFFFFF;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .columnaTitulos {")
        excel_text.AppendLine("            background-color:#FFFFFF;")
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
        excel_text.AppendLine("            background-color:#9de7d7;")
        excel_text.AppendLine("            color:#000;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .subtitulos2 {")
        excel_text.AppendLine("            font-size:12px;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .datos2 {")
        excel_text.AppendLine("            font-size:12px;")
        excel_text.AppendLine("            background-color:#FFFFFF;")
        excel_text.AppendLine("        }")
        excel_text.AppendLine("        .rep4Dato {")
        excel_text.AppendLine("            float:left;")
        excel_text.AppendLine("            display:inline-block;")
        excel_text.AppendLine("            /*width:25px;*/")
        excel_text.AppendLine("            width:41px;")
        excel_text.AppendLine("            text-align:right;")
        excel_text.AppendLine("            /*font-size:11px;*/")
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
        excel_text.AppendLine("     <td align='center' class='titulos'><b>Concepto</b></td>")

        ''Dim rep1cols As Integer = CInt((mes / 3)) + (mes Mod 3) + 2


        If mes >= trimestre Then excel_text.AppendLine("<td align='center' class='titulos'><b>T1</b></td>")
        If mes >= trimestre * 2 Then excel_text.AppendLine("<td align='center' class='titulos'><b>T2</b></td>")
        If mes >= trimestre * 3 Then excel_text.AppendLine("<td align='center' class='titulos'><b>T3</b></td>")
        If mes >= trimestre * 4 Then excel_text.AppendLine("<td align='center' class='titulos'><b>T4</b></td>")
        If (mes Mod trimestre) = 0 Then
            excel_text.AppendLine("<td align='center' class='titulos'><b>" & NombrePeriodo(mes) & "</b></td>")
        Else
            For i As Integer = 1 To (mes Mod trimestre)
                excel_text.AppendLine("<td align='center' class='titulos'><b>" & NombrePeriodo(Math.Floor((mes / trimestre)) * trimestre + i) & "</b></td>")
            Next
        End If
        excel_text.AppendLine("<td align='center' class='titulos'><b>Acum</b></td>")
        excel_text.AppendLine("<td align='center' class='titulos'><b>Plan</b></td>")


        excel_text.AppendLine("</tr>")

        For Each dr As DataRow In dtRep.Rows
            colAlterna = False



            excel_text.AppendLine("<tr>")
            excel_text.AppendLine("<td align='left' class='subtitulos columnaTitulos'><b>" & dr("descripcion") & "</b></td>")

            If mes >= trimestre Then
                excel_text.AppendLine("<td align='center' class='datos3" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep1(dtRep, dr, 1, True, False) & "</td>")
                colAlterna = Not colAlterna
            End If
            If mes >= trimestre * 2 Then
                excel_text.AppendLine("<td align='center' class='datos3" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep1(dtRep, dr, 2, True, False) & "</td>")
                colAlterna = Not colAlterna
            End If
            If mes >= trimestre * 3 Then
                excel_text.AppendLine("<td align='center' class='datos3" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep1(dtRep, dr, 3, True, False) & "</td>")
                colAlterna = Not colAlterna
            End If
            If mes >= trimestre * 4 Then
                excel_text.AppendLine("<td align='center' class='datos3" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep1(dtRep, dr, 4, True, False) & "</td>")
                colAlterna = Not colAlterna
            End If
            If (mes Mod trimestre) = 0 Then
                excel_text.AppendLine("<td align='center' class='datos3" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep1(dtRep, dr, mes, False, False) & "</td>")
                colAlterna = Not colAlterna
            Else
                For i As Integer = 1 To (mes Mod trimestre)
                    Dim mes_actual As Integer = Math.Floor((mes / trimestre)) * trimestre + i
                    excel_text.AppendLine("<td align='center' class='datos3" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep1(dtRep, dr, mes_actual, False, False) & "</td>")
                    colAlterna = Not colAlterna
                Next
            End If

            excel_text.AppendLine("<td align='center' class='datos3" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep1(dtRep, dr, -1, False, False) & "</td>")
            colAlterna = Not colAlterna
            excel_text.AppendLine("<td align='center' class='datos3" & IIf(colAlterna, " columnaAlterna", "") & "'><b>" & FormateaValorRep1(dtRep, dr, 0, False, False) & "</b></td>")
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





    Protected Function FormateaValorRep1(dt As DataTable, ByRef dr As DataRow, dato As Integer, esTrimestre As Boolean, esPeriodoAnterior As Boolean) As String
        Dim html As New StringBuilder("")
        Dim anio As Integer = Request.QueryString("a")
        Dim mes As Integer = Request.QueryString("m")


        Dim facturacion As Decimal = 0


        Dim monto As String
        Dim monto_dec As Decimal = 0
        Dim monto_ant_dec As Decimal
        Dim monto_plan_dec As Decimal
        If dato > 0 Then
            monto = ifNullEmpty(dr("monto" & IIf(esTrimestre, "_trim", "_mes") & IIf(esPeriodoAnterior, "_ant", "") & dato))
            html.AppendLine("<b>" & monto & IIf(dr("es_porcentaje") = True And monto <> "--", "%", "") & "</b>")
            If dr("es_multivalor") = True Then

                If monto <> "--" Then
                    monto_dec = monto
                    monto_ant_dec = ifNullEmpty(dr("monto" & IIf(esTrimestre, "_trim", "_mes") & "_ant" & dato))
                End If

                If esTrimestre Then
                    monto_plan_dec = PlanDistribucion(dr, dato * 3, TipoValor.MesActual)
                    monto_plan_dec += PlanDistribucion(dr, dato * 3 - 1, TipoValor.MesActual)
                    monto_plan_dec += PlanDistribucion(dr, dato * 3 - 2, TipoValor.MesActual)
                Else
                    monto_plan_dec = PlanDistribucion(dr, dato, TipoValor.MesActual)
                End If


                Dim porc_1 As Decimal = 0
                If monto_plan_dec <> 0 Then
                    porc_1 = ((monto_dec / monto_plan_dec) - 1) * 100
                End If
                Dim porc_2 As Decimal = 0
                If monto_ant_dec <> 0 Then
                    porc_2 = ((monto_dec / monto_ant_dec) - 1) * 100
                End If

                If dr("id") = 5 Or dr("id") = 6 Then  'Utilidad Neta
                    facturacion = RecuperaValorDeTabla(dt, "monto" & IIf(esTrimestre, "_trim", "_mes") & dato, 2)
                    If facturacion <> 0 Then
                        porc_1 = ((monto_dec / facturacion)) * 100
                    End If
                End If


                html.AppendLine("<br />")
                html.AppendLine("<span" & IIf(porc_1 < 0, " class='negativo'", "") & ">" & IIf(porc_1 < 0, "(" & ifNullEmpty(porc_1) & "%)", ifNullEmpty(porc_1) & "%") & "</span>")
                html.AppendLine("<br />")
                If monto_ant_dec <> 0 Then
                    html.AppendLine("<span" & IIf(porc_2 < 0, " class='negativo'", "") & ">" & IIf(porc_2 < 0, "(" & ifNullEmpty(porc_2) & "%)", ifNullEmpty(porc_2) & "%") & "</span> vs " & anio - 1)
                    html.AppendLine("<br />")
                    html.AppendLine("[" & ifNullEmpty(monto_ant_dec) & "]")
                End If
            End If
        ElseIf dato = 0 Then
            monto = ifNullEmpty(dr("monto_plan"))
            If dr("id") <> 3 Then

                If dr("es_porcentaje") = False Then
                    monto_plan_dec = PlanDistribucion(dr, mes, TipoValor.MesAcumulado)
                    html.AppendLine("<b>" & ifNullEmpty(monto_plan_dec) & "</b>")
                Else
                    html.AppendLine("<b>" & monto & IIf(dr("es_porcentaje") = True And monto <> "--", "%", "") & "</b>")
                End If
            End If
        ElseIf dato = -1 Then
            monto = ifNullEmpty(dr("monto_total"))

            If dr("id") <> 3 Then
                html.AppendLine("<b>" & monto & IIf(dr("es_porcentaje") = True And monto <> "--", "%", "") & "</b>")

                If dr("es_multivalor") = True Then

                    If monto <> "--" Then
                        monto_dec = monto
                        monto_ant_dec = ifNullEmpty(dr("monto_total_ant"))
                    End If

                    monto_plan_dec = PlanDistribucion(dr, mes, TipoValor.MesAcumulado)



                    Dim porc_1 As Decimal = 0
                    If monto_plan_dec <> 0 Then
                        porc_1 = ((monto_dec / monto_plan_dec) - 1) * 100
                    End If
                    Dim porc_2 As Decimal = 0
                    If monto_ant_dec <> 0 Then
                        porc_2 = ((monto_dec / monto_ant_dec) - 1) * 100
                    End If

                    If dr("id") = 5 Or dr("id") = 6 Then  'Utilidad Neta
                        facturacion = RecuperaValorDeTabla(dt, "monto_total", 2)
                        If facturacion <> 0 Then
                            porc_1 = ((monto_dec / facturacion)) * 100
                        End If
                    End If


                    html.AppendLine("<br />")
                    html.AppendLine("<span" & IIf(porc_1 < 0, " class='negativo'", "") & ">" & IIf(porc_1 < 0, "(" & ifNullEmpty(porc_1) & "%)", ifNullEmpty(porc_1) & "%") & "</span>")
                    html.AppendLine("<br />")
                    If monto_ant_dec <> 0 Then
                        html.AppendLine("<span" & IIf(porc_2 < 0, " class='negativo'", "") & ">" & IIf(porc_2 < 0, "(" & ifNullEmpty(porc_2) & "%)", ifNullEmpty(porc_2) & "%") & "</span> vs " & anio - 1)
                        html.AppendLine("<br />")
                        html.AppendLine("[" & ifNullEmpty(monto_ant_dec) & "]")
                    End If
                End If
            End If
        End If

        Return html.ToString
    End Function



    Public Enum TipoValor
        Anual = 1
        MesActual = 2
        MesAcumulado = 3
    End Enum



    Protected Function PlanDistribucion(dr As DataRow, mes As Integer, tipo As TipoValor, Optional division As String = "") As Decimal
        Dim nombre_campo As String = "monto_plan"
        If division.Length > 0 Then
            nombre_campo = "monto" & division & "_plan"
        End If
        If tipo = TipoValor.Anual Then
            Return dr(nombre_campo)
        ElseIf tipo = TipoValor.MesActual Then
            Return dr(nombre_campo & mes)
        ElseIf tipo = TipoValor.MesAcumulado Then
            Dim valor As Decimal = 0
            For i As Integer = 1 To mes
                valor += dr(nombre_campo & i)
            Next
            Return valor
        End If

        Return 0
    End Function
    Private Function RecuperaValorDeTabla(dt As DataTable, columna As String, id As Integer) As Decimal

        For Each dr As DataRow In dt.Rows
            If dr("id") = id Then
                Return dr(columna)
            End If
        Next

        Return 0
    End Function


    Private Function ifNullEmpty(valor As Object, Optional decim As Boolean = False) As String
        Try
            If IsDBNull(valor) Then
                Return "--"
            End If
            If decim Then
                Return Convert.ToDecimal(valor).ToString("###,###,##0.00")
            Else
                Return Convert.ToDecimal(valor).ToString("###,###,##0")
            End If
        Catch ex As Exception
            Return ex.Message
        End Try
    End Function


    Protected Function NombrePeriodo(periodo As Integer) As String
        Dim nombre As String = ""

        If periodo = 1 Then
            nombre = "Enero"
        ElseIf periodo = 2 Then
            nombre = "Febrero"
        ElseIf periodo = 3 Then
            nombre = "Marzo"
        ElseIf periodo = 4 Then
            nombre = "Abril"
        ElseIf periodo = 5 Then
            nombre = "Mayo"
        ElseIf periodo = 6 Then
            nombre = "Junio"
        ElseIf periodo = 7 Then
            nombre = "Julio"
        ElseIf periodo = 8 Then
            nombre = "Agosto"
        ElseIf periodo = 9 Then
            nombre = "Septiembre"
        ElseIf periodo = 10 Then
            nombre = "Octubre"
        ElseIf periodo = 11 Then
            nombre = "Noviembre"
        ElseIf periodo = 12 Then
            nombre = "Diciembre"
        ElseIf periodo = 13 Then
            nombre = "Enero"
        ElseIf periodo = 0 Then
            nombre = "Diciembre"
        ElseIf periodo = -1 Then
            nombre = "Noviembre"
        ElseIf periodo = -2 Then
            nombre = "Octubre"
        ElseIf periodo = -3 Then
            nombre = "Septiembre"
        ElseIf periodo = -4 Then
            nombre = "Agosto"
        ElseIf periodo = -5 Then
            nombre = "Julio"
        ElseIf periodo = -6 Then
            nombre = "Junio"
        ElseIf periodo = -7 Then
            nombre = "Mayo"
        ElseIf periodo = -8 Then
            nombre = "Abril"
        ElseIf periodo = -9 Then
            nombre = "Marzo"
        ElseIf periodo = -10 Then
            nombre = "Febrero"
        ElseIf periodo = -11 Then
            nombre = "Enero"
        End If

        Return nombre
    End Function
End Class
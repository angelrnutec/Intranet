<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepFinancierosEjecutivoHornosImpresion.aspx.vb" Inherits="Intranet.RepFinancierosEjecutivoHornosImpresion" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reporte</title>

    <style type="text/css">
        body {
            font-family:Arial,Tahoma;
        }
/*
        td {
            border-style:solid;
            border-color:#dedcdc;
            border-width:1px;
            padding-left:5px;
            padding-right:4px;
            padding-top:2px;
            padding-bottom:2px;
        }    
*/

        td {
            border-style:solid;
            border-color:#dedcdc;
            border-width:1px;
            padding-left:1px;
            padding-right:0px;
            padding-top:0px;
            padding-bottom:0px;
        }
        .bordederecho {
            border-right:none;
        }
        .bordeizquierdo {
            border-left:none;
        }
        .titulos {
            font-size:15px;
            background-color:#9de7d7;
            color:#000;
        }
        .subtitulos {
            font-size:12px;
        }
        .datos {
            font-size:12px;
            background-color:#FFFFFF;
        }
        .datos3 {
            font-size:12px;
            background-color:#FFFC99;
        }
        .columnaAlterna {
            background-color:#FFFFFF;
        }
        .columnaTitulos {
            background-color:#FFFFFF;
        }
        .negativo {
            color:red;
        }
        .negritas {
            font-weight:bold;
        }


        .rep2Dato {
            float:left;
            display:inline-block;
            width:40px;
            text-align:right;
            font-size:12px;
        }
        .rep2Porc {
            float:right;
            display:inline-block;
            width:25px;
            text-align:right;
            font-size:11px;
            border-width:0px;

        }

        .titulos2 {
            font-size:13px;
            background-color:#9de7d7;
            color:#000;
        }
        .subtitulos2 {
            font-size:12px;
        }
        .datos2 {
            /*font-size:11px;*/
            font-size:12px;
            background-color:#FFFFFF;
        }


        .rep4Dato {
            float:left;
            display:inline-block;
            /*width:25px;*/
            width:41px;
            text-align:right;
            /*font-size:11px;*/
            font-size:12px;
        }
        .rep4Porc {
            float:right;
            display:inline-block;
            width:20px;
            text-align:right;
            font-size:11px;
            border-width:0px;
        }



        ul
        {
            list-style-type:circle;
        }

        ul a {
            color:#1b6d9c;
            text-decoration:none;
        }

        .linkCopias a {
            text-decoration:none;
            color:#1b6d9c;
            padding-left:20px;
            font-size:14px
        }

        ul a:hover {
            color:#324f5e;
            text-decoration:underline;
        }

        .tblLinks td {
            border-style:none;
            border-width:0px;
            padding-left:0px;
            padding-right:0px;
            padding-top:2px;
            padding-bottom:2px;
        }

        .colorSel {
            color:#324f5e;
            text-decoration:underline;
        }



                 .noborder {
            border-style:none !important;
            border-color:#000 !important;
            border-width:1px !important;
        }

        .bordederecho {
            border-right:none;
        }
        .bordeizquierdo {
            border-left:none;
        }


    </style>

    <script type="text/javascript">

        function SeleccionaReporte(reporte) {
            if (reporte != 99) {
                for (i = 1; i <= 25; i++) {
                    if (document.getElementById('divReporte_' + i) != null) { document.getElementById('divReporte_' + i).style.display = 'none'; }
                    if (document.getElementById('lnkReporte_' + i) != null) { document.getElementById('lnkReporte_' + i).className = ''; }
                }
                document.getElementById('divReporte_' + reporte).style.display = '';
                document.getElementById('lnkReporte_' + reporte).className = 'colorSel';
                document.getElementById('lnkReporte_99').className = '';
            }
            else {
                for (i = 1; i <= 25; i++) {
                    if (document.getElementById('divReporte_' + i) != null) { document.getElementById('divReporte_' + i).style.display = ''; }
                    if (document.getElementById('lnkReporte_' + i) != null) { document.getElementById('lnkReporte_' + i).className = ''; }
                }
                if (document.getElementById('lnkReporte_' + reporte) != null) { document.getElementById('lnkReporte_' + reporte).className = 'colorSel'; }
            }
        }

        function TomaFoto(reporte){
            ScreenShot(document.getElementById('tblReporte_' + reporte));
        }


        function ScreenShot(id) {

            html2canvas(id, {
                onrendered: function(canvas) {

                    var img = canvas.toDataURL("image/png");
                    var output = img.replace(/^data:image\/(png|jpg);base64,/, "");
                    var output = encodeURIComponent(img);

                    var Parameters = "image=" + output;
                    $.ajax({
                        type: "POST",
                        url: "Servicios/GuardaScreenshot.aspx",
                        data: Parameters,
                        success : function(data)
                        {
                            window.open('/uploads/' + data);
                            //console.log("screenshot done");
                        }
                    }).done(function() {
                        //$('body').html(data);
                    });

                }
            });
        }

    </script>



	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<%--    <script src="/highcharts/js/highcharts.js"></script>
    <script src="/highcharts/js/highcharts-more.js"></script>
    <script src="/highcharts/js/modules/exporting.js"></script>--%>
        <script src="/highcharts2/js/highcharts.js"></script>
    <script src="/highcharts2/js/highcharts-more.js"></script>
    <script src="/highcharts2/js/modules/exporting.js"></script>
    <script src="/highcharts2/js/modules/offline-exporting.js"></script>

    <script src="/scripts/html2canvas.js"></script>
    <script src="/scripts/jquery.fileDownload.js"></script>

    <script type="text/javascript">
        Highcharts.setOptions({
            chart: {
                style: {
                    fontFamily: 'arial'
                }
            }
        });


        var STYLES = '<style type="text/css"> ';
        STYLES += 'body {font-family:Arial; background-color:#ffffff;} ';
        STYLES += 'td {border-style:solid;border-color:#dedcdc;border-width:1px;padding-left:1px;padding-right:0px;padding-top:0px;padding-bottom:0px;} ';
        STYLES += '.bordederecho { border-right:none; } ';
        STYLES += '.bordeizquierdo { border-left:none; } ';
        STYLES += '.titulos {font-size:15px;background-color:#9de7d7;color:#000;} ';
        STYLES += '.subtitulos {font-size:12px;} ';
        STYLES += '.datos {font-size:12px;background-color:#FFFFFF;} ';
        STYLES += '.datos3 {font-size:12px;background-color:#FFFC99;} ';
        STYLES += '.columnaAlterna {background-color:#FFFFFF;} ';
        STYLES += '.columnaTitulos {background-color:#FFFFFF;} ';
        STYLES += '.negativo {color:red; font-weight:bold;} ';
        STYLES += '.negritas {font-weight:bold;} ';
        STYLES += '.rep2Dato {float:left;display:inline-block;width:40px;text-align:right;font-size:12px;} ';
        STYLES += '.rep2Porc {float:right;display:inline-block;width:25px;text-align:right;font-size:11px;border-width:0px;} ';
        STYLES += '.titulos2 {font-size:13px;background-color:#9de7d7;color:#000;} ';
        STYLES += '.subtitulos2 {font-size:12px;} ';
        STYLES += '.datos2 {font-size:12px;background-color:#FFFFFF;} ';
        STYLES += '.rep4Dato {float:left;display:inline-block;width:41px;text-align:right;font-size:12px;} ';
        STYLES += '.rep4Porc {float:right;display:inline-block;width:20px;text-align:right;font-size:11px;border-width:0px;} ';
        STYLES += 'ul{list-style-type:circle;} ';
        STYLES += 'ul a {color:#1b6d9c;text-decoration:none;} ';
        STYLES += '.linkCopias a {text-decoration:none;color:#1b6d9c;padding-left:20px;font-size:14px} ';
        STYLES += 'ul a:hover {color:#324f5e;text-decoration:underline;} ';
        STYLES += '.tblLinks td {border-style:none;border-width:0px;padding-left:0px;padding-right:0px;padding-top:2px;padding-bottom:2px;} ';
        STYLES += '.colorSel {color:#324f5e;text-decoration:underline;} ';
        STYLES += '</style>';


        function base64_encode(data) {
            var b64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/=';
            var o1, o2, o3, h1, h2, h3, h4, bits, i = 0,
              ac = 0,
              enc = '',
              tmp_arr = [];

            if (!data) {
                return data;
            }

            do { // pack three octets into four hexets
                o1 = data.charCodeAt(i++);
                o2 = data.charCodeAt(i++);
                o3 = data.charCodeAt(i++);

                bits = o1 << 16 | o2 << 8 | o3;

                h1 = bits >> 18 & 0x3f;
                h2 = bits >> 12 & 0x3f;
                h3 = bits >> 6 & 0x3f;
                h4 = bits & 0x3f;

                // use hexets to index into b64, and append result to encoded string
                tmp_arr[ac++] = b64.charAt(h1) + b64.charAt(h2) + b64.charAt(h3) + b64.charAt(h4);
            } while (i < data.length);

            enc = tmp_arr.join('');

            var r = data.length % 3;

            return (r ? enc.slice(0, r - 3) : enc) + '==='.slice(r || 3);
        }

        var tableToExcel = (function () {
            var uri = 'data:application/vnd.ms-excel;base64,'
                , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><meta http-equiv="content-type" content="application/vnd.ms-excel;charset=UTF-8;"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
                , base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))) }
                , format = function (s, c) { return s.replace(/{(\w+)}/g, function (m, p) { return c[p]; }) }
            return function (table, name) {
                tblName = table;
                if (!table.nodeType) table = document.getElementById(table)
                $("#" + tblName).find('tr').css('font-family', 'Arial');
                $("#" + tblName).find(".negativo").css('color', 'red');
                $("#" + tblName).find(".datos").css('font-size', '12px');
                $("#" + tblName).find(".datos2").css('font-size', '12px');
                $("#" + tblName).find(".datos3").css('font-size', '12px');
                $("#" + tblName).find(".bordederecho").css('border-right', 'none');
                $("#" + tblName).find(".bordeizquierdo").css('border-left', 'none');

                var ctx = { worksheet: name || 'Worksheet', table: (STYLES + table.innerHTML) }
                //window.location.href = uri + base64(format(template, ctx));

                var a = document.createElement('a');
                a.href = uri + base64_encode(format(template, ctx));
                a.download = 'reporte.xls';
                a.click();
                //a.preventDefault();
            }
        })();
    </script> 
</head>
<body>



    <form id="form1" runat="server">

    <div style='padding-left:12px;font-size:22px;'><asp:Label ID="lblTituloReporte" runat="server"></asp:Label></div>
<%
    Dim anio = Request.QueryString("a")
    Dim mes = Request.QueryString("m")
   
%>

    <table class="tblLinks" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td>
                <ul>
                    <li><a id="lnkReporte_13" class="colorSel" href="#" onclick="SeleccionaReporte(13);"><%=TranslateLocale.text("Minuta Junta Anterior")%></a></li>
                    <li><a id="lnkReporte_14" href="#" onclick="SeleccionaReporte(14);"><%=TranslateLocale.text("Resumen Ejecutivo")%></a></li>
                    <li><a id="lnkReporte_1" href="#" onclick="SeleccionaReporte(1);"><%=TranslateLocale.text("Resumen Operativo")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_2" href="#" onclick="SeleccionaReporte(2);"><%=TranslateLocale.text("Estado de Resultados")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_3" href="#" onclick="SeleccionaReporte(3);"><%=TranslateLocale.text("Estado de Resultados")%> - <%= anio & " vs " & (anio - 1)%></a></li>
                    <li><a id="lnkReporte_4" href="#" onclick="SeleccionaReporte(4);"><%=TranslateLocale.text("Balance General")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_12" href="#" onclick="SeleccionaReporte(12);"><%=TranslateLocale.text("Perfil de Deuda")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_5" href="#" onclick="SeleccionaReporte(5);"><%=TranslateLocale.text("Estado de Cambios Base Efectivo")%></a></li>
                    <li><a id="lnkReporte_16" href="#" onclick="SeleccionaReporte(16);"><%=TranslateLocale.text("Gráfica: Flujo de Efectivo")%></a></li>

                </ul>
            </td>
            <td>&nbsp;&nbsp;&nbsp;</td>
            <td>
                <ul>

                    <li><a id="lnkReporte_7" href="#" onclick="SeleccionaReporte(7);"><%=TranslateLocale.text("Estado de Resultados HORNOS")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_9" href="#" onclick="SeleccionaReporte(9);"><%=TranslateLocale.text("Pedidos y Facturación HORNOS")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_11" href="#" onclick="SeleccionaReporte(11);"><%=TranslateLocale.text("Cashflow Forecast")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_22" href="#" onclick="SeleccionaReporte(22);"><%=TranslateLocale.text("Cap. de Trabajo: Cartera")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_23" href="#" onclick="SeleccionaReporte(23);"><%=TranslateLocale.text("Cap. de Trabajo: Caja")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_24" href="#" onclick="SeleccionaReporte(24);"><%=TranslateLocale.text("Cap. de Trabajo: Inventario")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_25" href="#" onclick="SeleccionaReporte(25);"><%=TranslateLocale.text("Cap. de Trabajo: Proveedores")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_99" href="#" onclick="SeleccionaReporte(99);"><%=TranslateLocale.text("Mostrar todos los reportes")%></a></li>
                </ul>
            </td>
        </tr>
    </table>


<div style="padding-left:20px">

<%
    Dim imprimir_separador As Boolean = False
    Dim dtComentarios As DataTable = RecuperaDatosReporteComentario()
    Dim grafica_flujo_efectivo As String = ""
    If dtComentarios.Rows.Count > 0 Then
        grafica_flujo_efectivo = dtComentarios.Rows(0)("grafica_flujo_efectivo")
    End If
    
    %>
    <div id="divReporte_13" style="width:900px;">
    <br /><br />
        <div style="font-size:20px"><%=TranslateLocale.text("Minuta Junta Anterior")%><span class="linkCopias"><a href="#" onclick="TomaFoto(13);"><%=TranslateLocale.text("(Copiar)")%></a></span></div>
        <div id="tblReporte_13">
<%
    If dtComentarios.Rows.Count > 0 Then
        Response.Write(dtComentarios.Rows(0)("minuta_junta_anterior"))
    Else
        Response.Write(" - " & TranslateLocale.text("Sin contenido"))
    End If
        %>
        </div>
    </div>

    <div id="divReporte_14" style="display:none;width:900px;">
    <br /><br />
        <div style="font-size:20px"><%=TranslateLocale.text("Resumen Ejecutivo")%><span class="linkCopias"><a href="#" onclick="TomaFoto(14);"><%=TranslateLocale.text("(Copiar)")%></a></span></div>
        <div id="tblReporte_14">
<%  
    If dtComentarios.Rows.Count > 0 Then
        Response.Write(dtComentarios.Rows(0)("resumen_ejecutivo"))
    Else
        Response.Write(" - " & TranslateLocale.text("Sin contenido"))
    End If
    %>
        </div>
    </div>




<%
    Dim colAlterna As Boolean
    Dim columnas As Integer = 14
    If Request.QueryString("r") = "1" Then
        columnas = 13
    End If

    Dim dsReporte As DataSet = RecuperaDatosReporte()

    Dim dtRep As DataTable = dsReporte.Tables(0)
    Dim trimestre = 3
    
%>


    <div id="divReporte_1" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Resumen Operativo")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(1);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_1', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>

    <table id="tblReporte_1" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td align="center" class="titulos"><b><%=TranslateLocale.text("Concepto")%></b></td>
<%
    ''Dim rep1cols As Integer = CInt((mes / 3)) + (mes Mod 3) + 2



    If mes >= trimestre Then Response.Write("<td align='center' class='titulos'><b>T1</b></td>")
    If mes >= trimestre * 2 Then Response.Write("<td align='center' class='titulos'><b>T2</b></td>")
    If mes >= trimestre * 3 Then Response.Write("<td align='center' class='titulos'><b>T3</b></td>")
    If mes >= trimestre * 4 Then Response.Write("<td align='center' class='titulos'><b>T4</b></td>")
    If (mes Mod trimestre) = 0 Then
        Response.Write("<td align='center' class='titulos'><b>" & NombrePeriodo(mes) & "</b></td>")
    Else
        For i As Integer = 1 To (mes Mod trimestre)
            Response.Write("<td align='center' class='titulos'><b>" & NombrePeriodo(Math.Floor((mes / trimestre)) * trimestre + i) & "</b></td>")
        Next
    End If
    Response.Write("<td align='center' class='titulos'><b>Acum</b></td>")
    Response.Write("<td align='center' class='titulos'><b>Plan</b></td>")

%>
        </tr>
<% 
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False


        
        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos columnaTitulos'><b>" & TranslateLocale.text(dr("descripcion")) & "</b></td>")

        If mes >= trimestre Then
            Response.Write("<td align='center' class='datos3" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep1(dtRep, dr, 1, True, False) & "</td>")
            colAlterna = Not colAlterna
        End If
        If mes >= trimestre * 2 Then
            Response.Write("<td align='center' class='datos3" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep1(dtRep, dr, 2, True, False) & "</td>")
            colAlterna = Not colAlterna
        End If
        If mes >= trimestre * 3 Then
            Response.Write("<td align='center' class='datos3" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep1(dtRep, dr, 3, True, False) & "</td>")
            colAlterna = Not colAlterna
        End If
        If mes >= trimestre * 4 Then
            Response.Write("<td align='center' class='datos3" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep1(dtRep, dr, 4, True, False) & "</td>")
            colAlterna = Not colAlterna
        End If
        If (mes Mod trimestre) = 0 Then
            Response.Write("<td align='center' class='datos3" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep1(dtRep, dr, mes, False, False) & "</td>")
            colAlterna = Not colAlterna
        Else
            For i As Integer = 1 To (mes Mod trimestre)
                Dim mes_actual As Integer = Math.Floor((mes / trimestre)) * trimestre + i
                Response.Write("<td align='center' class='datos3" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep1(dtRep, dr, mes_actual, False, False) & "</td>")
                colAlterna = Not colAlterna
            Next
        End If

        Response.Write("<td align='center' class='datos3" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep1(dtRep, dr, -1, False, False) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos3" & IIf(colAlterna, " columnaAlterna", "") & "'><b>" & FormateaValorRep1(dtRep, dr, 0, False, False) & "</b></td>")
        Response.Write("</tr>")
        
        
    Next
%>
    </table>
    </div>





    <div id="divReporte_2" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Estado de Resultados")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(2);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_2', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    <table id="tblReporte_2" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td align="center" class="titulos"><b><%=TranslateLocale.text("Concepto")%></b></td>
<%
    dtRep = dsReporte.Tables(1)



    If mes >= trimestre Then Response.Write("<td align='center' class='titulos'><b>T1</b></td><td align='center' class='titulos'>%</td>")
    If mes >= trimestre * 2 Then Response.Write("<td align='center' class='titulos'><b>T2</b></td><td align='center' class='titulos'>%</td>")
    If mes >= trimestre * 3 Then Response.Write("<td align='center' class='titulos'><b>T3</b></td><td align='center' class='titulos'>%</td>")
    If mes >= trimestre * 4 Then Response.Write("<td align='center' class='titulos'><b>T4</b></td><td align='center' class='titulos'>%</td>")
    If (mes Mod trimestre) = 0 Then
        Response.Write("<td align='center' class='titulos'><b>" & NombrePeriodo(mes) & "</b></td><td align='center' class='titulos'>%</td>")
    Else
        For i As Integer = 1 To (mes Mod trimestre)
            Response.Write("<td align='center' class='titulos'><b>" & NombrePeriodo(Math.Floor((mes / trimestre)) * trimestre + i) & "</b></td><td align='center' class='titulos'>%</td>")
        Next
    End If
    Response.Write("<td align='center' class='titulos'><b>Acum " & anio & "</b></td><td align='center' class='titulos'>%</td>")
    Response.Write("<td align='center' class='titulos'><b>Acum " & (anio - 1) & "</b></td><td align='center' class='titulos'>%</td>")
    Response.Write("<td align='center' class='titulos'><b>" & anio & "-" & (anio - 1) & "</b></td><td align='center' class='titulos'>%</td>")
    Response.Write("<td align='center' class='titulos'><b>Plan</b></td><td align='center' class='titulos'>%</td>")
    Response.Write("<td align='center' class='titulos'><b>R-P</b></td><td align='center' class='titulos'>%</td>")

%>
        </tr>
<% 
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False

        If imprimir_separador Then
            Response.Write("<tr><td colspan='1'><div style='height:7px'></div></td></tr>")
        End If

        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos columnaTitulos' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")

        If mes >= trimestre Then
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2(dr, 1, True, False, False, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2(dr, 1, True, False, False, 2) & "</td>")
            colAlterna = Not colAlterna
        End If
        If mes >= trimestre * 2 Then
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2(dr, 2, True, False, False, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2(dr, 2, True, False, False, 2) & "</td>")
            colAlterna = Not colAlterna
        End If
        If mes >= trimestre * 3 Then
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2(dr, 3, True, False, False, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2(dr, 3, True, False, False, 2) & "</td>")
            colAlterna = Not colAlterna
        End If
        If mes >= trimestre * 4 Then
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2(dr, 4, True, False, False, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2(dr, 4, True, False, False, 2) & "</td>")
            colAlterna = Not colAlterna
        End If
        If (mes Mod trimestre) = 0 Then
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2(dr, mes, False, False, False, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2(dr, mes, False, False, False, 2) & "</td>")
            colAlterna = Not colAlterna
        Else
            For i As Integer = 1 To (mes Mod trimestre)
                Dim mes_actual As Integer = Math.Floor((mes / trimestre)) * trimestre + i
                Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2(dr, mes_actual, False, False, False, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2(dr, mes_actual, False, False, False, 2) & "</td>")
                colAlterna = Not colAlterna
            Next
        End If
        
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2(dr, 0, False, True, False, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2(dr, 0, False, True, False, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2(dr, 0, False, False, True, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2(dr, 0, False, False, True, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2Tots(dr, 1, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2Tots(dr, 1, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2Tots(dr, 2, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2Tots(dr, 2, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2Tots(dr, 3, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2Tots(dr, 3, 2) & "</td>")
        Response.Write("</tr>")
        
        imprimir_separador = dr("separador_despues")
    Next

    
    imprimir_separador = True
    dtRep = dsReporte.Tables(2)
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False

        If imprimir_separador Then
            Response.Write("<tr><td colspan='1'><div style='height:20px'></div></td></tr>")
        End If
        imprimir_separador=False

        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos columnaTitulos' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")

        If mes >= trimestre Then
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2(dr, 1, True, False, False, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2(dr, 1, True, False, False, 2) & "</td>")
            colAlterna = Not colAlterna
        End If
        If mes >= trimestre * 2 Then
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2(dr, 2, True, False, False, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2(dr, 2, True, False, False, 2) & "</td>")
            colAlterna = Not colAlterna
        End If
        If mes >= trimestre * 3 Then
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2(dr, 3, True, False, False, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2(dr, 3, True, False, False, 2) & "</td>")
            colAlterna = Not colAlterna
        End If
        If mes >= trimestre * 4 Then
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2(dr, 4, True, False, False, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2(dr, 4, True, False, False, 2) & "</td>")
            colAlterna = Not colAlterna
        End If
        If (mes Mod trimestre) = 0 Then
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2(dr, mes, False, False, False, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2(dr, mes, False, False, False, 2) & "</td>")
            colAlterna = Not colAlterna
        Else
            For i As Integer = 1 To (mes Mod trimestre)
                Dim mes_actual As Integer = Math.Floor((mes / trimestre)) * trimestre + i
                Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2(dr, mes_actual, False, False, False, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2(dr, mes_actual, False, False, False, 2) & "</td>")
                colAlterna = Not colAlterna
            Next
        End If
        
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2(dr, 0, False, True, False, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2(dr, 0, False, True, False, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep2(dr, 0, False, False, True, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep2(dr, 0, False, False, True, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td>&nbsp;</td>")
        colAlterna = Not colAlterna
        Response.Write("<td>&nbsp;</td>")
        colAlterna = Not colAlterna
        Response.Write("<td>&nbsp;</td>")
        Response.Write("</tr>")
        
    Next
    
    %>
    </table>
    </div>


    
    <div id="divReporte_3" style="display:none;">
            <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Estado de Resultados")%> - <%= anio & " vs " & (anio - 1)%><span class="linkCopias"><a href="#" onclick="TomaFoto(3);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_3', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    <table id="tblReporte_3" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td rowspan="2" align="center" class="titulos"><b><%=TranslateLocale.text("CONCEPTO")%></b></td>
            <td>&nbsp;</td>
            <td colspan="6" align="center" class="titulos">NB</td>
            <td>&nbsp;</td>
            <td colspan="6" align="center" class="titulos">NBA</td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos"><%=TranslateLocale.text("CONSOLIDADO")%></td>
        </tr>
        <tr class="filaTotales">
            <td>&nbsp;</td>
            <td align='center' class='titulos'><b><%=anio%></b></td><td align='center' class='titulos'>%</td>
            <td align='center' class='titulos'><b><%=(anio-1)%></b></td><td align='center' class='titulos'>%</td>
            <td align='center' class='titulos'><b>R-P($)</b></td>
            <td align='center' class='titulos'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos'><b><%=anio%></b></td><td align='center' class='titulos'>%</td>
            <td align='center' class='titulos'><b><%=(anio-1)%></b></td><td align='center' class='titulos'>%</td>
            <td align='center' class='titulos'><b>R-P($)</b></td>
            <td align='center' class='titulos'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos'><b><%=anio%></b></td><td align='center' class='titulos'>%</td>
            <td align='center' class='titulos'><b><%=(anio-1)%></b></td><td align='center' class='titulos'>%</td>
            <td align='center' class='titulos'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
        </tr>
<% 
    dtRep = dsReporte.Tables(3)
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False

        If imprimir_separador Then
            Response.Write("<tr><td colspan='15'><div style='height:7px'></div></td></tr>")
        End If

        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos columnaTitulos' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep3(dr, 1, 1, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep3(dr, 1, 1, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep3(dr, 1, 2, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep3(dr, 1, 2, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 1, 3, 1) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 1, 4, 1) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep3(dr, 2, 5, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep3(dr, 2, 5, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep3(dr, 2, 6, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep3(dr, 2, 6, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 2, 7, 1) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 2, 8, 1) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep3(dr, 3, 9, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep3(dr, 3, 9, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep3(dr, 3, 10, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep3(dr, 3, 10, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 3, 11, 1) & "</td>")

        Response.Write("</tr>")
        
        imprimir_separador = dr("separador_despues")
    Next
%>
    </table>
    </div>




    <div id="divReporte_4" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Balance General")%> - <%= NombrePeriodo(mes) & " / " & (anio - 2000)%><span class="linkCopias"><a href="#" onclick="TomaFoto(4);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_4', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    
        <table id="tblReporte_4" border="0" cellpadding="0" cellspacing="0" style="border:none;border-style:none;">
            <tr valign="top">
                <td>


                    <table border="1" cellpadding="0" cellspacing="0">
                        <tr class="filaTotales">
                            <td align="center" class="titulos2"><b><%=TranslateLocale.text("CONCEPTO")%></b></td>
                            <td>&nbsp;</td>
                <% 
                    Dim ultimo_mes As Integer = 0
                    Dim penultimo_mes As Integer = 0
                    Dim ultimo_anio As Integer = 0
                    Dim penultimo_anio As Integer = 0
                    Dim ultimo_id As Integer = 0
                    Dim penultimo_id As Integer = 0

                    Dim dtCuartos As DataTable = dsReporte.Tables(23)
                    For Each drX As DataRow In dtCuartos.Rows
                %>        
                            <td align="center" class="titulos2" width="45px"><%= Left(NombrePeriodo(drX("periodo")), 3) & "-" & (drX("anio") - 2000)%></td><td align="center" class="titulos2">%</td>
                <%
                    penultimo_mes = ultimo_mes
                    ultimo_mes = drX("periodo")
                    penultimo_anio = ultimo_anio
                    ultimo_anio = drX("anio")
                    penultimo_id = ultimo_id
                    ultimo_id = drX("id")
                Next
                %>
                            <td>&nbsp;</td>
                            <td align="center" class="titulos2"><%= Left(NombrePeriodo(ultimo_mes), 3) & " '" & (ultimo_anio - 2000) & " - <br />" & Left(NombrePeriodo(penultimo_mes), 3) & " '" & (penultimo_anio - 2000)%></td>
                        </tr>
                <% 
                    dtRep = dsReporte.Tables(7)


                    For Each dr As DataRow In dtRep.Rows
                        colAlterna = False
                        If imprimir_separador Then
                            Response.Write("<tr><td colspan='1'><div style='height:7px'></div></td></tr>")
                        End If
        
                        Response.Write("<tr>")
                        Response.Write("<td align='left' class='subtitulos2 columnaTitulos' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
                        Response.Write("<td>&nbsp;</td>")
        
 
         
                        ultimo_mes = 0
                        penultimo_mes = 0
                        ultimo_anio = 0
                        penultimo_anio = 0
                        ultimo_id = 0
                        penultimo_id = 0  
        
                        For Each drX As DataRow In dtCuartos.Rows
                            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep7(dr, drX("id"), 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep7(dr, drX("id"), 2) & "</td>")
  
                            penultimo_mes = ultimo_mes
                            ultimo_mes = drX("periodo")
                            penultimo_anio = ultimo_anio
                            ultimo_anio = drX("anio")
                            penultimo_id = ultimo_id
                            ultimo_id = drX("id")
                        Next
          
         
                        Response.Write("<td>&nbsp;</td>")
                        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep7Resta(dr, ultimo_id, penultimo_id) & "</td>")

                        Response.Write("</tr>")
        
                        imprimir_separador = dr("separador_despues")
                    Next
                %>

            <tr valign="top"><td>&nbsp;</td></tr>

<% 
    Dim dtRepExtras As DataTable = dsReporte.Tables(24)

    For Each dr As DataRow In dtRepExtras.Rows
        colAlterna = False
        If imprimir_separador Then
            Response.Write("<tr><td colspan='1'><div style='height:20px'></div></td></tr>")
        End If

        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos2 columnaTitulos'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        ultimo_mes = 0
        penultimo_mes = 0
        ultimo_anio = 0
        penultimo_anio = 0
        ultimo_id = 0
        penultimo_id = 0
        
        For Each drX As DataRow In dtCuartos.Rows
            Response.Write("<td colspan='2' align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & IIf(dr("formato_decimal"), CType(dr("monto" & drX("id")), Double).ToString("###,##0.0"), IIf(dr("formato_porciento"), CType(dr("monto" & drX("id")), Double).ToString("###,##0") & "%", CType(dr("monto" & drX("id")), Double).ToString("###,##0"))) & "</td>")
  
            penultimo_mes = ultimo_mes
            ultimo_mes = drX("periodo")
            penultimo_anio = ultimo_anio
            ultimo_anio = drX("anio")
            penultimo_id = ultimo_id
            ultimo_id = drX("id")
        Next
          
         
        Response.Write("<td colspan='2'>&nbsp;</td>")

        Response.Write("</tr>")
        imprimir_separador = dr("separador_despues")
        
    Next
                %>


                    </table>


                </td>
                <td>&nbsp;&nbsp;&nbsp;
                </td>
                <td>

                    <table border="1" cellpadding="0" cellspacing="0">
                        <tr>
                            <td align="center" colspan="2" class="titulos2"><%=TranslateLocale.text("CAJA")%></td>
                        </tr>
                        <tr>
                            <td class="titulos2">Plan <%=Left(NombrePeriodo(ultimo_mes), 3) %></td>
                            <td class="titulos2">Var</td>
                        </tr>
                        <tr>
                            <td align="right" class="datos"><%=dtRep.Rows(0)("plan1")%></td>
                            <td align="right" class="datos"><%=dtRep.Rows(0)("var1")%></td>
                        </tr>
                        <tr>
                            <td colspan="2"><div style="height:7px;"></div></td>
                        </tr>
                        <tr>
                            <td class="titulos2"><%=TranslateLocale.text("Pronóstico")%> <%=Left(NombrePeriodo(ultimo_mes+1), 3) %></td>
                            <td class="titulos2">Var</td>
                        </tr>
                        <tr>
                            <td align="right" class="datos"><%=dtRep.Rows(0)("plan2")%></td>
                            <td align="right" class="datos"><%=dtRep.Rows(0)("var2")%></td>
                        </tr>
                    </table>


                </td>
            </tr>
        </table>
    </div>





        <div id="divReporte_12" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Perfil de Deuda")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(12);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_12', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    <table id="tblReporte_12">
        <tr valign="top">
            <td>
    
    <table border="1" cellpadding="0" cellspacing="0">
<%

    dtRep = dsReporte.Tables(18)

    Dim muestra7 As Boolean = False
    Dim muestra8 As Boolean = False
    Dim muestra9 As Boolean = False
    Dim muestra10 As Boolean = False
    Dim muestra11 As Boolean = False
    For Each drDato As DataRow In dtRep.Rows
        If drDato("monto7") > 0 Then muestra7 = True
        If drDato("monto8") > 0 Then muestra8 = True
        If drDato("monto9") > 0 Then muestra9 = True
        If drDato("monto10") > 0 Then muestra10 = True
        If drDato("monto11") > 0 Then muestra11 = True
    Next
    
    
%>
                <tr class="titulos2">
                    <td align="center"><b><%=TranslateLocale.text("Cia")%></b></td>
                    <td align="center"><b><%=TranslateLocale.text("Banco")%></b></td>
                    <td align="center"><b><%=TranslateLocale.text("Tipo")%></b></td>
                    <td align="center"><b><%=TranslateLocale.text("Deuda")%></b></td>
                    <td align="center"><b><%=(anio)%></b></td>
                    <td align="center"><b><%=(anio + 1)%></b></td>
                    <td align="center"><b><%=(anio + 2)%></b></td>
                    <td align="center"><b><%=(anio + 3)%></b></td>
                    <td align="center"><b><%=(anio + 4)%></b></td>
                    <%
                        If muestra7 Then Response.Write("<td align='center'><b>" & (anio + 5) & "</b></td>")
                        If muestra8 Then Response.Write("<td align='center'><b>" & (anio + 6) & "</b></td>")
                        If muestra9 Then Response.Write("<td align='center'><b>" & (anio + 7) & "</b></td>")
                        If muestra10 Then Response.Write("<td align='center'><b>" & (anio + 8) & "</b></td>")
                        If muestra11 Then Response.Write("<td align='center'><b>" & (anio + 9) & "</b></td>")
                        %>
                    <td align="center"><b><%=TranslateLocale.text("Deuda")%> + <br /><%=TranslateLocale.text("Interes")%></b></td>
                    <td align="center"><b><%=TranslateLocale.text("Linea")%> <br /><%=TranslateLocale.text("Disp")%></b></td>
                </tr>
<%
    Dim deuda_total As Integer = 0
    
    For Each drDato As DataRow In dtRep.Rows
        colAlterna = False

        Dim deuda As Integer = 0
        Dim deuda_interes As Integer = 0
        Dim monto_1 As Decimal = 0
        Dim monto_2 As Decimal = 0
        Dim monto_3 As Decimal = 0
        Dim monto_4 As Decimal = 0
        Dim monto_5 As Decimal = 0
        Dim monto_7 As Decimal = 0
        Dim monto_8 As Decimal = 0
        Dim monto_9 As Decimal = 0
        Dim monto_10 As Decimal = 0
        Dim monto_11 As Decimal = 0
        Dim linea_disp As Decimal = 0
        
        Dim cia As String = drDato("cia")
        Dim banco As String = TranslateLocale.text(drDato("descripcion"))
        Dim tipo As String = TranslateLocale.text(drDato("descripcion_2"))

        monto_1 = drDato("monto1")
        monto_2 = drDato("monto2")
        monto_3 = drDato("monto3")
        monto_4 = drDato("monto4")
        monto_5 = drDato("monto5")
        monto_7 = drDato("monto7")
        monto_8 = drDato("monto8")
        monto_9 = drDato("monto9")
        monto_10 = drDato("monto10")
        monto_11 = drDato("monto11")
        linea_disp = drDato("monto6")
        deuda = monto_1 + monto_2 + monto_3 + monto_4 + monto_5 + monto_7 + monto_8 + monto_9 + monto_10 + monto_11
        deuda_interes = deuda
        If banco = "-- Intereses" Then
            deuda = 0
        End If
                
        If tipo.IndexOf("TOTAL") >= 0 Then
            deuda = deuda_total
            deuda_total = 0
        Else
            deuda_total += deuda
        End If
        
        Dim permite_captura As Boolean = drDato("permite_captura")
        colAlterna = Not colAlterna
 %>
                <tr <%=IIf(drDato("permite_captura")=False,"class='filaTotales'","") %>>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>'><span style="font-size:14px;"><b><%=cia%></b></span></td>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>'><%=banco%></td>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>'><%=tipo%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(deuda < 0, " negativo", "")%>'><%=IIf(deuda <> 0, Format(deuda, "###,###,##0"), "")%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_1 < 0, " negativo", "")%>'><%=IIf(monto_1 <> 0, Format(monto_1, "###,###,##0"), "")%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_2 < 0, " negativo", "")%>'><%=IIf(monto_2 <> 0, Format(monto_2, "###,###,##0"), "")%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_3 < 0, " negativo", "")%>'><%=IIf(monto_3 <> 0, Format(monto_3, "###,###,##0"), "")%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_4 < 0, " negativo", "")%>'><%=IIf(monto_4 <> 0, Format(monto_4, "###,###,##0"), "")%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_5 < 0, " negativo", "")%>'><%=IIf(monto_5 <> 0, Format(monto_5, "###,###,##0"), "")%></td>
                    <% If muestra7 Then%>
                        <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_7 < 0, " negativo", "")%>'><%=IIf(monto_7 <> 0, Format(monto_7, "###,###,##0"), "")%></td>
                    <% End If%>
                    <% If muestra8 Then%>
                        <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_8 < 0, " negativo", "")%>'><%=IIf(monto_8 <> 0, Format(monto_8, "###,###,##0"), "")%></td>
                    <% End If%>
                    <% If muestra9 Then%>
                        <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_9 < 0, " negativo", "")%>'><%=IIf(monto_9 <> 0, Format(monto_9, "###,###,##0"), "")%></td>
                    <% End If%>
                    <% If muestra10 Then%>
                        <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_10 < 0, " negativo", "")%>'><%=IIf(monto_10 <> 0, Format(monto_10, "###,###,##0"), "")%></td>
                    <% End If%>
                    <% If muestra11 Then%>
                        <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_11 < 0, " negativo", "")%>'><%=IIf(monto_11 <> 0, Format(monto_11, "###,###,##0"), "")%></td>
                    <% End If%>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(deuda_interes < 0, " negativo", "")%>'><%=IIf(deuda_interes <> 0, Format(deuda_interes, "###,###,##0"), "")%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(linea_disp < 0, " negativo", "")%>'><%=IIf(linea_disp <> 0, Format(linea_disp, "###,###,##0"), "")%></td>
                </tr>
        <% 
            If permite_captura = False Then
                %>
            <tr><td colspan="11" style="background-color:#dedcdc;"><div style="background-color:#dedcdc;"></div></td></tr>
        <%
            End If
            %>
<%
Next
%>
            </table>    

<br />

    <table border="1" cellpadding="0" cellspacing="0">
<%

    dtRep = dsReporte.Tables(20)
    muestra7 = False
    muestra8 = False
    muestra9 = False
    muestra10 = False
    muestra11 = False
    For Each drDato As DataRow In dtRep.Rows
        If drDato("monto7") > 0 Then muestra7 = True
        If drDato("monto8") > 0 Then muestra8 = True
        If drDato("monto9") > 0 Then muestra9 = True
        If drDato("monto10") > 0 Then muestra10 = True
        If drDato("monto11") > 0 Then muestra11 = True
    Next
%>
                <tr class="titulos2">
                    <td align="center"><b><%=TranslateLocale.text("Tipo")%></b></td>
                    <td align="center"><b><%=TranslateLocale.text("Deuda")%></b></td>
                    <td align="center"><b><%=(anio)%></b></td>
                    <td align="center"><b><%=(anio + 1)%></b></td>
                    <td align="center"><b><%=(anio + 2)%></b></td>
                    <td align="center"><b><%=(anio + 3)%></b></td>
                    <td align="center"><b><%=(anio + 4)%></b></td>
                    <%
                        If muestra7 Then Response.Write("<td align='center'><b>" & (anio + 5) & "</b></td>")
                        If muestra8 Then Response.Write("<td align='center'><b>" & (anio + 6) & "</b></td>")
                        If muestra9 Then Response.Write("<td align='center'><b>" & (anio + 7) & "</b></td>")
                        If muestra10 Then Response.Write("<td align='center'><b>" & (anio + 8) & "</b></td>")
                        If muestra11 Then Response.Write("<td align='center'><b>" & (anio + 9) & "</b></td>")
                        %>
                    <td align="center"><b><%=TranslateLocale.text("Deuda")%> + <br /><%=TranslateLocale.text("Interes")%></b></td>
                    <td align="center"><b><%=TranslateLocale.text("Linea")%> <br /><%=TranslateLocale.text("Disp")%></b></td>
                </tr>
<%
    Dim separador_usado As Boolean = False
    For Each drDato As DataRow In dtRep.Rows
        colAlterna = False

        Dim deuda As Integer = 0
        Dim deuda_interes As Integer = 0
        Dim monto_1 As Decimal = 0
        Dim monto_2 As Decimal = 0
        Dim monto_3 As Decimal = 0
        Dim monto_4 As Decimal = 0
        Dim monto_5 As Decimal = 0
        Dim monto_7 As Decimal = 0
        Dim monto_8 As Decimal = 0
        Dim monto_9 As Decimal = 0
        Dim monto_10 As Decimal = 0
        Dim monto_11 As Decimal = 0
        Dim linea_disp As Decimal = 0
        
        Dim cia As String = drDato("cia")
        Dim banco As String = TranslateLocale.text(drDato("descripcion"))
        Dim tipo As String = TranslateLocale.text(drDato("descripcion_2"))

        monto_1 = drDato("monto1")
        monto_2 = drDato("monto2")
        monto_3 = drDato("monto3")
        monto_4 = drDato("monto4")
        monto_5 = drDato("monto5")
        monto_7 = drDato("monto7")
        monto_8 = drDato("monto8")
        monto_9 = drDato("monto9")
        monto_10 = drDato("monto10")
        monto_11 = drDato("monto11")
        linea_disp = drDato("monto6")
        deuda = drDato("monto_sub_total")
        deuda_interes = monto_1 + monto_2 + monto_3 + monto_4 + monto_5 + monto_7 + monto_8 + monto_9 + monto_10 + monto_11
                
        
        Dim permite_captura As Boolean = drDato("extras")
        colAlterna = Not colAlterna

        If permite_captura = True And separador_usado = False Then
            separador_usado = True
                %>
            <tr><td colspan="11" style="background-color:#dedcdc;"><div style="background-color:#dedcdc;"></div></td></tr>
        <%
            End If
            %>

                <tr <%=IIf(drDato("permite_captura")=False,"class='filaTotales'","") %>>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>' style="width:250px;"><%=tipo%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(deuda < 0, " negativo", "")%>'><%=IIf(deuda <> 0, Format(deuda, "###,###,##0"), "")%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_1 < 0, " negativo", "")%>'><%=IIf(monto_1 <> 0, Format(monto_1, "###,###,##0"), "")%></td>
<%
    If drDato("extras") = True Then
%>
                    <%--<td colspan="6">&nbsp;</td>--%>                          
<%
    Else
%>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_2 < 0, " negativo", "")%>'><%=IIf(monto_2 <> 0, Format(monto_2, "###,###,##0"), "")%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_3 < 0, " negativo", "")%>'><%=IIf(monto_3 <> 0, Format(monto_3, "###,###,##0"), "")%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_4 < 0, " negativo", "")%>'><%=IIf(monto_4 <> 0, Format(monto_4, "###,###,##0"), "")%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_5 < 0, " negativo", "")%>'><%=IIf(monto_5 <> 0, Format(monto_5, "###,###,##0"), "")%></td>
                    <% If muestra7 Then%>
                        <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_7 < 0, " negativo", "")%>'><%=IIf(monto_7 <> 0, Format(monto_7, "###,###,##0"), "")%></td>
                    <% End If%>
                    <% If muestra8 Then%>
                        <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_8 < 0, " negativo", "")%>'><%=IIf(monto_8 <> 0, Format(monto_8, "###,###,##0"), "")%></td>
                    <% End If%>
                    <% If muestra9 Then%>
                        <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_9 < 0, " negativo", "")%>'><%=IIf(monto_9 <> 0, Format(monto_9, "###,###,##0"), "")%></td>
                    <% End If%>
                    <% If muestra10 Then%>
                        <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_10 < 0, " negativo", "")%>'><%=IIf(monto_10 <> 0, Format(monto_10, "###,###,##0"), "")%></td>
                    <% End If%>
                    <% If muestra11 Then%>
                        <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_11 < 0, " negativo", "")%>'><%=IIf(monto_11 <> 0, Format(monto_11, "###,###,##0"), "")%></td>
                    <% End If%>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(deuda_interes < 0, " negativo", "")%>'><%=IIf(deuda_interes <> 0, Format(deuda_interes, "###,###,##0"), "")%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(linea_disp < 0, " negativo", "")%>'><%=IIf(linea_disp <> 0, Format(linea_disp, "###,###,##0"), "")%></td>
                            
<%
End If
%>
                </tr>
<%
Next
%>
            </table>    

    







<%--
    <table border="1" cellpadding="0" cellspacing="0">
<%

    dtRep = dsReporte.Tables(19)
    muestra7 = False
    muestra8 = False
    muestra9 = False
    muestra10 = False
    muestra11 = False
    For Each drDato As DataRow In dtRep.Rows
        If drDato("monto7") > 0 Then muestra7 = True
        If drDato("monto8") > 0 Then muestra8 = True
        If drDato("monto9") > 0 Then muestra9 = True
        If drDato("monto10") > 0 Then muestra10 = True
        If drDato("monto11") > 0 Then muestra11 = True
    Next
%>
                <tr class="titulos2">
                    <td align="center"><b>Cia</b></td>
                    <td align="center"><b>Banco</b></td>
                    <td align="center"><b>Tipo</b></td>
                    <td align="center"><b>Deuda</b></td>
                    <td align="center"><b><%=(anio)%></b></td>
                    <td align="center"><b><%=(anio + 1)%></b></td>
                    <td align="center"><b><%=(anio + 2)%></b></td>
                    <td align="center"><b><%=(anio + 3)%></b></td>
                    <td align="center"><b><%=(anio + 4)%></b></td>
                    <%
                        If muestra7 Then Response.Write("<td align='center'><b>" & (anio + 5) & "</b></td>")
                        If muestra8 Then Response.Write("<td align='center'><b>" & (anio + 6) & "</b></td>")
                        If muestra9 Then Response.Write("<td align='center'><b>" & (anio + 7) & "</b></td>")
                        If muestra10 Then Response.Write("<td align='center'><b>" & (anio + 8) & "</b></td>")
                        If muestra11 Then Response.Write("<td align='center'><b>" & (anio + 9) & "</b></td>")
                        %>
                    <td align="center"><b>Deuda + <br />Interes</b></td>
                    <td align="center"><b>Linea <br />Disp</b></td>
                </tr>
<%
    For Each drDato As DataRow In dtRep.Rows
        colAlterna = False

        Dim deuda As Integer = 0
        Dim deuda_interes As Integer = 0
        Dim monto_1 As Decimal = 0
        Dim monto_2 As Decimal = 0
        Dim monto_3 As Decimal = 0
        Dim monto_4 As Decimal = 0
        Dim monto_5 As Decimal = 0
        Dim monto_7 As Decimal = 0
        Dim monto_8 As Decimal = 0
        Dim monto_9 As Decimal = 0
        Dim monto_10 As Decimal = 0
        Dim monto_11 As Decimal = 0
        Dim linea_disp As Decimal = 0
        
        Dim cia As String = drDato("cia")
        Dim banco As String = TranslateLocale.text(drDato("descripcion"))
        Dim tipo As String = TranslateLocale.text(drDato("descripcion_2"))
        
        monto_1 = drDato("monto1")
        monto_2 = drDato("monto2")
        monto_3 = drDato("monto3")
        monto_4 = drDato("monto4")
        monto_5 = drDato("monto5")
        monto_7 = drDato("monto7")
        monto_8 = drDato("monto8")
        monto_9 = drDato("monto9")
        monto_10 = drDato("monto10")
        monto_11 = drDato("monto11")
        linea_disp = drDato("monto6")
        deuda = monto_1 + monto_2 + monto_3 + monto_4 + monto_5 + monto_7 + monto_8 + monto_9 + monto_10 + monto_11
        deuda_interes = deuda
        If banco = "-- Intereses" Then
            deuda = 0
        End If

        If tipo.IndexOf("TOTAL") >= 0 Then
            deuda = deuda_total
            deuda_total = 0
        Else
            deuda_total += deuda
        End If
        
        Dim permite_captura As Boolean = drDato("permite_captura")
        colAlterna = Not colAlterna
 %>
                <tr <%=IIf(drDato("permite_captura")=False,"class='filaTotales'","") %>>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>'><span style="font-size:14px;"><b><%=cia%></b></span></td>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>'><%=banco%></td>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>'><%=tipo%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(deuda < 0, " negativo", "")%>'><%=IIf(deuda <> 0, Format(deuda, "###,###,##0"), "")%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_1 < 0, " negativo", "")%>'><%=IIf(monto_1 <> 0, Format(monto_1, "###,###,##0"), "")%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_2 < 0, " negativo", "")%>'><%=IIf(monto_2 <> 0, Format(monto_2, "###,###,##0"), "")%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_3 < 0, " negativo", "")%>'><%=IIf(monto_3 <> 0, Format(monto_3, "###,###,##0"), "")%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_4 < 0, " negativo", "")%>'><%=IIf(monto_4 <> 0, Format(monto_4, "###,###,##0"), "")%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_5 < 0, " negativo", "")%>'><%=IIf(monto_5 <> 0, Format(monto_5, "###,###,##0"), "")%></td>
                    <% If muestra7 Then%>
                        <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_7 < 0, " negativo", "")%>'><%=IIf(monto_7 <> 0, Format(monto_7, "###,###,##0"), "")%></td>
                    <% End If%>
                    <% If muestra8 Then%>
                        <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_8 < 0, " negativo", "")%>'><%=IIf(monto_8 <> 0, Format(monto_8, "###,###,##0"), "")%></td>
                    <% End If%>
                    <% If muestra9 Then%>
                        <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_9 < 0, " negativo", "")%>'><%=IIf(monto_9 <> 0, Format(monto_9, "###,###,##0"), "")%></td>
                    <% End If%>
                    <% If muestra10 Then%>
                        <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_10 < 0, " negativo", "")%>'><%=IIf(monto_10 <> 0, Format(monto_10, "###,###,##0"), "")%></td>
                    <% End If%>
                    <% If muestra11 Then%>
                        <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_11 < 0, " negativo", "")%>'><%=IIf(monto_11 <> 0, Format(monto_11, "###,###,##0"), "")%></td>
                    <% End If%>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(deuda_interes < 0, " negativo", "")%>'><%=IIf(deuda_interes <> 0, Format(deuda_interes, "###,###,##0"), "")%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(linea_disp < 0, " negativo", "")%>'><%=IIf(linea_disp <> 0, Format(linea_disp, "###,###,##0"), "")%></td>
                </tr>
        <% 
            If permite_captura = False Then
                %>
            <tr><td colspan="11" style="background-color:#dedcdc;"><div style="background-color:#dedcdc;"></div></td></tr>
        <%
            End If
            %>
<%
Next
%>
            </table>
--%>


<br />





            </td>
        </tr>
    </table>
    </div>




       <% If New Date(anio, mes, 1) < New Date(2018, 10, 1) Then%>
    <!--VERSION ANTERIOR-->
    <!--VERSION ANTERIOR-->
    <!--VERSION ANTERIOR-->

    <div id="divReporte_5" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Estado de Cambios Base Efectivo")%><span class="linkCopias"><a href="#" onclick="TomaFoto(5);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_5', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    <div style='font-size:14px;'><%=TranslateLocale.text("Del 1 de Enero al")%> <%= (DateSerial(Year(New Date(anio, mes, 1)), Month(New Date(anio, mes, 1)) + 1, 0)).Day & TranslateLocale.text(" de ") & NombrePeriodo(mes) & TranslateLocale.text(" del ") & anio%></div>             
    <table id="tblReporte_5" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td align="center" class="titulos2"><b><%=TranslateLocale.text("CONCEPTO")%></b></td>
            <td>&nbsp;</td>
            <%--<td align="center" class="titulos2">&nbsp;</td>--%>
            <td align="center" class="titulos2">NB</td>
            <%--<td align="center" class="titulos2">NBA</td>--%>
        </tr>
<% 
    dtRep = dsReporte.Tables(8)
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False

        If imprimir_separador Then
            Response.Write("<tr><td colspan='6'><div style='height:7px'></div></td></tr>")
        End If

        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos2 columnaTitulos' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        'Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 0) & "</td>")
        'colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 3) & "</td>")
        colAlterna = Not colAlterna
        'Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 4) & "</td>")
        'colAlterna = Not colAlterna

        Response.Write("</tr>")
        
        imprimir_separador = dr("separador_despues")
    Next
%>
    </table>
    </div>

    <!--VERSION ANTERIOR-->
    <!--VERSION ANTERIOR-->
    <!--VERSION ANTERIOR-->
       <% Else%>
    <!--VERSION NUEVA-->
    <!--VERSION NUEVA-->
    <!--VERSION NUEVA-->

    <div id="divReporte_5" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Estado de Cambios Base Efectivo")%><span class="linkCopias"><a href="#" onclick="TomaFoto(5);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_5', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    <div style='font-size:14px;'><%=TranslateLocale.text("Del 1 de Enero al")%> <%= (DateSerial(Year(New Date(anio, mes, 1)), Month(New Date(anio, mes, 1)) + 1, 0)).Day & TranslateLocale.text(" de ") & NombrePeriodo(mes) & TranslateLocale.text(" del ") & anio%></div>             
    <table id="tblReporte_5" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td align="center" class="titulos2"><b><%=TranslateLocale.text("CONCEPTO")%></b></td>
            <td>&nbsp;</td>
            <%--<td align="center" class="titulos2">&nbsp;</td>--%>
            <td align="center" class="titulos2">NB</td>
            <%--<td align="center" class="titulos2">NBA</td>--%>
        </tr>
<% 
    dtRep = dsReporte.Tables(52)
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False

        If imprimir_separador Then
            Response.Write("<tr><td colspan='6'><div style='height:7px'></div></td></tr>")
        End If

        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos2 columnaTitulos' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        

        If dr("solo_titulo") Then
            'Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>&nbsp;</td>")
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>&nbsp;</td>")
            'Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>&nbsp;</td>")
        Else
            'Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 0) & "</td>")
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 3) & "</td>")
            'Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 4) & "</td>")
        End If

        
        Response.Write("</tr>")
        
        imprimir_separador = dr("separador_despues")
    Next
%>
    </table>
    </div>


















    

    
    <div id="divReporte_16" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Flujo de Efectivo")%></div>
    <div style='font-size:14px;'><%=TranslateLocale.text("Del 1 de Enero al")%> <%= (DateSerial(Year(New Date(anio, mes, 1)), Month(New Date(anio, mes, 1)) + 1, 0)).Day & TranslateLocale.text(" de ") & NombrePeriodo(mes) & TranslateLocale.text(" del ") & anio%></div>
<%
    dtRep = dsReporte.Tables(53)
%>

	<script type="text/javascript">
	    $(function () {
	        $('#containerFlujoEfectivo').highcharts({
	            chart: {
	                type: 'waterfall'
	            },

	            title: {
	                text: '<%=TranslateLocale.text("Flujo de Efectivo")%>'
	            },

	            xAxis: {
	                type: 'category'
	            },

	            yAxis: {
	                title: {
	                    text: 'USD'
	                }
	            },

	            legend: {
	                enabled: false
	            },

	            tooltip: {
	                pointFormat: '<b>${point.y:,.2f}</b> USD'
	            },

	            series: [{
	                upColor: Highcharts.getOptions().colors[2], //2
	                color: Highcharts.getOptions().colors[8],
	                data: [{
	                    name: '<%=TranslateLocale.text("Caja Final Dic/") & (anio - 1)%>',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 1)%>,
	                    color: Highcharts.getOptions().colors[7]
	                }, {
	                    name: '<%=TranslateLocale.text("Utilidad Neta")%>',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 2)%>,
	                }, {
	                    name: '<%=TranslateLocale.text("Depreciación y Amortización")%>',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 3)%>,
	                }, {
	                    name: '<%=TranslateLocale.text("Partidas Contables")%>',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 4)%>,
	                }, {
	                    name: '<%=TranslateLocale.text("Capital de Trabajo")%>',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 5)%>,
	                }, {
	                    name: '<%=TranslateLocale.text("Inversión")%>',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 6)%>,
	                }, {
	                    name: '<%=TranslateLocale.text("Financiamiento")%>',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 7)%>,
	                }, {
	                    name: '<%=TranslateLocale.text("Caja Final ") & Left(NombrePeriodo(mes), 3) & "/" & anio%>',
	                    isIntermediateSum: true,
	                    color: Highcharts.getOptions().colors[7]
	                }],
	                dataLabels: {
	                    enabled: true,
	                    formatter: function () {
	                        return Highcharts.numberFormat(this.y, 0, ',');
	                    },
	                    style: {
	                        color: '#FFFFFF',
	                        fontWeight: 'bold'
	                    }
	                },
	                pointPadding: 0
	            }]
	        });
	    });

		</script>

        <%
            dtRep = dsReporte.Tables(52)
            Dim PC_ActivoPasivoDiferido As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1505)
            Dim PC_ProvisionesImpuestosER As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1507)
            Dim PC_ProvisionesFinancierosER As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1508)
            Dim PC_UnderOverBilling As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1509)
            Dim PC_VariacionCambiariaNoRealizada As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1510)
            Dim PC_Total As Integer = PC_ActivoPasivoDiferido + PC_ProvisionesImpuestosER + PC_ProvisionesFinancierosER + PC_UnderOverBilling + PC_VariacionCambiariaNoRealizada

            Dim CT_Intercompanias As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1512)
            Dim CT_CuentasPorPagar As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1513)
            Dim CT_CuentasPorCobrarClientesDeudores As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1514)
            Dim CT_CuentasPorCobrarDepositosGarantia As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1515)
            Dim CT_Inventarios As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1516)
            Dim CT_ImpuestosPagados As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1517)
            Dim CT_total As Integer = CT_Intercompanias + CT_CuentasPorPagar + CT_CuentasPorCobrarClientesDeudores + CT_CuentasPorCobrarDepositosGarantia + CT_Inventarios + CT_ImpuestosPagados


            Dim Inv_Capex As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1521) + GraficaFlujoEfectivo_Dato2(dtRep, 1522)
            Dim Inv_Dividendos As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1523) + GraficaFlujoEfectivo_Dato2(dtRep, 1524) + GraficaFlujoEfectivo_Dato2(dtRep, 1525)
            'Dim Inv_DividendosPorPagar As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1563)
            Dim Inv_Total As Integer = Inv_Capex + Inv_Dividendos '+ Inv_DividendosPorPagar


            Dim Fin_ContratacionDeudaBancaria As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1528)
            Dim Fin_AmortizacionPasivo As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1529)
            Dim Fin_PagoInteresesBancarios As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1530)
            Dim Fin_Intercompanias As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1531)
            Dim Fin_DocsXPagarLP As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1644)
            Dim Fin_DividendosPagados As Integer = GraficaFlujoEfectivo_Dato2(dtRep, 1563)
            Dim Fin_Total As Integer = Fin_ContratacionDeudaBancaria + Fin_AmortizacionPasivo + Fin_PagoInteresesBancarios + Fin_Intercompanias + Fin_DocsXPagarLP + Fin_DividendosPagados

            %>

    <div id="containerFlujoEfectivo" style="width: 800px; height: 500px;"></div>
        <br />
        <table border="0" style="border:none;font-size:12px;" class="noborder">
            <tr valign="top">
                <td class="noborder">
                    <table border="0" style="border:none">
                        <tr>
                            <td colspan="2" class="noborder" style="border-bottom:1px dotted !important;border-color:#000;" ><b>Partidas Contables</b></td>
                        </tr>
                        <tr>
                            <td class="noborder">Activo y Pasivo Diferido, neto</td>
                            <td class="noborder" align="right"><%= IIf(PC_ActivoPasivoDiferido > 0, PC_ActivoPasivoDiferido.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(PC_ActivoPasivoDiferido).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Provisiones. Impuestos, ER</td>
                            <td class="noborder" align="right"><%= IIf(PC_ProvisionesImpuestosER > 0, PC_ProvisionesImpuestosER.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(PC_ProvisionesImpuestosER).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Provisiones. Financieros, ER</td>
                            <td class="noborder" align="right"><%= IIf(PC_ProvisionesFinancierosER > 0, PC_ProvisionesFinancierosER.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(PC_ProvisionesFinancierosER).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Under / Over Billing</td>
                            <td class="noborder" align="right"><%= IIf(PC_UnderOverBilling > 0, PC_UnderOverBilling.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(PC_UnderOverBilling).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder" style="border-bottom:1px dotted !important;border-color:#000;">Variación Cambiaria no realizada / por Deuda</td>
                            <td class="noborder" align="right" style="border-bottom:1px dotted !important;border-color:#000;"><%= IIf(PC_VariacionCambiariaNoRealizada > 0, PC_VariacionCambiariaNoRealizada.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(PC_VariacionCambiariaNoRealizada).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Total</td>
                            <td class="noborder" align="right"><%= IIf(PC_Total > 0, PC_Total.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(PC_Total).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td colspan="2"><b>NOTA: No incluye Nutec Ibar</b></td>
                        </tr>
                    </table>
                </td>
                <td class="noborder" style="width:30px;">
                    &nbsp;
                </td>
                <td class="noborder">
                    <table border="0" style="border:none">
                        <tr>
                            <td colspan="2" style="border-bottom:1px dotted !important;border-color:#000;" class="noborder"><b>Capital de Trabajo</b></td>
                        </tr>
                        <tr>
                            <td class="noborder">INTERCOMPAÑÍAS. CxC (-) CxP, facturas operativas</td>
                            <td class="noborder" align="right"><%= IIf(CT_Intercompanias > 0, CT_Intercompanias.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(CT_Intercompanias).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Cuentas por Pagar</td>
                            <td class="noborder" align="right"><%= IIf(CT_CuentasPorPagar > 0, CT_CuentasPorPagar.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(CT_CuentasPorPagar).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Cuentas por Cobrar (Clientes y Deudores)</td>
                            <td class="noborder" align="right"><%= IIf(CT_CuentasPorCobrarClientesDeudores > 0, CT_CuentasPorCobrarClientesDeudores.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(CT_CuentasPorCobrarClientesDeudores).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Cuentas por Cobrar (Depósitos en Garantía)</td>
                            <td class="noborder" align="right"><%= IIf(CT_CuentasPorCobrarDepositosGarantia > 0, CT_CuentasPorCobrarDepositosGarantia.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(CT_CuentasPorCobrarDepositosGarantia).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Inventarios</td>
                            <td class="noborder" align="right"><%= IIf(CT_Inventarios > 0, CT_Inventarios.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(CT_Inventarios).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder" style="border-bottom:1px dotted !important;border-color:#000;">Impuestos Pagados</td>
                            <td class="noborder" align="right" style="border-bottom:1px dotted !important;border-color:#000;"><%= IIf(CT_ImpuestosPagados > 0, CT_ImpuestosPagados.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(CT_ImpuestosPagados).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Total</td>
                            <td class="noborder" align="right"><%= IIf(CT_total > 0, CT_total.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(CT_total).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                    </table>
                </td>
                <td class="noborder" style="width:30px;">
                    &nbsp;
                </td>
                <td class="noborder">
                    <table border="0" style="border:none">
                        <tr>
                            <td colspan="2" style="border-bottom:1px dotted !important;border-color:#000;" class="noborder"><b>Inversión</b></td>
                        </tr>

                        <% If Inv_Dividendos <> 0 Then %>
                        <tr>
                            <td class="noborder"><%=TranslateLocale.text("Dividendos, neto")%></td>
                            <td class="noborder" align="right"><%= IIf(Inv_Dividendos > 0, Inv_Dividendos.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Inv_Dividendos).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <% End If %>

                        <tr>
                            <td class="noborder" style="border-bottom:1px dotted !important;border-color:#000;">Capex, neto</td>
                            <td class="noborder" align="right" style="border-bottom:1px dotted !important;border-color:#000;"><%= IIf(Inv_Capex > 0, Inv_Capex.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Inv_Capex).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <%--<tr>
                            <td class="noborder">Dividendos pagados</td>
                            <td class="noborder" align="right"><%= IIf(Inv_Dividendos > 0, Inv_Dividendos.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Inv_Dividendos).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Dividendos por pagar</td>
                            <td class="noborder" align="right"><%= IIf(Inv_Dividendos > 0, Inv_Dividendos.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Inv_Dividendos).ToString("#,###,###") & ")</span>")%></td>
                        </tr>--%>
                        <tr>
                            <td class="noborder">Total</td>
                            <td class="noborder" align="right"><%= IIf(Inv_Total > 0, Inv_Total.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Inv_Total).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                    </table>
                </td>
                <td class="noborder" style="width:30px;">
                    &nbsp;
                </td>
                <td class="noborder">
                    <table border="0" style="border:none">
                        <tr>
                            <td colspan="2" style="border-bottom:1px dotted !important;border-color:#000;" class="noborder"><b>Financiamiento</b></td>
                        </tr>
                        <tr>
                            <td class="noborder">Contratación Deuda Bancaria</td>
                            <td class="noborder" align="right"><%= IIf(Fin_ContratacionDeudaBancaria > 0, Fin_ContratacionDeudaBancaria.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Fin_ContratacionDeudaBancaria).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Amortización Pasivo</td>
                            <td class="noborder" align="right"><%= IIf(Fin_AmortizacionPasivo > 0, Fin_AmortizacionPasivo.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Fin_AmortizacionPasivo).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Pago de Intereses Bancarios</td>
                            <td class="noborder" align="right"><%= IIf(Fin_PagoInteresesBancarios > 0, Fin_PagoInteresesBancarios.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Fin_PagoInteresesBancarios).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder"><%=TranslateLocale.text("Dividendos pagados")%></td>
                            <td class="noborder" align="right"><%= IIf(Fin_DividendosPagados > 0, Fin_DividendosPagados.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Fin_DividendosPagados).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">INTERCOMPAÑÍAS. CxC (-) CxP, facturas fiscales y préstamos</td>
                            <td class="noborder" align="right" style="border-bottom:1px dotted !important;border-color:#000;"><%= IIf(Fin_Intercompanias > 0, Fin_Intercompanias.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Fin_Intercompanias).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
<%--                        <tr>
                            <td class="noborder" style="border-bottom:1px dotted !important;border-color:#000;"><%=TranslateLocale.text("Documentos por Pagar LP")%></td>
                            <td class="noborder" align="right"><%= IIf(Fin_DocsXPagarLP > 0, Fin_DocsXPagarLP.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Fin_DocsXPagarLP).ToString("#,###,###") & ")</span>")%></td>
                        </tr>--%>
                        <tr>
                            <td class="noborder">Total</td>
                            <td class="noborder" align="right"><%= IIf(Fin_Total > 0, Fin_Total.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Fin_Total).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
        <br />
        <div style="width:780px">
        <%=grafica_flujo_efectivo%>
        </div>
    </div>








    <!--VERSION NUEVA-->
    <!--VERSION NUEVA-->
    <!--VERSION NUEVA-->
       <% End If%>






    





<%--    <div id="divReporte_16" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'>Flujo de Efectivo</div>
    <div style='font-size:14px;'>Del 1 de Enero al <%= (DateSerial(Year(New Date(anio, mes, 1)), Month(New Date(anio, mes, 1)) + 1, 0)).Day & " de " & NombrePeriodo(mes) & " del " & anio%></div>
<%
        dtRep = dsReporte.Tables(22)
%>

	<script type="text/javascript">
	    $(function () {
	        $('#containerFlujoEfectivo').highcharts({
	            chart: {
	                type: 'waterfall'
	            },

	            title: {
	                text: 'Flujo de Efectivo'
	            },

	            xAxis: {
	                type: 'category'
	            },

	            yAxis: {
	                title: {
	                    text: 'USD'
	                }
	            },

	            legend: {
	                enabled: false
	            },

	            tooltip: {
	                pointFormat: '<b>${point.y:,.2f}</b> USD'
	            },

	            series: [{
	                upColor: Highcharts.getOptions().colors[2], //2
	                color: Highcharts.getOptions().colors[8],
	                data: [{
	                    name: 'UAFIR',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 1)%>
	                }, {
	                    name: 'Depreciación',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 2)%>
	                }, {
	                    name: 'Gasto Financiero',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 3)%>
	                }, {
	                    name: 'Impuestos',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 4)%>
	                }, {
	                    name: 'Capital de Trabajo',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 5)%>
	                }, {
	                    name: 'Cash from Operation',
	                    isIntermediateSum: true,
	                    color: Highcharts.getOptions().colors[2]
	                }, {
	                    name: 'Dividendos',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 7)%>
	                }, {
	                    name: 'Activo Fijo',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 8)%>
	                }, {
	                    name: 'Deuda y pago. Adeudo NP',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 9)%>
	                }],
	                dataLabels: {
	                    enabled: true,
	                    formatter: function () {
	                        return Highcharts.numberFormat(this.y / 1000, 0, ',') + 'k';
	                    },
	                    style: {
	                        color: '#FFFFFF',
	                        fontWeight: 'bold'
	                    }
	                },
	                pointPadding: 0
	            }]
	        });
	    });

		</script>

    <div id="containerFlujoEfectivo" style="width: 800px; height: 400px;"></div>
        <br />
        <div style="width:780px">
        <%=grafica_flujo_efectivo%>
        </div>
    </div>--%>








<%--    <div id="divReporte_6" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'>Pedidos y Facturación - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(6);"><%=TranslateLocale.text("(Copiar)")%></a></span></div>
    <table id="tblReporte_6">
        <tr valign="top">
            <td>
    
    <table border="1" cellpadding="0" cellspacing="0">
<%

    dtRep = dsReporte.Tables(9)
%>
                <tr class="titulos2">
                    <td rowspan="2" align="center"></td>
                    <td colspan="3" align="center"><b><%=NombrePeriodo(mes)%></b></td>
                    <td align="center">&nbsp;</td>
                    <td colspan="5" align="center"><b>Acumulado</b></td>
                </tr>
                <tr class="titulos2">
                    <td align="center"><b>Plan</b></td>
                    <td align="center"><b>Real</b></td>
                    <td align="center"><b>R - P</b></td>
                    <td align="center">&nbsp;</td>
                    <td align="center"><b>Plan</b></td>
                    <td align="center"><b>Real</b></td>
                    <td align="center"><b>R - P</b></td>
                    <td align="center"><b><%=(anio - 2000) & " - " & (anio - 1 - 2000)%></b></td>
                    <td align="center"><b>Particip.</b></td>
                </tr>
<%
    For Each drDato As DataRow In dtRep.Rows
        colAlterna = False

        Dim monto_plan_acum As Decimal = 0
        Dim monto_rp As Decimal = 0
        Dim monto_rpa As Decimal = 0
        Dim descripcion As String = TranslateLocale.text(drDato("descripcion"))
        Dim permite_captura As Boolean = drDato("permite_captura")
        Dim monto_real As Decimal = drDato("monto_real")
        Dim monto_real_tot As Decimal = drDato("monto_real_tot")
        Dim monto_plan_mes As Decimal = 0 ''//PlanDistribucion(drDato("id_concepto_plan"), drDato("monto_plan"), mes, TipoValor.MesActual)
        
        'If monto_plan_mes > 0 Then
        '    monto_plan_mes = monto_plan_mes / 12
        '    monto_plan_acum = monto_plan_mes * mes
        'End If
        
        monto_plan_mes = PlanDistribucion(drDato, mes, TipoValor.MesActual)
        monto_plan_acum = PlanDistribucion(drDato, mes, TipoValor.MesAcumulado)

        If monto_plan_mes > 0 Then monto_rp = (monto_real / monto_plan_mes - 1) * 100
        If monto_plan_acum > 0 Then monto_rpa = (monto_real_tot / monto_plan_acum - 1) * 100

        Dim monto_dif_anio As Double = 0
        If drDato("monto_real_tot_ant") > 0 Then
            monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
        End If

        If imprimir_separador Then
            Response.Write("<tr><td colspan='10'><div style='height:7px'></div></td></tr>")
        End If
            
        If drDato("es_separador") = True Then
%>
                <tr class='titulos'><td colspan="10"><%=descripcion%></td></tr>
<%
Else
 %>
                <tr <%=IIf(drDato("permite_captura")=False,"class='filaTotales'","") %>>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>'><%=descripcion%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_plan_mes < 0, " negativo", "")%>'><%=Format(monto_plan_mes, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_real < 0, " negativo", "")%>'><%=Format(monto_real, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_rp < 0, " negativo", "")%>'><%=Format(monto_rp, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right">&nbsp;</td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_plan_acum < 0, " negativo", "")%>'><%=Format(monto_plan_acum, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_real_tot < 0, " negativo", "")%>'><%=Format(monto_real_tot, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_rpa < 0, " negativo", "")%>'><%=Format(monto_rpa, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_dif_anio < 0, " negativo", "")%>'><%=Format(monto_dif_anio, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(drDato("participacion") < 0, " negativo", "")%>'><%=Format(drDato("participacion"), "###,###,##0")%></td>
                </tr>
<%
End If
imprimir_separador = drDato("separador_despues")
Next
%>
            </table>    
    
            </td>
            <td>









    <table border="1" cellpadding="0" cellspacing="0">
<%

    dtRep = dsReporte.Tables(11)
%>
                <tr class="titulos2"><td colspan="3">&nbsp;</td></tr>
                <tr class="titulos2">
                    <td align="center"></td>
                    <td align="center"><b>$</b></td>
                    <td align="center"><b>Meses</b></td>
                </tr>
<%
    For Each drDato As DataRow In dtRep.Rows
        colAlterna = False

        Dim descripcion As String = TranslateLocale.text(drDato("descripcion"))
        Dim permite_captura As Boolean = drDato("permite_captura")
        Dim monto_real As Decimal = drDato("monto_real")
        Dim monto_real_tot As Decimal = drDato("monto_real_tot")
        Dim meses As Integer = 0
        If Not IsDBNull(drDato("meses")) Then
            meses = drDato("meses")
        End If

        Dim monto_dif_anio As Decimal = drDato("monto_real_tot_ant") - drDato("monto_real_tot")

        If imprimir_separador Then
            Response.Write("<tr><td colspan='10'><div style='height:7px'></div></td></tr>")
        End If
            
        If drDato("es_separador") = True Then
%>
                <tr class='titulos'><td colspan="10"><%=descripcion%></td></tr>
<%
Else
 %>
                <tr <%=IIf(drDato("permite_captura")=False,"class='filaTotales'","") %>>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>' style="height:18px;"><%=descripcion%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_real < 0, " negativo", "")%>'><%=Format(monto_real, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="center" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>'><%=Format(meses, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                </tr>
<%
End If
Next
%>
            </table>    
    








            </td>
        </tr>
        <tr>
            <td>




    <table border="1" cellpadding="0" cellspacing="0">
<%

    dtRep = dsReporte.Tables(10)
%>
                <tr class="titulos2">
                    <td rowspan="2" align="center"></td>
                    <td colspan="3" align="center"><b><%=NombrePeriodo(mes)%></b></td>
                    <td align="center">&nbsp;</td>
                    <td colspan="5" align="center"><b>Acumulado</b></td>
                </tr>
                <tr class="titulos2">
                    <td align="center"><b>Plan</b></td>
                    <td align="center"><b>Real</b></td>
                    <td align="center"><b>R - P</b></td>
                    <td align="center">&nbsp;</td>
                    <td align="center"><b>Plan</b></td>
                    <td align="center"><b>Real</b></td>
                    <td align="center"><b>R - P</b></td>
                    <td align="center"><b><%=(anio - 2000) & " - " & (anio - 1 - 2000)%></b></td>
                    <td align="center"><b>Particip.</b></td>
                </tr>
<%
    For Each drDato As DataRow In dtRep.Rows
        colAlterna = False

        Dim monto_plan_mes As Decimal = 0 'drDato("monto_plan")
        Dim monto_plan_acum As Decimal = 0
        Dim monto_rp As Decimal = 0
        Dim monto_rpa As Decimal = 0
        Dim descripcion As String = TranslateLocale.text(drDato("descripcion"))
        Dim permite_captura As Boolean = drDato("permite_captura")
        Dim monto_real As Decimal = drDato("monto_real")
        Dim monto_real_tot As Decimal = drDato("monto_real_tot")

        monto_plan_mes = PlanDistribucion(drDato, mes, TipoValor.MesActual)
        monto_plan_acum = PlanDistribucion(drDato, mes, TipoValor.MesAcumulado)


        If monto_plan_mes > 0 Then monto_rp = (monto_real / monto_plan_mes - 1) * 100
        If monto_plan_acum > 0 Then monto_rpa = (monto_real_tot / monto_plan_acum - 1) * 100

        Dim monto_dif_anio As Double = 0
        If drDato("monto_real_tot_ant") > 0 Then
            monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
        End If

        If imprimir_separador Then
            Response.Write("<tr><td colspan='10'><div style='height:7px'></div></td></tr>")
        End If
            


        If drDato("es_separador") = True Then
%>
                <tr class='titulos'><td colspan="10"><%=descripcion%></td></tr>
<%
Else
 %>
                <tr <%=IIf(drDato("permite_captura")=False,"class='filaTotales'","") %>>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>'><%=descripcion%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_plan_mes < 0, " negativo", "")%>'><%=Format(monto_plan_mes, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_real < 0, " negativo", "")%>'><%=Format(monto_real, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_rp < 0, " negativo", "")%>'><%=Format(monto_rp, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right">&nbsp;</td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_plan_acum < 0, " negativo", "")%>'><%=Format(monto_plan_acum, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_real_tot < 0, " negativo", "")%>'><%=Format(monto_real_tot, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_rpa < 0, " negativo", "")%>'><%=Format(monto_rpa, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_dif_anio < 0, " negativo", "")%>'><%=Format(monto_dif_anio, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(drDato("participacion") < 0, " negativo", "")%>'><%=Format(drDato("participacion"), "###,###,##0")%></td>
                </tr>
<%
End If
imprimir_separador = drDato("separador_despues")
Next
%>
            </table>    
    




            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
    </div>--%>









<%--    <div id="divReporte_17" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'>Headcount - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(17);"><%=TranslateLocale.text("(Copiar)")%></a></span></div>
    <table id="tblReporte_17" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td rowspan="2" align="center" class="titulos2"><b>HEADCOUNT</b></td>
            <td align="center" class="titulos2">HORNOS</td>
            <td align="center" class="titulos2">FIBRAS</td>
            <td align="center" class="titulos2">NC</td>
            <td align="center" class="titulos2">TOTAL</td>
        </tr>
        <tr class="filaTotales">
            <td align='left' class='titulos2' style="width:75px;">&nbsp;&nbsp;<b>Act</b><div style='float:right'>Mes<br />Ant</div></td>
            <td align='left' class='titulos2' style="width:75px;">&nbsp;&nbsp;<b>Act</b><div style='float:right'>Mes<br />Ant</div></td>
            <td align='left' class='titulos2' style="width:75px;">&nbsp;&nbsp;<b>Act</b><div style='float:right'>Mes<br />Ant</div></td>
            <td align='left' class='titulos2' style="width:75px;">&nbsp;&nbsp;<b>Act</b><div style='float:right'>Mes<br />Ant</div></td>
        </tr>
<% 
    dtRep = dsReporte.Tables(25)
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False
        If imprimir_separador Then
            Response.Write("<tr><td colspan='5'><div style='height:7px'></div></td></tr>")
        End If
        If dr("es_separador") = True Then
            Response.Write("<tr class='titulos'><td colspan='5'>" & TranslateLocale.text(dr("descripcion")) & "</td></tr>")
        Else
            Response.Write("<tr>")
            Response.Write("<td align='left' class='subtitulos2 columnaTitulos' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
        
            Response.Write("<td align='" & IIf(dr("es_multivalor"), "center", "left") & "' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>&nbsp;&nbsp;&nbsp;" & IIf(dr("es_multivalor"), Format(dr("monto1"), "#,###,##0"), Format(dr("monto1"), "#,###,##0") & "<div style='float:right'>&nbsp;&nbsp;&nbsp;" & Format(dr("monto_ant1"), "#,###,##0") & "&nbsp;&nbsp;&nbsp;</div>") & "</td>")
            Response.Write("<td align='" & IIf(dr("es_multivalor"), "center", "left") & "' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>&nbsp;&nbsp;&nbsp;" & IIf(dr("es_multivalor"), Format(dr("monto2"), "#,###,##0"), Format(dr("monto2"), "#,###,##0") & "<div style='float:right'>&nbsp;&nbsp;&nbsp;" & Format(dr("monto_ant2"), "#,###,##0") & "&nbsp;&nbsp;&nbsp;</div>") & "</td>")
            Response.Write("<td align='" & IIf(dr("es_multivalor"), "center", "left") & "' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>&nbsp;&nbsp;&nbsp;" & IIf(dr("es_multivalor"), Format(dr("monto3"), "#,###,##0"), Format(dr("monto3"), "#,###,##0") & "<div style='float:right'>&nbsp;&nbsp;&nbsp;" & Format(dr("monto_ant3"), "#,###,##0") & "&nbsp;&nbsp;&nbsp;</div>") & "</td>")
            Response.Write("<td align='" & IIf(dr("es_multivalor"), "center", "left") & "' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>&nbsp;&nbsp;&nbsp;" & IIf(dr("es_multivalor"), Format(dr("monto4"), "#,###,##0"), Format(dr("monto4"), "#,###,##0") & "<div style='float:right'>&nbsp;&nbsp;&nbsp;" & Format(dr("monto_ant4"), "#,###,##0") & "&nbsp;&nbsp;&nbsp;</div>") & "</td>")
        
            Response.Write("</tr>")
        End If
        
        
        imprimir_separador = dr("separador_despues")
    Next
%>
<% 
    dtRep = dsReporte.Tables(26)
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False
        If imprimir_separador Then
            Response.Write("<tr><td colspan='5'><div style='height:7px'></div></td></tr>")
        End If
        If dr("es_separador") = True Then
            Response.Write("<tr class='titulos'><td colspan='5'>" & TranslateLocale.text(dr("descripcion")) & "</td></tr>")
        Else
            Response.Write("<tr>")
            Response.Write("<td align='left' class='subtitulos2 columnaTitulos' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
        
            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>&nbsp;&nbsp;&nbsp;" & IIf(dr("es_multivalor") = False, Format(dr("monto1"), "#,###,##0"), Format(dr("monto1"), "#,###,##0") & "<div style='float:right'>&nbsp;&nbsp;&nbsp;" & Format(dr("monto_ant1"), "#,###,##0") & "&nbsp;&nbsp;&nbsp;</div>") & "</td>")
            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>&nbsp;&nbsp;&nbsp;" & IIf(dr("es_multivalor") = False, Format(dr("monto2"), "#,###,##0"), Format(dr("monto2"), "#,###,##0") & "<div style='float:right'>&nbsp;&nbsp;&nbsp;" & Format(dr("monto_ant2"), "#,###,##0") & "&nbsp;&nbsp;&nbsp;</div>") & "</td>")
            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>&nbsp;&nbsp;&nbsp;" & IIf(dr("es_multivalor") = False, Format(dr("monto3"), "#,###,##0"), Format(dr("monto3"), "#,###,##0") & "<div style='float:right'>&nbsp;&nbsp;&nbsp;" & Format(dr("monto_ant3"), "#,###,##0") & "&nbsp;&nbsp;&nbsp;</div>") & "</td>")
            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>&nbsp;&nbsp;&nbsp;" & IIf(dr("es_multivalor") = False, Format(dr("monto4"), "#,###,##0"), Format(dr("monto4"), "#,###,##0") & "<div style='float:right'>&nbsp;&nbsp;&nbsp;" & Format(dr("monto_ant4"), "#,###,##0") & "&nbsp;&nbsp;&nbsp;</div>") & "</td>")
        
            Response.Write("</tr>")
        End If
        
        
        imprimir_separador = dr("separador_despues")
    Next
%>
    </table>
    </div>
    








    <div id="divReporte_18" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'>Headcount - <%=anio%></div>

<%
    dtRep = dsReporte.Tables(27)
%>
		<script type="text/javascript">
$(function () {
        $('#containerHeadcount').highcharts({
            chart: {
                type: 'line'
            },
            title: {
                text: 'Headcount '
            },
            xAxis: {
                categories: ['Cierre Ant', 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic']
            },
            yAxis: {
                title: {
                    text: 'Empleados'
                }
            },
            tooltip: {
                enabled: false,
                formatter: function() {
                    return '<b>'+ this.series.name +'</b><br/>'+
                        this.x +': '+ this.y +'';
                }
            },
            plotOptions: {
                line: {
                    dataLabels: {
                        enabled: true
                    },
                    enableMouseTracking: false
                }
            },
            series: [{
                name: 'HORNOS',
                data: [<%=GraficaHeadcount_Datos(dtRep, 1)%>]
            }, {
                name: 'FIBRAS',
                data: [<%=GraficaHeadcount_Datos(dtRep, 2)%>]
            }, {
                name: 'NC',
                data: [<%=GraficaHeadcount_Datos(dtRep, 3)%>]
            }]
        });
    });
    

		</script>
        <div id="containerHeadcount" style="width: 800px; height: 400px;"></div>
    </div>









    







    <div id="divReporte_19" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'>Costo de Nóminas - <%=anio%></div>

<%
    dtRep = dsReporte.Tables(28)
%>
		<script type="text/javascript">
$(function () {
        $('#containerCostoNominas').highcharts({
            chart: {
                type: 'line'
            },
            title: {
                text: 'Costo de Nóminas'
            },
            xAxis: {
                categories: ['Cierre Ant', 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic']
            },
            yAxis: {
                title: {
                    text: 'Costo (Miles de USD)'
                }
            },
            tooltip: {
                enabled: false,
                formatter: function() {
                    return '<b>'+ this.series.name +'</b><br/>'+
                        this.x +': '+ this.y +'';
                }
            },
            plotOptions: {
                line: {
                    dataLabels: {
                        enabled: true
                    },
                    enableMouseTracking: false
                }
            },
            series: [{
                name: 'HORNOS',
                data: [<%=GraficaCostoNominas_Datos(dtRep, 1)%>]
            }, {
                name: 'FIBRAS',
                data: [<%=GraficaCostoNominas_Datos(dtRep, 2)%>]
            }, {
                name: 'NC',
                data: [<%=GraficaCostoNominas_Datos(dtRep, 3)%>]
            }]
        });
    });
    

		</script>
        <div id="containerCostoNominas" style="width: 800px; height: 400px;"></div>
    </div>









    






    







    <div id="divReporte_20" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'>Utilidad Operativa por USD Pagado (total)</div>

<%
    dtRep = dsReporte.Tables(29)
%>
		<script type="text/javascript">
$(function () {
        $('#containerUtilidadOpPorUSD').highcharts({
            chart: {
                type: 'line'
            },
            title: {
                text: 'Utilidad Operativa por USD Pagado (total)'
            },
            subtitle: {
                text: 'PROMEDIO DE LOS ÚLTIMOS 3 MESES'
            },
            xAxis: {
                categories: [<%=GraficaUtilidadOpNominas_Datos(dtRep, 0)%>]
            },
            yAxis: {
                title: {
                    text: 'Utilidad'
                }
            },
            tooltip: {
                enabled: false,
                formatter: function() {
                    return '<b>'+ this.series.name +'</b><br/>'+
                        this.x +': '+ this.y +'';
                }
            },
            plotOptions: {
                line: {
                    dataLabels: {
                        enabled: true
                    },
                    enableMouseTracking: false
                }
            },
            series: [{
                name: 'HORNOS',
                data: [<%=GraficaUtilidadOpNominas_Datos(dtRep, 1)%>]
            }, {
                name: 'FIBRAS',
                data: [<%=GraficaUtilidadOpNominas_Datos(dtRep, 2)%>]
            }, {
                name: 'TOTAL',
                data: [<%=GraficaUtilidadOpNominas_Datos(dtRep, 3)%>]
            }]
        });
    });
    

		</script>
        <div id="containerUtilidadOpPorUSD" style="width: 800px; height: 400px;"></div>
    </div>--%>









    
<%--    <div id="divReporte_15" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'>Facturación neta / Utilidad de Operación</div>

<%
        dtRep = dsReporte.Tables(21)
%>

	<script type="text/javascript">
	    $(function () {
	        $('#containerFacturacionNeta').highcharts({
	            chart: {
	            },
	            title: {
	                text: 'Facturación neta / Utilidad de Operación'
	            },
	            xAxis: {
	                categories: [<%=GraficaFacturacionNeta_Etiquetas(dtRep)%>]
	            },
	            yAxis: {
	                title: {
	                    text: ''
	                }
	            },
	            tooltip: {
	                enabled: false
	            },
	            labels: {
	                items: [{
	                    html: 'Plan=<%=GraficaFacturacionNeta_Plan(dtRep)%>',
	                    style: {
	                        left: '690px',
	                        top: '10px',
	                        fontWeight: 'bold',
	                        color: 'black'
	                    }
	                }]
	            },
	            plotOptions: {
	                column: {
	                    stacking: 'normal'
	                }
	            },
	            series: [{
	                color: '#FC0',
	                type: 'column',
	                name: 'Plan',
	                data: [<%=GraficaFacturacionNeta_DatosPlan(dtRep)%>],
	                dataLabels: {
	                    enabled: false
	                }
	            }, {
	                color: '#FF2626',// Highcharts.getOptions().colors[11],
	                type: 'column',
	                name: 'Facturación neta',
	                data: [<%=GraficaFacturacionNeta_DatosBarras(dtRep)%>],
	                dataLabels: {
	                    enabled: true,
	                    formatter: function () {
	                        return Highcharts.numberFormat(this.y, 1, '.');
	                    },
	                    style: {
	                        fontWeight: 'bold',
	                        color: '#000',
	                        fontSize: '15px'
	                    },
	                    verticalAlign: 'top',
	                    x: 6,
	                    y: 0
	                }
	            }, {
	                color: '#FF0',
	                lineWidth: 3,
	                type: 'spline',
	                name: 'Utilidad de Operación',
	                data: [<%=GraficaFacturacionNeta_DatosLinea(dtRep)%>],
	                dataLabels: {
	                    enabled: true,
	                    formatter: function () {
	                        return Highcharts.numberFormat(this.y, 1, '.');
	                    },
	                    style: {
	                        fontWeight: 'bold', 
	                        color: '#000',
	                        fontSize: '15px'
	                    },
	                    x: 2,
	                    y: -5
	                },
	                marker: {
	                    lineWidth: 0,
	                    lineColor: '#00F',
	                    fillColor: '#00F',
	                    symbol: 'triangle'
	                }
	            }]
	        });
	    });
	</script>
    <div id="containerFacturacionNeta" style="width: 800px; height: 400px;"></div>
    </div>--%>






    <div id="divReporte_7" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Estado de Resultados HORNOS")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(7);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_7', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    <table id="tblReporte_7" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td rowspan="2" align="center" class="titulos2"><b><%=TranslateLocale.text("CONCEPTO")%></b></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos2">NBA</td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos2">NB</td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos2"><%=TranslateLocale.text("HORNOS")%></td>
        </tr>
        <tr class="filaTotales">
            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b><%=(anio-1)%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b><%=(anio-1)%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b><%=(anio-1)%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
        </tr>
<% 
    dtRep = dsReporte.Tables(4)
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False
        If imprimir_separador Then
            Response.Write("<tr><td colspan='13'><div style='height:7px'></div></td></tr>")
        End If
        
        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos2 columnaTitulos' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep4(dr, 1, 1, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep4(dr, 1, 1, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep4(dr, 1, 2, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep4(dr, 1, 2, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep4(dr, 1, 3, 1) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep4(dr, 2, 4, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep4(dr, 2, 4, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep4(dr, 2, 5, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep4(dr, 2, 5, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep4(dr, 2, 6, 1) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep4(dr, 5, 13, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep4(dr, 5, 13, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep4(dr, 5, 14, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep4(dr, 5, 14, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep4(dr, 5, 15, 1) & "</td>")

        Response.Write("</tr>")
        
        imprimir_separador = dr("separador_despues")
    Next
%>
    </table>
    </div>




<%--    <div id="divReporte_8" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'>Estado de Resultados FIBRAS - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(8);"><%=TranslateLocale.text("(Copiar)")%></a></span></div>
    <table id="tblReporte_8" border="1" cellpadding="0" cellspacing="0" width="1350px">
        <tr class="filaTotales">
            <td rowspan="2" align="center" class="titulos2"><b>CONCEPTO</b></td>
            <td>&nbsp;</td>
            <td colspan="3" align="center" class="titulos2">NF</td>
            <td>&nbsp;</td>
            <td colspan="3" align="center" class="titulos2">NE</td>
            <td>&nbsp;</td>
            <td colspan="3" align="center" class="titulos2">NFV</td>
            <td>&nbsp;</td>
            <td colspan="3" align="center" class="titulos2">NP</td>
            <td>&nbsp;</td>
            <td colspan="3" align="center" class="titulos2">NI</td>
            <td>&nbsp;</td>
            <td colspan="3" align="center" class="titulos2">FIBRAS</td>
        </tr>
        <tr class="filaTotales">
            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b><div style='float:right'>&nbsp;&nbsp;&nbsp;%</div></td>
            <td align='center' class='titulos2'><b><%=(anio-1)%></b><div style='float:right'>&nbsp;&nbsp;&nbsp;%</div></td>
            <td align='center' class='titulos2'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b><div style='float:right'>&nbsp;&nbsp;&nbsp;%</div></td>
            <td align='center' class='titulos2'><b><%=(anio-1)%></b><div style='float:right'>&nbsp;&nbsp;&nbsp;%</div></td>
            <td align='center' class='titulos2'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b><div style='float:right'>&nbsp;&nbsp;&nbsp;%</div></td>
            <td align='center' class='titulos2'><b><%=(anio-1)%></b><div style='float:right'>&nbsp;&nbsp;&nbsp;%</div></td>
            <td align='center' class='titulos2'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b><div style='float:right'>&nbsp;&nbsp;&nbsp;%</div></td>
            <td align='center' class='titulos2'><b><%=(anio-1)%></b><div style='float:right'>&nbsp;&nbsp;&nbsp;%</div></td>
            <td align='center' class='titulos2'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b><div style='float:right'>&nbsp;&nbsp;&nbsp;%</div></td>
            <td align='center' class='titulos2'><b><%=(anio-1)%></b><div style='float:right'>&nbsp;&nbsp;&nbsp;%</div></td>
            <td align='center' class='titulos2'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b><div style='float:right'>&nbsp;&nbsp;&nbsp;%</div></td>
            <td align='center' class='titulos2'><b><%=(anio-1)%></b><div style='float:right'>&nbsp;&nbsp;&nbsp;%</div></td>
            <td align='center' class='titulos2'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
        </tr>
<% 
    dtRep = dsReporte.Tables(5)
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False

        If imprimir_separador Then
            Response.Write("<tr><td colspan='21'><div style='height:7px'></div></td></tr>")
        End If
        
        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos2 columnaTitulos' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 2, 4) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 2, 5) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 2, 6) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 5, 13) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 5, 14) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 5, 15) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 1, 1) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 1, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 1, 3) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 3, 7) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 3, 8) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 3, 9) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 4, 10) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 4, 11) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 4, 12) & "</td>")
        Response.Write("<td>&nbsp;</td>")
                
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 6, 16) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 6, 17) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 6, 18) & "</td>")

        Response.Write("</tr>")

        imprimir_separador = dr("separador_despues")
    Next
%>
    </table>
    </div>--%>









    <div id="divReporte_9" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Pedidos y Facturación HORNOS")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(9);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_9', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    <table id="tblReporte_9">
        <tr valign="top">
            <td>
    
    <table border="1" cellpadding="0" cellspacing="0">
<%

    dtRep = dsReporte.Tables(12)
%>
                <tr class="titulos2">
                    <td rowspan="2" align="center"></td>
                    <td colspan="3" align="center"><b><%=NombrePeriodo(mes)%></b></td>
                    <td align="center">&nbsp;</td>
                    <td colspan="5" align="center"><b><%=TranslateLocale.text("Acumulado")%></b></td>
                </tr>
                <tr class="titulos2">
                    <td align="center"><b>Plan</b></td>
                    <td align="center"><b>Real</b></td>
                    <td align="center"><b>R - P</b></td>
                    <td align="center">&nbsp;</td>
                    <td align="center"><b>Plan</b></td>
                    <td align="center"><b>Real</b></td>
                    <td align="center"><b>R - P</b></td>
                    <td align="center"><b><%=(anio - 2000) & " - " & (anio - 1 - 2000)%></b></td>
                    <td align="center"><b>Particip.</b></td>
                </tr>
<%
    For Each drDato As DataRow In dtRep.Rows
        colAlterna = False

        Dim monto_plan_mes As Decimal = 0 'drDato("monto_plan")
        Dim monto_plan_acum As Decimal = 0
        Dim monto_rp As Decimal = 0
        Dim monto_rpa As Decimal = 0
        Dim descripcion As String = TranslateLocale.text(drDato("descripcion"))
        Dim permite_captura As Boolean = drDato("permite_captura")
        Dim monto_real As Decimal = drDato("monto_real")
        Dim monto_real_tot As Decimal = drDato("monto_real_tot")

        monto_plan_mes = PlanDistribucion(drDato, mes, TipoValor.MesActual)
        monto_plan_acum = PlanDistribucion(drDato, mes, TipoValor.MesAcumulado)


        If monto_plan_mes > 0 Then monto_rp = (monto_real / monto_plan_mes - 1) * 100
        If monto_plan_acum > 0 Then monto_rpa = (monto_real_tot / monto_plan_acum - 1) * 100

        Dim monto_dif_anio As Double = 0
        If drDato("monto_real_tot_ant") > 0 Then
            monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
        End If

        If imprimir_separador Then
            Response.Write("<tr><td colspan='10'><div style='height:7px'></div></td></tr>")
        End If

        If drDato("es_separador") = True Then
%>
                <tr class='titulos'><td colspan="10"><%=descripcion%></td></tr>
<%
Else
 %>
                <tr <%=IIf(drDato("permite_captura")=False,"class='filaTotales'","") %>>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>'><%=descripcion%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_plan_mes < 0, " negativo", "")%>'><%=Format(monto_plan_mes, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_real < 0, " negativo", "")%>'><%=Format(monto_real, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_rp < 0, " negativo", "")%>'><%=Format(monto_rp, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right">&nbsp;</td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_plan_acum < 0, " negativo", "")%>'><%=Format(monto_plan_acum, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_real_tot < 0, " negativo", "")%>'><%=Format(monto_real_tot, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_rpa < 0, " negativo", "")%>'><%=Format(monto_rpa, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_dif_anio < 0, " negativo", "")%>'><%=Format(monto_dif_anio, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(drDato("participacion") < 0, " negativo", "")%>'><%=Format(drDato("participacion"), "###,###,##0")%></td>
                </tr>
<%
End If
imprimir_separador = drDato("separador_despues")
Next
%>
            </table>    
    
            </td>
            <td>









    <table border="1" cellpadding="0" cellspacing="0">
<%

    dtRep = dsReporte.Tables(14)
%>
                <tr class="titulos2"><td colspan="3">&nbsp;</td></tr>
                <tr class="titulos2">
                    <td align="center"></td>
                    <td align="center"><b>$</b></td>
                    <td align="center"><b><%=TranslateLocale.text("Meses")%></b></td>
                </tr>
<%
    For Each drDato As DataRow In dtRep.Rows
        colAlterna = False

        Dim monto_plan_mes As Decimal = 0 'drDato("monto_plan")
        Dim monto_plan_acum As Decimal = 0
        Dim monto_rp As Decimal = 0
        Dim monto_rpa As Decimal = 0
        Dim descripcion As String = TranslateLocale.text(drDato("descripcion"))
        Dim permite_captura As Boolean = drDato("permite_captura")
        Dim monto_real As Decimal = drDato("monto_real")
        Dim monto_real_tot As Decimal = drDato("monto_real_tot")
        Dim meses As Integer = 0
        If Not IsDBNull(drDato("meses")) Then
            meses = drDato("meses")
        End If


        monto_plan_mes = PlanDistribucion(drDato, mes, TipoValor.MesActual)
        monto_plan_acum = PlanDistribucion(drDato, mes, TipoValor.MesAcumulado)


        If monto_plan_mes > 0 Then monto_rp = (monto_real / monto_plan_mes - 1) * 100
        If monto_plan_acum > 0 Then monto_rpa = (monto_real_tot / monto_plan_acum - 1) * 100

        Dim monto_dif_anio As Decimal = drDato("monto_real_tot_ant") - drDato("monto_real_tot")


        If drDato("es_separador") = True Then
%>
                <tr class='titulos'><td colspan="10"><%=descripcion%></td></tr>
<%
Else
 %>
                <tr <%=IIf(drDato("permite_captura")=False,"class='filaTotales'","") %>>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>' style="height:18px;"><%=descripcion%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_real < 0, " negativo", "")%>'><%=Format(monto_real, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="center" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>'><%=Format(meses, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                </tr>
<%
End If
Next
%>
            </table>









            </td>
        </tr>
        <tr>
            <td>




    <table border="1" cellpadding="0" cellspacing="0">
<%

    dtRep = dsReporte.Tables(13)
%>
                <tr class="titulos2">
                    <td rowspan="2" align="center"></td>
                    <td colspan="3" align="center"><b><%=NombrePeriodo(mes)%></b></td>
                    <td align="center">&nbsp;</td>
                    <td colspan="5" align="center"><b><%=TranslateLocale.text("Acumulado")%></b></td>
                </tr>
                <tr class="titulos2">
                    <td align="center"><b>Plan</b></td>
                    <td align="center"><b>Real</b></td>
                    <td align="center"><b>R - P</b></td>
                    <td align="center">&nbsp;</td>
                    <td align="center"><b>Plan</b></td>
                    <td align="center"><b>Real</b></td>
                    <td align="center"><b>R - P</b></td>
                    <td align="center"><b><%=(anio - 2000) & " - " & (anio - 1 - 2000)%></b></td>
                    <td align="center"><b>Particip.</b></td>
                </tr>
<%
    For Each drDato As DataRow In dtRep.Rows
        colAlterna = False

        Dim monto_plan_mes As Decimal = 0 'drDato("monto_plan")
        Dim monto_plan_acum As Decimal = 0
        Dim monto_rp As Decimal = 0
        Dim monto_rpa As Decimal = 0
        Dim descripcion As String = TranslateLocale.text(drDato("descripcion"))
        Dim permite_captura As Boolean = drDato("permite_captura")
        Dim monto_real As Decimal = drDato("monto_real")
        Dim monto_real_tot As Decimal = drDato("monto_real_tot")

        monto_plan_mes = PlanDistribucion(drDato, mes, TipoValor.MesActual)
        monto_plan_acum = PlanDistribucion(drDato, mes, TipoValor.MesAcumulado)


        If monto_plan_mes > 0 Then monto_rp = (monto_real / monto_plan_mes - 1) * 100
        If monto_plan_acum > 0 Then monto_rpa = (monto_real_tot / monto_plan_acum - 1) * 100

        Dim monto_dif_anio As Double = 0
        If drDato("monto_real_tot_ant") > 0 Then
            monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
        End If

        If imprimir_separador Then
            Response.Write("<tr><td colspan='10'><div style='height:7px'></div></td></tr>")
        End If

        If drDato("es_separador") = True Then
%>
                <tr class='titulos'><td colspan="10"><%=descripcion%></td></tr>
<%
Else
 %>
                <tr <%=IIf(drDato("permite_captura")=False,"class='filaTotales'","") %>>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>'><%=descripcion%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_plan_mes < 0, " negativo", "")%>'><%=Format(monto_plan_mes, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_real < 0, " negativo", "")%>'><%=Format(monto_real, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_rp < 0, " negativo", "")%>'><%=Format(monto_rp, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right">&nbsp;</td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_plan_acum < 0, " negativo", "")%>'><%=Format(monto_plan_acum, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_real_tot < 0, " negativo", "")%>'><%=Format(monto_real_tot, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_rpa < 0, " negativo", "")%>'><%=Format(monto_rpa, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_dif_anio < 0, " negativo", "")%>'><%=Format(monto_dif_anio, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(drDato("participacion") < 0, " negativo", "")%>'><%=Format(drDato("participacion"), "###,###,##0")%></td>
                </tr>
<%
End If
imprimir_separador = drDato("separador_despues")
Next
%>
            </table>    
    




            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
    </div>







<%--    <div id="divReporte_10" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'>Pedidos y Facturación FIBRAS - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(10);"><%=TranslateLocale.text("(Copiar)")%></a></span></div>
    <table id="tblReporte_10">
        <tr valign="top">
            <td>
    
    <table border="1" cellpadding="0" cellspacing="0">
<%

    dtRep = dsReporte.Tables(15)
%>
                <tr class="titulos2">
                    <td rowspan="2" align="center"></td>
                    <td colspan="3" align="center"><b><%=NombrePeriodo(mes)%></b></td>
                    <td align="center">&nbsp;</td>
                    <td colspan="5" align="center"><b>Acumulado</b></td>
                </tr>
                <tr class="titulos2">
                    <td align="center"><b>Plan</b></td>
                    <td align="center"><b>Real</b></td>
                    <td align="center"><b>R - P</b></td>
                    <td align="center">&nbsp;</td>
                    <td align="center"><b>Plan</b></td>
                    <td align="center"><b>Real</b></td>
                    <td align="center"><b>R - P</b></td>
                    <td align="center"><b><%=(anio - 2000) & " - " & (anio - 1 - 2000)%></b></td>
                    <td align="center"><b>Particip.</b></td>
                </tr>
<%
    For Each drDato As DataRow In dtRep.Rows
        colAlterna = False

        Dim monto_plan_mes As Decimal = 0 'drDato("monto_plan")
        Dim monto_plan_acum As Decimal = 0
        Dim monto_rp As Decimal = 0
        Dim monto_rpa As Decimal = 0
        Dim descripcion As String = TranslateLocale.text(drDato("descripcion"))
        Dim permite_captura As Boolean = drDato("permite_captura")
        Dim monto_real As Decimal = drDato("monto_real")
        Dim monto_real_tot As Decimal = drDato("monto_real_tot")

        monto_plan_mes = PlanDistribucion(drDato, mes, TipoValor.MesActual)
        monto_plan_acum = PlanDistribucion(drDato, mes, TipoValor.MesAcumulado)


        If monto_plan_mes > 0 Then monto_rp = (monto_real / monto_plan_mes - 1) * 100
        If monto_plan_acum > 0 Then monto_rpa = (monto_real_tot / monto_plan_acum - 1) * 100

        Dim monto_dif_anio As Double = 0
        If drDato("monto_real_tot_ant") > 0 Then
            monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
        End If

        If imprimir_separador Then
            Response.Write("<tr><td colspan='10'><div style='height:7px'></div></td></tr>")
        End If

        If drDato("es_separador") = True Then
%>
                <tr class='titulos'><td colspan="10"><%=descripcion%></td></tr>
<%
Else
 %>
                <tr <%=IIf(drDato("permite_captura")=False,"class='filaTotales'","") %>>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>'><%=descripcion%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_plan_mes < 0, " negativo", "")%>'><%=Format(monto_plan_mes, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_real < 0, " negativo", "")%>'><%=Format(monto_real, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_rp < 0, " negativo", "")%>'><%=Format(monto_rp, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right">&nbsp;</td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_plan_acum < 0, " negativo", "")%>'><%=Format(monto_plan_acum, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_real_tot < 0, " negativo", "")%>'><%=Format(monto_real_tot, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_rpa < 0, " negativo", "")%>'><%=Format(monto_rpa, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_dif_anio < 0, " negativo", "")%>'><%=Format(monto_dif_anio, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(drDato("participacion") < 0, " negativo", "")%>'><%=Format(drDato("participacion"), "###,###,##0")%></td>
                </tr>
<%
End If
imprimir_separador = drDato("separador_despues")
Next
%>
            </table>    
    
            </td>
            <td>









    <table border="1" cellpadding="0" cellspacing="0">
<%

    dtRep = dsReporte.Tables(17)
%>
                <tr class="titulos2"><td colspan="3">&nbsp;</td></tr>
                <tr class="titulos2">
                    <td align="center"></td>
                    <td align="center"><b>$</b></td>
                    <td align="center"><b>Meses</b></td>
                </tr>
<%
    For Each drDato As DataRow In dtRep.Rows
        colAlterna = False

        Dim monto_plan_mes As Decimal = 0   ''drDato("monto_plan")
        Dim monto_plan_acum As Decimal = 0
        Dim monto_rp As Decimal = 0
        Dim monto_rpa As Decimal = 0
        Dim descripcion As String = TranslateLocale.text(drDato("descripcion"))
        Dim permite_captura As Boolean = drDato("permite_captura")
        Dim monto_real As Decimal = drDato("monto_real")
        Dim monto_real_tot As Decimal = drDato("monto_real_tot")

        Dim meses As Integer = 0
        If Not IsDBNull(drDato("meses")) Then
            meses = drDato("meses")
        End If

        monto_plan_mes = PlanDistribucion(drDato, mes, TipoValor.MesActual)
        monto_plan_acum = PlanDistribucion(drDato, mes, TipoValor.MesAcumulado)


        If monto_plan_mes > 0 Then monto_rp = (monto_real / monto_plan_mes - 1) * 100
        If monto_plan_acum > 0 Then monto_rpa = (monto_real_tot / monto_plan_acum - 1) * 100

        Dim monto_dif_anio As Decimal = drDato("monto_real_tot_ant") - drDato("monto_real_tot")


        If drDato("es_separador") = True Then
%>
                <tr class='titulos'><td colspan="10"><%=descripcion%></td></tr>
<%
Else
 %>
                <tr <%=IIf(drDato("permite_captura")=False,"class='filaTotales'","") %>>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>' style="height:18px;"><%=descripcion%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_real < 0, " negativo", "")%>'><%=Format(monto_real, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="center" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>'><%=Format(meses, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                </tr>
<%
End If
Next
%>
            </table>









            </td>
        </tr>
        <tr>
            <td>




    <table border="1" cellpadding="0" cellspacing="0">
<%

    dtRep = dsReporte.Tables(16)
%>
                <tr class="titulos2">
                    <td rowspan="2" align="center"></td>
                    <td colspan="3" align="center"><b><%=NombrePeriodo(mes)%></b></td>
                    <td align="center">&nbsp;</td>
                    <td colspan="5" align="center"><b>Acumulado</b></td>
                </tr>
                <tr class="titulos2">
                    <td align="center"><b>Plan</b></td>
                    <td align="center"><b>Real</b></td>
                    <td align="center"><b>R - P</b></td>
                    <td align="center">&nbsp;</td>
                    <td align="center"><b>Plan</b></td>
                    <td align="center"><b>Real</b></td>
                    <td align="center"><b>R - P</b></td>
                    <td align="center"><b><%=(anio - 2000) & " - " & (anio - 1 - 2000)%></b></td>
                    <td align="center"><b>Particip.</b></td>
                </tr>
<%
    For Each drDato As DataRow In dtRep.Rows
        colAlterna = False

        Dim monto_plan_mes As Decimal = 0 'drDato("monto_plan")
        Dim monto_plan_acum As Decimal = 0
        Dim monto_rp As Decimal = 0
        Dim monto_rpa As Decimal = 0
        Dim descripcion As String = TranslateLocale.text(drDato("descripcion"))
        Dim permite_captura As Boolean = drDato("permite_captura")
        Dim monto_real As Decimal = drDato("monto_real")
        Dim monto_real_tot As Decimal = drDato("monto_real_tot")

        monto_plan_mes = PlanDistribucion(drDato, mes, TipoValor.MesActual)
        monto_plan_acum = PlanDistribucion(drDato, mes, TipoValor.MesAcumulado)


        If monto_plan_mes > 0 Then monto_rp = (monto_real / monto_plan_mes - 1) * 100
        If monto_plan_acum > 0 Then monto_rpa = (monto_real_tot / monto_plan_acum - 1) * 100

        'Dim monto_dif_anio As Decimal = drDato("monto_real_tot_ant") - drDato("monto_real_tot")
        Dim monto_dif_anio As Double = 0
        If drDato("monto_real_tot_ant") > 0 Then
            monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
        End If
        

        If imprimir_separador Then
            Response.Write("<tr><td colspan='10'><div style='height:7px'></div></td></tr>")
        End If

        If drDato("es_separador") = True Then
%>
                <tr class='titulos'><td colspan="10"><%=descripcion%></td></tr>
<%
Else
 %>
                <tr <%=IIf(drDato("permite_captura")=False,"class='filaTotales'","") %>>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>'><%=descripcion%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_plan_mes < 0, " negativo", "")%>'><%=Format(monto_plan_mes, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_real < 0, " negativo", "")%>'><%=Format(monto_real, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_rp < 0, " negativo", "")%>'><%=Format(monto_rp, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right">&nbsp;</td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_plan_acum < 0, " negativo", "")%>'><%=Format(monto_plan_acum, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_real_tot < 0, " negativo", "")%>'><%=Format(monto_real_tot, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_rpa < 0, " negativo", "")%>'><%=Format(monto_rpa, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_dif_anio < 0, " negativo", "")%>'><%=Format(monto_dif_anio, "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(drDato("participacion") < 0, " negativo", "")%>'><%=Format(drDato("participacion"), "###,###,##0")%></td>
                </tr>
<%
End If
imprimir_separador = drDato("separador_despues")
Next
%>
            </table>    
    




            </td>
            <td>&nbsp;</td>
        </tr>
    </table>
    </div>
--%>








    <div id="divReporte_11" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Cashflow Forecast")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(11);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_11', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    <table id="tblReporte_11" border="1" cellpadding="0" cellspacing="0">
<%
    Dim mes_act As Integer = mes + 1
    columnas = 14
    Dim mes_anterior As Integer
    mes_anterior = mes_act - 1
    If mes_anterior = 0 Then mes_anterior = 12

    dtRep = dsReporte.Tables(6)
%>
                <tr class="titulos2">
                    <td colspan="2" align="center"><b><%=NombrePeriodo(mes_anterior)%></b></td>
                    <td rowspan="2" align="center"><b><%=TranslateLocale.text("Concepto")%></b></td>
                    <td colspan="6" align="center"><b><%=TranslateLocale.text("Pronóstico")%> <%=NombrePeriodo(mes_act)%></b></td>
                </tr>
                <tr class="titulos2">
                    <td align="center"><b>Plan</b></td>
                    <td align="center"><b>Real</b></td>
<%
    For i As Integer = 1 To 5
        Response.Write("<td align='center'><b>" & TranslateLocale.text("Semana") & " " & i & "</b></td>")
    Next

    If columnas = 14 Then
%>
                    <td align="center"><b><%=TranslateLocale.text("Acumulado")%></b></td>
<%        
    End If
%>
                </tr>
<%
    For Each drDato As DataRow In dtRep.Rows
        colAlterna = False
        If drDato("es_separador") = True Then
%>
                <tr class='titulos'><td colspan="<%=columnas %>"><%=TranslateLocale.text(drDato("descripcion"))%></td></tr>
<%
        Else
 %>
                <tr <%=IIf(drDato("permite_captura")=False,"class='filaTotales'","") %>>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(colAlterna, " columnaAlterna", "") & IIf(drDato("monto_pron_mes_ant") < 0, " negativo", "")%>'><%=Format(drDato("monto_pron_mes_ant"), "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(colAlterna, " columnaAlterna", "") & IIf(drDato("monto_real_mes_ant") < 0, " negativo", "")%>'><%=Format(drDato("monto_real_mes_ant"), "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="left" class='datos<%= IIf(colAlterna, " columnaAlterna", "") & IIf(drDato("monto_real_mes_ant") < 0, " negativo", "")%>'><%=TranslateLocale.text(drDato("descripcion"))%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(colAlterna, " columnaAlterna", "") & IIf(drDato("monto1") < 0, " negativo", "")%>'><%=Format(drDato("monto1"), "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(colAlterna, " columnaAlterna", "") & IIf(drDato("monto2") < 0, " negativo", "")%>'><%=Format(drDato("monto2"), "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(colAlterna, " columnaAlterna", "") & IIf(drDato("monto3") < 0, " negativo", "")%>'><%=Format(drDato("monto3"), "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(colAlterna, " columnaAlterna", "") & IIf(drDato("monto4") < 0, " negativo", "")%>'><%=Format(drDato("monto4"), "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(colAlterna, " columnaAlterna", "") & IIf(drDato("monto5") < 0, " negativo", "")%>'><%=Format(drDato("monto5"), "###,###,##0")%></td>
                    <%     colAlterna = Not colAlterna %>
                    <td align="right" class='datos<%= IIf(colAlterna, " columnaAlterna", "") & IIf(drDato("monto_total") < 0, " negativo", "")%>'><%=Format(drDato("monto_total"), "###,###,##0")%></td>
                </tr>
<%
End If
Next
    
%>
            </table>
    </div>





    
<%
        dtRep = dsReporte.Tables(30)
    Dim dias_cartera As Integer = 0
    If dtRep.Rows.Count > 0 Then
        dias_cartera = dtRep.Rows(0)("dias_cartera")
    End If
%>

        <div id="divReporte_22" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Cap. de Trabajo: Cartera")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(22);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_22', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>    
<br />
    <table id="tblReporte_22" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td style="border: 0px solid;" width="100px"><%=TranslateLocale.text("Días Cartera")%>:</td>
            <td style="border: 0px solid;"><%=dias_cartera %></td>
            <td style="border: 0px solid;"></td>
            <td style="border: 0px solid;"></td>
            <td style="border: 0px solid;"></td>
            <td style="border: 0px solid;"></td>
            <td style="border: 0px solid;"></td>
        </tr>
        <tr valign="top">
            <td style="width: 400px; border: 0px solid;" colspan="3" align="center">
                <br />               
                <table border="1" cellpadding="0" cellspacing="0">
                    <tr>
                        <td colspan="3" class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("CARTERA TOTAL POR PAIS")%></td>                    		
                    </tr>
                    <tr>
                        <td class="titulos2"><%=TranslateLocale.text("PAÍS")%></td>
                        <td class="titulos2"><%=TranslateLocale.text("IMPORTE USD")%></td>
                        <td class="titulos2"><%=TranslateLocale.text("PORCENTAJE")%></td>                        		
                    </tr>
<%
    For Each drDato As DataRow In dtRep.Rows
%>

                    <% 
                        If drDato("permite_captura") = False Then
                       %> 
                    <tr>
                        <td colspan="3"><div style="height:7px"></div></td>
                    </tr>
                     <%     
                     End If
                     %>	                    
                    <tr>
                        <td class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=TranslateLocale.text(TranslateLocale.text(drDato("descripcion")))%></td>
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("monto") = 0, "", Convert.ToDecimal(drDato("monto")).ToString("###,###,###"))%></td>
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("porcentaje") = 0, "", drDato("porcentaje") & "%")%></td>                        		
                    </tr>

<%
Next
%>
                </table>
            </td>
            <td style="border: 0px solid;"></td>
            <td style="width: 400px; border: 0px solid;" align="center">
                <br />
                <table border="1" cellpadding="0" cellspacing="0">
                    <tr>
                        <td colspan="3" class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("CARTERA VENCIDA (No incluye filiales)")%></td>                    		
                    </tr>
                    <tr>
                        <td class="titulos2"><%=TranslateLocale.text("RANGO DE VENCIMIENTO")%></td>
                        <td class="titulos2"><%=TranslateLocale.text("IMPORTE USD")%></td>
                        <td class="titulos2"><%=TranslateLocale.text("PORCENTAJE")%></td>                        		
                    </tr>
<%
    dtRep = dsReporte.Tables(32)
    For Each drDato As DataRow In dtRep.Rows
%>

                    <% 
                        If drDato("permite_captura") = False Then
                       %> 
                    <tr>
                        <td colspan="3"><div style="height:7px"></div></td>
                    </tr>
                     <%     
                     End If
                     %>	
                    <tr>
                        <td class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=TranslateLocale.text(drDato("descripcion"))%></td>
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("monto") = 0, "", Convert.ToDecimal(drDato("monto")).ToString("###,###,###"))%></td>
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("porcentaje") = 0, "", drDato("porcentaje") & "%")%></td>                        		
                    </tr>

<%
Next
%>
                </table>
            </td>
            <td style="border: 0px solid;"></td>
            <td style="width: 400px; border: 0px solid;" align="center">
                <br />
                <table border="1" cellpadding="0" cellspacing="0">  
                    <tr>
                        <td colspan="3" class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("CARTERA VENCIDA POR PAIS")%></td>                    		
                    </tr>                                     
                    <tr>
                        <td class="titulos2"><%=TranslateLocale.text("PAÍS")%></td>
                        <td class="titulos2"><%=TranslateLocale.text("IMPORTE USD")%></td>
                        <td class="titulos2"><%=TranslateLocale.text("PORCENTAJE")%></td>                        		
                    </tr>
<%
    dtRep = dsReporte.Tables(31)
    For Each drDato As DataRow In dtRep.Rows
%>

                    <% 
                        If drDato("permite_captura") = False Then
                       %> 
                    <tr>
                        <td colspan="3"><div style="height:7px"></div></td>
                    </tr>
                     <%     
                     End If
                     %>	
                    <tr>
                        <td class="datos"  <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=TranslateLocale.text(drDato("descripcion"))%></td>
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("monto") = 0, "", Convert.ToDecimal(drDato("monto")).ToString("###,###,###"))%></td>
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("porcentaje") = 0, "", drDato("porcentaje") & "%")%></td>                        		
                    </tr>

<%
Next
%>
                </table>                
            </td>
        </tr>
            </table>
        <br /><br />

    <table border="0" cellpadding="0" cellspacing="0">

        <tr>
        	<td>
			<script type="text/javascript">
			    $(function () {

			        $(document).ready(function () {

			            // Build the chart
			            $('#containerCarteraTotalPorPais').highcharts({
			                colors: ['#C25B57', '#5D8BC1', '#ABC86D', '#8E72AA'],
			                chart: {
			                    plotBackgroundColor: null,
			                    plotBorderWidth: null,
			                    plotShadow: false,
			                    type: 'pie'
			                },
			                title: {
			                    text: '<%=TranslateLocale.text("CARTERA GLOBAL TOTAL POR PAIS")%>'
			                },
			                tooltip: {
			                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
			                },
			                plotOptions: {
			                    pie: {
			                        allowPointSelect: true,
			                        cursor: 'pointer',
			                        dataLabels: {
			                            enabled: true,
			                            format: '<b>{point.name}</b>: {point.percentage:.1f} %',
			                            style: {
			                                color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
			                            }
			                        },
			                        showInLegend: true
			                    }
			                },
			                series: [{
			                    name: "Total",
			                    colorByPoint: true,
			                    data: [
					    <%
			    dtRep = dsReporte.Tables(30)
			    Dim strData As String = ""
			    For Each drDato As DataRow In dtRep.Rows
				If drDato("id_concepto") <> "336" Then
				    strData += "{ name: '" & TranslateLocale.text(drDato("descripcion")) & "', y: " & drDato("porcentaje") & "},"
				End If		        
			    Next
			    If strData.Length > 0 Then
				strData = strData.Substring(0, strData.Length - 1)
			    End If

	%>
				    <%=strData%>
			                    ]
			                }]
			            });
			        });
			    });

			</script>
			<div id="containerCarteraTotalPorPais" style="width: 400px; height: 400px;"></div>        	
        	</td>
        	<td></td>
        	<td>
			<script type="text/javascript">
			    $(function () {

			        $(document).ready(function () {

			            // Build the chart
			            $('#containerCarteraVencida').highcharts({
			                colors: ['#C25B57', '#5D8BC1', '#ABC86D', '#8E72AA'],
			                chart: {
			                    plotBackgroundColor: null,
			                    plotBorderWidth: null,
			                    plotShadow: false,
			                    type: 'pie'
			                },
			                title: {
			                    text: '<%=TranslateLocale.text("CARTERA VENCIDA (No incluye filiales)")%>'
			                },
			                tooltip: {
			                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
			                },
			                plotOptions: {
			                    pie: {
			                        allowPointSelect: true,
			                        cursor: 'pointer',
			                        dataLabels: {
			                            enabled: true,
			                            format: '<b>{point.name}</b>: {point.percentage:.1f} %',
			                            style: {
			                                color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
			                            }
			                        },
			                        showInLegend: true
			                    }
			                },
			                series: [{
			                    name: "Total",
			                    colorByPoint: true,
			                    data: [
					    <%		    
			    strData = ""
			    dtRep = dsReporte.Tables(32)
			    For Each drDato As DataRow In dtRep.Rows
				If drDato("id_concepto") <> "346" Then
			            strData += "{ name: '" & TranslateLocale.text(drDato("descripcion")) & "', y: " & drDato("porcentaje") & "},"
				End If
			    Next
			    If strData.Length > 0 Then
				strData = strData.Substring(0, strData.Length - 1)
			    End If

	%>
				    <%=strData%>
			                    ]
			                }]
			            });
			        });
			    });

			</script>
			<div id="containerCarteraVencida" style="width: 400px; height: 400px;"></div>        	
        	</td>
        	<td></td>
        	<td>
			<script type="text/javascript">
			    $(function () {

			        $(document).ready(function () {

			            // Build the chart
			            $('#containerCarteraVencidaPorPais').highcharts({
			                colors: ['#C25B57', '#5D8BC1', '#ABC86D', '#8E72AA'],
			                chart: {
			                    plotBackgroundColor: null,
			                    plotBorderWidth: null,
			                    plotShadow: false,
			                    type: 'pie'
			                },
			                title: {
			                    text: '<%=TranslateLocale.text("CARTERA VENCIDA POR PAIS")%>'
			                },
			                tooltip: {
			                    pointFormat: '{series.name}: <b>{point.percentage:.1f}%</b>'
			                },
			                plotOptions: {
			                    pie: {
			                        allowPointSelect: true,
			                        cursor: 'pointer',
			                        dataLabels: {
			                            enabled: true,
			                            format: '<b>{point.name}</b>: {point.percentage:.1f} %',
			                            style: {
			                                color: (Highcharts.theme && Highcharts.theme.contrastTextColor) || 'black'
			                            }
			                        },
			                        showInLegend: true
			                    }
			                },
			                series: [{
			                    name: "Total",
			                    colorByPoint: true,
			                    data: [
					    <%		    
			    strData = ""
			    dtRep = dsReporte.Tables(31)
			    For Each drDato As DataRow In dtRep.Rows
				If drDato("id_concepto") <> "340" Then
			            strData += "{ name: '" & TranslateLocale.text(drDato("descripcion")) & "', y: " & drDato("porcentaje") & "},"
				End If
			    Next
			    If strData.Length > 0 Then
				strData = strData.Substring(0, strData.Length - 1)
			    End If

	%>
				    <%=strData%>
			                    ]
			                }]
			            });
			        });
			    });

			</script>
			<div id="containerCarteraVencidaPorPais" style="width: 400px; height: 400px;"></div>        	
        	</td>
        </tr>
</table>        

    </div>








    <div id="divReporte_23" style="display:none;">
        <br /><br />
        <div style='font-size:20px;'><%=TranslateLocale.text("Cap. de Trabajo: Caja")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(23);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_23', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
        <table id="tblReporte_23" border="1" cellpadding="0" cellspacing="0">
            <%--<tr>
                <td class="titulos" colspan="13"><%=TranslateLocale.text("Comportamiento de Caja")%></td>
            </tr>--%>
    	    <tr>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Comportamiento de Caja")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Ene")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Feb")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Mar")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Abr")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("May")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Jun")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Jul")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Ago")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Sep")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Oct")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Nov")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Dic")%></td>
    	    </tr>
<%
    dtRep = dsReporte.Tables(33)
    For Each drDato As DataRow In dtRep.Rows
%>
                    <tr>
                        <td class="datos"><%=TranslateLocale.text(drDato("descripcion"))%></td>
                        <td align="right" class="datos"><%=IIf(drDato("mes01") = 0, "", Convert.ToDecimal(drDato("mes01")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos"><%=IIf(drDato("mes02") = 0, "", Convert.ToDecimal(drDato("mes02")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos"><%=IIf(drDato("mes03") = 0, "", Convert.ToDecimal(drDato("mes03")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos"><%=IIf(drDato("mes04") = 0, "", Convert.ToDecimal(drDato("mes04")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos"><%=IIf(drDato("mes05") = 0, "", Convert.ToDecimal(drDato("mes05")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos"><%=IIf(drDato("mes06") = 0, "", Convert.ToDecimal(drDato("mes06")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos"><%=IIf(drDato("mes07") = 0, "", Convert.ToDecimal(drDato("mes07")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos"><%=IIf(drDato("mes08") = 0, "", Convert.ToDecimal(drDato("mes08")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos"><%=IIf(drDato("mes09") = 0, "", Convert.ToDecimal(drDato("mes09")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos"><%=IIf(drDato("mes10") = 0, "", Convert.ToDecimal(drDato("mes10")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos"><%=IIf(drDato("mes11") = 0, "", Convert.ToDecimal(drDato("mes11")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos"><%=IIf(drDato("mes12") = 0, "", Convert.ToDecimal(drDato("mes12")).ToString("###,###,##0"))%></td>                        
                    </tr>

<%
Next
%>
        </table>
        <br /><br />
		<script type="text/javascript">
		    $(function () {
		        $('#containerCaja').highcharts({
		            //colors: ['#5387C5'],
		            chart: {
		                type: 'column'
		            },
		            title: {
		                text: '<%=TranslateLocale.text("Comportamiento de Caja")%>'
		            },
		            xAxis: {
		                categories: [
                            '<%=TranslateLocale.text("Ene")%>',
                            '<%=TranslateLocale.text("Feb")%>',
                            '<%=TranslateLocale.text("Mar")%>',
                            '<%=TranslateLocale.text("Abr")%>',
                            '<%=TranslateLocale.text("May")%>',
                            '<%=TranslateLocale.text("Jun")%>',
                            '<%=TranslateLocale.text("Jul")%>',
                            '<%=TranslateLocale.text("Ago")%>',
                            '<%=TranslateLocale.text("Sep")%>',
                            '<%=TranslateLocale.text("Oct")%>',
                            '<%=TranslateLocale.text("Nov")%>',
                            '<%=TranslateLocale.text("Dic")%>'
		                ],
		                crosshair: true
		            },
		            yAxis: {
		                min: 0,
		                title: {
		                    text: '<%=TranslateLocale.text("Valores")%>'
		                }
		            },
		            //tooltip: {
		            //    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
		            //    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
		            //        '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
		            //    footerFormat: '</table>',
		            //    shared: true,
		            //    useHTML: true
		            //},
		            plotOptions: {
		                column: {
		                    pointPadding: 0.2,
		                    borderWidth: 0
		                }
		            },
		            series: [{
		                name: '<%=TranslateLocale.text("Caja")%>',
		                data: [
		                <%		    
		    strData = ""
		    dtRep = dsReporte.Tables(34)
		    For Each drDato As DataRow In dtRep.Rows
		        strData += drDato("monto") & ","
		    Next
		    If strData.Length > 0 Then
		        strData = strData.Substring(0, strData.Length - 1)
		    End If
		    
%>
                            <%=strData%>
		                ],
		                dataLabels: {
		                    enabled: true,
		                    formatter: function () {
		                        return Highcharts.numberFormat(this.y, 0, ',');
		                    }
		                },
		                pointPadding: 0
		            }]
		        });
		    });

		</script>
		<div id="containerCaja" style="width: 1100px; height: 400px;"></div>        
    </div>





    <div id="divReporte_24" style="display:none;">
        <br /><br />
        <div style='font-size:20px;'><%=TranslateLocale.text("Cap. de Trabajo: Inventario")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(24);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_24', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
        <table id="tblReporte_24" border="1" cellpadding="0" cellspacing="0">
    	    <tr>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Saldo de (miles de USD)")%>:</td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Ene")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Feb")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Mar")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Abr")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("May")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Jun")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Jul")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Ago")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Sep")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Oct")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Nov")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Dic")%></td>
    	    </tr>
<%
    dtRep = dsReporte.Tables(35)
    For Each drDato As DataRow In dtRep.Rows
%>
                    <% 
                        If drDato("permite_captura") = False Then
                       %> 
                    <tr>
                        <td colspan="13"><div style="height:7px"></div></td>
                    </tr>
                     <%     
                     End If
                     %>	
                    <tr>
                        <td class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=TranslateLocale.text(drDato("descripcion"))%></td>
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes01") = 0, "", Convert.ToDecimal(drDato("mes01")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes02") = 0, "", Convert.ToDecimal(drDato("mes02")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes03") = 0, "", Convert.ToDecimal(drDato("mes03")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes04") = 0, "", Convert.ToDecimal(drDato("mes04")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes05") = 0, "", Convert.ToDecimal(drDato("mes05")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes06") = 0, "", Convert.ToDecimal(drDato("mes06")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes07") = 0, "", Convert.ToDecimal(drDato("mes07")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes08") = 0, "", Convert.ToDecimal(drDato("mes08")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes09") = 0, "", Convert.ToDecimal(drDato("mes09")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes10") = 0, "", Convert.ToDecimal(drDato("mes10")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes11") = 0, "", Convert.ToDecimal(drDato("mes11")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes12") = 0, "", Convert.ToDecimal(drDato("mes12")).ToString("###,###,##0"))%></td>                        
                    </tr>

<%
Next
%>
        </table>

        <br /><br />
		<script type="text/javascript">
		    $(function () {
		        $('#containerInventario').highcharts({
		            //colors: ['#5387C5'],
		            chart: {
		                type: 'column'
		            },
		            title: {
		                text: '<%=TranslateLocale.text("Inventarios")%>'
		            },
		            xAxis: {
		                categories: [
                            '<%=TranslateLocale.text("Ene")%>',
                            '<%=TranslateLocale.text("Feb")%>',
                            '<%=TranslateLocale.text("Mar")%>',
                            '<%=TranslateLocale.text("Abr")%>',
                            '<%=TranslateLocale.text("May")%>',
                            '<%=TranslateLocale.text("Jun")%>',
                            '<%=TranslateLocale.text("Jul")%>',
                            '<%=TranslateLocale.text("Ago")%>',
                            '<%=TranslateLocale.text("Sep")%>',
                            '<%=TranslateLocale.text("Oct")%>',
                            '<%=TranslateLocale.text("Nov")%>',
                            '<%=TranslateLocale.text("Dic")%>'
		                ],
		                crosshair: true
		            },
		            yAxis: { // Primary yAxis
		                min: 0,
		                title: {
		                    text: '<%=TranslateLocale.text("Valores")%>'
		                }
		            },
		            //tooltip: {
		            //    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
		            //    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
		            //        '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
		            //    footerFormat: '</table>',
		            //    shared: true,
		            //    useHTML: true
		            //},
		            plotOptions: {
		                column: {
		                    pointPadding: 0.2,
		                    borderWidth: 0
		                }
		            },
		            series: [
		                <%		  
		    
		    Dim strDataMateriaPrima As String = ""
		    Dim strDataProdEnProceso As String = ""
		    Dim strDataRefacciones As String = ""
		    Dim strDataProdTerminado As String = ""
		    Dim strDataDiasInv As String = ""
		    
		    dtRep = dsReporte.Tables(36)
		    For Each drDato As DataRow In dtRep.Rows
		        strDataMateriaPrima += drDato("mat_prima") & ","
		        strDataProdEnProceso += drDato("prod_en_proceso") & ","
		        strDataRefacciones += drDato("refacciones") & ","
		        strDataProdTerminado += drDato("prod_terminado") & ","
		        strDataDiasInv += drDato("dias_inv") & ","
		    Next
		    If strDataMateriaPrima.Length > 0 Then
		        strDataMateriaPrima = strDataMateriaPrima.Substring(0, strDataMateriaPrima.Length - 1)
		    End If
		    If strDataProdEnProceso.Length > 0 Then
		        strDataProdEnProceso = strDataProdEnProceso.Substring(0, strDataProdEnProceso.Length - 1)
		    End If
		    If strDataRefacciones.Length > 0 Then
		        strDataRefacciones = strDataRefacciones.Substring(0, strDataRefacciones.Length - 1)
		    End If
		    If strDataProdTerminado.Length > 0 Then
		        strDataProdTerminado = strDataProdTerminado.Substring(0, strDataProdTerminado.Length - 1)
		    End If
		    If strDataDiasInv.Length > 0 Then
		        strDataDiasInv = strDataDiasInv.Substring(0, strDataDiasInv.Length - 1)
		    End If
		    
%>
                            {
                                name: '<%=TranslateLocale.text("Materia Prima")%>',
                                data: [<%=strDataMateriaPrima%>],
                                color: '#FF0000'
                            },
                            {
                                name: '<%=TranslateLocale.text("Producto en Proceso")%>',
                                data: [<%=strDataProdEnProceso%>],
                                color: '#92D050'
                            },
                            {
                                name: '<%=TranslateLocale.text("Refacciones")%>',
                                data: [<%=strDataRefacciones%>],
                                color: '#7F7F7F'
                            },
                            {
                                name: '<%=TranslateLocale.text("Producto Terminado")%>',
                                data: [<%=strDataProdTerminado%>],
                                color: '#000099'
                            },
                            {
                                color: '#46AAC5',
                                lineWidth: 3,
                                type: 'spline',
                                name: '<%=TranslateLocale.text("Días Inventario")%>',
                                data: [<%=strDataDiasInv%>],
                                dataLabels: {
                                    enabled: true,
                                    formatter: function () {
                                        return Highcharts.numberFormat(this.y, 0, '.');
                                    },
                                    style: {
                                        fontWeight: 'bold',
                                        color: '#3593AA',
                                        fontSize: '15px'
                                    },
                                    x: 2,
                                    y: -5
                                },
                                marker: {
                                    lineWidth: 0,
                                    lineColor: '#3593AA',
                                    fillColor: '#3593AA',
                                    symbol: 'triangle'
                                }
                            }
		            ]
		        });
		    });

		</script>
		<div id="containerInventario" style="width: 1100px; height: 400px;"></div>
    </div>




    <div id="divReporte_25" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Cap. de Trabajo: Proveedores")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(25);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_25', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    <table id="tblReporte_25" border="1" cellpadding="0" cellspacing="0">
    	    <tr>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Saldo de (miles de USD)")%>:</td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Ene")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Feb")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Mar")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Abr")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("May")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Jun")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Jul")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Ago")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Sep")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Oct")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Nov")%></td>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Dic")%></td>
    	    </tr>
<%
    dtRep = dsReporte.Tables(37)
    For Each drDato As DataRow In dtRep.Rows
%>
                    <% 
                        If drDato("permite_captura") = False Then
                       %> 
                    <tr>
                        <td colspan="13"><div style="height:7px"></div></td>
                    </tr>
                     <%     
                     End If
                     %>	
                    <tr>
                        <td class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=TranslateLocale.text(drDato("descripcion"))%></td>
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes01") = 0, "", Convert.ToDecimal(drDato("mes01")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes02") = 0, "", Convert.ToDecimal(drDato("mes02")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes03") = 0, "", Convert.ToDecimal(drDato("mes03")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes04") = 0, "", Convert.ToDecimal(drDato("mes04")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes05") = 0, "", Convert.ToDecimal(drDato("mes05")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes06") = 0, "", Convert.ToDecimal(drDato("mes06")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes07") = 0, "", Convert.ToDecimal(drDato("mes07")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes08") = 0, "", Convert.ToDecimal(drDato("mes08")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes09") = 0, "", Convert.ToDecimal(drDato("mes09")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes10") = 0, "", Convert.ToDecimal(drDato("mes10")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes11") = 0, "", Convert.ToDecimal(drDato("mes11")).ToString("###,###,##0"))%></td>                        
                        <td align="right" class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%=IIf(drDato("mes12") = 0, "", Convert.ToDecimal(drDato("mes12")).ToString("###,###,##0"))%></td>                        
                    </tr>

<%
Next
%>
        </table>

        <br /><br />
		<script type="text/javascript">
		    $(function () {
		        $('#containerProvedores').highcharts({
		            //colors: ['#5387C5'],
		            chart: {
		                type: 'column'
		            },
		            title: {
		                text: '<%=TranslateLocale.text("Proveedores")%>'
		            },
		            xAxis: {
		                categories: [
                            '<%=TranslateLocale.text("Ene")%>',
                            '<%=TranslateLocale.text("Feb")%>',
                            '<%=TranslateLocale.text("Mar")%>',
                            '<%=TranslateLocale.text("Abr")%>',
                            '<%=TranslateLocale.text("May")%>',
                            '<%=TranslateLocale.text("Jun")%>',
                            '<%=TranslateLocale.text("Jul")%>',
                            '<%=TranslateLocale.text("Ago")%>',
                            '<%=TranslateLocale.text("Sep")%>',
                            '<%=TranslateLocale.text("Oct")%>',
                            '<%=TranslateLocale.text("Nov")%>',
                            '<%=TranslateLocale.text("Dic")%>'
		                ],
		                crosshair: true
		            },
		            yAxis: { // Primary yAxis
		                min: 0,
		                title: {
		                    text: '<%=TranslateLocale.text("Valores")%>'
		                }
		            },
		            //tooltip: {
		            //    headerFormat: '<span style="font-size:10px">{point.key}</span><table>',
		            //    pointFormat: '<tr><td style="color:{series.color};padding:0">{series.name}: </td>' +
		            //        '<td style="padding:0"><b>{point.y:.1f} mm</b></td></tr>',
		            //    footerFormat: '</table>',
		            //    shared: true,
		            //    useHTML: true
		            //},
		            plotOptions: {
		                column: {
		                    pointPadding: 0.2,
		                    borderWidth: 0
		                }
		            },
		            series: [
		                <%		  
		    
		    Dim strDataProveedoresNacionales As String = ""
		    Dim strDataProveedoresExtranjeros As String = ""
		    Dim strDataProveedoresOperacion As String = ""
		    Dim strDataProveedoresFilialesDeudaFiscal As String = ""		    
		    Dim strDataDiasDePagoProveedores As String = ""
		    
		    dtRep = dsReporte.Tables(38)
		    For Each drDato As DataRow In dtRep.Rows
		        strDataProveedoresNacionales += drDato("prov_nac") & ","
		        strDataProveedoresExtranjeros += drDato("prov_ext") & ","
		        strDataProveedoresOperacion += drDato("prov_foper") & ","
		        strDataProveedoresFilialesDeudaFiscal += drDato("prov_fdeud") & ","		        
		        strDataDiasDePagoProveedores += drDato("dias_pago") & ","
		    Next
		    If strDataProveedoresNacionales.Length > 0 Then
		        strDataProveedoresNacionales = strDataProveedoresNacionales.Substring(0, strDataProveedoresNacionales.Length - 1)
		    End If
		    If strDataProveedoresExtranjeros.Length > 0 Then
		        strDataProveedoresExtranjeros = strDataProveedoresExtranjeros.Substring(0, strDataProveedoresExtranjeros.Length - 1)
		    End If
		    If strDataProveedoresOperacion.Length > 0 Then
		        strDataProveedoresOperacion = strDataProveedoresOperacion.Substring(0, strDataProveedoresOperacion.Length - 1)
		    End If
		    If strDataProveedoresFilialesDeudaFiscal.Length > 0 Then
		        strDataProveedoresFilialesDeudaFiscal = strDataProveedoresFilialesDeudaFiscal.Substring(0, strDataProveedoresFilialesDeudaFiscal.Length - 1)
		    End If
		    If strDataDiasDePagoProveedores.Length > 0 Then
		        strDataDiasDePagoProveedores = strDataDiasDePagoProveedores.Substring(0, strDataDiasDePagoProveedores.Length - 1)
		    End If
		    
%>
                            {
                                name: '<%=TranslateLocale.text("Proveedores Nacionales")%>',
                                data: [<%=strDataProveedoresNacionales%>],
                                color: '#FF0000'
                            },
                            {
                                name: '<%=TranslateLocale.text("Proveedores Filiales Operación")%>',
                                data: [<%=strDataProveedoresExtranjeros%>],
                                color: '#92D050'
                            },
                            {
                                name: '<%=TranslateLocale.text("Proveedores Filiales Operación")%>',
                                data: [<%=strDataProveedoresOperacion%>],
                                color: '#7F7F7F'
                            },
                            {
                                name: '<%=TranslateLocale.text("Proveedores Filiales Deuda y Fiscal")%>',
                                data: [<%=strDataProveedoresFilialesDeudaFiscal%>],
                                color: '#000099'
                            },
                            {
                                color: '#46AAC5',
                                lineWidth: 3,
                                type: 'spline',
                                name: '<%=TranslateLocale.text("Días de Pago Proveedores")%>',
                                data: [<%=strDataDiasDePagoProveedores%>],
                                dataLabels: {
                                    enabled: true,
                                    formatter: function () {
                                        return Highcharts.numberFormat(this.y, 0, '.');
                                    },
                                    style: {
                                        fontWeight: 'bold',
                                        color: '#3593AA',
                                        fontSize: '15px'
                                    },
                                    x: 2,
                                    y: -5
                                },
                                marker: {
                                    lineWidth: 0,
                                    lineColor: '#3593AA',
                                    fillColor: '#3593AA',
                                    symbol: 'triangle'
                                }
                            }
		            ]
		        });
		    });

		</script>
		<div id="containerProvedores" style="width: 1100px; height: 400px;"></div>
    </div>


<style type="text/css">
    .datos {
        font-size:12px;
    }

</style>




























            <br /><br /><br />
            <div id="divFotos" style="display:none">

            </div>

        </div>
    </form>
</body>
<script type="text/javascript">
    //window.print();
</script>
</html>

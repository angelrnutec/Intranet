<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepFinancierosEjecutivoImpresion.aspx.vb" Inherits="Intranet.RepFinancierosEjecutivoImpresion" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Import Namespace="System.Data" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reporte</title>

    <style type="text/css">
        body {
            font-family:Arial;
        }

        td {
            border-style:solid;
            border-color:#dedcdc;
            border-width:1px;
            padding-left:1px;
            padding-right:0px;
            padding-top:0px;
            padding-bottom:0px;
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
        .titulos4 {
            font-size:13px;
            background-color:#87CEEB;
            color:#000;
        }
        .subtitulos2 {
            font-size:12px;
        }
        .subtitulos4 {
            font-size:12px;
        }
        .datos2 {
            font-size:12px;
            background-color:#FFFFFF;
        }


        .rep4Dato {
            float:left;
            display:inline-block;
            width:41px;
            text-align:right;
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

    </style>

<%--    <script src="rasterizeHTML/canvas2image.js"></script>
    <script src="rasterizeHTML/base64.js"></script>--%>

    <script type="text/javascript">

        function SeleccionaReporte(reporte) {
            if (reporte != 99) {
                for (i = 1; i <= 40; i++) {
                    if (document.getElementById('divReporte_' + i) != null) { document.getElementById('divReporte_' + i).style.display = 'none'; }
                    if (document.getElementById('lnkReporte_' + i) != null) { document.getElementById('lnkReporte_' + i).className = ''; }
                }
                if (document.getElementById('divReporte_' + reporte) != null) {
                    document.getElementById('divReporte_' + reporte).style.display = '';
                    document.getElementById('lnkReporte_' + reporte).className = 'colorSel';
                    document.getElementById('lnkReporte_99').className = '';
                }
            }
            else {
                for (i = 1; i <= 40; i++) {
                    if (document.getElementById('divReporte_' + i) != null) { document.getElementById('divReporte_' + i).style.display = ''; }
                    if (document.getElementById('lnkReporte_' + i) != null) { document.getElementById('lnkReporte_' + i).className = ''; }
                }
                if (document.getElementById('lnkReporte_' + reporte) != null) { document.getElementById('lnkReporte_' + reporte).className = 'colorSel'; }
            }
        }

        function TomaFoto(reporte){
            ScreenShot(document.getElementById('tblReporte_' + reporte));
        }



        function ResizeAll(div){
            var scale = 2;

            var fontSize = parseInt($(".titulos2").css("font-size"));
            fontSize = (fontSize * scale) + "px";
            $(".titulos2").css({'font-size':fontSize});            

            var tableSize = parseInt($("#tblReporte_8").css("width"));
            tableSize = (tableSize * scale) + "px";
            $("#tblReporte_8").css({'width':tableSize});            
        }


        function ScreenShotHD(id){
            var scaledElement = $("#"+id).css({
                'transform': 'scale(3,3)',
                '-ms-transform': 'scale(3,3)',
                '-webkit-transform': 'scale(3,3)'
            });
            var oldWidth = scaledElement.width();
            var oldHeight = scaledElement.height();

            var newWidth = oldWidth * (3);
            var newHeight = oldHeight * (3);
            html2canvas(scaledElement, {
                onrendered: function(canvasq) {


                    var img = canvasq.toDataURL("image/jpg");
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

        function ScreenShot(id) {

            html2canvas(id, {
                onrendered: function(canvas) {

                    var img = canvas.toDataURL("image/jpg");
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

<%--    <script src="http://code.highcharts.com/highcharts.js"></script>
    <script src="http://code.highcharts.com/highcharts-more.js"></script>
    <script src="http://code.highcharts.com/modules/exporting.js"></script>
    <script src="http://code.highcharts.com/modules/offline-exporting.js"></script>--%>

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
        STYLES += 'td {border: 1pt solid #CCC;padding-left:1px;padding-right:0px;padding-top:0px;padding-bottom:0px;} ';
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
        STYLES += '.titulos4 {font-size:13px;background-color:#87CEEB;color:#000;} ';
        STYLES += '.subtitulos4 {font-size:12px;} ';
        
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

        //var tableToExcel = (function () {
        //    var uri = 'data:application/vnd.ms-excel;base64,'
        //        , template = '<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel" xmlns="http://www.w3.org/TR/REC-html40"><meta http-equiv="content-type" content="application/vnd.ms-excel;charset=UTF-8;"><head><!--[if gte mso 9]><xml><x:ExcelWorkbook><x:ExcelWorksheets><x:ExcelWorksheet><x:Name>{worksheet}</x:Name><x:WorksheetOptions><x:DisplayGridlines/></x:WorksheetOptions></x:ExcelWorksheet></x:ExcelWorksheets></x:ExcelWorkbook></xml><![endif]--></head><body><table>{table}</table></body></html>'
        //        , base64 = function (s) { return window.btoa(unescape(encodeURIComponent(s))) }
        //        , format = function (s, c) { return s.replace(/{(\w+)}/g, function (m, p) { return c[p]; }) }
        //    return function (table, name) {
        //        tblName = table;
        //        if (!table.nodeType) table = document.getElementById(table)
        //        $("#" + tblName).find(".negativo").css('color', 'red');
        //        $("#" + tblName).find(".datos").css('font-size', '12px');
        //        $("#" + tblName).find(".datos2").css('font-size', '12px');
        //        $("#" + tblName).find(".datos3").css('font-size', '12px');
        //        $("#" + tblName).find(".bordederecho").css('border-right', 'none');
        //        $("#" + tblName).find(".bordeizquierdo").css('border-left', 'none');


        //        var ctx = { worksheet: name || 'Worksheet', table: (STYLES + table.innerHTML) }

        //        var a = document.createElement('a');
        //        a.href = uri + base64_encode(format(template, ctx));
        //        a.download = 'reporte.xls';
        //        a.click();
        //    }
        //})();

        var tableToExcel = (function () {
            var uri = 'data:application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;base64,'
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

                var a = document.createElement('a');
                a.href = uri + base64_encode(format(template, ctx));
                a.download = 'reporte.xls';
                a.click();
            }
        })();


        //application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
    </script> 

</head>
<body>



    <form id="form1" runat="server">
<% 
    Dim anio = Request.QueryString("a")
    Dim mes = Request.QueryString("m")

    Dim version_2017 As Boolean = False
    If (anio >= 2017) Then
        version_2017 = True
    End If
    
    %>

    <div style='padding-left:12px;font-size:22px;'><asp:Label ID="lblTituloReporte" runat="server"></asp:Label></div>

    <table class="tblLinks" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td>
                <ul>
                    <li><a id="lnkReporte_13" class="colorSel" href="#" onclick="SeleccionaReporte(13);"><%=TranslateLocale.text("Minuta Junta Anterior")%></a></li>
                    <li><a id="lnkReporte_14" href="#" onclick="SeleccionaReporte(14);"><%=TranslateLocale.text("Resumen Ejecutivo")%></a></li>
                    <li><a id="lnkReporte_1" href="#" onclick="SeleccionaReporte(1);"><%=TranslateLocale.text("Resumen Operativo")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_2" href="#" onclick="SeleccionaReporte(2);"><%=TranslateLocale.text("Estado de Resultados")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_3" href="#" onclick="SeleccionaReporte(3);"><%=TranslateLocale.text("Estado de Resultados")%> - <%= anio & " vs " & (anio - 1)%></a></li>
                    <li><a id="lnkReporte_33" href="#" onclick="SeleccionaReporte(33);"><%=TranslateLocale.text("Estado de Resultados")%> - <%= anio & " vs " & (2019)%></a></li>
                    <li><a id="lnkReporte_31" href="#" onclick="SeleccionaReporte(31);"><%=TranslateLocale.text("Estado de Resultados - Detallado")%> - <%= anio & " vs " & (anio - 1)%></a></li>
                    <li><a id="lnkReporte_4" href="#" onclick="SeleccionaReporte(4);"><%=TranslateLocale.text("Balance General")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_30" href="#" onclick="SeleccionaReporte(30);"><%=TranslateLocale.text("Balance General Consolidado")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_12" href="#" onclick="SeleccionaReporte(12);"><%=TranslateLocale.text("Perfil de Deuda Condensado")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_5" href="#" onclick="SeleccionaReporte(5);"><%=TranslateLocale.text("Estado de Cambios Base Efectivo")%></a></li>
                    <li><a id="lnkReporte_16" href="#" onclick="SeleccionaReporte(16);"><%=TranslateLocale.text("Gráfica: Flujo de Efectivo")%></a></li>
                    <li><a id="lnkReporte_6" href="#" onclick="SeleccionaReporte(6);"><%=TranslateLocale.text("Pedidos y Facturación")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_17" href="#" onclick="SeleccionaReporte(17);"><%=TranslateLocale.text("Headcount")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_18" href="#" onclick="SeleccionaReporte(18);"><%=TranslateLocale.text("Gráfica: Headcount")%> - <%= anio%></a></li>
                    <li><a id="lnkReporte_19" href="#" onclick="SeleccionaReporte(19);"><%=TranslateLocale.text("Gráfica: Costo de Nóminas")%> - <%= anio%></a></li>
                    <li><a id="lnkReporte_32" href="#" onclick="SeleccionaReporte(32);"><%=TranslateLocale.text("Gráfica: Headcount y Costo de Nóminas")%> - <%= anio%></a></li>
                    <li><a id="lnkReporte_20" href="#" onclick="SeleccionaReporte(20);"><%=TranslateLocale.text("Gráfica: Utilidad Operativa por USD Pagado")%></a></li>
                    <li><a id="lnkReporte_15" href="#" onclick="SeleccionaReporte(15);"><%=TranslateLocale.text("Gráfica: Facturación neta / Utilidad de Operación")%></a></li>
                    <li><a id="lnkReporte_26" href="#" onclick="SeleccionaReporte(26);"><%=TranslateLocale.text("Gráfica: Facturación neta / Utilidad de Operación a partir de 2013")%></a></li>
                </ul>
            </td>   
            <td>&nbsp;&nbsp;&nbsp;</td>
            <td>
                <ul>
                    <li><a id="lnkReporte_7" href="#" onclick="SeleccionaReporte(7);"><%=TranslateLocale.text("Estado de Resultados HORNOS")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <% If version_2017 Then%>
                        <li><a id="lnkReporte_8" href="#" onclick="SeleccionaReporte(8);"><%=TranslateLocale.text("Estado de Resultados FIBRAS por Compañia")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                        <li><a id="lnkReporte_27" href="#" onclick="SeleccionaReporte(27);"><%=TranslateLocale.text("Estado de Resultados FIBRAS por Negocio")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                        <li><a id="lnkReporte_29" href="#" onclick="SeleccionaReporte(29);"><%=TranslateLocale.text("Estado de Resultados FIBRAS vs Presupuesto")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <% Else%>
                        <li><a id="lnkReporte_8" href="#" onclick="SeleccionaReporte(8);"><%=TranslateLocale.text("Estado de Resultados FIBRAS")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <% End If%>

                    <li><a id="lnkReporte_9" href="#" onclick="SeleccionaReporte(9);"><%=TranslateLocale.text("Pedidos y Facturación HORNOS")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_10" href="#" onclick="SeleccionaReporte(10);"><%=TranslateLocale.text("Pedidos y Facturación FIBRAS")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <% If version_2017 Then%>
                        <li><a id="lnkReporte_28" href="#" onclick="SeleccionaReporte(28);"><%=TranslateLocale.text("Pedidos y Facturación por Negocio")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <% End If%>

                    <li><a id="lnkReporte_11" href="#" onclick="SeleccionaReporte(11);"><%=TranslateLocale.text("Cashflow Forecast")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
                    <li><a id="lnkReporte_21" href="#" onclick="SeleccionaReporte(21);"><%=TranslateLocale.text("Anexo: Perfil de Deuda")%> - <%= NombrePeriodo(mes) & " / " & anio%></a></li>
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
    <div style='font-size:20px;'><%=TranslateLocale.text("Resumen Operativo")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(1);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<%--<a href="/Servicios/ResumenOperativoExcel.aspx?a=<%=Request.QueryString("a") & "&m=" & Request.QueryString("m")%>"><%=TranslateLocale.text("(Exportar a Excel)")%></a>--%> <a href="javascript:tableToExcel('tblReporte_1', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>

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
    Response.Write("<td align='center' class='titulos'>&nbsp;<b>Plan</b>&nbsp;</td>")
    Response.Write("<td align='center' class='titulos'><b>Plan Anual</b></td>")

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
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos3" & IIf(colAlterna, " columnaAlterna", "") & "'><b>" & FormateaValorRep1(dtRep, dr, -2, False, False) & "</b></td>")
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
            <td colspan="6" align="center" class="titulos"><%=TranslateLocale.text("HORNOS")%></td>
            <td>&nbsp;</td>
            <td colspan="6" align="center" class="titulos"><%=TranslateLocale.text("FIBRAS")%></td>
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




















        
    
    <div id="divReporte_33" style="display:none;">
            <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Estado de Resultados")%> - <%= anio & " vs " & (2019)%><span class="linkCopias"><a href="#" onclick="TomaFoto(33);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_33', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    <table id="tblReporte_33" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td rowspan="2" align="center" class="titulos"><b><%=TranslateLocale.text("CONCEPTO")%></b></td>
            <td>&nbsp;</td>
            <td colspan="6" align="center" class="titulos"><%=TranslateLocale.text("HORNOS")%></td>
            <td>&nbsp;</td>
            <td colspan="6" align="center" class="titulos"><%=TranslateLocale.text("FIBRAS")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos"><%=TranslateLocale.text("CONSOLIDADO")%></td>
        </tr>
        <tr class="filaTotales">
            <td>&nbsp;</td>
            <td align='center' class='titulos'><b><%=anio%></b></td><td align='center' class='titulos'>%</td>
            <td align='center' class='titulos'><b><%=(2019)%></b></td><td align='center' class='titulos'>%</td>
            <td align='center' class='titulos'><b>R-P($)</b></td>
            <td align='center' class='titulos'><b><%=(anio - 2000) & "-" & (19)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos'><b><%=anio%></b></td><td align='center' class='titulos'>%</td>
            <td align='center' class='titulos'><b><%=(2019)%></b></td><td align='center' class='titulos'>%</td>
            <td align='center' class='titulos'><b>R-P($)</b></td>
            <td align='center' class='titulos'><b><%=(anio - 2000) & "-" & (19)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos'><b><%=anio%></b></td><td align='center' class='titulos'>%</td>
            <td align='center' class='titulos'><b><%=(2019)%></b></td><td align='center' class='titulos'>%</td>
            <td align='center' class='titulos'><b><%=(anio - 2000) & "-" & (19)%></b></td>
        </tr>
<% 
    dtRep = dsReporte.Tables(64)
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

















    
    <div id="divReporte_31" style="display:none;">
            <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Estado de Resultados - Detallado")%> - <%= anio & " vs " & (anio - 1)%><span class="linkCopias"><a href="#" onclick="TomaFoto(31);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_31', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    <table id="tblReporte_31" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td rowspan="2" align="center" class="titulos"><b><%=TranslateLocale.text("CONCEPTO")%></b></td>
            <td>&nbsp;</td>
            <td colspan="2" align="center" class="titulos"><%=TranslateLocale.text("HORNOS")%></td>
            <td>&nbsp;</td>
            <td colspan="2" align="center" class="titulos"><%=TranslateLocale.text("FIBRAS")%></td>
            <td>&nbsp;</td>
            <td colspan="2" align="center" class="titulos"><%=TranslateLocale.text("CONSOLIDADO")%></td>
        </tr>
        <tr class="filaTotales">
            <td>&nbsp;</td>
            <td align='center' class='titulos'><b><%=anio%></b></td><td align='center' class='titulos'>%</td>
<%--            <td align='center' class='titulos'><b><%=(anio-1)%></b></td><td align='center' class='titulos'>%</td>
            <td align='center' class='titulos'><b>R-P($)</b></td>
            <td align='center' class='titulos'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>--%>
            <td>&nbsp;</td>
            <td align='center' class='titulos'><b><%=anio%></b></td><td align='center' class='titulos'>%</td>
<%--            <td align='center' class='titulos'><b><%=(anio-1)%></b></td><td align='center' class='titulos'>%</td>
            <td align='center' class='titulos'><b>R-P($)</b></td>
            <td align='center' class='titulos'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>--%>
            <td>&nbsp;</td>
            <td align='center' class='titulos'><b><%=anio%></b></td><td align='center' class='titulos'>%</td>
<%--            <td align='center' class='titulos'><b><%=(anio-1)%></b></td><td align='center' class='titulos'>%</td>
            <td align='center' class='titulos'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>--%>
        </tr>
<% 
    dtRep = dsReporte.Tables(63)
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False

        If imprimir_separador Then
            Response.Write("<tr><td colspan='15'><div style='height:7px'></div></td></tr>")
        End If

        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos columnaTitulos' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep3(dr, 1, 1, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep3(dr, 1, 1, 2) & "</td>")
        'colAlterna = Not colAlterna
        'Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep3(dr, 1, 2, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep3(dr, 1, 2, 2) & "</td>")
        'colAlterna = Not colAlterna
        'Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 1, 3, 1) & "</td>")
        'colAlterna = Not colAlterna
        'Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 1, 4, 1) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep3(dr, 2, 5, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep3(dr, 2, 5, 2) & "</td>")
        'colAlterna = Not colAlterna
        'Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep3(dr, 2, 6, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep3(dr, 2, 6, 2) & "</td>")
        'colAlterna = Not colAlterna
        'Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 2, 7, 1) & "</td>")
        'colAlterna = Not colAlterna
        'Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 2, 8, 1) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep3(dr, 3, 9, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep3(dr, 3, 9, 2) & "</td>")
        'colAlterna = Not colAlterna
        'Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep3(dr, 3, 10, 1) & "</td><td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep3(dr, 3, 10, 2) & "</td>")
        'colAlterna = Not colAlterna
        'Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 3, 11, 1) & "</td>")

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
                            <td align="center" class="titulos2" width="50px"><%= Left(NombrePeriodo(drX("periodo")), 3) & "-" & (drX("anio") - 2000)%></td><td align='center' class='titulos2'>%</td>
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
                            <td align="right" class="datos"><%=Decimal.Parse(dtRep.Rows(0)("plan1")).ToString("#,###,##0")%></td>
                            <td align="right" class="datos"><%=Decimal.Parse(dtRep.Rows(0)("var1")).ToString("#,###,##0")%></td>
                        </tr>
                        <tr>
                            <td colspan="2"><div style="height:7px;"></div></td>
                        </tr>
                        <tr>
                            <td class="titulos2"><%=TranslateLocale.text("Pronóstico")%> <%=Left(NombrePeriodo(ultimo_mes+1), 3) %></td>
                            <td class="titulos2">Var</td>
                        </tr>
                        <tr>
                            <td align="right" class="datos"><%=Decimal.Parse(dtRep.Rows(0)("plan2")).ToString("#,###,##0")%></td>
                            <td align="right" class="datos"><%=Decimal.Parse(dtRep.Rows(0)("var2")).ToString("#,###,##0")%></td>
                        </tr>
                    </table>


                </td>
            </tr>
        </table>
    </div>



















<div id="divReporte_30" style="display:none;">
<%
        Dim dtBalanceGeneralConsolidado As DataTable = dsReporte.Tables(62)
%>
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Balance General Consolidado")%> - <%= NombrePeriodo(mes) & " / " & (anio - 2000)%><span class="linkCopias"><a href="#" onclick="TomaFoto(30);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_30', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    
        <table id="tblReporte_30" border="0" cellpadding="0" cellspacing="0" style="border:none;border-style:none;">
            <tr valign="top">
                <td>


                    <table border="1" cellpadding="0" cellspacing="0">
                        <tr class="filaTotales">
                            <td align="center" class="titulos2"><b><%=TranslateLocale.text("CONCEPTO")%></b></td>
                            <td align="center" class="titulos2" style="width:60px"><b>NB</b></td>
                            <td align="center" class="titulos2" style="width:60px"><b>NE</b></td>
                            <td align="center" class="titulos2" style="width:60px"><b>NP</b></td>
                            <td align="center" class="titulos2" style="width:60px"><b>España</b></td>
                            <td align="center" class="titulos2" style="width:60px"><b>NF</b></td>
                            <td align="center" class="titulos2" style="width:60px"><b>NUSA</b></td>
                            <td align="center" class="titulos2" style="width:60px"><b>NPC</b></td>
                            <td align="center" class="titulos2" style="width:60px"><b>NS</b></td>
                            <td align="center" class="titulos2" style="width:60px"><b>Suma</b></td>
                            <td align="center" class="titulos2" style="width:60px"><b>GNU</b></td>
                            <td align="center" class="titulos2" style="width:60px"><b>Cargos</b></td>
                            <td align="center" class="titulos2" style="width:60px"><b>Créditos</b></td>
                            <td align="center" class="titulos2" style="width:60px"><b>Consolidado</b></td>
                            <td align="center" class="titulos2" style="width:40px"><b>%</b></td>
                        </tr>
                <% 
                    imprimir_separador = False
                    Dim es_negritas As String
                    For Each dr As DataRow In dtBalanceGeneralConsolidado.Rows
                        colAlterna = False
                        If imprimir_separador Then
                            Response.Write("<tr><td colspan='15'><div style='height:7px'></div></td></tr>")
                        End If
                        es_negritas = IIf(dr("es_negritas"), "negritas", "")
                        If dr("subtitulo_antes") <> "" Then
                            Response.Write("<tr><td align='center'><b><u>" & dr("subtitulo_antes") & "</u></b></td>")
                            Response.Write("<td colspan='14'><div style='height:7px'></div></td></tr>")
                        End If

                        Response.Write("<tr>")
                        Response.Write("<td align='left' class='" & es_negritas & " subtitulos2 columnaTitulos' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
                        Response.Write("<td align='center' class='" & es_negritas & " datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo' style='text-align:right;'>" & FormateaValorRepBalanceConsolidado(dr, "monto1") & "</td>")
                        Response.Write("<td align='center' class='" & es_negritas & " datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo' style='text-align:right;'>" & FormateaValorRepBalanceConsolidado(dr, "monto2") & "</td>")
                        Response.Write("<td align='center' class='" & es_negritas & " datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo' style='text-align:right;'>" & FormateaValorRepBalanceConsolidado(dr, "monto3") & "</td>")
                        Response.Write("<td align='center' class='" & es_negritas & " datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo' style='text-align:right;'>" & FormateaValorRepBalanceConsolidado(dr, "monto4") & "</td>")
                        Response.Write("<td align='center' class='" & es_negritas & " datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo' style='text-align:right;'>" & FormateaValorRepBalanceConsolidado(dr, "monto5") & "</td>")
                        Response.Write("<td align='center' class='" & es_negritas & " datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo' style='text-align:right;'>" & FormateaValorRepBalanceConsolidado(dr, "monto12") & "</td>")
                        Response.Write("<td align='center' class='" & es_negritas & " datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo' style='text-align:right;'>" & FormateaValorRepBalanceConsolidado(dr, "monto13") & "</td>")
                        Response.Write("<td align='center' class='" & es_negritas & " datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo' style='text-align:right;'>" & FormateaValorRepBalanceConsolidado(dr, "monto6") & "</td>")
                        Response.Write("<td align='center' class='" & es_negritas & " datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo' style='text-align:right;'>" & FormateaValorRepBalanceConsolidado(dr, "monto7") & "</td>")
                        Response.Write("<td align='center' class='" & es_negritas & " datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo' style='text-align:right;'>" & FormateaValorRepBalanceConsolidado(dr, "monto8") & "</td>")
                        Response.Write("<td align='center' class='" & es_negritas & " datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo' style='text-align:right;'>" & FormateaValorRepBalanceConsolidado(dr, "monto9") & "</td>")
                        Response.Write("<td align='center' class='" & es_negritas & " datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo' style='text-align:right;'>" & FormateaValorRepBalanceConsolidado(dr, "monto10") & "</td>")
                        Response.Write("<td align='center' class='" & es_negritas & " datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo' style='text-align:right;'>" & FormateaValorRepBalanceConsolidado(dr, "monto11") & "</td>")
                        Response.Write("<td align='center' class='" & es_negritas & " datos" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo' style='text-align:right;'><i>" & FormateaValorRepBalanceConsolidado(dr, "monto_tot11") & " %</i></td>")
                        Response.Write("</tr>")

                        imprimir_separador = dr("separador_despues")
                    Next
                %>



                    </table>


                </td>
            </tr>
        </table>
    </div>















        <div id="divReporte_12" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Perfil de Deuda Condensado")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(12);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_12', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    <table id="tblReporte_12" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td>
    
    <table border="1" cellpadding="0" cellspacing="0" style="width:800px">
<%

    dtRep = dsReporte.Tables(30)

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
        
        deuda = drDato("monto_sub_total")
           
        
        'If banco = "-- Intereses" Then
        'deuda = 0
        'End If
                
        'If tipo.IndexOf("TOTAL") >= 0 Then
        ' deuda = deuda_total
        ' deuda_total = 0
        ' Else
        ' deuda_total += deuda
        ' End If
        
        Dim permite_captura As Boolean = False
        colAlterna = Not colAlterna
 %>
                <tr <%=IIf(permite_captura=False,"class='filaTotales'","") %>>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>'><span style="font-size:14px;"><b><%=TranslateLocale.text(cia)%></b></span></td>
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
            <tr><td colspan="14" style="background-color:#dedcdc;"><div style="background-color:#dedcdc;height:5px"></div></td></tr>
        <%
            End If

            %>
<%
Next
%>









<%

    dtRep = dsReporte.Tables(31)
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
               <%-- <tr class="titulos2">
                    <td align="center"><b>Totales</b></td>
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
                </tr>--%>
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

        If drDato("id_concepto") = 9999 Then
            deuda_interes = 0
        End If

        If drDato("id_concepto") = 9997 Or drDato("id_concepto") = 9995 Or drDato("id_concepto") = 9994 Then
            monto_1 = monto_1 / 10
        End If

        Dim permite_captura As Boolean = drDato("extras")
        colAlterna = Not colAlterna

        If permite_captura = True And separador_usado = False Then
            separador_usado = True
                %>
            <tr><td colspan="14" style="background-color:#dedcdc;"><div style="background-color:#dedcdc;height:5px;"></div></td></tr>
        <%
            End If
        Dim enter As String = IIf(IsDBNull(drDato("referencia2")), "", drDato("referencia2"))
        'If IsDBNull(enter) Then
        '    enter = ""
        'End If
        If enter = "#ENTER#" Then
                %>
            <tr><td colspan="14" style="background-color:#dedcdc;"><div style="background-color:#dedcdc;height:5px"></div></td></tr>
        <%
                End If%>

                <tr <%=IIf(permite_captura=False,"class='filaTotales'","") %>>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>' style="width:205px;"><%=tipo%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(deuda < 0, " negativo", "")%>'><%=IIf(deuda <> 0, Format(deuda, "###,###,##0"), "")%></td>
                    <td align="right" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "") & IIf(monto_1 < 0, " negativo", "")%>'>
                        <%
                            If drDato("id_concepto") <> 9997 And drDato("id_concepto") <> 9995 And drDato("id_concepto") <> 9994 Then
                                If monto_1 <> 0 Then Response.Write(Format(monto_1, "###,###,##0"))
                            Else
                                If monto_1 <> 0 Then Response.Write(Format(monto_1, "###,###,##0.0"))
                            End If
                            %>
                    </td>
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

    



            </td>
        </tr>
    </table>






    <br /><br />
<%
        dtRep = dsReporte.Tables(32)
%>

	<script type="text/javascript">
	    $(function () {
	        $('#containerGraficaPerfilDeDeuda').highcharts({
	            chart: {
	            },
	            title: {
	                text: '<%=TranslateLocale.text("Vencimientos de Deuda por año por moneda")%>'
	            },
	            xAxis: {
	                categories: [<%=GraficaPerfilDeDeuda_Etiquetas(dtRep)%>]
	            },
	            yAxis: {
	                title: {
	                    text: ''
	                }
	            },
	            tooltip: {
	                enabled: false
	            },
	            plotOptions: {
	                column: {
	                    stacking: 'normal'
	                }
	            },
	            series: [{
	                color: '#FFFF07',
	                type: 'column',
	                name: 'EUR',
	                data: [<%=GraficaPerfilDeDeuda_DatosEUR(dtRep)%>],
	                dataLabels: {
	                    enabled: true,
	                    formatter: function () {
	                        return Highcharts.numberFormat(this.y, 0, '.');
	                    },
	                    style: {
	                        fontWeight: 'bold',
	                        color: '#000',
	                        fontSize: '11px'
	                    },
	                    verticalAlign: 'top',
	                    x: 1,
	                    y: 0
	                }
	            }, {
	                color: '#008001',// Highcharts.getOptions().colors[11],
	                type: 'column',
	                name: 'MXP',
	                data: [<%=GraficaPerfilDeDeuda_DatosMXP(dtRep)%>],
	                dataLabels: {
	                    enabled: true,
	                    formatter: function () {
	                        return Highcharts.numberFormat(this.y, 0, '.');
	                    },
	                    style: {
	                        fontWeight: 'bold',
	                        color: '#000',
	                        fontSize: '11px'
	                    },
	                    verticalAlign: 'top',
	                    x: 1,
	                    y: 0
	                }
	            }, {
	                color: '#040099',// Highcharts.getOptions().colors[11],
	                type: 'column',
	                name: 'USD',
	                data: [<%=GraficaPerfilDeDeuda_DatosUSD(dtRep)%>],
	                dataLabels: {
	                    enabled: true,
	                    formatter: function () {
	                        return Highcharts.numberFormat(this.y, 0, '.');
	                    },
	                    style: {
	                        fontWeight: 'bold',
	                        color: '#FFF',
	                        fontSize: '11px'
	                    },
	                    verticalAlign: 'top',
	                    x: 1,
	                    y: 0
	                }
	            }, {
	                color: '#FF0003',
	                lineWidth: 3,
	                type: 'spline',
	                name: '<%=TranslateLocale.text("Corto Plazo renovable")%>',
	                data: [<%=GraficaPerfilDeDeuda_DatosLinea(dtRep)%>],
	                dataLabels: {
	                    enabled: true,
	                    formatter: function () {
	                        return Highcharts.numberFormat(this.y, 0, '.');
	                    },
	                    style: {
	                        fontWeight: 'bold', 
	                        color: '#000',
	                        fontSize: '11px'
	                    },
	                    x: 2,
	                    y: -5
	                },
	                marker: {
	                    lineWidth: 0,
	                    lineColor: '#FF0003',
	                    fillColor: '#FF0003',
	                    symbol: 'square'
	                }
	            }]
	        });
	    });
	</script>
    <div id="containerGraficaPerfilDeDeuda" style="width: 600px; height: 400px;"></div>
    </div>





    <% If New Date(anio, mes, 1) < New Date(2018, 10, 1) Then%>
    <!--VERSION ANTERIOR-->
    <!--VERSION ANTERIOR-->
    <!--VERSION ANTERIOR-->
    <!--VERSION ANTERIOR-->


    


    <div id="divReporte_5" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Estado de Cambios Base Efectivo")%><span class="linkCopias"><a href="#" onclick="TomaFoto(5);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_5', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    <div style='font-size:14px;'><%=TranslateLocale.text("Del 1 de Enero al") %> <%= (DateSerial(Year(New Date(anio, mes, 1)), Month(New Date(anio, mes, 1)) + 1, 0)).Day & TranslateLocale.text(" de ") & NombrePeriodo(mes) & TranslateLocale.text(" del ") & anio%></div>             
    <table id="tblReporte_5" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td align="center" class="titulos2"><b><%=TranslateLocale.text("CONCEPTO")%></b></td>
            <td>&nbsp;</td>
            <td align="center" class="titulos2">&nbsp;</td>
            <td align="center" class="titulos2">GNU</td>
            <td align="center" class="titulos2">NB</td>
            <td align="center" class="titulos2">NF</td>
            <td align="center" class="titulos2">NUSA</td>
            <td align="center" class="titulos2">NE</td>
            <td align="center" class="titulos2">NP</td>
        </tr>
<% 
    dtRep = dsReporte.Tables(8)
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False

        If imprimir_separador Then
            Response.Write("<tr><td colspan='8'><div style='height:7px'></div></td></tr>")
        End If

        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos2 columnaTitulos' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
        Response.Write("<td>&nbsp;</td>")

        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 0) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 10) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 6) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 3) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 12) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 5) & "</td>")
        colAlterna = Not colAlterna

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
        dtRep = dsReporte.Tables(22)
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
	                    name: '<%=TranslateLocale.text("Ingresos")%>',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 2)%>,
	                }, {
	                    name: '<%=TranslateLocale.text("Costos")%>',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 3)%>,
	                }, {
	                    name: '<%=TranslateLocale.text("Gastos Operación")%>',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 4)%>,
	                }, {
	                    name: '<%=TranslateLocale.text("Depreciación")%>',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 5)%>,
	                }, {
	                    name: '<%=TranslateLocale.text("Gastos NS y DG")%>',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 6)%>,
	                }, {
	                    name: '<%=TranslateLocale.text("Otros")%>',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 7)%>,
	                }, {
	                    name: '<%=TranslateLocale.text("CNT")%>',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 8)%>,
	                }, {
	                    name: '<%=TranslateLocale.text("Capex")%>',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 9)%>,
	                }, {
	                    name: '<%=TranslateLocale.text("Pago de deuda")%>',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 10)%>,
	                }, {
	                    name: '<%=TranslateLocale.text("Dividendo NI")%>',
	                    y: <%=GraficaFlujoEfectivo_Dato(dtRep, 11)%>,
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
            Dim Otros_GstsProdsFinancieros As Integer = GraficaFlujoEfectivo_Dato(dtRep, 21)
            Dim Otros_FluctuacionCambiaria As Integer = GraficaFlujoEfectivo_Dato(dtRep, 22)
            Dim Otros_Impuestos As Integer = GraficaFlujoEfectivo_Dato(dtRep, 23)
            Dim Otros_OtrosGsts As Integer = GraficaFlujoEfectivo_Dato(dtRep, 24)
            Dim Otros_Total As Integer = Otros_GstsProdsFinancieros + Otros_FluctuacionCambiaria + Otros_Impuestos + Otros_OtrosGsts
            
            Dim CNT_Clientes As Integer = GraficaFlujoEfectivo_Dato(dtRep, 25)
            Dim CNT_Inventarios As Integer = GraficaFlujoEfectivo_Dato(dtRep, 26)
            Dim CNT_Impuestos As Integer = GraficaFlujoEfectivo_Dato(dtRep, 27)
            Dim CNT_ActivoDiferido As Integer = GraficaFlujoEfectivo_Dato(dtRep, 28)
            Dim CNT_Proveedores As Integer = GraficaFlujoEfectivo_Dato(dtRep, 29)
            Dim CNT_Total As Integer = CNT_Clientes + CNT_Inventarios + CNT_Impuestos + CNT_ActivoDiferido + CNT_Proveedores
            
            %>

    <div id="containerFlujoEfectivo" style="width: 800px; height: 500px;"></div>
        <br />
        <table border="0" style="border:none;font-size:12px;" class="noborder">
            <tr valign="top">
                <td class="noborder">
                    <table border="0" style="border:none">
                        <tr>
                            <td colspan="2" class="noborder" style="border-bottom:1px dotted !important;border-color:#000;" ><b>Otros</b></td>
                        </tr>
                        <tr>
                            <td class="noborder">Gsts / prods financieros</td>
                            <td class="noborder" align="right"><%= IIf(Otros_GstsProdsFinancieros > 0, Otros_GstsProdsFinancieros.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Otros_GstsProdsFinancieros).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Fluctuación Cambiaria</td>
                            <td class="noborder" align="right"><%= IIf(Otros_FluctuacionCambiaria > 0, Otros_FluctuacionCambiaria.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Otros_FluctuacionCambiaria).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Impuestos</td>
                            <td class="noborder" align="right"><%= IIf(Otros_Impuestos > 0, Otros_Impuestos.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Otros_Impuestos).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder" style="border-bottom:1px dotted !important;border-color:#000;">Otros gsts / Ingresos</td>
                            <td class="noborder" align="right" style="border-bottom:1px dotted !important;border-color:#000;"><%= IIf(Otros_OtrosGsts > 0, Otros_OtrosGsts.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Otros_OtrosGsts).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder" align="right">Total</td>
                            <td class="noborder" align="right"><%= IIf(Otros_Total > 0, Otros_Total.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Otros_Total).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                    </table>
                </td>
                <td class="noborder" style="width:30px;">
                    &nbsp;
                </td>
                <td class="noborder">
                    <table border="0" style="border:none">
                        <tr>
                            <td colspan="2" style="border-bottom:1px dotted !important;border-color:#000;" class="noborder"><b>CNT</b></td>
                        </tr>
                        <tr>
                            <td colspan="2" class="noborder"><b>(Aumento) Disminución Activo</b></td>
                        </tr>
                        <tr>
                            <td class="noborder">Clientes</td>
                            <td class="noborder" align="right"><%= IIf(CNT_Clientes > 0, CNT_Clientes.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(CNT_Clientes).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Inventarios</td>
                            <td class="noborder" align="right"><%= IIf(CNT_Inventarios > 0, CNT_Inventarios.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(CNT_Inventarios).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Impuestos</td>
                            <td class="noborder" align="right"><%= IIf(CNT_Impuestos > 0, CNT_Impuestos.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(CNT_Impuestos).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Activo Diferido e Intangible</td>
                            <td class="noborder" align="right"><%= IIf(CNT_ActivoDiferido > 0, CNT_ActivoDiferido.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(CNT_ActivoDiferido).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder" colspan="2"><b>Aumento (Disminución) Pasivo</b></td>
                        </tr>
                        <tr>
                            <td class="noborder" style="border-bottom:1px dotted !important;border-color:#000;">Proveedores</td>
                            <td class="noborder" align="right" style="border-bottom:1px dotted !important;border-color:#000;"><%= IIf(CNT_Proveedores > 0, CNT_Proveedores.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(CNT_Proveedores).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Total</td>
                            <td class="noborder" align="right"><%= IIf(CNT_Total > 0, CNT_Total.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(CNT_Total).ToString("#,###,###") & ")</span>")%></td>
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
    <div style='font-size:14px;'><%=TranslateLocale.text("Del 1 de Enero al") %> <%= (DateSerial(Year(New Date(anio, mes, 1)), Month(New Date(anio, mes, 1)) + 1, 0)).Day & TranslateLocale.text(" de ") & NombrePeriodo(mes) & TranslateLocale.text(" del ") & anio%></div>             
    <table id="tblReporte_5" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td align="center" class="titulos2"><b><%=TranslateLocale.text("CONCEPTO")%></b></td>
            <td>&nbsp;</td>
            <td align="center" class="titulos2">&nbsp;</td>
            <td align="center" class="titulos2">GNU</td>
            <td align="center" class="titulos2">NB</td>
            <td align="center" class="titulos2">NF</td>
            <td align="center" class="titulos2">NUSA</td>
            <td align="center" class="titulos2">NE</td>
            <td align="center" class="titulos2">NP</td>
            <td align="center" class="titulos2">NPC</td>
        </tr>
<% 
    dtRep = dsReporte.Tables(60)
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False

        If imprimir_separador Then
            Response.Write("<tr><td colspan='9'><div style='height:7px'></div></td></tr>")
        End If

        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos2 columnaTitulos' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
        Response.Write("<td>&nbsp;</td>")

        If dr("solo_titulo") Then
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>&nbsp;</td>")
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>&nbsp;</td>")
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>&nbsp;</td>")
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>&nbsp;</td>")
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>&nbsp;</td>")
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>&nbsp;</td>")
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>&nbsp;</td>")
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>&nbsp;</td>")
        Else
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 0) & "</td>")
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 10) & "</td>")
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 6) & "</td>")
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 3) & "</td>")
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 12) & "</td>")
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 2) & "</td>")
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 5) & "</td>")
            Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep8(dr, 13) & "</td>")
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
    dtRep = dsReporte.Tables(61)
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
            dtRep = dsReporte.Tables(60)
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
            Dim Inv_Total As Integer = Inv_Capex + Inv_Dividendos


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
                            <td colspan="2" class="noborder" style="border-bottom:1px dotted !important;border-color:#000;" ><b><%=TranslateLocale.text("Partidas Contables")%></b></td>
                        </tr>
                        <tr>
                            <td class="noborder"><%=TranslateLocale.text("Activo y Pasivo Diferido, neto")%></td>
                            <td class="noborder" align="right"><%= IIf(PC_ActivoPasivoDiferido > 0, PC_ActivoPasivoDiferido.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(PC_ActivoPasivoDiferido).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder"><%=TranslateLocale.text("Provisiones. Impuestos, ER")%></td>
                            <td class="noborder" align="right"><%= IIf(PC_ProvisionesImpuestosER > 0, PC_ProvisionesImpuestosER.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(PC_ProvisionesImpuestosER).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder"><%=TranslateLocale.text("Provisiones. Financieros, ER")%></td>
                            <td class="noborder" align="right"><%= IIf(PC_ProvisionesFinancierosER > 0, PC_ProvisionesFinancierosER.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(PC_ProvisionesFinancierosER).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder"><%=TranslateLocale.text("Under / Over Billing")%></td>
                            <td class="noborder" align="right"><%= IIf(PC_UnderOverBilling > 0, PC_UnderOverBilling.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(PC_UnderOverBilling).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder" style="border-bottom:1px dotted !important;border-color:#000;"><%=TranslateLocale.text("Variación Cambiaria no realizada / por Deuda")%></td>
                            <td class="noborder" align="right" style="border-bottom:1px dotted !important;border-color:#000;"><%= IIf(PC_VariacionCambiariaNoRealizada > 0, PC_VariacionCambiariaNoRealizada.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(PC_VariacionCambiariaNoRealizada).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder">Total</td>
                            <td class="noborder" align="right"><%= IIf(PC_Total > 0, PC_Total.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(PC_Total).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td colspan="2"><b><%=TranslateLocale.text("NOTA: No incluye Nutec Ibar")%></b></td>
                        </tr>
                    </table>
                </td>
                <td class="noborder" style="width:30px;">
                    &nbsp;
                </td>
                <td class="noborder">
                    <table border="0" style="border:none">
                        <tr>
                            <td colspan="2" style="border-bottom:1px dotted !important;border-color:#000;" class="noborder"><b><%=TranslateLocale.text("Capital de Trabajo")%></b></td>
                        </tr>
                        <tr>
                            <td class="noborder"><%=TranslateLocale.text("INTERCOMPAÑÍAS. CxC (-) CxP, facturas operativas")%></td>
                            <td class="noborder" align="right"><%= IIf(CT_Intercompanias > 0, CT_Intercompanias.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(CT_Intercompanias).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder"><%=TranslateLocale.text("Cuentas por Pagar")%></td>
                            <td class="noborder" align="right"><%= IIf(CT_CuentasPorPagar > 0, CT_CuentasPorPagar.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(CT_CuentasPorPagar).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder"><%=TranslateLocale.text("Cuentas por Cobrar (Clientes y Deudores)")%></td>
                            <td class="noborder" align="right"><%= IIf(CT_CuentasPorCobrarClientesDeudores > 0, CT_CuentasPorCobrarClientesDeudores.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(CT_CuentasPorCobrarClientesDeudores).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder"><%=TranslateLocale.text("Cuentas por Cobrar (Depósitos en Garantía)")%></td>
                            <td class="noborder" align="right"><%= IIf(CT_CuentasPorCobrarDepositosGarantia > 0, CT_CuentasPorCobrarDepositosGarantia.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(CT_CuentasPorCobrarDepositosGarantia).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder"><%=TranslateLocale.text("Inventarios")%></td>
                            <td class="noborder" align="right"><%= IIf(CT_Inventarios > 0, CT_Inventarios.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(CT_Inventarios).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder" style="border-bottom:1px dotted !important;border-color:#000;"><%=TranslateLocale.text("Impuestos Pagados")%></td>
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
                            <td colspan="2" style="border-bottom:1px dotted !important;border-color:#000;" class="noborder"><b><%=TranslateLocale.text("Inversión")%></b></td>
                        </tr>

                        
                        <% If Inv_Dividendos <> 0 Then %>
                        <tr>
                            <td class="noborder"><%=TranslateLocale.text("Dividendos, neto")%></td>
                            <td class="noborder" align="right"><%= IIf(Inv_Dividendos > 0, Inv_Dividendos.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Inv_Dividendos).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <% End If %>

                        <tr>
                            <td class="noborder" style="border-bottom:1px dotted !important;border-color:#000;"><%=TranslateLocale.text("Capex, neto")%></td>
                            <td class="noborder" align="right" style="border-bottom:1px dotted !important;border-color:#000;"><%= IIf(Inv_Capex > 0, Inv_Capex.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Inv_Capex).ToString("#,###,###") & ")</span>")%></td>
                        </tr>



                        <%--<tr>
                            <td class="noborder"><%=TranslateLocale.text("Dividendos por pagar")%></td>
                            <td class="noborder" align="right"><%= IIf(Inv_DividendosPorPagar > 0, Inv_DividendosPorPagar.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Inv_DividendosPorPagar).ToString("#,###,###") & ")</span>")%></td>
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
                            <td colspan="2" style="border-bottom:1px dotted !important;border-color:#000;" class="noborder"><b><%=TranslateLocale.text("Financiamiento")%></b></td>
                        </tr>
                        <tr>
                            <td class="noborder"><%=TranslateLocale.text("Contratación Deuda Bancaria")%></td>
                            <td class="noborder" align="right"><%= IIf(Fin_ContratacionDeudaBancaria > 0, Fin_ContratacionDeudaBancaria.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Fin_ContratacionDeudaBancaria).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder"><%=TranslateLocale.text("Amortización Pasivo")%></td>
                            <td class="noborder" align="right"><%= IIf(Fin_AmortizacionPasivo > 0, Fin_AmortizacionPasivo.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Fin_AmortizacionPasivo).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder"><%=TranslateLocale.text("Pago de Intereses Bancarios")%></td>
                            <td class="noborder" align="right"><%= IIf(Fin_PagoInteresesBancarios > 0, Fin_PagoInteresesBancarios.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Fin_PagoInteresesBancarios).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder"><%=TranslateLocale.text("Dividendos pagados")%></td>
                            <td class="noborder" align="right"><%= IIf(Fin_DividendosPagados > 0, Fin_DividendosPagados.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Fin_DividendosPagados).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder"><%=TranslateLocale.text("INTERCOMPAÑÍAS. CxC (-) CxP, facturas fiscales y préstamos")%></td>
                            <td class="noborder" align="right"><%= IIf(Fin_Intercompanias > 0, Fin_Intercompanias.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Fin_Intercompanias).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
                        <tr>
                            <td class="noborder" style="border-bottom:1px dotted !important;border-color:#000;"><%=TranslateLocale.text("Documentos por Pagar LP")%></td>
                            <td class="noborder" align="right" style="border-bottom:1px dotted !important;border-color:#000;"><%= IIf(Fin_DocsXPagarLP > 0, Fin_DocsXPagarLP.ToString("#,###,###"), "<span style='color:red'>(" & Math.Abs(Fin_DocsXPagarLP).ToString("#,###,###") & ")</span>")%></td>
                        </tr>
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





    <div id="divReporte_6" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Pedidos y Facturación")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(6);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_6', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
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
            'monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'If drDato("monto_real_tot") - drDato("monto_real_tot_ant") > 0 Then
            '    monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'Else
            '    monto_dif_anio = ((drDato("monto_real_tot_ant") - drDato("monto_real_tot")) / drDato("monto_real_tot")) * 100 * -1
            'End If
            monto_dif_anio = ((drDato("monto_real_tot") / drDato("monto_real_tot_ant")) - 1) * 100

        End If

        If imprimir_separador Then
            Response.Write("<tr><td colspan='10'><div style='height:7px'></div></td></tr>")
        End If
            
        If drDato("es_separador") = True Then
%>
                <tr class='titulos'><td colspan="10"><%=TranslateLocale.text(descripcion)%></td></tr>
<%
Else
 %>
                <tr <%=IIf(drDato("permite_captura")=False,"class='filaTotales'","") %>>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>'><%=TranslateLocale.text(descripcion)%></td>
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
                    <td align="center"><b><%=TranslateLocale.text("Meses")%></b></td>
                </tr>
<%
    For Each drDato As DataRow In dtRep.Rows
        colAlterna = False

        Dim descripcion As String = drDato("descripcion")
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
                <tr class='titulos'><td colspan="3"><%=TranslateLocale.text(descripcion)%></td></tr>
<%
Else
 %>
                <tr <%=IIf(drDato("permite_captura")=False,"class='filaTotales'","") %>>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>' style="height:18px;"><%=TranslateLocale.text(descripcion)%></td>
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
        Dim descripcion As String = drDato("descripcion")
        Dim permite_captura As Boolean = drDato("permite_captura")
        Dim monto_real As Decimal = drDato("monto_real")
        Dim monto_real_tot As Decimal = drDato("monto_real_tot")

        monto_plan_mes = PlanDistribucion(drDato, mes, TipoValor.MesActual)
        monto_plan_acum = PlanDistribucion(drDato, mes, TipoValor.MesAcumulado)


        If monto_plan_mes > 0 Then monto_rp = (monto_real / monto_plan_mes - 1) * 100
        If monto_plan_acum > 0 Then monto_rpa = (monto_real_tot / monto_plan_acum - 1) * 100

        Dim monto_dif_anio As Double = 0
        If drDato("monto_real_tot_ant") > 0 Then
            'monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'If drDato("monto_real_tot") - drDato("monto_real_tot_ant") > 0 Then
            '    monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'Else
            '    monto_dif_anio = ((drDato("monto_real_tot_ant") - drDato("monto_real_tot")) / drDato("monto_real_tot")) * 100 * -1
            'End If
            monto_dif_anio = ((drDato("monto_real_tot") / drDato("monto_real_tot_ant")) - 1) * 100

        End If

        If imprimir_separador Then
            Response.Write("<tr><td colspan='10'><div style='height:7px'></div></td></tr>")
        End If
            


        If drDato("es_separador") = True Then
%>
                <tr class='titulos'><td colspan="10"><%=TranslateLocale.text(descripcion)%></td></tr>
<%
Else
 %>
                <tr <%=IIf(drDato("permite_captura")=False,"class='filaTotales'","") %>>
                    <td align="left" class='datos<%= IIf(permite_captura = False, " negritas", "") & IIf(colAlterna, " columnaAlterna", "")%>'><%=TranslateLocale.text(descripcion)%></td>
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









    <div id="divReporte_17" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'>Headcount - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(17);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_17', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    <table id="tblReporte_17" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td rowspan="2" align="center" class="titulos2"><b>HEADCOUNT</b></td>
            <td colspan="2" align="center" class="titulos2"><%=TranslateLocale.text("HORNOS")%></td>
            <td colspan="2" align="center" class="titulos2"><%=TranslateLocale.text("FIBRAS")%></td>
            <td colspan="2" align="center" class="titulos2">NC</td>
            <td colspan="2" align="center" class="titulos2">TOTAL</td>
        </tr>
        <tr class="filaTotales">
            <td align='center' class='titulos2' style="width:38px;"><b>Act</b></td>
            <td align='center' class='titulos2' style="width:38px;"><%=TranslateLocale.text("Mes<br />Ant")%></td>
            <td align='center' class='titulos2' style="width:38px;"><b>Act</b></td>
            <td align='center' class='titulos2' style="width:38px;"><%=TranslateLocale.text("Mes<br />Ant")%></td>
            <td align='center' class='titulos2' style="width:38px;"><b>Act</b></td>
            <td align='center' class='titulos2' style="width:38px;"><%=TranslateLocale.text("Mes<br />Ant")%></td>
            <td align='center' class='titulos2' style="width:38px;"><b>Act</b></td>
            <td align='center' class='titulos2' style="width:38px;"><%=TranslateLocale.text("Mes<br />Ant")%></td>
        </tr>
<% 
    dtRep = dsReporte.Tables(25)
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False
        If imprimir_separador Then
            Response.Write("<tr><td colspan='9'><div style='height:7px'></div></td></tr>")
        End If
        If dr("es_separador") = True Then
            Response.Write("<tr class='titulos'><td colspan='9'>" & TranslateLocale.text(dr("descripcion")) & "</td></tr>")
        Else
            Response.Write("<tr>")
            Response.Write("<td align='left' class='subtitulos2 columnaTitulos' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
        
            Response.Write("<td align='" & IIf(dr("es_multivalor"), "center", "right") & "' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & IIf(dr("es_multivalor"), Format(dr("monto1"), "#,###,##0"), Format(dr("monto1"), "#,###,##0")) & "</td>")
            Response.Write("<td align='" & IIf(dr("es_multivalor"), "center", "right") & "' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'><span>" & IIf(Not dr("es_multivalor"), Format(dr("monto_ant1"), "#,###,##0"), "") & "</span>" & "</td>")
            Response.Write("<td align='" & IIf(dr("es_multivalor"), "center", "right") & "' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & IIf(dr("es_multivalor"), Format(dr("monto2"), "#,###,##0"), Format(dr("monto2"), "#,###,##0")) & "</td>")
            Response.Write("<td align='" & IIf(dr("es_multivalor"), "center", "right") & "' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'><span>" & IIf(Not dr("es_multivalor"), Format(dr("monto_ant2"), "#,###,##0"), "") & "</span>" & "</td>")
            Response.Write("<td align='" & IIf(dr("es_multivalor"), "center", "right") & "' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & IIf(dr("es_multivalor"), Format(dr("monto3"), "#,###,##0"), Format(dr("monto3"), "#,###,##0")) & "</td>")
            Response.Write("<td align='" & IIf(dr("es_multivalor"), "center", "right") & "' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'><span>" & IIf(Not dr("es_multivalor"), Format(dr("monto_ant3"), "#,###,##0"), "") & "</span>" & "</td>")
            Response.Write("<td align='" & IIf(dr("es_multivalor"), "center", "right") & "' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & IIf(dr("es_multivalor"), Format(dr("monto4"), "#,###,##0"), Format(dr("monto4"), "#,###,##0")) & "</td>")
            Response.Write("<td align='" & IIf(dr("es_multivalor"), "center", "right") & "' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'><span>" & IIf(Not dr("es_multivalor"), Format(dr("monto_ant4"), "#,###,##0"), "") & "</span>" & "</td>")
        
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
            Response.Write("<tr><td colspan='9'><div style='height:7px'></div></td></tr>")
        End If
        If dr("es_separador") = True Then
            Response.Write("<tr class='titulos'><td colspan='9'>" & TranslateLocale.text(dr("descripcion")) & "</td></tr>")
        Else
            Response.Write("<tr>")
            Response.Write("<td align='left' class='subtitulos2 columnaTitulos' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
        
            Response.Write("<td colspan='2' align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & IIf(dr("es_multivalor") = False, Format(dr("monto1"), "#,###,##0"), Format(dr("monto1"), "#,###,##0") & "<span style='float:right'>" & Format(dr("monto_ant1"), "#,###,##0") & "</span>") & "</td>")
            Response.Write("<td colspan='2' align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & IIf(dr("es_multivalor") = False, Format(dr("monto2"), "#,###,##0"), Format(dr("monto2"), "#,###,##0") & "<span style='float:right'>" & Format(dr("monto_ant2"), "#,###,##0") & "</span>") & "</td>")
            Response.Write("<td colspan='2' align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & IIf(dr("es_multivalor") = False, Format(dr("monto3"), "#,###,##0"), Format(dr("monto3"), "#,###,##0") & "<span style='float:right'>" & Format(dr("monto_ant3"), "#,###,##0") & "</span>") & "</td>")
            Response.Write("<td colspan='2' align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & IIf(dr("es_multivalor") = False, Format(dr("monto4"), "#,###,##0"), Format(dr("monto4"), "#,###,##0") & "<span style='float:right'>" & Format(dr("monto_ant4"), "#,###,##0") & "</span>") & "</td>")
        
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
    
    
    Dim stringPeriodosGrafica1 = "'Cierre " & (anio - 4) & "', 'Cierre " & (anio - 3) & "', 'Cierre " & (anio - 2) & "', 'Cierre Ant'"
    If mes = 1 Then
        stringPeriodosGrafica1 &= ", 'Ene'"
    ElseIf mes = 2 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb'"
    ElseIf mes = 3 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar'"
    ElseIf mes = 4 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr'"
    ElseIf mes = 5 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May'"
    ElseIf mes = 6 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun'"
    ElseIf mes = 7 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul'"
    ElseIf mes = 8 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago'"
    ElseIf mes = 9 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep'"
    ElseIf mes = 10 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct'"
    ElseIf mes = 11 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov'"
    ElseIf mes = 12 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'"
    End If
    
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
                categories: [<%=stringPeriodosGrafica1%>]
            },
            yAxis: {
                title: {
                    text: '<%=TranslateLocale.text("Empleados")%>'
                },
                min: 0
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
                name: '<%=TranslateLocale.text("HORNOS")%>',
                data: [<%=GraficaHeadcount_Datos(dtRep, 1)%>]
            }, {
                name: '<%=TranslateLocale.text("FIBRAS")%>',
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
    <div style='font-size:20px;'><%=TranslateLocale.text("Costo de Nóminas")%> - <%=anio%></div>

<%
    dtRep = dsReporte.Tables(28)
    stringPeriodosGrafica1 = "'Cierre " & (anio - 4) & "', 'Cierre " & (anio - 3) & "', 'Cierre " & (anio - 2) & "', 'Cierre Ant'"
    If mes = 1 Then
        stringPeriodosGrafica1 &= ", 'Ene'"
    ElseIf mes = 2 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb'"
    ElseIf mes = 3 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar'"
    ElseIf mes = 4 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr'"
    ElseIf mes = 5 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May'"
    ElseIf mes = 6 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun'"
    ElseIf mes = 7 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul'"
    ElseIf mes = 8 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago'"
    ElseIf mes = 9 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep'"
    ElseIf mes = 10 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct'"
    ElseIf mes = 11 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov'"
    ElseIf mes = 12 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'"
    End If

%>
		<script type="text/javascript">
$(function () {
        $('#containerCostoNominas').highcharts({
            chart: {
                type: 'line'
            },
            title: {
                text: '<%=TranslateLocale.text("Costo de Nóminas")%>'
            },
            xAxis: {
                categories: [<%=stringPeriodosGrafica1%>]
            },
            yAxis: {
                title: {
                    text: '<%=TranslateLocale.text("Costo (Miles de USD)")%>'
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
                name: '<%=TranslateLocale.text("HORNOS")%>',
                data: [<%=GraficaCostoNominas_Datos(dtRep, 1)%>]
            }, {
                name: '<%=TranslateLocale.text("FIBRAS")%>',
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









    






    

    
    <div id="divReporte_32" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Headcount y Costo de Nóminas")%> - <%=anio%></div>

<%
    Dim dtRepHeadcount As DataTable = dsReporte.Tables(27)
    dtRep = dsReporte.Tables(28)
    stringPeriodosGrafica1 = "'Cierre " & (anio - 4) & "', 'Cierre " & (anio - 3) & "', 'Cierre " & (anio - 2) & "', 'Cierre Ant'"
    If mes = 1 Then
        stringPeriodosGrafica1 &= ", 'Ene'"
    ElseIf mes = 2 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb'"
    ElseIf mes = 3 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar'"
    ElseIf mes = 4 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr'"
    ElseIf mes = 5 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May'"
    ElseIf mes = 6 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun'"
    ElseIf mes = 7 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul'"
    ElseIf mes = 8 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago'"
    ElseIf mes = 9 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep'"
    ElseIf mes = 10 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct'"
    ElseIf mes = 11 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov'"
    ElseIf mes = 12 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'"
    End If

%>
		<script type="text/javascript">

		    $(function () {
		        Highcharts.chart('containerHeadcountCostoNominas', {
		            chart: {
		                zoomType: 'xy'
		            },
		            title: {
		                text: 'Headcount y Costo de Nóminas'
		            },
		            xAxis: [{
		                categories: [<%=stringPeriodosGrafica1%>],
		                crosshair: true
		            }],
		            yAxis: [{ // Primary yAxis
		                labels: {
		                    format: '{value}',
		                    style: {
		                        color: Highcharts.getOptions().colors[1]
		                    }
		                },
		                title: {
		                    text: 'Empleados',
		                    style: {
		                        color: Highcharts.getOptions().colors[1]
		                    }
		                }
		            }, { // Secondary yAxis
		                title: {
		                    text: 'Costo',
		                    style: {
		                        color: Highcharts.getOptions().colors[0]
		                    }
		                },
		                labels: {
		                    format: '$ {value}',
		                    style: {
		                        color: Highcharts.getOptions().colors[0]
		                    }
		                },
		                opposite: true
		            }],
		            tooltip: {
		                shared: true
		            },
		            //legend: {
		            //    layout: 'vertical',
		            //    align: 'left',
		            //    x: 60,
		            //    verticalAlign: 'top',
		            //    y: 30,
		            //    floating: true,
		            //    backgroundColor:'rgba(255,255,255,0.25)'
		            //},
		            plotOptions: {
		                line: {
		                    dataLabels: {
		                        enabled: true
		                    },
		                    enableMouseTracking: true
		                },column: {
		                    dataLabels: {
		                        enabled: true
		                    },
		                    enableMouseTracking: true
		                }
		            },
		            series: [{
                        name: 'Costo <%=TranslateLocale.text("HORNOS")%>',
		                type: 'column',
		                yAxis: 1,
		                data: [<%=GraficaCostoNominas_Datos(dtRep, 1)%>]
                    }, {
                        name: 'Costo <%=TranslateLocale.text("FIBRAS")%>',
                        type: 'column',
                        yAxis: 1,
                        data: [<%=GraficaCostoNominas_Datos(dtRep, 2)%>]
                    }, {
                        name: 'Costo NC',
                        type: 'column',
                        yAxis: 1,
                        data: [<%=GraficaCostoNominas_Datos(dtRep, 3)%>]
                    }, {
                        name: 'Empleados <%=TranslateLocale.text("HORNOS")%>',
		                type: 'line',
		                data: [<%=GraficaHeadcount_Datos(dtRepHeadcount, 1)%>]
                    }, {
                        name: 'Empleados <%=TranslateLocale.text("FIBRAS")%>',
                        type: 'line',
                        data: [<%=GraficaHeadcount_Datos(dtRepHeadcount, 2)%>]
                    }, {
                        name: 'Empleados NC',
                        type: 'line',
                        data: [<%=GraficaHeadcount_Datos(dtRepHeadcount, 3)%>]
                    }]
		        });
		    });
	</script>



        <div id="containerHeadcountCostoNominas" style="width: 800px; height: 400px;"></div>
    </div>









    






    









    <div id="divReporte_20" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Utilidad Operativa por USD Pagado (total)")%></div>

<%
    dtRep = dsReporte.Tables(29)
    'stringPeriodosGrafica1 = "'Cierre " & (anio - 4) & "', 'Cierre " & (anio - 3) & "', 'Cierre " & (anio - 2) & "', 'Cierre Ant'"
    stringPeriodosGrafica1 = "'Prom " & (anio - 4) & "', 'Prom " & (anio - 3) & "', 'Prom " & (anio - 2) & "', 'Prom Ant'"
    If mes = 1 Then
        stringPeriodosGrafica1 &= ", 'Ene'"
    ElseIf mes = 2 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb'"
    ElseIf mes = 3 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar'"
    ElseIf mes = 4 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr'"
    ElseIf mes = 5 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May'"
    ElseIf mes = 6 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun'"
    ElseIf mes = 7 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul'"
    ElseIf mes = 8 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago'"
    ElseIf mes = 9 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep'"
    ElseIf mes = 10 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct'"
    ElseIf mes = 11 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov'"
    ElseIf mes = 12 Then
        stringPeriodosGrafica1 &= ", 'Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'"
    End If


    %>
		<script type="text/javascript">
$(function () {
        $('#containerUtilidadOpPorUSD').highcharts({
            chart: {
                type: 'line'
            },
            title: {
                text: '<%=TranslateLocale.text("Utilidad Operativa por USD Pagado (total)")%>'
            },
            subtitle: {
                text: '<%=TranslateLocale.text("PROMEDIO DE LOS ÚLTIMOS 3 MESES")%>'
            },
            xAxis: {
                categories: [<%=stringPeriodosGrafica1%>]
            },
            yAxis: {
                title: {
                    text: '<%=TranslateLocale.text("Utilidad")%>'
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
                name: '<%=TranslateLocale.text("HORNOS")%>',
                data: [<%=GraficaUtilidadOpNominas_Datos(dtRep, 1)%>]
            }, {
                name: '<%=TranslateLocale.text("FIBRAS")%>',
                data: [<%=GraficaUtilidadOpNominas_Datos(dtRep, 2)%>]
            }, {
                name: 'TOTAL',
                data: [<%=GraficaUtilidadOpNominas_Datos(dtRep, 3)%>]
            }]
        });
    });
    

		</script>
        <div id="containerUtilidadOpPorUSD" style="width: 800px; height: 400px;"></div>
    </div>









    
    <div id="divReporte_15" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Facturación neta / Utilidad de Operación")%></div>

<%
        dtRep = dsReporte.Tables(21)
%>

	<script type="text/javascript">
	    $(function () {
	        $('#containerFacturacionNeta').highcharts({
	            chart: {
	            },
	            title: {
	                text: '<%=TranslateLocale.text("Facturación neta / Utilidad de Operación")%>'
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
	                name: '<%=TranslateLocale.text("Facturación neta")%>',
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
	                    x: 0,
	                    y: -25
	                }
	            }, {
	                color: '#FF0',
	                lineWidth: 3,
	                type: 'spline',
	                name: '<%=TranslateLocale.text("Utilidad de Operación")%>',
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
	                    y: 2
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
    </div>






   <div id="divReporte_26" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Facturación neta / Utilidad de Operación a partir de 2013")%></div>

<%
        dtRep = dsReporte.Tables(46)
%>

	<script type="text/javascript">
	    $(function () {
	        $('#containerFacturacionNeta2010').highcharts({
	            chart: {
	            },
	            title: {
	                text: '<%=TranslateLocale.text("Facturación neta / Utilidad de Operación a partir de 2013")%>'
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
	                name: '<%=TranslateLocale.text("Facturación neta")%>',
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
	                    x: 0,
	                    y: -25
	                }
	            }, {
	                color: '#FF0',
	                lineWidth: 3,
	                type: 'spline',
	                name: '<%=TranslateLocale.text("Utilidad de Operación NS")%>',
	                data: [<%=GraficaFacturacionNeta_DatosLinea(dtRep)%>],
	                dataLabels: {
	                    enabled: true,
	                    formatter: function () {
	                        return Highcharts.numberFormat(this.y, 1, '.');
	                    },
	                    style: {
	                        fontWeight: 'bold', 
	                        color: '#000',
	                        fontSize: '12px'
	                    },
	                    x: -13,
	                    y: -2
	                },
	                marker: {
	                    lineWidth: 0,
	                    lineColor: '#00F',
	                    fillColor: '#00F',
	                    symbol: 'triangle'
	                }
	            }, {
	                color: '#000080',
	                lineWidth: 2,
	                type: 'spline',
	                name: '<%=TranslateLocale.text("EBITDA")%>',
	                data: [<%=GraficaFacturacionNeta_DatosLineaEbitda(dtRep)%>],
	                dataLabels: {
	                    enabled: true,
	                    formatter: function () {
	                        return Highcharts.numberFormat(this.y, 1, '.');
	                    },
	                    style: {
	                        fontWeight: 'bold', 
	                        color: '#000',
	                        fontSize: '12px'
	                    },
	                    x: 13,
	                    y: -3
	                },
	                marker: {
	                    lineWidth: 0,
	                    lineColor: '#00FFFF',
	                    fillColor: '#00FFFF',
	                    symbol: 'square'
	                }
	            }]
	        });
	    });
	</script>
    <div id="containerFacturacionNeta2010" style="width: 800px; height: 400px;"></div>
    </div>








    <div id="divReporte_7" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Estado de Resultados HORNOS")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(7);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_7', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    <table id="tblReporte_7" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td rowspan="2" align="center" class="titulos2"><b><%=TranslateLocale.text("CONCEPTO")%></b></td>
<%--            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos2">NBA</td>--%>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos2">NB</td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos2"><%=TranslateLocale.text("HORNOS")%></td>
        </tr>
        <tr class="filaTotales">
<%--            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b><%=(anio-1)%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>--%>
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
        
        'Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep4(dr, 1, 1, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep4(dr, 1, 1, 2) & "</td>")
        'colAlterna = Not colAlterna
        'Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep4(dr, 1, 2, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep4(dr, 1, 2, 2) & "</td>")
        'colAlterna = Not colAlterna
        'Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep4(dr, 1, 3, 1) & "</td>")
        'Response.Write("<td>&nbsp;</td>")
        
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


<% 
    Dim titulo8 As String = ""
    If version_2017 Then
        titulo8 = TranslateLocale.text("Estado de Resultados FIBRAS por Compañia")
    Else
        titulo8 = TranslateLocale.text("Estado de Resultados FIBRAS")
    End If
    %>


    <div id="divReporte_8" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=titulo8%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(8);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_8', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>    
    <table id="tblReporte_8" border="1" cellpadding="0" cellspacing="0" width="1840px">
        <tr class="filaTotales">
            <td rowspan="2" align="center" class="titulos2"><b><%=TranslateLocale.text("CONCEPTO")%></b></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos2">NF</td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos2">NUSA</td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos2">NPC</td>
            <td>&nbsp;</td>
            <% If version_2017 Then%>
            <td colspan="5" align="center" class="titulos2"><%=TranslateLocale.text("Suma America")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos2">NE</td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos2">NP</td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos2"><%=TranslateLocale.text("Suma Europa")%></td>
            <% Else%>
            <td colspan="5" align="center" class="titulos2">NE</td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos2">NFV</td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos2">NP</td>
            <% End If%>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos2">NI</td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos2"><%=TranslateLocale.text("FIBRAS")%></td>
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
    dtRep = dsReporte.Tables(5)
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False

        If imprimir_separador Then
            Response.Write("<tr><td colspan='21'><div style='height:7px'></div></td></tr>")
        End If

        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos2 columnaTitulos' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
        Response.Write("<td>&nbsp;</td>")

        If version_2017 Then
            'Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 9, 25, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 1, 1, 2) & "</td>")
            'colAlterna = Not colAlterna
            'Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 9, 26, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 1, 2, 2) & "</td>")
            'colAlterna = Not colAlterna
            'Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 9, 27, 1) & "</td>")
            'Response.Write("<td>&nbsp;</td>")

            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 2, 4, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 2, 4, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 2, 5, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 2, 5, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 2, 6, 1) & "</td>")
            Response.Write("<td>&nbsp;</td>")

            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 7, 19, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 7, 19, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 7, 20, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 7, 20, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 7, 21, 1) & "</td>")
            Response.Write("<td>&nbsp;</td>")

            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 11, 52, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 11, 52, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 11, 53, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 11, 53, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 11, 54, 1) & "</td>")
            Response.Write("<td>&nbsp;</td>")


            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 8, 22, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 8, 22, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 8, 23, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 8, 23, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 8, 24, 1) & "</td>")
            Response.Write("<td>&nbsp;</td>")

            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 5, 13, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 5, 13, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 5, 14, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 5, 14, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 5, 15, 1) & "</td>")
            Response.Write("<td>&nbsp;</td>")

            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 3, 7, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 3, 7, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 3, 8, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 3, 8, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 3, 9, 1) & "</td>")
            Response.Write("<td>&nbsp;</td>")

            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 10, 42, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 10, 42, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 10, 43, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 10, 43, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 10, 44, 1) & "</td>")
            Response.Write("<td>&nbsp;</td>")

            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 4, 10, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 4, 10, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 4, 11, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 4, 11, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 4, 12, 1) & "</td>")
            Response.Write("<td>&nbsp;</td>")
        Else
            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 2, 4, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 2, 4, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 2, 5, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 2, 5, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 2, 6, 1) & "</td>")
            Response.Write("<td>&nbsp;</td>")

            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 7, 19, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 7, 19, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 7, 20, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 7, 20, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 7, 21, 1) & "</td>")
            Response.Write("<td>&nbsp;</td>")


            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 5, 13, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 5, 13, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 5, 14, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 5, 14, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 5, 15, 1) & "</td>")
            Response.Write("<td>&nbsp;</td>")

            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 1, 1, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 1, 1, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 1, 2, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 1, 2, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 1, 3, 1) & "</td>")
            Response.Write("<td>&nbsp;</td>")

            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 3, 7, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 3, 7, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 3, 8, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 3, 8, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 3, 9, 1) & "</td>")
            Response.Write("<td>&nbsp;</td>")

            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 4, 10, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 4, 10, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 4, 11, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 4, 11, 2) & "</td>")
            colAlterna = Not colAlterna
            Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 4, 12, 1) & "</td>")
            Response.Write("<td>&nbsp;</td>")
        End If


        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 6, 16, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 6, 16, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 6, 17, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 6, 17, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 6, 18, 1) & "</td>")

        Response.Write("</tr>")

        imprimir_separador = dr("separador_despues")
    Next
%>
    </table>    
    </div>





<!------------------------------------------>
<!---------- REPORTE 27 -------------------->
<!------------------------------------------>



<% 
    If version_2017 Then
        Dim titulo27 As String = TranslateLocale.text("Estado de Resultados FIBRAS por Negocio")
        dtRep = dsReporte.Tables(47)

%>
        
        <div id="divReporte_27" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=titulo27%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(27);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_27', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>    

    <table id="tblReporte_27" border="0">
        <tr>
            <td>
    <table border="1" cellpadding="0" cellspacing="0" width="1300px">
        <tr class="filaTotales">
            <td rowspan="2" align="center" class="titulos4"><b><%=TranslateLocale.text("CONCEPTO")%></b></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NF Fibras")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NUSA Fibras")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NE Fibras")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NP Fibras")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NI Fibras")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NPC Fibras")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("Total Fibras")%></td>
        </tr>
        <tr class="filaTotales">
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
        </tr>
<% 
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False

        If imprimir_separador Then
            Response.Write("<tr><td colspan='21'><div style='height:7px'></div></td></tr>")
        End If

        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos4 columnaTitulos' nowrap style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
        Response.Write("<td>&nbsp;</td>")

        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 2, 4, 1, "_fibra") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 2, 4, 2, "_fibra") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 2, 5, 1, "_fibra") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 2, 5, 2, "_fibra") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 2, 6, 1, "_fibra") & "</td>")
        Response.Write("<td>&nbsp;</td>")

        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 7, 19, 1, "_fibra") & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 7, 19, 2, "_fibra") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 7, 20, 1, "_fibra") & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 7, 20, 2, "_fibra") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 7, 21, 1, "_fibra") & "</td>")
        Response.Write("<td>&nbsp;</td>")


        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 5, 13, 1, "_fibra") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 5, 13, 2, "_fibra") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 5, 14, 1, "_fibra") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 5, 14, 2, "_fibra") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 5, 15, 1, "_fibra") & "</td>")
        Response.Write("<td>&nbsp;</td>")

        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 3, 7, 1, "_fibra") & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 3, 7, 2, "_fibra") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 3, 8, 1, "_fibra") & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 3, 8, 2, "_fibra") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 3, 9, 1, "_fibra") & "</td>")
        Response.Write("<td>&nbsp;</td>")


        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 4, 10, 1, "_fibra") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 4, 10, 2, "_fibra") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 4, 11, 1, "_fibra") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 4, 11, 2, "_fibra") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 4, 12, 1, "_fibra") & "</td>")
        Response.Write("<td>&nbsp;</td>")


        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 12, 41, 1, "_fibra") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 12, 41, 2, "_fibra") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 12, 42, 1, "_fibra") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 12, 42, 2, "_fibra") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 12, 43, 1, "_fibra") & "</td>")
        Response.Write("<td>&nbsp;</td>")

        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 10, 28, 1, "_fibra") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 10, 28, 2, "_fibra") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 10, 29, 1, "_fibra") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 10, 29, 2, "_fibra") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 10, 30, 1, "_fibra") & "</td>")

        Response.Write("</tr>")

        imprimir_separador = dr("separador_despues")
    Next
%>
    </table>    

            </td>
        </tr>
        <tr>
            <td>
                <br />
            </td>
        </tr>
        <tr>
            <td>
    <table border="1" cellpadding="0" cellspacing="0" width="1300px">
        <tr class="filaTotales">
            <td rowspan="2" align="center" class="titulos4"><b><%=TranslateLocale.text("CONCEPTO")%></b></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NF FV")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NUSA FV")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NE FV")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NP FV")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NI FV")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NPC FV")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("Total FV")%></td>
        </tr>
        <tr class="filaTotales">
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
        </tr>
<% 
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False

        If imprimir_separador Then
            Response.Write("<tr><td colspan='21'><div style='height:7px'></div></td></tr>")
        End If

        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos4 columnaTitulos' nowrap style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
        Response.Write("<td>&nbsp;</td>")

        ''FV

        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 2, 4, 1, "_fv") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 2, 4, 2, "_fv") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 2, 5, 1, "_fv") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 2, 5, 2, "_fv") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 2, 6, 1, "_fv") & "</td>")
        Response.Write("<td>&nbsp;</td>")

        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 7, 19, 1, "_fv") & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 7, 19, 2, "_fv") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 7, 20, 1, "_fv") & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 7, 20, 2, "_fv") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 7, 21, 1, "_fv") & "</td>")
        Response.Write("<td>&nbsp;</td>")


        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 5, 13, 1, "_fv") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 5, 13, 2, "_fv") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 5, 14, 1, "_fv") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 5, 14, 2, "_fv") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 5, 15, 1, "_fv") & "</td>")
        Response.Write("<td>&nbsp;</td>")

        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 3, 7, 1, "_fv") & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 3, 7, 2, "_fv") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 3, 8, 1, "_fv") & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 3, 8, 2, "_fv") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 3, 9, 1, "_fv") & "</td>")
        Response.Write("<td>&nbsp;</td>")


        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 4, 10, 1, "_fv") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 4, 10, 2, "_fv") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 4, 11, 1, "_fv") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 4, 11, 2, "_fv") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 4, 12, 1, "_fv") & "</td>")
        Response.Write("<td>&nbsp;</td>")


        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 12, 41, 1, "_fv") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 12, 41, 2, "_fv") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 12, 42, 1, "_fv") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 12, 42, 2, "_fv") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 12, 43, 1, "_fv") & "</td>")
        Response.Write("<td>&nbsp;</td>")



        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 10, 28, 1, "_fv") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 10, 28, 2, "_fv") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 10, 29, 1, "_fv") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 10, 29, 2, "_fv") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 10, 30, 1, "_fv") & "</td>")

        Response.Write("</tr>")

        imprimir_separador = dr("separador_despues")
    Next
%>
    </table>    

            </td>
        </tr>
        <tr>
            <td>
                <br />
            </td>
        </tr>
        <tr>
            <td>
    <table border="1" cellpadding="0" cellspacing="0" width="1300px">
        <tr class="filaTotales">
            <td rowspan="2" align="center" class="titulos4"><b><%=TranslateLocale.text("CONCEPTO")%></b></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NF SAT")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NUSA SAT")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NE SAT")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NP SAT")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NI SAT")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NPC SAT")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("Total SAT")%></td>
        </tr>
        <tr class="filaTotales">
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
        </tr>
<% 
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False

        If imprimir_separador Then
            Response.Write("<tr><td colspan='21'><div style='height:7px'></div></td></tr>")
        End If

        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos4 columnaTitulos' nowrap style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
        Response.Write("<td>&nbsp;</td>")


        ''SAT

        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 2, 4, 1, "_sat") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 2, 4, 2, "_sat") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 2, 5, 1, "_sat") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 2, 5, 2, "_sat") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 2, 6, 1, "_sat") & "</td>")
        Response.Write("<td>&nbsp;</td>")

        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 7, 19, 1, "_sat") & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 7, 19, 2, "_sat") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 7, 20, 1, "_sat") & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 7, 20, 2, "_sat") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 7, 21, 1, "_sat") & "</td>")
        Response.Write("<td>&nbsp;</td>")


        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 5, 13, 1, "_sat") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 5, 13, 2, "_sat") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 5, 14, 1, "_sat") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 5, 14, 2, "_sat") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 5, 15, 1, "_sat") & "</td>")
        Response.Write("<td>&nbsp;</td>")

        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 3, 7, 1, "_sat") & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 3, 7, 2, "_sat") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 3, 8, 1, "_sat") & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 3, 8, 2, "_sat") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 3, 9, 1, "_sat") & "</td>")
        Response.Write("<td>&nbsp;</td>")


        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 4, 10, 1, "_sat") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 4, 10, 2, "_sat") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 4, 11, 1, "_sat") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 4, 11, 2, "_sat") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 4, 12, 1, "_sat") & "</td>")
        Response.Write("<td>&nbsp;</td>")


        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 12, 41, 1, "_sat") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 12, 41, 2, "_sat") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 12, 42, 1, "_sat") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 12, 42, 2, "_sat") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 12, 43, 1, "_sat") & "</td>")
        Response.Write("<td>&nbsp;</td>")


        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 10, 28, 1, "_sat") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 10, 28, 2, "_sat") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 10, 29, 1, "_sat") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 10, 29, 2, "_sat") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 10, 30, 1, "_sat") & "</td>")


        Response.Write("</tr>")

        imprimir_separador = dr("separador_despues")
    Next
%>
    </table>    

            </td>
        </tr>
        <tr>
            <td>
                <br />
            </td>
        </tr>
        <tr>
            <td>
    <table border="1" cellpadding="0" cellspacing="0" width="1500px">
        <tr class="filaTotales">
            <td rowspan="2" align="center" class="titulos4"><b><%=TranslateLocale.text("CONCEPTO")%></b></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NF Comercial")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NUSA Comercial")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NE Comercial")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NP Comercial")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NI Comercial")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("NPC Comercial")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("Total Comercial")%></td>
            <td>&nbsp;</td>
            <td colspan="5" align="center" class="titulos4"><%=TranslateLocale.text("Total General")%></td>
        </tr>
        <tr class="filaTotales">
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos4'><b><%=anio%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio-1)%></b></td><td align='center' class='titulos4'>%</td>
            <td align='center' class='titulos4'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
        </tr>
<% 
    For Each dr As DataRow In dtRep.Rows
        colAlterna = False

        If imprimir_separador Then
            Response.Write("<tr><td colspan='21'><div style='height:7px'></div></td></tr>")
        End If

        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos4 columnaTitulos' nowrap style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & TranslateLocale.text(dr("descripcion")) & "</td>")
        Response.Write("<td>&nbsp;</td>")


        ''COMERCIAL

        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 2, 4, 1, "_comercial") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 2, 4, 2, "_comercial") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 2, 5, 1, "_comercial") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 2, 5, 2, "_comercial") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 2, 6, 1, "_comercial") & "</td>")
        Response.Write("<td>&nbsp;</td>")

        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 7, 19, 1, "_comercial") & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 7, 19, 2, "_comercial") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 7, 20, 1, "_comercial") & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 7, 20, 2, "_comercial") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 7, 21, 1, "_comercial") & "</td>")
        Response.Write("<td>&nbsp;</td>")


        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 5, 13, 1, "_comercial") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 5, 13, 2, "_comercial") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 5, 14, 1, "_comercial") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 5, 14, 2, "_comercial") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 5, 15, 1, "_comercial") & "</td>")
        Response.Write("<td>&nbsp;</td>")

        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 3, 7, 1, "_comercial") & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 3, 7, 2, "_comercial") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 3, 8, 1, "_comercial") & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 3, 8, 2, "_comercial") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 3, 9, 1, "_comercial") & "</td>")
        Response.Write("<td>&nbsp;</td>")


        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 4, 10, 1, "_comercial") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 4, 10, 2, "_comercial") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 4, 11, 1, "_comercial") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 4, 11, 2, "_comercial") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 4, 12, 1, "_comercial") & "</td>")
        Response.Write("<td>&nbsp;</td>")


        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 12, 41, 1, "_comercial") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 12, 41, 2, "_comercial") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 12, 42, 1, "_comercial") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 12, 42, 2, "_comercial") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 12, 43, 1, "_comercial") & "</td>")
        Response.Write("<td>&nbsp;</td>")


        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 10, 28, 1, "_comercial") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 10, 28, 2, "_comercial") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 10, 29, 1, "_comercial") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 10, 29, 2, "_comercial") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 10, 30, 1, "_comercial") & "</td>")
        Response.Write("<td>&nbsp;</td>")


        '' TOTAL GENERAL
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 6, 16, 1, "") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 6, 16, 2, "") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep27(dr, 6, 17, 1, "") & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep27(dr, 6, 17, 2, "") & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep27(dr, 6, 18, 1, "") & "</td>")


        Response.Write("</tr>")

        imprimir_separador = dr("separador_despues")
    Next
%>
    </table>    

            </td>
        </tr>
    </table>
    </div>

    <%
    End If
    %>












<!------------------------------------------>
<!---------- REPORTE 29 -------------------->
<!------------------------------------------>




    
<% 
    If version_2017 Then
    %>


    <div id="divReporte_29" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Estado de Resultados FIBRAS vs Presupuesto")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(29);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_29', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>    
    <table id="tblReporte_29" border="1" cellpadding="0" cellspacing="0" width="2150px">
        <tr class="filaTotales">
            <td rowspan="2" align="center" class="titulos2"><b><%=TranslateLocale.text("CONCEPTO")%></b></td>
            <td>&nbsp;</td>
            <td colspan="6" align="center" class="titulos2">NF</td>
            <td>&nbsp;</td>
            <td colspan="6" align="center" class="titulos2">NUSA</td>
            <td>&nbsp;</td>
            <td colspan="6" align="center" class="titulos2">NPC</td>
            <td>&nbsp;</td>
            <td colspan="6" align="center" class="titulos2"><%=TranslateLocale.text("Suma America")%></td>
            <td>&nbsp;</td>
            <td colspan="6" align="center" class="titulos2">NE</td>
            <td>&nbsp;</td>
            <td colspan="6" align="center" class="titulos2">NP</td>
            <td>&nbsp;</td>
            <td colspan="6" align="center" class="titulos2"><%=TranslateLocale.text("Suma Europa")%></td>
            <td>&nbsp;</td>
            <td colspan="6" align="center" class="titulos2">NI</td>
            <td>&nbsp;</td>
            <td colspan="6" align="center" class="titulos2"><%=TranslateLocale.text("FIBRAS")%></td>
        </tr>
        <tr class="filaTotales">
            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b><%=TranslateLocale.text("Pto")%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b>% <%=TranslateLocale.text("Pto")%></b></td>
            <td align='center' class='titulos2'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b><%=TranslateLocale.text("Pto")%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b>% <%=TranslateLocale.text("Pto")%></b></td>
            <td align='center' class='titulos2'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b><%=TranslateLocale.text("Pto")%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b>% <%=TranslateLocale.text("Pto")%></b></td>
            <td align='center' class='titulos2'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b><%=TranslateLocale.text("Pto")%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b>% <%=TranslateLocale.text("Pto")%></b></td>
            <td align='center' class='titulos2'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b><%=TranslateLocale.text("Pto")%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b>% <%=TranslateLocale.text("Pto")%></b></td>
            <td align='center' class='titulos2'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b><%=TranslateLocale.text("Pto")%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b>% <%=TranslateLocale.text("Pto")%></b></td>
            <td align='center' class='titulos2'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b><%=TranslateLocale.text("Pto")%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b>% <%=TranslateLocale.text("Pto")%></b></td>
            <td align='center' class='titulos2'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b><%=TranslateLocale.text("Pto")%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b>% <%=TranslateLocale.text("Pto")%></b></td>
            <td align='center' class='titulos2'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos2'><b><%=anio%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b><%=TranslateLocale.text("Pto")%></b></td><td align='center' class='titulos2'>%</td>
            <td align='center' class='titulos2'><b>% <%=TranslateLocale.text("Pto")%></b></td>
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


        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 2, 4, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 2, 4, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 2, 105, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 2, 105, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 2, 106, 1) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 2, 6, 1) & "</td>")
        Response.Write("<td>&nbsp;</td>")

        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 7, 19, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 7, 19, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 7, 120, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 7, 120, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 7, 121, 1) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 7, 21, 1) & "</td>")
        Response.Write("<td>&nbsp;</td>")


        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 7, 52, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 7, 52, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 7, 155, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 7, 155, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 7, 156, 1) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 7, 54, 1) & "</td>")
        Response.Write("<td>&nbsp;</td>")


        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 8, 22, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 8, 22, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 8, 123, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 8, 123, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 8, 124, 1) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 8, 24, 1) & "</td>")
        Response.Write("<td>&nbsp;</td>")

        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 5, 13, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 5, 13, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 5, 114, 1) & "</td><td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 5, 114, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 5, 115, 1) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td nowrap align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 5, 15, 1) & "</td>")
        Response.Write("<td>&nbsp;</td>")


        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 3, 7, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 3, 7, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 3, 108, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 3, 108, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 3, 109, 1) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 3, 9, 1) & "</td>")
        Response.Write("<td>&nbsp;</td>")


        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 10, 42, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 10, 42, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 10, 143, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 10, 143, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 10, 144, 1) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 10, 44, 1) & "</td>")
        Response.Write("<td>&nbsp;</td>")

        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 4, 10, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 4, 10, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 4, 111, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 4, 111, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 4, 112, 1) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 4, 12, 1) & "</td>")
        Response.Write("<td>&nbsp;</td>")

        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 6, 16, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 6, 16, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordederecho'>" & FormateaValorRep5(dr, 6, 117, 1) & "</td><td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & " bordeizquierdo'>" & FormateaValorRep5(dr, 6, 117, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 6, 118, 1) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos2" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep5(dr, 6, 18, 1) & "</td>")

        Response.Write("</tr>")

        imprimir_separador = dr("separador_despues")
    Next
%>
    </table>    
    </div>







    
<% 
End If
    %>














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
            'monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'If drDato("monto_real_tot") - drDato("monto_real_tot_ant") > 0 Then
            '    monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'Else
            '    monto_dif_anio = ((drDato("monto_real_tot_ant") - drDato("monto_real_tot")) / drDato("monto_real_tot")) * 100 * -1
            'End If
            monto_dif_anio = ((drDato("monto_real_tot") / drDato("monto_real_tot_ant")) - 1) * 100

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
                <tr class='titulos'><td colspan="3"><%=descripcion%></td></tr>
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
            'monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'If drDato("monto_real_tot") - drDato("monto_real_tot_ant") > 0 Then
            '    monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'Else
            '    monto_dif_anio = ((drDato("monto_real_tot_ant") - drDato("monto_real_tot")) / drDato("monto_real_tot")) * 100 * -1
            'End If
            monto_dif_anio = ((drDato("monto_real_tot") / drDato("monto_real_tot_ant")) - 1) * 100

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







    <div id="divReporte_10" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Pedidos y Facturación FIBRAS")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(10);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_10', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
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
            'If drDato("monto_real_tot") - drDato("monto_real_tot_ant") > 0 Then
            '    monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'Else
            '    monto_dif_anio = ((drDato("monto_real_tot_ant") - drDato("monto_real_tot")) / drDato("monto_real_tot")) * 100 * -1
            'End If
            monto_dif_anio = ((drDato("monto_real_tot") / drDato("monto_real_tot_ant")) - 1) * 100

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
                    <td align="center"><b><%=TranslateLocale.text("Meses")%></b></td>
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
                <tr class='titulos'><td colspan="3"><%=descripcion%></td></tr>
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

        'Dim monto_dif_anio As Decimal = drDato("monto_real_tot_ant") - drDato("monto_real_tot")
        Dim monto_dif_anio As Double = 0
        If drDato("monto_real_tot_ant") > 0 Then
            'monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'If drDato("monto_real_tot") - drDato("monto_real_tot_ant") > 0 Then
            '    monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'Else
            '    monto_dif_anio = ((drDato("monto_real_tot_ant") - drDato("monto_real_tot")) / drDato("monto_real_tot")) * 100 * -1
            'End If
            monto_dif_anio = ((drDato("monto_real_tot") / drDato("monto_real_tot_ant")) - 1) * 100

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


<%
    If version_2017 Then
%>
    
    
    <div id="divReporte_28" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Pedidos y Facturación FIBRAS por Negocio")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(28);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_28', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    <table id="tblReporte_28">
        <tr><td colspan="2" style='font-size:18px;font-weight:bold;border:none;padding:15px 15px 5px 15px;'><%=TranslateLocale.text("Fibra")%></td></tr>
        <tr valign="top">
            <td>
    
    <table border="1" cellpadding="0" cellspacing="0">
<%

    dtRep = dsReporte.Tables(48)
%>
                <tr class="titulos4">
                    <td rowspan="2" align="center"></td>
                    <td colspan="3" align="center"><b><%=NombrePeriodo(mes)%></b></td>
                    <td align="center">&nbsp;</td>
                    <td colspan="5" align="center"><b><%=TranslateLocale.text("Acumulado")%></b></td>
                </tr>
                <tr class="titulos4">
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
            'monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'If drDato("monto_real_tot") - drDato("monto_real_tot_ant") > 0 Then
            '    monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'Else
            '    monto_dif_anio = ((drDato("monto_real_tot_ant") - drDato("monto_real_tot")) / drDato("monto_real_tot")) * 100 * -1
            'End If
            monto_dif_anio = ((drDato("monto_real_tot") / drDato("monto_real_tot_ant")) - 1) * 100

        End If

        If imprimir_separador Then
            Response.Write("<tr><td colspan='10'><div style='height:7px'></div></td></tr>")
        End If

        If drDato("es_separador") = True Then
%>
                <tr class='titulos4'><td colspan="10"><%=descripcion%></td></tr>
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

    dtRep = dsReporte.Tables(50)
%>
                <tr class="titulos4"><td colspan="3">&nbsp;</td></tr>
                <tr class="titulos4">
                    <td align="center"></td>
                    <td align="center"><b>$</b></td>
                    <td align="center"><b><%=TranslateLocale.text("Meses")%></b></td>
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
                <tr class='titulos4'><td colspan="3"><%=descripcion%></td></tr>
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

    dtRep = dsReporte.Tables(49)
%>
                <tr class="titulos4">
                    <td rowspan="2" align="center"></td>
                    <td colspan="3" align="center"><b><%=NombrePeriodo(mes)%></b></td>
                    <td align="center">&nbsp;</td>
                    <td colspan="5" align="center"><b><%=TranslateLocale.text("Acumulado")%></b></td>
                </tr>
                <tr class="titulos4">
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
            'monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'If drDato("monto_real_tot") - drDato("monto_real_tot_ant") > 0 Then
            '    monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'Else
            '    monto_dif_anio = ((drDato("monto_real_tot_ant") - drDato("monto_real_tot")) / drDato("monto_real_tot")) * 100 * -1
            'End If
            monto_dif_anio = ((drDato("monto_real_tot") / drDato("monto_real_tot_ant")) - 1) * 100

        End If
        

        If imprimir_separador Then
            Response.Write("<tr><td colspan='10'><div style='height:7px'></div></td></tr>")
        End If

        If drDato("es_separador") = True Then
%>
                <tr class='titulos4'><td colspan="10"><%=descripcion%></td></tr>
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

        <tr><td colspan="2" style='font-size:18px;font-weight:bold;border:none;padding:15px 15px 5px 15px;'><%=TranslateLocale.text("FV")%></td></tr>
        <tr valign="top">
            <td>
    
    <table border="1" cellpadding="0" cellspacing="0">
<%

    dtRep = dsReporte.Tables(51)
%>
                <tr class="titulos4">
                    <td rowspan="2" align="center"></td>
                    <td colspan="3" align="center"><b><%=NombrePeriodo(mes)%></b></td>
                    <td align="center">&nbsp;</td>
                    <td colspan="5" align="center"><b><%=TranslateLocale.text("Acumulado")%></b></td>
                </tr>
                <tr class="titulos4">
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
            'monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'If drDato("monto_real_tot") - drDato("monto_real_tot_ant") > 0 Then
            '    monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'Else
            '    monto_dif_anio = ((drDato("monto_real_tot_ant") - drDato("monto_real_tot")) / drDato("monto_real_tot")) * 100 * -1
            'End If
            monto_dif_anio = ((drDato("monto_real_tot") / drDato("monto_real_tot_ant")) - 1) * 100

        End If

        If imprimir_separador Then
            Response.Write("<tr><td colspan='10'><div style='height:7px'></div></td></tr>")
        End If

        If drDato("es_separador") = True Then
%>
                <tr class='titulos4'><td colspan="10"><%=descripcion%></td></tr>
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

    dtRep = dsReporte.Tables(53)
%>
                <tr class="titulos4"><td colspan="3">&nbsp;</td></tr>
                <tr class="titulos4">
                    <td align="center"></td>
                    <td align="center"><b>$</b></td>
                    <td align="center"><b><%=TranslateLocale.text("Meses")%></b></td>
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
                <tr class='titulos4'><td colspan="3"><%=descripcion%></td></tr>
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

    dtRep = dsReporte.Tables(52)
%>
                <tr class="titulos4">
                    <td rowspan="2" align="center"></td>
                    <td colspan="3" align="center"><b><%=NombrePeriodo(mes)%></b></td>
                    <td align="center">&nbsp;</td>
                    <td colspan="5" align="center"><b><%=TranslateLocale.text("Acumulado")%></b></td>
                </tr>
                <tr class="titulos4">
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
            'monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'If drDato("monto_real_tot") - drDato("monto_real_tot_ant") > 0 Then
            '    monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'Else
            '    monto_dif_anio = ((drDato("monto_real_tot_ant") - drDato("monto_real_tot")) / drDato("monto_real_tot")) * 100 * -1
            'End If
            monto_dif_anio = ((drDato("monto_real_tot") / drDato("monto_real_tot_ant")) - 1) * 100

        End If
        

        If imprimir_separador Then
            Response.Write("<tr><td colspan='10'><div style='height:7px'></div></td></tr>")
        End If

        If drDato("es_separador") = True Then
%>
                <tr class='titulos4'><td colspan="10"><%=descripcion%></td></tr>
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


        <tr><td colspan="2" style='font-size:18px;font-weight:bold;border:none;padding:15px 15px 5px 15px;'><%=TranslateLocale.text("SAT")%></td></tr>
        <tr valign="top">
            <td>
    
    <table border="1" cellpadding="0" cellspacing="0">
<%

    dtRep = dsReporte.Tables(54)
%>
                <tr class="titulos4">
                    <td rowspan="2" align="center"></td>
                    <td colspan="3" align="center"><b><%=NombrePeriodo(mes)%></b></td>
                    <td align="center">&nbsp;</td>
                    <td colspan="5" align="center"><b><%=TranslateLocale.text("Acumulado")%></b></td>
                </tr>
                <tr class="titulos4">
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
            'monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'If drDato("monto_real_tot") - drDato("monto_real_tot_ant") > 0 Then
            '    monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'Else
            '    monto_dif_anio = ((drDato("monto_real_tot_ant") - drDato("monto_real_tot")) / drDato("monto_real_tot")) * 100 * -1
            'End If
            monto_dif_anio = ((drDato("monto_real_tot") / drDato("monto_real_tot_ant")) - 1) * 100

        End If

        If imprimir_separador Then
            Response.Write("<tr><td colspan='10'><div style='height:7px'></div></td></tr>")
        End If

        If drDato("es_separador") = True Then
%>
                <tr class='titulos4'><td colspan="10"><%=descripcion%></td></tr>
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

    dtRep = dsReporte.Tables(56)
%>
                <tr class="titulos4"><td colspan="3">&nbsp;</td></tr>
                <tr class="titulos4">
                    <td align="center"></td>
                    <td align="center"><b>$</b></td>
                    <td align="center"><b><%=TranslateLocale.text("Meses")%></b></td>
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
                <tr class='titulos4'><td colspan="3"><%=descripcion%></td></tr>
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

    dtRep = dsReporte.Tables(55)
%>
                <tr class="titulos4">
                    <td rowspan="2" align="center"></td>
                    <td colspan="3" align="center"><b><%=NombrePeriodo(mes)%></b></td>
                    <td align="center">&nbsp;</td>
                    <td colspan="5" align="center"><b><%=TranslateLocale.text("Acumulado")%></b></td>
                </tr>
                <tr class="titulos4">
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
            'monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'If drDato("monto_real_tot") - drDato("monto_real_tot_ant") > 0 Then
            '    monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'Else
            '    monto_dif_anio = ((drDato("monto_real_tot_ant") - drDato("monto_real_tot")) / drDato("monto_real_tot")) * 100 * -1
            'End If
            monto_dif_anio = ((drDato("monto_real_tot") / drDato("monto_real_tot_ant")) - 1) * 100

        End If
        

        If imprimir_separador Then
            Response.Write("<tr><td colspan='10'><div style='height:7px'></div></td></tr>")
        End If

        If drDato("es_separador") = True Then
%>
                <tr class='titulos4'><td colspan="10"><%=descripcion%></td></tr>
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


        <tr><td colspan="2" style='font-size:18px;font-weight:bold;border:none;padding:15px 15px 5px 15px;'><%=TranslateLocale.text("Comercial")%></td></tr>
        <tr valign="top">
            <td>
    
    <table border="1" cellpadding="0" cellspacing="0">
<%

    dtRep = dsReporte.Tables(57)
%>
                <tr class="titulos4">
                    <td rowspan="2" align="center"></td>
                    <td colspan="3" align="center"><b><%=NombrePeriodo(mes)%></b></td>
                    <td align="center">&nbsp;</td>
                    <td colspan="5" align="center"><b><%=TranslateLocale.text("Acumulado")%></b></td>
                </tr>
                <tr class="titulos4">
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
            'monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'If drDato("monto_real_tot") - drDato("monto_real_tot_ant") > 0 Then
            '    monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'Else
            '    monto_dif_anio = ((drDato("monto_real_tot_ant") - drDato("monto_real_tot")) / drDato("monto_real_tot")) * 100 * -1
            'End If
            monto_dif_anio = ((drDato("monto_real_tot") / drDato("monto_real_tot_ant")) - 1) * 100

        End If

        If imprimir_separador Then
            Response.Write("<tr><td colspan='10'><div style='height:7px'></div></td></tr>")
        End If

        If drDato("es_separador") = True Then
%>
                <tr class='titulos4'><td colspan="10"><%=descripcion%></td></tr>
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

    dtRep = dsReporte.Tables(59)
%>
                <tr class="titulos4"><td colspan="3">&nbsp;</td></tr>
                <tr class="titulos4">
                    <td align="center"></td>
                    <td align="center"><b>$</b></td>
                    <td align="center"><b><%=TranslateLocale.text("Meses")%></b></td>
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
                <tr class='titulos4'><td colspan="3"><%=descripcion%></td></tr>
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

    dtRep = dsReporte.Tables(58)
%>
                <tr class="titulos4">
                    <td rowspan="2" align="center"></td>
                    <td colspan="3" align="center"><b><%=NombrePeriodo(mes)%></b></td>
                    <td align="center">&nbsp;</td>
                    <td colspan="5" align="center"><b><%=TranslateLocale.text("Acumulado")%></b></td>
                </tr>
                <tr class="titulos4">
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
            'monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'If drDato("monto_real_tot") - drDato("monto_real_tot_ant") > 0 Then
            '    monto_dif_anio = ((drDato("monto_real_tot") - drDato("monto_real_tot_ant")) / drDato("monto_real_tot_ant")) * 100
            'Else
            '    monto_dif_anio = ((drDato("monto_real_tot_ant") - drDato("monto_real_tot")) / drDato("monto_real_tot")) * 100 * -1
            'End If
            monto_dif_anio = ((drDato("monto_real_tot") / drDato("monto_real_tot_ant")) - 1) * 100

        End If
        

        If imprimir_separador Then
            Response.Write("<tr><td colspan='10'><div style='height:7px'></div></td></tr>")
        End If

        If drDato("es_separador") = True Then
%>
                <tr class='titulos4'><td colspan="10"><%=descripcion%></td></tr>
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

    
    <%        
    End If
    
    %>






    <div id="divReporte_11" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'>Cashflow Forecast - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(11);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_11', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
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
















        <div id="divReporte_21" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Perfil de Deuda")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(21);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_21', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    <table id="tblReporte_21">
        <tr valign="top">
            <td>
    
    <table border="1" cellpadding="0" cellspacing="0">
<%

    dtRep = dsReporte.Tables(18)

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
    deuda_total = 0
    
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
        Dim banco As String = drDato("descripcion")
        Dim tipo As String = drDato("descripcion_2")

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
            <tr><td colspan="16" style="background-color:#dedcdc;"><div style="background-color:#dedcdc;"></div></td></tr>
        <%
            End If
            %>
<%
Next
%>
            </table>    

            </td>
            <td>









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
        Dim banco As String = drDato("descripcion")
        Dim tipo As String = drDato("descripcion_2")
        
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
            <tr><td colspan="16" style="background-color:#dedcdc;"><div style="background-color:#dedcdc;"></div></td></tr>
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
    separador_usado = False
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
        Dim banco As String = drDato("descripcion")
        Dim tipo As String = drDato("descripcion_2")

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

    



            </td>
        </tr>
    </table>
    </div>























<%
    Dim dtRepDiasCartera = dsReporte.Tables(42)
    Dim dtRepDiasInventario = dsReporte.Tables(43)
    Dim dtRepDiasProveedores = dsReporte.Tables(44)
    Dim dtRepDiasTotales = dsReporte.Tables(45)
%>





<%
    dtRep = dsReporte.Tables(33)
    Dim dias_cartera As Integer = 0
    If dtRep.Rows.Count > 0 Then
        dias_cartera = dtRep.Rows(0)("dias_cartera")
    End If


    'RM
    'If dtRepDiasTotales.Rows.Count > 0 Then
    '    dias_cartera = dtRepDiasTotales.Rows(0)("total_dias_cartera")
    'End If
%>


    <div id="divReporte_22" style="display:none;">
    <br /><br />
    <div style='font-size:20px;'><%=TranslateLocale.text("Cap. de Trabajo: Cartera")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(22);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_22', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>    
<br />
    <table id="tblReporte_22" border="0" cellpadding="0" cellspacing="0">
        <tr>
            <td colspan="7" style="border: 0px solid;"><b><%=TranslateLocale.text("Días Cartera")%>:</b> <%=dias_cartera%>
                <table border="1" cellpadding="0" cellspacing="0" style="margin-left:20px;">
                    <tr>
                        <td class="titulos2"><%=TranslateLocale.text("Empresa")%></td>
                        <td class="titulos2"><%=TranslateLocale.text("Días Cartera")%></td>
                    </tr>
                    <%
                        For Each dr As DataRow In dtRepDiasCartera.Rows
                        %>
                    <tr>
                        <td class="datos"><%=dr("empresa")%></td>
                        <td class="datos" align="right" style="padding-right:5px;"><%=Convert.ToDecimal(dr("dias_cartera")).ToString("###,###,##0")%></td>
                    </tr>
                    <%
                    Next
                        %>
                </table>
            </td>
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
    dtRep = dsReporte.Tables(34)
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
    dtRep = dsReporte.Tables(35)
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
                        <td class="datos" <%= IIf(drDato("permite_captura") = False, "style='font-weight:bold;'", "")%> ><%= TranslateLocale.text(drDato("descripcion"))%></td>
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
			    dtRep = dsReporte.Tables(33)
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
			    dtRep = dsReporte.Tables(34)
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
			    dtRep = dsReporte.Tables(35)
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

        </tr>
</table>        

    </div>














    <div id="divReporte_23" style="display:none;">
        <br /><br />
        <div style='font-size:20px;'><%=TranslateLocale.text("Cap. de Trabajo: Caja")%> - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(23);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_23', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
        <table id="tblReporte_23" border="1" cellpadding="0" cellspacing="0">
            <%--<tr>
                <td class="titulos" colspan="13">Comportamiento de Caja</td>
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
    dtRep = dsReporte.Tables(36)
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
		    dtRep = dsReporte.Tables(37)
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
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Saldo de (miles de USD)")%></td>
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
    dtRep = dsReporte.Tables(38)
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
        <table border="1" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titulos2"><%=TranslateLocale.text("Empresa")%></td>
                <td class="titulos2"><%=TranslateLocale.text("Días Inventario")%></td>
            </tr>
            <%
                For Each dr As DataRow In dtRepDiasInventario.Rows
                %>
            <tr>
                <td class="datos"><%=dr("empresa")%></td>
                <td class="datos" align="right" style="padding-right:5px;"><%=Convert.ToDecimal(dr("dias_inventario")).ToString("###,###,##0")%></td>
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
		    
		    dtRep = dsReporte.Tables(39)
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
    <div style='font-size:20px;'>Cap. de Trabajo: Proveedores - <%= NombrePeriodo(mes) & " / " & anio%><span class="linkCopias"><a href="#" onclick="TomaFoto(25);"><%=TranslateLocale.text("(Copiar)")%></a>&nbsp;&nbsp;<a href="javascript:tableToExcel('tblReporte_25', 'Exporar a Excel');"><%=TranslateLocale.text("(Exportar a Excel)")%></a></span></div>
    <table id="tblReporte_25" border="1" cellpadding="0" cellspacing="0">
    	    <tr>
                <td class="titulos" style="font-weight:bold;"><%=TranslateLocale.text("Saldo de (miles de USD)")%></td>
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
    dtRep = dsReporte.Tables(40)
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
        <table border="1" cellpadding="0" cellspacing="0">
            <tr>
                <td class="titulos2"><%=TranslateLocale.text("Empresa")%></td>
                <td class="titulos2"><%=TranslateLocale.text("Días de Pago Proveedores")%></td>
            </tr>
            <%
                For Each dr As DataRow In dtRepDiasProveedores.Rows
                %>
            <tr>
                <td class="datos"><%=dr("empresa")%></td>
                <td class="datos" align="right" style="padding-right:5px;"><%=Convert.ToDecimal(dr("dias_proveedores")).ToString("###,###,##0")%></td>
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
		    
		    dtRep = dsReporte.Tables(41)
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

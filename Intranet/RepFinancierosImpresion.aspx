<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepFinancierosImpresion.aspx.vb" Inherits="Intranet.RepFinancierosImpresion" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reporte</title>
	<link rel="stylesheet" type="text/css" href="/styles/styles.css" />

    <style type="text/css">
        td {
            border-style:solid;
            border-color:#dedede;
            border-width:1px;
            padding-left:5px;
            padding-right:4px;
        }

        .filaHeader {
            background-color:#9de7d7;
            font-weight:bold;
        }
        .filaTotales {
            /*background-color:#9de7d7;*/
            font-weight:bold;
        }
        .filaSeparador {
            background-color:#9de7d7;
            font-weight:bold;
            color:#000;
        }
        .negativo {
            color: red;
        }
        body {
            background-image: none !important;
            background-color: #fff;
            font-family: Arial !important;
        }
        html {
            background-image: none !important;
            background-color: #fff;
            font-family: Arial !important;
        }
    </style>

        <script type="text/javascript">

            var STYLES = '<style type="text/css"> ';
            STYLES += 'body {font-family:Arial; background-color:#ffffff;} ';
            STYLES += ' td {border-style:solid;border-color:#dedede;border-width:1px;padding-left:5px;padding-right:4px;} ';
            STYLES += ' .filaHeader {background-color:#9de7d7;font-weight:bold;} ';
            STYLES += ' .filaTotales {font-weight:bold;} ';
            STYLES += ' .filaSeparador {background-color:#9de7d7;font-weight:bold;color:#000;} ';
            STYLES += ' .negativo {color: red;} ';
            STYLES += ' body {background-image: none !important;background-color: #fff;font-family: Arial !important;} ';
            STYLES += ' html {background-image: none !important;background-color: #fff;font-family: Arial !important;}';
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
                    //$("#" + tblName).find(".negativo").css('color', 'red');
                    //$("#" + tblName).find(".datos").css('font-size', '12px');
                    //$("#" + tblName).find(".datos2").css('font-size', '12px');
                    //$("#" + tblName).find(".datos3").css('font-size', '12px');
                    //$("#" + tblName).find(".bordederecho").css('border-right', 'none');
                    //$("#" + tblName).find(".bordeizquierdo").css('border-left', 'none');


                    var ctx = { worksheet: name || 'Worksheet', table: (STYLES + table.innerHTML) }

                    var a = document.createElement('a');
                    a.href = uri + base64_encode(format(template, ctx));
                    a.download = 'reporte.xls';
                    a.click();
                }
            })();
    </script> 
</head>
<body>
    <form id="form1" runat="server">
        <div style="padding-left:20px">
            <br />
            <div style="text-align:right; width:1200px;">
                <input onclick="javascript: tableToExcel('tblReporte_1', 'Exporar a Excel');" type="button" value="<%=TranslateLocale.text("Exportar a Excel")%>" />
            </div>
            <br />
<%
    Dim columnas As Integer = 14
    If Request.QueryString("r") = "1" Then
        columnas = 13
    End If

    Dim dsReporte As DataSet = RecuperaDatosReporte()
    Dim dtDatos As DataTable = dsReporte.Tables(0)
    Dim dtTotales As DataTable = dsReporte.Tables(1)
    Dim dtPeriodosSinDatos As DataTable = dsReporte.Tables(2)
%>
            <table id="tblReporte_1" border="1" cellpadding="0" cellspacing="0" width="1200">
                <tr>
                    <td class="filaHeader" align="center" colspan="<%=columnas %>" style='font-size:19px;'><asp:Label ID="lblTituloReporte" runat="server"></asp:Label></td>
                </tr>
                <tr>
                    <td class="filaHeader" align="center" colspan="<%=columnas %>" style='font-size:17px;'><%=NombreEmpresa() %> - <%=Request.QueryString("a")%></td>
                </tr>
                <tr>
                    <td class="filaHeader" align="center" style="font-size:17px;"><b><%=TranslateLocale.text("Concepto")%></b></td>
<%
    For i As Integer = 1 To 12
        Response.Write("<td class='filaHeader' align='center' style='font-size:16px;'><b>" & TranslateLocale.text(NombrePeriodo(i)) & "</b></td>")
    Next

    If columnas = 14 Then
%>
                    <td class="filaHeader" align="center" style="font-size:15px;"><b><%=TranslateLocale.text("Acumulado")%></b></td>
<%        
    End If
%>
                </tr>
<%
    For Each drDato As DataRow In dtDatos.Rows
        If drDato("es_separador") = True Then
%>
                <tr class='filaSeparador'><td colspan="<%=columnas %>"><%=TranslateLocale.text(drDato("descripcion"))%></td></tr>
<%
        Else
%>
                <tr <%=IIf(drDato("permite_captura")=False,"class='filaTotales'","") %>>
                    <td><%=TranslateLocale.text(drDato("descripcion")) %></td>
                    <td align="right"<%=IIf(drDato("monto1") < 0, " class='negativo'", "")%>><%=Format(drDato("monto1"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("monto2") < 0, " class='negativo'", "")%>><%=Format(drDato("monto2"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("monto3") < 0, " class='negativo'", "")%>><%=Format(drDato("monto3"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("monto4") < 0, " class='negativo'", "")%>><%=Format(drDato("monto4"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("monto5") < 0, " class='negativo'", "")%>><%=Format(drDato("monto5"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("monto6") < 0, " class='negativo'", "")%>><%=Format(drDato("monto6"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("monto7") < 0, " class='negativo'", "")%>><%=Format(drDato("monto7"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("monto8") < 0, " class='negativo'", "")%>><%=Format(drDato("monto8"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("monto9") < 0, " class='negativo'", "")%>><%=Format(drDato("monto9"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("monto10") < 0, " class='negativo'", "")%>><%=Format(drDato("monto10"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("monto11") < 0, " class='negativo'", "")%>><%=Format(drDato("monto11"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("monto12") < 0, " class='negativo'", "")%>><%=Format(drDato("monto12"), "###,###,##0")%></td>
<%
    If columnas = 14 Then
%>
                    <td align="right"<%=IIf(drDato("monto_total") < 0, " class='negativo'", "")%>><%=Format(drDato("monto_total"), "###,###,##0")%></td>
<%
    End If
%>
                </tr>
<%
End If
Next
    
%>









<%
    If Request.QueryString("r") = "1" And Request.QueryString("e") > 0 Then
%>      
                <tr class=''><td colspan="<%=columnas %>">&nbsp;<br></td></tr>
<%
    Dim dtDatosExtraBalance As DataTable = RecuperaDatosExtraBalanceReporte()
    For Each drDato As DataRow In dtDatosExtraBalance.Rows
        
        Dim formato As String = "###,###,##0"
        Dim signo As String = ""
        If drDato("formato_decimal") = True Then
            formato = "###,###,##0.0"
        End If
        If drDato("formato_porciento") = true Then
            signo = " %"
        End If
%>            

  
                <tr>
                    <td><%=TranslateLocale.text(drDato("descripcion"))%></td>
                    <td align="right"<%=IIf(drDato("mes01") < 0, " class='negativo'", "")%>><%=Format(drDato("mes01"), formato) & signo%></td>
                    <td align="right"<%=IIf(drDato("mes02") < 0, " class='negativo'", "")%>><%=Format(drDato("mes02"), formato) & signo%></td>
                    <td align="right"<%=IIf(drDato("mes03") < 0, " class='negativo'", "")%>><%=Format(drDato("mes03"), formato) & signo%></td>
                    <td align="right"<%=IIf(drDato("mes04") < 0, " class='negativo'", "")%>><%=Format(drDato("mes04"), formato) & signo%></td>
                    <td align="right"<%=IIf(drDato("mes05") < 0, " class='negativo'", "")%>><%=Format(drDato("mes05"), formato) & signo%></td>
                    <td align="right"<%=IIf(drDato("mes06") < 0, " class='negativo'", "")%>><%=Format(drDato("mes06"), formato) & signo%></td>
                    <td align="right"<%=IIf(drDato("mes07") < 0, " class='negativo'", "")%>><%=Format(drDato("mes07"), formato) & signo%></td>
                    <td align="right"<%=IIf(drDato("mes08") < 0, " class='negativo'", "")%>><%=Format(drDato("mes08"), formato) & signo%></td>
                    <td align="right"<%=IIf(drDato("mes09") < 0, " class='negativo'", "")%>><%=Format(drDato("mes09"), formato) & signo%></td>
                    <td align="right"<%=IIf(drDato("mes10") < 0, " class='negativo'", "")%>><%=Format(drDato("mes10"), formato) & signo%></td>
                    <td align="right"<%=IIf(drDato("mes11") < 0, " class='negativo'", "")%>><%=Format(drDato("mes11"), formato) & signo%></td>
                    <td align="right"<%=IIf(drDato("mes12") < 0, " class='negativo'", "")%>><%=Format(drDato("mes12"), formato) & signo%></td>

                </tr>
<%         
Next
End If
%>







            </table>

<%
    If Request.QueryString("r") = "3" Then
%>      <br />
                        <br />
            <div style="text-align:right; width:1200px;">
                <input onclick="javascript: tableToExcel('tblReporte_2', 'Exporar a Excel');" type="button" value="<%=TranslateLocale.text("Exportar a Excel")%>" />
            </div>
            <br />

          <table id="tblReporte_2" border="1" cellpadding="0" cellspacing="0" width="1200">
                <tr class="filaTotales">
                    <td align="center" style="font-size:16px;width:215px;"><b></b></td>
<%
        For i As Integer = 1 To 12
        Response.Write("<td align='center' style='font-size:15px;'><b>" & TranslateLocale.text(NombrePeriodo(i)) & "</b></td>")
        Next
%>
                </tr>
<%
        Dim dtValidacion As DataTable = dsReporte.Tables(3)
        For Each drDato As DataRow In dtValidacion.Rows
%>            

  
                <tr>
                    <td><%=TranslateLocale.text(drDato("descripcion"))%></td>
                    <td align="right"<%=IIf(drDato("valor1") < 0, " class='negativo'", "")%>><%=Format(drDato("valor1"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor2") < 0, " class='negativo'", "")%>><%=Format(drDato("valor2"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor3") < 0, " class='negativo'", "")%>><%=Format(drDato("valor3"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor4") < 0, " class='negativo'", "")%>><%=Format(drDato("valor4"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor5") < 0, " class='negativo'", "")%>><%=Format(drDato("valor5"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor6") < 0, " class='negativo'", "")%>><%=Format(drDato("valor6"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor7") < 0, " class='negativo'", "")%>><%=Format(drDato("valor7"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor8") < 0, " class='negativo'", "")%>><%=Format(drDato("valor8"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor9") < 0, " class='negativo'", "")%>><%=Format(drDato("valor9"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor10") < 0, " class='negativo'", "")%>><%=Format(drDato("valor10"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor11") < 0, " class='negativo'", "")%>><%=Format(drDato("valor11"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor12") < 0, " class='negativo'", "")%>><%=Format(drDato("valor12"), "###,###,##0")%></td>
                </tr>                 
<%    
Next
%>
                <tr class="filaTotales">
                    <td align="center" style="font-size:16px;width:215px;"><b><%=TranslateLocale.text("Validación para Gráfica")%></b></td>
                    <td colspan='12' align='center'>&nbsp;</td>
                </tr>
<%
    dtValidacion = dsReporte.Tables(4)
    For Each drDato As DataRow In dtValidacion.Rows
%>            

  
                <tr>
                    <td><%=TranslateLocale.text(drDato("descripcion"))%></td>
                    <td align="right"<%=IIf(drDato("valor1") < 0, " class='negativo'", "")%>><%=Format(drDato("valor1"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor2") < 0, " class='negativo'", "")%>><%=Format(drDato("valor2"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor3") < 0, " class='negativo'", "")%>><%=Format(drDato("valor3"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor4") < 0, " class='negativo'", "")%>><%=Format(drDato("valor4"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor5") < 0, " class='negativo'", "")%>><%=Format(drDato("valor5"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor6") < 0, " class='negativo'", "")%>><%=Format(drDato("valor6"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor7") < 0, " class='negativo'", "")%>><%=Format(drDato("valor7"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor8") < 0, " class='negativo'", "")%>><%=Format(drDato("valor8"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor9") < 0, " class='negativo'", "")%>><%=Format(drDato("valor9"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor10") < 0, " class='negativo'", "")%>><%=Format(drDato("valor10"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor11") < 0, " class='negativo'", "")%>><%=Format(drDato("valor11"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("valor12") < 0, " class='negativo'", "")%>><%=Format(drDato("valor12"), "###,###,##0")%></td>
                </tr>                 
<%    
Next
%>

            </table>
<%
    End If
%>
             

            <br /><br />
        </div>
    </form>
</body>
<script type="text/javascript">
    //window.print();
</script>
</html>

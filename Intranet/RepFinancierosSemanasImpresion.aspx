<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepFinancierosSemanasImpresion.aspx.vb" Inherits="Intranet.RepFinancierosSemanasImpresion" %>

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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="padding-left:20px">
            <br />
<%
    Dim columnas As Integer = 14
    Dim mes_actual As Integer = Request.QueryString("m")
    Dim mes_anterior As Integer
    mes_anterior = mes_actual - 1
    If mes_anterior = 0 Then mes_anterior = 12

    Dim dsReporte As DataSet = RecuperaDatosReporte()
    Dim dtDatos As DataTable = dsReporte.Tables(0)
    Dim dtMensaje As DataTable = dsReporte.Tables(1)
%>
            <table border="1" cellpadding="0" cellspacing="0">
                <tr class="filaHeader">
                    <td align="center" colspan="<%=columnas %>" style='font-size:20px;'><asp:Label ID="lblTituloReporte" runat="server"></asp:Label></td>
                </tr>
                <tr class="filaHeader">
                    <td align="center" colspan="<%=columnas %>" style='font-size:18px;'><%=NombreEmpresa() %> - <%= NombrePeriodo(Request.QueryString("m")) & " / " & Request.QueryString("a")%></td>
                </tr>
                <tr class="filaHeader">
                    <td align="center" style="font-size:17px;"><b>Plan<br /><%=NombrePeriodo(mes_actual)%></b></td>
                    <td align="center" style="font-size:17px;"><b>Real<br /><%=NombrePeriodo(mes_actual)%></b></td>
                    <td align="center" style="font-size:17px;"><b><%=TranslateLocale.text("Concepto")%></b></td>
<%
    For i As Integer = 1 To 5
        Response.Write("<td align='center' style='font-size:16px;'><b>" & TranslateLocale.text("Semana") & " " & i & "</b></td>")
    Next

    If columnas = 14 Then
%>
                    <td align="center" style="font-size:16px;"><b><%=TranslateLocale.text("Acumulado")%></b></td>
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
                    <td align="right"<%=IIf(drDato("monto_pron_mes_ant") < 0, " class='negativo'", "")%>><%=Format(drDato("monto_pron_mes_ant"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("monto_real_mes_ant") < 0, " class='negativo'", "")%>><%=Format(drDato("monto_real_mes_ant"), "###,###,##0")%></td>
                    <td><%=TranslateLocale.text(drDato("descripcion"))%></td>
                    <td align="right"<%=IIf(drDato("monto1") < 0, " class='negativo'", "")%>><%=Format(drDato("monto1"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("monto2") < 0, " class='negativo'", "")%>><%=Format(drDato("monto2"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("monto3") < 0, " class='negativo'", "")%>><%=Format(drDato("monto3"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("monto4") < 0, " class='negativo'", "")%>><%=Format(drDato("monto4"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("monto5") < 0, " class='negativo'", "")%>><%=Format(drDato("monto5"), "###,###,##0")%></td>
                    <td align="right"<%=IIf(drDato("monto_total") < 0, " class='negativo'", "")%>><%=Format(drDato("monto_total"), "###,###,##0")%></td>
                </tr>
<%
End If
Next
    
%>
            </table>

            <br />
            <div style="width:700px">
            <b><%=TranslateLocale.text("Comentarios a la Variacion del Prespuesto de Flujo")%>:</b>
                <hr />
            <br />
            <%
                If dtMensaje.Rows.Count > 0 Then
                    Response.Write(dtMensaje.Rows(0)("comentarios").ToString().Replace(vbCrLf,"<br />"))
                End If
                %>

            </div>

        </div>
    </form>
</body>
<script type="text/javascript">
    //window.print();
</script>
</html>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepVencimientoProximosImpresion.aspx.vb" Inherits="Intranet.RepVencimientoProximosImpresion" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Register TagPrefix="asp" Assembly="ExportToExcel" Namespace="KrishLabs.Web.Controls" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reporte</title>
	<link rel="stylesheet" type="text/css" href="/styles/styles.css" />

    <style type="text/css">
        body {
            font-family:Arial,Tahoma;
        }
        td {
            border-style:solid;
            border-color:#dedede;
            border-width:1px;
            padding-left:3px;
            padding-right:2px;
            font-size:11px;
        }
        .titulos td {
            font-size:12px;
        }

        .filaTotales {
            background-color:#bebdbd;
            font-weight:bold;
            font-size:13px;
        }
        a {
            color:#333333;
            text-decoration:none;
        }
            a:hover {
                text-decoration: underline;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="padding-left:10px; padding-right:10px;">
            <br />

            <table border="0" cellpadding="0" cellspacing="0"  width="1500px">
                <tr class="filaTotales">
                    <td align="left" style='font-size:18px;padding-left:20px;'><%=TranslateLocale.text("Reporte de Vencimiento Proximos")%></td>
                </tr>
                <tr>
                    <td align="left" style='font-size:15px;padding-left:50px;'><b><%=TranslateLocale.text("Filtros")%>:</b> <%=DefinicionParametros()%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvReporte" ExportFileName="VencimientosProximos.xls" Text="Exportar a Excel" IncludeTimeStamp="true" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir sin Formato" OnClientClick="window.print();" />
                    </td>
                </tr>
                <tr>
                    <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="true" width="900px" HeaderStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF">
                        <Columns>
                            <asp:BoundField HeaderText="Numero" DataField="numero" SortExpression="numero" />
                            <asp:BoundField HeaderText="Nombre" DataField="empleado" SortExpression="empleado" />
                            <asp:BoundField HeaderText="Fecha Otorgadas" DataField="fecha_otorgadas" SortExpression="fecha_otorgadas" DataFormatString="{0:dd/MM/yyyy}"/>
                            <asp:BoundField HeaderText="Dias Disp." DataField="disponibles" SortExpression="disponibles" />
                            <asp:BoundField HeaderText="Dias en Proceso" DataField="dias_proceso" SortExpression="dias_proceso" />
                            <asp:BoundField HeaderText="Proporcional" DataField="proporcional" SortExpression="proporcional" />
                            <asp:BoundField HeaderText="Saldo Final" DataField="saldo_final" SortExpression="saldo_final" />
                            <asp:BoundField HeaderText="Fecha de Vencimiento" DataField="fecha_vencimiento" SortExpression="fecha_vencimiento" DataFormatString="{0:dd/MM/yyyy}"/>
                        </Columns>
                    </asp:GridView>
                </tr>
            </table>


<%--
<%

    Dim columnas As Integer = 24
    Dim dsReporte As DataSet = RecuperaDatosReporte()
    Dim dtDatos As DataTable = dsReporte.Tables(0)
%>
            <table border="1" cellpadding="0" cellspacing="0" width="1500px">
                <tr class="filaTotales">
                    <td align="left" colspan="<%=columnas %>" style='font-size:18px;padding-left:20px;'>Reporte de Solicitudes de Vacaciones</td>
                </tr>
                <tr>
                    <td align="left" colspan="<%=columnas %>" style='font-size:15px;padding-left:50px;'><b>Filtros:</b> <%=DefinicionParametros()%></td>
                </tr>
                <tr class="filaTotales titulos" style='font-size:14px;'>
                    <td align="center"><b>Folio</b></td>
                    <td align="center"><b>Fecha de Solicitud</b></td>
                    <td align="center"><b>Solicitante</b></td>
                    <td align="center"><b>Empresa</b></td>
                    <td align="center"><b>Comentarios</b></td>
                    <td align="center"><b>Estatus</b></td>
                    <td align="center"><b>Dias</b></td>
                    <td align="center"><b>Fecha Ini</b></td>
                    <td align="center"><b>Fecha Fin</b></td>
                    <td align="center"><b>Nominas</b></td>
                    <td align="center"><b>Autoriza Jefe</b></td>
                    <td align="center"><b>Aut. por Jefe</b></td>
                </tr>
<%
    Dim i As Integer=0
    For Each drDato As DataRow In dtDatos.Rows
        i += 1
%>
                <tr <%=IIf(i Mod 2 = 0, "style='background-color:#FFFFFF;'", "")%>>
                    <td><%=drDato("folio")%></td>
                    <td align="center"><%=Format(drDato("fecha_solicitud"),"dd/MM/yyyy") %></td>
                    <td width="190px"><%=drDato("solicitante")%></td>
                    <td width="150px"><%=drDato("empresa")%></td>
                    <td width="250px"><%=drDato("comentarios")%></td>
                    <td width="190px"><%=drDato("estatus")%></td>
                    <td align="center"><%=drDato("dias")%></td>
                    <td align="center"><%=Format(drDato("fecha_ini"), "dd/MM/yyyy")%></td>
                    <td align="center"><%=Format(drDato("fecha_fin"), "dd/MM/yyyy")%></td>
                    <td width="190px"><%=drDato("empleado_nomina")%></td>
                    <td width="190px"><%=drDato("autorizacion_jefe")%></td>
                    <td width="100px"><%=drDato("solicitud_autorizada_jefe")%><%=ifNullEmptyFecha(drDato("fecha_autoriza_jefe"))%></td>
                </tr>
<%
Next
%>
            </table>--%>
            <br /><br /><br /><br />


        </div>
    </form>
</body>
<script type="text/javascript">
    //window.print();
</script>
</html>

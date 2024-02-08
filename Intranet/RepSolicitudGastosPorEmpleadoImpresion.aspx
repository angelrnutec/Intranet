<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepSolicitudGastosPorEmpleadoImpresion.aspx.vb" Inherits="Intranet.RepSolicitudGastosPorEmpleadoImpresion" %>

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

            <table border="0" cellpadding="0" cellspacing="0">
                <tr class="filaTotales">
                    <td align="left" style='font-size:18px;padding-left:20px;'><%=TranslateLocale.text("Rep. Solicitud de Gastos por Empleado")%></td>
                </tr>
                <tr>
                    <td align="left" style='font-size:15px;padding-left:50px;'><b><%=TranslateLocale.text("Filtros")%>:</b> <%=DefinicionParametros()%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvReporte" ExportFileName="GastosPorConceptoCC_.xls" Text="Exportar CC" IncludeTimeStamp="true" />
                        &nbsp;&nbsp;
                        <asp:ExportToExcel runat="server" ID="ExportToExcel2" GridViewID="gvReporteOI" ExportFileName="GastosPorConceptoOI_.xls" Text="Exportar OI" IncludeTimeStamp="true" />
                        &nbsp;&nbsp;
                        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir sin Formato" OnClientClick="window.print();" />
                    </td>
                </tr>
                <tr>
                    <td>
                    <br />
                    <asp:Label ID="lblReporteCC" runat="server" Text="Por Centros de Costo"></asp:Label>
                    <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="true" HeaderStyle-CssClass="filaTotales titulos" FooterStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF" ShowFooter="true" Width="1100px">
                        <Columns>
                            <asp:BoundField HeaderText="Concepto" DataField="concepto" SortExpression="concepto" ItemStyle-Width="250px" />
                            <asp:BoundField HeaderText="Cuenta Contable" DataField="cuenta_contable" SortExpression="cuenta_contable" ItemStyle-Width="80px" />
                            <asp:BoundField HeaderText="Ene" DataField="mes1" SortExpression="mes1" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Feb" DataField="mes2" SortExpression="mes2" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Mar" DataField="mes3" SortExpression="mes3" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Abr" DataField="mes4" SortExpression="mes4" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="May" DataField="mes5" SortExpression="mes5" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Jun" DataField="mes6" SortExpression="mes6" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Jul" DataField="mes7" SortExpression="mes7" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Ago" DataField="mes8" SortExpression="mes8" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Sep" DataField="mes9" SortExpression="mes9" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Oct" DataField="mes10" SortExpression="mes10" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Nov" DataField="mes11" SortExpression="mes11" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Dic" DataField="mes12" SortExpression="mes12" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Total" DataField="total" SortExpression="total" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                        </Columns>
                    </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td>
                    <br />
                    <asp:Label ID="lblReporteOI" runat="server" Text="Por Orden Interna"></asp:Label>
                    <asp:GridView ID="gvReporteOI" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="true" HeaderStyle-CssClass="filaTotales titulos" FooterStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF" ShowFooter="true" Width="1100px">
                        <Columns>
                            <asp:BoundField HeaderText="Concepto" DataField="concepto" SortExpression="concepto" ItemStyle-Width="250px" />
                            <asp:BoundField HeaderText="Cuenta Contable" DataField="cuenta_contable" SortExpression="cuenta_contable" ItemStyle-Width="80px" />
                            <asp:BoundField HeaderText="Ene" DataField="mes1" SortExpression="mes1" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Feb" DataField="mes2" SortExpression="mes2" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Mar" DataField="mes3" SortExpression="mes3" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Abr" DataField="mes4" SortExpression="mes4" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="May" DataField="mes5" SortExpression="mes5" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Jun" DataField="mes6" SortExpression="mes6" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Jul" DataField="mes7" SortExpression="mes7" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Ago" DataField="mes8" SortExpression="mes8" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Sep" DataField="mes9" SortExpression="mes9" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Oct" DataField="mes10" SortExpression="mes10" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Nov" DataField="mes11" SortExpression="mes11" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Dic" DataField="mes12" SortExpression="mes12" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Total" DataField="total" SortExpression="total" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right"/>
                        </Columns>
                    </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td>
                    <br />
                    <asp:GridView ID="gvReporteTot" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="false" HeaderStyle-CssClass="filaTotales titulos" FooterStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF" ShowFooter="false" Width="1100px">
                        <Columns>
                            <asp:BoundField HeaderText="Concepto" DataField="concepto" SortExpression="concepto" ItemStyle-Width="350px" />
                            <asp:BoundField HeaderText="Ene" DataField="mes1" SortExpression="mes1" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="true"/>
                            <asp:BoundField HeaderText="Feb" DataField="mes2" SortExpression="mes2" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="true"/>
                            <asp:BoundField HeaderText="Mar" DataField="mes3" SortExpression="mes3" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="true"/>
                            <asp:BoundField HeaderText="Abr" DataField="mes4" SortExpression="mes4" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="true"/>
                            <asp:BoundField HeaderText="May" DataField="mes5" SortExpression="mes5" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="true"/>
                            <asp:BoundField HeaderText="Jun" DataField="mes6" SortExpression="mes6" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="true"/>
                            <asp:BoundField HeaderText="Jul" DataField="mes7" SortExpression="mes7" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="true"/>
                            <asp:BoundField HeaderText="Ago" DataField="mes8" SortExpression="mes8" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="true"/>
                            <asp:BoundField HeaderText="Sep" DataField="mes9" SortExpression="mes9" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="true"/>
                            <asp:BoundField HeaderText="Oct" DataField="mes10" SortExpression="mes10" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="true"/>
                            <asp:BoundField HeaderText="Nov" DataField="mes11" SortExpression="mes11" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="true"/>
                            <asp:BoundField HeaderText="Dic" DataField="mes12" SortExpression="mes12" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="true"/>
                            <asp:BoundField HeaderText="Total" DataField="total" SortExpression="total" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="right" FooterStyle-HorizontalAlign="Right" ItemStyle-Font-Bold="true"/>
                        </Columns>
                    </asp:GridView>
                    </td>
                </tr>
            </table>

            <br /><br /><br /><br />


        </div>
    </form>
</body>
<script type="text/javascript">
    //window.print();
</script>
</html>

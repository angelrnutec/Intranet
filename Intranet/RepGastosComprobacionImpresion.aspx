<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepGastosComprobacionImpresion.aspx.vb" Inherits="Intranet.RepGastosComprobacionImpresion" %>

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
        <div style="padding-left:10px">
            <br />

            <table border="0" cellpadding="0" cellspacing="0"  width="2000px">
                <tr class="filaTotales">
                    <td align="left" style='font-size:18px;padding-left:20px;'><%=TranslateLocale.text("Reporte de Comprobantes de Gastos")%></td>
                </tr>
                <tr>
                    <td align="left" style='font-size:15px;padding-left:50px;'><b><%=TranslateLocale.text("Filtros")%>:</b> <%=DefinicionParametros()%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvReporte" ExportFileName="ComprobacionGastos.xls" Text="Exportar a Excel" IncludeTimeStamp="true" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir sin Formato" OnClientClick="window.print();" />
                    </td>
                </tr>
                <tr>
                    <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="true" width="1950px" HeaderStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF">
                        <Columns>
                            <asp:BoundField HeaderText="Folio" DataField="folio" SortExpression="folio" />
                            <asp:BoundField HeaderText="Fecha folio" DataField="fecha_folio" SortExpression="fecha_folio" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField HeaderText="Viajero" DataField="viajero" SortExpression="viajero" ItemStyle-Width="190px" />
                            <asp:BoundField HeaderText="Empresa" DataField="empresa" SortExpression="empresa"  ItemStyle-Width="150px"/>
                            <asp:BoundField HeaderText="Estatus" DataField="estatus" SortExpression="estatus"  ItemStyle-Width="190px"/>
                            <asp:BoundField HeaderText="Fecha Comprobante" DataField="fecha_comprobante" SortExpression="fecha_comprobante" DataFormatString="{0:dd/MM/yyyy}" />

                            <asp:BoundField HeaderText="O.I./C.C." DataField="oi_cc" SortExpression="oi_cc" />
                            <asp:BoundField HeaderText="No. Nec." DataField="no_necesidad" SortExpression="no_necesidad" />

                            <asp:BoundField HeaderText="Concepto" DataField="concepto" SortExpression="concepto"  ItemStyle-Width="250px"/>
                            <asp:BoundField HeaderText="Observaciones" DataField="observaciones" SortExpression="observaciones"  ItemStyle-Width="250px"/>

                            <asp:BoundField HeaderText="F. Pago" DataField="forma_pago" SortExpression="forma_pago" />
                            <asp:BoundField HeaderText="Moneda" DataField="moneda" SortExpression="moneda" />

                            <asp:BoundField HeaderText="Subtotal" DataField="subtotal" SortExpression="subtotal"  DataFormatString="{0:###,###,##0.00}" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="IVA" DataField="iva" SortExpression="iva"  DataFormatString="{0:###,###,##0.00}" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Otros Imp" DataField="otros_impuestos" SortExpression="otros_impuestos"  DataFormatString="{0:###,###,##0.00}" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Total" DataField="total" SortExpression="total"  DataFormatString="{0:###,###,##0.00}" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="T.C." DataField="tipo_cambio" SortExpression="tipo_cambio"  DataFormatString="{0:###,###,##0.0000}" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Total MXP" DataField="total_mxp" SortExpression="total_mxp"  DataFormatString="{0:###,###,##0.00}" ItemStyle-HorizontalAlign="Right"/>
                            <asp:TemplateField HeaderText="Adjuntos" HeaderStyle-ForeColor="Black" SortExpression="adjuntos" ItemStyle-Width="120px">
                                <ItemTemplate>
                                    <div align="left" style="padding: 2px;">
                                        <%# Eval("adjuntos") %>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

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

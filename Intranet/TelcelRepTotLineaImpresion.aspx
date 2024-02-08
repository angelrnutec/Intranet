<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TelcelRepTotLineaImpresion.aspx.vb" Inherits="Intranet.TelcelRepTotLineaImpresion" %>
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
                    <td align="left" style='font-size:18px;padding-left:20px;'>Presentación de Totales por Línea</td>
                </tr>
                <tr>
                    <td align="left" style='font-size:15px;padding-left:50px;'><b>Filtros:</b> <%=DefinicionParametros()%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvReporte" ExportFileName="TelefoniaPorLinea_.xls" Text="Exportar a Excel" IncludeTimeStamp="true" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir sin Formato" OnClientClick="window.print();" />
                    </td>
                </tr>
                <tr>
                    <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="true" HeaderStyle-CssClass="filaTotales titulos" FooterStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF" ShowFooter="true">
                        <Columns>
                            <asp:BoundField HeaderText="Proveedor" DataField="proveedor" SortExpression="proveedor" />
                            <asp:BoundField HeaderText="Empresa" DataField="empresa" SortExpression="empresa" />
                            <asp:BoundField HeaderText="Empleado" DataField="empleado" SortExpression="empleado" ItemStyle-Wrap="false" />
                            <asp:BoundField HeaderText="Telefono" DataField="linea" SortExpression="linea" ItemStyle-Wrap="false" />
                            <asp:BoundField HeaderText="Ene $" DataField="monto_mes_01" SortExpression="monto_mes_01" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="60px" />
                            <asp:BoundField HeaderText="Ene %" DataField="porc_mes_01" SortExpression="porc_mes_01" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0%}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="45px" />

                            <asp:BoundField HeaderText="Feb $" DataField="monto_mes_02" SortExpression="monto_mes_02" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="60px" />
                            <asp:BoundField HeaderText="Feb %" DataField="porc_mes_02" SortExpression="porc_mes_02" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0%}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="45px"/>

                            <asp:BoundField HeaderText="Mar $" DataField="monto_mes_03" SortExpression="monto_mes_03" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="60px"/>
                            <asp:BoundField HeaderText="Mar %" DataField="porc_mes_03" SortExpression="porc_mes_03" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0%}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="45px"/>

                            <asp:BoundField HeaderText="Abr $" DataField="monto_mes_04" SortExpression="monto_mes_04" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="60px"/>
                            <asp:BoundField HeaderText="Abr %" DataField="porc_mes_04" SortExpression="porc_mes_04" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0%}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="45px"/>

                            <asp:BoundField HeaderText="May $" DataField="monto_mes_05" SortExpression="monto_mes_05" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="60px"/>
                            <asp:BoundField HeaderText="May %" DataField="porc_mes_05" SortExpression="porc_mes_05" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0%}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="45px"/>

                            <asp:BoundField HeaderText="Jun $" DataField="monto_mes_06" SortExpression="monto_mes_06" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="60px"/>
                            <asp:BoundField HeaderText="Jun %" DataField="porc_mes_06" SortExpression="porc_mes_06" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0%}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="45px"/>

                            <asp:BoundField HeaderText="Jul $" DataField="monto_mes_07" SortExpression="monto_mes_07" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="60px"/>
                            <asp:BoundField HeaderText="Jul %" DataField="porc_mes_07" SortExpression="porc_mes_07" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0%}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="45px"/>

                            <asp:BoundField HeaderText="Ago $" DataField="monto_mes_08" SortExpression="monto_mes_08" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="60px"/>
                            <asp:BoundField HeaderText="Ago %" DataField="porc_mes_08" SortExpression="porc_mes_08" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0%}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="45px"/>

                            <asp:BoundField HeaderText="Sep $" DataField="monto_mes_09" SortExpression="monto_mes_09" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="60px"/>
                            <asp:BoundField HeaderText="Sep %" DataField="porc_mes_09" SortExpression="porc_mes_09" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0%}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="45px"/>

                            <asp:BoundField HeaderText="Oct $" DataField="monto_mes_10" SortExpression="monto_mes_10" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="60px"/>
                            <asp:BoundField HeaderText="Oct %" DataField="porc_mes_10" SortExpression="porc_mes_10" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0%}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="45px"/>

                            <asp:BoundField HeaderText="Nov $" DataField="monto_mes_11" SortExpression="monto_mes_11" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="60px"/>
                            <asp:BoundField HeaderText="Nov %" DataField="porc_mes_11" SortExpression="porc_mes_11" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0%}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="45px"/>

                            <asp:BoundField HeaderText="Dic $" DataField="monto_mes_12" SortExpression="monto_mes_12" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="60px"/>
                            <asp:BoundField HeaderText="Dic %" DataField="porc_mes_12" SortExpression="porc_mes_12" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0%}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="45px"/>
                            <asp:BoundField HeaderText="Total" DataField="monto_total" SortExpression="monto_total" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Total %" DataField="porc_total" SortExpression="porc_total" ItemStyle-Wrap="false" DataFormatString="{0:#,###,##0%}"  ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="45px"/>

<%--                            <asp:TemplateField HeaderText="Ene" SortExpression="monto_mes_01" ItemStyle-Width="100px">
                                <ItemTemplate>
                                    <div style="width:50px;display:inline-block;text-align:right"><asp:Label ID="lblMes01" runat="server" Text='<%# Bind("monto_mes_01", "{0:#,###,##0}")%>'></asp:Label></div>
                                    <div style="width:40px;display:inline-block;text-align:right;font-style:italic;"><asp:Label ID="lblPorc01" runat="server" Text='<%# Bind("porc_mes_01", "{0:#,###,##0}")%>'></asp:Label>%</div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Feb" SortExpression="monto_mes_02" ItemStyle-Width="100px">
                                <ItemTemplate>
                                    <div style="width:50px;display:inline-block;text-align:right"><asp:Label ID="lblMes01" runat="server" Text='<%# Bind("monto_mes_02", "{0:#,###,##0}")%>'></asp:Label></div>
                                    <div style="width:40px;display:inline-block;text-align:right;font-style:italic;"><asp:Label ID="lblPorc01" runat="server" Text='<%# Bind("porc_mes_02", "{0:#,###,##0}")%>'></asp:Label>%</div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mar" SortExpression="monto_mes_03">
                                <ItemTemplate>
                                    <div style="width:50px;display:block;text-align:right"><asp:Label ID="lblMes01" runat="server" Text='<%# Bind("monto_mes_03", "{0:#,###,##0}")%>'></asp:Label></div>
                                    <div style="width:50px;display:block; text-align:right"><asp:Label ID="lblPorc01" runat="server" Text='<%# Bind("porc_mes_03", "{0:#,###,##0}")%>'></asp:Label></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Abr" SortExpression="monto_mes_04">
                                <ItemTemplate>
                                    <div style="width:50px;display:block;text-align:right"><asp:Label ID="lblMes01" runat="server" Text='<%# Bind("monto_mes_04", "{0:#,###,##0}")%>'></asp:Label></div>
                                    <div style="width:50px;display:block; text-align:right"><asp:Label ID="lblPorc01" runat="server" Text='<%# Bind("porc_mes_04", "{0:#,###,##0}")%>'></asp:Label></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="May" SortExpression="monto_mes_05">
                                <ItemTemplate>
                                    <div style="width:50px;display:block;text-align:right"><asp:Label ID="lblMes01" runat="server" Text='<%# Bind("monto_mes_05", "{0:#,###,##0}")%>'></asp:Label></div>
                                    <div style="width:50px;display:block; text-align:right"><asp:Label ID="lblPorc01" runat="server" Text='<%# Bind("porc_mes_05", "{0:#,###,##0}")%>'></asp:Label></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Jun" SortExpression="monto_mes_06">
                                <ItemTemplate>
                                    <div style="width:50px;display:block;text-align:right"><asp:Label ID="lblMes01" runat="server" Text='<%# Bind("monto_mes_06", "{0:#,###,##0}")%>'></asp:Label></div>
                                    <div style="width:50px;display:block; text-align:right"><asp:Label ID="lblPorc01" runat="server" Text='<%# Bind("porc_mes_06", "{0:#,###,##0}")%>'></asp:Label></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Jul" SortExpression="monto_mes_07">
                                <ItemTemplate>
                                    <div style="width:50px;display:block;text-align:right"><asp:Label ID="lblMes01" runat="server" Text='<%# Bind("monto_mes_07", "{0:#,###,##0}")%>'></asp:Label></div>
                                    <div style="width:50px;display:block; text-align:right"><asp:Label ID="lblPorc01" runat="server" Text='<%# Bind("porc_mes_07", "{0:#,###,##0}")%>'></asp:Label></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Ago" SortExpression="monto_mes_08">
                                <ItemTemplate>
                                    <div style="width:50px;display:block;text-align:right"><asp:Label ID="lblMes01" runat="server" Text='<%# Bind("monto_mes_08", "{0:#,###,##0}")%>'></asp:Label></div>
                                    <div style="width:50px;display:block; text-align:right"><asp:Label ID="lblPorc01" runat="server" Text='<%# Bind("porc_mes_08", "{0:#,###,##0}")%>'></asp:Label></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Sep" SortExpression="monto_mes_09">
                                <ItemTemplate>
                                    <div style="width:50px;display:block;text-align:right"><asp:Label ID="lblMes01" runat="server" Text='<%# Bind("monto_mes_09", "{0:#,###,##0}")%>'></asp:Label></div>
                                    <div style="width:50px;display:block; text-align:right"><asp:Label ID="lblPorc01" runat="server" Text='<%# Bind("porc_mes_09", "{0:#,###,##0}")%>'></asp:Label></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Oct" SortExpression="monto_mes_10">
                                <ItemTemplate>
                                    <div style="width:50px;display:block;text-align:right"><asp:Label ID="lblMes01" runat="server" Text='<%# Bind("monto_mes_10", "{0:#,###,##0}")%>'></asp:Label></div>
                                    <div style="width:50px;display:block; text-align:right"><asp:Label ID="lblPorc01" runat="server" Text='<%# Bind("porc_mes_10", "{0:#,###,##0}")%>'></asp:Label></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Nov" SortExpression="monto_mes_11">
                                <ItemTemplate>
                                    <div style="width:50px;display:block;text-align:right"><asp:Label ID="lblMes01" runat="server" Text='<%# Bind("monto_mes_11", "{0:#,###,##0}")%>'></asp:Label></div>
                                    <div style="width:50px;display:block; text-align:right"><asp:Label ID="lblPorc01" runat="server" Text='<%# Bind("porc_mes_11", "{0:#,###,##0}")%>'></asp:Label></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dic" SortExpression="monto_mes_12">
                                <ItemTemplate>
                                    <div style="width:50px;display:block;text-align:right"><asp:Label ID="lblMes01" runat="server" Text='<%# Bind("monto_mes_12", "{0:#,###,##0}")%>'></asp:Label></div>
                                    <div style="width:50px;display:block; text-align:right"><asp:Label ID="lblPorc01" runat="server" Text='<%# Bind("porc_mes_12", "{0:#,###,##0}")%>'></asp:Label></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Total" SortExpression="monto_total">
                                <ItemTemplate>
                                    <div style="width:50px;display:block;text-align:right"><asp:Label ID="lblMes01" runat="server" Text='<%# Bind("monto_total", "{0:#,###,##0}")%>'></asp:Label></div>
                                </ItemTemplate>
                            </asp:TemplateField>--%>

                        </Columns>
                    </asp:GridView>
                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*El periodo del reporte corresponde al mes en que los consumos se realizaron.
                    <br />
                    <br />
                    <br />
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

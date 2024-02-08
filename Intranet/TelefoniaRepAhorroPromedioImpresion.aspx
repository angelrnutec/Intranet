<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TelefoniaRepAhorroPromedioImpresion.aspx.vb" Inherits="Intranet.TelefoniaRepAhorroPromedioImpresion" %>
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
                    <td align="left" style='font-size:18px;padding-left:20px;'>Presentación Ahorro Promedio</td>
                </tr>
                <tr>
                    <td align="left" style='font-size:15px;padding-left:50px;'><b>Filtros:</b> <%=DefinicionParametros()%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvReporte" ExportFileName="AhorroPromedio_.xls" Text="Exportar a Excel" IncludeTimeStamp="true" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir sin Formato" OnClientClick="window.print();" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="true" HeaderStyle-CssClass="filaTotales titulos" FooterStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF" ShowFooter="true">
                            <Columns>
                                <asp:BoundField HeaderText="Proveedor" DataField="proveedor" SortExpression="proveedor" ItemStyle-Wrap="false" />
                                <asp:BoundField HeaderText="Empresa" DataField="empresa" SortExpression="empresa" ItemStyle-Wrap="false" />
                                <asp:BoundField HeaderText="Ene" DataField="mes_01" SortExpression="mes_01" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Feb" DataField="mes_02" SortExpression="mes_02" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Mar" DataField="mes_03" SortExpression="mes_03" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Abr" DataField="mes_04" SortExpression="mes_04" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="May" DataField="mes_05" SortExpression="mes_05" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Jun" DataField="mes_06" SortExpression="mes_06" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Jul" DataField="mes_07" SortExpression="mes_07" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Ago" DataField="mes_08" SortExpression="mes_08" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Sep" DataField="mes_09" SortExpression="mes_09" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Oct" DataField="mes_10" SortExpression="mes_10" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Nov" DataField="mes_11" SortExpression="mes_11" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Dic" DataField="mes_12" SortExpression="mes_12" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Total" DataField="total" SortExpression="total" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Promedio" DataField="promedio" SortExpression="promedio" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Ahorro Mes Actual" DataField="ahorro" SortExpression="ahorro" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td><br />
                        <b>Periodo Enero - Diciembre <%=(Request.QueryString("anio") - 1)%></b>
                        <asp:GridView ID="gvResultados2" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="false" HeaderStyle-CssClass="filaTotales titulos" FooterStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF" ShowFooter="false">
                            <Columns>
                                <asp:TemplateField HeaderText="Empresa" SortExpression="empresa">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEmpresa" runat="server" Text='<%# Bind("empresa")%>'></asp:Label>
                                        <asp:Label ID="lblOrden" runat="server" Text='<%# Bind("orden")%>' Visible="false"></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField HeaderText="Ene" DataField="mes_01" SortExpression="mes_01" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Feb" DataField="mes_02" SortExpression="mes_02" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Mar" DataField="mes_03" SortExpression="mes_03" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Abr" DataField="mes_04" SortExpression="mes_04" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="May" DataField="mes_05" SortExpression="mes_05" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Jun" DataField="mes_06" SortExpression="mes_06" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Jul" DataField="mes_07" SortExpression="mes_07" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Ago" DataField="mes_08" SortExpression="mes_08" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Sep" DataField="mes_09" SortExpression="mes_09" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Oct" DataField="mes_10" SortExpression="mes_10" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Nov" DataField="mes_11" SortExpression="mes_11" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Dic" DataField="mes_12" SortExpression="mes_12" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                                <asp:BoundField HeaderText="Total" DataField="total" SortExpression="total" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" ItemStyle-Width="50px" />
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
            </table>
                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*El periodo del reporte corresponde al mes en que los consumos se realizaron.
                    <br />
                    <br />
                    <br />
                    <br />



        </div>
    </form>
</body>
<script type="text/javascript">
    //window.print();
</script>
</html>

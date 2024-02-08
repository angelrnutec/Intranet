<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepGastosNSCentroCostoImpresion.aspx.vb" Inherits="Intranet.RepGastosNSCentroCostoImpresion" %>
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
            font-size:12px;
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
                    <td align="left" style='font-size:18px;padding-left:20px;'>Reporte de Gastos NBR por Centro de Costo</td>
                </tr>
                <tr>
                    <td align="left" style='font-size:15px;padding-left:50px;'><b>Filtros:</b> <%=DefinicionParametros()%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvReporte" ExportFileName="RepGastosNSCentroCosto.xls" Text="Exportar a Excel" IncludeTimeStamp="true" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir sin Formato" OnClientClick="window.print();" />
                    </td>
                </tr>
                <tr>
                    <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="false" HeaderStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF">
                        <Columns>
                            <asp:BoundField HeaderText="Centro de Costo" DataField="centro_costo" SortExpression="periodo_desc"  ItemStyle-Width="200px"/>
                            <asp:TemplateField HeaderText="Negocio" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="150px">
                                <ItemTemplate>
                                    <asp:Label ID="lblNegocio" runat="server" Text='<%#Bind("negocio", "{0:#,###,###,###}")%>'></asp:Label>
                                    <asp:Label ID="lblTipo" runat="server" Text='<%#Bind("tipo")%>' Visible="false"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Por Negocio" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="150px">
                                <ItemTemplate>
                                    <asp:Label ID="lblPorNegocio" runat="server" Text='<%#Bind("por_negocio", "{0:#,###,###,###}")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Board Expense" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="150px">
                                <ItemTemplate>
                                    <asp:Label ID="lblBE" runat="server" Text='<%#Bind("board_expense", "{0:#,###,###,###}")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>

                </tr>
            </table>
            <asp:Label ID="lblNoRecords" runat="server" Visible="false" Text="No se encontraron registros para la busqueda realizada"></asp:Label>

            <br /><br /><br /><br />

            <asp:TextBox ID="txtMes" runat="server" Visible="false" Text="1"></asp:TextBox>
        </div>
    </form>
</body>

</html>

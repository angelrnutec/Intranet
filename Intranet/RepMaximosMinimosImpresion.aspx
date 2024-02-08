<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepMaximosMinimosImpresion.aspx.vb" Inherits="Intranet.RepMaximosMinimosImpresion" %>

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
            font-size:12px;
        }
        .titulos td {
            font-size:12px;
        }

        .filaTotales {
            background-color:#9de7d7;
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
        body {
            background-image: none !important;
            background-color: #fff;
            font-family: Arial !important;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="padding-left:10px; padding-right:10px;">
            <br />

            <table border="0" cellpadding="0" cellspacing="0" Width="850px">
                <tr class="filaTotales">
                    <td align="left" style='font-size:18px;padding-left:20px;'><%=TranslateLocale.text("Reporte de Máximos y Mínimos")%></td>
                </tr>
                <tr>
                    <td align="left" style='font-size:15px;padding-left:50px;'><b><%=TranslateLocale.text("Filtros")%>:</b> <%=DefinicionParametros()%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvReporte" ExportFileName="MaximosMinimos.xls" Text="Exportar a Excel" IncludeTimeStamp="true" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir sin Formato" OnClientClick="window.print();" />
                    </td>
                </tr>
                <tr>
                    <td>
                    <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="false" HeaderStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF" Width="100%">
                        <Columns>
                            <asp:BoundField HeaderText="Descripcion" DataField="periodo_desc" SortExpression="periodo_desc" />
                            <asp:TemplateField HeaderText="Pedidos" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <asp:Label ID="lblPedidosDesc" runat="server" Text='<%#Bind("desc1")%>'></asp:Label>
                                    <asp:Label ID="lblPedidos" runat="server" Text='<%#Bind("pedidos", "{0:#,###,###,###}")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Facturación" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <asp:Label ID="lblPedidosDesc" runat="server" Text='<%#Bind("desc2")%>'></asp:Label>
                                    <asp:Label ID="lblPedidos" runat="server" Text='<%#Bind("facturacion", "{0:#,###,###,###}")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Utilidad de Operación" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <asp:Label ID="lblPedidosDesc" runat="server" Text='<%#Bind("desc3")%>'></asp:Label>
                                    <asp:Label ID="lblPedidos" runat="server" Text='<%#Bind("util_opera", "{0:#,###,###,###}")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Utilidad Neta" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <asp:Label ID="lblPedidosDesc" runat="server" Text='<%#Bind("desc4")%>'></asp:Label>
                                    <asp:Label ID="lblPedidos" runat="server" Text='<%#Bind("util_neta", "{0:#,###,###,###}")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Saldo en Bancos" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <asp:Label ID="lblPedidosDesc" runat="server" Text='<%#Bind("desc5")%>'></asp:Label>
                                    <asp:Label ID="lblPedidos" runat="server" Text='<%#Bind("saldo_bancos", "{0:#,###,###,###}")%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    </td>
                </tr>
            </table>
            <asp:Label ID="lblNoRecords" runat="server" Visible="false" Text="No se encontraron registros para la busqueda realizada"></asp:Label>

            <br /><br /><br /><br />


        </div>
    </form>
</body>

</html>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepGastosNSCuentaAcumImpresion.aspx.vb" Inherits="Intranet.RepGastosNSCuentaAcumImpresion" %>
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
                    <td align="left" style='font-size:18px;padding-left:20px;'>Reporte de Gastos NBR por Cuenta Acumulado</td>
                </tr>
                <tr>
                    <td align="left" style='font-size:15px;padding-left:50px;'><b>Filtros:</b> <%=DefinicionParametros()%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvReporte" ExportFileName="RepGastosNSCuentaAcum.xls" Text="Exportar a Excel" IncludeTimeStamp="true" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir sin Formato" OnClientClick="window.print();" />
                    </td>
                </tr>
                <tr>
                    <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="true" HeaderStyle-CssClass="filaTotales titulos" FooterStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF" Width="780px" ShowFooter="true">
                        <Columns>
                            <asp:BoundField HeaderText="Descripcion" DataField="descripcion" SortExpression="descripcion" ItemStyle-Width="200px"/>
                            <asp:BoundField HeaderText="BE GCB" DataField="BEGCB" SortExpression="BEGCB" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="BE GFC" DataField="BEGFC" SortExpression="BEGFC" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="CECAP" DataField="CECAP" SortExpression="CECAP" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="DG GCB" DataField="DGGCB" SortExpression="DGGCB" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="DG GFC" DataField="DGGFC" SortExpression="DGGFC" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="HELICOPTERO" DataField="HELICOPTERO" SortExpression="HELICOPTERO" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="BE CCD" DataField="BECCD" SortExpression="BECCD" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="BE ZCD" DataField="BEZCD" SortExpression="BEZCD" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="TOTAL" DataField="total" SortExpression="total" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
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

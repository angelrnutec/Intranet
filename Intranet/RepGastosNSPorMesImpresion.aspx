<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepGastosNSPorMesImpresion.aspx.vb" Inherits="Intranet.RepGastosNSPorMesImpresion" %>
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
                    <td align="left" style='font-size:18px;padding-left:20px;'>Reporte de Gastos NS por Mes</td>
                </tr>
                <tr>
                    <td align="left" style='font-size:15px;padding-left:50px;'><b>Filtros:</b> <%=DefinicionParametros()%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvReporte" ExportFileName="RepGastosNSPorMes.xls" Text="Exportar a Excel" IncludeTimeStamp="true" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir sin Formato" OnClientClick="window.print();" />
                    </td>
                </tr>
                <tr>
                    <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="true" HeaderStyle-CssClass="filaTotales titulos" FooterStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF" Width="780px" ShowFooter="true">
                        <Columns>
                            <asp:BoundField HeaderText="Descripcion" DataField="descripcion" SortExpression="descripcion" ItemStyle-Width="200px"/>
                            <asp:BoundField HeaderText="Ene" DataField="mes_01" SortExpression="mes_01" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Feb" DataField="mes_02" SortExpression="mes_02" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Mar" DataField="mes_03" SortExpression="mes_03" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Abr" DataField="mes_04" SortExpression="mes_04" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="May" DataField="mes_05" SortExpression="mes_05" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Jun" DataField="mes_06" SortExpression="mes_06" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Jul" DataField="mes_07" SortExpression="mes_07" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Ago" DataField="mes_08" SortExpression="mes_08" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Sep" DataField="mes_09" SortExpression="mes_09" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Oct" DataField="mes_10" SortExpression="mes_10" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Nov" DataField="mes_11" SortExpression="mes_11" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Dic" DataField="mes_12" SortExpression="mes_12" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Total" DataField="total" SortExpression="total" DataFormatString="{0:#,###,###,###}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"/>

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

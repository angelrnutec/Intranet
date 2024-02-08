<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepConciliacionVacacionesImpresion.aspx.vb" Inherits="Intranet.RepConciliacionVacacionesImpresion" %>

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
                    <td align="left" style='font-size:18px;padding-left:20px;'><%=TranslateLocale.text("Reporte de Conciliacion de Vacaciones - Eslabón")%></td>
                </tr>
                <tr>
                    <td align="left" style='font-size:15px;padding-left:50px;'><b><%=TranslateLocale.text("Filtros")%>:</b> <%=DefinicionParametros()%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvReporte" ExportFileName="ConciliacionVacaciones.xls" Text="Exportar a Excel" IncludeTimeStamp="true" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir sin Formato" OnClientClick="window.print();" />
                    </td>
                </tr>
                <tr>
                    <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="true" HeaderStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF">
                        <Columns>
                            <asp:BoundField HeaderText="Numero" DataField="numero" SortExpression="numero" />
                            <asp:BoundField HeaderText="Nombre" DataField="nombre" SortExpression="nombre" />
                            <asp:BoundField HeaderText="Fecha. Alta" DataField="fecha_alta" SortExpression="fecha_alta" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField HeaderText="Empresa" DataField="empresa" SortExpression="empresa" />
                            <asp:BoundField HeaderText="Departamento" DataField="departamento" SortExpression="departamento" />
                            <asp:BoundField HeaderText="Saldo Anterior" DataField="saldo_dias" SortExpression="saldo_dias" ItemStyle-HorizontalAlign="Center"/>
                            <asp:BoundField HeaderText="Dias en Proceso" DataField="dias_en_proceso" SortExpression="dias_en_proceso" ItemStyle-HorizontalAlign="Center"/>
                            <asp:BoundField HeaderText="Saldo Final" DataField="dias_final" SortExpression="dias_final" ItemStyle-HorizontalAlign="Center"/>
                            <asp:BoundField HeaderText="Saldo Eslabón" DataField="dias_eslabon" SortExpression="dias_eslabon" ItemStyle-HorizontalAlign="Center"/>
                            <asp:BoundField HeaderText="Dif vs Saldo Anterior" DataField="dias_diferencia_1" SortExpression="dias_diferencia_1" ItemStyle-HorizontalAlign="Center"/>
                            <asp:BoundField HeaderText="Dif vs Saldo Final" DataField="dias_diferencia_2" SortExpression="dias_diferencia_2" ItemStyle-HorizontalAlign="Center"/>
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

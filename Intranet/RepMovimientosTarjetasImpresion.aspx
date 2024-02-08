<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepMovimientosTarjetasImpresion.aspx.vb" Inherits="Intranet.RepMovimientosTarjetasImpresion" %>

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

            <table border="0" cellpadding="0" cellspacing="0"  width="2000px">
                <tr class="filaTotales">
                    <td align="left" style='font-size:18px;padding-left:20px;'><%=TranslateLocale.text("Reporte de Movimientos de Tarjetas")%></td>
                </tr>
                <tr>
                    <td align="left" style='font-size:15px;padding-left:50px;'><b><%=TranslateLocale.text("Filtros")%>:</b> <%=DefinicionParametros()%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvReporte" ExportFileName="MovimientosTarjetas.xls" Text="Exportar a Excel" IncludeTimeStamp="true" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir sin Formato" OnClientClick="window.print();" />
                    </td>
                </tr>
                <tr>
                    <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="true" width="2000px" HeaderStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF">
                        <Columns>
                            <asp:BoundField HeaderText="Tipo" DataField="tipo" SortExpression="tipo" />
                            <asp:BoundField HeaderText="Num. Empleado" DataField="num_empleado" SortExpression="num_empleado" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField HeaderText="Empleado" DataField="empleado" SortExpression="empleado" />
                            <asp:BoundField HeaderText="Empresa" DataField="empresa" SortExpression="empresa" />
                            <asp:BoundField HeaderText="Num. Tarjeta" DataField="tarjeta" SortExpression="tarjeta" />
                            <asp:BoundField HeaderText="Fecha de Movimiento" DataField="fecha_movimiento" SortExpression="fecha_movimiento" DataFormatString="{0:dd/MM/yyyy}"  ItemStyle-HorizontalAlign="Center"/>

                            <asp:BoundField HeaderText="Concepto" DataField="concepto" SortExpression="concepto"  />
                            <asp:BoundField HeaderText="Descripción" DataField="descripcion" SortExpression="descripcion"  />
                            <asp:BoundField HeaderText="Tipo Comercio" DataField="tipo_comercio" SortExpression="tipo_comercio"  />
                            <asp:BoundField HeaderText="Moneda" DataField="moneda_gasto" SortExpression="moneda_gasto" ItemStyle-HorizontalAlign="Center"/>
                            <asp:BoundField HeaderText="Importe" DataField="importe_gasto" SortExpression="importe_gasto" DataFormatString="{0:#,###,##0.00}"  ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Tipo de Cambio" DataField="tipo_cambio" SortExpression="tipo_cambio" DataFormatString="{0:#,###,##0.0000}" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Importe MXN" DataField="importe_pesos" SortExpression="importe_pesos" DataFormatString="{0:#,###,##0.00}"  ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Comprobado" DataField="comprobado" SortExpression="comprobado" ItemStyle-HorizontalAlign="Center"/>
                            <asp:BoundField HeaderText="Fecha de Importación" DataField="fecha_registro" SortExpression="fecha_registro" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-HorizontalAlign="Center" />
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

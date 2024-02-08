<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepGastosViajeImpresion.aspx.vb" Inherits="Intranet.RepGastosViajeImpresion" %>

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

            <table border="0" cellpadding="0" cellspacing="0"  width="2350px">
                <tr class="filaTotales">
                    <td align="left" style='font-size:18px;padding-left:20px;'><%=TranslateLocale.text("Reporte de Gastos de Viaje")%></td>
                </tr>
                <tr>
                    <td align="left" style='font-size:15px;padding-left:50px;'><b><%=TranslateLocale.text("Filtros")%>:</b> <%=DefinicionParametros()%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvReporte" ExportFileName="SolicitudesGastosViaje.xls" Text="Exportar a Excel" IncludeTimeStamp="true" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir sin Formato" OnClientClick="window.print();" />
                    </td>
                </tr>
                <tr>
                    <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="true" width="2350px" HeaderStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF">
                        <Columns>
                            <asp:BoundField HeaderText="Folio" DataField="folio" SortExpression="folio" />
                            <asp:BoundField HeaderText="Fecha de Solicitud" DataField="fecha_solicitud" SortExpression="fecha_solicitud" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField HeaderText="Solicitante" DataField="solicitante" SortExpression="solicitante" ItemStyle-Width="190px" />
                            <asp:BoundField HeaderText="Empresa" DataField="empresa" SortExpression="empresa"  ItemStyle-Width="150px"/>
                            <asp:BoundField HeaderText="Departamento" DataField="departamento" SortExpression="departamento" />

                            <asp:BoundField HeaderText="Destino" DataField="destino" SortExpression="destino" ItemStyle-Width="180px" />
                            <asp:BoundField HeaderText="Motivo" DataField="motivo" SortExpression="motivo" ItemStyle-Width="250px" />
                            <asp:BoundField HeaderText="Monto MXP" DataField="monto_pesos" SortExpression="monto_pesos"  DataFormatString="{0:###,###,##0}"/>
                            <asp:BoundField HeaderText="Monto USD" DataField="monto_dolares" SortExpression="monto_dolares" DataFormatString="{0:###,###,##0}"/>
                            <asp:BoundField HeaderText="Monto EUR" DataField="monto_euros" SortExpression="monto_euros" DataFormatString="{0:###,###,##0}"/>
                            <asp:BoundField HeaderText="Total Anticipo MXP" DataField="anticipo" SortExpression="anticipo" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Total Viáticos MXP" DataField="viaticos" SortExpression="viaticos" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Total Compra Material MXP" DataField="materiales" SortExpression="materiales" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Saldo MXP" DataField="saldo" SortExpression="saldo" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Estatus" DataField="estatus" SortExpression="estatus"  ItemStyle-Width="190px"/>
                            <asp:BoundField HeaderText="Fecha Ini" DataField="fecha_ini" SortExpression="fecha_ini" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField HeaderText="Fecha Fin" DataField="fecha_fin" SortExpression="fecha_fin" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField HeaderText="Autoriza Jefe" DataField="autorizacion_jefe" SortExpression="autorizacion_jefe"  ItemStyle-Width="190px"/>
                            <asp:BoundField HeaderText="Autoriza Conta" DataField="autorizacion_conta" SortExpression="autorizacion_conta" ItemStyle-Width="190px" />


                            <asp:TemplateField HeaderText="Autorización Anticipo Jefe" SortExpression="solicitud_autorizada_jefe" ItemStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblAutPorJefe" runat="server" Text='<%#Eval("solicitud_autorizada_jefe") & ifNullEmptyFecha(Eval("fecha_autoriza_jefe"))%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Autorización Anticipo Conta" SortExpression="solicitud_autorizada_conta" ItemStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblAutPorConta" runat="server" Text='<%#Eval("solicitud_autorizada_conta") & ifNullEmptyFecha(Eval("fecha_autoriza_conta"))%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Autorización Comprobación Jefe" SortExpression="comprobacion_autorizada_jefe" ItemStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblCompPorJefe" runat="server" Text='<%#Eval("comprobacion_autorizada_jefe") & ifNullEmptyFecha(Eval("fecha_comprobacion_jefe"))%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Autorización Comprobación Conta" SortExpression="comprobacion_autorizada_conta" ItemStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblCompPorConta" runat="server" Text='<%#Eval("comprobacion_autorizada_conta") & ifNullEmptyFecha(Eval("fecha_comprobacion_conta"))%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="" DataField="cancelada" SortExpression="cancelada" ItemStyle-Width="90px" />
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

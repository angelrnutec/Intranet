<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SolicitudGastosImprimir.aspx.vb" Inherits="Intranet.SolicitudGastosImprimir" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Impresión</title>
	<link rel="stylesheet" type="text/css" href="/styles/styles.css" />

    <style type="text/css">
        body {
            font-family:Arial,Tahoma;
            font-size:11px;
        }
        .letrero_pendiente {
            font-size:13px;
            font-weight:bold;
        }

        .tabla_resumen table  {
            border-collapse: collapse;
        }

        .tabla_resumen table, .tabla_resumen th, .tabla_resumen td {
            border: 1px solid #888;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
        <asp:HiddenField ID="txtIdEmpresa" runat="server" Value="0" />
        <asp:HiddenField ID="txtIdSolicitud" runat="server" Value="0" />
        <asp:HiddenField ID="txtIdEmpleado" runat="server" Value="0" />

    <table cellpadding="0" cellspacing="0" border="0" width="800px">
        <tr>
            <td colspan="5">
                <span style="float:left;font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Reporte de Gastos de Viaje")%></span>
                <span style="float:right;padding-right:20px;">FR-AD-003 / 3</span><br /><br />
                <hr style="margin:0; padding:0;" />
            </td>
        </tr>
    </table>

    <br />
    <table width="800px">
        <tr>
            <td><b><%=TranslateLocale.text("Folio")%>:</b></td>
            <td colspan="4"><b><asp:Label ID="lblFolio" runat="server"></asp:Label></b>&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lblPendienteAuth" runat="server" Visible="false" Text=" (SOLICITUD PENDIENTE DE AUTORIZACIÓN)" CssClass="letrero_pendiente"></asp:Label>
            </td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Fecha de Solicitud")%>:</td>
            <td><asp:Label ID="lblFechaSolicitud" runat="server"></asp:Label></td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Solicitante")%>:</td>
            <td><asp:Label ID="lblSolicitante" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Empresa")%>:</td>
            <td><asp:Label ID="lblEmpresa" runat="server"></asp:Label></td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Viajero")%>:</td>
            <td><asp:Label ID="lblViajero" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Departamento")%>:</td>
            <td><asp:Label ID="lblDepartamento" runat="server"></asp:Label></td>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Fecha de Comprobación")%>:</td>
            <td><asp:Label ID="lblFechaComprobacion" runat="server"></asp:Label></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td colspan="2"><br />
                <b><%=TranslateLocale.text("Fechas")%>:</b><hr style="margin:0; padding:0;" />
            </td>
            <td colspan="3"><br />
                <b><%=TranslateLocale.text("Solicitud")%>:</b><hr style="margin:0; padding:0;" />
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <table cellpadding="0">
                    <tr>
                        <td><%=TranslateLocale.text("Fecha Ini")%>:&nbsp;</td>
                        <td><asp:Label ID="lblFechaIni" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Fecha Fin")%>:&nbsp;</td>
                        <td><asp:Label ID="lblFechaFin" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Dias de Viaje")%>:&nbsp;</td>
                        <td><asp:Label ID="diasViaje" runat="server"></asp:Label></td>
                    </tr>
                </table>
            </td>
            <td colspan="3">
                <table cellpadding="0">
                    <tr>
                        <td><%=TranslateLocale.text("Anticipo PESOS")%>:&nbsp;</td>
                        <td align="right"><asp:Label ID="lblMontoPesos" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Anticipo USD")%>:&nbsp;</td>
                        <td align="right"><asp:Label ID="lblMontoUSD" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Anticipo EUROS")%>:&nbsp;</td>
                        <td align="right"><asp:Label ID="lblMontoEuros" runat="server"></asp:Label></td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <br />

    <table cellpadding="0" cellspacing="0" border="0" width="800px">
        <tr>
            <td colspan="2"><span style="font-weight:bold;">Destino</span><hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td width="130px"><%=TranslateLocale.text("Destino")%>:</td>
            <td><asp:Label ID="lblDestino" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Motivo")%>:</td>
            <td><asp:Label ID="lblMotivo" runat="server"></asp:Label></td>
        </tr>
    </table>





    <br /><br />

    <div id="divSolicitudConMateriales" runat="server" visible="false">
        <table cellpadding="0" cellspacing="0" border="0" width="800px">
            <tr>
                <td>
                    <hr />
                    <div style="font-weight:bold;" class="link1">
                        <%=TranslateLocale.text("Esta solicitud de gastos de viaje esta ligada a una solicitud de reposición")%>
                         (<asp:Label ID="lblFolioSolicitudReposicion" runat="server"></asp:Label>)
                    </div>
                    <hr />
                    <br />
                </td>
            </tr>
        </table>
    </div>


    <div id="divComprobantes" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="800px">
            <tr>
                <td colspan="5"><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Comprobantes de Gastos")%></span><hr style="margin:0; padding:0;" /></td>
            </tr>
        </table>

        <br />
        <asp:GridView ID="gvConceptos" runat="server" CssClass="grid" Width="820px" PageSize="50" 
             AutoGenerateColumns="False" 
             AllowSorting="false" AllowPaging="false" ShowFooter="true">
             <HeaderStyle CssClass="grid_header" />
             <AlternatingRowStyle CssClass="grid_alternating" />
              <Columns>
                  <asp:BoundField HeaderText="Fecha" SortExpression="fecha_comprobante" DataField="fecha_comprobante" DataFormatString="{0:dd/MM/yyyy}" />
                  <asp:BoundField HeaderText="O.I./C.C." SortExpression="orden_interna" DataField="orden_interna" />
                  <asp:BoundField HeaderText="No. Nec." SortExpression="no_necesidad" DataField="no_necesidad" />
                  <asp:TemplateField HeaderText="Concepto" SortExpression="concepto">
                    <ItemTemplate>
                        <div>
                            <asp:Label ID="lblConcepto" runat="server" Text='<%# Eval("concepto")%>' />
                            <asp:Label ID="lblDesc" runat="server" Text='<%# Eval("descripcion_nb")%>' />
                        </div>
                    </ItemTemplate>
                  </asp:TemplateField>

                  <asp:TemplateField HeaderText="Observaciones" SortExpression="observaciones">
                    <ItemTemplate>
                        <div>
                            <asp:Label ID="lblObservaciones" runat="server" Text='<%# Eval("observaciones")%>' />
                            <br /><%=TranslateLocale.text("Num. Personas")%>: <asp:Label ID="lblNumPersonas" runat="server" Text='<%# Eval("num_personas")%>' />
                            <asp:Label ID="lblExcedioLimite" runat="server" style="color:red;font-weight:bold" Text='<%# Eval("excedio_limite")%>' />                            
                        </div>
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:BoundField HeaderText="F. Pago" SortExpression="forma_pago" DataField="forma_pago" />
                  <asp:BoundField HeaderText="Moneda" SortExpression="moneda" DataField="moneda" />
                  <asp:BoundField HeaderText="Subtotal" SortExpression="subtotal" DataField="subtotal" DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Right" />
                  <asp:BoundField HeaderText="IVA" SortExpression="iva" DataField="iva" DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Right" />
                  <asp:BoundField HeaderText="Otros Imp" SortExpression="otros_impuestos" DataField="otros_impuestos" DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Right" />
                  <asp:BoundField HeaderText="Propina" SortExpression="propina" DataField="propina" DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Right" />
                  <asp:BoundField HeaderText="Ret." SortExpression="retencion" DataField="retencion" DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Right" />
                  <asp:BoundField HeaderText="Ret. Resico" SortExpression="retencion_resico" DataField="retencion_resico" DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Right" />
                  <asp:BoundField HeaderText="T.C." SortExpression="tipo_cambio" DataField="tipo_cambio" DataFormatString="{0:###,##0.0000}" ItemStyle-HorizontalAlign="Right" />
                  <asp:BoundField HeaderText="Total" SortExpression="total" DataField="total" DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Right" />
                  <asp:BoundField HeaderText="Total MXN" SortExpression="total_pesos" DataField="total_pesos" DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Right" />
              </Columns>
        </asp:GridView>


    </div>



            <br /><br />

    <table cellpadding="0" cellspacing="0" border="0" width="820px">
        <tr valign="top">
            <td>


                <table cellpadding="0" cellspacing="0" border="0" width="260px">
                    <tr>
                        <td><span style="font-weight:bold;"><%=TranslateLocale.text("Historial de Autorizaciones")%></span><hr style="margin:0; padding:0;" /></td>
                    </tr>
                    <tr>
                        <td style="font-weight:bold;"><%=TranslateLocale.text("Autoriza Jefe (Anticipo)")%>:</td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblAutorizaJefe" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="font-weight:bold;"><%=TranslateLocale.text("Autoriza Conta (Anticipo)")%>:</td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblAutorizaConta" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="font-weight:bold;"><%=TranslateLocale.text("Autoriza Jefe (Comprobación)")%>:</td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblAutorizaJefeComprobacion" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="font-weight:bold;"><%=TranslateLocale.text("Autoriza Conta (Comprobación)")%>:</td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblAutorizaContaComprobacion" runat="server"></asp:Label></td>
                    </tr>
                </table>



            </td>
            <td>

                <div id="oculta1" runat="server">
                    <table cellpadding="2" cellspacing="0" border="0" width="100%" class="tabla_resumen" style="border-collapse:collapse;">
                        <tr style="font-weight:bold">
                            <td>&nbsp;</td>
                            <td align="center"><%=TranslateLocale.text("Efectivo")%></td>
                            <td align="center"><%=TranslateLocale.text("T. Crédito")%></td>
                            <td align="center" runat="server" id="tablaResumenColTE"><%=TranslateLocale.text("T. Débito (TE)")%></td>
                            <td align="center" runat="server" id="tablaResumenColCav"><%=TranslateLocale.text("CAV")%></td>
                            <td align="center"><%=TranslateLocale.text("Subtotal")%></td>
                            <td align="center"><%=TranslateLocale.text("IVA")%></td>
                            <td align="center"><%=TranslateLocale.text("Total")%></td>
                        </tr>
                        <asp:PlaceHolder ID="phResumenFormaPago" runat="server"></asp:PlaceHolder>
                    </table>
                    <br />
                    <table cellpadding="0" cellspacing="0" border="0" width="345px">
                        <tr style="display:none">
                            <td colspan="3"><span style="font-weight:bold;"><%=TranslateLocale.text("Resumen")%></span><hr style="margin:0; padding:0;" /></td>
                        </tr>
                        <tr style="background-color:#c7c5c5;display:none;">
                            <td><asp:Label ID="lblTotalConvertido" runat="server" Text="Total de Gastos Convertido a MXN"></asp:Label></td>
                            <td align="right"><asp:Label ID="lblTotalGastosConvPesos" runat="server"></asp:Label></td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                        <tr style="display:none">
                            <td><%=TranslateLocale.text("Gastos con Tarjeta de Crédito")%>:</td>
                            <td align="right"><asp:Label ID="lblGastosTC" runat="server"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr style="display:none">
                            <td><asp:Label ID="lblTotalGastos" runat="server" Text="Total de Gastos Convertido a MXN"></asp:Label>:</td>
                            <td align="right"><asp:Label ID="lblTotalGastosPesos" runat="server"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Dias de Viaje")%>:</td>
                            <td align="right"><asp:Label ID="lblDiasViaje" runat="server"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr style="background-color:#c7c5c5;">
                            <td><%=TranslateLocale.text("Gasto Diario Promedio")%>:</td>
                            <td align="right"><asp:Label ID="lblGastoDiarioPromedio" runat="server"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                    <table cellpadding="0" cellspacing="0" border="0" width="345px" style="display:none">
                        <tr>
                            <td colspan="3"><span style="font-weight:bold;"><%=TranslateLocale.text("Saldos")%></span><hr style="margin:0; padding:0;" /></td>
                        </tr>
                        <tr style="background-color:#c7c5c5;">
                            <td><asp:Label ID="lblAnticipo" runat="server" Text="Anticipo (MXP)"></asp:Label>:</td>
                            <td align="right"><asp:Label ID="lblSaldoAnticipo" runat="server"></asp:Label></td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblTotalViaticos" runat="server" Text="Total Viáticos (MXP)"></asp:Label>:</td>
                            <td align="right"><asp:Label ID="lblSaldoViaticos" runat="server"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr style="background-color:#c7c5c5;">
                            <td><asp:Label ID="lblTotalCompraMaterial" runat="server" Text="Total Compra Material (MXP)"></asp:Label>:</td>
                            <td align="right"><asp:Label ID="lblSaldoMateriales" runat="server"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblTotalAjustado" runat="server" Text="Importe Ajustado TE (MXP)"></asp:Label>:</td>
                            <td align="right"><asp:Label ID="lblSaldoAjustado" runat="server"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr style="background-color:#c7c5c5;">
                            <td><asp:Label ID="lblSaldoTexto" runat="server"></asp:Label>:</td>
                            <td align="right"><asp:Label ID="lblSaldoSaldo" runat="server"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                    <br />
                    <br />
                    <table id="tblTicketEmpresarial" runat="server" visible="false" cellpadding="0" cellspacing="0" border="0" width="345px">
                        <tr>
                            <td colspan="3"><span style="font-weight:bold;"><%=TranslateLocale.text("Resumen Tarjeta TE")%></span><hr style="margin:0; padding:0;" /></td>
                        </tr>
                        <tr style="background-color:#c7c5c5;">
                            <td><asp:Label ID="lblTESaldoInicialLabel" runat="server" Text="Saldo en TE antes de depositar anticipo"></asp:Label>:</td>
                            <td align="right"><asp:Label ID="lblTESaldoInicial" runat="server"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblTEAnticipoLabel" runat="server" Text="Anticipo depositado TE"></asp:Label>:</td>
                            <td align="right"><asp:Label ID="lblTEAnticipo" runat="server"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr style="background-color:#c7c5c5;">
                            <td><asp:Label ID="lblTERetirosLabel" runat="server" Text="Importe ajustado TE"></asp:Label>:</td>
                            <td align="right"><asp:Label ID="lblTERetiros" runat="server"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td><asp:Label ID="lblTESaldoFinalLabel" runat="server" Text="Saldo en TE después del ajuste"></asp:Label>:</td>
                            <td align="right"><asp:Label ID="lblTESaldoFinal" runat="server"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>

                    <asp:Button ID="btnRealizarRetiroTE" runat="server" Text="Realizar Retiro de TicketEmpresarial" style="margin-top:20px" Visible="false"  OnClientClick="this.disabled = true; this.value = 'Espere...';" UseSubmitBehavior="false"/>
                    <table id="tblRetiroTE" runat="server" visible="false" style="width:100%;margin-top:20px;">
                        <tr>
                            <td colspan="2" style="font-weight:bold">Realizar Retiro de Fondos de TicketEmpresarial</td>
                        </tr>
                        <tr>
                            <td>Saldo Actual:</td>
                            <td>
                                <asp:Label id="lblSaldoActualTE" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>Importe a retirar:</td>
                            <td>
                                <telerik:RadNumericTextBox ID="txtImporteRetiroTE" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0"></telerik:RadNumericTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Button ID="btnProcesarRetiroTE" runat="server" Text="Procesar Retiro" style="margin-top:10px"  OnClientClick="this.disabled = true; this.value = 'Espere...';" UseSubmitBehavior="false"/>
                            </td>
                            <td>
                                <asp:Button ID="btnCancelarRetiroTE" runat="server" Text="Cancelar Retiro" style="margin-top:10px"  OnClientClick="this.disabled = true; this.value = 'Espere...';" UseSubmitBehavior="false"/>
                            </td>
                        </tr>
                    </table>

                </div>


            </td>
        </tr>
    </table>

        <br />

    <div id="divPoliza" runat="server" visible="false">
        <table cellpadding="0" cellspacing="0" border="0" width="800px">
            <tr>
                <td colspan="5"><span id="spnTituloPoliza" runat="server" style="font-size:15px; font-weight:bold;">Vista previa de la póliza</span><hr style="margin:0; padding:0;" /></td>
            </tr>
        </table>

        <br />
        <asp:GridView ID="gvPoliza" runat="server" CssClass="grid" Width="790px" PageSize="50" 
             EmptyDataText="Favor de agregar tus comprobantes" AutoGenerateColumns="False" 
             AllowSorting="false" AllowPaging="false">
             <HeaderStyle CssClass="grid_header" />
             <AlternatingRowStyle CssClass="grid_alternating" />
              <Columns>
                  <asp:BoundField HeaderText="Concepto" SortExpression="concepto" DataField="concepto" />
                  <asp:BoundField HeaderText="Cuenta" SortExpression="cuenta" DataField="cuenta" />
                  <asp:BoundField HeaderText="Debe" SortExpression="debe" DataField="debe" DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Right" />
                  <asp:BoundField HeaderText="Haber" SortExpression="haber" DataField="haber" DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Right" />
              </Columns>
        </asp:GridView>


    </div>


        <br /><br />
    </form>
</body>
<%--<script type="text/javascript">
    window.print();
</script>--%>
</html>

﻿<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EnvioSolicitudGasto.aspx.vb" Inherits="Intranet.EnvioSolicitudGasto" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
</head>
<body>
    <form id="form1" runat="server">
        <asp:HiddenField ID="txtIdEmpresa" runat="server" Value="0" />
    <table width="600px">
        <tr>
            <td>
                <br />
                <%=TranslateLocale.text("Estimado(a)", EMAIL_LOCALE)%> &nbsp;<asp:Label ID="lblNombre" runat="server"></asp:Label>
            </td>
        </tr>        
        <tr>
            <td><br /><asp:Label ID="lblTitulo" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td align="center">
                <table width="90%">
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Folio", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblFolio" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" class="auto-style1"><%=TranslateLocale.text("Empleado Solicita", EMAIL_LOCALE)%>:</td>
                        <td align="left" class="auto-style2"><asp:Label ID="lblEmpleadoSolicita" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Empleado Viaja", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblEmpleadoViaja" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" class="auto-style1"><%=TranslateLocale.text("Autoriza Jefe", EMAIL_LOCALE)%>:</td>
                        <td align="left" class="auto-style2"><asp:Label ID="lblAutorizaJefe" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Autoriza Conta", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblAutorizaConta" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Empresa", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblEmpresa" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Departamento", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblDepartamento" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Fecha Inicio", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblFechaInicio" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Fecha Fin", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblFechaFin" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Destino", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblDestino" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Motivo", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblMotivo" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Monto Pesos", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblMontoPesos" runat="server"></asp:Label></td>
                    </tr>
                    <tr>                        
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Monto Dolares", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblMontoDolares" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Monto Euros", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblMontoEuro" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Estatus", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblEstatus" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="left" style="width:160px;">
                            <br />
                            <%=TranslateLocale.text("Acciones", EMAIL_LOCALE)%>: 
                            <a id="lnkAutoriza" runat="server" target="_blank"><%=TranslateLocale.text("Autorizar Solicitud", EMAIL_LOCALE)%></a>
                            &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
                            <a id="lnkRechaza" runat="server" target="_blank"><%=TranslateLocale.text("Rechazar Solicitud", EMAIL_LOCALE)%></a>
                            <br /><br />
                            <a id="lnkDetalle" runat="server" target="_blank"><%=TranslateLocale.text("Para ver sus tareas pendientes click aqui", EMAIL_LOCALE)%></a>
                            <br /><br />
                        </td>
                    </tr>
                </table>
                <br />
                <div id="divDetalleCombrobantes" runat="server" visible="false">
                    <%=TranslateLocale.text("Detalle de los comprobantes cargados por el empleado", EMAIL_LOCALE)%>:<br />
                    <asp:GridView ID="gvConceptos" runat="server" CssClass="grid" Width="820px" PageSize="99" AutoGenerateColumns="False" 
                         AllowSorting="false" AllowPaging="false">
                         <HeaderStyle CssClass="grid_header" />
                         <AlternatingRowStyle CssClass="grid_alternating" />
                          <Columns>
                              <asp:BoundField HeaderText="Fecha" SortExpression="fecha_comprobante" DataField="fecha_comprobante" DataFormatString="{0:dd/MM/yyyy}" />
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
                                        <br /><%=TranslateLocale.text("Num. Personas", EMAIL_LOCALE)%>: <asp:Label ID="lblNumPersonas" runat="server" Text='<%# Eval("num_personas")%>' />
                                        <asp:Label ID="lblExcedioLimite" runat="server" style="color:red;font-weight:bold" Text='<%# Eval("excedio_limite")%>' />                            
                                    </div>
                                </ItemTemplate>
                              </asp:TemplateField>
                              <asp:BoundField HeaderText="Moneda" SortExpression="moneda" DataField="moneda" />
                              <asp:BoundField HeaderText="Subtotal" SortExpression="subtotal" DataField="subtotal" DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Right" />
                              <asp:BoundField HeaderText="IVA" SortExpression="iva" DataField="iva" DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Right" />
                              <asp:BoundField HeaderText="Otros Imp" SortExpression="otros_impuestos" DataField="otros_impuestos" DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Right" />
                              <asp:BoundField HeaderText="Ret." SortExpression="retencion" DataField="retencion" DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Right" />
                              <asp:BoundField HeaderText="Ret. Resico" SortExpression="retencion_resico" DataField="retencion_resico" DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Right" />
                              <asp:BoundField HeaderText="Total" SortExpression="total" DataField="total" DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Right" />
                              <asp:BoundField HeaderText="T.C." SortExpression="tipo_cambio" DataField="tipo_cambio" DataFormatString="{0:###,##0.0000}" ItemStyle-HorizontalAlign="Right" />
                              <asp:BoundField HeaderText="Total MXP" SortExpression="total_mxp" DataField="total_mxp" DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Right" />
                              <asp:TemplateField HeaderText="Tipo Comprobante">
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblTipoComprobante" runat="server" Text='<%# Eval("info_comprobantes")%>' />
                                    </div>
                                </ItemTemplate>
                              </asp:TemplateField>
                          </Columns>
                    </asp:GridView>
                </div>
                <div id="divSaldos" runat="server" visible="false">
                    <br />
                    <table cellpadding="0" cellspacing="0" border="0" width="395px">
                        <tr>
                            <td colspan="3"><span style="font-weight:bold;"><%=TranslateLocale.text("Saldos", EMAIL_LOCALE)%></span><hr style="margin:0; padding:0;" /></td>
                        </tr>
                        <tr style="background-color:#c7c5c5;">
                            <td><%=TranslateLocale.text("Anticipo", EMAIL_LOCALE)%>:</td>
                            <td align="right"><asp:Label ID="lblSaldoAnticipo" runat="server"></asp:Label></td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Total Viáticos", EMAIL_LOCALE)%>:</td>
                            <td align="right"><asp:Label ID="lblSaldoViaticos" runat="server"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr style="background-color:#c7c5c5;">
                            <td><%=TranslateLocale.text("Total Compra Material", EMAIL_LOCALE)%>:</td>
                            <td align="right"><asp:Label ID="lblSaldoMateriales" runat="server"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Importe Ajustado TE (MXP)", EMAIL_LOCALE)%>:</td>
                            <td align="right"><asp:Label ID="lblSaldoAjustado" runat="server"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr style="background-color:#c7c5c5;">
                            <td><asp:Label ID="lblSaldoTexto" runat="server"></asp:Label>:</td>
                            <td align="right"><asp:Label ID="lblSaldoSaldo" runat="server"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>
                </div>
            </td>
        </tr>
    </table>   
        <asp:Label ID="lblId" runat="server" style="display:none;" Visible="false"></asp:Label>   
        <asp:Label ID="lblTipo" runat="server" style="display:none;" Visible="false"></asp:Label>   
    </form>
</body>
</html>

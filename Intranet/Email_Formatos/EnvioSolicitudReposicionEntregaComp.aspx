<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EnvioSolicitudReposicionEntregaComp.aspx.vb" Inherits="Intranet.EnvioSolicitudReposicionEntregaComp" %>

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
                <%=TranslateLocale.text("Estimado(a)", EMAIL_LOCALE)%>&nbsp;<asp:Label ID="lblNombre" runat="server"></asp:Label>
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
                        <td align="left" class="auto-style1"><%=TranslateLocale.text("Empleado Deudor", EMAIL_LOCALE)%>:</td>
                        <td align="left" class="auto-style2"><asp:Label ID="lblEmpleadoDeudor" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" class="auto-style1"><%=TranslateLocale.text("Autoriza Jefe", EMAIL_LOCALE)%>:</td>
                        <td align="left" class="auto-style2"><asp:Label ID="lblAutorizaJefe" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trAutorizaMateriales" runat="server" visible="false">
                        <td align="left" class="auto-style1"><%=TranslateLocale.text("Autoriza Materiales", EMAIL_LOCALE)%>:</td>
                        <td align="left" class="auto-style2"><asp:Label ID="lblAutorizaMateriales" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trAutorizaOperaciones" runat="server" visible="false">
                        <td align="left" class="auto-style1"><%=TranslateLocale.text("Autoriza Operaciones", EMAIL_LOCALE)%>:</td>
                        <td align="left" class="auto-style2"><asp:Label ID="lblAutorizaOperaciones" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trAutorizaComidasInternas" runat="server" visible="false">
                        <td align="left" class="auto-style1"><%=TranslateLocale.text("Autoriza Comidas Internas", EMAIL_LOCALE)%>:</td>
                        <td align="left" class="auto-style2"><asp:Label ID="lblAutorizaComidasInternas" runat="server"></asp:Label></td>
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
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Comentarios", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblComentarios" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Estatus", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblEstatus" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="left">
                            <table border="1" cellspacing="0" style="border-style:solid;width:200px">
                                <tr>
                                    <td colspan="2"><b><%=TranslateLocale.text("Total de las Partidas", EMAIL_LOCALE)%></b></td>
                                </tr>
                                <tr>
                                    <td><%=TranslateLocale.text("Pesos", EMAIL_LOCALE)%></td>
                                    <td align="right"><asp:Label ID="lblPesos" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td><%=TranslateLocale.text("Dolares", EMAIL_LOCALE)%></td>
                                    <td align="right"><asp:Label ID="lblDolares" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td><%=TranslateLocale.text("Euros", EMAIL_LOCALE)%></td>
                                    <td align="right"><asp:Label ID="lblEuros" runat="server"></asp:Label></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="left" style="width:160px;"><a id="lnkDetalle" runat="server" target="_blank"><%=TranslateLocale.text("Para ver sus tareas pendientes click aqui", EMAIL_LOCALE)%></a></td>
                    </tr>
                </table>
                <br />
                <div id="divDetalleCombrobantes" runat="server" visible="false">
                    <%=TranslateLocale.text("Detalle de los comprobantes cargados por el empleado", EMAIL_LOCALE)%>:<br />
                    <asp:GridView ID="gvConceptos" runat="server" CssClass="grid" Width="20px" PageSize="99" AutoGenerateColumns="False" 
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
                              <asp:BoundField HeaderText="Observaciones" SortExpression="observaciones" DataField="observaciones" ItemStyle-Width="100px" />
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
            </td>
        </tr>
    </table>   
        <asp:Label ID="lblId" runat="server" style="display:none;"></asp:Label>           
    </form>
</body>
</html>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SolicitudReposicionImprimir.aspx.vb" Inherits="Intranet.SolicitudReposicionImprimir" %>

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
                <asp:HiddenField ID="txtIdEmpresa" runat="server" Value="0" />

    <table cellpadding="0" cellspacing="0" border="0" width="800px">
        <tr>
            <td colspan="5">
                <span style="float:left;font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Reporte de Reposición de Gastos")%></span>
                <span style="float:right;padding-right:20px;">FR-AD-034</span><br /><br />
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
            <td><%=TranslateLocale.text("Deudor")%>:</td>
            <td><asp:Label ID="lblDeudor" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Fecha de Comprobación")%>:</td>
            <td><asp:Label ID="lblFechaComprobacion" runat="server"></asp:Label></td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Departamento")%>:</td>
            <td><asp:Label ID="lblDepartamento" runat="server"></asp:Label></td>
        </tr>
    </table>

    <br />

    <table cellpadding="0" cellspacing="0" border="0" width="800px">
        <tr>
            <td><span style="font-weight:bold;"><%=TranslateLocale.text("Comentarios")%></span><hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblComentarios" runat="server"></asp:Label></td>
        </tr>
    </table>





    <br /><br />

    <div id="divSolicitudConMateriales" runat="server" visible="false">
        <table cellpadding="0" cellspacing="0" border="0" width="800px">
            <tr>
                <td>
                    <hr />
                    <div style="font-weight:bold;" class="link1">
                        <%=TranslateLocale.text("Esta solicitud de reposición, esta ligada a una solicitud de gastos")%> (<asp:Label ID="lblFolioSolicitudGastos" runat="server"></asp:Label>)
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
             EmptyDataText="Favor de agregar tus comprobantes" AutoGenerateColumns="False" 
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
                  <asp:BoundField HeaderText="Observaciones" SortExpression="observaciones" DataField="observaciones" />
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
                        <td style="font-weight:bold;"><%=TranslateLocale.text("Autoriza Jefe")%>:</td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblAutorizaJefe" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td style="font-weight:bold;"><%=TranslateLocale.text("Autoriza Conta")%>:</td>
                    </tr>
                    <tr>
                        <td><asp:Label ID="lblAutorizaConta" runat="server"></asp:Label></td>
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
                    <table cellpadding="0" cellspacing="0" border="0" width="395px" style="display:none">
                        <tr>
                            <td colspan="3"><span style="font-weight:bold;"><%=TranslateLocale.text("Resumen")%></span><hr style="margin:0; padding:0;" /></td>
                        </tr>
                        <tr style="background-color:#c7c5c5;">
                            <td><asp:Label ID="lblTotalConvertido" runat="server" Text="Total de Gastos Convertido a MXN"></asp:Label> </td>
                            <td align="right"><asp:Label ID="lblTotalGastosConvPesos" runat="server"></asp:Label></td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Gastos con Tarjeta de Crédito")%>:</td>
                            <td align="right"><asp:Label ID="lblGastosTC" runat="server"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                        <tr style="background-color:#c7c5c5;">
                            <td><asp:Label ID="lblTotalGastos" runat="server" Text="Total de Gastos Convertido a MXN"></asp:Label>:</td>
                            <td align="right"><asp:Label ID="lblTotalGastosPesos" runat="server"></asp:Label></td>
                            <td>&nbsp;</td>
                        </tr>
                    </table>

                                        <br />
                    <br />
<%--                    <table cellpadding="0" cellspacing="0" border="0" width="395px">
                        <tr>
                            <td colspan="3"><span style="font-weight:bold;"><%=TranslateLocale.text("Resumen por Forma de Pago (MXP)")%></span><hr style="margin:0; padding:0;" /></td>
                        </tr>
                        <asp:PlaceHolder ID="" runat="server"></asp:PlaceHolder>
                    </table>--%>

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
<script type="text/javascript">
    window.print();
</script>
</html>

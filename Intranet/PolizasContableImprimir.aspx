<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PolizasContableImprimir.aspx.vb" Inherits="Intranet.PolizasContableImprimir" %>
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
    </style>
</head>
<body>
    <form id="form1" runat="server">

    <table cellpadding="0" cellspacing="0" border="0" width="800px">
        <tr>
            <td colspan="5">
                <span style="float:left;font-size:15px; font-weight:bold;">Poliza Contable enviada a SAP</span>
                
                <hr style="margin:0; padding:0;" />
            </td>
        </tr>
    </table>

    <br />
    <table width="800px">
        <tr>
            <td><b>Folio:</b></td>
            <td colspan="4"><b><asp:Label ID="lblFolio" runat="server"></asp:Label></b>&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Label ID="lblPendienteAuth" runat="server" Visible="false" Text=" (SOLICITUD PENDIENTE DE AUTORIZACIÓN)" CssClass="letrero_pendiente"></asp:Label>
            </td>
        </tr>
        <tr>
            <td>Fecha de Solicitud:</td>
            <td><asp:Label ID="lblFechaSolicitud" runat="server"></asp:Label></td>
            <td>&nbsp;</td>
            <td>Solicitante:</td>
            <td><asp:Label ID="lblSolicitante" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td>Empresa:</td>
            <td><asp:Label ID="lblEmpresa" runat="server"></asp:Label></td>
            <td>&nbsp;</td>
            <td>Viajero:</td>
            <td><asp:Label ID="lblViajero" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td>Departamento:</td>
            <td><asp:Label ID="lblDepartamento" runat="server"></asp:Label></td>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td>Fecha de Comprobación:</td>
            <td><asp:Label ID="lblFechaComprobacion" runat="server"></asp:Label></td>
            <td>&nbsp;</td>
            <td>Fecha de Envio a SAP:</td>
            <td><asp:Label ID="lblFechaEnvioSap" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td colspan="5">
                <table id="tblFechasYMontos" runat="server" cellpadding="0" cellspacing="0" border="0" width="100%">
                    <tr>
                        <td colspan="2"><br />
                            <b>Fechas:</b><hr style="margin:0; padding:0;" />
                        </td>
                        <td colspan="3"><br />
                            <b>Solicitud:</b><hr style="margin:0; padding:0;" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <table cellpadding="0">
                                <tr>
                                    <td>Fecha Ini:&nbsp;</td>
                                    <td><asp:Label ID="lblFechaIni" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Fecha Fin:&nbsp;</td>
                                    <td><asp:Label ID="lblFechaFin" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Dias de Viaje:&nbsp;</td>
                                    <td><asp:Label ID="diasViaje" runat="server"></asp:Label></td>
                                </tr>
                            </table>
                        </td>
                        <td colspan="3">
                            <table cellpadding="0">
                                <tr>
                                    <td>Anticipo PESOS:&nbsp;</td>
                                    <td align="right"><asp:Label ID="lblMontoPesos" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Anticipo USD:&nbsp;</td>
                                    <td align="right"><asp:Label ID="lblMontoUSD" runat="server"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td>Anticipo EUROS:&nbsp;</td>
                                    <td align="right"><asp:Label ID="lblMontoEuros" runat="server"></asp:Label></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>

    </table>

    <br />

    <table id="tblDestino" runat="server" cellpadding="0" cellspacing="0" border="0" width="800px">
        <tr>
            <td colspan="2"><span style="font-weight:bold;">Destino</span><hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td width="130px">Destino:</td>
            <td><asp:Label ID="lblDestino" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td>Motivo:</td>
            <td><asp:Label ID="lblMotivo" runat="server"></asp:Label></td>
        </tr>
    </table>

    <table id="tblComentarios" runat="server" cellpadding="0" cellspacing="0" border="0" width="800px">
        <tr>
            <td><span style="font-weight:bold;">Comentarios</span><hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td><asp:Label ID="lblComentarios" runat="server"></asp:Label></td>
        </tr>
    </table>

    <br /><br />

    <div id="divComprobantes" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="800px">
            <tr>
                <td colspan="5"><span style="font-size:15px; font-weight:bold;">Poliza Contable</span><hr style="margin:0; padding:0;" /></td>
            </tr>
        <tr>
            <td width="120px">Fecha de Documento:</td>
            <td aling="left"><asp:Label ID="lblFechaDocumento" runat="server"></asp:Label></td>
            <td>&nbsp;</td>
            <td width="80px">Sociedad:</td>
            <td aling="left"><asp:Label ID="lblSociedad" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td>Total MXP:</td>
            <td><asp:Label ID="lblTotal" runat="server"></asp:Label></td>
            <td>&nbsp;</td>
            <td>Referencia:</td>
            <td><asp:Label ID="lblReferencia" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td>Asignación:</td>
            <td><asp:Label ID="lblAsignacion" runat="server"></asp:Label></td>
            <td>&nbsp;</td>
            <td>Deudor:</td>
            <td><asp:Label ID="lblDeudor" runat="server"></asp:Label></td>
        </tr>
        </table>

        <br />
        <asp:GridView ID="gvPoliza" runat="server" CssClass="grid" Width="790px" PageSize="50" 
             EmptyDataText="Favor de agregar tus comprobantes" AutoGenerateColumns="False" 
             AllowSorting="false" AllowPaging="false">
             <HeaderStyle CssClass="grid_header" />
             <AlternatingRowStyle CssClass="grid_alternating" />
              <Columns>
                  <asp:BoundField HeaderText="# Cuenta" SortExpression="cuenta" DataField="cuenta" />                  
                  <asp:BoundField HeaderText="Clave IVA" SortExpression="clave_iva" DataField="clave_iva" />
                  <asp:BoundField HeaderText="Proyecto" SortExpression="proyecto" DataField="proyecto" />
                  <asp:BoundField HeaderText="Importe sin IVA" SortExpression="importe_sin_iva" DataField="importe_sin_iva" DataFormatString="{0:###,##0.00}" ItemStyle-HorizontalAlign="Right" />
                  <asp:BoundField HeaderText="Necesidad" SortExpression="no_necesidad" DataField="no_necesidad" />
                  <asp:BoundField HeaderText="Concepto" SortExpression="descripcion" DataField="descripcion" />                  
                  <asp:BoundField HeaderText="Descripción" SortExpression="asignacion" DataField="asignacion" />                  
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

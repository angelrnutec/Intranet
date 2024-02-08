<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="RepGastosNSCaptura.aspx.vb" Inherits="Intranet.RepGastosNSCaptura" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode != 46 && charCode != 45 && charCode > 31
              && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }

        function isNumber(o) {
            return !isNaN(o - 0) && o !== null && o !== "" && o !== false;
        }

    </script>
    

    <style type="text/css">
        .negativo {
            color: red;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table cellpadding="0" cellspacing="0" border="0" width="600px">
        <tr>
            <td><span style="font-size:15px; font-weight:bold;">Captura de Movimientos Financieros</span>
                <hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td>
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>Reporte:</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:DropDownList ID="ddlReporte" runat="server" Width="300px" onchange="ddlReporte_onchange(this.value)"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>A&ntilde;o:</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td colspan="3">
                            <asp:DropDownList ID="ddlAnio" runat="server" Width="105px"></asp:DropDownList>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            Mes:&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="ddlMes" runat="server" Width="120px"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" align="right">
                            <div style="height:7px"></div>
                            <asp:Button ID="btnContinuar" runat="server" Text="Continuar" OnClientClick="this.disabled = true; this.value = 'Guardando...';" UseSubmitBehavior="false" />&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnCancelar" runat="server" Text="Salir" />
                            <asp:TextBox ID="txtEstado" runat="server" Text="0" Visible="false"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                       <td colspan="5">
                           <asp:Label ID="lblMensajeEstatus" runat="server" style="font-size: 14px; font-weight: bold; color:red;"></asp:Label>
                       </td>
                    </tr>
                </table>

            </td>
        </tr>
        <tr>
            <td><br /><hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td>
                <div id="divCaptura" runat="server" visible="false">
                    <span style="font-size:14px; font-weight:bold;">Movimientos Reales por Concepto</span>
                
                    <asp:GridView ID="gvCaptura" runat="server" 
                                    AllowPaging="false" 
                                    AllowSorting="false" 
                                    AutoGenerateColumns="false"
                                    Width="600px">
                        <Columns>
                            <asp:BoundField HeaderText="Clave" DataField="clave" HeaderStyle-Font-Bold="true" Visible="false" />
                            <asp:BoundField HeaderText="Descripción" DataField="descripcion" HeaderStyle-Font-Bold="true" />
                            <asp:TemplateField HeaderText="Importe" HeaderStyle-Font-Bold="true" ItemStyle-Width="80px">
                                <ItemTemplate>
                                    <div style="padding-left:6px;">
                                        <asp:TextBox ID="txtIdConcepto" runat="server" Visible="false" Text='<%# Eval("id_concepto")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtImporte" runat="server" Text='<%# Eval("monto_dec")%>' Width="65px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                        <div id="divImporte" runat="server"><asp:Label ID="lblImporte" runat="server" Text='<%# Format(Eval("monto"),"###,###,##0")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto") < 0, "negativo", "")%>'></asp:Label></div>
                                        <asp:TextBox ID="txtPermiteCaptura" runat="server" Visible="false" Text='<%# Eval("permite_captura")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtEsSeparador" runat="server" Visible="false" Text='<%# Eval("es_separador")%>'></asp:TextBox>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                </div>
            </td>
        </tr>
    </table>
    <asp:TextBox ID="txtEstatus" runat="server" style="display:none;"></asp:TextBox>

</asp:Content>

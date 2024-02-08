<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="RepFinancierosBalanceAjustes.aspx.vb" Inherits="Intranet.RepFinancierosBalanceAjustes" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .reTool .YoutubeVideo
        {
          background-image: url(/images/youtube.gif);
        }

    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>


    <asp:Panel ID="pnlBusqueda" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="720px">
            <tr>
                <td colspan="5"><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Balance General (Ajustes)")%></span><hr style="margin:0; padding:0;" /></td>
            </tr>
        </table>
    </asp:Panel>
    <br />

    <table id="tblInicial" runat="server" cellpadding="0" cellspacing="0" border="0" width="720px">
        <tr>
            <td>
                <table>
                    <tr>
                        <td>&nbsp;&nbsp;&nbsp;<%=TranslateLocale.text("Año")%>:</td>
                        <td><asp:DropDownList ID="ddlAnio" runat="server" Width="80px"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td>&nbsp;&nbsp;&nbsp;<%=TranslateLocale.text("Periodo")%>:</td>
                        <td><asp:DropDownList ID="ddlPeriodo" runat="server" Width="80px"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="right">
                            <div style="height:7px"></div>
                            <asp:Button ID="btnContinuar" runat="server" Text="Continuar" OnClientClick="this.disabled = true; this.value = 'Guardando...';" UseSubmitBehavior="false" />&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnGuardar" Visible="false" runat="server" Text="Guardar" OnClientClick="this.disabled = true; this.value = 'Guardando...';" UseSubmitBehavior="false" />&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnActualizar" Visible="false" runat="server" Text="Calcular Totales" OnClientClick="this.disabled = true; this.value = 'Calculando...';" UseSubmitBehavior="false" />&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnCancelar" runat="server" Text="Salir" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>


    <table id="tblCapturaNormal" runat="server" cellpadding="0" cellspacing="0" border="0" width="1000px">
        <tr>
            <td>
                <br />
                <asp:GridView ID="gvCaptura" runat="server" 
                            AllowPaging="false" 
                            AllowSorting="false" 
                            AutoGenerateColumns="false">
                    <Columns>
                        <asp:BoundField HeaderText="Descripción" DataField="descripcion" HeaderStyle-Font-Bold="true" />
                        <asp:BoundField HeaderText="NB" DataField="monto1" HeaderStyle-Font-Bold="true" DataFormatString="{0:###,###,##0}" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="45" />
                        <asp:TemplateField HeaderText=" " HeaderStyle-Font-Bold="true" ItemStyle-Width="10px" ItemStyle-BackColor="LightGray">
                            <ItemTemplate><div>&nbsp;</div></ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="NE" DataField="monto2" HeaderStyle-Font-Bold="true" DataFormatString="{0:###,###,##0}" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="45" />
                        <asp:BoundField HeaderText="NP" DataField="monto3" HeaderStyle-Font-Bold="true" DataFormatString="{0:###,###,##0}" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="45" />
                        <asp:BoundField HeaderText="España" DataField="monto4" HeaderStyle-Font-Bold="true" DataFormatString="{0:###,###,##0}" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="45" />
                        <asp:BoundField HeaderText="NF" DataField="monto5" HeaderStyle-Font-Bold="true" DataFormatString="{0:###,###,##0}" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="45" />
                        <asp:BoundField HeaderText="NUSA" DataField="monto12" HeaderStyle-Font-Bold="true" DataFormatString="{0:###,###,##0}" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="45" />
                        <asp:BoundField HeaderText="NPC" DataField="monto13" HeaderStyle-Font-Bold="true" DataFormatString="{0:###,###,##0}" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="45" />

                        <asp:TemplateField HeaderText=" " HeaderStyle-Font-Bold="true" ItemStyle-Width="10px" ItemStyle-BackColor="LightGray">
                            <ItemTemplate><div>&nbsp;</div></ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="NS" DataField="monto6" HeaderStyle-Font-Bold="true" DataFormatString="{0:###,###,##0}" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="45" />
                        <asp:BoundField HeaderText="Suma" DataField="monto7" HeaderStyle-Font-Bold="true" DataFormatString="{0:###,###,##0}" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="45" />
                        <asp:BoundField HeaderText="GNU" DataField="monto8" HeaderStyle-Font-Bold="true" DataFormatString="{0:###,###,##0}" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="45" />
                        <asp:TemplateField HeaderText=" " HeaderStyle-Font-Bold="true" ItemStyle-Width="10px" ItemStyle-BackColor="LightGray">
                            <ItemTemplate><div>&nbsp;</div></ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Cargos" HeaderStyle-Font-Bold="true">
                            <ItemTemplate>
                                <div style="padding-left:6px;">
                                    <asp:TextBox ID="txtIdConcepto" runat="server" Visible="false" Text='<%# Eval("id_concepto")%>'></asp:TextBox>
                                    <asp:TextBox ID="txtCargos" runat="server" Text='<%# Eval("monto9")%>' Width="45px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                    <div id="divCargos" runat="server"><asp:Label ID="lblCargos" runat="server" Text='<%# Format(Eval("monto9"), "###,###,##0")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto9") < 0, "negativo", "")%>'></asp:Label></div>
                                    <asp:TextBox ID="txtPermiteCaptura" runat="server" Visible="false" Text='<%# Eval("permite_captura")%>'></asp:TextBox>
                                    <asp:TextBox ID="txtEsSeparador" runat="server" Visible="false" Text='<%# Eval("es_separador")%>'></asp:TextBox>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Créditos" HeaderStyle-Font-Bold="true">
                            <ItemTemplate>
                                <div style="padding-left:6px;">
                                    <asp:TextBox ID="txtCreditos" runat="server" Text='<%# Eval("monto10")%>' Width="45px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                    <div id="divCreditos" runat="server"><asp:Label ID="lblCreditos" runat="server" Text='<%# Format(Eval("monto10"), "###,###,##0")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto10") < 0, "negativo", "")%>'></asp:Label></div>
                                </div>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" " HeaderStyle-Font-Bold="true" ItemStyle-Width="10px" ItemStyle-BackColor="LightGray">
                            <ItemTemplate><div>&nbsp;</div></ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField HeaderText="Consolidado" DataField="monto11" HeaderStyle-Font-Bold="true" DataFormatString="{0:###,###,##0}" ItemStyle-HorizontalAlign="Right" ItemStyle-Width="45" />
                        <asp:BoundField HeaderText="%" DataField="monto_tot11" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Center" />
                    </Columns>
                </asp:GridView>

            </td>
        </tr>
    </table>
    <br />

    
</asp:Content>

<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ucEventos.ascx.vb" Inherits="Intranet.ucEventos" %>
<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<table border="0" cellpadding="0" cellspacing="0" width="210px">
    <tr><td width="4" height="4"><img src="/images/corner_top_left.png" /></td><td width="140px" background="/images/table_bak.png"></td><td width="4" height="4"><img src="/images/corner_top_right.png" /></td><td width="60px"></td><td width="4" height="4"></td></tr><tr><td background="/images/table_bak.png"></td><td background="/images/table_bak.png">&nbsp;&nbsp;<i class="icon-calendar icon-large"></i>&nbsp;&nbsp;<strong><%=TranslateLocale.text("Eventos")%></strong></td><td background="/images/table_bak.png"></td><td></td><td></td></tr><tr><td background="/images/table_bak.png"></td><td background="/images/table_bak.png"></td><td background="/images/table_bak.png"></td><td background="/images/table_bak.png"></td><td width="4" height="4"><img src="/images/corner_top_right.png" /></td></tr><tr><td background="/images/table_bak.png"></td>
        <td colspan="3" background="/images/table_bak.png">
            <div class="barra_der_contenido">
                <asp:ListView ID="lvEventos" runat="server">
                    <LayoutTemplate>
                        <div>
                            <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                        </div>
                    </LayoutTemplate>
                    <ItemTemplate>
                        	<div class="evento_fecha"><a href='/Ver.aspx?p=<%# Eval("id_texto") %>'><asp:Label ID="lblFecha" runat="server" Text='<%# Eval("fecha_evento") %>' /> / <asp:Label ID="Label1" runat="server" Text='<%# TranslateLocale.text(Eval("mes_evento"))%>' />&nbsp;<i class="icon-search icon-search"></i></a></div>
                        	<div class="evento_texto"><asp:Label id="lblDescCorta" runat="server" Text='<%# Eval("descripcion_corta") %>'></asp:Label></div>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <br /><br /><br />
                    </EmptyDataTemplate>
                    <ItemSeparatorTemplate>
                        <hr class="evento_separador" />
                    </ItemSeparatorTemplate>

                </asp:ListView>
                <br />
            </div>
        </td><td background="/images/table_bak.png"></td></tr><tr><td width="4" height="4"><img src="/images/corner_bot_left.png" /></td><td colspan="3" background="/images/table_bak.png"></td><td width="4" height="4"><img src="/images/corner_bot_right.png" /></td></tr></table>

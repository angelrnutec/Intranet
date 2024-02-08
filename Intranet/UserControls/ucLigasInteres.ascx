<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ucLigasInteres.ascx.vb" Inherits="Intranet.ucLigasInteres" %>
<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<table border="0" cellpadding="0" cellspacing="0" width="210px">
    <tr><td width="4" height="4"><img src="/images/corner_top_left.png" /></td><td width="140px" background="/images/table_bak.png"></td><td width="4" height="4"><img src="/images/corner_top_right.png" /></td><td width="60px"></td><td width="4" height="4"></td></tr><tr><td background="/images/table_bak.png"></td><td background="/images/table_bak.png">&nbsp;&nbsp;<i class="icon-link icon-large"></i>&nbsp;&nbsp;<strong><%=TranslateLocale.text("Ligas de Interés")%></strong></td><td background="/images/table_bak.png"></td><td></td><td></td></tr><tr><td background="/images/table_bak.png"></td><td background="/images/table_bak.png"></td><td background="/images/table_bak.png"></td><td background="/images/table_bak.png"></td><td width="4" height="4"><img src="/images/corner_top_right.png" /></td></tr><tr><td background="/images/table_bak.png"></td>
        <td colspan="3" background="/images/table_bak.png">
            <div class="barra_der_contenido">
                <asp:ListView ID="lvLigas" runat="server">
                    <LayoutTemplate>
                        <div>
                            <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                        </div>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <a href='<%# Eval("liga_url") %>' target='<%# Eval("liga_target") %>'>>&nbsp;<asp:Label ID="lblLigaDesc" runat="server" Text='<%# Eval("liga_desc")%>'></asp:Label></a><br />
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <br /><br /><br />
                    </EmptyDataTemplate>
                </asp:ListView>
                <br />
            </div>
        </td><td background="/images/table_bak.png"></td></tr><tr><td width="4" height="4"><img src="/images/corner_bot_left.png" /></td><td colspan="3" background="/images/table_bak.png"></td><td width="4" height="4"><img src="/images/corner_bot_right.png" /></td></tr></table>

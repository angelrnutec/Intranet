<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ucBanners.ascx.vb" Inherits="Intranet.ucBanners" %>
<asp:ListView ID="lvLigas" runat="server">
    <LayoutTemplate>
        <div>
            <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
        </div>
    </LayoutTemplate>
    <ItemTemplate>
        <div style="height:5px"></div>
        <a href='<%# Eval("liga_url") %>' target='<%# Eval("liga_target") %>'><img src='/uploads/banner/<%# Eval("liga_banner") %>' border="0" style='max-width:<%# IIf(Eval("ubicacion")="D","210px","260px") %>' /></a>
    </ItemTemplate>
    <EmptyDataTemplate>
        <br /><br /><br />
    </EmptyDataTemplate>
</asp:ListView>

<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="Default.aspx.vb" Inherits="Intranet._Default" %>
<%@ Register Src="~/UserControls/ucNoticias.ascx" TagName="ucNoticias" TagPrefix="uc" %>
<%@ Register Src="~/UserControls/ucCumple.ascx" TagName="ucCumple" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc:ucNoticias ID="ucNoticias1" runat="server" />
    <br /><br />
    <uc:ucCumple ID="ucCumple1" runat="server" />
</asp:Content>

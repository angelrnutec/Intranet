<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="Publicaciones.aspx.vb" Inherits="Intranet.Publicaciones" %>
<%@ Register Src="~/UserControls/ucPublicacionesListado.ascx" TagName="ucPublicacionesListado" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <uc:ucPublicacionesListado ID="ucPublicacionesListado1" runat="server" />
</asp:Content>

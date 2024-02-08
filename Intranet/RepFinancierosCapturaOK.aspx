<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="RepFinancierosCapturaOK.aspx.vb" Inherits="Intranet.RepFinancierosCapturaOK" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <span style="font-size:15px; font-weight:bold; color:#1980bd;"><br /><%=translatelocale.text("La captura de datos se guardo correctamente")%>.</span>
    <br /><br />
    <asp:Button ID="btnNuevo" runat="server" Text="Realizar Nueva Captura" />


</asp:Content>

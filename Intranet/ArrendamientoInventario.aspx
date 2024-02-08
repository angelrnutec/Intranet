<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="ArrendamientoInventario.aspx.vb" Inherits="Intranet.ArrendamientoInventario" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Panel ID="pnlBusqueda" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="600px">
            <tr>
                <td colspan="3"><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Inventario de Arrendamientos")%></span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr valign="top">
                <td>
                    <%=TranslateLocale.text("Empresa")%>:
                </td>
                <td>
                    <asp:DropDownList ID="ddlEmpresa" runat="server" Width="250px"></asp:DropDownList>
                </td>
                <td align="right" rowspan="2">
                    <asp:Button ID="btnBuscar" runat="server" Text="Exportar" CssClass="botones" />
                </td>
            </tr>
            <tr valign="top">
                <td>
                    <%=TranslateLocale.text("Categoría de Arrendamiento")%>:
                </td>
                <td>
                    <asp:DropDownList ID="ddlCategoriaArrendamiento" runat="server" Width="250px"></asp:DropDownList>
                </td>
                <td></td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <br />    
</asp:Content>

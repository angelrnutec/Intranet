<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="CambiarPassword.aspx.vb" Inherits="Intranet.CambiarPassword" %>
<%@ Register Src="~/UserControls/ucNoticias.ascx" TagName="ucNoticias" TagPrefix="uc" %>
<%@ Register Src="~/UserControls/ucCumple.ascx" TagName="ucCumple" TagPrefix="uc" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table>
        <tr>
            <td>
                Password Anterior:
            </td>
            <td>
                <asp:TextBox ID="txtPasswordAnterior" runat="server" Width="200px" MaxLength="64" TextMode="Password"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Password Nuevo:
            </td>
            <td>
                <asp:TextBox ID="txtPasswordNuevo" runat="server" Width="200px" MaxLength="64" TextMode="Password"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                Confirmacion de Password:
            </td>
            <td>
                <asp:TextBox ID="txtConfirmacionPassword" runat="server" Width="200px" MaxLength="64" TextMode="Password"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2">
                <br />
                <asp:Button ID="btnRegresar" runat="server" CssClass="botones" Text="Regresar" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnGuardar" runat="server" CssClass="botones" Text="Guardar" />
            </td>
        </tr>
    </table>
</asp:Content>

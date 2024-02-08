<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="ConceptosIntranetVer.aspx.vb" Inherits="Intranet.ConceptosIntranetVer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table cellpadding="0" cellspacing="0" border="0" width="95%">
        <tr>
            <td colspan="4"><span style="font-size:15px; font-weight:bold;">Información del Concepto de Intranet</span><hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td colspan="4"><br /></td>
        </tr>
        <tr>
            <td>Descripcion:</td>
            <td colspan="3"><asp:TextBox ID="txtDescripcion" runat="server" Width="200px" MaxLength="128"></asp:TextBox></td>
        </tr>      
        <tr>
            <td colspan="4"><br /></td>
        </tr>
        <tr>
            <td colspan="4">
                <br />
                <asp:Button ID="btnRegresar" runat="server" CssClass="botones" Text="Regresar" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnGuardar" runat="server" CssClass="botones" Text="Guardar" />
            </td>
        </tr>
    </table>
    <asp:TextBox ID="txtIdClasificacionCosto" runat="server" style="display:none;"></asp:TextBox>
</asp:Content>

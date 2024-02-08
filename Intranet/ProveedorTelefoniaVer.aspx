<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="ProveedorTelefoniaVer.aspx.vb" Inherits="Intranet.ProveedorTelefoniaVer" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table cellpadding="0" cellspacing="0" border="0" width="95%">
        <tr>
            <td colspan="4"><span style="font-size:15px; font-weight:bold;">Información del Proveedor de Telefonia</span><hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td colspan="4"><br /></td>
        </tr>
        <tr>
            <td>Descripcion:</td>
            <td colspan="3"><asp:TextBox ID="txtDescripcion" runat="server" Width="200px" MaxLength="256"></asp:TextBox></td>
        </tr> 
        <tr>
            <td>Tipo de Captura:</td>
            <td>
                <asp:DropDownList ID="ddlTipoCaptura" runat="server" Width="250px">
                    <asp:ListItem Value="0" Text=""></asp:ListItem>
                    <asp:ListItem Value="1" Text="Archivo de Excel"></asp:ListItem>
                    <asp:ListItem Value="2" Text="Captura Manual"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>   
        <tr>
            <td>Concepto en reporte:</td>
            <td><asp:DropDownList ID="ddlConcepto" runat="server" Width="250px"></asp:DropDownList></td>
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
    <asp:TextBox ID="txtIdProveedorTelefonia" runat="server" style="display:none;"></asp:TextBox>
</asp:Content>

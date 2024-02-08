<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="TelcelAsignacionEdita.aspx.vb" Inherits="Intranet.TelcelAsignacionEdita" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table cellpadding="0" cellspacing="0" border="0" width="800px">
        <tr>
            <td colspan="4"><span style="font-size:15px; font-weight:bold;">Asignacion de Numero Telefonico</span><hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td colspan="4"><br /></td>
        </tr>
        <tr>
            <td>Empresa:</td>
            <td colspan="3">
                <asp:DropDownList ID="ddlEmpresa" runat="server" Width="250px" AutoPostBack="true"></asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td>Empleado:</td>
            <td colspan="3">
                <asp:DropDownList ID="ddlEmpleado" runat="server" Width="250px" AutoPostBack="true"></asp:DropDownList>
            </td>
        </tr>
        <tr id="trExterno" runat="server" visible="false">
            <td>Nombre del Externo:</td>
            <td colspan="3"><asp:TextBox ID="txtExterno" runat="server" Width="250px" MaxLength="256"></asp:TextBox></td>
        </tr>
        <tr>
            <td>Telefono:</td>
            <td colspan="3"><asp:TextBox ID="txtTelefono" runat="server" Width="250px" MaxLength="256"></asp:TextBox></td>
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
    <asp:TextBox ID="txtIdConceptoGasto" runat="server" style="display:none;"></asp:TextBox>
</asp:Content>

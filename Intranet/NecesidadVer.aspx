<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="NecesidadVer.aspx.vb" Inherits="Intranet.NecesidadVer" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table cellpadding="0" cellspacing="0" border="0" width="95%">
        <tr>
            <td colspan="4"><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Información de la necesidad")%></span><hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td colspan="4"><br /></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Clave")%>:</td>
            <td colspan="3"><asp:TextBox ID="txtClave" runat="server" Width="80px" MaxLength="32"></asp:TextBox></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Descripción")%>:</td>
            <td colspan="3"><asp:TextBox ID="txtDescripcion" runat="server" Width="200px" MaxLength="256"></asp:TextBox></td>
        </tr> 
        <tr>
            <td><%=TranslateLocale.text("Descripción ingles")%>:</td>
            <td colspan="3"><asp:TextBox ID="txtDescripcionEn" runat="server" Width="200px" MaxLength="256"></asp:TextBox></td>
        </tr> 
        <tr>
            <td><%=TranslateLocale.text("Empresa")%>:</td>
            <td><asp:DropDownList ID="ddlEmpresa" runat="server" Width="250px"></asp:DropDownList></td>
        </tr>      
        <tr>
            <td><%=TranslateLocale.text("Tipo")%>:</td>
            <td>
                <asp:DropDownList ID="ddlTipo" runat="server" Width="250px">
                    <asp:ListItem Value="" Text="--Seleccione--"></asp:ListItem>
                    <asp:ListItem Value="OI" Text="OI"></asp:ListItem>
                    <asp:ListItem Value="PP" Text="PEP"></asp:ListItem>
                </asp:DropDownList>
            </td>
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
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnEliminar" runat="server" CssClass="botones" Text="Eliminar" Visible="false" OnClientClick="return confirm('Seguro que desea eliminar este registro?');" />
            </td>
        </tr>
    </table>
    <asp:TextBox ID="txtIdNecesidad" runat="server" style="display:none;"></asp:TextBox>
</asp:Content>

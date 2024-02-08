<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="RepGastosNSEjecutivo.aspx.vb" Inherits="Intranet.RepGastosNSEjecutivo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table cellpadding="0" cellspacing="0" border="0" width="600px">
        <tr>
            <td><span style="font-size:15px; font-weight:bold;"><asp:Label ID="lblNombreReporte" runat="server"></asp:Label></span>
                <hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td>
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>A&ntilde;o:</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:DropDownList ID="ddlAnio" runat="server" Width="105px"></asp:DropDownList>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            Al mes de:&nbsp;&nbsp;&nbsp;
                            <asp:DropDownList ID="ddlMes" runat="server" Width="120px"></asp:DropDownList>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            Moneda:&nbsp;&nbsp;&nbsp;
                            <asp:DropDownList ID="ddMoneda" runat="server" Width="100px">
                                <asp:ListItem Value="MXP" Text="MXP"></asp:ListItem>
                                <asp:ListItem Value="USD" Text="USD"></asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" align="right">
                            <div style="height:7px"></div>
                            <asp:Button ID="btnGenerarReporte" runat="server" Text="Generar Reporte" OnClientClick="this.disabled = true; this.value = 'Generando Reporte...';" UseSubmitBehavior="false" />&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnCancelar" runat="server" Text="Salir" />
                        </td>
                    </tr>
                </table>

            </td>
        </tr>
        <tr>
            <td><br /><hr style="margin:0; padding:0;" /></td>
        </tr>
    </table>


</asp:Content>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="GenerarPasswordNuevo.aspx.vb" Inherits="Intranet.GenerarPasswordNuevo" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>.: Intranet NUTEC :.</title>

    <style type="text/css">
        body {
            font-family:Helvetica, Tahoma, Arial;
            font-size:14px;
            font-weight:bold;
            color:#CACAD9;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div align="center" style="margin: 0 auto;">
        <div style="padding-top:100px"></div>
        <div style="width:400px; height:326px; background-image:url(/images/login/bak.png);">
            <div style="padding-top:100px;padding-left:10px">
                <table>
                    <tr>
                        <td align="center" colspan="3"><asp:Label ID="lblVencida" runat="server"></asp:Label>Ingrese su nueva contrase&ntilde;a. <asp:Label ID="lblNominas" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="right">Contrase&ntilde;a:</td>
                        <td>&nbsp;&nbsp;&nbsp;</td>
                        <td align="left"><asp:TextBox ID="txtPassword" TextMode="Password" runat="server" Width="180px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td align="right">Confirmar contrase&ntilde;a:</td>
                        <td>&nbsp;&nbsp;&nbsp;</td>
                        <td align="left"><asp:TextBox ID="txtPassword2" TextMode="Password" runat="server" Width="180px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td colspan="3" align="center">
                            <br />
                            <asp:Button ID="btnContinuar" runat="server" Text="Guardar nueva contrase&ntilde;a" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    
    </div>
        <asp:TextBox ID="txtUsuario" runat="server" Text="" Visible="false"></asp:TextBox>
        <asp:Label ID="lblPopUp" runat="server" Visible="false"></asp:Label>
    </form>
</body>
</html>

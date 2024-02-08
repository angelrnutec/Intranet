<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="GenerarPassword.aspx.vb" Inherits="Intranet.GenerarPassword" %>
<%@ Import Namespace="Intranet.LocalizationIntranet" %>

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
        <div style="width:400px; height:326px; background-image:url(/images/login/<%=TranslateLocale.text("bak.png")%>);">
            <div style="padding-top:100px;padding-left:10px">
                <table>
                    <tr>
                        <td align="center" colspan="3"><%=TranslateLocale.text("Ingrese su nombre de usuario")%>.</td>
                    </tr>
                    <tr>
                        <td align="right"><%=TranslateLocale.text("Usuario: (Email)")%></td>
                        <td>&nbsp;&nbsp;&nbsp;</td>
                        <td align="left"><asp:TextBox ID="txtUsuario" runat="server" Width="220px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td colspan="3" align="center">
                            <br />
                            <asp:Button ID="btnContinuar" runat="server" Text="Generar Nuevo Password" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    
    </div>

        <asp:Label ID="lblPopUp" runat="server" Visible="false"></asp:Label>
    </form>
</body>
</html>

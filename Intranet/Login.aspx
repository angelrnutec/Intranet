<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="Intranet.Login" %>

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
<% If ConfigurationManager.AppSettings("AMBIENTE_QA").ToString() = "1" Then%>
<table style="width:100%;background-color:red;color:#fff;"><tr><td><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;USTED ESTA USANDO UN AMBIENTE DE PRUEBAS</b></td></tr></table>
<% End If%>
    <div align="center" style="margin: 0 auto;">
        <div style="padding-top:100px"></div>
        <div style="width:400px; height:326px; background-image:url(/images/login/<%=TranslateLocale.text("bak.png")%>);">
            <div style="padding-top:100px;padding-left:10px">
                <table>
                    <tr>
                        <td align="right"><%=TranslateLocale.text("Usuario")%>:</td>
                        <td>&nbsp;&nbsp;&nbsp;</td>
                        <td align="left"><asp:TextBox ID="txtUsuario" runat="server" Width="220px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td colspan="3"><div style="height:8px;"></div></td>
                    </tr>
                    <tr>
                        <td align="right"><%=TranslateLocale.text("Contraseña")%>:</td>
                        <td>&nbsp;&nbsp;&nbsp;</td>
                        <td align="left"><asp:TextBox ID="txtPassword" TextMode="Password" runat="server" Width="220px"></asp:TextBox></td>
                    </tr>
                    <tr>
                        <td colspan="3" align="right"><br />
                            <span style="text-align: left;width: 230px;display: inline-block;font-size:12px;">
                                <a href="/CambiaIdioma.aspx?i=en" style="color:#fff">English</a>&nbsp;&nbsp;|&nbsp;&nbsp;<a href="/CambiaIdioma.aspx?i=es" style="color:#fff">Español</a>
                            </span>

                            <a href="GenerarPassword.aspx" style="font-size:12px;color:#FFFFFF;"><%=TranslateLocale.text("Olvide mi contraseña")%></a>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3">
                            <br />
                            <asp:ImageButton ID="btnEntrar" runat="server" ImageUrl="/images/login/boton.png" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    
    </div>

        <asp:TextBox ID="txtURLTarget" runat="server" Visible="false" Text=""></asp:TextBox>
        <asp:Label ID="lblPopUp" runat="server" Visible="false"></asp:Label>
    </form>
</body>
</html>

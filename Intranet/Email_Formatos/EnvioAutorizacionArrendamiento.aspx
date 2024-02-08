<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EnvioAutorizacionArrendamiento.aspx.vb" Inherits="Intranet.EnvioAutorizacionArrendamiento" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
</head>
<body>
    <form id="form1" runat="server">
    <table width="600px">
        <tr>
            <td>
                <br />
                <asp:Label ID="lblNombre" runat="server"></asp:Label>
            </td>
        </tr>        
        <tr>
            <td><br /><asp:Label ID="lblTitulo" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td align="center">
                <table width="90%">
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Numero", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblNumero" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" class="auto-style1"><%=TranslateLocale.text("Empleado Solicita", EMAIL_LOCALE)%>:</td>
                        <td align="left" class="auto-style2"><asp:Label ID="lblEmpleadoSolicita" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Empresa", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblEmpresa" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" class="auto-style1"><%=TranslateLocale.text("Categoría", EMAIL_LOCALE)%>:</td>
                        <td align="left" class="auto-style2"><asp:Label ID="lblCategoria" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="left">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Departamento", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblDepartamento" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Asignado a", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblAsignado" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="left">
                            <hr />
                        </td>
                    </tr>
                    <tr id="trAutorizaRH" runat="server">
                        <td align="left" class="auto-style1"><%=TranslateLocale.text("Autoriza Director RH", EMAIL_LOCALE)%>:</td>
                        <td align="left" class="auto-style2"><asp:Label ID="lblAutorizaRH" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trAutorizaNegocio" runat="server">
                        <td align="left" class="auto-style1"><%=TranslateLocale.text("Autoriza Director Negocio", EMAIL_LOCALE)%>:</td>
                        <td align="left" class="auto-style2"><asp:Label ID="lblAutorizaNegocio" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" class="auto-style1"><%=TranslateLocale.text("Autoriza Director Finanzas", EMAIL_LOCALE)%>:</td>
                        <td align="left" class="auto-style2"><asp:Label ID="lblAutorizaFinanzas" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="left">
                            <hr />
                        </td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Estatus", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblEstatus" runat="server"></asp:Label></td>
                    </tr>
                    <tr id="trMotivoRechazo" runat="server" visible="false">
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Motivo del rechazo", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblMotivoRechazo" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="left" style="width:160px;">
                            <br />
                            <div id="divAcciones" runat="server">
                            <%=TranslateLocale.text("Acciones", EMAIL_LOCALE)%>: 
                            <a id="lnkAutoriza" runat="server" target="_blank"><%=TranslateLocale.text("Autorizar", EMAIL_LOCALE)%></a>
                            &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
                            <a id="lnkRechaza" runat="server" target="_blank"><%=TranslateLocale.text("Rechazar", EMAIL_LOCALE)%></a>
                            <br /><br />
                            
                            <a id="lnkDetalle" runat="server" target="_blank"><%=TranslateLocale.text("Ver el detalle", EMAIL_LOCALE)%></a>
                            </div>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>   
        <asp:Label ID="lblId" runat="server" Visible="false"></asp:Label>   
        <asp:Label ID="lblAuth" runat="server" Visible="false"></asp:Label>   
    </form>
</body>
</html>

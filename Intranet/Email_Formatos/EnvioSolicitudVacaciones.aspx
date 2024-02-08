<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="EnvioSolicitudVacaciones.aspx.vb" Inherits="Intranet.EnvioSolicitudVacaciones" %>

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
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Folio", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblFolio" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" class="auto-style1"><%=TranslateLocale.text("Empleado Solicita", EMAIL_LOCALE)%>:</td>
                        <td align="left" class="auto-style2"><asp:Label ID="lblEmpleadoSolicita" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" class="auto-style1"><%=TranslateLocale.text("Autoriza Jefe", EMAIL_LOCALE)%>:</td>
                        <td align="left" class="auto-style2"><asp:Label ID="lblAutorizaJefe" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Empresa", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblEmpresa" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Nomina", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblNomina" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Fecha Inicio", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblFechaInicio" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Fecha Fin", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblFechaFin" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="2"><hr /></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Saldo Inicial", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblDiasDisponibles" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Dias Solicitados", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblDias" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Dias Proporcionales", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblDiasProporcionales" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Saldo Final", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblDiasFinal" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="2"><hr /></td>
                    </tr>
                    <tr>
                        <td align="left" style="width:160px;"><%=TranslateLocale.text("Comentarios", EMAIL_LOCALE)%>:</td>
                        <td align="left"><asp:Label ID="lblComentarios" runat="server"></asp:Label></td>
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
                            <a id="lnkAutoriza" runat="server" target="_blank"><%=TranslateLocale.text("Autorizar Solicitud", EMAIL_LOCALE)%></a>
                            &nbsp;&nbsp;&nbsp;|&nbsp;&nbsp;&nbsp;
                            <a id="lnkRechaza" runat="server" target="_blank"><%=TranslateLocale.text("Rechazar Solicitud", EMAIL_LOCALE)%></a>
                            <br /><br />
                            <a id="lnkDetalle" runat="server" target="_blank"><%=TranslateLocale.text("Para ver sus tareas pendientes click aqui", EMAIL_LOCALE)%></a>
                            <br /><br />
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

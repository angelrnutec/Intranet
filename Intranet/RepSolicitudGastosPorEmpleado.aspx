<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="RepSolicitudGastosPorEmpleado.aspx.vb" Inherits="Intranet.RepSolicitudGastosPorEmpleado" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
    <table cellpadding="0" cellspacing="0" border="0" width="600px">
        <tr>
            <td><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Rep. Solicitud de Gastos por Empleado")%></span>
                <hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td>
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td><%=TranslateLocale.text("Año")%>:</td>
                        <td><asp:DropDownList ID="ddlAnio" runat="server" Width="250px"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Empresa")%>:</td>
                        <td><asp:DropDownList ID="ddlEmpresa" runat="server" Width="250px" AutoPostBack="true"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Empleado")%>:</td>
                        <td><asp:DropDownList ID="ddlEmpleado" runat="server" Width="250px"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="right">
                            <div style="height:7px"></div>
                            <asp:Button ID="btnGenerarReporte" runat="server" Text="Ver Reporte" OnClientClick="this.disabled = true; this.value = 'Consultando...';" UseSubmitBehavior="false" />&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                </table>

                <br /><br />

            </td>
        </tr>
        <tr>
            <td><br /><hr style="margin:0; padding:0;" /></td>
        </tr>
    </table>




</asp:Content>

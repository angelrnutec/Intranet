<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="RepSolicitudGastosPorCentroCosto.aspx.vb" Inherits="Intranet.RepSolicitudGastosPorCentroCosto" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
    <table cellpadding="0" cellspacing="0" border="0" width="600px">
        <tr>
            <td><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Rep. Solicitud de Gastos por Centro de Costo / Orden Interna")%></span>
                <hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td>
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>&nbsp;&nbsp;&nbsp;<%=TranslateLocale.text("Año")%>:</td>
                        <td><asp:DropDownList ID="ddlAnio" runat="server" Width="250px"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Empresa")%>:</td>
                        <td><asp:DropDownList ID="ddlEmpresa" runat="server" Width="250px"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Mostrar CC o OI")%>:</td>
                        <td>
                            <asp:DropDownList ID="ddlMostrar" runat="server" Width="250px">
                            </asp:DropDownList>
                        </td>
                    </tr>
<%--                    <tr>
                        <td>&nbsp;&nbsp;&nbsp;Periodo:</td>
                        <td><asp:DropDownList ID="ddlPeriodo" runat="server" Width="110px"></asp:DropDownList></td>
                    </tr>--%>
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

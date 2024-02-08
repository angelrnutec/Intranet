<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="RepSolicitudGastosPorConcepto.aspx.vb" Inherits="Intranet.RepSolicitudGastosPorConcepto" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function MuestraAgrupar(id_empresa) {
            if (id_empresa == '3') {
                document.getElementById('trAgrupar').style.display = '';
            } else {
                document.getElementById('trAgrupar').style.display = 'none';
            }
        }
        setTimeout(function () { MuestraAgrupar(document.getElementById('<%=ddlAgrupado.ClientID%>').value); }, 400);
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
    <table cellpadding="0" cellspacing="0" border="0" width="600px">
        <tr>
            <td><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Rep. Solicitud de Gastos por Concepto")%></span>
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
                        <td><asp:DropDownList ID="ddlEmpresa" runat="server" Width="250px" onchange="MuestraAgrupar(this.value);"></asp:DropDownList></td>
                    </tr>
                    <tr id="trAgrupar" style="display:none">
                        <td><%=TranslateLocale.text("Agrupar Por")%>:</td>
                        <td>
                            <asp:DropDownList ID="ddlAgrupado" runat="server" Width="250px">
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

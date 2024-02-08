<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="DescargaGastosNSPresupuesto.aspx.vb" Inherits="Intranet.DescargaGastosNSPresupuesto" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
    <table cellpadding="0" cellspacing="0" border="0" width="600px">
        <tr>
            <td><span style="font-size:15px; font-weight:bold;">Descarga de Presupuesto de Gastos NS desde SAP</span>
                <hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td>
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>&nbsp;&nbsp;&nbsp;Año:</td>
                        <td><asp:DropDownList ID="ddlAnio" runat="server" Width="110px"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td colspan="2" align="right">
                            <div style="height:7px"></div>
                            <asp:Button ID="btnGenerarReporte" runat="server" Text="Descargar Datos" OnClientClick="this.disabled = true; this.value = 'Descargando...';" UseSubmitBehavior="false" />&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                    </tr>
                </table>

                <br /><br />
                <div id="divResultados" runat="server" visible="false">
                    <table>
                        <tr>
                            <td><b>Resgistros Descargados:</b></td>
                            <td><asp:Label ID="lblRegistrosDescargados" runat="server"></asp:Label></td>
                        </tr>
                    </table><br />
                    <asp:PlaceHolder ID="phGastosSinClasificar" runat="server"></asp:PlaceHolder>
                </div>
            </td>
        </tr>
        <tr>
            <td><br /><hr style="margin:0; padding:0;" /></td>
        </tr>
    </table>


</asp:Content>

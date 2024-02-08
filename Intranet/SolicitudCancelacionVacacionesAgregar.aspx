<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="SolicitudCancelacionVacacionesAgregar.aspx.vb" Inherits="Intranet.SolicitudCancelacionVacacionesAgregar" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .tblSolicitud th {
            font-weight:bold;
        }
    </style>


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>

    <table cellpadding="0" cellspacing="0" border="0" width="650px">
        <tr>
            <td colspan="5"><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Solicitud de Cancelación de Vacaciones")%></span><hr style="margin:0; padding:0;" /></td>
        </tr>
    </table>

    <br />
    <table>
        <tr>
            <td colspan="5"><b><asp:Label ID="lblFolio" runat="server"></asp:Label></b></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Fecha de Solicitud")%>:</td>
            <td><asp:Label ID="lblFechaSolicitud" runat="server"></asp:Label></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Empresa")%>:</td>
            <td><asp:DropDownList ID="ddlEmpresa" runat="server" Width="200px" AutoPostBack="true"></asp:DropDownList></td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Solicitante")%>:</td>
            <td><asp:DropDownList ID="ddlSolicitante" runat="server" Width="200px" AutoPostBack="true" ></asp:DropDownList></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Nomina")%>:</td>
            <td><asp:DropDownList ID="ddlNomina" runat="server" Width="200px"></asp:DropDownList></td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Autoriza Jefe")%>:</td>
            <td><asp:DropDownList ID="ddlAutorizaJefe" runat="server" Width="200px"></asp:DropDownList></td>
        </tr>
        <tr id="trDiasDisponibles" runat="server" visible="false">
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
        </tr>
        <tr id="trSolicitudOriginal" runat="server">
            <td></td>
            <td></td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Solicitud Original")%>:</td>
            <td><asp:DropDownList ID="ddlSolicitudesOriginales" runat="server" Width="200px" AutoPostBack="true"></asp:DropDownList></td>
        </tr>
        <tr valign="top">
            <td><%=TranslateLocale.text("Comentarios")%>:</td>
            <td colspan="3">
                <asp:TextBox ID="txtComentarios" runat="server" TextMode="MultiLine" Width="278px" Height="71px"></asp:TextBox>
            </td>
            <td colspan="1" style="padding-left:10px">
                <%=TranslateLocale.text("Fechas a Cancelar")%>:
                <asp:PlaceHolder ID="phFechasCancelar" runat="server"></asp:PlaceHolder>               
            </td>
        </tr>
        <tr>
            <td colspan="5"><asp:Label ID="lblEstatus" runat="server"></asp:Label></td>
        </tr>
    </table>


    <br /><br />
    <asp:Button ID="btnRegresar" runat="server" CssClass="botones" Text="Regresar" />
    &nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnGuardar" runat="server" Text="Enviar Solicitud de Cancelación" CssClass="botones"  UseSubmitBehavior="false"/>
    &nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnCancelarSolicitud" runat="server" Text="Cancelar la Solicitud" CssClass="botones" Visible="false" UseSubmitBehavior="false"/>
    &nbsp;&nbsp;&nbsp;


    <br /><br />


     <asp:TextBox ID="txtIdSolicitud" runat="server" Text="0" style="display:none;"></asp:TextBox>
    <asp:TextBox ID="txtIdEstatus" runat="server" Visible="false"></asp:TextBox>
</asp:Content>

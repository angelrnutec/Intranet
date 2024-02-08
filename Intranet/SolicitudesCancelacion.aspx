<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="SolicitudesCancelacion.aspx.vb" Inherits="Intranet.SolicitudesCancelacion" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <link href="styles/jquery-ui.css" rel="stylesheet" />  
  <script src="Scripts/jquery-1.9.1.js"></script>
  <script src="Scripts/jquery-ui.js"></script>    
  <link rel="stylesheet" type="text/css" href="/styles/styles.css" />

    <style type="text/css">
        .divDialog
        {
            height: 100%;
            margin: 0 0 0 0;
            font-family: 'arialnarrow', Helvetica, sans-serif;
            font-size: 14px;
            background-image: url(/images/page_bak.png);
        }

        .tablaEmpleados
        {
            width: 550px;
            border-style: solid;
            border-width: 1px;
            border-color: #cccfd3;
        }

        .tablaEmpleados td
        {
            border-style: solid;
            border-width: 1px;
            border-color: #cccfd3;
            height: 20px;
            padding-left: 5px;
            padding-right: 5px;
        }
    </style>
    <script type="text/javascript">

    </script>

    


    

    <asp:Panel ID="pnlBusqueda" runat="server" DefaultButton="btnBuscar">
        <table cellpadding="0" cellspacing="0" border="0" width="600px">
            <tr>
                <td colspan="2"><span style="font-size:15px; font-weight:bold;">Busqueda de Solicitudes</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;&nbsp;Tipo de Solicitud</td>
                <td>
                    <asp:DropDownList ID="ddlTipoSolicitud" runat="server">
                        <asp:ListItem Value="0" Text="--Seleccione--"></asp:ListItem>
                        <asp:ListItem Value="1" Text="Solicitud de Gastos de Viaje"></asp:ListItem>
                        <asp:ListItem Value="2" Text="Solicitud de Reposición de Gastos"></asp:ListItem>
                        <asp:ListItem Value="3" Text="Solicitud de Vacaciones"></asp:ListItem>
                        <asp:ListItem Value="4" Text="Solicitud de Permisos"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;&nbsp;Folio a cancelar</td>
                <td>
                    <asp:TextBox ID="txtFolio" runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="right">
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="botones" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />

    <asp:Label ID="lblResultado" runat="server"></asp:Label>
    <table width="85%" id="tblResultado" runat="server" visible="false">
        <tr>
            <td colspan="2"><b>Datos de la Solicitud</b></td>
        </tr>
        <tr>
            <td>Folio:</td>
            <td><asp:Label ID="lblFolio" runat="server"></asp:Label>
                <asp:TextBox ID="txtId" runat="server" Visible="false"></asp:TextBox>
                <asp:TextBox ID="txtIdTipo" runat="server" Visible="false"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>Solicitante:</td>
            <td><asp:Label ID="lblEmpleado" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td>Fecha de solicitud:</td>
            <td><asp:Label ID="lblFecha" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td>Empresa:</td>
            <td><asp:Label ID="lblEmpresa" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td>Estatus:</td>
            <td><asp:Label ID="lblEstatus" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td>Motivo:</td>
            <td><asp:TextBox ID="txtMotivoCancela" runat="server" Width="250px"></asp:TextBox></td>
        </tr>
        <tr>
            <td colspan="2" align="right">
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar esta solicitud" CssClass="botones" />
            </td>
        </tr>
    </table>
         
</asp:Content>

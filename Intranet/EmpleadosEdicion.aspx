<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="EmpleadosEdicion.aspx.vb" Inherits="Intranet.EmpleadosEdicion" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>

  <link rel="stylesheet" type="text/css" href="/styles/styles.css" />

    <table cellpadding="0" cellspacing="0" border="0" width="95%">
        <tr>
            <td><span style="font-size:15px; font-weight:bold;">Datos del Empleado</span><hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td><br /></td>
        </tr>
        <tr valign="top">
            <td>


            <div style="color:#e0dede;">
        	<table border="0" cellpadding="0" cellspacing="0" width="100%">
            	<tr valign="top"><td width="5" height="5"><img src="/images/centro_si.png" /></td><td width="300px" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td><td><div style="height:5px;"></div></td><td width="5" height="5"></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png" style="font-size:15px;">&nbsp;&nbsp;<i class="icon-user icon-large"></i>&nbsp;&nbsp;</td><td background="/images/centro_bak.png"></td><td></td><td></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td></tr><tr><td background="/images/centro_bak.png"></td>
                    <td colspan="3" background="/images/centro_bak.png">
                    	<div style="height:6px;"></div>
                        <table width="100%" border="0">
                            <tr valign="top">
                                <td rowspan="2">
                                    <table width="95%" border="0">
                                        <tr>
                                            <td>Nombre:</td>
                                            <td><asp:TextBox ID="txtNombre" runat="server" MaxLength="256" Width="190px"></asp:TextBox></td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                            <td>Numero:</td>
                                            <td><asp:TextBox ID="txtNumero" runat="server" MaxLength="4" Width="50px"></asp:TextBox></td>
                                        </tr>
                                        <tr>
                                            <td>Empresa:</td>
                                            <td>
                                                <asp:DropDownList ID="ddlEmpresa" runat="server" Width="200px" AutoPostBack="true"></asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                            <td>Fecha de Nacimiento:</td>
                                            <td><telerik:RadDatePicker ID="dtFechaNacimiento" runat="server" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy" Width="100px" MinDate="1900/01/01"></telerik:RadDatePicker></td>
                                        </tr>
                                        <tr>
                                            <td>Departamento:</td>
                                            <td>
                                                <asp:DropDownList ID="ddlDepartamento" runat="server" Width="200px"></asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                            <td>Fecha de Alta:</td>
                                            <td><telerik:RadDatePicker ID="dtFechaAlta" runat="server" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy" Width="100px" MinDate="1900/01/01"></telerik:RadDatePicker></td>
                                        </tr>
                                        <tr>
                                            <td>Num Deudor:</td>
                                            <td>
                                                <asp:TextBox ID="txtNumDeudor" runat="server" Width="200px" MaxLength="16"></asp:TextBox>
                                            </td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                            <td>Centro de Costo:</td>
                                            <td>
                                                <asp:TextBox ID="txtCentroCosto" runat="server" Width="200px" MaxLength="16"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td>Núm Acreedor:</td>
                                            <td>
                                                <asp:TextBox ID="txtNumAcreedor" runat="server" Width="200px" MaxLength="16"></asp:TextBox>
                                            </td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                        </tr>
                                    </table>
                                    <br />
                                </td>
                            </tr>
                        </table>
                    </td><td background="/images/centro_bak.png"></td></tr><tr><td width="5" height="5"><img src="/images/centro_ii.png" /></td><td colspan="3" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_id.png" /></td></tr></table>

                <br /><br />



                </div>

            </td>

        </tr>
        <tr>
            <td colspan="2">
                <br />
                <asp:Button ID="btnSalir" runat="server" CssClass="botones" Text="Salir" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnGuardar" runat="server" CssClass="botones" Text="Guardar" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnBaja" runat="server" CssClass="botones" Text="Dar de Baja" OnClientClick="return confirm('Seguro que desea dar de baja este empleado?');" />
            </td>
        </tr>
    </table>
    <asp:TextBox ID="txtIdEmpleado" runat="server" style="display:none;"></asp:TextBox>
</asp:Content>

<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="VerEmp.aspx.vb" Inherits="Intranet.VerEmp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table cellpadding="0" cellspacing="0" border="0" width="95%">
        <tr>
            <td><span style="font-size:15px; font-weight:bold;">Información del Empleado</span><hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td><br /></td>
        </tr>
        <tr valign="top">
            <td>


            <div style="color:#e0dede;">
        	<table border="0" cellpadding="0" cellspacing="0" width="100%">
            	<tr valign="top"><td width="5" height="5"><img src="/images/centro_si.png" /></td><td width="300px" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td><td><div style="height:5px;"></div></td><td width="5" height="5"></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png" style="font-size:15px;">&nbsp;&nbsp;<i class="icon-user icon-large"></i>&nbsp;&nbsp;<strong><asp:Label ID="lblNombre" runat="server"></asp:Label></strong></td><td background="/images/centro_bak.png"></td><td></td><td></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td></tr><tr><td background="/images/centro_bak.png"></td>
                    <td colspan="3" background="/images/centro_bak.png">
                    	<div style="height:6px;"></div>
                        <table width="100%" border="0">
                            <tr valign="top">
                                <td>
                                    <table width="95%" border="0">
                                        <tr>
                                            <td>Numero:</td>
                                            <td><asp:Label ID="lblNumero" runat="server"></asp:Label></td>
                                            <td>&nbsp;&nbsp;&nbsp;<br /><br /></td>
                                            <td>Email:</td>
                                            <td><asp:Label ID="lblEmail" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>Departamento:</td>
                                            <td><asp:Label ID="lblDepartamento" runat="server"></asp:Label></td>
                                            <td>&nbsp;&nbsp;&nbsp;<br /><br /></td>
                                            <td>Fecha de Nacimiento:</td>
                                            <td><asp:Label ID="lblFechaNacimiento" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>Telefono:</td>
                                            <td><asp:Label ID="lblTelefono" runat="server"></asp:Label></td>
                                            <td>&nbsp;&nbsp;&nbsp;<br /><br /></td>
                                            <td>Empresa:</td>
                                            <td><asp:Label ID="lblEmpresa" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>

                                </td>
                                <td width="170px" align="center">
                                    <div id="divFoto" class="foto_empleado_detalle" style="<%=FotoEmpleado()%>;background-size:170px 200px;"></div>
                                    
                                </td>
                            </tr>
                        </table>
                    </td><td background="/images/centro_bak.png"></td></tr><tr><td width="5" height="5"><img src="/images/centro_ii.png" /></td><td colspan="3" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_id.png" /></td></tr></table>


                <br />

                </div>

            </td>
        </tr>
    </table>
    <asp:TextBox ID="txtFoto" runat="server" style="display:none;"></asp:TextBox>
    <asp:TextBox ID="requierePassword" runat="server" Text="0" Visible="false"></asp:TextBox>
</asp:Content>

<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="AutorizacionesConfig.aspx.vb" Inherits="Intranet.AutorizacionesConfig" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Panel ID="pnlBusqueda" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="600px">
            <tr>
                <td><strong>Configuracion de Autorizaciones</strong><hr style="margin:0; padding:0;" /></td>
            </tr>
        </table>
    </asp:Panel>
    <br /><br />

    <table>
        <tr>
            <td colspan="3" style="font-size:13px"><strong>Project Managers</strong></td>
        </tr>
        <tr>
            <td>
                Empleados disponibles:<br />
                <asp:ListBox ID="lstEmpleadosProyectManagersDisponibles" runat="server" Width="250px" Height="200px" SelectionMode="Multiple"></asp:ListBox>
            </td>
            <td>
                <asp:ImageButton ID="btnProyectManagersLeft" runat="server" ImageUrl="/images/left.png" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:ImageButton ID="btnProyectManagersRight" runat="server" ImageUrl="/images/right.png" />
            </td>
            <td>
                Empleados asignados:<br />
                <asp:ListBox ID="lstEmpleadosProyectManagersAsignados" runat="server" Width="250px" Height="200px" SelectionMode="Multiple"></asp:ListBox>
            </td>
        </tr>
    </table>
    <br /><br />

    <table id="tblEmpleadosVer" runat="server">
        <tr>
            <td colspan="3" style="font-size:13px"><strong>Contabilidad</strong></td>
        </tr>
        <tr>
            <td>
                Empleados disponibles:<br />            
                <asp:ListBox ID="lstEmpleadosContabilidadDisponibles" runat="server" Width="250px" Height="200px" SelectionMode="Multiple"></asp:ListBox>
            </td>
            <td>
                <asp:ImageButton ID="btnContabilidadLeft" runat="server" ImageUrl="/images/left.png" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:ImageButton ID="btnContabilidadRight" runat="server" ImageUrl="/images/right.png" style="height: 40px" />
            </td>
            <td>
                Empleados asignados:<br />
                <asp:ListBox ID="lstEmpleadosContabilidadAsignados" runat="server" Width="250px" Height="200px" SelectionMode="Multiple"></asp:ListBox>
            </td>
        </tr>
    </table>

    <br /><br />

    <table>
        <tr>
            <td colspan="3" style="font-size:13px"><strong>Encargado de Nominas</strong></td>
        </tr>
        <tr>
            <td>
                Empleados disponibles:<br />            
                <asp:ListBox ID="lstEmpleadosNominasDisponibles" runat="server" Width="250px" Height="200px" SelectionMode="Multiple"></asp:ListBox>
            </td>
            <td>
                <asp:ImageButton ID="btnNominasLeft" runat="server" ImageUrl="/images/left.png" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:ImageButton ID="btnNominasRight" runat="server" ImageUrl="/images/right.png" style="height: 40px" />
            </td>
            <td>
                Empleados asignados:<br />
                <asp:ListBox ID="lstEmpleadosNominasAsignados" runat="server" Width="250px" Height="200px" SelectionMode="Multiple"></asp:ListBox>
            </td>
        </tr>
    </table>
</asp:Content>

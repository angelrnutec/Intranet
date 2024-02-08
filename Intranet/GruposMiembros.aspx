<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="GruposMiembros.aspx.vb" Inherits="Intranet.GruposMiembros" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Panel ID="pnlBusqueda" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="600px">
            <tr>
                <td><span style="font-size:15px;">Permisos de Ver y Editar para el grupo: <strong><asp:Label ID="lblGrupoNombre" runat="server"></asp:Label></strong></span><hr style="margin:0; padding:0;" /></td>
            </tr>
        </table>
    </asp:Panel>
    <br /><br />

    <table>
        <tr>
            <td colspan="3" style="font-size:13px"><strong>Empleados que pueden hacer nuevas publicaciones para este grupo</strong></td>
        </tr>
        <tr>
            <td>
                Empleados disponibles:<br />
                <asp:ListBox ID="lstEmpleadosPublicanDisponibles" runat="server" Width="250px" Height="200px" SelectionMode="Multiple"></asp:ListBox>
            </td>
            <td>
                <asp:ImageButton ID="btnPublicanLeft" runat="server" ImageUrl="/images/left.png" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:ImageButton ID="btnPublicanRight" runat="server" ImageUrl="/images/right.png" />
            </td>
            <td>
                Empleados asignados:<br />
                <asp:ListBox ID="lstEmpleadosPublicanAsignados" runat="server" Width="250px" Height="200px" SelectionMode="Multiple"></asp:ListBox>
            </td>
        </tr>
    </table>
    <br /><br />

    <table id="tblEmpleadosVer" runat="server">
        <tr>
            <td colspan="3" style="font-size:13px"><strong>Empleados que pueden ver las publicaciones de este grupo</strong></td>
        </tr>
        <tr>
            <td>
                Empleados disponibles:<br />
                <asp:ListBox ID="lstEmpleadosVenDisponibles" runat="server" Width="250px" Height="200px" SelectionMode="Multiple"></asp:ListBox>
            </td>
            <td>
                <asp:ImageButton ID="btnVenLeft" runat="server" ImageUrl="/images/left.png" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:ImageButton ID="btnVenRight" runat="server" ImageUrl="/images/right.png" />
            </td>
            <td>
                Empleados asignados:<br />
                <asp:ListBox ID="lstEmpleadosVenAsignados" runat="server" Width="250px" Height="200px" SelectionMode="Multiple"></asp:ListBox>
            </td>
        </tr>
    </table>
    <br /><br />

    <table id="tblDepartamentos" runat="server">
        <tr>
            <td colspan="3" style="font-size:13px"><strong>Departamentos que pueden ver las publicaciones de este grupo</strong></td>
        </tr>
        <tr>
            <td>
                Departamentos disponibles:<br />
                <asp:ListBox ID="lstDepartamentosVenDisponibles" runat="server" Width="250px" Height="200px" SelectionMode="Multiple"></asp:ListBox>
            </td>
            <td>
                <asp:ImageButton ID="btnDepLeft" runat="server" ImageUrl="/images/left.png" />
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:ImageButton ID="btnDepRight" runat="server" ImageUrl="/images/right.png" />
            </td>
            <td>
                Departamentos asignados:<br />
                <asp:ListBox ID="lstDepartamentosVenAsignados" runat="server" Width="250px" Height="200px" SelectionMode="Multiple"></asp:ListBox>
            </td>
        </tr>
    </table>
    <asp:TextBox ID="txtId" runat="server" Text="0" Visible="false"></asp:TextBox>
</asp:Content>

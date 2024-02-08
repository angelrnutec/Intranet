<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="EmpleadosAsignacionTarjetas.aspx.vb" Inherits="Intranet.EmpleadosAsignacionTarjetas" %>
<%@ Register TagPrefix="asp" Assembly="ExportToExcel" Namespace="KrishLabs.Web.Controls" %>

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


    <asp:Panel ID="pnlBusqueda" runat="server" DefaultButton="btnBuscar">
        <table cellpadding="0" cellspacing="0" border="0" width="600px">
            <tr>
                <td colspan="3"><span style="font-size:15px; font-weight:bold;">Asignación de Tarjetas de Gastos</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;&nbsp;Ingrese el texto de busqueda: (<i>Numero o Nombre del empleado</i>)</td>
                <td><asp:TextBox ID="txtBusqueda" runat="server" Width="120px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;&nbsp;Empresa:</td>
                <td><asp:DropDownList ID="ddlEmpresa" runat="server"></asp:DropDownList></td>
            </tr>
            <tr>
                <td colspan="2" align="right">
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="botones" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <asp:GridView ID="gvResultados" runat="server" CssClass="grid" Width="1000"
         EmptyDataText="No se encontraron resultados para la busqueda realizada" AutoGenerateColumns="False" 
         AllowSorting="True" AllowPaging="false">
         <HeaderStyle CssClass="grid_header" />
         <AlternatingRowStyle CssClass="grid_alternating" />
          <Columns>
            <asp:BoundField HeaderText="Empleado" SortExpression="nombre" DataField="nombre" />
            <asp:BoundField HeaderText="Empresa" SortExpression="empresa" DataField="empresa" />
            <asp:TemplateField HeaderText="Tarjeta TE" SortExpression="num_tarjeta_gastos">
            <ItemTemplate>
                <div align="center">
                    <asp:Label ID="lblTarjetaTE" runat="server" Text='<%# Eval("num_tarjeta_gastos")%>' />
                    <asp:TextBox ID="txtTarjetaTE" runat="server" Width="120px" Visible="false" Text='<%# Eval("num_tarjeta_gastos")%>' MaxLength="5"></asp:TextBox>
                </div>
            </ItemTemplate>
            </asp:TemplateField>                          
            <asp:TemplateField HeaderText="Tarjeta AMEX" SortExpression="num_tarjeta_gastos_amex">
            <ItemTemplate>
                <div align="center">
                    <asp:Label ID="lblTarjetaAMEX" runat="server" Text='<%# Eval("num_tarjeta_gastos_amex")%>' />
                    <asp:TextBox ID="txtTarjetaAMEX" runat="server" Width="120px" Visible="false" Text='<%# Eval("num_tarjeta_gastos_amex")%>' MaxLength="15"></asp:TextBox>
                </div>
            </ItemTemplate>
            </asp:TemplateField>                          
            <asp:TemplateField HeaderText="Acciones">
                <ItemTemplate>
                    <div align="center">
                        <asp:ImageButton ID="btnEdit" runat="server" ImageUrl="/images/edit.png" CommandName="editar" ToolTip="Editar" CommandArgument='<%# Bind("id_empleado")%>' />
                        &nbsp;&nbsp;
                        <asp:ImageButton ID="btnSave" runat="server" ImageUrl="/images/save.png" CommandName="save" Visible="false" ToolTip="Guardar" CommandArgument='<%# Bind("id_empleado")%>' />
                        &nbsp;&nbsp;
                        <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="/images/cancel.png" CommandName="cancelar" Visible="false" ToolTip="Cancelar" />
                    </div>

                </ItemTemplate>
            </asp:TemplateField>
          </Columns>
    </asp:GridView>
</asp:Content>

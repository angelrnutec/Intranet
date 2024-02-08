﻿<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="TelcelAsignacion.aspx.vb" Inherits="Intranet.TelcelAsignacion" %>
<%@ Register TagPrefix="asp" Assembly="ExportToExcel" Namespace="KrishLabs.Web.Controls" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
    <asp:Panel ID="pnlBusqueda" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="650px">
            <tr>
                <td colspan="6"><span style="font-size:15px; font-weight:bold;">Telefonos Asignados</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr valign="top">
                <td>
                    Empresa:
                </td>
                <td>
                    <asp:DropDownList ID="ddlEmpresa" runat="server" Width="160px"></asp:DropDownList>
                </td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
                <td>
                    Empleado:
                </td>
                <td>
                    <asp:TextBox ID="txtNombre" runat="server" Width="100px"></asp:TextBox>
                </td>
                <td align="left" rowspan="2">
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" />
                    &nbsp;
                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar"  />                    
                    <br />
                    <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvResultados" ExportFileName="EmpleadosTelefono_.xls" Text="Exportar a Excel" IncludeTimeStamp="true"  ColumnsToExclude="4" EnableHyperLinks="false" Width="217px" />
                    <br />
                    <asp:ExportToExcel runat="server" ID="ExportToExcel2" GridViewID="gvResultados2" ExportFileName="HistoricoDesasignacion_.xls" Text="Historico de Lineas Desasignadas" IncludeTimeStamp="true" EnableHyperLinks="false" Width="217px" />
                </td>
            </tr>
            <tr>
                <td>Telefono Asignado:</td>
                <td><asp:TextBox ID="txtNumero" runat="server" Width="157px"></asp:TextBox></td>
                <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                </td>
                <td></td>
                <td></td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <asp:GridView ID="gvResultados" runat="server" CssClass="grid" Width="950px" PageSize="50" 
         EmptyDataText="No se encontraron resultados para la busqueda realizada" AutoGenerateColumns="False" 
         AllowSorting="True" AllowPaging="False" AutoGenerateEditButton="false" AutoGenerateDeleteButton="false">
         <HeaderStyle CssClass="grid_header" />
         <AlternatingRowStyle CssClass="grid_alternating" />
          <Columns>
              <asp:BoundField HeaderText="Empleado" SortExpression="empleado" DataField="empleado" />
              <asp:TemplateField HeaderText="Telefono" SortExpression="numero">
                  <ItemTemplate>
                    <asp:Label ID="lblDescripcion" runat="server" Text='<%# Bind("numero")%>' />
                    <asp:TextBox id="txtDescripcion" runat="server" text='<%# Bind("numero")%>' Visible="false" />
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField HeaderText="Empresa" SortExpression="empresa" DataField="empresa" />
              <asp:BoundField HeaderText="Estatus" SortExpression="estatus" DataField="estatus" />
              <asp:BoundField HeaderText="Jefe Directo" SortExpression="empleado_jefe_directo" DataField="empleado_jefe_directo" />
              <asp:BoundField HeaderText="Gerente" SortExpression="empleado_gerente" DataField="empleado_gerente" />
              <asp:BoundField HeaderText="Jefe de Area" SortExpression="empleado_jefe_area" DataField="empleado_jefe_area" />
              <asp:TemplateField HeaderText="Desasignar">
                  <ItemTemplate>
                      <div align="center">
                          <asp:ImageButton ID="btnDelete" runat="server" ImageUrl="/images/down.png" CommandName="eliminar" ToolTip="Desasignar" CommandArgument='<%# Bind("id")%>' OnClientClick="return confirm('Seguro que desea desasignar este telefono?');" />
                      </div>
                  </ItemTemplate>
              </asp:TemplateField>
          </Columns>
    </asp:GridView>
    <br />    
    <asp:GridView ID="gvResultados2" runat="server" CssClass="grid"
         EmptyDataText="No se encontraron resultados para la busqueda realizada" AutoGenerateColumns="False" 
         AllowSorting="True" AllowPaging="False" AutoGenerateEditButton="false" AutoGenerateDeleteButton="false" Visible="false">
         <HeaderStyle CssClass="grid_header" />
         <AlternatingRowStyle CssClass="grid_alternating" />
          <Columns>
              <asp:BoundField HeaderText="Empleado" SortExpression="empleado" DataField="empleado" />
              <asp:BoundField HeaderText="Telefono" SortExpression="numero" DataField="numero" />
              <asp:BoundField HeaderText="Empresa" SortExpression="empresa" DataField="empresa" />
              <asp:BoundField HeaderText="Fecha de asignacion" SortExpression="fecha_asignacion" DataField="fecha_asignacion" DataFormatString="{0:dd/MM/yyyy}" />
              <asp:BoundField HeaderText="Fecha de desasignacion" SortExpression="fecha_desasignacion" DataField="fecha_desasignacion" DataFormatString="{0:dd/MM/yyyy}" />
              <asp:BoundField HeaderText="Linea asignada actualmente a" SortExpression="linea_asignada" DataField="linea_asignada" />
          </Columns>
    </asp:GridView>

</asp:Content>
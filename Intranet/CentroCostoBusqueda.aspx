<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="CentroCostoBusqueda.aspx.vb" Inherits="Intranet.CentroCostoBusqueda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
    <asp:Panel ID="pnlBusqueda" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="600px">
            <tr>
                <td colspan="3"><span style="font-size:15px; font-weight:bold;">Centro de Costos</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr valign="top">
                <td>
                    Empresa:
                    <asp:DropDownList ID="ddlEmpresa" runat="server" Width="250px"></asp:DropDownList>
                </td>
                <td align="right">
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="botones" />
                    &nbsp;
                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar" CssClass="botones" />                    
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <asp:GridView ID="gvResultados" runat="server" CssClass="grid" Width="630px" PageSize="50" 
         EmptyDataText="No se encontraron resultados para la busqueda realizada" AutoGenerateColumns="False" 
         AllowSorting="True" AllowPaging="False">
         <HeaderStyle CssClass="grid_header" />
         <AlternatingRowStyle CssClass="grid_alternating" />
          <Columns>
              <asp:TemplateField HeaderText="Clave" SortExpression="clave">
                  <ItemTemplate>
                      <a href='<%# "/CentroCostoVer.aspx?id=" & Eval("id_centro_costo")%>'><%# Eval("clave")%></a>
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField HeaderText="Descripcion" SortExpression="descripcion" DataField="descripcion" />
              <asp:BoundField HeaderText="Empresa" SortExpression="empresa" DataField="empresa" />
          </Columns>
    </asp:GridView>
    <br />    
</asp:Content>

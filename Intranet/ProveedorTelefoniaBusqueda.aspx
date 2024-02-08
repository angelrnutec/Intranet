<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="ProveedorTelefoniaBusqueda.aspx.vb" Inherits="Intranet.ProveedorTelefoniaBusqueda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
    <asp:Panel ID="pnlBusqueda" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="600px">
            <tr>
                <td colspan="3"><span style="font-size:15px; font-weight:bold;">Proveedor de Telefonia</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr valign="top">
                <td>
                    Concepto:
                    <asp:DropDownList ID="ddlConcepto" runat="server" Width="250px"></asp:DropDownList>
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
              <asp:BoundField HeaderText="Nombre" SortExpression="nombre" DataField="nombre" />
              <asp:BoundField HeaderText="Concepto en reporte" SortExpression="concepto" DataField="concepto" />
              <asp:TemplateField HeaderText="Acciones" SortExpression="Acciones">
                  <ItemTemplate>
                      <a href='<%# "/ProveedorTelefoniaVer.aspx?id=" & Eval("id_proveedor")%>'><img src="/images/edit.png" width="22px" /></a>
                  </ItemTemplate>
              </asp:TemplateField>
          </Columns>
    </asp:GridView>
    <br />    
</asp:Content>

<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="ArrendamientoListado.aspx.vb" Inherits="Intranet.ArrendamientoListado" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
    <asp:Panel ID="pnlBusqueda" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="600px">
            <tr>
                <td colspan="3"><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Arrendamientos")%></span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr valign="top">
                <td>
                    <%=TranslateLocale.text("Empresa")%>:
                </td>
                <td>
                    <asp:DropDownList ID="ddlEmpresa" runat="server" Width="250px"></asp:DropDownList>
                </td>
                <td align="right" rowspan="2">
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="botones" />
                    &nbsp;
                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar" CssClass="botones" />                    
                </td>
            </tr>
            <tr valign="top">
                <td>
                    <%=TranslateLocale.text("Categoría de Arrendamiento")%>:
                </td>
                <td>
                    <asp:DropDownList ID="ddlCategoriaArrendamiento" runat="server" Width="250px"></asp:DropDownList>
                </td>
                <td></td>
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
              <asp:TemplateField HeaderText="Numero" SortExpression="numero">
                  <ItemTemplate>
                      <a href='<%# "/ArrendamientoDetalle.aspx?id=" & Eval("id_arrendamiento")%>'><%# Eval("numero")%></a>
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField HeaderText="Tipo" SortExpression="tipo_arrendamiento" DataField="tipo_arrendamiento" />
              <asp:BoundField HeaderText="Empresa" SortExpression="empresa" DataField="empresa" />
              <asp:BoundField HeaderText="Arrendadora" SortExpression="arrendadora" DataField="arrendadora" />
              <asp:BoundField HeaderText="Importe de Pagos" SortExpression="importe_parcialidades" DataField="importe_parcialidades" DataFormatString="{0:C2}" />
              <asp:BoundField HeaderText="Importe Total" SortExpression="importe_total" DataField="importe_total" DataFormatString="{0:C2}" />
          </Columns>
    </asp:GridView>
    <br />    
</asp:Content>

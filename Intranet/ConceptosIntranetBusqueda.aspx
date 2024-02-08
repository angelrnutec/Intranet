<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="ConceptosIntranetBusqueda.aspx.vb" Inherits="Intranet.ConceptosIntranetBusqueda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
    <asp:Panel ID="pnlBusqueda" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="600px">
            <tr>
                <td colspan="3"><span style="font-size:15px; font-weight:bold;">Necesidades</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr valign="top">
                <td>
                    Texto:
                    <asp:TextBox ID="txtTexto" runat="server"></asp:TextBox>
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
              <asp:TemplateField HeaderText="Descripcion" SortExpression="descripcion">
                  <ItemTemplate>
                      <a href='<%# "/ConceptosIntranetVer.aspx?id=" & Eval("id_clasificacion_costo")%>'><%# Eval("descripcion")%></a>
                  </ItemTemplate>
              </asp:TemplateField>
          </Columns>
    </asp:GridView>
    <br />    
</asp:Content>

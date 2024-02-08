<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="ConceptoGastoBusqueda.aspx.vb" Inherits="Intranet.ConceptoGastoBusqueda" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
    <asp:Panel ID="pnlBusqueda" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="600px">
            <tr>
                <td colspan="3"><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Concepto de Gastos")%></span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td colspan="2" align="right">
                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar" CssClass="botones" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <asp:GridView ID="gvResultados" runat="server" CssClass="grid" Width="630px" PageSize="50" 
         EmptyDataText="No se encontraron resultados para la busqueda realizada" AutoGenerateColumns="False" 
         AllowSorting="True" AllowPaging="true">
         <HeaderStyle CssClass="grid_header" />
         <AlternatingRowStyle CssClass="grid_alternating" />
          <Columns>
              <asp:TemplateField HeaderText="Clave" SortExpression="clave">
                  <ItemTemplate>
                      <a href='<%# "/ConceptoGastoVer.aspx?id=" & Eval("id_concepto")%>'><%# Eval("clave")%></a>
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField HeaderText="Descripción" SortExpression="descripcion" DataField="descripcion" />
              <asp:BoundField HeaderText="Descripción ingles" SortExpression="descripcion_en" DataField="descripcion_en" />
              <asp:BoundField HeaderText="Tipo" SortExpression="tipo_desc" DataField="tipo_desc" />
          </Columns>
    </asp:GridView>
    <br />    
</asp:Content>

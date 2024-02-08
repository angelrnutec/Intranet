<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="VacacionesTabuladorBusqueda.aspx.vb" Inherits="Intranet.VacacionesTabuladorBusqueda" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
    <asp:Panel ID="pnlBusqueda" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="600px">
            <tr>
                <td colspan="3"><span style="font-size:15px; font-weight:bold;">Tabulador de Vacaciones</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr valign="top">
                <td align="right">
                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar nuevo tabulador" CssClass="botones" />                    
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
              <asp:BoundField HeaderText="Tipo de Tabla" SortExpression="tipo_tabla" DataField="tipo_tabla" DataFormatString="{0:dd/MM/yyyy}" />
              <asp:BoundField HeaderText="Fecha de Efectividad" SortExpression="fecha_efectividad" DataField="fecha_efectividad" DataFormatString="{0:dd/MM/yyyy}" />
              <asp:TemplateField HeaderText="Acciones" SortExpression="Acciones">
                  <ItemTemplate>
                      <a href='<%# "/VacacionesTabuladorVer.aspx?fe=" & Eval("fecha_efectividad", "{0:yyyyMMdd}") & "&id=" & Eval("id_tabla_vacaciones")%>'><img src="/images/edit.png" width="22px" /></a>
                  </ItemTemplate>
              </asp:TemplateField>   
          </Columns>
    </asp:GridView>
    <br />    
</asp:Content>

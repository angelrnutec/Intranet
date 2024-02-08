<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="PublicacionesBusqueda.aspx.vb" Inherits="Intranet.PublicacionesBusqueda" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Panel ID="pnlBusqueda" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="720px">
            <tr>
                <td colspan="5"><span style="font-size:15px; font-weight:bold;"><%=Translatelocale.text("Administracion de Contenidos")%></span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td><br />
                    <asp:RadioButton ID="rbVisible" runat="server" Text="Publicaciones Visibles" Checked="true" GroupName="Visible" AutoPostBack="true" /><br />
                    <asp:RadioButton ID="rbNoVisible" runat="server" Text="Publicaciones Ocultas" GroupName="Visible" AutoPostBack="true" />
                </td>
                <td>&nbsp;
                </td>
                <td><br />
                    <asp:RadioButton ID="rbActivo" runat="server" Text="Publicaciones Activas" Checked="true" GroupName="Activo" AutoPostBack="true" /><br />
                    <asp:RadioButton ID="rbBorrado" runat="server" Text="Publicaciones Borradas" GroupName="Activo" AutoPostBack="true" />
                </td>
                <td>&nbsp;
                </td>
                <td><br />
                    <asp:Button ID="btnAgregar" runat="server" CssClass="botones" Text="Agregar Publicacion" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <asp:GridView ID="gvResultados" runat="server" CssClass="grid" Width="720px" 
         EmptyDataText="No se encontraron resultados para la busqueda realizada" AutoGenerateColumns="False" 
         AllowSorting="false" AllowPaging="true" PageSize="20">
         <HeaderStyle CssClass="grid_header" />
         <AlternatingRowStyle CssClass="grid_alternating" />
          <Columns>
              <asp:TemplateField HeaderText="Titulo" SortExpression="titulo">
                  <ItemTemplate>
                      <a href='<%# "/PublicacionesAgregar.aspx?id=" & Eval("id_publicacion")%>'><%# Eval("titulo") %></a>
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField HeaderText="Tipo" DataField="tipo_publicacion" />
              <asp:BoundField HeaderText="Fecha de publicacion" DataField="fecha_publicacion" DataFormatString="{0:dd/MM/yyyy hh:mm ttt}" />
              <asp:BoundField HeaderText="Publicado por" DataField="empleado" />
          </Columns>
    </asp:GridView>

</asp:Content>

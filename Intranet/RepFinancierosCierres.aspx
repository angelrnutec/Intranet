<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="RepFinancierosCierres.aspx.vb" Inherits="Intranet.RepFinancierosCierres" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Panel ID="pnlBusqueda" runat="server" DefaultButton="btnBuscar">
        <table cellpadding="0" cellspacing="0" border="0" width="600px">
            <tr>
                <td colspan="3"><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Cierres de Reportes Financieros") %></span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;&nbsp;<%=TranslateLocale.text("Seleccione el año a consultar") %>:</td>
                <td><asp:DropDownList ID="ddlAnio" runat="server" Width="100px" AutoPostBack="true"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;&nbsp;<%=TranslateLocale.text("Seleccione el periodo a consultar")%>:</td>
                <td>
                    <asp:DropDownList ID="ddlPeriodo" runat="server" Width="100px" AutoPostBack="true">
                        <asp:ListItem Value="1" Text="Enero"></asp:ListItem>
                        <asp:ListItem Value="2" Text="Febrero"></asp:ListItem>
                        <asp:ListItem Value="3" Text="Marzo"></asp:ListItem>
                        <asp:ListItem Value="4" Text="Abril"></asp:ListItem>
                        <asp:ListItem Value="5" Text="Mayo"></asp:ListItem>
                        <asp:ListItem Value="6" Text="Junio"></asp:ListItem>
                        <asp:ListItem Value="7" Text="Julio"></asp:ListItem>
                        <asp:ListItem Value="8" Text="Agosto"></asp:ListItem>
                        <asp:ListItem Value="9" Text="Septiembre"></asp:ListItem>
                        <asp:ListItem Value="10" Text="Octubre"></asp:ListItem>
                        <asp:ListItem Value="11" Text="Noviembre"></asp:ListItem>
                        <asp:ListItem Value="12" Text="Diciembre"></asp:ListItem>
                        <asp:ListItem Value="13" Text="Pronostico Anual"></asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="right">
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="botones" />
                </td>
            </tr>
        </table>
    </asp:Panel>

    <br />
    <asp:GridView ID="gvResultados" runat="server" CssClass="grid" Width="630px" PageSize="50" 
         EmptyDataText="No se encontraron resultados para la busqueda realizada" AutoGenerateColumns="False" 
         AllowSorting="True" AllowPaging="true" DataKeyNames="id_detalle, estatus">
         <HeaderStyle CssClass="grid_header" />
         <AlternatingRowStyle CssClass="grid_alternating" />
          <Columns>
              <asp:BoundField HeaderText="Empresa" SortExpression="empresa" DataField="empresa" />
              <asp:BoundField HeaderText="Año" SortExpression="anio" DataField="anio" />
              <asp:BoundField HeaderText="Mes" SortExpression="mes_descripcion" DataField="mes_descripcion" />              
              <asp:BoundField HeaderText="Estatus" SortExpression="estatus_descripcion" DataField="estatus_descripcion" />  
              <asp:TemplateField HeaderText="Acciones">
                  <ItemTemplate>
                      <div align="center">
                          <asp:ImageButton ID="btnAbrir" runat="server" ImageUrl="/images/open-folder-icon.png" CommandName="abrir" ToolTip="Abrir Periodo" CommandArgument='<%# Bind("id_detalle")%>' />                          
                          <asp:ImageButton ID="btnCerrar" runat="server" ImageUrl="/images/close-folder-icon.png" CommandName="cerrar" ToolTip="Cerrar Periodo" CommandArgument='<%# Bind("id_detalle")%>' />
                          <asp:Label ID="lblAnio" runat="server" Text='<%# Bind("anio")%>' style="display:none;" />
                          <asp:Label ID="lblMes" runat="server" Text='<%# Bind("mes")%>' style="display:none;"  />                          
                          <asp:Label ID="lblIdEmpresa" runat="server" Text='<%# Bind("id_empresa")%>' style="display:none;"  />                          
                      </div>
                  </ItemTemplate>
              </asp:TemplateField>                          
          </Columns>
    </asp:GridView>    

</asp:Content>

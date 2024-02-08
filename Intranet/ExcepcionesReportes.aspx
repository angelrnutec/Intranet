<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="ExcepcionesReportes.aspx.vb" Inherits="Intranet.ExcepcionesReportes" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
    <asp:Panel ID="pnlBusqueda" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="700px">
            <tr>
                <td><span style="font-size:15px; font-weight:bold;">Excepciones para reportes</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td><br /><br /><b>Excepciones de Tipo de Costo</b></td>
            </tr>
            <tr>
                <td valign="middle">
                    Tipo de Costo:
                    &nbsp;&nbsp;
                    <asp:TextBox ID="txtTipoCosto" runat="server" Text=""></asp:TextBox>
                    &nbsp;&nbsp;
                    <asp:Button ID="btnAgregarTipoCosto" runat="server" Text="Agregar" CssClass="botones" />                   
                </td>
            </tr>
            <tr>
                <td>
                    <br />
                    <asp:GridView ID="gvResultadosTipoCosto" runat="server" CssClass="grid" Width="630px"  
                         EmptyDataText="No se encontraron resultados para la busqueda realizada" AutoGenerateColumns="False" DataKeyNames="id"
                         AllowSorting="false" AllowPaging="false">
                         <HeaderStyle CssClass="grid_header" />
                         <AlternatingRowStyle CssClass="grid_alternating" />
                          <Columns>                              
                              <asp:TemplateField HeaderText="Tipo de Costo" SortExpression="Tipo de Costo">
                                  <ItemTemplate>                      
                                      <asp:TextBox ID="txtTipoCosto" runat="server" Text='<%# Eval("tipo_costo")%>' Visible="false"></asp:TextBox>
                                      <asp:Label ID="lblTipoCosto" runat="server" Text='<%# Eval("tipo_costo")%>'></asp:Label>
                                  </ItemTemplate> 
                              </asp:TemplateField>
                             <asp:TemplateField HeaderText="Acciones" SortExpression="Acciones">
                                  <ItemTemplate>                      
                                      <asp:ImageButton ID="btnEdit" runat="server" ImageUrl="/images/edit.png" CommandName="edit" ToolTip="Editar" CommandArgument='<%# Eval("id")%>' />
                                      &nbsp;
                                      <asp:ImageButton ID="btnDelete" runat="server" ImageUrl="/images/delete.png" CommandName="eliminar" ToolTip="Eliminar" CommandArgument='<%# Eval("id")%>' OnClientClick="return confirm('Seguro que desea eliminar este registro?');" />
                                      &nbsp;
                                      <asp:ImageButton ID="btnSave" runat="server" ImageUrl="/images/save.png" CommandName="save" Visible="false" ToolTip="Guardar" CommandArgument='<%# Eval("id")%>' />
                                      &nbsp;
                                      <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="/images/cancel.png" CommandName="cancel" Visible="false" ToolTip="Cancelar" />
                                  </ItemTemplate> 
                              </asp:TemplateField>
                          </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td><br /><br /><b>Excepciones de Centro de Costo</b></td>
            </tr>
            <tr>
                <td valign="middle">
                    Centro de Costo:
                    &nbsp;&nbsp;
                    <asp:TextBox ID="txtCentroCosto" runat="server" Text=""></asp:TextBox>
                    &nbsp;&nbsp;
                    <asp:Button ID="btnAgregarCentroCosto" runat="server" Text="Agregar" CssClass="botones" />
                </td>
            </tr>
            <tr>
                <td>   
                    <br />
                    <asp:GridView ID="gvResultadosCentroCosto" runat="server" CssClass="grid" Width="630px"  
                         EmptyDataText="No se encontraron resultados para la busqueda realizada" AutoGenerateColumns="False" DataKeyNames="id"
                         AllowSorting="false" AllowPaging="false">
                         <HeaderStyle CssClass="grid_header" />
                         <AlternatingRowStyle CssClass="grid_alternating" />
                          <Columns>                              
                              <asp:TemplateField HeaderText="Centro de Costo" SortExpression="Centro de Costo">
                                  <ItemTemplate>                      
                                      <asp:TextBox ID="txtCentroCosto" runat="server" Text='<%# Eval("centro_costo")%>' Visible="false"></asp:TextBox>
                                      <asp:Label ID="lblCentroCosto" runat="server" Text='<%# Eval("centro_costo")%>'></asp:Label>
                                  </ItemTemplate> 
                              </asp:TemplateField>
                              <asp:TemplateField HeaderText="Acciones" SortExpression="Acciones">
                                  <ItemTemplate>                      
                                      <asp:ImageButton ID="btnEdit" runat="server" ImageUrl="/images/edit.png" CommandName="edit" ToolTip="Editar" CommandArgument='<%# Eval("id")%>' />
                                      &nbsp;
                                      <asp:ImageButton ID="btnDelete" runat="server" ImageUrl="/images/delete.png" CommandName="eliminar" ToolTip="Eliminar" CommandArgument='<%# Eval("id")%>' OnClientClick="return confirm('Seguro que desea eliminar este registro?');" />
                                      &nbsp;
                                      <asp:ImageButton ID="btnSave" runat="server" ImageUrl="/images/save.png" CommandName="save" Visible="false" ToolTip="Guardar" CommandArgument='<%# Eval("id")%>' />
                                      &nbsp;
                                      <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="/images/cancel.png" CommandName="cancel" Visible="false" ToolTip="Cancelar" />
                                  </ItemTemplate> 
                              </asp:TemplateField>
                          </Columns>
                    </asp:GridView>
                </td>
            </tr>
        </table>
    </asp:Panel>
   

    <br />      
</asp:Content>

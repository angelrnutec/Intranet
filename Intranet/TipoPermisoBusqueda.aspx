<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="TipoPermisoBusqueda.aspx.vb" Inherits="Intranet.TipoPermisoBusqueda" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

        <table cellpadding="0" cellspacing="0" border="0" width="700px">
            <tr>
                <td colspan="1"><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Catalogo de Tipos de Permiso")%></span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar" CssClass="botones" />
                </td>
            </tr>
        </table>
    <br />
    <div id="divNuevo" runat="server" style="width:730px">
        <table>
            <tr>
                <td colspan="2"><%=TranslateLocale.text("Ingrese los datos del nuevo Tipo de Permiso")%></td>
            </tr>
            <tr>
                <td><%=TranslateLocale.text("Descripción")%></td>
                <td><asp:TextBox ID="txtDescripcionNuevo" runat="server" Width="200px" MaxLength="256"></asp:TextBox></td>
            </tr>
            <tr>
                <td><%=TranslateLocale.text("Descripción ingles")%></td>
                <td><asp:TextBox ID="txtDescripcionEnNuevo" runat="server" Width="200px" MaxLength="256"></asp:TextBox></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td><asp:CheckBox ID="chkConGoceNuevo" runat="server" Text="Con Goce de Sueldo" /></td>
            </tr>
            <tr>
                <td>&nbsp;</td>
                <td><asp:CheckBox ID="chkSinGoceNuevo" runat="server" Text="Sin Goce de Sueldo" /></td>
            </tr>
            <tr>
                <td><%=TranslateLocale.text("Limite de dias")%></td>
                <td><asp:DropDownList ID="ddlMaxDiasNuevo" runat="server">
                        <asp:ListItem Value="999" Text="Sin Limite"></asp:ListItem>
                        <asp:ListItem Value="1" Text="1"></asp:ListItem>
                        <asp:ListItem Value="2" Text="2"></asp:ListItem>
                        <asp:ListItem Value="3" Text="3"></asp:ListItem>
                        <asp:ListItem Value="4" Text="4"></asp:ListItem>
                        <asp:ListItem Value="5" Text="5"></asp:ListItem>
                        <asp:ListItem Value="6" Text="6"></asp:ListItem>
                        <asp:ListItem Value="7" Text="7"></asp:ListItem>
                        <asp:ListItem Value="8" Text="8"></asp:ListItem>
                        <asp:ListItem Value="9" Text="9"></asp:ListItem>
                        <asp:ListItem Value="10" Text="10"></asp:ListItem>
                        <asp:ListItem Value="11" Text="11"></asp:ListItem>
                        <asp:ListItem Value="12" Text="12"></asp:ListItem>
                        <asp:ListItem Value="13" Text="13"></asp:ListItem>
                        <asp:ListItem Value="14" Text="14"></asp:ListItem>
                        <asp:ListItem Value="15" Text="15"></asp:ListItem>
                        <asp:ListItem Value="16" Text="16"></asp:ListItem>
                        <asp:ListItem Value="17" Text="17"></asp:ListItem>
                        <asp:ListItem Value="18" Text="18"></asp:ListItem>
                        <asp:ListItem Value="19" Text="19"></asp:ListItem>
                        <asp:ListItem Value="20" Text="20"></asp:ListItem>
                        <asp:ListItem Value="21" Text="21"></asp:ListItem>
                        <asp:ListItem Value="22" Text="22"></asp:ListItem>
                        <asp:ListItem Value="23" Text="23"></asp:ListItem>
                        <asp:ListItem Value="24" Text="24"></asp:ListItem>
                        <asp:ListItem Value="25" Text="25"></asp:ListItem>
                        <asp:ListItem Value="26" Text="26"></asp:ListItem>
                        <asp:ListItem Value="27" Text="27"></asp:ListItem>
                        <asp:ListItem Value="28" Text="28"></asp:ListItem>
                        <asp:ListItem Value="29" Text="29"></asp:ListItem>
                        <asp:ListItem Value="30" Text="30"></asp:ListItem>
                    </asp:DropDownList></td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="botones" />
                    &nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnCancelar" runat="server" Text="Salir" CssClass="botones" />
                </td>
            </tr>
        </table>
    </div>
    <asp:GridView ID="gvResultados" runat="server" CssClass="grid" Width="730px" 
         EmptyDataText="No se encontraron resultados para la busqueda realizada" AutoGenerateColumns="False" 
         AllowSorting="True" AllowPaging="true" AutoGenerateEditButton="false" AutoGenerateDeleteButton="false"
         DataKeyNames="id_tipo_permiso" PageSize="15">
         <HeaderStyle CssClass="grid_header" />
         <AlternatingRowStyle CssClass="grid_alternating" />
          <Columns>
              <asp:TemplateField HeaderText="Descripción" SortExpression="descripcion">
                    <ItemTemplate>
                            <asp:Label ID="lblDescripcion" runat="server" Text='<%# Bind("descripcion")%>' />
                            <asp:TextBox id="txtDescripcion" runat="server" text='<%# Bind("descripcion")%>' Visible="false" />
                    </ItemTemplate>
              </asp:TemplateField>              
              <asp:TemplateField HeaderText="Descripción ingles" SortExpression="descripcion">
                    <ItemTemplate>
                            <asp:Label ID="lblDescripcionEn" runat="server" Text='<%# Bind("descripcion_en")%>' />
                            <asp:TextBox id="txtDescripcionEn" runat="server" text='<%# Bind("descripcion_en")%>' Visible="false" />
                    </ItemTemplate>
              </asp:TemplateField>              
              <asp:TemplateField HeaderText="Con Goce" SortExpression="con_goce">
                    <ItemTemplate>
                            <asp:Label ID="lblConGoce" runat="server" Text='<%# Bind("con_goce_txt")%>' />
                            <asp:CheckBox ID="chkConGoce" runat="server" Checked='<%# Bind("con_goce")%>' Visible="false" />
                    </ItemTemplate>
              </asp:TemplateField>              
              <asp:TemplateField HeaderText="Sin Goce" SortExpression="sin_goce">
                    <ItemTemplate>
                            <asp:Label ID="lblSinGoce" runat="server" Text='<%# Bind("sin_goce_txt")%>' />
                            <asp:CheckBox ID="chkSinGoce" runat="server" Checked='<%# Bind("sin_goce")%>' Visible="false" />
                    </ItemTemplate>
              </asp:TemplateField>              
              <asp:TemplateField HeaderText="Limite de dias" SortExpression="sin_goce">
                    <ItemTemplate>
                            <asp:Label ID="lblMaxDiasDesc" runat="server" Text='<%# Bind("max_dias_desc")%>' />
                            <asp:Label ID="lblMaxDias" runat="server" Text='<%# Bind("max_dias")%>' Visible="false" />
                            <asp:DropDownList ID="ddlMaxDias" runat="server" Visible="false">
                                <asp:ListItem Value="999" Text="Sin Limite"></asp:ListItem>
                                <asp:ListItem Value="1" Text="1"></asp:ListItem>
                                <asp:ListItem Value="2" Text="2"></asp:ListItem>
                                <asp:ListItem Value="3" Text="3"></asp:ListItem>
                                <asp:ListItem Value="4" Text="4"></asp:ListItem>
                                <asp:ListItem Value="5" Text="5"></asp:ListItem>
                                <asp:ListItem Value="6" Text="6"></asp:ListItem>
                                <asp:ListItem Value="7" Text="7"></asp:ListItem>
                                <asp:ListItem Value="8" Text="8"></asp:ListItem>
                                <asp:ListItem Value="9" Text="9"></asp:ListItem>
                                <asp:ListItem Value="10" Text="10"></asp:ListItem>
                                <asp:ListItem Value="11" Text="11"></asp:ListItem>
                                <asp:ListItem Value="12" Text="12"></asp:ListItem>
                                <asp:ListItem Value="13" Text="13"></asp:ListItem>
                                <asp:ListItem Value="14" Text="14"></asp:ListItem>
                                <asp:ListItem Value="15" Text="15"></asp:ListItem>
                                <asp:ListItem Value="16" Text="16"></asp:ListItem>
                                <asp:ListItem Value="17" Text="17"></asp:ListItem>
                                <asp:ListItem Value="18" Text="18"></asp:ListItem>
                                <asp:ListItem Value="19" Text="19"></asp:ListItem>
                                <asp:ListItem Value="20" Text="20"></asp:ListItem>
                                <asp:ListItem Value="21" Text="21"></asp:ListItem>
                                <asp:ListItem Value="22" Text="22"></asp:ListItem>
                                <asp:ListItem Value="23" Text="23"></asp:ListItem>
                                <asp:ListItem Value="24" Text="24"></asp:ListItem>
                                <asp:ListItem Value="25" Text="25"></asp:ListItem>
                                <asp:ListItem Value="26" Text="26"></asp:ListItem>
                                <asp:ListItem Value="27" Text="27"></asp:ListItem>
                                <asp:ListItem Value="28" Text="28"></asp:ListItem>
                                <asp:ListItem Value="29" Text="29"></asp:ListItem>
                                <asp:ListItem Value="30" Text="30"></asp:ListItem>
                            </asp:DropDownList>
                    </ItemTemplate>
              </asp:TemplateField>              
              <asp:TemplateField HeaderText="Acciones">
                  <ItemTemplate>
                      <div align="center">
                          <asp:ImageButton ID="btnEdit" runat="server" ImageUrl="/images/edit.png" CommandName="edit" ToolTip="Editar" CommandArgument='<%# Bind("id_tipo_permiso")%>' />
                          <asp:ImageButton ID="btnSave" runat="server" ImageUrl="/images/save.png" CommandName="save" Visible="false" ToolTip="Guardar" CommandArgument='<%# Bind("id_tipo_permiso")%>' />
                          &nbsp;&nbsp;&nbsp;
                          <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="/images/cancel.png" CommandName="cancel" Visible="false" ToolTip="Cancelar" />
                          <asp:ImageButton ID="btnDelete" runat="server" ImageUrl="/images/delete.png" CommandName="eliminar" ToolTip="Eliminar" OnClientClick="return confirm('Seguro que desea eliminar este registro?');" CommandArgument='<%# Bind("id_tipo_permiso")%>' />
                      </div>
                  </ItemTemplate>
              </asp:TemplateField>
          </Columns>
    </asp:GridView>

</asp:Content>

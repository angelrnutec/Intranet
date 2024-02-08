﻿<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="GruposBusqueda.aspx.vb" Inherits="Intranet.GruposBusqueda" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <asp:Panel ID="pnlBusqueda" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="600px">
            <tr>
                <td><span style="font-size:15px; font-weight:bold;">Catalogo de Grupos</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td>
                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar Nuevo Grupo" CssClass="botones" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br /><br />
    <div id="divNuevo" runat="server" style="width:630px">
        <table>
            <tr>
                <td colspan="5">Ingrese los datos del nuevo Grupo</td>
            </tr>
            <tr>
                <td>Nombre:</td>
                <td><asp:TextBox ID="txtNombre" runat="server" Width="200px" MaxLength="256"></asp:TextBox></td>
            </tr>
            <tr>
                <td>Descripción:</td>
                <td><asp:TextBox ID="txtDescripcion" runat="server" Width="200px" MaxLength="256"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2"><asp:CheckBox ID="chkPrivado" runat="server" Text="¿El grupo es de acceso privado?" /></td>
            </tr>
            <tr>
                <td colspan="2"><br />
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="botones" />
                    &nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnCancelar" runat="server" Text="Salir" CssClass="botones" />
                </td>
            </tr>
        </table>
    </div>
    <asp:GridView ID="gvResultados" runat="server" CssClass="grid" Width="630px" 
         EmptyDataText="No se encontraron resultados para la busqueda realizada" AutoGenerateColumns="False" 
         AllowSorting="True" AllowPaging="true" AutoGenerateEditButton="false" AutoGenerateDeleteButton="false"
         DataKeyNames="id_grupo">
         <HeaderStyle CssClass="grid_header" />
         <AlternatingRowStyle CssClass="grid_alternating" />
          <Columns>
              <asp:TemplateField HeaderText="Grupo" SortExpression="nombre">
                    <ItemTemplate>
                            <asp:Label ID="lblGrupo" runat="server" Text='<%# Bind("nombre") %>' />
                            <asp:TextBox id="txtGrupo" runat="server" text='<%# Bind("nombre") %>' Visible="false" />
                    </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Descripción" SortExpression="descripcion">
                    <ItemTemplate>
                            <asp:Label ID="lblDescripcion" runat="server" Text='<%# Bind("descripcion")%>' />
                            <asp:TextBox id="txtDescripcion" runat="server" text='<%# Bind("descripcion")%>' Visible="false" />
                    </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Tipo" SortExpression="es_privado">
                    <ItemTemplate>
                        <asp:Label ID="lblEsPrivado" runat="server" Text='<%# TextoEsPrivado(DataBinder.Eval(Container.DataItem,"es_privado")) %>'></asp:Label>
                        <asp:CheckBox ID="chkPrivado" runat="server" Text="¿Acceso privado?" Checked='<%# Bind("es_privado")%>' Visible="false" />
                    </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Acciones">
                  <ItemTemplate>
                      <div align="center">
                          <asp:ImageButton ID="btnEdit" runat="server" ImageUrl="/images/edit.png" CommandName="edit" ToolTip="Editar" CommandArgument='<%# Bind("id_grupo")%>' />
                          &nbsp;
                          <asp:ImageButton ID="btnMiembros" runat="server" ImageUrl="/images/key.png" CommandName="members" ToolTip="Miembros y Administradores" CommandArgument='<%# Bind("id_grupo")%>' />
                          &nbsp;
                          <asp:ImageButton ID="btnSave" runat="server" ImageUrl="/images/save.png" CommandName="save" Visible="false" ToolTip="Guardar" CommandArgument='<%# Bind("id_grupo")%>' />
                          &nbsp;
                          <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="/images/cancel.png" CommandName="cancel" Visible="false" ToolTip="Cancelar" />
                      </div>
                  </ItemTemplate>
              </asp:TemplateField>
          </Columns>
    </asp:GridView>

</asp:Content>

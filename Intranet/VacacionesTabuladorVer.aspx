<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="VacacionesTabuladorVer.aspx.vb" Inherits="Intranet.VacacionesTabuladorVer" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>

    <table cellpadding="0" cellspacing="0" border="0" width="95%">
        <tr>
            <td colspan="4"><span id="spnTitulo" runat="server" style="font-size:15px; font-weight:bold;">Tabulador de Vacaciones</span><hr style="margin:0; padding:0;" /></td>
        </tr>           
        <tr>
            <td colspan="4"><br /></td>
        </tr>
        <tr>
            <td colspan="4">
                <asp:GridView ID="gvDetalle" runat="server" CssClass="grid" PageSize="50" 
                     EmptyDataText="Favor de volver a intentar" AutoGenerateColumns="False" 
                     AllowSorting="false" AllowPaging="false">
                     <HeaderStyle CssClass="grid_header" />
                     <AlternatingRowStyle CssClass="grid_alternating" />
                      <Columns>                            
                            <asp:TemplateField HeaderText="Empresa" SortExpression="Empresa">
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblId" runat="server" Visible="false" Text='<%# Eval("id")%>' />
                                        <asp:Label ID="lblFila" runat="server" Text='<%# Eval("empresa")%>' />                                        
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>  
                            <asp:TemplateField HeaderText="Año Inicio" SortExpression="anio_ini">
                                <ItemTemplate>
                                    <div>
                                        <telerik:RadNumericTextBox ID="txtAñoInicio" runat="server" NumberFormat-DecimalDigits="0" Width="70px" Value='<%# Bind("anio_ini", "{0:n}")%>' ReadOnly="true"></telerik:RadNumericTextBox>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Año Fin" SortExpression="anio_fin">
                                <ItemTemplate>
                                    <div>
                                        <telerik:RadNumericTextBox ID="txtAñoFin" runat="server" NumberFormat-DecimalDigits="0" Width="70px" Value='<%# Bind("anio_fin", "{0:n}")%>'  ReadOnly="true"></telerik:RadNumericTextBox>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dias" SortExpression="dias">
                                <ItemTemplate>
                                    <div>
                                        <telerik:RadNumericTextBox ID="txtDias" runat="server" NumberFormat-DecimalDigits="0" Width="70px" Value='<%# Bind("dias", "{0:n}")%>' ReadOnly="true" ></telerik:RadNumericTextBox>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Fecha de Efectividad" SortExpression="Fecha de Efectividad">
                                <ItemTemplate>
                                    <div>                                        
                                        <asp:Label ID="lblFechaEfectividad" runat="server" Text='<%# Eval("fecha_efectividad", "{0:dd/MM/yyyy}")%>' />                                        
                                        <telerik:RadDatePicker ID="dtFechaEfectividad" runat="server" Width="100px" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy"  MinDate="1900/01/01" SelectedDate='<%# Eval("fecha_efectividad", "{0:dd/MM/yyyy}")%>' ></telerik:RadDatePicker>                                        
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>                            
                          <asp:TemplateField HeaderText="Acciones" Visible="false">
                              <ItemTemplate>
                                  <div align="center">
                                      <asp:ImageButton ID="btnDelete" runat="server" ImageUrl="/images/delete.png" CommandName="borrar" ToolTip="Eliminar" CommandArgument='<%# Bind("id")%>'  OnClientClick="return confirm('Seguro que desea eliminar este registro?');" />                                      
                                  </div>

                              </ItemTemplate>
                          </asp:TemplateField>
                      </Columns>
                </asp:GridView>
            </td>
        </tr>
        <tr style="display:none">
            <td colspan="4">
                <b>*Si desea ingresar menos registros de los pre-cargados solo debe dejar en blanco el detalle de la fila.</b>
            </td>
        </tr>
        <tr>
            <td colspan="4">
                <br />
                <asp:Button ID="btnRegresar" runat="server" CssClass="botones" Text="Regresar" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnGuardar" runat="server" CssClass="botones" Text="Guardar" Visible="false" />
            </td>
        </tr>
        <tr style="display:none">
            <td colspan="4">
                <br /><br />
                <table id="tblAgregar" runat="server" width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td colspan="4"><span style="font-size:15px; font-weight:bold;">Si desea agregar un nuevo registro llene los siguientes datos:</span><hr style="margin:0; padding:0;" /></td>
                    </tr>
                    <tr>
                        <td colspan="4"><br /></td>
                    </tr>
                    <tr>
                        <td>Año de Inicio:</td>
                        <td colspan="3"><telerik:RadNumericTextBox ID="txtAñoInicio" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value='0'></telerik:RadNumericTextBox></td>
                    </tr>
                    <tr>
                        <td>Año de Fin:</td>
                        <td colspan="3"><telerik:RadNumericTextBox ID="txtAñoFin" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value='0'></telerik:RadNumericTextBox></td>
                    </tr>
                    <tr>
                        <td>Dias:</td>
                        <td colspan="3"><telerik:RadNumericTextBox ID="txtDias" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value='0'></telerik:RadNumericTextBox></td>
                    </tr> 
                    <tr style="display:none;">
                        <td>Fecha efectividad:</td>
                        <td><telerik:RadDatePicker ID="dtFechaEfectividad" runat="server" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy" Width="100px"  MinDate="1900/01/01"></telerik:RadDatePicker></td>
                    </tr>   
                    <tr>
                        <td colspan="4">
                            <asp:Button ID="btnAgregar" runat="server" Text="Agregar nueva fila" CssClass="botones" /> 
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <asp:TextBox ID="txtEsAlta" runat="server" style="display:none;"></asp:TextBox>
    <asp:TextBox ID="txtFechaEfectividad" runat="server" style="display:none;"></asp:TextBox>
    <asp:TextBox ID="txtIdTipoTabla" runat="server" style="display:none;"></asp:TextBox>
</asp:Content>

<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="ParametrosGenerales.aspx.vb" Inherits="Intranet.ParametrosGenerales" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>

    <asp:Panel ID="pnlBusqueda" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="600px">
            <tr>
                <td colspan="3"><span style="font-size:15px; font-weight:bold;">Parámetros Generales</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td colspan="3"><br /><span style="font-size:15px; font-weight:bold;">Solicitud de Vacaciones</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td colspan="3">Usuarios que reciben email para pago de anticipos:</td>
            </tr>
            <tr>
                <td colspan="3">
                    <table>
                        <tr>
                            <td width="40px">&nbsp;NC:</td>
                            <td><asp:DropDownList ID="ddlIdUsuarioPagosNC" runat="server" Width="250px"></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td>&nbsp;NB:</td>
                            <td><asp:DropDownList ID="ddlIdUsuarioPagosNB" runat="server" Width="250px"></asp:DropDownList></td>
                        </tr>
                        <tr>
                            <td>&nbsp;NF:</td>
                            <td><asp:DropDownList ID="ddlIdUsuarioPagosNF" runat="server" Width="250px"></asp:DropDownList></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="3"><br /><span style="font-size:15px; font-weight:bold;">Seguridad</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td>&nbsp;Días para vencimiento de contraseña (Intranet):</td>
                <td><telerik:RadNumericTextBox ID="txtDiasVencimientoIntranet" runat="server" NumberFormat-DecimalDigits="0" Width="100px"></telerik:RadNumericTextBox></td>
            </tr>
            <tr>
                <td>&nbsp;Días para vencimiento de contraseña (Recibos de Nomina):</td>
                <td><telerik:RadNumericTextBox ID="txtDiasVencimientoNomina" runat="server" NumberFormat-DecimalDigits="0" Width="100px"></telerik:RadNumericTextBox></td>
            </tr>            
            <tr>
                <td colspan="3"><br /><span style="font-size:15px; font-weight:bold;">Solicitud de Gastos</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td>&nbsp;Monto máximo para compra de materiales sin autorización de operaciones:</td>
                <td><telerik:RadNumericTextBox ID="txtMontoMaximoMateriales" runat="server" NumberFormat-DecimalDigits="2" Width="100px"></telerik:RadNumericTextBox></td>
            </tr>
            <tr>
                <td>&nbsp;Director de Operaciones NS:</td>
                <td><asp:DropDownList ID="ddlIdUsuarioOperacionesNC" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>&nbsp;Director de Operaciones NB:</td>
                <td><asp:DropDownList ID="ddlIdUsuarioOperacionesNB" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>&nbsp;Director de Operaciones NF:</td>
                <td><asp:DropDownList ID="ddlIdUsuarioOperacionesNF" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td colspan="3"><br /><span style="font-size:15px; font-weight:bold;">Comidas Internas</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td>&nbsp;Monto máximo para compra de comidas internas sin autorización:</td>
                <td><telerik:RadNumericTextBox ID="txtMontoMaximoComidasInternas" runat="server" NumberFormat-DecimalDigits="2" Width="100px"></telerik:RadNumericTextBox></td>
            </tr>
            <tr>
                <td>&nbsp;Autoriza comidas internas NS:</td>
                <td><asp:DropDownList ID="ddlIdUsuarioComidasInternasNC" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>&nbsp;Autoriza comidas internas NB:</td>
                <td><asp:DropDownList ID="ddlIdUsuarioComidasInternasNB" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>&nbsp;Autoriza comidas internas NF:</td>
                <td><asp:DropDownList ID="ddlIdUsuarioComidasInternasNF" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td colspan="3"><br /><br /><span style="font-size:15px; font-weight:bold;">Directores de Negocio</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td>&nbsp;Director de Negocio NS:</td>
                <td><asp:DropDownList ID="ddlIdUsuarioDirectorNS" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>&nbsp;Director de Negocio NB:</td>
                <td><asp:DropDownList ID="ddlIdUsuarioDirectorNB" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>&nbsp;Director de Negocio NF:</td>
                <td><asp:DropDownList ID="ddlIdUsuarioDirectorNF" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>&nbsp;Director de Negocio NE:</td>
                <td><asp:DropDownList ID="ddlIdUsuarioDirectorNE" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>&nbsp;Director de Negocio NUSA:</td>
                <td><asp:DropDownList ID="ddlIdUsuarioDirectorNU" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td colspan="3"><br /><br /><span style="font-size:15px; font-weight:bold;">Directores de Finanzas</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td>&nbsp;Director de Finanzas NS:</td>
                <td><asp:DropDownList ID="ddlIdUsuarioDirectorFinanzasNS" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>&nbsp;Director de Finanzas NB:</td>
                <td><asp:DropDownList ID="ddlIdUsuarioDirectorFinanzasNB" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>&nbsp;Director de Finanzas NF:</td>
                <td><asp:DropDownList ID="ddlIdUsuarioDirectorFinanzasNF" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>&nbsp;Director de Finanzas NE:</td>
                <td><asp:DropDownList ID="ddlIdUsuarioDirectorFinanzasNE" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td>&nbsp;Director de Finanzas NUSA:</td>
                <td><asp:DropDownList ID="ddlIdUsuarioDirectorFinanzasNU" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td colspan="3"><br /><br /><span style="font-size:15px; font-weight:bold;">Director de RH</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td>&nbsp;Director de RH:</td>
                <td><asp:DropDownList ID="ddlIdUsuarioDirectorRH" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td colspan="3"><br /><br /><span style="font-size:15px; font-weight:bold;">Materiales</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td>&nbsp;Autoriza Materiales:</td>
                <td><asp:DropDownList ID="ddlIdUsuarioAutorizaMateriales" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td colspan="3"><br /><br /><span style="font-size:15px; font-weight:bold;">Verificación vacaciones (Excepciones)</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td>&nbsp;Verificación vacaciones "GUARDIA DE SEGURIDAD NF":</td>
                <td><asp:DropDownList ID="ddlIdUsuarioVerificaVacacionesGuardiasSeguridadNF" runat="server" Width="250px"></asp:DropDownList></td>
            </tr>
            <tr>
                <td colspan="3"><br /><span style="font-size:15px; font-weight:bold;">Notificaciones</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr valign="top">
                <td colspan="2">&nbsp;Emails para notificacion de reporte de telefonia:
                    <br />
                    <asp:TextBox ID="txtEmailsNotificacionDatosTelefonia" runat="server" TextMode="MultiLine" Width="600px" Height="100px" MaxLength="4000" ></asp:TextBox>
                    <br />
                    <i style="font-size: 13px;">Puede ingresar uno o mas emails separandolos con <b>;</b></i>

                </td>                
            </tr>
            <tr>
                <td colspan="3"><br /><span style="font-size:15px; font-weight:bold;">Configuración General</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td colspan="2">

                    <asp:GridView ID="gvConfiguracion" runat="server" AutoGenerateColumns="false" Width="90%">
                        <Columns>
                            <asp:BoundField HeaderText="Descripción" SortExpression="descripcion" DataField="descripcion" />
                            <asp:TemplateField HeaderText="Valor" SortExpression="valor">
                            <ItemTemplate>
                                <div>
                                    <asp:HiddenField ID="txtIdConfiguracion" runat="server" Value='<%# Eval("id")%>' />
                                    <asp:TextBox ID="txtValor" runat="server" Text='<%# Eval("valor")%>' Width="90px" />
                                </div>
                            </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <br />
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="botones" />
                </td>
            </tr>
        </table>
    </asp:Panel>

</asp:Content>

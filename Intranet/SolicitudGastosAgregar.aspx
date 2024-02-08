<%@ Page MaintainScrollPositionOnPostback="true" Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="SolicitudGastosAgregar.aspx.vb" Inherits="Intranet.SolicitudGastosAgregar" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style type="text/css">
        .tblSolicitud th {
            font-weight:bold;
        }
        .link1 a {
            color:#0094ff;
        }
    </style>


    <script type="text/javascript">

        function DateSelected(sender, eventArgs) {
            var startDate = $find('<%=dtFechaIni.ClientID%>');
            var endDate = $find('<%=dtFechaFin.ClientID%>');

            if ((startDate.get_selectedDate() != null) && (endDate.get_selectedDate() != null)) {
                var timeDiffMS = endDate.get_selectedDate() - startDate.get_selectedDate();
                var diffDays = Math.floor(timeDiffMS / 1000 / 60 / 60 / 24);
                if (diffDays < 0) {
                    document.getElementById('<%=diasViaje.ClientID%>').innerHTML = "0";
                } else {
                    document.getElementById('<%=diasViaje.ClientID%>').innerHTML = (diffDays + 1);
                }
            }
            else {
                document.getElementById('<%=diasViaje.ClientID%>').innerHTML = "0";
            }
        }

        function CalculaTotal(sender, eventArgs) {
            var subtotal = 0;//$find('<%=txtSubtotal.ClientID%>').get_value();
            var iva_concepto = 0;
            var iva_combo_oculto = '<%=ddlTipoIVA.Visible%>';
            var retencion = 0;
            var retencion_resico = 0;

            if ($find('<%=txtSubtotal.ClientID%>').get_value() != '') {
                subtotal = $find('<%=txtSubtotal.ClientID%>').get_value();
            }       

            console.log('test 1');
            if ($find('<%=txtRetencion.ClientID%>') != null) {
                console.log('test 2');
                if ($find('<%=txtRetencion.ClientID%>').get_value() != '') {
                    console.log('test 3');
                    retencion = $find('<%=txtRetencion.ClientID%>').get_value();
                    console.log('test 4');
                }
            }

            console.log('test 5');
            if (document.getElementById('<%=txtRetencionResico.ClientID%>') != null) {
                console.log('test 6');
                if (document.getElementById('<%=txtRetencionResico.ClientID%>').value.length == 0) {
                    console.log('test 7');
                    document.getElementById('<%=txtRetencionResico.ClientID%>').value = 0;
                    console.log('test 8');
                }
                console.log('test 9');
                retencion_resico = parseFloat(document.getElementById('<%=txtRetencionResico.ClientID%>').value);
                console.log('test 10');
            }


            if (document.getElementById('<%=txtIvaEditado.ClientID%>') != null) {
                if (document.getElementById('<%=txtIvaEditado.ClientID%>').value.length == 0) {
                    document.getElementById('<%=txtIvaEditado.ClientID%>').value = 0;
                }
                iva_concepto = parseFloat(document.getElementById('<%=txtIvaEditado.ClientID%>').value);
            }

            console.log('test 11');
            if (iva_combo_oculto == 'True') {
                console.log('test 12');
                var tasa_iva = parseFloat(document.getElementById('<%=ddlTipoIVA.ClientID%>').value);
                console.log('test 13');
                if (tasa_iva == -1) {
                    console.log('test 14');
                    document.getElementById('<%=divTotal.ClientID%>').innerHTML = "0";
                    return true;
                }
                var iva = subtotal * tasa_iva;
            } else {
                var iva = iva_concepto;
            }

            var otros_imp = 0;
            if ($find('<%=txtOtrosImpuestos.ClientID%>').get_value() != '') {
                otros_imp = $find('<%=txtOtrosImpuestos.ClientID%>').get_value();
            }

            var propina = 0;
            if (document.getElementById('<%=txtPropina.ClientID%>') != null) { 
                if ($find('<%=txtPropina.ClientID%>').get_value() != '') {
                    propina = $find('<%=txtPropina.ClientID%>').get_value();
                }
            }

            if (isNaN(subtotal)) { subtotal = 0; }
            if (isNaN(iva)) { iva = 0; }
            if (isNaN(otros_imp)) { otros_imp = 0; }
            if (isNaN(retencion)) { retencion = 0; }
            if (isNaN(retencion_resico)) { retencion_resico = 0; }
            if (isNaN(propina)) { propina = 0; }

            document.getElementById('<%=divTotal.ClientID%>').innerHTML = (subtotal + iva + otros_imp - retencion + propina - retencion_resico).toFixed(2);
        }


    </script>

      <link href="styles/jquery-ui.css" rel="stylesheet" />  
      <script src="Scripts/jquery-1.9.1.js"></script>
      <script src="Scripts/jquery-ui.js"></script>    

      <link href="Scripts/jquery.uploadfile/uploadfile.css" rel="stylesheet">
      <script src="Scripts/jquery.uploadfile/jquery.uploadfile.min.js"></script>



</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>

    <table cellpadding="0" cellspacing="0" border="0" width="650px">
        <tr>
            <td colspan="5"><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Solicitud de Gastos")%></span><hr style="margin:0; padding:0;" /></td>
        </tr>
    </table>

    <br />
    <table>
        <tr>
            <td colspan="5"><b><asp:Label ID="lblFolio" runat="server"></asp:Label></b></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Fecha de Solicitud")%>:</td>
            <td><asp:Label ID="lblFechaSolicitud" runat="server"></asp:Label></td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Solicitante")%>:</td>
            <td><asp:Label ID="lblSolicitante" runat="server"></asp:Label><%--<%=Session("nombreEmpleado")%>--%></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Empresa")%>:</td>
            <td><asp:DropDownList ID="ddlEmpresa" runat="server" Width="200px" AutoPostBack="true"></asp:DropDownList></td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Viajero")%>:</td>
            <td><asp:DropDownList ID="ddlViajero" runat="server" Width="200px" AutoPostBack="true" ></asp:DropDownList></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Departamento")%>:</td>
            <td><asp:DropDownList ID="ddlDepartamento" runat="server" Width="200px"></asp:DropDownList></td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Autoriza Jefe")%>:</td>
            <td><asp:DropDownList ID="ddlAutorizaJefe" runat="server" Width="200px"></asp:DropDownList></td>
        </tr>
        <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Autoriza Conta")%>:</td>
            <td><asp:DropDownList ID="ddlAutorizaConta" runat="server" Width="200px"></asp:DropDownList></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Destino")%>:</td>
            <td><asp:TextBox ID="txtDestino" runat="server" TextMode="MultiLine" Height="55px" Width="200px"></asp:TextBox></td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Motivo")%>:</td>
            <td><asp:TextBox ID="txtMotivo" runat="server" TextMode="MultiLine" Height="55px" Width="200px"></asp:TextBox></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Fecha Ini")%>:</td>
            <td colspan="4">
                <telerik:RadDatePicker ID="dtFechaIni" runat="server" Width="100px" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy"><ClientEvents OnDateSelected="DateSelected" /></telerik:RadDatePicker>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <%=TranslateLocale.text("Fecha Fin")%>:&nbsp;<telerik:RadDatePicker ID="dtFechaFin" runat="server" Width="100px" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy"><ClientEvents OnDateSelected="DateSelected" /></telerik:RadDatePicker>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <%=TranslateLocale.text("Dias de Viaje")%>:&nbsp;<div id="diasViaje" style="display:inline;" runat="server">1</div>
            </td>
        </tr>
        <tr id="trAnticipos" runat="server">
            <td><%=TranslateLocale.text("Anticipo PESOS")%>:</td>
            <td colspan="4">
                <telerik:RadNumericTextBox ID="txtMontoPesos" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0"></telerik:RadNumericTextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <%=TranslateLocale.text("Anticipo USD")%>:&nbsp;
                <telerik:RadNumericTextBox ID="txtMontoUSD" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0"></telerik:RadNumericTextBox>
                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <%=TranslateLocale.text("Anticipo EUROS")%>:&nbsp;
                <telerik:RadNumericTextBox ID="txtMontoEuro" runat="server" NumberFormat-DecimalDigits="2" Width="60px" Value="0"></telerik:RadNumericTextBox>
            </td>
        </tr>
        <tr>
            <td colspan="5">
                <div id="divSeleccionTipoContabilidad" runat="server">
                    <hr />
                    <table>
                        <tr>
                            <td>
                                <br />
                                <%=TranslateLocale.text("Seleccione la categoría en que registrara los comprobantes de esta solicitud")%>:<br />
                                <asp:RadioButton ID="btnManejoOI" runat="server" Text="Orden Interna" GroupName="ManejoSolicitud" /><br />
                                <asp:RadioButton ID="btnManejoCC" runat="server" Text="Centro de Costo" GroupName="ManejoSolicitud" /><br />
                                <asp:RadioButton ID="btnManejoPEP" runat="server" Text="Elemento PEP" GroupName="ManejoSolicitud" /><br />
                                <asp:RadioButton ID="btnManejoRF" runat="server" Text="Reembolso Filiales" GroupName="ManejoSolicitud" />
                            </td>
                        </tr>
                    </table>
                </div>

            </td>
        </tr>
        <tr>
            <td colspan="5">
                <asp:Label ID="lblEstatus" runat="server"></asp:Label>

                <table id="tblHistAuth" runat="server" visible="false" cellpadding="0" cellspacing="0" border="0" width="395px">
                    <tr>
                        <td colspan="2"><span style="font-weight:bold;"><br /><%=TranslateLocale.text("Historial de Autorizaciones")%></span><hr style="margin:0; padding:0;" /></td>
                    </tr>
                    <tr>
                        <td width="160px"><%=TranslateLocale.text("Autoriza Jefe (Anticipo)")%>:</td>
                        <td><asp:Label ID="lblAutorizaJefe" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Autoriza Conta (Anticipo)")%>:</td>
                        <td><asp:Label ID="lblAutorizaConta" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Autoriza Jefe (Comprobación)")%>:</td>
                        <td><asp:Label ID="lblAutorizaJefeComprobacion" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Autoriza Conta (Comprobación)")%>:</td>
                        <td><asp:Label ID="lblAutorizaContaComprobacion" runat="server"></asp:Label></td>
                    </tr>
                </table>
                
            </td>
        </tr>
    </table>



    <br /><br />
    <asp:Button ID="btnRegresar" runat="server" CssClass="botones" Text="Regresar" />
    &nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnGuardar" runat="server" Text="Enviar Solicitud" CssClass="botones"  OnClientClick="this.disabled = true; this.value = 'Guardando...';" UseSubmitBehavior="false" />
    &nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnCancelarSolicitud" runat="server" Text="Cancelar la Solicitud" CssClass="botones"  Visible="false"/>
    &nbsp;&nbsp;&nbsp;
    <a id="lnkImpr" runat="server" target="_blank" visible="false"><img src="/images/printer.png" border="0" width="36px" height="36px"  /></a>

    <br /><br />


    <div id="divSolicitudConMateriales" runat="server" visible="false">
        <hr />
        <div style="color:blue;font-weight:bold;" class="link1">
            <%=TranslateLocale.text("Esta solicitud de gastos de viaje esta ligada a una solicitud de reposición")%> (<asp:Label ID="lblFolioSolicitudReposicion" runat="server"></asp:Label>), 
            <%=TranslateLocale.text("por los comprobantes de compra de materiales capturados por el solicitante")%>. 
            <asp:HyperLink ID="lnkSolicitudReposicion" CssClass="link1" runat="server" Target="_blank" Text="De click aquí para abrir la solicitud de reposición en otra ventana."></asp:HyperLink>
        </div>
        <hr />
    </div>


    <div id="comprobantes">&nbsp;</div>
    <div id="divComprobantes" runat="server" visible="false">
        <table cellpadding="0" cellspacing="0" border="0" width="650px">
            <tr>
                <td colspan="5">
                    <span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Comprobantes de Gastos")%></span>
                    <hr style="margin:0; padding:0;" />
                    <div style="text-align:right;font-weight:bold;">
                        <a href="javascript:void(0)" ID="lnkMovimientosPorComprobar" runat="server" onclick="MovimientosPorComprobar();"><%=LinkMovimientosPorComprobar() %></a>
                    </div>
                </td>
            </tr>
        </table>
        <br />

            <div id="divComprobantesAlta" runat="server" visible="false">
                <table width="850px">
                    <tr style="display:none;">
                        <td><%=TranslateLocale.text("Orden Interna / C.C. / Elemento PEP")%></td>
                        <td></td>
                        <td>&nbsp;&nbsp;</td>
                        <td><%=TranslateLocale.text("No. Necesidad")%>:</td>
                        <td><asp:TextBox ID="txtNecesidad" runat="server"></asp:TextBox></td>
                        <td>&nbsp;&nbsp;</td>
                    </tr>
                    <tr valign="middle">
                        <td colspan="6">
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td><asp:RadioButton ID="btnConceptoCC" runat="server" Text="Centro de Costo" GroupName="ConceptoManejo" Checked="true" AutoPostBack="true" /></td>
                                    <td>&nbsp;<asp:DropDownList ID="ddlCentroCosto" runat="server" Visible="false"></asp:DropDownList></td>
                                </tr>
                                <tr>
                                    <td><asp:RadioButton ID="btnConceptoOI" runat="server" Text="Orden Interna" GroupName="ConceptoManejo" AutoPostBack="true" /></td>
                                    <td>
                                        &nbsp;<asp:DropDownList ID="ddlOrdenInterna" runat="server" Visible="false" AutoPostBack="true"></asp:DropDownList>
                                       <asp:TextBox ID="txtOrdenInterna" runat="server" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:RadioButton ID="btnConceptoPEP" runat="server" Text="Elemento PEP" GroupName="ConceptoManejo" AutoPostBack="true" /></td>
                                    <td>
                                        &nbsp;<asp:DropDownList ID="ddlElementoPEP" runat="server" Visible="false" AutoPostBack="true"></asp:DropDownList>
                                       <asp:TextBox ID="txtElementoPep" runat="server" Visible="false"></asp:TextBox>
                                    </td>
                                </tr>
                                <tr>
                                    <td><asp:RadioButton ID="btnConceptoRF" runat="server" Text="Reembolso Filiales" GroupName="ConceptoManejo" AutoPostBack="true" /></td>
                                    <td>
                                        &nbsp;<asp:DropDownList ID="ddlElementoEmpresa" runat="server" Visible="false">
                                              </asp:DropDownList>
                                    </td>
                                </tr>
                            </table>
                            <div id="divNecesidad" runat="server" Visible="false">
                                <asp:Label ID="lblNecesidad" runat="server" Text="Necesidad:"></asp:Label>&nbsp;&nbsp;
                                <asp:DropDownList ID="ddlNecesidad" runat="server"></asp:DropDownList>
                            </div>
                        </td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Fecha")%>:</td>
                        <td><telerik:RadDatePicker ID="dtFechaConcepto" runat="server" Width="100px" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy"></telerik:RadDatePicker></td>
                        <td>&nbsp;&nbsp;</td>
                        <td>&nbsp;&nbsp;</td>
                        <td><%=TranslateLocale.text("Forma de Pago")%>:</td>
                        <td><asp:DropDownList ID="ddlFormaPago" runat="server"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Observaciones")%>:</td>
                        <td colspan="3"><asp:TextBox ID="txtObservaciones" runat="server" Width="300px"></asp:TextBox></td>
                        <td><%=TranslateLocale.text("Num. de Personas")%>:</td>
                        <td><asp:DropDownList ID="ddlNumPersonas" runat="server">
                            </asp:DropDownList></td>
                    </tr>
                </table>
                <table width="850px">
                    <tr>
                        <td><%=TranslateLocale.text("Concepto")%></td>
                        <td><%=TranslateLocale.text("Subtotal")%></td>
                        <td><%=TranslateLocale.text("I.V.A.")%></td>
                        <td><%=TranslateLocale.text("Otros Impuestos")%></td>
                        <td id="tdEtiquetaRetencion" runat="server">Retencion</td>
                        <td id="tdEtiquetaRetencionResico" runat="server">Ret. Resico</td>
                        <td id="tdEtiquetaPropina" runat="server"><%=TranslateLocale.text("Propina")%></td>
                        <td><%=TranslateLocale.text("Moneda")%></td>
                        <td><%=TranslateLocale.text("Total")%></td>
                        <td rowspan="2">
                            <asp:Button ID="btnAgregar" runat="server" Text="Agregar" OnClientClick="this.disabled = true; this.value = 'Agregando...';" UseSubmitBehavior="false"  />
                        </td>
                    </tr>
                    <tr>
                        <td><asp:DropDownList ID="ddlConcepto" runat="server" AutoPostBack="true"></asp:DropDownList></td>
                        <td><telerik:RadNumericTextBox ID="txtSubtotal" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0"><ClientEvents OnBlur="CalculaTotal" /></telerik:RadNumericTextBox></td>
                        <td>
                            <asp:DropDownList ID="ddlTipoIVA" runat="server" >
                            </asp:DropDownList>
                            <telerik:RadNumericTextBox ID="txtIvaEditado" Visible="false" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0"><ClientEvents OnBlur="CalculaTotal" /></telerik:RadNumericTextBox>
                        </td>
                        <td><telerik:RadNumericTextBox ID="txtOtrosImpuestos" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0"><ClientEvents OnBlur="CalculaTotal" /></telerik:RadNumericTextBox></td>
                        <td id="tdRetencion" runat="server"><telerik:RadNumericTextBox ID="txtRetencion" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0"><ClientEvents OnBlur="CalculaTotal" /></telerik:RadNumericTextBox></td>
                        <td id="tdRetencionResico" runat="server"><telerik:RadNumericTextBox ID="txtRetencionResico" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0"><ClientEvents OnBlur="CalculaTotal" /></telerik:RadNumericTextBox></td>
                        <td id="tdPropina" runat="server"><telerik:RadNumericTextBox ID="txtPropina" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0"><ClientEvents OnBlur="CalculaTotal" /></telerik:RadNumericTextBox></td>
                        <td>
                            <asp:DropDownList ID="ddlMoneda" runat="server" Width="60px">
                            </asp:DropDownList>
                        </td>
                        <td><div id="divTotal" runat="server">0.00</div></td>
                    </tr>
                </table>
            </div>

        <br />
        <asp:GridView ID="gvConceptos" runat="server" CssClass="grid" Width="1400px" PageSize="50" 
             EmptyDataText="Favor de agregar tus comprobantes" AutoGenerateColumns="False" 
             AllowSorting="false" AllowPaging="false">
             <HeaderStyle CssClass="grid_header" />
             <AlternatingRowStyle CssClass="grid_alternating" />
              <Columns>
                  <asp:TemplateField HeaderText="Fecha" SortExpression="fecha_comprobante">
                    <ItemTemplate>
                        <div>
                            <asp:Label runat="server" ID="lblFecha" Text='<%# Format(Eval("fecha_comprobante"), "dd/MM/yyyy")%>'></asp:Label>
                            <telerik:RadDatePicker ID="dtFecha" runat="server" Visible="false" Width="100px" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy" SelectedDate='<%# Eval("fecha_comprobante")%>'></telerik:RadDatePicker>
                        </div>
                    </ItemTemplate>
                  </asp:TemplateField>


                  <asp:TemplateField HeaderText="Concepto" SortExpression="concepto">
                    <ItemTemplate>
                        <div>
                            <asp:DropDownList ID="ddlConcepto" Visible="false"  runat="server"></asp:DropDownList>
                            <asp:Label ID="lblIdConcepto" runat="server" Text='<%# Eval("id_concepto")%>' Visible="false" />
                            <asp:Label ID="lblConcepto" runat="server" Text='<%# Eval("concepto")%>' />
                            <asp:Label ID="lblDesc" runat="server" Text='<%# Eval("descripcion_nb")%>' />
                            <div><a href="javascript:CargarComprobante(<%# Eval("id_detalle")%>, '<%# Eval("concepto")%>')"><%=TranslateLocale.text("Cargar Comprobante XML y PDF") %></a></div>
                            <div id="divDocs_<%# Eval("id_detalle")%>"></div>
                        </div>
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Observaciones" SortExpression="observaciones" ItemStyle-Width="140px">
                    <ItemTemplate>
                        <div>
                            <asp:TextBox ID="txtObservaciones" runat="server" Visible="false" Text='<%# Eval("observaciones")%>'></asp:TextBox>
                            <asp:Label ID="lblObservaciones" runat="server" Text='<%# Eval("observaciones")%>' />
                            <br /><%=TranslateLocale.text("Num. Personas")%>: <asp:Label ID="lblNumPersonas" runat="server" Text='<%# Eval("num_personas")%>' />
                            <asp:DropDownList ID="ddlNumPersonas" runat="server" Visible="false">
                            </asp:DropDownList>
                            <asp:Label ID="lblExcedioLimite" runat="server" style="color:red;font-weight:bold" Text='<%# Eval("excedio_limite")%>' />                            
                            <br />
                            <%=TranslateLocale.text("Forma de Pago")%>: <asp:Label ID="lblFormaPago" runat="server" Text='<%# Eval("forma_pago")%>' />
                            <asp:DropDownList ID="ddlFormaPago" runat="server" Visible="false">
                            </asp:DropDownList>
                            <asp:HiddenField ID="idFormaPago" runat="server" Value='<%# Eval("id_forma_pago")%>' />
                            <asp:HiddenField ID="formaPagoEditable" runat="server" Value='<%# Eval("forma_pago_editable")%>' />
                        </div>
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="PEP / CC" SortExpression="pep">
                    <ItemTemplate>
                        <asp:Label ID="lblPep" runat="server" Text='<%# Bind("info_comprobantes")%>' />
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Moneda" SortExpression="moneda">
                    <ItemTemplate>
                        <asp:Label ID="lblMoneda" runat="server" Text='<%# Bind("moneda")%>' />
                        <asp:DropDownList ID="ddlMoneda" runat="server" Width="60px" Visible="false">
                        </asp:DropDownList>
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Subtotal" SortExpression="subtotal">
                    <ItemTemplate>
                        <div align="right">
                            <asp:TextBox ID="txtIdDetalle" runat="server" Text='<%# Bind("id_detalle")%>' Visible="false"></asp:TextBox>
                            <asp:Label ID="lblSubtotal" runat="server" Text='<%# Format(Eval("subtotal"), "###,###,##0.00")%>' />
                            <telerik:RadNumericTextBox ID="txtSubtotal" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Visible="false"></telerik:RadNumericTextBox>
                        </div>
                    </ItemTemplate>
                  </asp:TemplateField>              
                  <asp:TemplateField HeaderText="IVA" SortExpression="iva">
                    <ItemTemplate>
                        <div align="right">
                            <asp:Label ID="lblIVA" runat="server" Text='<%# Format(Eval("iva"), "###,###,##0.00")%>' />
                            <asp:DropDownList ID="ddlTipoIVA" runat="server" Visible="false">
                                <asp:ListItem Value="0.16" Text="16 %"></asp:ListItem>
                                <asp:ListItem Value="0.08" Text="8 %"></asp:ListItem>
                                <asp:ListItem Value="0" Text="0 %"></asp:ListItem>
                            </asp:DropDownList>
                            <telerik:RadNumericTextBox ID="txtIvaEditado" Visible="false" runat="server" NumberFormat-DecimalDigits="2" Width="70px"></telerik:RadNumericTextBox>
                            <asp:HiddenField ID="esNoDeducible" runat="server" Value='<%# Eval("es_no_deducible")%>' />
                            <asp:HiddenField ID="esIvaEditable" runat="server" Value='<%# Eval("es_iva_editable")%>' />
                        </div>
                    </ItemTemplate>
                  </asp:TemplateField>              
                  <asp:TemplateField HeaderText="Otros Imp" SortExpression="iva">
                    <ItemTemplate>
                        <div align="right">
                            <asp:Label ID="lblOtrosImpuestos" runat="server" Text='<%# Format(Eval("otros_impuestos"), "###,###,##0.00")%>' />
                            <telerik:RadNumericTextBox ID="txtOtrosImpuestos" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Visible="false"></telerik:RadNumericTextBox>
                        </div>
                    </ItemTemplate>
                  </asp:TemplateField>              
                  <asp:TemplateField HeaderText="Ret." SortExpression="ret">
                    <ItemTemplate>
                        <div align="right">
                            <asp:Label ID="lblRetencion" runat="server" Text='<%# Format(Eval("retencion"), "###,###,##0.00")%>' />
                            <telerik:RadNumericTextBox ID="txtRetencion" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Visible="false"></telerik:RadNumericTextBox>
                            <asp:HiddenField ID="requiere_retencion" runat="server" Value='<%# Eval("requiere_retencion")%>' />
                        </div>
                    </ItemTemplate>
                  </asp:TemplateField>                          
                  <asp:TemplateField HeaderText="Ret. Resico" SortExpression="ret_resico">
                    <ItemTemplate>
                        <div align="right">
                            <asp:Label ID="lblRetencionResico" runat="server" Text='<%# Format(Eval("retencion_resico"), "###,###,##0.00")%>' />
                            <telerik:RadNumericTextBox ID="txtRetencionResico" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Visible="false"></telerik:RadNumericTextBox>
                        </div>
                    </ItemTemplate>
                  </asp:TemplateField>                          
                  <asp:TemplateField HeaderText="Propina" SortExpression="propina">
                    <ItemTemplate>
                        <div align="right">
                            <asp:Label ID="lblPropina" runat="server" Text='<%# Format(Eval("propina"), "###,###,##0.00")%>' />
                            <telerik:RadNumericTextBox ID="txtPropina" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Visible="false"></telerik:RadNumericTextBox>
                            <asp:HiddenField ID="permite_propina" runat="server" Value='<%# Eval("permite_propina")%>' />
                        </div>
                    </ItemTemplate>
                  </asp:TemplateField>                          
                  <asp:BoundField HeaderText="Total" SortExpression="total" DataField="total" ItemStyle-HorizontalAlign="Right" DataFormatString="{0:###,###,##0.00}" />
                  <asp:TemplateField HeaderText="T.C." SortExpression="tipo_cambio">
                    <ItemTemplate>
                        <div align="right">
                            <asp:Label ID="lblTipoCambio" runat="server" Text='<%# Bind("tipo_cambio")%>' />
                        </div>
                    </ItemTemplate>
                  </asp:TemplateField>
                  <asp:TemplateField HeaderText="Total MXP" SortExpression="total_mxp">
                    <ItemTemplate>
                        <div align="right">
                            <asp:Label ID="lblTotalMXP" runat="server" Text='<%# Format(Eval("total_mxp"), "###,###,##0.00")%>' />
                        </div>
                    </ItemTemplate>
                  </asp:TemplateField>

                  <asp:TemplateField HeaderText="Acciones">
                      <ItemTemplate>
                          <div align="center">
                              <asp:ImageButton ID="btnEdit" runat="server" ImageUrl="/images/edit.png" CommandName="editar" ToolTip="Editar" CommandArgument='<%# Bind("id_detalle")%>' />
                              &nbsp;&nbsp;
                              <asp:ImageButton ID="btnDelete" runat="server" ImageUrl="/images/delete.png" CommandName="delete" ToolTip="Eliminar" CommandArgument='<%# Bind("id_detalle")%>'  OnClientClick="return confirm('Seguro que desea eliminar este registro?');" />
                              <asp:ImageButton ID="btnSave" runat="server" ImageUrl="/images/save.png" CommandName="save" Visible="false" ToolTip="Guardar" CommandArgument='<%# Bind("id_detalle")%>' />
                              &nbsp;&nbsp;
                              <asp:ImageButton ID="btnCancel" runat="server" ImageUrl="/images/cancel.png" CommandName="cancelar" Visible="false" ToolTip="Cancelar" />
                          </div>

                      </ItemTemplate>
                  </asp:TemplateField>
              </Columns>
        </asp:GridView>
        <%        
        If gvConceptos.Rows.Count > 0 Then            
        %>
        <div style="color:blue;font-weight:bold;">
            <%=TranslateLocale.text("Importante: Recuerde cargar sus archivos PDF y XML por cada comprobante.")%>
        </div>
        <%
        End If
        %>
        <br />
        <div id="divTotales" visible="false" runat="server" style="width:630px;text-align:right;">
            <table align="right">
                <tr>
                    <td><b><%=TranslateLocale.text("Total Viáticos")%>:</b></td>
                    <td><b><asp:Label ID="lblTotalMXP" runat="server"></asp:Label></b></td>
                </tr>
                <tr>
                    <td><b><%=TranslateLocale.text("Total Compra Material")%>:</b></td>
                    <td><b><asp:Label ID="lblTotalMater" runat="server"></asp:Label></b></td>
                </tr>
                <tr>
                    <td><b><%=TranslateLocale.text("Importe Ajustado TE (MXP)")%>:</b></td>
                    <td><b><asp:Label ID="lblTotalAjustado" runat="server"></asp:Label></b></td>
                </tr>
                <tr>
                    <td><b><asp:Label ID="lblSaldoTexto" runat="server"></asp:Label>:</b></td>
                    <td><b><asp:Label ID="lblSaldoMonto" runat="server"></asp:Label></b></td>
                </tr>
            </table>
        </div>

        <br /><br />
        <asp:Button ID="btnEnviarAuth" runat="server" Text="Enviar a Autorización" CssClass="botones" Visible="false" OnClientClick="return confirm('¿Seguro que desea enviar esta solicitud a autorización?');" />

        <%
        
        If gvConceptos.Rows.Count > 0 Then
            
        %>
        <div id="divArchivos" style="display:none">
                <br /><br />
                <strong style="font-size:15px"><%=TranslateLocale.text("Cargar Comprobantes de")%>: <span id="txtNombreConcepto"></span></strong>
                <br />
                    <div id="fileuploader">Upload</div>
                <br />
                <br />
        </div>
                <div id="divDocs_0"></div>
        <%
        End If
        %>
    </div>


    <br /><br />


     <asp:TextBox ID="txtIdSolicitudGasto" runat="server" Text="0" style="display:none;"></asp:TextBox>
    <asp:TextBox ID="txtIdEmpleadoSolicita" runat="server" style="display:none;"></asp:TextBox>
    <asp:TextBox ID="txtTipoComprobantes" runat="server" style="display:none;"></asp:TextBox>
    
    <asp:TextBox ID="txtIdEstatus" runat="server" Visible="false"></asp:TextBox>
    <asp:TextBox ID="txtComprobacionJefe" runat="server" Visible="false"></asp:TextBox>
    <asp:TextBox ID="txtComprobacionConta" runat="server" Visible="false"></asp:TextBox>
    <asp:HiddenField ID="txtDiasGraciaConceptosAnioAnterior" runat="server" Value="0" />
    <input type="hidden" id="txtIdSolicitudDetalleCargar" name="txtIdSolicitudDetalleCargar" />


        <div id="dialog-form" title="<%=TranslateLocale.text("Movimientos pendientes de comprobar")%>" class="divDialog" style="display:none"></div>



    <script type="text/javascript">

        function CargarComprobante(id, texto) {
            document.getElementById('divArchivos').style.display = '';
            document.getElementById('txtNombreConcepto').innerHTML = texto;
            document.getElementById('txtIdSolicitudDetalleCargar').value = id;
            window.scrollTo(0, document.body.scrollHeight);
        }

        <%
        
        If gvConceptos.Rows.Count > 0 Then
            
        %>

        function RegistraUploadComprobante() {
            $("#fileuploader").uploadFile({
                url: "/UploadGastos.ashx",
                multiple: true,
                dragDrop: false,
                //maxFileCount: 1,
                fileName: "myfile",
                uploadStr: "<%=TranslateLocale.text("Subir Archivo")%>",
                onSuccess: function (files, data, xhr, pd) {
                    if (data.indexOf("Error=").length >= 0) {
                        alert(data);
                    } else {
                        AgregaDocumentos(document.getElementById('<%=txtIdSolicitudGasto.ClientID%>').value, data, document.getElementById('txtIdSolicitudDetalleCargar').value);
                        $('.ajax-file-upload-container').html('');
                    }
                },
                onError: function (files, status, errMsg, pd) {
                    alert(JSON.stringify(files));
                }
            });

        }


        function AgregaDocumentos(id, nombre, id_solicitud_detalle) {
            $.ajax({
                type: "GET",
                url: "/Servicios/ComprobanteGastosAgregar.aspx",
                data: { id: id, id_solicitud_detalle: id_solicitud_detalle, nombre: nombre, tipo: "GV" },
                success: function (datos) {
                    if (datos == "OK") {
                        RecuperaDocumentos(id);
                    } else {
                        alert(datos);
                    }
                },
                error: function (xhr, error, data) {
                    alert(xhr.responseText);
                }
            });
            return true;
        }

        function EliminarDocumento(id) {
            if (confirm('<%=TranslateLocale.text("Seguro que desea eliminar este archivo?")%>')) {
                $.ajax({
                    type: "GET",
                    url: "/Servicios/ComprobanteGastosEliminar.aspx",
                    data: { id: id, tipo: "GV" },
                    success: function (datos) {
                        RecuperaDocumentos(document.getElementById('<%=txtIdSolicitudGasto.ClientID%>').value);
                    },
                    error: function (error) {
                        alert(error);
                    }
                });
            }
            return true;
        }


        function RecuperaDocumentos(id) {
            $('div[id*=divDocs_]').html('');
            $.ajax({
                type: "GET",
                url: "/Servicios/ComprobanteGastos.aspx?id=" + id + "&tipo=GV",
                success: function (datos) {
                    var arrDatos = datos.split("##");
                    for (i = 0; i < arrDatos.length; i++) {
                        var posF = arrDatos[i].indexOf("||");
                        if (posF >= 0) {
                            var idDiv = arrDatos[i].substring(0, posF);
                            var txtDiv = arrDatos[i].substring(posF + 2)
                            if (document.getElementById(idDiv) != null) {
                                document.getElementById(idDiv).innerHTML = txtDiv;
                            } 
                        }
                    }
                },
                error: function (error) {
                    alert(error);
                }
            });
            return true;
        }




        $(document).ready(function () {
            RegistraUploadComprobante();
            RecuperaDocumentos(document.getElementById('<%=txtIdSolicitudGasto.ClientID%>').value);
        });

        <%
        
    End If
        
        %>
    </script>




        <script type="text/javascript">
            var GUARDAR_CLICKED = false;
            function MovimientosPorComprobar() {
                var id_empleado = document.getElementById('<%=ddlViajero.ClientID%>').value;
                var tipo_comprobantes = document.getElementById('<%=txtTipoComprobantes.ClientID%>').value;
                var id_empresa = document.getElementById('<%=ddlEmpresa.ClientID%>').value;


                $("#dialog-form").dialog({
                    autoOpen: false,
                    appendTo: "body",
                    height: 450,
                    width: 900,
                    modal: true,
                    buttons: {
                        "Guardar": function () {
                            GUARDAR_CLICKED = true;
                            GuardaCambios();
                        },
                        "Regresar": function () {
                            $(this).dialog("close");
                        },
                        //"Agregar Detalle": function () {
                        //    AgregarDetalle();
                        //}
                    },
                    close: function (event, ui) {
                        setTimeout(function () {
                            if (GUARDAR_CLICKED == false) {
                                window.location = '/SolicitudGastosAgregar.aspx?id=' + document.getElementById('<%=txtIdSolicitudGasto.ClientID%>').value + '&v=' + new Date().getTime() + '#comprobantes'
                                return false;
                            }
                        }, 200);
                        //$(this).find("form").remove();
                        //$(this).dialog('destroy').remove();
                    }
                });
                //$("#dialog-form").parent().appendTo($("form:first"));
                $("#dialog-form").html('Consultando, espere un momento...');
                $("#dialog-form").load('/MovimientosTarjetaPendiente.aspx?id=' + id_empleado + '&t=' + tipo_comprobantes + '&e=' + id_empresa + '&ts=G').dialog("open");

            }

            function ActivaMovimientoParaAgregar(id) {
                if ($('#mt_opciones_' + id).is(":visible")) {
                    $('#mt_opciones_' + id).hide();
                } else {
                    $('#mt_opciones_' + id).show();
                }
            }

            function MovimientosTarjetaOpcionesConcepto(fila, concepto) {
                var id_concepto = concepto.split('|')[0];
                var es_iva_editable = concepto.split('|')[1];
                var requiere_retencion = concepto.split('|')[2];
                var permite_propina = concepto.split('|')[3];

                //console.log('es_iva_editable:' + es_iva_editable);
                //console.log('requiere_retencion:' + requiere_retencion);
                //console.log('permite_propina:' + permite_propina);

                if (es_iva_editable == '1') {
                    $('.mt_lista_iva_' + fila).hide();
                    $('.mt_iva_manual_' + fila).show();
                } else {
                    $('.mt_lista_iva_' + fila).show();
                    $('.mt_iva_manual_' + fila).hide();
                }

                if (requiere_retencion == '1') {
                    $('.mt_retencion_' + fila).show();
                } else {
                    $('.mt_retencion_' + fila).hide();
                    document.getElementById('mt_retencion_' + fila).value = '0.00';
                }

                if (permite_propina == '1') {
                    $('.mt_propina_' + fila).show();
                } else {
                    $('.mt_propina_' + fila).hide();
                    document.getElementById('mt_propina_' + fila).value = '0.00';
                }

            }

            function GuardaCambios() {
                var msg = '';

                for (var i = 0; i < 200; i++) {
                    if (document.getElementById('mt_detalle_' + i) != null) {
                        if (document.getElementById('mt_seleccionado_' + i).checked == true) {
                            //mt_seleccionado_
                            if (document.getElementById('mt_lista_tipo_comprobacion_' + i).value.length == 0 || document.getElementById('mt_lista_tipo_comprobacion_' + i).value == '0') {
                                var tipo_comprobantes = document.getElementById('<%=txtTipoComprobantes.ClientID%>').value;
                                if (tipo_comprobantes == 'CC')
                                    msg += 'Centro de Costo es requerido en la fila ' + (i + 1) + '\n';
                                else if (tipo_comprobantes == 'OI')
                                    msg += 'Orden interna es requerida en la fila ' + (i + 1) + '\n';
                                else if (tipo_comprobantes == 'PEP')
                                    msg += 'Elemento PEP es requerido en la fila ' + (i + 1) + '\n';
                                else if (tipo_comprobantes == 'RF')
                                    msg += 'Reembolso Filiales es requerido en la fila ' + (i + 1) + '\n';
                            }
                            if (document.getElementById('mt_lista_necesidad_' + i) != null) {
                                if (document.getElementById('mt_lista_necesidad_' + i).value.length == 0 || document.getElementById('mt_lista_necesidad_' + i).value == '0') {
                                    msg += 'Necesidad es requerida en la fila ' + (i + 1) + '\n';
                                }
                            }

                            if (document.getElementById('mt_lista_concepto_' + i).value == '0|0|0|0') {
                                msg += 'Concepto requerido en la fila ' + (i + 1) + '\n';
                            }

                            var concepto = document.getElementById('mt_lista_concepto_' + i).value;
                            var id_concepto = concepto.split('|')[0];
                            var es_iva_editable = concepto.split('|')[1];
                            var requiere_retencion = concepto.split('|')[2];
                            var permite_propina = concepto.split('|')[3];

                            if (es_iva_editable == '0') {
                                if (document.getElementById('mt_lista_iva_' + i).value.length == 0) {
                                    msg += 'I.V.A. requerido en la fila ' + (i + 1) + '\n';
                                }
                            }

                            if (document.getElementById('mt_otros_impuestos_' + i).value.length == 0) {
                                document.getElementById('mt_otros_impuestos_' + i).value = '0';
                            }
                            if (document.getElementById('mt_iva_manual_' + i).value.length == 0) {
                                document.getElementById('mt_iva_manual_' + i).value = '0';
                            }
                            if (document.getElementById('mt_retencion_' + i).value.length == 0) {
                                document.getElementById('mt_retencion_' + i).value = '0';
                            }
                            if (document.getElementById('mt_propina_' + i).value.length == 0) {
                                document.getElementById('mt_propina_' + i).value = '0';
                            }
                        }

                    }
                }


                if (msg.length > 0) {
                    alert(msg);
                    return false;
                }


                var datos = {};
                var hayDatos = false;
                for (var i = 0; i < 200; i++) {
                    if (document.getElementById('mt_detalle_' + i) != null) {
                        if (document.getElementById('mt_seleccionado_' + i).checked == true) {
                            datos['mt_id_movimiento_' + i] = $('#mt_id_movimiento_' + i).val();
                            datos['mt_lista_concepto_' + i] = $('#mt_lista_concepto_' + i).val();
                            datos['mt_lista_tipo_comprobacion_' + i] = $('#mt_lista_tipo_comprobacion_' + i).val();
                            datos['mt_lista_necesidad_' + i] = $('#mt_lista_necesidad_' + i).val();
                            datos['mt_lista_iva_' + i] = $('#mt_lista_iva_' + i).val();
                            datos['mt_otros_impuestos_' + i] = $('#mt_otros_impuestos_' + i).val();
                            datos['mt_retencion_' + i] = $('#mt_retencion_' + i).val();
                            datos['mt_lista_num_personas_' + i] = $('#mt_lista_num_personas_' + i).val();
                            datos['mt_observaciones_' + i] = $('#mt_observaciones_' + i).val();

                            datos['mt_iva_manual_' + i] = $('#mt_iva_manual_' + i).val();
                            datos['mt_propina_' + i] = $('#mt_propina_' + i).val();

                            hayDatos = true;
                        }
                    }
                }

                datos['id_solicitud'] = $('#<%=txtIdSolicitudGasto.ClientID%>').val();
                datos['tipo'] = 'SV';
                datos['tipo_comprobantes'] = document.getElementById('<%=txtTipoComprobantes.ClientID%>').value;

                if (hayDatos) {
                    $.post('SolicitudAgregarComprobante.aspx', datos).done(function (data) {
                        if (data == 'OK|0') {
                            window.location = '/SolicitudGastosAgregar.aspx?id=' + document.getElementById('<%=txtIdSolicitudGasto.ClientID%>').value + '&v=' + new Date().getTime() + '#comprobantes'
                            return false;
                        } else if (data.indexOf('OK|') >= 0) {
                            var texto = data.replace('OK|', '');
                            alert('Hubo ' + texto + ' movimientos que no fueron agregados debido a que la forma de pago seleccionada no puede ser mezclada con las existentes en tu lista');
                            window.location = '/SolicitudGastosAgregar.aspx?id=' + document.getElementById('<%=txtIdSolicitudGasto.ClientID%>').value + '&v=' + new Date().getTime() + '#comprobantes'
                            return false;
                        } else {
                            alert(data);
                        }
                    });
                }

                $("#dialog-form").dialog("close");
            }

    </script>
</asp:Content>

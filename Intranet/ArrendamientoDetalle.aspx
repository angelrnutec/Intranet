<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="ArrendamientoDetalle.aspx.vb" Inherits="Intranet.ArrendamientoDetalle" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Import Namespace="Intranet.LocalizationIntranet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .tablaForm tr{
            height: 26px;
        }
    </style>

<%--        <script src="/scripts/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="/uploadify/scripts/jquery.uploadify.js" type="text/javascript"></script>
    <link rel="Stylesheet" type="text/css" href="/uploadify/CSS/uploadify.css" />--%>
      <link href="styles/jquery-ui.css" rel="stylesheet" />  
      <script src="Scripts/jquery-1.9.1.js"></script>
      <script src="Scripts/jquery-ui.js"></script>    

      <link href="Scripts/jquery.uploadfile/uploadfile.css" rel="stylesheet">
      <script src="Scripts/jquery.uploadfile/jquery.uploadfile.min.js"></script>


    <script type="text/javascript">

        function CalculaLabelsDetalle2(sender, eventArgs) {
            var cantidad = parseFloat(document.getElementById('<%=txtCantidadDetalle2.ClientID%>').value);
            var costo_unitario = parseFloat(document.getElementById('<%=txtMontoUnitarioDetalle2.ClientID%>').value);

            if (isNaN(cantidad)) {
                cantidad = 0;
            }
            if (isNaN(costo_unitario)) {
                costo_unitario = 0;
            }

            var total = (cantidad * costo_unitario).toFixed(2);
            document.getElementById('<%=lblMontoTotalDetalle2.ClientID%>').innerHTML = numberWithCommas(total);
            document.getElementById('<%=txtMontoTotalDetalle2.ClientID%>').value = total;
            

        }

        function CalculaLabels(sender, eventArgs) {

            var valor_total = parseFloat(document.getElementById('<%=txtMontoTotal.ClientID%>').value);
            if (isNaN(valor_total)) {
                valor_total = 0;
            }
            var comision = parseFloat(document.getElementById('<%=txtComision.ClientID%>').value);
            if (isNaN(comision)) {
                comision = 0;
            }
            var deposito = parseFloat(document.getElementById('<%=txtDepositoGarantia.ClientID%>').value);
            if (isNaN(deposito)) {
                deposito = 0;
            }
            var prima_financiada = parseFloat(document.getElementById('<%=txtSeguro.ClientID%>').value);
            if (isNaN(prima_financiada)) {
                prima_financiada = 0;
            }
            var arrendamiento_neto = (valor_total + comision + prima_financiada - deposito).toFixed(2);
            document.getElementById('<%=lblArrendamientoNeto.ClientID%>').innerHTML = numberWithCommas(arrendamiento_neto);
            




            var valor_rescate = parseFloat(document.getElementById('<%=txtValorRescate.ClientID%>').value);
            if (isNaN(valor_rescate)) {
                valor_rescate = 0;
            }
            var valor_residual = parseFloat(document.getElementById('<%=txtValorResidual.ClientID%>').value);
            if (isNaN(valor_residual)) {
                valor_residual = 0;
            }

            var valor_futuro = (parseFloat(valor_residual) - parseFloat(deposito)).toFixed(2);
            document.getElementById('<%=lblValorFuturo.ClientID%>').innerHTML = numberWithCommas(valor_futuro);


            var monto_parcialidad = parseFloat(document.getElementById('<%=txtMontoParcialidades.ClientID%>').value);
            if (isNaN(monto_parcialidad)) {
                monto_parcialidad = 0;
            }            
            var cantidad_pagos = parseFloat(document.getElementById('<%=txtNumeroParcialidades.ClientID%>').value);
            if (isNaN(cantidad_pagos)) {
                cantidad_pagos = 0;
            }
            var monto_parcialidad_seguro = parseFloat(document.getElementById('<%=txtParcialidadSeguro.ClientID%>').value);
            if (isNaN(monto_parcialidad_seguro)) {
                monto_parcialidad_seguro = 0;
            }

            console.log(parseFloat(cantidad_pagos));
            console.log(parseFloat((monto_parcialidad + monto_parcialidad_seguro) * -1));
            console.log(parseFloat(arrendamiento_neto));
            console.log(parseFloat(parseFloat(valor_residual * -1)));
            console.log('----------------------------------------------------');

            var tasa_mensual = rate(parseFloat(cantidad_pagos), parseFloat((monto_parcialidad + monto_parcialidad_seguro) * -1), parseFloat(arrendamiento_neto), parseFloat(valor_residual * -1), parseFloat(1));
            tasa_mensual = (tasa_mensual * 100).toFixed(2);
            var tasa_anual = (tasa_mensual * 12).toFixed(2);

            tasa_mensual_muestra = (parseFloat(tasa_mensual)).toFixed(1);

            document.getElementById('<%=lblTasaCalculadaMensual.ClientID%>').innerHTML = tasa_mensual_muestra + ' %';
            document.getElementById('<%=lblTasaCalculadaAnual.ClientID%>').innerHTML = tasa_anual + ' %';

            document.getElementById('<%=txtTasaCalculadaMensual.ClientID%>').value = tasa_mensual;




        }

        function numberWithCommas(x) {
            var valor = x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            return valor;
        }


        function rate(paymentsPerYear, paymentAmount, presentValue, futureValue, dueEndOrBeginning, interest) {
            //If interest, futureValue, dueEndorBeginning was not set, set now
            //if (interest == null) // not working here :D 
            if (isNaN(interest))
                interest = 0.1;
            //interest = 0.1;

            if (isNaN(futureValue))
                futureValue = 0;

            if (isNaN(dueEndOrBeginning))
                dueEndOrBeginning = 0;

            var FINANCIAL_MAX_ITERATIONS = 128;//Bet accuracy with 128
            var FINANCIAL_PRECISION = 0.0000001;//1.0e-8

            var y, y0, y1, x0, x1 = 0, f = 0, i = 0;
            var rate = interest; // initiallizing rate to our guess interest 
            if (Math.abs(rate) < FINANCIAL_PRECISION) {
                y = presentValue * (1 + paymentsPerYear * rate) + paymentAmount * (1 + rate * dueEndOrBeginning) * paymentsPerYear + futureValue;
            }
            else {
                f = Math.exp(paymentsPerYear * Math.log(1 + rate));
                y = presentValue * f + paymentAmount * (1 / rate + dueEndOrBeginning) * (f - 1) + futureValue;
            }
            y0 = presentValue + paymentAmount * paymentsPerYear + futureValue;
            y1 = presentValue * f + paymentAmount * (1 / rate + dueEndOrBeginning) * (f - 1) + futureValue;

            // find root by Newton secant method
            i = x0 = 0.0;
            x1 = rate;
            while ((Math.abs(y0 - y1) > FINANCIAL_PRECISION)
                && (i < FINANCIAL_MAX_ITERATIONS)) {
                rate = (y1 * x0 - y0 * x1) / (y1 - y0);
                x0 = x1;
                x1 = rate;

                if (Math.abs(rate) < FINANCIAL_PRECISION) {
                    y = presentValue * (1 + paymentsPerYear * rate) + paymentAmount * (1 + rate * dueEndOrBeginning) * paymentsPerYear + futureValue;
                }
                else {
                    f = Math.exp(paymentsPerYear * Math.log(1 + rate));
                    y = presentValue * f + paymentAmount * (1 / rate + dueEndOrBeginning) * (f - 1) + futureValue;
                }

                y0 = y1;
                y1 = y;
                ++i;
            }
            return rate;
            //return String(parseFloat(rate).toFixed(3)); // rounding it to 3 decimal places
            //return parseFloat(rate).toFixed(3);
        }



        function DateSelectedSeguro(sender, eventArgs) {

            var startDate = $find('<%=dtFechaInicioSeguro.ClientID%>');
            var endDate = $find('<%=dtFechaFinSeguro.ClientID%>');

            if ((startDate.get_selectedDate() != null) && (endDate.get_selectedDate() != null)) {
                var fecha_ini = String(startDate.get_selectedDate());
                var fecha_fin = String(endDate.get_selectedDate());




                var diffDays = endDate.get_selectedDate() - startDate.get_selectedDate();
                diffDays = diffDays / (1000 * 3600 * 24);
                anios = parseInt(diffDays / 363);
                document.getElementById('<%=lblPlazoSeguro.ClientID%>').innerHTML = anios;
                document.getElementById('<%=txtPlazoSeguroHidden.ClientID%>').value = anios;

            }
            else {
                document.getElementById('<%=lblPlazoSeguro.ClientID%>').innerHTML = "0";
                document.getElementById('<%=txtPlazoSeguroHidden.ClientID%>').value = "0";
            }
        }
    </script>







</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>


  <link href="styles/jquery-ui.css" rel="stylesheet" />  
  <script src="Scripts/jquery-ui.js"></script>    
  <link rel="stylesheet" type="text/css" href="/styles/styles.css" />

    <script type="text/javascript">
        function AbrirDialog() {
            $("#dialog-form").dialog("open");
            return false;
        }



        $(function () {

            $("#dialog-form").dialog({
                autoOpen: false,
                height: 200,
                width: 350,
                modal: true,
                buttons: {
                    "Guardar Rechazo": function () {
                        if (document.getElementById('txtMotivoRechazo').value == "") {
                            alert("Favor de ingresar el motivo del rechazo");
                        } else {
                            window.location = "/ArrendamientoRechazo.aspx?id=" + document.getElementById('<%=txtIdArrendamiento.ClientID%>').value + "&motivo=" + document.getElementById('txtMotivoRechazo').value;
                        }
                    },
                    "Cancelar": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                    //allFields.val("").removeClass("ui-state-error");
                }
            });

        });




    </script>

   <style type="text/css">
        .divDialog
        {
            height: 300px;
            margin: 0 0 0 0;
            font-family: 'arialnarrow', Helvetica, sans-serif;
            font-size: 12px;
            background-image: url(/images/page_bak.png);
        }

       .linksPaginacion a {
           color:#3b4e8d;
       }
    </style>




    <div id="dialog-form" title="<%=TranslateLocale.text("Motivo del Rechazo")%>" class="divDialog" style="display:none">     
        <table>
            <tr>
                <td>
                    <label for="txtMotivoRechazo"><%=TranslateLocale.text("Motivo del Rechazo")%></label>
                </td>
                <td>
                    <input type="text" name="txtMotivoRechazo" id="txtMotivoRechazo" class="text ui-widget-content ui-corner-all" style="width:250px" />
                </td>
            </tr>
        </table>                      
        <br />
    </div>    





    <asp:HiddenField ID="txtTasaCalculadaMensual" runat="server" Value="0" />
    <asp:HiddenField ID="txtIdEstatus" runat="server" Value="0" />
    <asp:HiddenField ID="txtIdDirRH" runat="server" Value="0" />
    <asp:HiddenField ID="txtIdDirNegocio" runat="server" Value="0" />
    <asp:HiddenField ID="txtIdDirFinanzas" runat="server" Value="0" />

    <table id="tblEstatus0" runat="server" visible="false" class="tablaForm" cellpadding="0" cellspacing="0" border="0" width="95%">
        <tr>
            <td colspan="5"><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Detalle del Arrendamiento")%></span><hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Estatus")%>:</td>
            <td><asp:Label ID="lblEstatus0" runat="server"></asp:Label>
                <br />
            </td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Usuario que registro")%>:</td>
            <td><asp:Label ID="lblUsuarioRegistro0" runat="server"></asp:Label></td>
        </tr>
        <tr>
            <td colspan="5">
                                <asp:Label ID="lblAutorizaciones0" runat="server"></asp:Label>
            </td>
        </tr>
        <tr>
            <td colspan="5"><hr /></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Número")%>:</td>
            <td><asp:Label ID="lblNumero0" runat="server" Text="Nuevo"></asp:Label></td>
            <td colspan="3">&nbsp;</td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Empresa")%>:</td>
            <td><asp:DropDownList ID="ddlEmpresa0" runat="server" Width="180px" Enabled="false"></asp:DropDownList></td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Categoría de Arrendamiento")%>:</td>
            <td><asp:DropDownList ID="ddlCategoriaArrendamiento0" runat="server" Width="180px" Enabled="false"></asp:DropDownList></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Departamento asignado")%>:</td>
            <td><asp:DropDownList ID="ddlDepartamento0" runat="server" Width="180px" AutoPostBack="true"></asp:DropDownList></td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Asignado a")%>:</td>
            <td><asp:DropDownList ID="ddlEmpleado0" runat="server" Width="180px"></asp:DropDownList></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Precio GE")%>:</td>
            <td><telerik:RadNumericTextBox ID="txtPrecioGE" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0"></telerik:RadNumericTextBox></td>
            <td colspan="3">&nbsp;</td>
        </tr>

        <tr>
            <td colspan="5">
                <asp:PlaceHolder ID="phTipoAuto" runat="server"></asp:PlaceHolder>
            </td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Comentarios")%>:</td>
            <td><br /><asp:TextBox ID="txtComentariosAuto" TextMode="MultiLine" runat="server" Rows="4" Columns="30"></asp:TextBox></td>
            <td colspan="3">&nbsp;</td>
        </tr>
    </table>
    <table id="tblGeneral" runat="server" class="tablaForm" cellpadding="0" cellspacing="0" border="0" width="95%">
        <tr>
            <td colspan="5"><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Detalle del Arrendamiento")%></span><hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Estatus")%>:</td>
            <td><asp:Label ID="lblEstatus" runat="server"></asp:Label></td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Usuario que registro")%>:</td>
            <td><asp:Label ID="lblUsuarioRegistro" runat="server"></asp:Label></td>
        </tr>
        <tr id="trAutosHeader1" runat="server" visible="false">
            <td><%=TranslateLocale.text("Precio GE")%>:</td>
            <td><asp:Label ID="lblPrecioGE" runat="server"></asp:Label></td>
            <td colspan="3">&nbsp;</td>
        </tr>

        <tr id="trAutosHeader2" runat="server" visible="false">
            <td colspan="5">
                <asp:Label ID="lblTipoAuto1" runat="server"></asp:Label>
            </td>
        </tr>
        <tr id="trAutosHeader3" runat="server" visible="false">
            <td><%=TranslateLocale.text("Comentarios")%>:</td>
            <td><br /><asp:Label ID="lblComentariosAuto" runat="server"></asp:Label></td>
            <td colspan="3">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="5">
                                <asp:Label ID="lblAutorizaciones" runat="server"></asp:Label>
            </td>
        </tr>

        <tr>
            <td colspan="5"><hr /></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Número")%>:</td>
            <td><asp:Label ID="lblNumero" runat="server" Text="Nuevo"></asp:Label></td>
            <td style="width:50px">&nbsp;</td>
            <td><%=TranslateLocale.text("Contrato Maestro")%>:</td>
            <td><asp:TextBox ID="txtContratoMaestro" runat="server" Width="80px" MaxLength="32"></asp:TextBox></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Empresa")%>:</td>
            <td><asp:DropDownList ID="ddlEmpresa" runat="server" Width="180px"></asp:DropDownList></td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Categoría de Arrendamiento")%>:</td>
            <td><asp:DropDownList ID="ddlCategoriaArrendamiento" runat="server" Width="180px"></asp:DropDownList></td>
        </tr>
        <tr id="trAutos1" runat="server">
            <td><%=TranslateLocale.text("Folio/Contrato/Arrendadora")%>:</td>
            <td><asp:TextBox ID="txtFolio" runat="server" Width="80px" MaxLength="32"></asp:TextBox></td>
            <td>&nbsp;</td>
            <td>
                <%=TranslateLocale.text("Arrendadora")%>:
            </td>
            <td>
                <asp:DropDownList ID="ddlArrendadora" runat="server" Width="180px"></asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Tipo")%>:</td>
            <td>
                <asp:DropDownList ID="ddlTipo" runat="server" Width="180px">
                </asp:DropDownList>
            </td>
            <td>&nbsp;</td>
            <td id="tdMaquinariaTecnologia1" runat="server"><%=TranslateLocale.text("Anexo")%>:</td>
            <td id="tdMaquinariaTecnologia2" runat="server">
                <asp:TextBox ID="txtAnexo" runat="server" Width="80px" MaxLength="32"></asp:TextBox>
            </td>
        </tr> 

        <tr>
            <td><%=TranslateLocale.text("Fecha Inicial")%>:</td>
            <td>
                <telerik:RadDatePicker ID="dtFechaInicio" runat="server" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy" Width="100px" MinDate="2010/01/01"></telerik:RadDatePicker>
            </td>
            <td style="width:120px">&nbsp;</td>
            <td><%=TranslateLocale.text("Dia de Pago")%>:</td>
            <td>
                <asp:DropDownList ID="ddlDiaPago" runat="server" Width="75px">
                </asp:DropDownList>
            </td>
        </tr>

        <tr>
            <td><%=TranslateLocale.text("Fecha Final")%>:</td>
            <td>
                <telerik:RadDatePicker ID="dtFechaFin" runat="server" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy" Width="100px" MinDate="2010/01/01"></telerik:RadDatePicker>
            </td>
            <td style="width:120px">&nbsp;</td>
            <td><%=TranslateLocale.text("Tasa del Anexo")%>:</td>
            <td><telerik:RadNumericTextBox ID="txtTasa" runat="server" NumberFormat-DecimalDigits="3" Width="70px" Value="0"></telerik:RadNumericTextBox>%</td>
        </tr>

        <tr>
            <td><%=TranslateLocale.text("Departamento asignado")%>:</td>
            <td><asp:DropDownList ID="ddlDepartamento" runat="server" Width="180px" AutoPostBack="true"></asp:DropDownList></td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Asignado a")%>:</td>
            <td><asp:DropDownList ID="ddlEmpleado" runat="server" Width="180px"></asp:DropDownList></td>
        </tr>
        <tr id="trFlotilla" runat="server">
            <td><%=TranslateLocale.text("Flotilla")%>:</td>
            <td>
                <asp:Label ID="lblFlotilla" runat="server"></asp:Label>
                <asp:TextBox ID="txtFlotilla" runat="server" Visible="false"></asp:TextBox>

            </td>
            <td colspan="3">&nbsp;</td>
        </tr>
        <tr>
            <td colspan="5"><hr /></td>
        </tr>
        <tr>
            <td colspan="5">
                <table id="tblDetalle1" runat="server" visible="true" border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
                    <tr>
                        <th><%=TranslateLocale.text("Marca")%></th>
                        <th><%=TranslateLocale.text("Modelo")%></th>
                        <th><%=TranslateLocale.text("Año")%></th>
                        <th><%=TranslateLocale.text("No. de Serie (VIN)")%></th>
                        <th><%=TranslateLocale.text("Color")%></th>
                    </tr>
                    <tr>
                        <td><asp:TextBox ID="txtMarca" runat="server"></asp:TextBox></td>
                        <td><asp:TextBox ID="txtModelo" runat="server"></asp:TextBox></td>
                        <td><asp:TextBox ID="txtAnio" runat="server"></asp:TextBox></td>
                        <td><asp:TextBox ID="txtNoSerie" runat="server"></asp:TextBox></td>
                        <td><asp:TextBox ID="txtColor" runat="server"></asp:TextBox></td>
                    </tr>
                </table>
                <table id="tblDetalle2" runat="server" visible="true" border="1" cellpadding="0" cellspacing="0" style="border-collapse:collapse;">
                    <tr>
                        <th><%=TranslateLocale.text("No. de Factura")%></th>
                        <th><%=TranslateLocale.text("Proveedor")%></th>
                        <th><%=TranslateLocale.text("Cantidad")%></th>
                        <th><%=TranslateLocale.text("Monto Unitario (Sin IVA)")%></th>
                        <th><%=TranslateLocale.text("Monto Total")%></th>
                        <th><%=TranslateLocale.text("Descripcion")%></th>
                    </tr>
                    <tr>
                        <td><asp:TextBox ID="txtNumFactura" runat="server"></asp:TextBox></td>
                        <td><asp:TextBox ID="txtProveedor" runat="server"></asp:TextBox></td>
                        <td><telerik:RadNumericTextBox ID="txtCantidadDetalle2" runat="server" NumberFormat-DecimalDigits="0" Width="70px" Value="1" ClientEvents-OnBlur="CalculaLabelsDetalle2"></telerik:RadNumericTextBox></td>
                        <td><telerik:RadNumericTextBox ID="txtMontoUnitarioDetalle2" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0.00" ClientEvents-OnBlur="CalculaLabelsDetalle2"></telerik:RadNumericTextBox></td>
                        <td><asp:Label ID="lblMontoTotalDetalle2" runat="server" Text="0.00"></asp:Label>
                            <asp:TextBox ID="txtMontoTotalDetalle2" runat="server" style="display:none"></asp:TextBox>
                        </td>
                        <td><asp:TextBox ID="txtDescripcionDetalle2" TextMode="MultiLine" runat="server" Rows="4" Columns="30"></asp:TextBox></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td colspan="5"><hr /></td>
        </tr>

        <tr>
            <td><%=TranslateLocale.text("Periodicidad del Arrendamiento")%>:</td>
            <td><asp:DropDownList ID="ddlPeriodicidad" runat="server" Width="180px"></asp:DropDownList></td>
            <td style="width:120px">&nbsp;</td>
            <td><%=TranslateLocale.text("Número de Parcialidades")%>:</td>
            <td><telerik:RadNumericTextBox ID="txtNumeroParcialidades" runat="server" NumberFormat-DecimalDigits="0" Width="70px" Value="0"></telerik:RadNumericTextBox></td>
        </tr>

        <tr>
            <td>(A) <%=TranslateLocale.text("Valor/Costo del Bien (Sin IVA)")%>:</td>
            <td><telerik:RadNumericTextBox ID="txtMontoTotal" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0" ClientEvents-OnBlur="CalculaLabels"></telerik:RadNumericTextBox></td>
            <td style="width:120px">&nbsp;</td>
            <td>(F) <%=TranslateLocale.text("Monto de la Parcialidad (Sin IVA)")%>:</td>
            <td><telerik:RadNumericTextBox ID="txtMontoParcialidades" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0"></telerik:RadNumericTextBox></td>
        </tr>
        <tr>
            <td>(B) <%=TranslateLocale.text("Comisión apertura/Costo Originación")%>:</td>
            <td><telerik:RadNumericTextBox ID="txtComision" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0" ClientEvents-OnBlur="CalculaLabels"></telerik:RadNumericTextBox></td>
            <td style="width:120px">&nbsp;</td>
            <td><%=TranslateLocale.text("Moneda")%>:</td>
            <td><asp:DropDownList ID="ddlMoneda" runat="server" Width="180px"></asp:DropDownList></td>
        </tr>
        <tr>
            <td>(C) <%=TranslateLocale.text("Deposito en Garantía")%>:</td>
            <td><telerik:RadNumericTextBox ID="txtDepositoGarantia" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0" ClientEvents-OnBlur="CalculaLabels"></telerik:RadNumericTextBox></td>
            <td style="width:120px">&nbsp;</td>
            <td><%=TranslateLocale.text("Arrendamiento Neto")%> (A + B + E - C) :</td>
            <td><asp:Label ID="lblArrendamientoNeto" runat="server" Text="0.00"></asp:Label> </td>
        </tr>
        <tr id="trAutos2" runat="server">
            <td>(D) <%=TranslateLocale.text("Valor Residual")%>:</td>
            <td><telerik:RadNumericTextBox ID="txtValorResidual" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0" ClientEvents-OnBlur="CalculaLabels"></telerik:RadNumericTextBox> </td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Valor de Compra al Final del Arrendamiento")%>:</td>
            <td><telerik:RadNumericTextBox ID="txtValorRescate" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0" ClientEvents-OnBlur="CalculaLabels"></telerik:RadNumericTextBox></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Valor Futuro")%> (D-C):</td>
            <td><asp:Label ID="lblValorFuturo" runat="server" Text="0.00"></asp:Label></td>
            <td style="width:120px">&nbsp;</td>
            <td><%=TranslateLocale.text("Tasa Calculada Mensual")%>:</td>
            <td><asp:Label ID="lblTasaCalculadaMensual" runat="server" Text="0.00"></asp:Label></td>
        </tr>
        <tr>
            <td colspan="3">&nbsp;</td>
            <td><%=TranslateLocale.text("Tasa Calculada Anual")%>:</td>
            <td><asp:Label ID="lblTasaCalculadaAnual" runat="server" Text="0.00"></asp:Label></td>
        </tr>




        <tr>
            <td colspan="5"><hr /></td>
        </tr>

        <tr>
            <td><%=TranslateLocale.text("Aseguradora")%>:</td>
            <td>
                <asp:DropDownList ID="ddlAseguradora" runat="server" Width="180px"></asp:DropDownList>
            </td>
            <td style="width:120px">&nbsp;</td>
            <td><%=TranslateLocale.text("Fecha Inicial del Seguro")%>:</td>
            <td>
                <telerik:RadDatePicker ID="dtFechaInicioSeguro" runat="server" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy" Width="100px" MinDate="2010/01/01"><ClientEvents OnDateSelected="DateSelectedSeguro" /></telerik:RadDatePicker>
            </td>
        </tr>

        <tr>
            <td>(E) <%=TranslateLocale.text("Prima total financiada")%>:</td>
            <td><telerik:RadNumericTextBox ID="txtSeguro" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0" ClientEvents-OnBlur="CalculaLabels"></telerik:RadNumericTextBox></td>
            <td style="width:120px">&nbsp;</td>
            <td><%=TranslateLocale.text("Fecha Final del Seguro")%>:</td>
            <td>
                <telerik:RadDatePicker ID="dtFechaFinSeguro" runat="server" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy" Width="100px" MinDate="2010/01/01"><ClientEvents OnDateSelected="DateSelectedSeguro" /></telerik:RadDatePicker>
            </td>
        </tr>

        <tr>
            <td><%=TranslateLocale.text("No. de póliza")%>:</td>
            <td><asp:TextBox ID="txtNumPoliza" runat="server" Width="80px" MaxLength="32"></asp:TextBox></td>
            <td style="width:120px">&nbsp;</td>
            <td><%=TranslateLocale.text("Plazo de la póliza")%>:</td>
            <td>
                <asp:Label ID="lblPlazoSeguro" runat="server" Text="0"></asp:Label> año(s)
                    <asp:HiddenField ID="txtPlazoSeguroHidden" runat="server" Value="0" />

            </td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Periodicidad para el Pago del Seguro")%>:</td>
            <td><asp:DropDownList ID="ddlPeriodicidadSeguro" runat="server" Width="180px"></asp:DropDownList></td>
            <td style="width:120px">&nbsp;</td>
            <td>(G) <%=TranslateLocale.text("Monto de la Parcialidad (Sin IVA)")%>:</td>
            <td><telerik:RadNumericTextBox ID="txtParcialidadSeguro" runat="server" NumberFormat-DecimalDigits="2" Width="70px" Value="0" ClientEvents-OnBlur="CalculaLabels"></telerik:RadNumericTextBox></td>
        </tr>
        <tr>
            <td colspan="5"><hr /></td>
        </tr>
         <tr>
            <td><%=TranslateLocale.text("Fecha de recepción")%>:</td>
            <td>
                <telerik:RadDatePicker ID="dtFechaRecepcion" runat="server" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy" Width="100px" MinDate="2010/01/01"></telerik:RadDatePicker>
            </td>
            <td style="width:120px">&nbsp;</td>
            <td><%=TranslateLocale.text("Recibido por")%>:</td>
            <td>
                <asp:TextBox ID="txtRecibidoPor" runat="server" MaxLength="256"></asp:TextBox>
            </td>
        </tr>
    </table>

    <table class="tablaForm" cellpadding="0" cellspacing="0" border="0" width="95%">
        <tr>
            <td colspan="5"><hr /></td>
        </tr>

        <tr>
            <td colspan="5">
                <br />
                <asp:Button ID="btnRegresar" runat="server" CssClass="botones" Text="Regresar" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnGuardar" runat="server" CssClass="botones" Text="Guardar" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnEliminar" runat="server" CssClass="botones" Text="Eliminar" Visible="false" OnClientClick="return confirm('Seguro que desea eliminar este registro?');" />
                &nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnAutorizar" runat="server" CssClass="botones" Text="Autorizar" Visible="false"  />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnRechazar" runat="server" CssClass="botones" Text="Rechazar" Visible="false" OnClientClick="AbrirDialog();return false;" />
            </td>
        </tr>
        <tr>
            <td colspan="5" id="tblArchivos" runat="server">
                <br />
                <br />
                <br />
                <br />
                <br />


                <strong style="font-size:15px"><%=TranslateLocale.text("Archivos asociados a este arrendamiento")%></strong>
                <br />
                <div id="divArchivos" runat="server">
                </div>
                <br />
                <br />
                <div id="UploadArchivoBoton" style="display:none">
                    <h3 id="tipoArchivoSubir"></h3>
                    <div id="fileuploader">Upload</div>
                    <input type="hidden" id="idTipoArchivo" name="idTipoArchivo" value="1" />
                </div>

                <br />

            </td>
        </tr>
    </table>

    <asp:TextBox ID="txtIdArrendamiento" runat="server" style="display:none;"></asp:TextBox>


<script type="text/javascript">

    $(document).ready(function () {
        RegistraUploadify();
        RecuperaDocumentos(document.getElementById('<%=txtIdArrendamiento.ClientID%>').value);
    });

    function MuestraBotonUpload(tipo, nombre) {
        $('#UploadArchivoBoton').show();
        $('#idTipoArchivo').val(tipo);
        $('#tipoArchivoSubir').html(nombre);
        window.scrollTo(0, document.body.scrollHeight);
    }

    function RegistraUploadify() {

        $("#fileuploader").uploadFile({
            url: "/UploadArrendamientos.ashx",
            multiple: false,
            dragDrop: false,
            fileName: "myfile",
            uploadStr: "<%=TranslateLocale.text("Subir Archivo")%>",
            //allowedTypes: "xml",
            formData: { "id": 1 },
            onSuccess: function (files, data, xhr, pd) {
                if (data.indexOf("Error=").length >= 0) {
                    alert(data);
                } else {
                    AgregaDocumentos(document.getElementById('<%=txtIdArrendamiento.ClientID%>').value, data, $('#idTipoArchivo').val());
                    setTimeout(function () {
                        $('#UploadArchivoBoton').hide();
                    }, 2000);
                }
            },
            onError: function (files, status, errMsg, pd) {
                alert(JSON.stringify(files));
            }
        });

    }

    function AgregaDocumentos(id, nombre, idTipoArchivo) {
        $.ajax({
            type: "GET",
            url: "/Servicios/DocumentosArrendamientoAgregar.aspx",
            data: { id: id, nombre: nombre, idTipoArchivo: idTipoArchivo },
            success: function (datos) {
                RecuperaDocumentos(id);
            },
            error: function (error) {
                alert(error);
            }
        });
        return true;
    }

    function RecuperaDocumentos(id) {
        $.ajax({
            type: "GET",
            url: "/Servicios/DocumentosArrendamiento.aspx?id=" + id,
            success: function (datos) {
                document.getElementById('<%=divArchivos.ClientID%>').innerHTML = datos;
            },
            error: function (error) {
                alert(error);
            }
        });
        return true;
    }

    function EliminarDocumento(id) {
        if (confirm('<%=TranslateLocale.text("Seguro que desea eliminar este archivo?")%>')) {
            $.ajax({
                type: "GET",
                url: "/Servicios/DocumentosArrendamientoEliminar.aspx",
                data: { id: id },
                success: function (datos) {
                    RecuperaDocumentos(document.getElementById('<%=txtIdArrendamiento.ClientID%>').value);
            },
            error: function (error) {
                alert(error);
            }
        });
            return true;
        }
    }


</script>
</asp:Content>

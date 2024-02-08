<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="GeneraPolizasContables.aspx.vb" Inherits="Intranet.GeneraPolizasContables" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    	<link rel="stylesheet" type="text/css" href="/styles/tablas.css" />
      <link href="styles/jquery-ui.css" rel="stylesheet" />  
      <script src="Scripts/jquery-1.9.1.js"></script>
      <script src="Scripts/jquery-ui.js"></script>    
      <link rel="stylesheet" type="text/css" href="/styles/styles.css" />

    <script type="text/javascript">
        function EditarPoliza(folio_poliza, tipo_poliza) {

            $(function () {
                $("#dialog-form").html('Consultando, espere un momento...');
                $("#dialog-form").load('/PolizaEditar.aspx?poliza=' + folio_poliza + '&tipo_poliza=' + tipo_poliza).dialog("open");
                //$("#dialog-form").dialog("open");
            });

            return false;
        }

        $(document).ready(function () {
            $("#dialog-form").dialog({
                autoOpen: false,
                height: 450,
                width: 800,
                modal: true,
                buttons: {
                    "Guardar": function () {
                        GuardaCambios();
                    },
                    "Regresar": function () {
                        $(this).dialog("close");
                    },
                    "Agregar Detalle": function () {
                        AgregarDetalle();
                    }
                }
            });
        });

        function AgregarDetalle() {
            var NUMERO_AGREGADO = parseInt($('#detallesAgregados').val());
            NUMERO_AGREGADO++;
            $('#detallesAgregados').val(NUMERO_AGREGADO);
            var trString = '';
            trString += '<tr id="detalle_' + NUMERO_AGREGADO + '">';
            trString += '<td>';
            trString += '    <input type="hidden" id="id_detalle_' + NUMERO_AGREGADO + '" value="0" />';
            trString += '    <input type="text" id="cuenta_' + NUMERO_AGREGADO + '" value="" style="width:80px" maxlength="17" readonly="readonly" />';
            trString += '</td>';
            trString += '<td><input type="text" id="clave_' + NUMERO_AGREGADO + '" value="" style="width:45px" maxlength="2" /></td>';
            trString += '<td><input type="text" id="proyecto_' + NUMERO_AGREGADO + '" value="" style="width:100px" maxlength="12" /></td>';
            trString += '<td><input type="text" id="necesidad_' + NUMERO_AGREGADO + '" value="" style="width:40px" maxlength="12" /></td>';
            trString += '<td><input type="text" id="importe_' + NUMERO_AGREGADO + '" value="" style="width:70px" maxlength="12" /></td>';
            trString += '<td><input type="text" id="descripcion_' + NUMERO_AGREGADO + '" value="" style="display:none" maxlength="50" />';
            trString += '<input type="text" id="id_concepto_' + NUMERO_AGREGADO + '" value="31" style="display:none" maxlength="50" />';
            trString += '<select id="combo_cuentas_' + NUMERO_AGREGADO + '" style="width:250px" onchange="ActualizaCuenta(' + NUMERO_AGREGADO + ')">';
            trString += '<option value="0-0||" selected>--Selecciona--</option>';
            trString += '</select>';
            trString += '</td>';

            trString += '<td>';
            trString += '    <select id="tipo_comprobacion_' + NUMERO_AGREGADO + '" style="width:45px">';
            trString += '        <option value="OI">OI</option>';
            trString += '        <option value="CC">CC</option>';
            trString += '        <option value="PP">EP</option>';
            trString += '    </select><a href="javascript:EliminarDetalle(' + NUMERO_AGREGADO + ',0)">Eliminar</a>';
            trString += '</td>';
            trString += '</tr>';

            $('#tblDetallesPoliza tr:last').after(trString);


            var $options = $("#combo_cuentas_0 > option").clone();
            $('#combo_cuentas_' + NUMERO_AGREGADO).append($options);
            $('#combo_cuentas_' + NUMERO_AGREGADO).val('0-0||');

        }
        function EliminarDetalle(id, id_detalle) {
            $('#detalle_' + id).remove();

            var eliminados = $('#eliminados').val();
            eliminados += '|' + id_detalle + '|';
            $('#eliminados').val(eliminados);
        }

        function GuardaCambios() {
            var msg = '';
            var importeItems = 0;
            var importeTotal = $('#importeTotal').val();
            var maxId = parseInt($('#detallesAgregados').val());

            for (var i = 0; i < 200; i++) {
                if (document.getElementById('cuenta_' + i) != null) {
                    if (document.getElementById('cuenta_' + i).value.length == 0) {
                        msg += 'Cuenta requerida en la fila ' + (i + 1) + '\n';
                    }
                    if (document.getElementById('clave_' + i).value.length == 0) {
                        msg += 'Clave I.V.A. requerida en la fila ' + (i + 1) + '\n';
                    }
                    if (document.getElementById('importe_' + i).value.length == 0) {
                        document.getElementById('importe_' + i).value = '0';
                    }
                    if (document.getElementById('necesidad_' + i).value.length > 0 && document.getElementById('necesidad_' + i).value.length != 4) {
                        msg += 'Necesidad debe ser de 4 caracteres en la fila ' + (i + 1) + '\n';
                    }
                    if (isNaN(document.getElementById('importe_' + i).value)) {
                        msg += 'Importe debe ser numerico en la fila ' + (i + 1) + '\n';
                    } else {
                        importeItems += parseFloat($('#importe_' + i).val());
                    }
                    if (document.getElementById('descripcion_' + i).value.length == 0) {
                        msg += 'Descripcion requerida en la fila ' + (i + 1) + '\n';
                    }
                }
            }


            if (msg.length > 0) {
                alert(msg);
                return false;
            }


            if (parseFloat(importeItems).toFixed(2) != parseFloat(importeTotal).toFixed(2)) {
                if (!confirm('<%=TranslateLocale.text("Hay una diferencia entre los conceptos y el encabezado: ")%>' + parseFloat(importeItems).toFixed(2) + ' vs ' + parseFloat(importeTotal).toFixed(2) + '<%=TranslateLocale.text(". Se modificara el encabezado en automático, ¿Seguro que desea continuar?")%>')) {
                    return false;
                }
            }


            var datos = {};
            for (var i = 0; i < 200; i++) {
                if (document.getElementById('cuenta_' + i) != null) {

                    datos['id_detalle_' + i] = $('#id_detalle_' + i).val();
                    datos['cuenta_' + i] = $('#cuenta_' + i).val();
                    datos['clave_' + i] = $('#clave_' + i).val();
                    datos['proyecto_' + i] = $('#proyecto_' + i).val();
                    datos['necesidad_' + i] = $('#necesidad_' + i).val();
                    datos['importe_' + i] = $('#importe_' + i).val();
                    datos['descripcion_' + i] = $('#descripcion_' + i).val();
                    datos['tipo_comprobacion_' + i] = $('#tipo_comprobacion_' + i).val();
                    datos['id_concepto_' + i] = $('#id_concepto_' + i).val();
                }
            }
            datos['id_solicitud'] = $('#id_solicitud').val();
            datos['fecha_doc'] = $('#dtFechaDoc').val();
            datos['referencia'] = $('#referencia').val();
            datos['tipo_poliza'] = $('#tipo_poliza').val();
            datos['eliminados'] = $('#eliminados').val();

            $.post('PolizaEditarGuarda.aspx', datos).done(function (data) {
                if (data == 'OK') {
                    alert('Datos modificados con exito');
                    window.location.reload()
                } else {
                    alert(data);
                }
            });
            $("#dialog-form").dialog("close");
        }

    </script>
    <style type="text/css">
        .divDialog
        {
            height: 100%;
            margin: 0 0 0 0;
            font-family: 'arialnarrow', Helvetica, sans-serif;
            font-size: 14px;
            background-image: url(/images/page_bak.png);
        }

        #tblFiltros td {
            height:23px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>

        <div id="dialog-form" title="<%=TranslateLocale.text("Modificar datos de la Póliza")%>" class="divDialog" style="display:none"></div>



    <table cellpadding="0" cellspacing="0" border="0" width="900px">
        <tr>
            <td><span style="font-size:15px; font-weight:bold;"><asp:Label ID="lblNombreReporte" runat="server"></asp:Label></span>
                <hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td>
                <table id="tblFiltros" cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td><%=TranslateLocale.text("Tipo de Solicitud")%>:</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:DropDownList ID="ddlPoliza" runat="server" Width="300px" AutoPostBack="true">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr runat="server" id="campoTipoConcepto">
                        <td><%=TranslateLocale.text("Tipo de Concepto")%>:</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:DropDownList ID="ddlTipoConcepto" runat="server" Width="300px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Empresa")%>:</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:DropDownList ID="ddlEmpresa" runat="server" Width="300px" AutoPostBack="true"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Empleado")%>:</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:DropDownList ID="ddlEmpleado" runat="server" Width="300px"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Estatus")%>:</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:DropDownList ID="ddlEstatus" runat="server" Width="300px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Fecha Ini")%>:</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <telerik:RadDatePicker ID="dtFechaIni" runat="server" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy" Width="100px" MinDate="2013/01/01"></telerik:RadDatePicker>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <%=TranslateLocale.text("Fecha Fin")%>:&nbsp;&nbsp;&nbsp;
                            <telerik:RadDatePicker ID="dtFechaFin" runat="server" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy" Width="100px" MinDate="2013/01/01"></telerik:RadDatePicker>


                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" align="left">
                            <div style="height:7px"></div>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnGenerar" Visible="true" runat="server" Text="Consultar Pólizas" />&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnCancelar" runat="server" Text="Salir" />&nbsp;&nbsp;&nbsp;&nbsp;                            
                            <asp:Button ID="btnExportarPoliza" Visible="false" OnClientClick="return EnviarPolizasSap(this)" runat="server" Text="Enviar Póliza(s) a SAP" UseSubmitBehavior="false" />&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnDescargarPoliza" OnClientClick="return DescargarPolizasSap(this)" runat="server" Text="Descargar Póliza(s) por corregir de SAP"  />
                        </td>
                    </tr>
                </table>

            </td>
        </tr>
        <tr>
            <td><br /><hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td id="tdPolizas">
                <div style="font-weight:bold;color:red;"><asp:Label ID="lblMensaje" runat="server"></asp:Label></div>
                <div id="divSeleccionaTodos" runat="server" visible="false">
                    <input id="chkSeleccionaTodos" type="checkbox" value="1" onchange="SeleccionaTodo()" /><%=TranslateLocale.text("Seleccionar todas")%>
                </div>
                <asp:PlaceHolder ID="phTablaPoliza" runat="server"></asp:PlaceHolder>
                <asp:TextBox ID="txtPoliza" runat="server" style="display:none;"></asp:TextBox>
                <asp:TextBox ID="txtIdRef" runat="server" style="display:none;"></asp:TextBox>

            </td>
        </tr>
        <tr>
            <td id="tdEnviando" style="display:none"><br /><span style="font-size:18px;color:#006bff"><%=TranslateLocale.text("Enviando Pólizas a SAP. Espere un momento")%>...</span></td>
        </tr>        
        <tr>
            <td id="tdResultadoEnvio" style="display:none"><br />
                <div style="font-size:18px;color:#006bff"><%=TranslateLocale.text("Resultados del envio a SAP")%></div>
                <span id="divResultados" style="font-size:13px;"></span>
            </td>
        </tr>  
        <tr>
            <td id="tdDescargandoPolizas" style="display:none"><br /><span style="font-size:18px;color:#006bff"><%=TranslateLocale.text("Descargando Pólizas de SAP. Espere un momento")%>...</span></td>
        </tr>                
    </table>

    <script type="text/javascript">
        function SeleccionaTodo() {
            var opcion = false;
            if (document.getElementById('chkSeleccionaTodos').checked) {
                opcion = true;
            }
            for (var i = 1; i < 100; i++) {
                if (document.getElementById('checkId-' + i) != null)
                    document.getElementById('checkId-' + i).checked = opcion;
            }
        }

        
        function EnviarPolizasSap(boton) {
            var listaPolizas = '';
            for (var i = 1; i < 100; i++) {
                if (document.getElementById('checkId-' + i) != null)
                    if (document.getElementById('checkId-' + i).checked) {
                        listaPolizas += document.getElementById('checkId-' + i).value + ',';
                    }
            }
            if (listaPolizas == '') {
                alert('Debes seleccionar al menos una póliza para enviar a SAP.');
                return false;
            }


            var tipo_concepto = '';
            if (document.getElementById('<%=ddlTipoConcepto.ClientID %>') != null) {
                tipo_concepto = document.getElementById('<%=ddlTipoConcepto.ClientID %>').value;
            }

            boton.style.display = 'none';
            $('#tdPolizas').hide();
            $('#tdEnviando').show();

            var params = "{listaPolizas:'" + listaPolizas + "', tipo: '" + tipo_concepto + "', poliza: '" + document.getElementById('<%=ddlPoliza.ClientID %>').value + "'}";
            $.ajax({
                type: "POST",
                url: "GeneraPolizasContables.aspx/EnviarPolizas",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                async: true,
                data: params,
                success: function (data) {
                    if (data.d != "") {
                        $('#tdEnviando').hide();
                        $('#tdResultadoEnvio').show();

                        var resultado = data.d;
                        $('#divResultados').html(resultado);
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert(textStatus + ": " + XMLHttpRequest.responseText);
                }
            });
            return false;
        }

        function DescargarPolizasSap(boton) {
            boton.style.display = 'none';
            $('#tdPolizas').hide();
            $('#tdDescargandoPolizas').show();
            return true;
        }

    </script>
</asp:Content>

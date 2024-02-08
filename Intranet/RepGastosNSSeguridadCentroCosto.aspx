<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="RepGastosNSSeguridadCentroCosto.aspx.vb" Inherits="Intranet.RepGastosNSSeguridadCentroCosto" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>
    <table cellpadding="0" cellspacing="0" border="0" width="600px">
        <tr>
            <td><span style="font-size:15px; font-weight:bold;">Seguridad por Empleado - Centro de Costo</span>
                <hr style="margin:0; padding:0;" />
                <br /><br />
            </td>
        </tr>
        <tr>
            <td>
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td colspan="3">
                            <b>Empleados con Acceso a Reportes NBR:</b>
                            <select id="cbEmpleados" name="cbEmpleados" style="width:250px" onchange="CargaCentrosCosto(this.value)">
                                <option value="0">Cargando...</option>
                            </select>
                            <br /><br />
                        </td>
                    </tr>
                    <tr>
                        <td><b>Centros de Costo Disponibles</b></td>
                        <td>&nbsp;</td>
                        <td><b>Centros de Costo Asignados</b></td>
                    </tr>
                    <tr valign="top">
                        <td>
                            <select id="cbDisponibles" name="cbDisponibles"  multiple="multiple" size="20"  style="width:250px">
                                <option value="0">--Seleccione un empleado--</option>
                            </select>
                        </td>
                        <td align="center">
                            <br /><br /><br /><br /><br /><br />
                            <input type="button" value="Asignar" id="swapLeft" name="swapLeft" />
                            <br /><br />
                            <input type="button" value="Quitar" id="swapRight" name="swapRight" />
                        </td>
                        <td>
                            <select id="cbAsignados" name="cbAsignados"  multiple="multiple" size="20"  style="width:250px">
                                <option value="0">--Seleccione un empleado--</option>
                            </select>
                            <br />
                            *Dejar vacia esta lista implica que el empleado tiene acceso a todos los centros de costos.
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" align="right">
                            <div style="height:7px"></div>
                            <input type="button" id="btnGuardar" name="btnGuardar" value="Guardar" onclick="GuardaCentrosCosto()" />
                        </td>
                    </tr>
                </table>

                <br /><br />

            </td>
        </tr>
        <tr>
            <td><br /><hr style="margin:0; padding:0;" /></td>
        </tr>
    </table>

    <script type="text/javascript">

        var SWAPLIST = {};
        SWAPLIST.swap = function(from, to) {
            $(from)
              .find(':selected')
              .appendTo(to);
        }
	
        $('#swapLeft').click(function() {
            SWAPLIST.swap('#cbDisponibles', '#cbAsignados');
        });
        $('#swapRight').click(function() {
            SWAPLIST.swap('#cbAsignados', '#cbDisponibles');
        });

        function selectAll(box) {
            for (var i = 0; i < box.length; i++) {
                box.options[i].selected = true;
            }
        }


        function CargaEmpleados() {
            $.getJSON('/json/cargaEmpleados.aspx',
            function (result) {
                var optionsValues = '<select id="cbEmpleados" name="cbEmpleados" style="width:250px" onchange="CargaCentrosCosto(this.value)">';
                $.each(result, function (key, val) {
                    optionsValues += '<option value="' + val.id_empleado + '">' + val.nombre + '</option>';
                });
                optionsValues += '</select>';
                var options = $('#cbEmpleados');
                options.replaceWith(optionsValues);
            });
        }

        function CargaCentroCostosDisponibles(id_empleado) {
            $("#cbDisponibles").html('<option value="0">Cargando...</option>');
            $.getJSON('/json/cargaCentroCostos.aspx?tipo=D&id_empleado=' + id_empleado,
            function (result) {
                var optionsValues = '<select id="cbDisponibles" name="cbDisponibles" multiple="multiple" size="20"  style="width:250px">';
                $.each(result, function (key, val) {
                    optionsValues += '<option value="' + val.id_centro_costo + '">' + val.descripcion + '</option>';
                });
                optionsValues += '</select>';
                var options = $('#cbDisponibles');
                options.replaceWith(optionsValues);
            });
        }

        function CargaCentroCostosAsignados(id_empleado) {
            $("#cbAsignados").html('<option value="0">Cargando...</option>');
            $.getJSON('/json/cargaCentroCostos.aspx?tipo=A&id_empleado=' + id_empleado,
            function (result) {
                var optionsValues = '<select id="cbAsignados" name="cbAsignados" multiple="multiple" size="20"  style="width:250px">';
                $.each(result, function (key, val) {
                    optionsValues += '<option value="' + val.id_centro_costo + '">' + val.descripcion + '</option>';
                });
                optionsValues += '</select>';
                var options = $('#cbAsignados');
                options.replaceWith(optionsValues);
            });
        }

        $(document).ready(function () {
            CargaEmpleados();
        });

        function CargaCentrosCosto(id_empleado) {
            CargaCentroCostosDisponibles(id_empleado);
            CargaCentroCostosAsignados(id_empleado);
        }

        function GuardaCentrosCosto() {
            var id_empleado = document.getElementById('cbEmpleados').value;
            var centros = '';
            if (id_empleado > 0) {
                selectAll(document.getElementById('cbAsignados'));
                document.getElementById('btnGuardar').value = 'Guardando...';
                document.getElementById('btnGuardar').disabled = true;
                $("#cbAsignados").each(function () {
                    var centro = $(this).val();
                    if (centro != null && centro != "null") {
                        centros += centro + ',';
                    }
                });

                $.ajax({
                    type: "post",
                    url: "/json/guardaCentroCostos.aspx",
                    data: "id_empleado=" + id_empleado + "&centros=" + centros,
                    success: function (data) {
                        document.getElementById('btnGuardar').value = 'Guardar';
                        document.getElementById('btnGuardar').disabled = false;
                        alert(data);
                        CargaCentrosCosto(id_empleado);
                    }
                });
            }
        }


    </script>


</asp:Content>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepDetalleSaldoVacacionesImpresion.aspx.vb" Inherits="Intranet.RepDetalleSaldoVacacionesImpresion" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<%@ Register TagPrefix="asp" Assembly="ExportToExcel" Namespace="KrishLabs.Web.Controls" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reporte</title>	

    <style type="text/css">
        body {
            font-family:Arial,Tahoma;
        }
        td {
            border-style:solid;
            border-color:#dedede;
            border-width:1px;
            padding-left:3px;
            padding-right:2px;
            font-size:11px;
        }
        .titulos td {
            font-size:12px;
        }

        .filaTotales {
            background-color:#bebdbd;
            font-weight:bold;
            font-size:13px;
        }
        a {
            color:#333333;
            text-decoration:none;
        }
            a:hover {
                text-decoration: underline;
            }
    </style>
</head>
<body>
  <link href="styles/jquery-ui.css" rel="stylesheet" />  
  <script src="Scripts/jquery-1.9.1.js"></script>
  <script src="Scripts/jquery-ui.js"></script>    
  <link rel="stylesheet" type="text/css" href="/styles/styles.css" />


  <style type="text/css">
        .divDialog
        {
            height: 100%;
            margin: 0 0 0 0;
            font-family: 'arialnarrow', Helvetica, sans-serif;
            font-size: 14px;
            background-image: url(/images/page_bak.png);
        }

        .tablaEmpleados
        {
            width: 550px;
            border-style: solid;
            border-width: 1px;
            border-color: #cccfd3;
        }

        .tablaEmpleados td
        {
            border-style: solid;
            border-width: 1px;
            border-color: #cccfd3;
            height: 20px;
            padding-left: 5px;
            padding-right: 5px;
        }
    </style>
    <script>
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode != 46 && charCode != 45 && charCode > 31
              && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }

        function isNumber(o) {
            return !isNaN(o - 0) && o !== null && o !== "" && o !== false;
        }

        function validaNumero(control) {
            if (!isNumber(control.value)) { control.value = "0"; }
        }
        
        function NumCheck(e, field) {
            key = e.keyCode ? e.keyCode : e.which
            // backspace            
            if (key == 8) return true
            // 0-9
            if (key > 47 && key < 58) {
                if (field.value == "") return true
                regexp = /.[0-9]{9}$/
                return !(regexp.test(field.value))
            }
            //// .
            //if (key == 46) {
            //    if (field.value == "") return false
            //    regexp = /^[0-9]+$/
            //    return regexp.test(field.value)
            //}
            // other key
            return false

        }

        function DecCheck(e, field) {
            key = e.keyCode ? e.keyCode : e.which
            // backspace
            if (key == 8) return true
            // 0-9
            if (key > 47 && key < 58) {
                if (field.value == "") return true
                regexp = /.[0-9]{9}$/
                return !(regexp.test(field.value))
            }
            // .
            if (key == 46) {
                if (field.value == "") return false
                regexp = /^[0-9]+$/
                return regexp.test(field.value)
            }
            // other key
            return false

        }

        $(function () {
            var allFields = $([]).add(name).add(divEmpleado)

            $("#dialog-form").dialog({
                autoOpen: false,
                height: 250,
                width: 350,
                modal: true,
                buttons: {
                    "Guardar": function () {
                        
                        var id_saldo = document.getElementById('txtIdSaldo').value;
                        var id_empleado = document.getElementById('txtIdEmplado').value;
                        var dias = document.getElementById('txtDias').value;
                        var fecha = document.getElementById('<%=dtFechaIni.ClientID%>').value; 
                        var fecha_orig = document.getElementById('txtFecha').value

                        //alert(fecha + ' ' + fecha_orig);

                        if (fecha != null && fecha.length > 0 || fecha_orig.length > 0) {
                            
                            if (fecha_orig.length > 0)
                            {
                                fecha = fecha_orig;
                            }

                            var params = "{id_saldo:'" + id_saldo + "', id_empleado:'" + id_empleado + "', dias:'" + dias + "', fecha:'" + fecha + "'}";
                            $.ajax({
                                type: "POST",
                                url: "RepDetalleSaldoVacacionesImpresion.aspx/AgregaDias",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                async: true,
                                data: params,
                                success: function (data) {
                                    if (data.d != "") {

                                        var resultado = data.d;

                                        alert(resultado);
                                        location.reload();

                                        //$(function () {
                                        //    $("#dialog-form").dialog("close");
                                        //});
                                    }
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    alert(textStatus + ": " + XMLHttpRequest.responseText);
                                }
                            });
                        }
                        else {
                            alert("Debe seleccionar la Fecha de Inicio");
                        }

                    },
                    "Salir": function () {
                        $(this).dialog("close");

                        LimpiarControles();
                    }
                },
                close: function () {
                    LimpiarControles();
                }
            });
           
        });
        
        function LimpiarControles() {

            document.getElementById('txtIdSaldo').value = "0";
            document.getElementById('txtIdEmplado').value = "0";
            document.getElementById('divEmpleado').innerHTML = "";
            document.getElementById('txtDias').value = "0";
            document.getElementById('divFecha').innerHTML = "";
            document.getElementById('txtFecha').value = "";

            dateVar = new Date();
            var datepicker = $find("<%= dtFechaIni.ClientID%>");
            datepicker.set_selectedDate(dateVar);
        }
       
        function AbrirDialog(id_saldo, id_empleado, empleado, fecha_efectiva) {
            
            document.getElementById('txtIdSaldo').value = id_saldo;
            document.getElementById('txtIdEmplado').value = id_empleado;
            document.getElementById('divEmpleado').innerHTML = empleado;

            if (fecha_efectiva == "") {
                var datepicker = $find("<%= dtFechaIni.ClientID%>");                
                datepicker.set_visible(true);

                document.getElementById('divFecha').style.display = "none";
                document.getElementById('txtFecha').value = "";

            }
            else {
                document.getElementById('txtFecha').value = fecha_efectiva;

                var fecha = new Date(fecha_efectiva);
                var datepicker = $find("<%= dtFechaIni.ClientID%>");
                datepicker.set_selectedDate(fecha);
                datepicker.set_visible(false);

                document.getElementById('divFecha').style.display = "";
                document.getElementById('divFecha').innerHTML = fecha_efectiva;             
            }            
       

            $(function () {
                $("#dialog-form").dialog("open");
            });

            return false;
        }

</script>



    <form id="form1" runat="server">
        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

    <div id="dialog-form" title="Agregar Dias" class="divDialog">      
        <table border="0">
            <tr>
                <td style="border-bottom: 0px; border-left: 0px; border-top:0px; border-right: 0px;">
                    <label for="name">Empleado: </label>
                </td>
                <td style="border-bottom: 0px; border-left: 0px; border-top:0px; border-right: 0px;">
                    <div id="divEmpleado"></div>                                                         
                </td>
            </tr>
            <tr>
                <td style="border-bottom: 0px; border-left: 0px; border-top:0px; border-right: 0px;">
                    <label for="name">Dias: </label>
                </td>
                <td style="border-bottom: 0px; border-left: 0px; border-top:0px; border-right: 0px;">
                    <input type="text" name="name" id="txtDias" onkeypress="return isNumberKey(event);" onblur="validaNumero(this);"style="width: 60px;" />     
                    <input type="text" name="name" id="txtIdSaldo"  style="display:none;" />                                        
                    <input type="text" name="name" id="txtIdEmplado"   style="display:none;" />                                                                           
                    <input type="text" name="name" id="txtFecha"   style="display:none;" />   
                </td>
            </tr>
            <tr>
                <td style="border-bottom: 0px; border-left: 0px; border-top:0px; border-right: 0px;">
                    <label for="name">Fecha de Inicio: </label>
                </td>
                <td style="border-bottom: 0px; border-left: 0px; border-top:0px; border-right: 0px;">
                    <telerik:RadDatePicker ID="dtFechaIni" runat="server" Width="100px" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy"></telerik:RadDatePicker>
                    <div id="divFecha"></div>   
                </td>
            </tr>
        </table>
    </div>

        <div style="padding-left:10px; padding-right:10px;">
            <br />

            <table border="0" cellpadding="0" cellspacing="0">
                <tr class="filaTotales">
                    <td align="left" style='font-size:18px;padding-left:20px;'><%=TranslateLocale.text("Detalle de Saldo de Vacaciones")%></td>
                </tr>
                <tr>
                    <td align="left" style='font-size:15px;padding-left:50px;'><b><%=TranslateLocale.text("Filtros")%>:</b> <%=DefinicionParametros()%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvReporte" ExportFileName="SaldoVacaciones.xls" Text="Exportar a Excel" IncludeTimeStamp="true" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir sin Formato" OnClientClick="window.print();" />
                    </td>
                </tr>
                <tr>
                    <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="true" HeaderStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF">
                        <Columns>
                            <asp:BoundField HeaderText="Numero" DataField="numero" SortExpression="numero" />
                            <asp:BoundField HeaderText="Nombre" DataField="nombre" SortExpression="nombre" />
                            <asp:BoundField HeaderText="Alta" DataField="fecha_alta" SortExpression="fecha_alta" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField HeaderText="Fecha Mod." DataField="fecha_modificacion" SortExpression="fecha_modificacion" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField HeaderText="Empresa" DataField="empresa" SortExpression="empresa" />
                            <asp:BoundField HeaderText="Departamento" DataField="departamento" SortExpression="departamento" />
                            <asp:BoundField HeaderText="Fecha Saldo Inicial" DataField="fecha_saldo_inicial" SortExpression="fecha_saldo_inicial" ItemStyle-HorizontalAlign="Center" DataFormatString="{0:dd/MM/yyyy}"/>
                            <asp:BoundField HeaderText="Saldo Inicial" DataField="saldo_inicial" SortExpression="saldo_inicial" />
                            <asp:BoundField HeaderText="Vencidas" DataField="vencidas" SortExpression="vencidas" />
                            <asp:BoundField HeaderText="Asignadas" DataField="asignadas" SortExpression="asignadas" />
                            <asp:BoundField HeaderText="Disfrutadas" DataField="disfrutadas" SortExpression="disfrutadas" />
                            <asp:BoundField HeaderText="Proporcional" DataField="proporcional" SortExpression="proporcional" />
                            <asp:BoundField HeaderText="Saldo Actual" DataField="saldo_disponible" SortExpression="saldo_disponible" />
                            <asp:BoundField HeaderText="Dias en Proceso" DataField="dias_en_proceso" SortExpression="dias_en_proceso" ItemStyle-HorizontalAlign="Center"/>
                            <asp:BoundField HeaderText="Saldo Final" DataField="dias_final" SortExpression="dias_final" ItemStyle-HorizontalAlign="Center"/>


                            <asp:TemplateField HeaderText="Acciones">
                                <ItemTemplate>
                                    <div align="center">
                                        <asp:ImageButton ID="btnDias" runat="server" ImageUrl="/images/edit.png" ToolTip="Agregar Dias" OnClientClick='<%# "return AbrirDialog(" & Eval("id_saldo") & "," & Eval("id_empleado") & "," & Chr(34) & Eval("nombre") & Chr(34) & "," & Chr(34) & IIf(IsDBNull(Eval("fecha_efectiva")) = True, "", Eval("fecha_efectiva")) & Chr(34) & ");"%>'  />                                        
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>                        
                        </Columns>
                    </asp:GridView>

                </tr>
            </table>

            <br /><br /><br /><br />


        </div>        
    </form>
</body>
<script type="text/javascript">
    //window.print();
</script>
</html>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TelcelPivoteImpresion.aspx.vb" Inherits="Intranet.TelcelPivoteImpresion" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en-us">
<head>
  <title>Reporte de Gastos de Telefonía (Tabla Pivote)</title>
  <!-- Twitter Bootstrap -->
  <link rel="stylesheet" href="/pivot/lib/css/bootstrap.min.css" type="text/css" />
  <link rel="stylesheet" href="/pivot/lib/css/subnav.css" type="text/css" />
  <link rel="stylesheet" href="/pivot/lib/css/pivot.css" type="text/css" />

  <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>
  <script type="text/javascript" src="/pivot/lib/javascripts/subnav.js"></script>
  <script type="text/javascript" src="/pivot/lib/javascripts/accounting.min.js"></script>
  <script type="text/javascript" src="/pivot/lib/javascripts/jquery.dataTables.min.js"></script>
  <script type="text/javascript" src="/pivot/lib/javascripts/dataTables.bootstrap.js"></script>

<style>
    body {
        background-image:url(/images/page_bak.png);
    }
    .container {
        width:90%;
    }
</style>

  <!-- jquery_pivot must be loaded after pivot.js and jQuery -->
  <script type="text/javascript" src="/pivot/pivot.js"></script>
  <script type="text/javascript" src="/pivot/jquery_pivot.js"></script>
</head>
<body>
    <form id="form1" runat="server">
      <div class="container">
        <div class="subnav">
          <ul class="nav nav-pills">
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                Filtros
                <b class="caret"></b>
              </a>
              <ul class="dropdown-menu stop-propagation" style="overflow:auto;max-height:450px;padding:10px;">
                <div id="filter-list"></div>
              </ul>
            </li>
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                Datos para Filas
                <b class="caret"></b>
              </a>
              <ul class="dropdown-menu stop-propagation" style="overflow:auto;max-height:450px;padding:10px;">
                <div id="row-label-fields"></div>
              </ul>
            </li>
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                Datos para columnas
                <b class="caret"></b>
              </a>
              <ul class="dropdown-menu stop-propagation" style="overflow:auto;max-height:450px;padding:10px;">
                <div id="column-label-fields"></div>
              </ul>
            </li>
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                Datos para totales
                <b class="caret"></b>
              </a>
              <ul class="dropdown-menu stop-propagation" style="overflow:auto;max-height:450px;padding:10px;">
                <div id="summary-fields"></div>
              </ul>
            </li>
            <li class="dropdown pull-right">
              <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                Reportes Basicos
                <b class="caret"></b>
              </a>
              <ul class="dropdown-menu">
               <li><a id="rep-lineas-sin-asignar" href="#">Lineas sin Asignar</a></li>
               <li><a id="rep-cargos-por-linea" href="#">Cargos por Linea</a></li>
               <li><a id="rep-minutos-por-linea" href="#">Minutos por Linea Acumulado</a></li>
               <li><a id="rep-minutos-por-linea-por-mes" href="#">Minutos Totales por Linea</a></li>
               <li><a id="rep-cargos-por-empresa" href="#">Cargos por Empresa</a></li>
               <li><a id="rep-minutos-por-empresa" href="#">Minutos por Empresa Acumulado</a></li>
               <li><a id="rep-minutos-por-empresa-por-mes" href="#">Minutos Totales por Empresa</a></li>
                  
              </ul>
            </li>
          </ul>
        </div>

        <hr/>
        <span id="pivot-detail"></span>

        <hr/>
        <div id="results"><h2>Cargando datos...</h2></div>
      </div>
    </form>
</body>

<script type="text/javascript">

    var fields = [
        // filterable fields

        { name: 'Mes', type: 'string', filterable: true, columnLabelable: true },
        { name: 'Region', type: 'string', filterable: true },
        { name: 'Padre', type: 'string', filterable: true },
        { name: 'Cuenta', type: 'string', filterable: true },
        { name: 'Razon Social', type: 'string', filterable: true },
        { name: 'Empresa', type: 'string', filterable: true },
        { name: 'Empleado', type: 'string', filterable: true },
        { name: 'Telefono', type: 'string', filterable: true },
        { name: 'Fecha Fact', type: 'string', filterable: true },
        { name: 'Factura', type: 'string', filterable: true },
        { name: 'Plan', type: 'string', filterable: true },

        { name: 'Renta', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'Serv Ad', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'TA Importe', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'TA Min Libr Pico', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'TA Min Fact Pico', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'TA Min Libr No Pico', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'TA Min Fact No Pico', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'TA Min Tot', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LD Total', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDN Importe', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDN Min Libres', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDN Min Fact', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDN Min Tot', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDI Importe', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDI Min Libres', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDI Min Fact', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDI Min Tot', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDM Importe', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDM Min Libres', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDM Min Fact', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDM Min Tot', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'TARN Importe', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'TARN Min Libres', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'TARN Min Fact', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'TARN Min Tot', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDRN Importe', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDRN Min Libres', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDRN Min Fact', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDRN Min Tot', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'TARI Importe', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'TARI Min Libres', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'TARI Min Factur', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'TARI Min Tot', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDRI Importe', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDRI Min Libres', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDRI Min Fact', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'LDRI Min Tot', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'Importe SVA', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'Fianza', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'Descuento TAR', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'Renta Roaming', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'Impuestos', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'Cargos', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } },
        { name: 'Min Totales', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } }


    ]

    function setupPivot(input) {
        input.callbacks = {
            afterUpdateResults: function () {
                $('#results > table').dataTable({
                    "sDom": "<'row'<'span6'l><'span6'f>>t<'row'<'span6'i><'span6'p>>",
                    "iDisplayLength": -1,
                    "aLengthMenu": [[50, 100, 200, -1], [50, 100, 200, "Todos"]],
                    "sPaginationType": "bootstrap",
                    "oLanguage": {
                        "sLengthMenu": "_MENU_ registros por pagina"
                    },
                    "fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay ) {
                        var myTotals = new Array();
                        var myFormat = new Array();
                        for (var x = 1 ; x < 20; x++) {
                            myTotals[x] = 0;
                            myFormat[x] = 0;
                            for ( var i=0 ; i<aaData.length ; i++ )
                            {
                                if (aaData[i][x] != undefined) {
                                    if (aaData[i][x].indexOf('$') >= 0) { myFormat[x] = 1; }
                                    var monto = replaceAll(replaceAll(aaData[i][x], '$', ''), ',', '');
                                    if (!isNaN(monto)) {
                                        myTotals[x] += parseFloat(monto);
                                    }						
                                }
                            }				
                        }
	

                        var nCells = nRow.getElementsByTagName('td');
                        for ( var x=1 ; x<20; x++){
                            if(myTotals[x]>0){
                                if (nCells[x] != undefined) {
                                    if (myTotals[x] < 599999999) {
                                        if (myFormat[x] == 1) { nCells[x].innerHTML = accounting.formatNumber(myTotals[x]); }
                                        else { nCells[x].innerHTML = accounting.formatNumber(myTotals[x]); }
                                    }
                                }					
                            }
                        }
                    }
                });
            }
        };
        $('#pivot-demo').pivot_display('setup', input);
    };

    function replaceAll(text, busca, reemplaza) {
        while (text.toString().indexOf(busca) != -1)
        text = text.toString().replace(busca, reemplaza);
        return text;
    }


    function inicializaPivote() {
        setupPivot({ bTotals: true, url: '/TelcelPivote_csv.aspx?a=<%=Request.QueryString("a")%>', fields: fields, rowLabels: ["Empresa"], columnLabels: ["Mes"], summaries: ["Cargos"] });

        $('.stop-propagation').click(function (event) {
            event.stopPropagation();
        });


        $('#rep-lineas-sin-asignar').click(function (event) {
            $('#pivot-demo').pivot_display('reprocess_display', { rowLabels: ["Empresa", "Empleado", "Telefono"], columnLabels: ["Mes"], summaries: ["Cargos"], filters: { "Empleado": "(Sin asignar)" } })
        });

        $('#rep-cargos-por-linea').click(function (event) {
            $('#pivot-demo').pivot_display('reprocess_display', { rowLabels: ["Empresa", "Empleado", "Telefono"], columnLabels: ["Mes"], summaries: ["Cargos"] })
        });

        $('#rep-minutos-por-linea').click(function (event) {
            $('#pivot-demo').pivot_display('reprocess_display', { rowLabels: ["Empresa", "Empleado", "Telefono"], summaries: ["TA Min Tot", "LDN Min Tot", "LDI Min Tot", "LDM Min Tot", "TARN Min Tot", "LDRN Min Tot", "TARI Min Tot", "LDRI Min Tot"] })
        });

        $('#rep-minutos-por-linea-por-mes').click(function (event) {
            $('#pivot-demo').pivot_display('reprocess_display', { rowLabels: ["Empresa", "Empleado", "Telefono"], columnLabels: ["Mes"], summaries: ["Min Totales"] })
        });

        $('#rep-cargos-por-empresa').click(function (event) {
            $('#pivot-demo').pivot_display('reprocess_display', { rowLabels: ["Empresa", "Razon Social"], columnLabels: ["Mes"], summaries: ["Cargos"] })
        });
        

        $('#rep-minutos-por-empresa').click(function (event) {
            $('#pivot-demo').pivot_display('reprocess_display', { rowLabels: ["Empresa"], summaries: ["TA Min Tot", "LDN Min Tot", "LDI Min Tot", "LDM Min Tot", "TARN Min Tot", "LDRN Min Tot", "TARI Min Tot", "LDRI Min Tot"] })
        });

        $('#rep-minutos-por-empresa-por-mes').click(function (event) {
            $('#pivot-demo').pivot_display('reprocess_display', { rowLabels: ["Empresa"], columnLabels: ["Mes"], summaries: ["Min Totales"] })
        });
    }

    $(document).ready(function () {
        setTimeout(function () { inicializaPivote() }, 500);
    });
</script>

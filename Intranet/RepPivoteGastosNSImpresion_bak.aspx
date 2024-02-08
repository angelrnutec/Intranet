<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepPivoteGastosNSImpresion_bak.aspx.vb" Inherits="Intranet.RepPivoteGastosNSImpresion_bak" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en-us">
<head>
  <title>Reporte de Gastos NS (Tabla Pivote)</title>
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
               <li><a id="rep-detalle-mes" href="#">Detalle Gastos por Mes</a></li>
               <li><a id="rep-categorias-mes" href="#">Categorias por Mes</a></li>
               <li><a id="rep-centro-costo" href="#">Centro de Costo por Mes</a></li>
              </ul>
            </li>
          </ul>
        </div>

        <hr/>
         <b>Moneda: </b><%=Request.QueryString("mon")%>,
        <span id="pivot-detail"></span>

        <hr/>
        <div id="results"><h2>Cargando datos...</h2></div>
      </div>
    </form>
</body>

<script type="text/javascript">

    var fields = [
        // filterable fields
        { name: 'Empresa', type: 'string', filterable: true },
        { name: 'Categoria', type: 'string', filterable: true },
        { name: 'Mes', type: 'string', filterable: true, columnLabelable: true },
        { name: 'Fecha', type: 'string', filterable: true },
        { name: 'Clasificacion', type: 'string', filterable: true },
        { name: 'Centro de Costo', type: 'string', filterable: true },
        { name: 'Tipo de Costo', type: 'string', filterable: true },
        { name: 'Cuenta', type: 'string', filterable: true },
        { name: 'Denom Cuenta', type: 'string', filterable: true },
        { name: 'Num Documento', type: 'string', filterable: true },
        { name: 'Texto Cabecera', type: 'string', filterable: true },
        { name: 'Denominacion', type: 'string', filterable: true },

        // psuedo fields
/*        {
            name: 'invoice_mm', type: 'string', filterable: true, pseudo: true,
            pseudoFunction: function (row) {
                var date = new Date(row.invoice_date);
                return pivot.utils().padLeft((date.getMonth() + 1), 2, '0')
            }
        },
        {
            name: 'invoice_yyyy_mm', type: 'string', filterable: true, pseudo: true,
            pseudoFunction: function (row) {
                var date = new Date(row.invoice_date);
                return date.getFullYear() + '_' + pivot.utils().padLeft((date.getMonth() + 1), 2, '0')
            }
        },
        {
            name: 'invoice_yyyy', type: 'string', filterable: true, pseudo: true, columnLabelable: true,
            pseudoFunction: function (row) { return new Date(row.invoice_date).getFullYear() }
        },
        { name: 'age_bucket', type: 'string', filterable: true, columnLabelable: true, pseudo: true, dataSource: 'last_payment_date', pseudoFunction: ageBucket },
        */

        // summary fields


        { name: 'Total', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } }
        /*
        {
            name: 'balance', type: 'float', rowLabelable: false, pseudo: true,
            pseudoFunction: function (row) { return row.billed_amount - row.payment_amount },
            summarizable: 'sum', displayFunction: function (value) { return accounting.formatMoney(value) }
        },
        { name: 'last_payment_date', type: 'date', filterable: true }*/
    ]

    function setupPivot(input) {
        input.callbacks = {
            afterUpdateResults: function () {
                $('#results > table').dataTable({
                    "sDom": "<'row'<'span6'l><'span6'f>>t<'row'<'span6'i><'span6'p>>",
                    "iDisplayLength": 100,
                    "aLengthMenu": [[25, 50, 100, -1], [25, 50, 100, "Todos"]],
                    "sPaginationType": "bootstrap",
                    "oLanguage": {
                        "sLengthMenu": "_MENU_ registros por pagina"
                    },
                    "fnFooterCallback": function ( nRow, aaData, iStart, iEnd, aiDisplay ) {
                        var myTotals = new Array();
                        for ( var x=1 ; x<20; x++){
                            myTotals[x] = 0;
                            for ( var i=0 ; i<aaData.length ; i++ )
                            {
                                if(aaData[i][x] != undefined){
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
                                if(nCells[x] != undefined){
                                    nCells[x].innerHTML = accounting.formatNumber(myTotals[x]);
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
        //setupPivot({ url: 'http://localhost:1059/RepPivoteGastosNS_csv.aspx?e=<%=Request.QueryString("e")%>&a=<%=Request.QueryString("a")%>', fields: fields, filters: { employer: 'Acme Corp' }, rowLabels: ["city"], summaries: ["billed_amount", "payment_amount"] })
        setupPivot({ bTotals: true, url: '/RepPivoteGastosNS_csv.aspx?e=<%=Request.QueryString("e")%>&a=<%=Request.QueryString("a")%>&mon=<%=Request.QueryString("mon")%>', fields: fields, rowLabels: ["Categoria"], columnLabels: ["Mes"], summaries: ["Total"] });
        //setupPivot({ bTotals: true, url: '/RepPivoteGastosNS_csv.aspx?e=<%=Request.QueryString("e")%>&a=<%=Request.QueryString("a")%>', fields: fields, rowLabels: ["Categoria"], summaries: ["Total"] });

        $('.stop-propagation').click(function (event) {
            event.stopPropagation();
        });

        
        $('#rep-detalle-mes').click(function (event) {
            $('#pivot-demo').pivot_display('reprocess_display', { rowLabels: ["Centro de Costo", "Categoria", "Denom Cuenta", "Texto Cabecera", "Denominacion"], columnLabels: ["Mes"], summaries: ["Total"] })
        });

        $('#rep-categorias-mes').click(function (event) {
            $('#pivot-demo').pivot_display('reprocess_display', { rowLabels: ["Categoria"], columnLabels: ["Mes"], summaries: ["Total"] })
        });

        $('#rep-centro-costo').click(function (event) {
            $('#pivot-demo').pivot_display('reprocess_display', { rowLabels: ["Centro de Costo"], columnLabels: ["Mes"], summaries: ["Total"] })
        });
    }

    $(document).ready(function () {
        setTimeout(function () { inicializaPivote() }, 500);
    });
</script>

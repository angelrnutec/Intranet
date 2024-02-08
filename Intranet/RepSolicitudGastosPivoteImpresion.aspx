<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepSolicitudGastosPivoteImpresion.aspx.vb" Inherits="Intranet.RepSolicitudGastosPivoteImpresion" %>
<%@ Import Namespace="Intranet.LocalizationIntranet" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en-us">
<head>
  <title><%=TranslateLocale.text("Reporte de Solicitud de Gastos (Pivote)")%></title>
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
    <%
        If TranslateLocale.isEnglish() Then
        %>
  <script type="text/javascript" src="/pivot/jquery_pivot.en.js"></script>
    <%
        Else
        %>
  <script type="text/javascript" src="/pivot/jquery_pivot.js"></script>
    <%
        End If
        %>
</head>
<body>
    <form id="form1" runat="server">
      <div class="container">
        <div class="subnav">
          <ul class="nav nav-pills">
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                Filters
                <b class="caret"></b>
              </a>
              <ul class="dropdown-menu stop-propagation" style="overflow:auto;max-height:450px;padding:10px;">
                <div id="filter-list"></div>
              </ul>
            </li>
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                <%=TranslateLocale.text("Datos para filas")%>
                <b class="caret"></b>
              </a>
              <ul class="dropdown-menu stop-propagation" style="overflow:auto;max-height:450px;padding:10px;">
                <div id="row-label-fields"></div>
              </ul>
            </li>
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                <%=TranslateLocale.text("Datos para columnas")%>                
                <b class="caret"></b>
              </a>
              <ul class="dropdown-menu stop-propagation" style="overflow:auto;max-height:450px;padding:10px;">
                <div id="column-label-fields"></div>
              </ul>
            </li>
            <li class="dropdown">
              <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                <%=TranslateLocale.text("Datos para totales")%>                                
                <b class="caret"></b>
              </a>
              <ul class="dropdown-menu stop-propagation" style="overflow:auto;max-height:450px;padding:10px;">
                <div id="summary-fields"></div>
              </ul>
            </li>
            <li class="dropdown pull-right">
              <a class="dropdown-toggle" data-toggle="dropdown" href="#">
                <%=TranslateLocale.text("Reportes Basicos")%>                                                
                <b class="caret"></b>
              </a>
              <ul class="dropdown-menu">
               <%--<li><a id="rep-totales-por-concepto" href="#">Totales por concepto</a></li>--%>
               <li><a id="rep-gastos-ns" href="#"><%=TranslateLocale.text("Gastos NS")%></a></li>
               <li><a id="rep-gastos-nb" href="#"><%=TranslateLocale.text("Gastos NB")%></a></li>
               <li><a id="rep-gastos-nf" href="#"><%=TranslateLocale.text("Gastos NF")%></a></li>
               <li><a id="rep-gastos-empleado" href="#"><%=TranslateLocale.text("Totales por empleado")%></a></li>
                  
              </ul>
            </li>
          </ul>
        </div>

        <hr/>
        <span id="pivot-detail"></span>

        <hr/>
        <div id="results"><h2><%=TranslateLocale.text("Cargando datos")%>...</h2></div>
      </div>
    </form>
</body>

<script type="text/javascript">

    var fields = [
        // filterable fields

        { name: '<%=TranslateLocale.text("Mes")%>', type: 'string', filterable: true, columnLabelable: true },
        { name: '<%=TranslateLocale.text("Empresa")%>', type: 'string', filterable: true },
        { name: '<%=TranslateLocale.text("Tipo")%>', type: 'string', filterable: true },
        { name: '<%=TranslateLocale.text("Folio")%>', type: 'string', filterable: true },
        { name: '<%=TranslateLocale.text("Nombre")%>', type: 'string', filterable: true },
        { name: '<%=TranslateLocale.text("Fecha Solicitud")%>', type: 'string', filterable: true },
        { name: '<%=TranslateLocale.text("Concepto")%>', type: 'string', filterable: true },
        { name: '<%=TranslateLocale.text("Forma Pago")%>', type: 'string', filterable: true },
        { name: '<%=TranslateLocale.text("Orden Interna")%>', type: 'string', filterable: true },
        { name: '<%=TranslateLocale.text("Necesidad")%>', type: 'string', filterable: true },
        { name: '<%=TranslateLocale.text("Centro Costo")%>', type: 'string', filterable: true },
        { name: '<%=TranslateLocale.text("Cuenta Contable")%>', type: 'string', filterable: true },
        { name: '<%=TranslateLocale.text("Clave IVA")%>', type: 'string', filterable: true },
        { name: '<%=TranslateLocale.text("Tipo Monto")%>', type: 'string', filterable: true },

        { name: '<%=TranslateLocale.text("Total Pesos")%>', type: 'float', rowLabelable: false, summarizable: 'sum', displayFunction: function (value) { return accounting.formatNumber(value) } }



    ]

    function setupPivot(input) {
        input.callbacks = {
            afterUpdateResults: function () {
                $('#results > table').dataTable({
                    "sDom": "<'row'<'span6'l><'span6'f>>t<'row'<'span6'i><'span6'p>>",
                    "iDisplayLength": -1,
                    "aLengthMenu": [[50, 100, 200, -1], [50, 100, 200, "<%=TranslateLocale.text("Todos")%>"]],
                    "sPaginationType": "bootstrap",
                    "oLanguage": {
                        "sLengthMenu": "_MENU_ <%=TranslateLocale.text("registros por pagina")%>",
                        "sSearch": "<%=TranslateLocale.text("Buscar")%>",
                        "sInfo": "<%=TranslateLocale.text("Mostrando _START_ al _END_ de _TOTAL_")%>",
                        "oPaginate": {
                            "sFirst": "<%=TranslateLocale.text("Primero")%>",
                            "sPrevious": "<%=TranslateLocale.text("Anterior")%>",
                            "sNext": "<%=TranslateLocale.text("Siguiente")%>",
                            "sLast": "<%=TranslateLocale.text("Ultimo")%>",
                            "sInfoEmpty": "<%=TranslateLocale.text("No se encontraron registros")%>",
                            "sZeroRecords": "<%=TranslateLocale.text("No se encontraron registros")%>"
            }
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
        setupPivot({ bTotals: true, url: '/RepSolicitudGastos_csv.aspx?a=<%=Request.QueryString("a")%>&m=<%=Request.QueryString("m")%>&t=<%=Request.QueryString("tipo")%>', fields: fields, rowLabels: ["<%=TranslateLocale.text("Nombre")%>", "<%=TranslateLocale.text("Empresa")%>"], columnLabels: ["<%=TranslateLocale.text("Mes")%>"], summaries: ["<%=TranslateLocale.text("Total Pesos")%>"] });

        $('.stop-propagation').click(function (event) {
            event.stopPropagation();
        });

        $('#rep-totales-por-concepto').click(function (event) {
            $('#pivot-demo').pivot_display('reprocess_display', { rowLabels: ["<%=TranslateLocale.text("Concepto")%>"], columnLabels: ["<%=TranslateLocale.text("Mes")%>"], summaries: ["<%=TranslateLocale.text("Total Pesos")%>"] })
        });

        $('#rep-gastos-ns').click(function (event) {
            $('#pivot-demo').pivot_display('reprocess_display', { rowLabels: ["<%=TranslateLocale.text("Empresa")%>", "<%=TranslateLocale.text("Concepto")%>"], columnLabels: ["<%=TranslateLocale.text("Mes")%>"], summaries: ["<%=TranslateLocale.text("Total Pesos")%>"], filters: { "<%=TranslateLocale.text("Empresa")%>": "NS" } })
        });

        $('#rep-gastos-nb').click(function (event) {
            $('#pivot-demo').pivot_display('reprocess_display', { rowLabels: ["<%=TranslateLocale.text("Empresa")%>", "<%=TranslateLocale.text("Concepto")%>"], columnLabels: ["<%=TranslateLocale.text("Mes")%>"], summaries: ["<%=TranslateLocale.text("Total Pesos")%>"], filters: { "<%=TranslateLocale.text("Empresa")%>": "NB" } })
        });

        $('#rep-gastos-nf').click(function (event) {
            $('#pivot-demo').pivot_display('reprocess_display', { rowLabels: ["<%=TranslateLocale.text("Empresa")%>", "<%=TranslateLocale.text("Concepto")%>"], columnLabels: ["<%=TranslateLocale.text("Mes")%>"], summaries: ["<%=TranslateLocale.text("Total Pesos")%>"], filters: { "<%=TranslateLocale.text("Empresa")%>": "NF" } })
        });

        $('#rep-gastos-empleado').click(function (event) {
            $('#pivot-demo').pivot_display('reprocess_display', { rowLabels: ["<%=TranslateLocale.text("Nombre")%>", "<%=TranslateLocale.text("Empresa")%>"], columnLabels: ["<%=TranslateLocale.text("Mes")%>"], summaries: ["<%=TranslateLocale.text("Total Pesos")%>"] })
        });
        
    }

    $(document).ready(function () {
        setTimeout(function () { inicializaPivote() }, 500);
    });
</script>

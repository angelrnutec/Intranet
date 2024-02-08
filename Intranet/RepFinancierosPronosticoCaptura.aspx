<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="RepFinancierosPronosticoCaptura.aspx.vb" Inherits="Intranet.RepFinancierosPronosticoCaptura" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .textoMontos {
            width:60px;
        }
    </style>

    <script type="text/javascript">
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


        function RecalculaTotales(control) {
            var combo = document.getElementById('<%=ddlReporte.ClientID%>');
            var id_reporte = combo.options[combo.selectedIndex].value;
            if (id_reporte == 2) {
                RecalculaTotales_EstadoResultados(control);
            } else if (id_reporte == 2999 || id_reporte == 32) {
                RecalculaTotales_EstadoResultadosIndividual(control);
            } else if (id_reporte == 6) {
                RecalculaTotales_PedidosFacturacion(control);
            } else if (id_reporte == 1017) {
                RecalculaTotales_PedidosFacturacionExpandido(control);
            }
        }


        function RecalculaTotales_EstadoResultados(control) {
            if (!isNumber(control.value)) { control.value = "0"; }

            var grid = document.getElementById("<%= gvCapturaER.ClientID%>");

            var totales = new Array(5, 9, 12, 14, 18, 20, 23, 25);
            var elementos_suman1 = new Array(0, 1);
            var elementos_restan1 = new Array(2, 3, 4);
            var elementos_suman2 = new Array(6, 7, 8);
            var elementos_restan2 = new Array(0);
            var elementos_suman3 = new Array(0, 1);
            var elementos_restan3 = new Array(2, 3, 4, 6, 7, 8, 10, 11);
            var elementos_suman4 = new Array(0, 1);
            var elementos_restan4 = new Array(2, 3, 4, 6, 7, 8, 10, 11, 13);
            var elementos_suman5 = new Array(1, 12, 15, 16, 17);
            var elementos_restan5 = new Array(2, 3, 4, 6, 7, 8, 10, 11, 13);
            var elementos_suman6 = new Array(1, 12, 15, 16, 17);
            var elementos_restan6 = new Array(2, 3, 4, 6, 7, 8, 10, 11, 13, 19);
            var elementos_suman7 = new Array(1, 12, 15, 16, 17);
            var elementos_restan7 = new Array(2, 3, 4, 6, 7, 8, 10, 11, 13, 19, 21, 22);
            var elementos_suman8 = new Array(0, 1, 24);
            var elementos_restan8 = new Array(2, 3, 3, 6, 7, 8, 10, 11, 13);


            if (grid.rows.length > 0) {
                for (columna = 1; columna <= 11; columna++) {
                    var str = "" + columna
                    var pad = "00"
                    var columna_txt = pad.substring(0, pad.length - str.length) + str

                    var monto_calculado = 0;
                    var totalesacalcular = 0;
                    var monto_calculado1 = 0;
                    var monto_calculado2 = 0;
                    var monto_calculado3 = 0;
                    var monto_calculado4 = 0;
                    var monto_calculado5 = 0;
                    var monto_calculado6 = 0;
                    var monto_calculado7 = 0;
                    var monto_calculado8 = 0;
                    for (iFila = 1; iFila < grid.rows.length; iFila++) {

                        var valor_total_columna = 0;
                        var valor_total_columna_fibras = 0;
                        var valor_total_columna_hornos = 0;
                        var elementos = grid.rows[iFila].getElementsByTagName('input');
                        for (var j = 0; j < elementos.length; j++) {
                            //if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte01") >= 0) { valor_total_columna += parseInt(elementos[j].value); }
                            //if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte02") >= 0) { valor_total_columna += parseInt(elementos[j].value); }

                            if (elementos[j].type == 'text'
                                && (elementos[j].id.indexOf("txtImporte03") >= 0
                                    || elementos[j].id.indexOf("txtImporte04") >= 0
                                    || elementos[j].id.indexOf("txtImporte05") >= 0
                                    || elementos[j].id.indexOf("txtImporte06") >= 0
                                    || elementos[j].id.indexOf("txtImporte07") >= 0
                                    || elementos[j].id.indexOf("txtImporte10") >= 0
                                    || elementos[j].id.indexOf("txtImporte11") >= 0)) {
                                valor_total_columna += parseInt(elementos[j].value);
                                valor_total_columna_fibras += parseInt(elementos[j].value);
                            }
                            if (elementos[j].type == 'text'
                                && (elementos[j].id.indexOf("txtImporte08") >= 0
                                    || elementos[j].id.indexOf("txtImporte09") >= 0)) {
                                valor_total_columna += parseInt(elementos[j].value);
                                valor_total_columna_hornos += parseInt(elementos[j].value);
                            }


                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte" + columna_txt) >= 0) {
                                var valor = elementos[j].value;
                                if (existe(elementos_suman1, iFila)) {
                                    monto_calculado1 += parseInt(valor);
                                }
                                if (existe(elementos_restan1, iFila)) {
                                    monto_calculado1 -= parseInt(valor);
                                }
                                if (existe(elementos_suman2, iFila)) {
                                    monto_calculado2 += parseInt(valor);
                                }
                                if (existe(elementos_restan2, iFila)) {
                                    monto_calculado2 -= parseInt(valor);
                                }
                                if (existe(elementos_suman3, iFila)) {
                                    monto_calculado3 += parseInt(valor);
                                }
                                if (existe(elementos_restan3, iFila)) {
                                    monto_calculado3 -= parseInt(valor);
                                }
                                if (existe(elementos_suman4, iFila)) {
                                    monto_calculado4 += parseInt(valor);
                                }
                                if (existe(elementos_restan4, iFila)) {
                                    monto_calculado4 -= parseInt(valor);
                                }
                                if (existe(elementos_suman5, iFila)) {
                                    monto_calculado5 += parseInt(valor);
                                }
                                if (existe(elementos_restan5, iFila)) {
                                    monto_calculado5 -= parseInt(valor);
                                }
                                if (existe(elementos_suman6, iFila)) {
                                    monto_calculado6 += parseInt(valor);
                                }
                                if (existe(elementos_restan6, iFila)) {
                                    monto_calculado6 -= parseInt(valor);
                                }
                                if (existe(elementos_suman7, iFila)) {
                                    monto_calculado7 += parseInt(valor);
                                }
                                if (existe(elementos_restan7, iFila)) {
                                    monto_calculado7 -= parseInt(valor);
                                }
                                if (existe(elementos_suman8, iFila)) {
                                    monto_calculado8 += parseInt(valor);
                                }
                                if (existe(elementos_restan8, iFila)) {
                                    monto_calculado8 -= parseInt(valor);
                                }



                                //if (j == 3 || j == 4 || j == 5 || j == 6 || j == 7 || j == 10) {
                                //    valor_total_columna_fibras += parseInt(valor);
                                //}
                                //if (j == 8 || j == 9) {
                                //    valor_total_columna_hornos += parseInt(valor);
                                //}
                            }
                        }


                        //console.log('- - - - - - - - - - - - - -');
                        //console.log('iFila: ' + iFila);
                        //console.log('valor_total_columna_fibras: ' + valor_total_columna_fibras);
                        //console.log('valor_total_columna_hornos: ' + valor_total_columna_hornos);


                        if (totales[totalesacalcular] == iFila) {
                            var divs = grid.rows[iFila].getElementsByTagName('div')
                            for (var kDiv = 0; kDiv < divs.length; kDiv++) {
                                if (divs[kDiv].id.indexOf("divImporte" + columna_txt) >= 0) {
                                    if (totalesacalcular == 0)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado1 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado1 + "&nbsp;</span>";
                                    else if (totalesacalcular == 1)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado2 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado2 + "&nbsp;</span>";
                                    else if (totalesacalcular == 2)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado3 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado3 + "&nbsp;</span>";
                                    else if (totalesacalcular == 3)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado4 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado4 + "&nbsp;</span>";
                                    else if (totalesacalcular == 4)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado5 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado5 + "&nbsp;</span>";
                                    else if (totalesacalcular == 5)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado6 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado6 + "&nbsp;</span>";
                                    else if (totalesacalcular == 6)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado7 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado7 + "&nbsp;</span>";
                                    else if (totalesacalcular == 7)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado8 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado8 + "&nbsp;</span>";
                                }
                            }
                            monto_calculado = 0;
                            totalesacalcular += 1;
                        }




                        var txtImporte01 = grid.rows[iFila].getElementsByClassName('total_fibras');
                        if (txtImporte01.length > 0) {
                            txtImporte01[0].value = valor_total_columna_fibras;
                        }

                        var txtImporte02 = grid.rows[iFila].getElementsByClassName('total_hornos');
                        if (txtImporte02.length > 0) {
                            txtImporte02[0].value = valor_total_columna_hornos;
                        }


                        var divsTot = grid.rows[iFila].getElementsByTagName('div')
                        for (var kDivTot = 0; kDivTot < divsTot.length; kDivTot++) {
                            if (divsTot[kDivTot].id.indexOf("divImporteTotal") >= 0) {
                                divsTot[kDivTot].innerHTML = "<span " + (valor_total_columna < 0 ? "style='color:red;'" : "") + ">" + valor_total_columna + "&nbsp;</span>";
                            }
                        }
                    }



                    for (iFila = 1; iFila < grid.rows.length; iFila++) {
                        var divsTots = grid.rows[iFila].getElementsByTagName('div');
                        var valor_total_totales = 0;
                        var hayValores = false;

                        //if (iFila == 4 || iFila == 8 || iFila == 10 || iFila == 14 || iFila == 16 || iFila == 19 || iFila == 21) {

                        //5, 9, 12, 14, 18, 20, 23, 25
                        if (iFila == 5 || iFila == 9 || iFila == 12 || iFila == 14 || iFila == 18 || iFila == 20 || iFila == 23 || iFila == 25) {
                            for (var j = 0; j < divsTots.length; j++) {



                                var valor_sin_formato = divsTots[j].innerHTML.replace('<span style="color:red;">', '').replace('<span>', '').replace('&nbsp;</span>', '');
                                if (divsTots[j].id.indexOf("divImporte01") >= 0) { valor_total_totales += parseInt(valor_sin_formato); hayValores = true; }
                                if (divsTots[j].id.indexOf("divImporte02") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }

                                if (divsTots[j].id.indexOf("divImporteTotal") >= 0 && hayValores) {
                                    divsTots[j].innerHTML = "<span " + (valor_total_totales < 0 ? "style='color:red;'" : "") + ">" + valor_total_totales + "&nbsp;</span>";
                                }
                            }
                        }


                    }
                }





                for (columna = 1; columna <= 11; columna++) {
                    var str = "" + columna
                    var pad = "00"
                    var columna_txt = pad.substring(0, pad.length - str.length) + str

                    var monto_calculado = 0;
                    var totalesacalcular = 0;
                    var monto_calculado1 = 0;
                    var monto_calculado2 = 0;
                    var monto_calculado3 = 0;
                    var monto_calculado4 = 0;
                    var monto_calculado5 = 0;
                    var monto_calculado6 = 0;
                    var monto_calculado7 = 0;
                    var monto_calculado8 = 0;
                    for (iFila = 1; iFila < grid.rows.length; iFila++) {

                        var valor_total_columna = 0;
                        var valor_total_columna_fibras = 0;
                        var valor_total_columna_hornos = 0;
                        var elementos = grid.rows[iFila].getElementsByTagName('input');
                        for (var j = 0; j < elementos.length; j++) {
                            //if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte01") >= 0) { valor_total_columna += parseInt(elementos[j].value); }
                            //if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte02") >= 0) { valor_total_columna += parseInt(elementos[j].value); }

                            if (elementos[j].type == 'text'
                                && (elementos[j].id.indexOf("txtImporte03") >= 0
                                    || elementos[j].id.indexOf("txtImporte04") >= 0
                                    || elementos[j].id.indexOf("txtImporte05") >= 0
                                    || elementos[j].id.indexOf("txtImporte06") >= 0
                                    || elementos[j].id.indexOf("txtImporte07") >= 0
                                    || elementos[j].id.indexOf("txtImporte10") >= 0
                                    || elementos[j].id.indexOf("txtImporte11") >= 0)) {
                                valor_total_columna += parseInt(elementos[j].value);
                                valor_total_columna_fibras += parseInt(elementos[j].value);
                            }
                            if (elementos[j].type == 'text'
                                && (elementos[j].id.indexOf("txtImporte08") >= 0
                                    || elementos[j].id.indexOf("txtImporte09") >= 0)) {
                                valor_total_columna += parseInt(elementos[j].value);
                                valor_total_columna_hornos += parseInt(elementos[j].value);
                            }


                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte" + columna_txt) >= 0) {
                                var valor = elementos[j].value;
                                if (existe(elementos_suman1, iFila)) {
                                    monto_calculado1 += parseInt(valor);
                                }
                                if (existe(elementos_restan1, iFila)) {
                                    monto_calculado1 -= parseInt(valor);
                                }
                                if (existe(elementos_suman2, iFila)) {
                                    monto_calculado2 += parseInt(valor);
                                }
                                if (existe(elementos_restan2, iFila)) {
                                    monto_calculado2 -= parseInt(valor);
                                }
                                if (existe(elementos_suman3, iFila)) {
                                    monto_calculado3 += parseInt(valor);
                                }
                                if (existe(elementos_restan3, iFila)) {
                                    monto_calculado3 -= parseInt(valor);
                                }
                                if (existe(elementos_suman4, iFila)) {
                                    monto_calculado4 += parseInt(valor);
                                }
                                if (existe(elementos_restan4, iFila)) {
                                    monto_calculado4 -= parseInt(valor);
                                }
                                if (existe(elementos_suman5, iFila)) {
                                    monto_calculado5 += parseInt(valor);
                                }
                                if (existe(elementos_restan5, iFila)) {
                                    monto_calculado5 -= parseInt(valor);
                                }
                                if (existe(elementos_suman6, iFila)) {
                                    monto_calculado6 += parseInt(valor);
                                }
                                if (existe(elementos_restan6, iFila)) {
                                    monto_calculado6 -= parseInt(valor);
                                }
                                if (existe(elementos_suman7, iFila)) {
                                    monto_calculado7 += parseInt(valor);
                                }
                                if (existe(elementos_restan7, iFila)) {
                                    monto_calculado7 -= parseInt(valor);
                                }
                                if (existe(elementos_suman8, iFila)) {
                                    monto_calculado8 += parseInt(valor);
                                }
                                if (existe(elementos_restan8, iFila)) {
                                    monto_calculado8 -= parseInt(valor);
                                }



                                //if (j == 3 || j == 4 || j == 5 || j == 6 || j == 7 || j == 10) {
                                //    valor_total_columna_fibras += parseInt(valor);
                                //}
                                //if (j == 8 || j == 9) {
                                //    valor_total_columna_hornos += parseInt(valor);
                                //}
                            }
                        }


                        //console.log('- - - - - - - - - - - - - -');
                        //console.log('iFila: ' + iFila);
                        //console.log('valor_total_columna_fibras: ' + valor_total_columna_fibras);
                        //console.log('valor_total_columna_hornos: ' + valor_total_columna_hornos);


                        if (totales[totalesacalcular] == iFila) {
                            var divs = grid.rows[iFila].getElementsByTagName('div')
                            for (var kDiv = 0; kDiv < divs.length; kDiv++) {
                                if (divs[kDiv].id.indexOf("divImporte" + columna_txt) >= 0) {
                                    if (totalesacalcular == 0)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado1 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado1 + "&nbsp;</span>";
                                    else if (totalesacalcular == 1)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado2 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado2 + "&nbsp;</span>";
                                    else if (totalesacalcular == 2)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado3 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado3 + "&nbsp;</span>";
                                    else if (totalesacalcular == 3)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado4 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado4 + "&nbsp;</span>";
                                    else if (totalesacalcular == 4)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado5 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado5 + "&nbsp;</span>";
                                    else if (totalesacalcular == 5)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado6 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado6 + "&nbsp;</span>";
                                    else if (totalesacalcular == 6)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado7 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado7 + "&nbsp;</span>";
                                    else if (totalesacalcular == 7)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado8 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado8 + "&nbsp;</span>";
                                }
                            }
                            monto_calculado = 0;
                            totalesacalcular += 1;
                        }




                        var txtImporte01 = grid.rows[iFila].getElementsByClassName('total_fibras');
                        if (txtImporte01.length > 0) {
                            txtImporte01[0].value = valor_total_columna_fibras;
                        }
                        var txtImporte02 = grid.rows[iFila].getElementsByClassName('total_hornos');
                        if (txtImporte02.length > 0) {
                            txtImporte02[0].value = valor_total_columna_hornos;
                        }


                        var divsTot = grid.rows[iFila].getElementsByTagName('div')
                        for (var kDivTot = 0; kDivTot < divsTot.length; kDivTot++) {
                            if (divsTot[kDivTot].id.indexOf("divImporteTotal") >= 0) {
                                divsTot[kDivTot].innerHTML = "<span " + (valor_total_columna < 0 ? "style='color:red;'" : "") + ">" + valor_total_columna + "&nbsp;</span>";
                            }
                        }
                    }



                    for (iFila = 1; iFila < grid.rows.length; iFila++) {
                        var divsTots = grid.rows[iFila].getElementsByTagName('div');
                        var valor_total_totales = 0;
                        var hayValores = false;

                        //if (iFila == 4 || iFila == 8 || iFila == 10 || iFila == 14 || iFila == 16 || iFila == 19 || iFila == 21) {

                        //5, 9, 12, 14, 18, 20, 23, 25
                        if (iFila == 5 || iFila == 9 || iFila == 12 || iFila == 14 || iFila == 18 || iFila == 20 || iFila == 23 || iFila == 25) {
                            for (var j = 0; j < divsTots.length; j++) {

                                var valor_sin_formato = divsTots[j].innerHTML.replace('<span style="color:red;">', '').replace('<span>', '').replace('&nbsp;</span>', '');
                                if (divsTots[j].id.indexOf("divImporte01") >= 0) { valor_total_totales += parseInt(valor_sin_formato); hayValores = true; }
                                if (divsTots[j].id.indexOf("divImporte02") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }

                                if (divsTots[j].id.indexOf("divImporteTotal") >= 0 && hayValores) {
                                    divsTots[j].innerHTML = "<span " + (valor_total_totales < 0 ? "style='color:red;'" : "") + ">" + valor_total_totales + "&nbsp;</span>";
                                }
                            }
                        }
                    }
                }
            }
        }










        function RecalculaTotales_EstadoResultadosIndividual(control) {
            if (!isNumber(control.value)) { control.value = "0"; }

            var grid = document.getElementById("<%= gvCapturaERIndividual.ClientID%>");

            var totales = new Array(5, 9, 12, 14, 18, 20, 23, 25);
            var elementos_suman1 = new Array(0, 1);
            var elementos_restan1 = new Array(2, 3, 4);
            var elementos_suman2 = new Array(6, 7, 8);
            var elementos_restan2 = new Array(0);
            var elementos_suman3 = new Array(0, 1);
            var elementos_restan3 = new Array(2, 3, 4, 6, 7, 8, 10, 11);
            var elementos_suman4 = new Array(0, 1);
            var elementos_restan4 = new Array(2, 3, 4, 6, 7, 8, 10, 11, 13);
            var elementos_suman5 = new Array(1, 12, 15, 16, 17);
            var elementos_restan5 = new Array(2, 3, 4, 6, 7, 8, 10, 11, 13);
            var elementos_suman6 = new Array(1, 12, 15, 16, 17);
            var elementos_restan6 = new Array(2, 3, 4, 6, 7, 8, 10, 11, 13, 19);
            var elementos_suman7 = new Array(1, 12, 15, 16, 17);
            var elementos_restan7 = new Array(2, 3, 4, 6, 7, 8, 10, 11, 13, 19, 21, 22);
            var elementos_suman8 = new Array(0, 1, 24);
            var elementos_restan8 = new Array(2, 3, 3, 6, 7, 8, 10, 11, 13);


            if (grid.rows.length > 0) {
                for (columna = 1; columna <= 11; columna++) {
                    var str = "" + columna
                    var pad = "00"
                    var columna_txt = pad.substring(0, pad.length - str.length) + str

                    var monto_calculado = 0;
                    var totalesacalcular = 0;
                    var monto_calculado1 = 0;
                    var monto_calculado2 = 0;
                    var monto_calculado3 = 0;
                    var monto_calculado4 = 0;
                    var monto_calculado5 = 0;
                    var monto_calculado6 = 0;
                    var monto_calculado7 = 0;
                    var monto_calculado8 = 0;
                    for (iFila = 1; iFila < grid.rows.length; iFila++) {

                        var valor_total_columna = 0;
                        var valor_total_columna_fibras = 0;
                        var valor_total_columna_hornos = 0;
                        var elementos = grid.rows[iFila].getElementsByTagName('input');
                        for (var j = 0; j < elementos.length; j++) {
                            //if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte01") >= 0) { valor_total_columna += parseInt(elementos[j].value); }
                            //if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte02") >= 0) { valor_total_columna += parseInt(elementos[j].value); }

                            if (elementos[j].type == 'text'
                                && (elementos[j].id.indexOf("txtImporte03") >= 0
                                    || elementos[j].id.indexOf("txtImporte04") >= 0
                                    || elementos[j].id.indexOf("txtImporte05") >= 0
                                    || elementos[j].id.indexOf("txtImporte06") >= 0
                                    || elementos[j].id.indexOf("txtImporte07") >= 0
                                    || elementos[j].id.indexOf("txtImporte10") >= 0
                                    || elementos[j].id.indexOf("txtImporte11") >= 0)) {
                                valor_total_columna += parseInt(elementos[j].value);
                                valor_total_columna_fibras += parseInt(elementos[j].value);
                            }
                            if (elementos[j].type == 'text'
                                && (elementos[j].id.indexOf("txtImporte08") >= 0
                                    || elementos[j].id.indexOf("txtImporte09") >= 0)) {
                                valor_total_columna += parseInt(elementos[j].value);
                                valor_total_columna_hornos += parseInt(elementos[j].value);
                            }


                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte" + columna_txt) >= 0) {
                                var valor = elementos[j].value;
                                if (existe(elementos_suman1, iFila)) {
                                    monto_calculado1 += parseInt(valor);
                                }
                                if (existe(elementos_restan1, iFila)) {
                                    monto_calculado1 -= parseInt(valor);
                                }
                                if (existe(elementos_suman2, iFila)) {
                                    monto_calculado2 += parseInt(valor);
                                }
                                if (existe(elementos_restan2, iFila)) {
                                    monto_calculado2 -= parseInt(valor);
                                }
                                if (existe(elementos_suman3, iFila)) {
                                    monto_calculado3 += parseInt(valor);
                                }
                                if (existe(elementos_restan3, iFila)) {
                                    monto_calculado3 -= parseInt(valor);
                                }
                                if (existe(elementos_suman4, iFila)) {
                                    monto_calculado4 += parseInt(valor);
                                }
                                if (existe(elementos_restan4, iFila)) {
                                    monto_calculado4 -= parseInt(valor);
                                }
                                if (existe(elementos_suman5, iFila)) {
                                    monto_calculado5 += parseInt(valor);
                                }
                                if (existe(elementos_restan5, iFila)) {
                                    monto_calculado5 -= parseInt(valor);
                                }
                                if (existe(elementos_suman6, iFila)) {
                                    monto_calculado6 += parseInt(valor);
                                }
                                if (existe(elementos_restan6, iFila)) {
                                    monto_calculado6 -= parseInt(valor);
                                }
                                if (existe(elementos_suman7, iFila)) {
                                    monto_calculado7 += parseInt(valor);
                                }
                                if (existe(elementos_restan7, iFila)) {
                                    monto_calculado7 -= parseInt(valor);
                                }
                                if (existe(elementos_suman8, iFila)) {
                                    monto_calculado8 += parseInt(valor);
                                }
                                if (existe(elementos_restan8, iFila)) {
                                    monto_calculado8 -= parseInt(valor);
                                }



                                //if (j == 3 || j == 4 || j == 5 || j == 6 || j == 7 || j == 10) {
                                //    valor_total_columna_fibras += parseInt(valor);
                                //}
                                //if (j == 8 || j == 9) {
                                //    valor_total_columna_hornos += parseInt(valor);
                                //}
                            }
                        }


                        //console.log('- - - - - - - - - - - - - -');
                        //console.log('iFila: ' + iFila);
                        //console.log('valor_total_columna_fibras: ' + valor_total_columna_fibras);
                        //console.log('valor_total_columna_hornos: ' + valor_total_columna_hornos);


                        if (totales[totalesacalcular] == iFila) {
                            var divs = grid.rows[iFila].getElementsByTagName('div')
                            for (var kDiv = 0; kDiv < divs.length; kDiv++) {
                                if (divs[kDiv].id.indexOf("divImporte" + columna_txt) >= 0) {
                                    if (totalesacalcular == 0)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado1 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado1 + "&nbsp;</span>";
                                    else if (totalesacalcular == 1)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado2 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado2 + "&nbsp;</span>";
                                    else if (totalesacalcular == 2)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado3 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado3 + "&nbsp;</span>";
                                    else if (totalesacalcular == 3)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado4 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado4 + "&nbsp;</span>";
                                    else if (totalesacalcular == 4)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado5 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado5 + "&nbsp;</span>";
                                    else if (totalesacalcular == 5)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado6 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado6 + "&nbsp;</span>";
                                    else if (totalesacalcular == 6)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado7 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado7 + "&nbsp;</span>";
                                    else if (totalesacalcular == 7)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado8 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado8 + "&nbsp;</span>";
                                }
                            }
                            monto_calculado = 0;
                            totalesacalcular += 1;
                        }




                        var txtImporte01 = grid.rows[iFila].getElementsByClassName('total_fibras');
                        if (txtImporte01.length > 0) {
                            txtImporte01[0].value = valor_total_columna_fibras;
                        }

                        var txtImporte02 = grid.rows[iFila].getElementsByClassName('total_hornos');
                        if (txtImporte02.length > 0) {
                            txtImporte02[0].value = valor_total_columna_hornos;
                        }


                        var divsTot = grid.rows[iFila].getElementsByTagName('div')
                        for (var kDivTot = 0; kDivTot < divsTot.length; kDivTot++) {
                            if (divsTot[kDivTot].id.indexOf("divImporteTotal") >= 0) {
                                divsTot[kDivTot].innerHTML = "<span " + (valor_total_columna < 0 ? "style='color:red;'" : "") + ">" + valor_total_columna + "&nbsp;</span>";
                            }
                        }
                    }



                    for (iFila = 1; iFila < grid.rows.length; iFila++) {
                        var divsTots = grid.rows[iFila].getElementsByTagName('div');
                        var valor_total_totales = 0;
                        var hayValores = false;

                        //if (iFila == 4 || iFila == 8 || iFila == 10 || iFila == 14 || iFila == 16 || iFila == 19 || iFila == 21) {

                        //5, 9, 12, 14, 18, 20, 23, 25
                        if (iFila == 5 || iFila == 9 || iFila == 12 || iFila == 14 || iFila == 18 || iFila == 20 || iFila == 23 || iFila == 25) {
                            for (var j = 0; j < divsTots.length; j++) {



                                var valor_sin_formato = divsTots[j].innerHTML.replace('<span style="color:red;">', '').replace('<span>', '').replace('&nbsp;</span>', '');
                                if (divsTots[j].id.indexOf("divImporte01") >= 0) { valor_total_totales += parseInt(valor_sin_formato); hayValores = true; }
                                if (divsTots[j].id.indexOf("divImporte02") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }

                                if (divsTots[j].id.indexOf("divImporteTotal") >= 0 && hayValores) {
                                    divsTots[j].innerHTML = "<span " + (valor_total_totales < 0 ? "style='color:red;'" : "") + ">" + valor_total_totales + "&nbsp;</span>";
                                }
                            }
                        }


                    }
                }





                for (columna = 1; columna <= 11; columna++) {
                    var str = "" + columna
                    var pad = "00"
                    var columna_txt = pad.substring(0, pad.length - str.length) + str

                    var monto_calculado = 0;
                    var totalesacalcular = 0;
                    var monto_calculado1 = 0;
                    var monto_calculado2 = 0;
                    var monto_calculado3 = 0;
                    var monto_calculado4 = 0;
                    var monto_calculado5 = 0;
                    var monto_calculado6 = 0;
                    var monto_calculado7 = 0;
                    var monto_calculado8 = 0;
                    for (iFila = 1; iFila < grid.rows.length; iFila++) {

                        var valor_total_columna = 0;
                        var valor_total_columna_fibras = 0;
                        var valor_total_columna_hornos = 0;
                        var elementos = grid.rows[iFila].getElementsByTagName('input');
                        for (var j = 0; j < elementos.length; j++) {
                            //if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte01") >= 0) { valor_total_columna += parseInt(elementos[j].value); }
                            //if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte02") >= 0) { valor_total_columna += parseInt(elementos[j].value); }

                            if (elementos[j].type == 'text'
                                && (elementos[j].id.indexOf("txtImporte03") >= 0
                                    || elementos[j].id.indexOf("txtImporte04") >= 0
                                    || elementos[j].id.indexOf("txtImporte05") >= 0
                                    || elementos[j].id.indexOf("txtImporte06") >= 0
                                    || elementos[j].id.indexOf("txtImporte07") >= 0
                                    || elementos[j].id.indexOf("txtImporte10") >= 0
                                    || elementos[j].id.indexOf("txtImporte11") >= 0)) {
                                valor_total_columna += parseInt(elementos[j].value);
                                valor_total_columna_fibras += parseInt(elementos[j].value);
                            }
                            if (elementos[j].type == 'text'
                                && (elementos[j].id.indexOf("txtImporte08") >= 0
                                    || elementos[j].id.indexOf("txtImporte09") >= 0)) {
                                valor_total_columna += parseInt(elementos[j].value);
                                valor_total_columna_hornos += parseInt(elementos[j].value);
                            }


                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte" + columna_txt) >= 0) {
                                var valor = elementos[j].value;
                                if (existe(elementos_suman1, iFila)) {
                                    monto_calculado1 += parseInt(valor);
                                }
                                if (existe(elementos_restan1, iFila)) {
                                    monto_calculado1 -= parseInt(valor);
                                }
                                if (existe(elementos_suman2, iFila)) {
                                    monto_calculado2 += parseInt(valor);
                                }
                                if (existe(elementos_restan2, iFila)) {
                                    monto_calculado2 -= parseInt(valor);
                                }
                                if (existe(elementos_suman3, iFila)) {
                                    monto_calculado3 += parseInt(valor);
                                }
                                if (existe(elementos_restan3, iFila)) {
                                    monto_calculado3 -= parseInt(valor);
                                }
                                if (existe(elementos_suman4, iFila)) {
                                    monto_calculado4 += parseInt(valor);
                                }
                                if (existe(elementos_restan4, iFila)) {
                                    monto_calculado4 -= parseInt(valor);
                                }
                                if (existe(elementos_suman5, iFila)) {
                                    monto_calculado5 += parseInt(valor);
                                }
                                if (existe(elementos_restan5, iFila)) {
                                    monto_calculado5 -= parseInt(valor);
                                }
                                if (existe(elementos_suman6, iFila)) {
                                    monto_calculado6 += parseInt(valor);
                                }
                                if (existe(elementos_restan6, iFila)) {
                                    monto_calculado6 -= parseInt(valor);
                                }
                                if (existe(elementos_suman7, iFila)) {
                                    monto_calculado7 += parseInt(valor);
                                }
                                if (existe(elementos_restan7, iFila)) {
                                    monto_calculado7 -= parseInt(valor);
                                }
                                if (existe(elementos_suman8, iFila)) {
                                    monto_calculado8 += parseInt(valor);
                                }
                                if (existe(elementos_restan8, iFila)) {
                                    monto_calculado8 -= parseInt(valor);
                                }



                                //if (j == 3 || j == 4 || j == 5 || j == 6 || j == 7 || j == 10) {
                                //    valor_total_columna_fibras += parseInt(valor);
                                //}
                                //if (j == 8 || j == 9) {
                                //    valor_total_columna_hornos += parseInt(valor);
                                //}
                            }
                        }


                        //console.log('- - - - - - - - - - - - - -');
                        //console.log('iFila: ' + iFila);
                        //console.log('valor_total_columna_fibras: ' + valor_total_columna_fibras);
                        //console.log('valor_total_columna_hornos: ' + valor_total_columna_hornos);


                        if (totales[totalesacalcular] == iFila) {
                            var divs = grid.rows[iFila].getElementsByTagName('div')
                            for (var kDiv = 0; kDiv < divs.length; kDiv++) {
                                if (divs[kDiv].id.indexOf("divImporte" + columna_txt) >= 0) {
                                    if (totalesacalcular == 0)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado1 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado1 + "&nbsp;</span>";
                                    else if (totalesacalcular == 1)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado2 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado2 + "&nbsp;</span>";
                                    else if (totalesacalcular == 2)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado3 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado3 + "&nbsp;</span>";
                                    else if (totalesacalcular == 3)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado4 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado4 + "&nbsp;</span>";
                                    else if (totalesacalcular == 4)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado5 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado5 + "&nbsp;</span>";
                                    else if (totalesacalcular == 5)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado6 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado6 + "&nbsp;</span>";
                                    else if (totalesacalcular == 6)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado7 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado7 + "&nbsp;</span>";
                                    else if (totalesacalcular == 7)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado8 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado8 + "&nbsp;</span>";
                                }
                            }
                            monto_calculado = 0;
                            totalesacalcular += 1;
                        }




                        var txtImporte01 = grid.rows[iFila].getElementsByClassName('total_fibras');
                        if (txtImporte01.length > 0) {
                            txtImporte01[0].value = valor_total_columna_fibras;
                        }
                        var txtImporte02 = grid.rows[iFila].getElementsByClassName('total_hornos');
                        if (txtImporte02.length > 0) {
                            txtImporte02[0].value = valor_total_columna_hornos;
                        }


                        var divsTot = grid.rows[iFila].getElementsByTagName('div')
                        for (var kDivTot = 0; kDivTot < divsTot.length; kDivTot++) {
                            if (divsTot[kDivTot].id.indexOf("divImporteTotal") >= 0) {
                                divsTot[kDivTot].innerHTML = "<span " + (valor_total_columna < 0 ? "style='color:red;'" : "") + ">" + valor_total_columna + "&nbsp;</span>";
                            }
                        }
                    }



                    for (iFila = 1; iFila < grid.rows.length; iFila++) {
                        var divsTots = grid.rows[iFila].getElementsByTagName('div');
                        var valor_total_totales = 0;
                        var hayValores = false;

                        //if (iFila == 4 || iFila == 8 || iFila == 10 || iFila == 14 || iFila == 16 || iFila == 19 || iFila == 21) {

                        //5, 9, 12, 14, 18, 20, 23, 25
                        if (iFila == 5 || iFila == 9 || iFila == 12 || iFila == 14 || iFila == 18 || iFila == 20 || iFila == 23 || iFila == 25) {
                            for (var j = 0; j < divsTots.length; j++) {

                                var valor_sin_formato = divsTots[j].innerHTML.replace('<span style="color:red;">', '').replace('<span>', '').replace('&nbsp;</span>', '');
                                if (divsTots[j].id.indexOf("divImporte01") >= 0) { valor_total_totales += parseInt(valor_sin_formato); hayValores = true; }
                                if (divsTots[j].id.indexOf("divImporte02") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }

                                if (divsTots[j].id.indexOf("divImporteTotal") >= 0 && hayValores) {
                                    divsTots[j].innerHTML = "<span " + (valor_total_totales < 0 ? "style='color:red;'" : "") + ">" + valor_total_totales + "&nbsp;</span>";
                                }
                            }
                        }
                    }
                }
            }
        }














        function RecalculaTotales_PedidosFacturacion(control) {
            if (!isNumber(control.value)) { control.value = "0"; }

            var grid = document.getElementById("<%= gvCaptura.ClientID %>");
            var totales = new Array(13, 18, 19, 32, 37, 38, 51, 56, 57);
            var elementos_suman1 = new Array(2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12);
            var elementos_restan1 = new Array(0, 0);
            var elementos_suman2 = new Array(14, 15);
            var elementos_restan2 = new Array(0, 0);
            var elementos_suman3 = new Array(14, 15);
            var elementos_restan3 = new Array(16, 17);
            var elementos_suman4 = new Array(21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31);
            var elementos_restan4 = new Array(0, 0);
            var elementos_suman5 = new Array(33, 34);
            var elementos_restan5 = new Array(0, 0);
            var elementos_suman6 = new Array(33, 34);
            var elementos_restan6 = new Array(35, 36);

            var elementos_suman7 = new Array(40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50);
            var elementos_restan7 = new Array(0, 0);
            var elementos_suman8 = new Array(52, 53);
            var elementos_restan8 = new Array(0, 0);
            var elementos_suman9 = new Array(42, 53);
            var elementos_restan9 = new Array(54, 55);

            //var totales = new Array(12, 17, 18, 30, 35, 36, 48, 53, 54);
            //var elementos_suman1 = new Array(2, 3, 4, 5, 6, 7, 8, 9, 10, 11);
            //var elementos_restan1 = new Array(0, 0);
            //var elementos_suman2 = new Array(13, 14);
            //var elementos_restan2 = new Array(0, 0);
            //var elementos_suman3 = new Array(13, 14);
            //var elementos_restan3 = new Array(15, 16);
            //var elementos_suman4 = new Array(20, 21, 22, 23, 24, 25, 26, 27, 28, 29);
            //var elementos_restan4 = new Array(0, 0);
            //var elementos_suman5 = new Array(31, 32);
            //var elementos_restan5 = new Array(0, 0);
            //var elementos_suman6 = new Array(31, 32);
            //var elementos_restan6 = new Array(33, 34);

            //var elementos_suman7 = new Array(38, 39, 40, 41, 42, 43, 44, 45, 46, 47);
            //var elementos_restan7 = new Array(0, 0);
            //var elementos_suman8 = new Array(49, 50);
            //var elementos_restan8 = new Array(0, 0);
            //var elementos_suman9 = new Array(49, 50);
            //var elementos_restan9 = new Array(51, 52);

           


            if (grid.rows.length > 0) {
                for (columna = 1; columna <= 2; columna++) {
                    var str = "" + columna
                    var pad = "00"
                    var columna_txt = pad.substring(0, pad.length - str.length) + str

                    var monto_calculado = 0;
                    var totalesacalcular = 0;
                    var monto_calculado1 = 0;
                    var monto_calculado2 = 0;
                    var monto_calculado3 = 0;
                    var monto_calculado4 = 0;
                    var monto_calculado5 = 0;
                    var monto_calculado6 = 0;
                    var monto_calculado7 = 0;
                    var monto_calculado8 = 0;
                    var monto_calculado9 = 0;
                    for (iFila = 1; iFila < grid.rows.length; iFila++) {

                        var valor_total_columna = 0;
                        var elementos = grid.rows[iFila].getElementsByTagName('input');
                        for (var j = 0; j < elementos.length; j++) {
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte01") >= 0) { valor_total_columna += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte02") >= 0) { valor_total_columna += parseInt(elementos[j].value); }
                            var divsTot = grid.rows[iFila].getElementsByTagName('div')
                            for (var kDivTot = 0; kDivTot < divsTot.length; kDivTot++) {
                                if (divsTot[kDivTot].id.indexOf("divImporteTotal") >= 0) {
                                    divsTot[kDivTot].innerHTML = "<span " + (valor_total_columna < 0 ? "style='color:red;'" : "") + ">" + valor_total_columna + "&nbsp;</span>";
                                }
                            }


                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte" + columna_txt) >= 0) {
                                var valor = elementos[j].value;

                                if (existe(elementos_suman1, iFila)) {
                                    monto_calculado1 += parseInt(valor);
                                }
                                if (existe(elementos_restan1, iFila)) {
                                    monto_calculado1 -= parseInt(valor);
                                }
                                if (existe(elementos_suman2, iFila)) {
                                    monto_calculado2 += parseInt(valor);
                                }
                                if (existe(elementos_restan2, iFila)) {
                                    monto_calculado2 -= parseInt(valor);
                                }
                                if (existe(elementos_suman3, iFila)) {
                                    monto_calculado3 += parseInt(valor);
                                }
                                if (existe(elementos_restan3, iFila)) {
                                    monto_calculado3 -= parseInt(valor);
                                }
                                if (existe(elementos_suman4, iFila)) {
                                    monto_calculado4 += parseInt(valor);
                                }
                                if (existe(elementos_restan4, iFila)) {
                                    monto_calculado4 -= parseInt(valor);
                                }
                                if (existe(elementos_suman5, iFila)) {
                                    monto_calculado5 += parseInt(valor);
                                }
                                if (existe(elementos_restan5, iFila)) {
                                    monto_calculado5 -= parseInt(valor);
                                }
                                if (existe(elementos_suman6, iFila)) {
                                    monto_calculado6 += parseInt(valor);
                                }
                                if (existe(elementos_restan6, iFila)) {
                                    monto_calculado6 -= parseInt(valor);
                                }

                                if (existe(elementos_suman7, iFila)) {
                                    monto_calculado7 += parseInt(valor);
                                }
                                if (existe(elementos_restan7, iFila)) {
                                    monto_calculado7 -= parseInt(valor);
                                }
                                if (existe(elementos_suman8, iFila)) {
                                    monto_calculado8 += parseInt(valor);
                                }
                                if (existe(elementos_restan8, iFila)) {
                                    monto_calculado8 -= parseInt(valor);
                                }
                                if (existe(elementos_suman9, iFila)) {
                                    monto_calculado9 += parseInt(valor);
                                }
                                if (existe(elementos_restan9, iFila)) {
                                    monto_calculado9 -= parseInt(valor);
                                }

                            }
                        }
                        
                        if (totales[totalesacalcular] == iFila) {
                            var divs = grid.rows[iFila].getElementsByTagName('div')
                            for (var kDiv = 0; kDiv < divs.length; kDiv++) {
                                if (divs[kDiv].id.indexOf("divImporte" + columna_txt) >= 0) {
                                    if (totalesacalcular == 0)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado1 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado1 + "&nbsp;</span>";
                                    else if (totalesacalcular == 1)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado2 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado2 + "&nbsp;</span>";
                                    else if (totalesacalcular == 2)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado3 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado3 + "&nbsp;</span>";
                                    else if (totalesacalcular == 3)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado4 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado4 + "&nbsp;</span>";
                                    else if (totalesacalcular == 4)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado5 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado5 + "&nbsp;</span>";
                                    else if (totalesacalcular == 5)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado6 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado6 + "&nbsp;</span>";
                                    else if (totalesacalcular == 6)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado7 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado7 + "&nbsp;</span>";
                                    else if (totalesacalcular == 7)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado8 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado8 + "&nbsp;</span>";
                                    else if (totalesacalcular == 8)
                                        divs[kDiv].innerHTML = "<span " + (monto_calculado9 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado9 + "&nbsp;</span>";
                                }
                            }
                            monto_calculado = 0;
                            totalesacalcular += 1;
                        }
                    }




                }
            }
        }


















        
        function existe(arr, obj) {
            for (var i = 0; i < arr.length; i++) {
                if (arr[i] == obj) return true;
            }
            return false;
        }


        function CalculaTotales(tipo) {
            if (tipo == 1) {
                if (document.getElementById('<%=txtFibrasTotal.ClientID%>') != null) {

                    var monto_total = parseInt(document.getElementById('<%=txtFibrasTotal.ClientID%>').value);
                    var monto_asignado = 0;
                    monto_asignado += parseInt(document.getElementById('<%=txtFibrasMes1.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtFibrasMes2.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtFibrasMes3.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtFibrasMes4.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtFibrasMes5.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtFibrasMes6.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtFibrasMes7.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtFibrasMes8.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtFibrasMes9.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtFibrasMes10.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtFibrasMes11.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtFibrasMes12.ClientID%>').value);

                    document.getElementById('<%=txtFibrasPorAsignar.ClientID%>').value = monto_total - monto_asignado;
                }
            } else {
                if (document.getElementById('<%=txtHornosTotal.ClientID%>') != null) {
                    var monto_total = parseInt(document.getElementById('<%=txtHornosTotal.ClientID%>').value);
                    var monto_asignado = 0;
                    monto_asignado += parseInt(document.getElementById('<%=txtHornosMes1.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtHornosMes2.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtHornosMes3.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtHornosMes4.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtHornosMes5.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtHornosMes6.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtHornosMes7.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtHornosMes8.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtHornosMes9.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtHornosMes10.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtHornosMes11.ClientID%>').value);
                    monto_asignado += parseInt(document.getElementById('<%=txtHornosMes12.ClientID%>').value);

                    document.getElementById('<%=txtHornosPorAsignar.ClientID%>').value = monto_total - monto_asignado;
                }
            }
        }

        function SeleccionAuto(tipo) {
            if (tipo == 1) {
                if (document.getElementById('<%=chkFibrasAuto.ClientID%>') != null) {
                    if (document.getElementById('<%=chkFibrasAuto.ClientID%>').checked) {
                        document.getElementById('<%=txtFibrasPorAsignar.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtFibrasMes1.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtFibrasMes2.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtFibrasMes3.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtFibrasMes4.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtFibrasMes5.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtFibrasMes6.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtFibrasMes7.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtFibrasMes8.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtFibrasMes9.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtFibrasMes10.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtFibrasMes11.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtFibrasMes12.ClientID%>').style.display = "none";
                    } else {
                        document.getElementById('<%=txtFibrasPorAsignar.ClientID%>').style.display = "";
                        document.getElementById('<%=txtFibrasMes1.ClientID%>').style.display = "";
                        document.getElementById('<%=txtFibrasMes2.ClientID%>').style.display = "";
                        document.getElementById('<%=txtFibrasMes3.ClientID%>').style.display = "";
                        document.getElementById('<%=txtFibrasMes4.ClientID%>').style.display = "";
                        document.getElementById('<%=txtFibrasMes5.ClientID%>').style.display = "";
                        document.getElementById('<%=txtFibrasMes6.ClientID%>').style.display = "";
                        document.getElementById('<%=txtFibrasMes7.ClientID%>').style.display = "";
                        document.getElementById('<%=txtFibrasMes8.ClientID%>').style.display = "";
                        document.getElementById('<%=txtFibrasMes9.ClientID%>').style.display = "";
                        document.getElementById('<%=txtFibrasMes10.ClientID%>').style.display = "";
                        document.getElementById('<%=txtFibrasMes11.ClientID%>').style.display = "";
                        document.getElementById('<%=txtFibrasMes12.ClientID%>').style.display = "";
                    }
                }
            }
            else if (tipo == 2) {
                if (document.getElementById('<%=chkHornosAuto.ClientID%>') != null) {
                    if (document.getElementById('<%=chkHornosAuto.ClientID%>').checked) {
                        document.getElementById('<%=txtHornosPorAsignar.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtHornosMes1.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtHornosMes2.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtHornosMes3.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtHornosMes4.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtHornosMes5.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtHornosMes6.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtHornosMes7.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtHornosMes8.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtHornosMes9.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtHornosMes10.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtHornosMes11.ClientID%>').style.display = "none";
                        document.getElementById('<%=txtHornosMes12.ClientID%>').style.display = "none";
                    } else {
                        document.getElementById('<%=txtHornosPorAsignar.ClientID%>').style.display = "";
                        document.getElementById('<%=txtHornosMes1.ClientID%>').style.display = "";
                        document.getElementById('<%=txtHornosMes2.ClientID%>').style.display = "";
                        document.getElementById('<%=txtHornosMes3.ClientID%>').style.display = "";
                        document.getElementById('<%=txtHornosMes4.ClientID%>').style.display = "";
                        document.getElementById('<%=txtHornosMes5.ClientID%>').style.display = "";
                        document.getElementById('<%=txtHornosMes6.ClientID%>').style.display = "";
                        document.getElementById('<%=txtHornosMes7.ClientID%>').style.display = "";
                        document.getElementById('<%=txtHornosMes8.ClientID%>').style.display = "";
                        document.getElementById('<%=txtHornosMes9.ClientID%>').style.display = "";
                        document.getElementById('<%=txtHornosMes10.ClientID%>').style.display = "";
                        document.getElementById('<%=txtHornosMes11.ClientID%>').style.display = "";
                        document.getElementById('<%=txtHornosMes12.ClientID%>').style.display = "";
                    }
                }
            }
        }

        function GuardaDistribucion_OnClientClick() {
            var msg = '';
            if (document.getElementById('<%=chkFibrasAuto.ClientID%>') != null) {
                if (document.getElementById('<%=chkFibrasAuto.ClientID%>').checked == false && 
                   parseInt(document.getElementById('<%=txtFibrasPorAsignar.ClientID%>').value) != 0) {
                    msg += "Tiene pendiente por asignar para FIBRAS: " + document.getElementById('<%=txtFibrasPorAsignar.ClientID%>').value + "\n"
                }
            }

            if (document.getElementById('<%=chkHornosAuto.ClientID%>') != null) {
                if (document.getElementById('<%=chkHornosAuto.ClientID%>').checked == false &&
                   parseInt(document.getElementById('<%=txtHornosPorAsignar.ClientID%>').value) != 0) {
                    msg += "Tiene pendiente por asignar para HORNOS: " + document.getElementById('<%=txtHornosPorAsignar.ClientID%>').value + "\n"
                }
            }
            if (msg.length > 0) {
                alert(msg);
                return false;
            }
            return true;
        }








        function RecalculaTotales_PedidosFacturacionExpandido(control) {
            if (!isNumber(control.value)) { control.value = "0"; }

            var grid = document.getElementById("<%=gvCapturaExtendido.ClientID %>");
            var totales = new Array(10, 11, 21, 22, 32, 33, 43, 44);
            var elementos_suman1 = new Array(2, 3, 4, 5, 6, 7, 8, 9);
            var elementos_restan1 = new Array(0);
            var elementos_suman2 = new Array(2, 3, 4, 5, 6, 7, 8, 9);
            var elementos_restan2 = new Array(0<%=RestanPyF(1)%>);
            var elementos_suman3 = new Array(13, 14, 15, 16, 17, 18, 19, 20);
            var elementos_restan3 = new Array(0);
            var elementos_suman4 = new Array(13, 14, 15, 16, 17, 18, 19, 20);
            var elementos_restan4 = new Array(0<%=RestanPyF(2)%>);
            var elementos_suman5 = new Array(24, 25, 26, 27, 28, 29, 30, 31);
            var elementos_restan5 = new Array(0);
            var elementos_suman6 = new Array(24, 25, 26, 27, 28, 29, 30, 31);
            var elementos_restan6 = new Array(0<%=RestanPyF(3) %>);
            var elementos_suman7 = new Array(35, 36, 37, 38, 39, 40, 41, 42);
            var elementos_restan7 = new Array(0);
            var elementos_suman8 = new Array(35, 36, 37, 38, 39, 40, 41, 42);
            var elementos_restan8 = new Array(0<%=RestanPyF(4) %>);

            var COLUMNAS = ['01','02','03','04'];
            if (grid.rows.length > 0) {
                for(var COLS = 0; COLS < COLUMNAS.length; COLS++){
                    //console.log(COLUMNAS.length);
                    //console.log(COLUMNAS[COLS]);

                    var monto_calculado = 0;
                    var totalesacalcular = 0;
                    var monto_calculado1 = 0;
                    var monto_calculado2 = 0;
                    var monto_calculado3 = 0;
                    var monto_calculado4 = 0;
                    var monto_calculado5 = 0;
                    var monto_calculado6 = 0;
                    var monto_calculado7 = 0;
                    var monto_calculado8 = 0;
                    for (iFila = 1; iFila < grid.rows.length; iFila++) {

                        var elementos = grid.rows[iFila].getElementsByTagName('input');
                        var valor_total_columna = 0;
                        for (var j = 0; j < elementos.length; j++) {

                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte01") >= 0) { valor_total_columna += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte02") >= 0) { valor_total_columna += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte03") >= 0) { valor_total_columna += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte04") >= 0) { valor_total_columna += parseInt(elementos[j].value); }
                            var divsTot = grid.rows[iFila].getElementsByTagName('div')
                            for (var kDivTot = 0; kDivTot < divsTot.length; kDivTot++) {
                                if (divsTot[kDivTot].id.indexOf("divImporteTotal") >= 0) {
                                    divsTot[kDivTot].innerHTML = "<span " + (valor_total_columna < 0 ? "style='color:red;'" : "") + ">" + valor_total_columna + "&nbsp;</span>";
                                }
                            }

                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte" + COLUMNAS[COLS]) >= 0) {
                                var valor = elementos[j].value;

                                if (existe(elementos_suman1, iFila)) {
                                    monto_calculado1 += parseInt(valor);
                                }
                                if (existe(elementos_restan1, iFila)) {
                                    monto_calculado1 -= parseInt(valor);
                                }
                                if (existe(elementos_suman2, iFila)) {
                                    monto_calculado2 += parseInt(valor);
                                }
                                if (existe(elementos_restan2, iFila)) {
                                    monto_calculado2 -= parseInt(valor);
                                }
                                if (existe(elementos_suman3, iFila)) {
                                    monto_calculado3 += parseInt(valor);
                                }
                                if (existe(elementos_restan3, iFila)) {
                                    monto_calculado3 -= parseInt(valor);
                                }
                                if (existe(elementos_suman4, iFila)) {
                                    monto_calculado4 += parseInt(valor);
                                }
                                if (existe(elementos_restan4, iFila)) {
                                    monto_calculado4 -= parseInt(valor);
                                }
                                if (existe(elementos_suman5, iFila)) {
                                    monto_calculado5 += parseInt(valor);
                                }
                                if (existe(elementos_restan5, iFila)) {
                                    monto_calculado5 -= parseInt(valor);
                                }
                                if (existe(elementos_suman6, iFila)) {
                                    monto_calculado6 += parseInt(valor);
                                }
                                if (existe(elementos_restan6, iFila)) {
                                    monto_calculado6 -= parseInt(valor);
                                }
                                if (existe(elementos_suman7, iFila)) {
                                    monto_calculado7 += parseInt(valor);
                                }
                                if (existe(elementos_restan7, iFila)) {
                                    monto_calculado7 -= parseInt(valor);
                                }
                                if (existe(elementos_suman8, iFila)) {
                                    monto_calculado8 += parseInt(valor);
                                }
                                if (existe(elementos_restan8, iFila)) {
                                    monto_calculado8 -= parseInt(valor);
                                }
                            }
                        }

                        if (totales[totalesacalcular] == iFila) {
                            var divs = grid.rows[iFila].getElementsByTagName('div')
                            for (var kDiv = 0; kDiv < divs.length; kDiv++) {
                                if (divs[kDiv].id.indexOf("divImporte" + COLUMNAS[COLS]) >= 0) {
                                    if (totalesacalcular == 0)
                                        divs[kDiv].innerHTML = "<span ID='lblImporte' " + (monto_calculado1 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado1 + "&nbsp;</span>";
                                    else if (totalesacalcular == 1)
                                        divs[kDiv].innerHTML = "<span ID='lblImporte' " + (monto_calculado2 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado2 + "&nbsp;</span>";
                                    else if (totalesacalcular == 2)
                                        divs[kDiv].innerHTML = "<span ID='lblImporte' " + (monto_calculado3 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado3 + "&nbsp;</span>";
                                    else if (totalesacalcular == 3)
                                        divs[kDiv].innerHTML = "<span ID='lblImporte' " + (monto_calculado4 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado4 + "&nbsp;</span>";
                                    else if (totalesacalcular == 4)
                                        divs[kDiv].innerHTML = "<span ID='lblImporte' " + (monto_calculado5 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado5 + "&nbsp;</span>";
                                    else if (totalesacalcular == 5)
                                        divs[kDiv].innerHTML = "<span ID='lblImporte' " + (monto_calculado6 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado6 + "&nbsp;</span>";
                                    else if (totalesacalcular == 6)
                                        divs[kDiv].innerHTML = "<span ID='lblImporte' " + (monto_calculado7 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado7 + "&nbsp;</span>";
                                    else if (totalesacalcular == 7)
                                        divs[kDiv].innerHTML = "<span ID='lblImporte' " + (monto_calculado8 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado8 + "&nbsp;</span>";
                                }
                            }
                            //console.log('monto_calculado: ' + monto_calculado);
                            /*
                            if (totalesacalcular == 0) { totales1 = monto_calculado; }
                            else if (totalesacalcular == 1) { totales2 = monto_calculado; }*/
                            monto_calculado = 0;
                            totalesacalcular += 1;
                        }
                    }

                    
                    for (iFila = 1; iFila < grid.rows.length; iFila++) {
                        // TOTAL DE COLUMNA SIN CAPTURA
                        valor_total_columna = 0;
                        var divsConTotales = grid.rows[iFila].getElementsByTagName('span')
                        for(var i = 0, l = divsConTotales.length; i < l; i++){
                            if (divsConTotales[i].id.indexOf("lblImporte") >= 0) { valor_total_columna += parseInt(divsConTotales[i].innerHTML); 
                                var divsTot = grid.rows[iFila].getElementsByTagName('div')
                                for (var kDivTot = 0; kDivTot < divsTot.length; kDivTot++) {
                                    if (divsTot[kDivTot].id.indexOf("divImporteTotal") >= 0) {
                                        divsTot[kDivTot].innerHTML = "<span " + (valor_total_columna < 0 ? "style='color:red;'" : "") + ">" + valor_total_columna + "&nbsp;</span>";
                                        console.log('valor_total_columna: ' + valor_total_columna);
                                    }
                                }
                            }
                        }

                    }
                }
            }
        }





    </script>
    

    <style type="text/css">
        .negativo {
            color: red;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table cellpadding="0" cellspacing="0" border="0" width="600px">
        <tr>
            <td><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Captura de Pronostico Anual")%></span>
                <hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td>
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td><%=TranslateLocale.text("Pronostico de")%>:</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:DropDownList ID="ddlReporte" runat="server" Width="350px" AutoPostBack="true">
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr id="trEmpresa" runat="server" visible="false">
                        <td><%=TranslateLocale.text("Empresa")%>:</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:DropDownList ID="ddlEmpresa" runat="server" Width="350px"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Año")%>:</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:DropDownList ID="ddlAnio" runat="server" Width="105px"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" align="right">
                            <div style="height:7px"></div>
                            <asp:Button ID="btnContinuar" runat="server" Text="Continuar" OnClientClick="this.disabled = true; this.value = 'Guardando...';$('.total_fibras').removeProp('disabled');$('.total_hornos').removeProp('disabled');" UseSubmitBehavior="false" />&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnCancelar" runat="server" Text="Salir" />
                            <asp:TextBox ID="txtEstado" runat="server" Text="0" Visible="false"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                       <td colspan="5">
                           <asp:Label ID="lblMensajeEstatus" runat="server" style="font-size: 14px; font-weight: bold; color:red;"></asp:Label>
                       </td>
                    </tr>
                </table>

            </td>
        </tr>
        <tr>
            <td><br /><hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td>
                <div id="divCaptura" runat="server" visible="false">
                    <span style="font-size:14px; font-weight:bold;"><%=TranslateLocale.text("Planeado por Concepto")%></span>
                
                    <asp:GridView ID="gvCaptura" runat="server" 
                                    AllowPaging="false" 
                                    AllowSorting="false" 
                                    AutoGenerateColumns="false"
                                    Width="600px">
                        <Columns>
                            <asp:BoundField HeaderText="Descripción" DataField="descripcion" HeaderStyle-Font-Bold="true" />
                            <asp:TemplateField HeaderText="Plan Fibras" HeaderStyle-Font-Bold="true" ItemStyle-Width="80px">
                                <ItemTemplate>
                                    <div style="padding-left:6px;">
                                        <asp:TextBox ID="txtIdConcepto" runat="server" Visible="false" Text='<%# Eval("id_concepto")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtImporte01" runat="server" Text='<%# Eval("monto1")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura") = "1", "true", "false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);" CssClass="total_fibras"></asp:TextBox>
                                        <div id="divImporte01" runat="server"><asp:Label ID="lblImporte1" runat="server" Text='<%# Format(Eval("monto1"), "###,###,##0")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto1") < 0, "negativo", "")%>'></asp:Label></div>
                                        <asp:TextBox ID="txtPermiteCaptura" runat="server" Visible="false" Text='<%# Eval("permite_captura")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtEsSeparador" runat="server" Visible="false" Text='<%# Eval("es_separador")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtEsHornos" runat="server" Visible="false" Text='<%# Eval("es_hornos")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtEsFibras" runat="server" Visible="false" Text='<%# Eval("es_fibras")%>'></asp:TextBox>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Plan Hornos" HeaderStyle-Font-Bold="true" ItemStyle-Width="80px">
                                <ItemTemplate>
                                    <div style="padding-left:6px;">
                                        <asp:TextBox ID="txtImporte02" runat="server" Text='<%# Eval("monto2")%>' Width="65px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                        <div id="divImporte02" runat="server"><asp:Label ID="lblImporte2" runat="server" Text='<%# Format(Eval("monto2"), "###,###,##0")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto2") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Consolidado" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div align="right" id="divImporteTotal" runat="server"><asp:Label ID="lblTotales" runat="server" Text='<%# Format(Eval("monto_total"), "###,###,##0")%>' Visible='<%# IIf(Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto_total") < 0, "negativo", "")%>'></asp:Label>&nbsp;</div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Distribución" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div align="center"><asp:LinkButton ID="lnkDistribucion" runat="server" Text='<%# Eval("tipo_distribucion")%>' Visible='<%# IIf(Eval("es_separador") = "1", "false", "true")%>' CommandName="Distribucion" CommandArgument='<%# Eval("id_concepto") & "|" & Eval("descripcion")%>'></asp:LinkButton>&nbsp;</div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>


                    <asp:GridView ID="gvCapturaER" runat="server" 
                                    AllowPaging="false" 
                                    AllowSorting="false" 
                                    AutoGenerateColumns="false"
                                    Width="900px" Visible="false">
                        <Columns>
                            <asp:BoundField HeaderText="Descripción" DataField="descripcion" HeaderStyle-Font-Bold="true" />
                            <asp:TemplateField HeaderText="Plan Fibras" HeaderStyle-Font-Bold="true" ItemStyle-Width="80px">
                                <ItemTemplate>
                                    <div style="padding-left:6px;">
                                        <asp:TextBox ID="txtIdConcepto" runat="server" Visible="false" Text='<%# Eval("id_concepto")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtImporte01" runat="server" Text='<%# Eval("monto1")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);" CssClass="total_fibras" disabled></asp:TextBox>
                                        <div id="divImporte01" runat="server"><asp:Label ID="lblImporte1" runat="server" Text='<%# Format(Eval("monto1"), "###,###,##0")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto1") < 0, "negativo", "")%> div_total_fibras'></asp:Label></div>
                                        <asp:TextBox ID="txtPermiteCaptura" runat="server" Visible="false" Text='<%# Eval("permite_captura")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtEsSeparador" runat="server" Visible="false" Text='<%# Eval("es_separador")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtEsHornos" runat="server" Visible="false" Text='<%# Eval("es_hornos")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtEsFibras" runat="server" Visible="false" Text='<%# Eval("es_fibras")%>'></asp:TextBox>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Plan Hornos" HeaderStyle-Font-Bold="true" ItemStyle-Width="80px">
                                <ItemTemplate>
                                    <div style="padding-left:6px;">
                                        <asp:TextBox ID="txtImporte02" runat="server" Text='<%# Eval("monto2")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);" CssClass="total_hornos" disabled></asp:TextBox>
                                        <div id="divImporte02" runat="server"><asp:Label ID="lblImporte2" runat="server" Text='<%# Format(Eval("monto2"), "###,###,##0")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto2") < 0, "negativo", "")%> div_total_fibras'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Consolidado" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div align="right" id="divImporteTotal" runat="server"><asp:Label ID="lblTotales" runat="server" Text='<%# Format(Eval("monto_total"), "###,###,##0")%>' Visible='<%# IIf(Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto_total") < 0, "negativo", "")%>'></asp:Label>&nbsp;</div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Plan NF" HeaderStyle-Font-Bold="true" ItemStyle-Width="70px">
                                <ItemTemplate>
                                    <div style="padding-left:6px;">
                                        <asp:TextBox ID="txtImporte03" runat="server" Text='<%#Format(Eval("monto3"), "###,###,##0")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                        <div id="divImporte03" runat="server"><asp:Label ID="lblImporte3" runat="server" Text='<%# Format(Eval("monto3"), "###,###,##0")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto3") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                           <asp:TemplateField HeaderText="Plan NE" HeaderStyle-Font-Bold="true" ItemStyle-Width="70px">
                                <ItemTemplate>
                                    <div style="padding-left:6px;">
                                        <asp:TextBox ID="txtImporte04" runat="server" Text='<%# Eval("monto4")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                        <div id="divImporte04" runat="server"><asp:Label ID="lblImporte4" runat="server" Text='<%# Format(Eval("monto4"), "###,###,##0")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto4") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                           <asp:TemplateField HeaderText="Plan NFV" HeaderStyle-Font-Bold="true" ItemStyle-Width="70px">
                                <ItemTemplate>
                                    <div style="padding-left:6px;">
                                        <asp:TextBox ID="txtImporte05" runat="server" Text='<%# Eval("monto5")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                        <div id="divImporte05" runat="server"><asp:Label ID="lblImporte5" runat="server" Text='<%# Format(Eval("monto5"), "###,###,##0")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto5") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                           <asp:TemplateField HeaderText="Plan NP" HeaderStyle-Font-Bold="true" ItemStyle-Width="70px">
                                <ItemTemplate>
                                    <div style="padding-left:6px;">
                                        <asp:TextBox ID="txtImporte06" runat="server" Text='<%# Eval("monto6")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                        <div id="divImporte06" runat="server"><asp:Label ID="lblImporte6" runat="server" Text='<%# Format(Eval("monto6"), "###,###,##0")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto6") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                           <asp:TemplateField HeaderText="Plan NI" HeaderStyle-Font-Bold="true" ItemStyle-Width="70px">
                                <ItemTemplate>
                                    <div style="padding-left:6px;">
                                        <asp:TextBox ID="txtImporte07" runat="server" Text='<%# Eval("monto7")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                        <div id="divImporte07" runat="server"><asp:Label ID="lblImporte7" runat="server" Text='<%# Format(Eval("monto7"), "###,###,##0")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto7") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                           <asp:TemplateField HeaderText="Plan NB" HeaderStyle-Font-Bold="true" ItemStyle-Width="70px">
                                <ItemTemplate>
                                    <div style="padding-left:6px;">
                                        <asp:TextBox ID="txtImporte08" runat="server" Text='<%# Eval("monto8")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                        <div id="divImporte08" runat="server"><asp:Label ID="lblImporte8" runat="server" Text='<%# Format(Eval("monto8"), "###,###,##0")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto8") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                           <asp:TemplateField HeaderText="Plan NBA" HeaderStyle-Font-Bold="true" ItemStyle-Width="70px">
                                <ItemTemplate>
                                    <div style="padding-left:6px;">
                                        <asp:TextBox ID="txtImporte09" runat="server" Text='<%# Eval("monto9")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                        <div id="divImporte09" runat="server"><asp:Label ID="lblImporte9" runat="server" Text='<%# Format(Eval("monto9"), "###,###,##0")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto9") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Plan NUSA" HeaderStyle-Font-Bold="true" ItemStyle-Width="70px">
                                <ItemTemplate>
                                    <div style="padding-left:6px;">
                                        <asp:TextBox ID="txtImporte10" runat="server" Text='<%# Eval("monto10")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura") = "1", "true", "false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                        <div id="divImporte10" runat="server"><asp:Label ID="lblImporte10" runat="server" Text='<%# Format(Eval("monto10"), "###,###,##0")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto10") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Plan NPC" HeaderStyle-Font-Bold="true" ItemStyle-Width="70px">
                                <ItemTemplate>
                                    <div style="padding-left:6px;">
                                        <asp:TextBox ID="txtImporte11" runat="server" Text='<%# Eval("monto11")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                        <div id="divImporte11" runat="server"><asp:Label ID="lblImporte11" runat="server" Text='<%# Format(Eval("monto11"), "###,###,##0")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto11") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>



                    <asp:GridView ID="gvCapturaERIndividual" runat="server" 
                                    AllowPaging="false" 
                                    AllowSorting="false" 
                                    AutoGenerateColumns="false"
                                    Width="900px" Visible="false">
                        <Columns>
                            <asp:BoundField HeaderText="Descripción" DataField="descripcion" HeaderStyle-Font-Bold="true" />
                            <asp:TemplateField HeaderText="Plan" HeaderStyle-Font-Bold="true" ItemStyle-Width="80px">
                                <ItemTemplate>
                                    <div style="padding-left:6px;">
                                        <asp:TextBox ID="txtIdConcepto" runat="server" Visible="false" Text='<%# Eval("id_concepto")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtImporte01" runat="server" Text='<%# Eval("monto1")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                        <div id="divImporte01" runat="server"><asp:Label ID="lblImporte1" runat="server" Text='<%# Format(Eval("monto1"), "###,###,##0")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto1") < 0, "negativo", "")%>'></asp:Label></div>
                                        <asp:TextBox ID="txtPermiteCaptura" runat="server" Visible="false" Text='<%# Eval("permite_captura")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtEsSeparador" runat="server" Visible="false" Text='<%# Eval("es_separador")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtEsHornos" runat="server" Visible="false" Text='<%# Eval("es_hornos")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtEsFibras" runat="server" Visible="false" Text='<%# Eval("es_fibras")%>'></asp:TextBox>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>





                    
                    <asp:GridView ID="gvCapturaExtendido" runat="server" 
                                    AllowPaging="false" 
                                    AllowSorting="false" 
                                    AutoGenerateColumns="false"
                                    Width="700px">
                        <Columns>
                            <asp:BoundField HeaderText="Clave" DataField="clave" HeaderStyle-Font-Bold="true" />
                            <asp:BoundField HeaderText="Descripción" DataField="descripcion" HeaderStyle-Font-Bold="true" />

                            <asp:TemplateField HeaderText="Fibra" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte01" runat="server" Text='<%# Eval("monto1")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                        <div id="divImporte01" runat="server"><asp:Label ID="lblImporte01" runat="server" Text='<%# Eval("monto1")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto1") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="FV" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte02" runat="server" Text='<%# Eval("monto2")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                        <div id="divImporte02" runat="server"><asp:Label ID="lblImporte02" runat="server" Text='<%# Eval("monto2")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto2") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="SAT" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte03" runat="server" Text='<%# Eval("monto3")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                        <div id="divImporte03" runat="server"><asp:Label ID="lblImporte03" runat="server" Text='<%# Eval("monto3")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto3") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Comercial" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte04" runat="server" Text='<%# Eval("monto4")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                        <div id="divImporte04" runat="server"><asp:Label ID="lblImporte04" runat="server" Text='<%# Eval("monto4")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto4") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>


                            <asp:TemplateField HeaderText="TOTAL" HeaderStyle-Font-Bold="true" ItemStyle-Width="80px">
                                <ItemTemplate>
                                    <div style="padding-left:6px;">
                                        <asp:TextBox ID="txtIdConcepto" runat="server" Visible="false" Text='<%# Eval("id_concepto")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtPermiteCaptura" runat="server" Visible="false" Text='<%# Eval("permite_captura")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtEsSeparador" runat="server" Visible="false" Text='<%# Eval("es_separador")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtAutollenado" runat="server" Visible="false" Text='<%# Eval("autollenado")%>'></asp:TextBox>

                                        <div align="right" id="divImporteTotal" runat="server"><asp:Label ID="lblTotales" runat="server" Text='<%# Format(Eval("monto"), "###,###,##0")%>' Visible='<%# IIf(Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto") < 0, "negativo", "")%>'></asp:Label>&nbsp;</div>

                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>






                </div>


                <div id="divDistribucion" runat="server" visible="false">
                    <table>
                        <tr>
                            <td colspan="4">
                                <b><%=TranslateLocale.text("Distribución del concepto")%>: <asp:Label ID="lblNombreConcepto" runat="server"></asp:Label></b>
                                <asp:TextBox ID="txtIdConcepto" runat="server" style="display:none;"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                            <td><asp:Label ID="lblFibras" runat="server" Text="FIBRAS"></asp:Label></td>
                            <td>&nbsp;</td>
                            <td><asp:Label ID="lblHornos" runat="server" Text="HORNOS"></asp:Label></td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Distribución automatica")%>:</td>
                            <td><asp:CheckBox ID="chkFibrasAuto" runat="server" Checked="true" CssClass="textoMontos" onclick="SeleccionAuto(1);" /></td>
                            <td>&nbsp;</td>
                            <td><asp:CheckBox ID="chkHornosAuto" runat="server" Checked="true" CssClass="textoMontos" onclick="SeleccionAuto(2);" /></td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Totales")%>:</td>
                            <td><asp:TextBox ID="txtFibrasTotal" runat="server" ReadOnly="true" CssClass="textoMontos"></asp:TextBox></td>
                            <td>&nbsp;</td>
                            <td><asp:TextBox ID="txtHornosTotal" runat="server" ReadOnly="true" CssClass="textoMontos"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Pendiente de Asignar")%>:</td>
                            <td><asp:TextBox ID="txtFibrasPorAsignar" runat="server" ReadOnly="true" CssClass="textoMontos"></asp:TextBox></td>
                            <td>&nbsp;</td>
                            <td><asp:TextBox ID="txtHornosPorAsignar" runat="server" ReadOnly="true" CssClass="textoMontos"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Enero")%></td>
                            <td><asp:TextBox ID="txtFibrasMes1" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(1);"></asp:TextBox></td>
                            <td>&nbsp;</td>
                            <td><asp:TextBox ID="txtHornosMes1" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(2);"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Febrero")%></td>
                            <td><asp:TextBox ID="txtFibrasMes2" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(1);"></asp:TextBox></td>
                            <td>&nbsp;</td>
                            <td><asp:TextBox ID="txtHornosMes2" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(2);"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Marzo")%></td>
                            <td><asp:TextBox ID="txtFibrasMes3" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(1);"></asp:TextBox></td>
                            <td>&nbsp;</td>
                            <td><asp:TextBox ID="txtHornosMes3" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(2);"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Abril")%></td>
                            <td><asp:TextBox ID="txtFibrasMes4" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(1);"></asp:TextBox></td>
                            <td>&nbsp;</td>
                            <td><asp:TextBox ID="txtHornosMes4" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(2);"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Mayo")%></td>
                            <td><asp:TextBox ID="txtFibrasMes5" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(1);"></asp:TextBox></td>
                            <td>&nbsp;</td>
                            <td><asp:TextBox ID="txtHornosMes5" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(2);"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Junio")%></td>
                            <td><asp:TextBox ID="txtFibrasMes6" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(1);"></asp:TextBox></td>
                            <td>&nbsp;</td>
                            <td><asp:TextBox ID="txtHornosMes6" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(2);"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Julio")%></td>
                            <td><asp:TextBox ID="txtFibrasMes7" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(1);"></asp:TextBox></td>
                            <td>&nbsp;</td>
                            <td><asp:TextBox ID="txtHornosMes7" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(2);"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Agosto")%></td>
                            <td><asp:TextBox ID="txtFibrasMes8" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(1);"></asp:TextBox></td>
                            <td>&nbsp;</td>
                            <td><asp:TextBox ID="txtHornosMes8" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(2);"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Septiembre")%></td>
                            <td><asp:TextBox ID="txtFibrasMes9" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(1);"></asp:TextBox></td>
                            <td>&nbsp;</td>
                            <td><asp:TextBox ID="txtHornosMes9" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(2);"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Octubre")%></td>
                            <td><asp:TextBox ID="txtFibrasMes10" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(1);"></asp:TextBox></td>
                            <td>&nbsp;</td>
                            <td><asp:TextBox ID="txtHornosMes10" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(2);"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Noviembre")%></td>
                            <td><asp:TextBox ID="txtFibrasMes11" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(1);"></asp:TextBox></td>
                            <td>&nbsp;</td>
                            <td><asp:TextBox ID="txtHornosMes11" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(2);"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td><%=TranslateLocale.text("Diciembre")%></td>
                            <td><asp:TextBox ID="txtFibrasMes12" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(1);"></asp:TextBox></td>
                            <td>&nbsp;</td>
                            <td><asp:TextBox ID="txtHornosMes12" runat="server" CssClass="textoMontos" Text="0" onblur="CalculaTotales(2);"></asp:TextBox></td>
                        </tr>
                        <tr>
                            <td colspan="4" align="right">
                                <asp:Button ID="btnGuardaDistribucion" runat="server" Text="Guardar" OnClientClick="return GuardaDistribucion_OnClientClick();" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                <asp:Button ID="btnRegresar" runat="server" Text="Regresar" />
                            </td>
                        </tr>
                    </table>


                </div>


            </td>
        </tr>
    </table>

<asp:TextBox ID="txtEstatus" runat="server" style="display:none;"></asp:TextBox>
</asp:Content>

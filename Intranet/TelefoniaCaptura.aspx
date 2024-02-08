<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="TelefoniaCaptura.aspx.vb" Inherits="Intranet.TelefoniaCaptura" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
            if (id_reporte == 1) {
                RecalculaTotales_BalanceGeneral(control);
            } else if (id_reporte == 2) {
                RecalculaTotales_EstadoResultados(control);
            } else if (id_reporte == 3) {
                RecalculaTotales_FlujoEfectivo(control);
            } else if (id_reporte == 4) {
                RecalculaTotales_PedidosFacturacion(control);
            } else if (id_reporte == 9) {
                RecalculaTotales_Headcount(control);
            } else if (id_reporte == 10) {
                RecalculaTotales_CuardeIntercompanies(control);
            }
        }

        function ValidaCaptura(){
            var combo = document.getElementById('<%=ddlReporte.ClientID%>');
            var id_reporte = combo.options[combo.selectedIndex].value;
            var grid = document.getElementById("<%= gvCapturaCuadreInter.ClientID %>");
            if (id_reporte == 10 && grid != null) {

                var elementos_capturados = grid.rows[(grid.rows.length-2)].getElementsByTagName('div');
                var elementos_referencia = grid.rows[(grid.rows.length-1)].getElementsByTagName('div');

                var cap_ac_cp = 0;
                var cap_ac_lp = 0;
                var cap_ap_cp = 0;
                var cap_ap_lp = 0;

                var ref_ac_cp = 0;
                var ref_ac_lp = 0;
                var ref_ap_cp = 0;
                var ref_ap_lp = 0;

                for (var j = 0; j < elementos_capturados.length; j++) {
                    if (elementos_capturados[j].id.indexOf("divImporte01") >= 0) { cap_ac_cp = elementos_capturados[j].innerHTML;}
                    if (elementos_capturados[j].id.indexOf("divImporte02") >= 0) { cap_ac_lp = elementos_capturados[j].innerHTML;}
                    if (elementos_capturados[j].id.indexOf("divImporte03") >= 0) { cap_ap_cp = elementos_capturados[j].innerHTML;}
                    if (elementos_capturados[j].id.indexOf("divImporte04") >= 0) { cap_ap_lp = elementos_capturados[j].innerHTML;}
                }

                for (var j = 0; j < elementos_referencia.length; j++) {
                    if (elementos_referencia[j].id.indexOf("divImporte01") >= 0) { ref_ac_cp = elementos_referencia[j].innerHTML;}
                    if (elementos_referencia[j].id.indexOf("divImporte02") >= 0) { ref_ac_lp = elementos_referencia[j].innerHTML;}
                    if (elementos_referencia[j].id.indexOf("divImporte03") >= 0) { ref_ap_cp = elementos_referencia[j].innerHTML;}
                    if (elementos_referencia[j].id.indexOf("divImporte04") >= 0) { ref_ap_lp = elementos_referencia[j].innerHTML;}
                }

                var pos=0;
                if(cap_ac_cp.indexOf('</span>') >= 0) {
                    cap_ac_cp = cap_ac_cp.replace("</span>",""); 
                    cap_ac_cp = cap_ac_cp.substring(cap_ac_cp.indexOf('lblImporte01">')+14, cap_ac_cp.length);
                }
                if(cap_ac_lp.indexOf('</span>') >= 0) {
                    cap_ac_lp = cap_ac_lp.replace("</span>",""); 
                    cap_ac_lp = cap_ac_lp.substring(cap_ac_lp.indexOf('lblImporte02">')+14, cap_ac_lp.length);
                }
                if(cap_ap_cp.indexOf('</span>') >= 0) {
                    cap_ap_cp = cap_ap_cp.replace("</span>",""); 
                    cap_ap_cp = cap_ap_cp.substring(cap_ap_cp.indexOf('lblImporte03">')+14, cap_ap_cp.length);
                }
                if(cap_ap_lp.indexOf('</span>') >= 0) {
                    cap_ap_lp = cap_ap_lp.replace("</span>",""); 
                    cap_ap_lp = cap_ap_lp.substring(cap_ap_lp.indexOf('lblImporte04">')+14, cap_ap_lp.length);
                }

                if(cap_ac_cp.indexOf('</SPAN>') >= 0) {
                    cap_ac_cp = cap_ac_cp.replace("</SPAN>",""); 
                    cap_ac_cp = cap_ac_cp.substring(cap_ac_cp.indexOf('lblImporte01>')+13, cap_ac_cp.length);
                }
                if(cap_ac_lp.indexOf('</SPAN>') >= 0) {
                    cap_ac_lp = cap_ac_lp.replace("</SPAN>",""); 
                    cap_ac_lp = cap_ac_lp.substring(cap_ac_lp.indexOf('lblImporte02>')+13, cap_ac_lp.length);
                }
                if(cap_ap_cp.indexOf('</SPAN>') >= 0) {
                    cap_ap_cp = cap_ap_cp.replace("</SPAN>",""); 
                    cap_ap_cp = cap_ap_cp.substring(cap_ap_cp.indexOf('lblImporte03>')+13, cap_ap_cp.length);
                }
                if(cap_ap_lp.indexOf('</SPAN>') >= 0) {
                    cap_ap_lp = cap_ap_lp.replace("</SPAN>",""); 
                    cap_ap_lp = cap_ap_lp.substring(cap_ap_lp.indexOf('lblImporte04>')+13, cap_ap_lp.length);
                }

                ref_ac_cp = ref_ac_cp.replace("</span>","");
                ref_ac_cp = ref_ac_cp.replace("</SPAN>","");
                if(ref_ac_cp.indexOf('lblImporte01">')>0) { ref_ac_cp = ref_ac_cp.substring(ref_ac_cp.indexOf('lblImporte01">')+14, ref_ac_cp.length); }
                if(ref_ac_cp.indexOf('lblImporte01>')>0) { ref_ac_cp = ref_ac_cp.substring(ref_ac_cp.indexOf('lblImporte01>')+13, ref_ac_cp.length); }
                
                ref_ac_lp = ref_ac_lp.replace("</span>","");
                ref_ac_lp = ref_ac_lp.replace("</SPAN>","");
                if(ref_ac_lp.indexOf('lblImporte02">')>0) { ref_ac_lp = ref_ac_lp.substring(ref_ac_lp.indexOf('lblImporte02">')+14, ref_ac_lp.length); }
                if(ref_ac_lp.indexOf('lblImporte02>')>0) { ref_ac_lp = ref_ac_lp.substring(ref_ac_lp.indexOf('lblImporte02>')+13, ref_ac_lp.length); }
                
                ref_ap_cp = ref_ap_cp.replace("</span>","");
                ref_ap_cp = ref_ap_cp.replace("</SPAN>","");
                if(ref_ap_cp.indexOf('lblImporte03">')>0) { ref_ap_cp = ref_ap_cp.substring(ref_ap_cp.indexOf('lblImporte03">')+14, ref_ap_cp.length); }
                if(ref_ap_cp.indexOf('lblImporte03>')>0) { ref_ap_cp = ref_ap_cp.substring(ref_ap_cp.indexOf('lblImporte03>')+13, ref_ap_cp.length); }

                ref_ap_lp = ref_ap_lp.replace("</span>","");
                ref_ap_lp = ref_ap_lp.replace("</SPAN>","");
                if(ref_ap_lp.indexOf('lblImporte04">')>0) { ref_ap_lp = ref_ap_lp.substring(ref_ap_lp.indexOf('lblImporte04">')+14, ref_ap_lp.length); }
                if(ref_ap_lp.indexOf('lblImporte04>')>0) { ref_ap_lp = ref_ap_lp.substring(ref_ap_lp.indexOf('lblImporte04>')+13, ref_ap_lp.length); }


                var msg='';
                if(parseFloat(cap_ac_cp) != parseFloat(ref_ac_cp)) { msg += 'Afil. x Cob CP no coincide con el Balance General: ' + cap_ac_cp + ' / ' + ref_ac_cp + '\n'; }
                if(parseFloat(cap_ac_lp) != parseFloat(ref_ac_lp)) { msg += 'Afil. x Cob LP no coincide con el Balance General: ' + cap_ac_lp + ' / ' + ref_ac_lp + '\n'; }
                if(parseFloat(cap_ap_cp) != parseFloat(ref_ap_cp)) { msg += 'Afil. x Pag CP no coincide con el Balance General: ' + cap_ap_cp + ' / ' + ref_ap_cp + '\n'; }
                if(parseFloat(cap_ap_lp) != parseFloat(ref_ap_lp)) { msg += 'Afil. x Pag LP no coincide con el Balance General: ' + cap_ap_lp + ' / ' + ref_ap_lp + '\n'; }

                if(msg.length>0){
                    alert('Favor de corregir las siguientes diferencias:\n\n' + msg);
                    return false;
                }

                return true;
            }
            return true;
        }

        <%
        If Me.ddlReporte.SelectedValue = 1 Then
%>
        function RecalculaTotales_BalanceGeneral(control) {
            if (!isNumber(control.value)) { control.value = "0"; }

            var grid = document.getElementById("<%= gvCaptura.ClientID %>");
            var totales = new Array(10, 13, 16, 25, 29, 35, 36);
            var elementos_suman1 = new Array(1, 2, 3, 4, 5, 6, 7, 8, 9);
            var elementos_suman2 = new Array(0, 11);
            var elementos_restan2 = new Array(0, 12);
            var elementos_suman3 = new Array(1, 2, 3, 4, 5, 6, 7, 8, 9, 11, 14, 15);
            var elementos_restan3 = new Array(0, 12);
            var elementos_suman4 = new Array(16, 17, 18, 19, 20, 21, 22, 23, 24);
            var elementos_suman5 = new Array(16, 17, 18, 19, 20, 21, 22, 23, 24, 26, 27, 28);
            var elementos_suman6 = new Array(30, 31, 32, 33, 34);
            var elementos_suman7 = new Array(16, 17, 18, 19, 20, 21, 22, 23, 24, 26, 27, 28, 30, 31, 32, 33, 34);

            if (grid.rows.length > 0) {
                var monto_calculado = 0;
                var totalesacalcular = 0;
                var monto_calculado1 = 0;
                var monto_calculado2 = 0;
                var monto_calculado3 = 0;
                var monto_calculado4 = 0;
                var monto_calculado5 = 0;
                var monto_calculado6 = 0;
                var monto_calculado7 = 0;
                var totales1 = 0;
                var totales2 = 0;
                for (iFila = 1; iFila < grid.rows.length; iFila++) {

                    var elementos = grid.rows[iFila].getElementsByTagName('input');
                    for (var j = 0; j < elementos.length; j++) {

                        if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte") >= 0) {
                            var valor = elementos[j].value;

                            if (existe(elementos_suman1, iFila)) {
                                monto_calculado1 += parseInt(valor);
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
                            if (existe(elementos_suman5, iFila)) {
                                monto_calculado5 += parseInt(valor);
                            }
                            if (existe(elementos_suman6, iFila)) {
                                monto_calculado6 += parseInt(valor);
                            }
                            if (existe(elementos_suman7, iFila)) {
                                monto_calculado7 += parseInt(valor);
                            }
                        }
                    }

                    if (totales[totalesacalcular] == iFila) {
                        var divs = grid.rows[iFila].getElementsByTagName('div')
                        for (var kDiv = 0; kDiv < divs.length; kDiv++) {
                            if (divs[kDiv].id.indexOf("divImporte") >= 0) {
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
                            }
                        }
                        if (totalesacalcular == 0) { totales1 = monto_calculado; }
                        else if (totalesacalcular == 1) { totales2 = monto_calculado; }
                        monto_calculado = 0;
                        totalesacalcular += 1;
                    }
                }
            }
        }

<%
        ElseIf Me.ddlReporte.SelectedValue = 2 Then
%>



        function RecalculaTotales_EstadoResultados(control) {
            if (!isNumber(control.value)) { control.value = "0"; }

            var grid = document.getElementById("<%= gvCaptura.ClientID %>");
            var totales = new Array(4, 7, 9, 13, 15, 18, 20);
            var elementos_suman1 = new Array(0, 1);
            var elementos_restan1 = new Array(2, 3);
            var elementos_suman2 = new Array(0, 1);
            var elementos_restan2 = new Array(2, 3, 5, 6);
            var elementos_suman3 = new Array(0, 1);
            var elementos_restan3 = new Array(2, 3, 5, 6, 8);
            var elementos_suman4 = new Array(1, 10);
            var elementos_restan4 = new Array(2, 3, 5, 6, 8, 11, 12);
            var elementos_suman5 = new Array(1, 10);
            var elementos_restan5 = new Array(2, 3, 5, 6, 8, 11, 12, 14);
            var elementos_suman6 = new Array(1, 10);
            var elementos_restan6 = new Array(2, 3, 5, 6, 8, 11, 12, 14, 16, 17);
            var elementos_suman7 = new Array(0, 1, 19);
            var elementos_restan7 = new Array(2, 3, 5, 6, 11);

            if (grid.rows.length > 0) {
                var monto_calculado = 0;
                var totalesacalcular = 0;
                var monto_calculado1 = 0;
                var monto_calculado2 = 0;
                var monto_calculado3 = 0;
                var monto_calculado4 = 0;
                var monto_calculado5 = 0;
                var monto_calculado6 = 0;
                var monto_calculado7 = 0;
                for (iFila = 1; iFila < grid.rows.length; iFila++) {

                    var elementos = grid.rows[iFila].getElementsByTagName('input');
                    for (var j = 0; j < elementos.length; j++) {

                        if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte") >= 0) {
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
                        }
                    }

                    if (totales[totalesacalcular] == iFila) {
                        var divs = grid.rows[iFila].getElementsByTagName('div')
                        for (var kDiv = 0; kDiv < divs.length; kDiv++) {
                            if (divs[kDiv].id.indexOf("divImporte") >= 0) {
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
                            }
                        }
                        /*
                        if (totalesacalcular == 0) { totales1 = monto_calculado; }
                        else if (totalesacalcular == 1) { totales2 = monto_calculado; }*/
                        monto_calculado = 0;
                        totalesacalcular += 1;
                    }
                }
            }
        }





<%
    ElseIf Me.ddlReporte.SelectedValue = 3 Then
%>



        function RecalculaTotales_FlujoEfectivo(control) {
            if (!isNumber(control.value)) { control.value = "0"; }

            var grid = document.getElementById("<%= gvCaptura.ClientID %>");
            var totales = new Array(8, 16, 18, 19);
            var elementos_suman1 = new Array(1, 2, 3, 4, 5, 6, 7);
            var elementos_suman2 = new Array(9, 10, 11, 12, 13, 14, 15);
            var elementos_suman3 = new Array(1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15, 17);
            var elementos_suman4 = new Array(1, 2, 3, 4, 5, 6, 7, 9, 10, 11, 12, 13, 14, 15);

            if (grid.rows.length > 0) {
                var monto_calculado = 0;
                var totalesacalcular = 0;
                var monto_calculado1 = 0;
                var monto_calculado2 = 0;
                var monto_calculado3 = 0;
                var monto_calculado4 = 0;
                for (iFila = 1; iFila < grid.rows.length; iFila++) {

                    var elementos = grid.rows[iFila].getElementsByTagName('input');
                    for (var j = 0; j < elementos.length; j++) {

                        if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte") >= 0) {
                            var valor = elementos[j].value;

                            if (existe(elementos_suman1, iFila)) {
                                monto_calculado1 += parseInt(valor);
                            }
                            if (existe(elementos_suman2, iFila)) {
                                monto_calculado2 += parseInt(valor);
                            }
                            if (existe(elementos_suman3, iFila)) {
                                monto_calculado3 += parseInt(valor);
                            }
                            if (existe(elementos_suman4, iFila)) {
                                monto_calculado4 += parseInt(valor);
                            }
                        }
                    }

                    if (totales[totalesacalcular] == iFila) {
                        var divs = grid.rows[iFila].getElementsByTagName('div')
                        for (var kDiv = 0; kDiv < divs.length; kDiv++) {
                            if (divs[kDiv].id.indexOf("divImporte") >= 0) {
                                if (totalesacalcular == 0)
                                    divs[kDiv].innerHTML = "<span " + (monto_calculado1 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado1 + "&nbsp;</span>";
                                else if (totalesacalcular == 1)
                                    divs[kDiv].innerHTML = "<span " + (monto_calculado2 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado2 + "&nbsp;</span>";
                                else if (totalesacalcular == 2)
                                    divs[kDiv].innerHTML = "<span " + (monto_calculado3 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado3 + "&nbsp;</span>";
                                else if (totalesacalcular == 3)
                                    divs[kDiv].innerHTML = "<span " + (monto_calculado4 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado4 + "&nbsp;</span>";
                            }
                        }
                        monto_calculado = 0;
                        totalesacalcular += 1;
                    }
                }
            }
        }



<%
    ElseIf Me.ddlReporte.SelectedValue = 9 Then
%>



        function RecalculaTotales_Headcount(control) {
            if (!isNumber(control.value)) { control.value = "0"; }

            var grid = document.getElementById("<%= gvCaptura.ClientID %>");
            var totales = new Array(5, 9, 11, 12, 17);
            var elementos_suman1 = new Array(2, 3, 4);
            var elementos_suman2 = new Array(7, 8);
            var elementos_suman3 = new Array(2, 3, 4, 7, 8);
            var elementos_suman4 = new Array(2, 3, 4, 7, 8, 10);
            var elementos_suman5 = new Array(14, 15, 16);

            if (grid.rows.length > 0) {
                var monto_calculado = 0;
                var totalesacalcular = 0;
                var monto_calculado1 = 0;
                var monto_calculado2 = 0;
                var monto_calculado3 = 0;
                var monto_calculado4 = 0;
                var monto_calculado5 = 0;
                for (iFila = 1; iFila < grid.rows.length; iFila++) {

                    var elementos = grid.rows[iFila].getElementsByTagName('input');
                    for (var j = 0; j < elementos.length; j++) {

                        if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte") >= 0) {
                            var valor = elementos[j].value;

                            if (existe(elementos_suman1, iFila)) {
                                monto_calculado1 += parseInt(valor);
                            }
                            if (existe(elementos_suman2, iFila)) {
                                monto_calculado2 += parseInt(valor);
                            }
                            if (existe(elementos_suman3, iFila)) {
                                monto_calculado3 += parseInt(valor);
                            }
                            if (existe(elementos_suman4, iFila)) {
                                monto_calculado4 += parseInt(valor);
                            }
                            if (existe(elementos_suman5, iFila)) {
                                monto_calculado5 += parseInt(valor);
                            }
                        }
                    }

                    if (totales[totalesacalcular] == iFila) {
                        var divs = grid.rows[iFila].getElementsByTagName('div')
                        for (var kDiv = 0; kDiv < divs.length; kDiv++) {
                            if (divs[kDiv].id.indexOf("divImporte") >= 0) {
                                if (totalesacalcular == 0)
                                    divs[kDiv].innerHTML = "<span " + (monto_calculado1 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado1 + "&nbsp;</span>";
                                else if (totalesacalcular == 1)
                                    divs[kDiv].innerHTML = "<span " + (monto_calculado2 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado2 + "&nbsp;</span>";
                                else if (totalesacalcular == 2)
                                    divs[kDiv].innerHTML = "<span " + (monto_calculado3 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado3 + "&nbsp;</span>";
                                else if (totalesacalcular == 3)
                                    divs[kDiv].innerHTML = "<span " + (monto_calculado4 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado4 + "&nbsp;</span>";
                                else if (totalesacalcular == 4)
                                    divs[kDiv].innerHTML = "<span " + (monto_calculado4 < 0 ? "style='color:red;'" : "") + ">" + monto_calculado5 + "&nbsp;</span>";
                            }
                        }
                        monto_calculado = 0;
                        totalesacalcular += 1;
                    }
                }
            }
        }




<%
        ElseIf Me.ddlReporte.SelectedValue = 4 Then
%>



        function RecalculaTotales_PedidosFacturacion(control) {
            if (!isNumber(control.value)) { control.value = "0"; }

            var grid = document.getElementById("<%= gvCaptura.ClientID %>");
            var totales = new Array(6, 7, 13, 14, 20, 21);
            var elementos_suman1 = new Array(2, 3, 4, 5);
            var elementos_restan1 = new Array(0);
            var elementos_suman2 = new Array(2, 3, 4, 5);
            var elementos_restan2 = new Array(0<%=RestanPyF(1)%>);
            var elementos_suman3 = new Array(9, 10, 11, 12);
            var elementos_restan3 = new Array(0);
            var elementos_suman4 = new Array(9, 10, 11, 12);
            var elementos_restan4 = new Array(0<%=RestanPyF(2)%>);
            var elementos_suman5 = new Array(16, 17, 18, 19);
            var elementos_restan5 = new Array(0);
            var elementos_suman6 = new Array(16, 17, 18, 19);
            var elementos_restan6 = new Array(0<%=RestanPyF(3) %>);

            if (grid.rows.length > 0) {
                var monto_calculado = 0;
                var totalesacalcular = 0;
                var monto_calculado1 = 0;
                var monto_calculado2 = 0;
                var monto_calculado3 = 0;
                var monto_calculado4 = 0;
                var monto_calculado5 = 0;
                var monto_calculado6 = 0;
                for (iFila = 1; iFila < grid.rows.length; iFila++) {

                    var elementos = grid.rows[iFila].getElementsByTagName('input');
                    for (var j = 0; j < elementos.length; j++) {

                        if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte") >= 0) {
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
                        }
                    }

                    if (totales[totalesacalcular] == iFila) {
                        var divs = grid.rows[iFila].getElementsByTagName('div')
                        for (var kDiv = 0; kDiv < divs.length; kDiv++) {
                            if (divs[kDiv].id.indexOf("divImporte") >= 0) {
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
                            }
                        }
                        /*
                        if (totalesacalcular == 0) { totales1 = monto_calculado; }
                        else if (totalesacalcular == 1) { totales2 = monto_calculado; }*/
                        monto_calculado = 0;
                        totalesacalcular += 1;
                    }
                }
            }
        }




<%
        ElseIf Me.ddlReporte.SelectedValue = 5 Then
%>
        function RecalculaTotales_PronosticoFlujoEfectivo(control) {
            if (!isNumber(control.value)) { control.value = "0"; }

            var grid = document.getElementById("<%= gvCapturaflujo.ClientID %>");   
            var totales = new Array(6, 16);
            var elementos_suman1 = new Array(2, 3, 4, 5);
            var elementos_suman2 = new Array(8, 9, 10, 11, 12, 13, 14, 15);
            var saldo_inicial = 0;
            var saldo_semanal = 0;

            if (grid.rows.length > 0) {
                for (columna = 0; columna <= 5; columna++) {
                    var monto_calculado = 0;
                    var totalesacalcular = 0;
                    var totales1 = 0;
                    var totales2 = 0;
                    var saldo_ini_valor = 0;
                    var saldo_fin_valor = 0;
                    for (iFila = 1; iFila < grid.rows.length; iFila++) {

                        var elementos = grid.rows[iFila].getElementsByTagName('input');
                        var valor_total_columna = 0;
                        for (var j = 0; j < elementos.length; j++) {
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte1") >= 0) { valor_total_columna += parseInt(elementos[j].value); if (iFila == 1) { saldo_ini_valor = parseInt(elementos[j].value); } }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte2") >= 0) { valor_total_columna += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte3") >= 0) { valor_total_columna += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte4") >= 0) { valor_total_columna += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte5") >= 0) { valor_total_columna += parseInt(elementos[j].value); }
                            var divsTot = grid.rows[iFila].getElementsByTagName('div')
                            for (var kDivTot = 0; kDivTot < divsTot.length; kDivTot++) {
                                if (divsTot[kDivTot].id.indexOf("divImporteTotal") >= 0) {
                                    if (iFila == 1) {
                                        divsTot[kDivTot].innerHTML = "<span " + (saldo_ini_valor < 0 ? "style='color:red;'" : "") + ">" + saldo_ini_valor + "&nbsp;</span>";
                                    }
                                    else {
                                        divsTot[kDivTot].innerHTML = "<span " + (valor_total_columna < 0 ? "style='color:red;'" : "") + ">" + valor_total_columna + "&nbsp;</span>";
                                    }
                                }
                            }


                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte" + columna) >= 0) {
                                var valor = elementos[j].value;

                                //Obtiene el saldo semanal
                                if (iFila == 1 && columna == 0) { saldo_inicial = parseInt(valor); }
                                else if (iFila == 1 && columna > 0) { elementos[j].value = saldo_semanal; valor = saldo_semanal; saldo_inicial = parseInt(valor); }


                                if (totalesacalcular == 0 && existe(elementos_suman1, iFila)) {
                                    monto_calculado += parseInt(valor);
                                } else if (totalesacalcular == 1 && existe(elementos_suman2, iFila)) {
                                    monto_calculado += parseInt(valor);
                                }
                            }
                        }

                        if (totales[totalesacalcular] == iFila) {
                            var divs = grid.rows[iFila].getElementsByTagName('div')
                            for (var kDiv = 0; kDiv < divs.length; kDiv++) {
                                if (divs[kDiv].id.indexOf("divImporte" + columna) >= 0) {
                                    divs[kDiv].innerHTML = monto_calculado;
                                }
                            }
                            if (totalesacalcular == 0) { totales1 = monto_calculado; }
                            else if (totalesacalcular == 1) { totales2 = monto_calculado; }
                            monto_calculado = 0;
                            totalesacalcular += 1;
                        }
                        if (iFila == 17) {
                            var divs = grid.rows[iFila].getElementsByTagName('div')
                            for (var kDiv = 0; kDiv < divs.length; kDiv++) {
                                if (divs[kDiv].id.indexOf("divImporte" + columna) >= 0) {
                                    var monto_div = (totales1 - totales2);
                                    divs[kDiv].innerHTML = "<span " + (monto_div < 0 ? "style='color:red;'" : "") + ">" + monto_div + "&nbsp;</span>";
                                    saldo_semanal = totales1 - totales2 + saldo_inicial;
                                }
                            }
                        } else if (iFila == 18) {
                            var divs = grid.rows[iFila].getElementsByTagName('div')
                            for (var kDiv = 0; kDiv < divs.length; kDiv++) {
                                if (divs[kDiv].id.indexOf("divImporte" + columna) >= 0) {
                                    var monto_div = (totales1 - totales2 + saldo_inicial);
                                    divs[kDiv].innerHTML = "<span " + (monto_div < 0 ? "style='color:red;'" : "") + ">" + monto_div + "&nbsp;</span>";
                                }
                            }
                        }
                    }
                }


                for (iFila = 1; iFila < grid.rows.length; iFila++) {
                    var divsTots = grid.rows[iFila].getElementsByTagName('div');
                    var valor_total_totales = 0;
                    var hayValores = false;
                    
                    if (iFila == 6 || iFila == 16 || iFila == 17 || iFila == 18) {
                        for (var j = 0; j < divsTots.length; j++) {
                            var valor_sin_formato = divsTots[j].innerHTML.replace('<span style="color:red;">', '').replace('<span>', '').replace('&nbsp;</span>', '');
                            if (divsTots[j].id.indexOf("divImporte1") >= 0) { valor_total_totales += parseInt(valor_sin_formato); hayValores = true; }
                            if (divsTots[j].id.indexOf("divImporte2") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }
                            if (divsTots[j].id.indexOf("divImporte3") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }
                            if (divsTots[j].id.indexOf("divImporte4") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }
                            if (divsTots[j].id.indexOf("divImporte5") >= 0) { valor_total_totales += parseInt(valor_sin_formato); if (iFila == 18) { saldo_fin_valor = parseInt(valor_sin_formato); } }


                            if (divsTots[j].id.indexOf("divImporteTotal") >= 0 && hayValores) {
                                if (iFila == 18) {
                                    divsTots[j].innerHTML = "<span " + (saldo_fin_valor < 0 ? "style='color:red;'" : "") + ">" + saldo_fin_valor + "&nbsp;</span>";
                                }
                                else {
                                    divsTots[j].innerHTML = "<span " + (valor_total_totales < 0 ? "style='color:red;'" : "") + ">" + valor_total_totales + "&nbsp;</span>";
                                }
                            }
                        }
                    }
                }
            }
        }


<%
        ElseIf Me.ddlReporte.SelectedValue = 7 Then
%>
        function RecalculaTotales_PerfilDeuda(control) {
            if (!isNumber(control.value)) { control.value = "0"; }

            var grid = document.getElementById("<%= gvCapturaDeuda.ClientID %>");
            
            var totales = new Array(<%=PerfilDeuda_Totales(Me.ddlEmpresa.SelectedValue)%>);
            var elementos_suman1 = new Array(<%=PerfilDeuda_Suman(Me.ddlEmpresa.SelectedValue)%>);
            var fila_totales = <%=PerfilDeuda_FilaTotales(Me.ddlEmpresa.SelectedValue)%>;

            var saldo_semanal = 0;

            if (grid.rows.length > 0) {
                for (columna = 1; columna <= 11; columna++) {
                    var monto_calculado = 0;
                    var totalesacalcular = 0;
                    var totales1 = 0;
                    var totales2 = 0;
                    for (iFila = 1; iFila < grid.rows.length; iFila++) {

                        var elementos = grid.rows[iFila].getElementsByTagName('input');
                        var valor_total_columna = 0;
                        for (var j = 0; j < elementos.length; j++) {
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte01") >= 0)  { valor_total_columna += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte02") >= 0)  { valor_total_columna += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte03") >= 0)  { valor_total_columna += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte04") >= 0)  { valor_total_columna += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte05") >= 0)  { valor_total_columna += parseInt(elementos[j].value); }

                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte07") >= 0)  { valor_total_columna += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte08") >= 0)  { valor_total_columna += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte09") >= 0)  { valor_total_columna += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte10") >= 0)  { valor_total_columna += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte11") >= 0) { valor_total_columna += parseInt(elementos[j].value); }

                            var divsTot = grid.rows[iFila].getElementsByTagName('div')
                            for (var kDivTot = 0; kDivTot < divsTot.length; kDivTot++) {
                                if (divsTot[kDivTot].id.indexOf("divImporteTotal") >= 0) {
                                    divsTot[kDivTot].innerHTML = "<span " + (valor_total_columna < 0 ? "style='color:red;'" : "") + ">" + valor_total_columna + "&nbsp;</span>";
                                }
                            }

                            var nombre_campo_txt = "txtImporte";
                            if(columna<10){nombre_campo_txt = "txtImporte0";}

                            if (elementos[j].type == 'text' && elementos[j].id.indexOf(nombre_campo_txt + columna) >= 0) {
                                var valor = elementos[j].value;

                                if (totalesacalcular == 0 && existe(elementos_suman1, iFila)) {
                                    monto_calculado += parseInt(valor);
                                }
                            }
                        }

                        if (totales[totalesacalcular] == iFila) {
                            var divs = grid.rows[iFila].getElementsByTagName('div')
                            for (var kDiv = 0; kDiv < divs.length; kDiv++) {
                                var nombre_campo_div = "divImporte";
                                if(columna<10){nombre_campo_div = "divImporte0";}

                                if (divs[kDiv].id.indexOf(nombre_campo_div + columna) >= 0) {
                                    divs[kDiv].innerHTML = monto_calculado;
                                }
                            }
                            if (totalesacalcular == 0) { totales1 = monto_calculado; }
                            else if (totalesacalcular == 1) { totales2 = monto_calculado; }
                            monto_calculado = 0;
                            totalesacalcular += 1;
                        }
                    }
                }


                for (iFila = 1; iFila < grid.rows.length; iFila++) {
                    var divsTots = grid.rows[iFila].getElementsByTagName('div');
                    var valor_total_totales = 0;
                    var hayValores = false;

                    if (iFila == fila_totales) {
                        for (var j = 0; j < divsTots.length; j++) {
                            var valor_sin_formato = divsTots[j].innerHTML.replace('<span style="color:red;">', '').replace('<span>', '').replace('&nbsp;</span>', '');
                            if (divsTots[j].id.indexOf("divImporte01") >= 0) { valor_total_totales += parseInt(valor_sin_formato); hayValores = true; }
                            if (divsTots[j].id.indexOf("divImporte02") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }
                            if (divsTots[j].id.indexOf("divImporte03") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }
                            if (divsTots[j].id.indexOf("divImporte04") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }
                            if (divsTots[j].id.indexOf("divImporte05") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }

                            if (divsTots[j].id.indexOf("divImporte07") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }
                            if (divsTots[j].id.indexOf("divImporte08") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }
                            if (divsTots[j].id.indexOf("divImporte09") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }
                            if (divsTots[j].id.indexOf("divImporte10") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }
                            if (divsTots[j].id.indexOf("divImporte11") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }

                            if (divsTots[j].id.indexOf("divImporteTotal") >= 0 && hayValores) {
                                divsTots[j].innerHTML = "<span " + (valor_total_totales < 0 ? "style='color:red;'" : "") + ">" + valor_total_totales + "&nbsp;</span>";
                            }
                        }
                    }
                }
            }
        }

        <%
    ElseIf Me.ddlReporte.SelectedValue = 10 Then
%>
        function RecalculaTotales_CuardeIntercompanies(control) {
            if (!isNumber(control.value)) { control.value = "0"; }

            var grid = document.getElementById("<%= gvCapturaCuadreInter.ClientID %>");
            
            var totales = new Array(8,0);
            var elementos_suman1 = new Array(1, 2, 3, 4, 5, 6, 7);
            var fila_totales = 8;

            var saldo_semanal = 0;

            if (grid.rows.length > 0) {
                for (columna = 1; columna <= 4; columna++) {
                    var monto_calculado = 0;
                    var totalesacalcular = 0;
                    var totales1 = 0;
                    var totales2 = 0;
                    for (iFila = 1; iFila < grid.rows.length; iFila++) {

                        var elementos = grid.rows[iFila].getElementsByTagName('input');
                        var valor_total_columna = 0;
                        for (var j = 0; j < elementos.length; j++) {
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte01") >= 0)  { valor_total_columna += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte02") >= 0)  { valor_total_columna += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte03") >= 0)  { valor_total_columna += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte04") >= 0)  { valor_total_columna += parseInt(elementos[j].value); }

                            var divsTot = grid.rows[iFila].getElementsByTagName('div')
                            for (var kDivTot = 0; kDivTot < divsTot.length; kDivTot++) {
                                if (divsTot[kDivTot].id.indexOf("divImporteTotal") >= 0) {
                                    divsTot[kDivTot].innerHTML = "<span " + (valor_total_columna < 0 ? "style='color:red;'" : "") + ">" + valor_total_columna + "&nbsp;</span>";
                                }
                            }

                            var nombre_campo_txt = "txtImporte";
                            if(columna<10){nombre_campo_txt = "txtImporte0";}

                            if (elementos[j].type == 'text' && elementos[j].id.indexOf(nombre_campo_txt + columna) >= 0) {
                                var valor = elementos[j].value;

                                if (totalesacalcular == 0 && existe(elementos_suman1, iFila)) {
                                    monto_calculado += parseInt(valor);
                                }
                            }
                        }

                        if (totales[totalesacalcular] == iFila) {
                            var divs = grid.rows[iFila].getElementsByTagName('div')
                            for (var kDiv = 0; kDiv < divs.length; kDiv++) {
                                var nombre_campo_div = "divImporte";
                                if(columna<10){nombre_campo_div = "divImporte0";}

                                if (divs[kDiv].id.indexOf(nombre_campo_div + columna) >= 0) {
                                    divs[kDiv].innerHTML = monto_calculado;
                                }
                            }
                            if (totalesacalcular == 0) { totales1 = monto_calculado; }
                            else if (totalesacalcular == 1) { totales2 = monto_calculado; }
                            monto_calculado = 0;
                            totalesacalcular += 1;
                        }
                    }
                }


                for (iFila = 1; iFila < grid.rows.length; iFila++) {
                    var divsTots = grid.rows[iFila].getElementsByTagName('div');
                    var valor_total_totales = 0;
                    var hayValores = false;

                    if (iFila == fila_totales) {
                        for (var j = 0; j < divsTots.length; j++) {
                            var valor_sin_formato = divsTots[j].innerHTML.replace('<span style="color:red;">', '').replace('<span>', '').replace('&nbsp;</span>', '');
                            if (divsTots[j].id.indexOf("divImporte01") >= 0) { valor_total_totales += parseInt(valor_sin_formato); hayValores = true; }
                            if (divsTots[j].id.indexOf("divImporte02") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }
                            if (divsTots[j].id.indexOf("divImporte03") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }
                            if (divsTots[j].id.indexOf("divImporte04") >= 0) { valor_total_totales += parseInt(valor_sin_formato); }

                            if (divsTots[j].id.indexOf("divImporteTotal") >= 0 && hayValores) {
                                divsTots[j].innerHTML = "<span " + (valor_total_totales < 0 ? "style='color:red;'" : "") + ">" + valor_total_totales + "&nbsp;</span>";
                            }
                        }
                    }
                }
            }
            MuestraDiferencias();
        }

        function AplicaValorGrid(id_empresa_cap, valor1, valor2, valor3, valor4)
        {

            var grid_referencia = document.getElementById("<%= gvCapturaCuadreInterRef.ClientID%>");

            if (grid_referencia.rows.length > 0) {
                for (iFila2 = 1; iFila2 < grid_referencia.rows.length; iFila2++) {
                    var elementos2 = grid_referencia.rows[iFila2].getElementsByTagName('input');

                    var id_empresa = 0;
                    var monto1 = 0;
                    var monto2 = 0;
                    var monto3 = 0;
                    var monto4 = 0;
                    for (var j = 0; j < elementos2.length; j++) {
                        if (elementos2[j].type == 'text' && elementos2[j].id.indexOf("txtIdEmpresa") >= 0)  { id_empresa = parseInt(elementos2[j].value); }
                        if (elementos2[j].type == 'text' && elementos2[j].id.indexOf("txtImporte01") >= 0)  { monto1 += parseInt(elementos2[j].value); }
                        if (elementos2[j].type == 'text' && elementos2[j].id.indexOf("txtImporte02") >= 0)  { monto2 += parseInt(elementos2[j].value); }
                        if (elementos2[j].type == 'text' && elementos2[j].id.indexOf("txtImporte03") >= 0)  { monto3 += parseInt(elementos2[j].value); }
                        if (elementos2[j].type == 'text' && elementos2[j].id.indexOf("txtImporte04") >= 0)  { monto4 += parseInt(elementos2[j].value); }

                    }
                    if(parseInt(id_empresa) == parseInt(id_empresa_cap)){
                        var divsTots = grid_referencia.rows[iFila2].getElementsByTagName('div');
                        for (var j = 0; j < divsTots.length; j++) {
                            if (divsTots[j].id.indexOf("divDiffMonto01") >= 0) { divsTots[j].innerHTML = (parseInt(monto1)-parseInt(valor1)!=0 ? "(Dif: " + (parseInt(monto1)-parseInt(valor1)) + ")" : ""); }
                            if (divsTots[j].id.indexOf("divDiffMonto02") >= 0) { divsTots[j].innerHTML = (parseInt(monto2)-parseInt(valor2)!=0 ? "(Dif: " + (parseInt(monto2)-parseInt(valor2)) + ")" : ""); }
                            if (divsTots[j].id.indexOf("divDiffMonto03") >= 0) { divsTots[j].innerHTML = (parseInt(monto3)-parseInt(valor3)!=0 ? "(Dif: " + (parseInt(monto3)-parseInt(valor3)) + ")" : ""); }
                            if (divsTots[j].id.indexOf("divDiffMonto04") >= 0) { divsTots[j].innerHTML = (parseInt(monto4)-parseInt(valor4)!=0 ? "(Dif: " + (parseInt(monto4)-parseInt(valor4)) + ")" : ""); }

                        }
                    }
                }
            }
        }

        function MuestraDiferencias()
        {
            var grid_captura = document.getElementById("<%= gvCapturaCuadreInter.ClientID%>");


            if (grid_captura.rows.length > 0) {
                for (columna = 1; columna <= 1; columna++) {

                    for (iFila = 1; iFila < grid_captura.rows.length; iFila++) {
                        var elementos = grid_captura.rows[iFila].getElementsByTagName('input');

                        var id_empresa = 0;
                        var monto1 = 0;
                        var monto2 = 0;
                        var monto3 = 0;
                        var monto4 = 0;
                        for (var j = 0; j < elementos.length; j++) {
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtIdEmpresa") >= 0)  { id_empresa = parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte01") >= 0)  { monto1 += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte02") >= 0)  { monto2 += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte03") >= 0)  { monto3 += parseInt(elementos[j].value); }
                            if (elementos[j].type == 'text' && elementos[j].id.indexOf("txtImporte04") >= 0)  { monto4 += parseInt(elementos[j].value); }

                        }
                        if(id_empresa>0){
                            AplicaValorGrid(id_empresa, monto1, monto2, monto3, monto4);
                        }
                    }
                }
            }
        }

        setTimeout(function(){MuestraDiferencias()}, 500);

<%  
    End If
%>
        
        function existe(arr, obj) {
            for (var i = 0; i < arr.length; i++) {
                if (arr[i] == obj) return true;
            }
            return false;
        }

        function ddlReporte_onchange(reporte) {
            if (reporte == 8) {
                document.getElementById('<%=ddlEmpresa.ClientID%>').value = 0;
                document.getElementById('<%=ddlEmpresa.ClientID%>').disabled = true;
            } else {
                document.getElementById('<%=ddlEmpresa.ClientID%>').disabled = false;
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
            <td><span style="font-size:15px; font-weight:bold;">Captura de Totales por Proveedor de Telefonia</span>
                <hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td>
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td>Reporte:</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:DropDownList ID="ddlReporte" runat="server" Width="300px" onchange="ddlReporte_onchange(this.value)"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>Empresa:</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <asp:DropDownList ID="ddlEmpresa" runat="server" Width="300px"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td>A&ntilde;o:</td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td colspan="3">
                            <asp:DropDownList ID="ddlAnio" runat="server" Width="105px"></asp:DropDownList>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            Mes:&nbsp;&nbsp;&nbsp;<asp:DropDownList ID="ddlMes" runat="server" Width="120px"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" align="right">
                            <div style="height:7px"></div>
                            <asp:Button ID="btnContinuar" runat="server" Text="Continuar" OnClientClick="if (!ValidaCaptura()) return false; this.disabled = true; this.value = 'Guardando...';" UseSubmitBehavior="false" />&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnActualizar" Visible="false" runat="server" Text="Calcular Totales" OnClientClick="if (!ValidaCaptura()) return false; this.disabled = true; this.value = 'Calculando...';" UseSubmitBehavior="false" />&nbsp;&nbsp;&nbsp;&nbsp;
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
                    <span style="font-size:14px; font-weight:bold;">Movimientos Reales por Concepto</span>
                
                    <asp:GridView ID="gvCaptura" runat="server" 
                                    AllowPaging="false" 
                                    AllowSorting="false" 
                                    AutoGenerateColumns="false"
                                    Width="600px">
                        <Columns>
                            <asp:BoundField HeaderText="Clave" DataField="clave" HeaderStyle-Font-Bold="true" Visible="false" />
                            <asp:BoundField HeaderText="Descripción" DataField="descripcion" HeaderStyle-Font-Bold="true" />
                            <asp:TemplateField HeaderText="Importe" HeaderStyle-Font-Bold="true" ItemStyle-Width="80px">
                                <ItemTemplate>
                                    <div style="padding-left:6px;">
                                        <asp:TextBox ID="txtIdConcepto" runat="server" Visible="false" Text='<%# Eval("id_concepto")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtImporte" runat="server" Text='<%# Eval("monto")%>' Width="65px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                        <div id="divImporte" runat="server"><asp:Label ID="lblImporte" runat="server" Text='<%# Format(Eval("monto"),"###,###,##0")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto") < 0, "negativo", "")%>'></asp:Label></div>
                                        <asp:TextBox ID="txtPermiteCaptura" runat="server" Visible="false" Text='<%# Eval("permite_captura")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtEsSeparador" runat="server" Visible="false" Text='<%# Eval("es_separador")%>'></asp:TextBox>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                    <asp:GridView ID="gvCapturaDecimales" runat="server" 
                                    AllowPaging="false" 
                                    AllowSorting="false" 
                                    AutoGenerateColumns="false"
                                    Width="600px" Visible="false">
                        <Columns>
                            <asp:BoundField HeaderText="Descripción" DataField="descripcion" HeaderStyle-Font-Bold="true" />
                            <asp:TemplateField HeaderText="Importe" HeaderStyle-Font-Bold="true" ItemStyle-Width="80px">
                                <ItemTemplate>
                                    <div style="padding-left:6px;">
                                        <asp:TextBox ID="txtIdConcepto" runat="server" Visible="false" Text='<%# Eval("id_concepto")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtImporte" runat="server" Text='<%# Eval("monto_dec")%>' Width="65px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales(this);"></asp:TextBox>
                                        <div id="divImporte" runat="server"><asp:Label ID="lblImporte" runat="server" Text='<%# Format(Eval("monto_dec"),"###,###,##0.00")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto_dec") < 0, "negativo", "")%>'></asp:Label></div>
                                        <asp:TextBox ID="txtPermiteCaptura" runat="server" Visible="false" Text='<%# Eval("permite_captura")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtEsSeparador" runat="server" Visible="false" Text='<%# Eval("es_separador")%>'></asp:TextBox>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                    <asp:GridView ID="gvCapturaflujo" runat="server" 
                                    AllowPaging="false" 
                                    AllowSorting="false" 
                                    AutoGenerateColumns="false"
                                    Width="700px" Visible="false">
                        <Columns>
                            <asp:BoundField HeaderText="Clave" DataField="clave" HeaderStyle-Font-Bold="true" />
                            <asp:BoundField HeaderText="Descripción" DataField="descripcion" HeaderStyle-Font-Bold="true" />
                            <asp:TemplateField HeaderText="Pronostico<br />Mes Anterior" HeaderStyle-Font-Bold="true" ItemStyle-Width="65px">
                                <ItemTemplate>
                                    <div align="right">
                                        <asp:TextBox ID="txtIdConcepto" runat="server" Visible="false" Text='<%# Eval("id_concepto")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtPermiteCaptura" runat="server" Visible="false" Text='<%# Eval("permite_captura")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtEsSeparador" runat="server" Visible="false" Text='<%# Eval("es_separador")%>'></asp:TextBox>
                                        <asp:Label ID="lblPronosticoMesAnt" runat="server" Text='<%# Eval("monto_pron_mes_ant")%>' Visible='<%# IIf(Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto_pron_mes_ant") < 0, "negativo", "")%>'></asp:Label>&nbsp;
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Real<br />Mes Anterior" HeaderStyle-Font-Bold="true" ItemStyle-Width="65px">
                                <ItemTemplate>
                                    <div>
                                        <asp:TextBox ID="txtImporte0" runat="server" Text='<%# Eval("monto_real_mes_ant")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_PronosticoFlujoEfectivo(this);"></asp:TextBox>
                                        <div id="divImporte0" runat="server"><asp:Label ID="lblImporte0" runat="server" Text='<%# Eval("monto_real_mes_ant")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto_pron_mes_ant") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Semana 1" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte1" runat="server" Text='<%# Eval("monto1")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' ReadOnly='<%# IIf(Eval("clave") = "40-SI-01", "true", "false")%>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_PronosticoFlujoEfectivo(this);"></asp:TextBox>
                                        <div id="divImporte1" runat="server"><asp:Label ID="lblImporte1" runat="server" Text='<%# Eval("monto1")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto1") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Semana 2" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte2" runat="server" Text='<%# Eval("monto2")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' ReadOnly='<%# IIf(Eval("clave") = "40-SI-01", "true", "false")%>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_PronosticoFlujoEfectivo(this);"></asp:TextBox>
                                        <div id="divImporte2" runat="server"><asp:Label ID="lblImporte2" runat="server" Text='<%# Eval("monto2")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto2") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Semana 3" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte3" runat="server" Text='<%# Eval("monto3")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' ReadOnly='<%# IIf(Eval("clave") = "40-SI-01", "true", "false")%>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_PronosticoFlujoEfectivo(this);"></asp:TextBox>
                                        <div id="divImporte3" runat="server"><asp:Label ID="lblImporte3" runat="server" Text='<%# Eval("monto3")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto3") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Semana 4" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte4" runat="server" Text='<%# Eval("monto4")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' ReadOnly='<%# IIf(Eval("clave") = "40-SI-01", "true", "false")%>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_PronosticoFlujoEfectivo(this);"></asp:TextBox>
                                        <div id="divImporte4" runat="server"><asp:Label ID="lblImporte4" runat="server" Text='<%# Eval("monto4")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto4") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Semana 5" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte5" runat="server" Text='<%# Eval("monto5")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' ReadOnly='<%# IIf(Eval("clave") = "40-SI-01", "true", "false")%>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_PronosticoFlujoEfectivo(this);"></asp:TextBox>
                                        <div id="divImporte5" runat="server"><asp:Label ID="lblImporte5" runat="server" Text='<%# Eval("monto5")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto5") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Totales" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div align="right" id="divImporteTotal" runat="server"><asp:Label ID="lblTotales" runat="server" Text='<%# Format(Eval("monto_total"), "###,###,##0")%>' Visible='<%# IIf(Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto_total") < 0, "negativo", "")%>'></asp:Label>&nbsp;</div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>




                    <asp:GridView ID="gvCapturaDeuda" runat="server" 
                                    AllowPaging="false" 
                                    AllowSorting="false" 
                                    AutoGenerateColumns="false"
                                    Width="950px" Visible="false">
                        <Columns>
                            <asp:BoundField HeaderText="Banco" DataField="descripcion" HeaderStyle-Font-Bold="true" />
                            <asp:BoundField HeaderText="Tipo" DataField="descripcion_2" HeaderStyle-Font-Bold="true" />
                            <asp:TemplateField HeaderText="2013" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte01" runat="server" Text='<%# Eval("monto1")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_PerfilDeuda(this);"></asp:TextBox>
                                        <div id="divImporte01" runat="server"><asp:Label ID="lblImporte01" runat="server" Text='<%# Eval("monto1")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto1") < 0, "negativo", "")%>'></asp:Label></div>
                                        <asp:TextBox ID="txtIdConcepto" runat="server" Visible="false" Text='<%# Eval("id_concepto")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtPermiteCaptura" runat="server" Visible="false" Text='<%# Eval("permite_captura")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtEsSeparador" runat="server" Visible="false" Text='<%# Eval("es_separador")%>'></asp:TextBox>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="2014" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte02" runat="server" Text='<%# Eval("monto2")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_PerfilDeuda(this);"></asp:TextBox>
                                        <div id="divImporte02" runat="server"><asp:Label ID="lblImporte02" runat="server" Text='<%# Eval("monto2")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto2") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="2015" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte03" runat="server" Text='<%# Eval("monto3")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_PerfilDeuda(this);"></asp:TextBox>
                                        <div id="divImporte03" runat="server"><asp:Label ID="lblImporte03" runat="server" Text='<%# Eval("monto3")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto3") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="2016" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte04" runat="server" Text='<%# Eval("monto4")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_PerfilDeuda(this);"></asp:TextBox>
                                        <div id="divImporte04" runat="server"><asp:Label ID="lblImporte04" runat="server" Text='<%# Eval("monto4")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto4") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="2017" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte05" runat="server" Text='<%# Eval("monto5")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_PerfilDeuda(this);"></asp:TextBox>
                                        <div id="divImporte05" runat="server"><asp:Label ID="lblImporte05" runat="server" Text='<%# Eval("monto5")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto5") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>




                            <asp:TemplateField HeaderText="2018" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte07" runat="server" Text='<%# Eval("monto7")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_PerfilDeuda(this);"></asp:TextBox>
                                        <div id="divImporte07" runat="server"><asp:Label ID="lblImporte07" runat="server" Text='<%# Eval("monto7")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto7") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="2019" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte08" runat="server" Text='<%# Eval("monto8")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_PerfilDeuda(this);"></asp:TextBox>
                                        <div id="divImporte08" runat="server"><asp:Label ID="lblImporte08" runat="server" Text='<%# Eval("monto8")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto8") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="2020" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte09" runat="server" Text='<%# Eval("monto9")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_PerfilDeuda(this);"></asp:TextBox>
                                        <div id="divImporte09" runat="server"><asp:Label ID="lblImporte09" runat="server" Text='<%# Eval("monto9")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto9") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="2021" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte10" runat="server" Text='<%# Eval("monto10")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_PerfilDeuda(this);"></asp:TextBox>
                                        <div id="divImporte10" runat="server"><asp:Label ID="lblImporte10" runat="server" Text='<%# Eval("monto10")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto10") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="2022" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte11" runat="server" Text='<%# Eval("monto11")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_PerfilDeuda(this);"></asp:TextBox>
                                        <div id="divImporte11" runat="server"><asp:Label ID="lblImporte11" runat="server" Text='<%# Eval("monto11")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto11") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>







                            <asp:TemplateField HeaderText="Total" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div align="right" id="divImporteTotal" runat="server"><asp:Label ID="lblTotales" runat="server" Text='<%# Format(Eval("monto_total"), "###,###,##0")%>' Visible='<%# IIf(Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto_total") < 0, "negativo", "")%>'></asp:Label>&nbsp;</div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Linea Disponible" HeaderStyle-Font-Bold="true" ItemStyle-Width="54px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte06" runat="server" Text='<%# Eval("monto6")%>' Width="50px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_PerfilDeuda(this);"></asp:TextBox>
                                        <div id="divImporte06" runat="server"><asp:Label ID="lblImporte06" runat="server" Text='<%# Eval("monto6")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto6") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>






                    <asp:GridView ID="gvCapturaCuadreInter" runat="server" 
                                    AllowPaging="false" 
                                    AllowSorting="false" 
                                    AutoGenerateColumns="false"
                                    Width="650px" Visible="false">
                        <Columns>
                            <asp:BoundField HeaderText="Empresa" DataField="descripcion" HeaderStyle-Font-Bold="true" />
                            <asp:TemplateField HeaderText="Afil. x Cob CP" HeaderStyle-Font-Bold="true" ItemStyle-Width="100px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte01" runat="server" Text='<%# Eval("monto1")%>' Width="100px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_CuardeIntercompanies(this);"></asp:TextBox>
                                        <div id="divImporte01" runat="server"><asp:Label ID="lblImporte01" runat="server" Text='<%# Eval("monto1")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto1") < 0, "negativo", "")%>'></asp:Label></div>
                                        <asp:TextBox ID="txtIdConcepto" runat="server" Visible="false" Text='<%# Eval("id_concepto")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtPermiteCaptura" runat="server" Visible="false" Text='<%# Eval("permite_captura")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtEsSeparador" runat="server" Visible="false" Text='<%# Eval("es_separador")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtIdEmpresa" runat="server" style="display:none" Text='<%# Eval("id_empresa_concepto")%>'></asp:TextBox>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Afil. x Cob LP" HeaderStyle-Font-Bold="true" ItemStyle-Width="100px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte02" runat="server" Text='<%# Eval("monto2")%>' Width="100px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_CuardeIntercompanies(this);"></asp:TextBox>
                                        <div id="divImporte02" runat="server"><asp:Label ID="lblImporte02" runat="server" Text='<%# Eval("monto2")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto2") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Afil. x Pag CP" HeaderStyle-Font-Bold="true" ItemStyle-Width="100px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte03" runat="server" Text='<%# Eval("monto3")%>' Width="100px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_CuardeIntercompanies(this);"></asp:TextBox>
                                        <div id="divImporte03" runat="server"><asp:Label ID="lblImporte03" runat="server" Text='<%# Eval("monto3")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto3") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Afil. x Pag LP" HeaderStyle-Font-Bold="true" ItemStyle-Width="100px">
                                <ItemTemplate>
                                    <div><asp:TextBox ID="txtImporte04" runat="server" Text='<%# Eval("monto4")%>' Width="100px" Visible='<%# IIf(Eval("permite_captura")="1","true","false") %>' onkeypress="return isNumberKey(event);" onblur="RecalculaTotales_CuardeIntercompanies(this);"></asp:TextBox>
                                        <div id="divImporte04" runat="server"><asp:Label ID="lblImporte04" runat="server" Text='<%# Eval("monto4")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto4") < 0, "negativo", "")%>'></asp:Label></div>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>



                    <br /><br />
                    <span style="font-size:14px; font-weight:bold;">
                        <asp:Label ID="lblTituloInterRef" runat="server" Text="Comparativo de lo reportado por las otras empresas" Visible="false"></asp:Label>
                    </span>
                    <asp:GridView ID="gvCapturaCuadreInterRef" runat="server" 
                                    AllowPaging="false" 
                                    AllowSorting="false" 
                                    AutoGenerateColumns="false"
                                    Width="650px" Visible="false">
                        <Columns>
                            <asp:BoundField HeaderText="Empresa" DataField="empresa" HeaderStyle-Font-Bold="true" />
                            <asp:TemplateField HeaderText="Afil. x Cob CP" HeaderStyle-Font-Bold="true" ItemStyle-Width="110px">
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblImporte01" runat="server" Text='<%# Eval("monto1")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto1") < 0, "negativo", "")%>'></asp:Label>
                                        &nbsp;&nbsp;
                                        <div id="divDiffMonto01" runat="server" style="display:inline;"></div>
                                        <asp:TextBox ID="txtIdEmpresa" runat="server" style="display:none" Text='<%# Eval("id_empresa")%>'></asp:TextBox>
                                        <asp:TextBox ID="txtImporte01" runat="server" Text='<%# Eval("monto1")%>' style='display:none'></asp:TextBox>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Afil. x Cob LP" HeaderStyle-Font-Bold="true" ItemStyle-Width="110px">
                                <ItemTemplate>
                                    <div><asp:Label ID="lblImporte02" runat="server" Text='<%# Eval("monto2")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto2") < 0, "negativo", "")%>'></asp:Label>
                                        &nbsp;&nbsp;
                                        <div id="divDiffMonto02" runat="server" style="display:inline;"></div>
                                        <asp:TextBox ID="txtImporte02" runat="server" Text='<%# Eval("monto2")%>' style='display:none'></asp:TextBox>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Afil. x Pag CP" HeaderStyle-Font-Bold="true" ItemStyle-Width="110px">
                                <ItemTemplate>
                                    <div><asp:Label ID="lblImporte03" runat="server" Text='<%# Eval("monto3")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto3") < 0, "negativo", "")%>'></asp:Label>
                                        &nbsp;&nbsp;
                                        <div id="divDiffMonto03" runat="server" style="display:inline;"></div>
                                        <asp:TextBox ID="txtImporte03" runat="server" Text='<%# Eval("monto3")%>' style='display:none'></asp:TextBox>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Afil. x Pag LP" HeaderStyle-Font-Bold="true" ItemStyle-Width="110px">
                                <ItemTemplate>
                                    <div><asp:Label ID="lblImporte04" runat="server" Text='<%# Eval("monto4")%>' Visible='<%# IIf(Eval("permite_captura") = "1" or Eval("es_separador") = "1", "false", "true")%>' CssClass='<%# IIf(Eval("monto4") < 0, "negativo", "")%>'></asp:Label>
                                        &nbsp;&nbsp;
                                        <div id="divDiffMonto04" runat="server" style="display:inline;"></div>
                                        <asp:TextBox ID="txtImporte04" runat="server" Text='<%# Eval("monto4")%>' style='display:none'></asp:TextBox>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>




                    <div id="divLeyenda_PedidosyFacturacion" runat="server" visible="false" style="color:#f00;font-size:15px;"><br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Intercompanies misma division: se captura positivo.<br />
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;- Intercompanies otra division: se captura negativo.
                    </div>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="divComentarios" runat="server" visible="false" style="padding-left:20px;">
                    <br />
                    Explicación de la variación respecto al mes anterior:<br />
                    <asp:TextBox ID="txtComentarios" runat="server" TextMode="MultiLine" Width="400px" Height="100px"></asp:TextBox>
                </div>
            </td>
        </tr>
        <tr>
            <td>
                <div id="divDatosFlujoEfectivo" runat="server" visible="false" style="padding-left:20px;">
                    <br />
                    Saldo en Caja (Balance General): <asp:Label ID="lblFE_SaldoCaja" runat="server"></asp:Label><br />
                    Utilidad Neta (Estado de Resultados): <asp:Label ID="lblFE_UtilidadNeta" runat="server"></asp:Label><br />
                </div>
            </td>
        </tr>
    </table>
    <asp:TextBox ID="txtEstatus" runat="server" style="display:none;"></asp:TextBox>

</asp:Content>

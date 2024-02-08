<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepGastosNSEjecutivoImpresion.aspx.vb" Inherits="Intranet.RepGastosNSEjecutivoImpresion" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reporte</title>

    <style type="text/css">
        body {
            font-family:Arial;
        }

        td {
            border-style:solid;
            border-color:#dedcdc;
            border-width:1px;
            padding-left:1px;
            padding-right:0px;
            padding-top:0px;
            padding-bottom:0px;
        }
        .titulos {
            font-size:14px;
            background-color:#9de7d7;
            color:#000;
            padding-left:4px;
            padding-right:4px;
        }
        .sub_titulos {
            font-size:13px;
            background-color:#AEFFED;
            color:#000;
            padding-left:4px;
            padding-right:4px;
            font-style:italic;
        }
        .subtitulos {
            font-size:13px;
        }
        .datos {
            font-size:13px;
            background-color:#FFFFFF;
        }
        .datos3 {
            font-size:13px;
            /*background-color:#FFFC99;*/
        }
        .datos4 {
            font-size:13px;
            font-weight:bold;
            /*background-color:#FFFC99;*/
        }
        .columnaAlterna {
            background-color:#FFFFFF;
        }
        .columnaTitulos {
            background-color:#FFFFFF;
        }
        .negativo {
            color:red;
        }
        .negritas {
            font-weight:bold;
        }


        .rep2Dato {
            float:left;
            display:inline-block;
            width:40px;
            text-align:right;
            font-size:13px;
        }
        .rep2Porc {
            float:right;
            display:inline-block;
            width:25px;
            text-align:right;
            font-size:11px;
            border-width:0px;

        }

        .titulos2 {
            font-size:14px;
            background-color:#9de7d7;
            color:#000;
        }
        .subtitulos2 {
            font-size:12px;
        }
        .datos2 {
            /*font-size:11px;*/
            font-size:13px;
            background-color:#FFFFFF;
        }


        .rep4Dato {
            float:left;
            display:inline-block;
            /*width:25px;*/
            width:41px;
            text-align:right;
            /*font-size:11px;*/
            font-size:12px;
        }
        .rep4Porc {
            float:right;
            display:inline-block;
            width:20px;
            text-align:right;
            font-size:11px;
            border-width:0px;
        }



        ul
        {
            list-style-type:circle;
        }

        ul a {
            color:#1b6d9c;
            text-decoration:none;
        }

        .linkCopias a {
            text-decoration:none;
            color:#1b6d9c;
            padding-left:20px;
            font-size:14px
        }

        ul a:hover {
            color:#324f5e;
            text-decoration:underline;
        }

        .tblLinks td {
            border-style:none;
            border-width:0px;
            padding-left:0px;
            padding-right:0px;
            padding-top:2px;
            padding-bottom:2px;
        }

        .colorSel {
            color:#324f5e;
            text-decoration:underline;
        }

    </style>

    <script src="rasterizeHTML/canvas2image.js"></script>
    <script src="rasterizeHTML/base64.js"></script>

    <script type="text/javascript">

        function SeleccionaReporte(reporte) {
            if (reporte != 99) {
                for (i = 1; i <= 15; i++) {
                    document.getElementById('divReporte_' + i).style.display = 'none';
                    document.getElementById('lnkReporte_' + i).className = '';
                }
                document.getElementById('divReporte_' + reporte).style.display = '';
                document.getElementById('lnkReporte_' + reporte).className = 'colorSel';
                document.getElementById('lnkReporte_99').className = '';
            }
            else {
                for (i = 1; i <= 15; i++) {
                    document.getElementById('divReporte_' + i).style.display = '';
                    document.getElementById('lnkReporte_' + i).className = '';
                }
                document.getElementById('lnkReporte_' + reporte).className = 'colorSel';
            }
            if (reporte == 11 || reporte == 12 || reporte == 13 || reporte == 14 || reporte == 15 || reporte == 99) {
                document.getElementById('divAnexos').style.display = '';
            } else {
                document.getElementById('divAnexos').style.display = 'none';
            }
        }

        function TomaFoto(reporte) {
            ResizeAll(2);
            ScreenShot(document.getElementById('tblReporte_' + reporte));
            setTimeout(function () { ResizeAll(0.5); }, 1000);
            
            //ScreenShotHD('tblReporte_' + reporte);
        }



        function ResizeAll(scale){
            //var scale = 2;

            var nombreClase = ".titulos";
            var claseTexto = parseInt($(nombreClase).css("font-size"));
            claseTexto = (claseTexto * scale) + "px";
            $(nombreClase).css({ 'font-size': claseTexto });

            nombreClase = ".sub_titulos";
            claseTexto = parseInt($(nombreClase).css("font-size"));
            claseTexto = (claseTexto * scale) + "px";
            $(nombreClase).css({ 'font-size': claseTexto });

            nombreClase = ".subtitulos";
            claseTexto = parseInt($(nombreClase).css("font-size"));
            claseTexto = (claseTexto * scale) + "px";
            $(nombreClase).css({ 'font-size': claseTexto });

            nombreClase = ".datos";
            claseTexto = parseInt($(nombreClase).css("font-size"));
            claseTexto = (claseTexto * scale) + "px";
            $(nombreClase).css({ 'font-size': claseTexto });

            nombreClase = ".datos3";
            claseTexto = parseInt($(nombreClase).css("font-size"));
            claseTexto = (claseTexto * scale) + "px";
            $(nombreClase).css({ 'font-size': claseTexto });

            nombreClase = ".datos4";
            claseTexto = parseInt($(nombreClase).css("font-size"));
            claseTexto = (claseTexto * scale) + "px";
            $(nombreClase).css({ 'font-size': claseTexto });

            nombreClase = ".rep2Dato";
            claseTexto = parseInt($(nombreClase).css("font-size"));
            claseTexto = (claseTexto * scale) + "px";
            $(nombreClase).css({ 'font-size': claseTexto });

            nombreClase = ".rep2Porc";
            claseTexto = parseInt($(nombreClase).css("font-size"));
            claseTexto = (claseTexto * scale) + "px";
            $(nombreClase).css({ 'font-size': claseTexto });

            nombreClase = ".titulos2";
            claseTexto = parseInt($(nombreClase).css("font-size"));
            claseTexto = (claseTexto * scale) + "px";
            $(nombreClase).css({ 'font-size': claseTexto });

            nombreClase = ".subtitulos2";
            claseTexto = parseInt($(nombreClase).css("font-size"));
            claseTexto = (claseTexto * scale) + "px";
            $(nombreClase).css({ 'font-size': claseTexto });

            nombreClase = ".datos2";
            claseTexto = parseInt($(nombreClase).css("font-size"));
            claseTexto = (claseTexto * scale) + "px";
            $(nombreClase).css({ 'font-size': claseTexto });

            nombreClase = ".rep4Dato";
            claseTexto = parseInt($(nombreClase).css("font-size"));
            claseTexto = (claseTexto * scale) + "px";
            $(nombreClase).css({ 'font-size': claseTexto });

            nombreClase = ".rep4Porc";
            claseTexto = parseInt($(nombreClase).css("font-size"));
            claseTexto = (claseTexto * scale) + "px";
            $(nombreClase).css({ 'font-size': claseTexto });
        }


        function ScreenShotHD(id){
            var scaledElement = $("#"+id).css({
                'transform': 'scale(3,3)',
                '-ms-transform': 'scale(3,3)',
                '-webkit-transform': 'scale(3,3)'
            });
            var oldWidth = scaledElement.width();
            var oldHeight = scaledElement.height();

            var newWidth = oldWidth * (3);
            var newHeight = oldHeight * (3);
            html2canvas(scaledElement, {
                onrendered: function(canvasq) {


                    var img = canvasq.toDataURL("image/jpg");
                    var output = img.replace(/^data:image\/(png|jpg);base64,/, "");
                    var output = encodeURIComponent(img);

                    var Parameters = "image=" + output;
                    $.ajax({
                        type: "POST",
                        url: "Servicios/GuardaScreenshot.aspx",
                        data: Parameters,
                        success : function(data)
                        {
                            window.open('/uploads/' + data);
                            //console.log("screenshot done");
                        }
                    }).done(function() {
                        //$('body').html(data);
                    });


                    //var w=window.open();
                    //w.document.write("<h3 style='text-align:center;'>TITULO</h3>");
                    //w.document.write("<img width='"+newWidth+"' height='"+newHeight+"' src='"+canvasq.toDataURL()+"' />");
                    //w.print();
                }
            });
        }

        function ScreenShot(id) {
            //ResizeAll(id);
            //id = document.getElementById(id);

            html2canvas(id, {
                onrendered: function(canvas) {

                    var img = canvas.toDataURL("image/jpg");
                    var output = img.replace(/^data:image\/(png|jpg);base64,/, "");
                    var output = encodeURIComponent(img);

                    var Parameters = "image=" + output;
                    $.ajax({
                        type: "POST",
                        url: "Servicios/GuardaScreenshot.aspx",
                        data: Parameters,
                        success : function(data)
                        {
                            window.open('/uploads/' + data);
                            //console.log("screenshot done");
                        }
                    }).done(function() {
                        //$('body').html(data);
                    });

                }
            });
        }

    </script>



	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
<%--    <script src="/highcharts/js/highcharts.js"></script>
    <script src="/highcharts/js/highcharts-more.js"></script>
    <script src="/highcharts/js/modules/exporting.js"></script>--%>
        <script src="/highcharts2/js/highcharts.js"></script>
    <script src="/highcharts2/js/highcharts-more.js"></script>
    <script src="/highcharts2/js/modules/exporting.js"></script>
    <script src="/highcharts2/js/modules/offline-exporting.js"></script>

    <script src="/scripts/html2canvas.js"></script>
    <script src="/scripts/jquery.fileDownload.js"></script>

    <script type="text/javascript">
        Highcharts.setOptions({
            chart: {
                style: {
                    fontFamily: 'arial'
                }
            }
        });

    </script>

</head>
<body>



    <form id="form1" runat="server">

    <div style='padding-left:12px;font-size:22px;'><asp:Label ID="lblTituloReporte" runat="server"></asp:Label></div>

    <table class="tblLinks" border="0" cellpadding="0" cellspacing="0">
        <tr valign="top">
            <td>
                <ul>
                    <li><a id="lnkReporte_1" class="colorSel" href="#" onclick="SeleccionaReporte(1);">Resumen NBR-CECAP-HELI</a></li>
                    <li><a id="lnkReporte_2" href="#" onclick="SeleccionaReporte(2);">Resumen DG</a></li>
                    <li><a id="lnkReporte_3" href="#" onclick="SeleccionaReporte(3);">BE CCD</a></li>
                    <li><a id="lnkReporte_4" href="#" onclick="SeleccionaReporte(4);">BE ZCD</a></li>
                    <li><a id="lnkReporte_5" href="#" onclick="SeleccionaReporte(5);">BE GCB</a></li>
                    <li><a id="lnkReporte_6" href="#" onclick="SeleccionaReporte(6);">BE GFC</a></li>
                    <li><a id="lnkReporte_7" href="#" onclick="SeleccionaReporte(7);">DG GCB</a></li>
                    <li><a id="lnkReporte_8" href="#" onclick="SeleccionaReporte(8);">DG GFC</a></li>
                    <li><a id="lnkReporte_9" href="#" onclick="SeleccionaReporte(9);">CECAP</a></li>
                    <li><a id="lnkReporte_10" href="#" onclick="SeleccionaReporte(10);">HELICOPTERO</a></li>
                </ul>
            </td>
            <td>&nbsp;&nbsp;&nbsp;</td>
            <td>
                <ul>
                    <li><b>ANEXOS</b></li>
                    <li><a id="lnkReporte_11" href="#" onclick="SeleccionaReporte(11);">Detalle de Gastos - Celulares</a></li>
                    <li><a id="lnkReporte_12" href="#" onclick="SeleccionaReporte(12);">Detalle de Gastos - Gasolina y Peajes</a></li>
                    <li><a id="lnkReporte_13" href="#" onclick="SeleccionaReporte(13);">Detalle de Gastos - Mantto. Eq. Transporte</a></li>
                    <li><a id="lnkReporte_14" href="#" onclick="SeleccionaReporte(14);">Detalle de Gastos - Arrendamiento Autos</a></li>
                    <li><a id="lnkReporte_15" href="#" onclick="SeleccionaReporte(15);">Detalle de Gastos - Arrendamiento Autos No Deducibles</a></li>
                    <li><a id="lnkReporte_99" href="#" onclick="SeleccionaReporte(99);">Mostrar todos los reportes</a></li>
                </ul>
            </td>
        </tr>
    </table>

        <br /><br />
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td colspan="2"><b>Código de colores para presupesto erogado.</b></td>
            </tr>
            <tr>
                <td style="background-color:#00B050">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>&nbsp;&nbsp;Presupuesto debajo del estimado.</td>
            </tr>
            <tr>
                <td style="background-color:#FFFF00">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>&nbsp;&nbsp;Presupuesto arriba del estimado, por 10% o menos.</td>
            </tr>
            <tr>
                <td style="background-color:#FA1100">&nbsp;&nbsp;&nbsp;&nbsp;</td>
                <td>&nbsp;&nbsp;Presupuesto arriba del estimado, por más del 10% o sin presupuesto.</td>
            </tr>
        </table>


<%
    Dim dsReporte As DataSet = RecuperaDatosReporte()
    Dim dtRep_Params As DataTable = dsReporte.Tables(0)
    Dim ULTIMO_MES_CON_DATOS As Integer = dtRep_Params.Rows(0)("ultimo_mes_con_datos")
    Dim ANIO As Integer = Request.QueryString("a")
    Dim MES As Integer = Request.QueryString("m")
    Dim FILA_ALTERNA As Boolean = False

    
    Dim sub_monto_01 As Decimal = 0
    Dim sub_monto_02 As Decimal = 0
    Dim sub_monto_03 As Decimal = 0
    Dim sub_monto_04 As Decimal = 0
    Dim sub_monto_05 As Decimal = 0
    Dim sub_monto_06 As Decimal = 0
    Dim sub_monto_07 As Decimal = 0
    Dim sub_monto_08 As Decimal = 0
    Dim sub_monto_09 As Decimal = 0
    Dim sub_monto_10 As Decimal = 0
    Dim sub_monto_11 As Decimal = 0
    Dim sub_monto_12 As Decimal = 0
    Dim sub_monto_tot As Decimal = 0

    
    Dim monto_01 As Decimal = 0
    Dim monto_02 As Decimal = 0
    Dim monto_03 As Decimal = 0
    Dim monto_04 As Decimal = 0
    Dim monto_05 As Decimal = 0
    Dim monto_06 As Decimal = 0
    Dim monto_07 As Decimal = 0
    Dim monto_08 As Decimal = 0
    Dim monto_09 As Decimal = 0
    Dim monto_10 As Decimal = 0
    Dim monto_11 As Decimal = 0
    Dim monto_12 As Decimal = 0
    Dim monto_tot As Decimal = 0
    Dim monto_pres As Decimal = 0
    Dim debe_ser As Decimal = 0
    Dim monto_erog As Decimal = 0
    
    Dim dtRep As DataTable = dsReporte.Tables(1)    
    
%>


    <div id="divReporte_1" style="">
    <br /><br />
    <div style='font-size:20px;'>Resumen NBR-CECAP-HELI<span class="linkCopias"><a href="#" onclick="TomaFoto(1);">(Copiar)</a></span></div>

    <table id="tblReporte_1" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td align="center" class="titulos"><b>CENTRO DE COSTOS</b></td>
<%

    For i As Integer = 1 To ULTIMO_MES_CON_DATOS
        Response.Write("<td align='center' class='titulos' nowrap><b>" & i.ToString("00") & " - " & NombrePeriodo(i) & "</b></td>")
    Next
    Response.Write("<td align='center' class='titulos'><b>TOTAL</b></td>")
    Response.Write("<td align='center' class='titulos'><b>&nbsp;</b></td>")
    Response.Write("<td align='center' class='titulos'><b>PRESUPUESTO<br>" & NombrePeriodo(MES) & "/" & ANIO & "</b></td>")
    Response.Write("<td align='center' class='titulos'><b>&nbsp;</b></td>")
    Response.Write("<td align='center' class='titulos'><b>% EROGADO DEL<br>PRESUPUESTO</b></td>")
    'Response.Write("<td align='center' class='titulos'><b>&nbsp;</b></td>")
    'Response.Write("<td align='center' class='titulos'><b>DEBER SER</b></td>")
    
%>
        </tr>
<% 
    For Each dr As DataRow In dtRep.Rows
        monto_01 += dr("mes_01")
        monto_02 += dr("mes_02")
        monto_03 += dr("mes_03")
        monto_04 += dr("mes_04")
        monto_05 += dr("mes_05")
        monto_06 += dr("mes_06")
        monto_07 += dr("mes_07")
        monto_08 += dr("mes_08")
        monto_09 += dr("mes_09")
        monto_10 += dr("mes_10")
        monto_11 += dr("mes_11")
        monto_12 += dr("mes_12")
        monto_tot += dr("total")
        monto_pres += dr("presupuesto")
        If dr("debe_ser") > 0 Then
            debe_ser = dr("debe_ser")
        End If
        If monto_pres = 0 Then
            monto_erog = 1
        Else
            monto_erog = monto_tot / monto_pres
        End If

        
        
        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos columnaTitulos'><b>" & dr("centro_costo") & "</b></td>")

        If ULTIMO_MES_CON_DATOS >= 1 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_01"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 2 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_02"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 3 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_03"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 4 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_04"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 5 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_05"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 6 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_06"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 7 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_07"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 8 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_08"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 9 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_09"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 10 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_10"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 11 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_11"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 12 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_12"), Decimal).ToString("#,###,###") & "</td>")

        Response.Write("<td align='right' class='datos4'>" & CType(dr("total"), Decimal).ToString("#,###,###") & "</td>")
        Response.Write("<td align='center' class=''><b>&nbsp;</b></td>")
        Response.Write("<td align='right' class='datos4'>" & CType(dr("presupuesto"), Decimal).ToString("#,###,###") & "</td>")
        Response.Write("<td align='center' class=''><b>&nbsp;</b></td>")
        Response.Write("<td align='center' class='datos4' bgcolor='" & dr("color") & "'>" & CType(dr("erogado"), Decimal).ToString("#,###,### %") & "</td>")
        'Response.Write("<td align='center' class=''><b>&nbsp;</b></td>")
        'Response.Write("<td align='center' class='datos4'>" & CType(dr("debe_ser"), Decimal).ToString("#,###,### %") & "</td>")

        FILA_ALTERNA = Not FILA_ALTERNA
        Response.Write("</tr>")
        
        
    Next
%>

        <tr class="filaTotales">
<%

    Response.Write("<td align='left' class='titulos'><b>TOTAL</b></td>")

    If ULTIMO_MES_CON_DATOS >= 1 Then Response.Write("<td align='right' class='titulos'><b>" & monto_01.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 2 Then Response.Write("<td align='right' class='titulos'><b>" & monto_02.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 3 Then Response.Write("<td align='right' class='titulos'><b>" & monto_03.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 4 Then Response.Write("<td align='right' class='titulos'><b>" & monto_04.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 5 Then Response.Write("<td align='right' class='titulos'><b>" & monto_05.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 6 Then Response.Write("<td align='right' class='titulos'><b>" & monto_06.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 7 Then Response.Write("<td align='right' class='titulos'><b>" & monto_07.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 8 Then Response.Write("<td align='right' class='titulos'><b>" & monto_08.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 9 Then Response.Write("<td align='right' class='titulos'><b>" & monto_09.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 10 Then Response.Write("<td align='right' class='titulos'><b>" & monto_10.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 11 Then Response.Write("<td align='right' class='titulos'><b>" & monto_11.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 12 Then Response.Write("<td align='right' class='titulos'><b>" & monto_12.ToString("#,###,###") & "</b></td>")

    Dim color As String = "#00B050"
    If monto_erog > debe_ser Then
        If (monto_erog - debe_ser) > 0.10 Then
            color = "#FA1100"
        Else
            color = "#FFFF00"
        End If
    End If
    
    Response.Write("<td align='right' class='titulos'><b>" & monto_tot.ToString("#,###,###") & "</b></td>")
    Response.Write("<td align='center' class='titulos'><b>&nbsp;</b></td>")
    Response.Write("<td align='right' class='titulos'><b>" & monto_pres.ToString("#,###,###") & "</b></td>")
    Response.Write("<td align='center' class='titulos'><b>&nbsp;</b></td>")
    Response.Write("<td align='center' class='' bgcolor='" & color & "'><b>" & monto_erog.ToString("#,###,### %") & "</b></td>")
    'Response.Write("<td align='center' class='titulos'><b>&nbsp;</b></td>")
    'Response.Write("<td align='center' class='titulos'><b>" & debe_ser.ToString("#,###,### %") & "</b></td>")

    
%>
        </tr>

    </table>
    </div>































        

<%
    
    monto_01 = 0
    monto_02 = 0
    monto_03 = 0
    monto_04 = 0
    monto_05 = 0
    monto_06 = 0
    monto_07 = 0
    monto_08 = 0
    monto_09 = 0
    monto_10 = 0
    monto_11 = 0
    monto_12 = 0
    monto_tot = 0
    monto_pres = 0
    debe_ser = 0
    monto_erog = 0
    
    dtRep = dsReporte.Tables(2)
    
%>


    <div id="divReporte_2" style="display:none">
    <br /><br />
    <div style='font-size:20px;'>Resumen DG<span class="linkCopias"><a href="#" onclick="TomaFoto(2);">(Copiar)</a></span></div>

    <table id="tblReporte_2" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td align="center" class="titulos"><b>CENTRO DE COSTOS</b></td>
<%

    For i As Integer = 1 To ULTIMO_MES_CON_DATOS
        Response.Write("<td align='center' class='titulos' nowrap><b>" & i.ToString("00") & " - " & NombrePeriodo(i) & "</b></td>")
    Next
    Response.Write("<td align='center' class='titulos'><b>TOTAL</b></td>")
    Response.Write("<td align='center' class='titulos'><b>&nbsp;</b></td>")
    Response.Write("<td align='center' class='titulos'><b>PRESUPUESTO<br>" & NombrePeriodo(MES) & "/" & ANIO & "</b></td>")
    Response.Write("<td align='center' class='titulos'><b>&nbsp;</b></td>")
    Response.Write("<td align='center' class='titulos'><b>% EROGADO DEL<br>PRESUPUESTO</b></td>")
    'Response.Write("<td align='center' class='titulos'><b>&nbsp;</b></td>")
    'Response.Write("<td align='center' class='titulos'><b>DEBER SER</b></td>")
    
%>
        </tr>
<% 
    For Each dr As DataRow In dtRep.Rows
        monto_01 += dr("mes_01")
        monto_02 += dr("mes_02")
        monto_03 += dr("mes_03")
        monto_04 += dr("mes_04")
        monto_05 += dr("mes_05")
        monto_06 += dr("mes_06")
        monto_07 += dr("mes_07")
        monto_08 += dr("mes_08")
        monto_09 += dr("mes_09")
        monto_10 += dr("mes_10")
        monto_11 += dr("mes_11")
        monto_12 += dr("mes_12")
        monto_tot += dr("total")
        monto_pres += dr("presupuesto")
        If dr("debe_ser") > 0 Then
            debe_ser = dr("debe_ser")
        End If
        If monto_pres = 0 Then
            monto_erog = 1
        Else
            monto_erog = monto_tot / monto_pres
        End If

        
        
        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos columnaTitulos'><b>" & dr("centro_costo") & "</b></td>")

        If ULTIMO_MES_CON_DATOS >= 1 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_01"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 2 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_02"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 3 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_03"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 4 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_04"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 5 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_05"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 6 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_06"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 7 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_07"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 8 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_08"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 9 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_09"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 10 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_10"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 11 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_11"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 12 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_12"), Decimal).ToString("#,###,###") & "</td>")

        Response.Write("<td align='right' class='datos4'>" & CType(dr("total"), Decimal).ToString("#,###,###") & "</td>")
        Response.Write("<td align='center' class=''><b>&nbsp;</b></td>")
        Response.Write("<td align='right' class='datos4'>" & CType(dr("presupuesto"), Decimal).ToString("#,###,###") & "</td>")
        Response.Write("<td align='center' class=''><b>&nbsp;</b></td>")
        Response.Write("<td align='center' class='datos4' bgcolor='" & dr("color") & "'>" & CType(dr("erogado"), Decimal).ToString("#,###,### %") & "</td>")
        'Response.Write("<td align='center' class=''><b>&nbsp;</b></td>")
        'Response.Write("<td align='center' class='datos4'>" & CType(dr("debe_ser"), Decimal).ToString("#,###,### %") & "</td>")

        FILA_ALTERNA = Not FILA_ALTERNA
        Response.Write("</tr>")
        
        
    Next
%>

        <tr class="filaTotales">
<%

    Response.Write("<td align='left' class='titulos'><b>TOTAL</b></td>")

    If ULTIMO_MES_CON_DATOS >= 1 Then Response.Write("<td align='right' class='titulos'><b>" & monto_01.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 2 Then Response.Write("<td align='right' class='titulos'><b>" & monto_02.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 3 Then Response.Write("<td align='right' class='titulos'><b>" & monto_03.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 4 Then Response.Write("<td align='right' class='titulos'><b>" & monto_04.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 5 Then Response.Write("<td align='right' class='titulos'><b>" & monto_05.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 6 Then Response.Write("<td align='right' class='titulos'><b>" & monto_06.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 7 Then Response.Write("<td align='right' class='titulos'><b>" & monto_07.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 8 Then Response.Write("<td align='right' class='titulos'><b>" & monto_08.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 9 Then Response.Write("<td align='right' class='titulos'><b>" & monto_09.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 10 Then Response.Write("<td align='right' class='titulos'><b>" & monto_10.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 11 Then Response.Write("<td align='right' class='titulos'><b>" & monto_11.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 12 Then Response.Write("<td align='right' class='titulos'><b>" & monto_12.ToString("#,###,###") & "</b></td>")

    color = "#00B050"
    If monto_erog > debe_ser Then
        If (monto_erog - debe_ser) > 0.1 Then
            color = "#FA1100"
        Else
            color = "#FFFF00"
        End If
    End If
    
    Response.Write("<td align='right' class='titulos'><b>" & monto_tot.ToString("#,###,###") & "</b></td>")
    Response.Write("<td align='center' class='titulos'><b>&nbsp;</b></td>")
    Response.Write("<td align='right' class='titulos'><b>" & monto_pres.ToString("#,###,###") & "</b></td>")
    Response.Write("<td align='center' class='titulos'><b>&nbsp;</b></td>")
    Response.Write("<td align='center' class='' bgcolor='" & color & "'><b>" & monto_erog.ToString("#,###,### %") & "</b></td>")
    'Response.Write("<td align='center' class='titulos'><b>&nbsp;</b></td>")
    'Response.Write("<td align='center' class='titulos'><b>" & debe_ser.ToString("#,###,### %") & "</b></td>")

    
%>
        </tr>

    </table>
    </div>

















        

<%
    Dim tituloDinamico As String = ""
    For numReporte = 3 To 10    


        monto_01 = 0
        monto_02 = 0
        monto_03 = 0
        monto_04 = 0
        monto_05 = 0
        monto_06 = 0
        monto_07 = 0
        monto_08 = 0
        monto_09 = 0
        monto_10 = 0
        monto_11 = 0
        monto_12 = 0
        monto_tot = 0
        monto_pres = 0
        debe_ser = 0
        monto_erog = 0
    
        dtRep = dsReporte.Tables(numReporte)
    
        If dtRep.Rows.Count > 0 Then
            tituloDinamico = dtRep.Rows(0)("centro_costo")
        End If
%>


    <div id="divReporte_<%=numReporte %>" style="display:none">
    <br /><br /><br />
    <div style='font-size:20px;'><%=tituloDinamico%><span class="linkCopias"><a href="#" onclick="TomaFoto(<%=numReporte %>);">(Copiar)</a></span></div>

    <table id="tblReporte_<%=numReporte %>" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td align="center" class="titulos"><b><%=tituloDinamico%></b></td>
<%

    For i As Integer = 1 To ULTIMO_MES_CON_DATOS
        Response.Write("<td align='center' class='titulos' nowrap><b>" & i.ToString("00") & " - " & NombrePeriodo(i) & "</b></td>")
    Next
    Response.Write("<td align='center' class='titulos'><b>TOTAL</b></td>")
    Response.Write("<td align='center' class='titulos'><b>&nbsp;</b></td>")
    Response.Write("<td align='center' class='titulos'><b>PRESUPUESTO<br>" & NombrePeriodo(MES) & "/" & ANIO & "</b></td>")
    Response.Write("<td align='center' class='titulos'><b>&nbsp;</b></td>")
    Response.Write("<td align='center' class='titulos'><b>% EROGADO DEL<br>PRESUPUESTO</b></td>")
    'Response.Write("<td align='center' class='titulos'><b>&nbsp;</b></td>")
    'Response.Write("<td align='center' class='titulos'><b>DEBER SER</b></td>")
    
%>
        </tr>
<% 
    For Each dr As DataRow In dtRep.Rows
        monto_01 += dr("mes_01")
        monto_02 += dr("mes_02")
        monto_03 += dr("mes_03")
        monto_04 += dr("mes_04")
        monto_05 += dr("mes_05")
        monto_06 += dr("mes_06")
        monto_07 += dr("mes_07")
        monto_08 += dr("mes_08")
        monto_09 += dr("mes_09")
        monto_10 += dr("mes_10")
        monto_11 += dr("mes_11")
        monto_12 += dr("mes_12")
        monto_tot += dr("total")
        monto_pres += dr("presupuesto")
        If dr("debe_ser") > 0 Then
            debe_ser = dr("debe_ser")
        End If
        If monto_pres = 0 Then
            monto_erog = 1
        Else
            monto_erog = monto_tot / monto_pres
        End If
     
        
        
        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos columnaTitulos'><b>" & dr("descripcion") & "</b></td>")

        If ULTIMO_MES_CON_DATOS >= 1 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_01"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 2 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_02"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 3 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_03"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 4 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_04"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 5 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_05"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 6 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_06"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 7 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_07"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 8 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_08"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 9 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_09"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 10 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_10"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 11 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_11"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 12 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_12"), Decimal).ToString("#,###,###") & "</td>")

        Response.Write("<td align='right' class='datos4'>" & CType(dr("total"), Decimal).ToString("#,###,###") & "</td>")
        Response.Write("<td align='center' class=''><b>&nbsp;</b></td>")
        Response.Write("<td align='right' class='datos4'>" & CType(dr("presupuesto"), Decimal).ToString("#,###,###") & "</td>")
        Response.Write("<td align='center' class=''><b>&nbsp;</b></td>")
        Response.Write("<td align='center' class='datos4' bgcolor='" & dr("color") & "'>" & CType(dr("erogado"), Decimal).ToString("#,###,### %") & "</td>")
        'Response.Write("<td align='center' class=''><b>&nbsp;</b></td>")
        'Response.Write("<td align='center' class='datos4'>" & CType(dr("debe_ser"), Decimal).ToString("#,###,### %") & "</td>")

        FILA_ALTERNA = Not FILA_ALTERNA
        Response.Write("</tr>")
        
        
    Next
%>

        <tr class="filaTotales">
<%

    Response.Write("<td align='left' class='titulos'><b>TOTAL " & tituloDinamico & "</b></td>")

    If ULTIMO_MES_CON_DATOS >= 1 Then Response.Write("<td align='right' class='titulos'><b>" & monto_01.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 2 Then Response.Write("<td align='right' class='titulos'><b>" & monto_02.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 3 Then Response.Write("<td align='right' class='titulos'><b>" & monto_03.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 4 Then Response.Write("<td align='right' class='titulos'><b>" & monto_04.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 5 Then Response.Write("<td align='right' class='titulos'><b>" & monto_05.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 6 Then Response.Write("<td align='right' class='titulos'><b>" & monto_06.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 7 Then Response.Write("<td align='right' class='titulos'><b>" & monto_07.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 8 Then Response.Write("<td align='right' class='titulos'><b>" & monto_08.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 9 Then Response.Write("<td align='right' class='titulos'><b>" & monto_09.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 10 Then Response.Write("<td align='right' class='titulos'><b>" & monto_10.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 11 Then Response.Write("<td align='right' class='titulos'><b>" & monto_11.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 12 Then Response.Write("<td align='right' class='titulos'><b>" & monto_12.ToString("#,###,###") & "</b></td>")

    
    color = "#00B050"
    If monto_erog > debe_ser Then
        If (monto_erog - debe_ser) > 0.10 Then
            color = "#FA1100"
        Else
            color = "#FFFF00"
        End If
    End If
    
    Response.Write("<td align='right' class='titulos'><b>" & monto_tot.ToString("#,###,###") & "</b></td>")
    Response.Write("<td align='center' class='titulos'><b>&nbsp;</b></td>")
    Response.Write("<td align='right' class='titulos'><b>" & monto_pres.ToString("#,###,###") & "</b></td>")
    Response.Write("<td align='center' class='titulos'><b>&nbsp;</b></td>")
    Response.Write("<td align='center' class='' bgcolor='" & color & "'><b>" & monto_erog.ToString("#,###,### %") & "</b></td>")
    'Response.Write("<td align='center' class='titulos'><b>&nbsp;</b></td>")
    'Response.Write("<td align='center' class='titulos'><b>" & debe_ser.ToString("#,###,### %") & "</b></td>")

    
%>
        </tr>

    </table>
    </div>


<%
    Next            
%>


















<div id="divAnexos" style="display:none"><br /><br /><br /><span style="font-weight:bold;font-size:25px">ANEXOS</span></div>

<%
    tituloDinamico = ""
    For numReporte = 11 To 15


        monto_01 = 0
        monto_02 = 0
        monto_03 = 0
        monto_04 = 0
        monto_05 = 0
        monto_06 = 0
        monto_07 = 0
        monto_08 = 0
        monto_09 = 0
        monto_10 = 0
        monto_11 = 0
        monto_12 = 0
        monto_tot = 0
    
        sub_monto_01 = 0
        sub_monto_02 = 0
        sub_monto_03 = 0
        sub_monto_04 = 0
        sub_monto_05 = 0
        sub_monto_06 = 0
        sub_monto_07 = 0
        sub_monto_08 = 0
        sub_monto_09 = 0
        sub_monto_10 = 0
        sub_monto_11 = 0
        sub_monto_12 = 0
        sub_monto_tot = 0
    
        dtRep = dsReporte.Tables(numReporte)
    
        If dtRep.Rows.Count > 0 Then
            tituloDinamico = dtRep.Rows(0)("descripcion")
        End If
%>


    <div id="divReporte_<%=numReporte %>" style="display:none">
    <br /><br /><br />
    <div style='font-size:20px;'>Detalle de Gastos - <%=IIf(tituloDinamico = "ARREND. AUTOS ND", "ARREND. AUTOS NO DEDUCIBLES", tituloDinamico)%><span class="linkCopias"><a href="#" onclick="TomaFoto(<%=numReporte %>);">(Copiar)</a></span></div>

    <table id="tblReporte_<%=numReporte %>" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td align="center" class="titulos"><b><%=tituloDinamico%></b></td>
            <td align="center" class="titulos"><b>DENOMINACIÓN</b></td>
<%

    For i As Integer = 1 To ULTIMO_MES_CON_DATOS
        Response.Write("<td align='center' class='titulos' nowrap><b>" & i.ToString("00") & " - " & NombrePeriodo(i) & "</b></td>")
    Next
    Response.Write("<td align='center' class='titulos'><b>TOTAL</b></td>")
    
%>
        </tr>
<% 
    Dim ULTIMO_CC As String = ""
    For Each dr As DataRow In dtRep.Rows
        
        
        If ULTIMO_CC <> "" And ULTIMO_CC <> dr("centro_costo") Then
        Response.Write("<tr class='filaTotales'>")

            Response.Write("<td align='left' colspan='2' class='sub_titulos'><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TOTAL " & ULTIMO_CC & "</b></td>")

            If ULTIMO_MES_CON_DATOS >= 1 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_01.ToString("#,###,###") & "</b></td>")
            If ULTIMO_MES_CON_DATOS >= 2 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_02.ToString("#,###,###") & "</b></td>")
            If ULTIMO_MES_CON_DATOS >= 3 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_03.ToString("#,###,###") & "</b></td>")
            If ULTIMO_MES_CON_DATOS >= 4 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_04.ToString("#,###,###") & "</b></td>")
            If ULTIMO_MES_CON_DATOS >= 5 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_05.ToString("#,###,###") & "</b></td>")
            If ULTIMO_MES_CON_DATOS >= 6 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_06.ToString("#,###,###") & "</b></td>")
            If ULTIMO_MES_CON_DATOS >= 7 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_07.ToString("#,###,###") & "</b></td>")
            If ULTIMO_MES_CON_DATOS >= 8 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_08.ToString("#,###,###") & "</b></td>")
            If ULTIMO_MES_CON_DATOS >= 9 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_09.ToString("#,###,###") & "</b></td>")
            If ULTIMO_MES_CON_DATOS >= 10 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_10.ToString("#,###,###") & "</b></td>")
            If ULTIMO_MES_CON_DATOS >= 11 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_11.ToString("#,###,###") & "</b></td>")
            If ULTIMO_MES_CON_DATOS >= 12 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_12.ToString("#,###,###") & "</b></td>")
    
            Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_tot.ToString("#,###,###") & "</b></td>")
            Response.Write("</tr>")
            
            
            
            sub_monto_01 = 0
            sub_monto_02 = 0
            sub_monto_03 = 0
            sub_monto_04 = 0
            sub_monto_05 = 0
            sub_monto_06 = 0
            sub_monto_07 = 0
            sub_monto_08 = 0
            sub_monto_09 = 0
            sub_monto_10 = 0
            sub_monto_11 = 0
            sub_monto_12 = 0
            sub_monto_tot = 0
        End If
        
        sub_monto_01 += dr("mes_01")
        sub_monto_02 += dr("mes_02")
        sub_monto_03 += dr("mes_03")
        sub_monto_04 += dr("mes_04")
        sub_monto_05 += dr("mes_05")
        sub_monto_06 += dr("mes_06")
        sub_monto_07 += dr("mes_07")
        sub_monto_08 += dr("mes_08")
        sub_monto_09 += dr("mes_09")
        sub_monto_10 += dr("mes_10")
        sub_monto_11 += dr("mes_11")
        sub_monto_12 += dr("mes_12")
        sub_monto_tot += dr("total")

        
        monto_01 += dr("mes_01")
        monto_02 += dr("mes_02")
        monto_03 += dr("mes_03")
        monto_04 += dr("mes_04")
        monto_05 += dr("mes_05")
        monto_06 += dr("mes_06")
        monto_07 += dr("mes_07")
        monto_08 += dr("mes_08")
        monto_09 += dr("mes_09")
        monto_10 += dr("mes_10")
        monto_11 += dr("mes_11")
        monto_12 += dr("mes_12")
        monto_tot += dr("total")
     
        
        
        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos columnaTitulos'><b>" & dr("centro_costo") & "</b></td>")
        Response.Write("<td align='left' class='subtitulos columnaTitulos'><b>" & dr("denom_cta_comp") & "</b></td>")

        If ULTIMO_MES_CON_DATOS >= 1 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_01"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 2 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_02"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 3 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_03"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 4 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_04"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 5 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_05"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 6 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_06"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 7 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_07"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 8 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_08"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 9 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_09"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 10 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_10"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 11 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_11"), Decimal).ToString("#,###,###") & "</td>")
        If ULTIMO_MES_CON_DATOS >= 12 Then Response.Write("<td align='right' class='datos3'>" & CType(dr("mes_12"), Decimal).ToString("#,###,###") & "</td>")

        Response.Write("<td align='right' class='datos4'>" & CType(dr("total"), Decimal).ToString("#,###,###") & "</td>")
 
        FILA_ALTERNA = Not FILA_ALTERNA
        Response.Write("</tr>")
        
        ULTIMO_CC = dr("centro_costo")
    Next
    
    If ULTIMO_CC <> "" Then
        Response.Write("<tr class='filaTotales'>")

        Response.Write("<td align='left' colspan='2' class='sub_titulos'><b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;TOTAL " & ULTIMO_CC & "</b></td>")

        If ULTIMO_MES_CON_DATOS >= 1 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_01.ToString("#,###,###") & "</b></td>")
        If ULTIMO_MES_CON_DATOS >= 2 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_02.ToString("#,###,###") & "</b></td>")
        If ULTIMO_MES_CON_DATOS >= 3 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_03.ToString("#,###,###") & "</b></td>")
        If ULTIMO_MES_CON_DATOS >= 4 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_04.ToString("#,###,###") & "</b></td>")
        If ULTIMO_MES_CON_DATOS >= 5 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_05.ToString("#,###,###") & "</b></td>")
        If ULTIMO_MES_CON_DATOS >= 6 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_06.ToString("#,###,###") & "</b></td>")
        If ULTIMO_MES_CON_DATOS >= 7 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_07.ToString("#,###,###") & "</b></td>")
        If ULTIMO_MES_CON_DATOS >= 8 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_08.ToString("#,###,###") & "</b></td>")
        If ULTIMO_MES_CON_DATOS >= 9 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_09.ToString("#,###,###") & "</b></td>")
        If ULTIMO_MES_CON_DATOS >= 10 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_10.ToString("#,###,###") & "</b></td>")
        If ULTIMO_MES_CON_DATOS >= 11 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_11.ToString("#,###,###") & "</b></td>")
        If ULTIMO_MES_CON_DATOS >= 12 Then Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_12.ToString("#,###,###") & "</b></td>")
    
        Response.Write("<td align='right' class='sub_titulos'><b>" & sub_monto_tot.ToString("#,###,###") & "</b></td>")
        Response.Write("</tr>")
            
            
            
        sub_monto_01 = 0
        sub_monto_02 = 0
        sub_monto_03 = 0
        sub_monto_04 = 0
        sub_monto_05 = 0
        sub_monto_06 = 0
        sub_monto_07 = 0
        sub_monto_08 = 0
        sub_monto_09 = 0
        sub_monto_10 = 0
        sub_monto_11 = 0
        sub_monto_12 = 0
        sub_monto_tot = 0
    End If
    
    
%>

        <tr class="filaTotales">
<%

    Response.Write("<td align='left' colspan='2' class='titulos'><b>TOTAL " & tituloDinamico & "</b></td>")

    If ULTIMO_MES_CON_DATOS >= 1 Then Response.Write("<td align='right' class='titulos'><b>" & monto_01.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 2 Then Response.Write("<td align='right' class='titulos'><b>" & monto_02.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 3 Then Response.Write("<td align='right' class='titulos'><b>" & monto_03.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 4 Then Response.Write("<td align='right' class='titulos'><b>" & monto_04.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 5 Then Response.Write("<td align='right' class='titulos'><b>" & monto_05.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 6 Then Response.Write("<td align='right' class='titulos'><b>" & monto_06.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 7 Then Response.Write("<td align='right' class='titulos'><b>" & monto_07.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 8 Then Response.Write("<td align='right' class='titulos'><b>" & monto_08.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 9 Then Response.Write("<td align='right' class='titulos'><b>" & monto_09.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 10 Then Response.Write("<td align='right' class='titulos'><b>" & monto_10.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 11 Then Response.Write("<td align='right' class='titulos'><b>" & monto_11.ToString("#,###,###") & "</b></td>")
    If ULTIMO_MES_CON_DATOS >= 12 Then Response.Write("<td align='right' class='titulos'><b>" & monto_12.ToString("#,###,###") & "</b></td>")

    
    Response.Write("<td align='right' class='titulos'><b>" & monto_tot.ToString("#,###,###") & "</b></td>")

    
%>
        </tr>

    </table>
    </div>


<%
    Next            
%>













            <br /><br /><br />
            <div id="divFotos" style="display:none">

            </div>

        </div>
    </form>
</body>
<script type="text/javascript">
    //window.print();
</script>
</html>

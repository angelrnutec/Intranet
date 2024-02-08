<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepGastosNSEjecutivoNegocioImpresion.aspx.vb" Inherits="Intranet.RepGastosNSEjecutivoNegocioImpresion" %>

<%@ Import Namespace="Intranet" %>
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
                for (i = 1; i <= 16; i++) {
                    if (document.getElementById('divReporte_' + i) != null && document.getElementById('lnkReporte_' + i)!=null) {
                        document.getElementById('divReporte_' + i).style.display = 'none';
                        document.getElementById('lnkReporte_' + i).className = '';
                    }
                }
                if (document.getElementById('divReporte_' + reporte) != null) {
                    document.getElementById('divReporte_' + reporte).style.display = '';
                    document.getElementById('lnkReporte_' + reporte).className = 'colorSel';
                }
                document.getElementById('lnkReporte_99').className = '';
            }
            else {
                for (i = 1; i <= 16; i++) {
                    if (document.getElementById('divReporte_' + i) != null && document.getElementById('lnkReporte_' + i) != null) {
                        document.getElementById('divReporte_' + i).style.display = '';
                        document.getElementById('lnkReporte_' + i).className = '';
                    }
                }
                document.getElementById('lnkReporte_' + reporte).className = 'colorSel';
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
                <ul id="ulMenu1">
<%--                    <li><a id='lnkReporte_1' class='colorSel' href='#' onclick='SeleccionaReporte(1);'>Reporte de Gastos NS por Mes</a></li>
                    <li><a id='lnkReporte_2' href='#' onclick='SeleccionaReporte(2);'>610101 - ADMINISTRACION</a></li>
                    <li><a id='lnkReporte_3' href='#' onclick='SeleccionaReporte(3);'>610102 - HELICOPTERO</a></li>
                    <li><a id='lnkReporte_4' href='#' onclick='SeleccionaReporte(4);'>610103 - CECAP</a></li>
                    <li><a id='lnkReporte_5' href='#' onclick='SeleccionaReporte(5);'>610104 - BE GFC</a></li>
                    <li><a id='lnkReporte_6' href='#' onclick='SeleccionaReporte(6);'>620101 - DG GFC</a></li>
                    <li><a id='lnkReporte_7' href='#' onclick='SeleccionaReporte(7);'>620102 - DG GCB</a></li>
                    <li><a id='lnkReporte_8' href='#' onclick='SeleccionaReporte(8);'>620751 - BE GCB</a></li>
                    <li><a id='lnkReporte_9' href='#' onclick='SeleccionaReporte(9);'>620752 - BE ZCD</a></li>--%>
                </ul>
            </td>
            <td>&nbsp;&nbsp;&nbsp;</td>
            <td>
                <ul id='ulMenu2'>
<%--                    <li><a id='lnkReporte_10' href='#' onclick='SeleccionaReporte(10);'>620753 - BE CCD</a></li>
                    <li><a id='lnkReporte_11' href='#' onclick='SeleccionaReporte(11);'>620851 - RECURSOS HUMANOS</a></li>
                    <li><a id='lnkReporte_12' href='#' onclick='SeleccionaReporte(12);'>620852 - SEG INTERNA</a></li>
                    <li><a id='lnkReporte_13' href='#' onclick='SeleccionaReporte(13);'>630101 - SISTEMAS</a></li>
                    <li><a id='lnkReporte_14' href='#' onclick='SeleccionaReporte(14);'>Gastos NBR por Centro de Costo</a></li>
                    <li><a id='lnkReporte_15' href='#' onclick='SeleccionaReporte(15);'>Gastos NBR por Cuenta Acumulado</a></li>
                    <li><a id='lnkReporte_16' href='#' onclick='SeleccionaReporte(16);'>Estado de Resultados</a></li>
                    <li><a id='lnkReporte_99' href='#' onclick='SeleccionaReporte(99);'>Mostrar todos los reportes</a></li>--%>
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
    If Session("idEmpleado") Is Nothing Then
        Response.Write("<br><br><br><b>Favor de volver a iniciar sesion. <a href='/'>Click aqui.</a></b>")
    Else
        Dim rep_actual As Integer = 0
        Dim menuItems As New List(Of MenuItems)
        menuItems.Add(New MenuItems With {.num_rep = 1, .activo = False, .valor = "<li><a id='lnkReporte_1' class='colorSel' href='#' onclick='SeleccionaReporte(1);'>Reporte de Gastos NS por Mes</a></li>"})
        menuItems.Add(New MenuItems With {.num_rep = 2, .activo = False, .valor = "<li><a id='lnkReporte_2' href='#' onclick='SeleccionaReporte(2);'>610101 - ADMINISTRACION</a></li>"})
        menuItems.Add(New MenuItems With {.num_rep = 3, .activo = False, .valor = "<li><a id='lnkReporte_3' href='#' onclick='SeleccionaReporte(3);'>610102 - HELICOPTERO</a></li>"})
        menuItems.Add(New MenuItems With {.num_rep = 4, .activo = False, .valor = "<li><a id='lnkReporte_4' href='#' onclick='SeleccionaReporte(4);'>610103 - CECAP</a></li>"})
        menuItems.Add(New MenuItems With {.num_rep = 5, .activo = False, .valor = "<li><a id='lnkReporte_5' href='#' onclick='SeleccionaReporte(5);'>610104 - BE GFC</a></li>"})
        menuItems.Add(New MenuItems With {.num_rep = 6, .activo = False, .valor = "<li><a id='lnkReporte_6' href='#' onclick='SeleccionaReporte(6);'>620101 - DG GFC</a></li>"})
        menuItems.Add(New MenuItems With {.num_rep = 7, .activo = False, .valor = "<li><a id='lnkReporte_7' href='#' onclick='SeleccionaReporte(7);'>620102 - DG GCB</a></li>"})
        menuItems.Add(New MenuItems With {.num_rep = 8, .activo = False, .valor = "<li><a id='lnkReporte_8' href='#' onclick='SeleccionaReporte(8);'>620751 - BE GCB</a></li>"})
        menuItems.Add(New MenuItems With {.num_rep = 9, .activo = False, .valor = "<li><a id='lnkReporte_9' href='#' onclick='SeleccionaReporte(9);'>620752 - BE ZCD</a></li>"})
        menuItems.Add(New MenuItems With {.num_rep = 10, .activo = False, .valor = "<li><a id='lnkReporte_10' href='#' onclick='SeleccionaReporte(10);'>620753 - BE CCD</a></li>"})
        menuItems.Add(New MenuItems With {.num_rep = 11, .activo = False, .valor = "<li><a id='lnkReporte_11' href='#' onclick='SeleccionaReporte(11);'>620851 - RECURSOS HUMANOS</a></li>"})
        menuItems.Add(New MenuItems With {.num_rep = 12, .activo = False, .valor = "<li><a id='lnkReporte_12' href='#' onclick='SeleccionaReporte(12);'>620852 - SEG INTERNA</a></li>"})
        menuItems.Add(New MenuItems With {.num_rep = 13, .activo = False, .valor = "<li><a id='lnkReporte_13' href='#' onclick='SeleccionaReporte(13);'>630101 - SISTEMAS</a></li>"})
        menuItems.Add(New MenuItems With {.num_rep = 14, .activo = False, .valor = "<li><a id='lnkReporte_14' href='#' onclick='SeleccionaReporte(14);'>Gastos NBR por Centro de Costo</a></li>"})
        menuItems.Add(New MenuItems With {.num_rep = 15, .activo = False, .valor = "<li><a id='lnkReporte_15' href='#' onclick='SeleccionaReporte(15);'>Gastos NBR por Cuenta Acumulado</a></li>"})
        menuItems.Add(New MenuItems With {.num_rep = 16, .activo = False, .valor = "<li><a id='lnkReporte_16' href='#' onclick='SeleccionaReporte(16);'>Estado de Resultados</a></li>"})
        menuItems.Add(New MenuItems With {.num_rep = 99, .activo = True, .valor = "<li><a id='lnkReporte_99' href='#' onclick='SeleccionaReporte(99);'>Mostrar todos los reportes</a></li>"})
    
    
    
    
    
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
        rep_actual += 1
        If dtRep.Rows.Count > 0 Then
            menuItems.Where(Function(x) x.num_rep = rep_actual).SingleOrDefault().activo = True
        End If
%>


    <div id="divReporte_1" style="">
    <br /><br />
    <div style='font-size:20px;'>Reporte de Gastos NS por Mes<span class="linkCopias"><a href="#" onclick="TomaFoto(1);">(Copiar)</a></span></div>

    <table id="tblReporte_1" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td align="center" class="titulos"><b>Descripción</b></td>
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
    Dim tituloDinamico As String = ""
    For numReporte = 2 To 13


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
        rep_actual += 1
        If dtRep.Rows.Count > 0 Then
            menuItems.Where(Function(x) x.num_rep = rep_actual).SingleOrDefault().activo = True
        End If
    
        If dtRep.Rows.Count > 0 Then
            tituloDinamico = dtRep.Rows(0)("centro_costo")
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
Else
%>
            <div id="divReporte_<%=numReporte %>" style="display:none"><br><br><br><b>Reporte no disponible</b></div>

<%    
End If

    Next            
%>




















        

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
    
    dtRep = dsReporte.Tables(14)
    rep_actual += 1
    If dtRep.Rows.Count > 0 Then
        menuItems.Where(Function(x) x.num_rep = rep_actual).SingleOrDefault().activo = True
    End If
    
    If dtRep.Rows.Count > 0 Then
%>


    <div id="divReporte_14" style="display:none">
    <br /><br /><br />
    <div style='font-size:20px;'>Gastos NBR por Centro de Costo<span class="linkCopias"><a href="#" onclick="TomaFoto(14);">(Copiar)</a></span></div>

    <table id="tblReporte_14" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td align="center" class="titulos"><b>CENTRO DE COSTO</b></td>
            <td align="center" class="titulos"><b>NEGOCIO</b></td>
            <td align="center" class="titulos"><b>POR NEGOCIO</b></td>
            <td align="center" class="titulos"><b>BOARD EXPENSE</b></td>
            <td align="center" class="titulos">&nbsp;</td>
            <td align="center" class="titulos"><b>PRESUPUESTO<br><%= NombrePeriodo(MES) & "/" & ANIO%></b></td>
            <td align="center" class="titulos"><b>&nbsp;</b></td>
            <td align="center" class="titulos"><b>% EROGADO DEL<br>PRESUPUESTO</b></td>
        </tr>
<% 
    For Each dr As DataRow In dtRep.Rows
        
        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos columnaTitulos'><b>" & dr("centro_costo") & "</b></td>")

        Response.Write("<td align='right' class='datos3'>" & CType(dr("negocio"), Decimal).ToString("#,###,###") & "</td>")
        Response.Write("<td align='right' class='datos3'>" & CType(dr("por_negocio"), Decimal).ToString("#,###,###") & "</td>")
        Response.Write("<td align='right' class='datos3'>" & CType(dr("board_expense"), Decimal).ToString("#,###,###") & "</td>")

        Response.Write("<td align='center' class=''><b>&nbsp;</b></td>")
        Response.Write("<td align='right' class='datos4'>" & CType(dr("presupuesto"), Decimal).ToString("#,###,###") & "</td>")
        Response.Write("<td align='center' class=''><b>&nbsp;</b></td>")

        If dr("id") >= 15 Or dr("id") = 13 Then
            Response.Write("<td align='center' class=''><b>&nbsp;</b></td>")
        Else
            Response.Write("<td align='center' class='datos4' bgcolor='" & dr("color") & "'>" & CType(dr("erogado"), Decimal).ToString("#,###,### %") & "</td>")
        End If

        Response.Write("</tr>")
        
        
    Next
%>



    </table>
    </div>


<%
Else
%>
    <div id="divReporte_14" style="display:none"><br><br><br><b>Reporte no disponible</b></div>
<%
End If

%>


















        
















        

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
    
    dtRep = dsReporte.Tables(15)
    rep_actual += 1
    If dtRep.Rows.Count > 0 Then
        menuItems.Where(Function(x) x.num_rep = rep_actual).SingleOrDefault().activo = True
    End If
    
    If dtRep.Rows.Count > 0 Then
%>


    <div id="divReporte_15" style="display:none">
    <br /><br /><br />
    <div style='font-size:20px;'>Gastos NBR por Cuenta Acumulado<span class="linkCopias"><a href="#" onclick="TomaFoto(15);">(Copiar)</a></span></div>

    <table id="tblReporte_15" border="1" cellpadding="0" cellspacing="0">
        <tr class="filaTotales">
            <td align="center" class="titulos"><b>DESCRIPCION</b></td>
            <td align="center" class="titulos"><b>BE GCB</b></td>
            <td align="center" class="titulos"><b>BE GFC</b></td>
            <td align="center" class="titulos"><b>CECAP</b></td>
            <td align="center" class="titulos"><b>DG GCB</b></td>
            <td align="center" class="titulos"><b>DG GFC</b></td>
            <td align="center" class="titulos"><b>HELICOPTERO</b></td>
            <td align="center" class="titulos"><b>BE CCD</b></td>
            <td align="center" class="titulos"><b>BE ZCD</b></td>
            <td align="center" class="titulos"><b>TOTAL</b></td>
            <td align="center" class="titulos"><b>&nbsp;</b></td>
            <td align="center" class="titulos"><b>PRESUPUESTO<br><%= NombrePeriodo(MES) & "/" & ANIO%></b></td>
            <td align="center" class="titulos"><b>&nbsp;</b></td>
            <td align="center" class="titulos"><b>% EROGADO DEL<br>PRESUPUESTO</b></td>
        </tr>
<% 
    For Each dr As DataRow In dtRep.Rows
        monto_01 += dr("BEGCB")
        monto_02 += dr("BEGFC")
        monto_03 += dr("CECAP")
        monto_04 += dr("DGGCB")
        monto_05 += dr("DGGFC")
        monto_06 += dr("HELICOPTERO")
        monto_07 += dr("BECCD")
        monto_08 += dr("BEZCD")
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

        Response.Write("<td align='right' class='datos3'>" & CType(dr("BEGCB"), Decimal).ToString("#,###,###") & "</td>")
        Response.Write("<td align='right' class='datos3'>" & CType(dr("BEGFC"), Decimal).ToString("#,###,###") & "</td>")
        Response.Write("<td align='right' class='datos3'>" & CType(dr("CECAP"), Decimal).ToString("#,###,###") & "</td>")
        Response.Write("<td align='right' class='datos3'>" & CType(dr("DGGCB"), Decimal).ToString("#,###,###") & "</td>")
        Response.Write("<td align='right' class='datos3'>" & CType(dr("DGGFC"), Decimal).ToString("#,###,###") & "</td>")
        Response.Write("<td align='right' class='datos3'>" & CType(dr("HELICOPTERO"), Decimal).ToString("#,###,###") & "</td>")
        Response.Write("<td align='right' class='datos3'>" & CType(dr("BECCD"), Decimal).ToString("#,###,###") & "</td>")
        Response.Write("<td align='right' class='datos3'>" & CType(dr("BEZCD"), Decimal).ToString("#,###,###") & "</td>")
        Response.Write("<td align='right' class='datos3'>" & CType(dr("total"), Decimal).ToString("#,###,###") & "</td>")

        Response.Write("<td align='center' class=''><b>&nbsp;</b></td>")
        Response.Write("<td align='right' class='datos4'>" & CType(dr("presupuesto"), Decimal).ToString("#,###,###") & "</td>")
        Response.Write("<td align='center' class=''><b>&nbsp;</b></td>")
        Response.Write("<td align='center' class='datos4' bgcolor='" & dr("color") & "'>" & CType(dr("erogado"), Decimal).ToString("#,###,### %") & "</td>")

        Response.Write("</tr>")
        
        
    Next
%>

        <tr class="filaTotales">
<%

    Response.Write("<td align='left' class='titulos'><b>TOTAL</b></td>")

    Response.Write("<td align='right' class='titulos'><b>" & monto_01.ToString("#,###,###") & "</b></td>")
    Response.Write("<td align='right' class='titulos'><b>" & monto_02.ToString("#,###,###") & "</b></td>")
    Response.Write("<td align='right' class='titulos'><b>" & monto_03.ToString("#,###,###") & "</b></td>")
    Response.Write("<td align='right' class='titulos'><b>" & monto_04.ToString("#,###,###") & "</b></td>")
    Response.Write("<td align='right' class='titulos'><b>" & monto_05.ToString("#,###,###") & "</b></td>")
    Response.Write("<td align='right' class='titulos'><b>" & monto_06.ToString("#,###,###") & "</b></td>")
    Response.Write("<td align='right' class='titulos'><b>" & monto_07.ToString("#,###,###") & "</b></td>")
    Response.Write("<td align='right' class='titulos'><b>" & monto_08.ToString("#,###,###") & "</b></td>")

    
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
Else
%>
    <div id="divReporte_15" style="display:none"><br><br><br><b>Reporte no disponible</b></div>

<%
End If

%>










<%
    dtRep = ReporteGastosNSEdoRes()
    rep_actual += 1
    If dtRep.Rows.Count > 0 Then
        menuItems.Where(Function(x) x.num_rep = rep_actual).SingleOrDefault().activo = True
    End If
    If dtRep.Rows.Count > 0 Then
%>



<div id="divReporte_16" style="display:none">
    <br /><br /><br />
    <div style='font-size:20px;'>Estado de Resultados - <%= anio & " vs " & (anio - 1)%> Incluyendo NBR (Acumu hasta <%=NombrePeriodo(mes)%>, Moneda: <%=Request.QueryString("mon") %>)<span class="linkCopias"><a href="#" onclick="TomaFoto(16);">(Copiar)</a></span></div>


    <table id="tblReporte_16" border="1" cellpadding="0" cellspacing="1">
        <tr class="filaTotales">
            <td rowspan="2" align="center" class="titulos"><b>CONCEPTO</b></td>
            <td>&nbsp;</td>
            <td colspan="4" align="center" class="titulos"><b>HORNOS</b></td>
            <td>&nbsp;</td>
            <td colspan="4" align="center" class="titulos"><b>FIBRAS</b></td>
            <td>&nbsp;</td>
            <td colspan="4" align="center" class="titulos"><b>CONSOLIDADO</b></td>
        </tr>
        <tr class="filaTotales">
            <td>&nbsp;</td>
            <td align='center' class='titulos'><b><%=anio%></b><div style='float:right'>&nbsp;&nbsp;&nbsp;%</div></td>
            <td align='center' class='titulos'><b><%=(anio-1)%></b><div style='float:right'>&nbsp;&nbsp;&nbsp;%</div></td>
            <td align='center' class='titulos'><b>R-P($)</b></td>
            <td align='center' class='titulos'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos'><b><%=anio%></b><div style='float:right'>&nbsp;&nbsp;&nbsp;%</div></td>
            <td align='center' class='titulos'><b><%=(anio-1)%></b><div style='float:right'>&nbsp;&nbsp;&nbsp;%</div></td>
            <td align='center' class='titulos'><b>R-P($)</b></td>
            <td align='center' class='titulos'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
            <td>&nbsp;</td>
            <td align='center' class='titulos'><b><%=anio%></b><div style='float:right'>&nbsp;&nbsp;&nbsp;%</div></td>
            <td align='center' class='titulos'><b><%=(anio-1)%></b><div style='float:right'>&nbsp;&nbsp;&nbsp;%</div></td>
            <td align='center' class='titulos'><b><%=(anio - 2000) & "-" & (anio - 1 - 2000)%></b></td>
        </tr>
<% 
    Dim colAlterna As Boolean = False
    Dim imprimir_separador As Boolean = False

    For Each dr As DataRow In dtRep.Rows
        colAlterna = False

        If imprimir_separador Then
            Response.Write("<tr><td colspan='15'><div style='height:7px'></div></td></tr>")
        End If

        Response.Write("<tr>")
        Response.Write("<td align='left' class='subtitulos columnaTitulos' style='" & IIf(dr("permite_captura") = False, "font-weight:bold;", "") & "'>" & dr("descripcion") & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 1, 1) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 1, 2) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 1, 3) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 1, 4) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 2, 5) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 2, 6) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 2, 7) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 2, 8) & "</td>")
        Response.Write("<td>&nbsp;</td>")
        
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 3, 9) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 3, 10) & "</td>")
        colAlterna = Not colAlterna
        Response.Write("<td align='center' class='datos" & IIf(colAlterna, " columnaAlterna", "") & "'>" & FormateaValorRep3(dr, 3, 11) & "</td>")

        Response.Write("</tr>")
        
        imprimir_separador = dr("separador_despues")
    Next
%>
    </table>
    </div>

<%
Else
%>
    <div id="divReporte_16" style="display:none"><br><br><br><b>Reporte no disponible</b></div>

<%
End If

%>










            <br /><br /><br />
            <div id="divFotos" style="display:none">

            </div>
<script type="text/javascript">

    var menu1 = '';
    var menu2 = '';

        <% 
    Dim cantEscritos As Integer = 0
    Dim cantidadItems As Integer = menuItems.Where(Function(x) x.activo = True).Count()
    cantidadItems = cantidadItems / 2
    For Each mi As MenuItems In menuItems
        If mi.activo Then
            If cantidadItems >= cantEscritos Then
        %>
    menu1 += "<%=mi.valor%>";
        <% 
            Else
        %>
    menu2 += "<%=mi.valor%>";
        <% 
            End If
cantEscritos += 1
End If
Next

End If

%>
</script>

        </div>
    </form>
</body>
<script type="text/javascript">
    //window.print();

    $(document).ready(function () {
        $("#ulMenu1").append(menu1);
        $("#ulMenu2").append(menu2);
    });

</script>
</html>

<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepGastosNSEdoResImpresion.aspx.vb" Inherits="Intranet.RepGastosNSEdoResImpresion" %>
<%@ Register TagPrefix="asp" Assembly="ExportToExcel" Namespace="KrishLabs.Web.Controls" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reporte</title>
	<link rel="stylesheet" type="text/css" href="/styles/styles.css" />

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
            font-size:12px;
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

  <style type="text/css">
        body {
            font-family:Arial,Tahoma;
        }
/*
        td {
            border-style:solid;
            border-color:#dedcdc;
            border-width:1px;
            padding-left:5px;
            padding-right:4px;
            padding-top:2px;
            padding-bottom:2px;
        }    
*/

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
            font-size:15px;
            background-color:#333333;
            color:#ffffff;
        }
        .subtitulos {
            font-size:12px;
        }
        .datos {
            font-size:12px;
            background-color:#FFFFFF;
        }
        .datos3 {
            font-size:12px;
            background-color:#FFFC99;
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
            font-size:12px;
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
            font-size:13px;
            background-color:#333333;
            color:#ffffff;
        }
        .subtitulos2 {
            font-size:12px;
        }
        .datos2 {
            /*font-size:11px;*/
            font-size:12px;
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

    <script type="text/javascript">
        function TomaFoto(reporte) {
            ScreenShot(document.getElementById('tblReporte_' + reporte));
        }


        function ScreenShot(id) {

            html2canvas(id, {
                onrendered: function (canvas) {

                    var img = canvas.toDataURL("image/png");
                    var output = img.replace(/^data:image\/(png|jpg);base64,/, "");
                    var output = encodeURIComponent(img);

                    var Parameters = "image=" + output;
                    $.ajax({
                        type: "POST",
                        url: "Servicios/GuardaScreenshot.aspx",
                        data: Parameters,
                        success: function (data) {
                            window.open('/uploads/' + data);
                            //console.log("screenshot done");
                        }
                    }).done(function () {
                        //$('body').html(data);
                    });

                }
            });
        }
    </script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.8.2/jquery.min.js"></script>
    <script src="/scripts/html2canvas.js"></script>

</head>
<body>
    <form id="form1" runat="server">
        <div style="padding-left:10px; padding-right:10px;">
            <br />
<%
    
    Dim anio As Integer = Request.QueryString("a")
    Dim mes As Integer = Request.QueryString("m")

%>

            <table border="0" cellpadding="0" cellspacing="0">
                <tr class="filaTotales">
                    <td align="left" style='font-size:18px;padding-left:20px;'>Estado de Resultados - <%= anio & " vs " & (anio - 1)%> Incluyendo NBR (Acumu hasta <%=NombreMes(mes)%>, Moneda: <%=Request.QueryString("mon") %>)  <span class="linkCopias"><a href="#" onclick="TomaFoto(3);">(Copiar)</a></span></td>
                </tr>
                <tr>
                    <td align="left" style='font-size:15px;padding-left:50px;'>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir sin Formato" OnClientClick="window.print();" />
                    </td>
                </tr>
                <tr>


<div id="divReporte_3" style="">
    <table id="tblReporte_3" border="1" cellpadding="0" cellspacing="1">
        <tr class="filaTotales">
            <td rowspan="2" align="center" class="titulos"><b>CONCEPTO</b></td>
            <td>&nbsp;</td>
            <td colspan="4" align="center" class="titulos">HORNOS</td>
            <td>&nbsp;</td>
            <td colspan="4" align="center" class="titulos">FIBRAS</td>
            <td>&nbsp;</td>
            <td colspan="4" align="center" class="titulos">CONSOLIDADO</td>
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
    Dim dtRep As DataTable = ReporteGastosNSEdoRes()
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

                </tr>
            </table>
            <asp:Label ID="lblNoRecords" runat="server" Visible="false" Text="No se encontraron registros para la busqueda realizada"></asp:Label>

            <br /><br /><br /><br />


        </div>
    </form>
</body>

</html>

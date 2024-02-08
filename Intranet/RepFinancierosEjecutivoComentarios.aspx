<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="RepFinancierosEjecutivoComentarios.aspx.vb" Inherits="Intranet.RepFinancierosEjecutivoComentarios" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .reTool .YoutubeVideo
        {
          background-image: url(/images/youtube.gif);
        }

    </style>

      <script src="Scripts/jquery-1.9.1.js"></script>
      <link href="Scripts/jquery.uploadfile/uploadfile.css" rel="stylesheet">
      <script src="Scripts/jquery.uploadfile/jquery.uploadfile.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>


    <asp:Panel ID="pnlBusqueda" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="720px">
            <tr>
                <td colspan="5"><span style="font-size:15px; font-weight:bold;"><%=Translatelocale.text("Comentarios para Reporte Ejecutivo")%></span><hr style="margin:0; padding:0;" /></td>
            </tr>
        </table>
    </asp:Panel>
    <br />

    <table id="tblInicial" runat="server" cellpadding="0" cellspacing="0" border="0" width="720px">
        <tr>
            <td>
                <table>
                    <tr>
                        <td>&nbsp;&nbsp;&nbsp;<%=TranslateLocale.text("Año")%>:</td>
                        <td><asp:DropDownList ID="ddlAnio" runat="server" Width="80px"></asp:DropDownList></td>
                        <td rowspan="2">
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <asp:Button ID="btnContinuar" runat="server" Text="Continuar" />
                        </td>
                    </tr>
                    <tr>
                        <td>&nbsp;&nbsp;&nbsp;<%=TranslateLocale.text("Periodo")%>:</td>
                        <td><asp:DropDownList ID="ddlPeriodo" runat="server" Width="80px"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td>&nbsp;&nbsp;&nbsp;<%=TranslateLocale.text("Tipo Reporte")%>:</td>
                        <td>
                            <asp:DropDownList ID="ddlTipoReporte" runat="server" Width="80px">
                            </asp:DropDownList>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>


    <table id="tblCapturaNormal" runat="server" cellpadding="0" cellspacing="0" border="0" width="720px">
        <tr>
            <td>
                    <br />
                    <br />
                    &nbsp;&nbsp;<b><%=TranslateLocale.text("Minuta Junta Anterior")%></b>
                    <telerik:RadEditor ID="radMinuta" runat="server" Width="99%" Height="250px" Skin="Office2007">
                        <Tools>
                            <telerik:EditorToolGroup Tag="Menu1">
                                <telerik:EditorTool Name="BackColor" />
                                <telerik:EditorTool Name="FontSize" />
                                <telerik:EditorTool Name="ForeColor" />
                                <telerik:EditorTool Name="Indent" />
                                <telerik:EditorTool Name="Outdent" />
                                <telerik:EditorTool Name="Undo" />
                                <telerik:EditorTool Name="Redo" />
                                <telerik:EditorTool Name="InsertLink" />
                            </telerik:EditorToolGroup>
                            <telerik:EditorToolGroup Tag="Menu2">
                                <telerik:EditorTool Name="Bold" />
                                <telerik:EditorTool Name="Italic" />
                                <telerik:EditorTool Name="Underline" />
                                <telerik:EditorTool Name="StrikeThrough" />
                                <telerik:EditorTool Name="JustifyCenter" />
                                <telerik:EditorTool Name="JustifyFull" />
                                <telerik:EditorTool Name="JustifyLeft" />
                                <telerik:EditorTool Name="JustifyNone" />
                                <telerik:EditorTool Name="JustifyRight" />
                                <telerik:EditorTool Name="ToggleScreenMode" />
                            </telerik:EditorToolGroup>
                        </Tools>
                        <Content></Content>                               
                    </telerik:RadEditor>

                    <br />
                    <br />
                    &nbsp;&nbsp;<b><%=TranslateLocale.text("Resumen Ejecutivo")%></b>
                    <telerik:RadEditor ID="radResumen" runat="server" Width="99%" Height="300px" Skin="Office2007">
                        <Tools>
                            <telerik:EditorToolGroup Tag="Menu1">
                                <telerik:EditorTool Name="BackColor" />
                                <telerik:EditorTool Name="FontSize" />
                                <telerik:EditorTool Name="ForeColor" />
                                <telerik:EditorTool Name="Indent" />
                                <telerik:EditorTool Name="Outdent" />
                                <telerik:EditorTool Name="Undo" />
                                <telerik:EditorTool Name="Redo" />
                                <telerik:EditorTool Name="InsertLink" />
                            </telerik:EditorToolGroup>
                            <telerik:EditorToolGroup Tag="Menu2">
                                <telerik:EditorTool Name="Bold" />
                                <telerik:EditorTool Name="Italic" />
                                <telerik:EditorTool Name="Underline" />
                                <telerik:EditorTool Name="StrikeThrough" />
                                <telerik:EditorTool Name="JustifyCenter" />
                                <telerik:EditorTool Name="JustifyFull" />
                                <telerik:EditorTool Name="JustifyLeft" />
                                <telerik:EditorTool Name="JustifyNone" />
                                <telerik:EditorTool Name="JustifyRight" />
                                <telerik:EditorTool Name="ToggleScreenMode" />
                            </telerik:EditorToolGroup>
                        </Tools>
                        <Content></Content>                               
                    </telerik:RadEditor>


                    <br />
                    <br />
                    &nbsp;&nbsp;<b><%=TranslateLocale.text("Notas para Gráfica de Flujo de Efectivo")%></b>
                    <telerik:RadEditor ID="radFlujoEfectivo" runat="server" Width="99%" Height="200px" Skin="Office2007">
                        <Tools>
                            <telerik:EditorToolGroup Tag="Menu1">
                                <telerik:EditorTool Name="BackColor" />
                                <telerik:EditorTool Name="FontSize" />
                                <telerik:EditorTool Name="ForeColor" />
                                <telerik:EditorTool Name="Indent" />
                                <telerik:EditorTool Name="Outdent" />
                                <telerik:EditorTool Name="Undo" />
                                <telerik:EditorTool Name="Redo" />
                                <telerik:EditorTool Name="InsertLink" />
                            </telerik:EditorToolGroup>
                            <telerik:EditorToolGroup Tag="Menu2">
                                <telerik:EditorTool Name="Bold" />
                                <telerik:EditorTool Name="Italic" />
                                <telerik:EditorTool Name="Underline" />
                                <telerik:EditorTool Name="StrikeThrough" />
                                <telerik:EditorTool Name="JustifyCenter" />
                                <telerik:EditorTool Name="JustifyFull" />
                                <telerik:EditorTool Name="JustifyLeft" />
                                <telerik:EditorTool Name="JustifyNone" />
                                <telerik:EditorTool Name="JustifyRight" />
                                <telerik:EditorTool Name="ToggleScreenMode" />
                            </telerik:EditorToolGroup>
                        </Tools>
                        <Content></Content>                               
                    </telerik:RadEditor>

            </td>
        </tr>
        <tr>
            <td><br /><br />
                <strong style="font-size:15px"><%=TranslateLocale.text("Archivos asociados a este reporte")%></strong>
                <br />
                    <div id="fileuploader">Upload</div>
                <br />
                <div id="divMultimedia" runat="server">
                </div>

            </td>
        </tr>
    </table>
    <br />
    <table id="tblBotones" runat="server" cellpadding="0" cellspacing="0" border="0" width="720px">
        <tr>
            <td align="right">
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar" />
            </td>
        </tr>
    </table>

        <script type="text/javascript">


            function AgregarDocMinuta(ruta, documento) {
                var editor = $find("<%=radMinuta.ClientID%>");
                var extension = (/[.]/.exec(documento)) ? /[^.]+$/.exec(documento) : "";

                if (extension == 'jpg' || extension == 'png' || extension == 'jpeg' || extension == 'bmp' || extension == 'tiff') {
                    editor.pasteHtml('<a href="' + ruta + documento + '" target="_blank"><img src="' + ruta + documento + '" border="0" style="max-width: 650px" /></a>');
                } else {
                    editor.pasteHtml('<a href="' + ruta + documento + '" target="_blank">' + documento + '</a>');
                }
            }

            function AgregarDocResumen(ruta, documento) {
                var editor = $find("<%=radResumen.ClientID%>");
                var extension = (/[.]/.exec(documento)) ? /[^.]+$/.exec(documento) : "";

                if (extension == 'jpg' || extension == 'png' || extension == 'jpeg' || extension == 'bmp' || extension == 'tiff') {
                    editor.pasteHtml('<a href="' + ruta + documento + '" target="_blank"><img src="' + ruta + documento + '" border="0" style="max-width: 650px" /></a>');
                } else {
                    editor.pasteHtml('<a href="' + ruta + documento + '" target="_blank">' + documento + '</a>');
                }
            }

            function RegistraUpload() {
                $("#fileuploader").uploadFile({
                    url: "/UploadArchivos.ashx",
                    multiple: false,
                    dragDrop: false,
                    fileName: "myfile",
                    uploadStr: "<%=TranslateLocale.text("Subir Imagen")%>",
                    //allowedTypes: "jpg,jpeg,png.gif",
                    onSuccess: function (files, data, xhr, pd) {
                        if (data.indexOf("Error=").length >= 0) {
                            alert(data);
                        } else {
                            AgregaDocumentos(document.getElementById('<%=ddlAnio.ClientID%>').value, document.getElementById('<%=ddlPeriodo.ClientID%>').value, document.getElementById('<%=ddlTipoReporte.ClientID%>').value, data);
                            $('.ajax-file-upload-container').html('');
                        }
                    },
                    onError: function (files, status, errMsg, pd) {
                        alert(JSON.stringify(files));
                    }
                });
            }


            function RecuperaDocumentos(anio, periodo, tipo) {
                $.ajax({
                    type: "GET",
                    url: "/Servicios/DocumentosReporte.aspx?anio=" + anio + "&periodo=" + periodo + "&tipo=" + tipo,
                    success: function (datos) {
                        document.getElementById('<%=divMultimedia.ClientID%>').innerHTML = datos;
                },
                error: function (error) {
                    alert(error);
                }
            });
            return true;
        }

        function AgregaDocumentos(anio, periodo, tipo, nombre) {
            $.ajax({
                type: "GET",
                url: "/Servicios/DocumentosReporteAgregar.aspx",
                data: { anio: anio, periodo: periodo, nombre: nombre, tipo: tipo },
                success: function (datos) {
                    RecuperaDocumentos(anio, periodo, tipo);
                },
                error: function (error) {
                    alert(error);
                }
            });
            return true;
        }
            
        function IniciaUpload() {
            $(document).ready(function () {
                RegistraUpload();
                RecuperaDocumentos(document.getElementById('<%=ddlAnio.ClientID%>').value, document.getElementById('<%=ddlPeriodo.ClientID%>').value, document.getElementById('<%=ddlTipoReporte.ClientID%>').value);
            });
        }


        </script>  
    
</asp:Content>

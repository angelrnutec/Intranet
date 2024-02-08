<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="PublicacionesAgregar.aspx.vb" Inherits="Intranet.PublicacionesAgregar" %>

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
                <td colspan="5"><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Publicación de Contenido")%></span><hr style="margin:0; padding:0;" /></td>
            </tr>
        </table>
    </asp:Panel>
    <br />

    <table id="tblInicial" runat="server" cellpadding="0" cellspacing="0" border="0" width="720px">
        <tr>
            <td>
                <br />
                <table width="100%">
                    <tr>
                        <td><%=TranslateLocale.text("Tipo de publicación")%>:</td>
                        <td><asp:DropDownList ID="ddlTipoPublicacion" runat="server" Width="150px"></asp:DropDownList></td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td><%=TranslateLocale.text("Grupo")%>:</td>
                        <td><asp:DropDownList ID="ddlGrupo" runat="server" Width="150px"></asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td colspan="5" align="right">
                            <br />
                            <asp:Button ID="btnContinuar" runat="server" Text="Continuar" CssClass="botones" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <table id="tblCaptura" runat="server" cellpadding="0" cellspacing="0" border="0" width="720px">
        <tr>
            <td>
                <br />
                <table width="90%">
                    <tr>
                        <td colspan="5">
                            <%=TranslateLocale.text("Tipo de publicación")%>:&nbsp;<strong><asp:Label ID="lblTipoPublicacion" runat="server"></asp:Label></strong>
                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                            <%=TranslateLocale.text("Grupo")%>:&nbsp;<strong><asp:Label ID="lblGrupo" runat="server"></asp:Label></strong>
                        </td>
                    </tr>
                    <tr id="trDatosAdicionales" runat="server">
                        <td><%=TranslateLocale.text("Fecha del Evento")%>:</td>
                        <td><telerik:RadDatePicker ID="dtFechaEvento" runat="server" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy"></telerik:RadDatePicker></td>
                        <td colspan="3"></td>
                    </tr>
                    <tr>
                        <td colspan="5"><asp:CheckBox ID="chkPermiteComentarios" runat="server" Text="¿Esta publicación permite comentarios de los empleados?" /></td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td><br />
                            <asp:RadioButton ID="rbVisible" runat="server" Text="Publicación Visible" Checked="true" GroupName="Visible" /><br />
                            <asp:RadioButton ID="rbNoVisible" runat="server" Text="Publicación Oculta" GroupName="Visible" />
                        </td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        </td>
                        <td><br />
                            <asp:RadioButton ID="rbActivo" runat="server" Text="Publicación Activa" Checked="true" GroupName="Activo" /><br />
                            <asp:RadioButton ID="rbBorrado" runat="server" Text="Publicación Borrada" GroupName="Activo" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr id="trTitulo" runat="server">
            <td><br />
                <asp:Label ID="lblTituloPublicacion" runat="server" Text="Titulo de la publicación:"></asp:Label>&nbsp;&nbsp;<asp:TextBox ID="txtTitulo" runat="server" Width="455px" style="font-size:15px" MaxLength="256"></asp:TextBox>
                <br />
                <asp:Label ID="lblTituloPublicacionEn" runat="server" Text="Titulo de la publicación (Ingles):"></asp:Label>&nbsp;&nbsp;<asp:TextBox ID="txtTituloEn" runat="server" Width="455px" style="font-size:15px" MaxLength="256"></asp:TextBox>
                <br />
                <asp:Label ID="lblLinkGenerado" runat="server" Text="" style="font-family:courier new;font-size:14px;font-weight:bold;"></asp:Label>
                <div style="height:10px"></div>
            </td>
        </tr>
    </table>
    <table id="tblCapturaLink" runat="server" cellpadding="0" cellspacing="0" border="0" width="720px">
        <tr>
            <td><br />
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td><br />
                            <%=TranslateLocale.text("URL")%>:
                        </td>
                        <td><br />
                            <asp:TextBox ID="txtLinkUrl" runat="server" Width="455px" MaxLength="512" Text="http://"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%=TranslateLocale.text("Texto")%>:
                        </td>
                        <td>
                            <asp:TextBox ID="txtLinkTexto" runat="server" Width="455px" MaxLength="256" Text=""></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%=TranslateLocale.text("Función")%>:
                        </td>
                        <td>
                            <asp:RadioButton ID="rbTargetSelf" runat="server" Text="Abrir la liga en la misma página" Checked="true" GroupName="liga_target" /><br />
                            <asp:RadioButton ID="rbTargetBlank" runat="server" Text="Abrir la liga en una página nueva" GroupName="liga_target" />
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
    <table id="tblCapturaBanner" runat="server" cellpadding="0" cellspacing="0" border="0" width="720px">
        <tr>
            <td><br />
                <table cellpadding="0" cellspacing="0" border="0">
                    <tr>
                        <td><br />
                            <%=TranslateLocale.text("URL")%>:
                        </td>
                        <td><br />
                            <asp:TextBox ID="txtBannerLink" runat="server" Width="455px" MaxLength="512" Text="http://"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td><br />
                            <%=TranslateLocale.text("Función")%>:<br /><br />
                        </td>
                        <td>
                            <asp:RadioButton ID="rbBannerTargetSelf" runat="server" Text="Abrir la liga en la misma página" Checked="true" GroupName="liga_target" /><br />
                            <asp:RadioButton ID="rbBannerTargetBlank" runat="server" Text="Abrir la liga en una página nueva" GroupName="liga_target" />
                        </td>
                    </tr>
                    <tr>
                        <td><br />
                            <%=TranslateLocale.text("Ubicación")%>:<br /><br />
                        </td>
                        <td>
                            <asp:RadioButton ID="rbBannerUbicaI" runat="server" Text="Barra lateral izquierda" Checked="true" GroupName="liga_ubica" /><br />
                            <asp:RadioButton ID="rbBannerUbicaD" runat="server" Text="Barra lateral derecha" GroupName="liga_ubica" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <%=TranslateLocale.text("Banner")%>:
                        </td>
                        <td>
                            <table width="100%">
                                <tr valign="top">
                                    <td>
                                        <div id="fileuploaderBanner">Upload</div>
                                    </td>
                                    <td>
                                        <div id="divBannerImagen"></div>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>

    <table id="tblCapturaAviso" runat="server" visible="false" cellpadding="0" cellspacing="0" border="0" width="720px">
        <tr>
            <td><%=TranslateLocale.text("Categoría")%>:</td>
            <td>
                <asp:DropDownList ID="ddlCategoria" runat="server" Width="200px"></asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Descripción")%>:</td>
            <td>
                <asp:TextBox ID="txtDescripcion" runat="server" MaxLength="512" TextMode="MultiLine" Width="455px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Descripción (Ingles)")%>:</td>
            <td>
                <asp:TextBox ID="txtDescripcionEn" runat="server" MaxLength="512" TextMode="MultiLine" Width="455px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Vendedor")%>:</td>
            <td>
                <asp:DropDownList ID="ddlVendedor" runat="server" Width="200px"></asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Datos de Contacto")%>:</td>
            <td>
                <asp:TextBox ID="txtTelefono" runat="server" MaxLength="256" Width="455px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="2"><br /><br />
                <strong style="font-size:15px"><%=TranslateLocale.text("Fotografias del aviso")%></strong>
                <br />
                    <div id="fileuploaderAviso">Upload</div>
                <br />
                <div id="divFotos" runat="server" style="width:500px;">
                </div>

            </td>
        </tr>
    </table>

    <table id="tblCapturaNormal" runat="server" cellpadding="0" cellspacing="0" border="0" width="720px">
        <tr>
            <td>
                <%=TranslateLocale.text("Descripción corta")%>:<br />
                <asp:TextBox ID="txtDescripcionCorta" runat="server" Width="590px" onKeyUp="maximo_largo();" TextMode="MultiLine" Height="30px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <%=TranslateLocale.text("Descripción corta (Ingles)")%>:<br />
                <asp:TextBox ID="txtDescripcionCortaEn" runat="server" Width="590px" onKeyUp="maximo_largo();" TextMode="MultiLine" Height="30px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td>
                <br />
                <%=TranslateLocale.text("Contenido")%>:<br />
                    <telerik:RadEditor ID="radTexto" runat="server" Width="99%" Height="350px" Skin="Office2007">
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
                                <telerik:EditorTool Name="YoutubeVideo" Text="Click para cargar video de you tube" />
                            </telerik:EditorToolGroup>
                        </Tools>
                        <Content></Content>                               
                    </telerik:RadEditor>


                <br />
                <%=TranslateLocale.text("Contenido (Ingles)")%>:<br />
                    <telerik:RadEditor ID="radTextoEn" runat="server" Width="99%" Height="350px" Skin="Office2007">
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
                                <telerik:EditorTool Name="YoutubeVideo" Text="Click para cargar video de you tube" />
                            </telerik:EditorToolGroup>
                        </Tools>
                        <Content></Content>                               
                    </telerik:RadEditor>

            </td>
        </tr>
        <tr>
            <td><br /><br />
                <strong style="font-size:15px"><%=TranslateLocale.text("Archivos asociados a esta publicación")%></strong>
                <br />
                    <div id="fileuploader">Upload</div>
                <br />
                <div id="divMultimedia" runat="server">
                </div>
                <br /><br />
                <div id="divImagenPortada" runat="server">
                </div>

            </td>
        </tr>
    </table>
    <br />
    <table id="tblBotones" runat="server" cellpadding="0" cellspacing="0" border="0" width="720px">
        <tr>
            <td align="right">
                <asp:Button ID="btnCancelar" runat="server" Text="Cancelar" CssClass="botones" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnGuardar" runat="server" Text="Guardar Publicación" CssClass="botones" OnClientClick="return ValidaCaptura();" />
            </td>
        </tr>
    </table>

        <script type="text/javascript">

            function maximo_largo()
            {
                var texto;
                texto = document.getElementById('<%=txtDescripcionCorta.ClientID%>').value;
                if(texto.length>180)
                {
                    document.getElementById('<%=txtDescripcionCorta.ClientID%>').value = texto.substring(0,180);
                }
            }
            <%
            If Me.txtTipoPublicacion.Text <> "4" And Me.txtTipoPublicacion.Text <> "5" And Me.txtTipoPublicacion.Text <> "7" Then
            %>



            Telerik.Web.UI.Editor.CommandList["YoutubeVideo"] = function (commandName, editor, args) {
                var videoURL = prompt("URL Video de YouTube", "Pega aqui la URL del Video de YouTube");
                if (videoURL == null) {
                    return true;
                }

                var videoURLPos = videoURL.indexOf("?v=");
                if (videoURLPos < 0) {
                    alert("Ingrese una URL valida de YouTube");
                    return true;
                }
                var videoCode = videoURL.substring(videoURLPos + 3, videoURLPos + 14);

                var videoHTML = "<object width='340' height='200'>";
                videoHTML += "<param name='movie' value='http://www.youtube.com/v/" + videoCode + "?fs=1&amp;hl=es_MX&amp;rel=0&amp;color1=0x006699&amp;color2=0x54abd6'></param>";
                videoHTML += "<param name='allowFullScreen' value='true'></param>";
                videoHTML += "<param name='allowscriptaccess' value='always'></param>";
                videoHTML += "<embed src='http://www.youtube.com/v/" + videoCode + "?fs=1&amp;hl=es_MX&amp;rel=0&amp;color1=0x006699&amp;color2=0x54abd6' type='application/x-shockwave-flash' allowscriptaccess='always' allowfullscreen='true' width='340' height='200'></embed>";
                videoHTML += "</object>";

                editor.pasteHtml(videoHTML);
            };


            function AgregarDocumentoALaPublicacion(ruta, documento) {
                var editor = $find("<%=radTexto.ClientID%>");
                var extension = (/[.]/.exec(documento)) ? /[^.]+$/.exec(documento) : "";

                if (extension == 'jpg' || extension == 'png' || extension == 'jpeg' || extension == 'bmp' || extension == 'tiff') {
                    editor.pasteHtml('<a href="' + ruta + documento + '" target="_blank"><img src="' + ruta + documento + '" border="0" style="max-width: 720px" /></a>');
                }
                else if (extension == 'doc' || extension == 'docx' || extension == 'pdf' || extension == 'ppt' ||
                         extension == 'pptx' || extension == 'xls' || extension == 'xlsx' || extension == 'zip' || extension == 'rar') {
                    editor.pasteHtml('<a href="' + ruta + documento + '" target="_blank">' + documento + '</a>');
                }


                var editor_en = $find("<%=radTextoEn.ClientID%>");
                if (extension == 'jpg' || extension == 'png' || extension == 'jpeg' || extension == 'bmp' || extension == 'tiff') {
                    editor_en.pasteHtml('<a href="' + ruta + documento + '" target="_blank"><img src="' + ruta + documento + '" border="0" style="max-width: 720px" /></a>');
                }
                else if (extension == 'doc' || extension == 'docx' || extension == 'pdf' || extension == 'ppt' ||
                         extension == 'pptx' || extension == 'xls' || extension == 'xlsx' || extension == 'zip' || extension == 'rar') {
                    editor_en.pasteHtml('<a href="' + ruta + documento + '" target="_blank">' + documento + '</a>');
                }

            }

            function RegistraUpload() {
                $("#fileuploader").uploadFile({
                    url: "/UploadArchivos.ashx",
                    multiple: false,
                    dragDrop: false,
                    fileName: "myfile",
                    uploadStr: "<%=TranslateLocale.text("Subir Archivo")%>",
                    //allowedTypes: "jpg,jpeg,png.gif",
                    onSuccess: function (files, data, xhr, pd) {
                        if (data.indexOf("Error=").length >= 0) {
                            alert(data);
                        } else {
                            AgregaDocumentos(document.getElementById('<%=txtID.ClientID%>').value, data);
                            $('.ajax-file-upload-container').html('');
                        }
                    },
                    onError: function (files, status, errMsg, pd) {
                        alert(JSON.stringify(files));
                    }
                });
            }



            function RecuperaDocumentos(id) {
                $.ajax({
                    type: "GET",
                    url: "/Servicios/DocumentosPublicacion.aspx?id=" + id,
                    success: function (datos) {
                        document.getElementById('<%=divMultimedia.ClientID%>').innerHTML = datos;
                },
                error: function (error) {
                    alert(error);
                }
            });
                return true;
            }




            function RecuperaDocumentoPortada(id) {
                $.ajax({
                    type: "GET",
                    url: "/Servicios/PublicacionPortada.aspx?id=" + id,
                    success: function (datos) {
                        document.getElementById('<%=divImagenPortada.ClientID%>').innerHTML = '<b><%=TranslateLocale.text("Imagen de Portada")%>:</b> ' + datos;
                    },
                    error: function (error) {
                        alert(error);
                    }
                });
                    return true;
                }


            function UsarComoPortada(nombre)
            {
                var id = document.getElementById('<%=txtID.ClientID%>').value;
                $.ajax({
                    type: "GET",
                    url: "/Servicios/PublicacionPortadaAgregar.aspx",
                    data: { id: id, nombre: nombre },
                    success: function (datos) {
                        RecuperaDocumentoPortada(id);
                    },
                    error: function (error) {
                        alert(error);
                    }
                });
                return true;
            }



            function AgregaDocumentos(id, nombre) {
                $.ajax({
                    type: "GET",
                    url: "/Servicios/DocumentosPublicacionAgregar.aspx",
                    data: { id: id, nombre: nombre },
                    success: function (datos) {
                        RecuperaDocumentos(id);
                    },
                    error: function (error) {
                        alert(error);
                    }
                });
                return true;
            }

            function EliminarDocumento(id) {
                $.ajax({
                    type: "GET",
                    url: "/Servicios/DocumentosPublicacionEliminar.aspx",
                    data: { id: id},
                    success: function (datos) {
                        RecuperaDocumentos(document.getElementById('<%=txtID.ClientID%>').value);
                    },
                    error: function (error) {
                        alert(error);
                    }
                });
                    return true;
                }


            <%
        ElseIf Me.txtTipoPublicacion.Text = "5" Then
            %>



            function RegistraUploadBanner() {
                $("#fileuploaderBanner").uploadFile({
                    url: "/UploadBanner.ashx",
                    multiple: false,
                    dragDrop: false,
                    fileName: "myfile",
                    uploadStr: "<%=TranslateLocale.text("Subir Banner")%>",
                    allowedTypes: "jpg,jpeg,png,gif,bmp",
                    onSuccess: function (files, data, xhr, pd) {
                        if (data.indexOf("Error=").length >= 0) {
                            alert(data);
                        } else {
                            MuestraBanner(data);
                            $('.ajax-file-upload-container').html('');
                        }
                    },
                    onError: function (files, status, errMsg, pd) {
                        alert(JSON.stringify(files));
                    }
                });
            }


            function RecuperaBanner(id) {
                $.ajax({
                    type: "GET",
                    url: "/Servicios/BannerPublicacion.aspx?id=" + id,
                    success: function (datos) {
                        MuestraBanner(datos);
                    },
                    error: function (error) {
                        alert('aaaa' + error);
                    }
                });
                return true;
            }

        function MuestraBanner(nombre)
        {
            if(nombre.length>0){
                document.getElementById('<%=txtBanner.ClientID%>').value = nombre;
                document.getElementById('divBannerImagen').innerHTML = '<img src="/uploads/banner/' + nombre + '" style="max-height: 300px; max-width: 300px" />';
            }
        }


            <%
        ElseIf Me.txtTipoPublicacion.Text = "7" Then
            %>
            function RecuperaDocumentosAviso(id) {
                $.ajax({
                    type: "GET",
                    url: "/Servicios/DocumentosPublicacion.aspx?id=" + id + "&t=aviso",
                    success: function (datos) {
                        document.getElementById('<%=divFotos.ClientID%>').innerHTML = datos;
                    },
                    error: function (error) {
                        alert(error);
                    }
                });
                    return true;
                }

            function AgregaDocumentos(id, nombre) {
                $.ajax({
                    type: "GET",
                    url: "/Servicios/DocumentosPublicacionAgregar.aspx",
                    data: { id: id, nombre: nombre },
                    success: function (datos) {
                        RecuperaDocumentosAviso(id);
                    },
                    error: function (error) {
                        alert(error);
                    }
                });
                return true;
            }

            function UsarComoPortada(nombre)
            {
                var id = document.getElementById('<%=txtID.ClientID%>').value;
                    $.ajax({
                        type: "GET",
                        url: "/Servicios/PublicacionPortadaAgregar.aspx",
                        data: { id: id, nombre: nombre },
                        success: function (datos) {
                            alert('Portada seleccionada');
                        },
                        error: function (error) {
                            alert(error);
                        }
                    });
                    return true;
                }


            function EliminarDocumento(id) {
                $.ajax({
                    type: "GET",
                    url: "/Servicios/DocumentosPublicacionEliminar.aspx",
                    data: { id: id},
                    success: function (datos) {
                        RecuperaDocumentosAviso(document.getElementById('<%=txtID.ClientID%>').value);
                    },
                    error: function (error) {
                        alert(error);
                    }
                });
                    return true;
                }




            function RegistraUploadAvisos() {
                $("#fileuploaderAviso").uploadFile({
                    url: "/UploadArchivos.ashx",
                    multiple: false,
                    dragDrop: false,
                    fileName: "myfile",
                    uploadStr: "<%=TranslateLocale.text("Subir Foto")%>",
                    allowedTypes: "jpg,jpeg,png,gif,bmp",
                    onSuccess: function (files, data, xhr, pd) {
                        if (data.indexOf("Error=").length >= 0) {
                            alert(data);
                        } else {
                            AgregaDocumentos(document.getElementById('<%=txtID.ClientID%>').value, data);
                            $('.ajax-file-upload-container').html('');
                        }
                    },
                    onError: function (files, status, errMsg, pd) {
                        alert(JSON.stringify(files));
                    }
                });
            }


            <%
            End If
            %>


            
    function ValidaCaptura()
        {
            var msg = '';
            if(document.getElementById('<%=txtTipoPublicacion.ClientID%>').value=="5")
            {
                if(document.getElementById("<%=txtTitulo.ClientID%>").value.length <= 0 || document.getElementById("<%=txtTituloEn.ClientID%>").value.length <= 0) { msg += ' - <%=TranslateLocale.text("Titulo (Español)")%> / <%=TranslateLocale.text("Titulo (Ingles)")%>\n'; }
                if(document.getElementById("<%=txtBannerLink.ClientID%>").value.length <= 0) { msg += ' - <%=TranslateLocale.text("URL para el banner")%>\n'; }
                if(document.getElementById("<%=txtBanner.ClientID%>").value.length <= 0) { msg += ' - <%=TranslateLocale.text("Imagen del banner")%>\n'; }
            }
            if(msg.length>0){
                alert('<%=TranslateLocale.text("Favor de proporcionar esta información")%>:\n' + msg);
                return false;
            }
            return true;
        }



        $(document).ready(function () {
<%
            If Me.txtTipoPublicacion.Text = "4" Then
%>
            <%
        ElseIf Me.txtTipoPublicacion.Text = "5" Then
%>
            RegistraUploadBanner();
            RecuperaBanner(document.getElementById('<%=txtID.ClientID%>').value);
<%
        ElseIf Me.txtTipoPublicacion.Text = "7" Then
%>
            RegistraUploadAvisos();
            RecuperaDocumentosAviso(document.getElementById('<%=txtID.ClientID%>').value);
<%
        Else
%>
            RegistraUpload();
            RecuperaDocumentos(document.getElementById('<%=txtID.ClientID%>').value);
            RecuperaDocumentoPortada(document.getElementById('<%=txtID.ClientID%>').value);
<%
        End If
%>
        });


        </script>  
    
    <asp:TextBox ID="txtID" runat="server" Text="0" style="display:none;"></asp:TextBox>
    <asp:TextBox ID="txtTipoPublicacion" runat="server" Text="0" style="display:none;"></asp:TextBox>
    <asp:TextBox ID="txtIdGrupo" runat="server" Text="0" style="display:none;"></asp:TextBox>
    <asp:TextBox ID="txtBanner" runat="server" Text="" style="display:none;"></asp:TextBox>
</asp:Content>

<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="GastosTarjetaImporta.aspx.vb" Inherits="Intranet.GastosTarjetaImporta" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<%--    <script src="/scripts/jquery-1.7.1.js" type="text/javascript"></script>
    <script src="/uploadify/scripts/jquery.uploadify.js" type="text/javascript"></script>
    <link rel="Stylesheet" type="text/css" href="/uploadify/CSS/uploadify.css" />--%>


              <link href="styles/jquery-ui.css" rel="stylesheet" />  
      <script src="Scripts/jquery-1.9.1.js"></script>
      <script src="Scripts/jquery-ui.js"></script>    

      <link href="Scripts/jquery.uploadfile/uploadfile.css" rel="stylesheet">
      <script src="Scripts/jquery.uploadfile/jquery.uploadfile.min.js"></script>


    <script type="text/javascript">
        function RegistraUploadify() {
<%--            $("#<%=fuFoto.ClientID%>").fileUpload({
                'uploader': '/uploadify/scripts/uploader.swf',
                'cancelImg': '/uploadify/images/cancel.png',
                'buttonText': 'Cargar XML TE',
                'script': '/UploadTicketEmpresarial.ashx',
                'folder': 'uploads',
                'fileDesc': 'XML Ticket Empresarial',
                'fileExt': '*.xml',
                'multi': false,
                'auto': true,
                'sizeLimit': 52428800,
                'scriptData': {
                    'id': 1
                    },
                'onComplete': function (event, ID, fileObj, response, data) {
                    ProcesaArchivo(response);
                },
                'onError': function (a, b, c, d) {
                    if (d.status == 404)
                        alert('Could not find upload script.');
                    else if (d.type === "HTTP")
                        alert('error ' + d.type + ": " + d.status);
                    else if (d.type === "File Size")
                        alert(c.name + ' ' + d.type + ' Limit: ' + Math.round(d.sizeLimit / 1024) + 'KB');
                    else
                        alert('error ' + d.type + ": " + d.text);
                }
            });--%>


            $("#fileuploader").uploadFile({
                url: "/UploadTicketEmpresarial.ashx",
                multiple: false,
                dragDrop: false,
                fileName: "myfile",
                uploadStr: "XML Ticket Empresarial",
                allowedTypes: "xml",
                formData: { "id": 1 },
                onSuccess: function (files, data, xhr, pd) {
                    if (data.indexOf("Error=").length >= 0) {
                        alert(data);
                    } else {
                        ProcesaArchivo(data);
                        $('.ajax-file-upload-container').html('');
                    }
                },
                onError: function (files, status, errMsg, pd) {
                    alert(JSON.stringify(files));
                }
            });

        }

        function ProcesaArchivo(nombre)
        {
            document.getElementById('<%=divProcesar.ClientID%>').style.display = '';
            document.getElementById('<%=divUpload.ClientID%>').style.display = 'none';
            document.getElementById('<%=txtNombre.ClientID%>').value = nombre;
        }


        $(document).ready(function() {
            RegistraUploadify();
        });

        function ValidaCaptura() {
            return true;
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <span style="font-size:15px; font-weight:bold; color:#1980bd;"><br />Seleccione el Archivo XML que desea Importar</span>
    <br /><br />

    <div id="divUpload" runat="server">
        Paso 1: Seleccionar Archivo<br />

        <div id="fileuploader">Upload</div>
    </div>

    <div id="divPrevio" runat="server">
        <div id="divProcesar" runat="server" style="display:none">
            Paso 2: Procesar el archivo seleccionado<br /><br />
            <asp:Button ID="btnImportar" runat="server" Text="Procesar Archivo" OnClientClick="if (!ValidaCaptura()) return false; this.disabled = true; this.value = 'Procesando...';"  UseSubmitBehavior="false"/>
            <asp:TextBox ID="txtNombre" runat="server" style="display:none" Text=""></asp:TextBox>
        </div>
    </div>
    <div id="divFinal" runat="server" visible="false">
        Archivo procesado: <asp:Label runat="server" ID="lblResultado"></asp:Label>
        <br />
        <input type="button" value="Cargar Nuevo Archivo" onclick="javascript: window.location = '/GastosTarjetaImporta.aspx';" />
    </div>
</asp:Content>

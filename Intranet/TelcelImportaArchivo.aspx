<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="TelcelImportaArchivo.aspx.vb" Inherits="Intranet.TelcelImportaArchivo" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="Scripts/jquery-1.9.1.js"></script>

    <link href="Scripts/jquery.uploadfile/uploadfile.css" rel="stylesheet">
    <script src="Scripts/jquery.uploadfile/jquery.uploadfile.min.js"></script>


    <script type="text/javascript">

        function RegistraUpload() {
            $("#fileuploader").uploadFile({
                url: "/UploadTelcel.ashx",
                multiple: false,
                dragDrop: false,
                fileName: "myfile",
                uploadStr: "Cargar Excel",
                allowedTypes: "xls,xlsx",
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
            RegistraUpload();
        });

        function ValidaCaptura() {
            var msg = '';
            if (document.getElementById('<%=ddlMes.ClientID%>').value == '0') {
                msg += 'Seleccione el Mes';
            }
            if (msg.length > 0) {
                alert(msg);
                return false;
            }
            return true;
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <span style="font-size:15px; font-weight:bold; color:#1980bd;"><br />Seleccione el Archivo Excel que desea Importar</span>
    <br /><br />

    <div id="divUpload" runat="server">
        Paso 1: Seleccionar Archivo<br />

        <div id="fileuploader">Upload</div>

    </div>

    <div id="divPrevio" runat="server">
        <div id="divProcesar" runat="server" style="display:none">
            Paso 2: Procesar el archivo seleccionado<br /><br />
            &nbsp;&nbsp;A&ntilde;o:&nbsp;&nbsp;<asp:DropDownList ID="ddlAnio" runat="server" Width="120px"></asp:DropDownList><br />
            &nbsp;&nbsp;Mes:&nbsp;<asp:DropDownList ID="ddlMes" runat="server" Width="120px"></asp:DropDownList><br /><br />


            <asp:Button ID="btnImportar" runat="server" Text="Procesar Archivo" OnClientClick="if (!ValidaCaptura()) return false; this.disabled = true; this.value = 'Procesando...';"  UseSubmitBehavior="false"/>
            <asp:TextBox ID="txtNombre" runat="server" style="display:none" Text=""></asp:TextBox>
        </div>
    </div>
    <div id="divFinal" runat="server" visible="false">
        Archivo procesado: <asp:Label runat="server" ID="lblResultado"></asp:Label>
        <br />
        <input type="button" value="Cargar Nuevo Archivo" onclick="javascript: window.location = '/TelcelImportaArchivo.aspx';" />
    </div>
</asp:Content>

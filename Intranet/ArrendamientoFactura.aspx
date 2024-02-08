<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="ArrendamientoFactura.aspx.vb" Inherits="Intranet.ArrendamientoFactura" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
      <link href="styles/jquery-ui.css" rel="stylesheet" />  
      <script src="Scripts/jquery-1.9.1.js"></script>
      <script src="Scripts/jquery-ui.js"></script>    

      <link href="Scripts/jquery.uploadfile/uploadfile.css" rel="stylesheet">
      <script src="Scripts/jquery.uploadfile/jquery.uploadfile.min.js"></script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
    <asp:Panel ID="pnlBusqueda" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="100%" style="display:none">
            <tr>
                <td colspan="3"><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Facturas de Arrendamientos")%></span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr valign="top">
                <td>
                    <%=TranslateLocale.text("Empresa")%>:
                </td>
                <td>
                    <asp:DropDownList ID="ddlEmpresa" runat="server" Width="250px"></asp:DropDownList>
                </td>
                <td align="right" rowspan="2">
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="botones" />
                    &nbsp;
                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar" CssClass="botones" />                    
                </td>
            </tr>
            <tr valign="top">
                <td>
                    <%=TranslateLocale.text("Categoría de Arrendamiento")%>:
                </td>
                <td>
                    <asp:DropDownList ID="ddlCategoriaArrendamiento" runat="server" Width="250px"></asp:DropDownList>
                </td>
                <td></td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <table id="tblAgregar" runat="server">
        <tr><td colspan="2"><br /><br /><b>Cargar nueva factura</b></td></tr>
        <tr>
            <td>Tipo de factura</td>
            <td>
                <asp:DropDownList ID="ddlTipoFactura" runat="server">
                    <asp:ListItem Value="lease">Autos - Renta</asp:ListItem>
                    <asp:ListItem Value="service">Autos - Servicios</asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td colspan="2"><div id="fileuploader">Upload</div></td>
        </tr>
    </table>
    <div id="divMensajesRespuesta"></div>
<%--    <asp:GridView ID="gvResultados" runat="server" CssClass="grid" Width="630px" PageSize="50" 
         EmptyDataText="No se encontraron resultados para la busqueda realizada" AutoGenerateColumns="False" 
         AllowSorting="True" AllowPaging="False">
         <HeaderStyle CssClass="grid_header" />
         <AlternatingRowStyle CssClass="grid_alternating" />
          <Columns>
              <asp:TemplateField HeaderText="Numero" SortExpression="numero">
                  <ItemTemplate>
                      <a href='<%# "/ArrendamientoDetalle.aspx?id=" & Eval("id_arrendamiento")%>'><%# Eval("numero")%></a>
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField HeaderText="Tipo" SortExpression="tipo_arrendamiento" DataField="tipo_arrendamiento" />
              <asp:BoundField HeaderText="Empresa" SortExpression="empresa" DataField="empresa" />
              <asp:BoundField HeaderText="Arrendadora" SortExpression="arrendadora" DataField="arrendadora" />
              <asp:BoundField HeaderText="Importe de Pagos" SortExpression="importe_parcialidades" DataField="importe_parcialidades" DataFormatString="{0:C2}" />
              <asp:BoundField HeaderText="Importe Total" SortExpression="importe_total" DataField="importe_total" DataFormatString="{0:C2}" />
          </Columns>
    </asp:GridView>--%>
    <br />    

<script type="text/javascript">
    $(document).ready(function () {
        RegistraUploadify();
    });
    
    function RegistraUploadify() {

        $("#fileuploader").uploadFile({
            url: "/UploadArrendamientos.ashx",
            multiple: false,
            dragDrop: false,
            fileName: "myfile",
            uploadStr: "<%=TranslateLocale.text("Subir Archivo")%>",
            allowedTypes: "csv",
            formData: { "id": 1 },
            onSuccess: function (files, data, xhr, pd) {
                if (data.indexOf("Error=").length >= 0) {
                    alert(data);
                } else {
                    ProcesarArchivo(document.getElementById('<%=ddlTipoFactura.ClientID%>').value, data);
                    $('#divMensajesRespuesta').html('Procesando archivo, espere un momento...');
                    setTimeout(function () {
                        $('.ajax-file-upload-container').html('');
                    }, 500);
                }
            },
            onError: function (files, status, errMsg, pd) {
                alert(JSON.stringify(files));
            }
        });

    }

    function ProcesarArchivo(tipo_factura, nombre) {
        $.ajax({
            type: "GET",
            url: "/Servicios/DocumentosArrendamientoFactura.aspx",
            data: { tipo_factura: tipo_factura, nombre: nombre },
            success: function (datos) {
                if (datos != 'OK') {
                    $('#divMensajesRespuesta').html('No fue posible cargar la factura:<br>' + datos);
                } else {
                    $('#divMensajesRespuesta').html('Factura agregada con éxito');
                }
            },
            error: function (error) {
                alert(error);
            }
        });
        return true;
    }
</script>
</asp:Content>

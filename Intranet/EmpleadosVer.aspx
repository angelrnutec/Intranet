<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="EmpleadosVer.aspx.vb" Inherits="Intranet.EmpleadosVer" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">


          <link href="styles/jquery-ui.css" rel="stylesheet" />  
      <script src="Scripts/jquery-1.9.1.js"></script>
      <script src="Scripts/jquery-ui.js"></script>    

      <link href="Scripts/jquery.uploadfile/uploadfile.css" rel="stylesheet">
      <script src="Scripts/jquery.uploadfile/jquery.uploadfile.min.js"></script>


    <script type="text/javascript">
        function RegistraUploadFoto() {
            $("#fileuploader").uploadFile({
                url: "/UploadFotos.ashx",
                multiple: false,
                dragDrop: false,
                fileName: "myfile",
                uploadStr: "Subir Foto",
                allowedTypes: "jpg,jpeg,png,gif",
                formData: { "id": <%=Request.QueryString("id") %> },
                onSuccess: function (files, data, xhr, pd) {
                    if (data.indexOf("Error=").length >= 0) {
                        alert(data);
                    } else {
                        MostrarImagen(data);
                        $('.ajax-file-upload-container').html('');
                    }
                },
                onError: function (files, status, errMsg, pd) {
                    alert(JSON.stringify(files));
                }
            });


        }

        function MostrarImagen(nombre)
        {
            //document.getElementById('divFoto').style.backgroundImage = 'none';
            document.getElementById('divFoto').style.backgroundImage = "url('/uploads/fotos/media/" + nombre + "')";
        }


        $(document).ready(function() {
            RegistraUploadFoto();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

  <link href="styles/jquery-ui.css" rel="stylesheet" />  
  <script src="Scripts/jquery-ui.js"></script>    
  <link rel="stylesheet" type="text/css" href="/styles/styles.css" />

   <style type="text/css">
       .swfupload
       {
           z-index: 10000 !important;
       }
        .divDialog
        {
            height: 100%;
            margin: 0 0 0 0;
            font-family: 'arialnarrow', Helvetica, sans-serif;
            font-size: 14px;
            background-image: url(/images/page_bak.png);
        }

        .tablaEmpleados
        {
            width: 550px;
            border-style: solid;
            border-width: 1px;
            border-color: #cccfd3;
        }

        .tablaEmpleados td
        {
            border-style: solid;
            border-width: 1px;
            border-color: #cccfd3;
            height: 20px;
            padding-left: 5px;
            padding-right: 5px;
        }
    </style>
    <script>
          $(function () {
              var allFields = $([]).add(name).add(divEmpleados)

              $("#dialog-form").dialog({
                  autoOpen: false,
                  height: 500,
                  width: 650,
                  modal: true,
                  buttons: {
                      "Busqueda de Empleados": function () {
                         
                          var nombre = document.getElementById('name').value

                          var params = "{nombre:'" + nombre + "'}";
                          $.ajax({
                              type: "POST",
                              url: "EmpleadosVer.aspx/RecuperaEmpleados",
                              contentType: "application/json; charset=utf-8",
                              dataType: "json",
                              async: true,
                              data: params,
                              success: function (data) {
                                  if (data.d != "") {
                                      var empleado = data.d.split('||');
                                      //alert(citas[0]);

                                      var len = empleado.length;

                                      if (len > 0) {
                                          
                                          var tablaHTML = '';                                          
                                          tablaHTML = '<table align="center" class="tablaEmpleados" cellpadding="0" cellspacing="0"><tr><td align="center"><b>Nombre</b></td>';
                                          tablaHTML += '<td><b>Departamento</b></td><td><b>Email</b></td><td align="center"><b>Seleccionar</b></td></tr>';
                                          for (i = 0; i < len; i++) {
                                              var datos = empleado[i].split(';');
                                              var d_nombre = "'" + datos[1] + "'";

                                              tablaHTML += '<tr><td>' + datos[1] + '</td>';
                                              tablaHTML += '<td>' + datos[2] + '</td>';
                                              tablaHTML += '<td>' + datos[3] + '</td>';
                                              tablaHTML += '<td align="center"><a tabindex="999" href="javascript:SeleccionaJefe(' + datos[0] + ',' + d_nombre + ')"><i class="icon-ok icon-large"></i></a></td></tr>';
                                          }

                                          tablaHTML += '</table>';

                                          document.getElementById('divEmpleados').innerHTML = tablaHTML;                                          
                                      }
                                  }
                                  else {
                                      alert("No se encontraron registros para esta busqueda!");
                                  }
                              },
                              error: function (XMLHttpRequest, textStatus, errorThrown) {
                                  alert(textStatus + ": " + XMLHttpRequest.responseText);
                              }
                          });

                      },
                      Cancel: function () {
                          $(this).dialog("close");
                      }
                  },
                  close: function () {
                      allFields.val("").removeClass("ui-state-error");
                  }
              });

          });


          function AbrirDialog(tipo) {
              $(function () {
                  if (tipo == 1) { document.getElementById('divDialogoTitulo').innerHTML = "<b>Busqueda de Jefe Directo<b/>"; }
                  else if (tipo == 2) { document.getElementById('divDialogoTitulo').innerHTML = "<b>Busqueda de Gerente<b/>"; }
                  else if (tipo == 3) { document.getElementById('divDialogoTitulo').innerHTML = "<b>Busqueda de Jefe de Area<b/>"; }

                  document.getElementById('<%=txtTipoAsignacion.ClientID%>').value = tipo;
                  $("#dialog-form").dialog("open");
              });
              return false;
          }

          function SeleccionaJefe(id_jefe, empleado) {              
              ActualizaEmpleadoJefeBD(id_jefe);

              var id_empleado = document.getElementById('<%=txtIdEmpleado.ClientID%>').value
          }

          function ActualizaEmpleadoJefeBD(id_jefe) {              
              var id_empleado = document.getElementById('<%=txtIdEmpleado.ClientID%>').value;
              var tipo_asignacion = document.getElementById('<%=txtTipoAsignacion.ClientID%>').value;
            
              var params = "{id_jefe:'" + id_jefe + "',id_empleado:'" + id_empleado + "',tipo_asignacion:'" + tipo_asignacion + "'}";
              $.ajax({
                  type: "POST",
                  url: "EmpleadosVer.aspx/ActualizaJefeEmpleado",
                  contentType: "application/json; charset=utf-8",
                  dataType: "json",
                  async: true,
                  data: params,
                  success: function (data) {
                      if (data.d != "") {
                          var resultado = data.d;

                          alert(resultado);

                          $(function () {
                              $("#dialog-form").dialog("close");
                          });

                          window.location = "EmpleadosVer.aspx?id=" + id_empleado;
                      }
                      else {
                          alert("Error al Actualizar!");
                      }
                  },
                  error: function (XMLHttpRequest, textStatus, errorThrown) {
                      alert(textStatus + ": " + XMLHttpRequest.responseText);
                  }
              });                            
          }
    </script>

    <div id="dialog-form" title="Busqueda de Empleados" class="divDialog">      
        <table>
            <tr><td colspan="2"><div id="divDialogoTitulo"></div></td></tr>
            <tr>
                <td>
                    <label for="name">Numero o Nombre del empleado</label>
                </td>
                <td>
                    <input type="text" name="name" id="name" class="text ui-widget-content ui-corner-all" />
                </td>
            </tr>
        </table>                      
        <br /><br />       
        <div id="divEmpleados"></div>
    </div>    

    <table cellpadding="0" cellspacing="0" border="0" width="95%">
        <tr>
            <td><span style="font-size:15px; font-weight:bold;">Información del Empleado</span><hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td><br /></td>
        </tr>
        <tr valign="top">
            <td>


            <div style="color:#e0dede;">
        	<table border="0" cellpadding="0" cellspacing="0" width="100%">
            	<tr valign="top"><td width="5" height="5"><img src="/images/centro_si.png" /></td><td width="300px" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td><td><div style="height:5px;"></div></td><td width="5" height="5"></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png" style="font-size:15px;">&nbsp;&nbsp;<i class="icon-user icon-large"></i>&nbsp;&nbsp;<strong><asp:Label ID="lblNombre" runat="server"></asp:Label></strong></td><td background="/images/centro_bak.png"></td><td></td><td></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td></tr><tr><td background="/images/centro_bak.png"></td>
                    <td colspan="3" background="/images/centro_bak.png">
                    	<div style="height:6px;"></div>
                        <table width="100%" border="0">
                            <tr valign="top">
                                <td rowspan="2">
                                    <table width="95%" border="0">
                                        <tr>
                                            <td>Numero:</td>
                                            <td><asp:Label ID="lblNumero" runat="server"></asp:Label></td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                            <td></td>
                                            <td></td>
                                        </tr>
                                        <tr>
                                            <td>Departamento:</td>
                                            <td><asp:Label ID="lblDepartamento" runat="server"></asp:Label></td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                            <td>Cuenta:</td>
                                            <td><asp:Label ID="lblCuenta" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>RFC:</td>
                                            <td><asp:Label ID="lblRFC" runat="server"></asp:Label></td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                            <td>IMSS:</td>
                                            <td><asp:Label ID="lblIMSS" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>CURP:</td>
                                            <td><asp:Label ID="lblCurp" runat="server"></asp:Label></td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                            <td>Fecha de Nacimiento:</td>
                                            <td><asp:Label ID="lblFechaNacimiento" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>Telefono:</td>
                                            <td><asp:Label ID="lblTelefono" runat="server"></asp:Label></td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                            <td>Fecha de alta:</td>
                                            <td><asp:Label ID="lblFechaAlta" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>Localidad:</td>
                                            <td><asp:Label ID="lblLocalidad" runat="server"></asp:Label></td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                            <td>Turno:</td>
                                            <td><asp:Label ID="lblTurno" runat="server"></asp:Label></td>
                                        </tr>
                                        <tr>
                                            <td>Direccion:</td>
                                            <td><asp:Label ID="lblDireccion" runat="server"></asp:Label></td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                            <td>Empresa:</td>
                                            <td><asp:Label ID="lblEmpresa" runat="server"></asp:Label></td>
                                        </tr>
                                    </table>

                                </td>
                                <td width="170px" align="center">
                                    <div id="divFoto" class="foto_empleado_detalle" style="<%=FotoEmpleado()%>"></div>
                                    
                                </td>
                            </tr>
                            <tr>
                                <td align="center">
                                    <div style="height:7px"></div>
                                    <div id="fileuploader">Upload</div>
                                </td>
                            </tr>
                        </table>
                    </td><td background="/images/centro_bak.png"></td></tr><tr><td width="5" height="5"><img src="/images/centro_ii.png" /></td><td colspan="3" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_id.png" /></td></tr></table>


                <br /><br />

        	<table border="0" cellpadding="0" cellspacing="0" width="100%">
            	<tr valign="top"><td width="5" height="5"><img src="/images/centro_si.png" /></td><td width="300px" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td><td><div style="height:5px;"></div></td><td width="5" height="5"></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png" style="font-size:15px;">&nbsp;&nbsp;<i class="icon-key icon-large"></i>&nbsp;&nbsp;<strong>Datos de acceso al sistema</strong></td><td background="/images/centro_bak.png"></td><td></td><td></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td></tr><tr><td background="/images/centro_bak.png"></td>
                    <td colspan="3" background="/images/centro_bak.png">
                    	<div style="height:6px;"></div>
                        <table width="95%" border="0">
                            <tr valign="top">
                                <td>
                                    <table width="430px" border="0">
                                        <tr>
                                            <td>Email:</td>
                                            <td><asp:TextBox ID="txtEmail" runat="server" Width="200px"></asp:TextBox></td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>Usuario:</td>
                                            <td><asp:TextBox ID="txtUsuario" runat="server" Width="200px"></asp:TextBox></td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>Contraseña:</td>
                                            <td><asp:TextBox ID="txtPassword" TextMode="Password" runat="server" Width="200px"></asp:TextBox></td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td colspan="3"><br /><br /><br /><br /></td>
                                        </tr>
                                        <tr>
                                            <td>Localidad:</td>
                                            <td>
                                                <asp:DropDownList ID="ddlLocalidad" runat="server"></asp:DropDownList>
                                            </td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>Núm Deudor:</td>
                                            <td>
                                                <asp:TextBox ID="txtNumDeudor" runat="server" Width="200px" MaxLength="16"></asp:TextBox>
                                            </td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>Núm Acreedor:</td>
                                            <td>
                                                <asp:TextBox ID="txtNumAcreedor" runat="server" Width="200px" MaxLength="16"></asp:TextBox>
                                            </td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>Centro de Costo:</td>
                                            <td>
                                                <asp:TextBox ID="txtCentroCosto" runat="server" Width="200px" MaxLength="16"></asp:TextBox>
                                            </td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>Núm Tarjeta de Edenred <i>(Últimos 5 digitos)</i>:</td>
                                            <td>
                                                <asp:TextBox ID="txtNumTarjetaGastos" runat="server" Width="200px" MaxLength="5"></asp:TextBox>
                                            </td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td>Núm Tarjeta de AMEX <i>(15 digitos)</i>:</td>
                                            <td>
                                                <asp:TextBox ID="txtNumTarjetaGastosAMEX" runat="server" Width="200px" MaxLength="15"></asp:TextBox>
                                            </td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td><asp:Label ID="lblPermitirGastosViajeCova" runat="server" AssociatedControlID="chkPermitirGastosViajeCova">¿Permitir gastos de viaje Cova?</asp:Label></td>
                                            <td>
                                                <asp:CheckBox ID="chkPermitirGastosViajeCova" runat="server" />
                                            </td>
                                            <td>&nbsp;&nbsp;&nbsp;</td>
                                        </tr>
                                    </table>

                                </td>
                                <td>                                    
                                    <table >
                                        <tr>
                                            <td>Jefe Directo:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                            <td>
                                                <asp:Label ID="lblJefeDirecto" runat="server"></asp:Label><br />
                                                <asp:LinkButton ID="lnkQuitarJefeDirecto" runat="server" Text="(Quitar Jefe Directo)" Visible="false" style="color:#ffffff;" OnClientClick="return confirm('Seguro que desea quitar el jefe directo a este empleado?');"></asp:LinkButton>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;<a id="lnkASignarJefeDirecto" runat="server" href="#" onclick="AbrirDialog(1);" style="color:#ffffff;"><i class="icon-search icon-large"></i></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3"><hr /></td>
                                        </tr>
                                        <tr>
                                            <td>Gerente:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                            <td>
                                                <asp:Label ID="lblGerente" runat="server"></asp:Label><br />
                                                <asp:LinkButton ID="lnkQuitarGerente" runat="server" Text="(Quitar Gerente)" Visible="false" style="color:#ffffff;" OnClientClick="return confirm('Seguro que desea quitar el gerente a este empleado?');"></asp:LinkButton>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;<a id="lnkAsignarGerente" runat="server" href="#" onclick="AbrirDialog(2);" style="color:#ffffff;"><i class="icon-search icon-large"></i></a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="3"><hr /></td>
                                        </tr>
                                        <tr>
                                            <td>Jefe de Area:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                                            <td>
                                                <asp:Label ID="lblJefeArea" runat="server"></asp:Label><br />
                                                <asp:LinkButton ID="lnkQuitarJefeArea" runat="server" Text="(Quitar Jefe de Area)" Visible="false" style="color:#ffffff;" OnClientClick="return confirm('Seguro que desea quitar el jefe de area a este empleado?');"></asp:LinkButton>
                                            </td>
                                            <td>
                                                &nbsp;&nbsp;<a id="lnkAsignarJefeArea" runat="server" href="#" onclick="AbrirDialog(3);" style="color:#ffffff;"><i class="icon-search icon-large"></i></a>
                                            </td>
                                        </tr>


                                    </table>
                                </td>
                            </tr>
                        </table>
                    </td><td background="/images/centro_bak.png"></td></tr><tr><td width="5" height="5"><img src="/images/centro_ii.png" /></td><td colspan="3" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_id.png" /></td></tr></table>          


                <br /><br />

        	<table id="tblPerfiles" runat="server" border="0" cellpadding="0" cellspacing="0" width="100%">
            	<tr valign="top"><td width="5" height="5"><img src="/images/centro_si.png" /></td><td width="300px" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td><td><div style="height:5px;"></div></td><td width="5" height="5"></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png" style="font-size:15px;">&nbsp;&nbsp;<i class="icon-list-alt icon-large"></i>&nbsp;&nbsp;<strong>Perfiles</strong></td><td background="/images/centro_bak.png"></td><td></td><td></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td></tr><tr><td background="/images/centro_bak.png"></td>
                    <td colspan="3" background="/images/centro_bak.png">
                    	<div style="height:6px;"></div>
                        <table width="95%" border="0">
                            <tr>
                                <td colspan="2">
                                    <b>Perfiles Disponibles:</b><br />
                                    <asp:ListBox ID="lbDisponibles" runat="server" Width="320px" Height="300px" SelectionMode="Multiple"></asp:ListBox>
                                </td>
                                <td align="center">
                                    <asp:Button ID="btnAgregar" runat="server" CssClass="botones" Text="&gt;" />                                    
                                    <br /><br />
                                    <asp:Button ID="btnQuitar" runat="server" CssClass="botones" Text="&lt;" />                                    
                                </td>
                                <td colspan="2">
                                    <b>Perfiles Otorgados:</b><br />
                                    <asp:ListBox ID="lbOtorgados" runat="server" Width="320px" Height="300px" SelectionMode="Multiple"></asp:ListBox>
                                </td>
                            </tr>
                        </table>
                    </td><td background="/images/centro_bak.png"></td></tr><tr><td width="5" height="5"><img src="/images/centro_ii.png" /></td><td colspan="3" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_id.png" /></td></tr></table>

                </div>

            </td>

        </tr>
        <tr>
            <td colspan="2">
                <br />
                <asp:Button ID="btnRegresar" runat="server" CssClass="botones" Text="Regresar" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnGuardar" runat="server" CssClass="botones" Text="Guardar" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnEditarExterno" runat="server" Visible="false" CssClass="botones" Text="Editar Externo" />
            </td>
        </tr>
    </table>
    <asp:TextBox ID="txtIdEmpleado" runat="server" style="display:none;"></asp:TextBox>
    <asp:TextBox ID="txtFoto" runat="server" style="display:none;"></asp:TextBox>
    <asp:TextBox ID="requierePassword" runat="server" Text="0" Visible="false"></asp:TextBox>
    <asp:TextBox ID="txtTipoAsignacion" runat="server" Text="1" style="display:none"></asp:TextBox>
</asp:Content>

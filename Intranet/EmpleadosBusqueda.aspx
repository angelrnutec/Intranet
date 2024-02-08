<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="EmpleadosBusqueda.aspx.vb" Inherits="Intranet.EmpleadosBusqueda" %>
<%@ Register TagPrefix="asp" Assembly="ExportToExcel" Namespace="KrishLabs.Web.Controls" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  <link href="styles/jquery-ui.css" rel="stylesheet" />  
  <script src="Scripts/jquery-1.9.1.js"></script>
  <script src="Scripts/jquery-ui.js"></script>    
  <link rel="stylesheet" type="text/css" href="/styles/styles.css" />

    <style type="text/css">
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
                              url: "EmpleadosBusqueda.aspx/RecuperaEmpleados",
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
          }

          function ActualizaEmpleadoJefeBD(id_jefe) {
              var datos = "";
              var id_empleado = 0;
              var grid = document.getElementById("<%= gvResultados.ClientID%>");

              if (grid.rows.length > 0) {
                  
                  for (var iFila = 0; iFila < grid.rows.length; iFila++) {
                      var inputs = grid.rows[iFila].getElementsByTagName('input');
                      id_empleado = 0;

                      for (var i = 0; i < inputs.length; i++) {
                          if (inputs[i].id.indexOf("txtEmpleado") >= 0) {                              
                              id_empleado = inputs[i].value;
                          }
                      }

                      for (var i = 0; i < inputs.length; i++) {
                          if (inputs[i].id.indexOf("chbSeleccionado") >= 0) {                              
                              if (inputs[i].checked) {
                                  datos += id_empleado + ",";
                              }
                          }                          
                      }

                  }

                  var tipo_asignacion = document.getElementById('<%=txtTipoAsignacion.ClientID%>').value;

                  if (datos != "" && id_jefe > 0) {
                      var params = "{id_jefe:'" + id_jefe + "',id_empleados:'" + datos + "',tipo_asignacion:'" + tipo_asignacion + "'}";
                      $.ajax({
                          type: "POST",
                          url: "EmpleadosBusqueda.aspx/ActualizaJefeEmpleado",
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

                                  window.location = "EmpleadosBusqueda.aspx";

                              }
                              else {
                                  alert("Error al Actualizar!");
                              }
                          },
                          error: function (XMLHttpRequest, textStatus, errorThrown) {
                              console.log(textStatus + ": " + XMLHttpRequest.responseText);
                              alert(textStatus + ": " + XMLHttpRequest.responseText);
                          }
                      });
                  }
                  else {
                      alert("No se encontraron Empleados por asignar");

                      $(function () {
                          $("#dialog-form").dialog("close");
                      });

                  }
              }
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

    <asp:Panel ID="pnlBusqueda" runat="server" DefaultButton="btnBuscar">
        <table cellpadding="0" cellspacing="0" border="0" width="600px">
            <tr>
                <td colspan="3"><span style="font-size:15px; font-weight:bold;">Busqueda de Empleados</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;&nbsp;Ingrese el texto de busqueda: (<i>Numero o Nombre del empleado</i>)</td>
                <td><asp:TextBox ID="txtBusqueda" runat="server" Width="120px"></asp:TextBox></td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;&nbsp;Empresa:</td>
                <td><asp:DropDownList ID="ddlEmpresa" runat="server"></asp:DropDownList></td>
            </tr>
            <tr>
                <td colspan="2" align="left">
                    <asp:CheckBox id="chbSoloSinJefe" runat="server" Text="Mostrar solo empleados que no cuenten con Jefe Directo" />
                </td>
            </tr>
            <tr>
                <td colspan="2" align="right">
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="botones" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar Empleado" CssClass="botones" />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvResultados" ExportFileName="Empleados_.xls" Text="Exportar a Excel" IncludeTimeStamp="true" CssClass="botones" ColumnsToExclude="0,1" EnableHyperLinks="false" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <asp:GridView ID="gvResultados" runat="server" CssClass="grid" Width="1000"
         EmptyDataText="No se encontraron resultados para la busqueda realizada" AutoGenerateColumns="False" 
         AllowSorting="True" AllowPaging="false">
         <HeaderStyle CssClass="grid_header" />
         <AlternatingRowStyle CssClass="grid_alternating" />
          <Columns>
              <asp:TemplateField HeaderText="" SortExpression="">
                  <ItemTemplate>                    
                    <input type="text" name="txtEmpleado" id="txtEmpleado" value='<%# Eval("id_empleado")%>' style="display:none;" />
                    <input type="checkbox" name="chbSeleccionado" id="chbSeleccionado" value="1" />
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Nombre" SortExpression="nombre">
                  <ItemTemplate>
                      <a href='<%# "/EmpleadosVer.aspx?id=" & Eval("id_empleado") %>'><%# Eval("nombre") %></a>
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:TemplateField HeaderText="Nombre" SortExpression="nombre" Visible="false">
                  <ItemTemplate>
                      <%# Eval("nombre") %>
                  </ItemTemplate>
              </asp:TemplateField>
              <asp:BoundField HeaderText="Departamento" SortExpression="Departamento" DataField="Departamento" />              
              <asp:BoundField HeaderText="Centro" SortExpression="centro" DataField="centro" />
              <asp:BoundField HeaderText="Jefe Directo" SortExpression="empleado_jefe" DataField="empleado_jefe" />
              <asp:BoundField HeaderText="Gerente" SortExpression="empleado_gerente" DataField="empleado_gerente" />
              <asp:BoundField HeaderText="Jefe de Area" SortExpression="empleado_jefe_area" DataField="empleado_jefe_area" />              
              <asp:BoundField HeaderText="Empresa" SortExpression="empresa" DataField="empresa" />
          </Columns>
    </asp:GridView>
    <br />
    <a id="lnkASignarJefeDirecto" runat="server" href="#" onclick="AbrirDialog(1)">Asignar Jefe Directo a los Empleados seleccionados</a>  <br />  
    <a id="lnkAsignarGerente" runat="server" href="#" onclick="AbrirDialog(2)">Asignar Gerente a los Empleados seleccionados</a>  <br />      
    <a id="lnkAsignarJefeArea" runat="server" href="#" onclick="AbrirDialog(3)">Asignar Jefe de Area a los Empleados seleccionados</a>    
    <asp:TextBox ID="txtTipoAsignacion" runat="server" Text="1" style="display:none"></asp:TextBox>
</asp:Content>

<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="ConceptoBusqueda.aspx.vb" Inherits="Intranet.ConceptoBusqueda" %>

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
        function NumCheck(e, field) {
            key = e.keyCode ? e.keyCode : e.which
            // backspace
            if (key == 8) return true
            // 0-9
            if (key > 47 && key < 58) {
                if (field.value == "") return true
                regexp = /.[0-9]{9}$/
                return !(regexp.test(field.value))
            }
            //// .
            //if (key == 46) {
            //    if (field.value == "") return false
            //    regexp = /^[0-9]+$/
            //    return regexp.test(field.value)
            //}
            // other key
            return false

        }

        function DecCheck(e, field) {
            key = e.keyCode ? e.keyCode : e.which
            // backspace
            if (key == 8) return true
            // 0-9
            if (key > 47 && key < 58) {
                if (field.value == "") return true
                regexp = /.[0-9]{9}$/
                return !(regexp.test(field.value))
            }
            // .
            if (key == 46) {
                if (field.value == "") return false
                regexp = /^[0-9]+$/
                return regexp.test(field.value)
            }
            // other key
            return false

        }

        $(function () {
            var allFields = $([]).add(name).add(divEmpleados)

            $("#dialog-form-detalle").dialog({
                autoOpen: false,
                height: 500,
                width: 650,
                modal: true,
                buttons: {
                    "Guardar": function () {
                                                                                 
                        var id_concepto = document.getElementById('txtIdConcepto').value;
                        var id_reporte = document.getElementById('<%=ddlReporte.ClientID%>').value;

                        var clave = document.getElementById('txtClave').value;
                        var descripcion = document.getElementById('txtDescripcion').value;
                        var orden = document.getElementById('txtOrden').value;
                        var formula_especial = document.getElementById('txtFormulaEspecial').value;
                        var descripcion_2 = document.getElementById('txtDescripcion2').value;

                        var resta = document.getElementById('chbResta').checked;
                        var permite_captura = document.getElementById('chbPermiteCaptura').checked;
                        var es_separador = document.getElementById('chbEsSeparador').checked;
                        var es_plan = document.getElementById('chbEsPlan').checked;
                        var es_fibras = document.getElementById('chbEsFibras').checked;
                        var es_hornos = document.getElementById('chbEsHornos').checked;

                        var id_padre = document.getElementById('<%=ddlPadre.ClientID%>').value;
                        var id_empresa = document.getElementById('<%=ddlEmpresa.ClientID%>').value;
                        var referencia = document.getElementById('<%=ddlReferencia.ClientID%>').value;
                        var referencia2 = document.getElementById('<%=ddlReferencia2.ClientID%>').value;
                        var referencia3 = document.getElementById('<%=ddlReferencia3.ClientID%>').value;                                                              

                        var params = "{id_concepto:'" + id_concepto + "', clave:'" + clave + "', descripcion:'" + descripcion + "', id_reporte:'" + id_reporte +
                                        "', orden:'" + orden + "', id_padre:'" + id_padre + "', resta:'" + resta + "', formula_especial:'" + formula_especial +
                                        "', permite_captura:'" + permite_captura + "', es_separador:'" + es_separador + "', es_plan:'" + es_plan +
                                        "', es_fibras:'" + es_fibras + "', es_hornos:'" + es_hornos + "', id_empresa:'" + id_empresa + "', descripcion_2:'" + descripcion_2 +
                                        "', referencia:'" + referencia + "', referencia2:'" + referencia2 + "', referencia3:'" + referencia3 + "'}";
                        $.ajax({
                            type: "POST",
                            url: "ConceptoBusqueda.aspx/GuardaConcepto",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            async: true,
                            data: params,
                            success: function (data) {
                                if (data.d != "") {
                                    var resultado = data.d;
                                    window.location = "ConceptoBusqueda.aspx?id_reporte=<%=ddlReporte.SelectedValue%>&id_empresa=<%=ddlFiltroEmpresa.SelectedValue%>";
                                }
                            },
                            error: function (XMLHttpRequest, textStatus, errorThrown) {
                                alert(textStatus + ": " + XMLHttpRequest.responseText);
                            }
                        });

                    },
                    "Salir": function () {
                        $(this).dialog("close");

                        LimpiarControles();
                    }
                },
                close: function () {
                    LimpiarControles();
                }
            });
                
            $("#dialog-form-baja").dialog({
                autoOpen: false,
                height: 400,
                width: 550,
                modal: true,
                buttons: {
                    "Guardar Baja": function () {

                        var id_concepto = document.getElementById('txtIdConcepto').value;
                        var anio_baja = document.getElementById('<%=ddlAnio.ClientID%>').value;
                        var periodo_baja = document.getElementById('<%=ddlMes.ClientID%>').value;

                        if (anio_baja == 0 || periodo_baja == 0) {
                            alert("Debe seleccionar el Año y Mes de Baja");
                        }
                        else {
                            var params = "{id_concepto:'" + id_concepto + "', anio_baja:'" + anio_baja + "', periodo_baja:'" + periodo_baja + "'}";
                            $.ajax({
                                type: "POST",
                                url: "ConceptoBusqueda.aspx/BajaConcepto",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                async: true,
                                data: params,
                                success: function (data) {
                                    if (data.d != "") {

                                        var resultado = data.d;

                                        //alert(resultado);

                                        //window.location = "ConceptoBusqueda.aspx";
                                        window.location = "ConceptoBusqueda.aspx?id_reporte=<%=ddlReporte.SelectedValue%>&id_empresa=<%=ddlFiltroEmpresa.SelectedValue%>";
                                    }
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    alert(textStatus + ": " + XMLHttpRequest.responseText);
                                }
                            });

                        }

                    },
                    "Salir": function () {
                        $(this).dialog("close");

                        LimpiarControlesBaja();
                    }
                },
                close: function () {
                    LimpiarControlesBaja();
                }
            });
        });

        function LimpiarControles() {
            document.getElementById('txtIdConcepto').value = "0";
            document.getElementById('txtClave').value = "";
            document.getElementById('txtDescripcion').value = "";
            document.getElementById('txtOrden').value = "";
            document.getElementById('txtFormulaEspecial').value = "";
            document.getElementById('txtDescripcion2').value = "";

            document.getElementById('chbResta').checked = 0;
            document.getElementById('chbPermiteCaptura').checked = 0;
            document.getElementById('chbEsSeparador').checked = 0;
            document.getElementById('chbEsPlan').checked = 0;
            document.getElementById('chbEsFibras').checked = 0;
            document.getElementById('chbEsHornos').checked = 0;

            document.getElementById('<%=ddlPadre.ClientID%>').value = "0";
            document.getElementById('<%=ddlEmpresa.ClientID%>').value = "0";
            document.getElementById('<%=ddlReferencia.ClientID%>').value = "";
            document.getElementById('<%=ddlReferencia2.ClientID%>').value = "";
            document.getElementById('<%=ddlReferencia3.ClientID%>').value = "";

            document.getElementById('divFechaBaja').innerHTML = "";

            document.getElementById('txtClave').disabled = false;
            document.getElementById('txtDescripcion').disabled = false;
            document.getElementById('txtOrden').disabled = false;
            document.getElementById('txtFormulaEspecial').disabled = false;
            document.getElementById('txtDescripcion2').disabled = false;
            document.getElementById('chbResta').disabled = false;
            document.getElementById('chbPermiteCaptura').disabled = false;
            document.getElementById('chbEsSeparador').disabled = false;
            document.getElementById('chbEsPlan').disabled = false;
            document.getElementById('chbEsFibras').disabled = false;
            document.getElementById('chbEsHornos').disabled = false;
            document.getElementById('<%=ddlPadre.ClientID%>').disabled = false;
            document.getElementById('<%=ddlEmpresa.ClientID%>').disabled = false;
            document.getElementById('<%=ddlReferencia.ClientID%>').disabled = false;
            document.getElementById('<%=ddlReferencia2.ClientID%>').disabled = false;
            document.getElementById('<%=ddlReferencia3.ClientID%>').disabled = false;
        }

        function LimpiarControlesBaja() {
            document.getElementById('txtIdConcepto').value = "0";
            document.getElementById('<%=ddlAnio.ClientID%>').value = "0";
            document.getElementById('<%=ddlMes.ClientID%>').value = "0";
        }

        function btnAgregar_OnClientClick() {
            document.getElementById('txtIdConcepto').value = "0";

            var id_reporte = document.getElementById('<%=ddlReporte.ClientID%>').value;

            if (id_reporte == 7 || id_reporte == 6) {
                document.getElementById('trEmpresa').style.display = "";
                document.getElementById('trReferencia').style.display = "";
                document.getElementById('trReferencia2').style.display = "";
                document.getElementById('trReferencia3').style.display = "";
            }
            else {
                document.getElementById('trEmpresa').style.display = "none";
                document.getElementById('trReferencia').style.display = "none";
                document.getElementById('trReferencia2').style.display = "none";
                document.getElementById('trReferencia3').style.display = "none";
            }

            $(function () {
                $("#dialog-form-detalle").dialog("open");
            });

            return false;
        }

        function AbrirDialogDetalle(id_concepto, clave, descripcion, orden, id_padre, resta, formula_especial, permite_captura, es_separador,
                                    es_plan, es_fibras, es_hornos, id_empresa, descripcion_2, referencia, referencia2, anio_baja, periodo_baja, referencia3) {
            

            document.getElementById('txtIdConcepto').value = id_concepto;
            document.getElementById('txtClave').value = clave;
            document.getElementById('txtDescripcion').value = descripcion;
            document.getElementById('txtOrden').value = orden;
            document.getElementById('txtFormulaEspecial').value = formula_especial;
            document.getElementById('txtDescripcion2').value = descripcion_2;
            
            
            if (resta == "True") {
                document.getElementById('chbResta').checked = 1;
            }

            if (permite_captura == "True") {
                document.getElementById('chbPermiteCaptura').checked = 1;
            }

            if (es_separador == "True") {
                document.getElementById('chbEsSeparador').checked = 1;
            }

            if (es_plan == "True") {
                document.getElementById('chbEsPlan').checked = 1;
            }

            if (es_fibras == "True") {
                document.getElementById('chbEsFibras').checked = 1;
            }


            if (es_hornos == "True") {
                document.getElementById('chbEsHornos').checked = 1;
            } 
                                           
            document.getElementById('<%=ddlPadre.ClientID%>').value = id_padre;
            document.getElementById('<%=ddlEmpresa.ClientID%>').value = id_empresa;
            document.getElementById('<%=ddlReferencia.ClientID%>').value = referencia;
            document.getElementById('<%=ddlReferencia2.ClientID%>').value = referencia2;
            document.getElementById('<%=ddlReferencia3.ClientID%>').value = referencia3;

            var id_reporte = document.getElementById('<%=ddlReporte.ClientID%>').value;

            if (id_reporte == 7 || id_reporte == 6) {
                document.getElementById('trEmpresa').style.display = "";

                if (id_reporte == 7) {
                    document.getElementById('trReferencia').style.display = "";
                    document.getElementById('trReferencia2').style.display = "";
                    document.getElementById('trReferencia3').style.display = "";
                }
                else {
                    document.getElementById('trReferencia').style.display = "none";
                    document.getElementById('trReferencia2').style.display = "none";
                    document.getElementById('trReferencia3').style.display = "none";
                }
            }
            else {
                document.getElementById('trEmpresa').style.display = "none";
                document.getElementById('trReferencia').style.display = "none";
                document.getElementById('trReferencia2').style.display = "none";
                document.getElementById('trReferencia3').style.display = "none";
            }

            if (anio_baja > 0) {
                document.getElementById('trBaja').style.display = "";
                document.getElementById('divFechaBaja').innerHTML = periodo_baja + '-' + anio_baja;

                document.getElementById('txtClave').disabled = true;
                document.getElementById('txtDescripcion').disabled = true;
                document.getElementById('txtOrden').disabled = true;
                document.getElementById('txtFormulaEspecial').disabled = true;
                document.getElementById('txtDescripcion2').disabled = true;
                document.getElementById('chbResta').disabled = true;
                document.getElementById('chbPermiteCaptura').disabled = true;
                document.getElementById('chbEsSeparador').disabled = true;
                document.getElementById('chbEsPlan').disabled = true;
                document.getElementById('chbEsFibras').disabled = true;
                document.getElementById('chbEsHornos').disabled = true;
                document.getElementById('<%=ddlPadre.ClientID%>').disabled = true;
                document.getElementById('<%=ddlEmpresa.ClientID%>').disabled = true;
                document.getElementById('<%=ddlReferencia.ClientID%>').disabled = true;
                document.getElementById('<%=ddlReferencia2.ClientID%>').disabled = true;
                document.getElementById('<%=ddlReferencia3.ClientID%>').disabled = true;

            }else {
                document.getElementById('trBaja').style.display = "none";
                document.getElementById('divFechaBaja').innerHTML = "";
            }

            $(function () {
                $("#dialog-form-detalle").dialog("open");
            });

            return false;
        }




        function AbrirDialogBaja(id_concepto, descripcion, descripcion_2) {
            
            document.getElementById('txtIdConcepto').value = id_concepto;
            document.getElementById('divConcepto').innerHTML = descripcion + ' ' + descripcion_2;

            $(function () {
                $("#dialog-form-baja").dialog("open");
            });

            return false;
        }

</script>

    <div id="dialog-form-detalle" title="Detalle del Concepto" class="divDialog">      
        <table>
            <tr>
                <td>
                    <label for="name">Clave</label>
                </td>
                <td colspan="4">
                    <input type="text" name="name" id="txtClave" style="width: 90px;" />
                    <input type="text" name="name" id="txtIdConcepto" style="display:none;" />                                       
                    <input type="text" name="name" id="txtIdReporte" style="display:none;" />                                       
                </td>
            </tr>
            <tr>
                <td>
                    <label for="name">Descripcion</label>
                </td>
                <td colspan="4">
                    <input type="text" name="name" id="txtDescripcion" style="width: 300px;" />                    
                </td>
            </tr>
            <tr>
                <td>
                    <label for="name">Orden</label>
                </td>
                <td colspan="4">
                    <input type="text" name="name" id="txtOrden" onKeyPress="return NumCheck(event, this)" style="width: 60px;" />                                        
                </td>
            </tr>
            <tr>
                <td>
                    <label for="name">Padre</label>
                </td>
                <td colspan="4">
                    <asp:DropDownList ID="ddlPadre" runat="server" Style="z-index:110;" 
                        Width="300px"></asp:DropDownList> 
                </td>
            </tr>
            <tr>
                <td>
                    <label for="name">Formula Especial</label>
                </td>
                <td colspan="4">
                    <input type="text" name="name" id="txtFormulaEspecial" style="width: 300px;" />                                        
                </td>
            </tr> 
            <tr>
                <td></td>
                <td>
                    <input type="checkbox" id="chbResta" />¿Resta?                    
                </td>
                <td></td>
                <td></td>
                <td>
                    <input type="checkbox" id="chbPermiteCaptura" />¿Permite Captura?                      
                </td>
            </tr> 
            <tr>
                <td></td>
                <td>
                    <input type="checkbox" id="chbEsSeparador" />¿Es Separador?                      
                </td>
                <td></td>
                <td></td>
                <td>
                    <input type="checkbox" id="chbEsPlan" />¿Es Plan?                                          
                </td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <input type="checkbox" id="chbEsFibras" />¿Es Fibras?                    
                </td>
                <td></td>
                <td></td>
                <td>
                    <input type="checkbox" id="chbEsHornos" />¿Es Hornos?                    
                </td>
            </tr>
            <tr id="trEmpresa">
                <td>
                    <label for="name">Empresa</label>
                </td>
                <td colspan="4">
                    <asp:DropDownList ID="ddlEmpresa" runat="server" Style="z-index:110;" 
                        Width="300px"></asp:DropDownList> 
                </td>
            </tr>
            <tr>
                <td>
                    <label for="name">Leyenda</label>
                </td>
                <td colspan="4">
                    <input type="text" name="name" id="txtDescripcion2" style="width: 300px;"/>                                                            
                </td>
            </tr>
            <tr id="trReferencia">
                <td>
                    <label for="name">Referencia</label>
                </td>
                <td colspan="4">
                    <asp:DropDownList ID="ddlReferencia" runat="server" Style="z-index:110;" 
                        Width="90px">
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                        <asp:ListItem Value="CP" Text="Corto Plazo"></asp:ListItem>
                        <asp:ListItem Value="LP" Text="Largo Plazo"></asp:ListItem>
                    </asp:DropDownList> 
                </td>
            </tr>
            <tr id="trReferencia2">
                <td>
                    <label for="name">Referencia 2</label>
                </td>
                <td colspan="4">
                    <asp:DropDownList ID="ddlReferencia2" runat="server" Style="z-index:110;" 
                        Width="90px">
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                        <asp:ListItem Value="I" Text="Interes"></asp:ListItem>
                        <asp:ListItem Value="C" Text="Capital"></asp:ListItem>
                    </asp:DropDownList> 
                </td>
            </tr>
            <tr id="trReferencia3">
                <td>
                    <label for="name">Referencia 3</label>
                </td>
                <td colspan="4">
                    <asp:DropDownList ID="ddlReferencia3" runat="server" Style="z-index:110;" 
                        Width="90px">
                        <asp:ListItem Value="" Text=""></asp:ListItem>
                        <asp:ListItem Value="MXP" Text="MXP"></asp:ListItem>
                        <asp:ListItem Value="USD" Text="USD"></asp:ListItem>
                        <asp:ListItem Value="EUR" Text="EUR"></asp:ListItem>
                    </asp:DropDownList> 
                </td>
            </tr>
            <tr id="trBaja">
                <td>
                    <label for="name"><b>Fecha de Baja</b></label>
                </td>
                <td colspan="4">
                    <div id="divFechaBaja" style="font-weight:bold;"></div>
                </td>
            </tr>
        </table> 
        <div id="divEmpleados"></div>                                     
    </div>


    <div id="dialog-form-baja" title="Baja de Concepto" class="divDialog">      
        <table>
            <tr>
                <td>
                    <label for="name"><b>Concepto: </b></label>
                </td>
                <td colspan="4">
                    <div id="divConcepto"></div>                                                         
                </td>
            </tr>
            <tr>
                <td>
                    <label for="name">Año</label>
                </td>
                <td colspan="4">
                    <asp:DropDownList ID="ddlAnio" runat="server" Style="z-index:110;" 
                        Width="300px"></asp:DropDownList> 
                </td>
            </tr>
            <tr>
                <td>
                    <label for="name">Mes</label>
                </td>
                <td colspan="4">
                    <asp:DropDownList ID="ddlMes" runat="server" Style="z-index:110;" 
                        Width="300px"></asp:DropDownList> 
                </td>
            </tr>
        </table>
    </div>

    <asp:Panel ID="pnlBusqueda" runat="server" DefaultButton="btnBuscar">
        <table cellpadding="0" cellspacing="0" border="0" width="600px">
            <tr>
                <td colspan="2"><span style="font-size:15px; font-weight:bold;">Busqueda de Conceptos</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr>
                <td>&nbsp;&nbsp;&nbsp;Seleccione el Reporte</td>
                <td>
                    <asp:DropDownList ID="ddlReporte" runat="server" Width="250px" AutoPostBack="true"></asp:DropDownList>
                </td>
            </tr>
            <tr id="trFiltroEmpresa" runat="server">
                <td>&nbsp;&nbsp;&nbsp;Seleccione la Empresa</td>
                <td>
                    <asp:DropDownList ID="ddlFiltroEmpresa" runat="server" Width="250px"></asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td colspan="2" align="right">
                    <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="botones" />
                    &nbsp;&nbsp;
                    <asp:Button ID="btnAgregar" runat="server" Text="Agregar" CssClass="botones" OnClientClick="return btnAgregar_OnClientClick();" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <asp:GridView ID="gvResultados" runat="server" CssClass="grid" Width="800px" PageSize="50" 
         EmptyDataText="No se encontraron resultados para la busqueda realizada" AutoGenerateColumns="False"
         AllowSorting="True">
         <HeaderStyle CssClass="grid_header" />
         <AlternatingRowStyle CssClass="grid_alternating" />
          <Columns>
              <asp:BoundField HeaderText="Clave" SortExpression="clave" DataField="clave" />
              <asp:BoundField HeaderText="Descripcion" SortExpression="Descripcion" DataField="descripcion" />              
              <asp:BoundField HeaderText="Leyenda" SortExpression="Leyenda" DataField="descripcion_2" />
              <asp:BoundField HeaderText="Orden" SortExpression="orden" DataField="orden" />
              <asp:BoundField HeaderText="Padre" SortExpression="Padre" DataField="padre" />
              <asp:BoundField HeaderText="Resta" SortExpression="Resta" DataField="resta_desc" />
              <asp:BoundField HeaderText="Referencia" SortExpression="Referencia" DataField="referencia3" />
              <asp:TemplateField HeaderText="Acciones">
                  <ItemTemplate>
                      <div align="center">
                          <asp:ImageButton ID="btnEditar" runat="server" ImageUrl="/images/edit.png" ToolTip="Editar Concepto" OnClientClick='<%# "return AbrirDialogDetalle(" & Eval("id_concepto") & "," & Chr(34) & Eval("clave") & Chr(34) & "," & Chr(34) & Eval("descripcion") & Chr(34) & "," & Chr(34) & Eval("orden") & Chr(34) & "," & Chr(34) & Eval("id_padre") & Chr(34) & "," & Chr(34) & Eval("resta") & Chr(34) & "," & Chr(34) & Eval("formula_especial") & Chr(34) & "," & Chr(34) & Eval("permite_captura") & Chr(34) & "," & Chr(34) & Eval("es_separador") & Chr(34) & "," & Chr(34) & Eval("es_plan") & Chr(34) & "," & Chr(34) & Eval("es_fibras") & Chr(34) & "," & Chr(34) & Eval("es_hornos") & Chr(34) & "," & IIf(IsDBNull(Eval("id_empresa")) = True, 0, Eval("id_empresa")) & "," & Chr(34) & Eval("descripcion_2") & Chr(34) & "," & Chr(34) & Eval("referencia") & Chr(34) & "," & Chr(34) & Eval("referencia2") & Chr(34) & "," & IIf(IsDBNull(Eval("anio_baja")) = True, 0, Eval("anio_baja")) & "," & IIf(IsDBNull(Eval("anio_baja")) = True, 0, Eval("periodo_baja")) & "," & Chr(34) & Eval("referencia3") & Chr(34) & ");"%>' />
                          <asp:ImageButton ID="btnBaja" runat="server" ImageUrl="/images/baja.png" ToolTip="Baja Concepto" Visible='<%# IIf(IsDBNull(Eval("anio_baja")) = True, True, False)%>'  OnClientClick='<%# "return AbrirDialogBaja(" & Eval("id_concepto") & "," & Chr(34) & Eval("descripcion") & Chr(34) & "," & Chr(34) & Eval("descripcion_2") & Chr(34) & ");"%>'  />                          
                          <asp:ImageButton ID="btnBorrar" runat="server" ImageUrl="/images/delete.png" ToolTip="Borrar Concepto" CommandName="borrar" CommandArgument='<%# Bind("id_concepto")%>'/>
                      </div>
                  </ItemTemplate>
              </asp:TemplateField>
          </Columns>
    </asp:GridView>   
         
</asp:Content>

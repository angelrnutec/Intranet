<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="SolicitudVacaciones.aspx.vb" Inherits="Intranet.SolicitudVacaciones" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
        <link rel="stylesheet" type="text/css" href="/styles/tablas.css" />
        <script src="/scripts/jquery-1.7.1.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <link href="styles/jquery-ui.css" rel="stylesheet" />  
  <script src="Scripts/jquery-ui.js"></script>    
  <link rel="stylesheet" type="text/css" href="/styles/styles.css" />

    <script type="text/javascript">
        function AbrirDialog(id_solicitud, tipo) {
            document.getElementById('txtIdSolicitudRechazo').value = id_solicitud;
            document.getElementById('txtTipo').value = tipo;
            $("#dialog-form").dialog("open");
            return false;
        }


        $(function () {

            $("#dialog-form").dialog({
                autoOpen: false,
                height: 200,
                width: 350,
                modal: true,
                buttons: {
                    "Guardar Rechazo": function () {
                        if (document.getElementById('txtMotivoRechazo').value == "") {
                            alert("<%=Translatelocale.text("Favor de ingresar el motivo del rechazo")%>");
                        } else {
                            window.location = "/SolicitudVacacionesRechazo.aspx?id=" + document.getElementById('txtIdSolicitudRechazo').value + "&motivo=" + document.getElementById('txtMotivoRechazo').value + "&tipo=" + document.getElementById('txtTipo').value;
                        }
                    },
                    "Cancelar": function () {
                        $(this).dialog("close");
                    }
                },
                close: function () {
                    //allFields.val("").removeClass("ui-state-error");
                }
            });

        });




    </script>

   <style type="text/css">
        .divDialog
        {
            height: 300px;
            margin: 0 0 0 0;
            font-family: 'arialnarrow', Helvetica, sans-serif;
            font-size: 12px;
            background-image: url(/images/page_bak.png);
        }
    </style>




    <div id="dialog-form" title="<%=TranslateLocale.text("Motivo del Rechazo")%>" class="divDialog">      
        <table>
            <tr>
                <td>
                    <label for="txtMotivoRechazo"><%=TranslateLocale.text("Motivo del Rechazo")%></label>
                </td>
                <td>
                    <input type="text" name="txtMotivoRechazo" id="txtMotivoRechazo" class="text ui-widget-content ui-corner-all" style="width:250px" />
                    <input type="text" name="txtIdSolicitudRechazo" id="txtIdSolicitudRechazo" style="display:none" />
                    <input type="text" name="txtTipo" id="txtTipo" style="display:none" />
                </td>
            </tr>
        </table>                      
        <br />
    </div>    



    <asp:Button ID="btnAgregar" runat="server" Text="Agregar Solicitud" CssClass="botones" />
    <br /><br /><br />



        <div id="divVencimientos" runat="server" style="">
        <table cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Vecimiento de mis Vacaciones (Dias Totales")%>: <asp:Label ID="lblDisponiblesTotales" runat="server"></asp:Label>)</span></td>
            </tr>
            <tr>
                <td>
                    <asp:ListView ID="lvVencimientos" runat="server">
                        <LayoutTemplate>
                            <div>
                                <table class="general" width="700px" cellpadding="1" cellspacing="0">
                                    <tr class="head">
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton1" CommandName="Sort" Text="Dias Disp." CommandArgument="disponibles" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton2" CommandName="Sort" Text="Fecha Otorgados" CommandArgument="fecha_otorgadas" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton3" CommandName="Sort" Text="Dias en Proceso" CommandArgument="dias_proceso" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton4" CommandName="Sort" Text="Proporcional" CommandArgument="proporcional" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton5" CommandName="Sort" Text="Saldo Final" CommandArgument="saldo_final" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton6" CommandName="Sort" Text="Fecha Vencimiento" CommandArgument="fecha_vencimiento" /></th>
                                    </tr>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                                </table>
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr class="<%# If(Container.DisplayIndex Mod 2 = 0, "", "even")%>">
                                <td><asp:Label ID="lblDisponibles" runat="server" Text='<%# Eval("disponibles")%>'></asp:Label></td>
                                <td><asp:Label ID="lblFechaOtorg" runat="server" Text='<%# Format(Eval("fecha_otorgadas"), "dd/MM/yyyy")%>'></asp:Label></td>
                                <td><asp:Label ID="Label2" runat="server" Text='<%# Eval("dias_proceso")%>'></asp:Label></td>
                                <td><asp:Label ID="Label3" runat="server" Text='<%# Eval("proporcional")%>'></asp:Label></td>
                                <td><asp:Label ID="Label4" runat="server" Text='<%# Eval("saldo_final")%>'></asp:Label></td>
                                <td><asp:Label ID="Label1" runat="server" Text='<%# Format(Eval("fecha_vencimiento"), "dd/MM/yyyy")%>'></asp:Label></td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate><%=TranslateLocale.text("No tiene vacaciones por vencer")%>.</EmptyDataTemplate>
                        <ItemSeparatorTemplate></ItemSeparatorTemplate>
                    </asp:ListView>
                </td>
            </tr>
        </table>
        <br /><br />
    </div>







    <div id="divMisTareas" runat="server">
        <table cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Mis Tareas Pendientes")%></span>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span style="font-size:12px;font-style:italic;"><%=TranslateLocale.text("(De click en los titulos para sortear los datos)")%></span></td>
            </tr>
            <tr>
                <td>
                    <asp:ListView ID="lvSolicitudesAuth" runat="server">
                        <LayoutTemplate>
                            <div>
                                <table class="general" width="900px" cellpadding="1" cellspacing="0">
                                    <tr class="head">
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton1" CommandName="Sort" Text="Folio" CommandArgument="folio" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton2" CommandName="Sort" Text="Empresa" CommandArgument="empresa" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton3" CommandName="Sort" Text="Dias Sol." CommandArgument="dias" /></th>
                                        <th align="left" colspan="2">Acciones</th>
                                    </tr>
                                    <tr class="head2">
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton4" CommandName="Sort" Text="Solicitante" CommandArgument="solicitante" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton5" CommandName="Sort" Text="Estatus" CommandArgument="estatus" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton6" CommandName="Sort" Text="Saldo Fin." CommandArgument="dias_disponibles" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton7" CommandName="Sort" Text="Fecha Ini" CommandArgument="fecha_ini" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton8" CommandName="Sort" Text="Fecha Fin" CommandArgument="fecha_fin" /></th>
                                    </tr>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                                </table>
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr class="<%# If(Container.DisplayIndex Mod 2 = 0, "", "even")%>">
                                <td><asp:HyperLink ID="lnkFolio" runat="server" NavigateUrl='<%# "SolicitudVacacionesAgregar.aspx?id=" & Eval("id_solicitud")%>' Text='<%# Eval("folio_txt")%>' ></asp:HyperLink></td>
                                <td><asp:Label ID="lblEmpresa" runat="server" Text='<%# Eval("empresa") %>'></asp:Label></td>
                                <td><asp:Label ID="lblDiasSol" runat="server" Text='<%# Eval("dias") %>'></asp:Label></td>
                                <td colspan="2">
                                    <asp:LinkButton ID="btnAutorizar" runat="server" Text="Autorizar" CommandName="btnAutorizar" CommandArgument='<%# Eval("id_solicitud") & "-" & Eval("tipo_auth")%>' OnClientClick="return confirm('Seguro que desea autorizar este registro?');"></asp:LinkButton>
                                    &nbsp;&nbsp;&nbsp;
                                    <a href='#' onclick='javascript:AbrirDialog(<%# Eval("id_solicitud") & "," & Eval("tipo_auth")%>);'><%=TranslateLocale.text("Rechazar")%></a>
                                </td>
                            </tr>
                            <tr class="<%# If(Container.DisplayIndex Mod 2 = 0, "", "even") %>">
                                <td><asp:Label ID="lblSolicitante" runat="server" Text='<%# Eval("solicitante")%>'></asp:Label></td>
                                <td><asp:Label ID="lblEstatus" runat="server" Text='<%# Eval("estatus") %>'></asp:Label></td>
                                <td><asp:Label ID="lblDiasFinal" runat="server" Text='<%# (Eval("dias_disponibles") - Eval("dias_en_proceso"))%>'></asp:Label></td>
                                <td><asp:Label ID="lblFechaIni" runat="server" Text='<%# Format(Eval("fecha_ini"),"dd/MM/yyyy") %>'></asp:Label></td>
                                <td><asp:Label ID="lblFechaFin" runat="server" Text='<%# Format(Eval("fecha_fin"),"dd/MM/yyyy") %>'></asp:Label></td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate><br /><br /></EmptyDataTemplate>
                        <ItemSeparatorTemplate></ItemSeparatorTemplate>
                    </asp:ListView>
                </td>
            </tr>
        </table>
        <br /><br /><br />
    </div>







    


    <div id="divVerificacionNominas" runat="server">
        <table cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Verificación de Nominas")%></span>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span style="font-size:12px;font-style:italic;"><%=TranslateLocale.text("(De click en los titulos para sortear los datos)") %></span></td>
            </tr>
            <tr>
                <td>
                    <asp:ListView ID="lvVerificacionNominas" runat="server">
                        <LayoutTemplate>
                            <div>
                                <table class="general" width="900px" cellpadding="1" cellspacing="0">
                                    <tr class="head">
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton1" CommandName="Sort" Text="Folio" CommandArgument="folio" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton2" CommandName="Sort" Text="Empresa" CommandArgument="empresa" /></th>
                                        <th align="left" colspan="2">Acciones</th>
                                    </tr>
                                    <tr class="head2">
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton3" CommandName="Sort" Text="Solicitante" CommandArgument="solicitante" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton4" CommandName="Sort" Text="Estatus" CommandArgument="estatus" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton5" CommandName="Sort" Text="Fecha Ini" CommandArgument="fecha_ini" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton6" CommandName="Sort" Text="Fecha Fin" CommandArgument="fecha_fin" /></th>
                                    </tr>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                                </table>
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr class="<%# If(Container.DisplayIndex Mod 2 = 0, "", "even")%>">
                                <td><asp:HyperLink ID="lnkFolio" runat="server" NavigateUrl='<%# "SolicitudVacacionesAgregar.aspx?id=" & Eval("id_solicitud")%>' Text='<%# Eval("folio_txt")%>' ></asp:HyperLink></td>
                                <td><asp:Label ID="lblEmpresa" runat="server" Text='<%# Eval("empresa") %>'></asp:Label></td>
                                <td colspan="2">
                                    <asp:LinkButton ID="btnCancelar" runat="server" Text="Cancelar" CommandName="btnCancelar" CommandArgument='<%# Eval("id_solicitud") %>' OnClientClick="return confirm('Seguro que desea CANCELAR estas vacaciones?');"></asp:LinkButton>
                                    &nbsp;&nbsp;&nbsp;
                                    <asp:LinkButton ID="btnVerifica" runat="server" Text="Verificada" CommandName="btnVerifica" CommandArgument='<%# Eval("id_solicitud") & "|" & Eval("fecha_ini","{0:yyyyMMdd}") & "|" & Eval("fecha_fin","{0:yyyyMMdd}") %>' OnClientClick="return confirm('Seguro que desea marcar estas vacaciones como verificadas?');"></asp:LinkButton>
                                </td>
                            </tr>
                            <tr class="<%# If(Container.DisplayIndex Mod 2 = 0, "", "even") %>">
                                <td><asp:Label ID="lblSolicitante" runat="server" Text='<%# Eval("solicitante")%>'></asp:Label></td>
                                <td><asp:Label ID="lblEstatus" runat="server" Text='<%# Eval("estatus") %>'></asp:Label></td>
                                <td><asp:Label ID="lblFechaIni" runat="server" Text='<%# Format(Eval("fecha_ini"),"dd/MM/yyyy") %>'></asp:Label></td>
                                <td><asp:Label ID="lblFechaFin" runat="server" Text='<%# Format(Eval("fecha_fin"),"dd/MM/yyyy") %>'></asp:Label></td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate><br /><br /></EmptyDataTemplate>
                        <ItemSeparatorTemplate></ItemSeparatorTemplate>
                    </asp:ListView>
                </td>
            </tr>
        </table>
        <br /><br /><br />
    </div>




    








    
    <div id="divMisSolicitudes" runat="server">
        <table cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Mis Solicitudes Realizadas")%></span>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span style="font-size:12px;font-style:italic;"><%=TranslateLocale.text("(De click en los titulos para sortear los datos)")%></span></td>
            </tr>
            <tr>
                <td>
                    <asp:ListView ID="lvSolicitudes" runat="server">
                        <LayoutTemplate>
                            <div>
                                <table class="general" width="900px" cellpadding="1" cellspacing="0">
                                    <tr class="head">
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton1" CommandName="Sort" Text="Folio" CommandArgument="folio" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton2" CommandName="Sort" Text="Empresa" CommandArgument="empresa" /></th>
                                        <th align="left" colspan="2"><asp:LinkButton runat="server" ID="lnkButton3" CommandName="Sort" Text="Solicitante" CommandArgument="solicitante" /></th>
                                    </tr>
                                    <tr class="head2">
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton4" CommandName="Sort" Text="Estatus" CommandArgument="estatus" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton5" CommandName="Sort" Text="Dias" CommandArgument="dias" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton6" CommandName="Sort" Text="Fecha Ini" CommandArgument="fecha_ini" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton7" CommandName="Sort" Text="Fecha Fin" CommandArgument="fecha_fin" /></th>
                                    </tr>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                                </table>
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr class="<%# If(Container.DisplayIndex Mod 2 = 0, "", "even")%>">
                                <td><asp:HyperLink ID="lnkFolio" runat="server" NavigateUrl='<%# "SolicitudVacacionesAgregar.aspx?id=" & Eval("id_solicitud")%>' Text='<%# Eval("folio_txt")%>' ></asp:HyperLink></td>
                                <td><asp:Label ID="lblEmpresa" runat="server" Text='<%# Eval("empresa") %>'></asp:Label></td>
                                <td colspan="2"><asp:Label ID="lblSolicitante" runat="server" Text='<%# Eval("solicitante")%>'></asp:Label></td>
                            </tr>
                            <tr class="<%# If(Container.DisplayIndex Mod 2 = 0, "", "even") %>">
                                <td><asp:Label ID="lblEstatus" runat="server" Text='<%# Eval("estatus") %>'></asp:Label></td>
                                <td><asp:Label ID="lblDias" runat="server" Text='<%# Eval("dias") %>'></asp:Label></td>
                                <td><asp:Label ID="lblFechaIni" runat="server" Text='<%# Format(Eval("fecha_ini"),"dd/MM/yyyy") %>'></asp:Label></td>
                                <td><asp:Label ID="lblFechaFin" runat="server" Text='<%# Format(Eval("fecha_fin"),"dd/MM/yyyy") %>'></asp:Label></td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate><br /><br /></EmptyDataTemplate>
                        <ItemSeparatorTemplate></ItemSeparatorTemplate>
                    </asp:ListView>
                </td>
            </tr>
        </table>
                <br /><br /><br />
    </div>


    

    <div id="divRealizado" runat="server">
        <table cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Mis Tareas Realizadas")%></span>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span style="font-size:12px;font-style:italic;"><%=TranslateLocale.text("(De click en los titulos para sortear los datos)") %></span></td>
            </tr>
            <tr>
                <td>
                    <asp:ListView ID="lvSolicitudesRealizado" runat="server">
                        <LayoutTemplate>
                            <div>
                                <table class="general" width="900px" cellpadding="1" cellspacing="0">
                                    <tr class="head">
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton1" CommandName="Sort" Text="Folio" CommandArgument="folio" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton2" CommandName="Sort" Text="Empresa" CommandArgument="empresa" /></th>
                                        <th align="left" colspan="2"><asp:LinkButton runat="server" ID="lnkButton3" CommandName="Sort" Text="Solicitante" CommandArgument="solicitante" /></th>
                                    </tr>
                                    <tr class="head2">
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton4" CommandName="Sort" Text="Estatus" CommandArgument="estatus" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton5" CommandName="Sort" Text="Dias" CommandArgument="dias" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton6" CommandName="Sort" Text="Fecha Ini" CommandArgument="fecha_ini" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton7" CommandName="Sort" Text="Fecha Fin" CommandArgument="fecha_fin" /></th>
                                    </tr>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                                </table>
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr class="<%# If(Container.DisplayIndex Mod 2 = 0, "", "even")%>">
                                <td><asp:HyperLink ID="lnkFolio" runat="server" NavigateUrl='<%# "SolicitudVacacionesAgregar.aspx?id=" & Eval("id_solicitud")%>' Text='<%# Eval("folio_txt")%>' ></asp:HyperLink></td>
                                <td><asp:Label ID="lblEmpresa" runat="server" Text='<%# Eval("empresa") %>'></asp:Label></td>
                                <td colspan="2"><asp:Label ID="lblSolicitante" runat="server" Text='<%# Eval("solicitante") %>'></asp:Label></td>
                            </tr>
                            <tr class="<%# If(Container.DisplayIndex Mod 2 = 0, "", "even") %>">
                                <td><asp:Label ID="lblEstatus" runat="server" Text='<%# Eval("estatus") & " (" & Format(Eval("fecha"),"dd/MM/yyyy HH:mm") & ")" %>'></asp:Label></td>
                                <td><asp:Label ID="lblDias" runat="server" Text='<%# Eval("dias") %>'></asp:Label></td>
                                <td><asp:Label ID="lblFechaIni" runat="server" Text='<%# Format(Eval("fecha_ini"),"dd/MM/yyyy") %>'></asp:Label></td>
                                <td><asp:Label ID="lblFechaFin" runat="server" Text='<%# Format(Eval("fecha_fin"),"dd/MM/yyyy") %>'></asp:Label></td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate><br /><br /></EmptyDataTemplate>
                        <ItemSeparatorTemplate></ItemSeparatorTemplate>
                    </asp:ListView>
                </td>
            </tr>
        </table>
        <br /><br /><br />
    </div>

    












    


    <div id="divVerificacionNominasHistorico" runat="server">
        <table cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Historico de Verificación de Nominas")%></span>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span style="font-size:12px;font-style:italic;"><%=TranslateLocale.text("(De click en los titulos para sortear los datos)")%></span></td>
            </tr>
            <tr>
                <td>
                    <asp:ListView ID="lvVerificacionNominasHistorico" runat="server">
                        <LayoutTemplate>
                            <div>
                                <table class="general" width="900px" cellpadding="1" cellspacing="0">
                                    <tr class="head">
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton1" CommandName="Sort" Text="Folio" CommandArgument="folio" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton2" CommandName="Sort" Text="Empresa" CommandArgument="empresa" /></th>
                                        <th align="left" colspan="2"><asp:LinkButton runat="server" ID="lnkButton3" CommandName="Sort" Text="Solicitante" CommandArgument="solicitante" /></th>
                                    </tr>
                                    <tr class="head2">
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton4" CommandName="Sort" Text="Estatus" CommandArgument="estatus" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton5" CommandName="Sort" Text="Dias" CommandArgument="dias" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton6" CommandName="Sort" Text="Fecha Ini" CommandArgument="fecha_ini" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton7" CommandName="Sort" Text="Fecha Fin" CommandArgument="fecha_fin" /></th>
                                    </tr>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                                </table>
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr class="<%# If(Container.DisplayIndex Mod 2 = 0, "", "even")%>">
                                <td><asp:HyperLink ID="lnkFolio" runat="server" NavigateUrl='<%# "SolicitudVacacionesAgregar.aspx?id=" & Eval("id_solicitud")%>' Text='<%# Eval("folio_txt")%>' ></asp:HyperLink></td>
                                <td><asp:Label ID="lblEmpresa" runat="server" Text='<%# Eval("empresa") %>'></asp:Label></td>
                                <td colspan="2"><asp:Label ID="lblSolicitante" runat="server" Text='<%# Eval("solicitante") %>'></asp:Label></td>
                            </tr>
                            <tr class="<%# If(Container.DisplayIndex Mod 2 = 0, "", "even") %>">
                                <td><asp:Label ID="lblEstatus" runat="server" Text='<%# Eval("estatus") & " (" & Format(Eval("fecha"),"dd/MM/yyyy HH:mm") & ")" %>'></asp:Label></td>
                                <td><asp:Label ID="lblDias" runat="server" Text='<%# Eval("dias") %>'></asp:Label></td>
                                <td><asp:Label ID="lblFechaIni" runat="server" Text='<%# Format(Eval("fecha_ini"),"dd/MM/yyyy") %>'></asp:Label></td>
                                <td><asp:Label ID="lblFechaFin" runat="server" Text='<%# Format(Eval("fecha_fin"),"dd/MM/yyyy") %>'></asp:Label></td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate><br /><br /></EmptyDataTemplate>
                        <ItemSeparatorTemplate></ItemSeparatorTemplate>
                    </asp:ListView>
                </td>
            </tr>
        </table>
        <br /><br /><br />
    </div>




    






    

</asp:Content>

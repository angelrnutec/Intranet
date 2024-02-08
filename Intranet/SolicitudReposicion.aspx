<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="SolicitudReposicion.aspx.vb" Inherits="Intranet.SolicitudReposicion" %>

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
            //var allFields = $([]).add(name).add(divEmpleados)

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
                            window.location = "/SolicitudReposicionRechazo.aspx?id=" + document.getElementById('txtIdSolicitudRechazo').value + "&motivo=" + document.getElementById('txtMotivoRechazo').value + "&tipo=" + document.getElementById('txtTipo').value;
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

       .linksPaginacion a {
           color:#3b4e8d;
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





    <asp:Button ID="btnAgregar" runat="server" Text="Agregar Solicitud de Reposición" CssClass="botones" />
    <br /><br /><br />




    <div id="divMisTareas" runat="server">
        <table cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Mis Tareas Pendientes")%></span>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span style="font-size:12px;font-style:italic;"><%=TranslateLocale.text("(De click en los titulos para sortear los datos)")%></span>
                    &nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="txtSolicitudesAuth" runat="server" placeholder="Buscar Folio" Width="100px"></asp:TextBox>
                    <asp:ImageButton ID="btnSolicitudesAuth" runat="server" ImageUrl="images/busqueda.png" Width="15" />
                </td>
            </tr>
            <tr>
                <td>
                    <div align="right" class="linksPaginacion">
                        <asp:DataPager runat="server" ID="dpSolicitudesAuthTop" PageSize="30" PagedControlID="lvSolicitudesAuth">
                                <Fields>
                                    <asp:NextPreviousPagerField FirstPageText="&lt;&lt;" ShowFirstPageButton="True" 
                                        ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                    <asp:NumericPagerField />
                                    <asp:NextPreviousPagerField LastPageText="&gt;&gt;" ShowLastPageButton="True" 
                                        ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                </Fields>                                
                        </asp:DataPager>
                    </div>                        
                    <asp:ListView ID="lvSolicitudesAuth" runat="server">
                        <LayoutTemplate>
                            <div>
                                <table class="general" width="950px;" cellpadding="1" cellspacing="0">
                                    <tr class="head">
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton1" CommandName="Sort" Text="Folio" CommandArgument="folio" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton2" CommandName="Sort" Text="Empresa" CommandArgument="empresa" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton3" CommandName="Sort" Text="Acciones" CommandArgument="folio" /></th>
                                    </tr>
                                    <tr class="head2">
                                        <th align="left" colspan="2"><asp:LinkButton runat="server" ID="lnkButton4" CommandName="Sort" Text="Estatus" CommandArgument="estatus" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton5" CommandName="Sort" Text="Solicitante" CommandArgument="solicitante" /></th>
                                    </tr>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                                </table>
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr class="<%# If(Container.DisplayIndex Mod 2 = 0, "", "even")%>">
                                <td><asp:HyperLink ID="lnkFolio" runat="server" NavigateUrl='<%# "SolicitudReposicionAgregar.aspx?id=" & Eval("id_solicitud")%>' Text='<%# Eval("folio_txt")%>' ></asp:HyperLink></td>
                                <td><asp:Label ID="lblEmpresa" runat="server" Text='<%# Eval("empresa") %>'></asp:Label></td>
                                <td colspan="2">
                                    <asp:LinkButton ID="btnAutorizar" runat="server" Text="Autorizar" CommandName="btnAutorizar" CommandArgument='<%# Eval("id_solicitud") & "-" & Eval("tipo_auth")%>' OnClientClick="return confirm('Seguro que desea autorizar este registro?');"></asp:LinkButton>
                                    &nbsp;&nbsp;&nbsp;
                                    <a href='#' onclick='javascript:AbrirDialog(<%# Eval("id_solicitud") & "," & Eval("tipo_auth")%>);'><%=TranslateLocale.text("Rechazar") %></a>
                                </td>
                            </tr>
                            <tr class="<%# If(Container.DisplayIndex Mod 2 = 0, "", "even") %>">
                                <td colspan="2"><asp:Label ID="lblEstatus" runat="server" Text='<%# Eval("estatus") %>'></asp:Label></td>
                                <td><asp:Label ID="lblSolicitante" runat="server" Text='<%# Eval("deudor")%>'></asp:Label></td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate><b><%=Translatelocale.text("Folio no encontrado") %></b></EmptyDataTemplate>
                        <ItemSeparatorTemplate></ItemSeparatorTemplate>
                    </asp:ListView>
                    <div align="right" class="linksPaginacion">
                            <asp:DataPager ID="dpSolicitudesAuth" runat="server" PagedControlID="lvSolicitudesAuth" PageSize="30">
                                <Fields>
                                    <asp:NextPreviousPagerField FirstPageText="&lt;&lt;" ShowFirstPageButton="True" 
                                        ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                    <asp:NumericPagerField />
                                    <asp:NextPreviousPagerField LastPageText="&gt;&gt;" ShowLastPageButton="True" 
                                        ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                </Fields>
                            </asp:DataPager>
                    </div>                       
                </td>
            </tr>
        </table>
        <br /><br /><br />
    </div>







    <div id="divReposicionesPorComprobar" runat="server">
        <table cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Mis Gastos Por Comprobar")%></span>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span style="font-size:12px;font-style:italic;"><%=TranslateLocale.text("(De click en los titulos para sortear los datos)")%></span>
                    &nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="txtSolicitudesPorComprobar" runat="server" placeholder="Buscar Folio" Width="100px"></asp:TextBox>
                    <asp:ImageButton ID="btnSolicitudesPorComprobar" runat="server" ImageUrl="images/busqueda.png" Width="15" />
                </td>
            </tr>
            <tr>
                <td>
                    <div align="right" class="linksPaginacion">
                        <asp:DataPager runat="server" ID="dpSolicitudesPorComprobarTop" PageSize="30" PagedControlID="lvSolicitudesPorComprobar">
                                <Fields>
                                    <asp:NextPreviousPagerField FirstPageText="&lt;&lt;" ShowFirstPageButton="True" 
                                        ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                    <asp:NumericPagerField />
                                    <asp:NextPreviousPagerField LastPageText="&gt;&gt;" ShowLastPageButton="True" 
                                        ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                </Fields>                                
                        </asp:DataPager>
                    </div>                        

                    <asp:ListView ID="lvSolicitudesPorComprobar" runat="server">
                        <LayoutTemplate>
                            <div>
                                <table class="general" width="950px;" cellpadding="1" cellspacing="0">
                                    <tr class="head">
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton1" CommandName="Sort" Text="Folio" CommandArgument="folio" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton2" CommandName="Sort" Text="Empresa" CommandArgument="empresa" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton3" CommandName="Sort" Text="Estatus" CommandArgument="estatus" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton4" CommandName="Sort" Text="Comentarios" CommandArgument="comentarios" /></th>
                                    </tr>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                                </table>
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr class="<%# If(Container.DisplayIndex Mod 2 = 0, "", "even")%>">
                                <td><asp:HyperLink ID="lnkFolio" runat="server" NavigateUrl='<%# "SolicitudReposicionAgregar.aspx?id=" & Eval("id_solicitud")%>' Text='<%# Eval("folio_txt")%>' ></asp:HyperLink></td>
                                <td><asp:Label ID="lblEmpresa" runat="server" Text='<%# Eval("empresa") %>'></asp:Label></td>
                                <td><asp:Label ID="lblEstatus" runat="server" Text='<%# Eval("estatus") %>'></asp:Label></td>
                                <td><asp:Label ID="lblComentarios" runat="server" Text='<%# Eval("comentarios") %>'></asp:Label></td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate><b><%=TranslateLocale.text("Folio no encontrado")%></b></EmptyDataTemplate>
                        <ItemSeparatorTemplate></ItemSeparatorTemplate>
                    </asp:ListView>

                    <div align="right" class="linksPaginacion">
                        <asp:DataPager runat="server" ID="dpSolicitudesPorComprobar" PageSize="30" PagedControlID="lvSolicitudesPorComprobar">
                                <Fields>
                                    <asp:NextPreviousPagerField FirstPageText="&lt;&lt;" ShowFirstPageButton="True" 
                                        ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                    <asp:NumericPagerField />
                                    <asp:NextPreviousPagerField LastPageText="&gt;&gt;" ShowLastPageButton="True" 
                                        ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                </Fields>                                
                        </asp:DataPager>
                    </div>                        

                </td>
            </tr>
        </table>
        <br /><br /><br />
    </div>



    
    <div id="divMisSolicitudes" runat="server">
        <table cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Mis Solicitudes Realizadas")%></span>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span style="font-size:12px;font-style:italic;"><%=TranslateLocale.text("(De click en los titulos para sortear los datos)")%></span>
                    &nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="txtSolicitudes" runat="server" placeholder="Buscar Folio" Width="100px"></asp:TextBox>
                    <asp:ImageButton ID="btnSolicitudes" runat="server" ImageUrl="images/busqueda.png" Width="15" />
                </td>
            </tr>
            <tr>
                <td>

                    <div align="right" class="linksPaginacion">
                        <asp:DataPager runat="server" ID="dpSolicitudesTop" PageSize="30" PagedControlID="lvSolicitudes">
                                <Fields>
                                    <asp:NextPreviousPagerField FirstPageText="&lt;&lt;" ShowFirstPageButton="True" 
                                        ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                    <asp:NumericPagerField />
                                    <asp:NextPreviousPagerField LastPageText="&gt;&gt;" ShowLastPageButton="True" 
                                        ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                </Fields>                                
                        </asp:DataPager>
                    </div>                        

                    <asp:ListView ID="lvSolicitudes" runat="server">
                        <LayoutTemplate>
                            <div>
                                <table class="general" width="950px;" cellpadding="1" cellspacing="0">
                                    <tr class="head">
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton1" CommandName="Sort" Text="Folio" CommandArgument="folio" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton2" CommandName="Sort" Text="Empresa" CommandArgument="empresa" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton3" CommandName="Sort" Text="Estatus" CommandArgument="estatus" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton4" CommandName="Sort" Text="Comentarios" CommandArgument="comentarios" /></th>
                                    </tr>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                                </table>
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr class="<%# If(Container.DisplayIndex Mod 2 = 0, "", "even")%>">
                                <td><asp:HyperLink ID="lnkFolio" runat="server" NavigateUrl='<%# "SolicitudReposicionAgregar.aspx?id=" & Eval("id_solicitud")%>' Text='<%# Eval("folio_txt")%>' ></asp:HyperLink></td>
                                <td><asp:Label ID="lblEmpresa" runat="server" Text='<%# Eval("empresa") %>'></asp:Label></td>
                                <td><asp:Label ID="lblEstatus" runat="server" Text='<%# Eval("estatus") %>'></asp:Label></td>
                                <td><asp:Label ID="lblComentarios" runat="server" Text='<%# Eval("comentarios")%>'></asp:Label></td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate><b><%=TranslateLocale.text("Folio no encontrado") %></b></EmptyDataTemplate>
                        <ItemSeparatorTemplate></ItemSeparatorTemplate>
                    </asp:ListView>

                    <div align="right" class="linksPaginacion">
                        <asp:DataPager runat="server" ID="dpSolicitudes" PageSize="30" PagedControlID="lvSolicitudes">
                                <Fields>
                                    <asp:NextPreviousPagerField FirstPageText="&lt;&lt;" ShowFirstPageButton="True" 
                                        ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                    <asp:NumericPagerField />
                                    <asp:NextPreviousPagerField LastPageText="&gt;&gt;" ShowLastPageButton="True" 
                                        ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                </Fields>                                
                        </asp:DataPager>
                    </div>                        

                </td>
            </tr>
        </table>
                <br /><br /><br />
    </div>


    

    <div id="divRealizado" runat="server">
        <table cellpadding="0" cellspacing="0" border="0">
            <tr>
                <td><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Mis Tareas Realizadas")%></span>
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                    <span style="font-size:12px;font-style:italic;"><%=TranslateLocale.text("(De click en los titulos para sortear los datos)") %></span>
                    &nbsp;&nbsp;&nbsp;
                    <asp:TextBox ID="txtSolicitudesRealizado" runat="server" placeholder="Buscar Folio" Width="100px"></asp:TextBox>
                    <asp:ImageButton ID="btnSolicitudesRealizado" runat="server" ImageUrl="images/busqueda.png" Width="15" />
                </td>
            </tr>
            <tr>
                <td>

                    <div align="right" class="linksPaginacion">
                        <asp:DataPager runat="server" ID="dpSolicitudesRealizadoTop" PageSize="30" PagedControlID="lvSolicitudesRealizado">
                                <Fields>
                                    <asp:NextPreviousPagerField FirstPageText="&lt;&lt;" ShowFirstPageButton="True" 
                                        ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                    <asp:NumericPagerField />
                                    <asp:NextPreviousPagerField LastPageText="&gt;&gt;" ShowLastPageButton="True" 
                                        ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                </Fields>                                
                        </asp:DataPager>
                    </div>                        


                    <asp:ListView ID="lvSolicitudesRealizado" runat="server">
                        <LayoutTemplate>
                            <div>
                                <table class="general" width="950px;" cellpadding="1" cellspacing="0">
                                    <tr class="head">
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton1" CommandName="Sort" Text="Folio" CommandArgument="folio" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton2" CommandName="Sort" Text="Empresa" CommandArgument="empresa" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton3" CommandName="Sort" Text="Solicitante" CommandArgument="solicitante" /></th>
                                    </tr>
                                    <tr class="head2">
                                        <th align="left" colspan="2"><asp:LinkButton runat="server" ID="lnkButton4" CommandName="Sort" Text="Estatus" CommandArgument="estatus" /></th>
                                        <th align="left"><asp:LinkButton runat="server" ID="lnkButton5" CommandName="Sort" Text="Comentarios" CommandArgument="comentarios" /></th>
                                    </tr>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                                </table>
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <tr class="<%# If(Container.DisplayIndex Mod 2 = 0, "", "even")%>">
                                <td><asp:HyperLink ID="lnkFolio" runat="server" NavigateUrl='<%# "SolicitudReposicionAgregar.aspx?id=" & Eval("id_solicitud")%>' Text='<%# Eval("folio_txt")%>' ></asp:HyperLink></td>
                                <td><asp:Label ID="lblEmpresa" runat="server" Text='<%# Eval("empresa") %>'></asp:Label></td>
                                <td><asp:Label ID="lblSolicitante" runat="server" Text='<%# Eval("solicitante") %>'></asp:Label></td>
                            </tr>
                            <tr class="<%# If(Container.DisplayIndex Mod 2 = 0, "", "even") %>">
                                <td colspan="2"><asp:Label ID="lblEstatus" runat="server" Text='<%# Eval("estatus") & " (" & Format(Eval("fecha"),"dd/MM/yyyy HH:mm") & ")" %>'></asp:Label></td>
                                <td><asp:Label ID="lblComentarios" runat="server" Text='<%# Eval("comentarios")%>'></asp:Label></td>
                            </tr>
                        </ItemTemplate>
                        <EmptyDataTemplate><b><%=TranslateLocale.text("Folio no encontrado")%></b></EmptyDataTemplate>
                        <ItemSeparatorTemplate></ItemSeparatorTemplate>
                    </asp:ListView>


                    <div align="right" class="linksPaginacion">
                        <asp:DataPager runat="server" ID="dpSolicitudesRealizado" PageSize="30" PagedControlID="lvSolicitudesRealizado">
                                <Fields>
                                    <asp:NextPreviousPagerField FirstPageText="&lt;&lt;" ShowFirstPageButton="True" 
                                        ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                    <asp:NumericPagerField />
                                    <asp:NextPreviousPagerField LastPageText="&gt;&gt;" ShowLastPageButton="True" 
                                        ShowNextPageButton="False" ShowPreviousPageButton="False" />
                                </Fields>                                
                        </asp:DataPager>
                    </div>                        

                </td>
            </tr>
        </table>
        <br /><br /><br />
    </div>

    

    

</asp:Content>

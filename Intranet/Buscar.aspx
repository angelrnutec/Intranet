<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="Buscar.aspx.vb" Inherits="Intranet.Buscar" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .ResultadoTitulo {
            font-size:15px;
            font-weight:bold;
        }
        .ResultadoDesc {
            font-size:13px;
            font-weight:normal;
        }
        .ResultadoListadoTexto {
            padding-left:20px;
            padding-right:20px;
        }
        .ResultadoListadoTexto a {
            color:#FFF;
            padding-left:0px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="width:600px">
        <div style="font-size:25px; font-weight:bold;"><asp:Label Id="lblTitulo" runat="server"></asp:Label></div>
        <hr style="margin:0; padding:0;" />
        <br />
        <br />

         



        <div id="divBusquedaContenidos" runat="server" style="color:#e0dede;">
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr valign="top"><td width="5" height="5"><img src="/images/centro_si.png" /></td><td width="300px" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td><td><div style="height:5px;"></div></td><td width="5" height="5"></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png" style="font-size:15px;">&nbsp;&nbsp;<i class="icon-bullhorn icon-large"></i>&nbsp;&nbsp;<strong>Resultados de Publicaciones</strong></td><td background="/images/centro_bak.png"></td><td></td><td></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td></tr><tr><td background="/images/centro_bak.png"></td>
                <td colspan="3" background="/images/centro_bak.png">
                    <div style="height:6px;"></div>
                    <div>

                        <asp:ListView ID="lvBusquedaContenidos" runat="server">
                            <LayoutTemplate>
                                <div>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                                </div>
                            </LayoutTemplate>
                            <ItemSeparatorTemplate>
                                <div style="padding-left:17px;padding-right:17px;">
                                    <hr style="border-style:solid;border-color:#e0dede;" />
                                </div>
                            </ItemSeparatorTemplate>
                            <ItemTemplate>
                                <div class="ResultadoListadoTexto">
                                    <a href='/Ver.aspx?p=<%# Eval("id_texto") %>'><asp:Label ID="lblTitulo" runat="server" Text='<%# Eval("titulo")%>' CssClass="ResultadoTitulo"></asp:Label></a>
                                    <div style="padding-left:5px;">
                                        <asp:Label ID="lblDescripcion" runat="server" Text='<%# Eval("descripcion_corta")%>' CssClass="ResultadoDesc"></asp:Label>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <EmptyDataTemplate><br />
                                <span style="font-size:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No se encontraron resultados para la busqueda realizada.</span><br /><br />
                            </EmptyDataTemplate>
                        </asp:ListView>
                        <br />





                    </div>
                </td><td background="/images/centro_bak.png"></td></tr><tr><td width="5" height="5"><img src="/images/centro_ii.png" /></td><td colspan="3" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_id.png" /></td></tr></table>
        </div>



        <br /><br />


        



        <div id="divBusquedaEmpleados" runat="server" style="color:#e0dede;">
            <table border="0" cellpadding="0" cellspacing="0" width="100%">
            <tr valign="top"><td width="5" height="5"><img src="/images/centro_si.png" /></td><td width="300px" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td><td><div style="height:5px;"></div></td><td width="5" height="5"></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png" style="font-size:15px;">&nbsp;&nbsp;<i class="icon-group icon-large"></i>&nbsp;&nbsp;<strong>Resultados de Personas</strong></td><td background="/images/centro_bak.png"></td><td></td><td></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td></tr><tr><td background="/images/centro_bak.png"></td>
                <td colspan="3" background="/images/centro_bak.png">
                    <div style="height:6px;"></div>
                    <div>

                        <asp:ListView ID="lvBusquedaEmpleados" runat="server">
                            <LayoutTemplate>
                                <div>
                                    <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                                </div>
                            </LayoutTemplate>
                            <ItemSeparatorTemplate>
                                <div style="clear:both;"></div>
                                <div style="padding-left:17px;padding-right:17px;">
                                    <hr style="border-style:solid;border-color:#e0dede;" />
                                </div>
                            </ItemSeparatorTemplate>
                            <ItemTemplate>

                                <div class="ResultadoListadoTexto">
                                    <div class="foto_busqueda" style="background:url('/uploads/fotos/mini/<%#Eval("fotografia")%>');background-size:70px 90px;"></div>
                                    <div style="float:left;padding-left:15px;">
                                        <a href='/VerEmp.aspx?id=<%# Eval("id_empleado") %>'><asp:Label ID="lblTitulo" runat="server" Text='<%# Eval("nombre")%>' CssClass="ResultadoTitulo"></asp:Label></a><br />
                                        <asp:Label ID="lblDescripcion" runat="server" Text='<%# Eval("departamento")%>' CssClass="ResultadoDesc"></asp:Label>
                                    </div>
                                </div>
                            </ItemTemplate>
                            <EmptyDataTemplate><br />
                                <span style="font-size:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;No se encontraron resultados para la busqueda realizada.</span><br /><br />
                            </EmptyDataTemplate>
                        </asp:ListView>
                        <br />





                    </div>
                </td><td background="/images/centro_bak.png"></td></tr><tr><td width="5" height="5"><img src="/images/centro_ii.png" /></td><td colspan="3" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_id.png" /></td></tr></table>
        </div>















    </div>
    <br />


    
    <asp:TextBox ID="txtBusqueda" runat="server" Text="" style="display:none;"></asp:TextBox>
</asp:Content>

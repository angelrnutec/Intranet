<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ucPublicacionesListado.ascx.vb" Inherits="Intranet.ucPublicacionesListado" %>
<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<style type="text/css">
    .NoticiasListado {
        float:left;
        width:330px;
        padding: 6px 6px 6px 6px;
        height:140px;
        background-image:url(/images/bak3.png);
        margin: 5px 5px 5px 5px;
    }
    .NoticiasListadoTitulo {
        font-size:15px;
        font-weight:bold;
    }
    .NoticiasListadoDesc {
        font-size:14px;
        font-weight:normal;
    }
    .NoticiasListadoTexto {
        float: left;
        width: 230px;
        padding: 0px 4px 0px 4px;
    }
    .NoticiasListadoTexto a {
        color:#fff;
    }

    .paginadorNumeros
    {
        color:#d1cdcd;	
        font-size:14px;
        font-family:Arial;
        font-weight:bold;    
        padding:5px;  
        border:none; 
        vertical-align:top;
    }

    .paginadorNumerosActual
    {
        color:black;	
        font-size:14px;
        font-family:Arial;
        font-weight:bold;    
        padding:5px;  
        border:none; 
        vertical-align:top;
    }

    .fechaPublicacion {
        font-weight: normal;
        font-style:italic; 
    }


    .nav{
        border:1px solid #ccc;
        border-width:1px 0;
        list-style:none;
        padding:0;
        font-size:14px;
    }
    .nav li{
        display:inline;
    }
    .nav a{
        display:inline-block;
        padding:7px;
        color:#ffffff;
        padding-left:15px;
        text-decoration:none;
    }
    .active a{
        display:inline-block;
        padding:7px;
        color:#ff6a00;
        padding-left:15px;
        text-decoration:underline;
    }
</style>

<div style="color:#e0dede;">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr valign="top"><td width="5" height="5"><img src="/images/centro_si.png" /></td><td width="300px" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td><td><div style="height:5px;"></div></td><td width="5" height="5"></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png" style="font-size:15px;">&nbsp;&nbsp;<i class="<%=RecuperaIcono() %> icon-large"></i>&nbsp;&nbsp;<strong><%=RecuperaTitulo() %></strong></td><td background="/images/centro_bak.png"></td><td></td><td></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td></tr><tr><td background="/images/centro_bak.png"></td>
        <td colspan="3" background="/images/centro_bak.png">
            <div style="height:6px;"></div>
            <div>
                <div id="divPublicacionCategoria" runat="server" visible="false">
                    <%=TranslateLocale.text("Filtros")%>: 
                    <div id="divCategoriasLinks" runat="server">
                    </div>
                </div>


                <div id="divPublicacionAviso" runat="server" visible="false">
                    <asp:ListView ID="lvPublicacionesAviso" runat="server">
                        <LayoutTemplate>
                            <div>
                                <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <div class="NoticiasListado" style='height:<%# IIf(Eval("liga_banner") = "", "100px", "100px")%>;'>
                                <div class="foto_empleado" style="background:url('/uploads/fotos/mini/<%#Eval("liga_banner")%>');display:<%# IIf(Eval("liga_banner")="","none","") %>"></div>
                                <div class="NoticiasListadoTexto" style='width:<%# IIf(Eval("liga_banner") = "", "330px", "230px")%>;'>
                                    <a href='/Ver.aspx?p=<%# Eval("id_texto") %>'><asp:Label ID="lblTitulo" runat="server" Text='<%# Eval(TranslateLocale.text("titulo"))%>' CssClass="NoticiasListadoTitulo"></asp:Label></a><br />
                                    <span class="fechaPublicacion"><%=TranslateLocale.text("Publicación")%>: <asp:Label ID="lblFechaPublicacion" runat="server" Text='<%# Format(Eval("fecha_publicacion"),"dd/MM/yyyy") %>'></asp:Label></span><br /><asp:Label ID="lblDescripcion" runat="server" Text='<%# IIf(Len(Eval(TranslateLocale.text("descripcion"))) > 120, Left(Eval(TranslateLocale.text("descripcion")), 120) & "...", Eval(TranslateLocale.text("descripcion")))%>' CssClass="NoticiasListadoDesc"></asp:Label>
                                </div>
                            </div>
                        </ItemTemplate>
                        <EmptyDataTemplate><br />
                            <span style="font-size:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=TranslateLocale.text("No hay publicaciones disponibles en este momento.")%></span><br /><br />
                        </EmptyDataTemplate>
                    </asp:ListView>
                    <br />
                    <div style="clear:both;"></div>
                    <div style="padding-left:30px">
                        <asp:DataPager ID="lvDataPagerAviso" runat="server" PagedControlID="lvPublicacionesAviso" PageSize="8">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Image" PreviousPageImageUrl="/images/btn_previous.png" ButtonCssClass="prew-item"  ShowNextPageButton="false"/>
                                <asp:NumericPagerField ButtonType="Link" CurrentPageLabelCssClass="paginadorNumerosActual" NumericButtonCssClass="paginadorNumeros" />
                                <asp:NextPreviousPagerField ButtonType="Image" NextPageImageUrl="/images/btn_next.png" ButtonCssClass="next-item" ShowPreviousPageButton="false" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>







                <div id="divPublicacionNormal" runat="server">
                    <asp:ListView ID="lvPublicaciones" runat="server">
                        <LayoutTemplate>
                            <div>
                                <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                            </div>
                        </LayoutTemplate>
                        <ItemTemplate>
                            <div class="NoticiasListado" style='height:<%# IIf(Eval("liga_banner") = "", "100px", "100px")%>;'>
                                <div class="foto_empleado" style="background:url('/uploads/fotos/mini/<%#Eval("liga_banner")%>');display:<%# IIf(Eval("liga_banner")="","none","") %>"></div>
                                <div class="NoticiasListadoTexto" style='width:<%# IIf(Eval("liga_banner") = "", "330px", "230px")%>;'>
                                    <a href='/Ver.aspx?p=<%# Eval("id_texto") %>'><asp:Label ID="lblTitulo" runat="server" Text='<%# Eval(TranslateLocale.text("titulo"))%>' CssClass="NoticiasListadoTitulo"></asp:Label></a><br />
                                    <span class="fechaPublicacion"><%=TranslateLocale.text("Publicación")%>: <asp:Label ID="lblFechaPublicacion" runat="server" Text='<%# Format(Eval("fecha_publicacion"),"dd/MM/yyyy") %>'></asp:Label></span>&nbsp;&nbsp;&nbsp;<asp:Label ID="lblDescripcion" runat="server" Text='<%# Eval(TranslateLocale.text("descripcion_corta"))%>' CssClass="NoticiasListadoDesc"></asp:Label>
                                </div>
                            </div>
                        </ItemTemplate>
                        <EmptyDataTemplate><br />
                            <span style="font-size:20px;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=TranslateLocale.text("No hay publicaciones disponibles en este momento.")%></span><br /><br />
                        </EmptyDataTemplate>
                    </asp:ListView>
                    <br />
                    <div style="clear:both;"></div>
                    <div style="padding-left:30px">
                        <asp:DataPager ID="lvDataPager1" runat="server" PagedControlID="lvPublicaciones" PageSize="8">
                            <Fields>
                                <asp:NextPreviousPagerField ButtonType="Image" PreviousPageImageUrl="/images/btn_previous.png" ButtonCssClass="prew-item"  ShowNextPageButton="false"/>
                                <asp:NumericPagerField ButtonType="Link" CurrentPageLabelCssClass="paginadorNumerosActual" NumericButtonCssClass="paginadorNumeros" />
                                <asp:NextPreviousPagerField ButtonType="Image" NextPageImageUrl="/images/btn_next.png" ButtonCssClass="next-item" ShowPreviousPageButton="false" />
                            </Fields>
                        </asp:DataPager>
                    </div>
                </div>

            </div>
        </td><td background="/images/centro_bak.png"></td></tr><tr><td width="5" height="5"><img src="/images/centro_ii.png" /></td><td colspan="3" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_id.png" /></td></tr></table>
</div>



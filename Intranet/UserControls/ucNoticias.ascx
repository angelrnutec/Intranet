<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ucNoticias.ascx.vb" Inherits="Intranet.ucNoticias" %>
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
</style>

<div style="color:#e0dede;">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr valign="top"><td width="5" height="5"><img src="/images/centro_si.png" /></td><td width="300px" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td><td><div style="height:5px;"></div></td><td width="5" height="5"></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png" style="font-size:15px;">&nbsp;&nbsp;<i class="icon-bullhorn icon-large"></i>&nbsp;&nbsp;<strong><%=TranslateLocale.text("Últimas Noticias")%></strong></td><td background="/images/centro_bak.png"></td><td></td><td></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td></tr><tr><td background="/images/centro_bak.png"></td>
        <td colspan="3" background="/images/centro_bak.png">
            <div style="height:6px;"></div>
            <div>

                <asp:ListView ID="lvNoticias" runat="server">
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
                                <asp:Label ID="lblDescripcion" runat="server" Text='<%# Eval(TranslateLocale.text("descripcion_corta"))%>' CssClass="NoticiasListadoDesc"></asp:Label>
                            </div>
                        </div>
                    </ItemTemplate>
                    <EmptyDataTemplate>
                        <br /><br /><br />
                    </EmptyDataTemplate>
                </asp:ListView>
                <br />





            </div>
        </td><td background="/images/centro_bak.png"></td></tr><tr><td width="5" height="5"><img src="/images/centro_ii.png" /></td><td colspan="3" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_id.png" /></td></tr></table>
</div>



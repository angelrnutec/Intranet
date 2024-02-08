<%@ Control Language="vb" AutoEventWireup="false" CodeBehind="ucCumple.ascx.vb" Inherits="Intranet.ucCumple" %>
<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<style type="text/css">
    .CumpleListado {
        float:left;
        width:225px;
        padding: 3px 3px 3px 3px;
        height:60px;
        background-image:url(/images/bak3.png);
        margin: 2px 2px 2px 2px;
    }
    .CumpleListadoTitulo {
        font-size:12px;
        font-weight:bold;
    }
    .CumpleListadoTexto a {
        text-decoration:none;
    }
    .CumpleListadoTexto a:hover {
        text-decoration:underline;
    }
    .CumpleListadoDesc {
        font-size:13px;
        font-weight:normal;
    }
    .CumpleListadoTexto {
        float: left;
        width: 160px;
        padding: 0px 3px 0px 3px;
    }
    
    .CumpleListadoFecha {
        font-size:14px;
    }
    .CumpleListadoTexto a {
        color:#fff;
    }
</style>

<div id="divCumples" runat="server" style="color:#e0dede;">
    <table border="0" cellpadding="0" cellspacing="0" width="100%">
    <tr valign="top"><td width="5" height="5"><img src="/images/centro_si.png" /></td><td width="300px" background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td><td><div style="height:5px;"></div></td><td width="5" height="5"></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png" style="font-size:15px;">&nbsp;&nbsp;<i class="icon-gift icon-large"></i>&nbsp;&nbsp;<strong><%=TranslateLocale.text("Próximos Cumpleaños")%></strong></td><td background="/images/centro_bak.png"></td><td></td><td></td></tr><tr><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td background="/images/centro_bak.png"></td><td width="5" height="5"><img src="/images/centro_sd.png" /></td></tr><tr><td background="/images/centro_bak.png"></td>
        <td colspan="3" background="/images/centro_bak.png">
            <div style="height:6px;"></div>
            <div>

                <asp:ListView ID="lvCumples" runat="server">
                    <LayoutTemplate>
                        <div>
                            <asp:PlaceHolder runat="server" ID="itemPlaceholder" />
                        </div>
                    </LayoutTemplate>
                    <ItemTemplate>
                        <div class="CumpleListado">
                            <div class="foto_cumple" style="background:url('/uploads/fotos/mini/<%#Eval("fotografia")%>');background-size:50px 59px;"></div>
                            <div class="CumpleListadoTexto">
                                <a href='/VerEmp.aspx?id=<%# Eval("id_empleado") %>'><asp:Label ID="lblTitulo" runat="server" Text='<%# Eval("nombre")%>' CssClass="CumpleListadoTitulo"></asp:Label></a><br />
                                <asp:Label ID="lblDescripcion" runat="server" Text='<%# Eval("departamento")%>' CssClass="CumpleListadoDesc"></asp:Label><br />
                                <asp:Label ID="lblFecha" runat="server" Text='<%# FechaCumple(Eval("fecha_nacimiento"))%>' CssClass="CumpleListadoFecha"></asp:Label>
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



<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepSolicitudPermisosImpresion.aspx.vb" Inherits="Intranet.RepSolicitudPermisosImpresion" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Register TagPrefix="asp" Assembly="ExportToExcel" Namespace="KrishLabs.Web.Controls" %>
<%@ Import Namespace="System.Data" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reporte</title>
	<link rel="stylesheet" type="text/css" href="/styles/styles.css" />

    <style type="text/css">
        body {
            font-family:Arial,Tahoma;
        }
        td {
            border-style:solid;
            border-color:#dedede;
            border-width:1px;
            padding-left:3px;
            padding-right:2px;
            font-size:11px;
        }
        .titulos td {
            font-size:12px;
        }

        .filaTotales {
            background-color:#bebdbd;
            font-weight:bold;
            font-size:13px;
        }
        a {
            color:#333333;
            text-decoration:none;
        }
            a:hover {
                text-decoration: underline;
            }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="padding-left:10px; padding-right:10px;">
            <br />

            <table border="0" cellpadding="0" cellspacing="0"  width="1500px">
                <tr class="filaTotales">
                    <td align="left" style='font-size:18px;padding-left:20px;'><%=TranslateLocale.text("Reporte de Solicitudes de Permisos")%></td>
                </tr>
                <tr>
                    <td align="left" style='font-size:15px;padding-left:50px;'><b><%=TranslateLocale.text("Filtros")%>:</b> <%=DefinicionParametros()%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvReporte" ExportFileName="SolicitudesPermisos.xls" Text="Exportar a Excel" IncludeTimeStamp="true" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir sin Formato" OnClientClick="window.print();" />
                    </td>
                </tr>
                <tr>
                    <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="true" width="1600px" HeaderStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF">
                        <Columns>
                            <asp:BoundField HeaderText="Folio" DataField="folio" SortExpression="folio" />
                            <asp:BoundField HeaderText="Fecha de Solicitud" DataField="fecha_solicitud" SortExpression="fecha_solicitud" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField HeaderText="Solicitante" DataField="solicitante" SortExpression="solicitante" ItemStyle-Width="190px" />
                            <asp:BoundField HeaderText="Empresa" DataField="empresa" SortExpression="empresa"  ItemStyle-Width="150px"/>
                            <asp:BoundField HeaderText="Concepto" DataField="tipo_permiso" SortExpression="tipo_permiso"  ItemStyle-Width="250px"/>
                            <asp:BoundField HeaderText="Comentarios" DataField="comentarios" SortExpression="comentarios"  ItemStyle-Width="250px"/>
                            <asp:BoundField HeaderText="Estatus" DataField="estatus" SortExpression="estatus"  ItemStyle-Width="190px"/>
                            <asp:BoundField HeaderText="Dias" DataField="dias" SortExpression="dias" />
                            <asp:BoundField HeaderText="Fecha Ini" DataField="fecha_ini" SortExpression="fecha_ini" DataFormatString="{0:dd/MM/yyyy}"/>
                            <asp:BoundField HeaderText="Fecha Fin" DataField="fecha_fin" SortExpression="fecha_fin" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField HeaderText="Nominas" DataField="empleado_nomina" SortExpression="empleado_nomina"  ItemStyle-Width="190px"/>
                            <asp:BoundField HeaderText="Autoriza Jefe" DataField="autorizacion_jefe" SortExpression="autorizacion_jefe"  ItemStyle-Width="190px"/>
                            <asp:TemplateField HeaderText="Aut. por Jefe" SortExpression="solicitud_autorizada_jefe" ItemStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblAutPorJefe" runat="server" Text='<%#Eval("solicitud_autorizada_jefe") & ifNullEmptyFecha(Eval("fecha_autoriza_jefe"))%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="Autoriza Director" DataField="autorizacion_director" SortExpression="autorizacion_director"  ItemStyle-Width="190px"/>
                            <asp:TemplateField HeaderText="Aut. por Director" SortExpression="solicitud_autorizada_director" ItemStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblAutPorDirector" runat="server" Text='<%#Eval("solicitud_autorizada_director") & ifNullEmptyFecha(Eval("fecha_autoriza_director"))%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="Fecha Verificación" DataField="fecha_verificado" SortExpression="fecha_verificado" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField HeaderText="" DataField="cancelada" SortExpression="cancelada" ItemStyle-Width="90px" />
                        </Columns>
                    </asp:GridView>

                </tr>
            </table>

            <br /><br /><br /><br />


        </div>
    </form>
</body>
<script type="text/javascript">
    //window.print();
</script>
</html>

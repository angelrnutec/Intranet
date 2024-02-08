<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepReposicionGastosImpresion.aspx.vb" Inherits="Intranet.RepReposicionGastosImpresion" %>

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
        <div style="padding-left:10px">
            <br />


            <table border="0" cellpadding="0" cellspacing="0"  width="1650px">
                <tr class="filaTotales">
                    <td align="left" style='font-size:18px;padding-left:20px;'><%=TranslateLocale.text("Reporte de Reposición de Gastos")%></td>
                </tr>
                <tr>
                    <td align="left" style='font-size:15px;padding-left:50px;'><b>Filtros:</b> <%=DefinicionParametros()%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvReporte" ExportFileName="SolicitudesReposicion.xls" Text="Exportar a Excel" IncludeTimeStamp="true" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir sin Formato" OnClientClick="window.print();" />
                    </td>
                </tr>
                <tr>
                    <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="true" width="1650px" HeaderStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF">
                        <Columns>
                            <asp:BoundField HeaderText="Folio" DataField="folio" SortExpression="folio" />
                            <asp:BoundField HeaderText="Fecha de Solicitud" DataField="fecha_solicitud" SortExpression="fecha_solicitud" DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField HeaderText="Solicitante" DataField="solicitante" SortExpression="solicitante" ItemStyle-Width="190px" />
                            <asp:BoundField HeaderText="Empresa" DataField="empresa" SortExpression="empresa"  ItemStyle-Width="150px"/>
                            <asp:BoundField HeaderText="Departamento" DataField="departamento" SortExpression="departamento" />
                            <asp:BoundField HeaderText="Estatus" DataField="estatus" SortExpression="estatus"  ItemStyle-Width="190px"/>
                            <asp:BoundField HeaderText="Total Gasto MXP" DataField="total_gasto" SortExpression="total_gasto" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right"/>
                            <asp:BoundField HeaderText="Comentarios" DataField="comentarios" SortExpression="comentarios"  ItemStyle-Width="250px"/>
                            <asp:BoundField HeaderText="Autoriza Jefe" DataField="autorizacion_jefe" SortExpression="autorizacion_jefe"  ItemStyle-Width="190px"/>
                            <asp:BoundField HeaderText="Autoriza Conta" DataField="autorizacion_conta" SortExpression="autorizacion_conta"  ItemStyle-Width="190px"/>
                            <asp:TemplateField HeaderText="Autorización Comprobación Jefe" SortExpression="comprobacion_autorizada_jefe" ItemStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblAutPorJefe" runat="server" Text='<%#Eval("comprobacion_autorizada_jefe") & ifNullEmptyFecha(Eval("fecha_comprobacion_jefe"))%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Autorización Comprobación Conta" SortExpression="comprobacion_autorizada_conta" ItemStyle-Width="100px">
                                <ItemTemplate>
                                    <asp:Label ID="lblAutPorConta" runat="server" Text='<%#Eval("comprobacion_autorizada_conta") & ifNullEmptyFecha(Eval("fecha_comprobacion_conta"))%>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField HeaderText="" DataField="cancelada" SortExpression="cancelada" ItemStyle-Width="90px" />


                        </Columns>
                    </asp:GridView>

                </tr>
            </table>



<%--<%

    Dim columnas As Integer = 24
    Dim dsReporte As DataSet = RecuperaDatosReporte()
    Dim dtDatos As DataTable = dsReporte.Tables(0)
%>
            <table border="1" cellpadding="0" cellspacing="0" width="1650px">
                <tr class="filaTotales">
                    <td align="left" colspan="<%=columnas %>" style='font-size:18px;padding-left:20px;'>Reporte de Reposición de Gastos</td>
                </tr>
                <tr>
                    <td align="left" colspan="<%=columnas %>" style='font-size:15px;padding-left:50px;'><b>Filtros:</b> <%=DefinicionParametros()%></td>
                </tr>
                <tr class="filaTotales titulos" style='font-size:14px;'>
                    <td align="center"><b>Folio</b></td>
                    <td align="center"><b>Fecha de Solicitud</b></td>
                    <td align="center"><b>Solicitante</b></td>
                    <td align="center"><b>Empresa</b></td>
                    <td align="center"><b>Departamento</b></td>
                    <td align="center"><b>Estatus</b></td>
                    <td align="center"><b>Comentarios</b></td>
                    <td align="center"><b>Autoriza Jefe</b></td>
                    <td align="center"><b>Autoriza Conta</b></td>
                    <td align="center"><b>Comp. Aut. por Jefe</b></td>
                    <td align="center"><b>Comp. Aut. por Conta</b></td>
                </tr>
<%
    Dim i As Integer=0
    For Each drDato As DataRow In dtDatos.Rows
        i += 1
%>
                <tr <%=IIf(i Mod 2 = 0, "style='background-color:#FFFFFF;'", "")%>>
                    <td><%=drDato("folio")%></td>
                    <td align="center"><%=Format(drDato("fecha_solicitud"),"dd/MM/yyyy") %></td>
                    <td width="190px"><%=drDato("solicitante")%></td>
                    <td width="150px"><%=drDato("empresa")%></td>
                    <td><%=drDato("departamento")%></td>
                    <td width="190px"><%=drDato("estatus")%></td>
                    <td width="250px"><%=drDato("comentarios")%></td>
                    <td width="190px"><%=drDato("autorizacion_jefe")%></td>
                    <td width="190px"><%=drDato("autorizacion_conta")%></td>
                    <td width="100px"><%=drDato("comprobacion_autorizada_jefe")%><%=ifNullEmptyFecha(drDato("fecha_comprobacion_jefe"))%></td>
                    <td width="100px"><%=drDato("comprobacion_autorizada_conta")%><%=ifNullEmptyFecha(drDato("fecha_comprobacion_conta"))%></td>
                </tr>
<%
Next
%>
            </table>--%>
            <br /><br /><br /><br />


        </div>
    </form>
</body>
<script type="text/javascript">
    //window.print();
</script>
</html>

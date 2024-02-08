<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="MovimientosTarjetaPendiente.aspx.vb" Inherits="Intranet.MovimientosTarjetaPendiente" %>

<%@ Import Namespace="Intranet" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="IntranetBL" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="frmPolizaEditar" runat="server">
<%    
    Dim id_empleado = Request.QueryString("id")
    Dim tipo_comprobacion = Request.QueryString("t")
    Dim id_empresa = Request.QueryString("e")
    Dim tipo_solicitud = Request.QueryString("ts")
    
    Dim mt As New MovimientosTarjeta(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
    Dim dt As DataTable = mt.RecuperaMovimientosPorComprobar(id_empleado)
    Dim dtListadoConceptos As List(Of ListadoGenerico) = RecuperaListadoConceptos(id_empresa, tipo_comprobacion, tipo_solicitud)
    Dim dtListadoTipoComprobacion As List(Of ListadoGenerico) = RecuperaListadoTipoComprobacion(id_empresa, tipo_comprobacion)
    Dim dtListadoNecesidades As List(Of ListadoGenerico) = RecuperaListadoNecesidades(id_empresa, tipo_comprobacion)
    
%>

    <div>

        <table id="tblMovimientos" style="width:870px;border-color:#eee;" border="1" cellpadding="2" cellspacing="0">
            <tr style="font-weight:bold">
                <td><%=TranslateLocale.text("Fecha")%></td>
                <%--<td><%=TranslateLocale.text("Concepto")%></td>--%>
                <td><%=TranslateLocale.text("Descripcion")%></td>
                <td><%=TranslateLocale.text("Moneda")%></td>
                <td><%=TranslateLocale.text("T.C.")%></td>
                <td><%=TranslateLocale.text("Importe original")%></td>
                <td><%=TranslateLocale.text("Importe en pesos")%></td>
                <td><%=TranslateLocale.text("Agregar")%></td>
            </tr>
<%
    
    
    Dim i As Integer = 0
    For Each dr As DataRow In dt.Rows
%>
            <tr id="mt_detalle_<%=i%>">
                <td>
                    <input type="hidden" id="mt_id_movimiento_<%=i%>" value="<%=dr("id_movimiento")%>" />
                    <%=Convert.ToDateTime(dr("fecha_movimiento")).ToString("dd/MM/yyyy")%>
                </td>
                <td><%=dr("tipo")%>-<%=dr("descripcion")%><br /><%=dr("tipo_comercio")%></td>
                <td><%=dr("moneda")%></td>
                <td align="right"><%=Convert.ToDecimal(dr("tipo_cambio")).ToString("#,###,##0.00")%></td>
                <td align="right"><%=Convert.ToDecimal(dr("moneda_extranjera")).ToString("#,###,##0.00")%></td>
                <td align="right"><%=Convert.ToDecimal(dr("pesos")).ToString("#,###,##0.00")%></td>
                <td style="text-align:center;"><input type="checkbox" id="mt_seleccionado_<%=i%>" name="seleccionado_<%=i%>" onclick="ActivaMovimientoParaAgregar(<%=i%>)" /></td>
            </tr>
            <tr id="mt_opciones_<%=i%>" style="display:none;border-bottom-color:#666">
                <td colspan="7">
                    <table cellpadding="2" cellspacing="0" border="0" width="100%">
                        <tr>
                            <td>
                                <%=IIf(tipo_comprobacion = "CC", TranslateLocale.text("Centro de Costo") & ":", "")%>
                                <%=IIf(tipo_comprobacion = "OI", TranslateLocale.text("Orden Interna") & ":", "")%>
                                <%=IIf(tipo_comprobacion = "PP", TranslateLocale.text("Elemento PEP") & ":", "")%>
                                <%=IIf(tipo_comprobacion = "RF", TranslateLocale.text("Reembolso Filiales") & ":", "")%>
                                <br />
                                <select id="mt_lista_tipo_comprobacion_<%=i%>" name="mt_lista_tipo_comprobacion_<%=i%>" style="width:130px">
                                    <%
                                        For Each l As ListadoGenerico In dtListadoTipoComprobacion
                                            Response.Write("<option value='" & l.value & "'>" & l.text & "</option>")
                                        Next
                                        %>                                    
                                </select>
                            </td>
                                <%If tipo_comprobacion = "OI" Or tipo_comprobacion = "PP" Then%>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td>
                                <%=TranslateLocale.text("Necesidad")%>:<br />
                                <select id="mt_lista_necesidad_<%=i%>" name="mt_lista_necesidad_<%=i%>" style="width:100px">
                                    <%
                                        For Each l As ListadoGenerico In dtListadoNecesidades
                                            Response.Write("<option value='" & l.value & "'>" & l.text & "</option>")
                                        Next
                                        %>                                    
                                </select>
                            </td>
                                <%End If%>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td>
                                <%=TranslateLocale.text("Concepto")%>:<br />
                                <select id="mt_lista_concepto_<%=i%>" name="mt_lista_concepto_<%=i%>" style="width:130px" onchange="javascript:MovimientosTarjetaOpcionesConcepto(<%=i%>, this.value)">
                                    <%
                                        For Each l As ListadoGenerico In dtListadoConceptos
                                            Response.Write("<option value='" & l.value & "'>" & l.text & "</option>")
                                        Next
                                        %>                                    
                                </select>
                            </td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td>
                                <%=TranslateLocale.text("I.V.A.")%>:<br />
                                <select class="mt_lista_iva_<%=i%>" id="mt_lista_iva_<%=i%>" name="mt_lista_iva_<%=i%>" style="width:60px">
                                    <option value="">--Seleccione--</option>
                                    <option value="16">16 %</option>
                                    <option value="0">0 %</option>
                                </select>
                                <input class="mt_iva_manual_<%=i%>" type="text" id="mt_iva_manual_<%=i%>" name="mt_iva_manual_<%=i%>" value="0.00" style="width:60px;display:none;" />
                            </td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td>
                                <%=TranslateLocale.text("Otros Impuestos")%>:<br />
                                <input type="text" id="mt_otros_impuestos_<%=i%>" name="mt_otros_impuestos_<%=i%>" value="0.00" style="width:60px" />
                            </td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td class="mt_propina_<%=i%>" style="display:none;">
                                <%=TranslateLocale.text("Propina")%>:<br />
                                <input type="text" id="mt_propina_<%=i%>" name="mt_propina_<%=i%>" value="0.00" style="width:60px" />
                            </td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td class="mt_retencion_<%=i%>" style="display:none;">
                                <%=TranslateLocale.text("Retencion")%>:<br />
                                <input type="text" id="mt_retencion_<%=i%>" name="mt_retencion_<%=i%>" value="0.00" style="width:60px" />
                            </td>
                                <%If tipo_solicitud = "G" Then%>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td>
                                <%=TranslateLocale.text("Num. de Personas")%>:<br />
                                <select id="mt_lista_num_personas_<%=i%>" name="mt_lista_num_personas_<%=i%>">
                                    <%For j As Integer = 1 To 30
                                            Response.Write("<option value='" & j & "'>" & j & "</option>")
                                        Next%>
                                </select>
                            </td>
                                <%End If%>
                        </tr>
                        <tr>
                            <td colspan="14">
                                <%=TranslateLocale.text("Observaciones")%>:<br />
                                <input type="text" id="mt_observaciones_<%=i%>" name="mt_observaciones_<%=i%>" value="" style="width:250px" maxlength="100" />
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>

<%                    
    i += 1
                Next
%>

        </table>

    </div>
    </form>
</body>
</html>

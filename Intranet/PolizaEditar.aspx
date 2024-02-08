<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="PolizaEditar.aspx.vb" Inherits="Intranet.PolizaEditar" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="IntranetBL" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript">
        function ActualizaCuenta(indice) {
            var id_concepto = document.getElementById('combo_cuentas_' + indice).value.split('|')[0].split('-')[0];
            var cuenta = document.getElementById('combo_cuentas_' + indice).value.split('|')[1];
            var descripcion = document.getElementById('combo_cuentas_' + indice).value.split('|')[2];

            document.getElementById('id_concepto_' + indice).value = id_concepto;
            document.getElementById('cuenta_' + indice).value = cuenta;
            document.getElementById('descripcion_' + indice).value = descripcion;
        }
    </script>
</head>
<body>
    <form id="frmPolizaEditar" runat="server">
<%    
    Dim poliza = Request.QueryString("poliza")
    Dim tipo_poliza = Request.QueryString("tipo_poliza")
    
    Dim polizaObj As New PolizaContable(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
    Dim ds As DataSet = polizaObj.RecuperaPorFolio(poliza, tipo_poliza)
    Dim dtPoliza As DataTable = ds.Tables(0)
    Dim dtPolizaDetalle As DataTable = ds.Tables(1)
    Dim dtCombo As DataTable = ds.Tables(2)

    Dim deudor As String = ""
    Dim asignacion As String = ""
    Dim total As Decimal = 0
    Dim sociedad = ""
    Dim empleado = ""
    Dim fecha_documento As String = ""
    Dim id_solicitud As String = ""
    
    If dtPoliza.Rows.Count > 0 Then
        id_solicitud = dtPoliza(0)("id_solicitud")
        empleado = dtPoliza(0)("empleado")
        deudor = dtPoliza(0)("deudor")
        sociedad = dtPoliza(0)("sociedad")
        fecha_documento = Convert.ToDateTime(dtPoliza(0)("fecha_documento")).ToString("dd/MM/yyyy")
        asignacion = dtPoliza(0)("asignacion")
        total = dtPoliza(0)("total")
    End If
    
%>

    <div>

        <table style="width:740px">
            <tr>
                <td colspan="3"><%=TranslateLocale.text("Empleado")%>: <%=empleado%></td>
            </tr>
            <tr>
                <td><%=TranslateLocale.text("Poliza")%>: <%=poliza %>
                    <input type="hidden" id="referencia" value="<%=poliza %>" />
                    <input type="hidden" id="tipo_poliza" value="<%=tipo_poliza %>" />
                    <input type="hidden" id="eliminados" value="" />
                </td>
                <td><%=TranslateLocale.text("Deudor")%>: <%=deudor%></td>
                <td><%=TranslateLocale.text("Sociedad")%>: <%=sociedad%></td>
            </tr>
            <tr>
                <td><%=TranslateLocale.text("Fecha Doc")%>: <%=fecha_documento%>
                    <input type="date" id="dtFechaDoc" value="<%=Convert.ToDateTime(dtPoliza(0)("fecha_documento")).ToString("yyyy-MM-dd")%>" style="width:120px" />
                </td>
                <td><%=TranslateLocale.text("Asignacion")%>: <%=asignacion%></td>
                <td><%=TranslateLocale.text("Total")%>: <%=total.ToString("#,###,##0.00")%></td>
            </tr>
        </table>
        <hr />
        <input type="hidden" id="poliza" value="<%=poliza%>" />
        <input type="hidden" id="id_solicitud" value="<%=id_solicitud%>" />
        <input type="hidden" id="importeTotal" value="<%=total%>" />
        <input type="hidden" id="detallesAgregados" value="<%=(dtPolizaDetalle.Rows.Count-1)%>" />
        <table id="tblDetallesPoliza" style="width:770px">
            <tr>
                <td><%=TranslateLocale.text("Cuenta")%></td>
                <td><%=TranslateLocale.text("Clave IVA")%></td>
                <td><%=TranslateLocale.text(IIf(tipo_poliza <> "SVA", "Proyecto", "Acreedor"))%></td>
                <td><%=TranslateLocale.text("Necesidad")%></td>
                <td><%=TranslateLocale.text("Importe")%></td>
                <td><%=TranslateLocale.text("Descripcion")%></td>
                <td><%=TranslateLocale.text("Tipo Comprobacion")%></td>
            </tr>
<%
    
    
    Dim i As Integer = 0
    For Each dr As DataRow In dtPolizaDetalle.Rows
%>
            <tr id="detalle_<%=i%>">
                <td>
                    <input type="hidden" id="id_detalle_<%=i%>" value="<%=dr("id")%>" />
                    <input type="text" id="cuenta_<%=i%>" value="<%=dr("cuenta")%>" style="width:80px" maxlength="17" readonly="readonly" />
                </td>
                <td><input type="text" id="clave_<%=i%>" value="<%=dr("clave_iva")%>" style="width:45px" maxlength="2" /></td>
                <td><input type="text" id="proyecto_<%=i%>" value="<%=dr("proyecto")%>" style="width:100px" maxlength="12" /></td>
                <td><input type="text" id="necesidad_<%=i%>" value="<%=dr("no_necesidad")%>" style="width:40px" maxlength="4" /></td>
                <td><input type="text" id="importe_<%=i%>" value="<%=dr("importe_sin_iva")%>" style="width:70px" maxlength="12" /></td>
<%--                <td><input type="text" id="descripcion_<%=i%>" value="<%=dr("descripcion")%>" style="width:250px" maxlength="50" /></td>--%>
                <td>
                    <input type="text" id="descripcion_<%=i%>" value="<%=dr("descripcion")%>" style="display:none" maxlength="50" />
                    <input type="text" id="id_concepto_<%=i%>" value="<%=dr("id_concepto")%>" style="display:none" maxlength="50" />
                    <select id="combo_cuentas_<%=i%>" style="width:250px" onchange="ActualizaCuenta(<%=i%>)">

<% 
    For Each drC As DataRow In dtCombo.Rows
     %>
     <option value='<%=drC("cuenta_combo") & "|" & drC("cuenta") & "|" & drC("desc_poliza")%>' <%=IIf(drC("cuenta_combo").ToString() = dr("cuenta_combo").ToString(), "selected", "")%>><%=drC("descripcion")%></option>
<% 
    Next
     %>
                    </select>
                </td>
                <td>
                    <select id="tipo_comprobacion_<%=i%>" style="width:45px">

                        <% If tipo_poliza = "SVA" then %>
                        <option value="" <%=IIf(dr("tipo_comprobacion") = "", "selected", "")%>>N/A</option>
                        <% Else%>
                        <option value="OI" <%=IIf(dr("tipo_comprobacion") = "OI", "selected", "")%>>OI</option>
                        <option value="CC" <%=IIf(dr("tipo_comprobacion") = "CC", "selected", "")%>>CC</option>
                        <option value="PP" <%=IIf(dr("tipo_comprobacion") = "PP", "selected", "")%>>EP</option>
                        <option value="RF" <%=IIf(dr("tipo_comprobacion") = "RF", "selected", "")%>>RF</option>
                        <% End If%>
                    </select><a href="javascript:EliminarDetalle(<%=i%>,<%=dr("id")%>)"><%=TranslateLocale.text("Eliminar")%></a>
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

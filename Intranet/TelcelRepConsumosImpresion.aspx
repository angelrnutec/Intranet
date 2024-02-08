<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="TelcelRepConsumosImpresion.aspx.vb" Inherits="Intranet.TelcelRepConsumosImpresion" %>
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

            <table border="0" cellpadding="0" cellspacing="0">
                <tr class="filaTotales">
                    <td align="left" style='font-size:18px;padding-left:20px;'>Presentación Detallada de Telefonía</td>
                </tr>
                <tr>
                    <td align="left" style='font-size:15px;padding-left:50px;'><b>Filtros:</b> <%=DefinicionParametros()%>
                        &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvReporte" ExportFileName="TelefoniaDetalle_.xls" Text="Exportar a Excel" IncludeTimeStamp="true" />
                        &nbsp;&nbsp;&nbsp;
                        <asp:Button ID="btnImprimir" runat="server" Text="Imprimir sin Formato" OnClientClick="window.print();" />
                    </td>
                </tr>
                <tr>
                    <asp:GridView ID="gvReporte" runat="server" AutoGenerateColumns="false" AllowPaging="false" AllowSorting="true" width="4500px" HeaderStyle-CssClass="filaTotales titulos" FooterStyle-CssClass="filaTotales titulos" AlternatingRowStyle-BackColor="#FFFFFF" ShowFooter="true">
                        <Columns>
                            <asp:BoundField HeaderText="Proveedor" DataField="proveedor" SortExpression="proveedor" ItemStyle-Wrap="false" />
                            <asp:BoundField HeaderText="Mes" DataField="mes" SortExpression="mes" ItemStyle-Wrap="false" />
                            <asp:BoundField HeaderText="Region" DataField="region" SortExpression="region" />
                            <asp:BoundField HeaderText="Padre" DataField="padre" SortExpression="padre" />
                            <asp:BoundField HeaderText="Cuenta" DataField="cuenta" SortExpression="cuenta" />
                            <asp:BoundField HeaderText="Razon Social" DataField="razon_social" SortExpression="razon_social" ItemStyle-Wrap="false" />
                            <asp:BoundField HeaderText="Empresa" DataField="empresa" SortExpression="empresa" />
                            <asp:BoundField HeaderText="Empleado" DataField="empleado" SortExpression="empleado" ItemStyle-Wrap="false" />
                            <asp:BoundField HeaderText="Telefono" DataField="telefono" SortExpression="telefono" ItemStyle-Wrap="false" />
                            <asp:BoundField HeaderText="Fecha Factura" DataField="fecha_factura" SortExpression="fecha_factura" DataFormatString="{0:dd/MM/yyyy}" ItemStyle-Wrap="false" />
                            <asp:BoundField HeaderText="Factura" DataField="factura" SortExpression="factura" />
                            <asp:BoundField HeaderText="Plan" DataField="nombre_plan" SortExpression="nombre_plan" ItemStyle-Wrap="false" />
                            <asp:BoundField HeaderText="Renta" DataField="renta" SortExpression="renta" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="Serv Adicionales" DataField="serv_adicionales" SortExpression="serv_adicionales" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="TA Importe" DataField="ta_importe" SortExpression="ta_importe" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="TA Min Libr Pico" DataField="ta_min_libres_pico" SortExpression="ta_min_libres_pico" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="TA Min Fact Pico" DataField="ta_min_factur_pico" SortExpression="ta_min_factur_pico" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="TA Min Libr No Pico" DataField="ta_min_libres_nopico" SortExpression="ta_min_libres_nopico" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="TA Min Fact No Pico" DataField="ta_min_factur_nopico" SortExpression="ta_min_factur_nopico" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="TA Min Tot" DataField="ta_min_tot" SortExpression="ta_min_tot" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="LD Total" DataField="ld_total" SortExpression="ld_total" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="LDN Importa" DataField="ldn_importe" SortExpression="ldn_importe" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="LDN Min Libr" DataField="ldn_libres" SortExpression="ldn_libres" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="LDN Min Fact" DataField="ldn_factur" SortExpression="ldn_factur" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="LDN Min Tot" DataField="ldn_min_tot" SortExpression="ldn_min_tot" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="LDI Importe" DataField="ldi_importe" SortExpression="ldi_importe" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="LDI Min Libr" DataField="ldi_libres" SortExpression="ldi_libres" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="LDI Min Fac" DataField="ldi_factur" SortExpression="ldi_factur" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="LDI Min Tot" DataField="ldi_min_tot" SortExpression="ldi_min_tot" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="LDM Importe" DataField="ldm_importe" SortExpression="ldm_importe" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="LDM Min Libr" DataField="ldm_libres" SortExpression="ldm_libres" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right"  FooterStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="LDM Min Fact" DataField="ldm_factur" SortExpression="ldm_factur" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="LDM Min Tot" DataField="ldm_min_tot" SortExpression="ldm_min_tot" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="TARN Importe" DataField="tarn_importe" SortExpression="tarn_importe" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="TARN Min Libr" DataField="tarn_libres" SortExpression="tarn_libres" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="TARN Min Fact" DataField="tarn_factur" SortExpression="tarn_factur" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="TARN Min Tot" DataField="tarn_min_tot" SortExpression="tarn_min_tot" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="LDRN Importe" DataField="ldrn_importe" SortExpression="ldrn_importe" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="LDRN Min Libr" DataField="ldrn_libres" SortExpression="ldrn_libres" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="LDRN Min Fact" DataField="ldrn_factur" SortExpression="ldrn_factur" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="LDRN Min Tot" DataField="ldrn_min_tot" SortExpression="ldrn_min_tot" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="TARI Importe" DataField="tari_importe" SortExpression="tari_importe" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="TARI Min Libr" DataField="tari_libres" SortExpression="tari_libres" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="TARI Min Fact" DataField="tari_factur" SortExpression="tari_factur" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="TARI Min Tot" DataField="tari_min_tot" SortExpression="tari_min_tot" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="LDRI Importe" DataField="ldri_importe" SortExpression="ldri_importe" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="LDRI Min Libr" DataField="ldri_libres" SortExpression="ldri_libres" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="LDRI Min Fact" DataField="ldri_factur" SortExpression="ldri_factur" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="LDRI Min Tot" DataField="ldri_min_tot" SortExpression="ldri_min_tot" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="Importe SVA" DataField="importe_siva" SortExpression="importe_siva" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="Fianza" DataField="fianza" SortExpression="fianza" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="Descuento TAR" DataField="descuento_tar" SortExpression="descuento_tar" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="Renta Roaming" DataField="renta_roaming" SortExpression="renta_roaming" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="Impuestos" DataField="impuestos" SortExpression="impuestos" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="Cargos" DataField="cargos" SortExpression="cargos" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                            <asp:BoundField HeaderText="Min Totales" DataField="min_totales" SortExpression="min_totales" DataFormatString="{0:#,###,##0}" ItemStyle-HorizontalAlign="Right" FooterStyle-HorizontalAlign="Right"  />
                        </Columns>
                    </asp:GridView>
                </tr>
            </table>
                    <br />
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;*El periodo del reporte corresponde al mes en que los consumos se realizaron.
                    <br />
                    <br />
                    <br />
                    <br />



        </div>
    </form>
</body>
<script type="text/javascript">
    //window.print();
</script>
</html>

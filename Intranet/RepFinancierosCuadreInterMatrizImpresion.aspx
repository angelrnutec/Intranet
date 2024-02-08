<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepFinancierosCuadreInterMatrizImpresion.aspx.vb" Inherits="Intranet.RepFinancierosCuadreInterMatrizImpresion" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Register TagPrefix="asp" Assembly="ExportToExcel" Namespace="KrishLabs.Web.Controls" %>
<%@ Import Namespace="System.Data" %>



<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Reporte</title>
	<link rel="stylesheet" type="text/css" href="/styles/styles.css" />

    <style type="text/css">
        td {
            border-style:solid;
            border-color:#dedede;
            border-width:1px;
            padding-left:5px;
            padding-right:4px;
        }
        .filaHeader {
            background-color:#9de7d7;
            font-weight:bold;
        }

        .filaTotales {
            font-weight:bold;
        }
        .filaSeparador {
            background-color:#9de7d7;
            font-weight:bold;
            color:#000;
        }
        .negativo {
            color: red;
        }
        body {
            background-image: none !important;
            background-color: #fff;
            font-family: Arial !important;
            font-size:12px;
            height:auto !important;
        }
        .headerRow
        {
            background-color:#9DE7D7;
        }   

    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div style="padding-left:20px">
            <br />


                <div style='padding-left:20px; font-size:19px;'><%=TranslateLocale.text("Cuadre de Intercompañias")%></div>
                <div style='padding-left:25px; font-size:17px;'><%=NombreEmpresa() %> - <%=NombrePeriodo(Request.QueryString("m")) & "/" & Request.QueryString("a")%></div>

            <div id="divReporteNormal" runat="server">
                <h3>Cuadre de Intercompañias OPERATIVAS</h3>
                <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvSumarizadoOperativas" ExportFileName="CuadreIntercompaniesOperativas_.xls" Text="Exportar a Excel" IncludeTimeStamp="true" EnableHyperLinks="false" />
                <asp:GridView ID="gvSumarizadoOperativas" runat="server" 
                                AllowPaging="false" 
                                AllowSorting="false" 
                                AutoGenerateColumns="false"
                                Width="950px">
                    <Columns>
                        <asp:BoundField HeaderText="Empresa" DataField="descripcion" HeaderStyle-Font-Bold="true" />
                        <asp:BoundField HeaderText="Nutec Europe" DataField="empresa_7" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField HeaderText="Nutec Fibratec" DataField="empresa_8" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField HeaderText="Nutec IBAR" DataField="empresa_9" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField HeaderText="Nutec Procal" DataField="empresa_10" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField HeaderText="Grupo Nutec" DataField="empresa_11" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField HeaderText="Nutec Bickley" DataField="empresa_3" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField HeaderText="Nutec Bickley Asia" DataField="empresa_4" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField HeaderText="Nutec Corporativo" DataField="empresa_6" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField HeaderText="Nutec USA" DataField="empresa_12" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField HeaderText="Nutec NPC" DataField="empresa_13" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                        <asp:BoundField HeaderText="Suma" DataField="suma" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />

                    </Columns>
                </asp:GridView>





                <br /><br /><br /><br />











                   <h3>Cuadre de Intercompañias FISCALES</h3>
                



                    <asp:ExportToExcel runat="server" ID="ExportToExcel3" GridViewID="gvSumarizadoFiscales" ExportFileName="CuadreIntercompaniesFiscales_.xls" Text="Exportar a Excel" IncludeTimeStamp="true" EnableHyperLinks="false" />
                    <asp:GridView ID="gvSumarizadoFiscales" runat="server" 
                                    AllowPaging="false" 
                                    AllowSorting="false" 
                                    AutoGenerateColumns="false"
                                    Width="950px">
                        <Columns>
                            <asp:BoundField HeaderText="Empresa" DataField="descripcion" HeaderStyle-Font-Bold="true" />
                            <asp:BoundField HeaderText="Nutec Europe" DataField="empresa_7" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="Nutec Fibratec" DataField="empresa_8" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="Nutec IBAR" DataField="empresa_9" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="Nutec Procal" DataField="empresa_10" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="Grupo Nutec" DataField="empresa_11" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="Nutec Bickley" DataField="empresa_3" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="Nutec Bickley Asia" DataField="empresa_4" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="Nutec Corporativo" DataField="empresa_6" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="Nutec USA" DataField="empresa_12" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="Nutec NPC" DataField="empresa_13" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />
                            <asp:BoundField HeaderText="Suma" DataField="suma" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />

                        </Columns>
                    </asp:GridView>



                <br />
                <div style="clear:both"></div>
            </div>
            
        </div>
    </form>
                <div style="clear:both"></div>
    <br />
</body>
<script type="text/javascript">
    //window.print();
</script>
</html>

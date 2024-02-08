<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="RepFinancierosCuadreInterImpresion.aspx.vb" Inherits="Intranet.RepFinancierosCuadreInterImpresion" %>

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
            /*background-color:#9de7d7;*/
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
                    <asp:ExportToExcel runat="server" ID="ExportToExcel1" GridViewID="gvCapturaCuadreInter" ExportFileName="CuadreIntercompanies_.xls" Text="Exportar a Excel" IncludeTimeStamp="true" EnableHyperLinks="false" />
                    <asp:GridView ID="gvCapturaCuadreInter" runat="server" 
                                    AllowPaging="false" 
                                    AllowSorting="false" 
                                    AutoGenerateColumns="false"
                                    Width="650px"
                                    HeaderStyle-BackColor="#9de7d7">
                        <Columns>
                            <asp:BoundField HeaderText="Empresa" DataField="descripcion" HeaderStyle-Font-Bold="true" />
                            <asp:TemplateField HeaderText="Afil. x Cob CP" HeaderStyle-Font-Bold="true" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <div><asp:Label ID="lblImporte01" runat="server" Text='<%# Format(Eval("monto1"), "#,###,##0")%>' ></asp:Label></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Afil. x Cob LP" HeaderStyle-Font-Bold="true" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <div><asp:Label ID="lblImporte02" runat="server" Text='<%# Format(Eval("monto2"), "#,###,##0")%>'></asp:Label></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Afil. x Pag CP" HeaderStyle-Font-Bold="true" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <div><asp:Label ID="lblImporte03" runat="server" Text='<%# Format(Eval("monto3"), "#,###,##0")%>'></asp:Label></div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Afil. x Pag LP" HeaderStyle-Font-Bold="true" ItemStyle-Width="100px" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <div><asp:Label ID="lblImporte04" runat="server" Text='<%# Format(Eval("monto4"), "#,###,##0")%>'></asp:Label></div>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>



                    <br /><br />
                    <span style="font-size:13px; font-weight:bold;">
                        <asp:Label ID="lblTituloInterRef" runat="server" Text="Comparativo de lo reportado por las otras empresas"></asp:Label>
                    </span>
                    <br />
                    <asp:ExportToExcel runat="server" ID="ExportToExcel2" GridViewID="gvCapturaCuadreInterRef" ExportFileName="CuadreIntercompaniesDiferencias_.xls" Text="Exportar a Excel" IncludeTimeStamp="true" EnableHyperLinks="false" />
                    <asp:GridView ID="gvCapturaCuadreInterRef" runat="server" 
                                    AllowPaging="false" 
                                    AllowSorting="false" 
                                    AutoGenerateColumns="false"
                                    Width="650px"
                                    HeaderStyle-BackColor="#9de7d7">
                        <Columns>
                            <asp:BoundField HeaderText="Empresa" DataField="empresa" HeaderStyle-Font-Bold="true" />
                            <asp:TemplateField HeaderText="Afil. x Cob CP" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblImporte01" runat="server" Text='<%# Format(Eval("monto1"), "#,###,##0")%>' ></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dif" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblImporteDif01" runat="server" Text='<%# IIf(Eval("monto_dif1") <> 0, Format(Eval("monto_dif1"), "#,###,##0"), "")%>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="" ItemStyle-BackColor="LightGray"><ItemTemplate><div>&nbsp;</div></ItemTemplate></asp:TemplateField>
                            <asp:TemplateField HeaderText="Afil. x Cob LP" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblImporte02" runat="server" Text='<%# Format(Eval("monto2"), "#,###,##0")%>' ></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dif" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblImporteDif02" runat="server" Text='<%# IIf(Eval("monto_dif2") <> 0, Format(Eval("monto_dif2"), "#,###,##0"), "")%>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="" ItemStyle-BackColor="LightGray"><ItemTemplate><div>&nbsp;</div></ItemTemplate></asp:TemplateField>
                            <asp:TemplateField HeaderText="Afil. x Pag CP" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblImporte03" runat="server" Text='<%# Format(Eval("monto3"), "#,###,##0")%>' ></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dif" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblImporteDif03" runat="server" Text='<%# IIf(Eval("monto_dif3") <> 0, Format(Eval("monto_dif3"), "#,###,##0"), "")%>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="" ItemStyle-BackColor="LightGray"><ItemTemplate><div>&nbsp;</div></ItemTemplate></asp:TemplateField>
                            <asp:TemplateField HeaderText="Afil. x Pag LP" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblImporte04" runat="server" Text='<%# Format(Eval("monto4"), "#,###,##0")%>' ></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dif" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right">
                                <ItemTemplate>
                                    <div>
                                        <asp:Label ID="lblImporteDif04" runat="server" Text='<%# IIf(Eval("monto_dif4") <> 0, Format(Eval("monto_dif4"), "#,###,##0"), "")%>'></asp:Label>
                                    </div>
                                </ItemTemplate>
                            </asp:TemplateField>

                        </Columns>
                    </asp:GridView>
        </div>



        <div id="divReporteSum" runat="server" visible="false">
                    <asp:ExportToExcel runat="server" ID="ExportToExcel3" GridViewID="gvSumarizado" ExportFileName="CuadreIntercompanies_.xls" Text="Exportar a Excel" IncludeTimeStamp="true" EnableHyperLinks="false" />
                    <asp:GridView ID="gvSumarizado" runat="server" 
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
                            <asp:BoundField HeaderText="Suma" DataField="suma" DataFormatString="{0:#,###,##0}" HeaderStyle-Font-Bold="true" ItemStyle-HorizontalAlign="Right" />

                        </Columns>
                    </asp:GridView>
        </div>




            
        </div>
    </form>
</body>
<script type="text/javascript">
    //window.print();
</script>
</html>

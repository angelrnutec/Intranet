<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="ConsultaReciboNomina.aspx.vb" Inherits="Intranet.ConsultaReciboNomina" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script src="/scripts/jquery-1.7.1.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

  <link href="styles/jquery-ui.css" rel="stylesheet" />  
  <script src="Scripts/jquery-ui.js"></script>    
  <link rel="stylesheet" type="text/css" href="/styles/styles.css" />

    <style type="text/css">
        .tblRecibo td {
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

        a:hover
        {
            text-decoration: underline;
        }
        .auto-style1
        {
            height: 14px;
        }
    </style>
    <script type="text/javascript">
        function MuestraLoading() {
            document.getElementById('loadImg').style.display = 'none';
        }
    </script>

    <table cellpadding="0" cellspacing="0" border="0" width="100%">
        <tr>
            <td><span style="font-size:15px; font-weight:bold;">Consulta de Recibo de Nomina</span><hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td><br /></td>
        </tr>
        <tr>
            <td>

                <div id="divConsultaQuincena" runat="server">
                    <asp:DropDownList ID="ddlQuincena" runat="server" Width="300px" AutoPostBack="true"></asp:DropDownList>
                    <b><br /><asp:Label ID="msgBloqueo" runat="server"></asp:Label></b>
                    <br />
                    <table>
                        <tr>
                            <td><asp:Button ID="btnAcepto" runat="server" Text="ACEPTO" Visible="false" /></td>
                            <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td><asp:Button ID="btnNoAcepto" runat="server" Text="NO ACEPTO" Visible="false" /></td>
                        </tr>
                        <tr>
                            <td colspan="3">
                                <i>Recibí de conformidad la cantidad anotada en este recibo por los conceptos en él especificados con lo cual me han sido pagados todos los salarios y prestaciones legales y contractuales que pudiera tener derecho.</i>
                            </td>
                        </tr>
                    </table>
                </div>

                <div id="divNuevoPassword" runat="server" visible="false">
                    <asp:Panel ID="pnlPassword" runat="server" DefaultButton="btnContinuar">
                        <table>
                            <tr>
                                <td align="left" colspan="3"><b>Ingrese su nueva contrase&ntilde;a.</b> <br /><i>Esta contrase&ntilde;a es para uso exclusivo de la consulta de recibos de nomina, y debe ser distinta a la utilizada para accesar a la intranet.</i></td>
                            </tr>
                            <tr>
                                <td align="right">Contrase&ntilde;a:</td>
                                <td>&nbsp;&nbsp;&nbsp;</td>
                                <td align="left"><asp:TextBox ID="txtPassword" TextMode="Password" runat="server" Width="180px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td align="right">Confirmar contrase&ntilde;a:</td>
                                <td>&nbsp;&nbsp;&nbsp;</td>
                                <td align="left"><asp:TextBox ID="txtPassword2" TextMode="Password" runat="server" Width="180px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td colspan="3" align="center">
                                    <br />
                                    <asp:Button ID="btnContinuar" runat="server" Text="Guardar Contrase&ntilde;a" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>


                <div id="divLoginNomina" runat="server" visible="false">
                    <asp:Panel ID="pnlLogin" runat="server" DefaultButton="btnLogin">
                        <table>
                            <tr>
                                <td align="left" colspan="3"><b>Ingrese su contrase&ntilde;a.</b> <br />
                                    <i>Ingrese su contrase&ntilde;a para acceso a recibos de nomina. Si desea generar una nueva contrase&ntilde;a de <b><asp:LinkButton ID="lnkGeneraPasswordNomina" runat="server" style="text-decoration:underline;" Text="click aqui"></asp:LinkButton></b></i></td>
                            </tr>
                            <tr>
                                <td align="right">Contrase&ntilde;a para consulta de nomina:</td>
                                <td>&nbsp;&nbsp;&nbsp;</td>
                                <td align="left"><asp:TextBox ID="txtPass" TextMode="Password" runat="server" Width="180px"></asp:TextBox></td>
                            </tr>
                            <tr>
                                <td colspan="3" align="center">
                                    <br />
                                    <asp:Button ID="btnLogin" runat="server" Text="Continuar" />
                                </td>
                            </tr>
                        </table>
                    </asp:Panel>
                </div>

            </td>
            <td>
                <%--<asp:Button ID="btnRegresar" runat="server" CssClass="botones" Text="Regresar" />--%>
            </td>
        </tr>
        <tr id="trRecibo" runat="server">
            <td colspan="2">
                <br />
                <style>
                    #loadImg{position:absolute;z-index:999;}
                    #loadImg div{display:table-cell;width:700px;height:200px;text-align:center;vertical-align:middle;}
                </style>
                <div id="loadImg"><div><img src="/images/loading.gif" /></div></div>
                <iframe id="iFrmRecibo" runat="server" frameborder="0" style="width:700px;height:600px"></iframe>
            </td>
        </tr>
    </table>    
</asp:Content>

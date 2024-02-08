<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_Wide.Master" CodeBehind="ConceptoGastoVer.aspx.vb" Inherits="Intranet.ConceptoGastoVer" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        function isNumberKey(evt) {
            var charCode = (evt.which) ? evt.which : event.keyCode
            if (charCode != 46 && charCode != 45 && charCode > 31
              && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <table cellpadding="0" cellspacing="0" border="0" width="800px">
        <tr>
            <td colspan="4"><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Información del Concepto de Gasto")%></span><hr style="margin:0; padding:0;" /></td>
        </tr>
        <tr>
            <td colspan="4"><br /></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Clave")%>:</td>
            <td colspan="3"><asp:TextBox ID="txtClave" runat="server" Width="160px" MaxLength="3"></asp:TextBox></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Descripción")%>:</td>
            <td colspan="3"><asp:TextBox ID="txtDescripcion" runat="server" Width="160px" MaxLength="256"></asp:TextBox></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Descripción ingles")%>:</td>
            <td colspan="3"><asp:TextBox ID="txtDescripcionEn" runat="server" Width="160px" MaxLength="256"></asp:TextBox></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Tipo")%>:</td>
            <td colspan="3">
                <asp:DropDownList ID="ddlTipo" runat="server" Width="160px">
                    <asp:ListItem Value="T" Text="Todos"></asp:ListItem>
                    <asp:ListItem Value="G" Text="Gastos de Viaje"></asp:ListItem>
                    <asp:ListItem Value="R" Text="Reposición"></asp:ListItem>
                </asp:DropDownList>
            </td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Limite Diario")%>:</td>
            <td colspan="3"><asp:TextBox ID="txtLimiteDiario" runat="server" Width="160px" MaxLength="8" onkeypress="return isNumberKey(event);" Text="0.00"></asp:TextBox>&nbsp;<i>0=<%=TranslateLocale.text("Sin Limite")%></i></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("¿No Deducible?")%>:</td>
            <td colspan="3">
                <asp:CheckBox ID="chkNoDeducible" runat="server" />&nbsp;<i>No permite aplicar I.V.A.</i>
            </td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("¿Permite I.V.A. variable?")%>:</td>
            <td colspan="3">
                 <asp:CheckBox ID="chkIvaEditable" runat="server" />&nbsp;<i><%=TranslateLocale.text("Permite ingresar un monto de I.V.A.")%></i>
            </td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("¿Permite Propina?")%>:</td>
            <td colspan="3">
                <asp:CheckBox ID="chkPermitePropina" runat="server" />&nbsp;<i>Permite desglose de propina</i>
            </td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("¿Es gasto de viaje?")%>:</td>
            <td colspan="3">
                <asp:CheckBox ID="chkEsGastoViaje" runat="server" />&nbsp;
            </td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("¿Es gasto directivo?")%>:</td>
            <td colspan="3">
                <asp:CheckBox ID="chkEsGastoDirectivo" runat="server" />&nbsp;
            </td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("¿Considerar como gasto de viaje Cova?")%>:</td>
            <td colspan="3">
                <asp:CheckBox ID="chkEsGastoCova" runat="server" />&nbsp;
            </td>
        </tr>
        <tr>
            <td colspan="4"><br /></td>
        </tr>
        <tr>
            <td colspan="4"><b><%=TranslateLocale.text("Cuentas contables")%></b></td>
        </tr>
        <tr>
            <td colspan="4"><br /></td>
        </tr>
        <tr>
            <td colspan="4">NUTEC BICKLEY</td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Clave")%>:</td>
            <td><asp:TextBox ID="txtClaveNB" runat="server" Width="80px" MaxLength="32"></asp:TextBox></td>            
            <td><%=TranslateLocale.text("Descripción")%>:</td>
            <td><asp:TextBox ID="txtDescripcionNB" runat="server" Width="160px" MaxLength="256"></asp:TextBox>
                &nbsp;&nbsp;&nbsp;<%=TranslateLocale.text("Desc. Reportes")%>&nbsp;
                <asp:TextBox ID="txtDescripcionNBReportes" runat="server" Width="160px" MaxLength="256"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td colspan="4"><br /></td>
        </tr>
        <tr>
            <td colspan="4">NUTEC FIBRATEC</td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Clave")%>:</td>
            <td><asp:TextBox ID="txtClaveNF" runat="server" Width="80px" MaxLength="32"></asp:TextBox></td>            
            <td><%=TranslateLocale.text("Descripción")%>:</td>
            <td><asp:TextBox ID="txtDescripcionNF" runat="server" Width="160px" MaxLength="256"></asp:TextBox></td>
        </tr>
        <tr>
            <td colspan="4"><br /></td>
        </tr>
        <tr>
            <td colspan="4">NUTEC CORPORATIVO</td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Clave")%>:</td>
            <td><asp:TextBox ID="txtClaveNS" runat="server" Width="80px" MaxLength="32"></asp:TextBox></td>            
            <td><%=TranslateLocale.text("Descripción")%>:</td>
            <td><asp:TextBox ID="txtDescripcionNS" runat="server" Width="160px" MaxLength="256"></asp:TextBox></td>
        </tr>
        <tr>
            <td colspan="4"><br /></td>
        </tr>
        <tr>
            <td colspan="4">NUTEC USA</td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Clave")%>:</td>
            <td><asp:TextBox ID="txtClaveNU" runat="server" Width="80px" MaxLength="32"></asp:TextBox></td>            
            <td><%=TranslateLocale.text("Descripción")%>:</td>
            <td><asp:TextBox ID="txtDescripcionNU" runat="server" Width="160px" MaxLength="256"></asp:TextBox></td>
        </tr>
        <tr>
            <td colspan="4"><br /></td>
        </tr>
        <tr>
            <td colspan="4">
                <br />
                <asp:Button ID="btnRegresar" runat="server" CssClass="botones" Text="Regresar" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnGuardar" runat="server" CssClass="botones" Text="Guardar" />
                &nbsp;&nbsp;&nbsp;
                <asp:Button ID="btnEliminar" runat="server" CssClass="botones" Text="Eliminar" Visible="false" OnClientClick="return confirm('Seguro que desea eliminar este registro?');" />
            </td>
        </tr>
    </table>
    <asp:TextBox ID="txtIdConceptoGasto" runat="server" style="display:none;"></asp:TextBox>
</asp:Content>

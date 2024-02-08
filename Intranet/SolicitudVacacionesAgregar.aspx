<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="SolicitudVacacionesAgregar.aspx.vb" Inherits="Intranet.SolicitudVacacionesAgregar" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        .tblSolicitud th {
            font-weight:bold;
        }
    </style>

    <script type="text/javascript">

        function DiasAsueto(dias, fecha_ini, fecha_fin){
            <%=DiasAsueto()%>
            var restar=0.0;
            
            for (i=0;i<myDates.length;i++)
            {
                if(fecha_ini <= myDates[i] && fecha_fin >= myDates[i]){
                    restar=restar+1;
                    if(myDatesMedio[i]=='True'){
                        restar=restar - 0.5;
                    }
                }
            }

            if(dias>=restar){
                DiasSaldo((dias-restar));
                document.getElementById('<%=diasViaje.ClientID%>').innerHTML = (dias-restar);
                //TODO: Se comentariza a partir del 21 de Septiembre
                //document.getElementById('<%=diasViajeProporcional.ClientID%>').innerHTML = (parseFloat((dias-restar)) * 0.2).toFixed(1);
                document.getElementById('<%=diasViajeProporcional.ClientID%>').innerHTML = 0;
            }else
            {
                DiasSaldo(dias);
            }
        }

        function DiasSaldo(dias) {
            var dias_disponibles = <%=DiasDisponibles()%>;
            document.getElementById('<%=diasSaldo.ClientID%>').innerHTML = (parseFloat(dias_disponibles)-parseFloat(dias)).toFixed(1);
        }

        <%
        If Me.txtIdSolicitud.Text = "0" Then
        %>            
        //Ejecutar al iniciar
        setTimeout(DateSelected,500);
        <%          
        End If
        %>

        function DateSelected(sender, eventArgs) {
            <%=DiasAsueto()%>

            var startDate = $find('<%=dtFechaIni.ClientID%>');
            var endDate = $find('<%=dtFechaFin.ClientID%>');
            var chkMedioDia = document.getElementById('<%=chkMedioDia.ClientID%>');

            if ((startDate.get_selectedDate() != null) && (endDate.get_selectedDate() != null)) {
                // INICIO DE OCULTAR ASUETO SI YA ES MEDIO DIA
                document.getElementById('mediosDiasActivo').style.display='';
                var fecha_ini = String(startDate.get_selectedDate());
                var fecha_fin = String(endDate.get_selectedDate());
                for (i=0;i<myDates.length;i++)
                {
                    if(fecha_ini == myDates[i] && fecha_fin == myDates[i]){
                        if(myDatesMedio[i]=='True'){
                            document.getElementById('<%=chkMedioDia.ClientID%>').checked=false;
                            document.getElementById('mediosDiasActivo').style.display='none';
                        }
                    }
                }
                // FIN DE OCULTAR ASUETO SI YA ES MEDIO DIA




                var diffDays =calcBusinessDays(startDate.get_selectedDate(),endDate.get_selectedDate());
                if (diffDays < 0) {
                    document.getElementById('<%=diasViaje.ClientID%>').innerHTML = "0";
                    document.getElementById('<%=diasViajeProporcional.ClientID%>').innerHTML = "0";
                    DiasSaldo(0);
                } else {
                    var dias = parseFloat(diffDays);
                    if (chkMedioDia.checked) { dias = dias - 0.5; }
                    document.getElementById('<%=diasViaje.ClientID%>').innerHTML = dias;
                    //TODO: Se comentariza a partir del 21 de Septiembre
                    //document.getElementById('<%=diasViajeProporcional.ClientID%>').innerHTML = (parseFloat(dias) * 0.2).toFixed(1);
                    document.getElementById('<%=diasViajeProporcional.ClientID%>').innerHTML = 0;

                    DiasAsueto(dias, startDate.get_selectedDate(), endDate.get_selectedDate());
                }

            }
            else {
                document.getElementById('<%=diasViaje.ClientID%>').innerHTML = "0";
                document.getElementById('<%=diasViajeProporcional.ClientID%>').innerHTML = "0";
                DiasSaldo(0);
            }
        }

        function calcBusinessDays(dDate1, dDate2) { // input given as Date objects
            var iWeeks, iDateDiff, iAdjust = 0;
            if (dDate2 < dDate1) return -1; // error code if dates transposed
            var iWeekday1 = dDate1.getDay(); // day of week
            var iWeekday2 = dDate2.getDay();
            iWeekday1 = (iWeekday1 == 0) ? 7 : iWeekday1; // change Sunday from 0 to 7
            iWeekday2 = (iWeekday2 == 0) ? 7 : iWeekday2;
            if ((iWeekday1 > 5) && (iWeekday2 > 5)) iAdjust = 1; // adjustment if both days on weekend
            iWeekday1 = (iWeekday1 > 5) ? 5 : iWeekday1; // only count weekdays
            iWeekday2 = (iWeekday2 > 5) ? 5 : iWeekday2;

            // calculate differnece in weeks (1000mS * 60sec * 60min * 24hrs * 7 days = 604800000)
            iWeeks = Math.floor((dDate2.getTime() - dDate1.getTime()) / 604800000)

            if (iWeekday1 <= iWeekday2) {
                iDateDiff = (iWeeks * 5) + (iWeekday2 - iWeekday1)
            } else {
                iDateDiff = ((iWeeks + 1) * 5) - (iWeekday1 - iWeekday2)
            }

            iDateDiff -= iAdjust // take into account both days on weekend

            return (iDateDiff + 1); // add 1 because dates are inclusive
        }


    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <telerik:RadScriptManager ID="RadScriptManager1" runat="server"></telerik:RadScriptManager>

    <table cellpadding="0" cellspacing="0" border="0" width="650px">
        <tr>
            <td colspan="5"><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Solicitud de Vacaciones")%></span><hr style="margin:0; padding:0;" /></td>
        </tr>
    </table>

    <br />
    <table>
        <tr>
            <td colspan="5"><b><asp:Label ID="lblFolio" runat="server"></asp:Label></b></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Fecha de Solicitud")%>:</td>
            <td><asp:Label ID="lblFechaSolicitud" runat="server"></asp:Label></td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Empresa")%>:</td>
            <td><asp:DropDownList ID="ddlEmpresa" runat="server" Width="200px" AutoPostBack="true"></asp:DropDownList></td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Solicitante")%>:</td>
            <td><asp:DropDownList ID="ddlSolicitante" runat="server" Width="200px" AutoPostBack="true" ></asp:DropDownList></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Nomina")%>:</td>
            <td><asp:DropDownList ID="ddlNomina" runat="server" Width="200px"></asp:DropDownList></td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Autoriza Jefe")%>:</td>
            <td><asp:DropDownList ID="ddlAutorizaJefe" runat="server" Width="200px"></asp:DropDownList></td>
        </tr>
        <tr id="trDiasDisponibles" runat="server" visible="false">
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td></td>
            <td></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Fecha Ini")%>:</td>
            <td colspan="4">
                <telerik:RadDatePicker ID="dtFechaIni" runat="server" Width="100px" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy"><ClientEvents OnDateSelected="DateSelected" /></telerik:RadDatePicker>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <%=TranslateLocale.text("Fecha Fin")%>:&nbsp;<telerik:RadDatePicker ID="dtFechaFin" runat="server" Width="100px" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy"><ClientEvents OnDateSelected="DateSelected" /></telerik:RadDatePicker>
                &nbsp;&nbsp;&nbsp;&nbsp;
                <span id="mediosDiasActivo">
                    <asp:CheckBox ID="chkMedioDia" runat="server" Text="¿Medio Día?" onclick="DateSelected();" />
                </span>
            </td>
        </tr>
        <tr valign="top">
            <td><%=TranslateLocale.text("Comentarios")%>:</td>
            <td colspan="3">
                <asp:TextBox ID="txtComentarios" runat="server" TextMode="MultiLine" Width="278px" Height="71px"></asp:TextBox>
            </td>
            <td colspan="1" style="padding-left:10px">
                <table>
                    <tr id="trDisponibles" runat="server">
                        <td><%=TranslateLocale.text("Dias Disponibles")%>:</td>
                        <td><asp:Label ID="lblDiasDisponibles" runat="server" Text="0"></asp:Label></td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Dias Solicitados")%>:</td>
                        <td><div id="diasViaje" style="display:inline;" runat="server">0</div></td>
                    </tr>
                    <tr>
                        <td><%=TranslateLocale.text("Proporcional de Dias Solicitados")%>:</td>
                        <td><div id="diasViajeProporcional" style="display:inline;" runat="server">0</div></td>
                    </tr>
                    <tr id="trSaldo" runat="server">
                        <td><%=TranslateLocale.text("Saldo")%>:</td>
                        <td><div id="diasSaldo" style="display:inline;" runat="server">0</div></td>
                    </tr>
                </table>

            </td>
        </tr>
        <tr>
            <td colspan="5"><asp:Label ID="lblEstatus" runat="server"></asp:Label></td>
        </tr>
    </table>


    <br /><br />
    <asp:Button ID="btnRegresar" runat="server" CssClass="botones" Text="Regresar" />
    &nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnGuardar" runat="server" Text="Enviar Solicitud" CssClass="botones" UseSubmitBehavior="false"/>
    &nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnCancelarSolicitud" runat="server" Text="Cancelar la Solicitud" CssClass="botones" Visible="false" UseSubmitBehavior="false"/>
    &nbsp;&nbsp;&nbsp;


    <br /><br />


     <asp:TextBox ID="txtIdSolicitud" runat="server" Text="0" style="display:none;"></asp:TextBox>
    <asp:TextBox ID="txtIdEstatus" runat="server" Visible="false"></asp:TextBox>
</asp:Content>

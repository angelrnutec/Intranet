<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="SolicitudPermisosAgregar.aspx.vb" Inherits="Intranet.SolicitudPermisosAgregar" %>

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
                document.getElementById('<%=diasViaje.ClientID%>').innerHTML = (dias-restar);
            }
        }

        <%
        If Me.txtIdSolicitud.Text = "0" Then
        %>            
        //Ejecutar al iniciar
        setTimeout(DateSelected, 500);
        setTimeout(DiasViajados, 500);
        <%          
        End If
        %>

        function ValidaMaxDias() {
            var max_dias = parseFloat(document.getElementById('<%=txtMaxDias.ClientID%>').value);
            var dias = parseFloat(document.getElementById('<%=diasViaje.ClientID%>').innerHTML);
            if (dias > max_dias) {
                alert('<%=Translatelocale.text("Esta solicitud permite maximo")%> ' + max_dias + ' <%=TranslateLocale.text("dias.")%>');
                return false;
            }
            return true;
        }

        function DateSelected(sender, eventArgs) {
            var startDate = $find('<%=dtFechaIni.ClientID%>');
            var endDate = $find('<%=dtFechaFin.ClientID%>');
            var chkMedioDia = document.getElementById('<%=chkMedioDia.ClientID%>');

            if ((startDate.get_selectedDate() != null) && (endDate.get_selectedDate() != null)) {
                var diffDays = calcBusinessDays(startDate.get_selectedDate(), endDate.get_selectedDate());
                if (diffDays < 0) {
                    document.getElementById('<%=diasViaje.ClientID%>').innerHTML = "0";
                } else {
                    var dias = parseFloat(diffDays);
                    if (chkMedioDia.checked) { dias = dias - 0.5; }
                    document.getElementById('<%=diasViaje.ClientID%>').innerHTML = dias;
                    DiasAsueto(dias, startDate.get_selectedDate(), endDate.get_selectedDate());
                }
            }
            else {
                document.getElementById('<%=diasViaje.ClientID%>').innerHTML = "0";
            }
        }

        function DiasViajados(sender, eventArgs) {
            var startDate = $find('<%=dtFechaViajeProlongadoIni.ClientID%>');
            var endDate = $find('<%=dtFechaViajeProlongadoFin.ClientID%>');

            if (startDate != null) {
                if ((startDate.get_selectedDate() != null) && (endDate.get_selectedDate() != null)) {
                    var timeDiffMS = endDate.get_selectedDate().getTime() - startDate.get_selectedDate().getTime();
                    var diffDays = Math.floor(timeDiffMS / 1000 / 60 / 60 / 24);

                    document.getElementById('divDiasViajados').innerHTML = "<br />&nbsp;<%=TranslateLocale.text("Dias Viajados")%>: " + diffDays;
                }
                else {
                    document.getElementById('divDiasViajados').innerHTML = "";
                }
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
            <td colspan="5"><span style="font-size:15px; font-weight:bold;"><%=TranslateLocale.text("Solicitud de Permiso")%></span><hr style="margin:0; padding:0;" /></td>
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
            <td><%=TranslateLocale.text("Nominas")%>:</td>
            <td><asp:DropDownList ID="ddlNomina" runat="server" Width="200px"></asp:DropDownList></td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Autoriza Jefe")%>:</td>
            <td><asp:DropDownList ID="ddlAutorizaJefe" runat="server" Width="200px"></asp:DropDownList></td>
        </tr>
        <tr>
            <td><%=TranslateLocale.text("Concepto")%>:</td>
            <td><asp:DropDownList ID="ddlTipoPermiso" AutoPostBack="true" runat="server" Width="200px"></asp:DropDownList>
                <div id="divFechasViajeProlongado" runat="server" visible="false">
                    <%=TranslateLocale.text("Fechas del Viaje Prolongado")%>:<br />
                    <%=TranslateLocale.text("Del")%> 
                    <telerik:RadDatePicker ID="dtFechaViajeProlongadoIni" runat="server" Width="90px" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy"><ClientEvents OnDateSelected="DiasViajados" /></telerik:RadDatePicker>
                        &nbsp;&nbsp;al&nbsp;
                    <telerik:RadDatePicker ID="dtFechaViajeProlongadoFin" runat="server" Width="90px" DateInput-DateFormat="dd/MM/yyyy" DateInput-DisplayDateFormat="dd/MM/yyyy"><ClientEvents OnDateSelected="DiasViajados" /></telerik:RadDatePicker>
                    <span id="divDiasViajados"></span>
                </div>
            </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
<%--            <td><%=TranslateLocale.text("Director de Area")%>:</td>
            <td><asp:DropDownList ID="ddlDirectorArea" runat="server" Width="200px"></asp:DropDownList></td>--%>
        </tr>
        <tr id="trGerente" runat="server">
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td><%=TranslateLocale.text("Gerente")%>:</td>
            <td><asp:DropDownList ID="ddlGerente" runat="server" Width="200px"></asp:DropDownList></td>
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
                <asp:CheckBox ID="chkMedioDia" runat="server" Text="¿Medio Día?" onclick="DateSelected();" />
                &nbsp;&nbsp;&nbsp;&nbsp;

                <%=TranslateLocale.text("Dias Solicitados")%>:
                <div id="diasViaje" style="display:inline;" runat="server">0</div>
            </td>
        </tr>
        <tr valign="top">
            <td><%=TranslateLocale.text("Comentarios")%>:</td>
            <td colspan="3">
                <asp:TextBox ID="txtComentarios" runat="server" TextMode="MultiLine" Width="278px" Height="71px"></asp:TextBox>
            </td>
            <td colspan="1" style="padding-left:10px">
                <table>
                    <tr>
                    </tr>
                </table><br />
                <asp:RadioButton ID="rbConGoce" runat="server" Text="Con goce de sueldo" Checked="true" GroupName="GoceDeSueldo" /><br />
                <asp:RadioButton ID="rbSinGoce" runat="server" Text="Sin goce de sueldo" GroupName="GoceDeSueldo" />
            </td>
        </tr>
        <tr>
            <td colspan="5"><asp:Label ID="lblEstatus" runat="server"></asp:Label></td>
        </tr>
    </table>

    <asp:TextBox ID="txtMaxDias" runat="server" style="display:none" Text="0"></asp:TextBox>

    <br /><br />
    <asp:Button ID="btnRegresar" runat="server" CssClass="botones" Text="Regresar" />
    &nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnGuardar" runat="server" Text="Enviar Solicitud" CssClass="botones" OnClientClick="return ValidaMaxDias();" />
    &nbsp;&nbsp;&nbsp;
    <asp:Button ID="btnCancelarSolicitud" runat="server" Text="Cancelar la Solicitud" CssClass="botones" Visible="false"/>
    &nbsp;&nbsp;&nbsp;


    <br /><br />


     <asp:TextBox ID="txtIdSolicitud" runat="server" Text="0" style="display:none;"></asp:TextBox>
    <asp:TextBox ID="txtIdEstatus" runat="server" Visible="false"></asp:TextBox>
</asp:Content>

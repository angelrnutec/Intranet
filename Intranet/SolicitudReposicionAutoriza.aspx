<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="SolicitudReposicionAutoriza.aspx.vb" Inherits="Intranet.SolicitudReposicionAutoriza" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Nutec Intranet</title>
    <style type="text/css">
        body {
            font-family: Arial, Verdana;
            font-size:12px;
        }
        a {
            color:#0094ff;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <div align="center">
    
        <div id="divNormal" runat="server">
            <div id="divTexto" runat="server"></div>
            <br />
            <br />
            <a href="javascript:window.close();">Cerrar</a>
        </div>

        <div id="divRechazo" runat="server" visible="false">
            Para guardar el rechazo de esta solicitud es obligatorio ingresar el motivo del rechazo:<br />
            <asp:TextBox ID="txtMotivoRechazo" runat="server" TextMode="MultiLine"></asp:TextBox>
            <br /><asp:Label ID="lblMensaje" runat="server" ForeColor="Red"></asp:Label>
            <br />
            <asp:Button ID="btnGuardarRechazo" runat="server" Text="Guardar Rechazo" />
        </div>

    </div>
    </form>
</body>
</html>

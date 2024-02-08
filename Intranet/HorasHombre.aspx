<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP_SM.Master" CodeBehind="HorasHombre.aspx.vb" Inherits="Intranet.HorasHombre" %>
<%@ Register TagPrefix="telerik" Namespace="Telerik.Web.UI" Assembly="Telerik.Web.UI" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        html, body    {
  height: 100%;
}
    </style>
    <script type="text/javascript">
        setTimeout(function () {
            document.getElementById('aspnetForm').style.height = (window.innerHeight - 111) + 'px';
        }, 500);
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <table id="tblIframe" style="height:100%;width:100%;border-collapse:collapse">
        <tr>
            <td class="content">
                <iframe id="iFramex" runat="server" width="100%" height="100%" style="border:0;"></iframe>
            </td>
        </tr>
    </table>

</asp:Content>

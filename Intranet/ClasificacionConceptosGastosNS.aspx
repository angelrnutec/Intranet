<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="ClasificacionConceptosGastosNS.aspx.vb" Inherits="Intranet.ClasificacionConceptosGastosNS" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
  
    <asp:Panel ID="pnlBusqueda" runat="server">
        <table cellpadding="0" cellspacing="0" border="0" width="700px">
            <tr>
                <td colspan="3"><span style="font-size:15px; font-weight:bold;">Clasificacion de Conceptos de Gastos</span><hr style="margin:0; padding:0;" /></td>
            </tr>
            <tr id="trOpciones" runat="server">
                <td>
                    <asp:RadioButton ID="rbNoClasificado" runat="server" Text="No Clasificado" Checked="true" GroupName="Tipo" /><br />
                    <div valign="middle">
                        <asp:RadioButton ID="rbClasificado" runat="server" Text="Clasificado" GroupName="Tipo" /> 
                        &nbsp;&nbsp;&nbsp;&nbsp;
                        <asp:DropDownList ID="ddlClasificacionCosto" runat="server" Width="250px"></asp:DropDownList>  
                    </div>         
                </td>
                <td colspan="2" align="right">
                    <asp:Button ID="btnConsultar" runat="server" Text="Consultar" CssClass="botones" />
                    &nbsp;&nbsp;
                    <asp:Button ID="btnGuardar" runat="server" Text="Guardar" CssClass="botones" />
                </td>
            </tr>
        </table>
    </asp:Panel>
    <br />
    <asp:GridView ID="gvResultados" runat="server" CssClass="grid" Width="630px"  
         EmptyDataText="No se encontraron resultados para la busqueda realizada" AutoGenerateColumns="False" DataKeyNames="id_clasificacion_costo, id_detalle, denominacion_sap"
         AllowSorting="false" AllowPaging="false">
         <HeaderStyle CssClass="grid_header" />
         <AlternatingRowStyle CssClass="grid_alternating" />
          <Columns>
              <asp:BoundField HeaderText="Denominacion SAP" SortExpression="denominacion_sap" DataField="denominacion_sap" />
              <asp:TemplateField HeaderText="Clasificacion Intranet" SortExpression="Clasificacion Intranet">
                  <ItemTemplate>                      
                      <asp:DropDownList ID="ddlClasificacion" runat="server" Width="250px"></asp:DropDownList>                        
                  </ItemTemplate>
              </asp:TemplateField>
          </Columns>
    </asp:GridView>
    <br />      
</asp:Content>

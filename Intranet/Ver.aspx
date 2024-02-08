<%@ Page Language="vb" AutoEventWireup="false" MasterPageFile="~/DefaultMP.Master" CodeBehind="Ver.aspx.vb" Inherits="Intranet.Ver" %>

<%@ Import Namespace="Intranet.LocalizationIntranet" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div style="width:720px">
        <table width="100%">
            <tr>
                <td>
                    <div style="font-size:25px; font-weight:bold;"><asp:Label Id="lblTitulo" runat="server"></asp:Label></div>
                    <div style="font-size:10px; font-weight:normal;font-style:italic;"><asp:Label Id="lblFechaPublicacion" runat="server"></asp:Label></div>
                    <div id="divDatosAviso" runat="server" visible="false">
                        <div style="font-size:18px; font-weight:bold;"><%=TranslateLocale.text("Categoria")%>: <asp:Label Id="lblCategoria" runat="server"></asp:Label></div>
                        <div style="font-size:18px; font-weight:bold;"><%=TranslateLocale.text("Vendedor")%>: <asp:Label Id="lblVendedor" runat="server"></asp:Label></div>
                        <div style="font-size:18px; font-weight:bold;"><%=TranslateLocale.text("Datos de contacto")%>: <asp:Label Id="lblTelefono" runat="server"></asp:Label></div>
                        <div style="font-size:18px; font-weight:bold;"><%=TranslateLocale.text("Empresa")%>: <asp:Label Id="lblEmpresa" runat="server"></asp:Label></div>
                    </div>
                </td>
                <td align="right">
                    <asp:Button ID="btnRegresar" runat="server" Text="Regresar" CssClass="botones" OnClientClick="history.back(1);return false;" />
                </td>
            </tr>
        </table>
        <hr style="margin:0; padding:0;" />
        <asp:PlaceHolder ID="phContenido" runat="server"></asp:PlaceHolder>
        <br /><br />
        <div id="divFotos" runat="server">
        </div>

        <br /><br /><br /><br />
        <div id="cuadro_comentarios" runat="server" style="width:500px">
            <b><%=TranslateLocale.text("Comentarios")%>...</b><br />
            <hr style="margin:0; padding:0;" />
            <div id="divComentarios">
            </div>
            <br />
            <hr style="margin:0; padding:0;" />
            <b><%=TranslateLocale.text("Agregar un comentario")%>:</b><br />
            <textarea id="txtComentario" rows="4" cols="60" onKeyUp="maximo_largo();"></textarea><br />
            <input type="button" id="btnComentario" class="botones" value="Guardar comentario"  onclick="EnviaComentario();"/>
        </div>
    </div>
    <br />


    <script type="text/javascript">
    <%
        If txtPermiteComentarios.Text = "1" Then
        %>

        function EnviaComentario() {
            var texto;
            texto = document.getElementById('txtComentario').value;
            if (texto.length > 512) {
                texto = texto.substring(0, 512);
            }
            if (texto.length <= 0) {
                alert('Ingrese el comentario que desea agregar');
                return;
            }

            $.ajax({
                type: "POST",
                url: "/Servicios/ComentariosPublicacion.aspx",
                data: {id : <%=Session("idEmpleado")%>, comentario : texto, t : 1, idt : document.getElementById('<%=txtIDN.ClientID%>').value },
                success: function (datos) {
                    //RecuperaComentarios(document.getElementById('<%=txtIDN.ClientID%>').value, false);
                },
                error: function (error) {
                    //alert(error);
                }
            });
            document.getElementById('txtComentario').value='';
        }


        function maximo_largo() {
            var texto;
            texto = document.getElementById('txtComentario').value;
            if (texto.length > 512) {
                document.getElementById('txtComentario').value = texto.substring(0, 512);
            }
        }

        var ultimo_id = 0;
        function RecuperaComentarios(ida, repetir) {
            $.ajax({
                type: "POST",
                url: "/Servicios/ComentariosPublicacion.aspx",
                data: {id : ida, t : 2, idu : ultimo_id },
                success: function (datos) {
                    MuestraComentarios(datos);
                    if(repetir){ setTimeout(function(){RecuperaComentarios(ida, true)},4000); }
                },
                error: function (error) {
                    //alert(error);
                    if(repetir){ setTimeout(function(){RecuperaComentarios(ida, true)},4000); }
                }
            });
            return true;
        }

        function MuestraComentarios(comentarios)
        {
            if(comentarios.length>0){
                var mensajes = comentarios.split('||');
                for(i=0;i<mensajes.length-1;i++){
                    if(mensajes[i].length>0){
                        var mensaje = mensajes[i].split('|');
                        //console.log(mensaje[0] + '-->' + mensaje[1] + '-->' + mensaje[2] + '-->' + mensaje[3]);
                        ultimo_id = mensaje[0];

                        var v_id_comentario = mensaje[0];
                        var v_id_empleado = mensaje[1];
                        var v_comentario = mensaje[2];
                        var v_fecha_registro = mensaje[3];
                        var v_empleado = mensaje[4];
                        var v_fotografia = mensaje[5];

                        var mensajeFormato = '';
                        mensajeFormato = '<div class="ComentarioCaja"><div class="ComentarioFoto" style="background:url(\'/uploads/fotos/mini/' + v_fotografia + '\');background-size:50px 50px;"></div><div class="ComentarioInfo"><span class="ComentarioNombre">' + v_empleado + '</span><span class="ComentarioFecha">' + v_fecha_registro + '</span><br><span class="ComentarioTexto">' + v_comentario + '</span></div></div><div style="clear:both;"></div><hr class="ComentarioSeparador" />';

                        document.getElementById('divComentarios').innerHTML += mensajeFormato;
                    }
                }
            }
        }


        $(document).ready(function () {
            RecuperaComentarios(document.getElementById('<%=txtIDN.ClientID%>').value, true);
        });
        <%
    End If
    
    If Me.txtTipoPublicacion.Text = "7" Then
%>

    function RecuperaDocumentosAviso(id) {
        $.ajax({
            type: "GET",
            url: "/Servicios/DocumentosPublicacion.aspx?id=" + id + "&t=aviso&l=link",
            success: function (datos) {
                document.getElementById('<%=divFotos.ClientID%>').innerHTML = datos;
            },
            error: function (error) {
                alert(error);
            }
        });
        return true;
    }

        $(document).ready(function () {
            RecuperaDocumentosAviso(<%=Me.txtIDN.Text%>);
        });

<%        
    End If
        %>

        </script>  
    
    <asp:TextBox ID="txtID" runat="server" Text="" style="display:none;"></asp:TextBox>
    <asp:TextBox ID="txtIDN" runat="server" Text="" style="display:none;"></asp:TextBox>
    <asp:TextBox ID="txtPermiteComentarios" runat="server" Text="" style="display:none;"></asp:TextBox>
    <asp:TextBox ID="txtTipoPublicacion" runat="server" Text="" style="display:none;"></asp:TextBox>
</asp:Content>

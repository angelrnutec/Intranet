Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class Ver
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            If Not Request.QueryString("p") Is Nothing Then
                Me.txtID.Text = Request.QueryString("p")
                Call CargaPublicacion()
            Else
                Response.Redirect("/NoAutorizado.aspx")
            End If
        End If

        Me.btnRegresar.Text = TranslateLocale.text(Me.btnRegresar.Text)

    End Sub

    Private Sub CargaPublicacion()
        Dim publicacion As New Publicacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dt As DataTable = publicacion.RecuperaPorIdTexto(Me.txtID.Text, Session("idEmpleado"))

        If dt.Rows.Count > 0 Then
            Dim dr As DataRow = dt.Rows(0)
            Me.txtIDN.Text = dr("id_publicacion")
            Me.lblTitulo.Text = dr(TranslateLocale.text("titulo"))
            Me.lblFechaPublicacion.Text = TranslateLocale.text("Publicación") & ": " & Convert.ToDateTime(dr("fecha_registro")).ToString("dd/MM/yyyy")
            Me.phContenido.Controls.Add(New LiteralControl(dr(TranslateLocale.text("descripcion"))))

            Me.txtTipoPublicacion.Text = dr("id_tipo_publicacion")
            If dr("id_tipo_publicacion") = 7 Then
                Me.lblCategoria.Text = TranslateLocale.text(dr("categoria"))
                Me.lblVendedor.Text = dr("vendedor")
                Me.lblTelefono.Text = dr("telefono")
                Me.lblEmpresa.Text = dr("empresa")
                Me.divDatosAviso.Visible = True
            End If

            Me.txtPermiteComentarios.Text = IIf(dr("permite_comentarios"), "1", "0")

            If Me.txtPermiteComentarios.Text = "0" Then
                Me.cuadro_comentarios.Visible = False
            End If
        Else
            Response.Redirect("/NoAutorizado.aspx")
        End If

    End Sub

End Class
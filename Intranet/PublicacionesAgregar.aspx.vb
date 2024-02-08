Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class PublicacionesAgregar
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            If Request.QueryString("id") Is Nothing Then
                Me.CargaCombos()

                Me.tblInicial.Visible = True
                Me.tblCaptura.Visible = False
                Me.tblCapturaLink.Visible = False
                Me.tblCapturaNormal.Visible = False
                Me.tblCapturaBanner.Visible = False
                Me.tblCapturaAviso.Visible = False
                Me.tblBotones.Visible = False
                Me.trTitulo.Visible = False

            Else
                Me.txtID.Text = Request.QueryString("id")

                Me.CargaCombos()
                Me.dtFechaEvento.SelectedDate = Date.Now()

                Me.tblInicial.Visible = False
                Me.tblCaptura.Visible = True
                Me.tblBotones.Visible = True
                Me.trTitulo.Visible = True

                Me.CargaDatos()
            End If

            Me.lblLinkGenerado.Text = TranslateLocale.text(Me.lblLinkGenerado.Text)
            Me.lblTipoPublicacion.Text = TranslateLocale.text(Me.lblTipoPublicacion.Text)
            Me.lblTituloPublicacion.Text = TranslateLocale.text(Me.lblTituloPublicacion.Text)
            Me.lblTituloPublicacionEn.Text = TranslateLocale.text(Me.lblTituloPublicacionEn.Text)

            Me.btnCancelar.Text = TranslateLocale.text(Me.btnCancelar.Text)
            Me.btnContinuar.Text = TranslateLocale.text(Me.btnContinuar.Text)
            Me.btnGuardar.Text = TranslateLocale.text(Me.btnGuardar.Text)

            Me.rbActivo.Text = TranslateLocale.text(rbActivo.Text)
            Me.rbBannerTargetBlank.Text = TranslateLocale.text(rbBannerTargetBlank.Text)
            Me.rbBannerTargetSelf.Text = TranslateLocale.text(rbBannerTargetSelf.Text)
            Me.rbBannerUbicaD.Text = TranslateLocale.text(rbBannerUbicaD.Text)
            Me.rbBannerUbicaI.Text = TranslateLocale.text(rbBannerUbicaI.Text)
            Me.rbBorrado.Text = TranslateLocale.text(rbBorrado.Text)
            Me.rbNoVisible.Text = TranslateLocale.text(rbNoVisible.Text)
            Me.rbTargetBlank.Text = TranslateLocale.text(rbTargetBlank.Text)
            Me.rbTargetSelf.Text = TranslateLocale.text(rbTargetSelf.Text)
            Me.rbVisible.Text = TranslateLocale.text(rbVisible.Text)

            Me.chkPermiteComentarios.Text = TranslateLocale.text(Me.chkPermiteComentarios.Text)

        End If
    End Sub

    Private Sub CargaCombos()
        Try
            Dim publicacion As New Publicacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Me.ddlTipoPublicacion.Items.Clear()
            Me.ddlTipoPublicacion.Items.AddRange(Funciones.DatatableToList(publicacion.RecuperaTipoPublicacionCombo("S"), "nombre", "id_tipo_publicacion"))



            Dim grupo As New Grupo(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Me.ddlGrupo.Items.Clear()
            Me.ddlGrupo.Items.AddRange(Funciones.DatatableToList(grupo.RecuperaGruposParaPublicacion("S", Session("idEmpleado")), "nombre", "id_grupo"))


            Dim combo As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Me.ddlVendedor.Items.Clear()
            Me.ddlVendedor.Items.AddRange(Funciones.DatatableToList(combo.RecuperaEmpleados(0, TranslateLocale.text("--Seleccione--")), "nombre", "id_empleado"))

            Me.ddlCategoria.Items.Clear()
            Me.ddlCategoria.Items.AddRange(Funciones.DatatableToList(combo.RecuperCategoriaAviso(TranslateLocale.text("--Seleccione--")), TranslateLocale.text("descripcion"), "id_categoria"))

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub CargaDatos()
        Dim publicacion As New Publicacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dt As DataTable = publicacion.RecuperaPorId(Me.txtID.Text)

        If dt.Rows.Count > 0 Then
            Dim dr As DataRow = dt.Rows(0)

            Me.lblGrupo.Text = TranslateLocale.text(dr("grupo"))
            Me.lblTipoPublicacion.Text = dr("tipo_publicacion")
            Me.txtTipoPublicacion.Text = dr("id_tipo_publicacion")
            Me.txtIdGrupo.Text = dr("id_grupo")
            Me.txtTitulo.Text = dr("titulo")
            Me.txtTituloEn.Text = dr("titulo_en")
            Me.rbVisible.Checked = IIf(dr("estatus") = "I", False, True)
            Me.rbNoVisible.Checked = IIf(dr("estatus") = "I", True, False)
            Me.rbBorrado.Checked = IIf(dr("borrada") = True, True, False)
            Me.rbActivo.Checked = IIf(dr("borrada") = True, False, True)

            Me.ddlVendedor.SelectedValue = dr("id_vendedor")
            Me.ddlCategoria.SelectedValue = dr("id_categoria")
            Me.txtTelefono.Text = dr("telefono")
            Me.txtDescripcion.Text = dr("descripcion")
            Me.txtDescripcionEn.Text = dr("descripcion_en")

            If Me.txtTipoPublicacion.Text = 4 Then
                Me.tblCapturaLink.Visible = True
                Me.tblCapturaNormal.Visible = False
                Me.tblCapturaBanner.Visible = False
                Me.tblCapturaAviso.Visible = False
                Me.chkPermiteComentarios.Visible = False
                Me.lblLinkGenerado.Visible = False
            ElseIf Me.txtTipoPublicacion.Text = 5 Then
                Me.tblCapturaLink.Visible = False
                Me.tblCapturaNormal.Visible = False
                Me.tblCapturaBanner.Visible = True
                Me.tblCapturaAviso.Visible = False
                Me.chkPermiteComentarios.Visible = False
                Me.lblLinkGenerado.Visible = False
            ElseIf Me.txtTipoPublicacion.Text = 7 Then
                Me.tblCapturaLink.Visible = False
                Me.tblCapturaNormal.Visible = False
                Me.tblCapturaBanner.Visible = False
                Me.tblCapturaAviso.Visible = True
                Me.lblLinkGenerado.Visible = True
            Else
                Me.tblCapturaLink.Visible = False
                Me.tblCapturaNormal.Visible = True
                Me.tblCapturaBanner.Visible = False
                Me.tblCapturaAviso.Visible = False
                Me.lblLinkGenerado.Visible = True
            End If

            If Me.txtTipoPublicacion.Text = 2 Then
                Me.trDatosAdicionales.Visible = True
            Else
                Me.trDatosAdicionales.Visible = False
            End If

            If dr("estatus") <> "N" Then
                Me.chkPermiteComentarios.Checked = Convert.ToBoolean(dr("permite_comentarios"))
                Me.lblLinkGenerado.Text = TranslateLocale.text("Enlace") & ":&nbsp;&nbsp;http://" & Request.Url.Host & "/Ver.aspx?p=" & dr("id_texto")

                Me.txtDescripcionCorta.Text = dr("descripcion_corta")
                Me.radTexto.Content = dr("descripcion")
                Me.txtDescripcionCortaEn.Text = dr("descripcion_corta_en")
                Me.radTextoEn.Content = dr("descripcion_en")

                Me.dtFechaEvento.SelectedDate = dr("fecha_evento")

                Me.txtBanner.Text = dr("liga_banner")
                Me.txtBannerLink.Text = dr("liga_url")


                Me.rbTargetSelf.Checked = IIf(dr("liga_target") = "_self", True, False)
                Me.rbTargetBlank.Checked = IIf(dr("liga_target") = "_self", False, True)

                Me.rbBannerUbicaD.Checked = IIf(dr("ubicacion") = "D", True, False)
                Me.rbBannerUbicaI.Checked = IIf(dr("ubicacion") = "D", False, True)


                Me.dtFechaEvento.SelectedDate = dr("fecha_evento")
                Me.txtLinkTexto.Text = dr("liga_desc")
                Me.txtLinkUrl.Text = dr("liga_url")

            End If

            If Me.txtTitulo.Text = "" And Me.txtTituloEn.Text = "" Then
                Me.btnCancelar.Text = TranslateLocale.text("Cancelar")
            Else
                Me.btnCancelar.Text = TranslateLocale.text("Salir")
            End If

        End If

    End Sub

    Private Sub btnContinuar_Click(sender As Object, e As EventArgs) Handles btnContinuar.Click
        Try
            Dim msg As String = ""
            If Me.ddlTipoPublicacion.SelectedValue = 0 Then msg &= " - Tipo de publicación\n"
            If Me.ddlGrupo.SelectedValue = 0 Then msg &= " - " & TranslateLocale.text("Grupo") & "\n"

            If msg.Length > 0 Then
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("Favor de proporcionar los siguientes datos") & ":\n" & msg & "');</script>", False)
                Exit Sub
            End If


            Dim publicacion As New Publicacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim id As Integer = publicacion.AgregaPublicacion(Me.ddlGrupo.SelectedValue, Me.ddlTipoPublicacion.SelectedValue, Session("idEmpleado"))

            Response.Redirect("/PublicacionesAgregar.aspx?id=" & id)

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Dim publicacion As New Publicacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            If Me.txtTipoPublicacion.Text = 4 Then
                Me.ValidaDatosLink()

                publicacion.Guarda(Me.txtID.Text, Me.txtIdGrupo.Text, Session("idEmpleado"), IIf(Me.rbVisible.Checked, "V", "I"), _
                                   Me.txtTipoPublicacion.Text, Me.txtTitulo.Text, "", "", Me.txtTituloEn.Text, "", "", "", False, IIf(Me.rbActivo.Checked, False, True), _
                                   DateTime.Now, Me.txtLinkUrl.Text, Me.txtLinkTexto.Text, DateTime.Now,
                                   IIf(Me.rbTargetSelf.Checked, "_self", "_blank"), "", "", 0, 0, "")

            ElseIf Me.txtTipoPublicacion.Text = 5 Then
                Me.ValidaDatosBanner()

                publicacion.Guarda(Me.txtID.Text, Me.txtIdGrupo.Text, Session("idEmpleado"), IIf(Me.rbVisible.Checked, "V", "I"), _
                                   Me.txtTipoPublicacion.Text, Me.txtTitulo.Text, "", "", Me.txtTituloEn.Text, "", "", "", False, IIf(Me.rbActivo.Checked, False, True), _
                                   DateTime.Now, Me.txtBannerLink.Text, "", DateTime.Now, IIf(Me.rbBannerTargetSelf.Checked, "_self", "_blank"), _
                                   Me.txtBanner.Text, IIf(Me.rbBannerUbicaD.Checked, "D", "I"), 0, 0, "")

            ElseIf Me.txtTipoPublicacion.Text = 7 Then
                Me.ValidaDatosAviso()

                publicacion.Guarda(Me.txtID.Text, Me.txtIdGrupo.Text, Session("idEmpleado"), IIf(Me.rbVisible.Checked, "V", "I"), _
                                   Me.txtTipoPublicacion.Text, Me.txtTitulo.Text, "", Me.txtDescripcion.Text, Me.txtTituloEn.Text, "", Me.txtDescripcionEn.Text, "", _
                                   Me.chkPermiteComentarios.Checked, IIf(Me.rbActivo.Checked, False, True), DateTime.Now, "", "", _
                                   Me.dtFechaEvento.SelectedDate, "", "", "", Me.ddlVendedor.SelectedValue, Me.ddlCategoria.SelectedValue,
                                   Me.txtTelefono.Text)

            Else
                Me.ValidaDatosPublicacion()

                publicacion.Guarda(Me.txtID.Text, Me.txtIdGrupo.Text, Session("idEmpleado"), IIf(Me.rbVisible.Checked, "V", "I"), _
                                   Me.txtTipoPublicacion.Text, Me.txtTitulo.Text, Me.txtDescripcionCorta.Text, Me.radTexto.Content, Me.txtTituloEn.Text, Me.txtDescripcionCortaEn.Text, Me.radTextoEn.Content, "", _
                                   Me.chkPermiteComentarios.Checked, IIf(Me.rbActivo.Checked, False, True), DateTime.Now, "", "", _
                                   Me.dtFechaEvento.SelectedDate, "", "", "", 0, 0, "")

            End If
            Me.btnCancelar.Text = "Salir"

            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Publicación guardada correctamente');</script>", False)

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    Private Sub ValidaDatosBanner()
        Dim msg As String = ""
        If Me.txtTitulo.Text.Trim.Length <= 0 Or Me.txtTituloEn.Text.Trim.Length <= 0 Then msg &= " - " & TranslateLocale.text("Titulo") & " / " & TranslateLocale.text("Titulo (Ingles)") & "\n"
        If Me.txtBannerLink.Text.Trim.Length = 0 Then msg &= " - " & TranslateLocale.text("URL para el banner") & "\n"
        If Me.txtBanner.Text.Trim.Length = 0 Then msg &= " - " & TranslateLocale.text("Imagen del banner") & "\n"

        If msg.Length > 0 Then
            Throw New Exception(TranslateLocale.text("Favor de proporcionar esta información") & ":\n" & msg)
        End If
    End Sub

    Private Sub ValidaDatosPublicacion()
        Dim msg As String = ""
        If Me.txtTitulo.Text.Trim.Length <= 0 Or Me.txtTituloEn.Text.Trim.Length <= 0 Then msg &= " - " & TranslateLocale.text("Titulo") & " / " & TranslateLocale.text("Titulo (Ingles)") & "\n"
        If Me.txtDescripcionCorta.Text.Trim.Length = 0 Or Me.txtDescripcionCortaEn.Text.Trim.Length = 0 Then msg &= " - " & TranslateLocale.text("Descripción corta") & " / " & TranslateLocale.text("Descripción corta (Ingles)") & "\n"
        If Me.radTexto.Content.Length = 0 Or Me.radTextoEn.Content.Length = 0 Then msg &= " - " & TranslateLocale.text("Detalles de la publicación") & " / " & TranslateLocale.text("Detalles de la publicación (Ingles)") & "\n"

        If msg.Length > 0 Then
            Throw New Exception(TranslateLocale.text("Favor de proporcionar esta información") & ":\n" & msg)
        End If
    End Sub

    Private Sub ValidaDatosAviso()
        Dim msg As String = ""
        If Me.txtTitulo.Text.Trim.Length <= 0 Or Me.txtTituloEn.Text.Trim.Length <= 0 Then msg &= " - " & TranslateLocale.text("Titulo") & " / " & TranslateLocale.text("Titulo (Ingles)") & "\n"
        If Me.txtDescripcion.Text.Trim.Length = 0 Or Me.txtDescripcionEn.Text.Trim.Length = 0 Then msg &= " - " & TranslateLocale.text("Descripción") & " / " & TranslateLocale.text("Descripción (Ingles)") & "\n"
        If Me.ddlVendedor.SelectedValue = 0 Then msg &= " - " & TranslateLocale.text("Vendedor") & "\n"
        If Me.ddlCategoria.SelectedValue = 0 Then msg &= " - " & TranslateLocale.text("Categoría") & "\n"

        If msg.Length > 0 Then
            Throw New Exception(TranslateLocale.text("Favor de proporcionar esta información") & ":\n" & msg)
        End If
    End Sub

    Private Sub ValidaDatosLink()
        Dim msg As String = ""
        If Me.txtTitulo.Text.Trim.Length <= 0 Or Me.txtTituloEn.Text.Trim.Length <= 0 Then msg &= " - " & TranslateLocale.text("Titulo") & " / " & TranslateLocale.text("Titulo (Ingles)") & "\n"
        If Me.txtLinkUrl.Text.Trim.Length <= 10 Then msg &= " - " & TranslateLocale.text("URL valido") & "\n"
        If Me.txtLinkTexto.Text.Trim.Length = 0 Then msg &= " - " & TranslateLocale.text("Texto") & "\n"

        If msg.Length > 0 Then
            Throw New Exception(TranslateLocale.text("Favor de proporcionar esta información") & ":\n" & msg)
        End If
    End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Response.Redirect("/PublicacionesBusqueda.aspx")
    End Sub
End Class
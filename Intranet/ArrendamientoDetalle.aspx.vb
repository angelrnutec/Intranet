Imports IntranetBL
Imports System.Web.Services
Imports Intranet.LocalizationIntranet

Public Class ArrendamientoDetalle
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If

        GeneraControlesRadioButtons()

        If Not Page.IsPostBack Then
            If Request.QueryString("id") Is Nothing Then
                Response.Redirect("/ErrorInesperado.aspx?Msg=Consulta invalida")
            End If

            Me.CargaCombos()
            Me.txtIdArrendamiento.Text = Request.QueryString("id")
            If Not Request.QueryString("idEmpresa") Is Nothing Then
                Me.ddlEmpresa.SelectedValue = Request.QueryString("idEmpresa")
                Me.ddlCategoriaArrendamiento.SelectedValue = Request.QueryString("idCategoria")
                Me.ddlEmpresa0.SelectedValue = Request.QueryString("idEmpresa")
                Me.ddlCategoriaArrendamiento0.SelectedValue = Request.QueryString("idCategoria")

                CargaCombos(Me.ddlEmpresa.SelectedValue)

                If Me.ddlCategoriaArrendamiento.SelectedValue = 1 Then
                    Me.tblEstatus0.Visible = True
                    Me.tblGeneral.Visible = False

                Else
                    Me.tblEstatus0.Visible = False
                    Me.tblGeneral.Visible = True
                End If

                Me.lblEstatus.Text = TranslateLocale.text("--Nuevo--")
                Me.lblEstatus0.Text = TranslateLocale.text("--Nuevo--")

                Me.lblUsuarioRegistro.Text = Session("nombreEmpleado")
                Me.lblUsuarioRegistro0.Text = Session("nombreEmpleado")

            End If
            Me.ddlEmpresa.Enabled = False
            Me.ddlCategoriaArrendamiento.Enabled = False


            Me.CargaDatos(Me.txtIdArrendamiento.Text)
        End If


        Me.btnEliminar.Text = TranslateLocale.text("Eliminar")
        'Me.btnGuardar.Text = TranslateLocale.text("Enviar a Autorizar")
        Me.btnRegresar.Text = TranslateLocale.text("Regresar")
        Me.btnAutorizar.Text = TranslateLocale.text(Me.btnAutorizar.Text)
        Me.btnRechazar.Text = TranslateLocale.text(Me.btnRechazar.Text)

        If Me.txtIdEstatus.Value = "4" Or (Me.ddlCategoriaArrendamiento.SelectedValue <> 1 And Me.txtIdArrendamiento.Text = "0") Then
            Me.btnGuardar.Text = TranslateLocale.text("Guardar")
        End If

    End Sub

    Private Sub GeneraControlesRadioButtons()
        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dtTipoAutos As DataTable = combos.RecuperaTipoAutos()
        For Each dr As DataRow In dtTipoAutos.Rows

            Dim myDiv As HtmlGenericControl = New HtmlGenericControl("div")
            myDiv.ID = "myDiv_" & dr("id_tipo_auto")

            Dim rbTipoAuto As New RadioButton
            rbTipoAuto.Text = dr("nombre")
            rbTipoAuto.ID = "rbTipoAuto_" & dr("id_tipo_auto")
            rbTipoAuto.GroupName = "rbTipoAuto"

            myDiv.Controls.Add(rbTipoAuto)

            Dim mySpan As HtmlGenericControl = New HtmlGenericControl("span")
            mySpan.ID = "mySpan_" & dr("id_tipo_auto")
            mySpan.Attributes.Add("style", "font-size: 13px;display: inline;")
            mySpan.InnerHtml = "<br />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & dr("descripcion")

            myDiv.Controls.Add(mySpan)

            phTipoAuto.Controls.Add(myDiv)
        Next

    End Sub

    Private Sub CargaCombos()
        Try
            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Me.ddlEmpresa.Items.Clear()
            Me.ddlEmpresa.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpresaArrendamiento(Session("idEmpleado")), "nombre", "id_empresa"))

            Me.ddlEmpresa0.Items.Clear()
            Me.ddlEmpresa0.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpresaArrendamiento(Session("idEmpleado")), "nombre", "id_empresa"))

            Me.ddlCategoriaArrendamiento.Items.Clear()
            Me.ddlCategoriaArrendamiento.Items.AddRange(Funciones.DatatableToList(combos.RecuperaCategoriaArrendamiento(Session("idEmpleado")), "descripcion", "id_categoria_arrendamiento"))

            Me.ddlCategoriaArrendamiento0.Items.Clear()
            Me.ddlCategoriaArrendamiento0.Items.AddRange(Funciones.DatatableToList(combos.RecuperaCategoriaArrendamiento(Session("idEmpleado")), "descripcion", "id_categoria_arrendamiento"))

            Me.ddlTipo.Items.Clear()
            Me.ddlTipo.Items.AddRange(Funciones.DatatableToList(combos.RecuperaTipoArrendamiento(), "descripcion", "id_tipo_arrendamiento"))

            Me.ddlPeriodicidad.Items.Clear()
            Me.ddlPeriodicidad.Items.AddRange(Funciones.DatatableToList(combos.RecuperaPeriodicidadArrendamiento(), "descripcion", "id_periodicidad_arrendamiento"))

            Me.ddlPeriodicidadSeguro.Items.Clear()
            Me.ddlPeriodicidadSeguro.Items.AddRange(Funciones.DatatableToList(combos.RecuperaPeriodicidadArrendamiento(), "descripcion", "id_periodicidad_arrendamiento"))

            Me.ddlDiaPago.Items.Clear()
            Me.ddlDiaPago.Items.Add(New ListItem(TranslateLocale.text("--Seleccione--"), 0))
            For i As Integer = 1 To 31
                Me.ddlDiaPago.Items.Add(New ListItem(i, i))
            Next

            Me.ddlMoneda.Items.Clear()
            Me.ddlMoneda.Items.AddRange(Funciones.DatatableToList(combos.RecuperaMonedas(), "descripcion", "clave"))

            Me.ddlArrendadora.Items.Clear()
            Me.ddlArrendadora.Items.AddRange(Funciones.DatatableToList(combos.RecuperaArrendadoras(), "descripcion", "id_arrendadora"))

            Me.ddlAseguradora.Items.Clear()
            Me.ddlAseguradora.Items.AddRange(Funciones.DatatableToList(combos.RecuperaAseguradoras(), "descripcion", "id_aseguradora"))



        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub

    Private Sub CargaCombos(id_empresa As Integer)

        Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ddlDepartamento.DataSource = empleado.RecuperaDepartamentoPorEmpresa(Me.ddlEmpresa.SelectedValue)
        Me.ddlDepartamento.DataValueField = "clave"
        Me.ddlDepartamento.DataTextField = "nombre"
        Me.ddlDepartamento.DataBind()

        CargaComboEmpleados()

        Me.ddlDepartamento0.DataSource = empleado.RecuperaDepartamentoPorEmpresa(Me.ddlEmpresa0.SelectedValue)
        Me.ddlDepartamento0.DataValueField = "clave"
        Me.ddlDepartamento0.DataTextField = "nombre"
        Me.ddlDepartamento0.DataBind()

        CargaComboEmpleados0()

    End Sub


    Private Sub CargaComboEmpleados()

        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ddlEmpleado.Items.Clear()
        Me.ddlEmpleado.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpleadosDepartamento(Me.ddlEmpresa.SelectedValue, Me.ddlDepartamento.SelectedValue, "--Seleccione--"), "nombre", "id_empleado"))
        Me.ddlEmpleado.SelectedValue = 0

    End Sub

    Private Sub CargaComboEmpleados0()

        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ddlEmpleado0.Items.Clear()
        Me.ddlEmpleado0.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpleadosDepartamento(Me.ddlEmpresa0.SelectedValue, Me.ddlDepartamento0.SelectedValue, "--Seleccione--"), "nombre", "id_empleado"))
        Me.ddlEmpleado0.SelectedValue = 0

    End Sub

    Private Sub CargaDatos(id As Integer)
        Try

            Me.tblDetalle1.Visible = False
            Me.tblDetalle2.Visible = False
            Me.trFlotilla.Visible = False

            If Me.ddlCategoriaArrendamiento.SelectedValue = 1 Then
                Me.tblDetalle1.Visible = True
                Me.trFlotilla.Visible = True
            ElseIf Me.ddlCategoriaArrendamiento.SelectedValue = 2 Or Me.ddlCategoriaArrendamiento.SelectedValue = 3 Then
                Me.tblDetalle2.Visible = True
            End If


            Dim id_usuario_registro As Integer = 0
            Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = arrendamiento.RecuperaArrendamiento(id)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                Dim autoriza_director_rh As String = IIf(IsDBNull(dr("autoriza_director_rh")), "", dr("autoriza_director_rh"))
                Dim autoriza_director_negocio As String = IIf(IsDBNull(dr("autoriza_director_negocio")), "", dr("autoriza_director_negocio"))
                Dim autoriza_director_finanzas As String = IIf(IsDBNull(dr("autoriza_director_finanzas")), "", dr("autoriza_director_finanzas"))
                Dim id_autoriza_director_rh As String = IIf(IsDBNull(dr("id_autoriza_director_rh")), "", dr("id_autoriza_director_rh"))
                Dim id_autoriza_director_negocio As String = IIf(IsDBNull(dr("id_autoriza_director_negocio")), "", dr("id_autoriza_director_negocio"))
                Dim id_autoriza_director_finanzas As String = IIf(IsDBNull(dr("id_autoriza_director_finanzas")), "", dr("id_autoriza_director_finanzas"))

                Me.txtIdDirRH.Value = IIf(IsDBNull(dr("id_autoriza_director_rh")), "0", dr("id_autoriza_director_rh"))
                Me.txtIdDirNegocio.Value = IIf(IsDBNull(dr("id_autoriza_director_negocio")), "0", dr("id_autoriza_director_negocio"))
                Me.txtIdDirFinanzas.Value = IIf(IsDBNull(dr("id_autoriza_director_finanzas")), "0", dr("id_autoriza_director_finanzas"))

                Dim fecha_autoriza_director_rh As String
                If IsDBNull(dr("fecha_autoriza_director_rh")) Then
                    fecha_autoriza_director_rh = ""
                Else
                    fecha_autoriza_director_rh = Convert.ToDateTime(dr("fecha_autoriza_director_rh")).ToString("dd/MM/yyyy HH:mm")
                End If

                Dim fecha_autoriza_director_negocio As String
                If IsDBNull(dr("fecha_autoriza_director_negocio")) Then
                    fecha_autoriza_director_negocio = ""
                Else
                    fecha_autoriza_director_negocio = Convert.ToDateTime(dr("fecha_autoriza_director_negocio")).ToString("dd/MM/yyyy HH:mm")
                End If

                Dim fecha_autoriza_director_finanzas As String
                If IsDBNull(dr("fecha_autoriza_director_finanzas")) Then
                    fecha_autoriza_director_finanzas = ""
                Else
                    fecha_autoriza_director_finanzas = Convert.ToDateTime(dr("fecha_autoriza_director_finanzas")).ToString("dd/MM/yyyy HH:mm")
                End If

                Me.lblAutorizaciones0.Text = LeyendaAutorizaciones(autoriza_director_rh, autoriza_director_negocio, autoriza_director_finanzas, dr("usuario_auth_rh"), dr("usuario_auth_negocios"), dr("usuario_auth_finanzas"), fecha_autoriza_director_rh, fecha_autoriza_director_negocio, fecha_autoriza_director_finanzas)
                Me.lblAutorizaciones.Text = LeyendaAutorizaciones(autoriza_director_rh, autoriza_director_negocio, autoriza_director_finanzas, dr("usuario_auth_rh"), dr("usuario_auth_negocios"), dr("usuario_auth_finanzas"), fecha_autoriza_director_rh, fecha_autoriza_director_negocio, fecha_autoriza_director_finanzas)


                Me.ddlEmpresa.SelectedValue = dr("id_empresa")
                Me.ddlCategoriaArrendamiento.SelectedValue = dr("id_categoria_arrendamiento")

                Me.ddlEmpresa0.SelectedValue = dr("id_empresa")
                Me.ddlCategoriaArrendamiento0.SelectedValue = dr("id_categoria_arrendamiento")
                id_usuario_registro = dr("id_usuario_registro")

                If Me.ddlCategoriaArrendamiento.SelectedValue = 1 Then
                    Me.tblDetalle1.Visible = True
                    Me.trFlotilla.Visible = True

                    If dr("id_estatus") = 1 Then
                        Me.tblEstatus0.Visible = True
                        Me.tblGeneral.Visible = False
                    Else
                        Me.tblEstatus0.Visible = False
                        Me.tblGeneral.Visible = True
                    End If

                ElseIf Me.ddlCategoriaArrendamiento.SelectedValue = 2 Or Me.ddlCategoriaArrendamiento.SelectedValue = 3 Then
                    Me.tblDetalle2.Visible = True

                    Me.tblEstatus0.Visible = False
                    Me.tblGeneral.Visible = True
                End If


                CargaCombos(Me.ddlEmpresa.SelectedValue)

                Me.lblEstatus.Text = dr("estatus")
                Me.lblEstatus0.Text = dr("estatus")
                Me.lblUsuarioRegistro.Text = dr("usuario_registro")
                Me.lblUsuarioRegistro0.Text = dr("usuario_registro")
                Me.txtIdEstatus.Value = dr("id_estatus")
                Me.txtFlotilla.Text = dr("flotilla")
                Me.lblFlotilla.Text = dr("flotilla")



                If dr("id_estatus") = 1 Then

                    Me.lblNumero0.Text = dr("numero")
                    Me.ddlDepartamento0.SelectedValue = dr("id_departamento")
                    CargaComboEmpleados0()
                    Me.ddlEmpleado0.SelectedValue = dr("id_empleado")

                    Me.txtComentariosAuto.Text = dr("comentarios_auto")
                    Me.txtPrecioGE.Value = Convert.ToDecimal(dr("precio_ge_auto"))


                    Dim i As Integer = dr("id_tipo_auto")
                    If Not phTipoAuto.FindControl("rbTipoAuto_" & i) Is Nothing Then
                        CType(phTipoAuto.FindControl("rbTipoAuto_" & i), RadioButton).Checked = True
                    End If



                Else
                    Me.ddlTipo.SelectedValue = dr("id_tipo_arrendamiento")
                    Me.txtFolio.Text = dr("folio")

                    Me.txtContratoMaestro.Text = dr("contrato_maestro")
                    Me.lblNumero.Text = dr("numero")
                    Me.txtAnexo.Text = dr("anexo")
                    Me.txtNumeroParcialidades.Text = dr("numero_parcialidades")
                    Me.txtComision.Value = Convert.ToDouble(dr("comision"))
                    Me.lblArrendamientoNeto.Text = Convert.ToDouble(dr("arrendamiento_neto")).ToString("#,###,##0.00")
                    Me.txtValorResidual.Text = Convert.ToDouble(dr("valor_residual")).ToString("#,###,##0.00")
                    Me.lblValorFuturo.Text = Convert.ToDouble((dr("valor_residual") - dr("deposito_garantia"))).ToString("#,###,##0.00")
                    Me.ddlDepartamento.SelectedValue = dr("id_departamento")
                    Me.ddlDepartamento0.SelectedValue = dr("id_departamento")
                    CargaComboEmpleados()
                    Me.ddlEmpleado.SelectedValue = dr("id_empleado")
                    Me.txtNumPoliza.Text = dr("num_poliza")
                    Me.ddlPeriodicidadSeguro.SelectedValue = dr("periodicidad_seguro")
                    Me.txtParcialidadSeguro.Value = Convert.ToDouble(dr("monto_parcialidad_seguro"))
                    Me.txtPlazoSeguroHidden.Value = dr("plazo_seguro")
                    Me.lblPlazoSeguro.Text = dr("plazo_seguro")

                    Me.txtIdArrendamiento.Text = dr("id_arrendamiento")
                    Me.txtFolio.Text = dr("folio")
                    Me.ddlEmpresa.SelectedValue = dr("id_empresa")
                    Me.ddlArrendadora.SelectedValue = dr("id_arrendadora")
                    Me.ddlTipo.SelectedValue = dr("id_tipo_arrendamiento")
                    Me.ddlCategoriaArrendamiento.SelectedValue = dr("id_categoria_arrendamiento")
                    'Me.txtDescripcion.Text = dr("descripcion")
                    Me.ddlPeriodicidad.SelectedValue = dr("id_periodicidad_arrendamiento")
                    Me.txtMontoTotal.Value = Convert.ToDouble(dr("importe_total"))
                    Me.ddlMoneda.SelectedValue = dr("id_moneda")
                    Me.txtMontoParcialidades.Value = Convert.ToDouble(dr("importe_parcialidades"))
                    If Not dr("fecha_inicio") Is DBNull.Value Then
                        Me.dtFechaInicio.SelectedDate = dr("fecha_inicio")
                    End If
                    If Not dr("fecha_fin") Is DBNull.Value Then
                        Me.dtFechaFin.SelectedDate = dr("fecha_fin")
                    End If
                    Me.ddlDiaPago.SelectedValue = dr("dia_pago")
                    Me.txtTasa.Value = Convert.ToDouble(dr("tasa"))
                    Me.txtValorRescate.Value = Convert.ToDouble(dr("valor_rescate"))
                    Me.txtDepositoGarantia.Value = Convert.ToDouble(dr("deposito_garantia"))
                    'Me.txtAseguradora.Text = dr("aseguradora")
                    Me.ddlAseguradora.SelectedValue = dr("id_aseguradora")
                    Me.txtSeguro.Value = Convert.ToDouble(dr("seguro"))
                    Me.txtTasaCalculadaMensual.Value = Convert.ToDouble(dr("tasa_calculada_mensual")).ToString("#,###,##0.00")
                    Me.lblTasaCalculadaMensual.Text = Convert.ToDouble(dr("tasa_calculada_mensual")).ToString("#,###,##0.0") & " %"
                    Me.lblTasaCalculadaAnual.Text = Convert.ToDouble(dr("tasa_calculada_mensual") * 12).ToString("#,###,##0.00") & " %"

                    If Not dr("fecha_inicio_seguro") Is DBNull.Value Then
                        Me.dtFechaInicioSeguro.SelectedDate = dr("fecha_inicio_seguro")
                    End If
                    If Not dr("fecha_fin_seguro") Is DBNull.Value Then
                        Me.dtFechaFinSeguro.SelectedDate = dr("fecha_fin_seguro")
                    End If

                    If Not dr("fecha_recepcion") Is DBNull.Value Then
                        Me.dtFechaRecepcion.SelectedDate = dr("fecha_recepcion")
                    End If
                    Me.txtRecibidoPor.Text = dr("recibido_por")



                    Me.txtMarca.Text = dr("marca")
                    Me.txtModelo.Text = dr("modelo")
                    Me.txtAnio.Text = dr("anio")
                    Me.txtNoSerie.Text = dr("no_serie")
                    Me.txtColor.Text = dr("color")
                    Me.txtNumFactura.Text = dr("num_factura")
                    Me.txtProveedor.Text = dr("proveedor")
                    Me.txtCantidadDetalle2.Value = Convert.ToDouble(dr("cantidad_d2"))
                    Me.txtMontoUnitarioDetalle2.Value = Convert.ToDouble(dr("monto_unitario_d2"))
                    Me.lblMontoTotalDetalle2.Text = Convert.ToDouble(dr("monto_total_d2")).ToString("#,###,##0.00")
                    Me.txtMontoTotalDetalle2.Text = dr("monto_total_d2")
                    Me.txtDescripcionDetalle2.Text = dr("descripcion_d2")


                    If Me.ddlCategoriaArrendamiento.SelectedValue = 1 Then 'Auto
                        Me.ddlDepartamento.Enabled = False
                        Me.ddlEmpleado.Enabled = False

                        Me.trAutosHeader1.Visible = True
                        Me.trAutosHeader2.Visible = True
                        Me.trAutosHeader3.Visible = True

                        Me.lblComentariosAuto.Text = dr("comentarios_auto")
                        Me.lblPrecioGE.Text = Convert.ToDecimal(dr("precio_ge_auto")).ToString("#,###,##0.00")
                        Me.lblTipoAuto1.Text = dr("tipo_auto_nombre") & "<br><span style='font-size:13px'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;" & dr("tipo_auto_descripcion") & "</span>"
                    End If

                End If


                ActivaBotones(id_usuario_registro, dr("id_estatus"), autoriza_director_rh, autoriza_director_negocio, autoriza_director_finanzas, id_autoriza_director_rh, id_autoriza_director_negocio, id_autoriza_director_finanzas)

                Me.tblArchivos.Visible = True
            Else
                Me.tblArchivos.Visible = False

                Dim configuracion As New Configuracion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Dim flotilla As String = configuracion.RecuperaConfiguracion("num-flotilla-autos", Me.ddlEmpresa.SelectedValue)
                Me.txtFlotilla.Text = flotilla
                Me.lblFlotilla.Text = flotilla

            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Function LeyendaAutorizaciones(autoriza_director_rh As String, autoriza_director_negocio As String, autoriza_director_finanzas As String, usuario_auth_rh As String, usuario_auth_negocios As String, usuario_auth_finanzas As String, fecha_autoriza_director_rh As String, fecha_autoriza_director_negocio As String, fecha_autoriza_director_finanzas As String) As String

        Dim strRespuesta As String = ""
        If usuario_auth_rh <> "" Then
            strRespuesta &= "<b>" & TranslateLocale.text("Aut. RH") & ":</b> " & usuario_auth_rh & " (" & IIf(autoriza_director_rh = "", TranslateLocale.text("Pendiente"), IIf(autoriza_director_rh = "1", TranslateLocale.text("Autorizado"), TranslateLocale.text("Rechazado"))) & IIf(fecha_autoriza_director_rh = "", "", " - " & fecha_autoriza_director_rh) & ")<br />"
        End If
        If usuario_auth_negocios <> "" Then
            strRespuesta &= "<b>" & TranslateLocale.text("Aut. Negocio") & ":</b> " & usuario_auth_negocios & " (" & IIf(autoriza_director_negocio = "", TranslateLocale.text("Pendiente"), IIf(autoriza_director_negocio = "1", TranslateLocale.text("Autorizado"), TranslateLocale.text("Rechazado"))) & IIf(fecha_autoriza_director_negocio = "", "", " - " & fecha_autoriza_director_negocio) & ")<br />"
        End If
        If usuario_auth_finanzas <> "" Then
            strRespuesta &= "<b>" & TranslateLocale.text("Aut. Finanzas") & ":</b> " & usuario_auth_finanzas & " (" & IIf(autoriza_director_finanzas = "", TranslateLocale.text("Pendiente"), IIf(autoriza_director_finanzas = "1", TranslateLocale.text("Autorizado"), TranslateLocale.text("Rechazado"))) & IIf(fecha_autoriza_director_finanzas = "", "", " - " & fecha_autoriza_director_finanzas) & ")<br />"
        End If

        If strRespuesta.Length > 0 Then
            strRespuesta = "<b>" & TranslateLocale.text("Autorizaciones") & "</b><br>" & strRespuesta
        End If

        Return strRespuesta
    End Function

    Private Sub ActivaBotones(id_usuario_registro As Integer, id_estatus As Integer, autoriza_director_rh As String, autoriza_director_negocio As String, autoriza_director_finanzas As String, id_autoriza_director_rh As String, id_autoriza_director_negocio As String, id_autoriza_director_finanzas As String)
        If Session("idEmpleado") = id_usuario_registro And id_estatus <> 4 Then
            Me.btnEliminar.Visible = True
        End If

        If autoriza_director_rh = "0" Or autoriza_director_negocio = "0" Or autoriza_director_finanzas = "0" Or id_estatus = "2" Then
            Me.btnGuardar.Visible = True
        Else
            Me.btnGuardar.Visible = False

            If id_estatus = 1 And autoriza_director_rh = "" And Session("idEmpleado") = id_autoriza_director_rh Then
                Me.btnAutorizar.Visible = True
                Me.btnRechazar.Visible = True
            ElseIf id_estatus = 1 And autoriza_director_negocio = "" And Session("idEmpleado") = id_autoriza_director_negocio And autoriza_director_rh = "1" Then
                Me.btnAutorizar.Visible = True
                Me.btnRechazar.Visible = True
            ElseIf id_estatus = 3 And autoriza_director_finanzas = "" And Session("idEmpleado") = id_autoriza_director_finanzas Then
                Me.btnAutorizar.Visible = True
                Me.btnRechazar.Visible = True
            End If

        End If

        If id_estatus = 4 Then

            Me.btnRegresar.Enabled = True
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>$( document ).ready(function() { $('#aspnetForm :input').attr('disabled', true); $('#" & Me.btnRegresar.ClientID & "').attr('disabled', false); });</script>", False)

        End If

    End Sub

    Private Sub btnRegresar_Click(sender As Object, e As EventArgs) Handles btnRegresar.Click
        Response.Redirect("ArrendamientoListado.aspx")
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try

            Dim enviaEmailAuth As Boolean = IIf(Me.txtIdArrendamiento.Text = "0", True, False)
            If Me.tblEstatus0.Visible = True Then

                Dim id_tipo_auto As Integer = 0
                For i As Integer = 1 To 10
                    If Not phTipoAuto.FindControl("rbTipoAuto_" & i) Is Nothing Then
                        If CType(phTipoAuto.FindControl("rbTipoAuto_" & i), RadioButton).Checked Then
                            id_tipo_auto = i
                        End If
                    End If
                Next

                Me.ValidaCapturaEstatus0()
                Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))


                Me.txtIdArrendamiento.Text = arrendamiento.GuardaArrendamientoEstatus0(Me.txtIdArrendamiento.Text,
                                                Me.ddlEmpresa0.SelectedValue,
                                                Me.ddlCategoriaArrendamiento0.SelectedValue,
                                                Session("idEmpleado"),
                                                Me.ddlDepartamento0.SelectedValue,
                                                Me.ddlEmpleado0.SelectedValue,
                                                Me.txtComentariosAuto.Text,
                                                id_tipo_auto,
                                                Me.txtPrecioGE.Value,
                                                Me.txtFlotilla.Text
                                            )
                'If enviaEmailAuth Then
                '    Funciones.EnviarEmailArrendamientoAuth(Me.txtIdArrendamiento.Text, -1, "Autorizante")
                'End If



            Else


                Me.ValidaCaptura()
                If Me.txtCantidadDetalle2.Value Is Nothing Then
                    Me.txtCantidadDetalle2.Value = 0
                End If
                If Me.txtMontoUnitarioDetalle2.Value Is Nothing Then
                    Me.txtMontoUnitarioDetalle2.Value = 0
                End If
                If Me.txtMontoTotalDetalle2.Text = "" Then
                    Me.txtMontoTotalDetalle2.Text = "0"
                End If

                Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Me.txtIdArrendamiento.Text = arrendamiento.GuardaArrendamiento(Me.txtIdArrendamiento.Text,
                                                                               Me.txtFolio.Text,
                                                Me.ddlEmpresa.SelectedValue,
                                                Me.ddlArrendadora.SelectedValue,
                                                Me.ddlTipo.SelectedValue,
                                                Me.ddlCategoriaArrendamiento.SelectedValue,
                                                "",
                                                Me.ddlPeriodicidad.SelectedValue,
                                                Me.txtMontoTotal.Value,
                                                Me.txtMontoParcialidades.Value,
                                                Me.ddlMoneda.SelectedValue,
                                                Me.dtFechaInicio.SelectedDate,
                                                Me.dtFechaFin.SelectedDate,
                                                Me.ddlDiaPago.SelectedValue,
                                                Me.txtTasa.Value,
                                                Me.txtValorRescate.Value,
                                                Me.txtDepositoGarantia.Value,
                                                Me.ddlAseguradora.SelectedValue,
                                                Me.txtSeguro.Value,
                                                Me.dtFechaInicioSeguro.SelectedDate,
                                                Me.dtFechaFinSeguro.SelectedDate,
                                                Session("idEmpleado"),
                                                Me.txtContratoMaestro.Text,
                                                Me.txtFlotilla.Text,
                                                Me.txtAnexo.Text,
                                                Me.txtNumeroParcialidades.Value,
                                                Me.txtComision.Value,
                                                Me.lblArrendamientoNeto.Text,
                                                Me.txtValorResidual.Text,
                                                Me.ddlDepartamento.SelectedValue,
                                                Me.ddlEmpleado.SelectedValue,
                                                Me.txtNumPoliza.Text,
                                                Me.ddlPeriodicidadSeguro.SelectedValue,
                                                Me.txtParcialidadSeguro.Text,
                                                Me.txtPlazoSeguroHidden.Value,
                                                Me.txtTasaCalculadaMensual.Value,
                                                Me.txtMarca.Text,
                                                Me.txtModelo.Text,
                                                Me.txtAnio.Text,
                                                Me.txtNoSerie.Text,
                                                Me.txtColor.Text,
                                                Me.txtNumFactura.Text,
                                                Me.txtProveedor.Text,
                                                Convert.ToInt32(Me.txtCantidadDetalle2.Value),
                                                Convert.ToDecimal(Me.txtMontoUnitarioDetalle2.Value),
                                                Convert.ToDecimal(Me.txtMontoTotalDetalle2.Text),
                                                Me.txtDescripcionDetalle2.Text,
                                                Me.dtFechaRecepcion.SelectedDate,
                                                Me.txtRecibidoPor.Text
                                    )

                'If Me.txtIdEstatus.Value = 2 Then
                '    Funciones.EnviarEmailArrendamientoAuth(Me.txtIdArrendamiento.Text, 2, "Autorizante")
                'End If


            End If

            Response.Redirect("/ArrendamientoDetalle.aspx?id=" & Me.txtIdArrendamiento.Text)



            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Datos guardados con exito');</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub ValidaCapturaEstatus0()
        Dim msg As String = ""


        If Me.ddlEmpresa0.SelectedValue = 0 Then
            msg += " - " & TranslateLocale.text("Empresa") & "\n"
        End If

        If Me.txtComentariosAuto.Text.Length = 0 Then
            msg += " - " & TranslateLocale.text("Comentarios") & "\n"
        End If

        If Me.ddlDepartamento0.SelectedValue = 0 Then
            msg += " - " & TranslateLocale.text("Departamento asignado") & "\n"
        End If
        If Me.ddlEmpleado0.SelectedValue = 0 Then
            msg += " - " & TranslateLocale.text("Asignado a") & "\n"
        End If

        Dim id_tipo_auto As Integer = 0
        For i As Integer = 1 To 10
            If Not phTipoAuto.FindControl("rbTipoAuto_" & i) Is Nothing Then
                If CType(phTipoAuto.FindControl("rbTipoAuto_" & i), RadioButton).Checked Then
                    id_tipo_auto = i
                End If
            End If
        Next

        If id_tipo_auto = 0 Then
            msg += " - " & TranslateLocale.text("Tipo de Auto") & "\n"
        End If


        If msg.Length > 0 Then
            Throw New Exception("Favor de capturar la siguiente información:\n" & msg)
        End If
    End Sub

    Private Sub ValidaCaptura()
        Dim msg As String = ""

        If Me.txtFolio.Text.Trim = "" Then
            msg += " - " & TranslateLocale.text("Folio") & "\n"
        End If

        If Me.ddlEmpresa.SelectedValue = 0 Then
            msg += " - " & TranslateLocale.text("Empresa") & "\n"
        End If

        If Me.ddlArrendadora.SelectedValue = 0 Then
            msg += " - " & TranslateLocale.text("Arrendadora") & "\n"
        End If

        If Me.ddlTipo.SelectedValue = 0 Then
            msg += " - " & TranslateLocale.text("Tipo") & "\n"
        End If

        If Me.ddlCategoriaArrendamiento.SelectedValue = 0 Then
            msg += " - " & TranslateLocale.text("Categoria") & "\n"
        End If

        'If Me.txtDescripcion.Text.Trim = "" Then
        '    msg += " - " & TranslateLocale.text("Descripción de los Bienes") & "\n"
        'End If

        If Me.ddlPeriodicidad.SelectedValue = 0 Then
            msg += " - " & TranslateLocale.text("Periodicidad del Arrendamiento") & "\n"
        End If

        If Me.txtMontoTotal.Value <= 0 Then
            msg += " - " & TranslateLocale.text("Valor/Costo del Bien (Sin IVA)") & "\n"
        End If

        If Me.ddlMoneda.SelectedValue = "" Then
            msg += " - " & TranslateLocale.text("Moneda") & "\n"
        End If

        If Me.txtMontoParcialidades.Value <= 0 Then
            msg += " - " & TranslateLocale.text("Monto de la Parcialidad (Sin IVA)") & "\n"
        End If


        If Not IsDate(Me.dtFechaInicio.SelectedDate) Then
            msg += " - " & TranslateLocale.text("Fecha Inicial") & "\n"
        End If
        If Not IsDate(Me.dtFechaFin.SelectedDate) Then
            msg += " - " & TranslateLocale.text("Fecha Final") & "\n"
        End If

        If Me.ddlDiaPago.SelectedValue = 0 Then
            msg += " - " & TranslateLocale.text("Dia de Pago") & "\n"
        End If


        If Me.ddlDepartamento.SelectedValue = 0 Then
            msg += " - " & TranslateLocale.text("Departamento asignado") & "\n"
        End If
        If Me.ddlEmpleado.SelectedValue = 0 Then
            msg += " - " & TranslateLocale.text("Asignado a") & "\n"
        End If

        If Me.txtNumPoliza.Text.Length > 0 And Me.ddlPeriodicidadSeguro.SelectedValue = 0 Then
            msg += " - " & TranslateLocale.text("Periodicidad del seguro") & "\n"
        End If

        If msg.Length > 0 Then
            Throw New Exception("Favor de capturar la siguiente información:\n" & msg)
        End If
    End Sub

    Private Sub btnEliminar_Click(sender As Object, e As EventArgs) Handles btnEliminar.Click
        Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        arrendamiento.ArrendamientoElimina(Me.txtIdArrendamiento.Text, Session("idEmpleado"))

        Response.Redirect("/ArrendamientoListado.aspx")
    End Sub

    Private Sub ddlDepartamento_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlDepartamento.SelectedIndexChanged
        CargaComboEmpleados()
    End Sub

    Private Sub ddlDepartamento0_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlDepartamento0.SelectedIndexChanged
        CargaComboEmpleados0()
    End Sub

    Private Sub btnAutorizar_Click(sender As Object, e As EventArgs) Handles btnAutorizar.Click
        Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        arrendamiento.GuardaAutorizacionArrendamiento(Me.txtIdArrendamiento.Text, True, "", Session("idEmpleado"))


        'If Me.txtIdEstatus.Value = 1 Then
        '    If Me.txtIdDirRH.Value = Session("idEmpleado") Then
        '        Funciones.EnviarEmailArrendamientoAuth(Me.txtIdArrendamiento.Text, 1, "Autorizante")
        '        Funciones.EnviarEmailArrendamientoAuth(Me.txtIdArrendamiento.Text, 1, "Solicitante")
        '    ElseIf Me.txtIdDirNegocio.Value = Session("idEmpleado") Then
        '        Funciones.EnviarEmailArrendamientoAuth(Me.txtIdArrendamiento.Text, 2, "Solicitante")
        '    End If
        'ElseIf Me.txtIdEstatus.Value = 3 Then
        '    Funciones.EnviarEmailArrendamientoAuth(Me.txtIdArrendamiento.Text, 3, "Solicitante")
        'End If



        Response.Redirect("/ArrendamientoDetalle.aspx?id=" & Me.txtIdArrendamiento.Text)
    End Sub















End Class
Imports IntranetBL
Imports Telerik.Web.UI
Imports Intranet.LocalizationIntranet

Public Class SolicitudGastosAgregar
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.CargaCombos()
            Me.dtFechaIni.SelectedDate = Now
            Me.dtFechaFin.SelectedDate = Now
            If Request.QueryString("id") Is Nothing Then
                Response.Redirect("/ErrorInesperado.aspx?Msg=Consulta invalida")
            End If

            Me.txtIdSolicitudGasto.Text = Request.QueryString("id")
            Me.lblFechaSolicitud.Text = Format(Now, "dd/MM/yyyy")
            Me.lnkImpr.Visible = False

            Me.CargaDatos(Me.txtIdSolicitudGasto.Text)
            Me.txtRetencion.Visible = False
            Me.txtRetencionResico.Visible = False
            Me.tdEtiquetaRetencion.Visible = False
            Me.tdRetencion.Visible = False

            Me.txtPropina.Visible = False
            Me.tdEtiquetaPropina.Visible = False
            Me.tdPropina.Visible = False

            Me.lnkImpr.Attributes.Add("href", "SolicitudGastosImprimir.aspx?id=" & Request.QueryString("id"))
            Call MuestraOcultaTipoContabilidad()
            Me.ddlTipoIVA.Attributes("onChange") = "CalculaTotal();"

            Me.lnkSolicitudReposicion.Text = TranslateLocale.text("De click aquí para abrir la solicitud de reposición en otra ventana.")

            Me.btnAgregar.Text = TranslateLocale.text("Agregar")
            Me.btnCancelarSolicitud.Text = TranslateLocale.text("Cancelar la Solicitud")
            Me.btnConceptoCC.Text = TranslateLocale.text("Centro de Costo")
            Me.btnConceptoOI.Text = TranslateLocale.text("Orden Interna")
            Me.btnConceptoPEP.Text = TranslateLocale.text("Elemento PEP")
            Me.btnConceptoRF.Text = TranslateLocale.text(Me.btnConceptoRF.Text)
            Me.btnEnviarAuth.Text = TranslateLocale.text("Enviar a Autorización")
            Me.btnGuardar.Text = TranslateLocale.text("Enviar Solicitud")
            Me.btnManejoCC.Text = TranslateLocale.text("Centro de Costo")
            Me.btnManejoOI.Text = TranslateLocale.text("Orden Interna")
            Me.btnManejoPEP.Text = TranslateLocale.text("Elemento PEP")
            Me.btnManejoRF.Text = TranslateLocale.text(Me.btnManejoRF.Text)
            Me.btnRegresar.Text = TranslateLocale.text("Regresar")


            Me.btnEnviarAuth.OnClientClick = "return confirm('" & TranslateLocale.text("¿Seguro que desea enviar esta solicitud a autorización?") & "');"
        End If
    End Sub

    Protected Function LinkMovimientosPorComprobar() As String

        If Session("idEmpleado") = Me.txtIdEmpleadoSolicita.Text Then
            Dim mt As New MovimientosTarjeta(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            'Dim movimientosPorComprobar As Integer = mt.RecuperaCantidadMovimientosPorComprobar(Session("idEmpleado"))
            Dim movimientosPorComprobar As Integer = mt.RecuperaCantidadMovimientosPorComprobar(Me.ddlViajero.SelectedValue)

            If movimientosPorComprobar > 0 Then
                Me.lnkMovimientosPorComprobar.Visible = True
                Return movimientosPorComprobar & " " & TranslateLocale.text("movimientos con tarjeta pendientes de comprobar")
            Else
                Me.lnkMovimientosPorComprobar.Visible = False
                Return ""
            End If
        Else
            Me.lnkMovimientosPorComprobar.Visible = False
            Return ""
        End If


    End Function

    Private Sub CargaCombos()
        Try
            Dim edita_viajero As Boolean = False
            Dim edita_empresa As Boolean = False
            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Me.ddlEmpresa.Items.Clear()
            Me.ddlEmpresa.Items.AddRange(Funciones.DatatableToList(combos.RecuperaSolicitudEmpresa(), "nombre", "id_empresa"))
            Me.ddlEmpresa.SelectedValue = Session("idEmpresa")


            Me.ActualizaEmpleados(Session("idEmpleado"))
            Me.ddlViajero.SelectedValue = Session("idEmpleado")


            Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = empleado.RecuperaEmpleadoPerfil(Session("idEmpleado")).Tables(0)

            For Each dRow As DataRow In dt.Rows
                If dRow("id_perfil") = 63 Then '63	Permiso para generar solicitudes de SV a nombre de alguien mas
                    edita_viajero = True
                End If

                If dRow("id_perfil") = 65 Then '65	Solicitudes de gastos para multiples empresas
                    edita_empresa = True
                End If
            Next

            If edita_viajero = True Then
                Me.ddlViajero.Enabled = True
            Else
                Me.ddlViajero.Enabled = False
            End If

            If edita_empresa = True Then
                Me.ddlEmpresa.Enabled = True
            Else
                Me.ddlEmpresa.Enabled = False
            End If

            Me.ActualizaAutorizaJefe(0)
            Me.ActualizaConta(0)

            Me.ddlDepartamento.Items.Clear()
            Me.ddlDepartamento.Items.AddRange(Funciones.DatatableToList(combos.RecuperaSolicitudDepartamentoCombo(Me.ddlViajero.SelectedValue), "nombre", "id_departamento"))
            Me.ddlDepartamento.SelectedValue = Session("idDepartamento")
            Me.ddlDepartamento.Enabled = False


            Me.ddlMoneda.Items.Clear()
            Me.ddlMoneda.Items.AddRange(Funciones.DatatableToList(combos.RecuperaMonedas(), "descripcion", "clave"))


            For i As Integer = 1 To 30
                Me.ddlNumPersonas.Items.Add(i)
            Next

            Me.CombosSAP(Me.ddlEmpresa.SelectedValue)



            Me.ActualizaCentroCostos(Me.ddlEmpresa.SelectedValue)
            Me.ActualizaNecesidad(Me.ddlEmpresa.SelectedValue)
            Me.ActualizaEmpresasRF()


            Me.ddlTipoIVA.Items.Clear()
            Me.ddlTipoIVA.Items.Add(New ListItem(TranslateLocale.text("-- Seleccione --"), "-1"))
            Me.ddlTipoIVA.Items.Add(New ListItem("16 %", "0.16"))
            Me.ddlTipoIVA.Items.Add(New ListItem("8 %", "0.08"))
            Me.ddlTipoIVA.Items.Add(New ListItem("0 %", "0"))


            ''PARA NUSA NO SE DEBEN MOSTRAR LOS CAMPOS DEL ANTICIPO
            If Session("idEmpresa") = 12 Then
                Me.ddlTipoIVA.SelectedValue = "0"
                Me.trAnticipos.Visible = False
                Me.ddlTipoIVA.Enabled = False
                Me.txtOtrosImpuestos.Enabled = False
            End If

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('ERR: " & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub

    Private Sub CargaDatos(id As Integer)
        Try
            Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = solicitud_gasto.RecuperaPorId(id, Session("idEmpleado"))

            If dt.Rows.Count > 0 Then
                Me.lnkImpr.Visible = True

                Dim dr As DataRow = dt.Rows(0)

                If dr("permitir_cancelar") = 1 Then
                    Me.btnCancelarSolicitud.Visible = True
                End If


                Me.ddlEmpresa.SelectedValue = dr("id_empresa")
                If Me.ddlEmpresa.SelectedValue = 12 Then
                    Me.ddlMoneda.SelectedValue = "USD"
                End If
                Me.txtIdEmpleadoSolicita.Text = dr("id_empleado_solicita")
                Me.lblSolicitante.Text = dr("empleado_solicita")
                Me.lblFolio.Text = TranslateLocale.text("Folio") & ": " & dr("folio_txt")
                Me.lblFechaSolicitud.Text = Format(dr("fecha_registro"), "dd/MM/yyyy")


                Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Me.ActualizaEmpleados(dr("id_empleado_viaja"))
                Me.ddlViajero.SelectedValue = dr("id_empleado_viaja")
                Me.ActualizaAutorizaJefe(dr("id_autoriza_jefe"))
                Me.ddlAutorizaJefe.SelectedValue = dr("id_autoriza_jefe")
                Me.ActualizaConta(dr("id_autoriza_conta"))

                Me.ActualizaEmpresasRF()

                Me.ddlAutorizaConta.SelectedValue = dr("id_autoriza_conta")

                Me.ddlDepartamento.SelectedValue = dr("id_departamento")
                Me.txtDestino.Text = dr("destino")
                Me.txtMotivo.Text = dr("motivo")
                Me.dtFechaIni.SelectedDate = dr("fecha_ini")
                Me.dtFechaFin.SelectedDate = dr("fecha_fin")
                Me.txtMontoPesos.Value = Convert.ToDouble(dr("monto_pesos"))
                Me.txtMontoUSD.Value = Convert.ToDouble(dr("monto_dolares"))
                Me.txtMontoEuro.Value = Convert.ToDouble(dr("monto_euros"))

                Me.diasViaje.InnerText = DateDiff(DateInterval.Day, dr("fecha_ini"), dr("fecha_fin")) + 1
                Me.lblEstatus.Text = "<br /><b>" & TranslateLocale.text("Estatus Actual") & ": " & TranslateLocale.text(dr("estatus")) & "</b>"

                Me.txtIdEstatus.Text = dr("id_estatus")
                Me.tblHistAuth.Visible = True

                If Not IsDBNull(dr("comprobacion_jefe")) Then Me.txtComprobacionJefe.Text = dr("comprobacion_jefe")
                If Not IsDBNull(dr("comprobacion_conta")) Then Me.txtComprobacionConta.Text = dr("comprobacion_conta")

                If Not IsDBNull(dr("comprobacion_jefe")) And
                    Not IsDBNull(dr("comprobacion_conta")) And
                    Not IsDBNull(dr("autoriza_jefe")) And
                    Not IsDBNull(dr("autoriza_conta")) Then
                End If


                ''''''''''''''''''''''''''''''''''
                'Historico de Autorizaciones
                ''''''''''''''''''''''''''''''''''
                If IsDBNull(dr("fecha_autoriza_jefe")) Then
                    Me.lblAutorizaJefe.Text = dr("jefe") & " " & TranslateLocale.text("(Pte)")
                Else
                    Me.lblAutorizaJefe.Text = dr("jefe") & " (" & IIf(dr("autoriza_jefe"), TranslateLocale.text("Aut"), TranslateLocale.text("Rech")) & " - " & Format(dr("fecha_autoriza_jefe"), "dd/MM/yyyy") & ")"
                End If

                If IsDBNull(dr("fecha_autoriza_conta")) Then
                    Me.lblAutorizaConta.Text = dr("conta") & " " & TranslateLocale.text("(Pte)")
                Else
                    Me.lblAutorizaConta.Text = dr("conta") & " (" & IIf(dr("autoriza_conta"), TranslateLocale.text("Aut"), TranslateLocale.text("Rech")) & " - " & Format(dr("fecha_autoriza_conta"), "dd/MM/yyyy") & ")"
                End If


                If IsDBNull(dr("fecha_comprobacion_jefe")) Then
                    Me.lblAutorizaJefeComprobacion.Text = dr("jefe") & " " & TranslateLocale.text("(Pte)")
                Else
                    Me.lblAutorizaJefeComprobacion.Text = dr("jefe") & " (" & IIf(dr("comprobacion_jefe"), TranslateLocale.text("Aut"), TranslateLocale.text("Rech")) & " - " & Format(dr("fecha_comprobacion_jefe"), "dd/MM/yyyy") & ")"
                End If

                If IsDBNull(dr("fecha_comprobacion_conta")) Then
                    Me.lblAutorizaContaComprobacion.Text = dr("conta") & " " & TranslateLocale.text("(Pte)")
                Else
                    Me.lblAutorizaContaComprobacion.Text = dr("conta") & " (" & IIf(dr("comprobacion_conta"), TranslateLocale.text("Aut"), TranslateLocale.text("Rech")) & " - " & Format(dr("fecha_comprobacion_conta"), "dd/MM/yyyy") & ")"
                End If

                ''''''''''''''''''''''''''''''''''
                ''''''''''''''''''''''''''''''''''

                Me.txtTipoComprobantes.Text = dr("tipo_comprobantes")
                If dr("tipo_comprobantes") = "" Then
                    Me.btnManejoOI.Checked = False
                    Me.btnManejoCC.Checked = False
                    Me.btnManejoPEP.Checked = False
                    Me.btnManejoRF.Checked = False
                ElseIf dr("tipo_comprobantes") = "OI" Then
                    Me.btnManejoOI.Checked = True
                    Me.btnManejoCC.Checked = False
                    Me.btnManejoPEP.Checked = False
                    Me.btnManejoRF.Checked = False
                ElseIf dr("tipo_comprobantes") = "CC" Then
                    Me.btnManejoOI.Checked = False
                    Me.btnManejoCC.Checked = True
                    Me.btnManejoPEP.Checked = False
                    Me.btnManejoRF.Checked = False
                ElseIf dr("tipo_comprobantes") = "PP" Then
                    Me.btnManejoOI.Checked = False
                    Me.btnManejoCC.Checked = False
                    Me.btnManejoPEP.Checked = True
                    Me.btnManejoRF.Checked = False
                ElseIf dr("tipo_comprobantes") = "RF" Then
                    Me.btnManejoOI.Checked = False
                    Me.btnManejoCC.Checked = False
                    Me.btnManejoPEP.Checked = False
                    Me.btnManejoRF.Checked = True
                End If

                'Call MuestraOcultaConceptos()


                If Not IsDBNull(dr("autoriza_conta")) Then
                    If dr("autoriza_conta") = True Then
                        Me.divComprobantes.Visible = True
                        Me.CargaConceptosGasto()
                        If dr("id_estatus") = 3 Or Me.txtComprobacionJefe.Text = "False" Or Me.txtComprobacionConta.Text = "False" Then
                            Me.divComprobantesAlta.Visible = True

                            Me.ddlFormaPago.Items.Clear()
                            Me.ddlFormaPago.Items.AddRange(Funciones.DatatableToList(solicitud_gasto.RecuperaFormaPago(Session("idEmpresa")), TranslateLocale.text("descripcion"), "id_forma_pago"))


                            Dim conceptos As New ConceptoGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

                            Me.ddlConcepto.Items.Clear()
                            Me.ddlConcepto.Items.AddRange(Funciones.DatatableToList(conceptos.Recupera("G", dr("tipo_comprobantes"), Me.ddlEmpresa.SelectedValue), TranslateLocale.text("descripcion"), "id_concepto"))

                        End If
                    End If

                End If

                If IsDBNull(dr("autoriza_jefe")) = False Then
                    Me.ddlEmpresa.Enabled = False
                    Me.ddlViajero.Enabled = False

                    Me.ddlAutorizaJefe.Enabled = False
                    Me.ddlAutorizaConta.Enabled = False

                    Me.ddlDepartamento.Enabled = False
                    Me.txtDestino.Enabled = False
                    Me.txtMotivo.Enabled = False
                    Me.dtFechaIni.Enabled = False
                    Me.dtFechaFin.Enabled = False
                    Me.txtMontoPesos.Enabled = False
                    Me.txtMontoUSD.Enabled = False
                    Me.txtMontoEuro.Enabled = False
                    Me.btnGuardar.Visible = False

                    Me.btnManejoOI.Enabled = False
                    Me.btnManejoCC.Enabled = False
                    Me.btnManejoPEP.Enabled = False
                    Me.btnManejoRF.Enabled = False
                End If

                If dr("solicitud_cancelada") = 1 Then
                    Me.btnCancelarSolicitud.Visible = False
                    Me.btnAgregar.Visible = False
                    Me.btnEnviarAuth.Visible = False
                    Me.btnGuardar.Visible = False

                    Me.btnManejoOI.Enabled = False
                    Me.btnManejoCC.Enabled = False
                    Me.btnManejoPEP.Enabled = False
                    Me.btnManejoRF.Enabled = False
                End If


                If dr("id_solicitud_reposicion") > 0 Then
                    Me.divSolicitudConMateriales.Visible = True
                    Me.lnkSolicitudReposicion.NavigateUrl = "/SolicitudReposicionAgregar.aspx?id=" & dr("id_solicitud_reposicion")
                    Me.lblFolioSolicitudReposicion.Text = dr("folio_txt_solicitud_reposicion")
                End If

            Else
                Me.txtIdEmpleadoSolicita.Text = Session("idEmpleado")
                Me.lblSolicitante.Text = Session("nombreEmpleado")
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Datos: " & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub


    Private Sub CargaConceptosGasto()

        Dim configuracion As New Configuracion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dias_gracia As String = configuracion.RecuperaConfiguracion("dias-gracia-comprobantes-anio-pasado", Me.ddlEmpresa.SelectedValue)
        If IsNumeric(dias_gracia) Then
            Me.txtDiasGraciaConceptosAnioAnterior.Value = dias_gracia
        End If



        Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim ds As DataSet = solicitud_gasto.RecuperaConceptos(Me.txtIdSolicitudGasto.Text, Funciones.CurrentLocale)
        Dim dtSaldo As DataTable = solicitud_gasto.RecuperaSaldo(Me.txtIdSolicitudGasto.Text)

        Dim dt As DataTable = ds.Tables(0)

        Me.gvConceptos.DataSource = dt
        Funciones.TranslateGridviewHeader(Me.gvConceptos)
        Me.gvConceptos.EmptyDataText = TranslateLocale.text("Favor de agregar tus comprobantes")
        Me.gvConceptos.DataBind()


        If (Me.txtIdEstatus.Text = 3 Or Me.txtComprobacionJefe.Text = "False" Or Me.txtComprobacionConta.Text = "False") And gvConceptos.Rows.Count > 0 Then
            Me.btnEnviarAuth.Visible = True
            Me.gvConceptos.Columns(11).Visible = True
        Else
            Me.btnEnviarAuth.Visible = False
            Me.gvConceptos.Columns(11).Visible = False
        End If

        If dt.Rows.Count > 0 Then
            Me.divTotales.Visible = True
            If ds.Tables(1).Rows.Count > 0 Then
                If dtSaldo.Rows.Count > 0 Then
                    Me.lblTotalMXP.Text = Format(dtSaldo.Rows(0)("viaticos"), "###,###,##0.00")
                    Me.lblTotalMater.Text = Format(dtSaldo.Rows(0)("materiales"), "###,###,##0.00")
                    Me.lblTotalAjustado.Text = Format(dtSaldo.Rows(0)("ajustado"), "###,###,##0.00")
                    Me.lblSaldoMonto.Text = Format(dtSaldo.Rows(0)("diferencia"), "###,###,##0.00")
                    If dtSaldo.Rows(0)("diferencia") > 0 Then
                        Me.lblSaldoTexto.Text = TranslateLocale.text("Saldo a Favor")
                    ElseIf dtSaldo.Rows(0)("diferencia") < 0 Then
                        Me.lblSaldoTexto.Text = TranslateLocale.text("Saldo a Cargo")
                    Else
                        Me.lblSaldoTexto.Text = TranslateLocale.text("Saldo")
                    End If
                End If
            End If
        End If


        If Me.btnManejoCC.Checked Then
            Me.btnConceptoCC.Checked = True
            Me.btnConceptoOI.Checked = False
            Me.btnConceptoPEP.Checked = False
            Me.btnConceptoRF.Checked = False

            Me.btnConceptoCC.Enabled = False
            Me.btnConceptoOI.Enabled = False
            Me.btnConceptoPEP.Enabled = False
            Me.btnConceptoRF.Enabled = False
        ElseIf Me.btnManejoOI.Checked Then
            Me.btnConceptoCC.Checked = False
            Me.btnConceptoOI.Checked = True
            Me.btnConceptoPEP.Checked = False
            Me.btnConceptoRF.Checked = False

            Me.btnConceptoCC.Enabled = False
            Me.btnConceptoOI.Enabled = False
            Me.btnConceptoPEP.Enabled = False
            Me.btnConceptoRF.Enabled = False
        ElseIf Me.btnManejoPEP.Checked Then
            Me.btnConceptoCC.Checked = False
            Me.btnConceptoOI.Checked = False
            Me.btnConceptoPEP.Checked = True
            Me.btnConceptoRF.Checked = False

            Me.btnConceptoCC.Enabled = False
            Me.btnConceptoOI.Enabled = False
            Me.btnConceptoPEP.Enabled = False
            Me.btnConceptoRF.Enabled = False
        ElseIf Me.btnManejoRF.Checked Then
            Me.btnConceptoCC.Checked = False
            Me.btnConceptoOI.Checked = False
            Me.btnConceptoPEP.Checked = False
            Me.btnConceptoRF.Checked = True

            Me.btnConceptoCC.Enabled = False
            Me.btnConceptoOI.Enabled = False
            Me.btnConceptoPEP.Enabled = False
            Me.btnConceptoRF.Enabled = False
        End If

        Call MuestraOcultaConceptos()

    End Sub

    Private Sub MuestraOcultaConceptos()
        If Me.btnConceptoCC.Checked Then

            Me.ddlCentroCosto.Visible = True
            Me.ddlOrdenInterna.Visible = False
            Me.ddlElementoPEP.Visible = False
            Me.ddlElementoEmpresa.Visible = False
            Me.divNecesidad.Visible = False

        ElseIf Me.btnConceptoOI.Checked Then
            Me.ActualizaNecesidad(Me.ddlEmpresa.SelectedValue)

            Me.ddlCentroCosto.Visible = False
            Me.ddlElementoPEP.Visible = False
            Me.ddlOrdenInterna.Visible = True
            If Me.ddlNecesidad.Items.Count > 1 Then
                Me.divNecesidad.Visible = True
            End If
            Me.ddlElementoEmpresa.Visible = False
        ElseIf Me.btnConceptoPEP.Checked Then
            Me.ActualizaNecesidad(Me.ddlEmpresa.SelectedValue)

            Me.ddlElementoPEP.Visible = True
            Me.ddlCentroCosto.Visible = False
            Me.ddlOrdenInterna.Visible = False
            If Me.ddlNecesidad.Items.Count > 1 Then
                Me.divNecesidad.Visible = True
            End If
            Me.ddlElementoEmpresa.Visible = False
        ElseIf Me.btnConceptoRF.Checked Then

            Me.ddlElementoPEP.Visible = False
            Me.ddlCentroCosto.Visible = False
            Me.ddlOrdenInterna.Visible = False
            Me.divNecesidad.Visible = False
            Me.ddlElementoEmpresa.Visible = True
        End If
    End Sub

    Private Sub btnRegresar_Click(sender As Object, e As EventArgs) Handles btnRegresar.Click
        Response.Redirect("SolicitudGastos.aspx")
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Me.ValidaCaptura()
            Dim folio As String = ""
            Dim tipo_comprobantes As String = ""
            If Me.btnManejoOI.Checked Then
                tipo_comprobantes = "OI"
            ElseIf Me.btnManejoCC.Checked Then
                tipo_comprobantes = "CC"
            ElseIf Me.btnManejoPEP.Checked Then
                tipo_comprobantes = "PP"
            ElseIf Me.btnManejoRF.Checked Then
                tipo_comprobantes = "RF"
            End If


            Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = solicitud_gasto.Guarda(Me.txtIdSolicitudGasto.Text, Me.txtIdEmpleadoSolicita.Text, Me.ddlViajero.SelectedValue,
                                   Me.ddlAutorizaJefe.SelectedValue, Me.ddlAutorizaConta.SelectedValue, Me.ddlDepartamento.SelectedValue,
                                   Me.dtFechaIni.SelectedDate, Me.dtFechaFin.SelectedDate, Me.txtDestino.Text, Me.txtMotivo.Text, "",
                                   Me.txtMontoPesos.Value, Me.txtMontoUSD.Value, Me.txtMontoEuro.Value, Me.ddlEmpresa.SelectedValue, tipo_comprobantes)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)
                Me.txtIdSolicitudGasto.Text = dr("id")
                folio = dr("folio")
            End If

            If (Me.txtMontoPesos.Value + Me.txtMontoUSD.Value + Me.txtMontoEuro.Value) > 0 Then
                EmailJefeDirecto()
            End If


            'ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("Datos guardados con exito") & "\n" & TranslateLocale.text("El No. de Folio de la solicitud es") & ": " & folio & "');window.location='SolicitudGastos.aspx';</script>", False)
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("Datos guardados con exito") & "\n" & TranslateLocale.text("El No. de Folio de la solicitud es") & ": " & folio & "');window.location='SolicitudGastosAgregar.aspx?id=" & Me.txtIdSolicitudGasto.Text & "';</script>", False)

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub ValidaCaptura()
        Dim msg As String = ""

        If Me.ddlEmpresa.SelectedValue = 0 Then
            msg += " - " & TranslateLocale.text("Empresa") & "\n"
        End If

        If Me.ddlDepartamento.SelectedValue = 0 Then
            msg += " - " & TranslateLocale.text("Departamento") & "\n"
        End If

        If Me.ddlAutorizaJefe.SelectedValue = 0 Then
            msg += " - " & TranslateLocale.text("Autoriza Jefe") & "\n"
        End If

        If Me.ddlAutorizaConta.SelectedValue = 0 Then
            msg += " - " & TranslateLocale.text("Autoriza Conta") & "\n"
        End If

        If Me.txtDestino.Text.Trim = "" Then
            msg += " - " & TranslateLocale.text("Destino") & "\n"
        End If

        If Me.txtMotivo.Text.Trim = "" Then
            msg += " - " & TranslateLocale.text("Motivo") & "\n"
        End If

        If Me.dtFechaIni.SelectedDate Is Nothing Then
            msg += " - " & TranslateLocale.text("Fecha Ini") & "\n"
        End If

        If Me.dtFechaFin.SelectedDate Is Nothing Then
            msg += " - " & TranslateLocale.text("Fecha Fin") & "\n"
        End If

        If Me.btnManejoOI.Checked = False And Me.btnManejoCC.Checked = False And Me.btnManejoPEP.Checked = False And Me.btnManejoRF.Checked = False Then
            msg += " - " & TranslateLocale.text("Seleccione Orden Interna, Centro de Costo, Elemento PEP o Reembolso Filiales") & "\n"
        End If


        Dim monedasAnticipoContador As Integer = 0
        If Me.txtMontoPesos.Value > 0 Then
            monedasAnticipoContador += 1
        End If
        If Me.txtMontoUSD.Value > 0 Then
            monedasAnticipoContador += 1
        End If
        If Me.txtMontoEuro.Value > 0 Then
            monedasAnticipoContador += 1
        End If

        If monedasAnticipoContador > 1 Then
            msg += " - " & TranslateLocale.text("El anticipo solo puede otorgarse en una moneda") & "\n"
        End If


        If (Not Me.dtFechaIni.SelectedDate Is Nothing) And (Not Me.dtFechaFin.SelectedDate Is Nothing) Then
            If Me.dtFechaIni.SelectedDate > Me.dtFechaFin.SelectedDate Then
                msg += " - " & TranslateLocale.text("Rango de Fechas Invalido") & "\n"
            End If
        End If

        If Me.ddlAutorizaConta.SelectedValue <> 0 And Me.ddlAutorizaJefe.SelectedValue <> 0 Then
            If Me.txtIdEmpleadoSolicita.Text = Me.ddlAutorizaConta.SelectedValue Or Me.txtIdEmpleadoSolicita.Text = Me.ddlAutorizaJefe.SelectedValue Then
                Dim excepcion As Boolean = False
                Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Dim dt As DataTable = empleado.RecuperaEmpleadoPerfil(Session("idEmpleado")).Tables(0)

                For Each dRow As DataRow In dt.Rows
                    If dRow("id_perfil") = 67 Then '67	Excepcion a regla de autorizacion de solicitudes propias
                        excepcion = True
                        Exit For
                    End If
                Next

                If excepcion = False Then
                    msg += " - " & TranslateLocale.text("No puede seleccionarse a si mismo como Autoriza Jefe o Autoriza Conta") & "\n"
                End If

            End If
        End If


        Dim sg As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        If sg.SolicitudesAbiertas(Me.ddlViajero.SelectedValue, Me.txtIdSolicitudGasto.Text) > 1 And (Me.txtMontoPesos.Value > 0 Or Me.txtMontoUSD.Value > 0 Or Me.txtMontoEuro.Value > 0) Then
            msg += " - " & TranslateLocale.text("No se permite agregar solicitudes para empleados que tengan 2 o mas solicitudes abiertas") & "\n"
        End If
        If sg.EmpleadoTieneNumDeudor(Me.ddlViajero.SelectedValue) = False Then
            msg += " - " & TranslateLocale.text("No es posible agregar la solicitud debido a que el empleado no tiene configurado un número de deudor") & "\n"
        End If

        If msg.Length > 0 Then
            Throw New Exception("" & TranslateLocale.text("Favor de capturar y/o revisar la siguiente información") & ":\n" & msg)
        End If
    End Sub

    Private Sub EmailJefeDirecto()
        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Try
            Dim email_para As String = ""
            Dim email_de As String = ""
            Dim email_usuario As String = ""
            Dim email_asunto As String = ""
            Dim email_smtp As String = ""
            Dim email_password As String = ""
            Dim email_port As String = ""
            Dim email_copia As String = ""
            Dim email_url_base As String = ""
            Dim email_url_base_local As String = ""
            Dim errorMsg As String = ""
            Dim email_body As String
            Dim folio As String = ""
            Dim id_cliente As Integer = 0
            Dim archivos As String = ""

            Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = solicitud_gasto.RecuperaInfoEmail(Me.txtIdSolicitudGasto.Text)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                email_smtp = System.Configuration.ConfigurationManager.AppSettings("SMTP_SERVER").ToString()
                email_usuario = System.Configuration.ConfigurationManager.AppSettings("SMTP_USER").ToString()
                email_password = System.Configuration.ConfigurationManager.AppSettings("SMTP_PASS").ToString()
                email_port = System.Configuration.ConfigurationManager.AppSettings("SMTP_PORT").ToString()
                email_de = System.Configuration.ConfigurationManager.AppSettings("SMTP_FROM").ToString()
                email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
                email_url_base_local = System.Configuration.ConfigurationManager.AppSettings("URL_BASE_LOCAL").ToString()

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                email_asunto = TranslateLocale.text("Solicitud de Gastos", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"

                If dr("email_jefe").ToString.Length > 0 Then
                    email_para = dr("email_jefe")
                Else
                    email_para = System.Configuration.ConfigurationManager.AppSettings("EMAIL_DEFAULT").ToString()
                End If

                Dim urlEmail As String = email_url_base_local & "/Email_Formatos/EnvioSolicitudGasto.aspx?id=" & Me.txtIdSolicitudGasto.Text & "&t=J"
                email_body = RetrieveHttpContent(urlEmail, errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioSolicitudGasto: " & resultado & "::::" & email_para & "---->" & urlEmail)
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudGasto: Error " & email_para & ", " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Function EmailAddressCheck(ByVal emailAddress As String) As Boolean

        Dim pattern As String = "^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$"
        Dim emailAddressMatch As Match = Regex.Match(emailAddress, pattern)
        If emailAddressMatch.Success Then
            EmailAddressCheck = True
        Else
            EmailAddressCheck = False
        End If

    End Function



    Public Shared Function RetrieveHttpContent(Url As String, ByRef ErrorMessage As String) As String
        Dim MergedText As String = ""
        Dim Http As New System.Net.WebClient()
        Try
            Dim Result As Byte() = Http.DownloadData(Url)
            Result = ConvertUtf8ToLatin1(Result)
            MergedText = System.Text.Encoding.GetEncoding(28591).GetString(Result)
        Catch ex As Exception
            ErrorMessage = ex.Message.Replace(CChar(ChrW(39)), CChar(ChrW(34)))
            Return Nothing
        End Try
        Return MergedText
    End Function

    Public Shared Function ConvertUtf8ToLatin1(bytes As Byte()) As Byte()
        Dim latin1 As System.Text.Encoding = System.Text.Encoding.GetEncoding(&H6FAF)
        Return System.Text.Encoding.Convert(System.Text.Encoding.UTF8, latin1, bytes)
    End Function

    Protected Sub ddlViajero_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlViajero.SelectedIndexChanged
        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        Me.ddlAutorizaJefe.Items.Clear()
        Me.ddlAutorizaJefe.Items.AddRange(Funciones.DatatableToList(combos.RecuperaAutorizaJefe(Me.ddlViajero.SelectedValue, 0), "nombre", "id_empleado"))

    End Sub

    Private Sub btnAgregar_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click

        Try
            Me.ValidaCapturaConceptos()
            Dim tipo_concepto As String = ""
            If Me.btnConceptoCC.Checked Then
                tipo_concepto = "CC"
            ElseIf Me.btnConceptoOI.Checked Then
                tipo_concepto = "OI"
            ElseIf Me.btnConceptoPEP.Checked Then
                tipo_concepto = "PP"
            ElseIf Me.btnConceptoRF.Checked Then
                tipo_concepto = "RF"
            End If

            Dim tipo_cambio As Decimal = 1
            Dim sap As New ConsultasSAP
            If Me.ddlEmpresa.SelectedValue = 12 Then   'NUSA
                If Me.ddlMoneda.SelectedValue <> "USD" Then
                    tipo_cambio = sap.RecuperaParidadDesdeHacia("USD", Me.ddlMoneda.SelectedValue, Me.dtFechaConcepto.SelectedDate)
                End If
            Else
                If Me.ddlMoneda.SelectedValue <> "MXP" Then
                    tipo_cambio = sap.RecuperaParidadDesdeHacia("MXP", Me.ddlMoneda.SelectedValue, Me.dtFechaConcepto.SelectedDate)
                End If
            End If

            Dim iva_concepto As Decimal = 0
            If Me.ddlTipoIVA.Visible Then
                iva_concepto = Me.ddlTipoIVA.SelectedValue * Me.txtSubtotal.Value
            Else
                iva_concepto = Me.txtIvaEditado.Text
            End If


            Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            'If solicitud_gasto.FormaPagoUnico(Me.txtIdSolicitudGasto.Text, Me.ddlFormaPago.SelectedValue) Then
            If Me.btnConceptoPEP.Checked Then
                Me.txtOrdenInterna.Text = Me.ddlElementoPEP.SelectedValue
            End If

            solicitud_gasto.GuardaConceptoGasto(0, Me.txtIdSolicitudGasto.Text, Me.ddlConcepto.SelectedValue, Me.txtSubtotal.Text,
                                                iva_concepto, Me.ddlMoneda.SelectedValue, tipo_cambio, Me.dtFechaConcepto.SelectedDate,
                                                Me.ddlFormaPago.SelectedValue, Me.txtOrdenInterna.Text, Me.txtNecesidad.Text, Me.txtObservaciones.Text,
                                                Me.ddlCentroCosto.SelectedValue, Me.ddlNecesidad.SelectedValue, tipo_concepto, Me.txtOtrosImpuestos.Text, Me.txtRetencion.Value,
                                                Me.ddlNumPersonas.SelectedValue, Me.ddlElementoEmpresa.SelectedValue, Me.txtPropina.Value, 0, Me.txtRetencionResico.Value)

            Me.CargaConceptosGasto()
            Me.txtSubtotal.Value = 0
            Me.ddlTipoIVA.SelectedValue = "-1"

            ''PARA NUSA NO SE DEBEN MOSTRAR LOS CAMPOS DEL ANTICIPO
            If Session("idEmpresa") = 12 Then
                Me.ddlTipoIVA.SelectedValue = "0"
            End If

            Me.txtOtrosImpuestos.Value = 0
            Me.txtRetencion.Value = 0
            Me.txtRetencionResico.Value = 0
            Me.txtPropina.Value = 0
            Me.divTotal.InnerHtml = "0.00"
            Me.txtObservaciones.Text = ""
            Me.ddlNumPersonas.SelectedValue = 1
            'Else
            'ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("Todos los conceptos registrados deben tener la misma forma de pago.") & "');</script>", False)
            'End If

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub



    Private Sub ValidaCapturaConceptos()
        Dim msg As String = ""

        If Me.dtFechaConcepto.SelectedDate Is Nothing Then
            msg += " - " & TranslateLocale.text("Fecha") & "\n"
        Else
            Dim fecha_comprobate As DateTime = Me.dtFechaConcepto.SelectedDate
            If Year(fecha_comprobate) < Year(DateTime.Now) Then
                If DateTime.Now.DayOfYear > Me.txtDiasGraciaConceptosAnioAnterior.Value Then
                    msg += " - " & TranslateLocale.text("Solo se permiten capturar gastos del año en curso") & "\n"
                End If
            End If
        End If

        If Me.txtRetencion.Value Is Nothing Then
            Me.txtRetencion.Value = 0
        End If
        If Me.txtRetencion.Value Is Nothing Then
            Me.txtRetencion.Value = 0
        End If

        If Me.txtPropina.Value Is Nothing Then
            Me.txtPropina.Value = 0
        End If

        If Me.txtOtrosImpuestos.Value Is Nothing Then
            Me.txtOtrosImpuestos.Value = 0
        End If

        If Me.txtSubtotal.Value Is Nothing Then
            Me.txtSubtotal.Value = 0
        End If

        If Me.txtIvaEditado.Value Is Nothing Then
            Me.txtIvaEditado.Value = 0
        End If

        If Me.txtSubtotal.Value = 0 Then
            msg += " - " & TranslateLocale.text("Subtotal") & "\n"
        End If

        If Me.ddlTipoIVA.Visible And Me.ddlTipoIVA.SelectedValue = -1 Then
            msg += " - " & TranslateLocale.text("Tipo de IVA") & "\n"
        End If

        If Me.txtObservaciones.Text.Length < 5 Then
            msg += " - " & TranslateLocale.text("Observaciones (Al menos 5 caracteres)") & "\n"
        End If

        If Me.btnConceptoCC.Checked Then
            If Me.ddlCentroCosto.SelectedValue = 0 Then
                msg += " - " & TranslateLocale.text("Centro de Costo") & "\n"
            End If
        ElseIf Me.btnConceptoOI.Checked Then
            If Me.ddlOrdenInterna.SelectedValue = TranslateLocale.text(" -- Seleccione --") Then
                msg += " - " & TranslateLocale.text("Orden Interna") & "\n"
            ElseIf Me.ddlOrdenInterna.SelectedValue = " OI Manual" And Me.txtOrdenInterna.Text.Trim.Length = 0 Then
                msg += " - " & TranslateLocale.text("Orden Interna") & "\n"
            End If
            If Me.ddlNecesidad.Visible And Me.ddlNecesidad.SelectedValue = 0 Then
                msg += " - " & TranslateLocale.text("Necesidad") & "\n"
            End If
        ElseIf Me.btnConceptoPEP.Checked Then
            If Me.ddlElementoPEP.SelectedValue = TranslateLocale.text(" -- Seleccione --") Then
                msg += " - " & TranslateLocale.text("Elemento PEP") & "\n"
                'ElseIf Me.ddlOrdenInterna.SelectedValue = " OI Manual" And Me.txtOrdenInterna.Text.Trim.Length = 0 Then
                '    msg += " - Orden Interna\n"
            End If
            If Me.ddlNecesidad.Visible And Me.ddlNecesidad.SelectedValue = 0 Then
                msg += " - " & TranslateLocale.text("Necesidad") & "\n"
            End If
        ElseIf Me.btnConceptoRF.Checked Then
            If Me.ddlElementoEmpresa.SelectedValue = 0 Then
                msg += " - " & TranslateLocale.text("Empresa Filial") & "\n"
            End If
        End If


        ''RMC: 20160413
        If (Me.txtMontoEuro.Value + Me.txtMontoPesos.Value + Me.txtMontoUSD.Value > 0) And (Me.ddlFormaPago.SelectedValue <> "1" And Me.ddlFormaPago.SelectedValue <> "3") Then
            msg += " - " & TranslateLocale.text("Cuando la solicitud cuenta con Anticipos solo se permite utilizar la forma de pago: EF o TE") & "\n"
        End If

        Dim validacion As String = ValidaFormaPago(Me.txtIdSolicitudGasto.Text, 0, ddlFormaPago.SelectedValue)
        If validacion.Length > 0 Then
            msg += " - " & TranslateLocale.text(validacion) & "\n"
        End If


        ''RMC: 20160425
        'If Me.txtMontoUSD.Value > 0 And Me.ddlMoneda.SelectedValue <> "USD" Then
        '    msg += " - " & TranslateLocale.text("Por tener anticipo en USD solo se permiten capturar gastos en USD") & "\n"
        'ElseIf Me.txtMontoEuro.Value > 0 And Me.ddlMoneda.SelectedValue <> "EUR" Then
        '    msg += " - " & TranslateLocale.text("Por tener anticipo en EUR solo se permiten capturar gastos en EUR") & "\n"
        'End If


        If msg.Length > 0 Then
            Throw New Exception(TranslateLocale.text("Favor de capturar y/o revisar la siguiente información") & ":\n" & msg)
        End If
    End Sub

    Private Function ValidaFormaPago(id_solicitud As Integer, id_detalle As Integer, id_forma_pago As Integer)
        Dim resultado As String
        Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        resultado = solicitud_gasto.ValidaFormaPago(id_solicitud, id_detalle, id_forma_pago)
        Return resultado
    End Function

    Private Sub gvConceptos_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs) Handles gvConceptos.RowCancelingEdit

    End Sub

    Private Sub gvConceptos_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvConceptos.RowCommand
        If e.CommandName = "editar" Then
            Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
            CType(gvRow.FindControl("lblSubtotal"), Label).Visible = False
            CType(gvRow.FindControl("txtSubtotal"), RadNumericTextBox).Visible = True
            CType(gvRow.FindControl("lblOtrosImpuestos"), Label).Visible = False
            CType(gvRow.FindControl("txtOtrosImpuestos"), RadNumericTextBox).Visible = True

            CType(gvRow.FindControl("lblConcepto"), Label).Visible = False
            Dim ddlConcepto As DropDownList = CType(gvRow.FindControl("ddlConcepto"), DropDownList)
            CType(gvRow.FindControl("lblObservaciones"), Label).Visible = False
            CType(gvRow.FindControl("txtObservaciones"), TextBox).Visible = True
            CType(gvRow.FindControl("lblFecha"), Label).Visible = False
            CType(gvRow.FindControl("dtFecha"), RadDatePicker).Visible = True


            Dim conceptos As New ConceptoGasto(ConfigurationManager.AppSettings("CONEXION"))
            ddlConcepto.Items.Clear()
            ddlConcepto.Items.AddRange(Funciones.DatatableToList(conceptos.Recupera("G", Me.txtTipoComprobantes.Text, Me.ddlEmpresa.SelectedValue), TranslateLocale.text("descripcion"), "id_concepto"))
            ddlConcepto.Visible = True
            ddlConcepto.SelectedValue = CType(gvRow.FindControl("lblIdConcepto"), Label).Text



            CType(gvRow.FindControl("lblIVA"), Label).Visible = False

            Dim es_no_deducible As Boolean = False
            Dim es_iva_editable As Boolean = False

            CType(gvRow.FindControl("ddlTipoIVA"), DropDownList).Visible = True
            CType(gvRow.FindControl("txtIvaEditado"), RadNumericTextBox).Visible = False

            es_no_deducible = CType(gvRow.FindControl("esNoDeducible"), HiddenField).Value
            es_iva_editable = CType(gvRow.FindControl("esIvaEditable"), HiddenField).Value

            If es_no_deducible Then
                CType(gvRow.FindControl("ddlTipoIVA"), DropDownList).SelectedValue = 0
                CType(gvRow.FindControl("ddlTipoIVA"), DropDownList).Enabled = False
            Else
                If es_iva_editable Then
                    CType(gvRow.FindControl("ddlTipoIVA"), DropDownList).Visible = False
                    CType(gvRow.FindControl("txtIvaEditado"), RadNumericTextBox).Visible = True
                End If
            End If


            Dim requiere_retencion As Boolean = False
            requiere_retencion = CType(gvRow.FindControl("requiere_retencion"), HiddenField).Value

            If requiere_retencion Then
                CType(gvRow.FindControl("lblRetencion"), Label).Visible = False
                CType(gvRow.FindControl("txtRetencion"), RadNumericTextBox).Visible = True
                CType(gvRow.FindControl("txtRetencion"), RadNumericTextBox).Value = CType(gvRow.FindControl("lblRetencion"), Label).Text
            Else
                CType(gvRow.FindControl("lblRetencion"), Label).Visible = True
                CType(gvRow.FindControl("txtRetencion"), RadNumericTextBox).Visible = False
            End If

            CType(gvRow.FindControl("lblRetencionResico"), Label).Visible = False
            CType(gvRow.FindControl("txtRetencionResico"), RadNumericTextBox).Visible = True
            CType(gvRow.FindControl("txtRetencionResico"), RadNumericTextBox).Value = CType(gvRow.FindControl("lblRetencionResico"), Label).Text


            Dim permite_propina As Boolean = False
            permite_propina = CType(gvRow.FindControl("permite_propina"), HiddenField).Value

            If permite_propina Then
                CType(gvRow.FindControl("lblPropina"), Label).Visible = False
                CType(gvRow.FindControl("txtPropina"), RadNumericTextBox).Visible = True
                CType(gvRow.FindControl("txtPropina"), RadNumericTextBox).Value = CType(gvRow.FindControl("lblPropina"), Label).Text
            Else
                CType(gvRow.FindControl("lblPropina"), Label).Visible = True
                CType(gvRow.FindControl("txtPropina"), RadNumericTextBox).Visible = False
            End If


            'CType(gvRow.FindControl("lblTipoCambio"), Label).Visible = False
            CType(gvRow.FindControl("lblMoneda"), Label).Visible = False
            CType(gvRow.FindControl("ddlMoneda"), DropDownList).Visible = True

            CType(gvRow.FindControl("lblNumPersonas"), Label).Visible = False
            CType(gvRow.FindControl("ddlNumPersonas"), DropDownList).Visible = True

            Dim ddlNumPersonasX As DropDownList = CType(gvRow.FindControl("ddlNumPersonas"), DropDownList)
            For i As Integer = 1 To 30
                ddlNumPersonasX.Items.Add(i)
            Next
            ddlNumPersonasX.SelectedValue = CType(gvRow.FindControl("lblNumPersonas"), Label).Text


            Dim formaPagoEditable As Integer = 0
            formaPagoEditable = CType(gvRow.FindControl("formaPagoEditable"), HiddenField).Value

            If formaPagoEditable > 0 Then  '' NO EDITABLE
                CType(gvRow.FindControl("lblFormaPago"), Label).Visible = True
                CType(gvRow.FindControl("ddlFormaPago"), DropDownList).Visible = False
            Else
                CType(gvRow.FindControl("lblFormaPago"), Label).Visible = False
                CType(gvRow.FindControl("ddlFormaPago"), DropDownList).Visible = True
            End If

            Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim ddlFormaPagoX As DropDownList = CType(gvRow.FindControl("ddlFormaPago"), DropDownList)
            ddlFormaPagoX.Items.AddRange(Funciones.DatatableToList(solicitud_gasto.RecuperaFormaPago(Session("idEmpresa")), TranslateLocale.text("descripcion"), "id_forma_pago"))
            ddlFormaPagoX.SelectedValue = CType(gvRow.FindControl("idFormaPago"), HiddenField).Value



            Dim ddlMonedaX As DropDownList = CType(gvRow.FindControl("ddlMoneda"), DropDownList)
            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            ddlMonedaX.DataSource = combos.RecuperaMonedas()
            ddlMonedaX.DataValueField = "clave"
            ddlMonedaX.DataTextField = "descripcion"
            ddlMonedaX.DataBind()

            ddlMonedaX.SelectedValue = CType(gvRow.FindControl("lblMoneda"), Label).Text
            CType(gvRow.FindControl("txtSubtotal"), RadNumericTextBox).Value = CType(gvRow.FindControl("lblSubtotal"), Label).Text
            CType(gvRow.FindControl("txtOtrosImpuestos"), RadNumericTextBox).Value = CType(gvRow.FindControl("lblOtrosImpuestos"), Label).Text
            'CType(gvRow.FindControl("txtIVA"), RadNumericTextBox).Value = CType(gvRow.FindControl("lblIVA"), Label).Text

            If CType(gvRow.FindControl("lblIVA"), Label).Text = 0 Then
                CType(gvRow.FindControl("ddlTipoIVA"), DropDownList).SelectedValue = 0
            ElseIf CType(gvRow.FindControl("lblIVA"), Label).Text / 0.16 = CType(gvRow.FindControl("lblSubtotal"), Label).Text Then
                CType(gvRow.FindControl("ddlTipoIVA"), DropDownList).SelectedValue = 0.16
            Else
                CType(gvRow.FindControl("ddlTipoIVA"), DropDownList).SelectedValue = 0.16
            End If
            CType(gvRow.FindControl("txtIvaEditado"), RadNumericTextBox).Value = CType(gvRow.FindControl("lblIVA"), Label).Text

            CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = False
            CType(gvRow.FindControl("btnDelete"), ImageButton).Visible = False
            CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnSave"), ImageButton).Visible = True

            'ANGEL RAMOS 08.02.2024 Editar proyecto y N Necesidad

            'Dim dtPEP As DataTable = SAP.RecuperaElementoPEP(id_empresa)
            'dtPEP.Rows.Add("", TranslateLocale.text(" -- Seleccione --"))
            'dtPEP.AcceptChanges()

            'Dim dvEP As DataView = New DataView(dtPEP)
            'dvEP.Sort = "POSKI"

            'Me.ddlElementoPEP.DataSource = dvEP
            'Me.ddlElementoPEP.DataValueField = "POSKI"
            'Me.ddlElementoPEP.DataTextField = "POSKI"
            'Me.ddlElementoPEP.DataBind()


        ElseIf e.CommandName = "cancelar" Then
            Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
            CType(gvRow.FindControl("lblSubtotal"), Label).Visible = True
            CType(gvRow.FindControl("txtSubtotal"), RadNumericTextBox).Visible = False
            CType(gvRow.FindControl("txtOtrosImpuestos"), RadNumericTextBox).Visible = False
            CType(gvRow.FindControl("lblOtrosImpuestos"), Label).Visible = True
            CType(gvRow.FindControl("lblIVA"), Label).Visible = True
            CType(gvRow.FindControl("ddlTipoIVA"), DropDownList).Visible = False
            CType(gvRow.FindControl("txtIvaEditado"), RadNumericTextBox).Visible = False

            CType(gvRow.FindControl("lblMoneda"), Label).Visible = True
            CType(gvRow.FindControl("ddlMoneda"), DropDownList).Visible = False

            CType(gvRow.FindControl("lblNumPersonas"), Label).Visible = True
            CType(gvRow.FindControl("ddlNumPersonas"), DropDownList).Visible = False

            CType(gvRow.FindControl("lblFormaPago"), Label).Visible = True
            CType(gvRow.FindControl("ddlFormaPago"), DropDownList).Visible = False

            CType(gvRow.FindControl("lblObservaciones"), Label).Visible = True
            CType(gvRow.FindControl("txtObservaciones"), TextBox).Visible = False

            CType(gvRow.FindControl("lblConcepto"), Label).Visible = True
            CType(gvRow.FindControl("ddlConcepto"), DropDownList).Visible = False


            CType(gvRow.FindControl("lblFecha"), Label).Visible = True
            CType(gvRow.FindControl("dtFecha"), RadDatePicker).Visible = False

            CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnDelete"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
            CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False


            CType(gvRow.FindControl("lblRetencion"), Label).Visible = True
            CType(gvRow.FindControl("txtRetencion"), RadNumericTextBox).Visible = False

            CType(gvRow.FindControl("lblRetencionResico"), Label).Visible = True
            CType(gvRow.FindControl("txtRetencionResico"), RadNumericTextBox).Visible = False

            CType(gvRow.FindControl("lblPropina"), Label).Visible = True
            CType(gvRow.FindControl("txtPropina"), RadNumericTextBox).Visible = False

        ElseIf e.CommandName = "save" Then
            Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
            Dim txtSubtotal As RadNumericTextBox = CType(gvRow.FindControl("txtSubtotal"), RadNumericTextBox)
            Dim txtOtrosImpuestos As RadNumericTextBox = CType(gvRow.FindControl("txtOtrosImpuestos"), RadNumericTextBox)
            Dim ddlIVA As DropDownList = CType(gvRow.FindControl("ddlTipoIVA"), DropDownList)
            Dim ddlMonedaX As DropDownList = CType(gvRow.FindControl("ddlMoneda"), DropDownList)
            Dim ddlNumPersonasX As DropDownList = CType(gvRow.FindControl("ddlNumPersonas"), DropDownList)
            Dim ddlFormaPagoX As DropDownList = CType(gvRow.FindControl("ddlFormaPago"), DropDownList)
            Dim txtIvaEditado As RadNumericTextBox = CType(gvRow.FindControl("txtIvaEditado"), RadNumericTextBox)
            Dim txtRetencion As RadNumericTextBox = CType(gvRow.FindControl("txtRetencion"), RadNumericTextBox)
            Dim txtRetencionResico As RadNumericTextBox = CType(gvRow.FindControl("txtRetencionResico"), RadNumericTextBox)
            Dim txtPropina As RadNumericTextBox = CType(gvRow.FindControl("txtPropina"), RadNumericTextBox)
            Dim ddlConcepto As DropDownList = CType(gvRow.FindControl("ddlConcepto"), DropDownList)
            Dim txtObservaciones As TextBox = CType(gvRow.FindControl("txtObservaciones"), TextBox)
            Dim dtFecha As RadDatePicker = CType(gvRow.FindControl("dtFecha"), RadDatePicker)



            If txtRetencion.Value Is Nothing Then
                txtRetencion.Value = 0
            End If

            If txtRetencionResico.Value Is Nothing Then
                txtRetencionResico.Value = 0
            End If

            If txtPropina.Value Is Nothing Then
                txtPropina.Value = 0
            End If

            If txtOtrosImpuestos.Value Is Nothing Then
                txtOtrosImpuestos.Value = 0
            End If

            If txtSubtotal.Value Is Nothing Then
                txtSubtotal.Value = 0
            End If

            If txtIvaEditado.Value Is Nothing Then
                txtIvaEditado.Value = 0
            End If





            Dim msg As String = ""
            If txtSubtotal.Value <= 0 Then
                msg = "Subtotal\n"
            End If

            If txtObservaciones.Text.Length <= 0 Then
                msg &= "Observaciones\n"
            End If

            If ddlConcepto.SelectedValue = 0 Then
                msg &= "Concepto\n"
            End If



            If dtFecha.SelectedDate Is Nothing Then
                msg &= "Fecha de comprobante\n"
            End If


            ''RMC: 20160425
            'If Me.txtMontoUSD.Value > 0 And ddlMonedaX.SelectedValue <> "USD" Then
            '    msg += " - " & TranslateLocale.text("Por tener anticipo en USD solo se permiten capturar gastos en USD") & "\n"
            'ElseIf Me.txtMontoEuro.Value > 0 And ddlMonedaX.SelectedValue <> "EUR" Then
            '    msg += " - " & TranslateLocale.text("Por tener anticipo en EUR solo se permiten capturar gastos en EUR") & "\n"
            'End If

            Dim validacion As String = ValidaFormaPago(Me.txtIdSolicitudGasto.Text, e.CommandArgument, ddlFormaPagoX.SelectedValue)
            If validacion.Length > 0 Then
                msg += " - " & TranslateLocale.text(validacion) & "\n"
            End If

            If msg.Length > 0 Then
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("Favor de ingresar los siguientes datos") & ":\n\n" & msg & "');</script>", False)
                Exit Sub
            End If








            Dim es_no_deducible As Boolean = False
            Dim es_iva_editable As Boolean = False
            Dim requiere_retencion As Boolean = False
            Dim permite_propina As Boolean = False
            Dim concepto_gasto As New ConceptoGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = concepto_gasto.RecuperaPorId(ddlConcepto.SelectedValue)
            If dt.Rows.Count > 0 Then
                es_no_deducible = dt.Rows(0)("es_no_deducible")
                es_iva_editable = dt.Rows(0)("es_iva_editable")
                requiere_retencion = dt.Rows(0)("requiere_retencion")
                permite_propina = dt.Rows(0)("permite_propina")
            End If

            'If es_no_deducible Then
            '    Me.ddlTipoIVA.SelectedValue = "0"
            '    Me.ddlTipoIVA.Enabled = False
            'Else
            '    If es_iva_editable Then
            '        Me.ddlTipoIVA.Visible = False
            '        Me.txtIvaEditado.Visible = True
            '    End If

            'End If

            If requiere_retencion = False Then
                txtRetencion.Value = "0"
            End If

            If permite_propina = False Then
                txtPropina.Value = 0
            End If






            If txtSubtotal.Value Is Nothing Then txtSubtotal.Value = 0

            Dim iva_concepto As Decimal = 0
            If ddlIVA.Visible = True Then
                iva_concepto = ddlIVA.SelectedValue * txtSubtotal.Value
            Else
                iva_concepto = txtIvaEditado.Value
            End If


            Dim tipo_cambio As Decimal = 1
            Dim sap As New ConsultasSAP
            If Me.ddlEmpresa.SelectedValue = 12 Then   'NUSA
                If ddlMonedaX.SelectedValue <> "USD" Then
                    tipo_cambio = sap.RecuperaParidadDesdeHacia("USD", ddlMonedaX.SelectedValue, dtFecha.SelectedDate)
                End If
            Else
                If ddlMonedaX.SelectedValue <> "MXP" Then
                    tipo_cambio = sap.RecuperaParidadDesdeHacia("MXP", ddlMonedaX.SelectedValue, dtFecha.SelectedDate)
                End If
            End If



            Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            solicitud_gasto.GuardaConceptoGasto(e.CommandArgument, txtSubtotal.Value, iva_concepto, ddlMonedaX.SelectedValue, txtOtrosImpuestos.Value, txtRetencion.Value, ddlNumPersonasX.SelectedValue, tipo_cambio, ddlFormaPagoX.SelectedValue, txtPropina.Value, txtObservaciones.Text, dtFecha.SelectedDate.Value, ddlConcepto.SelectedValue, txtRetencionResico.Value)

            Dim lblSubtotal As Label = CType(gvRow.FindControl("lblSubtotal"), Label)
            lblSubtotal.Visible = True
            lblSubtotal.Text = Format(txtSubtotal.Value, "###,###,##0.00")

            Dim lblOtrosImpuestos As Label = CType(gvRow.FindControl("lblOtrosImpuestos"), Label)
            lblOtrosImpuestos.Visible = True
            lblOtrosImpuestos.Text = Format(txtOtrosImpuestos.Value, "###,###,##0.00")

            Dim lblIVA As Label = CType(gvRow.FindControl("lblIVA"), Label)
            lblIVA.Visible = True
            lblIVA.Text = Format(iva_concepto, "###,###,##0.00")

            Dim lblMoneda As Label = CType(gvRow.FindControl("lblMoneda"), Label)
            lblMoneda.Visible = True
            lblMoneda.Text = ddlMonedaX.SelectedItem.Text


            Dim lblRetencion As Label = CType(gvRow.FindControl("lblRetencion"), Label)
            lblRetencion.Visible = True
            lblRetencion.Text = Format(txtRetencion.Value, "###,###,##0.00")

            Dim lblRetencionResico As Label = CType(gvRow.FindControl("lblRetencionResico"), Label)
            lblRetencionResico.Visible = True
            lblRetencionResico.Text = Format(txtRetencionResico.Value, "###,###,##0.00")

            Dim lblPropina As Label = CType(gvRow.FindControl("lblPropina"), Label)
            lblPropina.Visible = True
            lblPropina.Text = Format(txtPropina.Value, "###,###,##0.00")

            Dim lblNumPersonas As Label = CType(gvRow.FindControl("lblNumPersonas"), Label)
            lblNumPersonas.Visible = True
            lblNumPersonas.Text = ddlNumPersonasX.SelectedValue


            Dim lblFormaPago As Label = CType(gvRow.FindControl("lblFormaPago"), Label)
            lblFormaPago.Visible = True
            lblFormaPago.Text = ddlFormaPagoX.SelectedItem.Text

            Dim lblFecha As Label = CType(gvRow.FindControl("lblFecha"), Label)
            lblFecha.Visible = True
            lblFecha.Text = dtFecha.SelectedDate.Value.ToString("dd/MM/yyyy")


            Dim lblObservaciones As Label = CType(gvRow.FindControl("lblObservaciones"), Label)
            lblObservaciones.Visible = True
            lblObservaciones.Text = txtObservaciones.Text

            Dim lblConcepto As Label = CType(gvRow.FindControl("lblConcepto"), Label)
            lblConcepto.Visible = True
            lblConcepto.Text = ddlConcepto.SelectedItem.Text




            CType(gvRow.FindControl("txtSubtotal"), RadNumericTextBox).Visible = False
            CType(gvRow.FindControl("txtOtrosImpuestos"), RadNumericTextBox).Visible = False
            CType(gvRow.FindControl("ddlTipoIVA"), DropDownList).Visible = False
            CType(gvRow.FindControl("ddlMoneda"), DropDownList).Visible = False
            CType(gvRow.FindControl("txtRetencion"), RadNumericTextBox).Visible = False
            CType(gvRow.FindControl("txtRetencionResico"), RadNumericTextBox).Visible = False
            CType(gvRow.FindControl("txtPropina"), RadNumericTextBox).Visible = False
            CType(gvRow.FindControl("ddlNumPersonas"), DropDownList).Visible = False
            CType(gvRow.FindControl("ddlFormaPago"), DropDownList).Visible = False
            CType(gvRow.FindControl("ddlConcepto"), DropDownList).Visible = False
            CType(gvRow.FindControl("txtObservaciones"), TextBox).Visible = False
            CType(gvRow.FindControl("dtFecha"), RadDatePicker).Visible = False


            CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnDelete"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
            CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False

            Me.CargaConceptosGasto()

        ElseIf e.CommandName = "delete" Then
            Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            solicitud_gasto.EliminaComprobante(e.CommandArgument)

            Me.CargaConceptosGasto()
        End If



        Me.btnEnviarAuth.Focus()

    End Sub

    'Private Sub btnEnviarAuth_Click(sender As Object, e As EventArgs) Handles btnEnviarAuth.Click
    '    Try
    '        Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
    '        Dim id_solicitud_reposicion = solicitud_gasto.IniciaAutorizacionComprobantes(Me.txtIdSolicitudGasto.Text)

    '        'Envio de Email al Jefe Solicitud de Autorizacion de comprobantes de Viaje 
    '        EnviarComprobantes()
    '        If id_solicitud_reposicion > 0 Then
    '            EnviarComprobantesReposicionGenerada(id_solicitud_reposicion)
    '        End If

    '        ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("Sus comprobantes han sido enviados a autorización") & "');window.location='SolicitudGastos.aspx';</script>", False)

    '    Catch ex As Exception
    '        ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
    '    End Try

    'End Sub

    Private Sub btnEnviarAuth_Click(sender As Object, e As EventArgs) Handles btnEnviarAuth.Click
        Try
            Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim valida_comprobantes As Boolean = solicitud_gasto.ValidaDocumentosComprobantes(Me.txtIdSolicitudGasto.Text)

            If valida_comprobantes Then
                Dim id_solicitud_reposicion = solicitud_gasto.IniciaAutorizacionComprobantes(Me.txtIdSolicitudGasto.Text)

                'Envio de Email al Jefe Solicitud de Autorizacion de comprobantes de Viaje 
                EnviarComprobantes()
                If id_solicitud_reposicion > 0 Then
                    EnviarComprobantesReposicionGenerada(id_solicitud_reposicion)
                End If
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("Sus comprobantes han sido enviados a autorización") & "');window.location='SolicitudGastos.aspx';</script>", False)
            Else
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("Favor de cargar XML y/o PDF de todos los comprobantes") & "');window.location='SolicitudGastos.aspx?id=" & Me.txtIdSolicitudGasto.Text & "';</script>", False)
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try

    End Sub


    Private Sub EnviarComprobantes()
        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Try
            Dim email_para As String = ""
            Dim email_de As String = ""
            Dim email_usuario As String = ""
            Dim email_asunto As String = ""
            Dim email_smtp As String = ""
            Dim email_password As String = ""
            Dim email_port As String = ""
            Dim email_copia As String = ""
            Dim email_url_base As String = ""
            Dim email_url_base_local As String = ""
            Dim errorMsg As String = ""
            Dim email_body As String
            Dim folio As String = ""
            Dim id_cliente As Integer = 0
            Dim archivos As String = ""

            Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = solicitud_gasto.RecuperaInfoEmail(Me.txtIdSolicitudGasto.Text)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                email_smtp = System.Configuration.ConfigurationManager.AppSettings("SMTP_SERVER").ToString()
                email_usuario = System.Configuration.ConfigurationManager.AppSettings("SMTP_USER").ToString()
                email_password = System.Configuration.ConfigurationManager.AppSettings("SMTP_PASS").ToString()
                email_port = System.Configuration.ConfigurationManager.AppSettings("SMTP_PORT").ToString()
                email_de = System.Configuration.ConfigurationManager.AppSettings("SMTP_FROM").ToString()
                email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
                email_url_base_local = System.Configuration.ConfigurationManager.AppSettings("URL_BASE_LOCAL").ToString()

                If dr("email_jefe").ToString.Length > 0 Then
                    email_para = dr("email_jefe")
                Else
                    email_para = System.Configuration.ConfigurationManager.AppSettings("EMAIL_DEFAULT").ToString()
                End If

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                Dim urlEmail As String = email_url_base_local & "/Email_Formatos/EnvioSolicitudGastoComprobantes.aspx?id=" & Me.txtIdSolicitudGasto.Text & "&t=J"
                email_asunto = TranslateLocale.text("Solicitud de Autorizacion de comprobantes de Viaje", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                email_body = RetrieveHttpContent(urlEmail, errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioSolicitudGastoComprobantes: " & resultado & "::::" & email_para & "---->" & urlEmail)
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudGastoComprobantes: Error " & email_para & ", " & ex.Message())
                End Try


            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Private Sub EnviarComprobantesReposicionGenerada(id_solicitud_reposicion As Integer)
        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Try
            Dim email_para As String = ""
            Dim email_de As String = ""
            Dim email_usuario As String = ""
            Dim email_asunto As String = ""
            Dim email_smtp As String = ""
            Dim email_password As String = ""
            Dim email_port As String = ""
            Dim email_copia As String = ""
            Dim email_url_base As String = ""
            Dim email_url_base_local As String = ""
            Dim errorMsg As String = ""
            Dim email_body As String
            Dim folio As String = ""
            Dim id_cliente As Integer = 0
            Dim archivos As String = ""

            Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = solicitud_reposicion.RecuperaInfoEmail(id_solicitud_reposicion)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                email_smtp = System.Configuration.ConfigurationManager.AppSettings("SMTP_SERVER").ToString()
                email_usuario = System.Configuration.ConfigurationManager.AppSettings("SMTP_USER").ToString()
                email_password = System.Configuration.ConfigurationManager.AppSettings("SMTP_PASS").ToString()
                email_port = System.Configuration.ConfigurationManager.AppSettings("SMTP_PORT").ToString()
                email_de = System.Configuration.ConfigurationManager.AppSettings("SMTP_FROM").ToString()
                email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
                email_url_base_local = System.Configuration.ConfigurationManager.AppSettings("URL_BASE_LOCAL").ToString()


                If dr("email_jefe").ToString.Length > 0 Then
                    email_para = dr("email_jefe")
                Else
                    email_para = System.Configuration.ConfigurationManager.AppSettings("EMAIL_DEFAULT").ToString()
                End If

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                email_asunto = TranslateLocale.text("Solicitud de autorizacion de comprobantes de Viaje", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                email_body = RetrieveHttpContent(email_url_base_local & "/Email_Formatos/EnvioSolicitudReposicion.aspx?id=" & id_solicitud_reposicion & "&t=J", errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")
                    seguridad.GuardaLogDatos("EnvioSolicitudReposicion: " & resultado & "::::" & email_para & "---->" & email_url_base & "/Email_Formatos/EnvioSolicitudReposicion.aspx?id=" & id_solicitud_reposicion & "&t=J")
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudReposicion: Error " & email_para & ", " & ex.Message())
                End Try


            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub



    Protected Sub ActualizaAutorizaJefe(id_empleado_incluir As Integer)
        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        Me.ddlAutorizaJefe.DataSource = Nothing
        Me.ddlAutorizaJefe.DataBind()

        If Me.ddlViajero.SelectedValue <> "" Then

            Me.ddlAutorizaJefe.Items.Clear()
            Me.ddlAutorizaJefe.Items.AddRange(Funciones.DatatableToList(combos.RecuperaAutorizaJefe(Me.ddlViajero.SelectedValue, id_empleado_incluir), "nombre", "id_empleado"))

        End If
    End Sub

    Protected Sub ActualizaEmpleados(id_empleado_incluir As Integer)
        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        Me.ddlViajero.Items.Clear()
        Me.ddlViajero.Items.AddRange(Funciones.DatatableToList(combos.RecuperaSolicitudEmpleado(Me.ddlEmpresa.SelectedValue, id_empleado_incluir), "nombre", "id_empleado"))
    End Sub

    Protected Sub ActualizaConta(id_empleado_incluir As Integer)
        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        Me.ddlAutorizaConta.Items.Clear()
        Me.ddlAutorizaConta.Items.AddRange(Funciones.DatatableToList(combos.RecuperaAutorizaConta(Me.ddlEmpresa.SelectedValue, id_empleado_incluir, Session("idEmpleado")), "nombre", "id_empleado"))

    End Sub

    Private Sub ActualizaCentroCostos(ByVal id_empresa As Integer)
        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        Me.ddlCentroCosto.Items.Clear()
        Me.ddlCentroCosto.Items.AddRange(Funciones.DatatableToList(combos.RecuperaCentroCosto(Me.ddlEmpresa.SelectedValue, TranslateLocale.text("-- Seleccione --"), 0), "desc_combo", "id_centro_costo"))

    End Sub

    Private Sub ActualizaNecesidad(ByVal id_empresa As Integer)
        Dim tipo_concepto As String
        If Me.btnConceptoCC.Checked Then
            tipo_concepto = "CC"
        ElseIf Me.btnConceptoOI.Checked Then
            tipo_concepto = "OI"
        ElseIf Me.btnConceptoPEP.Checked Then
            tipo_concepto = "PP"
        ElseIf Me.btnConceptoRF.Checked Then
            tipo_concepto = "RF"
        End If


        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        Me.ddlNecesidad.Items.Clear()
        Me.ddlNecesidad.Items.AddRange(Funciones.DatatableToList(combos.RecuperaNecesidad(id_empresa, tipo_concepto), "desc_combo", "id_necesidad"))

    End Sub

    Private Sub ddlEmpresa_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlEmpresa.SelectedIndexChanged
        Me.ActualizaEmpleados(0)
        Me.ActualizaConta(0)
        Me.ActualizaAutorizaJefe(0)
        Call MuestraOcultaTipoContabilidad()
        Me.ActualizaCentroCostos(Me.ddlEmpresa.SelectedValue)
        Me.ActualizaNecesidad(Me.ddlEmpresa.SelectedValue)
        Me.CombosSAP(Me.ddlEmpresa.SelectedValue)

        Me.ActualizaEmpresasRF()


    End Sub

    Private Sub ActualizaEmpresasRF()
        If ddlEmpresa.SelectedValue = 6 Then
            Me.btnConceptoRF.Visible = True
            Me.btnManejoRF.Visible = True

        Else
            Me.btnConceptoRF.Visible = False
            Me.btnManejoRF.Visible = False
        End If

        Me.ddlElementoEmpresa.Items.Clear()
        Me.ddlElementoEmpresa.Items.Add(New ListItem(TranslateLocale.text("--Seleccione--"), 0))
        Me.ddlElementoEmpresa.Items.Add(New ListItem("Nutec Bickley", 3))
        Me.ddlElementoEmpresa.Items.Add(New ListItem("Nutec Fibratec", 8))
        Me.ddlElementoEmpresa.Items.Add(New ListItem("Nutec USA", 12))

    End Sub

    Private Sub CombosSAP(id_empresa As Integer)
        Try
            Dim sap As New ConsultasSAP()
            Dim dtOI As DataTable = sap.RecuperaOrdenesInternas(id_empresa)
            dtOI.Rows.Add(TranslateLocale.text(" -- Seleccione --"))
            dtOI.Rows.Add(" OI Manual")
            dtOI.AcceptChanges()

            Dim dvOI As DataView = New DataView(dtOI)
            dvOI.Sort = "AUFNR"

            Me.ddlOrdenInterna.DataSource = dvOI
            Me.ddlOrdenInterna.DataValueField = "AUFNR"
            Me.ddlOrdenInterna.DataTextField = "AUFNR"
            Me.ddlOrdenInterna.DataBind()


            Dim dtPEP As DataTable = sap.RecuperaElementoPEP(id_empresa)
            dtPEP.Rows.Add("", TranslateLocale.text(" -- Seleccione --"))
            dtPEP.AcceptChanges()

            Dim dvEP As DataView = New DataView(dtPEP)
            dvEP.Sort = "POSKI"

            Me.ddlElementoPEP.DataSource = dvEP
            Me.ddlElementoPEP.DataValueField = "POSKI"
            Me.ddlElementoPEP.DataTextField = "POSKI"
            Me.ddlElementoPEP.DataBind()
        Catch ex As Exception
            'ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Error al conectar con SAP. Intente mas tarde.');</script>", False)
        End Try
    End Sub

    Private Sub gvConceptos_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvConceptos.RowDataBound

        If e.Row.RowType = DataControlRowType.Header Then
            If Me.ddlEmpresa.SelectedValue = 12 Then
                e.Row.Cells(9).Text = "Total USD"
            End If
        End If

    End Sub

    Private Sub gvConceptos_RowDeleting(sender As Object, e As GridViewDeleteEventArgs) Handles gvConceptos.RowDeleting
    End Sub

    Private Sub gvConceptos_RowEditing(sender As Object, e As GridViewEditEventArgs) Handles gvConceptos.RowEditing

    End Sub

    Private Sub gvConceptos_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles gvConceptos.RowUpdating

    End Sub

    Private Sub btnCancelarSolicitud_Click(sender As Object, e As EventArgs) Handles btnCancelarSolicitud.Click
        Try
            Dim solicitud As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            solicitud.CancelaSolicitud(Me.txtIdSolicitudGasto.Text, Session("idEmpleado"))

            Response.Redirect("SolicitudGastosAgregar.aspx?id=" & Me.txtIdSolicitudGasto.Text)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub MuestraOcultaTipoContabilidad()
        'If Me.ddlEmpresa.SelectedValue = 8 Then
        '    Me.divSeleccionTipoContabilidad.Visible = True
        'Else
        '    Me.divSeleccionTipoContabilidad.Visible = False
        'End Ifs
        Me.divSeleccionTipoContabilidad.Visible = True
    End Sub

    Private Sub btnConceptoOI_CheckedChanged(sender As Object, e As EventArgs) Handles btnConceptoOI.CheckedChanged
        Call MuestraOcultaConceptos()
    End Sub

    Private Sub btnConceptoCC_CheckedChanged(sender As Object, e As EventArgs) Handles btnConceptoCC.CheckedChanged
        Call MuestraOcultaConceptos()
    End Sub

    Private Sub ddlOrdenInterna_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlOrdenInterna.SelectedIndexChanged
        Call MuestraOcultaOrdenInterna()
    End Sub

    Private Sub btnConceptoRF_CheckedChanged(sender As Object, e As EventArgs) Handles btnConceptoRF.CheckedChanged
        Call MuestraOcultaConceptos()
    End Sub

    Private Sub MuestraOcultaOrdenInterna()
        If Me.ddlOrdenInterna.SelectedValue = " OI Manual" Then
            Me.txtOrdenInterna.Visible = True
        Else
            Me.txtOrdenInterna.Visible = False
            Me.txtOrdenInterna.Text = Me.ddlOrdenInterna.Text
        End If
    End Sub

    Private Sub btnConceptoPEP_CheckedChanged(sender As Object, e As EventArgs) Handles btnConceptoPEP.CheckedChanged
        Call MuestraOcultaConceptos()
    End Sub

    Private Sub ddlConcepto_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlConcepto.SelectedIndexChanged
        If ddlConcepto.SelectedValue > 0 Then
            Dim es_no_deducible As Boolean = False
            Dim es_iva_editable As Boolean = False
            Dim requiere_retencion As Boolean = False
            Dim permite_propina As Boolean = False

            Me.ddlTipoIVA.Visible = True
            Me.txtIvaEditado.Visible = False

            Dim concepto_gasto As New ConceptoGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = concepto_gasto.RecuperaPorId(ddlConcepto.SelectedValue)
            If dt.Rows.Count > 0 Then
                es_no_deducible = dt.Rows(0)("es_no_deducible")
                es_iva_editable = dt.Rows(0)("es_iva_editable")
                requiere_retencion = dt.Rows(0)("requiere_retencion")
                permite_propina = dt.Rows(0)("permite_propina")
            End If

            If es_no_deducible Then
                Me.ddlTipoIVA.SelectedValue = "0"
                Me.ddlTipoIVA.Enabled = False
            Else
                If es_iva_editable Then
                    Me.ddlTipoIVA.Visible = False
                    Me.txtIvaEditado.Visible = True
                End If

            End If

            If requiere_retencion Then
                Me.txtRetencion.Visible = True
                Me.txtRetencion.Value = 0
                Me.tdEtiquetaRetencion.Visible = True
                Me.tdRetencion.Visible = True
            Else
                Me.txtRetencion.Visible = False
                Me.txtRetencion.Value = 0
                Me.tdEtiquetaRetencion.Visible = False
                Me.tdRetencion.Visible = False
            End If

            Me.txtRetencionResico.Visible = True
            Me.txtRetencionResico.Value = 0
            Me.tdEtiquetaRetencionResico.Visible = True
            Me.tdRetencionResico.Visible = True

            If permite_propina Then
                Me.txtPropina.Visible = True
                Me.txtPropina.Value = 0
                Me.tdEtiquetaPropina.Visible = True
                Me.tdPropina.Visible = True
            Else
                Me.txtPropina.Visible = False
                Me.txtPropina.Value = 0
                Me.tdEtiquetaPropina.Visible = False
                Me.tdPropina.Visible = False
            End If

        End If

    End Sub
End Class
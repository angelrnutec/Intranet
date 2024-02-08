Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class SolicitudGastosImprimir
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            If Request.QueryString("id") Is Nothing Then
                Response.Redirect("/ErrorInesperado.aspx?Msg=Consulta invalida")
            End If

            Me.CargaDatos(Request.QueryString("id"))

            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>window.print();</script>", False)
        End If

        Me.lblPendienteAuth.Text = TranslateLocale.text(" (SOLICITUD PENDIENTE DE AUTORIZACIÓN)")
        Me.lblAnticipo.Text = TranslateLocale.text(Me.lblAnticipo.Text)
        Me.lblTotalViaticos.Text = TranslateLocale.text(Me.lblTotalViaticos.Text)
        Me.lblTotalCompraMaterial.Text = TranslateLocale.text(Me.lblTotalCompraMaterial.Text)
        Me.lblTotalConvertido.Text = TranslateLocale.text(Me.lblTotalConvertido.Text)
        Me.lblTotalGastos.Text = TranslateLocale.text(Me.lblTotalGastos.Text)
        Me.lblTotalAjustado.Text = TranslateLocale.text(Me.lblTotalAjustado.Text)



    End Sub

    Private Sub CargaDatos(id As Integer)
        Try
            Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = solicitud_gasto.RecuperaPorIdDesc(id)

            If dt.Rows.Count > 0 Then

                Dim dr As DataRow = dt.Rows(0)

                Me.txtIdSolicitud.Value = dr("id_solicitud")
                Me.txtIdEmpleado.Value = dr("id_empleado_viaja")
                Me.lblEmpresa.Text = dr("empresa")
                Me.lblViajero.Text = dr("viajero")
                Me.lblSolicitante.Text = dr("solicitante")
                Me.lblFolio.Text = dr("folio_txt")
                Me.lblFechaSolicitud.Text = Format(dr("fecha_registro"), "dd/MM/yyyy")
                If Not IsDBNull(dr("fecha_envio_autorizacion")) Then
                    Me.lblFechaComprobacion.Text = Format(dr("fecha_envio_autorizacion"), "dd/MM/yyyy")
                End If

                Me.txtIdEmpresa.Value = dr("id_empresa")
                If Me.txtIdEmpresa.Value = 12 Then
                    Me.lblAnticipo.Text = Me.lblAnticipo.Text.Replace("MXP", "USD")
                    Me.lblTotalViaticos.Text = Me.lblTotalViaticos.Text.Replace("MXP", "USD")
                    Me.lblTotalCompraMaterial.Text = Me.lblTotalCompraMaterial.Text.Replace("MXP", "USD")
                    Me.lblTotalConvertido.Text = Me.lblTotalConvertido.Text.Replace("MXP", "USD")
                    Me.lblTotalGastos.Text = Me.lblTotalGastos.Text.Replace("MXP", "USD")

                End If

                If IsDBNull(dr("fecha_autoriza_jefe")) Then
                    Me.lblAutorizaJefe.Text = dr("jefe") & " " & TranslateLocale.text("(Pte)")
                Else
                    Me.lblAutorizaJefe.Text = dr("jefe") & " (" & IIf(dr("autoriza_jefe"), TranslateLocale.text("Aut"), TranslateLocale.text("Rech")) & " - " & Format(dr("fecha_autoriza_jefe"), "dd/MM/yyyy") & ")"
                End If

                If IsDBNull(dr("fecha_autoriza_conta")) Then
                    Me.lblAutorizaConta.Text = dr("conta") & " (Pte)"
                Else
                    Me.lblAutorizaConta.Text = dr("conta") & " (" & IIf(dr("autoriza_conta"), TranslateLocale.text("Aut"), TranslateLocale.text("Rech")) & " - " & Format(dr("fecha_autoriza_conta"), "dd/MM/yyyy") & ")"
                End If


                If IsDBNull(dr("fecha_comprobacion_jefe")) Then
                    Me.lblAutorizaJefeComprobacion.Text = dr("jefe") & " (Pte)"
                Else
                    Me.lblAutorizaJefeComprobacion.Text = dr("jefe") & " (" & IIf(dr("comprobacion_jefe"), TranslateLocale.text("Aut"), TranslateLocale.text("Rech")) & " - " & Format(dr("fecha_comprobacion_jefe"), "dd/MM/yyyy") & ")"
                End If

                If IsDBNull(dr("fecha_comprobacion_conta")) Then
                    Me.lblAutorizaContaComprobacion.Text = dr("conta") & " (Pte)"
                Else
                    Me.lblAutorizaContaComprobacion.Text = dr("conta") & " (" & IIf(dr("comprobacion_conta"), TranslateLocale.text("Aut"), TranslateLocale.text("Rech")) & " - " & Format(dr("fecha_comprobacion_conta"), "dd/MM/yyyy") & ")"
                End If


                Me.lblDepartamento.Text = dr("departamento")
                Me.lblDestino.Text = dr("destino")
                Me.lblMotivo.Text = dr("motivo")
                Me.lblFechaIni.Text = Format(dr("fecha_ini"), "dd/MM/yyyy")
                Me.lblFechaFin.Text = Format(dr("fecha_fin"), "dd/MM/yyyy")
                Me.lblMontoPesos.Text = Format(dr("monto_pesos"), "###,###,##0.00")
                Me.lblMontoUSD.Text = Format(dr("monto_dolares"), "###,###,##0.00")
                Me.lblMontoEuros.Text = Format(dr("monto_euros"), "###,###,##0.00")

                Me.diasViaje.Text = DateDiff(DateInterval.Day, dr("fecha_ini"), dr("fecha_fin")) + 1
                Me.lblDiasViaje.Text = DateDiff(DateInterval.Day, dr("fecha_ini"), dr("fecha_fin")) + 1

                If IsDBNull(dr("comprobacion_jefe")) = True Or
                    IsDBNull(dr("comprobacion_conta")) = True Or
                    IsDBNull(dr("autoriza_jefe")) = True Or
                    IsDBNull(dr("autoriza_conta")) = True Then

                    Me.lblPendienteAuth.Visible = True
                End If


                Me.CargaConceptosGasto()
                If dr("id_solicitud_reposicion") > 0 Then
                    Me.divSolicitudConMateriales.Visible = True
                    Me.lblFolioSolicitudReposicion.Text = dr("folio_txt_solicitud_reposicion")
                End If






                Dim id_solicitud As Integer = Me.txtIdSolicitud.Value
                Dim id_empleado As Integer = Me.txtIdEmpleado.Value
                Dim num_tarjeta_gastos As String = ""
                Dim anticipo_total As Decimal = 0
                Dim ajuste_total As Decimal = 0
                Dim solicitud_gastos As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
                solicitud_gastos.RecuperaInfoTicketEmpresarial(id_solicitud, num_tarjeta_gastos, anticipo_total, ajuste_total)

                If GlobalFunctions.ModuloTicketEmpresarial And num_tarjeta_gastos <> "" Then
                    Me.btnRealizarRetiroTE.Visible = True
                End If




                If Not Session("permisos") Is Nothing Then
                    Dim permisos As New ArrayList()
                    permisos = Session("permisos")
                    If permisos.IndexOf("boton_realizar_retiro_te") = -1 Then
                        Me.btnRealizarRetiroTE.Visible = False
                    End If
                End If


            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub



    Dim _totalMXP As Decimal = 0
    Dim _totalUSD As Decimal = 0
    Dim _totalEUR As Decimal = 0

    Dim _subtotalMXP As Decimal = 0
    Dim _subtotalUSD As Decimal = 0
    Dim _subtotalEUR As Decimal = 0

    Dim _ivaMXP As Decimal = 0
    Dim _ivaUSD As Decimal = 0
    Dim _ivaEUR As Decimal = 0

    Dim _otrosimpMXP As Decimal = 0
    Dim _otrosimpUSD As Decimal = 0
    Dim _otrosimpEUR As Decimal = 0

    Dim _propinaMXP As Decimal = 0
    Dim _propinaUSD As Decimal = 0
    Dim _propinaEUR As Decimal = 0

    Dim _retMXP As Decimal = 0
    Dim _retUSD As Decimal = 0
    Dim _retEUR As Decimal = 0

    Dim _retResicoMXP As Decimal = 0
    Dim _retResicoUSD As Decimal = 0
    Dim _retResicoEUR As Decimal = 0

    Private Sub gvConceptos_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvConceptos.RowDataBound

        If e.Row.RowType = DataControlRowType.Header Then
            If Me.txtIdEmpresa.Value = 12 Then
                e.Row.Cells(15).Text = "Total USD"
            End If
        End If



        If e.Row.RowType = DataControlRowType.DataRow Then
            If e.Row.Cells(6).Text = "MXP" Then
                _totalMXP += e.Row.Cells(14).Text
                _subtotalMXP += e.Row.Cells(7).Text
                _ivaMXP += e.Row.Cells(8).Text
                _otrosimpMXP += e.Row.Cells(9).Text
                _propinaMXP += e.Row.Cells(10).Text
                _retMXP += e.Row.Cells(11).Text
                _retResicoMXP += e.Row.Cells(12).Text
            ElseIf e.Row.Cells(6).Text = "USD" Then
                _totalUSD += e.Row.Cells(12).Text
                _subtotalUSD += e.Row.Cells(7).Text
                _ivaUSD += e.Row.Cells(8).Text
                _otrosimpUSD += e.Row.Cells(9).Text
                _propinaUSD += e.Row.Cells(10).Text
                _retUSD += e.Row.Cells(11).Text
                _retResicoUSD += e.Row.Cells(12).Text
            ElseIf e.Row.Cells(6).Text = "EUR" Then
                _totalEUR += e.Row.Cells(12).Text
                _subtotalEUR += e.Row.Cells(7).Text
                _ivaEUR += e.Row.Cells(8).Text
                _otrosimpEUR += e.Row.Cells(9).Text
                _propinaEUR += e.Row.Cells(10).Text
                _retEUR += e.Row.Cells(11).Text
                _retResicoEUR += e.Row.Cells(12).Text
            End If

        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(6).Text = "MXN:<br>USD:<br>EUR:"
            e.Row.Cells(6).HorizontalAlign = HorizontalAlign.Right

            e.Row.Cells(7).Text = _subtotalMXP.ToString("#,###,##0.00") & "<br>" & _subtotalUSD.ToString("#,###,##0.00") & "<br>" & _subtotalEUR.ToString("#,###,##0.00")
            e.Row.Cells(7).HorizontalAlign = HorizontalAlign.Right

            e.Row.Cells(8).Text = _ivaMXP.ToString("#,###,##0.00") & "<br>" & _ivaUSD.ToString("#,###,##0.00") & "<br>" & _ivaEUR.ToString("#,###,##0.00")
            e.Row.Cells(8).HorizontalAlign = HorizontalAlign.Right

            e.Row.Cells(9).Text = _otrosimpMXP.ToString("#,###,##0.00") & "<br>" & _otrosimpUSD.ToString("#,###,##0.00") & "<br>" & _otrosimpEUR.ToString("#,###,##0.00")
            e.Row.Cells(9).HorizontalAlign = HorizontalAlign.Right

            e.Row.Cells(10).Text = _propinaMXP.ToString("#,###,##0.00") & "<br>" & _propinaUSD.ToString("#,###,##0.00") & "<br>" & _propinaEUR.ToString("#,###,##0.00")
            e.Row.Cells(10).HorizontalAlign = HorizontalAlign.Right


            'e.Row.Cells(11).Text = "MXN:<br>USD:<br>EUR:"
            'e.Row.Cells(11).HorizontalAlign = HorizontalAlign.Right

            e.Row.Cells(11).Text = _retMXP.ToString("#,###,##0.00") & "<br>" & _retUSD.ToString("#,###,##0.00") & "<br>" & _retEUR.ToString("#,###,##0.00")
            e.Row.Cells(11).HorizontalAlign = HorizontalAlign.Right

            e.Row.Cells(12).Text = _retResicoMXP.ToString("#,###,##0.00") & "<br>" & _retResicoUSD.ToString("#,###,##0.00") & "<br>" & _retResicoEUR.ToString("#,###,##0.00")
            e.Row.Cells(12).HorizontalAlign = HorizontalAlign.Right


            e.Row.Cells(14).Text = _totalMXP.ToString("#,###,##0.00") & "<br>" & _totalUSD.ToString("#,###,##0.00") & "<br>" & _totalEUR.ToString("#,###,##0.00")
            e.Row.Cells(14).HorizontalAlign = HorizontalAlign.Right

            'e.Row.Cells(11).Text = "MXP: " & _totalMXP.ToString("#,###,###.00") & "<br>USD: " & _totalUSD.ToString("#,###,###.00") & "<br>EUR: " & _totalEUR.ToString("#,###,###.00")
            'e.Row.Cells(11).HorizontalAlign = HorizontalAlign.Right
        End If


    End Sub


    Private Sub CargaConceptosGasto()
        Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim ds As DataSet = solicitud_gasto.RecuperaConceptosDesc(Request.QueryString("id"), Funciones.CurrentLocale)
        Dim dtSaldo As DataTable = solicitud_gasto.RecuperaSaldo(Request.QueryString("id"))
        Dim dtPoliza As DataTable = solicitud_gasto.RecuperaPoliza(Request.QueryString("id"))
        Dim dtTablaResumen As DataTable = solicitud_gasto.RecuperaTablaResumen(Request.QueryString("id"))

        Me.gvConceptos.DataSource = ds.Tables(0)
        Funciones.TranslateGridviewHeader(gvConceptos)
        Me.gvConceptos.EmptyDataText = TranslateLocale.text("Favor de agregar tus comprobantes")
        Me.gvConceptos.DataBind()


        If ds.Tables(0).Rows.Count = 0 Then
            Me.oculta1.Visible = False
            Me.divComprobantes.Visible = False
        Else
            divPoliza.Visible = True
            Me.gvPoliza.DataSource = dtPoliza
            Funciones.TranslateGridviewHeader(gvPoliza)
            Me.gvPoliza.EmptyDataText = TranslateLocale.text("Favor de agregar tus comprobantes")
            Me.gvPoliza.DataBind()

            If dtPoliza.Rows.Count > 0 Then
                If dtPoliza.Rows(0)("tiene_poliza_contable") <> "0" Then
                    spnTituloPoliza.InnerText = TranslateLocale.text("Vista previa de la póliza (Enviada a SAP)")
                Else
                    spnTituloPoliza.InnerText = TranslateLocale.text("Vista previa de la póliza")
                End If
            End If
        End If

        If ds.Tables(1).Rows.Count > 0 Then
            Dim dr As DataRow = ds.Tables(1).Rows(0)

            Me.lblTotalGastosConvPesos.Text = Format(dr("total"), "###,###,##0.00")
            Me.lblGastosTC.Text = Format(dr("total_tc"), "###,###,##0.00")
            Me.lblTotalGastosPesos.Text = Format(dr("total_pes"), "###,###,##0.00")
            Me.lblGastoDiarioPromedio.Text = Format((dr("total_pes") / Me.lblDiasViaje.Text), "###,###,##0.00")

        End If

        Dim strResumenFormaPago As String = ""
        For Each dr As DataRow In dtTablaResumen.Rows
            'strResumenFormaPago &= "<tr><td>" & dr("forma_pago").ToString() & "</td><td align='right'>" & Convert.ToDecimal(dr("total").ToString()).ToString("#,###,##0.00") & "</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>"

            If Me.txtIdEmpresa.Value = 12 Then
                tablaResumenColTE.Visible = False
                tablaResumenColCav.Visible = False
                strResumenFormaPago &= "<tr><td>" & dr("descripcion").ToString() & "</td><td align='right'>" & Convert.ToDecimal(dr("efectivo").ToString()).ToString("#,###,##0.00") & "</td><td align='right'>" & Convert.ToDecimal(dr("tc").ToString()).ToString("#,###,##0.00") & "</td><td align='right'>" & Convert.ToDecimal(dr("subtotal").ToString()).ToString("#,###,##0.00") & "</td><td align='right'>" & Convert.ToDecimal(dr("iva").ToString()).ToString("#,###,##0.00") & "</td><td align='right'>" & Convert.ToDecimal(dr("total").ToString()).ToString("#,###,##0.00") & "</td><td>&nbsp;</td></tr>"
            Else
                tablaResumenColTE.Visible = True
                tablaResumenColCav.Visible = True
                strResumenFormaPago &= "<tr><td>" & dr("descripcion").ToString() & "</td><td align='right'>" & Convert.ToDecimal(dr("efectivo").ToString()).ToString("#,###,##0.00") & "</td><td align='right'>" & Convert.ToDecimal(dr("tc").ToString()).ToString("#,###,##0.00") & "</td><td align='right'>" & Convert.ToDecimal(dr("te").ToString()).ToString("#,###,##0.00") & "</td><td align='right'>" & Convert.ToDecimal(dr("cav").ToString()).ToString("#,###,##0.00") & "</td><td align='right'>" & Convert.ToDecimal(dr("subtotal").ToString()).ToString("#,###,##0.00") & "</td><td align='right'>" & Convert.ToDecimal(dr("iva").ToString()).ToString("#,###,##0.00") & "</td><td align='right'>" & Convert.ToDecimal(dr("total").ToString()).ToString("#,###,##0.00") & "</td></tr>"
            End If

        Next
        Me.phResumenFormaPago.Controls.Add(New LiteralControl(strResumenFormaPago))

        If dtSaldo.Rows.Count > 0 Then
            Me.lblSaldoAnticipo.Text = Format(dtSaldo.Rows(0)("anticipo"), "###,###,##0.00")
            Me.lblSaldoViaticos.Text = Format(dtSaldo.Rows(0)("viaticos"), "###,###,##0.00")
            Me.lblSaldoMateriales.Text = Format(dtSaldo.Rows(0)("materiales"), "###,###,##0.00")
            Me.lblSaldoAjustado.Text = Format(dtSaldo.Rows(0)("ajustado"), "###,###,##0.00")
            Me.lblSaldoSaldo.Text = Format(dtSaldo.Rows(0)("diferencia"), "###,###,##0.00")
            If dtSaldo.Rows(0)("diferencia") > 0 Then
                Me.lblSaldoTexto.Text = TranslateLocale.text("Saldo a Favor (MXP)")
            ElseIf dtSaldo.Rows(0)("diferencia") < 0 Then
                Me.lblSaldoTexto.Text = TranslateLocale.text("Saldo a Cargo (MXP)")
            Else
                Me.lblSaldoTexto.Text = TranslateLocale.text("Saldo (MXP)")
            End If


            If Me.txtIdEmpresa.Value = 12 Then
                Me.lblSaldoTexto.Text = Me.lblSaldoTexto.Text.Replace("MXP", "USD")
            End If


            If Application("Modulo_TicketEmpresarial") = True Then
                Dim num_tarjeta_gastos As String = ""
                Dim anticipo_total As Decimal = 0
                Dim ajuste_total As Decimal = 0
                Dim solicitud_gastos As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
                solicitud_gastos.RecuperaInfoTicketEmpresarial(Request.QueryString("id"), num_tarjeta_gastos, anticipo_total, ajuste_total)

                If num_tarjeta_gastos <> "" Then
                    Me.tblTicketEmpresarial.Visible = True

                    If dtSaldo.Rows(0)("ticket_empresarial_asignacion") > 0 Then
                        Me.lblTEAnticipo.Text = Format(dtSaldo.Rows(0)("ticket_empresarial_asignacion"), "###,###,##0.00")
                        Me.lblTESaldoInicial.Text = Format(dtSaldo.Rows(0)("ticket_empresarial_saldo_inicial"), "###,###,##0.00")
                    Else
                        Me.lblTEAnticipo.Text = "--.--"
                        Me.lblTESaldoInicial.Text = "--.--"
                    End If

                    If dtSaldo.Rows(0)("ticket_empresarial_ajuste") > 0 Then
                        Me.lblTERetiros.Text = Format(dtSaldo.Rows(0)("ticket_empresarial_ajuste"), "###,###,##0.00")
                        Me.lblTESaldoFinal.Text = Format(dtSaldo.Rows(0)("ticket_empresarial_saldo_final"), "###,###,##0.00")
                    Else
                        Me.lblTERetiros.Text = "--.--"
                        Me.lblTESaldoFinal.Text = "--.--"
                    End If
                End If
            End If

            'If dtSaldo.Rows(0)("ticket_empresarial_asignacion") > 0 Or dtSaldo.Rows(0)("ticket_empresarial_ajuste") > 0 Then
            '    Me.tblTicketEmpresarial.Visible = True

            '    If dtSaldo.Rows(0)("ticket_empresarial_asignacion") > 0 Then
            '        Me.lblTEAnticipo.Text = Format(dtSaldo.Rows(0)("ticket_empresarial_asignacion"), "###,###,##0.00")
            '        Me.lblTESaldoInicial.Text = Format(dtSaldo.Rows(0)("ticket_empresarial_saldo_inicial"), "###,###,##0.00")
            '    Else
            '        Me.lblTEAnticipo.Text = "--.--"
            '        Me.lblTESaldoInicial.Text = "--.--"
            '    End If

            '    If dtSaldo.Rows(0)("ticket_empresarial_ajuste") > 0 Then
            '        Me.lblTERetiros.Text = Format(dtSaldo.Rows(0)("ticket_empresarial_ajuste"), "###,###,##0.00")
            '        Me.lblTESaldoFinal.Text = Format(dtSaldo.Rows(0)("ticket_empresarial_saldo_final"), "###,###,##0.00")
            '    Else
            '        Me.lblTERetiros.Text = "--.--"
            '        Me.lblTESaldoFinal.Text = "--.--"
            '    End If

            'End If
        End If


    End Sub

    Protected Sub btnProcesarRetiroTE_Click(sender As Object, e As EventArgs) Handles btnProcesarRetiroTE.Click
        If Me.txtImporteRetiroTE.Value Is Nothing Then
            Me.txtImporteRetiroTE.Value = 0
        End If

        If Me.txtImporteRetiroTE.Value <= 0 Then
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("Ingresa el importe a retirar") & "');</script>", False)
            Return
        End If

        If Me.txtImporteRetiroTE.Value > Decimal.Parse(Me.lblSaldoActualTE.Text) Then
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("El importe a retirar no puede ser mayor al saldo actual de la cuenta") & "');</script>", False)
            Return
        End If


        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())

        Dim id_solicitud As Integer = Me.txtIdSolicitud.Value
        Dim id_empleado As Integer = Me.txtIdEmpleado.Value
        Dim num_tarjeta_gastos As String = ""
        Dim anticipo_total As Decimal = 0
        Dim ajuste_total As Decimal = 0
        Dim solicitud_gastos As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        solicitud_gastos.RecuperaInfoTicketEmpresarial(id_solicitud, num_tarjeta_gastos, anticipo_total, ajuste_total)

        ajuste_total = Me.txtImporteRetiroTE.Value

        ' RM: DEBUG
        seguridad.GuardaLogDatos("TicketEmpresarialTransaccion: DEBUG: ModuloTicketEmpresarial:" & GlobalFunctions.ModuloTicketEmpresarial & ",  num_tarjeta_gastos:" & num_tarjeta_gastos & ",  anticipo_total:" & anticipo_total)

        If GlobalFunctions.ModuloTicketEmpresarial And num_tarjeta_gastos <> "" And ajuste_total > 0 Then
            Try
                Dim te As New TicketEmpresarial(GlobalFunctions.ClientIdTicketEmpresarial,
                                                GlobalFunctions.TokenTicketEmpresarial,
                                                GlobalFunctions.UserTicketEmpresarial,
                                                GlobalFunctions.PasswordTicketEmpresarial,
                                                System.Configuration.ConfigurationManager.AppSettings("CONEXION"))


                Dim te_trans As TicketEmpresarialTransaccion = te.AdjustBalance(num_tarjeta_gastos, ajuste_total)
                te_trans.id_solicitud = id_solicitud
                te_trans.id_usuario = id_empleado
                te.GuardaTransaccion(te_trans)

                If te_trans.exitoso = True Then
                    ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("Retiro realizado con éxito") & "');window.location.href='/SolicitudGastosImprimir.aspx?id=" & Me.txtIdSolicitud.Value & "';</script>", False)

                    'EnviarEmailAjusteTicketEmpresarial(te_trans, num_tarjeta_gastos, "E")
                    'EnviarEmailAjusteTicketEmpresarial(te_trans, num_tarjeta_gastos, "C")
                Else
                    ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & te_trans.error & "');window.location.href='/SolicitudGastosImprimir.aspx?id=" & Me.txtIdSolicitud.Value & "';</script>", False)

                    'EnviarEmailErrorTicketEmpresarial(te_trans)
                End If

            Catch ex As Exception
                seguridad.GuardaLogDatos("TicketEmpresarialTransaccion: id_solicitud:" & id_solicitud & "---->" & ex.Message)
            End Try
        End If

    End Sub

    Protected Sub btnCancelarRetiroTE_Click(sender As Object, e As EventArgs) Handles btnCancelarRetiroTE.Click
        Me.btnRealizarRetiroTE.Visible = True
        Me.tblRetiroTE.Visible = False
    End Sub

    Protected Sub btnRealizarRetiroTE_Click(sender As Object, e As EventArgs) Handles btnRealizarRetiroTE.Click
        Me.btnRealizarRetiroTE.Visible = False
        Me.tblRetiroTE.Visible = True
        Me.lblSaldoActualTE.Text = "0.00"



        Dim id_solicitud As Integer = Me.txtIdSolicitud.Value
        Dim id_empleado As Integer = Me.txtIdEmpleado.Value
        Dim num_tarjeta_gastos As String = ""
        Dim anticipo_total As Decimal = 0
        Dim ajuste_total As Decimal = 0
        Dim solicitud_gastos As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        solicitud_gastos.RecuperaInfoTicketEmpresarial(id_solicitud, num_tarjeta_gastos, anticipo_total, ajuste_total)


        Dim te As New TicketEmpresarial(GlobalFunctions.ClientIdTicketEmpresarial,
                                        GlobalFunctions.TokenTicketEmpresarial,
                                        GlobalFunctions.UserTicketEmpresarial,
                                        GlobalFunctions.PasswordTicketEmpresarial,
                                        System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        Me.lblSaldoActualTE.Text = te.CardGetListRequest(num_tarjeta_gastos).ToString("#,###,##0.00")


    End Sub

    Private Sub EnviarEmailAjusteTicketEmpresarial(ByVal te As TicketEmpresarialTransaccion, numero_tarjeta As String, tipo As String)
        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Dim id_solicitud As Integer = te.id_solicitud
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
            Dim dt As DataTable = solicitud_gasto.RecuperaInfoEmail(id_solicitud)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                email_smtp = System.Configuration.ConfigurationManager.AppSettings("SMTP_SERVER").ToString()
                email_usuario = System.Configuration.ConfigurationManager.AppSettings("SMTP_USER").ToString()
                email_password = System.Configuration.ConfigurationManager.AppSettings("SMTP_PASS").ToString()
                email_port = System.Configuration.ConfigurationManager.AppSettings("SMTP_PORT").ToString()
                email_de = System.Configuration.ConfigurationManager.AppSettings("SMTP_FROM").ToString()
                email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
                email_url_base_local = System.Configuration.ConfigurationManager.AppSettings("URL_BASE_LOCAL").ToString()

                If tipo = "E" Then
                    If dr("email_viaja").ToString.Length > 0 Then
                        email_para = dr("email_viaja")
                    Else
                        email_para = System.Configuration.ConfigurationManager.AppSettings("EMAIL_DEFAULT").ToString()
                    End If

                    If dr("email_solicita").ToString.Length > 0 Then
                        email_para += "," & dr("email_solicita")
                    End If
                Else
                    If dr("email_conta").ToString.Length > 0 Then
                        email_para += "," & dr("email_conta")
                    End If
                End If

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                Dim urlEmail As String = email_url_base_local & "/Email_Formatos/EnvioSolicitudGastoAjuste.aspx?id=" & id_solicitud & "&t=" & tipo
                email_asunto = TranslateLocale.text("Solicitud de Gastos - Ajuste de Tarjeta Realizado", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"

                email_body = RetrieveHttpContent(urlEmail, errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnviarEmailAjusteTicketEmpresarial: " & resultado & "::::" & email_para & "---->" & urlEmail)
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnviarEmailAjusteTicketEmpresarial: Error " & email_para & ", " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try

    End Sub

    Private Sub EnviarEmailErrorTicketEmpresarial(ByVal te As TicketEmpresarialTransaccion)
        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Dim id_solicitud As Integer = te.id_solicitud

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
            Dim dt As DataTable = solicitud_gasto.RecuperaInfoEmail(id_solicitud)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                email_smtp = System.Configuration.ConfigurationManager.AppSettings("SMTP_SERVER").ToString()
                email_usuario = System.Configuration.ConfigurationManager.AppSettings("SMTP_USER").ToString()
                email_password = System.Configuration.ConfigurationManager.AppSettings("SMTP_PASS").ToString()
                email_port = System.Configuration.ConfigurationManager.AppSettings("SMTP_PORT").ToString()
                email_de = System.Configuration.ConfigurationManager.AppSettings("SMTP_FROM").ToString()
                email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
                email_url_base_local = System.Configuration.ConfigurationManager.AppSettings("URL_BASE_LOCAL").ToString()


                email_para = GlobalFunctions.EmailTicketEmpresarial

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                Dim ticket_empresarial As String = ""
                If te.tipo_movimiento = "A" Then
                    ticket_empresarial = "Ocurrio un error al procesar una transaccion de TicketEmpresarial<br>Asignación de Saldo: " & te.importe.ToString("#,###,##0.00") & "<br>Error: " & te.error
                Else
                    ticket_empresarial = "Ocurrio un error al procesar una transaccion de TicketEmpresarial<br>Ajuste de Saldo: " & te.importe.ToString("#,###,##0.00") & "<br>Error: " & te.error
                End If

                Dim urlEmail = email_url_base_local & "/Email_Formatos/EnvioErrorTicketEmpresarial.aspx?id=" & id_solicitud & "&ticket_empresarial=" & ticket_empresarial
                email_asunto = TranslateLocale.text("Error en transacción de TicketEmpresarial", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                email_body = RetrieveHttpContent(urlEmail, errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioErrorTicketEmpresarial: " & resultado & "::::" & email_para & "---->" & urlEmail)
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioErrorTicketEmpresarial: Error " & email_para & ", " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try

    End Sub
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

End Class
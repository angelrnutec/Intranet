Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class SolicitudReposicionImprimir
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
        End If
        Me.lblPendienteAuth.Text = TranslateLocale.text(" (SOLICITUD PENDIENTE DE AUTORIZACIÓN)")
        Me.lblTotalConvertido.Text = TranslateLocale.text(Me.lblTotalConvertido.Text)
        Me.lblTotalGastos.Text = TranslateLocale.text(Me.lblTotalGastos.Text)
    End Sub

    Private Sub CargaDatos(id As Integer)
        Try
            Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = solicitud_reposicion.RecuperaPorIdDesc(id)

            If dt.Rows.Count > 0 Then

                Dim dr As DataRow = dt.Rows(0)

                Me.lblEmpresa.Text = dr("empresa")
                Me.lblSolicitante.Text = dr("solicitante")
                Me.lblDeudor.Text = dr("empleado_viaja")
                Me.lblFolio.Text = dr("folio_txt")
                Me.lblFechaSolicitud.Text = Format(dr("fecha_registro"), "dd/MM/yyyy")
                If Not IsDBNull(dr("fecha_envio_autorizacion")) Then
                    Me.lblFechaComprobacion.Text = Format(dr("fecha_envio_autorizacion"), "dd/MM/yyyy")
                End If

                Me.txtIdEmpresa.Value = dr("id_empresa")
                If Me.txtIdEmpresa.Value = 12 Then
                    Me.lblTotalConvertido.Text = Me.lblTotalConvertido.Text.Replace("MXP", "USD")
                    Me.lblTotalGastos.Text = Me.lblTotalGastos.Text.Replace("MXP", "USD")

                End If

                If IsDBNull(dr("fecha_comprobacion_jefe")) Then
                    Me.lblAutorizaJefe.Text = dr("jefe") & " " & TranslateLocale.text("(Pte)")
                Else
                    Me.lblAutorizaJefe.Text = dr("jefe") & " (" & IIf(dr("comprobacion_jefe"), TranslateLocale.text("Aut"), TranslateLocale.text("Rech")) & " - " & Format(dr("fecha_comprobacion_jefe"), "dd/MM/yyyy") & ")"
                End If

                If IsDBNull(dr("fecha_comprobacion_conta")) Then
                    Me.lblAutorizaConta.Text = dr("conta") & " (Pte)"
                Else
                    Me.lblAutorizaConta.Text = dr("conta") & " (" & IIf(dr("comprobacion_conta"), TranslateLocale.text("Aut"), TranslateLocale.text("Rech")) & " - " & Format(dr("fecha_comprobacion_conta"), "dd/MM/yyyy") & ")"
                End If


                Me.lblDepartamento.Text = dr("departamento")
                Me.lblComentarios.Text = dr("comentarios")


                If IsDBNull(dr("comprobacion_jefe")) = True Or
                     IsDBNull(dr("comprobacion_conta")) = True Then

                    Me.lblPendienteAuth.Visible = True
                End If

                Me.CargaConceptosGasto()
                If dr("id_solicitud_gastos") > 0 Then
                    Me.divSolicitudConMateriales.Visible = True
                    Me.lblFolioSolicitudGastos.Text = dr("folio_txt_solicitud_gastos")
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

    Dim _retMXP As Decimal = 0
    Dim _retUSD As Decimal = 0
    Dim _retEUR As Decimal = 0

    Dim _retResicoMXP As Decimal = 0
    Dim _retResicoUSD As Decimal = 0
    Dim _retResicoEUR As Decimal = 0

    Dim _propinaMXP As Decimal = 0
    Dim _propinaUSD As Decimal = 0
    Dim _propinaEUR As Decimal = 0

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
                _totalUSD += e.Row.Cells(14).Text
                _subtotalUSD += e.Row.Cells(7).Text
                _ivaUSD += e.Row.Cells(8).Text
                _otrosimpUSD += e.Row.Cells(9).Text
                _propinaUSD += e.Row.Cells(10).Text
                _retUSD += e.Row.Cells(11).Text
                _retResicoUSD += e.Row.Cells(12).Text
            ElseIf e.Row.Cells(6).Text = "EUR" Then
                _totalEUR += e.Row.Cells(14).Text
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
        Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim ds As DataSet = solicitud_reposicion.RecuperaConceptosDesc(Request.QueryString("id"), Funciones.CurrentLocale)
        Dim dtPoliza As DataTable = solicitud_reposicion.RecuperaPoliza(Request.QueryString("id"))
        Dim dtTablaResumen As DataTable = solicitud_reposicion.RecuperaTablaResumen(Request.QueryString("id"))

        Me.gvConceptos.DataSource = ds.Tables(0)
        Funciones.TranslateGridviewHeader(gvConceptos)
        Me.gvConceptos.EmptyDataText = TranslateLocale.text("Favor de agregar tus comprobantes")
        Me.gvConceptos.DataBind()


        If ds.Tables(0).Rows.Count = 0 Then
            Me.oculta1.Visible = False
            ''Me.oculta2.Visible = False
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

        End If

        Dim strResumenFormaPago As String = ""
        For Each dr As DataRow In dtTablaResumen.Rows
            '            strResumenFormaPago &= "<tr><td>" & dr("forma_pago").ToString() & "</td><td align='right'>" & Convert.ToDecimal(dr("total").ToString()).ToString("#,###,##0.00") & "</td><td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>"
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



    End Sub

End Class
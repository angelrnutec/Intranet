Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class EnvioSolicitudGastoAjuste
    Inherits System.Web.UI.Page

    Public EMAIL_LOCALE As String = "es"
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            If Not Request.QueryString("id") Is Nothing Then
                Me.lblId.Text = Request.QueryString("id")
                Me.lblTipo.Text = Request.QueryString("t")
                Me.CargaFormulario()
            End If

        End If
    End Sub

    Private Sub CargaFormulario()
        Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Dim url_base As String = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()

        Dim dt As DataTable = solicitud_gasto.RecuperaEmail(Convert.ToInt32(Me.lblId.Text))

        If dt.Rows.Count > 0 Then
            Dim dr As DataRow = dt.Rows(0)
            If dr("id_empresa") = 12 Then
                EMAIL_LOCALE = "en"
            End If

            txtIdEmpresa.Value = dr("id_empresa")


            lblTitulo.Text = TranslateLocale.text("Ajuste de Saldo Realizado", EMAIL_LOCALE)

            If Me.lblTipo.Text = "E" Then
                lblNombre.Text = dr("empleado_viaja").ToString()
            Else
                lblNombre.Text = dr("autoriza_conta").ToString()
            End If

            lblFolio.Text = dr("folio_txt").ToString()
            lblEmpleadoSolicita.Text = dr("empleado_solicita").ToString()
            lblEmpleadoViaja.Text = dr("empleado_viaja").ToString()
            lblAutorizaJefe.Text = dr("autoriza_jefe").ToString()
            lblAutorizaConta.Text = dr("autoriza_conta").ToString()
            lblEmpresa.Text = dr("empresa").ToString()
            lblDepartamento.Text = dr("departamento").ToString()
            lblDestino.Text = dr("destino").ToString()
            lblMotivo.Text = dr("motivo").ToString()
            lblEstatus.Text = TranslateLocale.text(dr("estatus").ToString(), EMAIL_LOCALE)
            lblFechaInicio.Text = Convert.ToDateTime(dr("fecha_ini").ToString()).ToString("dd/MM/yyyy")
            lblFechaFin.Text = Convert.ToDateTime(dr("fecha_fin").ToString()).ToString("dd/MM/yyyy")
            lblMontoPesos.Text = Convert.ToDecimal(dr("monto_pesos").ToString()).ToString("$ ###,##0.00")
            lblMontoDolares.Text = Convert.ToDecimal(dr("monto_dolares").ToString()).ToString("$ ###,##0.00")
            lblMontoEuro.Text = Convert.ToDecimal(dr("monto_euros").ToString()).ToString("$ ###,##0.00")


            Me.CargaConceptos()
        End If
    End Sub

    Protected Sub CargaConceptos()
        Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim ds As DataSet = solicitud_gasto.RecuperaConceptos(Me.lblId.Text, EMAIL_LOCALE)
        Dim dt As DataTable = ds.Tables(0)

        If dt.Rows.Count > 0 Then
            Me.gvConceptos.DataSource = dt
            Funciones.TranslateGridviewHeader(gvConceptos, EMAIL_LOCALE)
            Me.gvConceptos.DataBind()
            Me.divDetalleCombrobantes.Visible = True

            If Not Request.QueryString("r") = "1" Then
                Me.divSaldos.Visible = True

                Dim dtSaldo As DataTable = solicitud_gasto.RecuperaSaldo(Me.lblId.Text)
                If dtSaldo.Rows.Count > 0 Then
                    Me.lblSaldoAnticipo.Text = Format(dtSaldo.Rows(0)("anticipo"), "###,###,##0.00")
                    Me.lblSaldoViaticos.Text = Format(dtSaldo.Rows(0)("viaticos"), "###,###,##0.00")
                    Me.lblSaldoMateriales.Text = Format(dtSaldo.Rows(0)("materiales"), "###,###,##0.00")
                    Me.lblSaldoAjustado.Text = Format(dtSaldo.Rows(0)("ajustado"), "###,###,##0.00")
                    Me.lblSaldoSaldo.Text = Format(dtSaldo.Rows(0)("diferencia"), "###,###,##0.00")
                    If dtSaldo.Rows(0)("diferencia") > 0 Then
                        Me.lblSaldoTexto.Text = TranslateLocale.text("Saldo a Favor", EMAIL_LOCALE)
                    ElseIf dtSaldo.Rows(0)("diferencia") < 0 Then
                        Me.lblSaldoTexto.Text = TranslateLocale.text("Saldo a Cargo", EMAIL_LOCALE)
                    Else
                        Me.lblSaldoTexto.Text = TranslateLocale.text("Saldo", EMAIL_LOCALE)
                    End If
                End If
            End If
        Else
            Me.divDetalleCombrobantes.Visible = False
        End If
    End Sub

    Private Sub gvConceptos_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvConceptos.RowDataBound

        If e.Row.RowType = DataControlRowType.Header Then
            If Me.txtIdEmpresa.Value = 12 Then
                e.Row.Cells(9).Text = "Total USD"
            End If
        End If

    End Sub


End Class
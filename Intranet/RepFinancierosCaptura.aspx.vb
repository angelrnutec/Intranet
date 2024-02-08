Imports IntranetBL
Imports Intranet.LocalizationIntranet
Imports System.Drawing

Public Class RepFinancierosCaptura
    Inherits System.Web.UI.Page

    ''Public EMPRESAS_FIBRA_EXTENDIDO As New List(Of Integer)(New Integer() {7, 8, 9, 10, 12})
    Public EMPRESAS_FIBRA_EXTENDIDO As String() = New String() {"1", "7", "8", "9", "10", "12", "13"}

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.CargaCombos()
            Me.btnContinuar.Attributes.Add("onclick", "this.disabled='true';")
            Me.btnContinuar.Attributes.Add("onload", "this.disabled='false';")

            If Not Request.QueryString("r") Is Nothing Then
                Me.CargaDatos()
            End If

            Me.btnActualizar.Text = TranslateLocale.text(Me.btnActualizar.Text)
            Me.btnCancelar.Text = TranslateLocale.text(Me.btnCancelar.Text)
            Me.btnContinuar.Text = TranslateLocale.text(Me.btnContinuar.Text)
            Me.lblTituloInterRef.Text = TranslateLocale.text(Me.lblTituloInterRef.Text)
        End If
    End Sub

    Protected Function PerfilDeuda_Totales(id_empresa As Integer) As String
        Dim dt As DataTable = CType(ViewState("dtConceptos"), DataTable)
        Dim total As String = ""
        If dt.Rows.Count > 0 Then
            For Each dr As DataRow In dt.Rows
                total = dr("id")
            Next
        End If
        Return total & "," & total
    End Function

    Protected Function PerfilDeuda_Suman(id_empresa As Integer) As String
        Dim dt As DataTable = CType(ViewState("dtConceptos"), DataTable)
        Dim total As String = ""
        For Each dr As DataRow In dt.Rows
            If dr("permite_captura") = True Then
                total &= dr("id") & ","
            End If
        Next
        If total.Length > 0 Then total = total.Substring(0, total.Length - 1)
        Return total
    End Function

    Protected Function PerfilDeuda_FilaTotales(id_empresa As Integer) As String
        Dim dt As DataTable = CType(ViewState("dtConceptos"), DataTable)
        Dim total As String = ""
        For Each dr As DataRow In dt.Rows
            total = dr("id")
        Next
        Return total
    End Function

    Private Sub CargaCombos()
        Try
            For i As Integer = Now.AddMonths(1).Year To 2012 Step -1
                Me.ddlAnio.Items.Add(i)
            Next

            Dim items As New List(Of ListItem)
            items.Add(New ListItem(TranslateLocale.text("Enero"), "1"))
            items.Add(New ListItem(TranslateLocale.text("Febrero"), "2"))
            items.Add(New ListItem(TranslateLocale.text("Marzo"), "3"))
            items.Add(New ListItem(TranslateLocale.text("Abril"), "4"))
            items.Add(New ListItem(TranslateLocale.text("Mayo"), "5"))
            items.Add(New ListItem(TranslateLocale.text("Junio"), "6"))
            items.Add(New ListItem(TranslateLocale.text("Julio"), "7"))
            items.Add(New ListItem(TranslateLocale.text("Agosto"), "8"))
            items.Add(New ListItem(TranslateLocale.text("Septiembre"), "9"))
            items.Add(New ListItem(TranslateLocale.text("Octubre"), "10"))
            items.Add(New ListItem(TranslateLocale.text("Noviembre"), "11"))
            items.Add(New ListItem(TranslateLocale.text("Diciembre"), "12"))
            Me.ddlMes.Items.AddRange(items.ToArray)

            Me.ddlAnio.SelectedValue = Now.Year
            Me.ddlMes.SelectedValue = Now.Month


            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Me.ddlEmpresa.Items.Clear()
            Me.ddlEmpresa.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpresas(), "nombre", "id_empresa"))

            Me.ddlReporte.Items.Clear()
            Me.ddlReporte.Items.AddRange(Funciones.DatatableToList(combos.RecuperaReportes(1), "nombre", "id_reporte"))

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub

    Private Sub CargaDatos()
        Me.ddlReporte.SelectedValue = Request.QueryString("r")
        Me.ddlEmpresa.SelectedValue = Request.QueryString("e")
        Me.ddlAnio.SelectedValue = Request.QueryString("a")
        Me.ddlMes.SelectedValue = Request.QueryString("m")
        Me.CargaGridCaptura()
    End Sub

    Private Sub CargaGridCaptura()

        Me.ValidaSeleccionReporte()
        Me.txtEstado.Text = "1"
        Me.btnContinuar.Text = TranslateLocale.text("Guardar")
        Me.btnCancelar.Text = TranslateLocale.text("Cancelar")
        Me.divCaptura.Visible = True

        Me.ddlEmpresa.Enabled = False
        Me.ddlReporte.Enabled = False
        Me.ddlAnio.Enabled = False
        Me.ddlMes.Enabled = False
        Me.btnActualizar.Visible = True

        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dtDatos As DataSet = reporte.RecuperaDatos(Me.ddlReporte.SelectedValue,
                                                          IIf(Me.ddlEmpresa.SelectedValue = 0, -1, Me.ddlEmpresa.SelectedValue),
                                                          Me.ddlAnio.SelectedValue,
                                                          Me.ddlMes.SelectedValue)


        Dim estatus As String = dtDatos.Tables(2).Rows(0)("estatus")

        Me.txtEstatus.Text = estatus
        Me.txtAlertaActualizacion.Value = dtDatos.Tables(2).Rows(0)("alerta_actualizacion")

        Funciones.TranslateTableData(dtDatos.Tables(0), {"descripcion"})

        If ddlReporte.SelectedValue = 5 Then
            Me.gvCaptura.Visible = False
            Me.gvCapturaExtendido.Visible = False
            Me.gvCapturaflujo.Visible = True
            Me.gvCapturaDecimales.Visible = False
            Me.gvCapturaCuadreInter.Visible = False
            Me.gvCapturaCuadreInterV2.Visible = False
            Me.tblHeadersGrid.Visible = False
            Me.gvCapturaCuadreInterRef.Visible = False
            Me.gvCapturaCuadreInterRefV2.Visible = False
            Me.divComentarios.Visible = True

            If dtDatos.Tables(1).Rows.Count > 0 Then
                Me.txtComentarios.Text = dtDatos.Tables(1).Rows(0)("comentarios")
            End If

            Me.gvCapturaflujo.DataSource = dtDatos.Tables(0)
            Funciones.TranslateGridviewHeader(Me.gvCapturaflujo)
            Me.gvCapturaflujo.DataBind()
        ElseIf ddlReporte.SelectedValue = 7 Then
            Dim dtDatosExtra As DataTable = reporte.RecuperaDatosExtra(Me.ddlReporte.SelectedValue,
                                                  IIf(Me.ddlEmpresa.SelectedValue = 0, -1, Me.ddlEmpresa.SelectedValue),
                                                  Me.ddlAnio.SelectedValue,
                                                  Me.ddlMes.SelectedValue).Tables(0)

            If dtDatosExtra.Rows.Count > 0 Then
                Dim deuda_total_balance_general As Decimal = dtDatosExtra.Rows(0)("deuda_total_balance_general")
                If deuda_total_balance_general > 0 Then
                    Me.lblPD_DeudaBalanceGeneral.Text = deuda_total_balance_general.ToString("#,###,###")
                    Me.divDatosPerfilDeuda.Visible = True
                End If
            End If


            Me.gvCaptura.Visible = False
            Me.gvCapturaExtendido.Visible = False
            Me.gvCapturaDeuda.Visible = True
            Me.gvCapturaDecimales.Visible = False
            Me.gvCapturaCuadreInter.Visible = False
            Me.gvCapturaCuadreInterV2.Visible = False
            Me.tblHeadersGrid.Visible = False
            Me.gvCapturaCuadreInterRef.Visible = False
            Me.gvCapturaCuadreInterRefV2.Visible = False

            Me.gvCapturaDeuda.Columns(2).HeaderText = Me.ddlAnio.SelectedValue
            Me.gvCapturaDeuda.Columns(3).HeaderText = Me.ddlAnio.SelectedValue + 1
            Me.gvCapturaDeuda.Columns(4).HeaderText = Me.ddlAnio.SelectedValue + 2
            Me.gvCapturaDeuda.Columns(5).HeaderText = Me.ddlAnio.SelectedValue + 3
            Me.gvCapturaDeuda.Columns(6).HeaderText = Me.ddlAnio.SelectedValue + 4

            Me.gvCapturaDeuda.Columns(7).HeaderText = Me.ddlAnio.SelectedValue + 5
            Me.gvCapturaDeuda.Columns(8).HeaderText = Me.ddlAnio.SelectedValue + 6
            Me.gvCapturaDeuda.Columns(9).HeaderText = Me.ddlAnio.SelectedValue + 7
            Me.gvCapturaDeuda.Columns(10).HeaderText = Me.ddlAnio.SelectedValue + 8
            Me.gvCapturaDeuda.Columns(11).HeaderText = Me.ddlAnio.SelectedValue + 9

            ViewState("dtConceptos") = dtDatos.Tables(0)
            Me.gvCapturaDeuda.DataSource = dtDatos.Tables(0)
            Funciones.TranslateGridviewHeader(Me.gvCapturaDeuda)
            Me.gvCapturaDeuda.DataBind()

        ElseIf ddlReporte.SelectedValue = 8 Then
            Me.gvCaptura.Visible = False
            Me.gvCapturaExtendido.Visible = False
            Me.gvCapturaDeuda.Visible = False
            Me.gvCapturaDecimales.Visible = True
            Me.gvCapturaCuadreInter.Visible = False
            Me.tblHeadersGrid.Visible = False
            Me.gvCapturaCuadreInterRef.Visible = False

            Me.gvCapturaCuadreInterV2.Visible = False
            Me.gvCapturaCuadreInterRefV2.Visible = False


            Me.gvCapturaDecimales.DataSource = dtDatos.Tables(0)
            Funciones.TranslateGridviewHeader(Me.gvCapturaDecimales)
            Me.gvCapturaDecimales.DataBind()
        ElseIf ddlReporte.SelectedValue = 3 Or ddlReporte.SelectedValue = 1014 Then
            Me.divComentarios.Visible = False
            Me.divDatosFlujoEfectivo.Visible = True

            If dtDatos.Tables.Count > 3 Then
                Me.lblFE_SaldoCaja.Text = Format(dtDatos.Tables(3).Rows(0)("saldo_caja"), "#,###,##0")
                Me.lblFE_UtilidadNeta.Text = Format(dtDatos.Tables(3).Rows(0)("utilidad_neta"), "#,###,##0")
            End If

            Me.gvCaptura.DataSource = dtDatos.Tables(0)
            Funciones.TranslateGridviewHeader(Me.gvCaptura)
            Me.gvCaptura.DataBind()
        ElseIf ddlReporte.SelectedValue = 10 Then 'Intercompañias v1
            Me.gvCaptura.Visible = False
            Me.gvCapturaExtendido.Visible = False
            Me.gvCapturaDeuda.Visible = False
            Me.gvCapturaDecimales.Visible = False
            Me.gvCapturaCuadreInter.Visible = True
            Me.gvCapturaCuadreInterV2.Visible = False
            Me.gvCapturaCuadreInterRef.Visible = True
            Me.gvCapturaCuadreInterRefV2.Visible = False
            Me.lblTituloInterRef.Visible = True
            Me.tblHeadersGrid.Visible = False

            Me.divComentarios.Visible = False

            Me.gvCapturaCuadreInter.DataSource = dtDatos.Tables(0)
            Funciones.TranslateGridviewHeader(Me.gvCapturaCuadreInter)
            Me.gvCapturaCuadreInter.DataBind()

            Me.gvCapturaCuadreInterRef.DataSource = dtDatos.Tables(3)
            Funciones.TranslateGridviewHeader(Me.gvCapturaCuadreInterRef)
            Me.gvCapturaCuadreInterRef.DataBind()
        ElseIf ddlReporte.SelectedValue = 1015 Then 'Intercompañias v2
            Me.gvCaptura.Visible = False
            Me.gvCapturaExtendido.Visible = False
            Me.gvCapturaDeuda.Visible = False
            Me.gvCapturaDecimales.Visible = False
            Me.gvCapturaCuadreInter.Visible = False
            Me.gvCapturaCuadreInterV2.Visible = True
            Me.tblHeadersGrid.Visible = True
            Me.gvCapturaCuadreInterRef.Visible = False
            Me.gvCapturaCuadreInterRefV2.Visible = True
            Me.lblTituloInterRef.Visible = True

            Me.divComentarios.Visible = False

            Me.gvCapturaCuadreInterV2.DataSource = dtDatos.Tables(0)
            Funciones.TranslateGridviewHeader(Me.gvCapturaCuadreInterV2)
            Me.gvCapturaCuadreInterV2.DataBind()

            Me.gvCapturaCuadreInterRefV2.DataSource = dtDatos.Tables(3)
            Funciones.TranslateGridviewHeader(Me.gvCapturaCuadreInterRefV2)
            Me.gvCapturaCuadreInterRefV2.DataBind()

        ElseIf (ddlReporte.SelectedValue = 2 Or ddlReporte.SelectedValue = 22 Or ddlReporte.SelectedValue = 32 Or ddlReporte.SelectedValue = 4) And Array.IndexOf(EMPRESAS_FIBRA_EXTENDIDO, ddlEmpresa.SelectedValue) >= 0 Then
            Me.divComentarios.Visible = False

            Me.gvCapturaExtendido.DataSource = dtDatos.Tables(0)
            Funciones.TranslateGridviewHeader(Me.gvCapturaExtendido)
            Me.gvCapturaExtendido.DataBind()

        Else
            Me.divComentarios.Visible = False

            Me.gvCaptura.DataSource = dtDatos.Tables(0)
            Funciones.TranslateGridviewHeader(Me.gvCaptura)
            Me.gvCaptura.DataBind()
        End If

        If ddlReporte.SelectedValue = 4 Then
            Me.divLeyenda_PedidosyFacturacion.Visible = True
        End If

        If txtEstatus.Text = "C" Then
            Me.txtEstado.Text = "0"
            Me.btnContinuar.Enabled = False
            Me.btnCancelar.Text = TranslateLocale.text("Salir")
            Me.btnActualizar.Enabled = False
            Me.lblMensajeEstatus.Visible = True
            Me.lblMensajeEstatus.Text = TranslateLocale.text("El perido seleccionado esta cerrado y no se puede modificar")
            Me.txtComentarios.Enabled = False
            Me.gvCaptura.Enabled = False
            Me.gvCapturaflujo.Enabled = False
        Else
            Me.lblMensajeEstatus.Visible = False
            Me.gvCaptura.Enabled = True
            Me.gvCapturaflujo.Enabled = True
        End If

    End Sub

    Private Sub btnContinuar_Click(sender As Object, e As EventArgs) Handles btnContinuar.Click
        Try
            If Me.txtEstado.Text = "0" Then  ''Iniciando la captura
                Me.CargaGridCaptura()
            Else ''Guarda la captura
                Me.GuardaCaptura()
                If Me.txtAlertaActualizacion.Value <> "" Then
                    ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & Me.txtAlertaActualizacion.Value & "');window.location='/RepFinancierosCapturaOK.aspx';</script>", False)
                Else
                    Me.Response.Redirect("/RepFinancierosCapturaOK.aspx")
                End If
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    Private Sub GuardaCaptura()
        Try
            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim listaDatos As New ArrayList()
            Dim tipoReporte As Integer = 1
            If Me.ddlReporte.SelectedValue = 5 Then
                tipoReporte = 2
                For Each row As GridViewRow In gvCapturaflujo.Rows
                    Dim txtIdConcepto As TextBox = CType(row.FindControl("txtIdConcepto"), TextBox)
                    Dim txtImporte1 As TextBox = CType(row.FindControl("txtImporte1"), TextBox)
                    Dim txtImporte2 As TextBox = CType(row.FindControl("txtImporte2"), TextBox)
                    Dim txtImporte3 As TextBox = CType(row.FindControl("txtImporte3"), TextBox)
                    Dim txtImporte4 As TextBox = CType(row.FindControl("txtImporte4"), TextBox)
                    Dim txtImporte5 As TextBox = CType(row.FindControl("txtImporte5"), TextBox)
                    Dim txtImporte0 As TextBox = CType(row.FindControl("txtImporte0"), TextBox)

                    listaDatos.Add(New ReporteDatos(tipoReporte, txtIdConcepto.Text,
                                                    IIf(IsNumeric(txtImporte1.Text), txtImporte1.Text, 0),
                                                    IIf(IsNumeric(txtImporte2.Text), txtImporte2.Text, 0),
                                                    IIf(IsNumeric(txtImporte3.Text), txtImporte3.Text, 0),
                                                    IIf(IsNumeric(txtImporte4.Text), txtImporte4.Text, 0),
                                                    IIf(IsNumeric(txtImporte5.Text), txtImporte5.Text, 0),
                                                    0,
                                                    IIf(IsNumeric(txtImporte0.Text), txtImporte0.Text, 0)))
                Next
            ElseIf Me.ddlReporte.SelectedValue = 7 Then
                Dim valor_esperado As Integer = Replace(Me.lblPD_DeudaBalanceGeneral.Text, ",", "")
                Dim valor_total_sin_intereses As Integer = 0


                tipoReporte = 4
                For Each row As GridViewRow In gvCapturaDeuda.Rows
                    Dim txtIdConcepto As TextBox = CType(row.FindControl("txtIdConcepto"), TextBox)
                    Dim txtImporte1 As TextBox = CType(row.FindControl("txtImporte01"), TextBox)
                    Dim txtImporte2 As TextBox = CType(row.FindControl("txtImporte02"), TextBox)
                    Dim txtImporte3 As TextBox = CType(row.FindControl("txtImporte03"), TextBox)
                    Dim txtImporte4 As TextBox = CType(row.FindControl("txtImporte04"), TextBox)
                    Dim txtImporte5 As TextBox = CType(row.FindControl("txtImporte05"), TextBox)
                    Dim txtImporte6 As TextBox = CType(row.FindControl("txtImporte06"), TextBox)

                    Dim txtImporte7 As TextBox = CType(row.FindControl("txtImporte07"), TextBox)
                    Dim txtImporte8 As TextBox = CType(row.FindControl("txtImporte08"), TextBox)
                    Dim txtImporte9 As TextBox = CType(row.FindControl("txtImporte09"), TextBox)
                    Dim txtImporte10 As TextBox = CType(row.FindControl("txtImporte10"), TextBox)

                    Dim txtImporte11 As TextBox = CType(row.FindControl("txtImporte11"), TextBox)

                    listaDatos.Add(New ReporteDatos(tipoReporte, txtIdConcepto.Text,
                                                    IIf(IsNumeric(txtImporte1.Text), txtImporte1.Text, 0),
                                                    IIf(IsNumeric(txtImporte2.Text), txtImporte2.Text, 0),
                                                    IIf(IsNumeric(txtImporte3.Text), txtImporte3.Text, 0),
                                                    IIf(IsNumeric(txtImporte4.Text), txtImporte4.Text, 0),
                                                    IIf(IsNumeric(txtImporte5.Text), txtImporte5.Text, 0),
                                                    IIf(IsNumeric(txtImporte6.Text), txtImporte6.Text, 0),
                                                    IIf(IsNumeric(txtImporte7.Text), txtImporte7.Text, 0),
                                                    IIf(IsNumeric(txtImporte8.Text), txtImporte8.Text, 0),
                                                    IIf(IsNumeric(txtImporte9.Text), txtImporte9.Text, 0),
                                                    IIf(IsNumeric(txtImporte10.Text), txtImporte10.Text, 0),
                                                    IIf(IsNumeric(txtImporte11.Text), txtImporte11.Text, 0),
                                                    0))


                    If row.RowType = DataControlRowType.DataRow Then
                        Dim txtPermiteCaptura As TextBox = CType(row.FindControl("txtPermiteCaptura"), TextBox)
                        Dim txtEsSeparador As TextBox = CType(row.FindControl("txtEsSeparador"), TextBox)
                        Dim txtReferencia2 As TextBox = CType(row.FindControl("txtReferencia2"), TextBox)
                        If txtPermiteCaptura.Text = "True" And txtEsSeparador.Text = "False" And txtReferencia2.Text = "C" Then

                            'valor_total_sin_intereses += Integer.Parse(IIf(IsNumeric(txtImporte1.Text), txtImporte1.Text, 0)) + Integer.Parse(IIf(IsNumeric(txtImporte2.Text), txtImporte2.Text, 0)) _
                            '             + Integer.Parse(IIf(IsNumeric(txtImporte3.Text), txtImporte3.Text, 0)) + Integer.Parse(IIf(IsNumeric(txtImporte4.Text), txtImporte4.Text, 0)) _
                            '             + Integer.Parse(IIf(IsNumeric(txtImporte5.Text), txtImporte5.Text, 0)) + Integer.Parse(IIf(IsNumeric(txtImporte6.Text), txtImporte6.Text, 0)) _
                            '             + Integer.Parse(IIf(IsNumeric(txtImporte7.Text), txtImporte7.Text, 0)) + Integer.Parse(IIf(IsNumeric(txtImporte8.Text), txtImporte8.Text, 0)) _
                            '             + Integer.Parse(IIf(IsNumeric(txtImporte9.Text), txtImporte9.Text, 0)) + Integer.Parse(IIf(IsNumeric(txtImporte10.Text), txtImporte10.Text, 0))

                            valor_total_sin_intereses += Integer.Parse(IIf(IsNumeric(txtImporte1.Text), txtImporte1.Text, 0)) + Integer.Parse(IIf(IsNumeric(txtImporte2.Text), txtImporte2.Text, 0)) _
                                         + Integer.Parse(IIf(IsNumeric(txtImporte3.Text), txtImporte3.Text, 0)) + Integer.Parse(IIf(IsNumeric(txtImporte4.Text), txtImporte4.Text, 0)) _
                                         + Integer.Parse(IIf(IsNumeric(txtImporte5.Text), txtImporte5.Text, 0)) _
                                         + Integer.Parse(IIf(IsNumeric(txtImporte7.Text), txtImporte7.Text, 0)) + Integer.Parse(IIf(IsNumeric(txtImporte8.Text), txtImporte8.Text, 0)) _
                                         + Integer.Parse(IIf(IsNumeric(txtImporte9.Text), txtImporte9.Text, 0)) + Integer.Parse(IIf(IsNumeric(txtImporte10.Text), txtImporte10.Text, 0)) _
                                         + Integer.Parse(IIf(IsNumeric(txtImporte11.Text), txtImporte11.Text, 0))

                        End If
                    End If


                Next

                If valor_esperado <> valor_total_sin_intereses Then
                    Throw New Exception("Las cantidades reportadas en Perfil de Deuda y Balance General son diferentes, favor de corregir. (Esperado: " & valor_esperado.ToString("#,###,###") & " vs. Capturado: " & valor_total_sin_intereses.ToString("#,###,###") & ")")
                End If

            ElseIf Me.ddlReporte.SelectedValue = 10 Then
                tipoReporte = 4
                For Each row As GridViewRow In gvCapturaCuadreInter.Rows
                    Dim txtIdConcepto As TextBox = CType(row.FindControl("txtIdConcepto"), TextBox)
                    Dim txtImporte1 As TextBox = CType(row.FindControl("txtImporte01"), TextBox)
                    Dim txtImporte2 As TextBox = CType(row.FindControl("txtImporte02"), TextBox)
                    Dim txtImporte3 As TextBox = CType(row.FindControl("txtImporte03"), TextBox)
                    Dim txtImporte4 As TextBox = CType(row.FindControl("txtImporte04"), TextBox)

                    If txtIdConcepto.Text <> "" Then
                        listaDatos.Add(New ReporteDatos(tipoReporte, txtIdConcepto.Text,
                                                IIf(IsNumeric(txtImporte1.Text), txtImporte1.Text, 0),
                                                IIf(IsNumeric(txtImporte2.Text), txtImporte2.Text, 0),
                                                IIf(IsNumeric(txtImporte3.Text), txtImporte3.Text, 0),
                                                IIf(IsNumeric(txtImporte4.Text), txtImporte4.Text, 0),
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                0))

                    End If

                Next
            ElseIf Me.ddlReporte.SelectedValue = 1015 Then
                tipoReporte = 4
                For Each row As GridViewRow In gvCapturaCuadreInterV2.Rows
                    Dim txtIdConcepto As TextBox = CType(row.FindControl("txtIdConcepto"), TextBox)
                    Dim txtImporte1 As TextBox = CType(row.FindControl("txtImporte01"), TextBox)
                    Dim txtImporte2 As TextBox = CType(row.FindControl("txtImporte02"), TextBox)
                    Dim txtImporte3 As TextBox = CType(row.FindControl("txtImporte03"), TextBox)
                    Dim txtImporte4 As TextBox = CType(row.FindControl("txtImporte04"), TextBox)

                    If txtIdConcepto.Text <> "" Then
                        listaDatos.Add(New ReporteDatos(tipoReporte, txtIdConcepto.Text,
                                                IIf(IsNumeric(txtImporte1.Text), txtImporte1.Text, 0),
                                                IIf(IsNumeric(txtImporte2.Text), txtImporte2.Text, 0),
                                                IIf(IsNumeric(txtImporte3.Text), txtImporte3.Text, 0),
                                                IIf(IsNumeric(txtImporte4.Text), txtImporte4.Text, 0),
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                0))

                    End If

                Next
            ElseIf Me.ddlReporte.SelectedValue = 8 Then
                For Each row As GridViewRow In gvCapturaDecimales.Rows()
                    Dim txtImporte As TextBox = CType(row.FindControl("txtImporte"), TextBox)
                    Dim txtIdConcepto As TextBox = CType(row.FindControl("txtIdConcepto"), TextBox)

                    listaDatos.Add(New ReporteDatos(tipoReporte, txtIdConcepto.Text, IIf(IsNumeric(txtImporte.Text), txtImporte.Text, 0)))
                Next
            ElseIf (ddlReporte.SelectedValue = 2 Or ddlReporte.SelectedValue = 22 Or ddlReporte.SelectedValue = 32 Or ddlReporte.SelectedValue = 4) And Array.IndexOf(EMPRESAS_FIBRA_EXTENDIDO, ddlEmpresa.SelectedValue) >= 0 Then
                tipoReporte = 5
                For Each row As GridViewRow In gvCapturaExtendido.Rows
                    Dim txtIdConcepto As TextBox = CType(row.FindControl("txtIdConcepto"), TextBox)
                    Dim txtImporte1 As TextBox = CType(row.FindControl("txtImporte01"), TextBox)
                    Dim txtImporte2 As TextBox = CType(row.FindControl("txtImporte02"), TextBox)
                    Dim txtImporte3 As TextBox = CType(row.FindControl("txtImporte03"), TextBox)
                    Dim txtImporte4 As TextBox = CType(row.FindControl("txtImporte04"), TextBox)

                    listaDatos.Add(New ReporteDatos(tipoReporte, txtIdConcepto.Text,
                                                IIf(IsNumeric(txtImporte1.Text), txtImporte1.Text, 0),
                                                IIf(IsNumeric(txtImporte2.Text), txtImporte2.Text, 0),
                                                IIf(IsNumeric(txtImporte3.Text), txtImporte3.Text, 0),
                                                IIf(IsNumeric(txtImporte4.Text), txtImporte4.Text, 0),
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                0,
                                                0))
                Next
            Else
                For Each row As GridViewRow In gvCaptura.Rows
                    Dim txtImporte As TextBox = CType(row.FindControl("txtImporte"), TextBox)
                    Dim txtIdConcepto As TextBox = CType(row.FindControl("txtIdConcepto"), TextBox)

                    listaDatos.Add(New ReporteDatos(tipoReporte, txtIdConcepto.Text, IIf(IsNumeric(txtImporte.Text), txtImporte.Text, 0)))
                Next
            End If

            reporte.GuardaDatos(listaDatos, _
                                tipoReporte, _
                                Me.ddlEmpresa.SelectedValue, _
                                Me.ddlReporte.SelectedValue, _
                                Me.ddlAnio.SelectedValue, _
                                Me.ddlMes.SelectedValue, _
                                Session("idEmpleado"), _
                                Me.txtComentarios.Text)

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub ValidaSeleccionReporte()
        Dim msg As String = ""
        Dim validacion As String = ""

        If Me.ddlReporte.SelectedValue = 0 Then msg &= " - Reporte\n"
        If Me.ddlReporte.SelectedValue <> 8 Then
            If Me.ddlEmpresa.SelectedValue = 0 Then msg &= " - Empresa\n"


            If msg.Length = 0 Then
                Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                validacion = reporte.ValidaCapturaReporte(Me.ddlReporte.SelectedValue, Me.ddlEmpresa.SelectedValue, Me.ddlAnio.SelectedValue, Me.ddlMes.SelectedValue)
            End If
        End If

        If msg.Length > 0 Then
            Throw New Exception(TranslateLocale.text("Favor de capturar la siguiente información") & ":\n" & msg)
        ElseIf validacion.Length > 0 Then
            Throw New Exception(validacion)
        End If

    End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        If Me.txtEstado.Text = "0" Then  ''Iniciando la captura
            Response.Redirect("/")
        Else
            Response.Redirect("/RepFinancierosCaptura.aspx")
        End If
    End Sub

    Private Sub gvCaptura_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCaptura.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim txtPermiteCaptura As TextBox = CType(e.Row.FindControl("txtPermiteCaptura"), TextBox)
            Dim txtEsSeparador As TextBox = CType(e.Row.FindControl("txtEsSeparador"), TextBox)
            Dim txtAutollenado As TextBox = CType(e.Row.FindControl("txtAutollenado"), TextBox)
            If txtPermiteCaptura.Text = "False" Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
            If txtEsSeparador.Text = "True" Then
                e.Row.BackColor = Drawing.Color.Gray
                e.Row.ForeColor = Drawing.Color.White
            End If
            If txtAutollenado.Text = "True" Then
                CType(e.Row.FindControl("txtImporte"), TextBox).Enabled = False
            End If

        End If
    End Sub

    Private Sub gvCapturaExtendido_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCapturaExtendido.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim txtPermiteCaptura As TextBox = CType(e.Row.FindControl("txtPermiteCaptura"), TextBox)
            Dim txtEsSeparador As TextBox = CType(e.Row.FindControl("txtEsSeparador"), TextBox)
            Dim txtAutollenado As TextBox = CType(e.Row.FindControl("txtAutollenado"), TextBox)
            If txtPermiteCaptura.Text = "False" Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
            If txtEsSeparador.Text = "True" Then
                e.Row.BackColor = Drawing.Color.Gray
                e.Row.ForeColor = Drawing.Color.White
            End If
            If txtAutollenado.Text = "True" Then
                CType(e.Row.FindControl("txtImporte01"), TextBox).Enabled = False
                CType(e.Row.FindControl("txtImporte02"), TextBox).Enabled = False
                CType(e.Row.FindControl("txtImporte03"), TextBox).Enabled = False
                CType(e.Row.FindControl("txtImporte04"), TextBox).Enabled = False
            End If

        End If
    End Sub

    Private Sub gvCapturaDecimales_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCapturaDecimales.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim txtPermiteCaptura As TextBox = CType(e.Row.FindControl("txtPermiteCaptura"), TextBox)
            Dim txtEsSeparador As TextBox = CType(e.Row.FindControl("txtEsSeparador"), TextBox)
            If txtPermiteCaptura.Text = "False" Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
            If txtEsSeparador.Text = "True" Then
                e.Row.BackColor = Drawing.Color.Gray
                e.Row.ForeColor = Drawing.Color.White
            End If

        End If
    End Sub

    Private Sub gvCapturaflujo_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCapturaflujo.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim txtPermiteCaptura As TextBox = CType(e.Row.FindControl("txtPermiteCaptura"), TextBox)
            Dim txtEsSeparador As TextBox = CType(e.Row.FindControl("txtEsSeparador"), TextBox)
            If txtPermiteCaptura.Text = "False" Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
            If txtEsSeparador.Text = "True" Then
                e.Row.BackColor = Drawing.Color.Gray
                e.Row.ForeColor = Drawing.Color.White
            End If

        End If
    End Sub

    Private Sub gvCapturaDeuda_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCapturaDeuda.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim txtPermiteCaptura As TextBox = CType(e.Row.FindControl("txtPermiteCaptura"), TextBox)
            Dim txtEsSeparador As TextBox = CType(e.Row.FindControl("txtEsSeparador"), TextBox)
            If txtPermiteCaptura.Text = "False" Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
            If txtEsSeparador.Text = "True" Then
                e.Row.BackColor = Drawing.Color.Gray
                e.Row.ForeColor = Drawing.Color.White
            End If

        End If
    End Sub

    Private Sub btnActualizar_Click(sender As Object, e As EventArgs) Handles btnActualizar.Click
        Me.GuardaCaptura()
        Me.Response.Redirect("/RepFinancierosCaptura.aspx?r=" & Me.ddlReporte.SelectedValue & "&e=" & Me.ddlEmpresa.SelectedValue & "&a=" & Me.ddlAnio.SelectedValue & "&m=" & Me.ddlMes.SelectedValue)
    End Sub

    Protected Function RestanPyF(tipo As Integer) As String

        If Array.IndexOf(EMPRESAS_FIBRA_EXTENDIDO, ddlEmpresa.SelectedValue) >= 0 Then
            If tipo = 1 Then
                Return ",4,5,6,7,9"
            ElseIf tipo = 2 Then
                Return ",15,16,17,18,20"
            ElseIf tipo = 3 Then
                Return ",26,27,28,29,31"
            End If
        Else
            If tipo = 1 Then
                Return ",8"
            ElseIf tipo = 2 Then
                Return ",19"
            ElseIf tipo = 3 Then
                Return ",30"
            End If

        End If

        Return ""
    End Function

    Protected Function EmpresasFibraExtendido() As String
        Dim respuesta As String = ""
        For Each i As Integer In EMPRESAS_FIBRA_EXTENDIDO
            respuesta &= i & ","
        Next

        If respuesta.Length > 1 Then
            respuesta = respuesta.Substring(0, respuesta.Length - 1)
        End If

        Return respuesta
    End Function

    'Private Sub gvCapturaCuadreInter_DataBound(sender As Object, e As EventArgs) Handles gvCapturaCuadreInter.DataBound
    '    Dim row As New GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal)
    '    Dim cell As New TableHeaderCell()
    '    cell.Text = ""
    '    cell.ColumnSpan = 1
    '    row.Controls.Add(cell)

    '    cell = New TableHeaderCell()
    '    cell.Text = "Operativas"
    '    cell.ColumnSpan = 2
    '    row.Controls.Add(cell)

    '    cell = New TableHeaderCell()
    '    cell.ColumnSpan = 2
    '    cell.Text = "Fiscales"
    '    row.Controls.Add(cell)

    '    row.BackColor = ColorTranslator.FromHtml("#92e3d1")
    '    gvCapturaCuadreInter.HeaderRow.Parent.Controls.AddAt(0, row)
    'End Sub

    Private Sub gvCapturaCuadreInterRefV2_DataBound(sender As Object, e As EventArgs) Handles gvCapturaCuadreInterRefV2.DataBound
        Dim row As New GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal)
        Dim cell As New TableHeaderCell()
        cell.Text = ""
        cell.ColumnSpan = 1
        row.Controls.Add(cell)

        cell = New TableHeaderCell()
        cell.Text = "Operativas"
        cell.ColumnSpan = 2
        row.Controls.Add(cell)

        cell = New TableHeaderCell()
        cell.ColumnSpan = 2
        cell.Text = "Fiscales"
        row.Controls.Add(cell)

        row.BackColor = ColorTranslator.FromHtml("#92e3d1")
        gvCapturaCuadreInterRefV2.HeaderRow.Parent.Controls.AddAt(0, row)
    End Sub
End Class

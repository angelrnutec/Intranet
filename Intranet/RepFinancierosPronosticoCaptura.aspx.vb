Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class RepFinancierosPronosticoCaptura
    Inherits System.Web.UI.Page

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

            Me.btnCancelar.Text = TranslateLocale.text(Me.btnCancelar.Text)
            Me.btnContinuar.Text = TranslateLocale.text(Me.btnContinuar.Text)
            Me.btnGuardaDistribucion.Text = TranslateLocale.text(Me.btnGuardaDistribucion.Text)
            Me.btnRegresar.Text = TranslateLocale.text(Me.btnRegresar.Text)
            Me.lblFibras.Text = TranslateLocale.text(Me.lblFibras.Text)
            Me.lblHornos.Text = TranslateLocale.text(Me.lblHornos.Text)

        End If

    End Sub

    Private Sub CargaCombos()
        Try
            For i As Integer = Now.AddMonths(1).Year To 2012 Step -1
                Me.ddlAnio.Items.Add(i)
            Next
            Me.ddlAnio.SelectedValue = Now.Year

            Me.ddlReporte.Items.Clear()
            Me.ddlReporte.Items.Add(New ListItem(TranslateLocale.text("Estado de Resultados"), "2"))
            Me.ddlReporte.Items.Add(New ListItem(TranslateLocale.text("Estado de Resultados Individual"), "2999"))
            Me.ddlReporte.Items.Add(New ListItem(TranslateLocale.text("Estado de Resultados Individual EUR/BRL"), "32"))
            Me.ddlReporte.Items.Add(New ListItem(TranslateLocale.text("Pedidos y Facturación"), "6"))
            Me.ddlReporte.Items.Add(New ListItem(TranslateLocale.text("Pedidos y Facturación Fibras"), "1017"))


            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.ddlEmpresa.Items.Clear()
            Me.ddlEmpresa.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpresas(), "nombre", "id_empresa"))

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub CargaDatos()
        Me.ddlAnio.SelectedValue = Request.QueryString("a")
        Me.CargaGridCaptura()
    End Sub

    Private Sub CargaGridCaptura()

        If (ddlReporte.SelectedValue = 2999 Or ddlReporte.SelectedValue = 32 Or ddlReporte.SelectedValue = 1017) And ddlEmpresa.SelectedValue = 0 Then
            Throw New Exception("Seleccione la empresa")
        End If

        Me.ValidaSeleccionReporte()
        Me.txtEstado.Text = "1"
        Me.btnContinuar.Text = TranslateLocale.text("Guardar")
        Me.btnCancelar.Text = TranslateLocale.text("Cancelar")
        Me.divCaptura.Visible = True

        Me.ddlAnio.Enabled = False
        Me.ddlReporte.Enabled = False
        Me.ddlEmpresa.Enabled = False

        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dtDatos As DataSet = reporte.RecuperaDatos(Me.ddlReporte.SelectedValue, GetIdEmpresa(), Me.ddlAnio.SelectedValue, 0)

        Dim estatus As String = dtDatos.Tables(2).Rows(0)("estatus")
        Me.txtEstatus.Text = estatus

        If Me.ddlReporte.SelectedValue = 2 Then
            Dim dt As DataTable = dtDatos.Tables(0)
            Funciones.TranslateTableData(dt, {"descripcion"})
            Me.gvCapturaER.DataSource = dt
            Funciones.TranslateGridviewHeader(Me.gvCapturaER)
            Me.gvCapturaER.DataBind()
            Me.gvCapturaER.Visible = True
            Me.gvCaptura.Visible = False
            Me.gvCapturaExtendido.Visible = False
        ElseIf Me.ddlReporte.SelectedValue = 2999 Or Me.ddlReporte.SelectedValue = 32 Then
            Dim dt As DataTable = dtDatos.Tables(0)
            Funciones.TranslateTableData(dt, {"descripcion"})
            Me.gvCapturaERIndividual.DataSource = dt
            Funciones.TranslateGridviewHeader(Me.gvCapturaERIndividual)
            Me.gvCapturaERIndividual.DataBind()
            Me.gvCapturaERIndividual.Visible = True
            Me.gvCaptura.Visible = False
            Me.gvCapturaExtendido.Visible = False
        ElseIf Me.ddlReporte.SelectedValue = 1017 Then
            Dim dt As DataTable = dtDatos.Tables(0)
            Funciones.TranslateTableData(dt, {"descripcion"})
            Me.gvCapturaExtendido.DataSource = dt
            Funciones.TranslateGridviewHeader(Me.gvCapturaExtendido)
            Me.gvCapturaExtendido.DataBind()
            Me.gvCapturaExtendido.Visible = True
            Me.gvCaptura.Visible = False
            Me.gvCapturaER.Visible = False
            Me.gvCapturaERIndividual.Visible = False
        Else
            Dim dt As DataTable = dtDatos.Tables(0)
            Funciones.TranslateTableData(dt, {"descripcion"})
            Me.gvCaptura.DataSource = dt
            Funciones.TranslateGridviewHeader(Me.gvCaptura)
            Me.gvCaptura.DataBind()
            Me.gvCaptura.Visible = True
            Me.gvCapturaER.Visible = False
            Me.gvCapturaExtendido.Visible = False
        End If

        If txtEstatus.Text = "C" Then
            Me.txtEstado.Text = "0"
            Me.btnContinuar.Enabled = False
            Me.btnCancelar.Text = TranslateLocale.text("Salir")
            Me.lblMensajeEstatus.Visible = True
            Me.lblMensajeEstatus.Text = TranslateLocale.text("El perido seleccionado esta cerrado y no se puede modificar")
            Me.gvCaptura.Enabled = False
            Me.gvCapturaER.Enabled = False
        Else
            Me.lblMensajeEstatus.Visible = False
            Me.gvCaptura.Enabled = True
            Me.gvCapturaER.Enabled = True
        End If

    End Sub

    Private Sub btnContinuar_Click(sender As Object, e As EventArgs) Handles btnContinuar.Click
        Try
            If Me.txtEstado.Text = "0" Then  ''Iniciando la captura
                Me.CargaGridCaptura()
            Else ''Guarda la captura
                Me.GuardaCaptura()
                Me.Response.Redirect("/RepFinancierosCapturaOK.aspx")
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub GuardaCaptura()
        Try
            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim listaDatos As New ArrayList()

            If Me.ddlReporte.SelectedValue = 2 Then
                For Each row As GridViewRow In gvCapturaER.Rows
                    Dim txtIdConcepto As TextBox = CType(row.FindControl("txtIdConcepto"), TextBox)
                    Dim txtImporte01 As TextBox = CType(row.FindControl("txtImporte01"), TextBox)
                    Dim txtImporte02 As TextBox = CType(row.FindControl("txtImporte02"), TextBox)
                    Dim txtImporte03 As TextBox = CType(row.FindControl("txtImporte03"), TextBox)
                    Dim txtImporte04 As TextBox = CType(row.FindControl("txtImporte04"), TextBox)
                    Dim txtImporte05 As TextBox = CType(row.FindControl("txtImporte05"), TextBox)
                    Dim txtImporte06 As TextBox = CType(row.FindControl("txtImporte06"), TextBox)
                    Dim txtImporte07 As TextBox = CType(row.FindControl("txtImporte07"), TextBox)
                    Dim txtImporte08 As TextBox = CType(row.FindControl("txtImporte08"), TextBox)
                    Dim txtImporte09 As TextBox = CType(row.FindControl("txtImporte09"), TextBox)
                    Dim txtImporte10 As TextBox = CType(row.FindControl("txtImporte10"), TextBox)
                    Dim txtImporte11 As TextBox = CType(row.FindControl("txtImporte11"), TextBox)

                    listaDatos.Add(New ReporteDatos(3, txtIdConcepto.Text,
                                                    IIf(IsNumeric(txtImporte01.Text), txtImporte01.Text, 0),
                                                    IIf(IsNumeric(txtImporte02.Text), txtImporte02.Text, 0),
                                                    IIf(IsNumeric(txtImporte03.Text), txtImporte03.Text, 0),
                                                    IIf(IsNumeric(txtImporte04.Text), txtImporte04.Text, 0),
                                                    IIf(IsNumeric(txtImporte05.Text), txtImporte05.Text, 0),
                                                    IIf(IsNumeric(txtImporte06.Text), txtImporte06.Text, 0),
                                                    IIf(IsNumeric(txtImporte07.Text), txtImporte07.Text, 0),
                                                    IIf(IsNumeric(txtImporte08.Text), txtImporte08.Text, 0),
                                                    IIf(IsNumeric(txtImporte09.Text), txtImporte09.Text, 0),
                                                    IIf(IsNumeric(txtImporte10.Text), txtImporte10.Text, 0),
                                                    IIf(IsNumeric(txtImporte11.Text), txtImporte11.Text, 0), 0))
                Next
            ElseIf Me.ddlReporte.SelectedValue = 2999 Or Me.ddlReporte.SelectedValue = 32 Then
                For Each row As GridViewRow In gvCapturaERIndividual.Rows
                    Dim txtIdConcepto As TextBox = CType(row.FindControl("txtIdConcepto"), TextBox)
                    Dim txtImporte01 As TextBox = CType(row.FindControl("txtImporte01"), TextBox)
                    'Dim txtImporte02 As TextBox = CType(row.FindControl("txtImporte02"), TextBox)
                    'Dim txtImporte03 As TextBox = CType(row.FindControl("txtImporte03"), TextBox)
                    'Dim txtImporte04 As TextBox = CType(row.FindControl("txtImporte04"), TextBox)
                    'Dim txtImporte05 As TextBox = CType(row.FindControl("txtImporte05"), TextBox)
                    'Dim txtImporte06 As TextBox = CType(row.FindControl("txtImporte06"), TextBox)
                    'Dim txtImporte07 As TextBox = CType(row.FindControl("txtImporte07"), TextBox)
                    'Dim txtImporte08 As TextBox = CType(row.FindControl("txtImporte08"), TextBox)
                    'Dim txtImporte09 As TextBox = CType(row.FindControl("txtImporte09"), TextBox)
                    'Dim txtImporte10 As TextBox = CType(row.FindControl("txtImporte10"), TextBox)
                    'Dim txtImporte11 As TextBox = CType(row.FindControl("txtImporte11"), TextBox)

                    listaDatos.Add(New ReporteDatos(3, txtIdConcepto.Text,
                                                    IIf(IsNumeric(txtImporte01.Text), txtImporte01.Text, 0),
                                                    0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0))
                Next
            ElseIf Me.ddlReporte.selectedvalue = 1017 Then
                Dim tipoReporte As Integer = 5
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
                    Dim txtIdConcepto As TextBox = CType(row.FindControl("txtIdConcepto"), TextBox)
                    Dim txtImporte01 As TextBox = CType(row.FindControl("txtImporte01"), TextBox)
                    Dim txtImporte02 As TextBox = CType(row.FindControl("txtImporte02"), TextBox)

                    listaDatos.Add(New ReporteDatos(3, txtIdConcepto.Text, _
                                                    IIf(IsNumeric(txtImporte01.Text), txtImporte01.Text, 0), _
                                                    IIf(IsNumeric(txtImporte02.Text), txtImporte02.Text, 0), 0, 0, 0, 0, 0))
                Next
            End If


            reporte.GuardaDatosPlan(listaDatos, GetIdEmpresa(), Me.ddlReporte.SelectedValue, Me.ddlAnio.SelectedValue, 0, Session("idEmpleado"))

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub ValidaSeleccionReporte()
        Dim msg As String = ""

        If msg.Length > 0 Then
            Throw New Exception(TranslateLocale.text("Favor de capturar la siguiente información") & ":\n" & msg)
        End If

    End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        If Me.txtEstado.Text = "0" Then  ''Iniciando la captura
            Response.Redirect("/")
        Else
            Response.Redirect("/RepFinancierosPronosticoCaptura.aspx")
        End If
    End Sub

    Private Sub gvCaptura_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvCaptura.RowCommand
        If e.CommandName = "Distribucion" Then
            If divDistribucion.Visible = True Then
                Me.divDistribucion.Visible = False
                Me.divCaptura.Visible = True
                Me.btnCancelar.Visible = True
                Me.btnContinuar.Visible = True

            Else
                Me.divDistribucion.Visible = True

                Me.divCaptura.Visible = False
                Me.btnCancelar.Visible = False
                Me.btnContinuar.Visible = False

                Me.txtIdConcepto.Text = e.CommandArgument.ToString.Split("|")(0)
                Me.lblNombreConcepto.Text = e.CommandArgument.ToString.Split("|")(1)

                Dim dvr As GridViewRow = CType(CType(e.CommandSource, LinkButton).NamingContainer, GridViewRow)

                Dim txtImporte01 As TextBox = gvCaptura.Rows(dvr.RowIndex).FindControl("txtImporte01")
                Dim txtImporte02 As TextBox = gvCaptura.Rows(dvr.RowIndex).FindControl("txtImporte02")

                Me.txtFibrasTotal.Text = txtImporte01.Text
                Me.txtHornosTotal.Text = txtImporte02.Text
                Me.txtFibrasPorAsignar.Text = txtImporte01.Text
                Me.txtHornosPorAsignar.Text = txtImporte02.Text

                If txtImporte01.Text = "0" Then
                    Me.chkFibrasAuto.Visible = False
                    Me.txtFibrasTotal.Visible = False
                    Me.txtFibrasPorAsignar.Visible = False
                    Me.lblFibras.Visible = False

                    Me.txtFibrasMes1.Visible = False
                    Me.txtFibrasMes2.Visible = False
                    Me.txtFibrasMes3.Visible = False
                    Me.txtFibrasMes4.Visible = False
                    Me.txtFibrasMes5.Visible = False
                    Me.txtFibrasMes6.Visible = False
                    Me.txtFibrasMes7.Visible = False
                    Me.txtFibrasMes8.Visible = False
                    Me.txtFibrasMes9.Visible = False
                    Me.txtFibrasMes10.Visible = False
                    Me.txtFibrasMes11.Visible = False
                    Me.txtFibrasMes12.Visible = False
                Else
                    Me.chkFibrasAuto.Visible = True
                    Me.txtFibrasTotal.Visible = True
                    Me.txtFibrasPorAsignar.Visible = True
                    Me.lblFibras.Visible = True

                    Me.txtFibrasMes1.Visible = True
                    Me.txtFibrasMes2.Visible = True
                    Me.txtFibrasMes3.Visible = True
                    Me.txtFibrasMes4.Visible = True
                    Me.txtFibrasMes5.Visible = True
                    Me.txtFibrasMes6.Visible = True
                    Me.txtFibrasMes7.Visible = True
                    Me.txtFibrasMes8.Visible = True
                    Me.txtFibrasMes9.Visible = True
                    Me.txtFibrasMes10.Visible = True
                    Me.txtFibrasMes11.Visible = True
                    Me.txtFibrasMes12.Visible = True
                End If
                If txtImporte02.Text = "0" Then
                    Me.chkHornosAuto.Visible = False
                    Me.txtHornosTotal.Visible = False
                    Me.txtHornosPorAsignar.Visible = False
                    Me.lblHornos.Visible = False

                    Me.txtHornosMes1.Visible = False
                    Me.txtHornosMes2.Visible = False
                    Me.txtHornosMes3.Visible = False
                    Me.txtHornosMes4.Visible = False
                    Me.txtHornosMes5.Visible = False
                    Me.txtHornosMes6.Visible = False
                    Me.txtHornosMes7.Visible = False
                    Me.txtHornosMes8.Visible = False
                    Me.txtHornosMes9.Visible = False
                    Me.txtHornosMes10.Visible = False
                    Me.txtHornosMes11.Visible = False
                    Me.txtHornosMes12.Visible = False
                Else
                    Me.chkHornosAuto.Visible = True
                    Me.txtHornosTotal.Visible = True
                    Me.txtHornosPorAsignar.Visible = True
                    Me.lblHornos.Visible = True

                    Me.txtHornosMes1.Visible = True
                    Me.txtHornosMes2.Visible = True
                    Me.txtHornosMes3.Visible = True
                    Me.txtHornosMes4.Visible = True
                    Me.txtHornosMes5.Visible = True
                    Me.txtHornosMes6.Visible = True
                    Me.txtHornosMes7.Visible = True
                    Me.txtHornosMes8.Visible = True
                    Me.txtHornosMes9.Visible = True
                    Me.txtHornosMes10.Visible = True
                    Me.txtHornosMes11.Visible = True
                    Me.txtHornosMes12.Visible = True
                End If


                ''CARGANDO DATOS DE DISTRIBUCION MANUAL
                Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Dim dtDist As DataTable = reporte.ReporteDistribucionManual(Me.ddlReporte.SelectedValue, Me.ddlAnio.SelectedValue, Me.txtIdConcepto.Text)


                For Each dr As DataRow In dtDist.Rows
                    If dr("tipo") = "F" Then
                        Me.txtFibrasMes1.Text = dr("monto_1")
                        Me.txtFibrasMes2.Text = dr("monto_2")
                        Me.txtFibrasMes3.Text = dr("monto_3")
                        Me.txtFibrasMes4.Text = dr("monto_4")
                        Me.txtFibrasMes5.Text = dr("monto_5")
                        Me.txtFibrasMes6.Text = dr("monto_6")
                        Me.txtFibrasMes7.Text = dr("monto_7")
                        Me.txtFibrasMes8.Text = dr("monto_8")
                        Me.txtFibrasMes9.Text = dr("monto_9")
                        Me.txtFibrasMes10.Text = dr("monto_10")
                        Me.txtFibrasMes11.Text = dr("monto_11")
                        Me.txtFibrasMes12.Text = dr("monto_12")

                        Me.chkFibrasAuto.Checked = False
                    ElseIf dr("tipo") = "H" Then
                        Me.txtHornosMes1.Text = dr("monto_1")
                        Me.txtHornosMes2.Text = dr("monto_2")
                        Me.txtHornosMes3.Text = dr("monto_3")
                        Me.txtHornosMes4.Text = dr("monto_4")
                        Me.txtHornosMes5.Text = dr("monto_5")
                        Me.txtHornosMes6.Text = dr("monto_6")
                        Me.txtHornosMes7.Text = dr("monto_7")
                        Me.txtHornosMes8.Text = dr("monto_8")
                        Me.txtHornosMes9.Text = dr("monto_9")
                        Me.txtHornosMes10.Text = dr("monto_10")
                        Me.txtHornosMes11.Text = dr("monto_11")
                        Me.txtHornosMes12.Text = dr("monto_12")

                        Me.chkHornosAuto.Checked = False
                    End If
                Next


                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>SeleccionAuto(1);SeleccionAuto(2);CalculaTotales(1);CalculaTotales(2);</script>", False)
            End If
        End If
    End Sub

    Private Sub gvCaptura_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCaptura.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim txtPermiteCaptura As TextBox = CType(e.Row.FindControl("txtPermiteCaptura"), TextBox)
            Dim txtEsSeparador As TextBox = CType(e.Row.FindControl("txtEsSeparador"), TextBox)
            Dim txtEsHornos As TextBox = CType(e.Row.FindControl("txtEsHornos"), TextBox)
            Dim txtEsFibras As TextBox = CType(e.Row.FindControl("txtEsFibras"), TextBox)
            Dim txtImporte01 As TextBox = CType(e.Row.FindControl("txtImporte01"), TextBox)
            Dim txtImporte02 As TextBox = CType(e.Row.FindControl("txtImporte02"), TextBox)
            Dim lblImporte1 As Label = CType(e.Row.FindControl("lblImporte1"), Label)
            Dim lblImporte2 As Label = CType(e.Row.FindControl("lblImporte2"), Label)

            If txtPermiteCaptura.Text = "False" Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
            If txtEsSeparador.Text = "True" Then
                e.Row.BackColor = Drawing.Color.Gray
                e.Row.ForeColor = Drawing.Color.White
            End If
            If ddlReporte.SelectedValue = 6 Then
                If txtEsHornos.Text = "True" Then
                    txtImporte01.Visible = False
                End If
                If txtEsFibras.Text = "True" Then
                    txtImporte02.Visible = False
                End If

            End If
            If ddlReporte.SelectedValue = 2 Then
                If txtEsHornos.Text = "True" Then
                    txtImporte01.Visible = False
                End If
                If txtEsFibras.Text = "True" Then
                    txtImporte02.Visible = False
                End If
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

    'Protected Function RestanPyF(tipo As Integer) As String
    '    If Me.ddlEmpresa.SelectedValue = 1 Or Me.ddlEmpresa.SelectedValue = 7 Or _
    '        Me.ddlEmpresa.SelectedValue = 8 Or Me.ddlEmpresa.SelectedValue = 9 Or _
    '        Me.ddlEmpresa.SelectedValue = 10 Then

    '        If tipo = 1 Then
    '            Return ",5"
    '        ElseIf tipo = 2 Then
    '            Return ",12"
    '        ElseIf tipo = 3 Then
    '            Return ",19"
    '        End If

    '    Else

    '        If tipo = 1 Then
    '            Return ",4"
    '        ElseIf tipo = 2 Then
    '            Return ",11"
    '        ElseIf tipo = 3 Then
    '            Return ",18"
    '        End If

    '    End If

    '    Return ""
    'End Function

    Private Sub btnGuardaDistribucion_Click(sender As Object, e As EventArgs) Handles btnGuardaDistribucion.Click

        ''GUARDANDO DATOS DE DISTRIBUCION MANUAL
        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        If Me.chkFibrasAuto.Checked = False Then
            reporte.GuardaDistribucionManual(Me.ddlReporte.SelectedValue, GetIdEmpresa(), Me.ddlAnio.SelectedValue, 0, Me.txtIdConcepto.Text, "", "F",
                                             Me.txtFibrasMes1.Text, Me.txtFibrasMes2.Text, Me.txtFibrasMes3.Text, Me.txtFibrasMes4.Text,
                                             Me.txtFibrasMes5.Text, Me.txtFibrasMes6.Text, Me.txtFibrasMes7.Text, Me.txtFibrasMes8.Text,
                                             Me.txtFibrasMes9.Text, Me.txtFibrasMes10.Text, Me.txtFibrasMes11.Text, Me.txtFibrasMes12.Text)
        Else
            reporte.EliminaDistribucionManual(Me.ddlReporte.SelectedValue, GetIdEmpresa(), Me.ddlAnio.SelectedValue, 0, Me.txtIdConcepto.Text, "F")
        End If
        If Me.chkHornosAuto.Checked = False Then
            reporte.GuardaDistribucionManual(Me.ddlReporte.SelectedValue, GetIdEmpresa(), Me.ddlAnio.SelectedValue, 0, Me.txtIdConcepto.Text, "", "H",
                                             Me.txtHornosMes1.Text, Me.txtHornosMes2.Text, Me.txtHornosMes3.Text, Me.txtHornosMes4.Text,
                                             Me.txtHornosMes5.Text, Me.txtHornosMes6.Text, Me.txtHornosMes7.Text, Me.txtHornosMes8.Text,
                                             Me.txtHornosMes9.Text, Me.txtHornosMes10.Text, Me.txtHornosMes11.Text, Me.txtHornosMes12.Text)
        Else
            reporte.EliminaDistribucionManual(Me.ddlReporte.SelectedValue, GetIdEmpresa(), Me.ddlAnio.SelectedValue, 0, Me.txtIdConcepto.Text, "H")
        End If


        Me.divDistribucion.Visible = False
        Me.divCaptura.Visible = True
        Me.btnCancelar.Visible = True
        Me.btnContinuar.Visible = True

        ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Datos guardados correctamente');</script>", False)
    End Sub
    Private Sub btnRegresar_Click(sender As Object, e As EventArgs) Handles btnRegresar.Click
        Me.divDistribucion.Visible = False
        Me.divCaptura.Visible = True
        Me.btnCancelar.Visible = True
        Me.btnContinuar.Visible = True
    End Sub

    Private Sub ddlReporte_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlReporte.SelectedIndexChanged
        If ddlReporte.SelectedValue = 2999 Or ddlReporte.SelectedValue = 32 Or ddlReporte.SelectedValue = 1017 Then
            trEmpresa.Visible = True
        Else
            trEmpresa.Visible = False
        End If
    End Sub

    Private Function GetIdEmpresa() As Integer
        If ddlReporte.SelectedValue = 2999 Or ddlReporte.SelectedValue = 32 Or ddlReporte.SelectedValue = 1017 Then
            Return ddlEmpresa.SelectedValue
        Else
            Return -1
        End If
    End Function


    Protected Function RestanPyF(tipo As Integer) As String

        If tipo = 1 Then
            Return ",4,5,6,7,9"
        ElseIf tipo = 2 Then
            Return ",15,16,17,18,20"
        ElseIf tipo = 3 Then
            Return ",26,27,28,29,31"
        ElseIf tipo = 4 Then
            Return ",37,38,39,40,42"
        End If

        'If Array.IndexOf(EMPRESAS_FIBRA_EXTENDIDO, ddlEmpresa.SelectedValue) >= 0 Then
        '    If tipo = 1 Then
        '        Return ",4,5,6,7,9"
        '    ElseIf tipo = 2 Then
        '        Return ",15,16,17,18,20"
        '    ElseIf tipo = 3 Then
        '        Return ",26,27,28,29,31"
        '    End If
        'Else
        '    If tipo = 1 Then
        '        Return ",8"
        '    ElseIf tipo = 2 Then
        '        Return ",19"
        '    ElseIf tipo = 3 Then
        '        Return ",30"
        '    End If

        'End If

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

    Public EMPRESAS_FIBRA_EXTENDIDO As String() = New String() {"1", "7", "8", "9", "10", "12", "13"}

End Class

Imports IntranetBL

Public Class TelefoniaCaptura
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

        End If
    End Sub

    Protected Function PerfilDeuda_Totales(id_empresa As Integer) As String
        Dim dt As DataTable = CType(ViewState("dtConceptos"), DataTable)
        Dim total As String = ""
        For Each dr As DataRow In dt.Rows
            total = dr("id")
        Next
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
            items.Add(New ListItem("Enero", "1"))
            items.Add(New ListItem("Febrero", "2"))
            items.Add(New ListItem("Marzo", "3"))
            items.Add(New ListItem("Abril", "4"))
            items.Add(New ListItem("Mayo", "5"))
            items.Add(New ListItem("Junio", "6"))
            items.Add(New ListItem("Julio", "7"))
            items.Add(New ListItem("Agosto", "8"))
            items.Add(New ListItem("Septiembre", "9"))
            items.Add(New ListItem("Octubre", "10"))
            items.Add(New ListItem("Noviembre", "11"))
            items.Add(New ListItem("Diciembre", "12"))
            Me.ddlMes.Items.AddRange(items.ToArray)

            Dim fecha As Date = Now.AddMonths(-1)

            Me.ddlAnio.SelectedValue = fecha.Year
            Me.ddlMes.SelectedValue = fecha.Month


            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.ddlEmpresa.DataSource = combos.RecuperaEmpresaRepTelefonia(Session("idEmpleado"), "telcel_rep_consumos")
            Me.ddlEmpresa.DataValueField = "id_empresa"
            Me.ddlEmpresa.DataTextField = "nombre"
            Me.ddlEmpresa.DataBind()

            Me.ddlReporte.DataSource = combos.RecuperaReportes(3)
            Me.ddlReporte.DataValueField = "id_reporte"
            Me.ddlReporte.DataTextField = "nombre"
            Me.ddlReporte.DataBind()
            Me.ddlReporte.SelectedValue = 12
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
        Me.btnContinuar.Text = "Guardar"
        Me.btnCancelar.Text = "Cancelar"
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

        If ddlReporte.SelectedValue = 5 Then
            Me.gvCaptura.Visible = False
            Me.gvCapturaflujo.Visible = True
            Me.gvCapturaDecimales.Visible = False
            Me.gvCapturaCuadreInter.Visible = False
            Me.gvCapturaCuadreInterRef.Visible = False
            Me.divComentarios.Visible = True

            If dtDatos.Tables(1).Rows.Count > 0 Then
                Me.txtComentarios.Text = dtDatos.Tables(1).Rows(0)("comentarios")
            End If

            Me.gvCapturaflujo.DataSource = dtDatos.Tables(0)
            Me.gvCapturaflujo.DataBind()
        ElseIf ddlReporte.SelectedValue = 7 Then


            Me.gvCaptura.Visible = False
            Me.gvCapturaDeuda.Visible = True
            Me.gvCapturaDecimales.Visible = False
            Me.gvCapturaCuadreInter.Visible = False
            Me.gvCapturaCuadreInterRef.Visible = False

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
            Me.gvCapturaDeuda.DataBind()

        ElseIf ddlReporte.SelectedValue = 8 Then
            Me.gvCaptura.Visible = False
            Me.gvCapturaDeuda.Visible = False
            Me.gvCapturaDecimales.Visible = True
            Me.gvCapturaCuadreInter.Visible = False
            Me.gvCapturaCuadreInterRef.Visible = False

            Me.gvCapturaDecimales.DataSource = dtDatos.Tables(0)
            Me.gvCapturaDecimales.DataBind()
        ElseIf ddlReporte.SelectedValue = 3 Then
            Me.divComentarios.Visible = False
            Me.divDatosFlujoEfectivo.Visible = True

            If dtDatos.Tables.Count > 3 Then
                Me.lblFE_SaldoCaja.Text = Format(dtDatos.Tables(3).Rows(0)("saldo_caja"), "#,###,##0")
                Me.lblFE_UtilidadNeta.Text = Format(dtDatos.Tables(3).Rows(0)("utilidad_neta"), "#,###,##0")
            End If

            Me.gvCaptura.DataSource = dtDatos.Tables(0)
            Me.gvCaptura.DataBind()
        ElseIf ddlReporte.SelectedValue = 10 Then
            Me.gvCaptura.Visible = False
            Me.gvCapturaDeuda.Visible = False
            Me.gvCapturaDecimales.Visible = False
            Me.gvCapturaCuadreInter.Visible = True
            Me.gvCapturaCuadreInterRef.Visible = True
            Me.lblTituloInterRef.Visible = True

            Me.divComentarios.Visible = False

            Me.gvCapturaCuadreInter.DataSource = dtDatos.Tables(0)
            Me.gvCapturaCuadreInter.DataBind()

            Me.gvCapturaCuadreInterRef.DataSource = dtDatos.Tables(3)
            Me.gvCapturaCuadreInterRef.DataBind()
        ElseIf ddlReporte.SelectedValue = 1015 Then
            Me.gvCaptura.Visible = False
            Me.gvCapturaDeuda.Visible = False
            Me.gvCapturaDecimales.Visible = False
            Me.gvCapturaCuadreInter.Visible = True
            Me.gvCapturaCuadreInterRef.Visible = True
            Me.lblTituloInterRef.Visible = True

            Me.divComentarios.Visible = False

            Me.gvCapturaCuadreInter.DataSource = dtDatos.Tables(0)
            Me.gvCapturaCuadreInter.DataBind()

            Me.gvCapturaCuadreInterRef.DataSource = dtDatos.Tables(3)
            Me.gvCapturaCuadreInterRef.DataBind()
        Else
            Me.divComentarios.Visible = False

            Me.gvCaptura.DataSource = dtDatos.Tables(0)
            Me.gvCaptura.DataBind()
        End If

        If ddlReporte.SelectedValue = 4 Then
            Me.divLeyenda_PedidosyFacturacion.Visible = True
        End If

        If txtEstatus.Text = "C" Then
            Me.txtEstado.Text = "0"
            Me.btnContinuar.Enabled = False
            Me.btnCancelar.Text = "Salir"
            Me.btnActualizar.Enabled = False
            Me.lblMensajeEstatus.Visible = True
            Me.lblMensajeEstatus.Text = "El perido seleccionado esta cerrado y no se puede modificar"
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
                Me.Response.Redirect("/TelefoniaCaptura.aspx")
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
                Next
            ElseIf Me.ddlReporte.SelectedValue = 10 Then
                tipoReporte = 4
                For Each row As GridViewRow In gvCapturaCuadreInter.Rows
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
            ElseIf Me.ddlReporte.SelectedValue = 1015 Then
                tipoReporte = 4
                For Each row As GridViewRow In gvCapturaCuadreInter.Rows
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
            ElseIf Me.ddlReporte.SelectedValue = 8 Then
                For Each row As GridViewRow In gvCapturaDecimales.Rows()
                    Dim txtImporte As TextBox = CType(row.FindControl("txtImporte"), TextBox)
                    Dim txtIdConcepto As TextBox = CType(row.FindControl("txtIdConcepto"), TextBox)

                    listaDatos.Add(New ReporteDatos(tipoReporte, txtIdConcepto.Text, IIf(IsNumeric(txtImporte.Text), txtImporte.Text, 0)))
                Next
            Else
                For Each row As GridViewRow In gvCaptura.Rows
                    Dim txtImporte As TextBox = CType(row.FindControl("txtImporte"), TextBox)
                    Dim txtIdConcepto As TextBox = CType(row.FindControl("txtIdConcepto"), TextBox)

                    listaDatos.Add(New ReporteDatos(tipoReporte, txtIdConcepto.Text, IIf(IsNumeric(txtImporte.Text), txtImporte.Text, 0)))
                Next
            End If

            reporte.GuardaDatos(listaDatos,
                                tipoReporte,
                                Me.ddlEmpresa.SelectedValue,
                                Me.ddlReporte.SelectedValue,
                                Me.ddlAnio.SelectedValue,
                                Me.ddlMes.SelectedValue,
                                Session("idEmpleado"),
                                Me.txtComentarios.Text)

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub ValidaSeleccionReporte()
        Dim msg As String = ""

        If Me.ddlReporte.SelectedValue = 0 Then msg &= " - Reporte\n"
        If Me.ddlReporte.SelectedValue <> 8 And Me.ddlEmpresa.SelectedValue = 0 Then msg &= " - Empresa\n"

        If msg.Length > 0 Then
            Throw New Exception("Favor de capturar la siguiente información:\n" & msg)
        End If
    End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        If Me.txtEstado.Text = "0" Then  ''Iniciando la captura
            Response.Redirect("/")
        Else
            Response.Redirect("/TelefoniaCaptura.aspx")
        End If
    End Sub

    Private Sub gvCaptura_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCaptura.RowDataBound
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
        Me.Response.Redirect("/TelefoniaCaptura.aspx?r=" & Me.ddlReporte.SelectedValue & "&e=" & Me.ddlEmpresa.SelectedValue & "&a=" & Me.ddlAnio.SelectedValue & "&m=" & Me.ddlMes.SelectedValue)
    End Sub

    Protected Function RestanPyF(tipo As Integer) As String
        If Me.ddlEmpresa.SelectedValue = 1 Or Me.ddlEmpresa.SelectedValue = 7 Or
            Me.ddlEmpresa.SelectedValue = 8 Or Me.ddlEmpresa.SelectedValue = 9 Or
            Me.ddlEmpresa.SelectedValue = 10 Or Me.ddlEmpresa.SelectedValue = 1015 Then

            If tipo = 1 Then
                Return ",5"
            ElseIf tipo = 2 Then
                Return ",12"
            ElseIf tipo = 3 Then
                Return ",19"
            End If
        Else
            If tipo = 1 Then
                Return ",4"
            ElseIf tipo = 2 Then
                Return ",11"
            ElseIf tipo = 3 Then
                Return ",18"
            End If
        End If

        Return ""
    End Function
End Class


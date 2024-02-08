Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class RepFinancierosBalanceAjustes
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then

            Me.tblCapturaNormal.Visible = False

            Me.CargaCombos()


            Me.btnActualizar.Text = TranslateLocale.text(Me.btnActualizar.Text)
            Me.btnCancelar.Text = TranslateLocale.text(Me.btnCancelar.Text)
            Me.btnContinuar.Text = TranslateLocale.text(Me.btnContinuar.Text)
            Me.btnGuardar.Text = TranslateLocale.text(Me.btnGuardar.Text)
        End If

    End Sub

    Private Sub CargaCombos()
        Try
            For i As Integer = Now.AddMonths(1).Year To 2012 Step -1
                Me.ddlAnio.Items.Add(i)
            Next

            Dim items As New List(Of ListItem)
            items.Add(New ListItem(TranslateLocale.text("Acumulado"), "0"))
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
            Me.ddlPeriodo.Items.AddRange(items.ToArray)

            Me.ddlAnio.SelectedValue = Now.Year
            Me.ddlPeriodo.SelectedValue = Now.Month

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub CargaDatos()
        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dt As DataTable = reporte.RecuperaReporteBalanceAjustes(Me.ddlAnio.SelectedValue, Me.ddlPeriodo.SelectedValue)

        Funciones.TranslateTableData(dt, {"descripcion"})

        Me.gvCaptura.DataSource = dt
        Funciones.TranslateGridviewHeader(Me.gvCaptura)
        Me.gvCaptura.DataBind()

        If dt.Rows.Count > 0 Then
            Dim dr As DataRow = dt.Rows(0)

            ''Me.radMinuta.Content = dr("minuta_junta_anterior")
            ''Me.radResumen.Content = dr("resumen_ejecutivo")

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

            If e.Row.Cells(1).Text < 0 Then e.Row.Cells(1).ForeColor = System.Drawing.Color.Red
            If e.Row.Cells(3).Text < 0 Then e.Row.Cells(3).ForeColor = System.Drawing.Color.Red
            If e.Row.Cells(4).Text < 0 Then e.Row.Cells(4).ForeColor = System.Drawing.Color.Red
            If e.Row.Cells(5).Text < 0 Then e.Row.Cells(5).ForeColor = System.Drawing.Color.Red
            If e.Row.Cells(6).Text < 0 Then e.Row.Cells(6).ForeColor = System.Drawing.Color.Red
            If e.Row.Cells(7).Text < 0 Then e.Row.Cells(7).ForeColor = System.Drawing.Color.Red

            If e.Row.Cells(8).Text < 0 Then e.Row.Cells(8).ForeColor = System.Drawing.Color.Red
            If e.Row.Cells(10).Text < 0 Then e.Row.Cells(10).ForeColor = System.Drawing.Color.Red
            If e.Row.Cells(11).Text < 0 Then e.Row.Cells(11).ForeColor = System.Drawing.Color.Red
            If e.Row.Cells(12).Text < 0 Then e.Row.Cells(12).ForeColor = System.Drawing.Color.Red
            If e.Row.Cells(17).Text < 0 Then e.Row.Cells(17).ForeColor = System.Drawing.Color.Red
            If e.Row.Cells(18).Text < 0 Then e.Row.Cells(18).ForeColor = System.Drawing.Color.Red
        End If
    End Sub




    Private Sub btnContinuar_Click(sender As Object, e As EventArgs) Handles btnContinuar.Click
        Try
            Me.ddlAnio.Enabled = False
            Me.ddlPeriodo.Enabled = False
            Me.btnContinuar.Visible = False

            Me.btnGuardar.Visible = True
            Me.btnActualizar.Visible = True

            Me.tblCapturaNormal.Visible = True

            Me.CargaDatos()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub



    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Response.Redirect("/RepFinancierosBalanceAjustes.aspx")
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Me.GuardaCaptura()
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub





    Private Sub GuardaCaptura()
        Try
            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim listaDatos As New ArrayList()
            Dim tipoReporte As Integer = 4

            For Each row As GridViewRow In gvCaptura.Rows
                Dim txtCargos As TextBox = CType(row.FindControl("txtCargos"), TextBox)
                Dim txtCreditos As TextBox = CType(row.FindControl("txtCreditos"), TextBox)
                Dim txtIdConcepto As TextBox = CType(row.FindControl("txtIdConcepto"), TextBox)

                listaDatos.Add(New ReporteDatos(tipoReporte, txtIdConcepto.Text, _
                                                IIf(IsNumeric(txtCargos.Text), txtCargos.Text, 0), _
                                                IIf(IsNumeric(txtCreditos.Text), txtCreditos.Text, 0), 0, 0, 0, 0, 0))
            Next

            reporte.GuardaDatos(listaDatos, tipoReporte, -1, 1, Me.ddlAnio.SelectedValue, _
                                Me.ddlPeriodo.SelectedValue, Session("idEmpleado"), "")

            Me.CargaDatos()

        Catch ex As Exception
            Throw ex
        End Try
    End Sub


End Class
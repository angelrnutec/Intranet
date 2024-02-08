Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class RepFinancierosEjecutivoComentarios
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then

            Me.tblCapturaNormal.Visible = False
            Me.tblBotones.Visible = False

            Me.CargaCombos()

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


            Me.ddlTipoReporte.Items.Clear()
            Me.ddlTipoReporte.Items.Add(New ListItem(TranslateLocale.text("Consolidado"), "C"))
            Me.ddlTipoReporte.Items.Add(New ListItem(TranslateLocale.text("Hornos"), "H"))
            Me.ddlTipoReporte.Items.Add(New ListItem(TranslateLocale.text("Fibras"), "F"))


        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub CargaDatos()
        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dt As DataTable = reporte.RecuperaReporteEjecutivoComentarios(Me.ddlAnio.SelectedValue, Me.ddlPeriodo.SelectedValue, Me.ddlTipoReporte.SelectedValue)

        If dt.Rows.Count > 0 Then
            Dim dr As DataRow = dt.Rows(0)

            Me.radMinuta.Content = dr("minuta_junta_anterior")
            Me.radResumen.Content = dr("resumen_ejecutivo")
            Me.radFlujoEfectivo.Content = dr("grafica_flujo_efectivo")
        End If
    End Sub

    Private Sub btnContinuar_Click(sender As Object, e As EventArgs) Handles btnContinuar.Click
        Try
            Me.ddlAnio.Enabled = False
            Me.ddlPeriodo.Enabled = False
            Me.ddlTipoReporte.Enabled = False
            Me.btnContinuar.Enabled = False

            Me.tblBotones.Visible = True
            Me.tblCapturaNormal.Visible = True

            Me.CargaDatos()

            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>IniciaUpload();</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            reporte.GuardaReporteEjecutivoComentarios(ddlTipoReporte.SelectedValue, ddlAnio.SelectedValue, ddlPeriodo.SelectedValue, radMinuta.Content, radResumen.Content, radFlujoEfectivo.Content)

            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Datos guardados correctamente');IniciaUpload();</script>", False)

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub



    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Response.Redirect("/RepFinancierosEjecutivoComentarios.aspx")
    End Sub
End Class
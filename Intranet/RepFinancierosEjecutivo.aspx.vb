Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class RepFinancierosEjecutivo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.CargaCombos()
            If Request.QueryString("t") = "C" Then
                Me.lblNombreReporte.Text = TranslateLocale.text("Reporte Ejecutivo - Consolidado")
            ElseIf Request.QueryString("t") = "H" Then
                Me.lblNombreReporte.Text = TranslateLocale.text("Reporte Ejecutivo - Hornos")
            ElseIf Request.QueryString("t") = "F" Then
                Me.lblNombreReporte.Text = TranslateLocale.text("Reporte Ejecutivo - Fibras")
            End If
        End If

        Me.btnGenerarReporte.OnClientClick = "this.disabled = true; this.value = '" & TranslateLocale.text("Generando Reporte") & "...';"
        Me.btnGenerarReporte.Text = TranslateLocale.text("Generar Reporte")
        Me.btnCancelar.Text = TranslateLocale.text("Salir")

    End Sub

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

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub


    Private Sub ValidaSeleccionReporte()
        Dim msg As String = ""

        If msg.Length > 0 Then
            Throw New Exception(TranslateLocale.text("Favor de capturar la siguiente información") & ":\n" & msg)
        End If

    End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Response.Redirect("/")
    End Sub

    Private Sub btnGenerarReporte_Click(sender As Object, e As EventArgs) Handles btnGenerarReporte.Click
        Try
            ValidaSeleccionReporte()

            Dim url As String = ""
            If Request.QueryString("t") = "C" Then
                url = "RepFinancierosEjecutivoImpresion.aspx?a=" & Me.ddlAnio.SelectedValue & "&m=" & Me.ddlMes.SelectedValue
            ElseIf Request.QueryString("t") = "H" Then
                url = "RepFinancierosEjecutivoHornosImpresion.aspx?a=" & Me.ddlAnio.SelectedValue & "&m=" & Me.ddlMes.SelectedValue
            ElseIf Request.QueryString("t") = "F" Then
                url = "RepFinancierosEjecutivoFibrasImpresion.aspx?a=" & Me.ddlAnio.SelectedValue & "&m=" & Me.ddlMes.SelectedValue
            End If


            Dim script As String = "window.open('" + url + "','')"
            ScriptManager.RegisterClientScriptBlock(Me.Page, Me.Page.GetType(), "NewWindow", script, True)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub
End Class

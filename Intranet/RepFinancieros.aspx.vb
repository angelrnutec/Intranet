Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class RepFinancieros
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.txtIdReporte.Text = Request.QueryString("r")
            Me.CargaCombos()

            Me.btnGenerarReporte.OnClientClick = "this.disabled = true; this.value = '" & TranslateLocale.text("Generando Reporte") & "...';"
            Me.btnGenerarReporte.Text = TranslateLocale.text("Generar Reporte")
            Me.btnCancelar.Text = TranslateLocale.text("Salir")

        End If

    End Sub

    Private Sub CargaCombos()
        Try
            For i As Integer = Now.AddMonths(1).Year To 2012 Step -1
                Me.ddlAnio.Items.Add(i)
            Next

            Dim items As New List(Of ListItem)

            If Me.txtIdReporte.Text <> "10" And Me.txtIdReporte.Text <> "1015" Then
                items.Add(New ListItem(TranslateLocale.text("Acumulado"), "0"))
            End If
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
            Me.ddlEmpresa.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpresasConsolidado(), "nombre", "id_empresa"))

            If Me.txtIdReporte.Text = "2" Or Me.txtIdReporte.Text = "4" Then
                Me.ddlEmpresa.Items.Add(New ListItem("Negocio: Fibra", -11))
                Me.ddlEmpresa.Items.Add(New ListItem("Negocio: FV", -12))
                Me.ddlEmpresa.Items.Add(New ListItem("Negocio: SAT", -13))
                Me.ddlEmpresa.Items.Add(New ListItem("Negocio: Comercial", -14))
            End If

            'If Me.txtIdReporte.Text = "10" Or Me.txtIdReporte.Text = "1015" Then
            '    Me.ddlEmpresa.Items.Add(New ListItem("Matriz comparativa", -99))
            'End If
            If Me.txtIdReporte.Text = "1015" Then
                Me.ddlEmpresa.Items.Add(New ListItem("Matriz comparativa", -99))
            End If

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.lblNombreReporte.Text = TranslateLocale.text(reporte.RecuperaReporteNombre(Me.txtIdReporte.Text))

            If Me.txtIdReporte.Text = "5" Or Me.txtIdReporte.Text = "10" Or Me.txtIdReporte.Text = "1015" Then
                Me.divAgrupado.Visible = True
            End If

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub


    Private Sub ValidaSeleccionReporte()
        Dim msg As String = ""

        If Me.ddlEmpresa.SelectedValue = 0 Then msg &= " - " & TranslateLocale.text("Empresa") & "\n"

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

            Dim url As String
            If Me.txtIdReporte.Text = "5" And Me.ddlMes.SelectedValue > 0 Then
                url = "RepFinancierosSemanasImpresion.aspx?r=" & Me.txtIdReporte.Text & "&e=" & Me.ddlEmpresa.SelectedValue & "&a=" & Me.ddlAnio.SelectedValue & "&m=" & Me.ddlMes.SelectedValue
                'ElseIf Me.txtIdReporte.Text = "10" And Me.ddlEmpresa.SelectedValue = -99 Then
                '    url = "RepFinancierosCuadreInterMatrizImpresion.aspx?r=" & Me.txtIdReporte.Text & "&e=" & Me.ddlEmpresa.SelectedValue & "&a=" & Me.ddlAnio.SelectedValue & "&m=" & Me.ddlMes.SelectedValue
            ElseIf Me.txtIdReporte.Text = "10" Then
                url = "RepFinancierosCuadreInterImpresion.aspx?r=" & Me.txtIdReporte.Text & "&e=" & Me.ddlEmpresa.SelectedValue & "&a=" & Me.ddlAnio.SelectedValue & "&m=" & Me.ddlMes.SelectedValue
            ElseIf Me.txtIdReporte.Text = "1015" And Me.ddlEmpresa.SelectedValue = -99 Then
                url = "RepFinancierosCuadreInterMatrizImpresion.aspx?r=" & Me.txtIdReporte.Text & "&e=" & Me.ddlEmpresa.SelectedValue & "&a=" & Me.ddlAnio.SelectedValue & "&m=" & Me.ddlMes.SelectedValue
            ElseIf Me.txtIdReporte.Text = "1015" Then
                url = "RepFinancierosCuadreInterImpresionV2.aspx?r=" & Me.txtIdReporte.Text & "&e=" & Me.ddlEmpresa.SelectedValue & "&a=" & Me.ddlAnio.SelectedValue & "&m=" & Me.ddlMes.SelectedValue
            Else
                url = "RepFinancierosImpresion.aspx?r=" & Me.txtIdReporte.Text & "&e=" & Me.ddlEmpresa.SelectedValue & "&a=" & Me.ddlAnio.SelectedValue
            End If

            Dim script As String = "window.open('" + url + "','')"
            ScriptManager.RegisterClientScriptBlock(Me.Page, Me.Page.GetType(), "NewWindow", script, True)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    'Private Sub btnGenerarReporteIntercompaniasGlobal_Click(sender As Object, e As EventArgs) Handles btnGenerarReporteIntercompaniasGlobal.Click
    '    Try
    '        ValidaSeleccionReporte()

    '        Dim url As String
    '        If Me.txtIdReporte.Text = "10" Then
    '            url = "RepFinancierosCuadreInterMatrizImpresion.aspx?r=" & Me.txtIdReporte.Text & "&e=" & Me.ddlEmpresa.SelectedValue & "&a=" & Me.ddlAnio.SelectedValue & "&m=" & Me.ddlMes.SelectedValue
    '        End If

    '        Dim script As String = "window.open('" + url + "','')"
    '        ScriptManager.RegisterClientScriptBlock(Me.Page, Me.Page.GetType(), "NewWindow", script, True)
    '    Catch ex As Exception
    '        ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
    '    End Try
    'End Sub
End Class

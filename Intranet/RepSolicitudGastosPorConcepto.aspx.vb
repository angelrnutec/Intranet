Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class RepSolicitudGastosPorConcepto
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.CargaCombos()

            Me.btnGenerarReporte.OnClientClick = "this.disabled = true; this.value = '" & TranslateLocale.text("Generando Reporte") & "...';"
            Me.btnGenerarReporte.Text = TranslateLocale.text("Generar Reporte")

        End If

    End Sub

    Private Sub CargaCombos()
        Try
            For i As Integer = Now.AddMonths(1).Year To 2013 Step -1
                Me.ddlAnio.Items.Add(i)
            Next

            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.ddlEmpresa.Items.Clear()
            Me.ddlEmpresa.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpresaRepSolicitudes(Session("idEmpleado"), "rep_saldo_vac"), "nombre", "id_empresa"))


            'Dim items As New List(Of ListItem)
            'items.Add(New ListItem("Año Completo", "0"))
            'items.Add(New ListItem("Enero", "1"))
            'items.Add(New ListItem("Febrero", "2"))
            'items.Add(New ListItem("Marzo", "3"))
            'items.Add(New ListItem("Abril", "4"))
            'items.Add(New ListItem("Mayo", "5"))
            'items.Add(New ListItem("Junio", "6"))
            'items.Add(New ListItem("Julio", "7"))
            'items.Add(New ListItem("Agosto", "8"))
            'items.Add(New ListItem("Septiembre", "9"))
            'items.Add(New ListItem("Octubre", "10"))
            'items.Add(New ListItem("Noviembre", "11"))
            'items.Add(New ListItem("Diciembre", "12"))
            'Me.ddlPeriodo.Items.AddRange(items.ToArray)

            Me.ddlAnio.SelectedValue = Now.Year
            'Me.ddlPeriodo.SelectedValue = Now.Month

            Me.ddlAgrupado.Items.Clear()
            Me.ddlAgrupado.Items.Add(New ListItem(TranslateLocale.text("Conceptos Generales"), "0"))
            Me.ddlAgrupado.Items.Add(New ListItem(TranslateLocale.text("Conceptos Bickley"), "1"))


        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub



    Private Sub btnGenerarReporte_Click(sender As Object, e As EventArgs) Handles btnGenerarReporte.Click
        Try
            Dim url As String = ""
            url = "RepSolicitudGastosPorConceptoImpresion.aspx?a=" & Me.ddlAnio.SelectedValue & "&e=" & Me.ddlEmpresa.SelectedValue & "&b=" & IIf(Me.ddlEmpresa.SelectedValue = 3, Me.ddlAgrupado.SelectedValue, 0)

            Dim script As String = "window.open('" + url + "','','scrollbars=yes,width='+screen.width+',height='+screen.height+',left=0,top=0');"
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>setTimeout(function(){MuestraAgrupar('" & Me.ddlEmpresa.SelectedValue & "')}, 1000);</script>", False)
            ScriptManager.RegisterClientScriptBlock(Me.Page, Me.Page.GetType(), "NewWindow", script, True)

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub



End Class

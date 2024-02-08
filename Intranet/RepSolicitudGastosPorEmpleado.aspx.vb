Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class RepSolicitudGastosPorEmpleado
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
            Me.ddlAnio.SelectedValue = Now.Year

            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.ddlEmpresa.Items.Clear()
            Me.ddlEmpresa.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpresaRepSolicitudes(Session("idEmpleado"), "rep_rep_gas"), "nombre", "id_empresa"))


            Me.ddlEmpleado.Items.Clear()
            Me.ddlEmpleado.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpleadosRepSolicitudes(Me.ddlEmpresa.SelectedValue, Session("idEmpleado"), "rep_rep_gas", TranslateLocale.text("--Seleccione--")), "nombre", "id_empleado"))

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub



    Private Sub btnGenerarReporte_Click(sender As Object, e As EventArgs) Handles btnGenerarReporte.Click
        Try
            If Me.ddlEmpleado.SelectedValue = 0 Then
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Seleccione un empleado');</script>", False)
                Exit Sub
            End If

            Dim url As String = ""
            url = "RepSolicitudGastosPorEmpleadoImpresion.aspx?a=" & Me.ddlAnio.SelectedValue & "&e=" & Me.ddlEmpresa.SelectedValue & "&em=" & Me.ddlEmpleado.SelectedValue

            Dim script As String = "window.open('" + url + "','','scrollbars=yes,width='+screen.width+',height='+screen.height+',left=0,top=0')"
            ScriptManager.RegisterClientScriptBlock(Me.Page, Me.Page.GetType(), "NewWindow", script, True)

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub



    Private Sub ddlEmpresa_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlEmpresa.SelectedIndexChanged
        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ddlEmpleado.DataSource = combos.RecuperaEmpleadosRepSolicitudes(Me.ddlEmpresa.SelectedValue, Session("idEmpleado"), "rep_rep_gas", "--Seleccione--")
        Me.ddlEmpleado.DataValueField = "id_empleado"
        Me.ddlEmpleado.DataTextField = "nombre"
        Me.ddlEmpleado.DataBind()
    End Sub
End Class

Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class RepVacacionesVencidas
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.CargaCombos()
            Me.dtFechaIni.SelectedDate = Now.AddDays(-30)
            Me.dtFechaFin.SelectedDate = Now
        End If
        Me.btnGenerarReporte.OnClientClick = "this.disabled = true; this.value = '" & TranslateLocale.text("Generando Reporte") & "...';"
        Me.btnGenerarReporte.Text = TranslateLocale.text("Generar Reporte")

    End Sub

    Private Sub CargaCombos()
        Try

            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            'Me.ddlEmpresa.DataSource = combos.RecuperaEmpresaRepSolicitudes(Session("idEmpleado"), "rep_sol_vac")
            'Me.ddlEmpresa.DataValueField = "id_empresa"
            'Me.ddlEmpresa.DataTextField = "nombre"
            'Me.ddlEmpresa.DataBind()


            'Me.ddlEmpleado.DataSource = combos.RecuperaEmpleadosRepSolicitudes(Me.ddlEmpresa.SelectedValue, Session("idEmpleado"), "rep_sol_vac")
            'Me.ddlEmpleado.DataValueField = "id_empleado"
            'Me.ddlEmpleado.DataTextField = "nombre"
            'Me.ddlEmpleado.DataBind()


            Me.ddlEmpresa.Items.Clear()
            Me.ddlEmpresa.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpresaRepSolicitudes(Session("idEmpleado"), "rep_sol_vac"), "nombre", "id_empresa"))


            Me.ddlEmpleado.Items.Clear()
            Me.ddlEmpleado.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpleadosRepSolicitudes(Me.ddlEmpresa.SelectedValue, Session("idEmpleado"), "rep_sol_vac"), "nombre", "id_empleado"))


        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub


    Private Sub ValidaSeleccionReporte()
        Dim msg As String = ""

        If msg.Length > 0 Then
            Throw New Exception("Favor de capturar la siguiente información:\n" & msg)
        End If

    End Sub

    Private Sub btnGenerarReporte_Click(sender As Object, e As EventArgs) Handles btnGenerarReporte.Click
        Try
            ValidaSeleccionReporte()

            Dim url As String
            url = "RepVacacionesVencidasImpresion.aspx?id_empresa=" & Me.ddlEmpresa.SelectedValue.ToString _
                                                    & "&id_empleado=" & Me.ddlEmpleado.SelectedValue.ToString _
                                                    & "&fecha_ini=" & Me.dtFechaIni.SelectedDate.Value.ToString("yyyyMMdd") _
                                                    & "&fecha_fin=" & Me.dtFechaFin.SelectedDate.Value.ToString("yyyyMMdd")

            Dim script As String = "window.open('" + url + "','')"
            ScriptManager.RegisterClientScriptBlock(Me.Page, Me.Page.GetType(), "NewWindow", script, True)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub ddlEmpresa_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlEmpresa.SelectedIndexChanged

        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ddlEmpleado.DataSource = combos.RecuperaEmpleadosRepSolicitudes(Me.ddlEmpresa.SelectedValue, Session("idEmpleado"), "rep_sol_vac")
        Me.ddlEmpleado.DataValueField = "id_empleado"
        Me.ddlEmpleado.DataTextField = "nombre"
        Me.ddlEmpleado.DataBind()
    End Sub
End Class

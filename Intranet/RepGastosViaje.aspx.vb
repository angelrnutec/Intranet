Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class RepGastosViaje
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
            Me.dtFechaIni.SelectedDate = DateTime.Now.AddDays(-30)
            Me.dtFechaFin.SelectedDate = DateTime.Now


            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.ddlEmpresa.Items.Clear()
            Me.ddlEmpresa.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpresaRepSolicitudes(Session("idEmpleado"), "rep_gas_via"), "nombre", "id_empresa"))


            Me.ddlEstatus.Items.Clear()
            Me.ddlEstatus.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEstatusRepGastosViaje(), "descripcion", "id_estatus"))


            Me.ddlEmpleado.Items.Clear()
            Me.ddlEmpleado.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpleadosRepSolicitudes(Me.ddlEmpresa.SelectedValue, Session("idEmpleado"), "rep_sol_vac"), "nombre", "id_empleado"))


            Me.ddlCancelada.Items.Add(New ListItem(TranslateLocale.text("--Todas--"), 0))
            Me.ddlCancelada.Items.Add(New ListItem(TranslateLocale.text("Solo Activas"), 1))
            Me.ddlCancelada.Items.Add(New ListItem(TranslateLocale.text("Solo Canceladas"), 2))


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
            url = "RepGastosViajeImpresion.aspx?fec_ini=" & CType(Me.dtFechaIni.SelectedDate, Date).ToString("yyyyMMdd") _
                                            & "&fec_fin=" & CType(Me.dtFechaFin.SelectedDate, Date).ToString("yyyyMMdd") _
                                            & "&id_empresa=" & Me.ddlEmpresa.SelectedValue.ToString _
                                            & "&id_estatus=" & Me.ddlEstatus.SelectedValue.ToString _
                                            & "&id_empleado=" & Me.ddlEmpleado.SelectedValue.ToString _
                                            & "&cancelada=" & Me.ddlCancelada.SelectedValue.ToString


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

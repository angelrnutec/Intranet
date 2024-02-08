Imports IntranetBL

Public Class TelcelRepTotLinea
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.CargaCombos()
        End If

    End Sub

    Private Sub CargaCombos()
        Try
            For i As Integer = Now.AddMonths(1).Year To 2013 Step -1
                Me.ddlAnio.Items.Add(i)
            Next

            Me.ddlAnio.SelectedValue = Now.Year

            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.ddlEmpresa.DataSource = combos.RecuperaEmpresaRepTelefonia(Session("idEmpleado"), "telcel_rep_consumos")
            Me.ddlEmpresa.DataValueField = "id_empresa"
            Me.ddlEmpresa.DataTextField = "nombre"
            Me.ddlEmpresa.DataBind()

            Me.ddlEmpleado.DataSource = combos.RecuperaEmpleadosRepTelefonia(Me.ddlEmpresa.SelectedValue, Session("idEmpleado"), "telcel_rep_consumos")
            Me.ddlEmpleado.DataValueField = "numero"
            Me.ddlEmpleado.DataTextField = "nombre"
            Me.ddlEmpleado.DataBind()

            Me.ddlCompania.DataSource = combos.RecuperaProveedorTelefonica()
            Me.ddlCompania.DataValueField = "id_proveedor"
            Me.ddlCompania.DataTextField = "nombre"
            Me.ddlCompania.DataBind()

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
            url = "TelcelRepTotLineaImpresion.aspx?anio=" & Me.ddlAnio.SelectedValue _
                                                    & "&id_empresa=" & Me.ddlEmpresa.SelectedValue.ToString _
                                                    & "&id_empleado=" & Me.ddlEmpleado.SelectedValue.ToString _
                                                    & "&id_proveedor=" & Me.ddlCompania.SelectedValue.ToString

            Dim script As String = "window.open('" + url + "','','scrollbars=yes,width='+screen.width+',height='+screen.height+',left=0,top=0')"
            ScriptManager.RegisterClientScriptBlock(Me.Page, Me.Page.GetType(), "NewWindow", script, True)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub ddlEmpresa_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlEmpresa.SelectedIndexChanged

        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ddlEmpleado.DataSource = combos.RecuperaEmpleadosRepTelefonia(Me.ddlEmpresa.SelectedValue, Session("idEmpleado"), "telcel_rep_consumos")
        Me.ddlEmpleado.DataValueField = "numero"
        Me.ddlEmpleado.DataTextField = "nombre"
        Me.ddlEmpleado.DataBind()
    End Sub
End Class

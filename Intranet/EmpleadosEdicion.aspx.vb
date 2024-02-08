Imports IntranetBL
Imports System.Web.Services

Public Class EmpleadosEdicion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.CargaCombos()
            If Request.QueryString("id") Is Nothing Then
                Me.txtIdEmpleado.Text = "0"
                Me.btnBaja.Visible = False
            Else
                Me.txtIdEmpleado.Text = Request.QueryString("id")
                Me.CargaDatos(Me.txtIdEmpleado.Text)
                Me.btnBaja.Visible = True
            End If

        End If
    End Sub

    Public Sub CargaCombos()
        Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        Me.ddlEmpresa.DataSource = empleado.RecuperaEmpresasEmpleado
        Me.ddlEmpresa.DataValueField = "id_empresa"
        Me.ddlEmpresa.DataTextField = "nombre"
        Me.ddlEmpresa.DataBind()

        Me.ddlDepartamento.DataSource = empleado.RecuperaDepartamentoPorEmpresa(Me.ddlEmpresa.SelectedValue)
        Me.ddlDepartamento.DataValueField = "clave"
        Me.ddlDepartamento.DataTextField = "nombre"
        Me.ddlDepartamento.DataBind()

    End Sub

    Private Sub CargaDatos(id As Integer)
        Try
            Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = empleado.RecuperaPorId(id)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                Me.ddlEmpresa.SelectedValue = dr("id_empresa")

                Me.ddlDepartamento.DataSource = empleado.RecuperaDepartamentoPorEmpresa(dr("id_empresa"))
                Me.ddlDepartamento.DataValueField = "clave"
                Me.ddlDepartamento.DataTextField = "nombre"
                Me.ddlDepartamento.DataBind()
                Me.ddlDepartamento.SelectedValue = dr("id_departamento")

                Me.dtFechaAlta.SelectedDate = dr("fecha_alta")
                Me.dtFechaNacimiento.SelectedDate = dr("fecha_nacimiento")
                Me.txtNombre.Text = dr("nombre")
                Me.txtNumero.Text = dr("numero")
                Me.txtNumDeudor.Text = dr("num_deudor")
                Me.txtNumAcreedor.Text = dr("num_acreedor")
                Me.txtCentroCosto.Text = dr("centro")


            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub


    Private Sub btnSalir_Click(sender As Object, e As EventArgs) Handles btnSalir.Click
        Response.Redirect("EmpleadosBusqueda.aspx")
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Me.ValidaCaptura()

            Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.txtIdEmpleado.Text = empleado.GuardaDatosEmpleado(Me.txtIdEmpleado.Text, _
                                                                    Me.txtNombre.Text, _
                                                                    Me.txtNumero.Text, _
                                                                    Me.ddlEmpresa.SelectedValue, _
                                                                    Me.ddlDepartamento.SelectedValue, _
                                                                    Me.dtFechaAlta.SelectedDate, _
                                                                    Me.dtFechaNacimiento.SelectedDate, _
                                                                    Me.txtNumDeudor.Text, _
                                                                    Me.txtNumAcreedor.Text, _
                                                                    Me.txtCentroCosto.Text)


            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Datos guardados con exito');window.location='/EmpleadosVer.aspx?id=" & Me.txtIdEmpleado.Text & "';</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub ValidaCaptura()
        Dim msg As String = ""
        If Me.txtNombre.Text.Trim = "" Then
            msg += " - Nombre\n"
        End If
        If Me.txtNumero.Text.Trim = "" Then
            msg += " - Numero\n"
        Else
            If NumeroEmpleadoRepetido(Me.txtNumero.Text, Me.txtIdEmpleado.Text) = True Then
                msg += " - El numero de empleado ya existe en la base de datos.\n"
            End If
        End If
        If Me.ddlEmpresa.SelectedValue = 0 Then
            msg += " - Empresa\n"
        End If

        If Me.ddlDepartamento.SelectedValue = 0 Then
            msg += " - Departamento\n"
        End If
        If Not IsDate(Me.dtFechaAlta.SelectedDate) Then
            msg += " - Fecha de Alta\n"
        End If
        If Not IsDate(Me.dtFechaNacimiento.SelectedDate) Then
            msg += " - Fecha de Nacimiento\n"
        Else
            If Me.dtFechaNacimiento.SelectedDate.Value.AddYears(10) > Now Then
                msg += " - Fecha de Nacimiento valida\n"
            End If
        End If

        If msg.Length > 0 Then
            Throw New Exception("Favor de capturar la siguiente información:\n" & msg)
        End If
    End Sub

    Private Function NumeroEmpleadoRepetido(numero As String, id_empleado As Integer) As Boolean
        Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Return empleado.NumeroEmpleadoRepetido(numero, id_empleado)
    End Function

    Private Sub ddlEmpresa_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlEmpresa.SelectedIndexChanged
        Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        Me.ddlDepartamento.DataSource = empleado.RecuperaDepartamentoPorEmpresa(Me.ddlEmpresa.SelectedValue)
        Me.ddlDepartamento.DataValueField = "clave"
        Me.ddlDepartamento.DataTextField = "nombre"
        Me.ddlDepartamento.DataBind()
    End Sub

    Private Sub btnBaja_Click(sender As Object, e As EventArgs) Handles btnBaja.Click
        Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        empleado.CambiarEstatusEmpleado(Me.txtIdEmpleado.Text, "I")

        ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Empleado dado de baja');window.location='/EmpleadosBusqueda.aspx';</script>", False)

    End Sub
End Class



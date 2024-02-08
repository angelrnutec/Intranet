Imports IntranetBL
Imports System.Web.Services

Public Class TelcelAsignacionEdita
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            CargaCombos()
        End If
    End Sub

    Private Sub CargaCombos()
        Dim telcel As New Telcel(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ddlEmpresa.DataSource = telcel.RecuperaEmpresas(Session("idEmpleado"), "telcel_asignacion", "--Seleccione--")
        Me.ddlEmpresa.DataValueField = "id_empresa"
        Me.ddlEmpresa.DataTextField = "nombre"
        Me.ddlEmpresa.DataBind()
        Me.ddlEmpresa.SelectedValue = Session("idEmpresa")

        Me.ddlEmpleado.DataSource = telcel.RecuperaEmpleados(Me.ddlEmpresa.SelectedValue, Session("idEmpleado"), "telcel_asignacion", "--Externo--")
        Me.ddlEmpleado.DataValueField = "id_empleado"
        Me.ddlEmpleado.DataTextField = "nombre"
        Me.ddlEmpleado.DataBind()
    End Sub

    Private Sub btnRegresar_Click(sender As Object, e As EventArgs) Handles btnRegresar.Click
        Response.Redirect("/TelcelAsignacion.aspx")
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Me.ValidaCaptura()

            Dim telcel As New Telcel(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            telcel.GuardaTelcelAsignacion(Me.txtTelefono.Text, Me.ddlEmpleado.SelectedValue, Session("idEmpleado"), IIf(Me.ddlEmpleado.SelectedValue > 0, Me.ddlEmpleado.SelectedItem.Text, Me.txtExterno.Text), Me.ddlEmpresa.SelectedValue)


            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Datos guardados con exito');window.location='/TelcelAsignacion.aspx';</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub ValidaCaptura()
        Dim msg As String = ""

        If Me.ddlEmpresa.SelectedValue = 0 Then
            msg += "Empresa\n"
        End If
        If Me.ddlEmpleado.SelectedValue = 0 Then
            If Me.txtExterno.Text.Trim.Length = 0 Then
                msg += "Nombre del Empleado Externo\n"
            End If
        End If

        If txtTelefono.Text.Length <> 10 Then
            msg += "El telefono debe ser de 10 digitos\n"
        Else
            Dim telcel As New Telcel(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dtAsigna As DataTable = telcel.ValidaTelcelAsignacion(txtTelefono.Text, Me.ddlEmpleado.SelectedValue)
            If dtAsigna.Rows.Count > 0 Then
                msg += "El numero ya esta asignado a otro empleado (" & dtAsigna.Rows(0)("empleado") & ")"
            End If
        End If


        If msg.Length > 0 Then
            Throw New Exception("Favor de capturar la siguiente información:\n" & msg)
        End If
    End Sub


    Private Sub ddlEmpresa_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlEmpresa.SelectedIndexChanged
        Dim telcel As New Telcel(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ddlEmpleado.DataSource = telcel.RecuperaEmpleados(Me.ddlEmpresa.SelectedValue, Session("idEmpleado"), "telcel_asignacion", "--Externo--")
        Me.ddlEmpleado.DataValueField = "id_empleado"
        Me.ddlEmpleado.DataTextField = "nombre"
        Me.ddlEmpleado.DataBind()

        If ddlEmpleado.SelectedValue = 0 Then
            Me.trExterno.Visible = True
        Else
            Me.trExterno.Visible = False
        End If

    End Sub

    Private Sub ddlEmpleado_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlEmpleado.SelectedIndexChanged
        If ddlEmpleado.SelectedValue = 0 Then
            Me.trExterno.Visible = True
        Else
            Me.trExterno.Visible = False
        End If
    End Sub
End Class
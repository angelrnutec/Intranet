Imports IntranetBL

Public Class CambiarPassword
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If

    End Sub

    Protected Sub btnRegresar_Click(sender As Object, e As EventArgs) Handles btnRegresar.Click
        Response.Redirect("/")
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Me.ValidaCaptura()

            Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            empleado.CambioPassword(Session("idEmpleado"), Me.txtPasswordAnterior.Text, Me.txtPasswordNuevo.Text)

            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Datos guardados con exito'); window.location = '/';</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub ValidaCaptura()
        Dim msg As String = ""

        If Me.txtPasswordNuevo.Text.Trim.Length = 0 Then
            msg += " - Password Nuevo\n"
        End If

        If Me.txtConfirmacionPassword.Text.Trim.Length = 0 Then
            msg += " - Confirmacion de Password\n"
        End If

        If Me.txtPasswordNuevo.Text.Trim.Length > 0 And Me.txtConfirmacionPassword.Text.Trim.Length > 0 Then
            If Me.txtPasswordNuevo.Text <> Me.txtConfirmacionPassword.Text Then
                msg += " - El Password Nuevo y la Confirmacion de Password no coinciden\n"
            End If
        End If

        If msg.Length > 0 Then
            Throw New Exception("Favor de capturar la siguiente información:\n" & msg)
        End If
    End Sub
End Class
Imports IntranetBL

Public Class GenerarPasswordNuevo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings.[Get]("CONEXION"))
            txtUsuario.Text = seguridad.RecuperaResetearPassword(Request.QueryString("c"))
            If txtUsuario.Text = "" Then
                ScriptManager.RegisterStartupScript(lblPopUp, lblPopUp.[GetType](), "script", "<script>alert('Este URL es invalido');window.location='/';</script>", False)
            End If

            If Request.QueryString("nom") = "1" Then
                Me.lblNominas.Text = "(CONSULTA DE NOMINAS)"
            End If
            If Request.QueryString("vencida") = "1" Then
                Me.lblVencida.Text = "Su contrase&ntilde;a ha expirado. "
            End If
        End If
    End Sub


    Protected Sub ValidaFormulario()
        Try
            Dim msg As New StringBuilder()

            If Me.txtPassword.Text.Trim().Length = 0 Then
                msg.Append("- Contrase&ntilde;a\n")
            Else
                If Me.txtPassword2.Text.Trim() <> Me.txtPassword.Text.Trim() Then
                    msg.Append("- Las contrase&ntilde;as no coinciden\n")
                End If
            End If

            If msg.Length > 0 Then
                Throw New Exception("Favor de proporcionar la siguiente información\n\n" & msg.ToString())
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub btnContinuar_Click(sender As Object, e As EventArgs) Handles btnContinuar.Click
        Try
            ValidaFormulario()

            Dim clave As String = System.Guid.NewGuid.ToString
            Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings.[Get]("CONEXION"))
            If Request.QueryString("nom") = "1" Then
                seguridad.PasswordNominaGuarda(Me.txtUsuario.Text, Me.txtPassword.Text)
            Else
                seguridad.RegeneraPasswordGuarda(Me.txtUsuario.Text, Me.txtPassword.Text)
            End If

            ScriptManager.RegisterStartupScript(lblPopUp, lblPopUp.[GetType](), "script", "<script>alert('Su nueva contraseña se guardo correctamente.');window.location='/';</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(lblPopUp, lblPopUp.[GetType](), "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub


End Class
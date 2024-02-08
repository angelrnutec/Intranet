Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class GenerarPassword
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Me.btnContinuar.Text = TranslateLocale.text("Generar Nuevo Password")
    End Sub


    Protected Sub ValidaFormulario()
        Try
            Dim msg As New StringBuilder()

            If Me.txtUsuario.Text.Trim().Length = 0 Then
                msg.Append("- Usuario\n")
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
            seguridad.RegeneraPassword(Me.txtUsuario.Text, HttpContext.Current.Request.UserHostAddress, clave)

            Me.EnviaEmail(clave)

            ScriptManager.RegisterStartupScript(lblPopUp, lblPopUp.[GetType](), "script", "<script>alert('Se le ha enviado un email con instrucciones para generar una nueva contraseña');window.location='/';</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(lblPopUp, lblPopUp.[GetType](), "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub


    Private Sub EnviaEmail(clave As String)
        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Try
            Dim email_para As String = ""
            Dim email_de As String = ""
            Dim email_usuario As String = ""
            Dim email_asunto As String = ""
            Dim email_smtp As String = ""
            Dim email_password As String = ""
            Dim email_port As String = ""
            Dim email_copia As String = ""
            Dim email_url_base As String = ""
            Dim errorMsg As String = ""
            Dim email_body As New StringBuilder("")
            Dim folio As String = ""
            Dim id_cliente As Integer = 0
            Dim archivos As String = ""


            email_smtp = System.Configuration.ConfigurationManager.AppSettings("SMTP_SERVER").ToString()
            email_usuario = System.Configuration.ConfigurationManager.AppSettings("SMTP_USER").ToString()
            email_password = System.Configuration.ConfigurationManager.AppSettings("SMTP_PASS").ToString()
            email_port = System.Configuration.ConfigurationManager.AppSettings("SMTP_PORT").ToString()
            email_de = System.Configuration.ConfigurationManager.AppSettings("SMTP_FROM").ToString()
            email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
            email_asunto = "Intranet Nutec - Generar nueva contraseña"

            email_para = Me.txtUsuario.Text

            email_body.AppendLine("Estimado Usuario,<br />")
            email_body.AppendLine("Recibimos una solicitud para generar una nueva contraseña de su cuenta.<br /><br />")
            email_body.AppendLine("Si usted no envió esta solicitud, haga caso omiso a este correo.<br /><br />")
            email_body.AppendLine("Si desea cambiar su contraseña de click en la siguiente URL:<br />")
            email_body.AppendLine("<a href='" & email_url_base & "/GenerarPasswordNuevo.aspx?c=" & clave & "'>" & email_url_base & "/GenerarPasswordNuevo.aspx?c=" & clave & "</a>")
            email_body.AppendLine("<br /><br />Nota: Este URL solo tendrá validez de 24 horas.")


            Try
                Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body.ToString(), email_copia, "")
                seguridad.GuardaLogDatos("EnvioRegeneraPassword: (" & email_usuario & ")  " & resultado & "::::" & email_para)
            Catch ex As Exception
                seguridad.GuardaLogDatos("EnvioRegeneraPassword: (" & email_usuario & ") Error " & email_para & ", " & ex.Message())
            End Try

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

End Class
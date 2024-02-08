Imports IntranetBL
Imports System.Web.Services

Public Class ConsultaReciboNomina
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If

        If Not Page.IsPostBack Then
            Me.CargaCombos()
            trRecibo.Visible = False

            If Session("tienePasswordNomina") = "1" Then
                Me.divConsultaQuincena.Visible = False
                Me.divNuevoPassword.Visible = False
                If Session("sesionNomina") = Nothing Then
                    Me.divLoginNomina.Visible = True
                Else
                    Me.divConsultaQuincena.Visible = True
                End If
            Else
                Me.divLoginNomina.Visible = False
                Me.divConsultaQuincena.Visible = False
                Me.divNuevoPassword.Visible = True
            End If


        End If
        'Me.iFrmRecibo.Attributes.Add("onload", "MuestraLoading();")

    End Sub

    Private Sub CargaCombos()
        Try

            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = combos.RecuperaQuincenasEmpleado("S", Session("idEmpleado"))

            If dt.Rows.Count > 1 Then
                Me.ddlQuincena.DataSource = dt
                Me.ddlQuincena.DataValueField = "periodo"
                Me.ddlQuincena.DataTextField = "descripcion"
                Me.ddlQuincena.DataBind()
                ''Me.trMensaje.Visible = False
            Else
                Me.divConsultaQuincena.Visible = False
                Me.trRecibo.Visible = False
                ''Me.trMensaje.Visible = True                
            End If


        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

  
    'Private Sub btnRegresar_Click(sender As Object, e As EventArgs) Handles btnRegresar.Click
    '    Response.Redirect("/")
    'End Sub

  
    Protected Sub ddlQuincena_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlQuincena.SelectedIndexChanged
        If ddlQuincena.SelectedValue.ToString().Split("|")(0) <> "0" Then
            Me.trRecibo.Visible = True

            Dim periodo As String = ddlQuincena.SelectedValue.ToString().Split("|")(0)
            Dim anio As String = ddlQuincena.SelectedValue.ToString().Split("|")(1)
            Dim num_empleado As String = ddlQuincena.SelectedValue.ToString().Split("|")(2)
            Dim empresa As String = ddlQuincena.SelectedValue.ToString().Split("|")(3)

            Me.iFrmRecibo.Attributes.Remove("onload")
            Me.iFrmRecibo.Attributes.Add("onload", "MuestraLoading();")
            Me.iFrmRecibo.Attributes.Remove("src")
            Me.iFrmRecibo.Attributes.Add("src", "http://starksystem.com/intranet/recibo.asp?empleado=" & num_empleado & "&anio=" & anio & "&periodo=" & periodo & "&empresa=" & empresa & "&key=245462342389504")

            Call RevisaFirmas(anio, periodo, Session("idEmpleado"))

        Else
            Me.trRecibo.Visible = False
            Me.msgBloqueo.Text = ""
            Me.btnAcepto.Visible = False
            Me.btnNoAcepto.Visible = False
            'Me.lblLeyenda.Visible = False
        End If


    End Sub


    Private Sub RevisaFirmas(anio As Integer, periodo As Integer, id_empleado As Integer)
        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings.[Get]("CONEXION"))
        seguridad.GuardaNominaFirma(id_empleado, anio, periodo, "CONSULTA")

        Dim ds As DataSet = seguridad.RecuperaNominaFirma(id_empleado, anio, periodo)
        Me.msgBloqueo.Text = ""

        Me.btnAcepto.Visible = True
        Me.btnNoAcepto.Visible = True
        'Me.lblLeyenda.Visible = True
        Me.btnAcepto.Enabled = True
        Me.btnNoAcepto.Enabled = True

        Dim dt As DataTable = ds.Tables(0)
        Dim dtNegativas As DataTable = ds.Tables(1)
        Dim tipo As String = ""
        Dim fecha_tipo As String = ""
        If dt.Rows.Count > 0 Then
            Dim dr As DataRow = dt.Rows(0)
            tipo = dr("tipo")
            fecha_tipo = Format(dr("fecha_registro"), "dd/MM/yyyy HH:mm")
        End If

        If tipo = "NO ACEPTO" And dtNegativas.Rows(0)("negativas") >= 3 Then
            ''PERIODO BLOQUEADO, CONSULTE A SU ADMINISTRADOR PARA DESBLOQUEARLO
            Me.msgBloqueo.Text = "Recibo bloqueado, consulte al administrador del sistema para desbloquearlo."
            Me.trRecibo.Visible = False
            Me.btnAcepto.Visible = False
            'Me.lblLeyenda.Visible = False
            Me.btnNoAcepto.Visible = False
        ElseIf dtNegativas.Rows(0)("anterior") <> "ACEPTO" Then
            '' ''PARA CONSULTAR EL PERIODO SELECCIONADO DEBE ACEPTAR SU RECIBO DE NOMINAS ANTERIOR
            ''Me.msgBloqueo.Text = "Para consultar el recibo seleccionado, debe dar click en ACEPTO en el recibo anterior."
            ''Me.trRecibo.Visible = False
            ''Me.btnAcepto.Visible = False
            ' ''Me.lblLeyenda.Visible = False
            ''Me.btnNoAcepto.Visible = False
        ElseIf tipo = "ACEPTO" Then
            ''DESHABILITAR BOTONES
            If tipo = "ACEPTO" Or tipo = "NO ACEPTO" Then
                Me.msgBloqueo.Text = "Usted " & tipo & " este recibo (" & fecha_tipo & ")."
            End If
            'Me.lblLeyenda.Visible = True
            Me.btnAcepto.Enabled = False
            Me.btnNoAcepto.Enabled = False
        ElseIf tipo = "NO ACEPTO" Then
            ''DESHABILITAR BOTONES
            If tipo = "ACEPTO" Or tipo = "NO ACEPTO" Then
                Me.msgBloqueo.Text = "Usted " & tipo & " este recibo (" & fecha_tipo & ")."
                'Me.lblLeyenda.Visible = True
            End If
        End If

    End Sub

    Private Sub btnContinuar_Click(sender As Object, e As EventArgs) Handles btnContinuar.Click
        Try
            ValidaFormulario()

            ''Dim clave As String = System.Guid.NewGuid.ToString
            Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings.[Get]("CONEXION"))
            seguridad.PasswordNominaGuarda(Session("empleadoUsuario"), Me.txtPassword.Text)

            Session("tienePasswordNomina") = "1"

            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.[GetType](), "script", "<script>alert('Su nueva contraseña se guardo correctamente.');window.location='/ConsultaReciboNomina.aspx';</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.[GetType](), "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub


    Protected Sub ValidaFormulario()
        Try
            Dim msg As New StringBuilder("")

            If Me.txtPassword.Text.Trim().Length < 4 Then
                msg.Append("- Contraseña de al menos 4 caracteres\n")
            Else
                If Me.txtPassword2.Text.Trim() <> Me.txtPassword.Text.Trim() Then
                    msg.Append("- Las contraseñas no coinciden\n")
                End If
            End If

            If msg.Length > 0 Then
                Throw New Exception("Favor de proporcionar la siguiente información\n\n" & msg.ToString())
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub btnLogin_Click(sender As Object, e As EventArgs) Handles btnLogin.Click
        Try
            ValidaFormularioLogin()

            ''Dim clave As String = System.Guid.NewGuid.ToString
            Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings.[Get]("CONEXION"))
            Dim dsLogin As DataSet = seguridad.NominaLogin(Session("idEmpleado"), Me.txtPass.Text)
            Dim dtRegenera As DataTable = dsLogin.Tables(0)
            If dtRegenera.Rows(0)("reset_password") <> "" Then
                Dim email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
                Response.Redirect(email_url_base & "/GenerarPasswordNuevo.aspx?nom=1&vencida=1&c=" & dtRegenera.Rows(0)("reset_password"))
            Else
                If dsLogin.Tables(1).Rows.Count > 0 Then
                    Session("sesionNomina") = "1"
                    ScriptManager.RegisterStartupScript(Me.Page, Me.Page.[GetType](), "script", "<script>window.location='/ConsultaReciboNomina.aspx';</script>", False)
                Else
                    ScriptManager.RegisterStartupScript(Me.Page, Me.Page.[GetType](), "script", "<script>alert('Contraseña invalida para consulta de nominas.');</script>", False)
                End If
            End If


        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.[GetType](), "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try

    End Sub

    Protected Sub ValidaFormularioLogin()
        Try
            Dim msg As New StringBuilder("")

            If Me.txtPass.Text.Trim().Length < 0 Then
                msg.Append("- Contraseña de nomina\n")
            End If

            If msg.Length > 0 Then
                Throw New Exception("Favor de proporcionar la siguiente información\n\n" & msg.ToString())
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub lnkGeneraPasswordNomina_Click(sender As Object, e As EventArgs) Handles lnkGeneraPasswordNomina.Click
        Try
            Dim clave As String = System.Guid.NewGuid.ToString
            Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings.[Get]("CONEXION"))
            seguridad.RegeneraPassword(Session("empleadoUsuario"), HttpContext.Current.Request.UserHostAddress, clave)

            Me.EnviaEmail(clave)

            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.[GetType](), "script", "<script>alert('Se le ha enviado un email con instrucciones para generar una nueva contraseña');window.location='/';</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.[GetType](), "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
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
            email_asunto = "Intranet Nutec - Generar nueva contraseña (CONSULTA DE NOMINA)"

            email_para = Session("empleadoEmail").ToString()

            email_body.AppendLine("Estimado Usuario,<br />")
            email_body.AppendLine("Recibimos una solicitud para generar una nueva contraseña para consulta de nomina.<br /><br />")
            email_body.AppendLine("Si usted no envió esta solicitud, haga caso omiso a este correo.<br /><br />")
            email_body.AppendLine("Si desea cambiar su contraseña de click en la siguiente URL:<br />")
            email_body.AppendLine("<a href='" & email_url_base & "/GenerarPasswordNuevo.aspx?nom=1&c=" & clave & "'>" & email_url_base & "/GenerarPasswordNuevo.aspx?nom=1&c=" & clave & "</a>")
            email_body.AppendLine("<br /><br />Nota: Este URL solo tendrá validez de 24 horas.")


            Try
                Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body.ToString(), email_copia, "")
                seguridad.GuardaLogDatos("EnvioRegeneraPasswordNomina: (" & email_usuario & ")  " & resultado & "::::" & email_para)
            Catch ex As Exception
                seguridad.GuardaLogDatos("EnvioRegeneraPasswordNomina: (" & email_usuario & ") Error " & email_para & ", " & ex.Message())
            End Try

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub btnAcepto_Click(sender As Object, e As EventArgs) Handles btnAcepto.Click
        Dim periodo As String = ddlQuincena.SelectedValue.ToString().Split("|")(0)
        Dim anio As String = ddlQuincena.SelectedValue.ToString().Split("|")(1)
        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings.[Get]("CONEXION"))
        seguridad.GuardaNominaFirma(Session("idEmpleado"), anio, periodo, "ACEPTO")
        Response.Redirect("/ConsultaReciboNomina.aspx")
    End Sub

    Private Sub btnNoAcepto_Click(sender As Object, e As EventArgs) Handles btnNoAcepto.Click
        Dim periodo As String = ddlQuincena.SelectedValue.ToString().Split("|")(0)
        Dim anio As String = ddlQuincena.SelectedValue.ToString().Split("|")(1)
        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings.[Get]("CONEXION"))
        seguridad.GuardaNominaFirma(Session("idEmpleado"), anio, periodo, "NO ACEPTO")
        Response.Redirect("/ConsultaReciboNomina.aspx")
    End Sub
End Class

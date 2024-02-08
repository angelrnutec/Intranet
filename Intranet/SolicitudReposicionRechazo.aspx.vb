Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class SolicitudReposicionRechazo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.ProcesaSolicitud()
        End If
    End Sub


    Private Sub ProcesaSolicitud()
        Dim id_solicitud As String = Request.QueryString("id")
        Dim tipo As String = Request.QueryString("tipo")
        Dim motivo As String = Request.QueryString("motivo")


        Try
            Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            solicitud_reposicion.CambiaEstatusMail(id_solicitud, Session("idEmpleado"), tipo, False)
            solicitud_reposicion.GuardaMotivoRechazo(id_solicitud, motivo)

            If tipo = 3 Or tipo = 4 Or tipo = 5 Or tipo = 7 Then   ''COMPROBACION DE GASTOS RECHAZADA
                EnviarEmailRechazo(id_solicitud, tipo, 1)
            Else
                EnviarEmailRechazo(id_solicitud, tipo, 2)
            End If

        Catch ex As Exception
        End Try
        Response.Redirect("/SolicitudReposicion.aspx")

    End Sub




    Private Sub EnviarEmailRechazo(ByVal id_solicitud As Integer, ByVal tipo As Integer, ByVal rechazo As Integer)
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
            Dim email_url_base_local As String = ""
            Dim errorMsg As String = ""
            Dim email_body As String
            Dim folio As String = ""
            Dim id_cliente As Integer = 0
            Dim archivos As String = ""

            Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = solicitud_reposicion.RecuperaInfoEmail(id_solicitud)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                email_smtp = System.Configuration.ConfigurationManager.AppSettings("SMTP_SERVER").ToString()
                email_usuario = System.Configuration.ConfigurationManager.AppSettings("SMTP_USER").ToString()
                email_password = System.Configuration.ConfigurationManager.AppSettings("SMTP_PASS").ToString()
                email_port = System.Configuration.ConfigurationManager.AppSettings("SMTP_PORT").ToString()
                email_de = System.Configuration.ConfigurationManager.AppSettings("SMTP_FROM").ToString()
                email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
                email_url_base_local = System.Configuration.ConfigurationManager.AppSettings("URL_BASE_LOCAL").ToString()


                If dr("email_solicita").ToString.Length > 0 Then
                    email_para = dr("email_solicita")
                End If

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                If rechazo = 1 Then
                    email_asunto = TranslateLocale.text("Comprobantes de Gastos Rechazados", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                Else
                    email_asunto = TranslateLocale.text("Solicitud de Reposicion Rechazada", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                End If

                email_body = RetrieveHttpContent(email_url_base_local & "/Email_Formatos/EnvioSolicitudReposicionComprobantes.aspx?id=" & id_solicitud & "&t=C&r=" & rechazo, errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")
                    seguridad.GuardaLogDatos("EnvioSolicitudReposicionComprobantes: " & resultado & "::::" & email_para & " tipo = " & tipo & "---->" & email_url_base_local & "/Email_Formatos/EnvioSolicitudReposicionComprobantes.aspx?id=" & id_solicitud & "&t=C&r=1")
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudReposicionComprobantes: Error " & email_para & ", " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub



    Private Sub EnviarEmail(ByVal id_solicitud As Integer, ByVal tipo As Integer)
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
            Dim email_url_base_local As String = ""
            Dim errorMsg As String = ""
            Dim email_body As String
            Dim folio As String = ""
            Dim id_cliente As Integer = 0
            Dim archivos As String = ""

            Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = solicitud_reposicion.RecuperaInfoEmail(id_solicitud)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                email_smtp = System.Configuration.ConfigurationManager.AppSettings("SMTP_SERVER").ToString()
                email_usuario = System.Configuration.ConfigurationManager.AppSettings("SMTP_USER").ToString()
                email_password = System.Configuration.ConfigurationManager.AppSettings("SMTP_PASS").ToString()
                email_port = System.Configuration.ConfigurationManager.AppSettings("SMTP_PORT").ToString()
                email_de = System.Configuration.ConfigurationManager.AppSettings("SMTP_FROM").ToString()
                email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
                email_url_base_local = System.Configuration.ConfigurationManager.AppSettings("URL_BASE_LOCAL").ToString()

                If dr("email_conta").ToString.Length > 0 Then
                    email_para = dr("email_conta")
                Else
                    email_para = System.Configuration.ConfigurationManager.AppSettings("EMAIL_DEFAULT").ToString()
                End If

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                email_asunto = TranslateLocale.text("Solicitud de Autorizacion de Comprobantes de Gastos", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                email_body = RetrieveHttpContent(email_url_base_local & "/Email_Formatos/EnvioSolicitudReposicion.aspx?id=" & id_solicitud & "&t=C", errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioSolicitudReposicion: " & resultado & "::::" & email_para & " tipo = " & tipo & "---->" & email_url_base & "/Email_Formatos/EnvioSolicitudReposicion.aspx?id=" & id_solicitud & "&t=C")
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudReposicion: Error " & email_para & ", " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub




    Private Sub EnviarSolicitudComprobantes(id_solicitud As Integer)
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
            Dim email_url_base_local As String = ""
            Dim errorMsg As String = ""
            Dim email_body As String
            Dim folio As String = ""
            Dim id_cliente As Integer = 0
            Dim archivos As String = ""

            Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = solicitud_reposicion.RecuperaInfoEmail(id_solicitud)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                email_smtp = System.Configuration.ConfigurationManager.AppSettings("SMTP_SERVER").ToString()
                email_usuario = System.Configuration.ConfigurationManager.AppSettings("SMTP_USER").ToString()
                email_password = System.Configuration.ConfigurationManager.AppSettings("SMTP_PASS").ToString()
                email_port = System.Configuration.ConfigurationManager.AppSettings("SMTP_PORT").ToString()
                email_de = System.Configuration.ConfigurationManager.AppSettings("SMTP_FROM").ToString()
                email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
                email_url_base_local = System.Configuration.ConfigurationManager.AppSettings("URL_BASE_LOCAL").ToString()


                If dr("email_solicita").ToString.Length > 0 Then
                    email_para = dr("email_solicita")
                Else
                    email_para = System.Configuration.ConfigurationManager.AppSettings("EMAIL_DEFAULT").ToString()
                End If

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                email_asunto = TranslateLocale.text("Recordatorio de entrega de comprobantes de Gastos", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                email_body = RetrieveHttpContent(email_url_base_local & "/Email_Formatos/EnvioSolicitudReposicionEntregaComp.aspx?id=" & id_solicitud, errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")
                    seguridad.GuardaLogDatos("EnvioSolicitudReposicionEntregaComp: " & resultado & "::::" & email_para & "---->" & email_url_base & "/Email_Formatos/EnvioSolicitudReposicionEntregaComp.aspx?id=" & id_solicitud)
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudReposicionEntregaComp: Error " & email_para & ", " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub




    Function EmailAddressCheck(ByVal emailAddress As String) As Boolean

        Dim pattern As String = "^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$"
        Dim emailAddressMatch As Match = Regex.Match(emailAddress, pattern)
        If emailAddressMatch.Success Then
            EmailAddressCheck = True
        Else
            EmailAddressCheck = False
        End If

    End Function

    Public Shared Function RetrieveHttpContent(Url As String, ByRef ErrorMessage As String) As String
        Dim MergedText As String = ""
        Dim Http As New System.Net.WebClient()
        Try
            Dim Result As Byte() = Http.DownloadData(Url)
            Result = ConvertUtf8ToLatin1(Result)
            MergedText = System.Text.Encoding.GetEncoding(28591).GetString(Result)
        Catch ex As Exception
            ErrorMessage = ex.Message.Replace(CChar(ChrW(39)), CChar(ChrW(34)))
            Return Nothing
        End Try
        Return MergedText
    End Function

    Public Shared Function ConvertUtf8ToLatin1(bytes As Byte()) As Byte()
        Dim latin1 As System.Text.Encoding = System.Text.Encoding.GetEncoding(&H6FAF)
        Return System.Text.Encoding.Convert(System.Text.Encoding.UTF8, latin1, bytes)
    End Function
End Class
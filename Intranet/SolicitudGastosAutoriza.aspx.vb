Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class SolicitudGastosAutoriza
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.ProcesaSolicitud()
        End If
    End Sub


    Private Sub ProcesaSolicitud()
        Dim id_solicitud As String = Request.QueryString("id")
        Dim tipo As String = Request.QueryString("t")
        Dim valor As String = Request.QueryString("auth")
        Dim id_empleado As String = Request.QueryString("ida")

        If id_solicitud Is Nothing _
            Or tipo Is Nothing _
            Or valor Is Nothing _
            Or id_empleado Is Nothing Then

            Me.divTexto.InnerText = "SOLICITUD INVALIDA"
            Exit Sub
        End If

        If Not IsNumeric(id_solicitud) _
            Or Not IsNumeric(tipo) _
            Or Not IsNumeric(valor) _
            Or Not IsNumeric(id_empleado) Then

            Me.divTexto.InnerText = "SOLICITUD INVALIDA"
            Exit Sub
        End If

        Try
            Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())

            If valor = "1" Then
                Dim solicitud_gastos As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
                solicitud_gastos.CambiaEstatusMail(id_solicitud, id_empleado, tipo, IIf(valor = "1", True, False))


                If tipo = 1 Then
                    EnviarEmail(id_solicitud, tipo)
                    EnviarEmailSolicitante(id_solicitud, 1)
                ElseIf tipo = 2 Then
                    solicitud_gastos.ActualizaTipoCambio(id_solicitud)


                    Dim num_tarjeta_gastos As String = ""
                    Dim anticipo_total As Decimal = 0
                    Dim ajuste_total As Decimal = 0
                    solicitud_gastos.RecuperaInfoTicketEmpresarial(id_solicitud, num_tarjeta_gastos, anticipo_total, ajuste_total)


                    ' RM: DEBUG
                    Seguridad.GuardaLogDatos("TicketEmpresarialTransaccion: DEBUG: ModuloTicketEmpresarial:" & GlobalFunctions.ModuloTicketEmpresarial & ",  num_tarjeta_gastos:" & num_tarjeta_gastos & ",  anticipo_total:" & anticipo_total)

                    ' RM: Solicitar acreditación de fondos.
                    If GlobalFunctions.ModuloTicketEmpresarial And num_tarjeta_gastos <> "" And anticipo_total > 0 Then
                        Try

                            Dim te As New TicketEmpresarial(GlobalFunctions.ClientIdTicketEmpresarial,
                                                            GlobalFunctions.TokenTicketEmpresarial,
                                                            GlobalFunctions.UserTicketEmpresarial,
                                                            GlobalFunctions.PasswordTicketEmpresarial,
                                                            System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

                            Dim te_trans As TicketEmpresarialTransaccion = te.AddBalance(num_tarjeta_gastos, anticipo_total)
                            te_trans.id_solicitud = id_solicitud
                            te_trans.id_usuario = id_empleado
                            te.GuardaTransaccion(te_trans)

                            If te_trans.exitoso = True Then
                                EnviarEmailAnticipo(id_solicitud, "Tarjeta: " & num_tarjeta_gastos & ", Importe Asignado: " & te_trans.importe_autorizado.ToString("#,###,##0.00") & ", Núm. de Autorización: " & te_trans.numero_autorizacion)
                                EnviarEmailSolicitante(id_solicitud, 2, "Tarjeta: " & num_tarjeta_gastos & ", Importe Asignado: " & te_trans.importe_autorizado.ToString("#,###,##0.00") & ", Núm. de Autorización: " & te_trans.numero_autorizacion)
                            Else
                                ' Si no se pudo ejecutar el deposito, seguir el proceso normal.
                                EnviarEmailAnticipo(id_solicitud)
                                EnviarEmailSolicitante(id_solicitud, 2)

                                EnviarEmailErrorTicketEmpresarial(te_trans)
                            End If

                        Catch ex As Exception
                            seguridad.GuardaLogDatos("TicketEmpresarialTransaccion: id_solicitud:" & id_solicitud & "---->" & ex.Message)
                        End Try
                    Else
                        EnviarEmailAnticipo(id_solicitud)
                        EnviarEmailSolicitante(id_solicitud, 2)
                    End If

                ElseIf tipo = 3 Then
                    EnviarEmail(id_solicitud, tipo)
                    'Envio de Email al Solicitante y al Viajero con solicitud de comprobantes de Viaje 
                    EnviarSolicitudComprobantes(id_solicitud)
                ElseIf tipo = 4 Then


                    Dim num_tarjeta_gastos As String = ""
                    Dim anticipo_total As Decimal = 0
                    Dim ajuste_total As Decimal = 0
                    solicitud_gastos.RecuperaInfoTicketEmpresarial(id_solicitud, num_tarjeta_gastos, anticipo_total, ajuste_total)

                    ' RM: DEBUG
                    seguridad.GuardaLogDatos("TicketEmpresarialTransaccion: DEBUG: ModuloTicketEmpresarial:" & GlobalFunctions.ModuloTicketEmpresarial & ",  num_tarjeta_gastos:" & num_tarjeta_gastos & ",  anticipo_total:" & anticipo_total)


                    If GlobalFunctions.ModuloTicketEmpresarial And num_tarjeta_gastos <> "" And ajuste_total > 0 Then
                        Dim dtSolicitud As DataTable = solicitud_gastos.RecuperaPorId(id_solicitud, Session("idEmpleado"))
                        Dim id_empresa As Integer = dtSolicitud.Rows(0)("id_empresa")

                        Dim configuracion As New Configuracion(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
                        Dim retiro_automatico As String = configuracion.RecuperaConfiguracion("te-retiro-automartico-fondos", id_empresa)
                        If retiro_automatico = "Si" Then
                            Try
                                Dim te As New TicketEmpresarial(GlobalFunctions.ClientIdTicketEmpresarial,
                                                                GlobalFunctions.TokenTicketEmpresarial,
                                                                GlobalFunctions.UserTicketEmpresarial,
                                                                GlobalFunctions.PasswordTicketEmpresarial,
                                                                System.Configuration.ConfigurationManager.AppSettings("CONEXION"))


                                Dim te_trans As TicketEmpresarialTransaccion = te.AdjustBalance(num_tarjeta_gastos, ajuste_total)
                                te_trans.id_solicitud = id_solicitud
                                te_trans.id_usuario = id_empleado
                                te.GuardaTransaccion(te_trans)


                                If te_trans.exitoso = True Then
                                    EnviarEmailAjusteTicketEmpresarial(te_trans, num_tarjeta_gastos, "E")
                                    EnviarEmailAjusteTicketEmpresarial(te_trans, num_tarjeta_gastos, "C")
                                Else
                                    EnviarEmailErrorTicketEmpresarial(te_trans)
                                End If

                            Catch ex As Exception
                                seguridad.GuardaLogDatos("TicketEmpresarialTransaccion: id_solicitud:" & id_solicitud & "---->" & ex.Message)
                            End Try
                        End If
                    End If
                End If
            Else
                Me.divNormal.Visible = False
                Me.divRechazo.Visible = True
            End If




            Me.divTexto.InnerText = "Gracias, su respuesta ha sido registrada: " & IIf(valor = "1", "SOLICITUD AUTORIZADA", "SOLICITUD RECHAZADA")
        Catch ex As Exception
            Me.divTexto.InnerText = ex.Message
        End Try

    End Sub





    Private Sub EnviarEmailSolicitante(id_solicitud As Integer, tipo As Integer, Optional ticket_empresarial As String = "")
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

            Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = solicitud_gasto.RecuperaInfoEmail(id_solicitud)

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

                If dr("email_viaja").ToString.Length > 0 Then
                    email_copia = dr("email_viaja")
                Else
                    email_copia = System.Configuration.ConfigurationManager.AppSettings("EMAIL_DEFAULT").ToString()
                End If

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                Dim urlEmail As String = email_url_base_local & "/Email_Formatos/EnvioSolicitudGastoAutorizado.aspx?id=" & id_solicitud & "&tipo=" & tipo & "&ticket_empresarial=" & ticket_empresarial
                email_asunto = TranslateLocale.text("Solicitud Autorizada por", EMAIL_LOCALE) & " " & IIf(tipo = 1, TranslateLocale.text("Jefe Directo", EMAIL_LOCALE), TranslateLocale.text("Contabilidad", EMAIL_LOCALE)) & " (" & dr("folio_txt").ToString() & ")"
                email_body = RetrieveHttpContent(urlEmail, errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioSolicitudGastoAutorizado: " & resultado & "::::" & email_para & "---->" & urlEmail)
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudGastoAutorizado: Error " & email_para & ", " & ex.Message())
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

            Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = solicitud_gasto.RecuperaInfoEmail(id_solicitud)

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

                If dr("email_viaja").ToString.Length > 0 Then
                    email_copia = dr("email_viaja")
                Else
                    email_copia = System.Configuration.ConfigurationManager.AppSettings("EMAIL_DEFAULT").ToString()
                End If

                Dim urlEmail As String = email_url_base_local & "/Email_Formatos/EnvioSolicitudGastoEntregaComp.aspx?id=" & id_solicitud

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                email_asunto = TranslateLocale.text("Recordatorio de entrega de comprobantes de Gastos", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                email_body = RetrieveHttpContent(urlEmail, errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioSolicitudGastoEntregaComp: " & resultado & "::::" & email_para & "---->" & urlEmail)
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudGastoEntregaComp: Error " & email_para & ", " & ex.Message())
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

            Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = solicitud_gasto.RecuperaInfoEmail(id_solicitud)

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

                Dim urlEmail As String = ""
                If tipo = 1 Then
                    email_asunto = TranslateLocale.text("Solicitud de Gastos", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                    urlEmail = email_url_base_local & "/Email_Formatos/EnvioSolicitudGasto.aspx?id=" & id_solicitud & "&t=C"
                Else
                    email_asunto = TranslateLocale.text("Solicitud de Autorizacion de comprobantes de Viaje", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                    urlEmail = email_url_base_local & "/Email_Formatos/EnvioSolicitudGastoComprobantes.aspx?id=" & id_solicitud & "&t=C"
                    email_body = RetrieveHttpContent(urlEmail, errorMsg)
                End If
                email_body = RetrieveHttpContent(urlEmail, errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioSolicitudGasto: " & resultado & "::::" & email_para & "---->" & urlEmail)
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudGasto: Error " & email_para & ", " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub EnviarEmailAjusteTicketEmpresarial(ByVal te As TicketEmpresarialTransaccion, numero_tarjeta As String, tipo As String)
        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Dim id_solicitud As Integer = te.id_solicitud
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

            Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = solicitud_gasto.RecuperaInfoEmail(id_solicitud)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                email_smtp = System.Configuration.ConfigurationManager.AppSettings("SMTP_SERVER").ToString()
                email_usuario = System.Configuration.ConfigurationManager.AppSettings("SMTP_USER").ToString()
                email_password = System.Configuration.ConfigurationManager.AppSettings("SMTP_PASS").ToString()
                email_port = System.Configuration.ConfigurationManager.AppSettings("SMTP_PORT").ToString()
                email_de = System.Configuration.ConfigurationManager.AppSettings("SMTP_FROM").ToString()
                email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
                email_url_base_local = System.Configuration.ConfigurationManager.AppSettings("URL_BASE_LOCAL").ToString()


                If tipo = "E" Then
                    If dr("email_viaja").ToString.Length > 0 Then
                        email_para = dr("email_viaja")
                    Else
                        email_para = System.Configuration.ConfigurationManager.AppSettings("EMAIL_DEFAULT").ToString()
                    End If

                    If dr("email_solicita").ToString.Length > 0 Then
                        email_para += "," & dr("email_solicita")
                    End If
                Else
                    If dr("email_conta").ToString.Length > 0 Then
                        email_para += "," & dr("email_conta")
                    End If
                End If

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                Dim urlEmail As String = email_url_base_local & "/Email_Formatos/EnvioSolicitudGastoAjuste.aspx?id=" & id_solicitud & "&t=" & tipo
                email_asunto = TranslateLocale.text("Solicitud de Gastos - Ajuste de Tarjeta Realizado", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"

                email_body = RetrieveHttpContent(urlEmail, errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnviarEmailAjusteTicketEmpresarial: " & resultado & "::::" & email_para & "---->" & urlEmail)
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnviarEmailAjusteTicketEmpresarial: Error " & email_para & ", " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try

    End Sub

    Private Sub EnviarEmailErrorTicketEmpresarial(ByVal te As TicketEmpresarialTransaccion)
        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Dim id_solicitud As Integer = te.id_solicitud

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

            Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = solicitud_gasto.RecuperaInfoEmail(id_solicitud)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                email_smtp = System.Configuration.ConfigurationManager.AppSettings("SMTP_SERVER").ToString()
                email_usuario = System.Configuration.ConfigurationManager.AppSettings("SMTP_USER").ToString()
                email_password = System.Configuration.ConfigurationManager.AppSettings("SMTP_PASS").ToString()
                email_port = System.Configuration.ConfigurationManager.AppSettings("SMTP_PORT").ToString()
                email_de = System.Configuration.ConfigurationManager.AppSettings("SMTP_FROM").ToString()
                email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
                email_url_base_local = System.Configuration.ConfigurationManager.AppSettings("URL_BASE_LOCAL").ToString()


                email_para = GlobalFunctions.EmailTicketEmpresarial

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                Dim ticket_empresarial As String = ""
                If te.tipo_movimiento = "A" Then
                    ticket_empresarial = "Ocurrio un error al procesar una transaccion de TicketEmpresarial<br>Asignación de Saldo: " & te.importe.ToString("#,###,##0.00") & "<br>Error: " & te.error
                Else
                    ticket_empresarial = "Ocurrio un error al procesar una transaccion de TicketEmpresarial<br>Ajuste de Saldo: " & te.importe.ToString("#,###,##0.00") & "<br>Error: " & te.error
                End If

                Dim urlEmail = email_url_base_local & "/Email_Formatos/EnvioErrorTicketEmpresarial.aspx?id=" & id_solicitud & "&ticket_empresarial=" & ticket_empresarial
                email_asunto = TranslateLocale.text("Error en transacción de TicketEmpresarial", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                email_body = RetrieveHttpContent(urlEmail, errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioErrorTicketEmpresarial: " & resultado & "::::" & email_para & "---->" & urlEmail)
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioErrorTicketEmpresarial: Error " & email_para & ", " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try

    End Sub

    Private Sub EnviarEmailAnticipo(ByVal id_solicitud As Integer, Optional ticket_empresarial As String = "")
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

            Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = solicitud_gasto.RecuperaInfoEmail(id_solicitud)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                email_smtp = System.Configuration.ConfigurationManager.AppSettings("SMTP_SERVER").ToString()
                email_usuario = System.Configuration.ConfigurationManager.AppSettings("SMTP_USER").ToString()
                email_password = System.Configuration.ConfigurationManager.AppSettings("SMTP_PASS").ToString()
                email_port = System.Configuration.ConfigurationManager.AppSettings("SMTP_PORT").ToString()
                email_de = System.Configuration.ConfigurationManager.AppSettings("SMTP_FROM").ToString()
                email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
                email_url_base_local = System.Configuration.ConfigurationManager.AppSettings("URL_BASE_LOCAL").ToString()


                If dr("email_anticipo").ToString.Length > 0 Then
                    email_para = dr("email_anticipo")
                Else
                    email_para = System.Configuration.ConfigurationManager.AppSettings("EMAIL_DEFAULT").ToString()
                End If

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                Dim urlEmail = email_url_base_local & "/Email_Formatos/EnvioSolicitudGastoAnticipo.aspx?id=" & id_solicitud & "&ticket_empresarial=" & ticket_empresarial
                If ticket_empresarial <> "" Then
                    email_asunto = TranslateLocale.text("Asignación de Fondos Exitosa", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                Else
                    email_asunto = TranslateLocale.text("Realizar anticipo de Gastos", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                End If
                email_body = RetrieveHttpContent(urlEmail, errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioSolicitudGastoAnticipo: " & resultado & "::::" & email_para & "---->" & urlEmail)
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudGastoAnticipo: Error " & email_para & ", " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try

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

            Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = solicitud_gasto.RecuperaInfoEmail(id_solicitud)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                email_smtp = System.Configuration.ConfigurationManager.AppSettings("SMTP_SERVER").ToString()
                email_usuario = System.Configuration.ConfigurationManager.AppSettings("SMTP_USER").ToString()
                email_password = System.Configuration.ConfigurationManager.AppSettings("SMTP_PASS").ToString()
                email_port = System.Configuration.ConfigurationManager.AppSettings("SMTP_PORT").ToString()
                email_de = System.Configuration.ConfigurationManager.AppSettings("SMTP_FROM").ToString()
                email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
                email_url_base_local = System.Configuration.ConfigurationManager.AppSettings("URL_BASE_LOCAL").ToString()

                If dr("email_viaja").ToString.Length > 0 Then
                    email_para = dr("email_viaja")
                Else
                    email_para = System.Configuration.ConfigurationManager.AppSettings("EMAIL_DEFAULT").ToString()
                End If

                If dr("email_solicita").ToString.Length > 0 Then
                    email_para += "," & dr("email_solicita")
                End If

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                Dim urlEmail As String = email_url_base_local & "/Email_Formatos/EnvioSolicitudGastoComprobantes.aspx?id=" & id_solicitud & "&t=C&r=" & rechazo
                If rechazo = 1 Then
                    email_asunto = TranslateLocale.text("Comprobantes de Viaje Rechazados", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                Else
                    email_asunto = TranslateLocale.text("Solicitud de Gastos de Viaje Rechazada", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                End If
                email_body = RetrieveHttpContent(urlEmail, errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioSolicitudGastoComprobantes: " & resultado & "::::" & email_para & "---->" & urlEmail)
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudGastoComprobantes: Error " & email_para & ", " & ex.Message())
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

    Private Sub btnGuardarRechazo_Click(sender As Object, e As EventArgs) Handles btnGuardarRechazo.Click
        If Me.txtMotivoRechazo.Text.Trim.Length = 0 Then
            Me.lblMensaje.Text = "Ingrese el motivo del rechazo"
            Exit Sub
        End If

        Dim id_solicitud As String = Request.QueryString("id")
        Dim tipo As String = Request.QueryString("t")
        Dim valor As String = Request.QueryString("auth")
        Dim id_empleado As String = Request.QueryString("ida")

        Dim solicitud_gastos As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        solicitud_gastos.CambiaEstatusMail(id_solicitud, id_empleado, tipo, IIf(valor = "1", True, False))
        solicitud_gastos.GuardaMotivoRechazo(id_solicitud, Me.txtMotivoRechazo.Text)

        If tipo = 3 Or tipo = 4 Then   ''COMPROBACION DE GASTOS RECHAZADA
            EnviarEmailRechazo(id_solicitud, tipo, 1)
        Else
            EnviarEmailRechazo(id_solicitud, tipo, 2)
        End If

        Me.divNormal.Visible = True
        Me.divRechazo.Visible = False

    End Sub
End Class
Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class SolicitudReposicion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.Busqueda()
        End If

        Me.btnAgregar.Text = TranslateLocale.text("Agregar Solicitud de Reposición")
        Me.txtSolicitudes.Attributes.Add("placeholder", TranslateLocale.text("Buscar Folio"))
        Me.txtSolicitudesAuth.Attributes.Add("placeholder", TranslateLocale.text("Buscar Folio"))
        Me.txtSolicitudesRealizado.Attributes.Add("placeholder", TranslateLocale.text("Buscar Folio"))
        Me.txtSolicitudesPorComprobar.Attributes.Add("placeholder", TranslateLocale.text("Buscar Folio"))

    End Sub




    Private Sub ListView_SolicitudesAuth(solicitud_reposicion As SolicitudReposiciones, sortExpression As String)
        sortExpression = sortExpression.Replace("Ascending", "ASC")
        sortExpression = sortExpression.Replace("Descending", "DESC")

        Dim dt As DataTable = solicitud_reposicion.RecuperaAuth(Session("idEmpleado"), Me.txtSolicitudesAuth.Text)
        If sortExpression.Length > 0 Then dt.DefaultView.Sort = sortExpression

        Funciones.TranslateTableData(dt, {"estatus"})

        Me.lvSolicitudesAuth.DataSource = dt
        Me.lvSolicitudesAuth.DataBind()

        If dt.Rows.Count > 0 Then
            CType(Me.lvSolicitudesAuth.FindControl("lnkButton1"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesAuth.FindControl("lnkButton1"), LinkButton).Text)
            CType(Me.lvSolicitudesAuth.FindControl("lnkButton2"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesAuth.FindControl("lnkButton2"), LinkButton).Text)
            CType(Me.lvSolicitudesAuth.FindControl("lnkButton3"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesAuth.FindControl("lnkButton3"), LinkButton).Text)
            CType(Me.lvSolicitudesAuth.FindControl("lnkButton4"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesAuth.FindControl("lnkButton4"), LinkButton).Text)
            CType(Me.lvSolicitudesAuth.FindControl("lnkButton5"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesAuth.FindControl("lnkButton5"), LinkButton).Text)
            'CType(Me.lvSolicitudesAuth.FindControl("btnAutorizar"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesAuth.FindControl("btnAutorizar"), LinkButton).Text)
        End If


        If dt.Rows.Count = 0 And Me.txtSolicitudesAuth.Text = "" Then
            Me.divMisTareas.Visible = False
        End If
    End Sub

    Private Sub ListView_Solicitudes(solicitud_reposicion As SolicitudReposiciones, sortExpression As String)
        sortExpression = sortExpression.Replace("Ascending", "ASC")
        sortExpression = sortExpression.Replace("Descending", "DESC")

        Dim dt As DataTable = solicitud_reposicion.Recupera(Session("idEmpleado"), Me.txtSolicitudes.Text)
        If sortExpression.Length > 0 Then dt.DefaultView.Sort = sortExpression

        Funciones.TranslateTableData(dt, {"estatus"})

        Me.lvSolicitudes.DataSource = dt
        Me.lvSolicitudes.DataBind()

        If dt.Rows.Count > 0 Then
            CType(Me.lvSolicitudes.FindControl("lnkButton1"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudes.FindControl("lnkButton1"), LinkButton).Text)
            CType(Me.lvSolicitudes.FindControl("lnkButton2"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudes.FindControl("lnkButton2"), LinkButton).Text)
            CType(Me.lvSolicitudes.FindControl("lnkButton3"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudes.FindControl("lnkButton3"), LinkButton).Text)
            CType(Me.lvSolicitudes.FindControl("lnkButton4"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudes.FindControl("lnkButton4"), LinkButton).Text)
        End If

        If dt.Rows.Count = 0 And Me.txtSolicitudes.Text = "" Then
            Me.divMisSolicitudes.Visible = False
        End If
    End Sub

    Private Sub ListView_SolicitudesRealizado(solicitud_reposicion As SolicitudReposiciones, sortExpression As String)
        sortExpression = sortExpression.Replace("Ascending", "ASC")
        sortExpression = sortExpression.Replace("Descending", "DESC")

        Dim dt As DataTable = solicitud_reposicion.RecuperaRealizado(Session("idEmpleado"), Me.txtSolicitudesRealizado.Text)
        If sortExpression.Length > 0 Then dt.DefaultView.Sort = sortExpression

        Funciones.TranslateTableData(dt, {"estatus"})

        Me.lvSolicitudesRealizado.DataSource = dt
        Me.lvSolicitudesRealizado.DataBind()

        If dt.Rows.Count > 0 Then
            CType(Me.lvSolicitudesRealizado.FindControl("lnkButton1"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesRealizado.FindControl("lnkButton1"), LinkButton).Text)
            CType(Me.lvSolicitudesRealizado.FindControl("lnkButton2"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesRealizado.FindControl("lnkButton2"), LinkButton).Text)
            CType(Me.lvSolicitudesRealizado.FindControl("lnkButton3"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesRealizado.FindControl("lnkButton3"), LinkButton).Text)
            CType(Me.lvSolicitudesRealizado.FindControl("lnkButton4"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesRealizado.FindControl("lnkButton4"), LinkButton).Text)
            CType(Me.lvSolicitudesRealizado.FindControl("lnkButton5"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesRealizado.FindControl("lnkButton5"), LinkButton).Text)
        End If

        If dt.Rows.Count = 0 And Me.txtSolicitudesRealizado.Text = "" Then
            Me.divRealizado.Visible = False
        End If
    End Sub

    Private Sub ListView_SolicitudesPorComprobar(solicitud_reposicion As SolicitudReposiciones, sortExpression As String)
        sortExpression = sortExpression.Replace("Ascending", "ASC")
        sortExpression = sortExpression.Replace("Descending", "DESC")

        Dim dt As DataTable = solicitud_reposicion.RecuperaPorComprobar(Session("idEmpleado"), Me.txtSolicitudesPorComprobar.Text)
        If sortExpression.Length > 0 Then dt.DefaultView.Sort = sortExpression

        Funciones.TranslateTableData(dt, {"estatus"})

        Me.lvSolicitudesPorComprobar.DataSource = dt
        Me.lvSolicitudesPorComprobar.DataBind()


        If dt.Rows.Count > 0 Then
            CType(Me.lvSolicitudesPorComprobar.FindControl("lnkButton1"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesPorComprobar.FindControl("lnkButton1"), LinkButton).Text)
            CType(Me.lvSolicitudesPorComprobar.FindControl("lnkButton2"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesPorComprobar.FindControl("lnkButton2"), LinkButton).Text)
            CType(Me.lvSolicitudesPorComprobar.FindControl("lnkButton3"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesPorComprobar.FindControl("lnkButton3"), LinkButton).Text)
            CType(Me.lvSolicitudesPorComprobar.FindControl("lnkButton4"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesPorComprobar.FindControl("lnkButton4"), LinkButton).Text)
        End If

        If dt.Rows.Count = 0 And Me.txtSolicitudesPorComprobar.Text = "" Then
            Me.divReposicionesPorComprobar.Visible = False
        End If
    End Sub

    Private Sub Busqueda()
        Try
            Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.ListView_Solicitudes(solicitud_reposicion, "")
            Me.ListView_SolicitudesAuth(solicitud_reposicion, "")
            Me.ListView_SolicitudesRealizado(solicitud_reposicion, "")
            Me.ListView_SolicitudesPorComprobar(solicitud_reposicion, "")


        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    Public Property GridViewSortDirection() As SortDirection
        Get
            If ViewState("sortDirection") Is Nothing Then
                ViewState("sortDirection") = SortDirection.Ascending
            End If

            Return DirectCast(ViewState("sortDirection"), SortDirection)
        End Get
        Set(value As SortDirection)
            ViewState("sortDirection") = value
        End Set
    End Property


    Private Sub SortGridView(sortExpression As String, direction As String)
        Try
            '  You can cache the DataTable for improving performance
            Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = solicitud_reposicion.Recupera(Session("idEmpleado"), Me.txtSolicitudes.Text)
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            lvSolicitudes.DataSource = dv
            lvSolicitudes.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub btnAgregar_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click
        Response.Redirect("SolicitudReposicionAgregar.aspx?id=0")
    End Sub

    Private Sub lvSolicitudesAuth_ItemCommand(sender As Object, e As ListViewCommandEventArgs) Handles lvSolicitudesAuth.ItemCommand
        Try
            Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            If e.CommandName = "btnAutorizar" Then
                Dim id_solicitud As Integer = e.CommandArgument.ToString().Split("-")(0)
                Dim tipo As Integer = e.CommandArgument.ToString().Split("-")(1)

                solicitud_reposicion.CambiaEstatus(id_solicitud, Session("idEmpleado"), tipo, True)

                'tipo = 1 notificar al contador email tipo 1
                'tipo = 3 notificar al contador email tipo 2
                If tipo = 1 Then
                    EnviarEmail(id_solicitud, tipo)
                ElseIf tipo = 3 Then
                    If solicitud_reposicion.RequiereAutorizacionDeMateriales(id_solicitud, True) = True Then
                        EnviarEmailMateriales(id_solicitud, 6)

                        'Envio de Email al Solicitante y al Viajero con solicitud de comprobantes de Viaje 
                        EnviarSolicitudComprobantes(id_solicitud)
                    ElseIf solicitud_reposicion.RequiereAutorizacionDeComidasInternas(id_solicitud) = True Then
                        EnviarEmailComidasInternas(id_solicitud, 7)

                        'Envio de Email al Solicitante y al Viajero con solicitud de comprobantes de Viaje 
                        EnviarSolicitudComprobantes(id_solicitud)
                    ElseIf solicitud_reposicion.RequiereAutorizacionDeOperaciones(id_solicitud) = True Then
                        EnviarEmailOperaciones(id_solicitud, 5)

                        'Envio de Email al Solicitante y al Viajero con solicitud de comprobantes de Viaje 
                        EnviarSolicitudComprobantes(id_solicitud)
                    Else
                        EnviarEmail(id_solicitud, tipo)
                        'Envio de Email al Solicitante y al Viajero con solicitud de comprobantes de Viaje 
                        EnviarSolicitudComprobantes(id_solicitud)
                    End If
                ElseIf tipo = 4 Then
                    EnviarEmailSolicitante(id_solicitud, 2) '1-Jefe Directo, 2-Contabilidad, 3-Operaciones, 4-Materiales, 5-Comidas Internas
                ElseIf tipo = 5 Then
                    EnviarEmail(id_solicitud, tipo)
                    EnviarEmailSolicitante(id_solicitud, 3) '1-Jefe Directo, 2-Contabilidad, 3-Operaciones, 4-Materiales, 5-Comidas Internas
                ElseIf tipo = 6 Then
                    If solicitud_reposicion.RequiereAutorizacionDeComidasInternas(id_solicitud) = True Then
                        EnviarEmailComidasInternas(id_solicitud, 7)

                        'Envio de Email al Solicitante y al Viajero con solicitud de comprobantes de Viaje 
                        EnviarSolicitudComprobantes(id_solicitud)
                    ElseIf solicitud_reposicion.RequiereAutorizacionDeOperaciones(id_solicitud) = True Then
                        EnviarEmailOperaciones(id_solicitud, 5)

                        'Envio de Email al Solicitante y al Viajero con solicitud de comprobantes de Viaje 
                        EnviarSolicitudComprobantes(id_solicitud)
                    Else
                        EnviarEmail(id_solicitud, tipo)
                        EnviarEmailSolicitante(id_solicitud, 4) '1-Jefe Directo, 2-Contabilidad, 3-Operaciones, 4-Materiales, 5-Comidas Internas
                    End If
                ElseIf tipo = 7 Then
                    If solicitud_reposicion.RequiereAutorizacionDeOperaciones(id_solicitud) = True Then
                        EnviarEmailOperaciones(id_solicitud, 5)

                        'Envio de Email al Solicitante y al Viajero con solicitud de comprobantes de Viaje 
                        EnviarSolicitudComprobantes(id_solicitud)
                    Else
                        EnviarEmail(id_solicitud, tipo)
                        EnviarEmailSolicitante(id_solicitud, 5) '1-Jefe Directo, 2-Contabilidad, 3-Operaciones, 4-Materiales, 5-Comidas Internas
                    End If
                End If
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("Datos Guardados Correctamente") & "');window.location='SolicitudReposicion.aspx';</script>", False)

            ElseIf e.CommandName = "btnRechazar" Then
                Dim id_solicitud As Integer = e.CommandArgument.ToString().Split("-")(0)
                Dim tipo As Integer = e.CommandArgument.ToString().Split("-")(1)

                solicitud_reposicion.CambiaEstatus(id_solicitud, Session("idEmpleado"), tipo, False)

                If tipo = 3 Or tipo = 4 Then   ''COMPROBACION DE GASTOS RECHAZADA
                    EnviarEmailRechazo(id_solicitud, tipo)
                End If
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("Datos Guardados Correctamente") & "');window.location='SolicitudReposicion.aspx';</script>", False)
            End If


        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
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
                    seguridad.GuardaLogDatos("EnvioSolicitudReposicionEntregaComp: " & resultado & "::::" & email_para & "---->" & email_url_base_local & "/Email_Formatos/EnvioSolicitudReposicionEntregaComp.aspx?id=" & id_solicitud)
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudReposicionEntregaComp: Error " & email_para & ", " & ex.Message())
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

                email_asunto = TranslateLocale.text("Solicitud de Autorizacion de Comprobantes de gastos", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                email_body = RetrieveHttpContent(email_url_base_local & "/Email_Formatos/EnvioSolicitudReposicion.aspx?id=" & id_solicitud & "&t=C", errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioSolicitudReposicion: " & resultado & "::::" & email_para & " tipo = " & tipo & "---->" & email_url_base_local & "/Email_Formatos/EnvioSolicitudReposicion.aspx?id=" & id_solicitud & "&t=C")
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudReposicion: Error " & email_para & " tipo = " & tipo & " " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub




    Private Sub EnviarEmailRechazo(ByVal id_solicitud As Integer, ByVal tipo As Integer)
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


                email_asunto = TranslateLocale.text("Comprobantes de Gastos Rechazados", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                email_body = RetrieveHttpContent(email_url_base_local & "/Email_Formatos/EnvioSolicitudReposicionComprobantes.aspx?id=" & id_solicitud & "&t=C&r=1", errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")
                    seguridad.GuardaLogDatos("EnvioSolicitudReposicionComprobantes: " & resultado & "::::" & email_para & " tipo = " & tipo & "---->" & email_url_base & "/Email_Formatos/EnvioSolicitudReposicionComprobantes.aspx?id=" & id_solicitud & "&t=C&r=1")
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudReposicionComprobantes: Error " & email_para & " tipo = " & tipo & " " & ex.Message())
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

    Private Sub lvSolicitudesAuth_PagePropertiesChanging(sender As Object, e As PagePropertiesChangingEventArgs) Handles lvSolicitudesAuth.PagePropertiesChanging
        Me.dpSolicitudesAuthTop.SetPageProperties(e.StartRowIndex, e.MaximumRows, False)
        Me.dpSolicitudesAuth.SetPageProperties(e.StartRowIndex, e.MaximumRows, False)
        Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ListView_SolicitudesAuth(solicitud_reposicion, "")

    End Sub


    Private Sub lvSolicitudesAuth_Sorting(sender As Object, e As ListViewSortEventArgs) Handles lvSolicitudesAuth.Sorting

        Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ListView_SolicitudesAuth(solicitud_reposicion, Convert.ToString(e.SortExpression) & " " & ListViewSortDirection.ToString())

        If ListViewSortDirection = SortDirection.Ascending Then
            ListViewSortDirection = SortDirection.Descending
        Else
            ListViewSortDirection = SortDirection.Ascending
        End If
        Me.lvSolicitudesAuth.Focus()
    End Sub



    Protected Property ListViewSortDirection() As SortDirection
        Get
            If ViewState("sortDirection") Is Nothing Then
                ViewState("sortDirection") = SortDirection.Ascending
            End If
            Return DirectCast(ViewState("sortDirection"), SortDirection)
        End Get
        Set(value As SortDirection)
            ViewState("sortDirection") = value
        End Set
    End Property

    Private Sub lvSolicitudes_PagePropertiesChanging(sender As Object, e As PagePropertiesChangingEventArgs) Handles lvSolicitudes.PagePropertiesChanging
        Me.dpSolicitudesTop.SetPageProperties(e.StartRowIndex, e.MaximumRows, False)
        Me.dpSolicitudes.SetPageProperties(e.StartRowIndex, e.MaximumRows, False)
        Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ListView_Solicitudes(solicitud_reposicion, "")

    End Sub


    Private Sub lvSolicitudes_Sorting(sender As Object, e As ListViewSortEventArgs) Handles lvSolicitudes.Sorting
        Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ListView_Solicitudes(solicitud_reposicion, Convert.ToString(e.SortExpression) & " " & ListViewSortDirection.ToString())

        If ListViewSortDirection = SortDirection.Ascending Then
            ListViewSortDirection = SortDirection.Descending
        Else
            ListViewSortDirection = SortDirection.Ascending
        End If
        Me.lvSolicitudes.Focus()
    End Sub

    Private Sub lvSolicitudesPorComprobar_PagePropertiesChanging(sender As Object, e As PagePropertiesChangingEventArgs) Handles lvSolicitudesPorComprobar.PagePropertiesChanging
        Me.dpSolicitudesPorComprobarTop.SetPageProperties(e.StartRowIndex, e.MaximumRows, False)
        Me.dpSolicitudesPorComprobar.SetPageProperties(e.StartRowIndex, e.MaximumRows, False)
        Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ListView_SolicitudesPorComprobar(solicitud_reposicion, "")

    End Sub

    Private Sub lvSolicitudesPorComprobar_Sorting(sender As Object, e As ListViewSortEventArgs) Handles lvSolicitudesPorComprobar.Sorting
        Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ListView_SolicitudesPorComprobar(solicitud_reposicion, Convert.ToString(e.SortExpression) & " " & ListViewSortDirection.ToString())

        If ListViewSortDirection = SortDirection.Ascending Then
            ListViewSortDirection = SortDirection.Descending
        Else
            ListViewSortDirection = SortDirection.Ascending
        End If
        Me.lvSolicitudesPorComprobar.Focus()
    End Sub

    Private Sub lvSolicitudesRealizado_PagePropertiesChanging(sender As Object, e As PagePropertiesChangingEventArgs) Handles lvSolicitudesRealizado.PagePropertiesChanging
        Me.dpSolicitudesRealizadoTop.SetPageProperties(e.StartRowIndex, e.MaximumRows, False)
        Me.dpSolicitudesRealizado.SetPageProperties(e.StartRowIndex, e.MaximumRows, False)
        Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ListView_SolicitudesRealizado(solicitud_reposicion, "")

    End Sub

    Private Sub lvSolicitudesRealizado_Sorting(sender As Object, e As ListViewSortEventArgs) Handles lvSolicitudesRealizado.Sorting
        Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ListView_SolicitudesRealizado(solicitud_reposicion, Convert.ToString(e.SortExpression) & " " & ListViewSortDirection.ToString())

        If ListViewSortDirection = SortDirection.Ascending Then
            ListViewSortDirection = SortDirection.Descending
        Else
            ListViewSortDirection = SortDirection.Ascending
        End If
        Me.lvSolicitudesRealizado.Focus()
    End Sub


    Private Sub btnSolicitudesRealizado_Click(sender As Object, e As ImageClickEventArgs) Handles btnSolicitudesRealizado.Click
        Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ListView_SolicitudesRealizado(solicitud_reposicion, "")
    End Sub

    Private Sub btnSolicitudes_Click(sender As Object, e As ImageClickEventArgs) Handles btnSolicitudes.Click
        Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ListView_Solicitudes(solicitud_reposicion, "")
    End Sub

    Private Sub btnSolicitudesAuth_Click(sender As Object, e As ImageClickEventArgs) Handles btnSolicitudesAuth.Click
        Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ListView_SolicitudesAuth(solicitud_reposicion, "")
    End Sub

    Private Sub btnSolicitudesPorComprobar_Click(sender As Object, e As ImageClickEventArgs) Handles btnSolicitudesPorComprobar.Click
        Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ListView_SolicitudesPorComprobar(solicitud_reposicion, "")
    End Sub


    Private Sub EnviarEmailMateriales(ByVal id_solicitud As Integer, ByVal tipo As Integer)
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

                If dr("email_materiales").ToString.Length > 0 Then
                    email_para = dr("email_materiales")
                Else
                    email_para = System.Configuration.ConfigurationManager.AppSettings("EMAIL_DEFAULT").ToString()
                End If

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                email_asunto = TranslateLocale.text("Solicitud de Autorizacion de Comprobantes de gastos", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                email_body = RetrieveHttpContent(email_url_base_local & "/Email_Formatos/EnvioSolicitudReposicion.aspx?id=" & id_solicitud & "&t=M", errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioSolicitudReposicion (Mater): " & resultado & "::::" & email_para & " tipo = " & tipo & "---->" & email_url_base & "/Email_Formatos/EnvioSolicitudReposicion.aspx?id=" & id_solicitud & "&t=M")
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudReposicion (Mater): Error " & email_para & ", " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub EnviarEmailOperaciones(ByVal id_solicitud As Integer, ByVal tipo As Integer)
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

                If dr("email_operaciones").ToString.Length > 0 Then
                    email_para = dr("email_operaciones")
                Else
                    email_para = System.Configuration.ConfigurationManager.AppSettings("EMAIL_DEFAULT").ToString()
                End If

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                email_asunto = TranslateLocale.text("Solicitud de Autorizacion de Comprobantes de gastos", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                email_body = RetrieveHttpContent(email_url_base_local & "/Email_Formatos/EnvioSolicitudReposicion.aspx?id=" & id_solicitud & "&t=O", errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioSolicitudReposicion (Opera): " & resultado & "::::" & email_para & " tipo = " & tipo & "---->" & email_url_base & "/Email_Formatos/EnvioSolicitudReposicion.aspx?id=" & id_solicitud & "&t=O")
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudReposicion (Opera): Error " & email_para & ", " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub EnviarEmailComidasInternas(ByVal id_solicitud As Integer, ByVal tipo As Integer)
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

                If dr("email_comidas_internas").ToString.Length > 0 Then
                    email_para = dr("email_comidas_internas")
                Else
                    email_para = System.Configuration.ConfigurationManager.AppSettings("EMAIL_DEFAULT").ToString()
                End If

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                email_asunto = TranslateLocale.text("Solicitud de Autorizacion de Comprobantes de gastos", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                email_body = RetrieveHttpContent(email_url_base_local & "/Email_Formatos/EnvioSolicitudReposicion.aspx?id=" & id_solicitud & "&t=CI", errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioSolicitudReposicion (Comidas Internas): " & resultado & "::::" & email_para & " tipo = " & tipo & "---->" & email_url_base & "/Email_Formatos/EnvioSolicitudReposicion.aspx?id=" & id_solicitud & "&t=O")
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudReposicion (Comidas Internas): Error " & email_para & ", " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Private Sub EnviarEmailSolicitante(id_solicitud As Integer, tipo As Integer)
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
                Dim autorizado_por As String = ""
                If tipo = 1 Then
                    autorizado_por = TranslateLocale.text("Jefe Directo")
                ElseIf tipo = 2 Then
                    autorizado_por = TranslateLocale.text("Contabilidad")
                ElseIf tipo = 3 Then
                    autorizado_por = TranslateLocale.text("Operaciones")
                ElseIf tipo = 4 Then
                    autorizado_por = TranslateLocale.text("Materiales")
                ElseIf tipo = 5 Then
                    autorizado_por = TranslateLocale.text("Comidas Internas")
                End If
                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                email_asunto = TranslateLocale.text("Solicitud de Reposicion Autorizada por", EMAIL_LOCALE) & " " & autorizado_por & " (" & dr("folio_txt").ToString() & ")"
                email_body = RetrieveHttpContent(email_url_base_local & "/Email_Formatos/EnvioSolicitudReposicionEntregaComp.aspx?id=" & id_solicitud, errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")
                    seguridad.GuardaLogDatos("EnvioSolicitudReposicionAutorizada: " & resultado & "::::" & email_para & "---->" & email_url_base & "/Email_Formatos/EnvioSolicitudReposicionEntregaComp.aspx?id=" & id_solicitud & "&x=1")
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudReposicionAutorizada: Error " & email_para & ", " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
End Class
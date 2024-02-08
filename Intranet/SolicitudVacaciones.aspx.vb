Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class SolicitudVacaciones
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.Busqueda()
        End If

        Me.btnAgregar.Text = TranslateLocale.text("Agregar Solicitud")

    End Sub




    Private Sub ListView_SolicitudesAuth(solicitud_vacaciones As SolicitudVacacion, sortExpression As String)
        sortExpression = sortExpression.Replace("Ascending", "ASC")
        sortExpression = sortExpression.Replace("Descending", "DESC")

        Dim dt As DataTable = solicitud_vacaciones.RecuperaAuth(Session("idEmpleado"))
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
            CType(Me.lvSolicitudesAuth.FindControl("lnkButton6"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesAuth.FindControl("lnkButton6"), LinkButton).Text)
            CType(Me.lvSolicitudesAuth.FindControl("lnkButton7"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesAuth.FindControl("lnkButton7"), LinkButton).Text)
            CType(Me.lvSolicitudesAuth.FindControl("lnkButton8"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesAuth.FindControl("lnkButton8"), LinkButton).Text)
        End If

        If dt.Rows.Count = 0 Then
            Me.divMisTareas.Visible = False
        End If
    End Sub

    Private Sub ListView_Solicitudes(solicitud_vacaciones As SolicitudVacacion, sortExpression As String)
        sortExpression = sortExpression.Replace("Ascending", "ASC")
        sortExpression = sortExpression.Replace("Descending", "DESC")

        Dim dt As DataTable = solicitud_vacaciones.Recupera(Session("idEmpleado"))
        If sortExpression.Length > 0 Then dt.DefaultView.Sort = sortExpression

        Funciones.TranslateTableData(dt, {"estatus"})

        Me.lvSolicitudes.DataSource = dt
        Me.lvSolicitudes.DataBind()


        If dt.Rows.Count > 0 Then
            CType(Me.lvSolicitudes.FindControl("lnkButton1"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudes.FindControl("lnkButton1"), LinkButton).Text)
            CType(Me.lvSolicitudes.FindControl("lnkButton2"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudes.FindControl("lnkButton2"), LinkButton).Text)
            CType(Me.lvSolicitudes.FindControl("lnkButton3"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudes.FindControl("lnkButton3"), LinkButton).Text)
            CType(Me.lvSolicitudes.FindControl("lnkButton4"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudes.FindControl("lnkButton4"), LinkButton).Text)
            CType(Me.lvSolicitudes.FindControl("lnkButton5"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudes.FindControl("lnkButton5"), LinkButton).Text)
            CType(Me.lvSolicitudes.FindControl("lnkButton6"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudes.FindControl("lnkButton6"), LinkButton).Text)
            CType(Me.lvSolicitudes.FindControl("lnkButton7"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudes.FindControl("lnkButton7"), LinkButton).Text)
        End If

        If dt.Rows.Count = 0 Then
            Me.divMisSolicitudes.Visible = False
        End If
    End Sub

    Private Sub ListView_SolicitudesRealizado(solicitud_vacaciones As SolicitudVacacion, sortExpression As String)
        sortExpression = sortExpression.Replace("Ascending", "ASC")
        sortExpression = sortExpression.Replace("Descending", "DESC")

        Dim dt As DataTable = solicitud_vacaciones.RecuperaRealizado(Session("idEmpleado"))
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
            CType(Me.lvSolicitudesRealizado.FindControl("lnkButton6"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesRealizado.FindControl("lnkButton6"), LinkButton).Text)
            CType(Me.lvSolicitudesRealizado.FindControl("lnkButton7"), LinkButton).Text = TranslateLocale.text(CType(Me.lvSolicitudesRealizado.FindControl("lnkButton7"), LinkButton).Text)
        End If

        If dt.Rows.Count = 0 Then
            Me.divRealizado.Visible = False
        End If
    End Sub

    Public Sub ListView_SolicitudesVerificar(solicitud_vacaciones As SolicitudVacacion, sortExpression As String)
        sortExpression = sortExpression.Replace("Ascending", "ASC")
        sortExpression = sortExpression.Replace("Descending", "DESC")

        Dim dt As DataTable = solicitud_vacaciones.RecuperaVerificar(Session("idEmpleado"))
        If sortExpression.Length > 0 Then dt.DefaultView.Sort = sortExpression

        Funciones.TranslateTableData(dt, {"estatus"})

        Me.lvVerificacionNominas.DataSource = dt
        Me.lvVerificacionNominas.DataBind()


        If dt.Rows.Count > 0 Then
            CType(Me.lvVerificacionNominas.FindControl("lnkButton1"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVerificacionNominas.FindControl("lnkButton1"), LinkButton).Text)
            CType(Me.lvVerificacionNominas.FindControl("lnkButton2"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVerificacionNominas.FindControl("lnkButton2"), LinkButton).Text)
            CType(Me.lvVerificacionNominas.FindControl("lnkButton3"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVerificacionNominas.FindControl("lnkButton3"), LinkButton).Text)
            CType(Me.lvVerificacionNominas.FindControl("lnkButton4"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVerificacionNominas.FindControl("lnkButton4"), LinkButton).Text)
            CType(Me.lvVerificacionNominas.FindControl("lnkButton5"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVerificacionNominas.FindControl("lnkButton5"), LinkButton).Text)
            CType(Me.lvVerificacionNominas.FindControl("lnkButton6"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVerificacionNominas.FindControl("lnkButton6"), LinkButton).Text)
        End If

        If dt.Rows.Count = 0 Then
            Me.divVerificacionNominas.Visible = False
        End If
    End Sub

    Public Sub ListView_SolicitudesVerificarHistorico(solicitud_vacaciones As SolicitudVacacion, sortExpression As String)
        sortExpression = sortExpression.Replace("Ascending", "ASC")
        sortExpression = sortExpression.Replace("Descending", "DESC")

        Dim dt As DataTable = solicitud_vacaciones.RecuperaVerificarHistorico(Session("idEmpleado"))
        If sortExpression.Length > 0 Then dt.DefaultView.Sort = sortExpression

        Funciones.TranslateTableData(dt, {"estatus"})

        Me.lvVerificacionNominasHistorico.DataSource = dt
        Me.lvVerificacionNominasHistorico.DataBind()


        If dt.Rows.Count > 0 Then
            CType(Me.lvVerificacionNominasHistorico.FindControl("lnkButton1"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVerificacionNominasHistorico.FindControl("lnkButton1"), LinkButton).Text)
            CType(Me.lvVerificacionNominasHistorico.FindControl("lnkButton2"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVerificacionNominasHistorico.FindControl("lnkButton2"), LinkButton).Text)
            CType(Me.lvVerificacionNominasHistorico.FindControl("lnkButton3"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVerificacionNominasHistorico.FindControl("lnkButton3"), LinkButton).Text)
            CType(Me.lvVerificacionNominasHistorico.FindControl("lnkButton4"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVerificacionNominasHistorico.FindControl("lnkButton4"), LinkButton).Text)
            CType(Me.lvVerificacionNominasHistorico.FindControl("lnkButton5"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVerificacionNominasHistorico.FindControl("lnkButton5"), LinkButton).Text)
            CType(Me.lvVerificacionNominasHistorico.FindControl("lnkButton6"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVerificacionNominasHistorico.FindControl("lnkButton6"), LinkButton).Text)
            CType(Me.lvVerificacionNominasHistorico.FindControl("lnkButton7"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVerificacionNominasHistorico.FindControl("lnkButton7"), LinkButton).Text)
        End If

        If dt.Rows.Count = 0 Then
            Me.divVerificacionNominasHistorico.Visible = False
        End If
    End Sub


    Public Sub ListView_Vencimientos(solicitud_vacaciones As SolicitudVacacion, sortExpression As String)
        sortExpression = sortExpression.Replace("Ascending", "ASC")
        sortExpression = sortExpression.Replace("Descending", "DESC")

        Dim ds As DataSet = solicitud_vacaciones.RecuperaVencimientosVacaciones(Session("idEmpleado"), 0, 0, 0)
        Dim dt As DataTable = ds.Tables(0)

        If sortExpression.Length > 0 Then dt.DefaultView.Sort = sortExpression

        Me.lvVencimientos.DataSource = dt
        Me.lvVencimientos.DataBind()

        If dt.Rows.Count > 0 Then
            CType(Me.lvVencimientos.FindControl("lnkButton1"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVencimientos.FindControl("lnkButton1"), LinkButton).Text)
            CType(Me.lvVencimientos.FindControl("lnkButton2"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVencimientos.FindControl("lnkButton2"), LinkButton).Text)
            CType(Me.lvVencimientos.FindControl("lnkButton3"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVencimientos.FindControl("lnkButton3"), LinkButton).Text)
            CType(Me.lvVencimientos.FindControl("lnkButton4"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVencimientos.FindControl("lnkButton4"), LinkButton).Text)
            CType(Me.lvVencimientos.FindControl("lnkButton5"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVencimientos.FindControl("lnkButton5"), LinkButton).Text)
            CType(Me.lvVencimientos.FindControl("lnkButton6"), LinkButton).Text = TranslateLocale.text(CType(Me.lvVencimientos.FindControl("lnkButton6"), LinkButton).Text)
        End If

        Me.lblDisponiblesTotales.Text = ds.Tables(1).Rows(0)("disponibles")
    End Sub

    Private Sub Busqueda()
        Try
            Dim solicitud_vacaciones As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.ListView_Solicitudes(solicitud_vacaciones, "")
            Me.ListView_SolicitudesAuth(solicitud_vacaciones, "")
            Me.ListView_SolicitudesRealizado(solicitud_vacaciones, "")
            Me.ListView_SolicitudesVerificar(solicitud_vacaciones, "")
            Me.ListView_SolicitudesVerificarHistorico(solicitud_vacaciones, "")
            Me.ListView_Vencimientos(solicitud_vacaciones, "")

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
            Dim solicitud_vacaciones As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = solicitud_vacaciones.Recupera(Session("idEmpleado"))
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            lvSolicitudes.DataSource = dv
            lvSolicitudes.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub btnAgregar_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click
        Response.Redirect("SolicitudVacacionesAgregar.aspx?id=0")
    End Sub

    Private Sub lvSolicitudesAuth_ItemCommand(sender As Object, e As ListViewCommandEventArgs) Handles lvSolicitudesAuth.ItemCommand
        Try
            Dim solicitud_vacaciones As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            If e.CommandName = "btnAutorizar" Then
                Dim id_solicitud As Integer = e.CommandArgument.ToString().Split("-")(0)
                Dim tipo As Integer = e.CommandArgument.ToString().Split("-")(1)

                solicitud_vacaciones.CambiaEstatus(id_solicitud, Session("idEmpleado"), tipo, True)

                EnviarEmail(id_solicitud, True)
                EnviarEmailNominas(id_solicitud)

                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("Datos Guardados Correctamente") & "');window.location='SolicitudVacaciones.aspx';</script>", False)
            ElseIf e.CommandName = "btnRechazar" Then
                Dim id_solicitud As Integer = e.CommandArgument.ToString().Split("-")(0)
                Dim tipo As Integer = e.CommandArgument.ToString().Split("-")(1)

                solicitud_vacaciones.CambiaEstatus(id_solicitud, Session("idEmpleado"), tipo, False)

                EnviarEmail(id_solicitud, False)
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("Datos Guardados Correctamente") & "');window.location='SolicitudVacaciones.aspx';</script>", False)
            End If


        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub EnviarEmail(ByVal id_solicitud As Integer, autorizado As Boolean)
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

            Dim solicitud_vacaciones As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = solicitud_vacaciones.RecuperaInfoEmail(id_solicitud)

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

                If autorizado Then
                    email_asunto = TranslateLocale.text("Solicitud de Vacaciones Autorizada", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                    email_body = RetrieveHttpContent(email_url_base_local & "/Email_Formatos/EnvioSolicitudVacaciones.aspx?id=" & id_solicitud & "&auth=1", errorMsg)
                Else
                    email_asunto = TranslateLocale.text("Solicitud de Vacaciones Rechazada", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                    email_body = RetrieveHttpContent(email_url_base_local & "/Email_Formatos/EnvioSolicitudVacaciones.aspx?id=" & id_solicitud & "&auth=0", errorMsg)
                End If

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioSolicitudVacaciones: " & resultado & "::::" & email_para & "---->" & email_url_base_local & "/Email_Formatos/EnvioSolicitudVacaciones.aspx?id=" & id_solicitud & "&auth=1")
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudVacaciones: Error " & email_para & ", " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub EnviarEmailNominas(ByVal id_solicitud As Integer)
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

            Dim solicitud_vacaciones As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = solicitud_vacaciones.RecuperaInfoEmail(id_solicitud)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                email_smtp = System.Configuration.ConfigurationManager.AppSettings("SMTP_SERVER").ToString()
                email_usuario = System.Configuration.ConfigurationManager.AppSettings("SMTP_USER").ToString()
                email_password = System.Configuration.ConfigurationManager.AppSettings("SMTP_PASS").ToString()
                email_port = System.Configuration.ConfigurationManager.AppSettings("SMTP_PORT").ToString()
                email_de = System.Configuration.ConfigurationManager.AppSettings("SMTP_FROM").ToString()
                email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
                email_url_base_local = System.Configuration.ConfigurationManager.AppSettings("URL_BASE_LOCAL").ToString()

                If dr("email_nominas").ToString.Length > 0 Then
                    email_para = dr("email_nominas") & IIf(dr("email_sistema_nominas").ToString.Length > 0, "," & dr("email_sistema_nominas"), "")
                Else
                    email_para = System.Configuration.ConfigurationManager.AppSettings("EMAIL_DEFAULT").ToString()
                End If

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                email_asunto = TranslateLocale.text("Solicitud de Vacaciones Autorizada", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"
                email_body = RetrieveHttpContent(email_url_base_local & "/Email_Formatos/EnvioSolicitudVacaciones.aspx?id=" & id_solicitud & "&auth=2", errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioSolicitudVacaciones: " & resultado & "::::" & email_para & "---->" & email_url_base & "/Email_Formatos/EnvioSolicitudVacaciones.aspx?id=" & id_solicitud & "&auth=2")
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioSolicitudVacaciones: Error " & email_para & ", " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try

    End Sub


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


    Private Sub lvSolicitudesAuth_Sorting(sender As Object, e As ListViewSortEventArgs) Handles lvSolicitudesAuth.Sorting

        Dim solicitud_vacaciones As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ListView_SolicitudesAuth(solicitud_vacaciones, Convert.ToString(e.SortExpression) & " " & ListViewSortDirection.ToString())

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


    Private Sub lvSolicitudes_Sorting(sender As Object, e As ListViewSortEventArgs) Handles lvSolicitudes.Sorting
        Dim solicitud_vacaciones As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ListView_Solicitudes(solicitud_vacaciones, Convert.ToString(e.SortExpression) & " " & ListViewSortDirection.ToString())

        If ListViewSortDirection = SortDirection.Ascending Then
            ListViewSortDirection = SortDirection.Descending
        Else
            ListViewSortDirection = SortDirection.Ascending
        End If
        Me.lvSolicitudes.Focus()
    End Sub

    Private Sub lvSolicitudesRealizado_Sorting(sender As Object, e As ListViewSortEventArgs) Handles lvSolicitudesRealizado.Sorting
        Dim solicitud_vacaciones As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ListView_SolicitudesRealizado(solicitud_vacaciones, Convert.ToString(e.SortExpression) & " " & ListViewSortDirection.ToString())

        If ListViewSortDirection = SortDirection.Ascending Then
            ListViewSortDirection = SortDirection.Descending
        Else
            ListViewSortDirection = SortDirection.Ascending
        End If
        Me.lvSolicitudesRealizado.Focus()
    End Sub

    Private Sub lvVerificacionNominas_ItemCommand(sender As Object, e As ListViewCommandEventArgs) Handles lvVerificacionNominas.ItemCommand
        Try
            Dim solicitud_vacaciones As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            If e.CommandName = "btnCancelar" Then
                Dim id_solicitud As Integer = e.CommandArgument

                solicitud_vacaciones.CancelaSolicitud(id_solicitud, Session("idEmpleado"))

                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>window.location='SolicitudVacaciones.aspx';</script>", False)
            ElseIf e.CommandName = "btnVerifica" Then
                Dim comando As String = e.CommandArgument
                Dim id_solicitud As Integer = comando.Split("|")(0)
                Dim fecha_ini As String = comando.Split("|")(1)
                Dim fecha_fin As String = comando.Split("|")(2)

                solicitud_vacaciones.VerificaSolicitud(id_solicitud, fecha_ini, fecha_fin)

                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>window.location='SolicitudVacaciones.aspx';</script>", False)
            End If


        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub lvVerificacionNominas_Sorting(sender As Object, e As ListViewSortEventArgs) Handles lvVerificacionNominas.Sorting
        Dim solicitud_vacaciones As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ListView_SolicitudesVerificar(solicitud_vacaciones, Convert.ToString(e.SortExpression) & " " & ListViewSortDirection.ToString())

        If ListViewSortDirection = SortDirection.Ascending Then
            ListViewSortDirection = SortDirection.Descending
        Else
            ListViewSortDirection = SortDirection.Ascending
        End If
        Me.lvVerificacionNominas.Focus()
    End Sub

    Private Sub lvVerificacionNominasHistorico_Sorting(sender As Object, e As ListViewSortEventArgs) Handles lvVerificacionNominasHistorico.Sorting
        Dim solicitud_vacaciones As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ListView_SolicitudesVerificarHistorico(solicitud_vacaciones, Convert.ToString(e.SortExpression) & " " & ListViewSortDirection.ToString())

        If ListViewSortDirection = SortDirection.Ascending Then
            ListViewSortDirection = SortDirection.Descending
        Else
            ListViewSortDirection = SortDirection.Ascending
        End If
        Me.lvVerificacionNominasHistorico.Focus()
    End Sub
End Class
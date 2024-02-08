Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class SolicitudVacacionesAgregar
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.CargaCombos()
            Me.diasViaje.InnerText = "0"

            If Request.QueryString("id") Is Nothing Then
                Response.Redirect("/ErrorInesperado.aspx?Msg=Consulta invalida")
            End If

            Me.btnGuardar.Attributes.Add("onclick", "this.disabled='true';")
            Me.btnGuardar.Attributes.Add("onload", "this.disabled='false';")
            Me.btnCancelarSolicitud.Attributes.Add("onclick", "this.disabled='true';")
            Me.btnCancelarSolicitud.Attributes.Add("onload", "this.disabled='false';")


            Me.txtIdSolicitud.Text = Request.QueryString("id")
            Me.lblFechaSolicitud.Text = Format(Now, "dd/MM/yyyy")
            Me.CargaDatos(Me.txtIdSolicitud.Text)

            Me.btnCancelarSolicitud.Text = TranslateLocale.text("Cancelar la Solicitud")
            Me.btnGuardar.Text = TranslateLocale.text("Enviar Solicitud")
            Me.btnRegresar.Text = TranslateLocale.text("Regresar")
            Me.btnCancelarSolicitud.Text = TranslateLocale.text("Cancelar Solicitud")
            Me.chkMedioDia.Text = TranslateLocale.text(Me.chkMedioDia.Text)

        End If
    End Sub

    Protected Function DiasDisponibles() As String
        Return Me.lblDiasDisponibles.Text
    End Function

    Private Sub CargaCombos()
        Try
            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Me.ddlEmpresa.Items.Clear()
            Me.ddlEmpresa.Items.AddRange(Funciones.DatatableToList(combos.RecuperaSolicitudVacacionesEmpresa(Session("idEmpleado")), "nombre", "id_empresa"))
            Me.ddlEmpresa.SelectedValue = Session("idEmpresa")
            Me.ddlEmpresa.Enabled = False


            Me.ActualizaEmpleados(Session("idEmpleado"))
            Me.ddlSolicitante.SelectedValue = Session("idEmpleado")
            Me.ddlSolicitante.Enabled = False
            Me.ActualizaAutorizaJefe(0)
            Me.ActualizaNomina(0)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub CargaDatos(id As Integer)
        Try
            Dim solicitud_vacacion As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = solicitud_vacacion.RecuperaPorId(id)

            If dt.Rows.Count > 0 Then
                'Me.lnkImpr.Visible = True

                Dim dr As DataRow = dt.Rows(0)

                If dr("permitir_cancelar") = 1 Then
                    Me.btnCancelarSolicitud.Visible = True
                End If


                Me.ddlEmpresa.SelectedValue = dr("id_empresa")
                Me.lblFolio.Text = TranslateLocale.text("Folio") & ": " & dr("folio_txt")
                Me.lblFechaSolicitud.Text = Format(dr("fecha_registro"), "dd/MM/yyyy")

                Me.ActualizaEmpleados(dr("id_empleado_solicita"))
                Me.ddlSolicitante.SelectedValue = dr("id_empleado_solicita")
                Me.ActualizaAutorizaJefe(dr("id_autoriza_jefe"))
                Me.ddlAutorizaJefe.SelectedValue = dr("id_autoriza_jefe")
                Me.ActualizaNomina(dr("id_empleado_nomina"))

                Me.ddlNomina.SelectedValue = dr("id_empleado_nomina")
                Me.dtFechaIni.SelectedDate = dr("fecha_ini")
                Me.dtFechaFin.SelectedDate = dr("fecha_fin")
                Me.txtComentarios.Text = dr("comentarios")
                Me.chkMedioDia.Checked = dr("medio_dia")

                Me.diasViaje.InnerText = dr("dias")
                Me.lblEstatus.Text = "<br /><b>" & TranslateLocale.text("Estatus Actual") & ": " & TranslateLocale.text(dr("estatus")) & "</b>"

                Me.txtIdEstatus.Text = dr("id_estatus")

                Me.trDisponibles.Attributes.Add("style", "display:none")
                Me.trSaldo.Attributes.Add("style", "display:none")

                If IsDBNull(dr("autoriza_jefe")) = False Then
                    Me.ddlEmpresa.Enabled = False
                    Me.ddlSolicitante.Enabled = False
                    Me.ddlAutorizaJefe.Enabled = False
                    Me.chkMedioDia.Enabled = False
                    Me.txtComentarios.Enabled = False
                    Me.ddlNomina.Enabled = False

                    Me.ddlNomina.Enabled = False
                    Me.dtFechaIni.Enabled = False
                    Me.dtFechaFin.Enabled = False
                    Me.btnGuardar.Visible = False
                End If

                If dr("solicitud_cancelada") = 1 Then
                    Me.btnCancelarSolicitud.Visible = False
                    Me.btnGuardar.Visible = False
                End If


                If dr("id_empleado_solicita") <> Session("idEmpleado") Then
                    Me.btnGuardar.Visible = False
                End If
            End If

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Protected Function DiasAsueto() As String
        Dim asueto As New Asueto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dt As DataTable = asueto.RecuperaFuturos(Session("idEmpresa"))
        Dim sb As New StringBuilder("")
        Dim sb2 As New StringBuilder("")
        Dim i As Integer = 0
        sb.AppendLine("var myDates=new Array();")
        sb2.AppendLine("")
        sb2.AppendLine("var myDatesMedio=new Array();")
        For Each dr As DataRow In dt.Rows
            sb.AppendLine(String.Format("myDates[{0}]=new Date({1},{2},{3});", i, Convert.ToDateTime(dr("fecha")).Year, Convert.ToDateTime(dr("fecha")).Month - 1, Convert.ToDateTime(dr("fecha")).Day))
            sb2.AppendLine(String.Format("myDatesMedio[{0}]='{1}';", i, dr("medio_dia")))
            i += 1
        Next
        sb.AppendLine(sb2.ToString())
        Return sb.ToString()
    End Function

    Private Sub btnRegresar_Click(sender As Object, e As EventArgs) Handles btnRegresar.Click
        Response.Redirect("SolicitudVacaciones.aspx")
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Me.ValidaCaptura()
            Dim folio As String = ""

            Dim solicitud_vacacion As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = solicitud_vacacion.Guarda(Me.txtIdSolicitud.Text, Me.ddlSolicitante.SelectedValue,
                                   Me.ddlAutorizaJefe.SelectedValue, Me.ddlNomina.SelectedValue,
                                   Me.dtFechaIni.SelectedDate, Me.dtFechaFin.SelectedDate, Me.txtComentarios.Text,
                                   Me.ddlEmpresa.SelectedValue, Session("idEmpleado"), Me.chkMedioDia.Checked)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)
                Me.txtIdSolicitud.Text = dr("id")
                folio = dr("folio")
            End If

            EmailJefeDirecto()

            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("Datos guardados con exito\nEl No. de Folio de la solicitud es") & ": " & folio & "');window.location='SolicitudVacaciones.aspx';</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub ValidaCaptura()
        Dim msg As String = ""

        If Me.ddlEmpresa.SelectedValue = 0 Then
            msg += " - " & TranslateLocale.text("Empresa") & "\n"
        End If

        If Me.ddlAutorizaJefe.SelectedValue = 0 Then
            msg += " - " & TranslateLocale.text("Autoriza Jefe") & "\n"
        End If

        If Me.dtFechaIni.SelectedDate Is Nothing Then
            msg += " - " & TranslateLocale.text("Fecha Ini") & "\n"
        End If

        If Me.dtFechaFin.SelectedDate Is Nothing Then
            msg += " - " & TranslateLocale.text("Fecha Fin") & "\n"
        End If

        If (Not Me.dtFechaIni.SelectedDate Is Nothing) And (Not Me.dtFechaFin.SelectedDate Is Nothing) Then

            If Me.dtFechaIni.SelectedDate > Me.dtFechaFin.SelectedDate Then
                msg += " - " & TranslateLocale.text("Rango de Fechas Invalido") & "\n"
            End If

        End If


        If Me.ddlAutorizaJefe.SelectedValue <> 0 Then
            If Me.ddlSolicitante.SelectedValue = Me.ddlAutorizaJefe.SelectedValue Then
                Dim excepcion As Boolean = False
                Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Dim dt As DataTable = empleado.RecuperaEmpleadoPerfil(Session("idEmpleado")).Tables(0)

                For Each dRow As DataRow In dt.Rows
                    If dRow("id_perfil") = 67 Then '67	Excepcion a regla de autorizacion de solicitudes propias
                        excepcion = True
                        Exit For
                    End If
                Next

                If excepcion = False Then
                    msg += " - " & TranslateLocale.text("No puede seleccionarse a si mismo como Autoriza Jefe") & "\n"
                End If
            End If
        End If

        If msg.Length > 0 Then
            Throw New Exception("" & TranslateLocale.text("Favor de capturar y/o revisar la siguiente información") & ":\n" & msg)
        End If
    End Sub

    Private Sub EmailJefeDirecto()
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

            Dim solicitud_vacacion As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = solicitud_vacacion.RecuperaInfoEmail(Me.txtIdSolicitud.Text)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                email_smtp = System.Configuration.ConfigurationManager.AppSettings("SMTP_SERVER").ToString()
                email_usuario = System.Configuration.ConfigurationManager.AppSettings("SMTP_USER").ToString()
                email_password = System.Configuration.ConfigurationManager.AppSettings("SMTP_PASS").ToString()
                email_port = System.Configuration.ConfigurationManager.AppSettings("SMTP_PORT").ToString()
                email_de = System.Configuration.ConfigurationManager.AppSettings("SMTP_FROM").ToString()
                email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
                email_url_base_local = System.Configuration.ConfigurationManager.AppSettings("URL_BASE_LOCAL").ToString()

                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"

                email_asunto = TranslateLocale.text("Solicitud de Vacaciones", EMAIL_LOCALE) & " (" & dr("folio_txt").ToString() & ")"

                If dr("email_jefe").ToString.Length > 0 Then
                    email_para = dr("email_jefe")
                Else
                    email_para = System.Configuration.ConfigurationManager.AppSettings("EMAIL_DEFAULT").ToString()
                End If

                email_body = RetrieveHttpContent(email_url_base_local & "/Email_Formatos/EnvioSolicitudVacaciones.aspx?id=" & Me.txtIdSolicitud.Text, errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioSolicitudVacaciones: " & resultado & "::::" & email_para & "---->" & email_url_base & "/Email_Formatos/EnvioSolicitudVacaciones.aspx?id=" & Me.txtIdSolicitud.Text)
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

    Protected Sub ddlSolicitante_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlSolicitante.SelectedIndexChanged
        ActualizaAutorizaJefe(0)
    End Sub

    Protected Sub ActualizaAutorizaJefe(id_empleado_incluir As Integer)
        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        Me.ddlAutorizaJefe.Items.Clear()
        Me.ddlAutorizaJefe.Items.AddRange(Funciones.DatatableToList(combos.RecuperaAutorizaJefeVacaciones(Me.ddlSolicitante.SelectedValue, id_empleado_incluir), "nombre", "id_empleado"))

        Dim sv As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.lblDiasDisponibles.Text = Format(sv.DiasDisponibles(Me.ddlSolicitante.SelectedValue) - sv.DiasEnProceso(Me.ddlSolicitante.SelectedValue), "##0.0")

        Me.trDiasDisponibles.Visible = True

    End Sub

    Protected Sub ActualizaNomina(id_empleado_incluir As Integer)
        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        Me.ddlNomina.Items.Clear()
        Me.ddlNomina.Items.AddRange(Funciones.DatatableToList(combos.RecuperaAutorizaNomina(Me.ddlEmpresa.SelectedValue, id_empleado_incluir, Me.ddlSolicitante.SelectedValue), "nombre", "id_empleado"))


    End Sub

    Protected Sub ActualizaEmpleados(id_empleado_incluir As Integer)
        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        Me.ddlSolicitante.Items.Clear()
        Me.ddlSolicitante.Items.AddRange(Funciones.DatatableToList(combos.RecuperaSolicitudEmpleado(Me.ddlEmpresa.SelectedValue, id_empleado_incluir), "nombre", "id_empleado"))

    End Sub

    Private Sub ddlEmpresa_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlEmpresa.SelectedIndexChanged
        Me.ActualizaEmpleados(0)
        Me.ActualizaNomina(0)
    End Sub

    Private Sub btnCancelarSolicitud_Click(sender As Object, e As EventArgs) Handles btnCancelarSolicitud.Click
        Try
            Dim solicitud As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            solicitud.CancelaSolicitud(Me.txtIdSolicitud.Text, Session("idEmpleado"))

            Response.Redirect("SolicitudVacacionesAgregar.aspx?id=" & Me.txtIdSolicitud.Text)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

End Class
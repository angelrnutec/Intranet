Imports IntranetBL

Public Class ParametrosGenerales
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.CargaCombos()
            Me.CargaDatos()
        End If

    End Sub

    Private Sub CargaCombos()
        Dim combo As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dtTodos As DataTable = combo.RecuperaEmpleados(0, "--Sin Asignar--")
        Dim dtNC As DataTable = combo.RecuperaEmpleados(6, "--Sin Asignar--")
        Dim dtNB As DataTable = combo.RecuperaEmpleados(3, "--Sin Asignar--")
        Dim dtNF As DataTable = combo.RecuperaEmpleados(8, "--Sin Asignar--")
        Dim dtNE As DataTable = combo.RecuperaEmpleados(7, "--Sin Asignar--")
        Dim dtNU As DataTable = combo.RecuperaEmpleados(12, "--Sin Asignar--")

        Me.ddlIdUsuarioPagosNC.DataSource = dtTodos
        Me.ddlIdUsuarioPagosNC.DataValueField = "id_empleado"
        Me.ddlIdUsuarioPagosNC.DataTextField = "nombre"
        Me.ddlIdUsuarioPagosNC.DataBind()

        Me.ddlIdUsuarioOperacionesNC.DataSource = dtNC
        Me.ddlIdUsuarioOperacionesNC.DataValueField = "id_empleado"
        Me.ddlIdUsuarioOperacionesNC.DataTextField = "nombre"
        Me.ddlIdUsuarioOperacionesNC.DataBind()

        Me.ddlIdUsuarioComidasInternasNC.DataSource = dtNC
        Me.ddlIdUsuarioComidasInternasNC.DataValueField = "id_empleado"
        Me.ddlIdUsuarioComidasInternasNC.DataTextField = "nombre"
        Me.ddlIdUsuarioComidasInternasNC.DataBind()

        Me.ddlIdUsuarioDirectorNS.DataSource = dtNC
        Me.ddlIdUsuarioDirectorNS.DataValueField = "id_empleado"
        Me.ddlIdUsuarioDirectorNS.DataTextField = "nombre"
        Me.ddlIdUsuarioDirectorNS.DataBind()

        Me.ddlIdUsuarioPagosNB.DataSource = dtTodos
        Me.ddlIdUsuarioPagosNB.DataValueField = "id_empleado"
        Me.ddlIdUsuarioPagosNB.DataTextField = "nombre"
        Me.ddlIdUsuarioPagosNB.DataBind()

        Me.ddlIdUsuarioOperacionesNB.DataSource = dtNB
        Me.ddlIdUsuarioOperacionesNB.DataValueField = "id_empleado"
        Me.ddlIdUsuarioOperacionesNB.DataTextField = "nombre"
        Me.ddlIdUsuarioOperacionesNB.DataBind()

        Me.ddlIdUsuarioComidasInternasNB.DataSource = dtNB
        Me.ddlIdUsuarioComidasInternasNB.DataValueField = "id_empleado"
        Me.ddlIdUsuarioComidasInternasNB.DataTextField = "nombre"
        Me.ddlIdUsuarioComidasInternasNB.DataBind()

        Me.ddlIdUsuarioDirectorNB.DataSource = dtNB
        Me.ddlIdUsuarioDirectorNB.DataValueField = "id_empleado"
        Me.ddlIdUsuarioDirectorNB.DataTextField = "nombre"
        Me.ddlIdUsuarioDirectorNB.DataBind()


        Me.ddlIdUsuarioPagosNF.DataSource = dtTodos
        Me.ddlIdUsuarioPagosNF.DataValueField = "id_empleado"
        Me.ddlIdUsuarioPagosNF.DataTextField = "nombre"
        Me.ddlIdUsuarioPagosNF.DataBind()

        Me.ddlIdUsuarioOperacionesNF.DataSource = dtNF
        Me.ddlIdUsuarioOperacionesNF.DataValueField = "id_empleado"
        Me.ddlIdUsuarioOperacionesNF.DataTextField = "nombre"
        Me.ddlIdUsuarioOperacionesNF.DataBind()

        Me.ddlIdUsuarioComidasInternasNF.DataSource = dtNF
        Me.ddlIdUsuarioComidasInternasNF.DataValueField = "id_empleado"
        Me.ddlIdUsuarioComidasInternasNF.DataTextField = "nombre"
        Me.ddlIdUsuarioComidasInternasNF.DataBind()

        Me.ddlIdUsuarioDirectorNF.DataSource = dtNF
        Me.ddlIdUsuarioDirectorNF.DataValueField = "id_empleado"
        Me.ddlIdUsuarioDirectorNF.DataTextField = "nombre"
        Me.ddlIdUsuarioDirectorNF.DataBind()

        Me.ddlIdUsuarioDirectorNE.DataSource = dtNE
        Me.ddlIdUsuarioDirectorNE.DataValueField = "id_empleado"
        Me.ddlIdUsuarioDirectorNE.DataTextField = "nombre"
        Me.ddlIdUsuarioDirectorNE.DataBind()

        Me.ddlIdUsuarioDirectorNU.DataSource = dtNU
        Me.ddlIdUsuarioDirectorNU.DataValueField = "id_empleado"
        Me.ddlIdUsuarioDirectorNU.DataTextField = "nombre"
        Me.ddlIdUsuarioDirectorNU.DataBind()


        Me.ddlIdUsuarioDirectorFinanzasNB.DataSource = dtNB
        Me.ddlIdUsuarioDirectorFinanzasNB.DataValueField = "id_empleado"
        Me.ddlIdUsuarioDirectorFinanzasNB.DataTextField = "nombre"
        Me.ddlIdUsuarioDirectorFinanzasNB.DataBind()

        Me.ddlIdUsuarioDirectorFinanzasNE.DataSource = dtNE
        Me.ddlIdUsuarioDirectorFinanzasNE.DataValueField = "id_empleado"
        Me.ddlIdUsuarioDirectorFinanzasNE.DataTextField = "nombre"
        Me.ddlIdUsuarioDirectorFinanzasNE.DataBind()

        Me.ddlIdUsuarioDirectorFinanzasNF.DataSource = dtNF
        Me.ddlIdUsuarioDirectorFinanzasNF.DataValueField = "id_empleado"
        Me.ddlIdUsuarioDirectorFinanzasNF.DataTextField = "nombre"
        Me.ddlIdUsuarioDirectorFinanzasNF.DataBind()

        Me.ddlIdUsuarioDirectorFinanzasNS.DataSource = dtNC
        Me.ddlIdUsuarioDirectorFinanzasNS.DataValueField = "id_empleado"
        Me.ddlIdUsuarioDirectorFinanzasNS.DataTextField = "nombre"
        Me.ddlIdUsuarioDirectorFinanzasNS.DataBind()

        Me.ddlIdUsuarioDirectorFinanzasNU.DataSource = dtNU
        Me.ddlIdUsuarioDirectorFinanzasNU.DataValueField = "id_empleado"
        Me.ddlIdUsuarioDirectorFinanzasNU.DataTextField = "nombre"
        Me.ddlIdUsuarioDirectorFinanzasNU.DataBind()


        Me.ddlIdUsuarioDirectorRH.DataSource = dtTodos
        Me.ddlIdUsuarioDirectorRH.DataValueField = "id_empleado"
        Me.ddlIdUsuarioDirectorRH.DataTextField = "nombre"
        Me.ddlIdUsuarioDirectorRH.DataBind()

        Me.ddlIdUsuarioAutorizaMateriales.DataSource = dtTodos
        Me.ddlIdUsuarioAutorizaMateriales.DataValueField = "id_empleado"
        Me.ddlIdUsuarioAutorizaMateriales.DataTextField = "nombre"
        Me.ddlIdUsuarioAutorizaMateriales.DataBind()

        Me.ddlIdUsuarioVerificaVacacionesGuardiasSeguridadNF.DataSource = dtTodos
        Me.ddlIdUsuarioVerificaVacacionesGuardiasSeguridadNF.DataValueField = "id_empleado"
        Me.ddlIdUsuarioVerificaVacacionesGuardiasSeguridadNF.DataTextField = "nombre"
        Me.ddlIdUsuarioVerificaVacacionesGuardiasSeguridadNF.DataBind()

    End Sub

    Private Sub CargaDatos()
        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dt As DataTable = seguridad.RecuperaParametrosGenerales()

        If dt.Rows.Count > 0 Then
            Dim dr As DataRow = dt.Rows(0)
            Me.ddlIdUsuarioPagosNC.SelectedValue = dr("id_usuario_pagos")
            Me.ddlIdUsuarioPagosNB.SelectedValue = dr("id_usuario_pagos_nb")
            Me.ddlIdUsuarioPagosNF.SelectedValue = dr("id_usuario_pagos_nf")

            Me.txtDiasVencimientoIntranet.Text = dr("vencimiento_password_intranet_dias")
            Me.txtDiasVencimientoNomina.Text = dr("vencimiento_password_nomina_dias")

            Me.txtMontoMaximoMateriales.Text = dr("monto_limite_compra_materiales")
            Me.ddlIdUsuarioOperacionesNC.SelectedValue = dr("id_director_operaciones_co")
            Me.ddlIdUsuarioOperacionesNB.SelectedValue = dr("id_director_operaciones_nb")
            Me.ddlIdUsuarioOperacionesNF.SelectedValue = dr("id_director_operaciones_nf")

            Me.txtMontoMaximoComidasInternas.Text = dr("monto_limite_comidas_internas")
            Me.ddlIdUsuarioComidasInternasNC.SelectedValue = dr("id_usuario_comidas_internas_nc")
            Me.ddlIdUsuarioComidasInternasNB.SelectedValue = dr("id_usuario_comidas_internas_nb")
            Me.ddlIdUsuarioComidasInternasNF.SelectedValue = dr("id_usuario_comidas_internas_nf")

            Me.ddlIdUsuarioDirectorNS.SelectedValue = dr("id_director_ns")
            Me.ddlIdUsuarioDirectorNB.SelectedValue = dr("id_director_nb")
            Me.ddlIdUsuarioDirectorNF.SelectedValue = dr("id_director_nf")
            Me.ddlIdUsuarioDirectorNE.SelectedValue = dr("id_director_ne")
            Me.ddlIdUsuarioDirectorNU.SelectedValue = dr("id_director_nu")

            Me.ddlIdUsuarioDirectorFinanzasNS.SelectedValue = dr("id_director_finanzas_ns")
            Me.ddlIdUsuarioDirectorFinanzasNB.SelectedValue = dr("id_director_finanzas_nb")
            Me.ddlIdUsuarioDirectorFinanzasNF.SelectedValue = dr("id_director_finanzas_nf")
            Me.ddlIdUsuarioDirectorFinanzasNE.SelectedValue = dr("id_director_finanzas_ne")
            Me.ddlIdUsuarioDirectorFinanzasNU.SelectedValue = dr("id_director_finanzas_nu")

            Me.ddlIdUsuarioDirectorRH.SelectedValue = dr("id_director_rh")

            Me.ddlIdUsuarioAutorizaMateriales.SelectedValue = dr("id_autoriza_materiales")
            Me.ddlIdUsuarioVerificaVacacionesGuardiasSeguridadNF.SelectedValue = dr("id_verifica_vacaciones_guardias_nf")

            Me.txtEmailsNotificacionDatosTelefonia.Text = dr("email_notificacion_datos_telefonia")


            Dim configuracion As New Configuracion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.gvConfiguracion.DataSource = configuracion.RecuperaConfiguraciones()
            Me.gvConfiguracion.DataBind()
        End If
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Dim msg As String = ""
            Me.txtEmailsNotificacionDatosTelefonia.Text = Me.txtEmailsNotificacionDatosTelefonia.Text.Trim()

            If Me.txtEmailsNotificacionDatosTelefonia.Text.Trim().Length > 0 Then
                Me.txtEmailsNotificacionDatosTelefonia.Text = Me.txtEmailsNotificacionDatosTelefonia.Text.Replace(Chr(10), "")
                Me.txtEmailsNotificacionDatosTelefonia.Text = Me.txtEmailsNotificacionDatosTelefonia.Text.Replace(Chr(13), "")
                Dim emails() As String = txtEmailsNotificacionDatosTelefonia.Text.Split(";")
                For Each strFile In emails
                    'If strFile.Trim().Length > 0 Then
                    If EmailAddressCheck(strFile.Trim()) = False Then
                        msg += strFile.Trim() & "\n"
                    End If
                    'End If
                Next

                If msg.Length > 0 Then
                    Throw New Exception("Email(s) invalido(s):\n" & msg)
                End If
            End If

            If Me.txtMontoMaximoMateriales.Value Is Nothing Then
                Me.txtMontoMaximoMateriales.Value = 0
            End If

            If Me.txtMontoMaximoComidasInternas.Value Is Nothing Then
                Me.txtMontoMaximoComidasInternas.Value = 0
            End If


            Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            seguridad.GuardaParametrosGenerales(Me.ddlIdUsuarioPagosNC.SelectedValue, Me.ddlIdUsuarioPagosNB.SelectedValue, Me.ddlIdUsuarioPagosNF.SelectedValue,
                                                Me.txtDiasVencimientoIntranet.Value, Me.txtDiasVencimientoNomina.Value, Me.txtMontoMaximoMateriales.Value,
                                                Me.ddlIdUsuarioOperacionesNC.SelectedValue, Me.ddlIdUsuarioOperacionesNB.SelectedValue, Me.ddlIdUsuarioOperacionesNF.SelectedValue,
                                                Me.ddlIdUsuarioDirectorNS.SelectedValue, Me.ddlIdUsuarioDirectorNB.SelectedValue, Me.ddlIdUsuarioDirectorNF.SelectedValue,
                                                Me.txtEmailsNotificacionDatosTelefonia.Text, Me.txtMontoMaximoComidasInternas.Value, Me.ddlIdUsuarioComidasInternasNC.SelectedValue,
                                                Me.ddlIdUsuarioComidasInternasNB.SelectedValue, Me.ddlIdUsuarioComidasInternasNF.SelectedValue, Me.ddlIdUsuarioDirectorNE.SelectedValue,
                                                Me.ddlIdUsuarioDirectorNU.SelectedValue, Me.ddlIdUsuarioDirectorFinanzasNS.SelectedValue, Me.ddlIdUsuarioDirectorFinanzasNB.SelectedValue,
                                                Me.ddlIdUsuarioDirectorFinanzasNF.SelectedValue, Me.ddlIdUsuarioDirectorFinanzasNE.SelectedValue, Me.ddlIdUsuarioDirectorFinanzasNU.SelectedValue,
                                                Me.ddlIdUsuarioDirectorRH.SelectedValue, Me.ddlIdUsuarioAutorizaMateriales.SelectedValue, Me.ddlIdUsuarioVerificaVacacionesGuardiasSeguridadNF.SelectedValue)


            Dim configuracion As New Configuracion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            For Each gvRow As GridViewRow In gvConfiguracion.Rows
                Dim id As Integer = CType(gvRow.FindControl("txtIdConfiguracion"), HiddenField).Value
                Dim valor As String = CType(gvRow.FindControl("txtValor"), TextBox).Text

                configuracion.GuardaConfiguracion(id, valor)
            Next


            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "script", "<script>alert('Datos Guardados con Exito');</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType(), "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
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
End Class
Imports IntranetBL
Imports System.Web.Services
Imports Telerik.Web.UI

Public Class VacacionesTabuladorVer
    Inherits System.Web.UI.Page

    Private Property txtClave As Object

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            If Request.QueryString("fe") Is Nothing Then
                Response.Redirect("/ErrorInesperado.aspx?Msg=Consulta invalida")
            End If

            Me.txtFechaEfectividad.Text = Request.QueryString("fe")
            Me.txtIdTipoTabla.Text = Request.QueryString("id")

            'If Me.txtFechaEfectividad.Text.Length > 0 Then
            '    spnTitulo.InnerText = "Edicion de Tabulador de Vacaciones"
            '    Me.txtEsAlta.Text = "0"
            '    Me.tblAgregar.Visible = True
            'Else
            '    spnTitulo.InnerText = "Alta de Tabulador de Vacaciones"
            '    Me.txtEsAlta.Text = "1"
            '    Me.tblAgregar.Visible = False
            'End If

            spnTitulo.InnerText = "Consulta de Tabulador de Vacaciones"
            Me.txtEsAlta.Text = "0"

            Me.CargaDatos()

        End If
    End Sub


    Private Sub CargaDatos()
        Try
            Dim vacaciones_tabulador As New VacacionesTabulador(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = New DataTable

            If Me.txtFechaEfectividad.Text.Length > 0 Then
                dt = vacaciones_tabulador.Recupera(Me.txtFechaEfectividad.Text, Me.txtIdTipoTabla.Text)

                If dt.Rows.Count > 0 Then
                    Me.dtFechaEfectividad.SelectedDate = Convert.ToDateTime(dt.Rows(0)("fecha_efectividad")).ToString("dd/MM/yyy")
                End If
            Else
                dt = vacaciones_tabulador.RecuperaUltimo()
                If dt.Rows.Count > 0 Then
                    Me.txtFechaEfectividad.Text = Convert.ToDateTime(dt.Rows(0)("fecha_efectividad")).ToString("yyyyMMdd")
                    Me.dtFechaEfectividad.SelectedDate = Convert.ToDateTime(dt.Rows(0)("fecha_efectividad")).ToString("dd/MM/yyy")
                End If
            End If

                Me.gvDetalle.DataSource = dt
                Me.gvDetalle.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub btnRegresar_Click(sender As Object, e As EventArgs) Handles btnRegresar.Click
        Response.Redirect("VacacionesTabuladorBusqueda.aspx")
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Me.ValidaCaptura()

            For Each row As GridViewRow In gvDetalle.Rows
                Dim lblIdG As Label = CType(row.FindControl("lblId"), Label)
                Dim txtAñoInicioG As RadNumericTextBox = CType(row.FindControl("txtAñoInicio"), RadNumericTextBox)
                Dim txtAñoFinG As RadNumericTextBox = CType(row.FindControl("txtAñoFin"), RadNumericTextBox)
                Dim txtDiasG As RadNumericTextBox = CType(row.FindControl("txtDias"), RadNumericTextBox)
                Dim dtFechaEfectividadG As RadDatePicker = CType(row.FindControl("dtFechaEfectividad"), RadDatePicker)

                If (Not txtAñoInicioG.Value Is Nothing) And (Not txtAñoFinG.Value Is Nothing) And (Not txtDiasG.Value Is Nothing) And (Not dtFechaEfectividadG.SelectedDate Is Nothing) Then
                    If txtAñoInicioG.Value > 0 And txtAñoFinG.Value > 0 And txtDiasG.Value > 0 Then
                        Dim vacaciones_tabulador As New VacacionesTabulador(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                        vacaciones_tabulador.Guarda(lblIdG.Text, txtAñoInicioG.Value, txtAñoFinG.Value, txtDiasG.Value, Convert.ToDateTime(dtFechaEfectividadG.SelectedDate).ToString("yyyyMMdd"))
                    End If                    
                End If
            Next

            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Datos guardados con exito');window.location='VacacionesTabuladorBusqueda.aspx';</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub ValidaCaptura()
        Dim msg As String = ""
        Dim msg_detalle As String = ""
        Dim tiene_valor As Boolean = False

        For Each row As GridViewRow In gvDetalle.Rows
            msg_detalle = ""
            Dim txtAñoInicioG As RadNumericTextBox = CType(row.FindControl("txtAñoInicio"), RadNumericTextBox)
            Dim txtAñoFinG As RadNumericTextBox = CType(row.FindControl("txtAñoFin"), RadNumericTextBox)
            Dim txtDiasG As RadNumericTextBox = CType(row.FindControl("txtDias"), RadNumericTextBox)
            Dim dtFechaEfectividadG As RadDatePicker = CType(row.FindControl("dtFechaEfectividad"), RadDatePicker)
            Dim lblFilaG As Label = CType(row.FindControl("lblFila"), Label)

            If ((Not txtAñoInicioG.Value Is Nothing) And (txtAñoFinG.Value Is Nothing)) Or
                 ((txtAñoInicioG.Value Is Nothing) And (Not txtAñoFinG.Value Is Nothing)) And (Not txtDiasG.Value Is Nothing) Then
                msg_detalle += " - Fila " & lblFilaG.Text & " Seleccione Año de inicio y fin\n"
            End If

            If ((Not txtAñoInicioG.Value Is Nothing) And (Not txtAñoFinG.Value Is Nothing)) And (txtDiasG.Value Is Nothing) Then
                msg_detalle += " - Fila " & lblFilaG.Text & " Seleccione Dias\n"
            End If

            If (Not txtAñoInicioG.Value Is Nothing) And (Not txtAñoFinG.Value Is Nothing) And (Not txtDiasG.Value Is Nothing) And (Not dtFechaEfectividadG.SelectedDate Is Nothing) Then
                If txtAñoInicioG.Value > txtAñoFinG.Value Then
                    msg_detalle += " - Fila " & lblFilaG.Text & " Año de inicio y fin invalidos\n"
                Else
                    If txtAñoInicioG.Value = 0 Then
                        msg_detalle += " - Fila " & lblFilaG.Text & " el año inicio debe ser mayor a 0\n"
                    End If

                    If txtAñoFinG.Value = 0 Then
                        msg_detalle += " - Fila " & lblFilaG.Text & " el año fin debe ser mayor a 0\n"
                    End If
                End If

                If txtDiasG.Value = 0 Then
                    msg_detalle += " - Fila " & lblFilaG.Text & " los dias deben ser mayor a 0\n"            
                End If

                If txtAñoInicioG.Value > 0 And txtAñoFinG.Value > 0 And txtDiasG.Value > 0 Then
                    tiene_valor = True
                End If

            End If

            If msg_detalle.Length > 0 Then
                msg += msg_detalle
            End If
        Next

        If tiene_valor = False Then
            msg += " - Debe de ingresar valores para al menos un tabulador\n"
        End If

        If msg.Length > 0 Then
            Throw New Exception("Favor de capturar la siguiente información:\n" & msg)
        End If
    End Sub

    Private Sub gvDetalle_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvDetalle.RowCommand
        Try
            If e.CommandName = "borrar" Then
                Dim vacaciones_tabulador As New VacacionesTabulador(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                vacaciones_tabulador.Elimina(e.CommandArgument)
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Registro eliminado');window.location='VacacionesTabuladorVer.aspx?fe=" & Me.txtFechaEfectividad.Text & "';</script>", False)
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub gvDetalle_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvDetalle.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lblFechaEfectividadG As Label = CType(e.Row.FindControl("lblFechaEfectividad"), Label)
            Dim dtFechaEfectividadG As RadDatePicker = CType(e.Row.FindControl("dtFechaEfectividad"), RadDatePicker)
            Dim btnDelete As ImageButton = CType(e.Row.FindControl("btnDelete"), ImageButton)

            If Me.txtEsAlta.Text = "0" Then
                dtFechaEfectividadG.Visible = False
                lblFechaEfectividadG.Visible = True
                btnDelete.Visible = True
            Else
                dtFechaEfectividadG.Visible = True
                lblFechaEfectividadG.Visible = False
                btnDelete.Visible = False
            End If
        End If

    End Sub

    Protected Sub btnAgregar_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click
        Try
            Dim msg As String = ""

            If txtAñoInicio.Value Is Nothing Then
                msg += " - El año inicio debe ser mayor a 0\n"
            Else
                If txtAñoInicio.Value = 0 Then
                    msg += " - El año inicio debe ser mayor a 0\n"
                End If
            End If

            If txtAñoFin.Value Is Nothing Then
                msg += " - El año fin debe ser mayor a 0\n"
            Else
                If txtAñoFin.Value = 0 Then
                    msg += " - El año fin debe ser mayor a 0\n"
                End If
            End If

            If txtDias.Value Is Nothing Then
                msg += " - Los dias deben ser mayor a 0\n"
            Else
                If txtDias.Value = 0 Then
                    msg += " - Los dias deben ser mayor a 0\n"
                End If
            End If

            If dtFechaEfectividad.SelectedDate Is Nothing Then
                msg += " - Fecha de Efectividad\n"
            End If

            If msg.Length > 0 Then
                Throw New Exception("Favor de capturar la siguiente información:\n" & msg)
            End If

            Dim fecha As String = Convert.ToDateTime(dtFechaEfectividad.SelectedDate).ToString("yyyyMMdd")
            Dim vacaciones_tabulador As New VacacionesTabulador(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            vacaciones_tabulador.Guarda(0, txtAñoInicio.Value, txtAñoFin.Value, txtDias.Value, fecha)

            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Datos guardados con exito');window.location='VacacionesTabuladorVer.aspx?fe=" & fecha & "';</script>", False)

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try

    End Sub
End Class
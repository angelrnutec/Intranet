Imports IntranetBL

Public Class TelcelAsignacion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If

        If Not Page.IsPostBack Then
            Me.CargaCombos()
            Me.Busqueda()
            Me.CargaReporteHistorico()
        End If

    End Sub

    Private Sub CargaCombos()
        'recupera_empresas_telcel
        Dim telcel As New Telcel(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ddlEmpresa.DataSource = telcel.RecuperaEmpresas(Session("idEmpleado"), "telcel_asignacion", "--Todas--")
        Me.ddlEmpresa.DataValueField = "id_empresa"
        Me.ddlEmpresa.DataTextField = "nombre"
        Me.ddlEmpresa.DataBind()
    End Sub

    Private Sub Busqueda()
        Try
            Dim telcel As New Telcel(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = telcel.RecuperaTelcelAsignacion(Me.ddlEmpresa.SelectedValue, Me.txtNumero.Text, Me.txtNombre.Text, "", 0)
            Me.gvResultados.DataSource = dt
            Me.gvResultados.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub CargaReporteHistorico()
        Try
            Dim telcel As New Telcel(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = telcel.RecuperaTelcelDessignacion()
            Me.gvResultados2.DataSource = dt
            Me.gvResultados2.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub gvResultados_PageIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles gvResultados.PageIndexChanging
        Me.gvResultados.PageIndex = e.NewPageIndex
        Me.Busqueda()
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

    Private Sub gvResultados_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs) Handles gvResultados.RowCancelingEdit

    End Sub

    Private Sub gvResultados_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvResultados.RowCommand

        Try
            If e.CommandName = "edita" Then
                Response.Redirect("/TelcelAsignacionEdita.aspx?id=" & e.CommandArgument)
                'Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
                'CType(gvRow.FindControl("lblDescripcion"), Label).Visible = False
                'CType(gvRow.FindControl("txtDescripcion"), TextBox).Visible = True

                'CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = False
                'CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = True
                'CType(gvRow.FindControl("btnSave"), ImageButton).Visible = True
                'CType(gvRow.FindControl("btnDelete"), ImageButton).Visible = False
            ElseIf e.CommandName = "cancela" Then
                Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
                CType(gvRow.FindControl("lblDescripcion"), Label).Visible = True
                CType(gvRow.FindControl("txtDescripcion"), TextBox).Visible = False

                CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnDelete"), ImageButton).Visible = True

            ElseIf e.CommandName = "guarda" Then
                Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
                Dim telcel As New Telcel(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

                Dim msg As String = ""
                Dim txtDescripcion As TextBox = CType(gvRow.FindControl("txtDescripcion"), TextBox)
                If txtDescripcion.Text.Length <> 10 Then
                    msg += "El telefono debe ser de 10 digitos\n"
                Else
                    Dim dtAsigna As DataTable = telcel.ValidaTelcelAsignacion(txtDescripcion.Text, e.CommandArgument)
                    If dtAsigna.Rows.Count > 0 Then
                        msg += "El numero ya esta asignado a otro empleado (" & dtAsigna.Rows(0)("empleado") & ")"
                    End If
                End If

                If msg.Length > 0 Then
                    ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & msg & "');</script>", False)
                    Exit Sub
                End If

                telcel.GuardaTelcelAsignacion(txtDescripcion.Text.Trim, e.CommandArgument, Session("idEmpleado"), "", "")


                Dim lblDescripcion As Label = CType(gvRow.FindControl("lblDescripcion"), Label)
                lblDescripcion.Visible = True
                lblDescripcion.Text = txtDescripcion.Text

                CType(gvRow.FindControl("txtDescripcion"), TextBox).Visible = False

                CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnDelete"), ImageButton).Visible = True
            ElseIf e.CommandName = "eliminar" Then
                Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
                Dim telcel As New Telcel(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                telcel.EliminaTelcelAsignacion(e.CommandArgument)
                Me.Busqueda()
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub gvResultados_RowEditing(sender As Object, e As GridViewEditEventArgs) Handles gvResultados.RowEditing

    End Sub

    Private Sub gvResultados_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles gvResultados.RowUpdating

    End Sub

    Protected Sub gvResultados_Sorting(sender As Object, e As GridViewSortEventArgs) Handles gvResultados.Sorting
        Dim sortExpression As String = e.SortExpression

        If GridViewSortDirection = SortDirection.Ascending Then
            GridViewSortDirection = SortDirection.Descending
            SortGridView(sortExpression, " ASC")
        Else
            GridViewSortDirection = SortDirection.Ascending
            SortGridView(sortExpression, " DESC")
        End If

    End Sub

    Private Sub SortGridView(sortExpression As String, direction As String)
        Try
            '  You can cache the DataTable for improving performance
            Dim telcel As New Telcel(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = telcel.RecuperaTelcelAsignacion(Me.ddlEmpresa.SelectedValue, Me.txtNumero.Text, Me.txtNombre.Text, "", 0)
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvResultados.DataSource = dv
            gvResultados.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Protected Sub btnAgregar_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click
        Response.Redirect("/TelcelAsignacionEdita.aspx")
    End Sub

    Protected Sub btnBuscar_Click(sender As Object, e As EventArgs) Handles btnBuscar.Click
        Me.Busqueda()
    End Sub
End Class
Imports IntranetBL

Public Class DepartamentosBusqueda
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.CargaCombos()
            Me.Busqueda()
        End If

    End Sub

    Private Sub CargaCombos()
        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.ddlEmpresaNuevo.DataSource = combos.RecuperaEmpresas()
        Me.ddlEmpresaNuevo.DataValueField = "id_empresa"
        Me.ddlEmpresaNuevo.DataTextField = "nombre"
        Me.ddlEmpresaNuevo.DataBind()

        Me.ddlDirectorAreaNuevo.DataSource = combos.RecuperaEmpleados(0, "--Sin Director--")
        Me.ddlDirectorAreaNuevo.DataValueField = "id_empleado"
        Me.ddlDirectorAreaNuevo.DataTextField = "nombre"
        Me.ddlDirectorAreaNuevo.DataBind()

    End Sub


    Protected Sub btnBuscar_Click(sender As Object, e As EventArgs) Handles btnBuscar.Click
        Me.Busqueda()
    End Sub

    Private Sub Busqueda()
        Try
            Dim departamento As New Departamento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.gvResultados.DataSource = departamento.Recupera(Me.txtBusqueda.Text)
            Me.gvResultados.DataBind()

            Me.gvResultados.Visible = True
            Me.divNuevo.Visible = False
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

        If e.CommandName = "edit" Then
            Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
            CType(gvRow.FindControl("lblDepartamento"), Label).Visible = False
            CType(gvRow.FindControl("txtDepartamento"), TextBox).Visible = True
            CType(gvRow.FindControl("lblClave"), Label).Visible = False
            CType(gvRow.FindControl("txtClave"), TextBox).Visible = True
            CType(gvRow.FindControl("lblEmpresa"), Label).Visible = False
            CType(gvRow.FindControl("lblDirectorArea"), Label).Visible = False


            Dim ddlEmpresaX As DropDownList = CType(gvRow.FindControl("ddlEmpresa"), DropDownList)
            ddlEmpresaX.Visible = True

            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            ddlEmpresaX.DataSource = combos.RecuperaEmpresas()
            ddlEmpresaX.DataValueField = "id_empresa"
            ddlEmpresaX.DataTextField = "nombre"
            ddlEmpresaX.DataBind()
            ddlEmpresaX.SelectedValue = CType(gvRow.FindControl("txtIdEmpresa"), TextBox).Text


            Dim ddlDirectorAreaX As DropDownList = CType(gvRow.FindControl("ddlDirectorArea"), DropDownList)
            ddlDirectorAreaX.Visible = True

            ddlDirectorAreaX.DataSource = combos.RecuperaEmpleados(0, "--Sin Director--")
            ddlDirectorAreaX.DataValueField = "id_empleado"
            ddlDirectorAreaX.DataTextField = "nombre"
            ddlDirectorAreaX.DataBind()
            ddlDirectorAreaX.SelectedValue = CType(gvRow.FindControl("txtIdDirectorArea"), TextBox).Text



            CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = False
            CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnSave"), ImageButton).Visible = True
        ElseIf e.CommandName = "cancel" Then
            Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
            CType(gvRow.FindControl("lblDepartamento"), Label).Visible = True
            CType(gvRow.FindControl("txtDepartamento"), TextBox).Visible = False
            CType(gvRow.FindControl("lblClave"), Label).Visible = True
            CType(gvRow.FindControl("txtClave"), TextBox).Visible = False
            CType(gvRow.FindControl("lblEmpresa"), Label).Visible = True
            CType(gvRow.FindControl("ddlEmpresa"), DropDownList).Visible = False
            CType(gvRow.FindControl("lblDirectorArea"), Label).Visible = True
            CType(gvRow.FindControl("ddlDirectorArea"), DropDownList).Visible = False

            CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
            CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False
        ElseIf e.CommandName = "save" Then
            Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
            Dim txtDepartamento As TextBox = CType(gvRow.FindControl("txtDepartamento"), TextBox)
            Dim txtClave As TextBox = CType(gvRow.FindControl("txtClave"), TextBox)
            Dim ddlEmpresa As DropDownList = CType(gvRow.FindControl("ddlEmpresa"), DropDownList)
            Dim ddlDirectorArea As DropDownList = CType(gvRow.FindControl("ddlDirectorArea"), DropDownList)

            Dim msg As String = ""
            If txtDepartamento.Text.Trim = "" Then
                msg = "Departamento\n"
            End If
            If Not IsNumeric(txtClave.Text) Then
                msg += "Clave numerica\n"
            End If

            If msg.Length > 0 Then
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Favor de ingresar los siguientes datos:\n\n" & msg & "');</script>", False)
                Exit Sub
            End If

            Dim departamento As New Departamento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            departamento.Guarda(e.CommandArgument, txtDepartamento.Text.Trim, txtClave.Text.Trim, ddlEmpresa.SelectedValue, ddlDirectorArea.SelectedValue)

            Dim lblDepartamento As Label = CType(gvRow.FindControl("lblDepartamento"), Label)
            lblDepartamento.Visible = True
            lblDepartamento.Text = txtDepartamento.Text

            Dim lblClave As Label = CType(gvRow.FindControl("lblClave"), Label)
            lblClave.Visible = True
            lblClave.Text = txtClave.Text

            Dim lblEmpresa As Label = CType(gvRow.FindControl("lblEmpresa"), Label)
            lblEmpresa.Visible = True
            lblEmpresa.Text = ddlEmpresa.SelectedItem.Text

            Dim lblDirectorArea As Label = CType(gvRow.FindControl("lblDirectorArea"), Label)
            lblDirectorArea.Visible = True
            lblDirectorArea.Text = ddlDirectorArea.SelectedItem.Text

            CType(gvRow.FindControl("txtDepartamento"), TextBox).Visible = False
            CType(gvRow.FindControl("txtClave"), TextBox).Visible = False
            CType(gvRow.FindControl("ddlEmpresa"), DropDownList).Visible = False
            CType(gvRow.FindControl("ddlDirectorArea"), DropDownList).Visible = False

            CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
            CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False
        End If
    End Sub

    Private Sub gvResultados_RowDeleting(sender As Object, e As GridViewDeleteEventArgs) Handles gvResultados.RowDeleting

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
        '  You can cache the DataTable for improving performance
        Dim departamento As New Departamento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dv As New DataView(departamento.Recupera(Me.txtBusqueda.Text))
        dv.Sort = sortExpression & direction

        gvResultados.DataSource = dv
        gvResultados.DataBind()
    End Sub


    'Private Sub btnAgregar_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click
    '    Me.gvResultados.Visible = False
    '    Me.divNuevo.visible = True
    'End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Me.gvResultados.Visible = True
        Me.divNuevo.Visible = False
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click

        Dim msg As String = ""
        If txtDepartamentoNuevo.Text.Trim = "" Then
            msg = "Departamento\n"
        End If
        If Not IsNumeric(txtClaveNuevo.Text) Then
            msg += "Clave numerica\n"
        End If

        If msg.Length > 0 Then
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Favor de ingresar los siguientes datos:\n\n" & msg & "');</script>", False)
            Exit Sub
        End If

        Dim departamento As New Departamento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        departamento.Guarda(0, txtDepartamentoNuevo.Text.Trim, txtClaveNuevo.Text.Trim, ddlEmpresaNuevo.SelectedValue, ddlDirectorAreaNuevo.SelectedValue)

        Me.Busqueda()

    End Sub
End Class
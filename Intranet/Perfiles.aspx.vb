Imports IntranetBL

Public Class Perfiles
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If

        If Not Page.IsPostBack Then
            Me.Busqueda()
        End If
    End Sub

    Private Sub Busqueda()
        Try
            Dim seg As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.gvResultados.DataSource = seg.RecuperaPerfiles("")
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
            CType(gvRow.FindControl("lblDescripcion"), Label).Visible = False
            CType(gvRow.FindControl("txtDescripcion"), TextBox).Visible = True



            CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = False
            CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnSave"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnEliminar"), ImageButton).Visible = False
        ElseIf e.CommandName = "cancel" Then
            Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
            CType(gvRow.FindControl("lblDescripcion"), Label).Visible = True
            CType(gvRow.FindControl("txtDescripcion"), TextBox).Visible = False

            CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
            CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False
            CType(gvRow.FindControl("btnEliminar"), ImageButton).Visible = True
        ElseIf e.CommandName = "save" Then
            Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
            Dim txtDescripcion As TextBox = CType(gvRow.FindControl("txtDescripcion"), TextBox)

            Dim msg As String = ""
            If txtDescripcion.Text.Trim = "" Then
                msg = "Descripcion\n"
            End If

            If msg.Length > 0 Then
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Favor de ingresar los siguientes datos:\n\n" & msg & "');</script>", False)
                Exit Sub
            End If

            Dim seg As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            seg.GuardaPerfil(e.CommandArgument, txtDescripcion.Text.Trim)

            Dim lblDescripcion As Label = CType(gvRow.FindControl("lblDescripcion"), Label)
            lblDescripcion.Visible = True
            lblDescripcion.Text = txtDescripcion.Text



            CType(gvRow.FindControl("txtDescripcion"), TextBox).Visible = False

            CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
            CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False
            CType(gvRow.FindControl("btnEliminar"), ImageButton).Visible = True

        ElseIf e.CommandName = "eliminar" Then
            Try
                Dim seg As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                seg.EliminaPerfil(e.CommandArgument)

                Me.Busqueda()
            Catch ex As Exception
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
            End Try
        End If
    End Sub

    Private Sub gvResultados_RowDeleting(sender As Object, e As GridViewDeleteEventArgs) Handles gvResultados.RowDeleting

    End Sub

    Private Sub gvResultados_RowEditing(sender As Object, e As GridViewEditEventArgs) Handles gvResultados.RowEditing

    End Sub

    Private Sub gvResultados_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles gvResultados.RowUpdating

    End Sub


    Private Sub btnAgregar_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click
        Me.gvResultados.Visible = False
        Me.divNuevo.Visible = True
        Me.txtDescripcion.Text = ""
    End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Me.gvResultados.Visible = True
        Me.divNuevo.Visible = False
    End Sub

    Private Sub btnGuardarPerfil_Click(sender As Object, e As EventArgs) Handles btnGuardarPerfil.Click
        Try
            Dim msg As String = ""
            If txtDescripcion.Text.Trim = "" Then
                msg = "Descripción\n"
            End If

            If msg.Length > 0 Then
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Favor de ingresar los siguientes datos:\n\n" & msg & "');</script>", False)
                Exit Sub
            End If

            Dim seg As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            seg.GuardaPerfil(0, txtDescripcion.Text.Trim)

            Me.Busqueda()
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub

    Private Sub btnReporte_Click(sender As Object, e As EventArgs) Handles btnReporte.Click
        Dim url As String
        url = "RepSeguridadUsuariosImpresion.aspx"

        Dim script As String = "window.open('" + url + "','')"
        ScriptManager.RegisterClientScriptBlock(Me.Page, Me.Page.GetType(), "NewWindow", script, True)

    End Sub
End Class

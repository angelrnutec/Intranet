Imports IntranetBL

Public Class GruposBusqueda
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
            Dim grupo As New Grupo(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.gvResultados.DataSource = grupo.Recupera()
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

        Try
            If e.CommandName = "edit" Then
                Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
                CType(gvRow.FindControl("lblGrupo"), Label).Visible = False
                CType(gvRow.FindControl("txtGrupo"), TextBox).Visible = True
                CType(gvRow.FindControl("lblDescripcion"), Label).Visible = False
                CType(gvRow.FindControl("txtDescripcion"), TextBox).Visible = True
                CType(gvRow.FindControl("lblEsPrivado"), Label).Visible = False
                CType(gvRow.FindControl("chkPrivado"), CheckBox).Visible = True

                CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnSave"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnMiembros"), ImageButton).Visible = False
            ElseIf e.CommandName = "cancel" Then
                Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
                CType(gvRow.FindControl("lblGrupo"), Label).Visible = True
                CType(gvRow.FindControl("txtGrupo"), TextBox).Visible = False
                CType(gvRow.FindControl("lblDescripcion"), Label).Visible = True
                CType(gvRow.FindControl("txtDescripcion"), TextBox).Visible = False
                CType(gvRow.FindControl("lblEsPrivado"), Label).Visible = True
                CType(gvRow.FindControl("chkPrivado"), CheckBox).Visible = False

                CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnMiembros"), ImageButton).Visible = True

            ElseIf e.CommandName = "save" Then
                Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)

                Dim msg As String = ""
                Dim txtGrupo As TextBox = CType(gvRow.FindControl("txtGrupo"), TextBox)
                Dim txtDescripcion As TextBox = CType(gvRow.FindControl("txtDescripcion"), TextBox)
                Dim chkPrivado As CheckBox = CType(gvRow.FindControl("chkPrivado"), CheckBox)
                If txtGrupo.Text.Trim = "" Then msg += " - Grupo\n"
                If txtDescripcion.Text.Trim = "" Then msg += " - Descripción\n"

                If msg.Length > 0 Then
                    ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & msg & "');</script>", False)
                    Exit Sub
                End If

                Dim grupo As New Grupo(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                grupo.Guarda(e.CommandArgument, txtGrupo.Text.Trim, txtDescripcion.Text.Trim, Session("idEmpleado"), chkPrivado.Checked)

                Dim lblGrupo As Label = CType(gvRow.FindControl("lblGrupo"), Label)
                lblGrupo.Visible = True
                lblGrupo.Text = txtGrupo.Text

                Dim lblDescripcion As Label = CType(gvRow.FindControl("lblDescripcion"), Label)
                lblDescripcion.Visible = True
                lblDescripcion.Text = txtDescripcion.Text

                Dim lblEsPrivado As Label = CType(gvRow.FindControl("lblEsPrivado"), Label)
                lblEsPrivado.Visible = True
                lblEsPrivado.Text = TextoEsPrivado(chkPrivado.Checked)

                CType(gvRow.FindControl("txtGrupo"), TextBox).Visible = False
                CType(gvRow.FindControl("txtDescripcion"), TextBox).Visible = False
                CType(gvRow.FindControl("chkPrivado"), CheckBox).Visible = False

                CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnMiembros"), ImageButton).Visible = True
            ElseIf e.CommandName = "members" Then
                Response.Redirect("GruposMiembros.aspx?id=" & e.CommandArgument)
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
            Dim grupo As New Grupo(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dv As New DataView(grupo.Recupera())
            dv.Sort = sortExpression & direction

            gvResultados.DataSource = dv
            gvResultados.DataBind()
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    Private Sub btnAgregar_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click
        Me.gvResultados.Visible = False
        Me.divNuevo.Visible = True
    End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Me.gvResultados.Visible = True
        Me.divNuevo.Visible = False
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Dim msg As String = ""
            If Me.txtNombre.Text.Trim = "" Then msg += " - Grupo\n"
            If Me.txtDescripcion.Text.Trim = "" Then msg += " - Descripción\n"

            If msg.Length > 0 Then
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & msg & "');</script>", False)
                Exit Sub
            End If

            Dim grupo As New Grupo(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            grupo.Guarda(0, Me.txtNombre.Text, Me.txtDescripcion.Text, Session("idEmpleado"), chkPrivado.Checked)

            Me.Busqueda()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Favor de proporcionar la siguiente información:\n" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Protected Function TextoEsPrivado(privado As Boolean) As String
        Return IIf(privado, "Privado", "Público")
    End Function

End Class
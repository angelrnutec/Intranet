Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class CatalogoAseguradoras
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.Busqueda()
        End If

        Me.btnAgregar.Text = TranslateLocale.text(Me.btnAgregar.Text)
        Me.btnGuardar.Text = TranslateLocale.text(Me.btnGuardar.Text)
        Me.btnCancelar.Text = TranslateLocale.text(Me.btnCancelar.Text)

    End Sub

    Private Sub Busqueda()
        Try
            Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.gvResultados.DataSource = arrendamiento.RecuperaAseguradoras()
            Funciones.TranslateGridviewHeader(Me.gvResultados)
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
                CType(gvRow.FindControl("lblDescripcion"), Label).Visible = False
                CType(gvRow.FindControl("txtDescripcion"), TextBox).Visible = True

                CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnSave"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnDelete"), ImageButton).Visible = False
            ElseIf e.CommandName = "cancel" Then
                Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
                CType(gvRow.FindControl("lblDescripcion"), Label).Visible = True
                CType(gvRow.FindControl("txtDescripcion"), TextBox).Visible = False

                CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnDelete"), ImageButton).Visible = True

            ElseIf e.CommandName = "save" Then
                Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)

                Dim msg As String = ""
                Dim txtDescripcion As TextBox = CType(gvRow.FindControl("txtDescripcion"), TextBox)
                If txtDescripcion.Text.Trim = "" Then msg += " - Descripción\n"

                If msg.Length > 0 Then
                    ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & msg & "');</script>", False)
                    Exit Sub
                End If

                Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                arrendamiento.GuardaAseguradora(e.CommandArgument, txtDescripcion.Text.Trim, False)


                Dim lblDescripcion As Label = CType(gvRow.FindControl("lblDescripcion"), Label)
                lblDescripcion.Visible = True
                lblDescripcion.Text = txtDescripcion.Text

                CType(gvRow.FindControl("txtDescripcion"), TextBox).Visible = False

                CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnDelete"), ImageButton).Visible = True
            ElseIf e.CommandName = "eliminar" Then
                Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                arrendamiento.GuardaAseguradora(e.CommandArgument, txtDescripcion.Text.Trim, True)
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
            Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dv As New DataView(arrendamiento.RecuperaAseguradoras())
            dv.Sort = sortExpression & direction

            gvResultados.DataSource = dv
            Funciones.TranslateGridviewHeader(Me.gvResultados)
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
            If Me.txtDescripcion.Text.Trim = "" Then msg += " - Descripción\n"

            If msg.Length > 0 Then
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & msg & "');</script>", False)
                Exit Sub
            End If

            Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            arrendamiento.GuardaAseguradora(0, Me.txtDescripcion.Text.Trim, False)

            Me.Busqueda()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Favor de proporcionar la siguiente información:\n" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


End Class
Imports IntranetBL

Public Class ExcepcionesReportes
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If


        If Not Page.IsPostBack Then
            Me.Busqueda()
        End If


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

    Private Sub gvResultadosCentroCosto_PageIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles gvResultadosCentroCosto.PageIndexChanging
        Me.gvResultadosCentroCosto.PageIndex = e.NewPageIndex
        Me.Busqueda()
    End Sub

    Protected Sub gvResultadosCentroCosto_Sorting(sender As Object, e As GridViewSortEventArgs) Handles gvResultadosCentroCosto.Sorting
        Dim sortExpression As String = e.SortExpression

        If GridViewSortDirection = SortDirection.Ascending Then
            GridViewSortDirection = SortDirection.Descending
            SortGridView(sortExpression, " ASC", 2)
        Else
            GridViewSortDirection = SortDirection.Ascending
            SortGridView(sortExpression, " DESC", 2)
        End If

    End Sub

    Protected Sub gvResultadosCentroCosto_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvResultadosCentroCosto.RowDataBound

    End Sub

    Private Sub gvResultadosCentroCosto_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs) Handles gvResultadosCentroCosto.RowCancelingEdit

    End Sub

    Private Sub gvResultadosCentroCosto_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvResultadosCentroCosto.RowCommand

        Try
            If e.CommandName = "edit" Then
                Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
                CType(gvRow.FindControl("lblCentroCosto"), Label).Visible = False
                CType(gvRow.FindControl("txtCentroCosto"), TextBox).Visible = True

                CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnSave"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnDelete"), ImageButton).Visible = False
            ElseIf e.CommandName = "cancel" Then
                Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
                CType(gvRow.FindControl("lblCentroCosto"), Label).Visible = True
                CType(gvRow.FindControl("txtCentroCosto"), TextBox).Visible = False

                CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnDelete"), ImageButton).Visible = True

            ElseIf e.CommandName = "save" Then
                Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)

                Dim msg As String = ""
                Dim txtCentroCosto As TextBox = CType(gvRow.FindControl("txtCentroCosto"), TextBox)
                If txtCentroCosto.Text.Trim = "" Then msg += " - Centro de Costo\n"

                If msg.Length > 0 Then
                    ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & msg & "');</script>", False)
                    Exit Sub
                End If

                Dim gastos As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                gastos.GuardaExcepcion(e.CommandArgument, Nothing, txtCentroCosto.Text.Trim)


                Dim lblCentroCosto As Label = CType(gvRow.FindControl("lblCentroCosto"), Label)
                lblCentroCosto.Visible = True
                lblCentroCosto.Text = txtCentroCosto.Text

                CType(gvRow.FindControl("txtCentroCosto"), TextBox).Visible = False

                CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnDelete"), ImageButton).Visible = True

            ElseIf e.CommandName = "eliminar" Then
                Dim gastos As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                gastos.EliminaExcepcion(e.CommandArgument)
                Me.Busqueda()
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub

    Private Sub gvResultadosCentroCosto_RowEditing(sender As Object, e As GridViewEditEventArgs) Handles gvResultadosCentroCosto.RowEditing

    End Sub

    Private Sub gvResultadosCentroCosto_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles gvResultadosCentroCosto.RowUpdating

    End Sub


    Private Sub gvResultadosTipoCosto_PageIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles gvResultadosTipoCosto.PageIndexChanging
        Me.gvResultadosTipoCosto.PageIndex = e.NewPageIndex
        Me.Busqueda()
    End Sub

    Protected Sub gvResultadosTipoCosto_Sorting(sender As Object, e As GridViewSortEventArgs) Handles gvResultadosTipoCosto.Sorting
        Dim sortExpression As String = e.SortExpression

        If GridViewSortDirection = SortDirection.Ascending Then
            GridViewSortDirection = SortDirection.Descending
            SortGridView(sortExpression, " ASC", 1)
        Else
            GridViewSortDirection = SortDirection.Ascending
            SortGridView(sortExpression, " DESC", 1)
        End If

    End Sub

    Protected Sub gvResultadosTipoCosto_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvResultadosTipoCosto.RowDataBound

    End Sub

    Private Sub gvResultadosTipoCosto_RowCancelingEdit(sender As Object, e As GridViewCancelEditEventArgs) Handles gvResultadosTipoCosto.RowCancelingEdit

    End Sub

    Private Sub gvResultadosTipoCosto_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvResultadosTipoCosto.RowCommand

        Try
            If e.CommandName = "edit" Then
                Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
                CType(gvRow.FindControl("lblTipoCosto"), Label).Visible = False
                CType(gvRow.FindControl("txtTipoCosto"), TextBox).Visible = True

                CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnSave"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnDelete"), ImageButton).Visible = False
            ElseIf e.CommandName = "cancel" Then
                Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
                CType(gvRow.FindControl("lblTipoCosto"), Label).Visible = True
                CType(gvRow.FindControl("txtTipoCosto"), TextBox).Visible = False

                CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnDelete"), ImageButton).Visible = True

            ElseIf e.CommandName = "save" Then
                Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)

                Dim msg As String = ""
                Dim txtTipoCosto As TextBox = CType(gvRow.FindControl("txtTipoCosto"), TextBox)
                If txtTipoCosto.Text.Trim = "" Then msg += " - Tipo de Costo\n"

                If msg.Length > 0 Then
                    ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & msg & "');</script>", False)
                    Exit Sub
                End If

                Dim gastos As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                gastos.GuardaExcepcion(e.CommandArgument, txtTipoCosto.Text.Trim, Nothing)


                Dim lblTipoCosto As Label = CType(gvRow.FindControl("lblTipoCosto"), Label)
                lblTipoCosto.Visible = True
                lblTipoCosto.Text = txtTipoCosto.Text

                CType(gvRow.FindControl("txtTipoCosto"), TextBox).Visible = False

                CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnDelete"), ImageButton).Visible = True
            ElseIf e.CommandName = "eliminar" Then
                Dim gastos As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                gastos.EliminaExcepcion(e.CommandArgument)
                Me.Busqueda()
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub

    Private Sub gvResultadosTipoCosto_RowEditing(sender As Object, e As GridViewEditEventArgs) Handles gvResultadosTipoCosto.RowEditing

    End Sub

    Private Sub gvResultadosTipoCosto_RowUpdating(sender As Object, e As GridViewUpdateEventArgs) Handles gvResultadosTipoCosto.RowUpdating

    End Sub

    Private Sub SortGridView(sortExpression As String, direction As String, ByVal tipo As String)
        Try
            '  You can cache the DataTable for improving performance
            Dim gastos As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            If tipo = 1 Then

                Dim dt As DataTable = gastos.RecuperaExcepcion(1)
                Dim dv As New DataView(dt)
                dv.Sort = sortExpression & direction

                gvResultadosTipoCosto.DataSource = dv
                gvResultadosTipoCosto.DataBind()
            Else                
                Dim dt As DataTable = gastos.RecuperaExcepcion(2)
                Dim dv As New DataView(dt)
                dv.Sort = sortExpression & direction

                gvResultadosCentroCosto.DataSource = dv
                gvResultadosCentroCosto.DataBind()
            End If


        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub Busqueda()
        Try
            Dim gastos As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))


            Dim dt As DataTable = gastos.RecuperaExcepcion(1)
            gvResultadosTipoCosto.DataSource = dt
            gvResultadosTipoCosto.DataBind()

            dt = gastos.RecuperaExcepcion(2)
            gvResultadosCentroCosto.DataSource = dt
            gvResultadosCentroCosto.DataBind()


        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    Protected Sub btnAgregarTipoCosto_Click(sender As Object, e As EventArgs) Handles btnAgregarTipoCosto.Click
        Try
            If txtTipoCosto.Text.Trim.Length = 0 Then
                Throw New Exception("Debe ingresar el Tipo de Costo")
            End If

            Dim gastos As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            gastos.GuardaExcepcion(0, txtTipoCosto.Text.Trim, Nothing)

            Dim dt As DataTable = gastos.RecuperaExcepcion(1)
            gvResultadosTipoCosto.DataSource = dt
            gvResultadosTipoCosto.DataBind()

            txtTipoCosto.Text = ""

            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Datos guardados con exito');</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Protected Sub btnAgregarCentroCosto_Click(sender As Object, e As EventArgs) Handles btnAgregarCentroCosto.Click
        Try
            If txtCentroCosto.Text.Trim.Length = 0 Then
                Throw New Exception("Debe ingresar el Centro de Costo")
            End If

            Dim gastos As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            gastos.GuardaExcepcion(0, Nothing, txtCentroCosto.Text.Trim)

            Dim dt As DataTable = gastos.RecuperaExcepcion(2)
            gvResultadosCentroCosto.DataSource = dt
            gvResultadosCentroCosto.DataBind()

            txtCentroCosto.Text = ""

            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Datos guardados con exito');</script>", False)

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub
End Class
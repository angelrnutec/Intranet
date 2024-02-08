Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class PublicacionesBusqueda
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.Busqueda()
        End If

        Me.btnAgregar.Text = TranslateLocale.text(Me.btnAgregar.Text)
        Me.rbActivo.Text = TranslateLocale.text(Me.rbActivo.Text)
        Me.rbBorrado.Text = TranslateLocale.text(Me.rbBorrado.Text)
        Me.rbNoVisible.Text = TranslateLocale.text(Me.rbNoVisible.Text)
        Me.rbVisible.Text = TranslateLocale.text(Me.rbVisible.Text)

    End Sub

    Private Sub Busqueda()
        Try

            Dim publicacion As New Publicacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Dim dt As DataTable = publicacion.Recupera(IIf(rbVisible.Checked, "V", "I"), IIf(rbActivo.Checked, "0", "1"), Session("idEmpleado"), Funciones.CurrentLocale)

            Funciones.TranslateTableData(dt, {"tipo_publicacion"})
            Me.gvResultados.DataSource = dt
            Funciones.TranslateGridviewHeader(gvResultados)
            Me.gvResultados.EmptyDataText = TranslateLocale.text(Me.gvResultados.EmptyDataText)
            Me.gvResultados.DataBind()
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
            Dim publicacion As New Publicacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dv As New DataView(publicacion.Recupera(IIf(rbVisible.Checked, "V", "I"), IIf(rbActivo.Checked, "0", "1"), Session("idEmpleado"), Funciones.CurrentLocale))
            dv.Sort = sortExpression & direction

            gvResultados.DataSource = dv
            Funciones.TranslateGridviewHeader(gvResultados)
            gvResultados.DataBind()
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    Private Sub rbActivo_CheckedChanged(sender As Object, e As EventArgs) Handles rbActivo.CheckedChanged
        Me.Busqueda()
    End Sub

    Private Sub rbBorrado_CheckedChanged(sender As Object, e As EventArgs) Handles rbBorrado.CheckedChanged
        Me.Busqueda()
    End Sub

    Private Sub rbNoVisible_CheckedChanged(sender As Object, e As EventArgs) Handles rbNoVisible.CheckedChanged
        Me.Busqueda()
    End Sub

    Private Sub rbVisible_CheckedChanged(sender As Object, e As EventArgs) Handles rbVisible.CheckedChanged
        Me.Busqueda()
    End Sub

    Private Sub btnAgregar_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click
        Response.Redirect("PublicacionesAgregar.aspx")
    End Sub
End Class
Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class ArrendamientoListado
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If

        If Not Page.IsPostBack Then
            Me.CargaCombos()
        End If

        Me.btnAgregar.Text = TranslateLocale.text("Agregar")
        Me.btnBuscar.Text = TranslateLocale.text("Buscar")
    End Sub

    Private Sub CargaCombos()
        Try
            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Me.ddlEmpresa.Items.Clear()
            Me.ddlEmpresa.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpresaArrendamiento(Session("idEmpleado")), "nombre", "id_empresa"))

            Me.ddlCategoriaArrendamiento.Items.Clear()
            Me.ddlCategoriaArrendamiento.Items.AddRange(Funciones.DatatableToList(combos.RecuperaCategoriaArrendamiento(Session("idEmpleado")), "descripcion", "id_categoria_arrendamiento"))

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub

    Private Sub Busqueda()
        Try
            Dim mensaje As String = ""
            If Me.ddlEmpresa.SelectedValue = 0 Then
                mensaje += " - " & TranslateLocale.text("Empresa") & "\n"
            End If
            If Me.ddlCategoriaArrendamiento.SelectedValue = 0 Then
                mensaje += " - " & TranslateLocale.text("Categoría") & "\n"
            End If

            If mensaje.Length > 0 Then
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("Favor de capturar y/o revisar la siguiente información") & ":\n" & mensaje & "');</script>", False)
            Else

                Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Dim dt As DataTable = arrendamiento.RecuperaArrendamientos(Me.ddlEmpresa.SelectedValue, Me.ddlCategoriaArrendamiento.SelectedValue)
                Me.gvResultados.DataSource = dt
                Funciones.TranslateGridviewHeader(Me.gvResultados)
                Me.gvResultados.EmptyDataText = TranslateLocale.text(Me.gvResultados.EmptyDataText)
                Me.gvResultados.DataBind()

            End If


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
            Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = arrendamiento.RecuperaArrendamientos(Me.ddlEmpresa.SelectedValue, Me.ddlCategoriaArrendamiento.SelectedValue)
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvResultados.DataSource = dv
            Funciones.TranslateGridviewHeader(Me.gvResultados)
            gvResultados.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Protected Sub btnAgregar_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click
        If Me.ddlCategoriaArrendamiento.SelectedValue = 0 Or Me.ddlEmpresa.SelectedValue = 0 Then
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Debes seleccionar Empresa y Categoria');</script>", False)
        Else
            Response.Redirect("/ArrendamientoDetalle.aspx?id=0&idCategoria=" & Me.ddlCategoriaArrendamiento.SelectedValue & "&idEmpresa=" & Me.ddlEmpresa.SelectedValue)
        End If
    End Sub

    Protected Sub btnBuscar_Click(sender As Object, e As EventArgs) Handles btnBuscar.Click
        Me.Busqueda()
    End Sub
End Class
Imports IntranetBL

Public Class CentroCostoBusqueda
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If

        If Not Page.IsPostBack Then
            Me.CargaCombos()
        End If

        Me.Busqueda()
    End Sub

    Private Sub CargaCombos()
        Try
            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.ddlEmpresa.DataSource = combos.RecuperaEmpresaConceptoGasto(2)
            Me.ddlEmpresa.DataValueField = "id_empresa"
            Me.ddlEmpresa.DataTextField = "nombre"
            Me.ddlEmpresa.DataBind()


        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub

    Private Sub Busqueda()
        Try
            Dim centro_costo As New CentroCosto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = centro_costo.Recupera(Me.ddlEmpresa.SelectedValue)
            Me.gvResultados.DataSource = dt
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
            Dim centro_costo As New CentroCosto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = centro_costo.Recupera(Me.ddlEmpresa.SelectedValue)
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvResultados.DataSource = dv
            gvResultados.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Protected Sub btnAgregar_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click
        Response.Redirect("/CentroCostoVer.aspx?id=0")
    End Sub

    Protected Sub btnBuscar_Click(sender As Object, e As EventArgs) Handles btnBuscar.Click
        Me.Busqueda()
    End Sub
End Class
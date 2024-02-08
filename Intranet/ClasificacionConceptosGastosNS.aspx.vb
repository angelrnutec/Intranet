Imports IntranetBL

Public Class ClasificacionConceptosGastosNS
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If


        If Not Page.IsPostBack Then
            Me.CargaCombos()
            Me.btnGuardar.Visible = False
        End If


    End Sub

    Private Sub CargaCombos()
        Try
            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.ddlClasificacionCosto.DataSource = combos.RecuperaGastosNSClasificacion("T")
            Me.ddlClasificacionCosto.DataValueField = "id_clasificacion_costo"
            Me.ddlClasificacionCosto.DataTextField = "descripcion"
            Me.ddlClasificacionCosto.DataBind()

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
            Dim tipo As Integer = 0

            If Me.rbClasificado.Checked = True Then
                tipo = 1
            End If

            Dim gastos As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = gastos.RecuperaClasificacion(tipo, Me.ddlClasificacionCosto.SelectedValue)
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvResultados.DataSource = dv
            gvResultados.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Protected Sub btnConsultar_Click(sender As Object, e As EventArgs) Handles btnConsultar.Click
        Me.btnGuardar.Visible = True
        Me.Busqueda()
    End Sub

    Private Sub Busqueda()
        Try
            Dim tipo As Integer = 0

            If Me.rbClasificado.Checked = True Then
                tipo = 1
            End If

            Dim gastos As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = gastos.RecuperaClasificacion(tipo, Me.ddlClasificacionCosto.SelectedValue)

            gvResultados.DataSource = dt
            gvResultados.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
    Dim dtClasificacion As DataTable = combos.RecuperaGastosNSClasificacion("Si")

    Protected Sub gvResultados_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvResultados.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim ddlClasificacion As DropDownList = TryCast(e.Row.FindControl("ddlClasificacion"), DropDownList)

            ddlClasificacion.DataSource = dtClasificacion
            ddlClasificacion.DataValueField = "id_clasificacion_costo"
            ddlClasificacion.DataTextField = "descripcion"
            ddlClasificacion.DataBind()

            Dim rowView As DataRowView = DirectCast(e.Row.DataItem, DataRowView)
            Dim id_clasificacion_costo As Integer = rowView("id_clasificacion_costo")
            ddlClasificacion.SelectedValue = id_clasificacion_costo

        End If
    End Sub

    Protected Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            For Each gvr As GridViewRow In gvResultados.Rows
                Dim ddlClasificacion As DropDownList = CType(gvr.FindControl("ddlClasificacion"), DropDownList)

                Dim denominacion_sap As String = DirectCast(Me.gvResultados.DataKeys(gvr.RowIndex)("denominacion_sap"), String)
                Dim id_detalle As Integer = DirectCast(Me.gvResultados.DataKeys(gvr.RowIndex)("id_detalle"), Integer)

                Dim gastos As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

                If ddlClasificacion.SelectedValue > 0 Then
                    gastos.GuardaClasificacionDetalle(id_detalle, ddlClasificacion.SelectedValue, denominacion_sap)
                Else
                    If id_detalle > 0 Then
                        gastos.EliminaClasificacionDetalle(id_detalle)
                    End If

                End If
            Next

            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Datos guardados con exito');</script>", False)

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub


End Class
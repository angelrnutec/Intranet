Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class RepFinancierosCierres
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.CargaCombos()

            Me.ddlAnio.SelectedValue = Now.AddMonths(-1).Year
            Me.ddlPeriodo.SelectedValue = Now.AddMonths(-1).Month

            Me.btnBuscar.Text = TranslateLocale.text("Buscar")
        End If


    End Sub

    Private Sub CargaCombos()
        Try

            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.ddlAnio.DataSource = combos.RecuperaAnio("")
            Me.ddlAnio.DataValueField = "id_anio"
            Me.ddlAnio.DataTextField = "anio"
            Me.ddlAnio.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub

    Private Sub CargaGrid()
        Try
            Dim reporte As New ReporteCierre(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = reporte.Recupera(Me.ddlAnio.SelectedValue, Me.ddlPeriodo.SelectedValue)
            Me.gvResultados.DataSource = dt
            Funciones.TranslateGridviewHeader(Me.gvResultados)
            Me.gvResultados.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Protected Sub btnBuscar_Click(sender As Object, e As EventArgs) Handles btnBuscar.Click
        CargaGrid()
    End Sub

    Private Sub gvResultados_PageIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles gvResultados.PageIndexChanging
        Me.gvResultados.PageIndex = e.NewPageIndex
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
            Dim reporte As New ReporteCierre(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = reporte.Recupera(Me.ddlAnio.SelectedValue, Me.ddlPeriodo.SelectedValue)
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvResultados.DataSource = dv
            gvResultados.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub gvResultados_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvResultados.RowCommand
        Try
            Dim reporte As New ReporteCierre(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            If e.CommandName = "abrir" Then
                If e.CommandArgument = "0" Then
                    Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
                    reporte.GuardaCierre(0, CType(gvRow.FindControl("lblAnio"), Label).Text, CType(gvRow.FindControl("lblMes"), Label).Text, "A", Session("idEmpleado"), CType(gvRow.FindControl("lblIdEmpresa"), Label).Text)
                Else
                    reporte.ActualizaEstatus(e.CommandArgument, "A", Session("idEmpleado"))
                End If
                CargaGrid()
            ElseIf e.CommandName = "cerrar" Then
                If e.CommandArgument = "0" Then
                    Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
                    reporte.GuardaCierre(0, CType(gvRow.FindControl("lblAnio"), Label).Text, CType(gvRow.FindControl("lblMes"), Label).Text, "C", Session("idEmpleado"), CType(gvRow.FindControl("lblIdEmpresa"), Label).Text)
                Else
                    reporte.ActualizaEstatus(e.CommandArgument, "C", Session("idEmpleado"))
                End If
                CargaGrid()
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub gvResultados_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvResultados.RowDataBound



        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Cells(1).Text = TranslateLocale.text(e.Row.Cells(1).Text)
            e.Row.Cells(2).Text = TranslateLocale.text(e.Row.Cells(2).Text)

            Dim btnAbrir As ImageButton = TryCast(e.Row.FindControl("btnAbrir"), ImageButton)
            Dim btnCerrar As ImageButton = TryCast(e.Row.FindControl("btnCerrar"), ImageButton)

            Dim rowView As DataRowView = DirectCast(e.Row.DataItem, DataRowView)
            Dim myDataKey As String = rowView("estatus")

            If myDataKey = "A" Then
                btnAbrir.Visible = False
            Else
                btnCerrar.Visible = False
            End If
        End If
    End Sub
End Class

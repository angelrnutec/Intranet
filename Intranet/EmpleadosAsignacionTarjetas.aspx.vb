Imports IntranetBL
Imports System.Web.Services
Imports Intranet.LocalizationIntranet

Public Class EmpleadosAsignacionTarjetas
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            CargaCombos()
        End If

    End Sub

    Protected Sub btnBuscar_Click(sender As Object, e As EventArgs) Handles btnBuscar.Click
        Me.Busqueda()
    End Sub

    Private Sub CargaCombos()
        Try
            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.ddlEmpresa.Items.Clear()
            Me.ddlEmpresa.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpresaRepSolicitudes(Session("idEmpleado"), "rep_gas_via"), "nombre", "id_empresa"))

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub

    Private Sub Busqueda()
        Try
            Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = empleado.RecuperaPorPermisos(Me.txtBusqueda.Text, Me.ddlEmpresa.SelectedValue, Session("idEmpleado"), "rep_gas_via")
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

    Private Sub gvResultados_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvResultados.RowCommand
        If e.CommandName = "editar" Then
            Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
            CType(gvRow.FindControl("lblTarjetaTE"), Label).Visible = False
            CType(gvRow.FindControl("txtTarjetaTE"), TextBox).Visible = True
            CType(gvRow.FindControl("lblTarjetaAMEX"), Label).Visible = False
            CType(gvRow.FindControl("txtTarjetaAMEX"), TextBox).Visible = True


            CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = False
            CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnSave"), ImageButton).Visible = True
        ElseIf e.CommandName = "cancelar" Then
            Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
            CType(gvRow.FindControl("lblTarjetaTE"), Label).Visible = True
            CType(gvRow.FindControl("txtTarjetaTE"), TextBox).Visible = False
            CType(gvRow.FindControl("lblTarjetaAMEX"), Label).Visible = True
            CType(gvRow.FindControl("txtTarjetaAMEX"), TextBox).Visible = False

            CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
            CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False

        ElseIf e.CommandName = "save" Then
            Try
                Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
                Dim txtTarjetaTE As TextBox = CType(gvRow.FindControl("txtTarjetaTE"), TextBox)
                Dim txtTarjetaAMEX As TextBox = CType(gvRow.FindControl("txtTarjetaAMEX"), TextBox)

                Dim msg As String = ""
                If txtTarjetaTE.Text.Length > 0 And txtTarjetaTE.Text.Length <> 5 Then
                    msg = " - Tarjeta TE debe tener longitud de 5\n"
                End If
                If txtTarjetaAMEX.Text.Length > 0 And txtTarjetaAMEX.Text.Length <> 15 Then
                    msg += " - Tarjeta AMEX debe tener longitud de 15\n"
                End If


                If msg.Length > 0 Then
                    ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("Favor de ingresar los siguientes datos") & ":\n\n" & msg & "');</script>", False)
                    Exit Sub
                End If


                Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                empleado.GuardaTarjetaGastos(e.CommandArgument, txtTarjetaTE.Text, txtTarjetaAMEX.Text)

                Dim lblTarjetaTE As Label = CType(gvRow.FindControl("lblTarjetaTE"), Label)
                lblTarjetaTE.Visible = True
                lblTarjetaTE.Text = txtTarjetaTE.Text

                Dim lblTarjetaAMEX As Label = CType(gvRow.FindControl("lblTarjetaAMEX"), Label)
                lblTarjetaAMEX.Visible = True
                lblTarjetaAMEX.Text = txtTarjetaAMEX.Text


                CType(gvRow.FindControl("txtTarjetaTE"), TextBox).Visible = False
                CType(gvRow.FindControl("txtTarjetaAMEX"), TextBox).Visible = False

                CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
                CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
                CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False
            Catch ex As Exception
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
            End Try

        End If

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
            Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = empleado.RecuperaPorPermisos(Me.txtBusqueda.Text, Me.ddlEmpresa.SelectedValue, Session("idEmpleado"), "rep_gas_via")
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvResultados.DataSource = dv
            gvResultados.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

End Class
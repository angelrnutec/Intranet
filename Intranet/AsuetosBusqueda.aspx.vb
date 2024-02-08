Imports IntranetBL

Public Class AsuetosBusqueda
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.CargaCombos()
            Me.Busqueda()
        End If

    End Sub

    Private Sub CargaCombos()

        For i As Integer = 2013 To DateTime.Now.Year + 1
            Me.ddlAnio.Items.Add(i.ToString())
        Next

        Me.ddlAnio.SelectedValue = DateTime.Now.Year

    End Sub


    Private Sub Busqueda()
        Try
            Dim asueto As New Asueto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.gvResultados.DataSource = asueto.Recupera(Me.ddlAnio.SelectedValue, Me.ddlPais.SelectedValue)
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
        If e.CommandName = "eliminar" Then
            Try
                Dim asueto As New Asueto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                asueto.Elimina(e.CommandArgument)

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

        Me.dtFecha.SelectedDate = Nothing
        Me.txtDescripcion.Text = ""
    End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Me.gvResultados.Visible = True
        Me.divNuevo.Visible = False
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Dim msg As String = ""
            If txtDescripcion.Text.Trim = "" Then
                msg = "Descripción\n"
            End If
            If dtFecha.SelectedDate Is Nothing Then
                msg += "Fecha\n"
            End If

            If msg.Length > 0 Then
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Favor de ingresar los siguientes datos:\n\n" & msg & "');</script>", False)
                Exit Sub
            End If

            Dim asueto As New Asueto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            asueto.Guarda(dtFecha.SelectedDate, txtDescripcion.Text.Trim, Session("idEmpleado"), Me.chkMedioDia.Checked, Me.ddlPais.SelectedValue)

            Me.Busqueda()
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub

    Private Sub ddlAnio_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlAnio.SelectedIndexChanged
        Me.Busqueda()
    End Sub

    Private Sub ddlPais_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlPais.SelectedIndexChanged
        Me.Busqueda()
    End Sub
End Class
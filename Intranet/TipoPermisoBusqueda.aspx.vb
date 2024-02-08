Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class TipoPermisoBusqueda
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.Busqueda()
        End If

        Me.btnAgregar.Text = TranslateLocale.text("Agregar")
        Me.btnCancelar.Text = TranslateLocale.text("Salir")
        Me.btnGuardar.Text = TranslateLocale.text("Guardar")
        Me.chkConGoceNuevo.Text = TranslateLocale.text("Con Goce de Sueldo")
        Me.chkSinGoceNuevo.Text = TranslateLocale.text("Sin Goce de Sueldo")
    End Sub


    Private Sub Busqueda()
        Try
            Dim tipo_permiso As New TipoPermiso(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.gvResultados.DataSource = tipo_permiso.Recupera()
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

        If e.CommandName = "edit" Then
            Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
            CType(gvRow.FindControl("lblDescripcion"), Label).Visible = False
            CType(gvRow.FindControl("txtDescripcion"), TextBox).Visible = True
            CType(gvRow.FindControl("lblDescripcionEn"), Label).Visible = False
            CType(gvRow.FindControl("txtDescripcionEn"), TextBox).Visible = True
            CType(gvRow.FindControl("lblConGoce"), Label).Visible = False
            CType(gvRow.FindControl("chkConGoce"), CheckBox).Visible = True
            CType(gvRow.FindControl("lblSinGoce"), Label).Visible = False
            CType(gvRow.FindControl("chkSinGoce"), CheckBox).Visible = True

            CType(gvRow.FindControl("lblMaxDiasDesc"), Label).Visible = False
            CType(gvRow.FindControl("ddlMaxDias"), DropDownList).Visible = True
            CType(gvRow.FindControl("ddlMaxDias"), DropDownList).SelectedValue = CType(gvRow.FindControl("lblMaxDias"), Label).Text


            CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = False
            CType(gvRow.FindControl("btnDelete"), ImageButton).Visible = False
            CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnSave"), ImageButton).Visible = True
        ElseIf e.CommandName = "eliminar" Then
            Dim tipo_permiso As New TipoPermiso(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            tipo_permiso.Elimina(e.CommandArgument)
            Me.Busqueda()

        ElseIf e.CommandName = "cancel" Then
            Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
            CType(gvRow.FindControl("lblDescripcion"), Label).Visible = True
            CType(gvRow.FindControl("txtDescripcion"), TextBox).Visible = False
            CType(gvRow.FindControl("lblDescripcionEn"), Label).Visible = True
            CType(gvRow.FindControl("txtDescripcionEn"), TextBox).Visible = False
            CType(gvRow.FindControl("lblConGoce"), Label).Visible = True
            CType(gvRow.FindControl("chkConGoce"), CheckBox).Visible = False
            CType(gvRow.FindControl("lblSinGoce"), Label).Visible = True
            CType(gvRow.FindControl("chkSinGoce"), CheckBox).Visible = False

            CType(gvRow.FindControl("lblMaxDiasDesc"), Label).Visible = True
            CType(gvRow.FindControl("ddlMaxDias"), DropDownList).Visible = False


            CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnDelete"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
            CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False
        ElseIf e.CommandName = "save" Then
            Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
            Dim txtDescripcion As TextBox = CType(gvRow.FindControl("txtDescripcion"), TextBox)
            Dim txtDescripcionEn As TextBox = CType(gvRow.FindControl("txtDescripcionEn"), TextBox)
            Dim chkConGoce As CheckBox = CType(gvRow.FindControl("chkConGoce"), CheckBox)
            Dim chkSinGoce As CheckBox = CType(gvRow.FindControl("chkSinGoce"), CheckBox)
            Dim ddlMaxDias As DropDownList = CType(gvRow.FindControl("ddlMaxDias"), DropDownList)

            Dim msg As String = ""
            If txtDescripcion.Text.Trim = "" Then
                msg = "Descripcion\n"
            End If
            If txtDescripcionEn.Text.Trim = "" Then
                msg = "Descripcion ingles\n"
            End If

            If msg.Length > 0 Then
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Favor de ingresar los siguientes datos:\n\n" & msg & "');</script>", False)
                Exit Sub
            End If

            Dim tipo_permiso As New TipoPermiso(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            tipo_permiso.Guarda(e.CommandArgument, txtDescripcion.Text.Trim, txtDescripcionEn.Text.Trim, chkConGoce.Checked, chkSinGoce.Checked, ddlMaxDias.SelectedValue)

            Dim lblDescripcion As Label = CType(gvRow.FindControl("lblDescripcion"), Label)
            lblDescripcion.Visible = True
            lblDescripcion.Text = txtDescripcion.Text

            Dim lblDescripcionEn As Label = CType(gvRow.FindControl("lblDescripcionEn"), Label)
            lblDescripcionEn.Visible = True
            lblDescripcionEn.Text = txtDescripcionEn.Text

            Dim lblConGoce As Label = CType(gvRow.FindControl("lblConGoce"), Label)
            lblConGoce.Visible = True
            lblConGoce.Text = IIf(chkConGoce.Checked, "Si", "No")

            Dim lblSinGoce As Label = CType(gvRow.FindControl("lblSinGoce"), Label)
            lblSinGoce.Visible = True
            lblSinGoce.Text = IIf(chkSinGoce.Checked, "Si", "No")

            Dim lblMaxDiasDesc As Label = CType(gvRow.FindControl("lblMaxDiasDesc"), Label)
            lblMaxDiasDesc.Visible = True
            lblMaxDiasDesc.Text = IIf(ddlMaxDias.SelectedValue = 999, "Sin Limite", ddlMaxDias.SelectedValue)

            Dim lblMaxDias As Label = CType(gvRow.FindControl("lblMaxDias"), Label)
            lblMaxDias.Text = ddlMaxDias.SelectedValue

            CType(gvRow.FindControl("txtDescripcion"), TextBox).Visible = False
            CType(gvRow.FindControl("txtDescripcionEn"), TextBox).Visible = False
            CType(gvRow.FindControl("chkConGoce"), CheckBox).Visible = False
            CType(gvRow.FindControl("chkSinGoce"), CheckBox).Visible = False
            CType(gvRow.FindControl("ddlMaxDias"), DropDownList).Visible = False

            CType(gvRow.FindControl("btnEdit"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnDelete"), ImageButton).Visible = True
            CType(gvRow.FindControl("btnCancel"), ImageButton).Visible = False
            CType(gvRow.FindControl("btnSave"), ImageButton).Visible = False
        End If
    End Sub

    Private Sub gvResultados_RowDeleting(sender As Object, e As GridViewDeleteEventArgs) Handles gvResultados.RowDeleting

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
        '  You can cache the DataTable for improving performance
        Dim tipo_permiso As New TipoPermiso(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dv As New DataView(tipo_permiso.Recupera())
        dv.Sort = sortExpression & direction

        gvResultados.DataSource = dv
        Funciones.TranslateGridviewHeader(Me.gvResultados)
        gvResultados.DataBind()
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

        Dim msg As String = ""
        If txtDescripcionNuevo.Text.Trim = "" Then
            msg = "Descripcion\n"
        End If
        If txtDescripcionEnNuevo.Text.Trim = "" Then
            msg = "Descripcion ingles\n"
        End If

        If msg.Length > 0 Then
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Favor de ingresar los siguientes datos:\n\n" & msg & "');</script>", False)
            Exit Sub
        End If

        Dim tipo_permiso As New TipoPermiso(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        tipo_permiso.Guarda(0, txtDescripcionNuevo.Text.Trim, txtDescripcionEnNuevo.Text.Trim, chkConGoceNuevo.Checked, chkSinGoceNuevo.Checked, ddlMaxDiasNuevo.SelectedValue)

        Me.Busqueda()

    End Sub
End Class
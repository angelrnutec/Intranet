Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class ArrendamientoInventario
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If

        If Not Page.IsPostBack Then
            Me.CargaCombos()
        End If

        Me.btnBuscar.Text = TranslateLocale.text(Me.btnBuscar.Text)
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


    Protected Sub btnBuscar_Click(sender As Object, e As EventArgs) Handles btnBuscar.Click

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
            Response.Redirect("/ArrendamientoInventarioExcel.aspx?id_empresa=" & Me.ddlEmpresa.SelectedValue & "&id_categoria=" & Me.ddlCategoriaArrendamiento.SelectedValue)
        End If


    End Sub

End Class
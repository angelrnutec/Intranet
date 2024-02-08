Imports IntranetBL
Imports System.Web.Services
Imports Intranet.LocalizationIntranet

Public Class NecesidadVer
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            If Request.QueryString("id") Is Nothing Then
                Response.Redirect("/ErrorInesperado.aspx?Msg=Consulta invalida")
            End If

            Me.CargaCombos()
            Me.txtIdNecesidad.Text = Request.QueryString("id")
            Me.CargaDatos(Me.txtIdNecesidad.Text)
        End If

        Me.btnEliminar.Text = TranslateLocale.text("Eliminar")
        Me.btnGuardar.Text = TranslateLocale.text("Guardar")
        Me.btnRegresar.Text = TranslateLocale.text("Regresar")

    End Sub

    Private Sub CargaCombos()
        Try
            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            'Me.ddlEmpresa.DataSource = combos.RecuperaEmpresaConceptoGasto(1)
            'Me.ddlEmpresa.DataValueField = "id_empresa"
            'Me.ddlEmpresa.DataTextField = "nombre"
            'Me.ddlEmpresa.DataBind()

            Me.ddlEmpresa.Items.Clear()
            Me.ddlEmpresa.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpresaConceptoGasto(1), "nombre", "id_empresa"))

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub

    Private Sub CargaDatos(id As Integer)
        Try
            Dim necesidad As New Necesidad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = necesidad.RecuperaPorId(id)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                Me.txtClave.Text = dr("clave")
                Me.txtDescripcion.Text = dr("descripcion")
                Me.txtDescripcionEn.Text = dr("descripcion_en")
                Me.ddlEmpresa.SelectedValue = dr("id_empresa")
                Me.ddlTipo.SelectedValue = dr("tipo")

                Me.btnEliminar.Visible = True
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub btnRegresar_Click(sender As Object, e As EventArgs) Handles btnRegresar.Click
        Response.Redirect("NecesidadBusqueda.aspx")
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Me.ValidaCaptura()

            Dim necesidad As New Necesidad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            necesidad.Guarda(Me.txtIdNecesidad.Text, Me.txtClave.Text, Me.txtDescripcion.Text, Me.txtDescripcionEn.Text, Me.ddlEmpresa.SelectedValue, Me.ddlTipo.SelectedValue)


            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Datos guardados con exito');</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub ValidaCaptura()
        Dim msg As String = ""

        If Me.txtClave.Text.Trim = "" Then
            msg += " - Clave\n"
        End If

        If Me.txtDescripcion.Text.Trim = "" Then
            msg += " - Descripción\n"
        End If

        If Me.txtDescripcion.Text.Trim = "" Then
            msg += " - Descripción ingles\n"
        End If

        If Me.ddlEmpresa.SelectedValue = "0" Then
            msg += " - Empresa\n"
        End If

        If Me.ddlTipo.SelectedValue = "" Then
            msg += " - Tipo\n"
        End If

        If msg.Length > 0 Then
            Throw New Exception("Favor de capturar la siguiente información:\n" & msg)
        End If
    End Sub

    Private Sub btnEliminar_Click(sender As Object, e As EventArgs) Handles btnEliminar.Click
        Dim necesidad As New Necesidad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        necesidad.Elimina(Me.txtIdNecesidad.Text)

        Response.Redirect("/NecesidadBusqueda.aspx")
    End Sub
End Class
Imports IntranetBL
Imports System.Web.Services

Public Class CentroCostoVer
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
            Me.txtIdCentroCosto.Text = Request.QueryString("id")
            Me.CargaDatos(Me.txtIdCentroCosto.Text)
        End If
    End Sub

    Private Sub CargaCombos()
        Try
            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.ddlEmpresa.DataSource = combos.RecuperaEmpresaConceptoGasto(1)
            Me.ddlEmpresa.DataValueField = "id_empresa"
            Me.ddlEmpresa.DataTextField = "nombre"
            Me.ddlEmpresa.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub

    Private Sub CargaDatos(id As Integer)
        Try
            Dim centro_costo As New CentroCosto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = centro_costo.RecuperaPorId(id)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                Me.txtClave.Text = dr("clave")
                Me.txtDescripcion.Text = dr("descripcion")
                Me.ddlEmpresa.SelectedValue = dr("id_empresa")

                Me.btnEliminar.Visible = True
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub btnRegresar_Click(sender As Object, e As EventArgs) Handles btnRegresar.Click
        Response.Redirect("CentroCostoBusqueda.aspx")
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Me.ValidaCaptura()

            Dim centro_costo As New CentroCosto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            centro_costo.Guarda(Me.txtIdCentroCosto.Text, Me.ddlEmpresa.SelectedValue, Me.txtClave.Text, Me.txtDescripcion.Text)


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
            msg += " - Descripcion\n"
        End If

        If Me.ddlEmpresa.SelectedValue = "0" Then
            msg += " - Empresa\n"
        End If

        If msg.Length > 0 Then
            Throw New Exception("Favor de capturar la siguiente información:\n" & msg)
        End If
    End Sub

    Private Sub btnEliminar_Click(sender As Object, e As EventArgs) Handles btnEliminar.Click
        Dim centro_costo As New CentroCosto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        centro_costo.Elimina(Me.txtIdCentroCosto.Text)

        Response.Redirect("/CentroCostoBusqueda.aspx")
    End Sub
End Class
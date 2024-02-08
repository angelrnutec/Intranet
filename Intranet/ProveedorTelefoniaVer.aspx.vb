Imports IntranetBL
Imports System.Web.Services

Public Class ProveedorTelefoniaVer
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
            Me.txtIdProveedorTelefonia.Text = Request.QueryString("id")
            Me.CargaDatos(Me.txtIdProveedorTelefonia.Text)
        End If
    End Sub

    Private Sub CargaCombos()
        Try
            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.ddlConcepto.DataSource = combos.RecuperaConceptoPadre(12)
            Me.ddlConcepto.DataValueField = "id_concepto"
            Me.ddlConcepto.DataTextField = "descripcion"
            Me.ddlConcepto.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub

    Private Sub CargaDatos(id As Integer)
        Try
            Dim proveedor_telefonia As New ProveedorTelefonia(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = proveedor_telefonia.RecuperaPorId(id)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                Me.txtDescripcion.Text = dr("nombre")
                Me.ddlTipoCaptura.SelectedValue = dr("tipo_captura")
                Me.ddlConcepto.SelectedValue = dr("id_concepto")
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub btnRegresar_Click(sender As Object, e As EventArgs) Handles btnRegresar.Click
        Response.Redirect("ProveedorTelefoniaBusqueda.aspx")
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Me.ValidaCaptura()

            Dim proveedor_telefonia As New ProveedorTelefonia(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.txtIdProveedorTelefonia.Text = proveedor_telefonia.Guarda(Me.txtIdProveedorTelefonia.Text, Me.txtDescripcion.Text, Me.ddlTipoCaptura.SelectedValue, Me.ddlConcepto.SelectedValue)


            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Datos guardados con exito');window.location='ProveedorTelefoniaBusqueda.aspx';</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub ValidaCaptura()
        Dim msg As String = ""

        If Me.txtDescripcion.Text.Trim = "" Then
            msg += " - Descripcion\n"
        End If

        If Me.ddlTipoCaptura.SelectedValue = "0" Then
            msg += " - Tipo de Captura\n"
        End If

        If Me.ddlConcepto.SelectedValue = "0" Then
            msg += " - Concepto en reporte\n"
        End If

        If msg.Length > 0 Then
            Throw New Exception("Favor de capturar la siguiente información:\n" & msg)
        End If
    End Sub
End Class
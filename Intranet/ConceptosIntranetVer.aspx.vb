Imports IntranetBL
Imports System.Web.Services

Public Class ConceptosIntranetVer
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            If Request.QueryString("id") Is Nothing Then
                Response.Redirect("/ErrorInesperado.aspx?Msg=Consulta invalida")
            End If

            Me.txtIdClasificacionCosto.Text = Request.QueryString("id")
            Me.CargaDatos(Me.txtIdClasificacionCosto.Text)
        End If
    End Sub

    Private Sub CargaDatos(id As Integer)
        Try
            Dim gastos As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = gastos.RecuperaConceptoPorId(id)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                Me.txtDescripcion.Text = dr("descripcion")                
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub btnRegresar_Click(sender As Object, e As EventArgs) Handles btnRegresar.Click
        Response.Redirect("ConceptosIntranetBusqueda.aspx")
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Me.ValidaCaptura()

            Dim gastos As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            gastos.GuardaClasificacion(Me.txtIdClasificacionCosto.Text, Me.txtDescripcion.Text)


            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Datos guardados con exito');</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub ValidaCaptura()
        Dim msg As String = ""

        If Me.txtDescripcion.Text.Trim = "" Then
            msg += " - Descripcion\n"
        End If

        If msg.Length > 0 Then
            Throw New Exception("Favor de capturar la siguiente información:\n" & msg)
        End If
    End Sub

End Class
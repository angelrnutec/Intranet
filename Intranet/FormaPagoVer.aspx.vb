Imports IntranetBL
Imports System.Web.Services
Imports Intranet.LocalizationIntranet

Public Class FormaPagoVer
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            If Request.QueryString("id") Is Nothing Then
                Response.Redirect("/ErrorInesperado.aspx?Msg=Consulta invalida")
            End If

            Me.txtIdFormaPago.Text = Request.QueryString("id")
            Me.CargaDatos(Me.txtIdFormaPago.Text)

            Me.btnGuardar.Text = TranslateLocale.text("Guardar")
            Me.btnRegresar.Text = TranslateLocale.text("Regresar")
            Me.btnEliminar.Text = TranslateLocale.text("Eliminar")
        End If
    End Sub


    Private Sub CargaDatos(id As Integer)
        Try
            Dim forma_pago As New FormaPago(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = forma_pago.RecuperaPorId(id)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                Me.txtDescripcion.Text = dr("descripcion")
                Me.txtDescripcionEn.Text = dr("descripcion_en")
                Me.txtAbreviatura.Text = dr("abreviatura")

                Me.btnEliminar.Visible = True
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub btnRegresar_Click(sender As Object, e As EventArgs) Handles btnRegresar.Click
        Response.Redirect("FormaPagoBusqueda.aspx")
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Me.ValidaCaptura()

            Dim forma_pago As New FormaPago(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            forma_pago.Guarda(Me.txtIdFormaPago.Text, Me.txtDescripcion.Text, Me.txtDescripcionEn.Text, Me.txtAbreviatura.Text)


            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Datos guardados con exito');window.location='FormaPagoBusqueda.aspx';</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub ValidaCaptura()
        Dim msg As String = ""

        If Me.txtDescripcion.Text.Trim = "" Then
            msg += " - Descripcion\n"
        End If
        If Me.txtDescripcionEn.Text.Trim = "" Then
            msg += " - Descripcion Ingles\n"
        End If
        If Me.txtAbreviatura.Text.Trim = "" Then
            msg += " - Abreviatura\n"
        End If

        If msg.Length > 0 Then
            Throw New Exception("Favor de capturar la siguiente información:\n" & msg)
        End If
    End Sub

    Private Sub btnEliminar_Click(sender As Object, e As EventArgs) Handles btnEliminar.Click
        Try
            Dim forma_pago As New FormaPago(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim msg As String = forma_pago.Elimina(Me.txtIdFormaPago.Text)

            If msg.Length > 0 Then
                ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & msg & "');</script>", False)
                Return
            End If

            Response.Redirect("/FormaPagoBusqueda.aspx")

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub
End Class
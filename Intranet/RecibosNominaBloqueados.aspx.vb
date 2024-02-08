Imports IntranetBL

Public Class RecibosNominaBloqueados
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.Busqueda()
        End If

    End Sub

    Private Sub Busqueda()
        Try
            Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.gvResultados.DataSource = seguridad.RecuperaRecibosBloqueados()
            Me.gvResultados.DataBind()

            Me.gvResultados.Visible = True
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub
    Private Sub gvResultados_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvResultados.RowCommand

        If e.CommandName = "desbloquear" Then
            Dim gvRow As GridViewRow = CType(CType(e.CommandSource, Control).NamingContainer, GridViewRow)
            Dim anio As Integer = CType(gvRow.FindControl("lblParamAnio"), Label).Text
            Dim periodo As Integer = CType(gvRow.FindControl("lblParamPeriodo"), Label).Text
            Dim id_empleado As Integer = CType(gvRow.FindControl("lblParamEmpleado"), Label).Text

            Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings.[Get]("CONEXION"))
            seguridad.GuardaNominaFirma(id_empleado, anio, periodo, "DESBLOQUEO")

            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Recibo desloqueado');</script>", False)
            Me.Busqueda()
        End If
    End Sub
End Class
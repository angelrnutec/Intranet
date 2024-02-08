Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class ArrendamientoRechazo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.ProcesaSolicitud()
        End If
    End Sub


    Private Sub ProcesaSolicitud()
        Dim id_arrendamiento As String = Request.QueryString("id")
        Dim motivo As String = Request.QueryString("motivo")

        Try
            Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            arrendamiento.GuardaAutorizacionArrendamiento(id_arrendamiento, False, motivo, Session("idEmpleado"))

            Funciones.EnviarEmailArrendamientoAuth(id_arrendamiento, 0, "Rechazado")

        Catch ex As Exception
        End Try

        Response.Redirect("/ArrendamientoDetalle.aspx?id=" & id_arrendamiento)
    End Sub

End Class
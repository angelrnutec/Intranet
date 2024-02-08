Imports IntranetBL

Public Class ucLigasInteres
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.CargaDatos()
        End If
    End Sub

    Private Sub CargaDatos()
        If Not Session("idEmpleado") Is Nothing Then
            Dim publicacion As New Publicacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.lvLigas.DataSource = publicacion.RecuperaLigasDeInteres(Session("idEmpleado"), Funciones.CurrentLocale)
            Me.lvLigas.DataBind()
        End If
    End Sub
End Class
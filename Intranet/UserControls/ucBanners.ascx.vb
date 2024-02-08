Imports IntranetBL

Public Class ucBanners
    Inherits System.Web.UI.UserControl

    Private _ubicacionBanner As String
    Property UbicacionBanner() As String
        Get
            Return _ubicacionBanner
        End Get
        Set(value As String)
            _ubicacionBanner = value
        End Set
    End Property


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.CargaDatos()
        End If
    End Sub

    Private Sub CargaDatos()
        If Not Session("idEmpleado") Is Nothing Then
            Dim publicacion As New Publicacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.lvLigas.DataSource = publicacion.RecuperaBanners(Session("idEmpleado"), UbicacionBanner, Funciones.CurrentLocale)
            Me.lvLigas.DataBind()
        End If
    End Sub

End Class
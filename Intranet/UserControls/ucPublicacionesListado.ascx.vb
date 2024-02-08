Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class ucPublicacionesListado
    Inherits System.Web.UI.UserControl

    Private _tipoPublicacion As Integer
    Private _categoria As String = ""
    Property TipoPublicacion() As Integer
        Get
            Return _tipoPublicacion
        End Get
        Set(value As Integer)
            _tipoPublicacion = value
        End Set
    End Property
    Property Categoria() As String
        Get
            If _categoria = "" Then
                _categoria = "0"
            End If
            Return _categoria
        End Get
        Set(value As String)
            _categoria = value
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
            If TipoPublicacion = 7 Then
                Me.lvPublicacionesAviso.DataSource = publicacion.RecuperaPublicaciones(Session("idEmpleado"), TipoPublicacion, Categoria, Funciones.CurrentLocale)
                Me.lvPublicacionesAviso.DataBind()
            Else
                Me.lvPublicaciones.DataSource = publicacion.RecuperaPublicaciones(Session("idEmpleado"), TipoPublicacion, Categoria, Funciones.CurrentLocale)
                Me.lvPublicaciones.DataBind()
            End If
        End If
    End Sub

    Protected Function RecuperaIcono() As String
        If TipoPublicacion = 1 Then
            Return "icon-bullhorn"
        ElseIf TipoPublicacion = 2 Then
            Return "icon-calendar"
        ElseIf TipoPublicacion = 3 Then
            Return "icon-book"
        ElseIf TipoPublicacion = 6 Then
            Return "icon-briefcase"
        ElseIf TipoPublicacion = 7 Then
            Return "icon-paper-clip"
        End If
        Return ""
    End Function

    Protected Function RecuperaTitulo() As String
        If TipoPublicacion = 1 Then
            Return TranslateLocale.text("Noticias y Avisos")
        ElseIf TipoPublicacion = 2 Then
            Return TranslateLocale.text("Eventos")
        ElseIf TipoPublicacion = 3 Then
            Return TranslateLocale.text("Biblioteca")
        ElseIf TipoPublicacion = 6 Then
            Return TranslateLocale.text("Vacantes Internas Vigentes")
        ElseIf TipoPublicacion = 7 Then
            Me.divPublicacionNormal.Visible = False
            Me.divPublicacionAviso.Visible = True
            Me.divPublicacionCategoria.Visible = True
            Me.divCategoriasLinks.InnerHtml = MenuAvisos()
            Return TranslateLocale.text("Avisos de Ocasión")
        End If
        Return ""
    End Function

    Private Sub lvDataPager1_PreRender(sender As Object, e As EventArgs) Handles lvDataPager1.PreRender
        Dim publicacion As New Publicacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        If TipoPublicacion = 7 Then
            Me.lvPublicacionesAviso.DataSource = publicacion.RecuperaPublicaciones(Session("idEmpleado"), TipoPublicacion, Categoria, Funciones.CurrentLocale)
            Me.lvPublicacionesAviso.DataBind()
        Else
            Me.lvPublicaciones.DataSource = publicacion.RecuperaPublicaciones(Session("idEmpleado"), TipoPublicacion, Categoria, Funciones.CurrentLocale)
            Me.lvPublicaciones.DataBind()
        End If

    End Sub

    Private Function MenuAvisos() As String
        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dt As DataTable = combos.RecuperCategoriaAviso(" TODOS")
        Dim strMenu As New StringBuilder("")
        strMenu.AppendLine("<ul class='nav'>")
        For Each dr As DataRow In dt.Rows
            strMenu.AppendLine("<li " & IIf(_categoria = dr("id_categoria"), "class='active", "") & "'><a href='/Publicaciones.aspx?t=Avisos&c=" & dr("id_categoria") & "'>" & dr(TranslateLocale.text("descripcion")) & "</a></li>")
        Next
        strMenu.AppendLine("</ul>")

        Return strMenu.ToString()
    End Function

    Private Sub lvDataPagerAviso_PreRender(sender As Object, e As EventArgs) Handles lvDataPagerAviso.PreRender
        Dim publicacion As New Publicacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.lvPublicacionesAviso.DataSource = publicacion.RecuperaPublicaciones(Session("idEmpleado"), TipoPublicacion, Categoria, Funciones.CurrentLocale)
        Me.lvPublicacionesAviso.DataBind()
    End Sub
End Class

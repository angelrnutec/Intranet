Imports Intranet.LocalizationIntranet
Imports IntranetBL

Public Class DefaultMP_Wide
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.txtBusqueda.Text = TranslateLocale.text("¿Buscas algo o alguien?")
        End If

    End Sub


    Protected Function FechaHoyTexto() As String
        Dim fecha As String = ""
        fecha &= DiaSemana(Now.DayOfWeek) & ", "
        fecha &= Now.Day & " / "
        fecha &= NombreMes(Now.Month) & " / "
        fecha &= Now.Year

        Return fecha
    End Function

    Private Function DiaSemana(dia As DayOfWeek) As String
        If dia = DayOfWeek.Monday Then
            Return TranslateLocale.text("Lunes")
        ElseIf dia = DayOfWeek.Tuesday Then
            Return TranslateLocale.text("Martes")
        ElseIf dia = DayOfWeek.Wednesday Then
            Return TranslateLocale.text("Miercoles")
        ElseIf dia = DayOfWeek.Thursday Then
            Return TranslateLocale.text("Jueves")
        ElseIf dia = DayOfWeek.Friday Then
            Return TranslateLocale.text("Viernes")
        ElseIf dia = DayOfWeek.Saturday Then
            Return TranslateLocale.text("Sabado")
        ElseIf dia = DayOfWeek.Sunday Then
            Return TranslateLocale.text("Domingo")
        End If

        Return ""
    End Function

    Private Function NombreMes(mes As Integer) As String
        If mes = 1 Then
            Return TranslateLocale.text("Enero")
        ElseIf mes = 2 Then
            Return TranslateLocale.text("Febrero")
        ElseIf mes = 3 Then
            Return TranslateLocale.text("Marzo")
        ElseIf mes = 4 Then
            Return TranslateLocale.text("Abril")
        ElseIf mes = 5 Then
            Return TranslateLocale.text("Mayo")
        ElseIf mes = 6 Then
            Return TranslateLocale.text("Junio")
        ElseIf mes = 7 Then
            Return TranslateLocale.text("Julio")
        ElseIf mes = 8 Then
            Return TranslateLocale.text("Agosto")
        ElseIf mes = 9 Then
            Return TranslateLocale.text("Septiembre")
        ElseIf mes = 10 Then
            Return TranslateLocale.text("Octubre")
        ElseIf mes = 11 Then
            Return TranslateLocale.text("Noviembre")
        ElseIf mes = 12 Then
            Return TranslateLocale.text("Diciembre")
        End If

        Return ""
    End Function

    Private Sub btnBusqueda_Click(sender As Object, e As ImageClickEventArgs) Handles btnBusqueda.Click
        Dim texto As String = Me.txtBusqueda.Text
        If texto.Length > 0 And texto <> TranslateLocale.text("¿Buscas algo o alguien?") Then
            Response.Redirect("Buscar.aspx?b=" & texto)
        Else
            Me.txtBusqueda.Text = TranslateLocale.text("¿Buscas algo o alguien?")
        End If
    End Sub

    Public Function GetUrlMesaAyuda() As String
        'Dim ruta As String = System.Configuration.ConfigurationManager.AppSettings("LINK_MESA_AYUDA")
        Dim ruta As String = "http://201.158.240.118:8097/Intranet"
        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        ruta = ruta & "?u=" & seguridad.RecuperaUsuarioEncriptado(Session("idEmpleado")) & "&locale=" & Funciones.CurrentLocale

        Return ruta
    End Function


    Public Function GetUrlMesaAyudaMtto() As String
        Dim ruta As String = "http://201.158.240.118:8096/Intranet"
        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        ruta = ruta & "?u=" & seguridad.RecuperaUsuarioEncriptado(Session("idEmpleado")) & "&locale=" & Funciones.CurrentLocale

        Return ruta
    End Function

    Public Function GetUrlMesaAyudaRD() As String
        Dim ruta As String = "http://201.158.240.118:8599/Intranet"
        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        ruta = ruta & "?u=" & seguridad.RecuperaUsuarioEncriptado(Session("idEmpleado")) & "&locale=" & Funciones.CurrentLocale

        Return ruta
    End Function

End Class
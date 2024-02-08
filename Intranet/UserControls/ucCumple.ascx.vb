Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class ucCumple
    Inherits System.Web.UI.UserControl

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.CargaDatos()
        End If
    End Sub

    Private Sub CargaDatos()
        If Not Session("idEmpleado") Is Nothing Then
            Dim cumples As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = cumples.RecuperaCumplesDelMes()
            If dt.Rows.Count > 0 Then
                Me.lvCumples.DataSource = dt
                Me.lvCumples.DataBind()
                divCumples.Visible = True
            Else
                divCumples.Visible = False
            End If
        End If
    End Sub

    Protected Function FechaCumple(fecha As DateTime) As String
        Dim resultado As String = ""
        fecha = fecha.AddYears(DateTime.Now.Year - fecha.Year)

        'Dim nuevaFecha As New Date(Now.Year, fecha.Month, fecha.Day)
        'resultado = NombreDia(nuevaFecha.DayOfWeek) & ", " & fecha.Day & " de " & NombreMes(fecha.Month)
        resultado = NombreDia(fecha.DayOfWeek) & ", " & fecha.Day & " de " & NombreMes(fecha.Month)

        Return resultado
    End Function

    Private Function NombreMes(mes As Integer) As String
        Dim resultado As String = ""
        Select Case mes
            Case 1
                resultado = "Enero"
            Case 2
                resultado = "Febrero"
            Case 3
                resultado = "Marzo"
            Case 4
                resultado = "Abril"
            Case 5
                resultado = "Mayo"
            Case 6
                resultado = "Junio"
            Case 7
                resultado = "Julio"
            Case 8
                resultado = "Agosto"
            Case 9
                resultado = "Septiembre"
            Case 10
                resultado = "Octubre"
            Case 11
                resultado = "Noviembre"
            Case 12
                resultado = "Diciembre"
        End Select

        Return TranslateLocale.text(resultado)
    End Function
    Private Function NombreDia(dia As Integer) As String
        Dim resultado As String = ""
        Select Case dia
            Case 1
                resultado = "Lunes"
            Case 2
                resultado = "Martes"
            Case 3
                resultado = "Miércoles"
            Case 4
                resultado = "Jueves"
            Case 5
                resultado = "Viernes"
            Case 6
                resultado = "Sábado"
            Case 0
                resultado = "Domingo"
        End Select

        Return TranslateLocale.text(resultado)
    End Function

End Class
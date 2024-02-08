Imports IntranetBL

Public Class RepGastosNSEjecutivoImpresion
    Inherits System.Web.UI.Page

    Protected dtPlanDistribucion As DataTable
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Me.CargaTituloReporte()
        End If
    End Sub

    Private Sub CargaTituloReporte()
        Me.lblTituloReporte.Text = "Reporte Ejecutivo Gastos NS (" & NombrePeriodo(Request.QueryString("m")) & " / " & Request.QueryString("a") & ", Moneda: " & Request.QueryString("mon") & ")"
    End Sub

    Protected Function RecuperaDatosReporte() As DataSet
        Dim anio As String = Request.QueryString("a")
        Dim mes As String = Request.QueryString("m")
        Dim moneda As String = Request.QueryString("mon")

        If Not anio Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Return reporte.RecuperaReporteEjecutivoGastosNS(anio, moneda, mes)
        End If
        Return Nothing
    End Function


    Protected Function NombrePeriodo(periodo As Integer) As String
        Dim nombre As String = ""

        If periodo = 1 Then
            nombre = "Enero"
        ElseIf periodo = 2 Then
            nombre = "Febrero"
        ElseIf periodo = 3 Then
            nombre = "Marzo"
        ElseIf periodo = 4 Then
            nombre = "Abril"
        ElseIf periodo = 5 Then
            nombre = "Mayo"
        ElseIf periodo = 6 Then
            nombre = "Junio"
        ElseIf periodo = 7 Then
            nombre = "Julio"
        ElseIf periodo = 8 Then
            nombre = "Agosto"
        ElseIf periodo = 9 Then
            nombre = "Septiembre"
        ElseIf periodo = 10 Then
            nombre = "Octubre"
        ElseIf periodo = 11 Then
            nombre = "Noviembre"
        ElseIf periodo = 12 Then
            nombre = "Diciembre"
        ElseIf periodo = 13 Then
            nombre = "Enero"
        ElseIf periodo = 0 Then
            nombre = "Diciembre"
        ElseIf periodo = -1 Then
            nombre = "Noviembre"
        ElseIf periodo = -2 Then
            nombre = "Octubre"
        ElseIf periodo = -3 Then
            nombre = "Septiembre"
        ElseIf periodo = -4 Then
            nombre = "Agosto"
        ElseIf periodo = -5 Then
            nombre = "Julio"
        ElseIf periodo = -6 Then
            nombre = "Junio"
        ElseIf periodo = -7 Then
            nombre = "Mayo"
        ElseIf periodo = -8 Then
            nombre = "Abril"
        ElseIf periodo = -9 Then
            nombre = "Marzo"
        ElseIf periodo = -10 Then
            nombre = "Febrero"
        ElseIf periodo = -11 Then
            nombre = "Enero"
        End If

        Return Left(nombre, 3).ToUpper()
    End Function


End Class
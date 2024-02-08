Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class RepFinancierosImpresion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Dim reporte As String = Request.QueryString("r")
            Dim empresa As String = Request.QueryString("e")
            Dim anio As String = Request.QueryString("a")

            If Not reporte Is Nothing And
                Not empresa Is Nothing And
                Not anio Is Nothing Then

                Me.CargaTituloReporte(reporte, empresa, anio)
            End If
        End If
    End Sub

    Private Sub CargaTituloReporte(id_reporte As Integer, id_empresa As Integer, anio As Integer)
        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Me.lblTituloReporte.Text = TranslateLocale.text(reporte.RecuperaReporteNombre(id_reporte))
    End Sub

    Protected Function NombreEmpresa()
        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Return reporte.RecuperaEmpresaNombre(Request.QueryString("e"))
    End Function

    Protected Function RecuperaDatosReporte() As DataSet
        Dim id_reporte As String = Request.QueryString("r")
        Dim id_empresa As String = Request.QueryString("e")
        Dim anio As String = Request.QueryString("a")

        If Not id_reporte Is Nothing And
            Not id_empresa Is Nothing And
            Not anio Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Return reporte.RecuperaReporte(id_reporte, id_empresa, anio)
        End If
        Return Nothing
    End Function


    Protected Function RecuperaDatosExtraBalanceReporte() As DataTable
        Dim id_reporte As String = Request.QueryString("r")
        Dim id_empresa As String = Request.QueryString("e")
        Dim anio As String = Request.QueryString("a")

        If Not id_reporte Is Nothing And
            Not id_empresa Is Nothing And
            Not anio Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Return reporte.RecuperaReporteDatosExtraBalanceGeneral(id_empresa, anio).Tables(1)
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
        End If

        Return nombre
    End Function

End Class
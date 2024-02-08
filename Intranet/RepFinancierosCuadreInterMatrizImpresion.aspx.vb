Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class RepFinancierosCuadreInterMatrizImpresion
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
                Me.CargaDatosReporte()
            End If
        End If
    End Sub

    Private Sub CargaTituloReporte(id_reporte As Integer, id_empresa As Integer, anio As Integer)
        'Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        'Me.lblTituloReporte.Text = reporte.RecuperaReporteNombre(id_reporte)
    End Sub

    Protected Function NombreEmpresa()
        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Return reporte.RecuperaEmpresaNombre(Request.QueryString("e"))
    End Function



    Protected Sub CargaDatosReporte()
        Dim id_reporte As String = Request.QueryString("r")
        Dim id_empresa As String = Request.QueryString("e")
        Dim anio As String = Request.QueryString("a")
        Dim periodo As String = Request.QueryString("m")

        If Not id_reporte Is Nothing And
            Not id_empresa Is Nothing And
            Not anio Is Nothing And
            Not periodo Is Nothing Then


            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Dim dsOperativa As DataSet = reporte.RecuperaReporteCuadreInterMatriz(id_reporte, id_empresa, anio, periodo, "operativa")
            Me.gvSumarizadoOperativas.DataSource = dsOperativa.Tables(0)
            Me.gvSumarizadoOperativas.DataBind()

            Dim dsFiscal As DataSet = reporte.RecuperaReporteCuadreInterMatriz(id_reporte, id_empresa, anio, periodo, "fiscal")
            Me.gvSumarizadoFiscales.DataSource = dsFiscal.Tables(0)
            Me.gvSumarizadoFiscales.DataBind()


        End If

    End Sub

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

        Return TranslateLocale.text(nombre)
    End Function

    Private Sub gvSumarizadoFiscales_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvSumarizadoFiscales.RowDataBound
        e.Row.Cells(0).Text = TranslateLocale.text(e.Row.Cells(0).Text)

        Dim valor0 As String = e.Row.Cells(0).Text
        Dim valor1 As String = e.Row.Cells(1).Text
        Dim valor2 As String = e.Row.Cells(2).Text
        Dim valor3 As String = e.Row.Cells(3).Text
        Dim valor4 As String = e.Row.Cells(4).Text
        Dim valor5 As String = e.Row.Cells(5).Text
        Dim valor6 As String = e.Row.Cells(6).Text
        Dim valor7 As String = e.Row.Cells(7).Text
        Dim valor8 As String = e.Row.Cells(8).Text
        Dim valor9 As String = e.Row.Cells(9).Text
        Dim valor10 As String = e.Row.Cells(10).Text


        If valor0 = TranslateLocale.text("TOTALES") Then
            e.Row.BackColor = Drawing.Color.LightGray
        End If
        If valor0 = TranslateLocale.text("POR COBRAR") Then
            e.Row.Font.Bold = True
            e.Row.BackColor = Drawing.Color.LightGray
            e.Row.Cells(11).Text = "&nbsp;"
        End If
        If valor0 = TranslateLocale.text("POR PAGAR") Then
            e.Row.Font.Bold = True
            e.Row.BackColor = Drawing.Color.LightGray
            e.Row.Cells(11).Text = "&nbsp;"
        End If
        If valor0 = TranslateLocale.text("VARIACIONES") Then
            e.Row.Font.Bold = True
            e.Row.BackColor = Drawing.Color.LightGray
            e.Row.Cells(11).Text = "&nbsp;"
        End If

        If valor1 = "&nbsp;" Then e.Row.Cells(1).BackColor = Drawing.Color.LightGray
        If valor2 = "&nbsp;" Then e.Row.Cells(2).BackColor = Drawing.Color.LightGray
        If valor3 = "&nbsp;" Then e.Row.Cells(3).BackColor = Drawing.Color.LightGray
        If valor4 = "&nbsp;" Then e.Row.Cells(4).BackColor = Drawing.Color.LightGray
        If valor5 = "&nbsp;" Then e.Row.Cells(5).BackColor = Drawing.Color.LightGray
        If valor6 = "&nbsp;" Then e.Row.Cells(6).BackColor = Drawing.Color.LightGray
        If valor7 = "&nbsp;" Then e.Row.Cells(7).BackColor = Drawing.Color.LightGray
        If valor8 = "&nbsp;" Then e.Row.Cells(8).BackColor = Drawing.Color.LightGray
        If valor9 = "&nbsp;" Then e.Row.Cells(9).BackColor = Drawing.Color.LightGray
        If valor10 = "&nbsp;" Then e.Row.Cells(10).BackColor = Drawing.Color.LightGray

        If valor1 = "0" Then e.Row.Cells(1).Text = "&nbsp;"
        If valor2 = "0" Then e.Row.Cells(2).Text = "&nbsp;"
        If valor3 = "0" Then e.Row.Cells(3).Text = "&nbsp;"
        If valor4 = "0" Then e.Row.Cells(4).Text = "&nbsp;"
        If valor5 = "0" Then e.Row.Cells(5).Text = "&nbsp;"
        If valor6 = "0" Then e.Row.Cells(6).Text = "&nbsp;"
        If valor7 = "0" Then e.Row.Cells(7).Text = "&nbsp;"
        If valor8 = "0" Then e.Row.Cells(8).Text = "&nbsp;"
        If valor9 = "0" Then e.Row.Cells(9).Text = "&nbsp;"
        If valor10 = "0" Then e.Row.Cells(10).Text = "&nbsp;"
    End Sub

    Private Sub gvSumarizadoOperativas_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvSumarizadoOperativas.RowDataBound
        e.Row.Cells(0).Text = TranslateLocale.text(e.Row.Cells(0).Text)

        Dim valor0 As String = e.Row.Cells(0).Text
        Dim valor1 As String = e.Row.Cells(1).Text
        Dim valor2 As String = e.Row.Cells(2).Text
        Dim valor3 As String = e.Row.Cells(3).Text
        Dim valor4 As String = e.Row.Cells(4).Text
        Dim valor5 As String = e.Row.Cells(5).Text
        Dim valor6 As String = e.Row.Cells(6).Text
        Dim valor7 As String = e.Row.Cells(7).Text
        Dim valor8 As String = e.Row.Cells(8).Text
        Dim valor9 As String = e.Row.Cells(9).Text
        Dim valor10 As String = e.Row.Cells(10).Text


        If valor0 = TranslateLocale.text("TOTALES") Then
            e.Row.BackColor = Drawing.Color.LightGray
        End If
        If valor0 = TranslateLocale.text("POR COBRAR") Then
            e.Row.Font.Bold = True
            e.Row.BackColor = Drawing.Color.LightGray
            e.Row.Cells(11).Text = "&nbsp;"
        End If
        If valor0 = TranslateLocale.text("POR PAGAR") Then
            e.Row.Font.Bold = True
            e.Row.BackColor = Drawing.Color.LightGray
            e.Row.Cells(11).Text = "&nbsp;"
        End If
        If valor0 = TranslateLocale.text("VARIACIONES") Then
            e.Row.Font.Bold = True
            e.Row.BackColor = Drawing.Color.LightGray
            e.Row.Cells(11).Text = "&nbsp;"
        End If

        If valor1 = "&nbsp;" Then e.Row.Cells(1).BackColor = Drawing.Color.LightGray
        If valor2 = "&nbsp;" Then e.Row.Cells(2).BackColor = Drawing.Color.LightGray
        If valor3 = "&nbsp;" Then e.Row.Cells(3).BackColor = Drawing.Color.LightGray
        If valor4 = "&nbsp;" Then e.Row.Cells(4).BackColor = Drawing.Color.LightGray
        If valor5 = "&nbsp;" Then e.Row.Cells(5).BackColor = Drawing.Color.LightGray
        If valor6 = "&nbsp;" Then e.Row.Cells(6).BackColor = Drawing.Color.LightGray
        If valor7 = "&nbsp;" Then e.Row.Cells(7).BackColor = Drawing.Color.LightGray
        If valor8 = "&nbsp;" Then e.Row.Cells(8).BackColor = Drawing.Color.LightGray
        If valor9 = "&nbsp;" Then e.Row.Cells(9).BackColor = Drawing.Color.LightGray
        If valor10 = "&nbsp;" Then e.Row.Cells(10).BackColor = Drawing.Color.LightGray

        If valor1 = "0" Then e.Row.Cells(1).Text = "&nbsp;"
        If valor2 = "0" Then e.Row.Cells(2).Text = "&nbsp;"
        If valor3 = "0" Then e.Row.Cells(3).Text = "&nbsp;"
        If valor4 = "0" Then e.Row.Cells(4).Text = "&nbsp;"
        If valor5 = "0" Then e.Row.Cells(5).Text = "&nbsp;"
        If valor6 = "0" Then e.Row.Cells(6).Text = "&nbsp;"
        If valor7 = "0" Then e.Row.Cells(7).Text = "&nbsp;"
        If valor8 = "0" Then e.Row.Cells(8).Text = "&nbsp;"
        If valor9 = "0" Then e.Row.Cells(9).Text = "&nbsp;"
        If valor10 = "0" Then e.Row.Cells(10).Text = "&nbsp;"
    End Sub
End Class
Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class RepFinancierosCuadreInterImpresionV2
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

            Me.lblTituloInterRef.Text = TranslateLocale.text("Comparativo de lo reportado por las otras empresas")
            Me.ExportToExcel1.Text = TranslateLocale.text("Exportar a Excel")
            Me.ExportToExcel2.Text = TranslateLocale.text("Exportar a Excel")
            Me.ExportToExcel3.Text = TranslateLocale.text("Exportar a Excel")
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

    Private Sub CargaDatosReporte()
        Dim id_reporte As String = Request.QueryString("r")
        Dim id_empresa As String = Request.QueryString("e")
        Dim anio As String = Request.QueryString("a")
        Dim periodo As String = Request.QueryString("m")

        If Not id_reporte Is Nothing And
            Not id_empresa Is Nothing And
            Not anio Is Nothing And
            Not periodo Is Nothing Then


            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim ds As DataSet = reporte.RecuperaReporteCuadreInter(id_reporte, id_empresa, anio, periodo)

            If id_empresa > 0 Then
                Me.divReporteNormal.Visible = True
                Me.divReporteSum.Visible = False

                Funciones.TranslateTableData(ds.Tables(0), {"descripcion"})
                Funciones.TranslateTableData(ds.Tables(1), {"empresa"})

                Me.gvCapturaCuadreInter.DataSource = ds.Tables(0)
                Funciones.TranslateGridviewHeader(Me.gvCapturaCuadreInter)
                Me.gvCapturaCuadreInter.DataBind()

                Me.gvCapturaCuadreInterRef.DataSource = ds.Tables(1)
                Funciones.TranslateGridviewHeader(Me.gvCapturaCuadreInterRef)
                Me.gvCapturaCuadreInterRef.DataBind()
            Else
                Me.divReporteNormal.Visible = False
                Me.divReporteSum.Visible = True

                Funciones.TranslateTableData(ds.Tables(0), {"descripcion"})

                Me.gvSumarizado.DataSource = ds.Tables(0)
                Funciones.TranslateGridviewHeader(Me.gvSumarizado)
                Me.gvSumarizado.DataBind()
            End If


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

    Private Sub gvSumarizado_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvSumarizado.RowDataBound

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


        If valor0 = TranslateLocale.text("TOTALES") Then
            e.Row.BackColor = Drawing.Color.LightGray
        End If
        If valor0 = TranslateLocale.text("POR COBRAR") Then
            e.Row.Font.Bold = True
            e.Row.BackColor = Drawing.Color.LightGray
            e.Row.Cells(10).Text = "&nbsp;"
        End If
        If valor0 = TranslateLocale.text("POR PAGAR") Then
            e.Row.Font.Bold = True
            e.Row.BackColor = Drawing.Color.LightGray
            e.Row.Cells(10).Text = "&nbsp;"
        End If
        If valor0 = TranslateLocale.text("VARIACIONES") Then
            e.Row.Font.Bold = True
            e.Row.BackColor = Drawing.Color.LightGray
            e.Row.Cells(10).Text = "&nbsp;"
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

        If valor1 = "0" Then e.Row.Cells(1).Text = "&nbsp;"
        If valor2 = "0" Then e.Row.Cells(2).Text = "&nbsp;"
        If valor3 = "0" Then e.Row.Cells(3).Text = "&nbsp;"
        If valor4 = "0" Then e.Row.Cells(4).Text = "&nbsp;"
        If valor5 = "0" Then e.Row.Cells(5).Text = "&nbsp;"
        If valor6 = "0" Then e.Row.Cells(6).Text = "&nbsp;"
        If valor7 = "0" Then e.Row.Cells(7).Text = "&nbsp;"
        If valor8 = "0" Then e.Row.Cells(8).Text = "&nbsp;"
        If valor9 = "0" Then e.Row.Cells(9).Text = "&nbsp;"

    End Sub

    Private Sub gvCapturaCuadreInter_DataBound(sender As Object, e As EventArgs) Handles gvCapturaCuadreInter.DataBound
        Dim row As New GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal)
        Dim cell As New TableHeaderCell()
        cell.Text = ""
        cell.ColumnSpan = 1
        row.Controls.Add(cell)

        cell = New TableHeaderCell()
        cell.Text = "Operativas"
        cell.ColumnSpan = 2
        row.Controls.Add(cell)

        cell = New TableHeaderCell()
        cell.ColumnSpan = 2
        cell.Text = "Fiscales"
        row.Controls.Add(cell)

        'row.BackColor = ColorTranslator.FromHtml("#92e3d1")
        gvCapturaCuadreInter.HeaderRow.Parent.Controls.AddAt(0, row)
    End Sub

    Private Sub gvCapturaCuadreInterRef_DataBound(sender As Object, e As EventArgs) Handles gvCapturaCuadreInterRef.DataBound
        Dim row As New GridViewRow(0, 0, DataControlRowType.Header, DataControlRowState.Normal)
        Dim cell As New TableHeaderCell()
        cell.Text = ""
        cell.ColumnSpan = 1
        row.Controls.Add(cell)

        cell = New TableHeaderCell()
        cell.Text = "Operativas"
        cell.ColumnSpan = 6
        row.Controls.Add(cell)

        cell = New TableHeaderCell()
        cell.ColumnSpan = 5
        cell.Text = "Fiscales"
        row.Controls.Add(cell)

        'row.BackColor = ColorTranslator.FromHtml("#92e3d1")
        gvCapturaCuadreInterRef.HeaderRow.Parent.Controls.AddAt(0, row)
    End Sub
End Class
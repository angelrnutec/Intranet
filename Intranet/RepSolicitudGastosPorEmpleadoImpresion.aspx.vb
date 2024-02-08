Imports IntranetBL
Imports KrishLabs.Web.Controls
Imports Intranet.LocalizationIntranet

Public Class RepSolicitudGastosPorEmpleadoImpresion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim id_empresa As String = Request.QueryString("e")
            Dim id_empleado As String = Request.QueryString("em")
            Dim anio As String = Request.QueryString("a")

            If Not id_empresa Is Nothing Then

                Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Dim ds As DataSet = reporte.ReporteGastosPorEmpleado(id_empresa, id_empleado, anio)

                Me.gvReporte.DataSource = ds.Tables(0)
                Funciones.TranslateGridviewHeader(Me.gvReporte)
                Me.gvReporte.DataBind()

                Me.gvReporteOI.DataSource = ds.Tables(1)
                Funciones.TranslateGridviewHeader(Me.gvReporteOI)
                Me.gvReporteOI.DataBind()

                Me.gvReporteTot.DataSource = ds.Tables(2)
                Funciones.TranslateGridviewHeader(Me.gvReporteTot)
                Me.gvReporteTot.DataBind()

                If ds.Tables(0).Rows.Count = 0 Then
                    Me.gvReporte.Visible = False
                    Me.lblReporteCC.Visible = False
                    Me.gvReporteTot.Visible = False
                End If
                If ds.Tables(1).Rows.Count = 0 Then
                    Me.gvReporteOI.Visible = False
                    Me.lblReporteOI.Visible = False
                    Me.gvReporteTot.Visible = False
                End If

            End If

            Me.ExportToExcel1.Text = TranslateLocale.text("Exportar CC")
            Me.btnImprimir.Text = TranslateLocale.text("Imprimir sin Formato")
            Me.ExportToExcel2.Text = TranslateLocale.text("Exportar OI")

            Me.lblReporteCC.Text = TranslateLocale.text("Por Centros de Costo")
            Me.lblReporteOI.Text = TranslateLocale.text("Por Orden Interna")

        End If
    End Sub


    Public Property GridViewSortDirection() As SortDirection
        Get
            If ViewState("sortDirection") Is Nothing Then
                ViewState("sortDirection") = SortDirection.Ascending
            End If

            Return DirectCast(ViewState("sortDirection"), SortDirection)
        End Get
        Set(value As SortDirection)
            ViewState("sortDirection") = value
        End Set
    End Property

    Public Property GridViewSortDirectionOI() As SortDirection
        Get
            If ViewState("sortDirectionOI") Is Nothing Then
                ViewState("sortDirectionOI") = SortDirection.Ascending
            End If

            Return DirectCast(ViewState("sortDirectionOI"), SortDirection)
        End Get
        Set(value As SortDirection)
            ViewState("sortDirectionOI") = value
        End Set
    End Property

    Dim monto1 As Decimal
    Dim monto2 As Decimal
    Dim monto3 As Decimal
    Dim monto4 As Decimal
    Dim monto5 As Decimal
    Dim monto6 As Decimal
    Dim monto7 As Decimal
    Dim monto8 As Decimal
    Dim monto9 As Decimal
    Dim monto10 As Decimal
    Dim monto11 As Decimal
    Dim monto12 As Decimal
    Dim monto_tot As Decimal

    Dim monto1_oi As Decimal
    Dim monto2_oi As Decimal
    Dim monto3_oi As Decimal
    Dim monto4_oi As Decimal
    Dim monto5_oi As Decimal
    Dim monto6_oi As Decimal
    Dim monto7_oi As Decimal
    Dim monto8_oi As Decimal
    Dim monto9_oi As Decimal
    Dim monto10_oi As Decimal
    Dim monto11_oi As Decimal
    Dim monto12_oi As Decimal
    Dim monto_tot_oi As Decimal


    Private Sub gvReporte_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvReporte.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            monto1 += e.Row.Cells(2).Text
            monto2 += e.Row.Cells(3).Text
            monto3 += e.Row.Cells(4).Text
            monto4 += e.Row.Cells(5).Text
            monto5 += e.Row.Cells(6).Text
            monto6 += e.Row.Cells(7).Text
            monto7 += e.Row.Cells(8).Text
            monto8 += e.Row.Cells(9).Text
            monto9 += e.Row.Cells(10).Text
            monto10 += e.Row.Cells(11).Text
            monto11 += e.Row.Cells(12).Text
            monto12 += e.Row.Cells(13).Text
            monto_tot += e.Row.Cells(14).Text

        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(2).Text = Format(monto1, "#,###,##0")
            e.Row.Cells(3).Text = Format(monto2, "#,###,##0")
            e.Row.Cells(4).Text = Format(monto3, "#,###,##0")
            e.Row.Cells(5).Text = Format(monto4, "#,###,##0")
            e.Row.Cells(6).Text = Format(monto5, "#,###,##0")
            e.Row.Cells(7).Text = Format(monto6, "#,###,##0")
            e.Row.Cells(8).Text = Format(monto7, "#,###,##0")
            e.Row.Cells(9).Text = Format(monto8, "#,###,##0")
            e.Row.Cells(10).Text = Format(monto9, "#,###,##0")
            e.Row.Cells(11).Text = Format(monto10, "#,###,##0")
            e.Row.Cells(12).Text = Format(monto11, "#,###,##0")
            e.Row.Cells(13).Text = Format(monto12, "#,###,##0")
            e.Row.Cells(14).Text = Format(monto_tot, "#,###,##0")
        End If
    End Sub
    Protected Sub gvReporte_Sorting(sender As Object, e As GridViewSortEventArgs) Handles gvReporte.Sorting
        Dim sortExpression As String = e.SortExpression

        If GridViewSortDirection = SortDirection.Ascending Then
            GridViewSortDirection = SortDirection.Descending
            SortGridView(sortExpression, " ASC")
        Else
            GridViewSortDirection = SortDirection.Ascending
            SortGridView(sortExpression, " DESC")
        End If

    End Sub

    Private Sub SortGridView(sortExpression As String, direction As String)
        Try
            '  You can cache the DataTable for improving performance
            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Dim id_empresa As String = Request.QueryString("e")
            Dim id_empleado As String = Request.QueryString("em")
            Dim anio As String = Request.QueryString("a")



            Dim ds As DataSet = reporte.ReporteGastosPorEmpleado(id_empresa, id_empleado, anio)

            Dim dv As New DataView(ds.Tables(0))
            dv.Sort = sortExpression & direction

            gvReporte.DataSource = dv
            gvReporte.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    Private Sub SortGridViewOI(sortExpression As String, direction As String)
        Try
            '  You can cache the DataTable for improving performance
            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Dim id_empresa As String = Request.QueryString("e")
            Dim id_empleado As String = Request.QueryString("em")
            Dim anio As String = Request.QueryString("a")



            Dim ds As DataSet = reporte.ReporteGastosPorEmpleado(id_empresa, id_empleado, anio)

            Dim dv As New DataView(ds.Tables(1))
            dv.Sort = sortExpression & direction

            gvReporteOI.DataSource = dv
            gvReporteOI.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Protected Function ifNullEmptyFecha(valor As Object) As String
        If IsDBNull(valor) Then
            Return ""
        Else
            Return "<br />(" & Format(CType(valor, Date), "dd/MM/yyyy HH:mm") & ")"
        End If
    End Function

    Protected Function DefinicionParametros() As String
        Dim id_empresa As String = Request.QueryString("e")
        Dim id_empleado As String = Request.QueryString("em")
        Dim anio As String = Request.QueryString("a")

        Dim parametros As String = ""
        If Not id_empresa Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            parametros += TranslateLocale.text("Empleado") & ": " & IIf(id_empleado = "0", TranslateLocale.text("Todas"), reporte.RecuperaEmpleadoNombre(id_empleado))
            parametros += ", " & TranslateLocale.text("Año") & ": " & anio
            parametros += ", " & TranslateLocale.text("Moneda: MXP")

        End If
        Return parametros
    End Function

    Private Sub gvReporteOI_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvReporteOI.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            monto1_oi += e.Row.Cells(2).Text
            monto2_oi += e.Row.Cells(3).Text
            monto3_oi += e.Row.Cells(4).Text
            monto4_oi += e.Row.Cells(5).Text
            monto5_oi += e.Row.Cells(6).Text
            monto6_oi += e.Row.Cells(7).Text
            monto7_oi += e.Row.Cells(8).Text
            monto8_oi += e.Row.Cells(9).Text
            monto9_oi += e.Row.Cells(10).Text
            monto10_oi += e.Row.Cells(11).Text
            monto11_oi += e.Row.Cells(12).Text
            monto12_oi += e.Row.Cells(13).Text
            monto_tot_oi += e.Row.Cells(14).Text

        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(2).Text = Format(monto1_oi, "#,###,##0")
            e.Row.Cells(3).Text = Format(monto2_oi, "#,###,##0")
            e.Row.Cells(4).Text = Format(monto3_oi, "#,###,##0")
            e.Row.Cells(5).Text = Format(monto4_oi, "#,###,##0")
            e.Row.Cells(6).Text = Format(monto5_oi, "#,###,##0")
            e.Row.Cells(7).Text = Format(monto6_oi, "#,###,##0")
            e.Row.Cells(8).Text = Format(monto7_oi, "#,###,##0")
            e.Row.Cells(9).Text = Format(monto8_oi, "#,###,##0")
            e.Row.Cells(10).Text = Format(monto9_oi, "#,###,##0")
            e.Row.Cells(11).Text = Format(monto10_oi, "#,###,##0")
            e.Row.Cells(12).Text = Format(monto11_oi, "#,###,##0")
            e.Row.Cells(13).Text = Format(monto12_oi, "#,###,##0")
            e.Row.Cells(14).Text = Format(monto_tot_oi, "#,###,##0")
        End If
    End Sub

    Private Sub gvReporteOI_Sorting(sender As Object, e As GridViewSortEventArgs) Handles gvReporteOI.Sorting
        Dim sortExpressionOI As String = e.SortExpression

        If GridViewSortDirectionOI = SortDirection.Ascending Then
            GridViewSortDirectionOI = SortDirection.Descending
            SortGridViewOI(sortExpressionOI, " ASC")
        Else
            GridViewSortDirectionOI = SortDirection.Ascending
            SortGridViewOI(sortExpressionOI, " DESC")
        End If
    End Sub
End Class
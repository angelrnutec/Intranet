Imports IntranetBL
Imports KrishLabs.Web.Controls
Imports Intranet.LocalizationIntranet

Public Class RepSolicitudGastosPorConceptoImpresion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim id_empresa As String = Request.QueryString("e")
            Dim anio As String = Request.QueryString("a")
            Dim agrupar As String = Request.QueryString("b")
            
            If Not id_empresa Is Nothing Then

                Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Me.gvReporte.DataSource = reporte.ReporteGastosPorConcepto(id_empresa, anio, agrupar)
                Funciones.TranslateGridviewHeader(Me.gvReporte)
                Me.gvReporte.DataBind()

            End If

            Me.ExportToExcel1.Text = TranslateLocale.text("Exportar a Excel")
            Me.btnImprimir.Text = TranslateLocale.text("Imprimir sin Formato")

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

    Private Sub gvReporte_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvReporte.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then

            monto1 += e.Row.Cells(1).Text
            monto2 += e.Row.Cells(2).Text
            monto3 += e.Row.Cells(3).Text
            monto4 += e.Row.Cells(4).Text
            monto5 += e.Row.Cells(5).Text
            monto6 += e.Row.Cells(6).Text
            monto7 += e.Row.Cells(7).Text
            monto8 += e.Row.Cells(8).Text
            monto9 += e.Row.Cells(9).Text
            monto10 += e.Row.Cells(10).Text
            monto11 += e.Row.Cells(11).Text
            monto12 += e.Row.Cells(12).Text
            monto_tot += e.Row.Cells(13).Text

        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(1).Text = Format(monto1, "#,###,##0")
            e.Row.Cells(2).Text = Format(monto2, "#,###,##0")
            e.Row.Cells(3).Text = Format(monto3, "#,###,##0")
            e.Row.Cells(4).Text = Format(monto4, "#,###,##0")
            e.Row.Cells(5).Text = Format(monto5, "#,###,##0")
            e.Row.Cells(6).Text = Format(monto6, "#,###,##0")
            e.Row.Cells(7).Text = Format(monto7, "#,###,##0")
            e.Row.Cells(8).Text = Format(monto8, "#,###,##0")
            e.Row.Cells(9).Text = Format(monto9, "#,###,##0")
            e.Row.Cells(10).Text = Format(monto10, "#,###,##0")
            e.Row.Cells(11).Text = Format(monto11, "#,###,##0")
            e.Row.Cells(12).Text = Format(monto12, "#,###,##0")
            e.Row.Cells(13).Text = Format(monto_tot, "#,###,##0")
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
            Dim anio As String = Request.QueryString("a")
            Dim agrupar As String = Request.QueryString("b")

            Dim dt As DataTable = reporte.ReporteGastosPorConcepto(id_empresa, anio, agrupar)
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvReporte.DataSource = dv
            gvReporte.DataBind()

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
        Dim anio As String = Request.QueryString("a")
        Dim moneda As String = Request.QueryString("mon")

        Dim parametros As String = ""
        If Not id_empresa Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            parametros += TranslateLocale.text("Empresa") & ": " & IIf(id_empresa = "0", TranslateLocale.text("Todas"), reporte.RecuperaEmpresaNombre(id_empresa))
            parametros += ", " & TranslateLocale.text("Año") & ": " & anio & ", "
            parametros += TranslateLocale.text("Moneda") & ": " & IIf(id_empresa = "12", "USD", "MXP")



        End If
        Return parametros
    End Function

End Class
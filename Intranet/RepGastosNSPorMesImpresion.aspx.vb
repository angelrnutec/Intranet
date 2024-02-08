Imports IntranetBL
Imports KrishLabs.Web.Controls

Public Class RepGastosNSPorMesImpresion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim id_empresa As String = Request.QueryString("e")
            Dim anio As String = Request.QueryString("a")
            Dim cuenta As String = Request.QueryString("c")
            Dim mon As String = Request.QueryString("mon")

            If Not id_empresa Is Nothing And
                Not anio Is Nothing Then

                Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Dim ds As DataSet = reporte.ReporteGastosNSPorMes(id_empresa, anio, cuenta, mon, Session("idEmpleado"))
                CalculaTotales(ds.Tables(0))
                Me.gvReporte.DataSource = ds.Tables(0)
                Me.gvReporte.DataBind()

                Me.txtMes.Text = ds.Tables(1).Rows(0)("mes")

                If Me.gvReporte.Rows.Count = 0 Then
                    Me.lblNoRecords.Visible = True
                End If
            End If
        End If
    End Sub


    Public Sub CalculaTotales(dt As DataTable)

        For Each dr As DataRow In dt.Rows
            mes01 += dr("mes_01")
            mes02 += dr("mes_02")
            mes03 += dr("mes_03")
            mes04 += dr("mes_04")
            mes05 += dr("mes_05")
            mes06 += dr("mes_06")
            mes07 += dr("mes_07")
            mes08 += dr("mes_08")
            mes09 += dr("mes_09")
            mes10 += dr("mes_10")
            mes11 += dr("mes_11")
            mes12 += dr("mes_12")
            mes_tot += dr("total")

        Next

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

    Private mes01 As Decimal = 0
    Private mes02 As Decimal = 0
    Private mes03 As Decimal = 0
    Private mes04 As Decimal = 0
    Private mes05 As Decimal = 0
    Private mes06 As Decimal = 0
    Private mes07 As Decimal = 0
    Private mes08 As Decimal = 0
    Private mes09 As Decimal = 0
    Private mes10 As Decimal = 0
    Private mes11 As Decimal = 0
    Private mes12 As Decimal = 0
    Private mes_tot As Decimal = 0
    Private Sub gvReporte_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvReporte.RowDataBound
        If e.Row.RowType = DataControlRowType.Footer Then
            If mes01 > 0 Then e.Row.Cells(1).Text = Format(mes01, "#,###,##0")
            If mes02 > 0 Then e.Row.Cells(2).Text = Format(mes02, "#,###,##0")
            If mes03 > 0 Then e.Row.Cells(3).Text = Format(mes03, "#,###,##0")
            If mes04 > 0 Then e.Row.Cells(4).Text = Format(mes04, "#,###,##0")
            If mes05 > 0 Then e.Row.Cells(5).Text = Format(mes05, "#,###,##0")
            If mes06 > 0 Then e.Row.Cells(6).Text = Format(mes06, "#,###,##0")
            If mes07 > 0 Then e.Row.Cells(7).Text = Format(mes07, "#,###,##0")
            If mes08 > 0 Then e.Row.Cells(8).Text = Format(mes08, "#,###,##0")
            If mes09 > 0 Then e.Row.Cells(9).Text = Format(mes09, "#,###,##0")
            If mes10 > 0 Then e.Row.Cells(10).Text = Format(mes10, "#,###,##0")
            If mes11 > 0 Then e.Row.Cells(11).Text = Format(mes11, "#,###,##0")
            If mes12 > 0 Then e.Row.Cells(12).Text = Format(mes12, "#,###,##0")
            e.Row.Cells(13).Text = Format(mes_tot, "#,###,##0")
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
            Dim cuenta As String = Request.QueryString("c")
            Dim mon As String = Request.QueryString("mon")

            Dim ds As DataSet = reporte.ReporteGastosNSPorMes(id_empresa, anio, cuenta, mon, Session("idEmpleado"))
            CalculaTotales(ds.Tables(0))
            Dim dt As DataTable = ds.Tables(0)
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvReporte.DataSource = dv
            gvReporte.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    Protected Function RecuperaDatosReporte() As DataTable
        Dim fec_ini As String = Request.QueryString("fec_ini")
        Dim fec_fin As String = Request.QueryString("fec_fin")

        If Not fec_ini Is Nothing And
            Not fec_fin Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Return reporte.ReporteAccesos(fec_ini, fec_fin)
        End If
        Return Nothing
    End Function

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
        Dim mon As String = Request.QueryString("mon")

        Dim parametros As String = ""

        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))


        parametros += "Cuenta: " & Request.QueryString("d") & ", "
        parametros += "Periodo: " & NombreMes(Me.txtMes.Text) & "/" & anio & ", "
        parametros += "Moneda: " & mon


        Return parametros
    End Function

    Private Function NombreMes(mes As Integer) As String
        If mes = 1 Then
            Return "Enero"
        ElseIf mes = 2 Then
            Return "Febrero"
        ElseIf mes = 3 Then
            Return "Marzo"
        ElseIf mes = 4 Then
            Return "Abril"
        ElseIf mes = 5 Then
            Return "Mayo"
        ElseIf mes = 6 Then
            Return "Junio"
        ElseIf mes = 7 Then
            Return "Julio"
        ElseIf mes = 8 Then
            Return "Agosto"
        ElseIf mes = 9 Then
            Return "Septiembre"
        ElseIf mes = 10 Then
            Return "Octubre"
        ElseIf mes = 11 Then
            Return "Noviembre"
        ElseIf mes = 12 Then
            Return "Diciembre"
        End If

        Return ""
    End Function
End Class
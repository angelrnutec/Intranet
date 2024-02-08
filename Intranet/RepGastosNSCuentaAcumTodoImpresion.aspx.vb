Imports IntranetBL
Imports KrishLabs.Web.Controls

Public Class RepGastosNSCuentaAcumTodoImpresion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim id_empresa As String = Request.QueryString("e")
            Dim anio As String = Request.QueryString("a")
            Dim mon As String = Request.QueryString("mon")
            Dim mes As String = Request.QueryString("m")

            If Not id_empresa Is Nothing And
                Not anio Is Nothing Then

                Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Dim ds As DataSet = reporte.ReporteGastosNSCuentaAcumTodo(id_empresa, anio, mon, Session("idEmpleado"), mes)
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
            BEGCB += dr("BEGCB")
            BEGFC += dr("BEGFC")
            CECAP += dr("CECAP")
            DGGCB += dr("DGGCB")
            DGGFC += dr("DGGFC")
            HELICOPTERO += dr("HELICOPTERO")
            BECCD += dr("BECCD")
            BEZCD += dr("BEZCD")

            ADMON += dr("ADMON")
            RH += dr("RH")
            SEGINT += dr("SEGINT")
            SISTEMAS += dr("SISTEMAS")

            total += dr("total")
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



    Private BEGCB As Decimal = 0
    Private BEGFC As Decimal = 0
    Private CECAP As Decimal = 0
    Private DGGCB As Decimal = 0
    Private DGGFC As Decimal = 0
    Private HELICOPTERO As Decimal = 0
    Private BECCD As Decimal = 0
    Private BEZCD As Decimal = 0

    Private ADMON As Decimal = 0
    Private RH As Decimal = 0
    Private SEGINT As Decimal = 0
    Private SISTEMAS As Decimal = 0

    Private total As Decimal = 0
    Private Sub gvReporte_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvReporte.RowDataBound
        If e.Row.RowType = DataControlRowType.Footer Then
            If BEGCB > 0 Then e.Row.Cells(1).Text = Format(BEGCB, "#,###,##0")
            If BEGFC > 0 Then e.Row.Cells(2).Text = Format(BEGFC, "#,###,##0")
            If CECAP > 0 Then e.Row.Cells(3).Text = Format(CECAP, "#,###,##0")
            If DGGCB > 0 Then e.Row.Cells(4).Text = Format(DGGCB, "#,###,##0")
            If DGGFC > 0 Then e.Row.Cells(5).Text = Format(DGGFC, "#,###,##0")
            If HELICOPTERO > 0 Then e.Row.Cells(6).Text = Format(HELICOPTERO, "#,###,##0")
            If BECCD > 0 Then e.Row.Cells(7).Text = Format(BECCD, "#,###,##0")
            If BEZCD > 0 Then e.Row.Cells(8).Text = Format(BEZCD, "#,###,##0")

            If ADMON > 0 Then e.Row.Cells(9).Text = Format(ADMON, "#,###,##0")
            If RH > 0 Then e.Row.Cells(10).Text = Format(RH, "#,###,##0")
            If SEGINT > 0 Then e.Row.Cells(11).Text = Format(SEGINT, "#,###,##0")
            If SISTEMAS > 0 Then e.Row.Cells(12).Text = Format(SISTEMAS, "#,###,##0")

            If total > 0 Then e.Row.Cells(13).Text = Format(total, "#,###,##0")
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
            Dim mon As String = Request.QueryString("mon")
            Dim mes As String = Request.QueryString("m")

            Dim ds As DataSet = reporte.ReporteGastosNSCuentaAcumTodo(id_empresa, anio, mon, Session("idEmpleado"), mes)
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


        parametros += "Empresa: " & reporte.RecuperaEmpresaNombre(Request.QueryString("e")) & ", "
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
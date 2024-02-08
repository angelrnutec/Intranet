Imports IntranetBL
Imports KrishLabs.Web.Controls
Imports Intranet.LocalizationIntranet

Public Class RepMaximosMinimosImpresion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim id_empresa As String = Request.QueryString("e")
            Dim anio As String = Request.QueryString("a")
            Dim periodo As String = Request.QueryString("m")

            If Not id_empresa Is Nothing And
                Not anio Is Nothing And
                Not periodo Is Nothing Then

                Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Me.gvReporte.DataSource = reporte.ReporteMaximosMinimos(id_empresa, anio, periodo)
                Funciones.TranslateGridviewHeader(gvReporte)
                Me.gvReporte.DataBind()

                If Me.gvReporte.Rows.Count = 0 Then
                    Me.lblNoRecords.Visible = True
                End If
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

    Private Sub gvReporte_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvReporte.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            e.Row.Cells(0).Text = TranslateLocale.text(e.Row.Cells(0).Text)
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

            Dim fec_ini As String = Request.QueryString("fec_ini")
            Dim fec_fin As String = Request.QueryString("fec_fin")

            Dim dt As DataTable = reporte.ReporteAccesos(fec_ini, fec_fin)
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
        Dim periodo As String = Request.QueryString("m")

        Dim parametros As String = ""

        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))


        parametros += TranslateLocale.text("Empresa") & ": " & reporte.RecuperaEmpresaNombre(Request.QueryString("e")) & ", "
        parametros += TranslateLocale.text("Fecha") & ": " & NombreMes(periodo) & "/" & anio


        Return parametros
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
End Class
Imports IntranetBL
Imports KrishLabs.Web.Controls

Public Class TelefoniaRepAhorroPromedioImpresion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim anio As String = Request.QueryString("anio")
            Dim mes As String = Request.QueryString("mes")

            If Not anio Is Nothing And
                Not mes Is Nothing Then

                Dim telcel As New Telcel(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Dim ds As DataSet = telcel.RepTelcelAhorroPromedio(anio, mes)
                Me.gvReporte.DataSource = ds.Tables(0)
                Me.gvReporte.DataBind()

                Me.gvResultados2.DataSource = ds.Tables(1)
                Me.gvResultados2.DataBind()
            End If
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

#Region "TOTALES"
    Dim mes_01 As Decimal = 0
    Dim mes_02 As Decimal = 0
    Dim mes_03 As Decimal = 0
    Dim mes_04 As Decimal = 0
    Dim mes_05 As Decimal = 0
    Dim mes_06 As Decimal = 0
    Dim mes_07 As Decimal = 0
    Dim mes_08 As Decimal = 0
    Dim mes_09 As Decimal = 0
    Dim mes_10 As Decimal = 0
    Dim mes_11 As Decimal = 0
    Dim mes_12 As Decimal = 0
    Dim total As Decimal = 0
    Dim promedio As Decimal = 0
    Dim ahorro As Decimal = 0
#End Region

    Private Sub gvReporte_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvReporte.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then



            mes_01 += e.Row.Cells(2).Text
            mes_02 += e.Row.Cells(3).Text
            mes_03 += e.Row.Cells(4).Text
            mes_04 += e.Row.Cells(5).Text
            mes_05 += e.Row.Cells(6).Text
            mes_06 += e.Row.Cells(7).Text
            mes_07 += e.Row.Cells(8).Text
            mes_08 += e.Row.Cells(9).Text
            mes_09 += e.Row.Cells(10).Text
            mes_10 += e.Row.Cells(11).Text
            mes_11 += e.Row.Cells(12).Text
            mes_12 += e.Row.Cells(13).Text
            total += e.Row.Cells(14).Text
            promedio += e.Row.Cells(15).Text
            ahorro += e.Row.Cells(16).Text


        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(2).Text = Format(mes_01, "#,###,##0")
            e.Row.Cells(3).Text = Format(mes_02, "#,###,##0")
            e.Row.Cells(4).Text = Format(mes_03, "#,###,##0")
            e.Row.Cells(5).Text = Format(mes_04, "#,###,##0")
            e.Row.Cells(6).Text = Format(mes_05, "#,###,##0")
            e.Row.Cells(7).Text = Format(mes_06, "#,###,##0")
            e.Row.Cells(8).Text = Format(mes_07, "#,###,##0")
            e.Row.Cells(9).Text = Format(mes_08, "#,###,##0")
            e.Row.Cells(10).Text = Format(mes_09, "#,###,##0")
            e.Row.Cells(11).Text = Format(mes_10, "#,###,##0")
            e.Row.Cells(12).Text = Format(mes_11, "#,###,##0")
            e.Row.Cells(13).Text = Format(mes_12, "#,###,##0")
            e.Row.Cells(14).Text = Format(total, "#,###,##0")
            e.Row.Cells(15).Text = Format(promedio, "#,###,##0")
            e.Row.Cells(16).Text = Format(ahorro, "#,###,##0")

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

            Dim anio As String = Request.QueryString("anio")
            Dim mes As String = Request.QueryString("mes")

            Dim telcel As New Telcel(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = telcel.RepTelcelAhorroPromedio(anio, mes).Tables(0)
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvReporte.DataSource = dv
            gvReporte.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    'Protected Function RecuperaDatosReporte() As DataSet
    '    Dim fec_ini As String = Request.QueryString("fec_ini")
    '    Dim fec_fin As String = Request.QueryString("fec_fin")
    '    Dim id_empresa As String = Request.QueryString("id_empresa")
    '    Dim id_estatus As String = Request.QueryString("id_estatus")
    '    Dim id_empleado As String = Request.QueryString("id_empleado")
    '    Dim cancelada As String = Request.QueryString("cancelada")

    '    If Not fec_ini Is Nothing And
    '        Not fec_fin Is Nothing And
    '        Not id_empresa Is Nothing And
    '        Not id_estatus Is Nothing And
    '        Not id_empleado Is Nothing Then

    '        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
    '        Return reporte.ReporteSolicitudVacaciones(fec_ini, fec_fin, id_empresa, id_estatus, id_empleado, cancelada, Session("idEmpleado"))
    '    End If
    '    Return Nothing
    'End Function

    Protected Function ifNullEmptyFecha(valor As Object) As String
        If IsDBNull(valor) Then
            Return ""
        Else
            Return "<br />(" & Format(CType(valor, Date), "dd/MM/yyyy HH:mm") & ")"
        End If
    End Function

    Protected Function DefinicionParametros() As String
        Dim anio As String = Request.QueryString("anio")
        Dim mes As String = Request.QueryString("mes")

        Dim parametros As String = ""
        If Not anio Is Nothing And
            Not mes Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            parametros += "A&ntilde;o: " & anio & ", "
            parametros += "Mes: " & NombrePeriodo(mes) & ""

        End If
        Return parametros
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

        Return nombre
    End Function

    Private Sub gvResultados2_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvResultados2.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim lblOrden As Label = CType(e.Row.FindControl("lblOrden"), Label)
            If lblOrden.Text = "4" Then
                e.Row.CssClass = "filaTotales titulos"
                e.Row.BackColor = Drawing.Color.LightGray
                e.Row.BorderColor = Drawing.Color.Gray
            ElseIf lblOrden.Text = "5" Then
                e.Row.CssClass = "filaTotales titulos"
                e.Row.BackColor = Drawing.ColorTranslator.FromHtml("#bebdbd")
            End If
        End If
    End Sub
End Class
Imports IntranetBL
Imports KrishLabs.Web.Controls

Public Class RepGastosNSEdoResImpresion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            'Dim id_empresa As String = Request.QueryString("e")
            'Dim anio As String = Request.QueryString("a")
            'Dim mes As String = Request.QueryString("m")

            'If Not id_empresa Is Nothing And
            '    Not anio Is Nothing And
            '    Not mes Is Nothing Then

            '    Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            '    Me.gvReporte.DataSource = reporte.ReporteGastosNSEdoRes(anio, mes)
            '    Me.gvReporte.DataBind()

            '    If Me.gvReporte.Rows.Count = 0 Then
            '        Me.lblNoRecords.Visible = True
            '    End If
            'End If
        End If
    End Sub


    Protected Function ReporteGastosNSEdoRes() As DataTable
        Dim anio As String = Request.QueryString("a")
        Dim mes As String = Request.QueryString("m")
        Dim mon As String = Request.QueryString("mon")

        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Return reporte.ReporteGastosNSEdoRes(anio, mes, mon)
    End Function



    Dim rep3_monto(50) As Decimal
    Dim rep3_monto_ant(50) As Decimal
    Protected Function FormateaValorRep3(dr As DataRow, tipo As Integer, columna As Integer) As String
        Dim html As New StringBuilder("")
        Dim anio As Integer = Request.QueryString("a")
        Dim mes As Integer = Request.QueryString("m")

        Dim monto As Decimal = 0
        Dim porcentaje As Decimal = 0
        If tipo = 1 Then
            If columna = 1 Then
                If dr("id") = 1 Then rep3_monto(columna) = dr("monto_horn")
                monto = dr("monto_horn")
                html.AppendLine("<div class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</div>")
                If dr("datos_extras") = False Then
                    If rep3_monto(columna) <> 0 Then
                        html.AppendLine("<div class='rep2Porc" & IIf((monto / rep3_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep3_monto(columna)) * 100) & "</i></div>")
                    Else
                        html.AppendLine("<div class='rep2Porc'><i>--</i></div>")
                    End If
                End If
            ElseIf columna = 2 Then
                If dr("id") = 1 Then rep3_monto(columna) = dr("monto_horn_ant")
                monto = dr("monto_horn_ant")
                html.AppendLine("<div class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</div>")
                If dr("datos_extras") = False Then
                    If rep3_monto(columna) <> 0 Then
                        html.AppendLine("<div class='rep2Porc" & IIf((monto / rep3_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep3_monto(columna)) * 100) & "</i></div>")
                    Else
                        html.AppendLine("<div class='rep2Porc'><i>--</i></div>")
                    End If
                End If
            ElseIf columna = 3 Then
                If dr("datos_extras") = False Then
                    monto = dr("monto_horn") - (PlanDistribucion(dr, mes, TipoValor.MesAcumulado, "_horn"))
                    html.AppendLine("<div class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</div>")
                End If
            ElseIf columna = 4 Then
                If dr("monto_horn_ant") <> 0 Then
                    porcentaje = Math.Abs((-1 + dr("monto_horn") / dr("monto_horn_ant")) * 100)
                    If dr("monto_horn") < dr("monto_horn_ant") Then
                        porcentaje = porcentaje * -1
                    End If
                    html.AppendLine("<div class='rep2Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</div>")
                Else
                    html.AppendLine("<div class='rep2Dato'>--</div>")
                End If
            End If

        ElseIf tipo = 2 Then
            If columna = 5 Then
                If dr("id") = 1 Then rep3_monto(columna) = dr("monto_fibr")
                monto = dr("monto_fibr")
                html.AppendLine("<div class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</div>")
                If dr("datos_extras") = False Then
                    If rep3_monto(columna) <> 0 Then
                        html.AppendLine("<div class='rep2Porc" & IIf((monto / rep3_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep3_monto(columna)) * 100) & "</i></div>")
                    Else
                        html.AppendLine("<div class='rep2Porc'><i>--</i></div>")
                    End If
                End If
            ElseIf columna = 6 Then
                If dr("id") = 1 Then rep3_monto(columna) = dr("monto_fibr_ant")
                monto = dr("monto_fibr_ant")
                html.AppendLine("<div class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</div>")
                If dr("datos_extras") = False Then
                    If rep3_monto(columna) <> 0 Then
                        html.AppendLine("<div class='rep2Porc" & IIf((monto / rep3_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep3_monto(columna)) * 100) & "</i></div>")
                    Else
                        html.AppendLine("<div class='rep2Porc'><i>--</i></div>")
                    End If
                End If
            ElseIf columna = 7 Then
                If dr("datos_extras") = False Then
                    monto = dr("monto_fibr") - (PlanDistribucion(dr, mes, TipoValor.MesAcumulado, "_fibr"))
                    html.AppendLine("<div class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</div>")
                End If
            ElseIf columna = 8 Then
                If dr("monto_fibr_ant") <> 0 Then
                    porcentaje = Math.Abs((-1 + dr("monto_fibr") / dr("monto_fibr_ant")) * 100)
                    If dr("monto_fibr") < dr("monto_fibr_ant") Then
                        porcentaje = porcentaje * -1
                    End If
                    html.AppendLine("<div class='rep2Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</div>")
                Else
                    html.AppendLine("<div class='rep2Dato'>--</div>")
                End If
            End If
        ElseIf tipo = 3 Then
            If columna = 9 Then
                If dr("id") = 1 Then rep3_monto(columna) = dr("monto_horn") + dr("monto_fibr") - dr("monto_resta_total")
                monto = dr("monto_horn") + dr("monto_fibr") - dr("monto_resta_total")
                html.AppendLine("<div class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</div>")

                If dr("datos_extras") = False Then
                    If rep3_monto(columna) <> 0 Then
                        html.AppendLine("<div class='rep2Porc" & IIf((monto / rep3_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep3_monto(columna)) * 100) & "</i></div>")
                    Else
                        html.AppendLine("<div class='rep2Porc'><i>--</i></div>")
                    End If
                End If
            ElseIf columna = 10 Then
                If dr("id") = 1 Then rep3_monto(columna) = dr("monto_horn_ant") + dr("monto_fibr_ant") - dr("monto_resta_total_ant")
                monto = dr("monto_horn_ant") + dr("monto_fibr_ant") - dr("monto_resta_total_ant")
                html.AppendLine("<div class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</div>")

                If dr("datos_extras") = False Then
                    If rep3_monto(columna) <> 0 Then
                        html.AppendLine("<div class='rep2Porc" & IIf((monto / rep3_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep3_monto(columna)) * 100) & "</i></div>")
                    Else
                        html.AppendLine("<div class='rep2Porc'><i>--</i></div>")
                    End If
                End If
            ElseIf columna = 11 Then
                If (dr("monto_fibr_ant") + dr("monto_horn_ant") - dr("monto_resta_total_ant")) <> 0 Then
                    'monto = ((dr("monto_fibr") + dr("monto_horn") - dr("monto_resta_total")) / (dr("monto_fibr_ant") + dr("monto_horn_ant") - dr("monto_resta_total_ant")) - 1) * 100

                    porcentaje = Math.Abs(((dr("monto_fibr") + dr("monto_horn") - dr("monto_resta_total")) / (dr("monto_fibr_ant") + dr("monto_horn_ant") - dr("monto_resta_total_ant")) - 1) * 100)
                    If (dr("monto_fibr") + dr("monto_horn") - dr("monto_resta_total")) < (dr("monto_fibr_ant") + dr("monto_horn_ant") - dr("monto_resta_total_ant")) Then
                        porcentaje = porcentaje * -1
                    End If

                    html.AppendLine("<div class='rep2Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</div>")
                Else
                    html.AppendLine("<div class='rep2Dato'>--</div>")
                End If
            End If
        End If


        If dr("permite_captura") = False Then
            Return "<b>" & html.ToString & "</b>"
        Else
            Return html.ToString
        End If

    End Function




    Protected Function PlanDistribucion(dr As DataRow, mes As Integer, tipo As TipoValor, Optional division As String = "") As Decimal
        Dim nombre_campo As String = "monto_plan"
        If division.Length > 0 Then
            nombre_campo = "monto" & division & "_plan"
        End If
        If tipo = TipoValor.Anual Then
            Return dr(nombre_campo)
        ElseIf tipo = TipoValor.MesActual Then
            Return dr(nombre_campo & mes)
        ElseIf tipo = TipoValor.MesAcumulado Then
            Dim valor As Decimal = 0
            For i As Integer = 1 To mes
                valor += dr(nombre_campo & i)
            Next
            Return valor
        End If

        Return 0
    End Function

    Public Enum TipoValor
        Anual = 1
        MesActual = 2
        MesAcumulado = 3
    End Enum

    Private Function ifNullEmpty(valor As Object, Optional decim As Boolean = False) As String
        Try
            If IsDBNull(valor) Then
                Return "--"
            End If
            If decim Then
                Return Convert.ToDecimal(valor).ToString("###,###,##0.00")
            Else
                Return Convert.ToDecimal(valor).ToString("###,###,##0")
            End If
        Catch ex As Exception
            Return ex.Message
        End Try
    End Function


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


    Private Sub SortGridView(sortExpression As String, direction As String)
        'Try
        '    '  You can cache the DataTable for improving performance
        '    Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        '    Dim fec_ini As String = Request.QueryString("fec_ini")
        '    Dim fec_fin As String = Request.QueryString("fec_fin")

        '    Dim dt As DataTable = reporte.ReporteAccesos(fec_ini, fec_fin)
        '    Dim dv As New DataView(dt)
        '    dv.Sort = sortExpression & direction

        '    gvReporte.DataSource = dv
        '    gvReporte.DataBind()

        'Catch ex As Exception
        '    ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        'End Try
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
        parametros += "Periodo: " & anio & ", "
        parametros += "Moneda: " & mon


        Return parametros
    End Function

    Protected Function NombreMes(mes As Integer) As String
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
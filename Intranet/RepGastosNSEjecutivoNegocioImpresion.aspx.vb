Imports IntranetBL

Public Class RepGastosNSEjecutivoNegocioImpresion
    Inherits System.Web.UI.Page

    Protected dtPlanDistribucion As DataTable
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Me.CargaTituloReporte()
        End If
    End Sub

    Private Sub CargaTituloReporte()
        Me.lblTituloReporte.Text = "Reporte Ejecutivo Negocio (" & NombrePeriodo(Request.QueryString("m")) & " / " & Request.QueryString("a") & ", Moneda: " & Request.QueryString("mon") & ")"
    End Sub

    Protected Function RecuperaDatosReporte() As DataSet
        Dim anio As String = Request.QueryString("a")
        Dim mes As String = Request.QueryString("m")
        Dim moneda As String = Request.QueryString("mon")

        If Not anio Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            If Session("idEmpleado") = Nothing Then
                Return New DataSet()
            End If
            Return reporte.RecuperaReporteEjecutivoGastosNSNegocio(anio, moneda, mes, Session("idEmpleado"))
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

        Return Left(nombre, 3).ToUpper()
    End Function
















    Protected Function ReporteGastosNSEdoRes() As DataTable
        Dim anio As String = Request.QueryString("a")
        Dim mes As String = Request.QueryString("m")
        Dim mon As String = Request.QueryString("mon")

        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        If seguridad.ValidaPermisoPagina(Session("idEmpleado"), 32) Then
            Return reporte.ReporteGastosNSEdoRes(anio, mes, mon)
        Else
            Return New DataTable
        End If
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


End Class

Public Class MenuItems
    Public valor As String
    Public activo As Boolean
    Public num_rep As Integer
End Class

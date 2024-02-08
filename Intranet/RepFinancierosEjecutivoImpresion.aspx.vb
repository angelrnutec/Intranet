Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class RepFinancierosEjecutivoImpresion
    Inherits System.Web.UI.Page

    Protected dtPlanDistribucion As DataTable
    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Dim anio As String = Request.QueryString("a")
            Dim mes As String = Request.QueryString("m")

            Me.CargaTituloReporte()
        End If
    End Sub

    Private Sub CargaTituloReporte()
        Me.lblTituloReporte.Text = TranslateLocale.text("Reporte Ejecutivo")
    End Sub


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

    Protected Function RecuperaDatosReporte() As DataSet
        Dim anio As String = Request.QueryString("a")
        Dim mes As String = Request.QueryString("m")

        If Not anio Is Nothing And
            Not mes Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Return reporte.RecuperaReporteEjecutivo(anio, mes, "C")
        End If
        Return Nothing
    End Function

    Protected Function RecuperaDatosReporteComentario() As DataTable
        Dim anio As String = Request.QueryString("a")
        Dim mes As String = Request.QueryString("m")

        If Not anio Is Nothing And
            Not mes Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Return reporte.RecuperaReporteEjecutivoComentarios(anio, mes, "C")
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

        Return TranslateLocale.text(nombre)
    End Function

    Protected Function FormateaValorRep1(dt As DataTable, ByRef dr As DataRow, dato As Integer, esTrimestre As Boolean, esPeriodoAnterior As Boolean) As String
        Dim html As New StringBuilder("")
        Dim anio As Integer = Request.QueryString("a")
        Dim mes As Integer = Request.QueryString("m")


        Dim facturacion As Decimal = 0


        Dim monto As String
        Dim monto_dec As Decimal = 0
        Dim monto_ant_dec As Decimal
        Dim monto_plan_dec As Decimal
        If dato > 0 Then
            monto = ifNullEmpty(dr("monto" & IIf(esTrimestre, "_trim", "_mes") & IIf(esPeriodoAnterior, "_ant", "") & dato))
            html.AppendLine("<b>" & monto & IIf(dr("es_porcentaje") = True And monto <> "--", "%", "") & "</b>")
            If dr("es_multivalor") = True Then

                If monto <> "--" Then
                    monto_dec = monto
                    monto_ant_dec = ifNullEmpty(dr("monto" & IIf(esTrimestre, "_trim", "_mes") & "_ant" & dato))
                End If

                If esTrimestre Then
                    monto_plan_dec = PlanDistribucion(dr, dato * 3, TipoValor.MesActual)
                    monto_plan_dec += PlanDistribucion(dr, dato * 3 - 1, TipoValor.MesActual)
                    monto_plan_dec += PlanDistribucion(dr, dato * 3 - 2, TipoValor.MesActual)
                Else
                    monto_plan_dec = PlanDistribucion(dr, dato, TipoValor.MesActual)
                End If


                Dim porc_1 As Decimal = 0
                If monto_plan_dec <> 0 Then
                    porc_1 = ((monto_dec / monto_plan_dec) - 1) * 100
                End If
                Dim porc_2 As Decimal = 0
                If monto_ant_dec <> 0 Then
                    porc_2 = ((monto_dec / monto_ant_dec) - 1) * 100
                End If

                'If dr("id") = 5 Or dr("id") = 6 Then  'Utilidad Neta
                '    facturacion = RecuperaValorDeTabla(dt, "monto" & IIf(esTrimestre, "_trim", "_mes") & dato, 2)
                '    If facturacion <> 0 Then
                '        porc_1 = ((monto_dec / facturacion)) * 100
                '    End If
                'End If


                If dr("id") = 5 Or dr("id") = 6 Then  'Operational Profit NS
                    If esTrimestre Then
                        Dim planAnual = dr("monto_plan" & dato) * 3
                        Dim operationProfit = dr("monto" & IIf(esTrimestre, "_trim", "_mes") & dato)
                        If (planAnual = 0) Then
                            porc_1 = 0
                        Else
                            porc_1 = ((operationProfit / planAnual) - 1) * 100
                        End If
                    Else
                        Dim planAnual = dr("monto_plan" & dato)
                        Dim operationProfit = dr("monto_mes" & dato)
                        If (planAnual = 0) Then
                            porc_1 = 0
                        Else
                            porc_1 = ((operationProfit / planAnual) - 1) * 100
                        End If
                    End If
                End If


                html.AppendLine("<br />")
                html.AppendLine("<span" & IIf(porc_1 < 0, " class='negativo'", "") & ">" & IIf(porc_1 < 0, "(" & ifNullEmpty(porc_1) & "%)", ifNullEmpty(porc_1) & "%") & "</span>")
                html.AppendLine("<br />")
                If monto_ant_dec <> 0 Then
                    html.AppendLine("<span" & IIf(porc_2 < 0, " class='negativo'", "") & ">" & IIf(porc_2 < 0, "(" & ifNullEmpty(porc_2) & "%)", ifNullEmpty(porc_2) & "%") & "</span> vs " & anio - 1)
                    html.AppendLine("<br />")
                    html.AppendLine("[" & ifNullEmpty(monto_ant_dec) & "]")
                End If
            End If
        ElseIf dato = 0 Then
            monto = ifNullEmpty(dr("monto_plan"))
            If dr("id") <> 3 Then

                If dr("es_porcentaje") = False Then
                    monto_plan_dec = PlanDistribucion(dr, mes, TipoValor.MesAcumulado)
                    html.AppendLine("<b>" & ifNullEmpty(monto_plan_dec) & "</b>")
                Else
                    html.AppendLine("<b>" & monto & IIf(dr("es_porcentaje") = True And monto <> "--", "%", "") & "</b>")
                End If
            End If
        ElseIf dato = -2 Then
            monto = ifNullEmpty(dr("monto_plan"))
            If dr("id") <> 3 Then

                If dr("es_porcentaje") = False Then
                    monto_plan_dec = PlanDistribucion(dr, mes, TipoValor.Anual)
                    html.AppendLine("<b>" & ifNullEmpty(monto_plan_dec) & "</b>")
                Else
                    html.AppendLine("<b>" & monto & IIf(dr("es_porcentaje") = True And monto <> "--", "%", "") & "</b>")
                End If
            End If
        ElseIf dato = -1 Then
            monto = ifNullEmpty(dr("monto_total"))

            If dr("id") <> 3 Then
                html.AppendLine("<b>" & monto & IIf(dr("es_porcentaje") = True And monto <> "--", "%", "") & "</b>")

                If dr("es_multivalor") = True Then

                    If monto <> "--" Then
                        monto_dec = monto
                        monto_ant_dec = ifNullEmpty(dr("monto_total_ant"))
                    End If

                    monto_plan_dec = PlanDistribucion(dr, mes, TipoValor.MesAcumulado)



                    Dim porc_1 As Decimal = 0
                    If monto_plan_dec <> 0 Then
                        porc_1 = ((monto_dec / monto_plan_dec) - 1) * 100
                    End If
                    Dim porc_2 As Decimal = 0
                    If monto_ant_dec <> 0 Then
                        porc_2 = ((monto_dec / monto_ant_dec) - 1) * 100
                    End If

                    'If dr("id") = 5 Or dr("id") = 6 Then  'Utilidad Neta
                    '    facturacion = RecuperaValorDeTabla(dt, "monto_total", 2)
                    '    If facturacion <> 0 Then
                    '        porc_1 = ((monto_dec / facturacion)) * 100
                    '    End If
                    'End If

                    If dr("id") = 5 Or dr("id") = 6 Then  'Operational Profit NS
                        Dim planAnual = (dr("monto_plan") / 12) * mes
                        Dim operationProfit = dr("monto_total")
                        If planAnual = 0 Then
                            porc_1 = 0
                        Else
                            porc_1 = ((operationProfit / planAnual) - 1) * 100
                        End If
                    End If


                    html.AppendLine("<br />")
                    html.AppendLine("<span" & IIf(porc_1 < 0, " class='negativo'", "") & ">" & IIf(porc_1 < 0, "(" & ifNullEmpty(porc_1) & "%)", ifNullEmpty(porc_1) & "%") & "</span>")
                    html.AppendLine("<br />")
                    If monto_ant_dec <> 0 Then
                        html.AppendLine("<span" & IIf(porc_2 < 0, " class='negativo'", "") & ">" & IIf(porc_2 < 0, "(" & ifNullEmpty(porc_2) & "%)", ifNullEmpty(porc_2) & "%") & "</span> vs " & anio - 1)
                        html.AppendLine("<br />")
                        html.AppendLine("[" & ifNullEmpty(monto_ant_dec) & "]")
                    End If
                End If
            End If
        End If

        Return html.ToString
    End Function



    Private Function RecuperaValorDeTabla(dt As DataTable, columna As String, id As Integer) As Decimal

        For Each dr As DataRow In dt.Rows
            If dr("id") = id Then
                Return dr(columna)
            End If
        Next

        Return 0
    End Function




    Public monto_base(50) As Decimal
    Public monto_base_trim1(50) As Decimal
    Public monto_base_trim2(50) As Decimal
    Public monto_base_trim3(50) As Decimal
    Public monto_base_trim4(50) As Decimal
    Public monto_base_anual(50) As Decimal
    Public monto_base_anual_ant(50) As Decimal
    Public monto_plan As Decimal
    Public monto_real_menos_plan As Decimal

    Protected Function FormateaValorRep2(ByRef dr As DataRow, dato As Integer, esTrimestre As Boolean, esTotal As Boolean, esTotalAnt As Boolean, posicion As Integer) As String
        Dim html As New StringBuilder("")
        Dim anio As Integer = Request.QueryString("a")
        Dim mes As Integer = Request.QueryString("m")

        Dim monto As Decimal
        Dim porcentaje As Decimal = 0

        If dato > 0 Then
            If dr("id") = 1 And esTrimestre = False Then monto_base(dato) = dr("monto_mes" & dato)
            If dr("id") = 1 And esTrimestre = True And dato = 1 Then monto_base_trim1(dato) = dr("monto_trim" & dato)
            If dr("id") = 1 And esTrimestre = True And dato = 2 Then monto_base_trim2(dato) = dr("monto_trim" & dato)
            If dr("id") = 1 And esTrimestre = True And dato = 3 Then monto_base_trim3(dato) = dr("monto_trim" & dato)
            If dr("id") = 1 And esTrimestre = True And dato = 4 Then monto_base_trim4(dato) = dr("monto_trim" & dato)

            monto = dr("monto" & IIf(esTrimestre, "_trim", "_mes") & dato)
            If posicion = 1 Then
                html.AppendLine("<span class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto, dr("datos_extras")) & "</span>")
            End If
            If posicion = 2 Then
                If esTrimestre = False And monto_base(dato) <> 0 Then
                    If dr("datos_extras") = False Then
                        html.AppendLine("<span class='rep2Porc" & IIf((monto / monto_base(dato)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / monto_base(dato)) * 100, dr("datos_extras")) & "</i></span>")
                    ElseIf dr("es_porcentaje") = True Then
                        html.AppendLine("%")
                    End If
                ElseIf esTrimestre = True And dato = 1 And monto_base_trim1(dato) <> 0 Then
                    If dr("datos_extras") = False Then
                        html.AppendLine("<span class='rep2Porc" & IIf((monto / monto_base_trim1(dato)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / monto_base_trim1(dato)) * 100, dr("datos_extras")) & "</i></span>")
                    ElseIf dr("es_porcentaje") = True Then
                        html.AppendLine("%")
                    End If
                ElseIf esTrimestre = True And dato = 2 And monto_base_trim2(dato) <> 0 Then
                    If dr("datos_extras") = False Then
                        html.AppendLine("<span class='rep2Porc" & IIf((monto / monto_base_trim2(dato)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / monto_base_trim2(dato)) * 100, dr("datos_extras")) & "</i></span>")
                    ElseIf dr("es_porcentaje") = True Then
                        html.AppendLine("%")
                    End If
                ElseIf esTrimestre = True And dato = 3 And monto_base_trim3(dato) <> 0 Then
                    If dr("datos_extras") = False Then
                        html.AppendLine("<span class='rep2Porc" & IIf((monto / monto_base_trim3(dato)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / monto_base_trim3(dato)) * 100, dr("datos_extras")) & "</i></span>")
                    ElseIf dr("es_porcentaje") = True Then
                        html.AppendLine("%")
                    End If
                ElseIf esTrimestre = True And dato = 4 And monto_base_trim4(dato) <> 0 Then
                    If dr("datos_extras") = False Then
                        html.AppendLine("<span class='rep2Porc" & IIf((monto / monto_base_trim4(dato)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / monto_base_trim4(dato)) * 100, dr("datos_extras")) & "</i></span>")
                    ElseIf dr("es_porcentaje") = True Then
                        html.AppendLine("%")
                    End If
                End If
            End If
        Else
            If dr("id") = 1 And esTotal Then
                monto_base_anual(dato) = dr("monto_trim1") + dr("monto_trim2") + dr("monto_trim3") + dr("monto_trim4") '- dr("monto_resta_total")
            End If
            If dr("id") = 1 And esTotalAnt Then
                monto_base_anual_ant(dato) = dr("monto_trim_ant1") + dr("monto_trim_ant2") + dr("monto_trim_ant3") + dr("monto_trim_ant4") '- dr("monto_resta_total_ant")
            End If

            Dim capturas As Integer = 0
            If esTotal And dr("datos_extras") = True Then
                capturas = IIf(dr("monto_mes1") > 0, 1, 0) + IIf(dr("monto_mes2") > 0, 1, 0) + IIf(dr("monto_mes3") > 0, 1, 0) + IIf(dr("monto_mes4") > 0, 1, 0)
                capturas += IIf(dr("monto_mes5") > 0, 1, 0) + IIf(dr("monto_mes6") > 0, 1, 0) + IIf(dr("monto_mes7") > 0, 1, 0) + IIf(dr("monto_mes8") > 0, 1, 0)
                capturas += IIf(dr("monto_mes9") > 0, 1, 0) + IIf(dr("monto_mes10") > 0, 1, 0) + IIf(dr("monto_mes11") > 0, 1, 0) + IIf(dr("monto_mes12") > 0, 1, 0)

                monto = dr("monto_mes1") + dr("monto_mes2") + dr("monto_mes3") + dr("monto_mes4") + dr("monto_mes5") + dr("monto_mes6")
                monto += dr("monto_mes7") + dr("monto_mes8") + dr("monto_mes9") + dr("monto_mes10") + dr("monto_mes11") + dr("monto_mes12")
            ElseIf esTotalAnt And dr("datos_extras") = True Then
                capturas = IIf(dr("monto_mes_ant1") > 0, 1, 0) + IIf(dr("monto_mes_ant2") > 0, 1, 0) + IIf(dr("monto_mes_ant3") > 0, 1, 0) + IIf(dr("monto_mes_ant4") > 0, 1, 0)
                capturas += IIf(dr("monto_mes_ant5") > 0, 1, 0) + IIf(dr("monto_mes_ant6") > 0, 1, 0) + IIf(dr("monto_mes_ant7") > 0, 1, 0) + IIf(dr("monto_mes_ant8") > 0, 1, 0)
                capturas += IIf(dr("monto_mes_ant9") > 0, 1, 0) + IIf(dr("monto_mes_ant10") > 0, 1, 0) + IIf(dr("monto_mes_ant11") > 0, 1, 0) + IIf(dr("monto_mes_ant12") > 0, 1, 0)

                monto = dr("monto_mes_ant1") + dr("monto_mes_ant2") + dr("monto_mes_ant3") + dr("monto_mes_ant4") + dr("monto_mes_ant5") + dr("monto_mes_ant6")
                monto += dr("monto_mes_ant7") + dr("monto_mes_ant8") + dr("monto_mes_ant9") + dr("monto_mes_ant10") + dr("monto_mes_ant11") + dr("monto_mes_ant12")
            ElseIf esTotal And dr("datos_extras") = False Then

                monto = dr("monto_mes1") + dr("monto_mes2") + dr("monto_mes3") + dr("monto_mes4") + dr("monto_mes5") + dr("monto_mes6")
                monto += dr("monto_mes7") + dr("monto_mes8") + dr("monto_mes9") + dr("monto_mes10") + dr("monto_mes11") + dr("monto_mes12")
            ElseIf esTotalAnt And dr("datos_extras") = False Then
                monto = dr("monto_mes_ant1") + dr("monto_mes_ant2") + dr("monto_mes_ant3") + dr("monto_mes_ant4") + dr("monto_mes_ant5") + dr("monto_mes_ant6")
                monto += dr("monto_mes_ant7") + dr("monto_mes_ant8") + dr("monto_mes_ant9") + dr("monto_mes_ant10") + dr("monto_mes_ant11") + dr("monto_mes_ant12")
            End If


            If capturas > 0 And dr("datos_extras") = True Then
                monto = monto / capturas
                If posicion = 1 Then
                    html.AppendLine("<span class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto, dr("datos_extras")) & "</span>")
                End If

                If posicion = 2 Then
                    If dr("es_porcentaje") = True Then
                        html.AppendLine("%")
                    End If
                End If
            ElseIf dr("datos_extras") = False Then
                If posicion = 1 Then
                    html.AppendLine("<span class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto, dr("datos_extras")) & "</span>")
                End If
            Else
                If posicion = 1 Then
                    html.AppendLine("<span class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(0, dr("datos_extras")) & "</span>")
                End If
                If posicion = 2 Then
                    If dr("es_porcentaje") = True Then
                        html.AppendLine("%")
                    End If
                End If

            End If

            If posicion = 2 Then
                If dr("datos_extras") = False Then
                    If esTotal And monto_base_anual(dato) <> 0 Then
                        html.AppendLine("<span class='rep2Porc" & IIf((monto / monto_base_anual(dato)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / monto_base_anual(dato)) * 100, dr("datos_extras")) & "</i></span>")
                    ElseIf esTotalAnt And monto_base_anual_ant(dato) <> 0 Then
                        html.AppendLine("<span class='rep2Porc" & IIf((monto / monto_base_anual_ant(dato)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / monto_base_anual_ant(dato)) * 100, dr("datos_extras")) & "</i></span>")
                    End If
                End If
            End If
        End If



        If dr("permite_captura") = False Then
            Return "<b>" & html.ToString & "</b>"
        Else
            Return html.ToString
        End If
    End Function

    Protected Function FormateaValorRep2Tots(dr As DataRow, tipo As Integer, posicion As Integer) As String
        Dim html As New StringBuilder("")
        Dim anio As Integer = Request.QueryString("a")
        Dim mes As Integer = Request.QueryString("m")

        Dim monto As Decimal
        Dim porcentaje As Decimal = 0
        If tipo = 1 Then
            monto = dr("monto_trim1") + dr("monto_trim2") + dr("monto_trim3") + dr("monto_trim4") - (dr("monto_trim_ant1") + dr("monto_trim_ant2") + dr("monto_trim_ant3") + dr("monto_trim_ant4"))
            If posicion = 1 Then
                html.AppendLine("<span class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
            End If
            'If dr("id") > 0 Then
            '    html.AppendLine("<span class='rep2Porc'><i>0</i></span>")
            'Else
            Dim monto_anio_ant As Decimal = dr("monto_trim_ant1") + dr("monto_trim_ant2") + dr("monto_trim_ant3") + dr("monto_trim_ant4")
            If monto_anio_ant <> 0 Then
                porcentaje = Math.Abs(monto / monto_anio_ant)
                If dr("monto_trim1") + dr("monto_trim2") + dr("monto_trim3") + dr("monto_trim4") < monto_anio_ant Then
                    porcentaje = porcentaje * -1
                End If

                If posicion = 2 Then
                    html.AppendLine("<span class='rep2Porc" & IIf(porcentaje < 0, " negativo", "") & "'><i>" & ifNullEmpty(porcentaje * 100) & "</i></span>")
                End If
            Else
                If posicion = 2 Then
                    html.AppendLine("<span class='rep2Porc'><i>--</i></span>")
                End If
                'End If
            End If
        ElseIf tipo = 2 Then
            If dr("id") = 1 Then monto_plan = PlanDistribucion(dr, mes, TipoValor.MesAcumulado)
            If dr("oculta_plan") = False Then
                monto = PlanDistribucion(dr, mes, TipoValor.MesAcumulado)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If

                If posicion = 2 Then
                    If monto_plan <> 0 Then
                        html.AppendLine("<span class='rep2Porc" & IIf((monto / monto_plan) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / monto_plan) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep2Porc'><i>--</i></span>")
                    End If
                End If
            End If
        ElseIf tipo = 3 Then
            If dr("oculta_plan") = False Then
                monto_real_menos_plan = PlanDistribucion(dr, mes, TipoValor.MesAcumulado)
                monto = (dr("monto_trim1") + dr("monto_trim2") + dr("monto_trim3") + dr("monto_trim4")) - (PlanDistribucion(dr, mes, TipoValor.MesAcumulado))
                If posicion = 1 Then
                    html.AppendLine("<span class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If monto_real_menos_plan <> 0 Then
                        html.AppendLine("<span class='rep2Porc" & IIf((monto / monto_real_menos_plan) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / monto_real_menos_plan) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep2Porc'><i>--</i></span>")
                    End If
                End If
            End If
        End If


        If dr("permite_captura") = False Then
            Return "<b>" & html.ToString & "</b>"
        Else
            Return html.ToString
        End If

    End Function

    Protected Function FormateaValorRepBalanceConsolidado(dr As DataRow, campo As String)
        Dim negativo As String = ""
        If Convert.ToDecimal(dr(campo).ToString()) < 0 Then
            negativo = "negativo"
        End If

        Return "<span class='" & negativo & "'>" & Convert.ToDecimal(dr(campo).ToString()).ToString("#,###,###,##0") & "</span>"
    End Function

    Dim rep3_monto(50) As Decimal
    Dim rep3_monto_ant(50) As Decimal
    Protected Function FormateaValorRep3(dr As DataRow, tipo As Integer, columna As Integer, posicion As Integer) As String
        Dim html As New StringBuilder("")
        Dim anio As Integer = Request.QueryString("a")
        Dim mes As Integer = Request.QueryString("m")

        Dim monto As Decimal = 0
        Dim porcentaje As Decimal = 0
        If tipo = 1 Then
            If columna = 1 Then
                If dr("id") = 1 Then rep3_monto(columna) = dr("monto_horn")
                monto = dr("monto_horn")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If dr("datos_extras") = False Then
                        If rep3_monto(columna) <> 0 Then
                            html.AppendLine("<span class='rep2Porc" & IIf((monto / rep3_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep3_monto(columna)) * 100) & "</i></span>")
                        Else
                            html.AppendLine("<span class='rep2Porc'><i>--</i></span>")
                        End If
                    End If
                End If

            ElseIf columna = 2 Then
                If dr("id") = 1 Then rep3_monto(columna) = dr("monto_horn_ant")
                monto = dr("monto_horn_ant")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If dr("datos_extras") = False Then
                        If rep3_monto(columna) <> 0 Then
                            html.AppendLine("<span class='rep2Porc" & IIf((monto / rep3_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep3_monto(columna)) * 100) & "</i></span>")
                        Else
                            html.AppendLine("<span class='rep2Porc'><i>--</i></span>")
                        End If
                    End If
                End If
            ElseIf columna = 3 Then
                If dr("datos_extras") = False Then
                    monto = dr("monto_horn") - (PlanDistribucion(dr, mes, TipoValor.MesAcumulado, "_horn"))
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                    End If
                End If
            ElseIf columna = 4 Then
                If dr("monto_horn_ant") <> 0 Then
                    porcentaje = Math.Abs((-1 + dr("monto_horn") / dr("monto_horn_ant")) * 100)
                    If dr("monto_horn") < dr("monto_horn_ant") Then
                        porcentaje = porcentaje * -1
                    End If

                    If posicion = 1 Then
                        html.AppendLine("<span class='rep2Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep2Dato'>--</span>")
                    End If
                End If
            End If

        ElseIf tipo = 2 Then
            If columna = 5 Then
                If dr("id") = 1 Then rep3_monto(columna) = dr("monto_fibr")
                monto = dr("monto_fibr")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If

                If posicion = 2 Then
                    If dr("datos_extras") = False Then
                        If rep3_monto(columna) <> 0 Then
                            html.AppendLine("<span class='rep2Porc" & IIf((monto / rep3_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep3_monto(columna)) * 100) & "</i></span>")
                        Else
                            html.AppendLine("<span class='rep2Porc'><i>--</i></span>")
                        End If
                    End If
                End If
            ElseIf columna = 6 Then
                If dr("id") = 1 Then rep3_monto(columna) = dr("monto_fibr_ant")
                monto = dr("monto_fibr_ant")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If

                If posicion = 2 Then
                    If dr("datos_extras") = False Then
                        If rep3_monto(columna) <> 0 Then
                            html.AppendLine("<span class='rep2Porc" & IIf((monto / rep3_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep3_monto(columna)) * 100) & "</i></span>")
                        Else
                            html.AppendLine("<span class='rep2Porc'><i>--</i></span>")
                        End If
                    End If
                End If
            ElseIf columna = 7 Then
                If dr("datos_extras") = False Then
                    monto = dr("monto_fibr") - (PlanDistribucion(dr, mes, TipoValor.MesAcumulado, "_fibr"))
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                    End If
                End If
            ElseIf columna = 8 Then
                If dr("monto_fibr_ant") <> 0 Then
                    porcentaje = Math.Abs((-1 + dr("monto_fibr") / dr("monto_fibr_ant")) * 100)
                    If dr("monto_fibr") < dr("monto_fibr_ant") Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep2Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep2Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 3 Then
            If columna = 9 Then
                If dr("id") = 1 Then rep3_monto(columna) = dr("monto_horn") + dr("monto_fibr") + dr("monto_corp") - dr("monto_resta_total")
                monto = dr("monto_horn") + dr("monto_fibr") + dr("monto_corp") - dr("monto_resta_total")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If

                If posicion = 2 Then
                    If dr("datos_extras") = False Then
                        If rep3_monto(columna) <> 0 Then
                            html.AppendLine("<span class='rep2Porc" & IIf((monto / rep3_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep3_monto(columna)) * 100) & "</i></span>")
                        Else
                            html.AppendLine("<span class='rep2Porc'><i>--</i></span>")
                        End If
                    End If
                End If
            ElseIf columna = 10 Then
                If dr("id") = 1 Then rep3_monto(columna) = dr("monto_horn_ant") + dr("monto_fibr_ant") + dr("monto_corp_ant") - dr("monto_resta_total_ant")
                monto = dr("monto_horn_ant") + dr("monto_fibr_ant") + dr("monto_corp_ant") - dr("monto_resta_total_ant")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep2Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If

                If posicion = 2 Then
                    If dr("datos_extras") = False Then
                        If rep3_monto(columna) <> 0 Then
                            html.AppendLine("<span class='rep2Porc" & IIf((monto / rep3_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep3_monto(columna)) * 100) & "</i></span>")
                        Else
                            html.AppendLine("<span class='rep2Porc'><i>--</i></span>")
                        End If
                    End If
                End If
            ElseIf columna = 11 Then
                If (dr("monto_fibr_ant") + dr("monto_horn_ant") + dr("monto_corp_ant") - dr("monto_resta_total_ant")) <> 0 Then
                    'monto = ((dr("monto_fibr") + dr("monto_horn") - dr("monto_resta_total")) / (dr("monto_fibr_ant") + dr("monto_horn_ant") - dr("monto_resta_total_ant")) - 1) * 100

                    porcentaje = Math.Abs(((dr("monto_fibr") + dr("monto_horn") + dr("monto_corp") - dr("monto_resta_total")) / (dr("monto_fibr_ant") + dr("monto_horn_ant") + dr("monto_corp_ant") - dr("monto_resta_total_ant")) - 1) * 100)
                    If (dr("monto_fibr") + dr("monto_horn") + dr("monto_corp") - dr("monto_resta_total")) < (dr("monto_fibr_ant") + dr("monto_horn_ant") + dr("monto_corp_ant") - dr("monto_resta_total_ant")) Then
                        porcentaje = porcentaje * -1
                    End If

                    If posicion = 1 Then
                        html.AppendLine("<span class='rep2Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep2Dato'>--</span>")
                    End If
                End If
            End If
        End If


        If dr("permite_captura") = False Then
            Return "<b>" & html.ToString & "</b>"
        Else
            Return html.ToString
        End If

    End Function



    Dim rep4_monto(50) As Decimal
    Dim rep4_monto_ant(50) As Decimal
    Protected Function FormateaValorRep4(dr As DataRow, tipo As Integer, columna As Integer, posicion As Integer) As String
        Dim html As New StringBuilder("")
        Dim anio As Integer = Request.QueryString("a")
        Dim mes As Integer = Request.QueryString("m")
        Dim porcentaje As Integer

        Dim monto As Decimal = 0
        If tipo = 1 Then
            If columna = 1 Then
                If dr("id") = 1 Then rep4_monto(columna) = dr("monto2")
                monto = dr("monto2")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep4_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep4_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep4_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 2 Then
                If dr("id") = 1 Then rep4_monto_ant(columna) = dr("monto_ant2")
                monto = dr("monto_ant2")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep4_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep4_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep4_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 3 Then
                If dr("monto_ant2") <> 0 Then
                    porcentaje = Math.Abs((-1 + dr("monto2") / dr("monto_ant2")) * 100)
                    If dr("monto2") < dr("monto_ant2") Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If

                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If

        ElseIf tipo = 2 Then
            If columna = 4 Then
                If dr("id") = 1 Then rep4_monto(columna) = dr("monto1")
                monto = dr("monto1")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep4_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep4_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep4_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 5 Then
                If dr("id") = 1 Then rep4_monto_ant(columna) = dr("monto_ant1")
                monto = dr("monto_ant1")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep4_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep4_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep4_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 6 Then
                If dr("monto_ant1") <> 0 Then
                    ''monto = (-1 + dr("monto1") / dr("monto_ant1")) * 100


                    porcentaje = Math.Abs((-1 + dr("monto1") / dr("monto_ant1")) * 100)
                    If dr("monto1") < dr("monto_ant1") Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 3 Then
            If columna = 7 Then
                If dr("id") = 1 Then rep4_monto(columna) = dr("monto3")
                monto = dr("monto3")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep4_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep4_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep4_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 8 Then
                If dr("id") = 1 Then rep4_monto_ant(columna) = dr("monto_ant3")
                monto = dr("monto_ant3")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep4_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep4_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep4_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 9 Then
                If dr("monto_ant3") <> 0 Then
                    'monto = (-1 + dr("monto3") / dr("monto_ant3")) * 100

                    porcentaje = Math.Abs((-1 + dr("monto3") / dr("monto_ant3")) * 100)
                    If dr("monto3") < dr("monto_ant3") Then
                        porcentaje = porcentaje * -1
                    End If

                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 4 Then
            If columna = 10 Then
                If dr("id") = 1 Then rep4_monto(columna) = dr("monto4")
                monto = dr("monto4")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep4_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep4_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep4_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 11 Then
                If dr("id") = 1 Then rep4_monto_ant(columna) = dr("monto_ant4")
                monto = dr("monto_ant4")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep4_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep4_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep4_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 12 Then
                If dr("monto_ant4") <> 0 Then
                    'monto = (-1 + dr("monto4") / dr("monto_ant4")) * 100


                    porcentaje = Math.Abs((-1 + dr("monto4") / dr("monto_ant4")) * 100)
                    If dr("monto4") < dr("monto_ant4") Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 5 Then
            If columna = 13 Then
                If dr("id") = 1 Then rep4_monto(columna) = dr("monto1") + dr("monto2") + dr("monto3") + dr("monto4")
                monto = dr("monto1") + dr("monto2") + dr("monto3") + dr("monto4")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep4_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep4_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep4_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 14 Then
                If dr("id") = 1 Then rep4_monto_ant(columna) = dr("monto_ant1") + dr("monto_ant2") + dr("monto_ant3") + dr("monto_ant4")
                monto = dr("monto_ant1") + dr("monto_ant2") + dr("monto_ant3") + dr("monto_ant4")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep4_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep4_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep4_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 15 Then
                If (dr("monto_ant1") + dr("monto_ant2") + dr("monto_ant3") + dr("monto_ant4")) <> 0 Then
                    'monto = (-1 + (dr("monto1") + dr("monto2") + dr("monto3") + dr("monto4")) / (dr("monto_ant1") + dr("monto_ant2") + dr("monto_ant3") + dr("monto_ant4"))) * 100

                    porcentaje = Math.Abs((-1 + (dr("monto1") + dr("monto2") + dr("monto3") + dr("monto4")) / (dr("monto_ant1") + dr("monto_ant2") + dr("monto_ant3") + dr("monto_ant4"))) * 100)
                    If (dr("monto1") + dr("monto2") + dr("monto3") + dr("monto4")) < (dr("monto_ant1") + dr("monto_ant2") + dr("monto_ant3") + dr("monto_ant4")) Then
                        porcentaje = porcentaje * -1
                    End If

                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        End If


        If dr("permite_captura") = False Then
            Return "<b>" & html.ToString & "</b>"
        Else
            Return html.ToString
        End If

    End Function




    Dim rep5_monto(500) As Decimal
    Dim rep5_monto_ant(500) As Decimal
    Protected Function FormateaValorRep5(dr As DataRow, tipo As Integer, columna As Integer, posicion As Integer) As String
        Dim html As New StringBuilder("")
        Dim anio As Integer = Request.QueryString("a")
        Dim mes As Integer = Request.QueryString("m")
        Dim porcentaje As Integer
        Dim monto As Decimal = 0
        If tipo = 1 Then
            If columna = 1 Then
                If dr("id") = 1 Then rep5_monto(columna) = dr("monto2")
                monto = dr("monto2")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 2 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto_ant2")
                monto = dr("monto_ant2")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 3 Then
                If dr("monto_ant2") <> 0 Then
                    'monto = (-1 + dr("monto2") / dr("monto_ant2")) * 100


                    porcentaje = Math.Abs((-1 + dr("monto2") / dr("monto_ant2")) * 100)
                    If dr("monto2") < dr("monto_ant2") Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If

        ElseIf tipo = 2 Then
            If columna = 4 Then
                If dr("id") = 1 Then rep5_monto(columna) = dr("monto1")
                monto = dr("monto1")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If

            ElseIf columna = 5 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto_ant1")
                monto = dr("monto_ant1")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If

            ElseIf columna = 6 Then
                If dr("monto_ant1") <> 0 Then
                    'monto = (-1 + dr("monto1") / dr("monto_ant1")) * 100

                    porcentaje = Math.Abs((-1 + dr("monto1") / dr("monto_ant1")) * 100)
                    If dr("monto1") < dr("monto_ant1") Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If

                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 105 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto1_plan")
                monto = dr("monto1_plan")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 106 Then
                If dr("monto1_plan") <> 0 Then
                    'monto = (-1 + dr("monto1") / dr("monto_ant1")) * 100

                    porcentaje = Math.Abs((-1 + dr("monto1") / dr("monto1_plan")) * 100)
                    If dr("monto1") < dr("monto1_plan") Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If

                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 3 Then
            If columna = 7 Then
                If dr("id") = 1 Then rep5_monto(columna) = dr("monto3")
                monto = dr("monto3")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 8 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto_ant3")
                monto = dr("monto_ant3")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 9 Then
                If dr("monto_ant3") <> 0 Then
                    'monto = (-1 + dr("monto3") / dr("monto_ant3")) * 100

                    porcentaje = Math.Abs((-1 + dr("monto3") / dr("monto_ant3")) * 100)
                    If dr("monto3") < dr("monto_ant3") Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 108 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto3_plan")
                monto = dr("monto3_plan")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 109 Then
                If dr("monto3_plan") <> 0 Then
                    'monto = (-1 + dr("monto3") / dr("monto_ant3")) * 100

                    porcentaje = Math.Abs((-1 + dr("monto3") / dr("monto3_plan")) * 100)
                    If dr("monto3") < dr("monto3_plan") Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 4 Then
            If columna = 10 Then
                If dr("id") = 1 Then rep5_monto(columna) = dr("monto4")
                monto = dr("monto4")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 11 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto_ant4")
                monto = dr("monto_ant4")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 12 Then
                If dr("monto_ant4") <> 0 Then
                    'monto = (-1 + dr("monto4") / dr("monto_ant4")) * 100

                    porcentaje = Math.Abs((-1 + dr("monto4") / dr("monto_ant4")) * 100)
                    If dr("monto4") < dr("monto_ant4") Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 111 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto4_plan")
                monto = dr("monto4_plan")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 112 Then
                If dr("monto4_plan") <> 0 Then
                    'monto = (-1 + dr("monto4") / dr("monto_ant4")) * 100

                    porcentaje = Math.Abs((-1 + dr("monto4") / dr("monto4_plan")) * 100)
                    If dr("monto4") < dr("monto4_plan") Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 5 Then
            If columna = 13 Then
                If dr("id") = 1 Then rep5_monto(columna) = dr("monto5")
                monto = dr("monto5")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 14 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto_ant5")
                monto = dr("monto_ant5")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 15 Then
                If dr("monto_ant5") <> 0 Then
                    'monto = (-1 + dr("monto5") / dr("monto_ant5")) * 100

                    porcentaje = Math.Abs((-1 + dr("monto5") / dr("monto_ant5")) * 100)
                    If dr("monto5") < dr("monto_ant5") Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 114 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto5_plan")
                monto = dr("monto5_plan")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 115 Then
                If dr("monto5_plan") <> 0 Then
                    'monto = (-1 + dr("monto5") / dr("monto_ant5")) * 100

                    porcentaje = Math.Abs((-1 + dr("monto5") / dr("monto5_plan")) * 100)
                    If dr("monto5") < dr("monto5_plan") Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 6 Then 'LB 20150805: Se agrego la empresa 12  
            If columna = 16 Then
                'If dr("id") = 1 Then rep5_monto(columna) = dr("monto1") + dr("monto2") + dr("monto3") + dr("monto4") + dr("monto5") + dr("monto6")
                'monto = dr("monto1") + dr("monto2") + dr("monto3") + dr("monto4") + dr("monto5") + dr("monto6")
                If dr("id") = 1 Then rep5_monto(columna) = dr("monto_tot")
                monto = dr("monto_tot")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 17 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto_tot_ant")
                monto = dr("monto_tot_ant")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 18 Then
                If (dr("monto_tot_ant")) <> 0 Then
                    porcentaje = Math.Abs((-1 + (dr("monto_tot")) / (dr("monto_tot_ant"))) * 100)
                    If (dr("monto_tot")) < (dr("monto_tot_ant")) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 117 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto_tot_plan")
                monto = dr("monto_tot_plan")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 118 Then
                If (dr("monto_tot_plan")) <> 0 Then
                    porcentaje = Math.Abs((-1 + (dr("monto_tot")) / (dr("monto_tot_plan"))) * 100)
                    If (dr("monto_tot")) < (dr("monto_tot_plan")) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 7 Then
            If columna = 19 Then
                If dr("id") = 1 Then rep5_monto(columna) = dr("monto6")
                monto = dr("monto6")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 20 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto_ant6")
                monto = dr("monto_ant6")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 21 Then
                If dr("monto_ant6") <> 0 Then
                    'monto = (-1 + dr("monto6") / dr("monto_ant6")) * 100

                    porcentaje = Math.Abs((-1 + dr("monto6") / dr("monto_ant6")) * 100)
                    If dr("monto6") < dr("monto_ant6") Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 120 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto6_plan")
                monto = dr("monto6_plan")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 121 Then
                If dr("monto6_plan") <> 0 Then
                    'monto = (-1 + dr("monto6") / dr("monto_ant6")) * 100

                    porcentaje = Math.Abs((-1 + dr("monto6") / dr("monto6_plan")) * 100)
                    If dr("monto6") < dr("monto6_plan") Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 8 Then
            'If columna = 22 Then
            '    If dr("id") = 1 Then rep5_monto(columna) = dr("monto1") + dr("monto2") + dr("monto6")
            '    monto = dr("monto1") + dr("monto2") + dr("monto6")
            '    If posicion = 1 Then
            '        html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
            '    End If
            '    If posicion = 2 Then
            '        If rep5_monto(columna) <> 0 Then
            '            html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto(columna)) * 100) & "</i></span>")
            '        Else
            '            html.AppendLine("<span class='rep4Dato'>--</span>")
            '        End If
            '    End If
            'ElseIf columna = 23 Then
            '    If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto_ant1") + dr("monto_ant2") + dr("monto_ant6")
            '    monto = dr("monto_ant1") + dr("monto_ant2") + dr("monto_ant6")
            '    If posicion = 1 Then
            '        html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
            '    End If
            '    If posicion = 2 Then
            '        If rep5_monto_ant(columna) <> 0 Then
            '            html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
            '        Else
            '            html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
            '        End If
            '    End If
            'ElseIf columna = 24 Then
            '    If (dr("monto_ant1") + dr("monto_ant2") + dr("monto_ant6")) <> 0 Then

            '        porcentaje = Math.Abs((-1 + (dr("monto1") + dr("monto2") + dr("monto6")) / (dr("monto_ant1") + dr("monto_ant2") + dr("monto_ant6"))) * 100)
            '        If (dr("monto1") + dr("monto2") + dr("monto6")) < (dr("monto_ant1") + dr("monto_ant2") + dr("monto_ant6")) Then
            '            porcentaje = porcentaje * -1
            '        End If
            '        If posicion = 1 Then
            '            html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
            '        End If
            '    Else
            '        If posicion = 1 Then
            '            html.AppendLine("<span class='rep4Dato'>--</span>")
            '        End If
            '    End If
            'End If

            If columna = 22 Then
                If dr("id") = 1 Then rep5_monto(columna) = dr("monto_tot_america")
                monto = dr("monto_tot_america")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 23 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto_tot_ant_america")
                monto = dr("monto_tot_ant_america")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 24 Then
                If (dr("monto_tot_ant_america")) <> 0 Then

                    porcentaje = Math.Abs((-1 + (dr("monto_tot_america")) / (dr("monto_tot_ant_america"))) * 100)
                    If (dr("monto_tot_america")) < (dr("monto_tot_ant_america")) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 123 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto_tot_plan_america")
                monto = dr("monto_tot_plan_america")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 124 Then
                If (dr("monto_tot_plan_america")) <> 0 Then

                    porcentaje = Math.Abs((-1 + (dr("monto_tot_america")) / (dr("monto_tot_plan_america"))) * 100)
                    If (dr("monto_tot_america")) < (dr("monto_tot_plan_america")) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 9 Then
            If columna = 25 Then
                If dr("id") = 1 Then rep5_monto(columna) = dr("monto1") + dr("monto2")
                monto = dr("monto1") + dr("monto2")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 26 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto_ant1") + dr("monto_ant2")
                monto = dr("monto_ant1") + dr("monto_ant2")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 27 Then
                If (dr("monto_ant1") + dr("monto_ant2")) <> 0 Then

                    porcentaje = Math.Abs((-1 + (dr("monto1") + dr("monto2")) / (dr("monto_ant1") + dr("monto_ant2"))) * 100)
                    If (dr("monto1") + dr("monto2")) < (dr("monto_ant1") + dr("monto_ant2")) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 10 Then
            If columna = 42 Then
                If dr("id") = 1 Then rep5_monto(columna) = dr("monto_tot_europa")
                monto = dr("monto_tot_europa")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 43 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto_tot_ant_europa")
                monto = dr("monto_tot_ant_europa")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 44 Then
                If (dr("monto_tot_ant_europa")) <> 0 Then

                    porcentaje = Math.Abs((-1 + (dr("monto_tot_europa")) / (dr("monto_tot_ant_europa"))) * 100)
                    If (dr("monto_tot_europa")) < (dr("monto_tot_ant_europa")) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 143 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto_tot_plan_europa")
                monto = dr("monto_tot_plan_europa")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 144 Then
                If (dr("monto_tot_plan_europa")) <> 0 Then

                    porcentaje = Math.Abs((-1 + (dr("monto_tot_europa")) / (dr("monto_tot_plan_europa"))) * 100)
                    If (dr("monto_tot_europa")) < (dr("monto_tot_plan_europa")) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 11 Then ' NPC
            If columna = 52 Then
                If dr("id") = 1 Then rep5_monto(columna) = dr("monto7")
                monto = dr("monto7")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If

            ElseIf columna = 53 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto_ant7")
                monto = dr("monto_ant7")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If

            ElseIf columna = 54 Then
                If dr("monto_ant7") <> 0 Then
                    'monto = (-1 + dr("monto1") / dr("monto_ant1")) * 100

                    porcentaje = Math.Abs((-1 + dr("monto7") / dr("monto_ant7")) * 100)
                    If dr("monto7") < dr("monto_ant7") Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If

                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 155 Then
                If dr("id") = 1 Then rep5_monto_ant(columna) = dr("monto7_plan")
                monto = dr("monto7_plan")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep5_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep5_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep5_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 156 Then
                If dr("monto7_plan") <> 0 Then
                    'monto = (-1 + dr("monto1") / dr("monto_ant1")) * 100

                    porcentaje = Math.Abs((-1 + dr("monto7") / dr("monto7_plan")) * 100)
                    If dr("monto7") < dr("monto1_plan") Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If

                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        End If


        If dr("permite_captura") = False Then
            Return "<b>" & html.ToString & "</b>"
        Else
            Return html.ToString
        End If

    End Function



    Dim rep27_monto(500) As Decimal
    Dim rep27_monto_ant(500) As Decimal
    Protected Function FormateaValorRep27(dr As DataRow, tipo As Integer, columna As Integer, posicion As Integer, sufijo As String) As String
        Dim html As New StringBuilder("")
        Dim anio As Integer = Request.QueryString("a")
        Dim mes As Integer = Request.QueryString("m")
        Dim porcentaje As Integer
        Dim monto As Decimal = 0
        Dim factor = IIf(sufijo = "_fibra", 100, IIf(sufijo = "_fv", 200, IIf(sufijo = "_sat", 300, IIf(sufijo = "_comercial", 400, 0))))
        If tipo = 1 Then
            If columna = 1 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto(columna) = dr("monto2" & sufijo)
                monto = dr("monto2" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 2 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto_ant(columna) = dr("monto_ant2" & sufijo)
                monto = dr("monto_ant2" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 3 Then
                columna = columna + factor
                If dr("monto_ant2" & sufijo) <> 0 Then
                    'monto = (-1 + dr("monto2") / dr("monto_ant2")) * 100


                    porcentaje = Math.Abs((-1 + dr("monto2" & sufijo) / dr("monto_ant2") & sufijo) * 100)
                    If dr("monto2" & sufijo) < dr("monto_ant2" & sufijo) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If

        ElseIf tipo = 2 Then
            'If columna = 4 Then
            '    columna = columna + factor
            '    If dr("id") = 1 Then rep27_monto(columna) = dr("monto1" & sufijo) + dr("monto2" & sufijo)
            '    monto = dr("monto1" & sufijo) + dr("monto2" & sufijo)
            '    If posicion = 1 Then
            '        html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
            '    End If
            '    If posicion = 2 Then
            '        If rep27_monto(columna) <> 0 Then
            '            html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto(columna)) * 100) & "</i></span>")
            '        Else
            '            html.AppendLine("<span class='rep4Dato'>--</span>")
            '        End If
            '    End If
            'ElseIf columna = 5 Then
            '    columna = columna + factor
            '    If dr("id") = 1 Then rep27_monto_ant(columna) = dr("monto_ant1" & sufijo) + dr("monto_ant2" & sufijo)
            '    monto = dr("monto_ant1" & sufijo) + dr("monto_ant2" & sufijo)
            '    If posicion = 1 Then
            '        html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
            '    End If
            '    If posicion = 2 Then
            '        If rep27_monto_ant(columna) <> 0 Then
            '            html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto_ant(columna)) * 100) & "</i></span>")
            '        Else
            '            html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
            '        End If
            '    End If
            'ElseIf columna = 6 Then
            '    columna = columna + factor
            '    If (dr("monto_ant1" & sufijo) + dr("monto_ant2" & sufijo)) <> 0 Then

            '        porcentaje = Math.Abs((-1 + (dr("monto1" & sufijo) + dr("monto2" & sufijo)) / (dr("monto_ant1" & sufijo) + dr("monto_ant2" & sufijo))) * 100)
            '        If (dr("monto1" & sufijo) + dr("monto2" & sufijo)) < (dr("monto_ant1" & sufijo) + dr("monto_ant2" & sufijo)) Then
            '            porcentaje = porcentaje * -1
            '        End If
            '        If posicion = 1 Then
            '            html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
            '        End If
            '    Else
            '        If posicion = 1 Then
            '            html.AppendLine("<span class='rep4Dato'>--</span>")
            '        End If
            '    End If
            'End If


            If columna = 4 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto(columna) = dr("monto1" & sufijo)
                monto = dr("monto1" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 5 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto_ant(columna) = dr("monto_ant1" & sufijo)
                monto = dr("monto_ant1" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 6 Then
                columna = columna + factor
                If (dr("monto_ant1" & sufijo)) <> 0 Then

                    porcentaje = Math.Abs((-1 + (dr("monto1" & sufijo)) / (dr("monto_ant1" & sufijo))) * 100)
                    If (dr("monto1" & sufijo)) < (dr("monto_ant1" & sufijo)) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If


        ElseIf tipo = 3 Then
            If columna = 7 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto(columna) = dr("monto3" & sufijo)
                monto = dr("monto3" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 8 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto_ant(columna) = dr("monto_ant3" & sufijo)
                monto = dr("monto_ant3" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 9 Then
                columna = columna + factor
                If dr("monto_ant3" & sufijo) <> 0 Then
                    'monto = (-1 + dr("monto3") / dr("monto_ant3")) * 100

                    porcentaje = Math.Abs((-1 + dr("monto3" & sufijo) / dr("monto_ant3" & sufijo)) * 100)
                    If dr("monto3" & sufijo) < dr("monto_ant3" & sufijo) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 4 Then
            If columna = 10 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto(columna) = dr("monto4" & sufijo)
                monto = dr("monto4" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 11 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto_ant(columna) = dr("monto_ant4" & sufijo)
                monto = dr("monto_ant4" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 12 Then
                columna = columna + factor
                If dr("monto_ant4" & sufijo) <> 0 Then
                    'monto = (-1 + dr("monto4") / dr("monto_ant4")) * 100

                    porcentaje = Math.Abs((-1 + dr("monto4" & sufijo) / dr("monto_ant4" & sufijo)) * 100)
                    If dr("monto4" & sufijo) < dr("monto_ant4" & sufijo) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 5 Then
            If columna = 13 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto(columna) = dr("monto5" & sufijo)
                monto = dr("monto5" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 14 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto_ant(columna) = dr("monto_ant5" & sufijo)
                monto = dr("monto_ant5" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 15 Then
                columna = columna + factor
                If dr("monto_ant5" & sufijo) <> 0 Then
                    'monto = (-1 + dr("monto5") / dr("monto_ant5")) * 100

                    porcentaje = Math.Abs((-1 + dr("monto5" & sufijo) / dr("monto_ant5" & sufijo)) * 100)
                    If dr("monto5" & sufijo) < dr("monto_ant5" & sufijo) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 6 Then 'LB 20150805: Se agrego la empresa 12  
            If columna = 16 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto(columna) = dr("monto_tot")
                monto = dr("monto_tot")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 17 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto_ant(columna) = dr("monto_tot_ant")
                monto = dr("monto_tot_ant")
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 18 Then
                columna = columna + factor
                If (dr("monto_tot_ant")) <> 0 Then
                    porcentaje = Math.Abs((-1 + (dr("monto_tot")) / (dr("monto_tot_ant"))) * 100)
                    If (dr("monto_tot")) < (dr("monto_tot_ant")) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 7 Then
            If columna = 19 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto(columna) = dr("monto6" & sufijo)
                monto = dr("monto6" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 20 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto_ant(columna) = dr("monto_ant6" & sufijo)
                monto = dr("monto_ant6" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 21 Then
                columna = columna + factor
                If dr("monto_ant6" & sufijo) <> 0 Then

                    porcentaje = Math.Abs((-1 + dr("monto6" & sufijo) / dr("monto_ant6" & sufijo)) * 100)
                    If dr("monto6" & sufijo) < dr("monto_ant6" & sufijo) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 8 Then
            If columna = 22 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto(columna) = dr("monto1" & sufijo) + dr("monto2" & sufijo) + dr("monto6" & sufijo)
                monto = dr("monto1" & sufijo) + dr("monto2" & sufijo) + dr("monto6" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 23 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto_ant(columna) = dr("monto_ant1" & sufijo) + dr("monto_ant2" & sufijo) + dr("monto_ant6" & sufijo)
                monto = dr("monto_ant1" & sufijo) + dr("monto_ant2" & sufijo) + dr("monto_ant6" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 24 Then
                columna = columna + factor
                If (dr("monto_ant1" & sufijo) + dr("monto_ant2" & sufijo) + dr("monto_ant6" & sufijo)) <> 0 Then

                    porcentaje = Math.Abs((-1 + (dr("monto1" & sufijo) + dr("monto2" & sufijo) + dr("monto6" & sufijo)) / (dr("monto_ant1" & sufijo) + dr("monto_ant2" & sufijo) + dr("monto_ant6" & sufijo))) * 100)
                    If (dr("monto1" & sufijo) + dr("monto2" & sufijo) + dr("monto6" & sufijo)) < (dr("monto_ant1" & sufijo) + dr("monto_ant2" & sufijo) + dr("monto_ant6" & sufijo)) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 9 Then
            If columna = 25 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto(columna) = dr("monto1" & sufijo) + dr("monto2" & sufijo)
                monto = dr("monto1" & sufijo) + dr("monto2" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 26 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto_ant(columna) = dr("monto_ant1" & sufijo) + dr("monto_ant2" & sufijo)
                monto = dr("monto_ant1" & sufijo) + dr("monto_ant2" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 27 Then
                columna = columna + factor
                If (dr("monto_ant1" & sufijo) + dr("monto_ant2" & sufijo)) <> 0 Then

                    porcentaje = Math.Abs((-1 + (dr("monto1" & sufijo) + dr("monto2" & sufijo)) / (dr("monto_ant1" & sufijo) + dr("monto_ant2" & sufijo))) * 100)
                    If (dr("monto1" & sufijo) + dr("monto2" & sufijo)) < (dr("monto_ant1" & sufijo) + dr("monto_ant2" & sufijo)) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 10 Then

            If columna = 28 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto(columna) = dr("monto1" & sufijo) + dr("monto3" & sufijo) + dr("monto4" & sufijo) + dr("monto5" & sufijo) + dr("monto6" & sufijo) + dr("monto7" & sufijo)
                monto = dr("monto1" & sufijo) + dr("monto3" & sufijo) + dr("monto4" & sufijo) + dr("monto5" & sufijo) + dr("monto6" & sufijo) + dr("monto7" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 29 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto_ant(columna) = dr("monto_ant1" & sufijo) + dr("monto_ant3" & sufijo) + dr("monto_ant4" & sufijo) + dr("monto_ant5" & sufijo) + dr("monto_ant6" & sufijo) + dr("monto_ant7" & sufijo)
                monto = dr("monto_ant1" & sufijo) + dr("monto_ant3" & sufijo) + dr("monto_ant4" & sufijo) + dr("monto_ant5" & sufijo) + dr("monto_ant6" & sufijo) + dr("monto_ant7" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 30 Then
                columna = columna + factor
                If (dr("monto_ant1" & sufijo) + dr("monto_ant3" & sufijo) + dr("monto_ant4" & sufijo) + dr("monto_ant5" & sufijo) + dr("monto_ant6" & sufijo) + dr("monto_ant7" & sufijo)) <> 0 Then

                    porcentaje = Math.Abs((-1 + (dr("monto1" & sufijo) + dr("monto3" & sufijo) + dr("monto4" & sufijo) + dr("monto5" & sufijo) + dr("monto6" & sufijo) + dr("monto7" & sufijo)) / (dr("monto_ant1" & sufijo) + dr("monto_ant3" & sufijo) + dr("monto_ant4" & sufijo) + dr("monto_ant5" & sufijo) + dr("monto_ant6" & sufijo) + dr("monto_ant7" & sufijo))) * 100)
                    If (dr("monto1" & sufijo) + dr("monto3" & sufijo) + dr("monto4" & sufijo) + dr("monto5" & sufijo) + dr("monto6" & sufijo) + dr("monto7" & sufijo)) < (dr("monto_ant1" & sufijo) + dr("monto_ant3" & sufijo) + dr("monto_ant4" & sufijo) + dr("monto_ant5" & sufijo) + dr("monto_ant6" & sufijo) + dr("monto_ant7" & sufijo)) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 11 Then

            If columna = 31 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto(columna) = dr("monto1" & sufijo) + dr("monto3" & sufijo) + dr("monto4" & sufijo) + dr("monto5" & sufijo) + dr("monto6" & sufijo)
                monto = dr("monto1" & sufijo) + dr("monto3" & sufijo) + dr("monto4" & sufijo) + dr("monto5" & sufijo) + dr("monto6" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 32 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto_ant(columna) = dr("monto_ant1" & sufijo) + dr("monto_ant3" & sufijo) + dr("monto_ant4" & sufijo) + dr("monto_ant5" & sufijo) + dr("monto_ant6" & sufijo)
                monto = dr("monto_ant1" & sufijo) + dr("monto_ant3" & sufijo) + dr("monto_ant4" & sufijo) + dr("monto_ant5" & sufijo) + dr("monto_ant6" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 33 Then
                columna = columna + factor
                If (dr("monto_ant1" & sufijo) + dr("monto_ant3" & sufijo) + dr("monto_ant4" & sufijo) + dr("monto_ant5" & sufijo) + dr("monto_ant6" & sufijo)) <> 0 Then

                    porcentaje = Math.Abs((-1 + (dr("monto1" & sufijo) + dr("monto3" & sufijo) + dr("monto4" & sufijo) + dr("monto5" & sufijo) + dr("monto6" & sufijo)) / (dr("monto_ant1" & sufijo) + dr("monto_ant3" & sufijo) + dr("monto_ant4" & sufijo) + dr("monto_ant5" & sufijo) + dr("monto_ant6" & sufijo))) * 100)
                    If (dr("monto1" & sufijo) + dr("monto3" & sufijo) + dr("monto4" & sufijo) + dr("monto5" & sufijo) + dr("monto6" & sufijo)) < (dr("monto_ant1" & sufijo) + dr("monto_ant3" & sufijo) + dr("monto_ant4" & sufijo) + dr("monto_ant5" & sufijo) + dr("monto_ant6" & sufijo)) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        ElseIf tipo = 12 Then
            If columna = 41 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto(columna) = dr("monto7" & sufijo)
                monto = dr("monto7" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            ElseIf columna = 42 Then
                columna = columna + factor
                If dr("id") = 1 Then rep27_monto_ant(columna) = dr("monto_ant7" & sufijo)
                monto = dr("monto_ant7" & sufijo)
                If posicion = 1 Then
                    html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "'>" & ifNullEmpty(monto) & "</span>")
                End If
                If posicion = 2 Then
                    If rep27_monto_ant(columna) <> 0 Then
                        html.AppendLine("<span class='rep4Porc" & IIf((monto / rep27_monto_ant(columna)) < 0, " negativo", "") & "'><i>" & ifNullEmpty((monto / rep27_monto_ant(columna)) * 100) & "</i></span>")
                    Else
                        html.AppendLine("<span class='rep4Porc'><i>--</i></span>")
                    End If
                End If
            ElseIf columna = 43 Then
                columna = columna + factor
                If dr("monto_ant7" & sufijo) <> 0 Then

                    porcentaje = Math.Abs((-1 + dr("monto7" & sufijo) / dr("monto_ant7" & sufijo)) * 100)
                    If dr("monto7" & sufijo) < dr("monto_ant7" & sufijo) Then
                        porcentaje = porcentaje * -1
                    End If
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato" & IIf(porcentaje < 0, " negativo", "") & "'>" & ifNullEmpty(porcentaje) & "</span>")
                    End If
                Else
                    If posicion = 1 Then
                        html.AppendLine("<span class='rep4Dato'>--</span>")
                    End If
                End If
            End If
        End If


        If dr("permite_captura") = False Then
            Return "<b>" & html.ToString & "</b>"
        Else
            Return html.ToString
        End If

    End Function





    Dim rep7_monto(50) As Decimal
    Protected Function FormateaValorRep7(dr As DataRow, columna As Integer, posicion As Integer) As String
        Dim html As New StringBuilder("")
        Dim anio As Integer = Request.QueryString("a")
        Dim mes As Integer = Request.QueryString("m")

        Dim monto As Decimal = 0
        Dim monto_tot As Decimal = 0
        If columna < 14 Then
            If dr("id") = 1 Then rep7_monto(columna) = dr("monto_tot" & columna)
            monto = dr("monto" & columna)
            monto_tot = dr("monto_tot" & columna)
            If posicion = 1 Then
                html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "' style='width:45px;'>" & ifNullEmpty(monto) & "</span>")
            End If
            If posicion = 2 Then
                If rep7_monto(columna) <> 0 Then
                    html.AppendLine("<span class='rep4Porc" & IIf(monto_tot < 0, " negativo", "") & "'><i>" & ifNullEmpty(monto_tot) & "</i></span>")
                Else
                    html.AppendLine("<span class='rep4Dato'>--</span>")
                End If
            End If
        ElseIf columna = 14 Then
            monto = dr("monto1") - dr("monto2")
            If posicion = 1 Then
                html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "' style='width:60px;'>" & ifNullEmpty(monto) & "</span>")
            End If
        End If

        If dr("permite_captura") = False Then
            Return "<b>" & html.ToString & "</b>"
        Else
            Return html.ToString
        End If

    End Function





    Protected Function FormateaValorRep7Resta(dr As DataRow, ultimo As Integer, penultimo As Integer) As String
        Dim html As New StringBuilder("")
        Dim anio As Integer = Request.QueryString("a")
        Dim mes As Integer = Request.QueryString("m")

        Dim monto As Decimal = 0
        Dim monto_tot As Decimal = 0

        monto = dr("monto" & ultimo) - dr("monto" & penultimo)
        html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "' style='width:60px;'>" & ifNullEmpty(monto) & "</span>")

        If dr("permite_captura") = False Then
            Return "<b>" & html.ToString & "</b>"
        Else
            Return html.ToString
        End If

    End Function


    Protected Function FormateaValorRep8(dr As DataRow, columna As Integer) As String
        Dim html As New StringBuilder("")
        Dim anio As Integer = Request.QueryString("a")
        Dim mes As Integer = Request.QueryString("m")

        Dim monto As Decimal = 0
        If columna = 0 Then
            monto = dr("monto_total")
        Else
            Dim nombre_columna As String = "monto_emp" & columna
            monto = dr(nombre_columna)
        End If
        html.AppendLine("<span class='rep4Dato" & IIf(monto < 0, " negativo", "") & "' style='width:45px;'>" & ifNullEmpty(monto) & "</span>")


        If dr("permite_captura") = False Then
            Return "<b>" & html.ToString & "</b>"
        Else
            Return html.ToString
        End If

    End Function



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


    Protected Function GraficaPerfilDeDeuda_Etiquetas(dt As DataTable) As String
        Dim etiquetas As String = ""
        For Each dr As DataRow In dt.Rows
            etiquetas &= Chr(39) & dr("anio").ToString() & Chr(39) & ","
        Next
        If etiquetas.Length > 0 Then etiquetas = etiquetas.Substring(0, etiquetas.Length - 1)
        Return etiquetas
    End Function

    Protected Function GraficaFacturacionNeta_Etiquetas(dt As DataTable) As String
        Dim etiquetas As String = ""
        For Each dr As DataRow In dt.Rows
            etiquetas &= Chr(39) & Right(dr("anio").ToString(), 2) & Chr(39) & ","
        Next
        If etiquetas.Length > 0 Then etiquetas = etiquetas.Substring(0, etiquetas.Length - 1)
        Return etiquetas
    End Function


    Protected Function GraficaFacturacionNeta_Plan(dt As DataTable) As String
        Dim plan As String = ""
        If dt.Rows.Count > 0 Then
            Return (dt.Rows(dt.Rows.Count - 1)("valor_plan2"))
        End If
        Return ""
    End Function

    Protected Function GraficaFacturacionNeta_DatosPlan(dt As DataTable) As String
        Dim valores As String = ""
        For Each dr As DataRow In dt.Rows
            If dr("valor_plan") = 0 Then
                valores &= "null,"
            Else
                valores &= dr("valor_plan").ToString() & ","
            End If
        Next
        If valores.Length > 0 Then valores = valores.Substring(0, valores.Length - 1)
        Return valores
    End Function

    Protected Function GraficaFacturacionNeta_DatosBarras(dt As DataTable) As String
        Dim valores As String = ""
        For Each dr As DataRow In dt.Rows
            valores &= dr("facturacion").ToString() & ","
        Next
        If valores.Length > 0 Then valores = valores.Substring(0, valores.Length - 1)
        Return valores
    End Function



    Protected Function GraficaPerfilDeDeuda_Plan(dt As DataTable) As String
        Dim plan As String = ""
        If dt.Rows.Count > 0 Then
            Return (dt.Rows(dt.Rows.Count - 1)("valor_mxp"))
        End If
        Return ""
    End Function

    Protected Function GraficaPerfilDeDeuda_DatosMXP(dt As DataTable) As String
        Dim valores As String = ""
        For Each dr As DataRow In dt.Rows
            If dr("valor_mxp") = 0 Then
                valores &= "null,"
            Else
                valores &= dr("valor_mxp").ToString() & ","
            End If
        Next
        If valores.Length > 0 Then valores = valores.Substring(0, valores.Length - 1)
        Return valores
    End Function

    Protected Function GraficaPerfilDeDeuda_DatosUSD(dt As DataTable) As String
        Dim valores As String = ""
        For Each dr As DataRow In dt.Rows
            If dr("valor_usd") = 0 Then
                valores &= "null,"
            Else
                valores &= dr("valor_usd").ToString() & ","
            End If
        Next
        If valores.Length > 0 Then valores = valores.Substring(0, valores.Length - 1)
        Return valores
    End Function

    Protected Function GraficaPerfilDeDeuda_DatosEUR(dt As DataTable) As String
        Dim valores As String = ""
        For Each dr As DataRow In dt.Rows
            valores &= dr("valor_eur").ToString() & ","
        Next
        If valores.Length > 0 Then valores = valores.Substring(0, valores.Length - 1)
        Return valores
    End Function


    Protected Function GraficaPerfilDeDeuda_DatosLinea(dt As DataTable) As String
        Dim valores As String = ""
        For Each dr As DataRow In dt.Rows
            If dr("valor_cpr") = 0 Then
                valores &= "null,"
            Else
                valores &= dr("valor_cpr").ToString() & ","
            End If
        Next
        If valores.Length > 0 Then valores = valores.Substring(0, valores.Length - 1)
        Return valores
    End Function

    Protected Function GraficaHeadcount_Datos(dt As DataTable, tipo As Integer) As String
        Dim valores As String = ""
        For Each dr As DataRow In dt.Rows
            If IsDBNull(dr("valor" & tipo)) Then
                valores &= "null,"
            Else
                valores &= dr("valor" & tipo).ToString() & ","
            End If
        Next
        If valores.Length > 0 Then valores = valores.Substring(0, valores.Length - 1)
        Return valores
    End Function


    Protected Function GraficaCostoNominas_Datos(dt As DataTable, tipo As Integer) As String
        Dim valores As String = ""
        For Each dr As DataRow In dt.Rows
            If IsDBNull(dr("valor" & tipo)) Then
                valores &= "null,"
            Else
                valores &= dr("valor" & tipo).ToString() & ","
            End If
        Next
        If valores.Length > 0 Then valores = valores.Substring(0, valores.Length - 1)
        Return valores
    End Function

    Protected Function GraficaUtilidadOpNominas_Datos(dt As DataTable, tipo As Integer) As String
        Dim valores As String = ""
        For Each dr As DataRow In dt.Rows
            If Not IsDBNull(dr("valor1")) Then
                If tipo = 0 Then

                    Dim anio As String = Request.QueryString("a")
                    If dr("periodo") = -3 Then
                        valores &= "'Cierre " & (anio - 4) & "',"
                    ElseIf dr("periodo") = -2 Then
                        valores &= "'Cierre " & (anio - 3) & "',"
                    ElseIf dr("periodo") = -1 Then
                        valores &= "'Cierre " & (anio - 2) & "',"
                    ElseIf dr("periodo") = 0 Then
                        valores &= "'Cierre Ant',"
                    Else
                        valores &= "'" & Left(NombrePeriodo(dr("periodo")).ToString(), 3) & "',"
                    End If
                Else
                        valores &= Format(dr("valor" & tipo), "###,##0.00") & ","
                    End If
                End If
        Next
        If valores.Length > 0 Then valores = valores.Substring(0, valores.Length - 1)
        Return valores
    End Function

    Protected Function GraficaFacturacionNeta_DatosLinea(dt As DataTable) As String
        Dim valores As String = ""
        For Each dr As DataRow In dt.Rows
            If dr("ut_op") = 0 Then
                valores &= "null,"
            Else
                valores &= dr("ut_op").ToString() & ","
            End If
        Next
        If valores.Length > 0 Then valores = valores.Substring(0, valores.Length - 1)
        Return valores
    End Function

    Protected Function GraficaFacturacionNeta_DatosLineaEbitda(dt As DataTable) As String
        Dim valores As String = ""
        For Each dr As DataRow In dt.Rows
            If dr("ebitda") = 0 Then
                valores &= "null,"
            Else
                valores &= dr("ebitda").ToString() & ","
            End If
        Next
        If valores.Length > 0 Then valores = valores.Substring(0, valores.Length - 1)
        Return valores
    End Function

    Protected Function GraficaFlujoEfectivo_Dato(dt As DataTable, dato As Integer) As String
        For Each dr As DataRow In dt.Rows
            If dr("orden") = dato Then
                Return dr("valor").ToString()
            End If
        Next
        Return "0"
    End Function

    Protected Function GraficaFlujoEfectivo_Dato2(dt As DataTable, dato As Integer) As Integer
        For Each dr As DataRow In dt.Rows
            If dr("id_concepto") = dato Then
                Return dr("monto_total").ToString()
            End If
        Next
        Return "0"
    End Function

End Class
Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports IntranetDA

''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' DevelTec.mx 
' Clase Generada Utilizando el Generador de Codigo DeveltecCodeGenerator
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Class Reporte
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Function RecuperaDatos(id_reporte As Integer, id_empresa As Integer, anio As Integer, periodo As Integer) As DataSet
        Try

            If id_reporte = 2999 Then
                id_reporte = 2
                anio = anio + 1000
            End If

            Dim sql As String = "recupera_reporte_datos"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("anio", anio)
            params(3) = New SqlParameter("periodo", periodo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaDatosExtra(id_reporte As Integer, id_empresa As Integer, anio As Integer, periodo As Integer) As DataSet
        Try
            Dim sql As String = "recupera_reporte_datos_extra"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("anio", anio)
            params(3) = New SqlParameter("periodo", periodo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaReporteDatosExtraBalanceGeneral(id_empresa As Integer, anio As Integer) As DataSet
        Try
            Dim sql As String = "reporte_ejecutivo_balance_general_datos_extra_individual"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("tipo", "")
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("anio", anio)
            params(3) = New SqlParameter("periodo", 12)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ReporteGastosNSEdoRes(anio As Integer, periodo As Integer, moneda As String) As DataTable
        Try
            Dim sql As String = "reporte_ejecutivo_3_gastos_ns"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("periodo", periodo)
            params(2) = New SqlParameter("moneda", moneda)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ReporteGastosNSCentroCosto(id_empresa As Integer, anio As Integer, moneda As String, id_empleado_consulta As Integer, mes As Integer) As DataSet
        Try
            Dim sql As String = "rep_gastos_ns_total_por_centro_costo"

            Dim params As SqlParameter() = New SqlParameter(4) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("anio", anio)
            params(2) = New SqlParameter("moneda", moneda)
            params(3) = New SqlParameter("id_empleado_consulta", id_empleado_consulta)
            params(4) = New SqlParameter("mes", mes)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ReporteGastosNSCuentaAcum(id_empresa As Integer, anio As Integer, moneda As String, id_empleado_consulta As Integer, mes As Integer) As DataSet
        Try
            Dim sql As String = "rep_gastos_ns_por_cuenta_acumulado"

            Dim params As SqlParameter() = New SqlParameter(4) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("anio", anio)
            params(2) = New SqlParameter("moneda", moneda)
            params(3) = New SqlParameter("id_empleado_consulta", id_empleado_consulta)
            params(4) = New SqlParameter("mes", mes)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ReporteGastosNSCuentaAcumTodo(id_empresa As Integer, anio As Integer, moneda As String, id_empleado_consulta As Integer, mes As Integer) As DataSet
        Try
            Dim sql As String = "rep_gastos_ns_por_cuenta_acumulado_todo"

            Dim params As SqlParameter() = New SqlParameter(4) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("anio", anio)
            params(2) = New SqlParameter("moneda", moneda)
            params(3) = New SqlParameter("id_empleado_consulta", id_empleado_consulta)
            params(4) = New SqlParameter("mes", mes)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ReporteGastosNSPorMes(id_empresa As Integer, anio As Integer, centro_costo As String, moneda As String, id_empleado_consulta As Integer) As DataSet
        Try
            Dim sql As String = "rep_gastos_ns_por_mes"

            Dim params As SqlParameter() = New SqlParameter(4) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("anio", anio)
            params(2) = New SqlParameter("centro_costo", centro_costo)
            params(3) = New SqlParameter("moneda", moneda)
            params(4) = New SqlParameter("id_empleado_consulta", id_empleado_consulta)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaReporteCuadreInter(id_reporte As Integer, id_empresa As Integer, anio As Integer, periodo As Integer) As DataSet
        Try
            Dim sql As String = "recupera_reporte_cuadre_inter"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("anio", anio)
            params(3) = New SqlParameter("periodo", periodo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaReporteCuadreInterMatriz(id_reporte As Integer, id_empresa As Integer, anio As Integer, periodo As Integer, operativa_fiscal As String) As DataSet
        Try
            Dim sql As String = "recupera_reporte_cuadre_inter_matriz"

            Dim params As SqlParameter() = New SqlParameter(4) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("anio", anio)
            params(3) = New SqlParameter("periodo", periodo)
            params(4) = New SqlParameter("operativa_fiscal", operativa_fiscal)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function ReporteSaldoVacaciones(id_empresa As Integer, id_empleado_usuario As Integer) As DataSet
        Try
            Dim sql As String = "rpt_saldo_vacaciones"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("id_empleado_usuario", id_empleado_usuario)


            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function ReporteMovimientosTarjetas(fecha_inicio As String, fecha_fin As String, id_empresa As Integer, _
                                       tipo As String, id_empleado_usuario As Integer, locale As String) As DataSet
        Try
            Dim sql As String = "reporte_movimientos_tarjetas"

            Dim params As SqlParameter() = New SqlParameter(7) {}
            params(0) = New SqlParameter("fecha_ini", fecha_inicio)
            params(1) = New SqlParameter("fecha_fin", fecha_fin)
            params(2) = New SqlParameter("id_empresa", id_empresa)
            params(3) = New SqlParameter("tipo", tipo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function ReporteAsignacionTarjetas(id_empresa As Integer, tipo As String, id_empleado_usuario As Integer, locale As String) As DataSet
        Try
            Dim sql As String = "reporte_asignacion_tarjetas"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("tipo", tipo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ReporteConciliacionVacaciones(id_empresa As Integer, id_empleado_usuario As Integer, solo_diferencias As Boolean) As DataSet
        Try
            Dim sql As String = "rpt_conciliacion_vacaciones"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("solo_diferencias", solo_diferencias)


            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ReporteDetalleSaldoVacaciones(id_empresa As Integer, id_empleado_usuario As Integer) As DataSet
        Try
            Dim sql As String = "rpt_detalle_saldo_vacaciones"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("id_empleado_usuario", id_empleado_usuario)


            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub GuardaDiasVacaciones(ByVal id_saldo As Integer, ByVal id_empleado As Integer, ByVal dias As Decimal, ByVal fecha As Date)
        Try
            Dim sql As String = "guarda_saldo_inicial_vacaciones"

            Dim params As SqlParameter() = New SqlParameter(4) {}
            params(0) = New SqlParameter("id_saldo", id_saldo)
            params(1) = New SqlParameter("id_empleado", id_empleado)
            params(2) = New SqlParameter("dias", dias)
            params(3) = New SqlParameter("fecha", fecha)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function ReporteDistribucionManual(id_reporte As Integer, anio As Integer, id_concepto As Integer) As DataTable
        Try
            Dim sql As String = "recupera_reporte_plan_distribucion"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)
            params(1) = New SqlParameter("anio", anio)
            params(2) = New SqlParameter("id_concepto", id_concepto)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaReporteBalanceAjustes(anio As Integer, periodo As Integer) As DataTable
        Try
            Dim sql As String = "reporte_balance_ajustes"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("periodo", periodo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function ReporteMaximosMinimos(id_empresa As Integer, anio As Integer, periodo As Integer) As DataTable
        Try
            Dim sql As String = "rpt_max_min"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("periodo", periodo)
            params(2) = New SqlParameter("id_empresa", id_empresa)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub GuardaDistribucionManual(id_reporte As Integer, id_empresa As Integer, anio As Integer, periodo As Integer, _
                                        id_concepto As Integer, tipo_distribucion As String, tipo As String, monto_1 As Integer, _
                                        monto_2 As Integer, monto_3 As Integer, monto_4 As Integer, monto_5 As Integer, monto_6 As Integer, _
                                        monto_7 As Integer, monto_8 As Integer, monto_9 As Integer, monto_10 As Integer, monto_11 As Integer, _
                                        monto_12 As Integer)
        Try
            Dim sql As String = "guarda_reporte_plan_distribucion"

            Dim params As SqlParameter() = New SqlParameter(18) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("anio", anio)
            params(3) = New SqlParameter("periodo", periodo)
            params(4) = New SqlParameter("id_concepto", id_concepto)
            params(5) = New SqlParameter("tipo_distribucion", tipo_distribucion)
            params(6) = New SqlParameter("tipo", tipo)
            params(7) = New SqlParameter("monto_1", monto_1)
            params(8) = New SqlParameter("monto_2", monto_2)
            params(9) = New SqlParameter("monto_3", monto_3)
            params(10) = New SqlParameter("monto_4", monto_4)
            params(11) = New SqlParameter("monto_5", monto_5)
            params(12) = New SqlParameter("monto_6", monto_6)
            params(13) = New SqlParameter("monto_7", monto_7)
            params(14) = New SqlParameter("monto_8", monto_8)
            params(15) = New SqlParameter("monto_9", monto_9)
            params(16) = New SqlParameter("monto_10", monto_10)
            params(17) = New SqlParameter("monto_11", monto_11)
            params(18) = New SqlParameter("monto_12", monto_12)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Sub EliminaDistribucionManual(id_reporte As Integer, id_empresa As Integer, anio As Integer, _
                                         periodo As Integer, id_concepto As Integer, tipo As String)
        Try

            Dim sql As String = "elimina_reporte_plan_distribucion"

            Dim params As SqlParameter() = New SqlParameter(5) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("anio", anio)
            params(3) = New SqlParameter("periodo", periodo)
            params(4) = New SqlParameter("id_concepto", id_concepto)
            params(5) = New SqlParameter("tipo", tipo)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function ReporteAccesos(fecha_inicio As String, fecha_fin As String) As DataTable
        Try
            Dim sql As String = "recupera_accesos_log"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("fecha_ini", fecha_inicio)
            params(1) = New SqlParameter("fecha_fin", fecha_fin)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ReporteSolicitudGastos(fecha_inicio As String, fecha_fin As String, id_empresa As Integer, _
                                           id_estatus As Integer, id_empleado As Integer, canceladas As Integer, _
                                           id_empleado_usuario As Integer, locale As String) As DataSet
        Try
            Dim sql As String = "rpt_solicitud_gastos"

            Dim params As SqlParameter() = New SqlParameter(7) {}
            params(0) = New SqlParameter("fecha_ini", fecha_inicio)
            params(1) = New SqlParameter("fecha_fin", fecha_fin)
            params(2) = New SqlParameter("id_empresa", id_empresa)
            params(3) = New SqlParameter("id_estatus", id_estatus)
            params(4) = New SqlParameter("id_empleado", id_empleado)
            params(5) = New SqlParameter("canceladas", canceladas)
            params(6) = New SqlParameter("id_empleado_usuario", id_empleado_usuario)
            params(7) = New SqlParameter("locale", locale)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ReporteSolicitudComprobacion(fecha_inicio As String, fecha_fin As String, id_empresa As Integer, id_empleado As Integer,
                                                 tipo_solicitud As String, elemento_pep As String, id_empleado_usuario As Integer) As DataSet
        Try
            Dim sql As String = "rpt_solicitud_comprobacion"

            Dim params As SqlParameter() = New SqlParameter(6) {}
            params(0) = New SqlParameter("fecha_ini", fecha_inicio)
            params(1) = New SqlParameter("fecha_fin", fecha_fin)
            params(2) = New SqlParameter("id_empresa", id_empresa)
            params(3) = New SqlParameter("id_empleado", id_empleado)
            params(4) = New SqlParameter("tipo_solicitud", tipo_solicitud)
            params(5) = New SqlParameter("elemento_pep", elemento_pep)
            params(6) = New SqlParameter("id_empleado_usuario", id_empleado_usuario)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ReporteSolicitudReposicion(fecha_inicio As String, fecha_fin As String, id_empresa As Integer, _
                                               id_estatus As Integer, id_empleado As Integer, canceladas As Integer, _
                                               id_empleado_usuario As Integer, locale As String) As DataSet
        Try
            Dim sql As String = "rpt_solicitud_reposicion"

            Dim params As SqlParameter() = New SqlParameter(7) {}
            params(0) = New SqlParameter("fecha_ini", fecha_inicio)
            params(1) = New SqlParameter("fecha_fin", fecha_fin)
            params(2) = New SqlParameter("id_empresa", id_empresa)
            params(3) = New SqlParameter("id_estatus", id_estatus)
            params(4) = New SqlParameter("id_empleado", id_empleado)
            params(5) = New SqlParameter("canceladas", canceladas)
            params(6) = New SqlParameter("id_empleado_usuario", id_empleado_usuario)
            params(7) = New SqlParameter("locale", locale)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ReporteSolicitudPermisos(fecha_inicio As String, fecha_fin As String, id_empresa As Integer, _
                                               id_estatus As Integer, id_empleado As Integer, canceladas As Integer, _
                                               id_empleado_usuario As Integer, locale As String) As DataSet
        Try
            Dim sql As String = "rpt_solicitud_permisos"

            Dim params As SqlParameter() = New SqlParameter(7) {}
            params(0) = New SqlParameter("fecha_ini", fecha_inicio)
            params(1) = New SqlParameter("fecha_fin", fecha_fin)
            params(2) = New SqlParameter("id_empresa", id_empresa)
            params(3) = New SqlParameter("id_estatus", id_estatus)
            params(4) = New SqlParameter("id_empleado", id_empleado)
            params(5) = New SqlParameter("canceladas", canceladas)
            params(6) = New SqlParameter("id_empleado_usuario", id_empleado_usuario)
            params(7) = New SqlParameter("locale", locale)


            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function ReporteSolicitudVacaciones(fecha_inicio As String, fecha_fin As String, id_empresa As Integer, _
                                               id_estatus As Integer, id_empleado As Integer, canceladas As Integer, _
                                               id_empleado_usuario As Integer, locale As String) As DataSet
        Try
            Dim sql As String = "rpt_solicitud_vacaciones"

            Dim params As SqlParameter() = New SqlParameter(7) {}
            params(0) = New SqlParameter("fecha_ini", fecha_inicio)
            params(1) = New SqlParameter("fecha_fin", fecha_fin)
            params(2) = New SqlParameter("id_empresa", id_empresa)
            params(3) = New SqlParameter("id_estatus", id_estatus)
            params(4) = New SqlParameter("id_empleado", id_empleado)
            params(5) = New SqlParameter("canceladas", canceladas)
            params(6) = New SqlParameter("id_empleado_usuario", id_empleado_usuario)
            params(7) = New SqlParameter("locale", locale)


            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaReporteEjecutivoPlan(anio As Integer) As DataTable
        Try
            Dim sql As String = "recupera_reporte_plan_distribucion"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_reporte", 6)
            params(1) = New SqlParameter("anio", anio)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaReporteEjecutivoGastosNSNegocio(anio As Integer, moneda As String, mes As Integer, id_usuario As Integer) As DataSet
        Try
            Dim params As SqlParameter() = New SqlParameter(3) {}

            Dim sql As String = ""
            sql = "recupera_gastos_ns_ejecutivo_negocio"

            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("moneda", moneda)
            params(2) = New SqlParameter("mes", mes)
            params(3) = New SqlParameter("id_empleado_consulta", id_usuario)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function RecuperaReporteEjecutivoGastosNS(anio As Integer, moneda As String, mes As Integer) As DataSet
        Try
            Dim params As SqlParameter() = New SqlParameter(2) {}

            Dim sql As String = ""
            sql = "recupera_gastos_ns_ejecutivo"

            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("moneda", moneda)
            params(2) = New SqlParameter("mes", mes)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaReporteEjecutivo(anio As Integer, periodo As Integer, tipo As String, Optional es_presentacion_fibras As Boolean = False, Optional es_presentacion_fibras_extendido As Boolean = False) As DataSet
        Try
            Dim params As SqlParameter() = New SqlParameter(5) {}

            Dim sql As String = ""
            If tipo = "C" Then
                sql = "recupera_reporte_ejecutivo"
            Else
                sql = "recupera_reporte_ejecutivo_empresa"
                params(2) = New SqlParameter("tipo", tipo)
                params(3) = New SqlParameter("es_presentacion_fibras", es_presentacion_fibras)
                params(4) = New SqlParameter("es_presentacion_fibras_extendido", es_presentacion_fibras_extendido)
            End If

            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("periodo", periodo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaReporteEjecutivo_ResumenOperativo(anio As Integer, periodo As Integer) As DataSet
        Try
            Dim params As SqlParameter() = New SqlParameter(2) {}

            Dim sql As String = ""
            sql = "reporte_ejecutivo_1"

            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("periodo", periodo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaReporte(id_reporte As Integer, id_empresa As Integer, anio As Integer) As DataSet
        Try
            Dim sql As String = "recupera_reporte_final"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("anio", anio)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaReporteSemanal(id_reporte As Integer, id_empresa As Integer, anio As Integer, periodo As Integer) As DataSet
        Try
            Dim sql As String = "recupera_reporte_final_semana"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("anio", anio)
            params(3) = New SqlParameter("periodo", periodo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaReporteNombre(id_reporte As Integer) As String
        Try
            Dim sql As String = "recupera_reporte_nombre"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0).Rows(0)("nombre")
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmpresaNombre(id_empresa As Integer) As String
        Try
            Dim sql As String = "recupera_empresa_nombre"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)

            Dim sqlHelp As New SqlHelper(_connString)
            Dim dt As DataTable = sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
            If dt.Rows.Count > 0 Then
                Return dt.Rows(0)("nombre")
            Else
                Return ""
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmpleadoNombre(id_empleado As Integer) As String
        Try
            Dim sql As String = "recupera_empleado_nombre"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)
            Dim dt As DataTable = sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
            If dt.Rows.Count > 0 Then
                Return dt.Rows(0)("nombre")
            Else
                Return ""
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function RecuperaEmpleadoNombreTelefono(id_empleado As String) As String
        Try
            Dim sql As String = "recupera_empleado_nombre_telcel"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)
            Dim dt As DataTable = sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
            If dt.Rows.Count > 0 Then
                Return dt.Rows(0)("nombre")
            Else
                Return ""
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEstatusGastosViajeNombre(id_estatus As Integer) As String
        Try
            Dim sql As String = "recupera_solicitud_gastos_estatus_nombre"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_estatus", id_estatus)

            Dim sqlHelp As New SqlHelper(_connString)
            Dim dt As DataTable = sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
            If dt.Rows.Count > 0 Then
                Return dt.Rows(0)("descripcion")
            Else
                Return ""
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub GuardaDatosPlan(ByRef listaDatos As ArrayList, _
                                id_empresa As Integer, _
                                id_reporte As Integer, _
                                anio As Integer, _
                                periodo As Integer, _
                                id_empleado As Integer)

        If id_reporte = 2999 Then
            id_reporte = 2
            anio = anio + 1000
        End If

        Try

            Dim sqlHelp As New SqlHelperTrans(_connString)
            Dim sql As String = "elimina_reporte_captura"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("anio", anio)
            params(3) = New SqlParameter("periodo", periodo)
            sqlHelp.ExecuteNonQuery(sql, params)


            sql = "guarda_reporte_captura_encabezado"
            params = New SqlParameter(5) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("anio", anio)
            params(3) = New SqlParameter("periodo", periodo)
            params(4) = New SqlParameter("id_empleado", id_empleado)
            params(5) = New SqlParameter("comentarios", "")
            sqlHelp.ExecuteNonQuery(sql, params)


            sql = "guarda_reporte_captura"
            For Each rd As ReporteDatos In listaDatos

                If rd.Importe10 > 0 Or rd.Importe11 > 0 Then
                    params = New SqlParameter(16) {}
                    params(0) = New SqlParameter("id_reporte", id_reporte)
                    params(1) = New SqlParameter("id_empresa", id_empresa)
                    params(2) = New SqlParameter("anio", anio)
                    params(3) = New SqlParameter("periodo", periodo)
                    params(4) = New SqlParameter("id_concepto", rd.Id_concepto)
                    params(5) = New SqlParameter("monto1", rd.Importe1)
                    params(6) = New SqlParameter("monto2", rd.Importe2)
                    params(7) = New SqlParameter("monto3", rd.Importe3)
                    params(8) = New SqlParameter("monto4", rd.Importe4)
                    params(9) = New SqlParameter("monto5", rd.Importe5)
                    params(10) = New SqlParameter("monto6", rd.Importe6)
                    params(11) = New SqlParameter("monto7", rd.Importe7)
                    params(12) = New SqlParameter("monto8", rd.Importe8)
                    params(13) = New SqlParameter("monto9", rd.Importe9)
                    params(14) = New SqlParameter("monto10", rd.Importe10)
                    params(15) = New SqlParameter("monto11", rd.Importe11)
                    params(16) = New SqlParameter("monto_real_mes_ant", 0)
                Else
                    params = New SqlParameter(14) {}
                    params(0) = New SqlParameter("id_reporte", id_reporte)
                    params(1) = New SqlParameter("id_empresa", id_empresa)
                    params(2) = New SqlParameter("anio", anio)
                    params(3) = New SqlParameter("periodo", periodo)
                    params(4) = New SqlParameter("id_concepto", rd.Id_concepto)
                    params(5) = New SqlParameter("monto1", rd.Importe1)
                    params(6) = New SqlParameter("monto2", rd.Importe2)
                    params(7) = New SqlParameter("monto3", rd.Importe3)
                    params(8) = New SqlParameter("monto4", rd.Importe4)
                    params(9) = New SqlParameter("monto5", rd.Importe5)
                    params(10) = New SqlParameter("monto6", rd.Importe6)
                    params(11) = New SqlParameter("monto7", rd.Importe7)
                    params(12) = New SqlParameter("monto8", rd.Importe8)
                    params(13) = New SqlParameter("monto9", rd.Importe9)
                    params(14) = New SqlParameter("monto_real_mes_ant", 0)
                End If

                sqlHelp.ExecuteDataAdapter(sql, params)
            Next

            sql = "reporte_calculos_totales"
            params = New SqlParameter(4) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("anio", anio)
            params(3) = New SqlParameter("periodo", periodo)
            params(4) = New SqlParameter("tipo", 3)
            sqlHelp.ExecuteNonQuery(sql, params)

            sqlHelp.CloseConnection()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub GuardaDatos(ByRef listaDatos As ArrayList, _
                                tipo As Integer, _
                                id_empresa As Integer, _
                                id_reporte As Integer, _
                                anio As Integer, _
                                periodo As Integer, _
                                id_empleado As Integer, _
                                comentarios As String)
        Try
            If id_empresa = 0 Then
                id_empresa = -1
            End If
            Dim sqlHelp As New SqlHelperTrans(_connString)
            Dim sql As String = "elimina_reporte_captura"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("anio", anio)
            params(3) = New SqlParameter("periodo", periodo)
            sqlHelp.ExecuteNonQuery(sql, params)


            sql = "guarda_reporte_captura_encabezado"
            params = New SqlParameter(5) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("anio", anio)
            params(3) = New SqlParameter("periodo", periodo)
            params(4) = New SqlParameter("id_empleado", id_empleado)
            params(5) = New SqlParameter("comentarios", comentarios)
            sqlHelp.ExecuteNonQuery(sql, params)


            sql = "guarda_reporte_captura"
            If tipo = 1 Then
                For Each rd As ReporteDatos In listaDatos
                    params = New SqlParameter(5) {}
                    params(0) = New SqlParameter("id_reporte", id_reporte)
                    params(1) = New SqlParameter("id_empresa", id_empresa)
                    params(2) = New SqlParameter("anio", anio)
                    params(3) = New SqlParameter("periodo", periodo)
                    params(4) = New SqlParameter("id_concepto", rd.Id_concepto)
                    params(5) = New SqlParameter("monto", rd.Importe)
                    sqlHelp.ExecuteDataAdapter(sql, params)
                Next
            Else
                For Each rd As ReporteDatos In listaDatos
                    params = New SqlParameter(16) {}
                    params(0) = New SqlParameter("id_reporte", id_reporte)
                    params(1) = New SqlParameter("id_empresa", id_empresa)
                    params(2) = New SqlParameter("anio", anio)
                    params(3) = New SqlParameter("periodo", periodo)
                    params(4) = New SqlParameter("id_concepto", rd.Id_concepto)
                    params(5) = New SqlParameter("monto1", rd.Importe1)
                    params(6) = New SqlParameter("monto2", rd.Importe2)
                    params(7) = New SqlParameter("monto3", rd.Importe3)
                    params(8) = New SqlParameter("monto4", rd.Importe4)
                    params(9) = New SqlParameter("monto5", rd.Importe5)
                    params(10) = New SqlParameter("monto6", rd.Importe6)
                    params(11) = New SqlParameter("monto7", rd.Importe7)
                    params(12) = New SqlParameter("monto8", rd.Importe8)
                    params(13) = New SqlParameter("monto9", rd.Importe9)
                    params(14) = New SqlParameter("monto10", rd.Importe10)
                    params(15) = New SqlParameter("monto11", rd.Importe11)
                    params(16) = New SqlParameter("monto_real_mes_ant", rd.Importe_real_ma)
                    sqlHelp.ExecuteDataAdapter(sql, params)
                Next
            End If

            sql = "reporte_calculos_totales"
            params = New SqlParameter(4) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("anio", anio)
            params(3) = New SqlParameter("periodo", periodo)
            params(4) = New SqlParameter("tipo", tipo)
            sqlHelp.ExecuteNonQuery(sql, params)

            sqlHelp.CloseConnection()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function ReporteRecibosNomina(id_empresa As Integer, anio As Integer, periodo As Integer) As DataTable
        Try
            Dim sql As String = "rep_recibos_nomina"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("anio", anio)
            params(2) = New SqlParameter("periodo", periodo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


#Region "REPORTE_EJECUTIVO_COMENTARIOS"


    Public Sub GuardaReporteEjecutivoComentarios(tipo As String, anio As Integer, periodo As Integer, minuta_junta_anterior As String, _
                                                 resumen_ejecutivo As String, grafica_flujo_efectivo As String)
        Try
            Dim sql As String = "guarda_reporte_ejecutivo_comentarios"

            Dim params As SqlParameter() = New SqlParameter(5) {}
            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("periodo", periodo)
            params(2) = New SqlParameter("minuta_junta_anterior", minuta_junta_anterior)
            params(3) = New SqlParameter("resumen_ejecutivo", resumen_ejecutivo)
            params(4) = New SqlParameter("grafica_flujo_efectivo", grafica_flujo_efectivo)
            params(5) = New SqlParameter("tipo", tipo)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Sub GuardaReporteEjecutivoComentariosArchivo(anio As Integer, periodo As Integer, tipo As String, archivo As String)
        Try
            Dim sql As String = "guarda_reporte_ejecutivo_comentarios_archivo"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("periodo", periodo)
            params(2) = New SqlParameter("archivo", archivo)
            params(3) = New SqlParameter("tipo", tipo)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Function RecuperaReporteEjecutivoComentarios(anio As Integer, periodo As Integer, tipo As String) As DataTable
        Try
            Dim sql As String = "recupera_reporte_ejecutivo_comentarios"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("periodo", periodo)
            params(2) = New SqlParameter("tipo", tipo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaReporteEjecutivoComentariosArchivo(anio As Integer, periodo As Integer, tipo As String) As DataTable
        Try
            Dim sql As String = "recupera_reporte_ejecutivo_comentarios_archivo"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("periodo", periodo)
            params(2) = New SqlParameter("tipo", tipo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function




    Public Function ReporteGastosPorConcepto(id_empresa As Integer, anio As Integer, agrupar As Integer) As DataTable
        Try
            Dim sql As String = "rpt_solicitud_gastos_por_concepto"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("anio", anio)
            params(2) = New SqlParameter("agrupar", agrupar)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function ReporteGastosPorCentroCosto(id_empresa As Integer, anio As Integer, modo As String) As DataTable
        Try
            Dim sql As String = "rpt_solicitud_gastos_por_centro_costo"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("anio", anio)
            params(2) = New SqlParameter("modo", modo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function ReporteGastosPorEmpleado(id_empresa As Integer, id_empleado As Integer, anio As Integer) As DataSet
        Try
            Dim sql As String = "rpt_solicitud_gastos_por_empleado"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("id_empleado", id_empleado)
            params(2) = New SqlParameter("anio", anio)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function ReporteArrendamientoInventario(id_empresa As Integer, id_categoria As Integer) As DataTable
        Try
            Dim sql As String = "rep_arrendamiento_inventario"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("id_categoria", id_categoria)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ValidaCapturaReporte(id_reporte As Integer, id_empresa As Integer, anio As Integer, periodo As Integer) As String
        Try
            Dim sql As String = "valida_permiso_para_capturar_reporte_financiero"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("anio", anio)
            params(3) = New SqlParameter("periodo", periodo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0).Rows(0)("respuesta")
        Catch ex As Exception
            Throw ex
        End Try
    End Function



#End Region

End Class




Public Class ReporteDatos
    Private _tipo As Integer
    Private _id_concepto As Integer
    Private _importe As Decimal
    Private _importe1 As Integer
    Private _importe2 As Integer
    Private _importe3 As Integer
    Private _importe4 As Integer
    Private _importe5 As Integer
    Private _importe6 As Integer
    Private _importe7 As Integer
    Private _importe8 As Integer
    Private _importe9 As Integer
    Private _importe10 As Integer
    Private _importe11 As Integer
    Private _importe_real_ma As Integer

    Sub New(tipo As Integer, id_concepto As Integer, importe As Decimal)
        _tipo = tipo
        _id_concepto = id_concepto
        _importe = importe
    End Sub

    Sub New(tipo As Integer, id_concepto As Integer, importe1 As Integer, importe2 As Integer, importe3 As Integer, importe4 As Integer, importe5 As Integer, importe6 As Integer, importe_real_ma As Integer)
        _tipo = tipo
        _id_concepto = id_concepto
        _importe1 = importe1
        _importe2 = importe2
        _importe3 = importe3
        _importe4 = importe4
        _importe5 = importe5
        _importe6 = importe6
        _importe_real_ma = importe_real_ma
    End Sub

    Sub New(tipo As Integer, id_concepto As Integer, importe1 As Integer, importe2 As Integer, importe3 As Integer, _
            importe4 As Integer, importe5 As Integer, importe6 As Integer, importe7 As Integer, importe8 As Integer, _
            importe9 As Integer, importe10 As Integer, importe11 As Integer, importe_real_ma As Integer)
        _tipo = tipo
        _id_concepto = id_concepto
        _importe1 = importe1
        _importe2 = importe2
        _importe3 = importe3
        _importe4 = importe4
        _importe5 = importe5
        _importe6 = importe6
        _importe7 = importe7
        _importe8 = importe8
        _importe9 = importe9
        _importe10 = importe10
        _importe11 = importe11
        _importe_real_ma = importe_real_ma
    End Sub

    Public Property Id_concepto() As Integer
        Get
            Return _id_concepto
        End Get
        Private Set(ByVal value As Integer)
            _id_concepto = value
        End Set
    End Property

    Public Property Importe() As Decimal
        Get
            Return _importe
        End Get
        Private Set(ByVal value As Decimal)
            _importe = value
        End Set
    End Property

    Public Property Importe1() As Integer
        Get
            Return _importe1
        End Get
        Private Set(ByVal value As Integer)
            _importe1 = value
        End Set
    End Property

    Public Property Importe2() As Integer
        Get
            Return _importe2
        End Get
        Private Set(ByVal value As Integer)
            _importe2 = value
        End Set
    End Property

    Public Property Importe3() As Integer
        Get
            Return _importe3
        End Get
        Private Set(ByVal value As Integer)
            _importe3 = value
        End Set
    End Property

    Public Property Importe4() As Integer
        Get
            Return _importe4
        End Get
        Private Set(ByVal value As Integer)
            _importe4 = value
        End Set
    End Property

    Public Property Importe5() As Integer
        Get
            Return _importe5
        End Get
        Private Set(ByVal value As Integer)
            _importe5 = value
        End Set
    End Property

    Public Property Importe6() As Integer
        Get
            Return _importe6
        End Get
        Private Set(ByVal value As Integer)
            _importe6 = value
        End Set
    End Property

    Public Property Importe7() As Integer
        Get
            Return _importe7
        End Get
        Private Set(ByVal value As Integer)
            _importe7 = value
        End Set
    End Property

    Public Property Importe8() As Integer
        Get
            Return _importe8
        End Get
        Private Set(ByVal value As Integer)
            _importe8 = value
        End Set
    End Property

    Public Property Importe9() As Integer
        Get
            Return _importe9
        End Get
        Private Set(ByVal value As Integer)
            _importe9 = value
        End Set
    End Property

    Public Property Importe10() As Integer
        Get
            Return _importe10
        End Get
        Private Set(ByVal value As Integer)
            _importe10 = value
        End Set
    End Property

    Public Property Importe11() As Integer
        Get
            Return _importe11
        End Get
        Private Set(ByVal value As Integer)
            _importe11 = value
        End Set
    End Property

    Public Property Importe_real_ma() As Integer
        Get
            Return _importe_real_ma
        End Get
        Private Set(ByVal value As Integer)
            _importe_real_ma = value
        End Set
    End Property



End Class

Public Class ReporteCierre

    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub

    Public Function GuardaCierre(ByVal id_detalle As Integer, ByVal anio As Integer, ByVal mes As Integer,
                                 ByVal estatus As String, ByVal id_usuario As Integer, ByVal id_empresa As Integer) As Integer
        Try
            Dim sql As String = "guarda_reporte_financiero_cierres"

            Dim params As SqlParameter() = New SqlParameter(6) {}
            params(0) = New SqlParameter("id_detalle", id_detalle)
            params(1) = New SqlParameter("anio", anio)
            params(2) = New SqlParameter("mes", mes)
            params(3) = New SqlParameter("estatus", estatus)
            params(4) = New SqlParameter("id_usuario", id_usuario)
            params(5) = New SqlParameter("id_empresa", id_empresa)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Recupera(anio As Integer, periodo As Integer) As DataTable
        Try
            Dim sql As String = "recupera_reporte_financiero_cierres"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("periodo", periodo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub ActualizaEstatus(id_detalle As Integer, estatus As String, id_usuario As Integer)
        Try
            Dim sql As String = "actualiza_reporte_financiero_cierres"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_detalle", id_detalle)
            params(1) = New SqlParameter("estatus", estatus)
            params(2) = New SqlParameter("id_usuario", id_usuario)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub



End Class
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
Public Class SolicitudCancelacionVacacion
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub



    Public Function Recupera(ByVal id_usuario As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_cancelacion_vacaciones"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_usuario", id_usuario)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaSolicitudVacacionesParaCancelar(ByVal id_empleado As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitudes_vacaciones_para_cancelacion"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaSolicitudVacacionesDiasParaCancelar(ByVal id_solicitud As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_cancelacion_vacaciones_dias"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    'Public Function RecuperaConceptosDesc(id_solicitud As Integer) As DataSet
    '    Try
    '        Dim sql As String = "recupera_solicitud_cancelacion_vacaciones_detalle_desc"

    '        Dim params As SqlParameter() = New SqlParameter(0) {}
    '        params(0) = New SqlParameter("id_solicitud", id_solicitud)

    '        Dim sqlHelp As New SqlHelper(_connString)

    '        Return sqlHelp.ExecuteDataAdapter(sql, params)
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Function



    Public Sub CambiaEstatusMail(id_solicitud As Integer, id_empleado As Integer, tipo As Integer, valor As Boolean)
        Try
            Dim sql As String = "guarda_solicitud_cancelacion_vacaciones_autorizacion_mail"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("id_empleado", id_empleado)
            params(2) = New SqlParameter("tipo", tipo)
            params(3) = New SqlParameter("valor", valor)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub



    Public Sub GuardaMotivoRechazo(id_solicitud As Integer, motivo As String)
        Try
            Dim sql As String = "guarda_solicitud_cancelacion_vacaciones_motivo_rechazo"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("motivo", motivo)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    'Public Function RecuperaVencimientosVacaciones(id_empleado_filtro As Integer, id_empresa_filtro As Integer, _
    '                                               id_empleado_usuario As Integer, dias_proximos As Integer) As DataSet
    '    Try
    '        Dim sql As String = "recupera_vencimientos_vacaciones"

    '        Dim params As SqlParameter() = New SqlParameter(3) {}
    '        params(0) = New SqlParameter("id_empleado_filtro", id_empleado_filtro)
    '        params(1) = New SqlParameter("id_empresa_filtro", id_empresa_filtro)
    '        params(2) = New SqlParameter("id_empleado_usuario", id_empleado_usuario)
    '        params(3) = New SqlParameter("dias_proximos", dias_proximos)

    '        Dim sqlHelp As New SqlHelper(_connString)
    '        Return sqlHelp.ExecuteDataAdapter(sql, params)
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Function

    'Public Function ReporteVacacionesVencidas(id_empleado_filtro As Integer, id_empresa_filtro As Integer, _
    '                                               id_empleado_usuario As Integer, fecha_ini As String, fecha_fin As String) As DataSet
    '    Try
    '        Dim sql As String = "rep_vacaciones_vencidas"

    '        Dim params As SqlParameter() = New SqlParameter(4) {}
    '        params(0) = New SqlParameter("id_empleado_filtro", id_empleado_filtro)
    '        params(1) = New SqlParameter("id_empresa_filtro", id_empresa_filtro)
    '        params(2) = New SqlParameter("id_empleado_usuario", id_empleado_usuario)
    '        params(3) = New SqlParameter("fecha_ini", fecha_ini)
    '        params(4) = New SqlParameter("fecha_fin", fecha_fin)

    '        Dim sqlHelp As New SqlHelper(_connString)
    '        Return sqlHelp.ExecuteDataAdapter(sql, params)
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Function

    'Public Function DiasDisponibles(id_empleado As Integer) As Decimal
    '    Try
    '        Dim sql As String = "recupera_vacaciones_disponibles"

    '        Dim params As SqlParameter() = New SqlParameter(0) {}
    '        params(0) = New SqlParameter("id_empleado", id_empleado)

    '        Dim sqlHelp As New SqlHelper(_connString)

    '        Return sqlHelp.ExecuteScalar(sql, params)
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Function

    'Public Function DiasEnProceso(id_empleado As Integer) As Decimal
    '    Try
    '        Dim sql As String = "recupera_vacaciones_en_proceso"

    '        Dim params As SqlParameter() = New SqlParameter(0) {}
    '        params(0) = New SqlParameter("id_empleado", id_empleado)

    '        Dim sqlHelp As New SqlHelper(_connString)

    '        Return sqlHelp.ExecuteScalar(sql, params)
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Function

    Public Sub CambiaEstatus(id_solicitud As Integer, id_empleado As Integer, tipo As Integer, valor As Boolean)
        Try
            Dim sql As String = "guarda_solicitud_cancelacion_vacaciones_autorizacion"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("id_empleado", id_empleado)
            params(2) = New SqlParameter("tipo", tipo)
            params(3) = New SqlParameter("valor", valor)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function RecuperaAuth(ByVal id_usuario As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_cancelacion_vacaciones_auth1"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_usuario", id_usuario)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaRealizado(ByVal id_usuario As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_cancelacion_vacaciones_realizado"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_usuario", id_usuario)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    'Public Function RecuperaVerificar(ByVal id_usuario As Integer) As DataTable
    '    Try
    '        Dim sql As String = "recupera_solicitud_cancelacion_vacaciones_verificar"

    '        Dim params As SqlParameter() = New SqlParameter(0) {}
    '        params(0) = New SqlParameter("id_usuario", id_usuario)


    '        Dim sqlHelp As New SqlHelper(_connString)

    '        Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Function

    'Public Function RecuperaVerificarHistorico(ByVal id_usuario As Integer) As DataTable
    '    Try
    '        Dim sql As String = "recupera_solicitud_cancelacion_vacaciones_verificar_historico"

    '        Dim params As SqlParameter() = New SqlParameter(0) {}
    '        params(0) = New SqlParameter("id_usuario", id_usuario)


    '        Dim sqlHelp As New SqlHelper(_connString)

    '        Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Function

    Public Function RecuperaPorId(ByVal id_solicitud As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_cancelacion_vacaciones_x_id"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    'Public Function RecuperaPorIdDesc(ByVal id_solicitud As Integer) As DataTable
    '    Try
    '        Dim sql As String = "recupera_solicitud_cancelacion_vacaciones_x_id_desc"

    '        Dim params As SqlParameter() = New SqlParameter(0) {}
    '        params(0) = New SqlParameter("id_solicitud", id_solicitud)


    '        Dim sqlHelp As New SqlHelper(_connString)

    '        Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Function



    Public Function Guarda(ByVal id_solicitud As Integer, ByVal id_empleado_solicita As Integer, ByVal id_autoriza_jefe As Integer,
                           ByVal id_empleado_nomina As Integer, ByVal fechas_a_cancelar As String, ByVal dias_a_cancelar As String, id_solicitud_original As Integer,
                           ByVal comentarios As String, ByVal id_empresa As Integer, ByVal id_empleado_registro As Integer) As DataTable
        Try
            Dim sql As String = "guarda_solicitud_cancelacion_vacaciones"

            Dim params As SqlParameter() = New SqlParameter(9) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("id_empleado_solicita", id_empleado_solicita)
            params(2) = New SqlParameter("id_autoriza_jefe", id_autoriza_jefe)
            params(3) = New SqlParameter("id_empleado_nomina", id_empleado_nomina)
            params(4) = New SqlParameter("fechas_a_cancelar", fechas_a_cancelar)
            params(5) = New SqlParameter("dias_a_cancelar", dias_a_cancelar)
            params(6) = New SqlParameter("id_solicitud_original", id_solicitud_original)
            params(7) = New SqlParameter("comentarios", comentarios)
            params(8) = New SqlParameter("id_empresa", id_empresa)
            params(9) = New SqlParameter("id_empleado_registro", id_empleado_registro)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaInfoEmail(ByVal id_solicitud As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_cancelacion_vacaciones_email_autoriza"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmail(ByVal id_solicitud As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_cancelacion_vacaciones_email"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    'Public Sub VerificaSolicitud(id_solicitud As Integer)
    '    Try
    '        Dim sql As String = "verifica_solicitud_cancelacion_vacaciones"

    '        Dim params As SqlParameter() = New SqlParameter(0) {}
    '        params(0) = New SqlParameter("id_solicitud", id_solicitud)

    '        Dim sqlHelp As New SqlHelper(_connString)
    '        sqlHelp.ExecuteNonQuery(sql, params)
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Sub

    Public Sub CancelaSolicitud(id_solicitud As Integer, id_cancela As Integer)
        Try
            Dim sql As String = "cancela_solicitud_cancelacion_vacaciones"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("id_cancela", id_cancela)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
End Class

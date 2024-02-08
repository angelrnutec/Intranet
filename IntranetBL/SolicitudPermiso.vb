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
Public Class SolicitudPermiso
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub



    Public Function Recupera(ByVal id_usuario As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_permisos"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_usuario", id_usuario)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaConceptosDesc(id_solicitud As Integer) As DataSet
        Try
            Dim sql As String = "recupera_solicitud_permisos_detalle_desc"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Sub CambiaEstatusMail(id_solicitud As Integer, id_empleado As Integer, tipo As Integer, valor As Boolean)
        Try
            Dim sql As String = "guarda_solicitud_permisos_autorizacion_mail"

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


    Public Function SolicitudTieneGerente(id_solicitud As Integer) As Boolean
        Try
            Dim sql As String = "solicitud_permisos_tiene_gerente"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)

            Dim sqlHelp As New SqlHelper(_connString)

            Dim resultado As Integer = sqlHelp.ExecuteScalar(sql, params)
            If resultado = 1 Then
                Return True
            Else
                Return False
            End If

        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Sub GuardaMotivoRechazo(id_solicitud As Integer, motivo As String)
        Try
            Dim sql As String = "guarda_solicitud_permisos_motivo_rechazo"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("motivo", motivo)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    'Public Function DiasDisponibles(id_empleado As Integer) As Decimal
    '    Try
    '        Dim sql As String = "recupera_permisos_disponibles"

    '        Dim params As SqlParameter() = New SqlParameter(0) {}
    '        params(0) = New SqlParameter("id_empleado", id_empleado)

    '        Dim sqlHelp As New SqlHelper(_connString)

    '        Return sqlHelp.ExecuteScalar(sql, params)
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Function

    Public Function DiasEnProceso(id_empleado As Integer) As Decimal
        Try
            Dim sql As String = "recupera_permisos_en_proceso"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub CambiaEstatus(id_solicitud As Integer, id_empleado As Integer, tipo As Integer, valor As Boolean)
        Try
            Dim sql As String = "guarda_solicitud_permisos_autorizacion"

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
            Dim sql As String = "recupera_solicitud_permisos_auth1"

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
            Dim sql As String = "recupera_solicitud_permisos_realizado"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_usuario", id_usuario)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaVerificar(ByVal id_usuario As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_permisos_verificar"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_usuario", id_usuario)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaVerificarHistorico(ByVal id_usuario As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_permisos_verificar_historico"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_usuario", id_usuario)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPorId(ByVal id_solicitud As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_permisos_x_id"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPorIdDesc(ByVal id_solicitud As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_permisos_x_id_desc"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function Guarda(ByVal id_solicitud As Integer, ByVal id_empleado_solicita As Integer, ByVal id_autoriza_jefe As Integer,
                           ByVal id_empleado_nomina As Integer, ByVal fecha_ini As Date, ByVal fecha_fin As Date,
                           ByVal comentarios As String, ByVal id_empresa As Integer, ByVal id_empleado_registro As Integer,
                           ByVal medio_dia As Boolean, ByVal id_empleado_director As Integer, id_tipo_permiso As Integer,
                           ByVal con_goce As Boolean, fecha_viaje_prolongado_ini As Nullable(Of Date), fecha_viaje_prolongado_fin As Nullable(Of Date)) As DataTable
        Try
            Dim sql As String = "guarda_solicitud_permisos"

            Dim params As SqlParameter() = New SqlParameter(14) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("id_empleado_solicita", id_empleado_solicita)
            params(2) = New SqlParameter("id_autoriza_jefe", id_autoriza_jefe)
            params(3) = New SqlParameter("id_empleado_nomina", id_empleado_nomina)
            params(4) = New SqlParameter("fecha_ini", fecha_ini)
            params(5) = New SqlParameter("fecha_fin", fecha_fin)
            params(6) = New SqlParameter("comentarios", comentarios)
            params(7) = New SqlParameter("id_empresa", id_empresa)
            params(8) = New SqlParameter("id_empleado_registro", id_empleado_registro)
            params(9) = New SqlParameter("medio_dia", medio_dia)
            params(10) = New SqlParameter("id_empleado_director", id_empleado_director)
            params(11) = New SqlParameter("id_tipo_permiso", id_tipo_permiso)
            params(12) = New SqlParameter("con_goce", con_goce)

            params(13) = New SqlParameter("fecha_viaje_prolongado_ini", IIf(fecha_viaje_prolongado_ini Is Nothing, "19000101", fecha_viaje_prolongado_ini))
            params(14) = New SqlParameter("fecha_viaje_prolongado_fin", IIf(fecha_viaje_prolongado_fin Is Nothing, "19000101", fecha_viaje_prolongado_fin))

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaInfoEmail(ByVal id_solicitud As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_permisos_email_autoriza"

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
            Dim sql As String = "recupera_solicitud_permisos_email"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub VerificaSolicitud(id_solicitud As Integer)
        Try
            Dim sql As String = "verifica_solicitud_permisos"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub CancelaSolicitud(id_solicitud As Integer, id_cancela As Integer)
        Try
            Dim sql As String = "cancela_solicitud_permisos"

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

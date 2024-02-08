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
Public Class Telcel
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Sub GuardaDatos(sql As String)
        Try
            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub GuardaTelcelAsignacion(numero As String, id_empleado As Integer, id_usuario As Integer, nombre As String, id_empresa As String)
        Try
            Dim sql As String = "guarda_telcel_asignacion"

            Dim params As SqlParameter() = New SqlParameter(4) {}
            params(0) = New SqlParameter("numero", numero)
            params(1) = New SqlParameter("id_empleado", id_empleado)
            params(2) = New SqlParameter("id_usuario", id_usuario)
            params(3) = New SqlParameter("nombre", nombre)
            params(4) = New SqlParameter("id_empresa", id_empresa)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function ValidaTelcelAsignacion(numero As String, id_empleado As Integer) As DataTable
        Try
            Dim sql As String = "valida_telcel_asignacion"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("numero", numero)
            params(1) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RepTelcelConsumos(anio As Integer, periodo As Integer, id_empresa As Integer, id_empleado As String, id_empleado_usuario As Integer,
                                      id_proveedor As Integer) As DataTable
        Try
            Dim sql As String = "rep_telcel_consumos"

            Dim params As SqlParameter() = New SqlParameter(5) {}
            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("periodo", periodo)
            params(2) = New SqlParameter("id_empresa", id_empresa)
            params(3) = New SqlParameter("id_empleado", id_empleado)
            params(4) = New SqlParameter("id_empleado_usuario", id_empleado_usuario)
            params(5) = New SqlParameter("id_proveedor", id_proveedor)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RepTelcelTotalesConcepto(anio As Integer, id_empresa As Integer, id_empleado As String, id_empleado_usuario As Integer,
                                             id_proveedor As Integer) As DataTable
        Try
            Dim sql As String = "rep_telcel_totales_concepto"

            Dim params As SqlParameter() = New SqlParameter(4) {}
            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("id_empleado", id_empleado)
            params(3) = New SqlParameter("id_empleado_usuario", id_empleado_usuario)
            params(4) = New SqlParameter("id_proveedor", id_proveedor)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RepTelcelTotalesLinea(anio As Integer, id_empresa As Integer, id_empleado As String, id_empleado_usuario As Integer,
                                          id_proveedor As Integer) As DataTable
        Try
            Dim sql As String = "rep_telcel_totales_linea"

            Dim params As SqlParameter() = New SqlParameter(4) {}
            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("id_empleado", id_empleado)
            params(3) = New SqlParameter("id_empleado_usuario", id_empleado_usuario)
            params(4) = New SqlParameter("id_proveedor", id_proveedor)


            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaPivote(fecha_ini As DateTime, fecha_fin As DateTime) As DataTable
        Try
            Dim sql As String = "rep_telcel_pivote"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("fecha_ini", fecha_ini)
            params(1) = New SqlParameter("fecha_fin", fecha_fin)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaTelcelAsignacion(id_empresa As Integer, numero As String, nombre As String, estatus As String, id_empleado As Integer) As DataTable
        Try
            Dim sql As String = "recupera_telcel_asignacion"

            Dim params As SqlParameter() = New SqlParameter(4) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("numero", numero)
            params(2) = New SqlParameter("nombre", nombre)
            params(3) = New SqlParameter("estatus", estatus)
            params(4) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaTelcelDessignacion() As DataTable
        Try
            Dim sql As String = "recupera_telcel_desasignacion"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmpresas(id_empleado As Integer, reporte As String, texto As String) As DataTable
        Try
            Dim sql As String = "recupera_empresas_telcel"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("reporte", reporte)
            params(2) = New SqlParameter("texto", texto)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmpleados(id_empresa As Integer, id_empleado As Integer, reporte As String, texto As String) As DataTable
        Try
            Dim sql As String = "recupera_empleado_telcel"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("id_empleado", id_empleado)
            params(2) = New SqlParameter("reporte", reporte)
            params(3) = New SqlParameter("texto", texto)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RepTelcelResumenPorProveedor(anio As Integer, periodo As Integer) As DataTable
        Try
            Dim sql As String = "rep_telcel_resumen_x_proveedor"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("periodo", periodo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RepTelcelAhorroPromedio(anio As Integer, periodo As Integer) As DataSet
        Try
            Dim sql As String = "rep_telcel_ahorro_promedio"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("periodo", periodo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub EliminaTelcelAsignacion(id As Integer)
        Try
            Dim sql As String = "elimina_telcel_asignacion"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id", id)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub LimpiaDatos()
        Try
            Dim sql As String = "telcel_limpia_datos"

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function ProcesoFinal() As String
        Try
            Dim sql As String = "telcel_datos_procesa"

            Dim sqlHelp As New SqlHelper(_connString)
            Dim dt As DataTable = sqlHelp.ExecuteDataAdapter(sql).Tables(0)
            Return dt.Rows(0)("mensaje")
        Catch ex As Exception
            Throw ex
        End Try
    End Function

End Class

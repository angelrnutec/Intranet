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
Public Class MovimientosTarjeta
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Function RecuperaCantidadMovimientosPorComprobar(ByVal id_empleado As Integer) As Integer
        Try
            Dim sql As String = "cantidad_movimientos_por_comprobar"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function RecuperaMovimientosPorComprobar(ByVal id_empleado As Integer) As DataTable
        Try
            Dim sql As String = "recupera_movimientos_por_comprobar"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Sub Guarda(ByVal tipo As String, ByVal numero_tarjeta As String, ByVal fecha_movimiento As DateTime,
            ByVal concepto As String, ByVal descripcion As String, ByVal tipo_comercio As String,
            ByVal moneda As String, ByVal num_autorizacion As String, ByVal estatus_tarjeta As String,
            ByVal tipo_cambio As Decimal, ByVal moneda_extranjera As Decimal, ByVal pesos As Decimal,
            ByVal id_usuario_registro As Integer, ByVal comision_iva As Decimal, ByVal archivo_origen As String, ByVal id_movimiento_tarjeta As String)

        Try
            Dim sql As String = "guarda_movimientos_tarjetas"

            Dim params As SqlParameter() = New SqlParameter(19) {}
            params(0) = New SqlParameter("tipo", tipo)
            params(1) = New SqlParameter("numero_tarjeta", numero_tarjeta)
            params(2) = New SqlParameter("fecha_movimiento", fecha_movimiento)
            params(3) = New SqlParameter("concepto", concepto)
            params(4) = New SqlParameter("descripcion", descripcion)
            params(5) = New SqlParameter("tipo_comercio", tipo_comercio)
            params(6) = New SqlParameter("moneda", moneda)
            params(7) = New SqlParameter("num_autorizacion", num_autorizacion)
            params(8) = New SqlParameter("estatus_tarjeta", estatus_tarjeta)
            params(9) = New SqlParameter("tipo_cambio", tipo_cambio)
            params(10) = New SqlParameter("moneda_extranjera", moneda_extranjera)
            params(11) = New SqlParameter("pesos", pesos)
            params(12) = New SqlParameter("id_usuario_registro", id_usuario_registro)

            params(13) = New SqlParameter("rfc_comercio", "")
            params(14) = New SqlParameter("no_control_edo_cuenta", "")
            params(15) = New SqlParameter("abono", 0)
            params(16) = New SqlParameter("comision_iva", comision_iva)
            params(17) = New SqlParameter("archivo_origen", archivo_origen)
            params(18) = New SqlParameter("id_movimiento_tarjeta", id_movimiento_tarjeta)


            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Function AgregarSolicitudComprobate(ByVal id_solicitud As Integer, ByVal tipo As String, ByVal id_movimiento As Integer, ByVal id_concepto As Integer,
                                          ByVal tipo_comprobantes As String, ByVal tipo_comprobacion_valor As String, ByVal necesidad As String, ByVal iva As Decimal,
                                          ByVal otros_impuestos As Decimal, ByVal retencion As Decimal, ByVal num_personas As Integer, ByVal iva_manual As Decimal,
                                          ByVal propina As Decimal, ByVal observaciones As String) As Integer

        Dim respuesta As Integer = 0
        Try
            Dim sql As String = "guarda_comprobante_movimientos_tarjetas_en_solicitud"

            Dim params As SqlParameter() = New SqlParameter(14) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("tipo", tipo)
            params(2) = New SqlParameter("id_movimiento", id_movimiento)
            params(3) = New SqlParameter("id_concepto", id_concepto)
            params(4) = New SqlParameter("tipo_comprobantes", tipo_comprobantes)
            params(5) = New SqlParameter("tipo_comprobacion_valor", tipo_comprobacion_valor)
            params(6) = New SqlParameter("necesidad", necesidad)
            params(7) = New SqlParameter("iva", iva)
            params(8) = New SqlParameter("otros_impuestos", otros_impuestos)
            params(9) = New SqlParameter("retencion", retencion)
            params(10) = New SqlParameter("num_personas", num_personas)
            params(11) = New SqlParameter("iva_manual", iva_manual)
            params(12) = New SqlParameter("propina", propina)
            params(13) = New SqlParameter("observaciones_extra", observaciones)

            Dim sqlHelp As New SqlHelper(_connString)

            respuesta = sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try

        Return respuesta
    End Function


End Class

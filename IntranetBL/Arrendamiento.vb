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
Public Class Arrendamiento
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub

    Public Sub GuardaAutorizacionArrendamiento(id_arrendamiento As Integer, autorizado As Boolean, motivo As String, id_usuario As Integer)
        Try
            Dim sql As String = "autorizacion_arrendamiento"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_arrendamiento", id_arrendamiento)
            params(1) = New SqlParameter("autorizado", autorizado)
            params(2) = New SqlParameter("motivo", motivo)
            params(3) = New SqlParameter("id_usuario", id_usuario)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function RecuperaArrendamientoPagos(id_arrendamiento As Integer) As DataTable
        Try
            Dim sql As String = "recupera_arrendamiento_pagos"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_arrendamiento", id_arrendamiento)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function RecuperaArrendamientosCalendario(id_empleado As Integer, fecha_inicio As DateTime, fecha_fin As DateTime) As DataTable
        Try
            Dim sql As String = "recupera_arrendamientos_calendario"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("fecha_inicio", fecha_inicio)
            params(2) = New SqlParameter("fecha_fin", fecha_fin)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function RecuperaArrendamientos(id_empresa As Integer, id_categoria_arrendamiento As Integer) As DataTable
        Try
            Dim sql As String = "recupera_arrendamientos"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("id_categoria_arrendamiento", id_categoria_arrendamiento)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function RecuperaArrendamientosFacturas(id_empresa As Integer, id_categoria_arrendamiento As Integer) As DataTable
        Try
            Dim sql As String = "recupera_arrendamientos_facturas"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("id_categoria_arrendamiento", id_categoria_arrendamiento)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function RecuperaArrendamiento(id_arrendamiento As Integer) As DataTable
        Try
            Dim sql As String = "recupera_arrendamiento"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_arrendamiento", id_arrendamiento)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function RecuperaArrendadoras() As DataTable
        Try
            Dim sql As String = "recupera_arrendadoras"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub GuardaArrendadora(id_arrendadora As Integer, descripcion As String, es_borrado As Boolean)
        Try
            Dim sql As String = "guarda_arrendadora"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_arrendadora", id_arrendadora)
            params(1) = New SqlParameter("descripcion", descripcion)
            params(2) = New SqlParameter("es_borrado", es_borrado)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function RecuperaAseguradoras() As DataTable
        Try
            Dim sql As String = "recupera_aseguradoras"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub GuardaAseguradora(id_aseguradora As Integer, descripcion As String, es_borrado As Boolean)
        Try
            Dim sql As String = "guarda_aseguradora"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_aseguradora", id_aseguradora)
            params(1) = New SqlParameter("descripcion", descripcion)
            params(2) = New SqlParameter("es_borrado", es_borrado)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function GuardaArrendamientoEstatus0(id_arrendamiento As Integer, id_empresa As Integer, id_categoria_arrendamiento As Integer, id_usuario As Integer,
                                                id_departamento As Integer, id_empleado As Integer, comentarios As String, id_tipo_auto As Integer,
                                                precio_ge_auto As Decimal, flotilla As String)
        Try
            Dim sql As String = "guarda_arrendamiento_estatus0"

            Dim params As SqlParameter() = New SqlParameter(9) {}
            params(0) = New SqlParameter("id_arrendamiento", id_arrendamiento)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("id_categoria_arrendamiento", id_categoria_arrendamiento)
            params(3) = New SqlParameter("id_usuario", id_usuario)
            params(4) = New SqlParameter("id_departamento", id_departamento)
            params(5) = New SqlParameter("id_empleado", id_empleado)
            params(6) = New SqlParameter("comentarios", comentarios)
            params(7) = New SqlParameter("id_tipo_auto", id_tipo_auto)
            params(8) = New SqlParameter("precio_ge_auto", precio_ge_auto)
            params(9) = New SqlParameter("flotilla", flotilla)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function GuardaArrendamiento(id_arrendamiento As Integer, folio As String, id_empresa As Integer, id_arrendadora As Integer, id_tipo_arrendamiento As Integer, id_categoria_arrendamiento As Integer,
                                   descripcion As String, id_periodicidad_arrendamiento As Integer, importe_total As Decimal, importe_parcialidades As Decimal, id_moneda As String,
                                   fecha_inicio As DateTime, fecha_fin As DateTime, dia_pago As Integer, tasa As Decimal, valor_rescate As Decimal, deposito_garantia As Decimal,
                                    id_aseguradora As Integer, seguro As Decimal, fecha_inicio_seguro As DateTime?, fecha_fin_seguro As DateTime?, id_usuario As Integer, contrato_maestro As String,
                                    flotilla As String, anexo As String, numero_parcialidades As Integer, comision As Decimal, arrendamiento_neto As Decimal, valor_residual As Decimal,
                                    id_departamento As Integer, id_empleado As Integer, num_poliza As String, periodicidad_seguro As Integer, monto_parcialidad_seguro As Decimal,
                                    plazo_seguro As Integer, tasa_calculada_mensual As Decimal, marca As String, modelo As String, anio As String, no_serie As String, color As String,
                                    num_factura As String, proveedor As String, cantidad_d2 As Integer, monto_unitario_d2 As Decimal, monto_total_d2 As Decimal, descripcion_d2 As String,
                                    fecha_recepcion As DateTime?, recibido_por As String) As Integer

        Try
            Dim sql As String = "guarda_arrendamiento"

            Dim params As SqlParameter() = New SqlParameter(48) {}
            params(0) = New SqlParameter("id_arrendamiento", id_arrendamiento)
            params(1) = New SqlParameter("folio", folio)
            params(2) = New SqlParameter("id_empresa", id_empresa)
            params(3) = New SqlParameter("id_tipo_arrendamiento", id_tipo_arrendamiento)
            params(4) = New SqlParameter("id_categoria_arrendamiento", id_categoria_arrendamiento)
            params(5) = New SqlParameter("descripcion", descripcion)
            params(6) = New SqlParameter("id_periodicidad_arrendamiento", id_periodicidad_arrendamiento)
            params(7) = New SqlParameter("importe_total", importe_total)
            params(8) = New SqlParameter("importe_parcialidades", importe_parcialidades)
            params(9) = New SqlParameter("id_moneda", id_moneda)
            params(10) = New SqlParameter("fecha_inicio", fecha_inicio)
            params(11) = New SqlParameter("fecha_fin", fecha_fin)
            params(12) = New SqlParameter("dia_pago", dia_pago)
            params(13) = New SqlParameter("tasa", tasa)
            params(14) = New SqlParameter("valor_rescate", valor_rescate)
            params(15) = New SqlParameter("deposito_garantia", deposito_garantia)
            params(16) = New SqlParameter("id_aseguradora", id_aseguradora)
            params(17) = New SqlParameter("seguro", seguro)
            params(18) = New SqlParameter("fecha_inicio_seguro", IIf(fecha_inicio_seguro Is Nothing, DBNull.Value, fecha_inicio_seguro))
            params(19) = New SqlParameter("fecha_fin_seguro", IIf(fecha_fin_seguro Is Nothing, DBNull.Value, fecha_fin_seguro))
            params(20) = New SqlParameter("id_usuario", id_usuario)
            params(21) = New SqlParameter("id_arrendadora", id_arrendadora)

            params(22) = New SqlParameter("contrato_maestro", contrato_maestro)
            params(23) = New SqlParameter("flotilla", flotilla)
            params(24) = New SqlParameter("anexo", anexo)
            params(25) = New SqlParameter("numero_parcialidades", numero_parcialidades)
            params(26) = New SqlParameter("comision", comision)
            params(27) = New SqlParameter("arrendamiento_neto", arrendamiento_neto)
            params(28) = New SqlParameter("valor_residual", valor_residual)
            params(29) = New SqlParameter("id_departamento", id_departamento)
            params(30) = New SqlParameter("id_empleado", id_empleado)
            params(31) = New SqlParameter("num_poliza", num_poliza)
            params(32) = New SqlParameter("periodicidad_seguro", periodicidad_seguro)
            params(33) = New SqlParameter("monto_parcialidad_seguro", monto_parcialidad_seguro)
            params(34) = New SqlParameter("plazo_seguro", plazo_seguro)
            params(35) = New SqlParameter("tasa_calculada_mensual", tasa_calculada_mensual)

            params(36) = New SqlParameter("marca", marca)
            params(37) = New SqlParameter("modelo", modelo)
            params(38) = New SqlParameter("anio", anio)
            params(39) = New SqlParameter("no_serie", no_serie)
            params(40) = New SqlParameter("color", color)
            params(41) = New SqlParameter("num_factura", num_factura)
            params(42) = New SqlParameter("proveedor", proveedor)
            params(43) = New SqlParameter("cantidad_d2", cantidad_d2)
            params(44) = New SqlParameter("monto_unitario_d2", monto_unitario_d2)
            params(45) = New SqlParameter("monto_total_d2", monto_total_d2)
            params(46) = New SqlParameter("descripcion_d2", descripcion_d2)

            params(47) = New SqlParameter("fecha_recepcion", IIf(fecha_recepcion Is Nothing, DBNull.Value, fecha_recepcion))
            params(48) = New SqlParameter("recibido_por", recibido_por)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function RecuperaTipoArrendamientos() As DataTable
        Try
            Dim sql As String = "recupera_tipo_arrendamientos"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub GuardaTipoArrendamiento(id_tipo_arrendamiento As Integer, descripcion As String, es_borrado As Boolean)
        Try
            Dim sql As String = "guarda_tipo_arrendamiento"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_tipo_arrendamiento", id_tipo_arrendamiento)
            params(1) = New SqlParameter("descripcion", descripcion)
            params(2) = New SqlParameter("es_borrado", es_borrado)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub




    Public Function RecuperaCategoriaArrendamientos() As DataTable
        Try
            Dim sql As String = "recupera_categoria_arrendamientos"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub GuardaCategoriaArrendamiento(id_categoria_arrendamiento As Integer, descripcion As String, es_borrado As Boolean)
        Try
            Dim sql As String = "guarda_categoria_arrendamiento"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_categoria_arrendamiento", id_categoria_arrendamiento)
            params(1) = New SqlParameter("descripcion", descripcion)
            params(2) = New SqlParameter("es_borrado", es_borrado)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Sub ArrendamientoElimina(id_arrendamiento As Integer, id_usuario As Integer)
        Try
            Dim sql As String = "elimina_arrendamiento"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_arrendamiento", id_arrendamiento)
            params(1) = New SqlParameter("id_usuario", id_usuario)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub









    Public Sub AgregaDocumento(id_arrendamiento As Integer, nombre As String, id_empleado As Integer, id_tipo As Integer)
        Try
            Dim sql As String = "guarda_arrendamiento_archivo"

            Dim params As SqlParameter() = New SqlParameter(4) {}
            params(0) = New SqlParameter("id_archivo", 0)
            params(1) = New SqlParameter("id_arrendamiento", id_arrendamiento)
            params(2) = New SqlParameter("nombre", nombre)
            params(3) = New SqlParameter("id_empleado", id_empleado)
            params(4) = New SqlParameter("id_tipo", id_tipo)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Sub EliminarDocumento(id_archivo As Integer)
        Try
            Dim sql As String = "elimina_arrendamiento_archivo"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_archivo", id_archivo)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function RecuperaArrendamientoDocumento(id_arrendamiento As Integer) As DataTable
        Try
            Dim sql As String = "recupera_arrendamiento_documento"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_arrendamiento", id_arrendamiento)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmail(id_arrendamiento As Integer) As DataTable
        Try
            Dim sql As String = "recupera_arrendamiento_email"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_arrendamiento", id_arrendamiento)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

End Class

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
Public Class PolizaContable
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Function Recupera(ByVal tipo As String, id_empresa As Integer, fecha_ini As String, fecha_fin As String, regenerar As Boolean, id_usuario As Integer, tipo_concepto As String, estatus As Integer, ByVal id_empleado As Integer) As DataSet
        Try
            Dim sql As String = "recupera_poliza_contable"

            Dim params As SqlParameter() = New SqlParameter(8) {}
            params(0) = New SqlParameter("tipo", tipo)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("fecha_ini", fecha_ini)
            params(3) = New SqlParameter("fecha_fin", fecha_fin)
            params(4) = New SqlParameter("regenerar", regenerar)
            params(5) = New SqlParameter("id_usuario", id_usuario)
            params(6) = New SqlParameter("tipo_concepto", tipo_concepto)
            params(7) = New SqlParameter("estatus", estatus)
            params(8) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPorFolio(ByVal listaPolizas As String, ByVal tipo As String) As DataSet
        Try
            Dim sql As String = "recupera_poliza_contable_lista"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("listaPolizas", listaPolizas)
            params(1) = New SqlParameter("tipo", tipo)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub RecuperaEnviadaOK(ByVal poliza As String, ByVal id_usuario As String, ByVal tipo_poliza As String)
        Try
            Dim sql As String = "poliza_contable_sap"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("poliza", poliza)
            params(1) = New SqlParameter("id_usuario", id_usuario)
            params(2) = New SqlParameter("tipo_poliza", tipo_poliza)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub ActualizaPolizaFecha(id_solicitud As Integer, fecha_doc As String, referencia As String, ByVal tipo_poliza As String)
        Try
            Dim sql As String = "poliza_contable_encabezado_edita"

            Dim params As SqlParameter() = New SqlParameter(4) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("fecha_doc", fecha_doc)
            params(2) = New SqlParameter("referencia", referencia)
            params(3) = New SqlParameter("tipo_poliza", tipo_poliza)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub ActualizaPolizaDetalle(id_solicitud As Integer, tipo_poliza As String, id_detalle As String, cuenta As String, clave As String, proyecto As String, no_necesidad As String, importe As String, descripcion As String, tipo_comprobacion As String, id_concepto As String)
        Try
            Dim sql As String = "poliza_contable_detalle_edita"

            Dim params As SqlParameter() = New SqlParameter(11) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("id_detalle", id_detalle)
            params(2) = New SqlParameter("cuenta", cuenta)
            params(3) = New SqlParameter("clave", clave)
            params(4) = New SqlParameter("proyecto", proyecto)
            params(5) = New SqlParameter("importe", importe)
            params(6) = New SqlParameter("descripcion", descripcion)
            params(7) = New SqlParameter("tipo_comprobacion", tipo_comprobacion)
            params(8) = New SqlParameter("id_concepto", id_concepto)
            params(9) = New SqlParameter("no_necesidad", no_necesidad)
            params(10) = New SqlParameter("tipo", tipo_poliza)


            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub EliminaPolizaDetalle(id_solicitud As Integer, tipo_poliza As String, id_detalle As String)
        Try
            Dim sql As String = "poliza_contable_detalle_elimina"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("id_detalle", id_detalle)
            params(2) = New SqlParameter("tipo", tipo_poliza)


            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Sub GuardaPolizaContable(ByVal id As Integer, fecha_documento As String, sociedad As String, deudor As String,
                                         referencia As String, asignacion As String, total As String, id_usuario As Integer)
        Try
            Dim sql As String = "modifica_poliza_contable"

            Dim params As SqlParameter() = New SqlParameter(7) {}
            params(0) = New SqlParameter("id", id)
            params(1) = New SqlParameter("fecha_documento", fecha_documento)
            params(2) = New SqlParameter("sociedad", sociedad)
            params(3) = New SqlParameter("deudor", deudor)
            params(4) = New SqlParameter("referencia", referencia)
            params(5) = New SqlParameter("asignacion", asignacion)
            params(6) = New SqlParameter("total", total)
            params(7) = New SqlParameter("id_usuario", id_usuario)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Sub GuardaPolizaContableDetalle(ByVal id As Integer, cuenta As String, sociedad As String, clave_iva As String,
                                             proyecto As String, asignacion As String, importe_sin_iva As String, no_necesidad As String,
                                             descripcion As String, id_usuario As Integer)
        Try
            Dim sql As String = "modifica_poliza_contable_detalle"

            Dim params As SqlParameter() = New SqlParameter(9) {}
            params(0) = New SqlParameter("id", id)
            params(1) = New SqlParameter("cuenta", cuenta)
            params(2) = New SqlParameter("sociedad", sociedad)
            params(3) = New SqlParameter("clave_iva", clave_iva)
            params(4) = New SqlParameter("proyecto", proyecto)
            params(5) = New SqlParameter("asignacion", asignacion)
            params(6) = New SqlParameter("importe_sin_iva", importe_sin_iva)
            params(7) = New SqlParameter("no_necesidad", no_necesidad)
            params(8) = New SqlParameter("descripcion", descripcion)
            params(9) = New SqlParameter("id_usuario", id_usuario)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function RecuperaImpresion(ByVal id As Integer) As DataSet
        Try
            Dim sql As String = "recupera_poliza_contable_impresion"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id", id)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function CorregirPolizaContableSap(ByVal referencia As String, ByVal id_usuario As Integer) As String
        Try

            Dim sql As String = "corregir_poliza_contable_sap"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("referencia", referencia)
            params(1) = New SqlParameter("id_usuario", id_usuario)

            Dim sqlHelp As New SqlHelper(_connString)

            Dim drResultado As DataTable = sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)

            If drResultado.Rows.Count > 0 Then
                Return drResultado.Rows(0)("resultado")
            End If

            Return ""

        Catch ex As Exception
            Throw ex
        End Try
    End Function

End Class


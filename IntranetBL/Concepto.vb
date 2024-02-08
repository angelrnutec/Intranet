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
Public Class Concepto
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Function Recupera(ByVal id_reporte As Integer, ByVal id_empresa As Integer) As DataTable
        Try
            Dim sql As String = "recupera_concepto"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)
            params(1) = New SqlParameter("id_empresa", id_empresa)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function RecuperaPorId(ByVal id_concepto As Integer) As DataTable
        Try
            Dim sql As String = "recupera_concepto_x_id"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_concepto", id_concepto)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function Guarda(ByVal id_concepto As Integer, ByVal clave As String,
            ByVal descripcion As String, ByVal id_reporte As Integer, ByVal orden As Integer,
            ByVal id_padre As Integer, ByVal resta As Boolean, ByVal formula_especial As String,
            ByVal permite_captura As Boolean, ByVal es_separador As Boolean, ByVal es_plan As Boolean,
            ByVal es_fibras As Boolean, ByVal es_hornos As Boolean, ByVal id_empresa As Integer,
            ByVal descripcion_2 As String, ByVal referencia As String, ByVal referencia2 As String,
            ByVal referencia3 As String) As Integer

        Try
            Dim sql As String = "guarda_concepto"

            Dim params As SqlParameter() = New SqlParameter(18) {}
            params(0) = New SqlParameter("id_concepto", id_concepto)
            params(1) = New SqlParameter("clave", clave)
            params(2) = New SqlParameter("descripcion", descripcion)
            params(3) = New SqlParameter("id_reporte", id_reporte)
            params(4) = New SqlParameter("orden", orden)
            params(5) = New SqlParameter("id_padre", id_padre)
            params(6) = New SqlParameter("resta", resta)
            params(7) = New SqlParameter("formula_especial", formula_especial)
            params(8) = New SqlParameter("permite_captura", permite_captura)
            params(9) = New SqlParameter("es_separador", es_separador)
            params(10) = New SqlParameter("es_plan", es_plan)
            params(11) = New SqlParameter("es_fibras", es_fibras)
            params(12) = New SqlParameter("es_hornos", es_hornos)
            params(13) = New SqlParameter("id_empresa", id_empresa)
            params(14) = New SqlParameter("descripcion_2", descripcion_2)
            params(15) = New SqlParameter("referencia", referencia)
            params(16) = New SqlParameter("referencia2", referencia2)
            params(17) = New SqlParameter("referencia3", referencia3)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function Elimina(ByVal id_concepto As Integer) As String
        Try


            Dim mensaje As String = ValidaDependencia(id_concepto)
            If mensaje.Length > 0 Then
                Return mensaje
            Else
                Dim sqlHelp As New SqlHelper(_connString)
                Dim sql As String = "elimina_concepto"

                Dim params As SqlParameter() = New SqlParameter(0) {}
                params(0) = New SqlParameter("id_concepto", id_concepto)


                sqlHelp.ExecuteNonQuery(sql, params)
                Return ""

            End If




        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function ValidaDependencia(ByVal id_concepto As Integer) As String
        Try
            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "valida_dependencia_concepto"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_concepto", id_concepto)


            Dim dsValida As DataSet = sqlHelp.ExecuteDataAdapter(sql, params)

            Dim mensaje As String = ""
            If dsValida.Tables(0).Rows.Count > 0 Then
                For Each dr As DataRow In dsValida.Tables(0).Rows
                    mensaje += "Tabla " & Convert.ToString(dr("registro")) & ", registros " & Convert.ToString(dr("cantidad")) & "\n"
                Next
                If mensaje.Length > 0 Then
                    mensaje = "No se puede eliminar el registro debido a las siguientes dependencias: \n" & mensaje
                End If
            End If
            Return mensaje

        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function Baja(ByVal id_concepto As Integer, ByVal anio_baja As Integer, ByVal periodo_baja As Integer) As Integer
        Try
            Dim sql As String = "baja_concepto"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_concepto", id_concepto)
            params(1) = New SqlParameter("anio_baja", anio_baja)
            params(2) = New SqlParameter("periodo_baja", periodo_baja)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

End Class

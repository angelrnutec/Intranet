Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports IntranetDA


Public Class VacacionesTabulador
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Function Recupera(ByVal fecha_efectividad As String, ByVal id_tabla_vacaciones As Integer) As DataTable
        Try
            Dim sql As String = "recupera_vacaciones_tabulador"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("fecha_efectividad", fecha_efectividad)
            params(1) = New SqlParameter("id_tabla_vacaciones", id_tabla_vacaciones)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaUltimo() As DataTable
        Try
            Dim sql As String = "recupera_ultimo_vacaciones_tabulador"

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Guarda(ByVal id As Integer, ByVal anio_ini As Integer, ByVal anio_fin As Integer, ByVal dias As Integer, ByVal fecha_efectividad As String) As Integer
        Try
            Dim sql As String = "guarda_vacaciones_tabulador"

            Dim params As SqlParameter() = New SqlParameter(4) {}
            params(0) = New SqlParameter("id", id)
            params(1) = New SqlParameter("anio_ini", anio_ini)
            params(2) = New SqlParameter("anio_fin", anio_fin)
            params(3) = New SqlParameter("dias", dias)
            params(4) = New SqlParameter("fecha_efectividad", fecha_efectividad)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function Elimina(ByVal id As Integer) As String
        Try


            Dim mensaje As String = ValidaDependencia(id)
            If mensaje.Length > 0 Then
                Return mensaje
            Else
                Dim sqlHelp As New SqlHelper(_connString)
                Dim sql As String = "elimina_vacaciones_tabulador"

                Dim params As SqlParameter() = New SqlParameter(0) {}
                params(0) = New SqlParameter("id", id)


                sqlHelp.ExecuteNonQuery(sql, params)
                Return ""

            End If




        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function ValidaDependencia(ByVal id As Integer) As String
        Try
            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "valida_dependencia_vacaciones_tabulador"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id", id)


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




End Class


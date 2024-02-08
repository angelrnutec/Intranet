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
Public Class Asueto
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Function Recupera(anio As Integer, id_pais As Integer) As DataTable
        Try
            Dim sql As String = "recupera_asueto"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("id_pais", id_pais)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaFuturos(id_empresa As Integer) As DataTable
        Try
            Dim sql As String = "recupera_asueto_futuros"
            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Guarda(ByVal fecha As DateTime, descripcion As String, id_usuario As Integer, medio_dia As Boolean, id_pais As Integer) As Integer
        Try
            Dim sql As String = "guarda_asueto"

            Dim params As SqlParameter() = New SqlParameter(5) {}
            params(0) = New SqlParameter("fecha", fecha)
            params(1) = New SqlParameter("descripcion", descripcion)
            params(2) = New SqlParameter("id_usuario", id_usuario)
            params(3) = New SqlParameter("medio_dia", medio_dia)
            params(4) = New SqlParameter("id_pais", id_pais)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Sub Elimina(ByVal id_asueto As Integer)
        Try
            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "elimina_asueto"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_asueto", id_asueto)


            sqlHelp.ExecuteNonQuery(sql, params)

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

End Class

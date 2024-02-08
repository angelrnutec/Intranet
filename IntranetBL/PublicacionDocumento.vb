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
Public Class PublicacionDocumento
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Function Recupera() As DataTable
        Try
            Dim sql As String = "recupera_publicacion_documento"



            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function





    Public Function Guarda(ByVal id_documento As Integer, ByVal id_publicacion As Integer,
            ByVal nombre As String, ByVal documento As String,
            ByVal fecha_registro As DateTime) As Integer
        Try
            Dim sql As String = "guarda_publicacion_documento"

            Dim params As SqlParameter() = New SqlParameter(4) {}
            params(0) = New SqlParameter("id_documento", id_documento)
            params(1) = New SqlParameter("id_publicacion", id_publicacion)
            params(2) = New SqlParameter("nombre", nombre)
            params(3) = New SqlParameter("documento", documento)
            params(4) = New SqlParameter("fecha_registro", fecha_registro)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function Elimina(ByVal id_documento As Integer) As String
        Try




            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "elimina_publicacion_documento"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_documento", id_documento)


            sqlHelp.ExecuteNonQuery(sql, params)
            Return ""


        Catch ex As Exception
            Throw ex
        End Try
    End Function






End Class

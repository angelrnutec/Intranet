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
Public Class Configuracion
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Function RecuperaConfiguracion(llave As String, id_empresa As Integer) As String
        Try
            Dim sql As String = "recupera_configuracion"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("llave", llave)
            params(1) = New SqlParameter("id_empresa", id_empresa)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0).Rows(0)("valor")
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaConfiguraciones() As DataTable
        Try
            Dim sql As String = "recupera_configuraciones"

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Sub GuardaConfiguracion(id As Integer, valor As String)
        Try
            Dim sql As String = "guarda_configuracion"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id", id)
            params(1) = New SqlParameter("valor", valor)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

End Class

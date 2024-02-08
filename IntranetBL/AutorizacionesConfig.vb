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
Public Class Autorizaciones_Config
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Function Recupera() As DataSet
        Try
            Dim sql As String = "recupera_autorizaciones_config"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Sub GuardaQuita(ByVal tipo As String, ByVal id_tipo_autorizacion As Integer, ByVal id_empleado As Integer)
        Try
            Dim sql As String = "guarda_autorizaciones_config"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("tipo", tipo)
            params(1) = New SqlParameter("id_tipo_autorizacion", id_tipo_autorizacion)
            params(2) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

End Class

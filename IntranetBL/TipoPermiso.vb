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
Public Class TipoPermiso
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Function Recupera() As DataTable
        Try
            Dim sql As String = "recupera_solicitud_permisos_tipo"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function Guarda(id_tipo_permiso As Integer, descripcion As String, descripcion_en As String, con_goce As Boolean, sin_goce As Boolean, max_dias As Integer) As Integer
        Try
            Dim sql As String = "guarda_solicitud_permisos_tipo"

            Dim params As SqlParameter() = New SqlParameter(5) {}
            params(0) = New SqlParameter("id_tipo_permiso", id_tipo_permiso)
            params(1) = New SqlParameter("descripcion", descripcion)
            params(2) = New SqlParameter("con_goce", con_goce)
            params(3) = New SqlParameter("sin_goce", sin_goce)
            params(4) = New SqlParameter("max_dias", max_dias)
            params(5) = New SqlParameter("descripcion_en", descripcion_en)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function Elimina(ByVal id_tipo_permiso As Integer) As String
        Try
            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "elimina_solicitud_permisos_tipo"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_tipo_permiso", id_tipo_permiso)

            sqlHelp.ExecuteNonQuery(sql, params)
            Return ""
        Catch ex As Exception
            Throw ex
        End Try
    End Function





End Class

Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports IntranetDA


Public Class ProveedorTelefonia
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Function Recupera(ByVal id_concepto As Integer) As DataTable
        Try
            Dim sql As String = "recupera_telefonia_proveedor_busqueda"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_concepto", id_concepto)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPorId(ByVal id_proveedor As Integer) As DataTable
        Try
            Dim sql As String = "recupera_telefonia_proveedor_x_id"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_proveedor", id_proveedor)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Guarda(ByVal id_proveedor As Integer, ByVal nombre As String, ByVal tipo_captura As String, ByVal id_concepto As String) As Integer
        Try
            Dim sql As String = "guarda_telefonia_proveedor"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_proveedor", id_proveedor)
            params(1) = New SqlParameter("nombre", nombre)
            params(2) = New SqlParameter("tipo_captura", tipo_captura)
            params(3) = New SqlParameter("id_concepto", id_concepto)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function Elimina(ByVal id_proveedor As Integer) As String
        Try
            Dim mensaje As String = ValidaDependencia(id_proveedor)
            If mensaje.Length > 0 Then
                Return mensaje
            Else
                Dim sqlHelp As New SqlHelper(_connString)
                Dim sql As String = "elimina_telefonia_proveedor"

                Dim params As SqlParameter() = New SqlParameter(0) {}
                params(0) = New SqlParameter("id_proveedor", id_proveedor)

                sqlHelp.ExecuteNonQuery(sql, params)
                Return ""
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function ValidaDependencia(ByVal id_proveedor As Integer) As String
        Try
            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "valida_dependencia_telefonia_proveedor"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_proveedor", id_proveedor)

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


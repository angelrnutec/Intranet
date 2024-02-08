Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports IntranetDA


Public Class FormaPago
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Function Recupera() As DataTable
        Try
            Dim sql As String = "recupera_forma_pago"

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPorId(ByVal id_forma_pago As Integer) As DataTable
        Try
            Dim sql As String = "recupera_forma_pago_x_id"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_forma_pago", id_forma_pago)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Guarda(ByVal id_forma_pago As Integer, ByVal descripcion As String, ByVal descripcion_en As String, ByVal abreviatura As String) As Integer
        Try
            Dim sql As String = "guarda_forma_pago"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_forma_pago", id_forma_pago)
            params(1) = New SqlParameter("descripcion", descripcion)
            params(2) = New SqlParameter("descripcion_en", descripcion)
            params(3) = New SqlParameter("abreviatura", abreviatura)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function Elimina(ByVal id_forma_pago As Integer) As String
        Try
            Dim mensaje As String = ValidaDependencia(id_forma_pago)
            If mensaje.Length > 0 Then
                Return mensaje
            Else
                Dim sqlHelp As New SqlHelper(_connString)
                Dim sql As String = "elimina_forma_pago"

                Dim params As SqlParameter() = New SqlParameter(0) {}
                params(0) = New SqlParameter("id_forma_pago", id_forma_pago)

                sqlHelp.ExecuteNonQuery(sql, params)
                Return ""
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function ValidaDependencia(ByVal id_forma_pago As Integer) As String
        Try
            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "valida_dependencia_forma_pago"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_forma_pago", id_forma_pago)

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


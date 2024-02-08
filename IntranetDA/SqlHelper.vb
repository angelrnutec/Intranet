Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient

Public NotInheritable Class SqlHelper
    Public dbConn As New SqlConnection()
    Public dbCommand As New SqlCommand()
    Public dbAdapter As New SqlDataAdapter()

    Private _connection_string As String
    Public Sub New(connection_string As String)
        _connection_string = connection_string
        OpenConnection()
    End Sub

    Public Function ExecuteDataAdapter(sql As String, params As SqlParameter()) As DataSet
        Dim functionReturnValue As DataSet = Nothing
        Try
            dbCommand = New SqlCommand()
            functionReturnValue = New DataSet()

            If dbConn Is Nothing Or dbConn.State = ConnectionState.Closed Then
                OpenConnection()
            End If

            Dim paramStr As String = ""
            Dim p As SqlParameter = Nothing
            For Each p_loopVariable As SqlParameter In params
                p = p_loopVariable
                If (p IsNot Nothing) Then
                    'check for derived output value with no value assigned
                    If p.Direction = ParameterDirection.InputOutput And p.Value Is Nothing Then
                        p.Value = Nothing
                        'paramStr += p.ParameterName & "=" & p.Value
                    Else
                    End If
                    dbCommand.Parameters.Add(p)
                End If
            Next

            dbCommand.Connection = dbConn
            dbCommand.CommandText = sql
            dbCommand.CommandTimeout = 0
            '& paramStr
            dbCommand.CommandType = CommandType.StoredProcedure

            functionReturnValue.Clear()
            dbAdapter.SelectCommand = dbCommand
            dbAdapter.Fill(functionReturnValue)

            CloseConnection()
        Catch ex As Exception
            Throw ex
        End Try
        Return functionReturnValue

    End Function

    Public Function ExecuteDataAdapter(sql As String) As DataSet
        Dim functionReturnValue As DataSet = Nothing
        Try
            dbCommand = New SqlCommand()
            functionReturnValue = New DataSet()

            If dbConn.State = ConnectionState.Closed Then
                OpenConnection()
            End If

            dbCommand.CommandType = CommandType.StoredProcedure
            dbCommand.Connection = dbConn
            dbCommand.CommandText = sql
            dbCommand.CommandTimeout = 0
            functionReturnValue.Clear()
            dbAdapter.SelectCommand = dbCommand
            dbAdapter.Fill(functionReturnValue)

            CloseConnection()
        Catch ex As Exception
            Throw ex
        End Try
        Return functionReturnValue
    End Function

    Public Function ExecuteDataAdapterText(sql As String) As DataSet
        Dim functionReturnValue As DataSet = Nothing
        Try
            dbCommand = New SqlCommand()
            functionReturnValue = New DataSet()

            If dbConn.State = ConnectionState.Closed Then
                OpenConnection()
            End If

            dbCommand.CommandType = CommandType.Text
            dbCommand.Connection = dbConn
            dbCommand.CommandText = sql
            dbCommand.CommandTimeout = 0
            functionReturnValue.Clear()
            dbAdapter.SelectCommand = dbCommand
            dbAdapter.Fill(functionReturnValue)

            CloseConnection()
        Catch ex As Exception
            Throw ex
        End Try
        Return functionReturnValue
    End Function

    Public Function ExecuteScalarS(sql As String, params As SqlParameter()) As String
        Try
            dbCommand = New SqlCommand()

            If dbConn.State = ConnectionState.Closed Then
                OpenConnection()
            End If

            Dim paramStr As String = ""

            Dim p As SqlParameter = Nothing
            For Each p_loopVariable As SqlParameter In params
                p = p_loopVariable
                If (p IsNot Nothing) Then
                    'check for derived output value with no value assigned
                    If p.Direction = ParameterDirection.InputOutput And p.Value Is Nothing Then
                        p.Value = Nothing
                        'paramStr += p.ParameterName & "=" & p.Value
                    Else
                    End If
                    dbCommand.Parameters.Add(p)
                End If
            Next

            dbCommand.Connection = dbConn
            dbCommand.CommandText = sql
            dbCommand.CommandTimeout = 0
            '& paramStr
            dbCommand.CommandType = CommandType.StoredProcedure

            Dim texto As String = dbCommand.ExecuteScalar()

            CloseConnection()

            Return texto
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ExecuteScalar(sql As String) As Integer
        Try
            dbCommand = New SqlCommand()
            If dbConn.State = ConnectionState.Closed Then
                OpenConnection()
            End If

            dbCommand.Connection = dbConn
            dbCommand.CommandText = sql
            dbCommand.CommandTimeout = 0

            Dim id As Integer = Convert.ToInt32(dbCommand.ExecuteScalar())

            CloseConnection()

            Return id
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ExecuteScalar(sql As String, params As SqlParameter()) As Decimal
        Try
            dbCommand = New SqlCommand()

            If dbConn.State = ConnectionState.Closed Then
                OpenConnection()
            End If

            Dim paramStr As String = ""

            Dim p As SqlParameter = Nothing
            For Each p_loopVariable As SqlParameter In params
                p = p_loopVariable
                If (p IsNot Nothing) Then
                    'check for derived output value with no value assigned
                    If p.Direction = ParameterDirection.InputOutput And p.Value Is Nothing Then
                        p.Value = Nothing
                        'paramStr += p.ParameterName & "=" & p.Value
                    Else
                    End If
                    dbCommand.Parameters.Add(p)
                End If
            Next

            dbCommand.Connection = dbConn
            dbCommand.CommandText = sql
            dbCommand.CommandTimeout = 0
            '& paramStr
            dbCommand.CommandType = CommandType.StoredProcedure

            Dim id As Decimal = dbCommand.ExecuteScalar()

            CloseConnection()

            Return id
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub ExecuteNonQuery(sql As String)
        Try
            dbCommand = New SqlCommand()

            If dbConn.State = ConnectionState.Closed Then
                OpenConnection()
            End If

            dbCommand.Connection = dbConn
            dbCommand.CommandText = sql
            dbCommand.CommandTimeout = 0

            dbCommand.ExecuteNonQuery()


            CloseConnection()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub ExecuteNonQuery(sql As String, params As SqlParameter())
        Try
            dbCommand = New SqlCommand()

            If dbConn.State = ConnectionState.Closed Then
                OpenConnection()
            End If
            Dim paramStr As String = ""
            Dim p As SqlParameter = Nothing
            For Each p_loopVariable As SqlParameter In params
                p = p_loopVariable
                If (p IsNot Nothing) Then
                    'check for derived output value with no value assigned
                    If p.Direction = ParameterDirection.InputOutput And p.Value Is Nothing Then
                        p.Value = Nothing
                        'paramStr += p.ParameterName & "=" & p.Value
                    Else
                    End If
                    dbCommand.Parameters.Add(p)
                End If
            Next

            dbCommand.Connection = dbConn
            dbCommand.CommandText = sql
            dbCommand.CommandTimeout = 0
            dbCommand.CommandType = CommandType.StoredProcedure

            dbCommand.ExecuteNonQuery()


            CloseConnection()
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Shared Sub AttachParameters(command As SqlCommand, commandParameters As SqlParameter())
        Dim p As SqlParameter = Nothing

        For Each p_loopVariable As SqlParameter In commandParameters
            p = p_loopVariable
            If p.Direction = ParameterDirection.InputOutput And p.Value Is Nothing Then
                p.Value = Nothing
            End If
            command.Parameters.Add(p)
        Next
    End Sub

    Private Sub OpenConnection()
        Try
            If Not (dbConn.State = ConnectionState.Open) Then
                dbConn.ConnectionString = _connection_string
                dbConn.Open()
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub CloseConnection()
        Try
            If Not (dbConn.State = ConnectionState.Closed) Then
                dbConn.Close()
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
End Class

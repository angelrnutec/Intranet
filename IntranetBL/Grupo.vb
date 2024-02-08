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
Public Class Grupo
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Function Recupera() As DataTable
        Try
            Dim sql As String = "recupera_grupo"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaGruposParaPublicacion(titulo As String, id_empleado As Integer) As DataTable
        Try
            Dim sql As String = "recupera_grupo_para_publicacion"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("titulo", titulo)
            params(1) = New SqlParameter("id_empleado", id_empleado)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPorId(ByVal id_grupo As Integer) As DataTable
        Try
            Dim sql As String = "recupera_grupo_x_id"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_grupo", id_grupo)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Sub EmpleadosPublicanQuitar(ByVal id_grupo As Integer, id_empleado As Integer)
        Try
            Dim sql As String = "grupo_config_publican"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("tipo", "Q")
            params(1) = New SqlParameter("id_grupo", id_grupo)
            params(2) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub EmpleadosPublicanAgregar(ByVal id_grupo As Integer, id_empleado As Integer)
        Try
            Dim sql As String = "grupo_config_publican"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("tipo", "A")
            params(1) = New SqlParameter("id_grupo", id_grupo)
            params(2) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Sub EmpleadosVenQuitar(ByVal id_grupo As Integer, id_empleado As Integer)
        Try
            Dim sql As String = "grupo_config_ven"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("tipo", "Q")
            params(1) = New SqlParameter("id_grupo", id_grupo)
            params(2) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub EmpleadosVenAgregar(ByVal id_grupo As Integer, id_empleado As Integer)
        Try
            Dim sql As String = "grupo_config_ven"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("tipo", "A")
            params(1) = New SqlParameter("id_grupo", id_grupo)
            params(2) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Sub DeptosVenQuitar(ByVal id_grupo As Integer, id_departamento As Integer)
        Try
            Dim sql As String = "grupo_config_deptos_ven"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("tipo", "Q")
            params(1) = New SqlParameter("id_grupo", id_grupo)
            params(2) = New SqlParameter("id_departamento", id_departamento)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub DeptosVenAgregar(ByVal id_grupo As Integer, id_departamento As Integer)
        Try
            Dim sql As String = "grupo_config_deptos_ven"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("tipo", "A")
            params(1) = New SqlParameter("id_grupo", id_grupo)
            params(2) = New SqlParameter("id_departamento", id_departamento)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub





    Public Function RecuperaConfiguracion(ByVal id_grupo As Integer) As DataSet
        Try
            Dim sql As String = "recupera_grupo_configuracion"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_grupo", id_grupo)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Guarda(ByVal id_grupo As Integer, ByVal nombre As String,
            ByVal descripcion As String, ByVal id_empleado_admin As Integer,
            ByVal es_privado As Boolean) As Integer
        Try
            Dim sql As String = "guarda_grupo"

            Dim params As SqlParameter() = New SqlParameter(4) {}
            params(0) = New SqlParameter("id_grupo", id_grupo)
            params(1) = New SqlParameter("nombre", nombre)
            params(2) = New SqlParameter("descripcion", descripcion)
            params(3) = New SqlParameter("id_empleado_admin", id_empleado_admin)
            params(4) = New SqlParameter("es_privado", es_privado)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function Elimina(ByVal id_grupo As Integer) As String
        Try


            Dim mensaje As String = ValidaDependencia(id_grupo)
            If mensaje.Length > 0 Then
                Return mensaje
            Else
                Dim sqlHelp As New SqlHelper(_connString)
                Dim sql As String = "elimina_grupo"

                Dim params As SqlParameter() = New SqlParameter(0) {}
                params(0) = New SqlParameter("id_grupo", id_grupo)


                sqlHelp.ExecuteNonQuery(sql, params)
                Return ""

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function ValidaDependencia(ByVal id_grupo As Integer) As String
        Try
            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "valida_dependencia_grupo"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_grupo", id_grupo)


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

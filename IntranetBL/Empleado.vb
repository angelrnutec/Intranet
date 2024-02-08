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
Public Class Empleado
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Function Recupera(texto As String, sin_jefe_directo As Boolean, Optional id_empresa As Integer = 0) As DataTable
        Try
            Dim sql As String = "recupera_empleado"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("texto", texto)
            params(1) = New SqlParameter("sin_jefe_directo", sin_jefe_directo)
            params(2) = New SqlParameter("id_empresa", id_empresa)


            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPorPermisos(texto As String, id_empresa As Integer, id_empleado As Integer, perfil As String) As DataTable
        Try
            Dim sql As String = "recupera_empleado_por_permisos"

            Dim params As SqlParameter() = New SqlParameter(4) {}
            params(0) = New SqlParameter("texto", texto)
            params(1) = New SqlParameter("id_empresa", id_empresa)
            params(2) = New SqlParameter("id_empleado", id_empleado)
            params(3) = New SqlParameter("reporte", perfil)


            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function NumeroEmpleadoRepetido(numero As String, id_empleado As Integer) As Boolean
        Try
            Dim sql As String = "valida_numero_empleado"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("numero", numero)
            params(1) = New SqlParameter("id_empleado", id_empleado)


            Dim sqlHelp As New SqlHelper(_connString)
            Dim dt As DataTable = sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
            Return IIf(dt.Rows.Count > 0, True, False)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaBusqueda(texto As String) As DataTable
        Try
            Dim sql As String = "recupera_empleado_jefe_busqueda"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("texto", texto)


            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaCumplesDelMes() As DataTable
        Try
            Dim sql As String = "recupera_empleado_cumples"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaPorBusqueda(texto As String) As DataTable
        Try
            Dim sql As String = "recupera_empleado_busqueda"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("texto", texto)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPorId(ByVal id_empleado As Integer) As DataTable
        Try
            Dim sql As String = "recupera_empleado_x_id"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Sub GuardaFotografia(ByVal id_empleado As Integer, foto As String)
        Try
            Dim sql As String = "guarda_empleado_foto"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("foto", foto)


            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Sub GuardaTarjetaGastos(ByVal id_empleado As Integer, ByVal num_tarjeta_gastos As String, ByVal num_tarjeta_gastos_amex As String)
        Try
            Dim sql As String = "guarda_empleado_tarjeta_gastos"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("num_tarjeta_gastos", num_tarjeta_gastos)
            params(2) = New SqlParameter("num_tarjeta_gastos_amex", num_tarjeta_gastos_amex)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Sub CambiarEstatusEmpleado(ByVal id_empleado As Integer, estatus As String)
        Try
            Dim sql As String = "guarda_empleado_estatus"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("estatus", estatus)


            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub GuardaDatosUsuario(ByVal id_empleado As Integer, email As String, usuario As String, password As String, id_localidad As Integer,
                                  num_deudor As String, num_acreedor As String, centro As String, num_tarjeta_gastos As String,
                                  num_tarjeta_gastos_amex As String, permitir_gastos_viaje_cova As Boolean)
        Try
            Dim sql As String = "guarda_empleado_datos"

            Dim params As SqlParameter() = New SqlParameter(11) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("email", email)
            params(2) = New SqlParameter("usuario", usuario)
            params(3) = New SqlParameter("password", password)
            params(4) = New SqlParameter("id_localidad", id_localidad)
            params(5) = New SqlParameter("num_deudor", num_deudor)
            params(6) = New SqlParameter("num_acreedor", num_acreedor)
            params(7) = New SqlParameter("centro", centro)
            params(8) = New SqlParameter("num_tarjeta_gastos", num_tarjeta_gastos)
            params(9) = New SqlParameter("num_tarjeta_gastos_amex", num_tarjeta_gastos_amex)
            params(10) = New SqlParameter("permitir_gastos_viaje_cova", permitir_gastos_viaje_cova)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function GuardaDatosEmpleado(id_empleado As Integer, nombre As String, numero As String, id_empresa As Integer, _
                                   departamento As Integer, fecha_alta As DateTime, fecha_nacimiento As DateTime, num_deudor As String, num_acreedor As String, centro As String) As Integer
        Try
            Dim sql As String = "guarda_empleado_externo"

            Dim params As SqlParameter() = New SqlParameter(10) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("nombre", nombre)
            params(2) = New SqlParameter("numero", numero)
            params(3) = New SqlParameter("id_empresa", id_empresa)
            params(4) = New SqlParameter("departamento", departamento)
            params(5) = New SqlParameter("fecha_alta", fecha_alta)
            params(6) = New SqlParameter("fecha_nacimiento", fecha_nacimiento)
            params(7) = New SqlParameter("num_deudor", num_deudor)
            params(8) = New SqlParameter("num_acreedor", num_acreedor)
            params(9) = New SqlParameter("centro", centro)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function Elimina(ByVal id_empleado As Integer) As String
        Try


            Dim mensaje As String = ValidaDependencia(id_empleado)
            If mensaje.Length > 0 Then
                Return mensaje
            Else
                Dim sqlHelp As New SqlHelper(_connString)
                Dim sql As String = "elimina_empleado"

                Dim params As SqlParameter() = New SqlParameter(0) {}
                params(0) = New SqlParameter("id_empleado", id_empleado)


                sqlHelp.ExecuteNonQuery(sql, params)
                Return ""

            End If




        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function ValidaDependencia(ByVal id_empleado As Integer) As String
        Try
            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "valida_dependencia_empleado"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)


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


    Public Sub AsignaJefeDirecto(id_empleado As Integer, id_jefe_directo As Integer, tipo_asignacion As Integer)
        Try
            Dim sql As String = "asigna_jefe_directo_empleado"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("id_jefe_directo", id_jefe_directo)
            params(2) = New SqlParameter("tipo_asignacion", tipo_asignacion)


            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub QuitarJefeArea(id_empleado As Integer)
        Try
            Dim sql As String = "elimina_jefe_area_empleado"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Sub QuitarGerente(id_empleado As Integer)
        Try
            Dim sql As String = "elimina_gerente_empleado"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Sub QuitarJefeDirecto(id_empleado As Integer)
        Try
            Dim sql As String = "elimina_jefe_directo_empleado"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
    Public Sub CambioPassword(ByVal id_empleado As Integer, password_anterior As String, password As String)
        Try
            Dim sql As String = "cambio_password_empleado"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("password_anterior", password_anterior)
            params(2) = New SqlParameter("password", password)


            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function RecuperaEmpleadoPerfil(id_empleado As Integer) As DataSet
        Try
            Dim sql As String = "recupera_empleado_perfil"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)


            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub EliminaEmpleadoPerfil(ByVal id_empleado As Integer)
        Try

            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "elimina_empleado_perfil"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)


            sqlHelp.ExecuteNonQuery(sql, params)

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub GuardaEmpleadoPerfil(ByVal id_empleado As Integer, ByVal id_perfil As Integer)
        Try

            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "guarda_empleado_perfil"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("id_perfil", id_perfil)


            sqlHelp.ExecuteNonQuery(sql, params)

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function RecuperaReciboNomina(ByVal id_empleado As Integer, ByVal fecha_inicio As String, ByVal fecha_fin As String) As DataTable
        Try
            Dim sql As String = "recupera_recibo_nomina"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("fecha_inicio", fecha_inicio)
            params(2) = New SqlParameter("fecha_fin", fecha_fin)


            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmpresasEmpleado() As DataTable
        Try
            Dim sql As String = "recupera_empresas_empleados"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaDepartamentoPorEmpresa(ByVal id_empresa As Integer) As DataTable
        Try
            Dim sql As String = "recupera_departamento_x_empresa"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


End Class

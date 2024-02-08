Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports IntranetDA

Public Class Seguridad
    Private _connString As String = ""
    Public Sub New(connString As String)
        _connString = connString
    End Sub


    Public Function ValidaLogin(usuario As String, password As String, ip As String) As DataSet
        Try
            Dim sql As String = "valida_login"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("usuario", usuario)
            params(1) = New SqlParameter("password", password)
            params(2) = New SqlParameter("ip", ip)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ValidaPermisoPagina(id_empleado As Integer, id_pagina As Integer) As Boolean
        Try
            Dim sql As String = "valida_permiso_pagina"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("id_pagina", id_pagina)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
           
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function RepSeguridadUsuarios() As DataTable
        Try
            Dim sql As String = "rpt_seguridad_empleados"
            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaParametrosGenerales() As DataTable
        Try
            Dim sql As String = "recupera_parametros_generales"
            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function GuardaPerfil(id_perfil As Integer, nombre As String) As DataTable
        Try
            Dim sql As String = "guarda_perfil"
            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_perfil", id_perfil)
            params(1) = New SqlParameter("nombre", nombre)
            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub EliminaPerfil(id_perfil As Integer)
        Try
            Dim sql As String = "elimina_perfil"
            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_perfil", id_perfil)
            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function RecuperaPaginasDisponibles(id_perfil) As DataTable
        Try
            Dim sql As String = "recupera_paginas_disponibles"
            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_perfil", id_perfil)
            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPaginasAsignadas(id_perfil) As DataTable
        Try
            Dim sql As String = "recupera_paginas_asignadas"
            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_perfil", id_perfil)
            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPerfiles(texto As String) As DataTable
        Try
            Dim sql As String = "recupera_perfiles"
            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("texto", texto)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub GuardaParametrosGenerales(id_usuario_pagos_nc As Integer, id_usuario_pagos_nb As Integer, id_usuario_pagos_nf As Integer,
                                         vencimiento_password_intranet_dias As Integer, vencimiento_password_nomina_dias As Integer,
                                         monto_limite_compra_materiales As Decimal, id_director_operaciones_nc As Integer,
                                         id_director_operaciones_nb As Integer, id_director_operaciones_nf As Integer,
                                         id_director_ns As Integer, id_director_nb As Integer, id_director_nf As Integer,
                                         email_notificacion_datos_telefonia As String, monto_limite_comidas_internas As Decimal,
                                         id_usuario_comidas_internas_nc As Integer, id_usuario_comidas_internas_nb As Integer,
                                         id_usuario_comidas_internas_nf As Integer, id_director_ne As Integer, id_director_nu As Integer,
                                         id_director_finanzas_ns As Integer, id_director_finanzas_nb As Integer, id_director_finanzas_nf As Integer,
                                         id_director_finanzas_ne As Integer, id_director_finanzas_nu As Integer, id_director_rh As Integer,
                                         id_autoriza_materiales As Integer, id_verifica_vacaciones_guardias_nf As Integer)

        Try
            Dim sql As String = "guarda_parametros_generales"

            Dim params As SqlParameter() = New SqlParameter(26) {}
            params(0) = New SqlParameter("id_usuario_pagos_nc", id_usuario_pagos_nc)
            params(1) = New SqlParameter("id_usuario_pagos_nb", id_usuario_pagos_nb)
            params(2) = New SqlParameter("id_usuario_pagos_nf", id_usuario_pagos_nf)
            params(3) = New SqlParameter("vencimiento_password_intranet_dias", vencimiento_password_intranet_dias)
            params(4) = New SqlParameter("vencimiento_password_nomina_dias", vencimiento_password_nomina_dias)
            params(5) = New SqlParameter("monto_limite_compra_materiales", monto_limite_compra_materiales)
            params(6) = New SqlParameter("id_director_operaciones_nc", id_director_operaciones_nc)
            params(7) = New SqlParameter("id_director_operaciones_nb", id_director_operaciones_nb)
            params(8) = New SqlParameter("id_director_operaciones_nf", id_director_operaciones_nf)

            params(9) = New SqlParameter("id_director_ns", id_director_ns)
            params(10) = New SqlParameter("id_director_nb", id_director_nb)
            params(11) = New SqlParameter("id_director_nf", id_director_nf)
            params(12) = New SqlParameter("email_notificacion_datos_telefonia", email_notificacion_datos_telefonia)

            params(13) = New SqlParameter("monto_limite_comidas_internas", monto_limite_comidas_internas)
            params(14) = New SqlParameter("id_usuario_comidas_internas_nc", id_usuario_comidas_internas_nc)
            params(15) = New SqlParameter("id_usuario_comidas_internas_nb", id_usuario_comidas_internas_nb)
            params(16) = New SqlParameter("id_usuario_comidas_internas_nf", id_usuario_comidas_internas_nf)

            params(17) = New SqlParameter("id_director_ne", id_director_ne)
            params(18) = New SqlParameter("id_director_nu", id_director_nu)
            params(19) = New SqlParameter("id_director_finanzas_ns", id_director_finanzas_ns)
            params(20) = New SqlParameter("id_director_finanzas_nb", id_director_finanzas_nb)
            params(21) = New SqlParameter("id_director_finanzas_nf", id_director_finanzas_nf)
            params(22) = New SqlParameter("id_director_finanzas_ne", id_director_finanzas_ne)
            params(23) = New SqlParameter("id_director_finanzas_nu", id_director_finanzas_nu)
            params(24) = New SqlParameter("id_director_rh", id_director_rh)
            params(25) = New SqlParameter("id_autoriza_materiales", id_autoriza_materiales)
            params(26) = New SqlParameter("id_verifica_vacaciones_guardias_nf", id_verifica_vacaciones_guardias_nf)


            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function NominaLogin(id_empleado As Integer, password As String) As DataSet
        Try
            Dim sql As String = "valida_login_nomina"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("password", password)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub GuardaLogDatos(texto As String, Optional long_text As String = "")
        Try
            Dim sql As String = "guarda_log_datos"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("texto", texto)
            params(1) = New SqlParameter("long_text", long_text)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub RegeneraPassword(usuario As String, ip As String, codigo As String)
        Try
            Dim sql As String = "guarda_resetear_password"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("codigo", codigo)
            params(1) = New SqlParameter("ip", ip)
            params(2) = New SqlParameter("usuario", usuario)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub RegeneraPasswordGuarda(usuario As String, password As String)
        Try
            Dim sql As String = "cambio_password_empleado_solicitud"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("usuario", usuario)
            params(1) = New SqlParameter("password", password)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Sub PasswordNominaGuarda(usuario As String, password As String)
        Try
            Dim sql As String = "guarda_password_nomina"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("usuario", usuario)
            params(1) = New SqlParameter("password", password)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function RecuperaResetearPassword(codigo As String) As String
        Try
            Dim sql As String = "recupera_resetear_password"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("codigo", codigo)

            Dim sqlHelp As New SqlHelper(_connString)
            Dim dt As DataTable = sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
            If dt.Rows.Count > 0 Then
                Return dt.Rows(0)("usuario")
            Else
                Return ""
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPermisosEmpleado(ByVal id_empleado As Integer) As DataTable
        Try
            Dim sql As String = "recupera_permisos_empleado"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaRecibosBloqueados() As DataTable
        Try
            Dim sql As String = "recupera_empleado_nomina_firma_bloqueos"

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function RecuperaNominaFirma(ByVal id_empleado As Integer, anio As Integer, periodo As Integer) As DataSet
        Try
            Dim sql As String = "recupera_empleado_nomina_firma"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("anio", anio)
            params(2) = New SqlParameter("periodo", periodo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Sub GuardaNominaFirma(id_empleado As Integer, anio As Integer, periodo As Integer, tipo As String)
        Try
            Dim sql As String = "guarda_empleado_nomina_firma"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("anio", anio)
            params(2) = New SqlParameter("periodo", periodo)
            params(3) = New SqlParameter("tipo", tipo)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub



    Public Sub EliminaPaginasPerfil(ByVal id_perfil As Integer)
        Try
            Dim sql As String = "elimina_paginas_perfil"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_perfil", id_perfil)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub GuardaPaginasPerfil(ByVal id_perfil As Integer, paginas As String)
        Try
            Dim sql As String = "guarda_paginas_perfil"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_perfil", id_perfil)
            params(1) = New SqlParameter("paginas", paginas)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function RecuperaUsuarioEncriptado(ByVal id_empleado As Integer) As String
        Try
            Dim sql As String = "recupera_usuario_encriptado"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteScalarS(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
End Class
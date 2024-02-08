Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports IntranetDA


Public Class Combos
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub

    Public Function RecuperaTipoAutos() As DataTable
        Try
            Dim sql As String = "recupera_arrendamiento_tipo_auto"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmpresas() As DataTable
        Try
            Dim sql As String = "recupera_empresas"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaMonedas() As DataTable
        Try
            Dim sql As String = "recupera_moneda"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaLocalidades() As DataTable
        Try
            Dim sql As String = "recupera_localidades"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaArrendamientoTipo() As DataTable
        Try
            Dim sql As String = "recupera_arrendamiento_archivo_tipo"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmpresasConsolidado() As DataTable
        Try
            Dim sql As String = "recupera_empresas_consolidado"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaTipoPermiso() As DataTable
        Try
            Dim sql As String = "recupera_solicitud_permisos_tipo_combo"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmpresaRepSolicitudes(id_empleado As Integer, reporte As String) As DataTable
        Try
            Dim sql As String = "recupera_empresas_rep_solicitudes"
            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("reporte", reporte)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmpresaRepTelefonia(id_empleado As Integer, reporte As String) As DataTable
        Try
            Dim sql As String = "recupera_empresas_rep_telefonia"
            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("reporte", reporte)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaAutorizaDireccion(id_empleado As Integer) As DataTable
        Try
            Dim sql As String = "recupera_autoriza_direccion"
            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaCategoriaArrendamiento(id_empleado As Integer) As DataTable
        Try
            Dim sql As String = "recupera_categoria_arrendamiento_combo"
            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmpresaArrendamiento(id_empleado As Integer) As DataTable
        Try
            Dim sql As String = "recupera_empresa_arrendamiento_combo"
            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function RecuperaAutorizaGerente(id_empleado As Integer) As DataTable
        Try
            Dim sql As String = "recupera_autoriza_gerente"
            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmpleadosRepSolicitudes(id_empresa As Integer, id_empleado As Integer, reporte As String) As DataTable
        Try
            Dim sql As String = "recupera_empleado_rep_solicitudes"
            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("id_empleado", id_empleado)
            params(2) = New SqlParameter("reporte", reporte)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function
    Public Function RecuperaEmpleadosRepSolicitudes(id_empresa As Integer, id_empleado As Integer, reporte As String, texto As String) As DataTable
        Try
            Dim sql As String = "recupera_empleado_rep_solicitudes"
            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("id_empleado", id_empleado)
            params(2) = New SqlParameter("reporte", reporte)
            params(3) = New SqlParameter("texto", texto)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmpleadosRepTelefonia(id_empresa As Integer, id_empleado As Integer, reporte As String) As DataTable
        Try
            Dim sql As String = "recupera_empleado_rep_telefonia"
            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("id_empleado", id_empleado)
            params(2) = New SqlParameter("reporte", reporte)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaProveedorTelefonica() As DataTable
        Try
            Dim sql As String = "recupera_telefonia_proveedor"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaReportes(tipo As Integer)
        Try
            Dim sql As String = "recupera_reporte"
            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("tipo", tipo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaSolicitudEmpresa() As DataTable
        Try
            Dim sql As String = "recupera_solicitud_empresa"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEstatusRepGastosViaje() As DataTable
        Try
            Dim sql As String = "recupera_rep_solicitud_gastos_estatus"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmpleados(id_empresa As Integer, Optional titulo As String = "") As DataTable
        Try
            Dim sql As String = "recupera_empleado_combo"

            Dim sqlHelp As New SqlHelper(_connString)

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("titulo", titulo)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmpleadosDepartamento(id_empresa As Integer, departamento As String, Optional titulo As String = "") As DataTable
        Try
            Dim sql As String = "recupera_empleado_departamento_combo"

            Dim sqlHelp As New SqlHelper(_connString)

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("titulo", titulo)
            params(2) = New SqlParameter("departamento", departamento)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperCategoriaAviso(titulo As String) As DataTable
        Try
            Dim sql As String = "recupera_categoria_aviso"

            Dim sqlHelp As New SqlHelper(_connString)

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("titulo", titulo)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaEstatusRepReposicionGastos() As DataTable
        Try
            Dim sql As String = "recupera_rep_solicitud_reposicion_estatus"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEstatusRepPermisos() As DataTable
        Try
            Dim sql As String = "recupera_rep_solicitud_permisos_estatus"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEstatusRepVacaciones() As DataTable
        Try
            Dim sql As String = "recupera_rep_solicitud_vacaciones_estatus"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaSolicitudVacacionesEmpresa(id_empleado As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_vacaciones_empresa"
            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaSolicitudEmpleado(id_empresa As Integer, id_empleado_incluir As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_empleado"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("id_empleado_incluir", id_empleado_incluir)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaAutorizaJefe(id_empleado As Integer, id_empleado_incluir As Integer) As DataTable
        Try
            Dim sql As String = "recupera_autoriza_jefe"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("id_empleado_incluir", id_empleado_incluir)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaAutorizaJefeVacaciones(id_empleado As Integer, id_empleado_incluir As Integer) As DataTable
        Try
            Dim sql As String = "recupera_autoriza_jefe_vacaciones"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("id_empleado_incluir", id_empleado_incluir)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaAutorizaConta(id_empresa As Integer, id_empleado_incluir As Integer, id_empleado_consulta As Integer) As DataTable
        Try
            Dim sql As String = "recupera_autoriza_conta"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("id_empleado_incluir", id_empleado_incluir)
            params(2) = New SqlParameter("id_empleado_consulta", id_empleado_consulta)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function RecuperaAutorizaNomina(id_empresa As Integer, id_empleado_incluir As Integer, id_solicitante As Integer) As DataTable
        Try
            Dim sql As String = "recupera_autoriza_nomina"
            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("id_empleado_incluir", id_empleado_incluir)
            params(2) = New SqlParameter("id_solicitante", id_solicitante)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaSolicitudDepartamento(id_empleado As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_departamento"
            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaSolicitudDepartamentoCombo(id_empleado As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_departamento_combo"
            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaCentroCosto(ByVal id_empresa As Integer, texto As String, id_empleado_consulta As Integer) As DataTable
        Try
            Dim sql As String = "recupera_centro_costo_combo"
            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("texto", texto)
            params(2) = New SqlParameter("id_empleado_consulta", id_empleado_consulta)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaNecesidad(ByVal id_empresa As Integer, tipo As String) As DataTable
        Try
            Dim sql As String = "recupera_necesidad_combo"
            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("tipo", tipo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaAnio(ByVal tipo As String) As DataTable
        Try
            Dim dt As DataTable = New DataTable
            Dim dr As DataRow = dt.NewRow()

            dt.Columns.Add("id_anio")
            dt.Columns.Add("anio")

            If tipo = "S" Then
                dr("id_anio") = "0"
                dr("anio") = "--Seleccione--"
                dt.Rows.Add(dr)
                dr = dt.NewRow()

            ElseIf tipo = "T" Then
                dr("id_anio") = "0"
                dr("anio") = "--Todos--"
                dt.Rows.Add(dr)
                dr = dt.NewRow()

            End If

            Dim i As Integer = 0

            For i = 2010 To Now.Year + 1
                dr("id_anio") = i
                dr("anio") = i
                dt.Rows.Add(dr)
                dr = dt.NewRow()
            Next

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaQuincenas(tipo As String) As DataTable
        Try
            Dim sql As String = "recupera_quincenas_combo"
            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("tipo", tipo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaQuincenasEmpleado(tipo As String, id_empleado As Integer) As DataTable
        Try
            Dim sql As String = "recupera_quincenas_empleado_combo"
            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("tipo", tipo)
            params(1) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmpresasConcepto(ByVal tipo As String) As DataTable
        Try
            Dim sql As String = "recupera_empresas_concepto"
            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("tipo", tipo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaConceptoPadre(ByVal id_reporte As Integer) As DataTable
        Try
            Dim sql As String = "recupera_concepto_padre"
            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_reporte", id_reporte)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaReportesConcepto()
        Try
            Dim sql As String = "recupera_reporte_concepto"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaMes(ByVal tipo As String) As DataTable
        Try
            Dim dt As DataTable = New DataTable
            Dim dr As DataRow = dt.NewRow()

            dt.Columns.Add("id_mes")
            dt.Columns.Add("mes")

            If tipo = "S" Then
                dr("id_mes") = "0"
                dr("mes") = "--Seleccione--"
                dt.Rows.Add(dr)
                dr = dt.NewRow()

            ElseIf tipo = "T" Then
                dr("id_mes") = "0"
                dr("mes") = "--Todos--"
                dt.Rows.Add(dr)
                dr = dt.NewRow()

            End If

            dr("id_mes") = "1"
            dr("mes") = "Enero"
            dt.Rows.Add(dr)
            dr = dt.NewRow()

            dr("id_mes") = "2"
            dr("mes") = "Febrero"
            dt.Rows.Add(dr)
            dr = dt.NewRow()

            dr("id_mes") = "3"
            dr("mes") = "Marzo"
            dt.Rows.Add(dr)
            dr = dt.NewRow()

            dr("id_mes") = "4"
            dr("mes") = "Abril"
            dt.Rows.Add(dr)
            dr = dt.NewRow()

            dr("id_mes") = "5"
            dr("mes") = "Mayo"
            dt.Rows.Add(dr)
            dr = dt.NewRow()

            dr("id_mes") = "6"
            dr("mes") = "Junio"
            dt.Rows.Add(dr)
            dr = dt.NewRow()

            dr("id_mes") = "7"
            dr("mes") = "Julio"
            dt.Rows.Add(dr)
            dr = dt.NewRow()

            dr("id_mes") = "8"
            dr("mes") = "Agosto"
            dt.Rows.Add(dr)
            dr = dt.NewRow()

            dr("id_mes") = "9"
            dr("mes") = "Septiembre"
            dt.Rows.Add(dr)
            dr = dt.NewRow()

            dr("id_mes") = "10"
            dr("mes") = "Octubre"
            dt.Rows.Add(dr)
            dr = dt.NewRow()

            dr("id_mes") = "11"
            dr("mes") = "Noviembre"
            dt.Rows.Add(dr)
            dr = dt.NewRow()

            dr("id_mes") = "12"
            dr("mes") = "Diciembre"
            dt.Rows.Add(dr)
            dr = dt.NewRow()

            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmpresaConceptoGasto(tipo As Integer, Optional ByVal id_usuario As Integer = 0) As DataTable
        Try
            Dim sql As String = "recupera_empresas_cuentas_contables"
            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("tipo", tipo)
            params(1) = New SqlParameter("id_usuario", id_usuario)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaGastosNSClasificacion(ByVal tipo As String) As DataTable
        Try
            Dim sql As String = "recupera_gastos_ns_clasificacion_combo"
            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("tipo", tipo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

    End Function


    Public Function RecuperaTipoArrendamiento() As DataTable
        Try
            Dim sql As String = "recupera_tipo_arrendamientos_combo"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPeriodicidadArrendamiento() As DataTable
        Try
            Dim sql As String = "recupera_periodicidad_arrendamientos_combo"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaArrendadoras() As DataTable
        Try
            Dim sql As String = "recupera_arrendadoras_combo"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaAseguradoras() As DataTable
        Try
            Dim sql As String = "recupera_aseguradoras_combo"

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function




End Class

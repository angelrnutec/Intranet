Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports IntranetDA

Public Class GastosNS
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Function RecuperaGastos(id_empresa As Integer, fecha_ini As DateTime,
                                   fecha_fin As DateTime, moneda As String,
                                   id_empleado_consulta As Integer) As DataTable
        Try
            Dim sql As String = "recupera_gastos_ns"

            Dim params As SqlParameter() = New SqlParameter(5) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("fecha_ini", fecha_ini)
            params(2) = New SqlParameter("fecha_fin", fecha_fin)
            params(3) = New SqlParameter("moneda", moneda)
            params(4) = New SqlParameter("id_empleado_consulta", id_empleado_consulta)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function RecuperaGastosExcel(id_empresa As Integer, fecha_ini As DateTime,
                                   fecha_fin As DateTime, moneda As String,
                                   id_empleado_consulta As Integer) As DataTable
        Try
            Dim sql As String = "recupera_gastos_ns_excel"

            Dim params As SqlParameter() = New SqlParameter(5) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("fecha_ini", fecha_ini)
            params(2) = New SqlParameter("fecha_fin", fecha_fin)
            params(3) = New SqlParameter("moneda", moneda)
            params(4) = New SqlParameter("id_empleado_consulta", id_empleado_consulta)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try

    End Function

    Public Function Guarda(id_empresa As Integer, centro_costo As String, tipo_costo As String, denom_tipo_costo As String,
                        monto As Decimal, clasificacion As String, cta_comp As String, denom_cta_comp As String, fecha As DateTime,
                        num_documento As String, texto_cabecera As String, denominacion As String, fecha_ini As DateTime,
                        fecha_fin As DateTime) As Integer
        Try
            Dim sql As String = "guarda_gastos_ns"

            Dim params As SqlParameter() = New SqlParameter(14) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("centro_costo", centro_costo)
            params(2) = New SqlParameter("tipo_costo", tipo_costo)
            params(3) = New SqlParameter("denom_tipo_costo", denom_tipo_costo)
            params(4) = New SqlParameter("monto", monto)
            params(5) = New SqlParameter("clasificacion", clasificacion)
            params(6) = New SqlParameter("cta_comp", cta_comp)
            params(7) = New SqlParameter("denom_cta_comp", denom_cta_comp)
            params(8) = New SqlParameter("fecha", fecha)
            params(9) = New SqlParameter("num_documento", num_documento)
            params(10) = New SqlParameter("texto_cabecera", texto_cabecera)
            params(11) = New SqlParameter("denominacion", denominacion)
            params(12) = New SqlParameter("fecha_ini", fecha_ini)
            params(13) = New SqlParameter("fecha_fin", fecha_fin)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function GuardaTabla(id_empresa As Integer, dt As DataTable, fecha_ini As DateTime, fecha_fin As DateTime) As Integer
        Try
            Dim contador As Integer = 0
            Dim indicador As Integer = 0
            'Dim sql As String = "guarda_gastos_ns"
            Dim sqlHelp As New SqlHelper(_connString)

            Dim sqlStr As New StringBuilder("")
            Dim inserta_header As Boolean = True


            For Each dr As DataRow In dt.Rows
                If Trim(dr("KOSTL")) <> "" And _
                    Trim(dr("KOSTL")) <> "Ce.cost" And _
                    dr("KOSTL").ToString().IndexOf("*") < 0 And _
                    Trim(dr("KOSTL")).IndexOf("La lista") < 0 And _
                    Trim(dr("KSTAR")) <> "" < 0 Then



                    contador += 1
                    indicador += 1

                    If indicador = 100 Then
                        indicador = 0
                        sqlHelp.ExecuteNonQuery(sqlStr.ToString())
                        inserta_header = True
                        sqlStr = New StringBuilder("")
                    End If

                    If inserta_header Then
                        inserta_header = False
                        sqlStr.AppendLine("insert into gastos_ns (id_empresa,centro_costo,tipo_costo,denom_tipo_costo,monto, clasificacion, cta_comp, denom_cta_comp,")
                        sqlStr.AppendLine("fecha,num_documento, texto_cabecera, denominacion,fecha_registro,fecha_ini,fecha_fin)")
                    Else
                        sqlStr.AppendLine("UNION ALL")
                    End If

                    sqlStr.AppendLine(String.Format("select {0},'{1}','{2}','{3}',{4},'{5}','{6}','{7}','{8}','{9}','{10}','{11}', getdate(),'{12}','{13}'", _
                                                    id_empresa, Trim(dr("KOSTL")), Trim(dr("KSTAR")), Trim(dr("KAEP_CEKTX")), ConvertToAmount(Trim(dr("RKGXXX"))), Trim(dr("GKOAR")), _
                                                    Trim(dr("GKONT")), Trim(dr("GKONT_KTXT")), ConvertToSQLDate(Trim(dr("CO_BUDAT"))), Trim(dr("CO_REFBN")), _
                                                    Trim(dr("CO_BLTXT")), Trim(dr("CO_SGTXT")), fecha_ini.ToString("yyyyMMdd"), fecha_fin.ToString("yyyyMMdd")))

                End If
            Next

            If indicador > 0 Then
                sqlHelp.ExecuteNonQuery(sqlStr.ToString())
            End If

            Return contador
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function GuardaTablaPresupuestos(dt As DataTable, anio As Integer) As Integer
        Try
            Dim contador As Integer = 0
            Dim indicador As Integer = 0
            'Dim sql As String = "guarda_gastos_ns_presupuesto"
            Dim sqlHelp As New SqlHelper(_connString)

            Dim sqlStr As New StringBuilder("")
            Dim inserta_header As Boolean = True


            If dt.Rows.Count > 0 Then
                sqlHelp.ExecuteNonQuery("delete from gastos_ns_presupuesto where anio = " & anio)
            End If

            For Each dr As DataRow In dt.Rows

                contador += 1
                indicador += 1

                If indicador = 100 Then
                    indicador = 0
                    sqlHelp.ExecuteNonQuery(sqlStr.ToString())
                    inserta_header = True
                    sqlStr = New StringBuilder("")
                End If

                If inserta_header Then
                    inserta_header = False
                    sqlStr.AppendLine("insert into gastos_ns_presupuesto (centro_costo, concepto, anio, monto, tipo_cambio)")
                Else
                    sqlStr.AppendLine("UNION ALL")
                End If

                sqlStr.AppendLine(String.Format("select '{0}','{1}',{2},{3},{4}", _
                                                Right(Trim(dr("KOSTL")), 6), Trim(dr("KSTAR")), anio, Trim(dr("WTG00")), Trim(dr("UKURS"))))


            Next

            If indicador > 0 Then
                sqlHelp.ExecuteNonQuery(sqlStr.ToString())
            End If

            Return contador
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function ConvertToSQLDate(text As String) As String
        If text.Length = 10 Then
            Dim dia As String = text.Substring(0, 2)
            Dim mes As String = text.Substring(3, 2)
            Dim anio As String = text.Substring(6, 4)
            Return anio & mes & dia
        End If
        Return "19000101"
    End Function

    Public Function ConvertToAmount(text As String) As String
        text = text.Replace(".", "")
        text = text.Replace(",", ".")

        'text = text.Replace(",", "")
        If text.IndexOf("-") > 0 Then
            text = "-" & text.Replace("-", "")
        End If
        If IsNumeric(text) Then
            Return text
        End If
        Return 0
    End Function



    Public Function GastosSinClasificar(ByVal id_empresa As Integer, fecha_ini As DateTime) As DataTable
        Try

            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "recupera_gastos_ns_sin_clasificar"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("fecha_inicio", fecha_ini)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Elimina(ByVal id_empresa As Integer, fecha_ini As DateTime, fecha_fin As DateTime) As String
        Try

            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "elimina_gastos_ns"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)
            params(1) = New SqlParameter("fecha_ini", fecha_ini)
            params(2) = New SqlParameter("fecha_fin", fecha_fin)

            sqlHelp.ExecuteNonQuery(sql, params)
            Return ""

            'End If

        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaClasificacion(ByVal tipo As Integer, ByVal id_clasificacion_costo As Integer) As DataTable
        Try
            Dim sql As String = "recupera_gastos_ns_clasificacion"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("tipo", tipo)
            params(1) = New SqlParameter("id_clasificacion_costo", id_clasificacion_costo)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function GuardaClasificacion(ByVal id_clasificacion_costo As Integer, descripcion As String) As DataTable
        Try

            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "guarda_gastos_ns_clasificacion"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_clasificacion_costo", id_clasificacion_costo)
            params(1) = New SqlParameter("descripcion", descripcion)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function GuardaClasificacionDetalle(ByVal id_detalle As Integer, ByVal id_clasificacion_costo As Integer, descripcion As String) As DataTable
        Try

            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "guarda_gastos_ns_clasificacion_detalle"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_detalle", id_detalle)
            params(1) = New SqlParameter("id_clasificacion_costo", id_clasificacion_costo)
            params(2) = New SqlParameter("descripcion", descripcion)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function EliminaClasificacionDetalle(ByVal id_detalle As Integer) As DataTable
        Try

            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "elimina_gastos_ns_clasificacion_detalle"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_detalle", id_detalle)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaExcepcion(ByVal tipo As Integer) As DataTable
        Try
            Dim sql As String = "recupera_gastos_ns_excepciones"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("tipo", tipo)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaConceptos(ByVal texto As String) As DataTable
        Try
            Dim sql As String = "recupera_conceptos_gastos_ns"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("texto", texto)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaConceptoPorId(ByVal id_clasificacion_costo As Integer) As DataTable
        Try
            Dim sql As String = "recupera_conceptos_gastos_ns_x_id"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_clasificacion_costo", id_clasificacion_costo)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function EliminaExcepcion(ByVal id As Integer) As DataTable
        Try

            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "elimina_gastos_ns_excepciones"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id", id)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function GuardaExcepcion(ByVal id As Integer, ByVal tipo_costo As String, centro_costo As String) As DataTable
        Try

            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "guarda_gastos_ns_excepciones"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id", id)
            params(1) = New SqlParameter("tipo_costo", tipo_costo)
            params(2) = New SqlParameter("centro_costo", centro_costo)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

End Class

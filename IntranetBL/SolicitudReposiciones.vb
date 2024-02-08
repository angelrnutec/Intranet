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
Public Class SolicitudReposiciones
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub



    Public Function Recupera(ByVal id_usuario As Integer, ByVal folio_txt As String) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_reposicion"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_usuario", id_usuario)
            params(1) = New SqlParameter("folio_txt", folio_txt)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RequiereAutorizacionDeMateriales(id_solicitud As Integer, valida_ya_autorizado As Boolean) As Boolean
        Try
            Dim sql As String = "solicitud_reposicion_requiere_autorizacion_materiales"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("valida_ya_autorizado", valida_ya_autorizado)


            Dim sqlHelp As New SqlHelper(_connString)
            Dim dt As DataTable = sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
            Return dt.Rows(0)("resultado")
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RequiereAutorizacionDeComidasInternas(id_solicitud As Integer) As Boolean
        Try
            Dim sql As String = "solicitud_reposicion_requiere_autorizacion_comidas_internas"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)


            Dim sqlHelp As New SqlHelper(_connString)
            Dim dt As DataTable = sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
            Return dt.Rows(0)("resultado")
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RequiereAutorizacionDeOperaciones(id_solicitud As Integer) As Boolean
        Try
            Dim sql As String = "solicitud_reposicion_requiere_autorizacion_operaciones"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)


            Dim sqlHelp As New SqlHelper(_connString)
            Dim dt As DataTable = sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
            Return dt.Rows(0)("resultado")
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaConceptos(id_solicitud As Integer, locale As String) As DataSet
        Try
            Dim sql As String = "recupera_solicitud_reposicion_detalle"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("locale", locale)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaConceptosDesc(id_solicitud As Integer, locale As String) As DataSet
        Try
            Dim sql As String = "recupera_solicitud_reposicion_detalle_desc"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("locale", locale)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaPoliza(id_solicitud As Integer) As DataTable
        Try
            Dim sql As String = "genera_poliza_contable_reposicion_individual"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaTablaResumen(id_solicitud As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_reposicion_tabla_resumen"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaFormaPago(id_empresa As Integer) As DataTable
        Try
            Dim sql As String = "recupera_forma_pago"
            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empresa", id_empresa)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Sub GuardaMotivoRechazo(id_solicitud As Integer, motivo As String)
        Try
            Dim sql As String = "guarda_solicitud_reposicion_motivo_rechazo"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("motivo", motivo)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function RecuperaPorComprobar(ByVal id_usuario As Integer, ByVal folio_txt As String) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_reposicion_por_comprobar"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_usuario", id_usuario)
            params(1) = New SqlParameter("folio_txt", folio_txt)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Sub CambiaEstatus(id_solicitud As Integer, id_empleado As Integer, tipo As Integer, valor As Boolean)
        Try
            Dim sql As String = "guarda_solicitud_reposicion_autorizacion"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("id_empleado", id_empleado)
            params(2) = New SqlParameter("tipo", tipo)
            params(3) = New SqlParameter("valor", valor)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Sub CambiaEstatusMail(id_solicitud As Integer, id_empleado As Integer, tipo As Integer, valor As Boolean)
        Try
            Dim sql As String = "guarda_solicitud_reposicion_autorizacion_mail"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("id_empleado", id_empleado)
            params(2) = New SqlParameter("tipo", tipo)
            params(3) = New SqlParameter("valor", valor)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Sub EliminaComprobante(id_detalle As Integer)
        Try
            Dim sql As String = "elimina_solicitud_reposicion_comprobante"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_detalle", id_detalle)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function RecuperaAuth(ByVal id_usuario As Integer, ByVal folio_txt As String) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_reposicion_auth1"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_usuario", id_usuario)
            params(1) = New SqlParameter("folio_txt", folio_txt)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaRealizado(ByVal id_usuario As Integer, ByVal folio_txt As String) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_reposicion_realizado"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_usuario", id_usuario)
            params(1) = New SqlParameter("folio_txt", folio_txt)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function EmpleadoTieneNumDeudor(ByVal id_empleado As Integer) As Boolean
        Try
            Dim sql As String = "valida_num_deudor_existente"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)


            Dim sqlHelp As New SqlHelper(_connString)
            Dim respuesta As Integer = sqlHelp.ExecuteScalar(sql, params)

            Return IIf(respuesta = 1, True, False)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPorId(ByVal id_solicitud As Integer, ByVal id_usuario_consulta As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_reposicion_x_id"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("id_usuario_consulta", id_usuario_consulta)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPorIdDesc(ByVal id_solicitud As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_reposicion_x_id_desc"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function Guarda(ByVal id_solicitud As Integer, ByVal id_empleado_solicita As Integer, ByVal id_autoriza_jefe As Integer,
                           ByVal id_autoriza_conta As Integer, ByVal id_departamento As Integer, ByVal comentarios As String,
                           ByVal id_empresa As Integer, ByVal tipo_comprobantes As String, ByVal id_empleado_viaja As Integer,
                           Optional ByVal version_api As String = "") As DataTable
        Try
            Dim sql As String = "guarda_solicitud_reposicion"

            Dim params As SqlParameter() = New SqlParameter(9) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("id_empleado_solicita", id_empleado_solicita)
            params(2) = New SqlParameter("id_autoriza_jefe", id_autoriza_jefe)
            params(3) = New SqlParameter("id_autoriza_conta", id_autoriza_conta)
            params(4) = New SqlParameter("id_departamento", id_departamento)
            params(5) = New SqlParameter("comentarios", comentarios)
            params(6) = New SqlParameter("id_empresa", id_empresa)
            params(7) = New SqlParameter("tipo_comprobantes", tipo_comprobantes)
            params(8) = New SqlParameter("id_empleado_viaja", id_empleado_viaja)
            params(9) = New SqlParameter("version_api", version_api)



            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function GuardaConceptoReposicion(id_detalle As Integer, id_solicitud As Integer, id_concepto As Integer, subtotal As Decimal,
                                   iva As Decimal, moneda As String, tipo_cambio As Decimal, fecha_comprobante As Date, id_forma_pago As Integer,
                                   orden_interna As String, no_necesidad As String, observaciones As String, id_centro_costo As Integer,
                                   id_necesidad As Integer, tipo_concepto As String, otros_impuestos As Decimal, retencion As Decimal,
                                   id_empresa_reembolso As Integer, propina As Decimal, id_movimiento_tarjeta As Integer, retencion_resico As Decimal) As Integer
        Try
            Dim sql As String = "guarda_solicitud_reposicion_detalle"

            Dim params As SqlParameter() = New SqlParameter(20) {}
            params(0) = New SqlParameter("id_detalle", id_detalle)
            params(1) = New SqlParameter("id_solicitud", id_solicitud)
            params(2) = New SqlParameter("id_concepto", id_concepto)
            params(3) = New SqlParameter("subtotal", subtotal)
            params(4) = New SqlParameter("iva", iva)
            params(5) = New SqlParameter("moneda", moneda)
            params(6) = New SqlParameter("tipo_cambio", tipo_cambio)

            params(7) = New SqlParameter("fecha_comprobante", fecha_comprobante)
            params(8) = New SqlParameter("id_forma_pago", id_forma_pago)
            params(9) = New SqlParameter("orden_interna", orden_interna)
            params(10) = New SqlParameter("no_necesidad", no_necesidad)
            params(11) = New SqlParameter("observaciones", observaciones)

            params(12) = New SqlParameter("id_centro_costo", id_centro_costo)
            params(13) = New SqlParameter("id_necesidad", id_necesidad)
            params(14) = New SqlParameter("tipo_concepto", tipo_concepto)
            params(15) = New SqlParameter("otros_impuestos", otros_impuestos)
            params(16) = New SqlParameter("retencion", retencion)
            params(17) = New SqlParameter("id_empresa_reembolso", id_empresa_reembolso)
            params(18) = New SqlParameter("propina", propina)
            params(19) = New SqlParameter("id_movimiento_tarjeta", id_movimiento_tarjeta)
            params(20) = New SqlParameter("retencion_resico", retencion_resico)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    'Public Function FormaPagoUnico(id_solicitud As Integer, id_forma_pago As Integer) As Boolean
    '    Try
    '        Dim sql As String = "solicitud_reposicion_valida_forma_pago_unico"

    '        Dim params As SqlParameter() = New SqlParameter(1) {}
    '        params(0) = New SqlParameter("id_solicitud", id_solicitud)
    '        params(1) = New SqlParameter("id_forma_pago", id_forma_pago)

    '        Dim sqlHelp As New SqlHelper(_connString)

    '        Dim resultado As Integer = sqlHelp.ExecuteScalar(sql, params)
    '        If resultado = 1 Then
    '            Return True
    '        Else
    '            Return False
    '        End If
    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Function



    Public Sub GuardaConceptoReposicion(id_detalle As Integer, subtotal As Decimal, iva As Decimal, moneda As String, otros_impuestos As Decimal,
                                        retencion As Decimal, tipo_cambio As Decimal, id_forma_pago As Integer, propina As Decimal,
                                        observaciones As String, fecha As DateTime, id_concepto As Integer, retencion_resico As Decimal)

        Try
            Dim sql As String = "guarda_solicitud_reposicion_detalle"

            Dim params As SqlParameter() = New SqlParameter(12) {}
            params(0) = New SqlParameter("id_detalle", id_detalle)
            params(1) = New SqlParameter("subtotal", subtotal)
            params(2) = New SqlParameter("iva", iva)
            params(3) = New SqlParameter("moneda", moneda)
            params(4) = New SqlParameter("otros_impuestos", otros_impuestos)
            params(5) = New SqlParameter("retencion", retencion)
            params(6) = New SqlParameter("tipo_cambio", tipo_cambio)
            params(7) = New SqlParameter("id_forma_pago", id_forma_pago)
            params(8) = New SqlParameter("propina", propina)
            params(9) = New SqlParameter("observaciones", observaciones)
            params(10) = New SqlParameter("fecha_comprobante", fecha)
            params(11) = New SqlParameter("id_concepto", id_concepto)
            params(12) = New SqlParameter("retencion_resico", retencion_resico)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Function ValidaFormaPago(id_solicitud, id_detalle, id_forma_pago) As String
        Try
            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "valida_forma_pago"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("tipo", "RG")
            params(1) = New SqlParameter("id_solicitud", id_solicitud)
            params(2) = New SqlParameter("id_detalle", id_detalle)
            params(3) = New SqlParameter("id_forma_pago", id_forma_pago)


            Dim cuenta As Integer = sqlHelp.ExecuteScalar(sql, params)

            If cuenta > 0 Then
                Return "La forma de pago seleccionada no puede ser mezclada con las existentes en tu comprobacion"
            End If

        Catch ex As Exception
            Throw ex
        End Try
        Return ""
    End Function


    Public Function Elimina(ByVal id_concepto As Integer) As String
        Try


            Dim mensaje As String = ValidaDependencia(id_concepto)
            If mensaje.Length > 0 Then
                Return mensaje
            Else
                Dim sqlHelp As New SqlHelper(_connString)
                Dim sql As String = "elimina_concepto_gasto"

                Dim params As SqlParameter() = New SqlParameter(0) {}
                params(0) = New SqlParameter("id_concepto", id_concepto)


                sqlHelp.ExecuteNonQuery(sql, params)
                Return ""

            End If




        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function ValidaDependencia(ByVal id_concepto As Integer) As String
        Try
            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "valida_dependencia_concepto_gasto"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_concepto", id_concepto)


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

    Public Function RecuperaInfoEmail(ByVal id_solicitud As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_reposicion_email_autoriza"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmail(ByVal id_solicitud As Integer) As DataSet
        Try
            Dim sql As String = "recupera_solicitud_reposicion_email"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function IniciaAutorizacionComprobantes(id_solicitud As Integer) As String
        Try
            Dim sql As String = "guarda_solicitud_reposicion_inicia_auth_comprobantes"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0).Rows(0)("folio")
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Sub CancelaSolicitud(id_solicitud As Integer, id_cancela As Integer)
        Try
            Dim sql As String = "cancela_solicitud_reposicion"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("id_cancela", id_cancela)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Function SolicitudesAbiertas(id_usuario As Integer) As Integer
        Try
            Dim sql As String = "recupera_solicitud_reposicion_abiertas"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_usuario", id_usuario)


            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteScalar(sql, params)

        Catch ex As Exception
            Throw ex
        End Try
    End Function

End Class

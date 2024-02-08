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
Public Class SolicitudGasto
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Function RecuperaSolicitudesParaOffline(id_empleado As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_para_offline"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaSolicitudPorFolioTexto(folio_txt As String, tipo_solicitud As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_por_folio"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("folio_txt", folio_txt)
            params(1) = New SqlParameter("tipo_solicitud", tipo_solicitud)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Sub CancelarPorFolio(id_solicitud As Integer, tipo_solicitud As Integer, motivo_cancelacion As String, id_usuario As Integer)
        Try
            Dim sql As String = "cancela_solicitud_por_folio"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("tipo_solicitud", tipo_solicitud)
            params(2) = New SqlParameter("motivo_cancelacion", motivo_cancelacion)
            params(3) = New SqlParameter("id_usuario", id_usuario)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)

        Catch ex As Exception
            Throw ex
        End Try
    End Sub



    Public Function Recupera(ByVal id_usuario As Integer, ByVal folio_txt As String) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_gastos"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_usuario", id_usuario)
            params(1) = New SqlParameter("folio_txt", folio_txt)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaConceptos(id_solicitud As Integer, locale As String) As DataSet
        Try
            Dim sql As String = "recupera_solicitud_gastos_detalle"

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
            Dim sql As String = "recupera_solicitud_gastos_detalle_desc"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("locale", locale)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params)
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

    Public Function RecuperaPorComprobar(ByVal id_usuario As Integer, ByVal folio_txt As String) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_gastos_por_comprobar"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_usuario", id_usuario)
            params(1) = New SqlParameter("folio_txt", folio_txt)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub ActualizaTipoCambio(ByVal id_solicitud As Integer)
        Try
            Dim tipo_cambio_usd As Decimal = 0
            Dim tipo_cambio_eur As Decimal = 0

            Dim sap As New ConsultasSAP
            tipo_cambio_usd = sap.RecuperaParidad("USD", Now)
            tipo_cambio_eur = sap.RecuperaParidad("EUR", Now)

            Dim sql As String = "guarda_solicitud_gastos_tipo_cambio"
            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("tipo_cambio_anticipo_usd", tipo_cambio_usd)
            params(2) = New SqlParameter("tipo_cambio_anticipo_eur", tipo_cambio_eur)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub CambiaEstatus(id_solicitud As Integer, id_empleado As Integer, tipo As Integer, valor As Boolean)
        Try
            Dim sql As String = "guarda_solicitud_autorizacion"

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

    Public Sub GuardaMotivoRechazo(id_solicitud As Integer, motivo As String)
        Try
            Dim sql As String = "guarda_solicitud_gastos_motivo_rechazo"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("motivo", motivo)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub CambiaEstatusMail(id_solicitud As Integer, id_empleado As Integer, tipo As Integer, valor As Boolean)
        Try
            Dim sql As String = "guarda_solicitud_autorizacion_mail"

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

    Public Sub RecuperaInfoTicketEmpresarial(id_solicitud As String, ByRef num_tarjeta_gastos As String, ByRef anticipo_total As Decimal, ByRef ajuste_total As Decimal)
        Try
            Dim sql As String = "recupera_solicitud_gastos_datos_anticipo"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)


            Dim sqlHelp As New SqlHelper(_connString)

            Dim dt As DataTable = sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)

            num_tarjeta_gastos = dt.Rows(0)("num_tarjeta_gastos")
            anticipo_total = dt.Rows(0)("anticipo_total")
            ajuste_total = dt.Rows(0)("ajuste_total")

        Catch ex As Exception
            Throw ex
        End Try

    End Sub

    Public Sub EliminaComprobante(id_detalle As Integer)
        Try
            Dim sql As String = "elimina_solicitud_gastos_comprobante"

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
            Dim sql As String = "recupera_solicitud_gastos_auth1"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_usuario", id_usuario)
            params(1) = New SqlParameter("folio_txt", folio_txt)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaSaldo(id_solicitud As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_gastos_saldo"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPoliza(id_solicitud As Integer) As DataTable
        Try
            Dim sql As String = "genera_poliza_contable_gastos_individual"

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
            Dim sql As String = "recupera_solicitud_gastos_tabla_resumen"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaRealizado(ByVal id_usuario As Integer, ByVal folio_txt As String) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_gastos_realizado"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_usuario", id_usuario)
            params(1) = New SqlParameter("folio_txt", folio_txt)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPorId(ByVal id_solicitud As Integer, ByVal id_usuario_consulta As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_gastos_x_id"

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
            Dim sql As String = "recupera_solicitud_gastos_x_id_desc"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function Guarda(ByVal id_solicitud As Integer, ByVal id_empleado_solicita As Integer, ByVal id_empleado_viaja As Integer,
                           ByVal id_autoriza_jefe As Integer, ByVal id_autoriza_conta As Integer, ByVal id_departamento As Integer,
                           ByVal fecha_ini As Date, ByVal fecha_fin As Date, ByVal destino As String,
                           ByVal motivo As String, ByVal comentarios As String, ByVal monto_pesos As Decimal,
                            ByVal monto_dolares As Decimal, ByVal monto_euros As Decimal, ByVal id_empresa As Integer,
                            ByVal tipo_comprobantes As String, Optional ByVal version_api As String = "") As DataTable
        Try
            Dim sql As String = "guarda_solicitud_gastos"

            Dim params As SqlParameter() = New SqlParameter(16) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("id_empleado_solicita", id_empleado_solicita)
            params(2) = New SqlParameter("id_empleado_viaja", id_empleado_viaja)
            params(3) = New SqlParameter("id_autoriza_jefe", id_autoriza_jefe)
            params(4) = New SqlParameter("id_autoriza_conta", id_autoriza_conta)
            params(5) = New SqlParameter("id_departamento", id_departamento)
            params(6) = New SqlParameter("fecha_ini", fecha_ini)
            params(7) = New SqlParameter("fecha_fin", fecha_fin)
            params(8) = New SqlParameter("destino", destino)
            params(9) = New SqlParameter("motivo", motivo)
            params(10) = New SqlParameter("comentarios", comentarios)
            params(11) = New SqlParameter("monto_pesos", monto_pesos)
            params(12) = New SqlParameter("monto_dolares", monto_dolares)
            params(13) = New SqlParameter("monto_euros", monto_euros)
            params(14) = New SqlParameter("id_empresa", id_empresa)
            params(15) = New SqlParameter("tipo_comprobantes", tipo_comprobantes)
            params(16) = New SqlParameter("version_api", version_api)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function GuardaConceptoGasto(id_detalle As Integer, id_solicitud As Integer, id_concepto As Integer, subtotal As Decimal,
                                   iva As Decimal, moneda As String, tipo_cambio As Decimal, fecha_comprobante As Date, id_forma_pago As Integer,
                                   orden_interna As String, no_necesidad As String, observaciones As String, id_centro_costo As Integer,
                                   id_necesidad As Integer, tipo_concepto As String, otros_impuestos As Decimal, retencion As Decimal, num_personas As Integer,
                                   id_empresa_reembolso As Integer, propina As Decimal, id_movimiento_tarjeta As Integer, retencion_resico As Decimal) As Integer
        Try
            Dim sql As String = "guarda_solicitud_gastos_detalle"

            Dim params As SqlParameter() = New SqlParameter(21) {}
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
            params(17) = New SqlParameter("num_personas", num_personas)
            params(18) = New SqlParameter("id_empresa_reembolso", id_empresa_reembolso)
            params(19) = New SqlParameter("propina", propina)
            params(20) = New SqlParameter("id_movimiento_tarjeta", id_movimiento_tarjeta)
            params(21) = New SqlParameter("retencion_resico", retencion_resico)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    'Public Function FormaPagoUnico(id_solicitud As Integer, id_forma_pago As Integer) As Boolean
    '    Try
    '        Dim sql As String = "solicitud_gastos_valida_forma_pago_unico"

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



    Public Sub GuardaConceptoGasto(id_detalle As Integer, subtotal As Decimal, iva As Decimal, moneda As String, otros_impuestos As Decimal, retencion As Decimal,
                                   num_personas As Integer, tipo_cambio As Decimal, id_forma_pago As Integer, propina As Decimal, observaciones As String,
                                   fecha As DateTime, id_concepto As Integer, retencion_resico As Decimal)
        Try
            Dim sql As String = "guarda_solicitud_gastos_detalle"

            Dim params As SqlParameter() = New SqlParameter(13) {}
            params(0) = New SqlParameter("id_detalle", id_detalle)
            params(1) = New SqlParameter("subtotal", subtotal)
            params(2) = New SqlParameter("iva", iva)
            params(3) = New SqlParameter("moneda", moneda)
            params(4) = New SqlParameter("otros_impuestos", otros_impuestos)
            params(5) = New SqlParameter("retencion", retencion)
            params(6) = New SqlParameter("num_personas", num_personas)
            params(7) = New SqlParameter("tipo_cambio", tipo_cambio)
            params(8) = New SqlParameter("id_forma_pago", id_forma_pago)
            params(9) = New SqlParameter("propina", propina)
            params(10) = New SqlParameter("observaciones", observaciones)
            params(11) = New SqlParameter("fecha_comprobante", fecha)
            params(12) = New SqlParameter("id_concepto", id_concepto)
            params(13) = New SqlParameter("retencion_resico", retencion_resico)



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
            params(0) = New SqlParameter("tipo", "SV")
            params(1) = New SqlParameter("id_solicitud", id_solicitud)
            params(2) = New SqlParameter("id_detalle", id_detalle)
            params(3) = New SqlParameter("id_forma_pago", id_forma_pago)


            Dim cuenta As Integer = sqlHelp.ExecuteScalar(sql, params)

            If cuenta > 0 Then
                Return "La forma de pago seleccionada no puede ser mezclada con las existentes en tu lista"
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
            Dim sql As String = "recupera_solicitud_gastos_email_autoriza"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEmail(ByVal id_solicitud As Integer) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_gastos_email"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function IniciaAutorizacionComprobantes(id_solicitud As Integer) As Integer
        Try
            Dim sql As String = "guarda_solicitud_gastos_inicia_auth_comprobantes"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
        Return 0
    End Function


    'Public Function IniciaAutorizacionComprobantes(id_solicitud As Integer) As Integer
    '    Try
    '        Dim sql As String = "guarda_solicitud_gastos_inicia_auth_comprobantes"

    '        Dim params As SqlParameter() = New SqlParameter(0) {}
    '        params(0) = New SqlParameter("id_solicitud", id_solicitud)

    '        Dim sqlHelp As New SqlHelper(_connString)
    '        Dim ds As DataSet = sqlHelp.ExecuteDataAdapter(sql, params)

    '        Dim dt As DataTable = ds.Tables(0)
    '        Return dt.Rows(0)("resultado")

    '    Catch ex As Exception
    '        Throw ex
    '    End Try
    'End Function


    Public Sub CancelaSolicitud(id_solicitud As Integer, id_cancela As Integer)
        Try
            Dim sql As String = "cancela_solicitud_gastos"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("id_cancela", id_cancela)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function RepSolicitudGastosPivote(ByVal anio As Integer, periodo As Integer, tipo As String) As DataTable
        Try
            Dim sql As String = "rpt_solicitud_gastos_pivote"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("anio", anio)
            params(1) = New SqlParameter("periodo", periodo)
            params(2) = New SqlParameter("tipo", tipo)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function SolicitudesAbiertas(id_usuario As Integer, id_solicitud As Integer) As Integer
        Try
            Dim sql As String = "recupera_solicitud_gastos_abiertas"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_usuario", id_usuario)
            params(1) = New SqlParameter("id_solicitud", id_solicitud)


            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteScalar(sql, params)

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

    Public Function ValidaDocumentosComprobantes(id_solicitud As Integer) As Boolean
        Try
            Dim sql As String = "cuenta_documentos_comprobantes"
            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            Dim sqlHelp As New SqlHelper(_connString)
            Dim detalle As DataTable = sqlHelp.ExecuteDataAdapter(sql,
            params).Tables(0)
            For Each item As DataRow In detalle.Rows
                If item("comprobantes") = 0 Then
                    Return False
                End If
            Next
            Return True
        Catch ex As Exception
            Throw ex
        End Try
    End Function

End Class

Imports System.Web.Services
Imports System.Web.Script.Services
Imports IntranetDA
Imports System.Data.SqlClient
Imports IntranetBL
Imports System.IO

Public Class WebAPI
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim metodo As String = ""
            Dim sentencia As String = ""
            Dim table As String = ""
            Dim responseJson As String = ""

            metodo = Request.Form("metodo")
            sentencia = Request.Form("sentencia")
            table = Request.Form("table")
            If table Is Nothing Then
                table = "0"
            End If



            ' ' ' ' ' ' ' ' ' ' ' '
            ' ' Metodos
            ' ' ' ' ' ' ' ' ' ' ' '
            If metodo = "SqlQuery" Then
                responseJson = Me.SqlQuery(sentencia, table)
            ElseIf metodo = "SapQuery" Then
                responseJson = Me.SapQuery(sentencia)
            ElseIf metodo = "SaveSolicitud" Then
                responseJson = Me.SaveSolicitud(sentencia)
            ElseIf metodo = "GetSolicitud" Then
                responseJson = Me.GetSolicitud(sentencia)
            End If




            ' ' ' ' ' ' ' ' ' ' ' '
            ' ' Response
            ' ' ' ' ' ' ' ' ' ' ' '
            Response.Clear()
            If responseJson <> "" Then
                Response.Write(responseJson)
            Else
                Response.Write("{Error: Invalid request (01)}")
            End If
            Response.End()



        End If

    End Sub



    Public Function SqlQuery(SqlSentence As String, table As String) As String

        If Not SqlSentence.ToLower().StartsWith("exec") Then
            Return "Error: Invalid request (02)"
        End If

        Try
            Dim sqlHelp As New SqlHelper(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dsResponse As DataSet = sqlHelp.ExecuteDataAdapterText(SqlSentence)

            If table = "" Or table = "0" Then
                Return GetJsonFromDataTable(dsResponse.Tables(0))
            Else
                If table >= dsResponse.Tables.Count Then
                    Return "NO-TABLE"
                End If
                Return GetJsonFromDataTable(dsResponse.Tables(Integer.Parse(table)))
            End If


        Catch ex As Exception
            Throw ex
            Return "Error: " & ex.Message
        End Try

        Return ""
    End Function


    Public Function SapQuery(SqlSentence As String) As String

        If Not SqlSentence.ToLower().StartsWith("exec") Then
            Return "Error: Invalid request (02)"
        End If

        Try
            If SqlSentence.ToLower().StartsWith("exec orden_interna") Then

                Dim id_empresa As String = SqlSentence.Split("|")(1)

                Dim sap As New ConsultasSAP()
                Dim dtOI As DataTable = sap.RecuperaOrdenesInternas(id_empresa)
                dtOI.Rows.Add(" -- Seleccione --")
                'dtOI.Rows.Add(" OI Manual")
                dtOI.AcceptChanges()

                Return GetJsonFromDataTable(dtOI)
            ElseIf SqlSentence.ToLower().StartsWith("exec elmento_pep") Then

                Dim id_empresa As String = SqlSentence.Split("|")(1)

                Dim sap As New ConsultasSAP()
                Dim dtPEP As DataTable = sap.RecuperaElementoPEP(id_empresa)
                dtPEP.Rows.Add(" -- Seleccione --")
                dtPEP.AcceptChanges()

                Return GetJsonFromDataTable(dtPEP)
            End If


        Catch ex As Exception
            Throw ex
            Return "Error: " & ex.Message
        End Try

        Return ""
    End Function


    Public Function GetSolicitud(id_empleado As String) As String
        Dim serializer As System.Web.Script.Serialization.JavaScriptSerializer = New System.Web.Script.Serialization.JavaScriptSerializer()
        serializer.MaxJsonLength = 70000000

        Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        Dim solicitudes As New List(Of Solicitud)


        Dim dt As DataTable = solicitud_gasto.RecuperaSolicitudesParaOffline(id_empleado)
        For Each dr As DataRow In dt.Rows
            Dim s As New Solicitud()
            s._id = 0
            s.comprobantes = New List(Of SolicitudComprobante)
            s.id_solicitud_servidor = dr("id_solicitud_servidor").ToString()
            s.categoria = dr("categoria").ToString()
            s.autoriza_conta = dr("autoriza_conta").ToString()
            s.autoriza_jefe = dr("autoriza_jefe").ToString()
            s.departamento = dr("departamento").ToString()
            s.destino = dr("destino").ToString()
            s.elemento_pep = dr("elemento_pep").ToString()
            s.enviado_al_servidor = False
            s.fecha_fin = dr("fecha_fin").ToString()
            s.fecha_inicio = dr("fecha_inicio").ToString()
            s.folio_servidor = dr("folio_txt").ToString()
            s.id_autoriza_conta = dr("id_autoriza_conta").ToString()
            s.id_autoriza_jefe = dr("id_autoriza_jefe").ToString()
            s.id_departamento = dr("id_departamento").ToString()
            s.id_empleado = dr("id_empleado").ToString()
            s.id_empresa = dr("id_empresa").ToString()
            s.motivo = dr("motivo").ToString()
            s.tipo = dr("tipo").ToString()

            solicitudes.Add(s)
        Next

        Return serializer.Serialize(solicitudes)
    End Function

    Public Function SaveSolicitud(SqlSentence As String) As String
        Try
            Dim serializer As System.Web.Script.Serialization.JavaScriptSerializer = New System.Web.Script.Serialization.JavaScriptSerializer()
            serializer.MaxJsonLength = 70000000
            Dim s As Solicitud = serializer.Deserialize(Of Solicitud)(SqlSentence)

            Try
                'Return s.empresa


                Dim id_solicitud As Integer = s.id_solicitud_servidor
                Dim hubo_errores As Boolean = False

                'Me.ValidaCaptura()
                'Me.ValidaCapturaConceptos()

                Dim solicitud_gasto As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Dim solicitud_documento As New SolicitudDocumento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

                'Solicitud de Gastos de Viaje
                If s.tipo = "SV" Then
                    Try
                        Dim folio As String = ""
                        Dim tipo_comprobantes As String = s.categoria

                        Dim dt As DataTable = solicitud_gasto.Guarda(s.id_solicitud_servidor, s.id_empleado, s.id_empleado,
                                               s.id_autoriza_jefe, s.id_autoriza_conta, s.id_departamento,
                                               s.fecha_inicio, s.fecha_fin, s.destino, s.motivo, "",
                                               0, 0, 0, s.id_empresa, tipo_comprobantes, s.version)

                        If dt.Rows.Count > 0 Then
                            Dim dr As DataRow = dt.Rows(0)
                            id_solicitud = dr("id")
                            folio = dr("folio")
                            s.id_solicitud_servidor = id_solicitud
                            s.folio_servidor = folio
                        End If

                        'If (Me.txtMontoPesos.Value + Me.txtMontoUSD.Value + Me.txtMontoEuro.Value) > 0 Then
                        '    EmailJefeDirecto()
                        'End If
                    Catch ex As Exception
                        s.errors = ex.Message.Replace(ChrW(39), ChrW(34))
                        hubo_errores = True
                    End Try







                    If hubo_errores = False Then
                        '''''''''''''''''''''''''''''''''''''''''''''''''
                        ' COMPROBANTES
                        '''''''''''''''''''''''''''''''''''''''''''''''''
                        Dim tipo_concepto As String = s.categoria
                        For Each sd As SolicitudComprobante In s.comprobantes
                            Try

                                Dim tipo_cambio As Decimal = 1
                                Dim sap As New ConsultasSAP
                                If s.id_empresa = 12 Then   'NUSA
                                    If sd.moneda <> "USD" Then
                                        tipo_cambio = sap.RecuperaParidadDesdeHacia("USD", sd.moneda, sd.fecha)
                                    End If
                                Else
                                    If sd.moneda <> "MXP" Then
                                        tipo_cambio = sap.RecuperaParidadDesdeHacia("MXP", sd.moneda, sd.fecha)
                                    End If
                                End If

                                Dim iva_concepto As Decimal = sd.iva ' (sd.tasa_iva / 100) * sd.subtotal
                                Dim orden_interna As String = ""

                                'If solicitud_gasto.FormaPagoUnico(Me.txtIdSolicitudGasto.Text, Me.ddlFormaPago.SelectedValue) Then
                                If s.categoria = "PP" Then
                                    orden_interna = s.elemento_pep
                                End If

                                Dim id_detalle As Integer = solicitud_gasto.GuardaConceptoGasto(0, id_solicitud, sd.id_concepto, sd.subtotal,
                                                                    iva_concepto, sd.moneda, tipo_cambio, sd.fecha,
                                                                    sd.id_forma_pago, orden_interna, "", sd.observaciones,
                                                                    sd.centro_costo, 0, tipo_concepto, sd.otros_impuestos, sd.retencion,
                                                                    sd.num_personas, 0, sd.propina, sd.id_movimiento_tarjeta, sd.retencion_resico)




                                'ARCHIVOS
                                For Each arc As SolicitudComprobanteArchivos In sd.archivos
                                    If Not arc.contenido Is Nothing Then
                                        Dim savepath As String = ""
                                        Dim tempPath As String = ""
                                        tempPath = "/Uploads/"

                                        savepath = Context.Server.MapPath(tempPath)
                                        Dim filename As String = arc.nombre_archivo
                                        If Not Directory.Exists(savepath) Then
                                            Directory.CreateDirectory(savepath)
                                        End If

                                        Dim filewithoutextension As String = Path.GetFileNameWithoutExtension(filename)
                                        filewithoutextension = filewithoutextension.Replace(" ", "").Replace(".", "").Replace("(", "").Replace(")", "").Replace("'", "").Replace("]", "").Replace("[", "").Replace("=", "").Replace("¡", "").Replace("¿", "").Replace("*", "")
                                        filewithoutextension = filewithoutextension.Replace("+", "").Replace("#", "").Replace("$", "").Replace("%", "").Replace("&", "").Replace("!", "").Replace("/", "").Replace("?", "")
                                        filename = filewithoutextension + "_" + DateTime.Now.ToString("MMddHHmmss") + Path.GetExtension(filename).ToLower()

                                        File.WriteAllBytes(savepath + filename, arc.contenido)

                                        solicitud_documento.AgregaDocumento(id_solicitud, id_detalle, filename, "GV", savepath)
                                        arc.contenido = Nothing
                                    End If
                                Next


                            Catch ex As Exception
                                sd.errors = ex.Message.Replace(ChrW(39), ChrW(34))
                                hubo_errores = True
                            End Try

                        Next
                    End If


                    If id_solicitud > 0 And hubo_errores = True Then
                        'Eliminar la solicitud previa
                    End If


                    'Else
                    'ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & TranslateLocale.text("Todos los conceptos registrados deben tener la misma forma de pago.") & "');</script>", False)
                    'End If


                Else






                    ' '''''''''''''''''''''''''''''''
                    'Solicitud de Reposicion de Gastos
                    ' '''''''''''''''''''''''''''''''
                    Try
                        Dim folio As String = ""
                        Dim tipo_comprobantes As String = s.categoria


                        Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                        Dim dt As DataTable = solicitud_reposicion.Guarda(s.id_solicitud_servidor, s.id_empleado,
                                               s.id_autoriza_jefe, s.id_autoriza_conta, s.id_departamento,
                                               s.destino, s.id_empresa, tipo_comprobantes, s.id_empleado, s.version)

                        If dt.Rows.Count > 0 Then
                            Dim dr As DataRow = dt.Rows(0)
                            id_solicitud = dr("id")
                            folio = dr("folio")
                            s.id_solicitud_servidor = id_solicitud
                            s.folio_servidor = folio
                        End If

                    Catch ex As Exception
                        s.errors = ex.Message.Replace(ChrW(39), ChrW(34))
                        hubo_errores = True
                    End Try

















                    If hubo_errores = False Then
                        '''''''''''''''''''''''''''''''''''''''''''''''''
                        ' COMPROBANTES
                        '''''''''''''''''''''''''''''''''''''''''''''''''
                        Dim tipo_concepto As String = s.categoria
                        For Each sd As SolicitudComprobante In s.comprobantes
                            Try

                                Dim tipo_cambio As Decimal = 1
                                Dim sap As New ConsultasSAP
                                If s.id_empresa = 12 Then   'NUSA
                                    If sd.moneda <> "USD" Then
                                        tipo_cambio = sap.RecuperaParidadDesdeHacia("USD", sd.moneda, sd.fecha)
                                    End If
                                Else
                                    If sd.moneda <> "MXP" Then
                                        tipo_cambio = sap.RecuperaParidadDesdeHacia("MXP", sd.moneda, sd.fecha)
                                    End If
                                End If


                                Dim iva_concepto As Decimal = sd.iva ' (sd.tasa_iva / 100) * sd.subtotal
                                Dim orden_interna As String = ""

                                Dim solicitud_reposicion As New SolicitudReposiciones(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                                If s.categoria = "PP" Then
                                    orden_interna = s.elemento_pep
                                End If

                                Dim id_detalle As Integer = solicitud_reposicion.GuardaConceptoReposicion(0, s.id_solicitud_servidor, sd.id_concepto, sd.subtotal,
                                                                                iva_concepto, sd.moneda, tipo_cambio,
                                                                                sd.fecha, sd.id_forma_pago,
                                                                                orden_interna, "", sd.observaciones,
                                                                                sd.centro_costo, 0, tipo_concepto,
                                                                                sd.otros_impuestos, sd.retencion, 0, sd.propina,
                                                                                sd.id_movimiento_tarjeta, sd.retencion_resico)




                                'ARCHIVOS
                                For Each arc As SolicitudComprobanteArchivos In sd.archivos
                                    If Not arc.contenido Is Nothing Then
                                        Dim savepath As String = ""
                                        Dim tempPath As String = ""
                                        tempPath = "/Uploads/"

                                        savepath = Context.Server.MapPath(tempPath)
                                        Dim filename As String = arc.nombre_archivo
                                        If Not Directory.Exists(savepath) Then
                                            Directory.CreateDirectory(savepath)
                                        End If

                                        Dim filewithoutextension As String = Path.GetFileNameWithoutExtension(filename)
                                        filewithoutextension = filewithoutextension.Replace(" ", "").Replace(".", "").Replace("(", "").Replace(")", "").Replace("'", "").Replace("]", "").Replace("[", "").Replace("=", "").Replace("¡", "").Replace("¿", "").Replace("*", "")
                                        filewithoutextension = filewithoutextension.Replace("+", "").Replace("#", "").Replace("$", "").Replace("%", "").Replace("&", "").Replace("!", "").Replace("/", "").Replace("?", "")
                                        filename = filewithoutextension + "_" + DateTime.Now.ToString("MMddHHmmss") + Path.GetExtension(filename).ToLower()

                                        File.WriteAllBytes(savepath + filename, arc.contenido)

                                        solicitud_documento.AgregaDocumento(id_solicitud, id_detalle, filename, "RG", savepath)
                                        arc.contenido = Nothing
                                    End If
                                Next

                            Catch ex As Exception
                                sd.errors = ex.Message.Replace(ChrW(39), ChrW(34))
                                hubo_errores = True
                            End Try
                        Next

                    End If




                End If

            Catch ex As Exception
                s.errors = "Error: " & ex.Message
            End Try

            Dim respuesta As String = serializer.Serialize(s)

            Try
                Dim seg As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                seg.GuardaLogDatos("web_api_offline", respuesta)
            Catch exx As Exception
            End Try


            Return respuesta
        Catch ex As Exception
            Try
                Dim seg As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                seg.GuardaLogDatos("web_api_offline: ex:" & ex.Message, SqlSentence)
            Catch exx As Exception
                Dim seg As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                seg.GuardaLogDatos("web_api_offline: exx:" & ex.Message, "ERROR DE DATOS")
            End Try
        End Try

        Return "Error: X045"
    End Function



    Public Function GetJsonFromDataTable(ByVal dt As DataTable) As String

        Try
            Dim serializer As System.Web.Script.Serialization.JavaScriptSerializer = New System.Web.Script.Serialization.JavaScriptSerializer()
            Dim rows As New List(Of Dictionary(Of String, Object))
            Dim row As Dictionary(Of String, Object)

            For Each dr As DataRow In dt.Rows
                row = New Dictionary(Of String, Object)
                For Each col As DataColumn In dt.Columns
                    row.Add(col.ColumnName, dr(col))
                Next
                rows.Add(row)
            Next
            Return serializer.Serialize(rows)
        Catch ex As Exception
            Return "[]"
        End Try
    End Function



End Class



Public Class Solicitud
    Public Property _id As Integer
    Public Property id_solicitud_servidor As Integer
    Public Property folio_servidor As String
    Public Property tipo As String
    Public Property categoria As String
    Public Property version As String
    Public Property fecha_inicio As DateTime
    Public Property fecha_fin As DateTime
    Public Property empresa As String
    Public Property departamento As String
    Public Property autoriza_jefe As String
    Public Property autoriza_conta As String
    Public Property motivo As String
    Public Property destino As String
    Public Property id_empresa As Integer
    Public Property id_empleado As Integer
    Public Property id_departamento As Integer
    Public Property id_autoriza_jefe As Integer
    Public Property id_autoriza_conta As Integer
    Public Property enviado_al_servidor As Boolean
    Public Property estatus As Integer
    Public Property elemento_pep As String
    Public Property errors As String
    Public Property comprobantes As List(Of SolicitudComprobante)
End Class

Public Class SolicitudComprobante
    Public Property _id As Integer
    Public Property referencia As String
    Public Property centro_costo As String
    Public Property necesidad As String
    Public Property elementopep As String
    Public Property observaciones As String
    Public Property fecha As DateTime
    Public Property id_concepto As Integer
    Public Property subtotal As Decimal
    Public Property tasa_iva As Decimal
    Public Property iva As Decimal
    Public Property otros_impuestos As Decimal
    Public Property retencion As Decimal
    Public Property retencion_resico As Decimal

    Public Property propina As Decimal
    Public Property total As Decimal
    Public Property moneda As String
    Public Property id_forma_pago As Integer
    Public Property num_personas As Integer
    Public Property id_movimiento_tarjeta As Integer
    Public Property errors As String
    Public Property archivos As List(Of SolicitudComprobanteArchivos)
End Class

Public Class SolicitudComprobanteArchivos
    Public Property _id As Integer
    Public Property row_index As Integer
    Public Property referencia As String
    Public Property nombre_archivo As String
    Public Property ruta_local As String
    Public Property contenido As Byte()
End Class
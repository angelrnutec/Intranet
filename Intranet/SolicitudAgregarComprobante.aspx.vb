Imports IntranetBL

Public Class SolicitudAgregarComprobante
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'FormDataDump(True, True)

            Response.Clear()
            Try
                Dim mt As New MovimientosTarjeta(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

                Dim id_solicitud As String = Request.Form("id_solicitud")
                Dim tipo As String = Request.Form("tipo")
                Dim tipo_comprobantes As String = Request.Form("tipo_comprobantes")

                Dim contador_errores As Integer = 0

                For i As Integer = 0 To 200
                    If Not Request.Form("mt_id_movimiento_" & i) Is Nothing Then
                        Dim mt_id_movimiento As String = Request.Form("mt_id_movimiento_" & i)
                        Dim mt_lista_tipo_comprobacion As String = Request.Form("mt_lista_tipo_comprobacion_" & i)
                        Dim mt_lista_concepto As String = Request.Form("mt_lista_concepto_" & i)
                        Dim mt_lista_necesidad As String = ""
                        If Not Request.Form("mt_lista_necesidad_" & i) Is Nothing Then
                            mt_lista_necesidad = Request.Form("mt_lista_necesidad_" & i)
                        End If
                        Dim mt_lista_iva As String = Request.Form("mt_lista_iva_" & i)
                        If mt_lista_iva.Length = 0 Then
                            mt_lista_iva = "0"
                        End If

                        Dim mt_otros_impuestos As String = Request.Form("mt_otros_impuestos_" & i)
                        Dim mt_retencion As String = Request.Form("mt_retencion_" & i)
                        Dim mt_iva_manual As String = Request.Form("mt_iva_manual_" & i)
                        Dim mt_propina As String = Request.Form("mt_propina_" & i)
                        Dim mt_observaciones As String = Request.Form("mt_observaciones_" & i)

                        Dim mt_lista_num_personas As String = "1"
                        If Not Request.Form("mt_lista_num_personas_" & i) Is Nothing Then
                            mt_lista_num_personas = Request.Form("mt_lista_num_personas_" & i)
                        End If

                        Dim concepto As String = mt_lista_concepto
                        Dim id_concepto As String = concepto.Split("|")(0)
                        'Dim es_iva_editable As String = concepto.Split("|")(1)
                        'Dim requiere_retencion As String = concepto.Split("|")(2)
                        'Dim permite_propina As String = concepto.Split("|")(3)


                        Dim agregado As Integer = mt.AgregarSolicitudComprobate(id_solicitud,
                                                                                tipo,
                                                                                mt_id_movimiento,
                                                                                id_concepto,
                                                                                tipo_comprobantes,
                                                                                mt_lista_tipo_comprobacion,
                                                                                mt_lista_necesidad,
                                                                                mt_lista_iva,
                                                                                mt_otros_impuestos,
                                                                                mt_retencion,
                                                                                mt_lista_num_personas,
                                                                                mt_iva_manual,
                                                                                mt_propina,
                                                                                mt_observaciones)
                        If agregado = 0 Then
                            contador_errores += 1
                        End If

                    End If
                Next

                Response.Write("OK|" & contador_errores)
            Catch ex As Exception
                Response.Write(ex.Message)
            End Try
            Response.End()
        End If

    End Sub

    Sub FormDataDump(bolShowOutput, bolEndPageExecution)
        Dim sItem

        'What linebreak character do we need to use?
        Dim strLineBreak
        If bolShowOutput Then
            'We are showing the output, so set the line break character
            'to the HTML line breaking character
            strLineBreak = "<br>"
        Else
            'We are nesting the data dump in an HTML comment block, so
            'use the carraige return instead of <br>
            'Also start the HTML comment block
            strLineBreak = vbCrLf
            Response.Write("<!--" & strLineBreak)
        End If


        'Display the Request.Form collection
        Response.Write("DISPLAYING REQUEST.FORM COLLECTION" & strLineBreak)
        For Each sItem In Request.Form
            Response.Write(sItem)
            Response.Write(" - [" & Request.Form(sItem) & "]" & strLineBreak)
        Next


        'Display the Request.QueryString collection
        Response.Write(strLineBreak & strLineBreak)
        Response.Write("DISPLAYING REQUEST.QUERYSTRING COLLECTION" & strLineBreak)
        For Each sItem In Request.QueryString
            Response.Write(sItem)
            Response.Write(" - [" & Request.QueryString(sItem) & "]" & strLineBreak)
        Next


        'If we are wanting to hide the output, display the closing
        'HTML comment tag
        If Not bolShowOutput Then Response.Write(strLineBreak & "-->")

        'End page execution if needed
        If bolEndPageExecution Then Response.End()
    End Sub
End Class
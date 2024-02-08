Imports IntranetBL

Public Class PolizaEditarGuarda
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            'FormDataDump(True, True)

            Response.Clear()
            Try
                Dim polizaObj As New PolizaContable(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

                Dim id_solicitud As String = Request.Form("id_solicitud")
                Dim tipo_poliza As String = Request.Form("tipo_poliza")
                Dim referencia As String = Request.Form("referencia")
                Dim eliminados As String = Request.Form("eliminados")

                For Each id_detalle As String In eliminados.Split("|")
                    If id_detalle.Length > 0 Then
                        polizaObj.EliminaPolizaDetalle(id_solicitud, tipo_poliza, id_detalle)
                    End If
                Next




                For i As Integer = 0 To 200
                    If Not Request.Form("cuenta_" & i) Is Nothing Then
                        Dim id_detalle As String = Request.Form("id_detalle_" & i)
                        Dim cuenta As String = Request.Form("cuenta_" & i)
                        Dim clave As String = Request.Form("clave_" & i)
                        Dim proyecto As String = Request.Form("proyecto_" & i)
                        Dim no_necesidad As String = Request.Form("necesidad_" & i)
                        Dim importe As String = Request.Form("importe_" & i)
                        Dim descripcion As String = Request.Form("descripcion_" & i)
                        Dim tipo_comprobacion As String = Request.Form("tipo_comprobacion_" & i)
                        Dim id_concepto As String = Request.Form("id_concepto_" & i)

                        polizaObj.ActualizaPolizaDetalle(id_solicitud, tipo_poliza, id_detalle, cuenta, clave, proyecto, no_necesidad, importe, descripcion, tipo_comprobacion, id_concepto)
                    End If
                Next
                polizaObj.ActualizaPolizaFecha(id_solicitud, Request.Form("fecha_doc"), referencia, tipo_poliza)

                Response.Write("OK")
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
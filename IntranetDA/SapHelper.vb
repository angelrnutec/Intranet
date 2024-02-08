Imports SAP.Middleware.Connector

Public Class SapHelper

    Public Function GetDataTable(funcion As String, table As String, params As String(), incluye_columnas As String()) As DataTable
        Try
            Dim dt As New DataTable
            Dim SapRfcDestination As RfcDestination = RfcDestinationManager.GetDestination("DEV")
            Dim SapRfcRepository As RfcRepository = SapRfcDestination.Repository

            Dim BapiGetDataTable As IRfcFunction = SapRfcRepository.CreateFunction(funcion)

            If Not params Is Nothing Then
                For Each strParam As String In params
                    If Not strParam Is Nothing Then
                        Dim llave As String = strParam.Split("=")(0)
                        Dim valor As String = strParam.Split("=")(1)
                        BapiGetDataTable.SetValue(llave, valor)
                    End If
                Next
            End If

            BapiGetDataTable.Invoke(SapRfcDestination)
            Dim ResultDataTable As IRfcTable = BapiGetDataTable.GetTable(table)

            If incluye_columnas Is Nothing Then
                For j As Integer = 0 To ResultDataTable.ElementCount - 1
                    dt.Columns.Add(ResultDataTable.Metadata(j).Name)
                Next
                For i As Integer = 0 To ResultDataTable.RowCount - 1
                    ResultDataTable.CurrentIndex = i

                    Dim dr As DataRow = dt.NewRow
                    For j As Integer = 0 To ResultDataTable.ElementCount - 1
                        dr.Item(ResultDataTable.Metadata(j).Name) = ResultDataTable.GetString(ResultDataTable.Metadata(j).Name)
                    Next
                    dt.Rows.Add(dr)
                    dt.AcceptChanges()
                Next
            Else
                For Each strIncluye As String In incluye_columnas
                    If Not strIncluye Is Nothing Then
                        dt.Columns.Add(strIncluye)
                    End If
                Next
                For i As Integer = 0 To ResultDataTable.RowCount - 1
                    ResultDataTable.CurrentIndex = i

                    Dim dr As DataRow = dt.NewRow
                    For Each strIncluye As String In incluye_columnas
                        If Not strIncluye Is Nothing Then
                            dr.Item(strIncluye) = ResultDataTable.GetString(strIncluye)
                        End If
                    Next
                    dt.Rows.Add(dr)
                    dt.AcceptChanges()
                Next
            End If
            Return dt
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function GetDataArray(funcion As String, table As String, params As String(), valores_salida As String()) As String()
        Try
            Dim resultados(valores_salida.Length) As String
            Dim SapRfcDestination As RfcDestination = RfcDestinationManager.GetDestination("DEV")
            Dim SapRfcRepository As RfcRepository = SapRfcDestination.Repository

            Dim BapiGetDataTable As IRfcFunction = SapRfcRepository.CreateFunction(funcion)

            For Each strParam As String In params
                If Not strParam Is Nothing Then
                    Dim llave As String = strParam.Split("=")(0)
                    Dim valor As String = strParam.Split("=")(1)
                    BapiGetDataTable.SetValue(llave, valor)
                End If
            Next

            BapiGetDataTable.Invoke(SapRfcDestination)
            Dim i As Integer = 0
            For Each valor_salida As String In valores_salida
                If Not valor_salida Is Nothing Then
                    resultados(i) = valor_salida & "=" & BapiGetDataTable.GetValue(valor_salida)
                End If
                i += 1
            Next

            Return resultados
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function SendPoliza(dtPoliza As DataTable) As PolizaSapResult
        Try
            Dim SapRfcDestination As RfcDestination = RfcDestinationManager.GetDestination("DEV")
            Dim SapRfcRepository As RfcRepository = SapRfcDestination.Repository

            Dim BapiSaveDataTable As IRfcFunction = SapRfcRepository.CreateFunction("ZFI0054POLCON")

            Dim tblParams As IRfcTable = BapiSaveDataTable.GetTable("T_ZFI0054PC")

            For Each dr As DataRow In dtPoliza.Rows
                Dim strucInputHead As IRfcStructure = tblParams.Metadata.LineType.CreateStructure()

                strucInputHead.SetValue("MANDT", "0")
                strucInputHead.SetValue("CAMPO01", dr("dato01"))
                strucInputHead.SetValue("CAMPOTP", dr("dato02"))
                strucInputHead.SetValue("CAMPO02", dr("dato03"))
                strucInputHead.SetValue("CAMPO03", dr("dato04"))
                strucInputHead.SetValue("CAMPO04", dr("dato05"))
                strucInputHead.SetValue("CAMPO05", dr("dato06"))
                strucInputHead.SetValue("CAMPO06", dr("dato07"))
                strucInputHead.SetValue("CAMPO07", dr("dato08"))
                strucInputHead.SetValue("CAMPO08", dr("dato09"))
                strucInputHead.SetValue("CAMPO09", dr("dato10"))
                strucInputHead.SetValue("CAMPO10", dr("dato11"))
                strucInputHead.SetValue("CAMPO11", dr("dato12"))
                strucInputHead.SetValue("CAMPO12", dr("dato13"))
                strucInputHead.SetValue("CAMPO14", dr("dato14"))

                tblParams.Append(strucInputHead)
            Next


            Dim respuesta As New PolizaSapResult
            respuesta.sap_log = BapiSaveDataTable.ToString()


            BapiSaveDataTable.Invoke(SapRfcDestination)

            Dim codigoRespuesta As String = BapiSaveDataTable.GetValue("E_CAMPO00")
            Dim mensajeRespuesta As String = BapiSaveDataTable.GetValue("E_MENSAJE")

            respuesta.respuesta = codigoRespuesta & "|" & mensajeRespuesta

            Return respuesta
        Catch ex As Exception
            Throw ex
        End Try
    End Function
End Class


Public Class PolizaSapResult
    Public respuesta As String
    Public sap_log As String
End Class
Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports IntranetDA
Imports DeveltecExtractUUID
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
' DevelTec.mx 
' Clase Generada Utilizando el Generador de Codigo DeveltecCodeGenerator
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Public Class SolicitudDocumento
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Sub AgregaDocumento(ByVal id_solicitud As Integer, ByVal id_solicitud_detalle As Integer, ByVal documento As String, tipo As String, ruta As String)
        Try

            Dim uuid As String = ""
            Dim fechaTimbrado As DateTime = DateTime.Now
            Try
                If IO.Path.GetExtension(documento).ToUpper() = ".XML" Then
                    uuid = ExtractUUID.GetUUID(ruta & documento)

                    Dim IdEmpresaSolicitud = RecuperaIdEmpresaSolicitud(id_solicitud, tipo)
                    '20230609 - Validación para que no carguen XML timbrados hace más de dos meses (La validación solo aplica para NB)
                    If IdEmpresaSolicitud = 3 Then
                        Dim fechaTimbradoString As String = ExtractUUID.GetFechaTimbrado(ruta & documento)
                        fechaTimbrado = New DateTime(CInt(fechaTimbradoString.Substring(0, 4)), CInt(fechaTimbradoString.Substring(5, 2)), CInt(fechaTimbradoString.Substring(8, 2)))
                        If fechaTimbrado < DateTime.Now.AddDays(-62) Then
                            Throw New Exception("Factura no válida debido a su fecha de emisión. Favor de revisarlo con Administración")
                        End If
                    End If
                End If
            Catch ex As Exception
                uuid = "Error: " & ex.Message
            End Try


            Dim sql As String = "guarda_solicitud_documento"

            Dim params As SqlParameter() = New SqlParameter(4) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("documento", documento)
            params(2) = New SqlParameter("tipo", tipo)
            params(3) = New SqlParameter("id_solicitud_detalle", id_solicitud_detalle)
            params(4) = New SqlParameter("uuid", uuid)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Sub EliminaDocumento(id_documento As Integer, tipo As String)
        Try
            Dim sql As String = "elimina_solicitud_documento"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_documento", id_documento)
            params(1) = New SqlParameter("tipo", tipo)

            Dim sqlHelp As New SqlHelper(_connString)

            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function RecuperaSolicitudDocumento(id_solicitud As Integer, tipo As String) As DataTable
        Try
            Dim sql As String = "recupera_solicitud_documento"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("tipo", tipo)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function RecuperaIdEmpresaSolicitud(id_solicitud As Integer, tipo As String) As Integer
        Try
            Dim sql As String = "recupera_solicitud_id_empresa"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_solicitud", id_solicitud)
            params(1) = New SqlParameter("tipo", tipo)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0).Rows(0)("id_empresa")
        Catch ex As Exception
            Throw ex
        End Try
    End Function

End Class

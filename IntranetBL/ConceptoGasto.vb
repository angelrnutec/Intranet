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
Public Class ConceptoGasto
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Function Recupera(tipo As String, tipo_comprobantes As String, id_empresa As Integer) As DataTable
        Try
            Dim sql As String = "recupera_concepto_gasto"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("tipo", tipo)
            params(1) = New SqlParameter("tipo_comprobantes", tipo_comprobantes)
            params(2) = New SqlParameter("id_empresa", id_empresa)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function RecuperaPorId(ByVal id_concepto As Integer) As DataTable
        Try
            Dim sql As String = "recupera_concepto_gasto_x_id"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_concepto", id_concepto)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function Guarda(ByVal id_concepto As Integer, ByVal clave As String, ByVal descripcion As String, ByVal descripcion_en As String, tipo As String,
                           ByVal nb_cuenta_clave As String, ByVal nb_cuenta_desc As String, ByVal nf_cuenta_clave As String,
                           ByVal nf_cuenta_desc As String, ByVal ns_cuenta_clave As String, ByVal ns_cuenta_desc As String,
                           ByVal nb_cuenta_desc_reportes As String, ByVal limite_diario As Decimal, ByVal es_no_deducible As Boolean,
                           ByVal es_iva_editable As Boolean, ByVal nu_cuenta_clave As String, ByVal nu_cuenta_desc As String,
                           ByVal permite_propina As Boolean, ByVal es_gasto_viaje As Boolean, ByVal es_gasto_directivo As Boolean,
                           ByVal es_gasto_viaje_cova As Boolean) As Integer
        Try
            Dim sql As String = "guarda_concepto_gasto"

            Dim params As SqlParameter() = New SqlParameter(21) {}
            params(0) = New SqlParameter("id_concepto", id_concepto)
            params(1) = New SqlParameter("clave", clave)
            params(2) = New SqlParameter("descripcion", descripcion)
            params(3) = New SqlParameter("tipo", tipo)
            params(4) = New SqlParameter("nb_cuenta_clave", nb_cuenta_clave)
            params(5) = New SqlParameter("nb_cuenta_desc", nb_cuenta_desc)
            params(6) = New SqlParameter("nf_cuenta_clave", nf_cuenta_clave)
            params(7) = New SqlParameter("nf_cuenta_desc", nf_cuenta_desc)
            params(8) = New SqlParameter("ns_cuenta_clave", ns_cuenta_clave)
            params(9) = New SqlParameter("ns_cuenta_desc", ns_cuenta_desc)
            params(10) = New SqlParameter("nb_cuenta_desc_reportes", nb_cuenta_desc_reportes)
            params(11) = New SqlParameter("limite_diario", limite_diario)
            params(12) = New SqlParameter("es_no_deducible", es_no_deducible)
            params(13) = New SqlParameter("es_iva_editable", es_iva_editable)
            params(14) = New SqlParameter("descripcion_en", descripcion_en)
            params(15) = New SqlParameter("nu_cuenta_clave", nu_cuenta_clave)
            params(16) = New SqlParameter("nu_cuenta_desc", nu_cuenta_desc)
            params(17) = New SqlParameter("permite_propina", permite_propina)
            params(18) = New SqlParameter("es_gasto_viaje", es_gasto_viaje)
            params(19) = New SqlParameter("es_gasto_directivo", es_gasto_directivo)
            params(20) = New SqlParameter("es_gasto_viaje_cova", es_gasto_viaje_cova)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function Elimina(ByVal id_concepto As Integer) As String
        Try


            'Dim mensaje As String = ValidaDependencia(id_concepto)
            'If mensaje.Length > 0 Then
            '    Return mensaje
            'Else
            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "elimina_concepto_gasto"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_concepto", id_concepto)


            sqlHelp.ExecuteNonQuery(sql, params)
            Return ""

            'End If

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




End Class

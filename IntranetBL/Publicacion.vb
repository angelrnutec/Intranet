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
Public Class Publicacion
    Private _connString As String = ""
    Public Sub New(ByVal connString As String)
        _connString = connString
    End Sub


    Public Function Recupera(visible As String, activo As Integer, id_empleado As Integer, locale As String) As DataTable
        Try
            Dim sql As String = "recupera_publicacion"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("visible", visible)
            params(1) = New SqlParameter("activo", activo)
            params(2) = New SqlParameter("id_empleado", id_empleado)
            params(3) = New SqlParameter("locale", locale)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaCategoriaAvisos() As DataTable
        Try
            Dim sql As String = "recupera_categoria_aviso"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("titulo", "")

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub GuardaCategoriaAviso(id_categoria As Integer, descripcion As String, descripcion_en As String, es_borrado As Boolean)
        Try
            Dim sql As String = "guarda_categoria_aviso"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_categoria", id_categoria)
            params(1) = New SqlParameter("descripcion", descripcion)
            params(2) = New SqlParameter("es_borrado", es_borrado)
            params(3) = New SqlParameter("descripcion_en", descripcion_en)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function RecuperaPublicaciones(id_empleado As Integer, id_tipo_publicacion As Integer, id_categoria As Integer, locale As String)
        Try
            Dim sql As String = "recupera_publicaciones"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("id_tipo_publicacion", id_tipo_publicacion)
            params(2) = New SqlParameter("id_categoria", id_categoria)
            params(3) = New SqlParameter("locale", locale)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPorBusqueda(id_empleado As Integer, texto As String) As DataTable
        Try
            Dim sql As String = "recupera_publicaciones_busqueda"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("texto", texto)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function RecuperaPorIdTexto(id_texto As String, id_empleado As Integer) As DataTable
        Try
            Dim sql As String = "recupera_publicacion_x_id_texto"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("id_texto", id_texto)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaLigasDeInteres(id_empleado As Integer, locale As String) As DataTable
        Try
            Dim sql As String = "recupera_publicacion_ligas_interes"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("locale", locale)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaBanners(id_empleado As Integer, ubicacion As String, locale As String) As DataTable
        Try
            Dim sql As String = "recupera_publicacion_banner"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("ubicacion", ubicacion)
            params(2) = New SqlParameter("locale", locale)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaNoticiasUltimas(id_empleado As Integer, locale As String) As DataTable
        Try
            Dim sql As String = "recupera_publicacion_ultimas_noticias"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("locale", locale)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaEventos(id_empleado As Integer, locale As String) As DataTable
        Try
            Dim sql As String = "recupera_publicacion_evento"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_empleado", id_empleado)
            params(1) = New SqlParameter("locale", locale)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPublicacionBanner(id_publicacion As Integer) As String
        Try
            Dim sql As String = "recupera_publicacion_x_id"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_publicacion", id_publicacion)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0).Rows(0)("liga_banner")
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Sub AgregaDocumento(id_publicacion As Integer, nombre As String)
        Try
            Dim sql As String = "guarda_publicacion_documento"

            Dim params As SqlParameter() = New SqlParameter(3) {}
            params(0) = New SqlParameter("id_documento", 0)
            params(1) = New SqlParameter("id_publicacion", id_publicacion)
            params(2) = New SqlParameter("nombre", nombre)
            params(3) = New SqlParameter("documento", nombre)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub


    Public Sub AgregaDocumentoPortada(id_publicacion As Integer, nombre As String)
        Try
            Dim sql As String = "guarda_publicacion_portada"

            Dim params As SqlParameter() = New SqlParameter(1) {}
            params(0) = New SqlParameter("id_publicacion", id_publicacion)
            params(1) = New SqlParameter("nombre", nombre)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Sub EliminarDocumento(id_documento As Integer)
        Try
            Dim sql As String = "elimina_publicacion_documento"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_documento", id_documento)

            Dim sqlHelp As New SqlHelper(_connString)
            sqlHelp.ExecuteNonQuery(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Function AgregaPublicacion(id_grupo As Integer, id_tipo_publicacion As Integer, id_empleado As Integer) As Integer
        Try
            Dim sql As String = "agrega_publicacion"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_grupo", id_grupo)
            params(1) = New SqlParameter("id_tipo_publicacion", id_tipo_publicacion)
            params(2) = New SqlParameter("id_empleado", id_empleado)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaTipoPublicacionCombo(titulo As String) As DataTable
        Try
            Dim sql As String = "recupera_tipo_publicacion_combo"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("titulo", titulo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPorId(ByVal id_publicacion As Integer) As DataTable
        Try
            Dim sql As String = "recupera_publicacion_x_id"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_publicacion", id_publicacion)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPublicacionDocumento(id_publicacion As Integer) As DataTable
        Try
            Dim sql As String = "recupera_publiacion_documento"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_publicacion", id_publicacion)


            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function Guarda(ByVal id_publicacion As Integer, ByVal id_grupo As Integer,
            ByVal id_empleado_registro As Integer, ByVal estatus As String, ByVal id_tipo_publicacion As Integer,
            ByVal titulo As String, ByVal descripcion_corta As String, ByVal descripcion As String,
            ByVal titulo_en As String, ByVal descripcion_corta_en As String, ByVal descripcion_en As String,
            ByVal imagen_destacada As String, ByVal permite_comentarios As Boolean, ByVal borrada As Boolean,
            ByVal fecha_publicacion As DateTime, ByVal liga_url As String, ByVal liga_desc As String, ByVal fecha_evento As DateTime,
            ByVal liga_target As String, ByVal liga_banner As String, ByVal ubicacion As String, ByVal id_vendedor As Integer,
            ByVal id_categoria As Integer, ByVal telefono As String) As Integer
        Try
            Dim sql As String = "guarda_publicacion"

            Dim params As SqlParameter() = New SqlParameter(23) {}
            params(0) = New SqlParameter("id_publicacion", id_publicacion)
            params(1) = New SqlParameter("id_grupo", id_grupo)
            params(2) = New SqlParameter("id_empleado_registro", id_empleado_registro)
            params(3) = New SqlParameter("estatus", estatus)
            params(4) = New SqlParameter("id_tipo_publicacion", id_tipo_publicacion)
            params(5) = New SqlParameter("titulo", titulo)
            params(6) = New SqlParameter("descripcion_corta", descripcion_corta)
            params(7) = New SqlParameter("descripcion", descripcion)
            params(8) = New SqlParameter("imagen_destacada", imagen_destacada)
            params(9) = New SqlParameter("permite_comentarios", permite_comentarios)

            params(10) = New SqlParameter("borrada", borrada)
            params(11) = New SqlParameter("fecha_publicacion", fecha_publicacion)
            params(12) = New SqlParameter("liga_url", liga_url)
            params(13) = New SqlParameter("liga_desc", liga_desc)
            params(14) = New SqlParameter("fecha_evento", fecha_evento)
            params(15) = New SqlParameter("liga_target", liga_target)
            params(16) = New SqlParameter("liga_banner", liga_banner)
            params(17) = New SqlParameter("ubicacion", ubicacion)

            params(18) = New SqlParameter("id_vendedor", id_vendedor)
            params(19) = New SqlParameter("id_categoria", id_categoria)
            params(20) = New SqlParameter("telefono", telefono)

            params(21) = New SqlParameter("titulo_en", titulo_en)
            params(22) = New SqlParameter("descripcion_en", descripcion_en)
            params(23) = New SqlParameter("descripcion_corta_en", descripcion_corta_en)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function EliminaComentario(ByVal id_publicacion As Integer) As String
        Try


            Dim mensaje As String = ValidaDependencia(id_publicacion)
            If mensaje.Length > 0 Then
                Return mensaje
            Else
                Dim sqlHelp As New SqlHelper(_connString)
                Dim sql As String = "elimina_publicacion"

                Dim params As SqlParameter() = New SqlParameter(0) {}
                params(0) = New SqlParameter("id_publicacion", id_publicacion)


                sqlHelp.ExecuteNonQuery(sql, params)
                Return ""

            End If




        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function ValidaDependencia(ByVal id_publicacion As Integer) As String
        Try
            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "valida_dependencia_publicacion"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_publicacion", id_publicacion)


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




    Public Function RecuperaComentarios(ByVal id_publicacion As Integer, id_ultimo As Integer) As DataTable
        Try
            Dim sql As String = "recupera_publicacion_comentario"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_publicacion", id_publicacion)
            params(1) = New SqlParameter("id_ultimo", id_ultimo)

            Dim sqlHelp As New SqlHelper(_connString)
            Return sqlHelp.ExecuteDataAdapter(sql, params).Tables(0)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function GuardaComentario(ByVal id_publicacion As Integer, _
                                     ByVal id_empleado As Integer, _
                                     ByVal comentario As String) As Integer
        Try
            Dim sql As String = "guarda_publicacion_comentario"

            Dim params As SqlParameter() = New SqlParameter(2) {}
            params(0) = New SqlParameter("id_publicacion", id_publicacion)
            params(1) = New SqlParameter("id_empleado", id_empleado)
            params(2) = New SqlParameter("comentario", comentario)

            Dim sqlHelp As New SqlHelper(_connString)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function



    Public Function Elimina(ByVal id_comentario As Integer) As String
        Try
            Dim sqlHelp As New SqlHelper(_connString)
            Dim sql As String = "elimina_publicacion_comentario"

            Dim params As SqlParameter() = New SqlParameter(0) {}
            params(0) = New SqlParameter("id_comentario", id_comentario)

            sqlHelp.ExecuteNonQuery(sql, params)
            Return ""
        Catch ex As Exception
            Throw ex
        End Try
    End Function


End Class

Imports IntranetBL
Imports System.Net

Public Class Login
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Session.Abandon()
            Dim CacheEnum As IDictionaryEnumerator = HttpRuntime.Cache.GetEnumerator()
            While CacheEnum.MoveNext()
                Dim key As String = CacheEnum.Key.ToString()
                HttpRuntime.Cache.Remove(key)
            End While

            If Request.QueryString("URL") IsNot Nothing Then
                Me.txtURLTarget.Text = Request.QueryString("URL")
            Else
                Me.txtURLTarget.Text = "Default.aspx"
            End If



        End If
    End Sub

    Private Sub btnEntrar_Click(sender As Object, e As ImageClickEventArgs) Handles btnEntrar.Click




        Try
            Session("idEmpleado") = Nothing
            Session("idEmpresa") = Nothing
            Session("idDepartamento") = Nothing
            Session("nombreEmpleado") = Nothing
            Session("departamentoEmpleado") = Nothing
            Session("fotoEmpleado") = Nothing
            Session("hacePublicaciones") = Nothing
            Session("permisos") = Nothing
            Session("esAdministrador") = Nothing
            Session("tienePasswordNomina") = Nothing
            Session("sesionNomina") = Nothing
            Session("empleadoEmail") = Nothing
            Session("empleadoUsuario") = Nothing
            Session("numTarjetaGastos") = Nothing

            ValidaFormulario()

            Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings.[Get]("CONEXION"))
            Dim ds As DataSet = seguridad.ValidaLogin(Me.txtUsuario.Text, Me.txtPassword.Text, GetIp(Request).ToString())
            Dim dtRegenera As DataTable = ds.Tables(0)
            If dtRegenera.Rows(0)("reset_password") <> "" Then
                Dim email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
                Response.Redirect(email_url_base & "/GenerarPasswordNuevo.aspx?vencida=1&c=" & dtRegenera.Rows(0)("reset_password"))
            Else
                Dim dt As DataTable = ds.Tables(1)
                Dim dtPermisos As DataTable = ds.Tables(2)
                Dim dtPaginas As DataTable = ds.Tables(3)

                If dt.Rows.Count > 0 Then
                    Dim dr As DataRow = dt.Rows(0)
                    Session("idEmpleado") = dr("id_empleado").ToString()
                    Session("nombreEmpleado") = dr("nombre").ToString()
                    Session("departamentoEmpleado") = dr("departamento").ToString()
                    Session("fotoEmpleado") = dr("foto").ToString()
                    Session("hacePublicaciones") = dr("hace_publicaciones").ToString()
                    Session("idEmpresa") = dr("id_empresa").ToString()
                    Session("esAdministrador") = dr("es_admin").ToString()
                    Session("tienePasswordNomina") = dr("tiene_password_nomina").ToString()
                    Session("empleadoEmail") = dr("empleado_email").ToString()
                    Session("empleadoUsuario") = Me.txtUsuario.Text
                    Session("idDepartamento") = dr("id_departamento").ToString()
                    Session("numTarjetaGastos") = dr("num_tarjeta_gastos").ToString()


                    Dim permisos As New ArrayList()
                    For Each drP As DataRow In dtPermisos.Rows
                        permisos.Add(drP("permiso"))
                    Next
                    Session("permisos") = permisos
                    Session("dt_paginas") = dtPaginas

                    Dim mensaje As String = ""
                    If dr("folios_pendientes").ToString.Length > 0 Then
                        If Me.txtURLTarget.Text.IndexOf("?") >= 0 Then
                            mensaje = "&msg="
                        Else
                            mensaje = "?msg="
                        End If
                        mensaje &= "Favor de realizar su comprobacion de gastos para los folios: " & dr("folios_pendientes")
                    End If

                    Response.Redirect(txtURLTarget.Text & mensaje)
                Else
                    Throw New Exception("Usuario y/o contraseña incorrectos.")
                End If
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(lblPopUp, lblPopUp.[GetType](), "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Public Shared Function GetIp(request As HttpRequest) As IPAddress
        Dim ipString As String
        If String.IsNullOrEmpty(request.ServerVariables("HTTP_X_FORWARDED_FOR")) Then
            ipString = request.ServerVariables("REMOTE_ADDR")
        Else
            ipString = request.ServerVariables("HTTP_X_FORWARDED_FOR").Split(",".ToCharArray(), StringSplitOptions.RemoveEmptyEntries).FirstOrDefault()
        End If

        Dim result As IPAddress = Nothing
        If Not IPAddress.TryParse(ipString, result) Then
            result = IPAddress.None
        End If

        Return result
    End Function

    Protected Sub ValidaFormulario()
        Try
            Dim msg As New StringBuilder()

            If Me.txtUsuario.Text.Trim().Length = 0 Then
                msg.Append("- Usuario\n")
            End If
            If Me.txtPassword.Text.Trim().Length = 0 Then
                msg.Append("- Contraseña\n")
            End If

            If msg.Length > 0 Then
                Throw New Exception("Favor de proporcionar la siguiente información\n\n" & msg.ToString())
            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub
End Class
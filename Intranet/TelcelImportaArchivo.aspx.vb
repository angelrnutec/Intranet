Imports IntranetBL
Imports Excel

Public Class TelcelImportaArchivo
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            CargaCombos()
        End If

    End Sub

    Private Sub CargaCombos()
        Try
            For i As Integer = Now.AddMonths(1).Year To 2013 Step -1
                Me.ddlAnio.Items.Add(i)
            Next

            Dim items As New List(Of ListItem)
            items.Add(New ListItem("-- Seleccione --", "0"))
            items.Add(New ListItem("Enero", "1"))
            items.Add(New ListItem("Febrero", "2"))
            items.Add(New ListItem("Marzo", "3"))
            items.Add(New ListItem("Abril", "4"))
            items.Add(New ListItem("Mayo", "5"))
            items.Add(New ListItem("Junio", "6"))
            items.Add(New ListItem("Julio", "7"))
            items.Add(New ListItem("Agosto", "8"))
            items.Add(New ListItem("Septiembre", "9"))
            items.Add(New ListItem("Octubre", "10"))
            items.Add(New ListItem("Noviembre", "11"))
            items.Add(New ListItem("Diciembre", "12"))
            Me.ddlMes.Items.AddRange(items.ToArray)

            Me.ddlAnio.SelectedValue = Now.Year
         
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    Private Sub btnNuevo_Click(sender As Object, e As EventArgs) Handles btnImportar.Click

        divPrevio.Visible = False
        divFinal.Visible = True
        divUpload.Visible = False
        Try
            Dim archivo As String = Server.MapPath("\") & "uploads\" & Me.txtNombre.Text

            Dim resultado As String = ProcesaArchivo(archivo, 1, Me.ddlAnio.SelectedValue, Me.ddlMes.SelectedValue)
            lblResultado.Text = "<br>" & resultado

            EmailNotifiacionReporteTelefonia()
        Catch ex As Exception
            lblResultado.Text = ex.Message
        End Try

    End Sub

    Private Function FormatoFecha(texto As String) As String
        Try
            If texto.Split("/").Length = 3 Then
                Dim anio As String = texto.Split("/")(2)
                Dim mes As String = texto.Split("/")(1)
                Dim dia As String = texto.Split("/")(0)

                Return New Date(anio, mes, dia).ToString("yyyyMMdd")
            End If
        Catch ex As Exception
            Throw New Exception("Fecha invalida en la columna G")
        End Try
        Return ""
    End Function

    Private Function ProcesaArchivo(archivo As String, id_usuario As Integer, anio As Integer, periodo As Integer) As String
        Try
            Dim mensajes As String = ""
            Dim datosExcel As New ExcelData(archivo)
            Dim telcel As New Telcel(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            telcel.LimpiaDatos()

            Dim hojas = datosExcel.getWorksheetNames()
            For Each hoja In hojas
                Try
                    Dim filas As Integer = 0
                    Dim registros = datosExcel.getData(hoja)
                    Dim sqlStr As New StringBuilder("")
                    sqlStr.AppendLine("insert into telcel_datos_paso (region,padre,cuenta,rfc,razon_social,telefono,fecha_factura,factura,nombre_plan," & _
                                                "renta, serv_adicionales, ta_importe, ta_min_libres_pico, ta_min_factur_pico, ta_min_libres_nopico," & _
                                                "ta_min_factur_nopico, ld_total, ldn_importe, ldn_libres, ldn_factur, ldi_importe, ldi_libres," & _
                                                "ldi_factur, ldm_importe, ldm_libres, ldm_factur, tarn_importe, tarn_libres, tarn_factur," & _
                                                "ldrn_importe, ldrn_libres, ldrn_factur, tari_importe, tari_libres, tari_factur, ldri_importe," & _
                                                "ldri_libres, ldri_factur, importe_siva, fianza, descuento_tar, renta_roaming, impuestos, cargos," & _
                                                "fecha_registro, id_usuario_registro, anio, periodo) ")

                    Dim contrato As String = ""
                    Dim i As Integer = 0
                    For Each registro In registros
                        i += 1
                        If i > 2 And IsDBNull(registro(0)) = False Then
                            If registro(0).ToString().IndexOf("Número de registros") < 0 Then
                                filas += 1
                                contrato = registro(1)
                                sqlStr.AppendLine("select ")
                                sqlStr.Append(String.Format("'{0}',", registro(0)))
                                sqlStr.Append(String.Format("'{0}',", registro(1)))
                                sqlStr.Append(String.Format("'{0}',", registro(2)))
                                sqlStr.Append(String.Format("'{0}',", registro(3)))
                                sqlStr.Append(String.Format("'{0}',", registro(4)))
                                sqlStr.Append(String.Format("'{0}',", registro(5)))
                                sqlStr.Append(String.Format("'{0}',", FormatoFecha(registro(6))))
                                sqlStr.Append(String.Format("'{0}',", registro(7)))
                                sqlStr.Append(String.Format("'{0}',", registro(8)))
                                sqlStr.Append(String.Format("{0},", registro(9)))
                                sqlStr.Append(String.Format("{0},", registro(10)))
                                sqlStr.Append(String.Format("{0},", registro(11)))
                                sqlStr.Append(String.Format("{0},", registro(13)))
                                sqlStr.Append(String.Format("{0},", registro(14)))
                                sqlStr.Append(String.Format("{0},", registro(16)))
                                sqlStr.Append(String.Format("{0},", registro(17)))
                                sqlStr.Append(String.Format("{0},", registro(18)))
                                sqlStr.Append(String.Format("{0},", registro(19)))
                                sqlStr.Append(String.Format("{0},", registro(21)))
                                sqlStr.Append(String.Format("{0},", registro(22)))
                                sqlStr.Append(String.Format("{0},", registro(23)))
                                sqlStr.Append(String.Format("{0},", registro(25)))
                                sqlStr.Append(String.Format("{0},", registro(26)))
                                sqlStr.Append(String.Format("{0},", registro(27)))
                                sqlStr.Append(String.Format("{0},", registro(29)))
                                sqlStr.Append(String.Format("{0},", registro(30)))
                                sqlStr.Append(String.Format("{0},", registro(31)))
                                sqlStr.Append(String.Format("{0},", registro(33)))
                                sqlStr.Append(String.Format("{0},", registro(34)))
                                sqlStr.Append(String.Format("{0},", registro(35)))
                                sqlStr.Append(String.Format("{0},", registro(37)))
                                sqlStr.Append(String.Format("{0},", registro(38)))
                                sqlStr.Append(String.Format("{0},", registro(39)))
                                sqlStr.Append(String.Format("{0},", registro(41)))
                                sqlStr.Append(String.Format("{0},", registro(42)))
                                sqlStr.Append(String.Format("{0},", registro(43)))
                                sqlStr.Append(String.Format("{0},", registro(45)))
                                sqlStr.Append(String.Format("{0},", registro(46)))
                                sqlStr.Append(String.Format("{0},", registro(47)))
                                sqlStr.Append(String.Format("{0},", registro(48)))
                                sqlStr.Append(String.Format("{0},", registro(49)))
                                sqlStr.Append(String.Format("{0},", registro(50)))
                                sqlStr.Append(String.Format("{0},", registro(51)))
                                sqlStr.Append(String.Format("{0},", registro(52)))
                                sqlStr.Append("getdate(),")
                                sqlStr.Append(String.Format("{0},", id_usuario))
                                sqlStr.Append(String.Format("{0},", anio))
                                sqlStr.Append(String.Format("{0}", periodo))
                                sqlStr.AppendLine(" union")
                            End If
                        End If
                    Next

                    If contrato.Length > 0 Then
                        telcel.GuardaDatos(sqlStr.ToString().Substring(0, sqlStr.ToString().Length - 7))
                    End If
                    mensajes += "&nbsp;&nbsp;Hoja '" & hoja & "' procesada correctamente, " & filas & " registros.<br />"
                Catch ex As Exception
                    mensajes += "&nbsp;&nbsp;Hoja '" & hoja & "' procesada con errores: " & ex.Message & "<br />"
                End Try
            Next

            mensajes += telcel.ProcesoFinal()

            Return mensajes
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Private Sub EmailNotifiacionReporteTelefonia()
        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Try            
            Dim email_bbc As String = ""
            Dim email_de As String = ""
            Dim email_usuario As String = ""
            Dim email_asunto As String = ""
            Dim email_smtp As String = ""
            Dim email_password As String = ""
            Dim email_port As String = ""
            Dim email_copia As String = ""
            Dim email_url_base As String = ""
            Dim errorMsg As String = ""
            Dim email_body As String
            Dim folio As String = ""
            Dim id_cliente As Integer = 0
            Dim archivos As String = ""

            Dim dt As DataTable = seguridad.RecuperaParametrosGenerales()

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                email_smtp = System.Configuration.ConfigurationManager.AppSettings("SMTP_SERVER").ToString()
                email_usuario = System.Configuration.ConfigurationManager.AppSettings("SMTP_USER").ToString()
                email_password = System.Configuration.ConfigurationManager.AppSettings("SMTP_PASS").ToString()
                email_port = System.Configuration.ConfigurationManager.AppSettings("SMTP_PORT").ToString()
                email_de = System.Configuration.ConfigurationManager.AppSettings("SMTP_FROM").ToString()
                email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
                email_asunto = "Reporte de Telefonia"

                If dr("email_notificacion_datos_telefonia").ToString.Length > 0 Then
                    email_bbc = dr("email_notificacion_datos_telefonia")
                Else
                    email_bbc = System.Configuration.ConfigurationManager.AppSettings("EMAIL_DEFAULT").ToString()
                End If

                email_body = "<table><tr><td>Estimado usuario,</td></tr><tr><td>Este correo es para notificarle que se ha actualizado el reporte de telefonía en intranet.</td></tr>" &
                                "<tr><td>http://intranet.nutec.com/TelcelRepConsumos.aspx</td></tr></table>"

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, "", email_bbc, email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioNotificacionReporteTelefonia: " & resultado & "::::" & email_bbc & "---->" & email_body)
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioNotificacionReporteTelefonia: Error " & email_bbc & ", " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Public Shared Function RetrieveHttpContent(Url As String, ByRef ErrorMessage As String) As String
        Dim MergedText As String = ""
        Dim Http As New System.Net.WebClient()
        Try
            Dim Result As Byte() = Http.DownloadData(Url)
            Result = ConvertUtf8ToLatin1(Result)
            MergedText = System.Text.Encoding.GetEncoding(28591).GetString(Result)
        Catch ex As Exception
            ErrorMessage = ex.Message.Replace(CChar(ChrW(39)), CChar(ChrW(34)))
            Return Nothing
        End Try
        Return MergedText
    End Function

    Public Shared Function ConvertUtf8ToLatin1(bytes As Byte()) As Byte()
        Dim latin1 As System.Text.Encoding = System.Text.Encoding.GetEncoding(&H6FAF)
        Return System.Text.Encoding.Convert(System.Text.Encoding.UTF8, latin1, bytes)
    End Function

End Class

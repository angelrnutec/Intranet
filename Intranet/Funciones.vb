
Imports Intranet.LocalizationIntranet
Imports IntranetBL

Public NotInheritable Class Funciones

    Public Shared Function DatatableToList(dt As DataTable, description As String, value As String) As ListItem()

        Dim resultado(dt.Rows.Count - 1) As ListItem

        Dim i As Integer = 0
        For Each dr As DataRow In dt.Rows
            resultado(i) = New ListItem(TranslateLocale.text(dr(description)), dr(value))
            i += 1
        Next
        Return resultado
    End Function

    Public Shared Sub TranslateGridviewHeader(ByRef dv As GridView)
        For Each dvr As DataControlField In dv.Columns
            dvr.HeaderText = TranslateLocale.text(dvr.HeaderText)
        Next
    End Sub

    Public Shared Sub TranslateGridviewHeader(ByRef dv As GridView, locale As String)
        For Each dvr As DataControlField In dv.Columns
            dvr.HeaderText = TranslateLocale.text(dvr.HeaderText, locale)
        Next
    End Sub


    Public Shared Sub TranslateTableData(ByRef dt As DataTable, ByVal params() As String)
        For Each row As DataRow In dt.Rows
            For Each param As String In params
                row(param) = TranslateLocale.text(row(param))
            Next
            row.EndEdit()
            dt.AcceptChanges()
        Next

    End Sub

    Public Shared Function CurrentLocale() As String
        Return TranslateLocale.getLocale()
    End Function
















    Public Shared Sub EnviarEmailArrendamientoAuth(ByVal id_arrendamiento As Integer, ByVal tipo As Integer, ByVal tipo_email As String)
        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Try
            Dim email_para As String = ""
            Dim email_de As String = ""
            Dim email_usuario As String = ""
            Dim email_asunto As String = ""
            Dim email_smtp As String = ""
            Dim email_password As String = ""
            Dim email_port As String = ""
            Dim email_copia As String = ""
            Dim email_url_base As String = ""
            Dim email_url_base_local As String = ""
            Dim errorMsg As String = ""
            Dim email_body As String
            Dim folio As String = ""
            Dim id_cliente As Integer = 0
            Dim archivos As String = ""

            Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = arrendamiento.RecuperaEmail(id_arrendamiento)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                email_smtp = System.Configuration.ConfigurationManager.AppSettings("SMTP_SERVER").ToString()
                email_usuario = System.Configuration.ConfigurationManager.AppSettings("SMTP_USER").ToString()
                email_password = System.Configuration.ConfigurationManager.AppSettings("SMTP_PASS").ToString()
                email_port = System.Configuration.ConfigurationManager.AppSettings("SMTP_PORT").ToString()
                email_de = System.Configuration.ConfigurationManager.AppSettings("SMTP_FROM").ToString()
                email_url_base = System.Configuration.ConfigurationManager.AppSettings("URL_BASE").ToString()
                email_url_base_local = System.Configuration.ConfigurationManager.AppSettings("URL_BASE_LOCAL").ToString()




                Dim EMAIL_LOCALE = "es"
                If dr("id_empresa") = 12 Then EMAIL_LOCALE = "en"
                Dim urlEmail As String = ""

                Select Case tipo_email
                    Case "Autorizante"
                        If tipo = -1 Then
                            email_para = dr("email_usuario_auth_rh")
                            urlEmail = email_url_base_local & "/Email_Formatos/EnvioAutorizacionArrendamiento.aspx?id=" & id_arrendamiento & "&auth=1"
                        ElseIf tipo = 1 Then
                            email_para = dr("email_usuario_auth_negocios")
                            urlEmail = email_url_base_local & "/Email_Formatos/EnvioAutorizacionArrendamiento.aspx?id=" & id_arrendamiento & "&auth=2"
                        ElseIf tipo = 2 Then
                            email_para = dr("email_usuario_auth_finanzas")
                            urlEmail = email_url_base_local & "/Email_Formatos/EnvioAutorizacionArrendamiento.aspx?id=" & id_arrendamiento & "&auth=3"
                        End If
                        email_asunto = TranslateLocale.text("Solicitud de autorización de arrendamiento", EMAIL_LOCALE) & " (" & dr("numero").ToString() & ")"


                    Case "Solicitante"
                        email_para = dr("email_usuario_registro")
                        email_asunto = TranslateLocale.text("Arrendamiento Autorizado", EMAIL_LOCALE) & " (" & dr("numero").ToString() & ")"

                        If tipo = 1 Then
                            urlEmail = email_url_base_local & "/Email_Formatos/EnvioAutorizacionArrendamiento.aspx?id=" & id_arrendamiento & "&auth=4"
                        ElseIf tipo = 2 Then
                            urlEmail = email_url_base_local & "/Email_Formatos/EnvioAutorizacionArrendamiento.aspx?id=" & id_arrendamiento & "&auth=5"
                        ElseIf tipo = 3 Then
                            urlEmail = email_url_base_local & "/Email_Formatos/EnvioAutorizacionArrendamiento.aspx?id=" & id_arrendamiento & "&auth=6"
                        End If


                    Case "Rechazado"
                        email_para = dr("email_usuario_registro")
                        email_asunto = TranslateLocale.text("Arrendamiento Rechazado", EMAIL_LOCALE) & " (" & dr("numero").ToString() & ")"

                        urlEmail = email_url_base_local & "/Email_Formatos/EnvioAutorizacionArrendamiento.aspx?id=" & id_arrendamiento & "&auth=0"

                End Select



                email_body = RetrieveHttpContent(urlEmail, errorMsg)

                Try
                    Dim mail As New SendMailBL(email_smtp, email_usuario, email_password, email_port)
                    Dim resultado As String = mail.Send(email_de, email_para, "", email_asunto, email_body, email_copia, "")

                    seguridad.GuardaLogDatos("EnvioArrendamientoAutoriza: " & resultado & "::::" & email_para & "---->" & urlEmail)
                Catch ex As Exception
                    seguridad.GuardaLogDatos("EnvioArrendamientoAutoriza: Error " & email_para & ", " & ex.Message())
                End Try

            End If
        Catch ex As Exception
            Throw ex
        End Try
    End Sub



    Function EmailAddressCheck(ByVal emailAddress As String) As Boolean

        Dim pattern As String = "^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$"
        Dim emailAddressMatch As Match = Regex.Match(emailAddress, pattern)
        If emailAddressMatch.Success Then
            EmailAddressCheck = True
        Else
            EmailAddressCheck = False
        End If

    End Function

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

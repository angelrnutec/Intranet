Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports IntranetDA
Imports System.Net.Mail

Public Class SendMailBL

    Private _host As String = ""
    Private _usuario As String = ""
    Private _password As String = ""
    Private _puerto As String = ""
    Public Sub New(ByVal host As String, ByVal usuario As String, ByVal password As String, ByVal puerto As String)
        _host = host
        _usuario = usuario
        _password = password
        _puerto = puerto
    End Sub

    Public Function Send(ByVal from As String, ByVal [to] As String, ByVal bcc As String, _
                            ByVal subject As String, ByVal message As String, ByVal email_copia_1 As String, _
                            ByVal email_copia_2 As String, Optional ByVal rutaAttachments As String = "", Optional ByVal strAttachments As String = "") As String
        Try
            Dim correo As New System.Net.Mail.MailMessage()
            correo.From = New System.Net.Mail.MailAddress(from)
            'correo.To.Add([to])

            [to] = [to].Replace(",", ";")

            Dim strTo2() As String = [to].Split(";")
            For Each strSplit As String In strTo2
                If strSplit.Trim.Length > 0 Then
                    Try
                        correo.To.Add(New MailAddress(strSplit.Trim))
                    Catch ex As Exception
                        Throw New Exception(ex.Message)
                    End Try
                End If
            Next

            If email_copia_1.Trim.Length > 0 Then
                correo.CC.Add(email_copia_1)
            End If
            If email_copia_2.Trim.Length > 0 Then
                correo.CC.Add(email_copia_2)
            End If
            'If bcc.Trim.Length > 0 Then
            '    correo.Bcc.Add(bcc)
            'End If
            bcc = bcc.Replace(",", ";")

            Dim strbcc2() As String = bcc.Split(";")
            For Each strSplit As String In strbcc2
                If strSplit.Trim.Length > 0 Then
                    Try
                        correo.Bcc.Add(New MailAddress(strSplit.Trim))
                    Catch ex As Exception
                        Throw New Exception(ex.Message)
                    End Try
                End If
            Next

            correo.Subject = subject
            correo.Body = message

            correo.IsBodyHtml = True

            If Not strAttachments.Equals(String.Empty) Then
                Dim strFile As String
                Dim strAttach() As String = strAttachments.Split(",")

                For Each strFile In strAttach
                    If strFile.Trim().Length > 0 Then
                        correo.Attachments.Add(New Attachment(rutaAttachments & strFile.Trim()))

                    End If
                Next
            End If

            System.Net.ServicePointManager.SecurityProtocol = System.Net.SecurityProtocolType.Tls12

            correo.Priority = System.Net.Mail.MailPriority.Normal
            Dim smtp As New System.Net.Mail.SmtpClient()
            smtp.Host = _host
            smtp.Credentials = New System.Net.NetworkCredential(_usuario, _password)
            'smtp.EnableSsl = False
            smtp.EnableSsl = True
            smtp.Port = Convert.ToInt16(_puerto)

            smtp.Send(correo)
            Return "Email enviado correctamente"
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function SendAttachments(ByVal from As String, ByVal [to] As String, ByVal bcc As String, _
                            ByVal subject As String, ByVal message As String, ByVal email_copia_1 As String, _
                            ByVal email_copia_2 As String, ByVal file_name As String, ByVal file As System.IO.Stream) As String
        Try
            Dim correo As New System.Net.Mail.MailMessage()
            correo.From = New System.Net.Mail.MailAddress(from)
            'correo.To.Add([to])

            Dim strTo2() As String = [to].Split(",")
            For Each strSplit As String In strTo2
                If strSplit.Trim.Length > 0 Then
                    Try
                        correo.To.Add(New MailAddress(strSplit.Trim))
                    Catch ex As Exception
                        Throw New Exception(ex.Message)
                    End Try
                End If
            Next

            If email_copia_1.Trim.Length > 0 Then
                correo.CC.Add(email_copia_1)
            End If
            If email_copia_2.Trim.Length > 0 Then
                correo.CC.Add(email_copia_2)
            End If
            If bcc.Trim.Length > 0 Then
                correo.Bcc.Add(bcc)
            End If
            correo.Subject = subject
            correo.Body = message

            correo.IsBodyHtml = True

            If Not file Is Nothing Then
                correo.Attachments.Add(New Attachment(file, file_name))
            End If

            correo.Priority = System.Net.Mail.MailPriority.Normal
            Dim smtp As New System.Net.Mail.SmtpClient()
            smtp.Host = _host
            smtp.Credentials = New System.Net.NetworkCredential(_usuario, _password)
            smtp.EnableSsl = False
            smtp.Port = Convert.ToInt16(_puerto)

            smtp.Send(correo)
            Return "Email enviado correctamente"
        Catch ex As Exception
            Throw ex
        End Try
    End Function
End Class


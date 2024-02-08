Imports System.Web.SessionState
Imports System.Xml
Imports IntranetBL

Public Class Global_asax
    Inherits System.Web.HttpApplication

    Sub Application_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the application is started

        Dim myTranslations = New Hashtable
        Dim doc As XmlDocument = New XmlDocument()
        doc.Load(Server.MapPath("/locale.en.xml"))
        Dim lst As XmlNodeList = doc.SelectNodes("//item")


        For i = 0 To lst.Count - 1
            Dim key As String = lst(i).SelectSingleNode("key").InnerText
            Dim value As String = lst(i).SelectSingleNode("value").InnerText

            myTranslations.Add(key, value)
        Next

        Application("tablaTraducciones") = myTranslations


        Application("Modulo_TicketEmpresarial") = False
        Application("ClientId_TicketEmpresarial") = ""
        Application("Token_TicketEmpresarial") = ""
        Application("User_TicketEmpresarial") = ""
        Application("Pass_TicketEmpresarial") = ""

        Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dt As DataTable = seguridad.RecuperaParametrosGenerales()

        If dt.Rows.Count > 0 Then
            Dim dr As DataRow = dt.Rows(0)
            If dr("es_activo_ticket_empresarial") = True Then
                Application("Modulo_TicketEmpresarial") = True
                Application("ClientId_TicketEmpresarial") = dr("external_client_id_ticket_empresarial")
                Application("Token_TicketEmpresarial") = dr("token_ticket_empresarial")

                Application("User_TicketEmpresarial") = dr("user_ticket_empresarial")
                Application("Pass_TicketEmpresarial") = dr("pass_ticket_empresarial")

                Application("Email_TicketEmpresarial") = dr("email_notificaciones_ticket_empresarial")
            End If
        End If





    End Sub

    Sub Session_Start(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the session is started

    End Sub

    Sub Application_BeginRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires at the beginning of each request
    End Sub

    Sub Application_AuthenticateRequest(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires upon attempting to authenticate the use
    End Sub

    Sub Application_Error(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when an error occurs
    End Sub

    Sub Session_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the session ends
    End Sub

    Sub Application_End(ByVal sender As Object, ByVal e As EventArgs)
        ' Fires when the application ends
    End Sub

End Class
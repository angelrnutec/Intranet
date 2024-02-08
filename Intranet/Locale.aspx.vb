Imports System.Xml
Imports IntranetBL

Public Class Locale
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load





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

        Response.Clear()
        Response.Write("Traducciones: " & myTranslations.Count)
        Response.Write("<br />Modulo_TicketEmpresarial: " & Application("Modulo_TicketEmpresarial"))
        Response.End()

    End Sub

End Class
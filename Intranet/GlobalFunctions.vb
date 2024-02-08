Public NotInheritable Class GlobalFunctions

    Public Shared Function ModuloTicketEmpresarial() As Boolean
        If HttpContext.Current.Application("Modulo_TicketEmpresarial") Is Nothing Then
            Return False
        End If

        Dim dato As Boolean = HttpContext.Current.Application("Modulo_TicketEmpresarial")
        Return dato
    End Function

    Public Shared Function ClientIdTicketEmpresarial() As String
        If HttpContext.Current.Application("ClientId_TicketEmpresarial") Is Nothing Then
            Return ""
        End If

        Dim dato As String = HttpContext.Current.Application("ClientId_TicketEmpresarial")
        Return dato
    End Function

    Public Shared Function TokenTicketEmpresarial() As String
        If HttpContext.Current.Application("Token_TicketEmpresarial") Is Nothing Then
            Return ""
        End If

        Dim dato As String = HttpContext.Current.Application("Token_TicketEmpresarial")
        Return dato
    End Function

    Public Shared Function UserTicketEmpresarial() As String
        If HttpContext.Current.Application("User_TicketEmpresarial") Is Nothing Then
            Return ""
        End If

        Dim dato As String = HttpContext.Current.Application("User_TicketEmpresarial")
        Return dato
    End Function

    Public Shared Function PasswordTicketEmpresarial() As String
        If HttpContext.Current.Application("Pass_TicketEmpresarial") Is Nothing Then
            Return ""
        End If

        Dim dato As String = HttpContext.Current.Application("Pass_TicketEmpresarial")
        Return dato
    End Function

    Public Shared Function EmailTicketEmpresarial() As String
        If HttpContext.Current.Application("Email_TicketEmpresarial") Is Nothing Then
            Return ""
        End If

        Dim dato As String = HttpContext.Current.Application("Email_TicketEmpresarial")
        Return dato
    End Function



End Class
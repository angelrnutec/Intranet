Imports System.Data.SqlClient
Imports IntranetDA

Public Class TicketEmpresarial

    Private _Conexion As String

    Private _ExternalClientId As String
    Private _Token As String
    Private _Username As String
    Private _Password As String

    Public Sub New(ExternalClientId As String, Token As String, Username As String, Password As String, Conexion As String)
        _ExternalClientId = ExternalClientId
        _Token = Token
        _Username = Username
        _Password = Password

        _Conexion = Conexion
    End Sub

    Public Function GuardaTransaccion(transaccion As TicketEmpresarialTransaccion) As Integer
        Try
            Dim sql As String = "te_guarda_movimiento"

            Dim params As SqlParameter() = New SqlParameter(12) {}
            params(0) = New SqlParameter("id_solicitud", transaccion.id_solicitud)
            params(1) = New SqlParameter("fecha", transaccion.fecha)
            params(2) = New SqlParameter("exitoso", transaccion.exitoso)
            params(3) = New SqlParameter("importe", transaccion.importe)
            params(4) = New SqlParameter("importe_autorizado", transaccion.importe_autorizado)
            params(5) = New SqlParameter("saldo_anterior", transaccion.saldo_anterior)
            params(6) = New SqlParameter("saldo_nuevo", transaccion.saldo_nuevo)
            params(7) = New SqlParameter("tipo_movimiento", transaccion.tipo_movimiento)
            params(8) = New SqlParameter("numero_autorizacion", transaccion.numero_autorizacion)
            params(9) = New SqlParameter("error", transaccion.error)
            params(10) = New SqlParameter("referencia", transaccion.referencia)
            params(11) = New SqlParameter("id_usuario", transaccion.id_usuario)

            Dim sqlHelp As New SqlHelper(_Conexion)

            Return sqlHelp.ExecuteScalar(sql, params)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    Public Function AddBalance(cardNumber As String, amount As Decimal) As TicketEmpresarialTransaccion

        Dim t As New TicketEmpresarialTransaccion()
        t.tipo_movimiento = "A"
        t.fecha = DateTime.Now
        t.importe = amount
        t.exitoso = False
        t.error = ""

        Try
            t.saldo_anterior = CardGetListRequest(cardNumber)
            CardBalanceAssignment(cardNumber, amount, t)
            t.saldo_nuevo = CardGetListRequest(cardNumber)

        Catch ex As Exception
            t.error &= ex.Message
        End Try

        Return t
    End Function

    Public Function AdjustBalance(cardNumber As String, amount As Decimal) As TicketEmpresarialTransaccion

        Dim t As New TicketEmpresarialTransaccion()
        t.tipo_movimiento = "C"
        t.fecha = DateTime.Now
        t.importe = amount
        t.exitoso = False
        t.error = ""

        Try
            t.saldo_anterior = CardGetListRequest(cardNumber)
            If t.saldo_anterior < amount Then
                amount = t.saldo_anterior
            End If
            CardBalanceAdjustment(cardNumber, amount, t)
            t.saldo_nuevo = CardGetListRequest(cardNumber)

        Catch ex As Exception
            t.error &= ex.Message
        End Try

        Return t
    End Function


    Public Function CardGetListRequest(cardNumber As String) As Decimal

        Return 2000  ' TODO quitar


        Dim request As New TicketEmpresarialService.CardGetListRequest()
        request.Security = New TicketEmpresarialService.SecurityDTO()
        request.Security.ExternalClientId = _ExternalClientId
        request.Security.Token = _Token

        request.Filter = TicketEmpresarialService.CardGetListFilter.ByCardNumber
        request.FilterValue = cardNumber

        request.Paging = New TicketEmpresarialService.PagingDTO()

        Dim client As New TicketEmpresarialService.TEServiceClient()

        client.ClientCredentials.UserName.UserName = _Username
        client.ClientCredentials.UserName.Password = _Password


        Dim response As TicketEmpresarialService.CardGetListResponse = client.CardGetList(request)
        If response.Success Then
            If response.CardList IsNot Nothing Then
                For Each cardDetail As TicketEmpresarialService.CardDetailDTO In response.CardList
                    Return cardDetail.Amount
                Next
            Else
                Throw New Exception("CardGetListRequest: Sin resultado")
            End If
        Else
            If response.ErrorList IsNot Nothing Then
                For Each [error] As TicketEmpresarialService.ErrorDTO In response.ErrorList
                    Throw New Exception("Code: " + [error].Code + ", Message: " + [error].Message)
                Next
            End If

        End If

        Return 0
    End Function


    Private Sub CardBalanceAssignment(cardNumber As String, amount As Decimal, ByRef transaccion As TicketEmpresarialTransaccion)
        Dim request As New TicketEmpresarialService.CardBalanceAssignmentRequest()
        request.Security = New TicketEmpresarialService.SecurityDTO()
        request.Security.ExternalClientId = _ExternalClientId
        request.Security.Token = _Token


        Dim cards As TicketEmpresarialService.CardBalanceDTO() = New TicketEmpresarialService.CardBalanceDTO(0) {}
        cards(0) = New TicketEmpresarialService.CardBalanceDTO()
        cards(0).Amount = amount
        cards(0).CardNumber = cardNumber

        request.CardBalanceDTOList = cards


        Dim client As New TicketEmpresarialService.TEServiceClient()

        client.ClientCredentials.UserName.UserName = _Username
        client.ClientCredentials.UserName.Password = _Password


        Dim response As TicketEmpresarialService.CardBalanceAssignmentResponse = client.CardBalanceAssignment(request)
        If response.Success Then
            If response.CardBalanceDTOList IsNot Nothing Then
                For Each cardDetail As TicketEmpresarialService.CardBalanceDTO In response.CardBalanceDTOList
                    If cardDetail.AuthorizationNumber IsNot Nothing AndAlso cardDetail.AuthorizationNumber <> "" Then
                        transaccion.numero_autorizacion = cardDetail.AuthorizationNumber
                        transaccion.importe_autorizado = cardDetail.Amount
                        transaccion.exitoso = True
                    Else
                        transaccion.error &= "CardBalanceAssignment: No autorizado, sin error"
                    End If
                Next
            Else
                transaccion.error &= "CardBalanceAssignment: No autorizado, sin error"
            End If
        Else
            If response.CardBalanceDTOList IsNot Nothing Then
                For Each [error] As TicketEmpresarialService.ErrorDTO In response.ErrorList
                    transaccion.error &= "Code: " + [error].Code + ", Message: " + [error].Message
                Next
            Else
                transaccion.error &= "CardBalanceAssignment: No autorizado, sin error"
            End If

        End If
    End Sub


    Private Sub CardBalanceAdjustment(cardNumber As String, amount As Decimal, ByRef transaccion As TicketEmpresarialTransaccion)
        transaccion.numero_autorizacion = "11111"
        transaccion.importe_autorizado = amount
        transaccion.exitoso = True
        Return 'TODO QUITAR


        Dim request As New TicketEmpresarialService.CardBalanceAdjustmentRequest()
        request.Security = New TicketEmpresarialService.SecurityDTO()
        request.Security.ExternalClientId = _ExternalClientId
        request.Security.Token = _Token


        Dim cards As TicketEmpresarialService.CardBalanceDTO() = New TicketEmpresarialService.CardBalanceDTO(0) {}
        cards(0) = New TicketEmpresarialService.CardBalanceDTO()
        cards(0).Amount = amount
        cards(0).CardNumber = cardNumber

        request.CardBalanceDTOList = cards


        Dim client As New TicketEmpresarialService.TEServiceClient()

        client.ClientCredentials.UserName.UserName = _Username
        client.ClientCredentials.UserName.Password = _Password


        Dim response As TicketEmpresarialService.CardBalanceAdjustmentResponse = client.CardBalanceAdjustment(request)
        If response.Success Then
            If response.CardBalanceDTOList IsNot Nothing Then
                For Each cardDetail As TicketEmpresarialService.CardBalanceDTO In response.CardBalanceDTOList
                    If cardDetail.AuthorizationNumber IsNot Nothing AndAlso cardDetail.AuthorizationNumber <> "" Then
                        transaccion.numero_autorizacion = cardDetail.AuthorizationNumber
                        transaccion.importe_autorizado = cardDetail.Amount
                        transaccion.exitoso = True
                    Else
                        transaccion.error &= "CardBalanceAdjustment: No autorizado, sin error"
                    End If
                Next
            Else
                transaccion.error &= "CardBalanceAdjustment: No autorizado, sin error"
            End If
        Else
            For Each [error] As TicketEmpresarialService.ErrorDTO In response.ErrorList
                transaccion.error &= "Code: " + [error].Code + ", Message: " + [error].Message
            Next

        End If

    End Sub


End Class


Public Class TicketEmpresarialTransaccion
    Public Property fecha() As DateTime
        Get
            Return m_fecha
        End Get
        Set(value As DateTime)
            m_fecha = value
        End Set
    End Property
    Private m_fecha As DateTime
    Public Property tipo_movimiento() As String
        Get
            Return m_tipo_movimiento
        End Get
        Set(value As String)
            m_tipo_movimiento = value
        End Set
    End Property
    Private m_tipo_movimiento As String
    Public Property importe() As Decimal
        Get
            Return m_importe
        End Get
        Set(value As Decimal)
            m_importe = value
        End Set
    End Property
    Private m_importe As Decimal
    Public Property importe_autorizado() As Decimal
        Get
            Return m_importe_autorizado
        End Get
        Set(value As Decimal)
            m_importe_autorizado = value
        End Set
    End Property
    Private m_importe_autorizado As Decimal
    Public Property saldo_anterior() As Decimal
        Get
            Return m_saldo_anterior
        End Get
        Set(value As Decimal)
            m_saldo_anterior = value
        End Set
    End Property
    Private m_saldo_anterior As Decimal
    Public Property saldo_nuevo() As Decimal
        Get
            Return m_saldo_nuevo
        End Get
        Set(value As Decimal)
            m_saldo_nuevo = value
        End Set
    End Property
    Private m_saldo_nuevo As Decimal
    Public Property numero_autorizacion() As String
        Get
            Return m_numero_autorizacion
        End Get
        Set(value As String)
            m_numero_autorizacion = value
        End Set
    End Property
    Private m_numero_autorizacion As String
    Public Property exitoso() As Boolean
        Get
            Return m_exitoso
        End Get
        Set(value As Boolean)
            m_exitoso = value
        End Set
    End Property
    Private m_exitoso As Boolean
    Public Property referencia() As String
        Get
            Return m_referencia
        End Get
        Set(value As String)
            m_referencia = value
        End Set
    End Property
    Private m_referencia As String
    Public Property id_solicitud() As Integer
        Get
            Return m_id_solicitud
        End Get
        Set(value As Integer)
            m_id_solicitud = value
        End Set
    End Property
    Private m_id_solicitud As Integer
    Public Property id_usuario() As Integer
        Get
            Return m_id_usuario
        End Get
        Set(value As Integer)
            m_id_usuario = value
        End Set
    End Property
    Private m_id_usuario As Integer
    Public Property [error]() As String
        Get
            Return m_error
        End Get
        Set(value As String)
            m_error = value
        End Set
    End Property
    Private m_error As String
End Class

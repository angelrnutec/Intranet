Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class ArrendamientoAutoriza
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Me.ProcesaSolicitud()
        End If
    End Sub


    Private Sub ProcesaSolicitud()
        Dim id_arrendamiento As String = Request.QueryString("id")
        Dim tipo As String = Request.QueryString("t")
        Dim valor As String = Request.QueryString("auth")
        Dim id_empleado As String = Request.QueryString("ida")

        If id_arrendamiento Is Nothing _
            Or tipo Is Nothing _
            Or valor Is Nothing _
            Or id_empleado Is Nothing Then

            Me.divTexto.InnerText = "SOLICITUD INVALIDA"
            Exit Sub
        End If

        If Not IsNumeric(id_arrendamiento) _
            Or Not IsNumeric(tipo) _
            Or Not IsNumeric(valor) _
            Or Not IsNumeric(id_empleado) Then

            Me.divTexto.InnerText = "SOLICITUD INVALIDA"
            Exit Sub
        End If

        Try

            If valor = "1" Then
                Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
                arrendamiento.GuardaAutorizacionArrendamiento(id_arrendamiento, True, "", id_empleado)

                If tipo = 1 Then
                    Funciones.EnviarEmailArrendamientoAuth(id_arrendamiento, tipo, "Autorizante")
                End If
                Funciones.EnviarEmailArrendamientoAuth(id_arrendamiento, tipo, "Solicitante")

            Else
                Me.divNormal.Visible = False
                Me.divRechazo.Visible = True
            End If




            Me.divTexto.InnerText = "Gracias, su respuesta ha sido registrada: " & IIf(valor = "1", "SOLICITUD AUTORIZADA", "SOLICITUD RECHAZADA")
        Catch ex As Exception
            Me.divTexto.InnerText = ex.Message
        End Try

    End Sub




    Private Sub btnGuardarRechazo_Click(sender As Object, e As EventArgs) Handles btnGuardarRechazo.Click
        If Me.txtMotivoRechazo.Text.Trim.Length = 0 Then
            Me.lblMensaje.Text = "Ingrese el motivo del rechazo"
            Exit Sub
        End If

        Dim id_arrendamiento As String = Request.QueryString("id")
        Dim tipo As String = Request.QueryString("t")
        Dim valor As String = Request.QueryString("auth")
        Dim id_empleado As String = Request.QueryString("ida")


        Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        arrendamiento.GuardaAutorizacionArrendamiento(id_arrendamiento, False, Me.txtMotivoRechazo.Text, id_empleado)


        Funciones.EnviarEmailArrendamientoAuth(id_arrendamiento, tipo, "Rechazado")

        Me.divNormal.Visible = True
        Me.divRechazo.Visible = False

    End Sub
End Class


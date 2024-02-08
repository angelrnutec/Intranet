Imports IntranetBL
Imports System.Web.Services

Public Class SolicitudesCancelacion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then

        End If

    End Sub


    Protected Sub btnBuscar_Click(sender As Object, e As EventArgs) Handles btnBuscar.Click
        Me.Busqueda()
    End Sub

    Private Sub Busqueda()
        Try
            If Me.ddlTipoSolicitud.SelectedValue = 0 Then
                Throw New Exception("Seleccione el tipo de solicitud")
                Exit Sub
            End If
            If Me.txtFolio.Text.Trim.Length = 0 Then
                Throw New Exception("Ingrese un folio para realizar la búsqueda")
                Exit Sub
            End If

            Dim solicitud As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = solicitud.RecuperaSolicitudPorFolioTexto(Me.txtFolio.Text, Me.ddlTipoSolicitud.SelectedValue)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)
                Me.txtId.Text = dr("id_solicitud")
                Me.txtIdTipo.Text = Me.ddlTipoSolicitud.SelectedValue
                Me.lblFolio.Text = dr("folio_txt")
                Me.lblEmpleado.Text = dr("empleado_solicita")
                Me.lblEmpresa.Text = dr("empresa")
                Me.lblEstatus.Text = dr("estatus")
                Me.lblFecha.Text = Format(dr("fecha_registro"))
                Me.txtMotivoCancela.Text = dr("estatus_comentarios")

                Me.btnCancelar.Visible = True
                Me.txtMotivoCancela.Enabled = True
                If dr("estatus") = "SOLICITUD CANCELADA" Then
                    'If dr("estatus") = "SOLICITUD CANCELADA" Or dr("estatus").ToString().IndexOf("RECHAZA") >= 0 Then
                    Me.txtMotivoCancela.Enabled = False
                    Me.btnCancelar.Visible = False
                End If
                Me.lblResultado.Text = ""
                Me.tblResultado.Visible = True
            Else
                Me.lblResultado.Text = "Solicitud no encontrada"
                Me.tblResultado.Visible = False
            End If

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Try
            If Me.txtMotivoCancela.Text.Trim.Length = 0 Then
                Throw New Exception("Ingrese un motivo para la cancelación")
                Exit Sub
            End If

            Dim solicitud As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            solicitud.CancelarPorFolio(Me.txtId.Text, Me.txtIdTipo.Text, Me.txtMotivoCancela.Text, Session("idEmpleado"))

            Me.Busqueda()

            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Solicitud Cancelada Correctamente');</script>", False)

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub
End Class
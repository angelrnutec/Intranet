Imports IntranetBL
Imports Excel

Public Class GastosTarjetaImporta
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
            Dim nombre_archivo As String = Me.txtNombre.Text



            Dim resultado As String = ProcesaArchivo(archivo, -1, nombre_archivo)
            lblResultado.Text = "<br>" & resultado

        Catch ex As Exception
            lblResultado.Text = ex.Message
        End Try

    End Sub

    Private Function ProcesaArchivo(archivo As String, id_usuario As Integer, nombre_archivo As String) As String
        Try
            Dim mensajes As String = ""

            Try
                Dim mt As New MovimientosTarjeta(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

                Dim respuesta As TicketEmpresarialReporteMovimientos.ProcesoRespuesta = TicketEmpresarialReporteMovimientos.Proceso.ImportarArchivoXML(archivo)
                'For Each s As String In respuesta.mensajes

                'Next

                For Each m As TicketEmpresarialReporteMovimientos.Movimiento In respuesta.movimientos
                    mt.Guarda("TE", m.NumeroTarjeta, m.FechaMovimiento, m.Concepto, m.Descripcion, m.TipoComercio, m.DescMonedaExtranjera, m.Autorizacion, m.EstatusTarjeta, m.TipoCambio, m.ValorMonedaExtranjera, m.ValorPesos, id_usuario, m.ComisionIva, nombre_archivo, m.IdMovimiento)
                Next

                mensajes = "Se importaron " & respuesta.movimientos.Count() & " movimientos"
            Catch ex As Exception
                mensajes = "ERROR: " & ex.Message
            End Try


            Return mensajes
        Catch ex As Exception
            Throw ex
        End Try
    End Function

End Class

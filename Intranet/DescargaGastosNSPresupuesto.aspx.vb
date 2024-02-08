Imports IntranetBL

Public Class DescargaGastosNSPresupuesto
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.CargaCombos()
        End If

    End Sub

    Private Sub CargaCombos()
        Try
            For i As Integer = Now.AddMonths(1).Year To Now.Year - 1 Step -1
                Me.ddlAnio.Items.Add(i)
            Next

            Me.ddlAnio.SelectedValue = Now.Year

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub



    Private Sub btnGenerarReporte_Click(sender As Object, e As EventArgs) Handles btnGenerarReporte.Click
        Try
            Me.divResultados.Visible = True
            Me.lblRegistrosDescargados.Text = ProcesaDatos(Me.ddlAnio.SelectedValue)

            Dim gastosNS As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            'Dim dt As DataTable = gastosNS.GastosSinClasificar(6, New DateTime(Me.ddlAnio.SelectedValue, Me.ddlPeriodo.SelectedValue, 1))
            'Dim html As New StringBuilder("<table><tr><td colspan='2' align='left'><b>Tipos de gastos sin clasificacion</b></td></tr>")

            'If dt.Rows.Count = 0 Then
            '    html.AppendLine("<tr><td colspan='2' align='left'>Todos los gastos fueron correctamente clasificados</td>")
            'End If
            'For Each dr As DataRow In dt.Rows
            '    html.AppendLine("<tr><td>" & dr("denom_tipo_costo") & "</td><td>Asignar</td>")
            'Next
            'html.AppendLine("</table>")
            'Me.phGastosSinClasificar.Controls.Add(New LiteralControl(html.ToString()))

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub




    Private Function ProcesaDatos(anio As Integer) As Integer

        Dim sap As New ConsultasSAP
        Dim dt As DataTable = sap.RecuperaGastosNSPresupuesto(anio)

        Dim gastosNS As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        Return gastosNS.GuardaTablaPresupuestos(dt, anio)

    End Function
End Class

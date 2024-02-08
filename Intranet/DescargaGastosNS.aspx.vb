Imports IntranetBL

Public Class DescargaGastosNS
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
            For i As Integer = Now.AddMonths(1).Year To 2013 Step -1
                Me.ddlAnio.Items.Add(i)
            Next

            Dim items As New List(Of ListItem)
            items.Add(New ListItem("Enero", "1"))
            items.Add(New ListItem("Febrero", "2"))
            items.Add(New ListItem("Marzo", "3"))
            items.Add(New ListItem("Abril", "4"))
            items.Add(New ListItem("Mayo", "5"))
            items.Add(New ListItem("Junio", "6"))
            items.Add(New ListItem("Julio", "7"))
            items.Add(New ListItem("Agosto", "8"))
            items.Add(New ListItem("Septiembre", "9"))
            items.Add(New ListItem("Octubre", "10"))
            items.Add(New ListItem("Noviembre", "11"))
            items.Add(New ListItem("Diciembre", "12"))
            Me.ddlPeriodo.Items.AddRange(items.ToArray)

            Me.ddlAnio.SelectedValue = Now.Year
            Me.ddlPeriodo.SelectedValue = Now.Month

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub



    Private Sub btnGenerarReporte_Click(sender As Object, e As EventArgs) Handles btnGenerarReporte.Click
        Try
            Me.divResultados.Visible = True
            Me.lblRegistrosDescargados.Text = ProcesaDatos(Me.ddlAnio.SelectedValue, Me.ddlPeriodo.SelectedValue)

            Dim gastosNS As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = gastosNS.GastosSinClasificar(6, New DateTime(Me.ddlAnio.SelectedValue, Me.ddlPeriodo.SelectedValue, 1))
            Dim html As New StringBuilder("<table><tr><td colspan='2' align='left'><b>Tipos de gastos sin clasificacion</b></td></tr>")

            If dt.Rows.Count = 0 Then
                html.AppendLine("<tr><td colspan='2' align='left'>Todos los gastos fueron correctamente clasificados</td>")
            End If
            For Each dr As DataRow In dt.Rows
                html.AppendLine("<tr><td>" & dr("denom_tipo_costo") & "</td><td>Asignar</td>")
            Next
            html.AppendLine("</table>")
            Me.phGastosSinClasificar.Controls.Add(New LiteralControl(html.ToString()))

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub




    Private Function ProcesaDatos(anio As Integer, periodo As Integer) As Integer
        Dim fecha_ini As DateTime = New DateTime(anio, periodo, 1)
        Dim fecha_fin As DateTime = fecha_ini.AddMonths(1).AddDays(-1)

        Dim sap As New ConsultasSAP
        Dim dt As DataTable = sap.RecuperaGastosNS(fecha_ini, fecha_fin)

        Dim gastosNS As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        gastosNS.Elimina(6, fecha_ini, fecha_fin)
        Return gastosNS.GuardaTabla(6, dt, fecha_ini, fecha_fin)

    End Function
End Class

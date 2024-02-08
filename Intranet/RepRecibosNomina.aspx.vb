Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class RepRecibosNomina
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.CargaCombos()
        End If
        Me.btnGenerarReporte.OnClientClick = "this.disabled = true; this.value = '" & TranslateLocale.text("Generando Reporte") & "...';"
        Me.btnGenerarReporte.Text = TranslateLocale.text("Generar Reporte")

    End Sub

    Private Sub CargaCombos()
        Try
            For i As Integer = 2013 To Now.Year Step 1
                Me.ddlAnio.Items.Add(i)
            Next

            For i As Integer = 1 To 24 Step 1
                Me.ddlQuincena.Items.Add(i)
            Next

            Me.ddlAnio.SelectedValue = Now.Year


            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            'Me.ddlEmpresa.DataSource = combos.RecuperaEmpresaConceptoGasto(1)
            'Me.ddlEmpresa.DataValueField = "id_empresa"
            'Me.ddlEmpresa.DataTextField = "nombre"
            'Me.ddlEmpresa.DataBind()


            Me.ddlEmpresa.Items.Clear()
            Me.ddlEmpresa.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpresaConceptoGasto(1), "nombre", "id_empresa"))



            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.lblNombreReporte.Text = TranslateLocale.text("Reporte de Recibos de Nomina")

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub


    Private Sub ValidaSeleccionReporte()
        Dim msg As String = ""

        If Me.ddlEmpresa.SelectedValue = 0 Then msg &= " - " & TranslateLocale.text("Empresa") & "\n"

        If msg.Length > 0 Then
            Throw New Exception(TranslateLocale.text("Favor de capturar la siguiente información") & ":\n" & msg)
        End If

    End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Response.Redirect("/")
    End Sub

    Private Sub btnGenerarReporte_Click(sender As Object, e As EventArgs) Handles btnGenerarReporte.Click
        Try
            ValidaSeleccionReporte()

            Dim url As String = ""
            url = "RepRecibosNominaImpresion.aspx?e=" & Me.ddlEmpresa.SelectedValue & "&a=" & Me.ddlAnio.SelectedValue & "&p=" & Me.ddlQuincena.SelectedValue

            Dim script As String = "window.open('" + url + "','')"
            ScriptManager.RegisterClientScriptBlock(Me.Page, Me.Page.GetType(), "NewWindow", script, True)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub
End Class

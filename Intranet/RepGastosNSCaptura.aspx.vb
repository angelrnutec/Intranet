Imports IntranetBL

Public Class RepGastosNSCaptura
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.CargaCombos()
            Me.btnContinuar.Attributes.Add("onclick", "this.disabled='true';")
            Me.btnContinuar.Attributes.Add("onload", "this.disabled='false';")

            If Not Request.QueryString("r") Is Nothing Then
                Me.CargaDatos()
            End If

        End If
    End Sub

    Protected Function PerfilDeuda_Totales(id_empresa As Integer) As String
        Dim dt As DataTable = CType(ViewState("dtConceptos"), DataTable)
        Dim total As String = ""
        For Each dr As DataRow In dt.Rows
            total = dr("id")
        Next
        Return total & "," & total
    End Function

    Protected Function PerfilDeuda_Suman(id_empresa As Integer) As String
        Dim dt As DataTable = CType(ViewState("dtConceptos"), DataTable)
        Dim total As String = ""
        For Each dr As DataRow In dt.Rows
            If dr("permite_captura") = True Then
                total &= dr("id") & ","
            End If
        Next
        If total.Length > 0 Then total = total.Substring(0, total.Length - 1)
        Return total
    End Function

    Protected Function PerfilDeuda_FilaTotales(id_empresa As Integer) As String
        Dim dt As DataTable = CType(ViewState("dtConceptos"), DataTable)
        Dim total As String = ""
        For Each dr As DataRow In dt.Rows
            total = dr("id")
        Next
        Return total
    End Function

    Private Sub CargaCombos()
        Try
            For i As Integer = Now.AddMonths(1).Year To 2012 Step -1
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
            Me.ddlMes.Items.AddRange(items.ToArray)

            Me.ddlAnio.SelectedValue = Now.Year
            Me.ddlMes.SelectedValue = Now.Month


            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            'Me.ddlEmpresa.DataSource = combos.RecuperaEmpresas()
            'Me.ddlEmpresa.DataValueField = "id_empresa"
            'Me.ddlEmpresa.DataTextField = "nombre"
            'Me.ddlEmpresa.DataBind()

            Me.ddlReporte.DataSource = combos.RecuperaReportes(2)
            Me.ddlReporte.DataValueField = "id_reporte"
            Me.ddlReporte.DataTextField = "nombre"
            Me.ddlReporte.DataBind()
            Me.ddlReporte.SelectedValue = 11
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub

    Private Sub CargaDatos()
        Me.ddlReporte.SelectedValue = Request.QueryString("r")
        'Me.ddlEmpresa.SelectedValue = Request.QueryString("e")
        Me.ddlAnio.SelectedValue = Request.QueryString("a")
        Me.ddlMes.SelectedValue = Request.QueryString("m")
        Me.CargaGridCaptura()
    End Sub

    Private Sub CargaGridCaptura()

        Me.ValidaSeleccionReporte()
        Me.txtEstado.Text = "1"
        Me.btnContinuar.Text = "Guardar"
        Me.btnCancelar.Text = "Cancelar"
        Me.divCaptura.Visible = True

        'Me.ddlEmpresa.Enabled = False
        Me.ddlReporte.Enabled = False
        Me.ddlAnio.Enabled = False
        Me.ddlMes.Enabled = False

        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dtDatos As DataSet = reporte.RecuperaDatos(Me.ddlReporte.SelectedValue,
                                                          -1,
                                                          Me.ddlAnio.SelectedValue,
                                                          Me.ddlMes.SelectedValue)


        Dim estatus As String = dtDatos.Tables(2).Rows(0)("estatus")
        Me.txtEstatus.Text = estatus



        Me.gvCaptura.DataSource = dtDatos.Tables(0)
        Me.gvCaptura.DataBind()

        If txtEstatus.Text = "C" Then
            Me.txtEstado.Text = "0"
            Me.btnContinuar.Enabled = False
            Me.btnCancelar.Text = "Salir"
            Me.lblMensajeEstatus.Visible = True
            Me.lblMensajeEstatus.Text = "El perido seleccionado esta cerrado y no se puede modificar"
            Me.gvCaptura.Enabled = False
        Else
            Me.lblMensajeEstatus.Visible = False
            Me.gvCaptura.Enabled = True
        End If

    End Sub

    Private Sub btnContinuar_Click(sender As Object, e As EventArgs) Handles btnContinuar.Click
        Try
            If Me.txtEstado.Text = "0" Then  ''Iniciando la captura
                Me.CargaGridCaptura()
            Else ''Guarda la captura
                Me.GuardaCaptura()
                Me.Response.Redirect("/RepGastosNSCaptura.aspx")
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    Private Sub GuardaCaptura()
        Try
            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim listaDatos As New ArrayList()
            Dim tipoReporte As Integer = 1
            
            For Each row As GridViewRow In gvCaptura.Rows
                Dim txtImporte As TextBox = CType(row.FindControl("txtImporte"), TextBox)
                Dim txtIdConcepto As TextBox = CType(row.FindControl("txtIdConcepto"), TextBox)

                listaDatos.Add(New ReporteDatos(tipoReporte, txtIdConcepto.Text, IIf(IsNumeric(txtImporte.Text), txtImporte.Text, 0)))
            Next
            
            reporte.GuardaDatos(listaDatos, _
                                tipoReporte, _
                                -1, _
                                Me.ddlReporte.SelectedValue, _
                                Me.ddlAnio.SelectedValue, _
                                Me.ddlMes.SelectedValue, _
                                Session("idEmpleado"), _
                                "")

        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    Private Sub ValidaSeleccionReporte()
        Dim msg As String = ""

        If Me.ddlReporte.SelectedValue = 0 Then msg &= " - Reporte\n"

        If msg.Length > 0 Then
            Throw New Exception("Favor de capturar la siguiente información:\n" & msg)
        End If
    End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        If Me.txtEstado.Text = "0" Then  ''Iniciando la captura
            Response.Redirect("/")
        Else
            Response.Redirect("/RepGastosNSCaptura.aspx")
        End If
    End Sub

    Private Sub gvCaptura_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvCaptura.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim txtPermiteCaptura As TextBox = CType(e.Row.FindControl("txtPermiteCaptura"), TextBox)
            Dim txtEsSeparador As TextBox = CType(e.Row.FindControl("txtEsSeparador"), TextBox)
            If txtPermiteCaptura.Text = "False" Then
                e.Row.BackColor = Drawing.Color.LightGray
            End If
            If txtEsSeparador.Text = "True" Then
                e.Row.BackColor = Drawing.Color.Gray
                e.Row.ForeColor = Drawing.Color.White
            End If

        End If
    End Sub



End Class

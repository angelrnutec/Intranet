Imports IntranetBL
Imports KrishLabs.Web.Controls

Public Class RepGastosNSCentroCostoImpresion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim id_empresa As String = Request.QueryString("e")
            Dim anio As String = Request.QueryString("a")
            Dim mon As String = Request.QueryString("mon")
            Dim mes As String = Request.QueryString("m")

            If Not id_empresa Is Nothing And
                Not anio Is Nothing  Then

                Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Dim ds As DataSet = reporte.ReporteGastosNSCentroCosto(id_empresa, anio, mon, Session("idEmpleado"), mes)
                Me.gvReporte.DataSource = ds.Tables(0)
                Me.gvReporte.DataBind()

                Me.txtMes.Text = ds.Tables(1).Rows(0)("mes")


                If Me.gvReporte.Rows.Count = 0 Then
                    Me.lblNoRecords.Visible = True
                End If
            End If
        End If
    End Sub




    Public Property GridViewSortDirection() As SortDirection
        Get
            If ViewState("sortDirection") Is Nothing Then
                ViewState("sortDirection") = SortDirection.Ascending
            End If

            Return DirectCast(ViewState("sortDirection"), SortDirection)
        End Get
        Set(value As SortDirection)
            ViewState("sortDirection") = value
        End Set
    End Property

    Private Sub gvReporte_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvReporte.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim tipo As String = CType(e.Row.FindControl("lblTipo"), Label).Text
            If tipo = 2 Or tipo = 3 Then
                e.Row.Style.Add("font-weight", "bold")
            End If
        End If
    End Sub

    Protected Sub gvReporte_Sorting(sender As Object, e As GridViewSortEventArgs) Handles gvReporte.Sorting
        Dim sortExpression As String = e.SortExpression

        If GridViewSortDirection = SortDirection.Ascending Then
            GridViewSortDirection = SortDirection.Descending
            SortGridView(sortExpression, " ASC")
        Else
            GridViewSortDirection = SortDirection.Ascending
            SortGridView(sortExpression, " DESC")
        End If

    End Sub

    Private Sub SortGridView(sortExpression As String, direction As String)
        Try
            '  You can cache the DataTable for improving performance
            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Dim id_empresa As String = Request.QueryString("e")
            Dim anio As String = Request.QueryString("a")
            Dim mon As String = Request.QueryString("mon")
            Dim mes As String = Request.QueryString("m")

            Dim dt As DataTable = reporte.ReporteGastosNSCentroCosto(id_empresa, anio, mon, Session("idEmpleado"), mes).Tables(0)
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvReporte.DataSource = dv
            gvReporte.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    Protected Function RecuperaDatosReporte() As DataTable
        Dim fec_ini As String = Request.QueryString("fec_ini")
        Dim fec_fin As String = Request.QueryString("fec_fin")

        If Not fec_ini Is Nothing And
            Not fec_fin Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Return reporte.ReporteAccesos(fec_ini, fec_fin)
        End If
        Return Nothing
    End Function

    Protected Function ifNullEmptyFecha(valor As Object) As String
        If IsDBNull(valor) Then
            Return ""
        Else
            Return "<br />(" & Format(CType(valor, Date), "dd/MM/yyyy HH:mm") & ")"
        End If
    End Function

    Protected Function DefinicionParametros() As String
        Dim id_empresa As String = Request.QueryString("e")
        Dim anio As String = Request.QueryString("a")
        Dim mon As String = Request.QueryString("mon")

        Dim parametros As String = ""

        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))


        parametros += "Empresa: " & reporte.RecuperaEmpresaNombre(Request.QueryString("e")) & ", "
        parametros += "Periodo: " & NombreMes(Me.txtMes.Text) & "/" & anio & ", "
        parametros += "Moneda: " & mon


        Return parametros
    End Function

    Private Function NombreMes(mes As Integer) As String
        If mes = 1 Then
            Return "Enero"
        ElseIf mes = 2 Then
            Return "Febrero"
        ElseIf mes = 3 Then
            Return "Marzo"
        ElseIf mes = 4 Then
            Return "Abril"
        ElseIf mes = 5 Then
            Return "Mayo"
        ElseIf mes = 6 Then
            Return "Junio"
        ElseIf mes = 7 Then
            Return "Julio"
        ElseIf mes = 8 Then
            Return "Agosto"
        ElseIf mes = 9 Then
            Return "Septiembre"
        ElseIf mes = 10 Then
            Return "Octubre"
        ElseIf mes = 11 Then
            Return "Noviembre"
        ElseIf mes = 12 Then
            Return "Diciembre"
        End If

        Return ""
    End Function
End Class
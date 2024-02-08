Imports IntranetBL
Imports KrishLabs.Web.Controls

Public Class TelcelRepTotLineaImpresion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim anio As String = Request.QueryString("anio")
            Dim id_empresa As String = Request.QueryString("id_empresa")
            Dim id_empleado As String = Request.QueryString("id_empleado")
            Dim id_proveedor As String = Request.QueryString("id_proveedor")

            If Not id_empresa Is Nothing And
                Not id_empleado Is Nothing Then

                Dim telcel As New Telcel(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Me.gvReporte.DataSource = telcel.RepTelcelTotalesLinea(anio, id_empresa, id_empleado, Session("idEmpleado"), id_proveedor)
                Me.gvReporte.DataBind()

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

#Region "TOTALES"
    Dim monto_mes_01 As Decimal = 0
    Dim monto_mes_02 As Decimal = 0
    Dim monto_mes_03 As Decimal = 0
    Dim monto_mes_04 As Decimal = 0
    Dim monto_mes_05 As Decimal = 0
    Dim monto_mes_06 As Decimal = 0
    Dim monto_mes_07 As Decimal = 0
    Dim monto_mes_08 As Decimal = 0
    Dim monto_mes_09 As Decimal = 0
    Dim monto_mes_10 As Decimal = 0
    Dim monto_mes_11 As Decimal = 0
    Dim monto_mes_12 As Decimal = 0
    Dim monto_total As Decimal = 0

#End Region

    Private Sub gvReporte_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvReporte.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then


            monto_mes_01 += e.Row.Cells(4).Text
            monto_mes_02 += e.Row.Cells(6).Text
            monto_mes_03 += e.Row.Cells(8).Text
            monto_mes_04 += e.Row.Cells(10).Text
            monto_mes_05 += e.Row.Cells(12).Text
            monto_mes_06 += e.Row.Cells(14).Text
            monto_mes_07 += e.Row.Cells(16).Text
            monto_mes_08 += e.Row.Cells(18).Text
            monto_mes_09 += e.Row.Cells(20).Text
            monto_mes_10 += e.Row.Cells(22).Text
            monto_mes_11 += e.Row.Cells(24).Text
            monto_mes_12 += e.Row.Cells(26).Text
            monto_total += e.Row.Cells(28).Text


        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(4).Text = Format(monto_mes_01, "#,###,##0")
            e.Row.Cells(6).Text = Format(monto_mes_02, "#,###,##0")
            e.Row.Cells(8).Text = Format(monto_mes_03, "#,###,##0")
            e.Row.Cells(10).Text = Format(monto_mes_04, "#,###,##0")
            e.Row.Cells(12).Text = Format(monto_mes_05, "#,###,##0")
            e.Row.Cells(14).Text = Format(monto_mes_06, "#,###,##0")
            e.Row.Cells(16).Text = Format(monto_mes_07, "#,###,##0")
            e.Row.Cells(18).Text = Format(monto_mes_08, "#,###,##0")
            e.Row.Cells(20).Text = Format(monto_mes_09, "#,###,##0")
            e.Row.Cells(22).Text = Format(monto_mes_10, "#,###,##0")
            e.Row.Cells(24).Text = Format(monto_mes_11, "#,###,##0")
            e.Row.Cells(26).Text = Format(monto_mes_12, "#,###,##0")
            e.Row.Cells(28).Text = Format(monto_total, "#,###,##0")


            If monto_mes_12 = 0 Then
                gvReporte.Columns(26).Visible = False
                gvReporte.Columns(27).Visible = False
            End If
            If monto_mes_11 = 0 Then
                gvReporte.Columns(24).Visible = False
                gvReporte.Columns(25).Visible = False
            End If
            If monto_mes_10 = 0 Then
                gvReporte.Columns(22).Visible = False
                gvReporte.Columns(23).Visible = False
            End If
            If monto_mes_09 = 0 Then
                gvReporte.Columns(20).Visible = False
                gvReporte.Columns(21).Visible = False
            End If
            If monto_mes_08 = 0 Then
                gvReporte.Columns(18).Visible = False
                gvReporte.Columns(19).Visible = False
            End If
            If monto_mes_07 = 0 Then
                gvReporte.Columns(16).Visible = False
                gvReporte.Columns(17).Visible = False
            End If
            If monto_mes_06 = 0 Then
                gvReporte.Columns(14).Visible = False
                gvReporte.Columns(15).Visible = False
            End If
            If monto_mes_05 = 0 Then
                gvReporte.Columns(12).Visible = False
                gvReporte.Columns(13).Visible = False
            End If
            If monto_mes_04 = 0 Then
                gvReporte.Columns(10).Visible = False
                gvReporte.Columns(11).Visible = False
            End If
            If monto_mes_03 = 0 Then
                gvReporte.Columns(9).Visible = False
                gvReporte.Columns(10).Visible = False
            End If
            If monto_mes_02 = 0 Then
                gvReporte.Columns(6).Visible = False
                gvReporte.Columns(7).Visible = False
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

            gvReporte.Columns(26).Visible = True
            gvReporte.Columns(27).Visible = True
            gvReporte.Columns(24).Visible = True
            gvReporte.Columns(25).Visible = True
            gvReporte.Columns(22).Visible = True
            gvReporte.Columns(23).Visible = True
            gvReporte.Columns(20).Visible = True
            gvReporte.Columns(21).Visible = True
            gvReporte.Columns(18).Visible = True
            gvReporte.Columns(19).Visible = True
            gvReporte.Columns(16).Visible = True
            gvReporte.Columns(17).Visible = True
            gvReporte.Columns(14).Visible = True
            gvReporte.Columns(15).Visible = True
            gvReporte.Columns(12).Visible = True
            gvReporte.Columns(13).Visible = True
            gvReporte.Columns(10).Visible = True
            gvReporte.Columns(11).Visible = True
            gvReporte.Columns(8).Visible = True
            gvReporte.Columns(9).Visible = True
            gvReporte.Columns(6).Visible = True
            gvReporte.Columns(7).Visible = True
            gvReporte.Columns(4).Visible = True
            gvReporte.Columns(5).Visible = True


            Dim anio As String = Request.QueryString("anio")
            Dim id_empresa As String = Request.QueryString("id_empresa")
            Dim id_empleado As String = Request.QueryString("id_empleado")
            Dim id_proveedor As String = Request.QueryString("id_proveedor")

            Dim telcel As New Telcel(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = telcel.RepTelcelTotalesLinea(anio, id_empresa, id_empleado, Session("idEmpleado"), id_proveedor)
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvReporte.DataSource = dv
            gvReporte.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    Protected Function ifNullEmptyFecha(valor As Object) As String
        If IsDBNull(valor) Then
            Return ""
        Else
            Return "<br />(" & Format(CType(valor, Date), "dd/MM/yyyy HH:mm") & ")"
        End If
    End Function

    Protected Function DefinicionParametros() As String
        Dim id_empresa As String = Request.QueryString("id_empresa")
        Dim id_empleado As String = Request.QueryString("id_empleado")
        Dim anio As String = Request.QueryString("anio")

        Dim parametros As String = ""
        If Not id_empresa Is Nothing And
            Not id_empleado Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            parametros += "A&ntilde;o: " & anio & ", "
            parametros += "Empresa: " & IIf(id_empresa = "0", "Todas", reporte.RecuperaEmpresaNombre(id_empresa)) & ", "
            parametros += "Empleado: " & IIf(id_empleado = "", "Todos", reporte.RecuperaEmpleadoNombreTelefono(id_empleado))

        End If
        Return parametros
    End Function

End Class
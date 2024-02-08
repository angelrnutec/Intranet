Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class RepReposicionGastosImpresion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim fec_ini As String = Request.QueryString("fec_ini")
            Dim fec_fin As String = Request.QueryString("fec_fin")
            Dim id_empresa As String = Request.QueryString("id_empresa")
            Dim id_estatus As String = Request.QueryString("id_estatus")
            Dim id_empleado As String = Request.QueryString("id_empleado")
            Dim cancelada As String = Request.QueryString("cancelada")

            If Not fec_ini Is Nothing And
                Not fec_fin Is Nothing And
                Not id_empresa Is Nothing And
                Not id_estatus Is Nothing And
                Not id_empleado Is Nothing Then

                Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Dim tabla As DataTable = reporte.ReporteSolicitudReposicion(fec_ini, fec_fin, id_empresa, id_estatus, id_empleado, cancelada, Session("idEmpleado"), TranslateLocale.getLocale()).Tables(0)

                Funciones.TranslateTableData(tabla, {"folio", "estatus"})
                Me.gvReporte.DataSource = tabla

                Funciones.TranslateGridviewHeader(Me.gvReporte)
                Me.gvReporte.DataBind()

            End If

            Me.ExportToExcel1.Text = TranslateLocale.text("Exportar a Excel")
            Me.btnImprimir.Text = TranslateLocale.text("Imprimir sin Formato")

        End If
    End Sub

    Protected Function RecuperaDatosReporte() As DataSet
        Dim fec_ini As String = Request.QueryString("fec_ini")
        Dim fec_fin As String = Request.QueryString("fec_fin")
        Dim id_empresa As String = Request.QueryString("id_empresa")
        Dim id_estatus As String = Request.QueryString("id_estatus")
        Dim id_empleado As String = Request.QueryString("id_empleado")
        Dim cancelada As String = Request.QueryString("cancelada")

        If Not fec_ini Is Nothing And
            Not fec_fin Is Nothing And
            Not id_empresa Is Nothing And
            Not id_estatus Is Nothing And
            Not id_empleado Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Return reporte.ReporteSolicitudReposicion(fec_ini, fec_fin, id_empresa, id_estatus, id_empleado, cancelada, Session("idEmpleado"), TranslateLocale.getLocale())
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

            Dim fec_ini As String = Request.QueryString("fec_ini")
            Dim fec_fin As String = Request.QueryString("fec_fin")
            Dim id_empresa As String = Request.QueryString("id_empresa")
            Dim id_estatus As String = Request.QueryString("id_estatus")
            Dim id_empleado As String = Request.QueryString("id_empleado")
            Dim cancelada As String = Request.QueryString("cancelada")

            Dim dt As DataTable = reporte.ReporteSolicitudReposicion(fec_ini, fec_fin, id_empresa, id_estatus, id_empleado, cancelada, Session("idEmpleado"), TranslateLocale.getLocale()).Tables(0)
            Funciones.TranslateTableData(dt, {"folio", "estatus"})

            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvReporte.DataSource = dv
            gvReporte.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub



    Protected Function DefinicionParametros() As String
        Dim fec_ini As String = Request.QueryString("fec_ini")
        Dim fec_fin As String = Request.QueryString("fec_fin")
        Dim id_empresa As String = Request.QueryString("id_empresa")
        Dim id_estatus As String = Request.QueryString("id_estatus")
        Dim id_empleado As String = Request.QueryString("id_empleado")
        Dim cancelada As String = Request.QueryString("cancelada")

        Dim parametros As String = ""
        If Not fec_ini Is Nothing And
            Not fec_fin Is Nothing And
            Not id_empresa Is Nothing And
            Not id_estatus Is Nothing And
            Not id_empleado Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Dim fecha_ini As New Date(fec_ini.Substring(0, 4), fec_ini.Substring(4, 2), fec_ini.Substring(6, 2))
            Dim fecha_fin As New Date(fec_fin.Substring(0, 4), fec_fin.Substring(4, 2), fec_fin.Substring(6, 2))

            parametros += TranslateLocale.text("Fecha Inicial") & ": " & fecha_ini.ToString("dd/MM/yyyy") & ", "
            parametros += TranslateLocale.text("Fecha Final") & ": " & fecha_fin.ToString("dd/MM/yyyy") & ", "
            parametros += TranslateLocale.text("Empresa") & ": " & IIf(id_empresa = "0", TranslateLocale.text("Todas"), reporte.RecuperaEmpresaNombre(id_empresa)) & ", "
            parametros += TranslateLocale.text("Estatus") & ": " & IIf(id_estatus = "0", TranslateLocale.text("Todos"), reporte.RecuperaEstatusGastosViajeNombre(id_estatus)) & ", "
            parametros += TranslateLocale.text("Empleado") & ": " & IIf(id_empleado = "0", TranslateLocale.text("Todos"), reporte.RecuperaEmpleadoNombre(id_empleado)) & ", "
            parametros += TranslateLocale.text("Moneda") & ": " & IIf(id_empleado = "12", "USD", "MXP")

        End If
        Return parametros
    End Function

End Class
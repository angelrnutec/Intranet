Imports IntranetBL
Imports KrishLabs.Web.Controls
Imports Intranet.LocalizationIntranet

Public Class RepVencimientoProximosImpresion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim id_empresa As String = Request.QueryString("id_empresa")
            Dim id_empleado As String = Request.QueryString("id_empleado")
            Dim dias As String = Request.QueryString("dias")

            If Not id_empresa Is Nothing And
                Not id_empleado Is Nothing Then

                Dim vacaciones As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Me.gvReporte.DataSource = vacaciones.RecuperaVencimientosVacaciones(id_empleado, id_empresa, Session("idEmpleado"), dias)
                Funciones.TranslateGridviewHeader(Me.gvReporte)
                Me.gvReporte.DataBind()

            End If
            Me.ExportToExcel1.Text = TranslateLocale.text("Exportar a Excel")
            Me.btnImprimir.Text = TranslateLocale.text("Imprimir sin Formato")

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

            Dim id_empresa As String = Request.QueryString("id_empresa")
            Dim id_empleado As String = Request.QueryString("id_empleado")
            Dim dias As String = Request.QueryString("dias")


            Dim vacaciones As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = vacaciones.RecuperaVencimientosVacaciones(id_empleado, id_empresa, Session("idEmpleado"), dias).Tables(0)
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvReporte.DataSource = dv
            Funciones.TranslateGridviewHeader(Me.gvReporte)
            gvReporte.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    'Protected Function RecuperaDatosReporte() As DataSet
    '    Dim fec_ini As String = Request.QueryString("fec_ini")
    '    Dim fec_fin As String = Request.QueryString("fec_fin")
    '    Dim id_empresa As String = Request.QueryString("id_empresa")
    '    Dim id_estatus As String = Request.QueryString("id_estatus")
    '    Dim id_empleado As String = Request.QueryString("id_empleado")
    '    Dim cancelada As String = Request.QueryString("cancelada")

    '    If Not fec_ini Is Nothing And
    '        Not fec_fin Is Nothing And
    '        Not id_empresa Is Nothing And
    '        Not id_estatus Is Nothing And
    '        Not id_empleado Is Nothing Then

    '        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
    '        Return reporte.ReporteSolicitudVacaciones(fec_ini, fec_fin, id_empresa, id_estatus, id_empleado, cancelada, Session("idEmpleado"))
    '    End If
    '    Return Nothing
    'End Function

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
        Dim dias As String = Request.QueryString("dias")

        Dim parametros As String = ""
        If Not id_empresa Is Nothing And
            Not id_empleado Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            parametros += TranslateLocale.text("Empresa") & ": " & IIf(id_empresa = "0", TranslateLocale.text("Todas"), reporte.RecuperaEmpresaNombre(id_empresa)) & ", "
            parametros += TranslateLocale.text("Empleado") & ": " & IIf(id_empleado = "0", TranslateLocale.text("Todas"), reporte.RecuperaEmpleadoNombre(id_empleado)) & ", "
            parametros += TranslateLocale.text("Con vencimiento en los proximos") & " " & dias.ToString() & " " & TranslateLocale.text("dias")

        End If
        Return parametros
    End Function

End Class
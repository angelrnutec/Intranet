Imports IntranetBL
Imports KrishLabs.Web.Controls

Public Class RepSeguridadUsuariosImpresion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim seg As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.gvReporte.DataSource = seg.RepSeguridadUsuarios()
            Me.gvReporte.DataBind()
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


            Dim vacaciones As New SolicitudVacacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = vacaciones.RecuperaVencimientosVacaciones(id_empleado, id_empresa, Session("idEmpleado"), 0).Tables(0)
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvReporte.DataSource = dv
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


End Class
Imports IntranetBL
Imports KrishLabs.Web.Controls

Public Class RepAccesosLogImpresion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim fec_ini As String = Request.QueryString("fec_ini")
            Dim fec_fin As String = Request.QueryString("fec_fin")

            If Not fec_ini Is Nothing And
                Not fec_fin Is Nothing Then

                Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Me.gvReporte.DataSource = reporte.ReporteAccesos(fec_ini, fec_fin)
                Me.gvReporte.DataBind()

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

            Dim dt As DataTable = reporte.ReporteAccesos(fec_ini, fec_fin)
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
        Dim fec_ini As String = Request.QueryString("fec_ini")
        Dim fec_fin As String = Request.QueryString("fec_fin")

        Dim parametros As String = ""
        If Not fec_ini Is Nothing And
            Not fec_fin Is Nothing  Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Dim fecha_ini As New Date(fec_ini.Substring(0, 4), fec_ini.Substring(4, 2), fec_ini.Substring(6, 2))
            Dim fecha_fin As New Date(fec_fin.Substring(0, 4), fec_fin.Substring(4, 2), fec_fin.Substring(6, 2))

            parametros += "Fecha Inicial: " & fecha_ini.ToString("dd/MM/yyyy") & ", "
            parametros += "Fecha Final: " & fecha_fin.ToString("dd/MM/yyyy") & ", "


        End If
        Return parametros
    End Function

End Class
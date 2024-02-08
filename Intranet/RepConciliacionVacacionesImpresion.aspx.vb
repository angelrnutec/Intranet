Imports IntranetBL
Imports KrishLabs.Web.Controls
Imports Intranet.LocalizationIntranet

Public Class RepConciliacionVacacionesImpresion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim id_empresa As String = Request.QueryString("id_empresa")
            Dim solo_diferencias As Boolean = IIf(Request.QueryString("solo_diferencias") = "1", True, False)

            If Not id_empresa Is Nothing Then

                Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Me.gvReporte.DataSource = reporte.ReporteConciliacionVacaciones(id_empresa, Session("idEmpleado"), solo_diferencias)
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
            '  You can cache the DataTable for improving performance
            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Dim id_empresa As String = Request.QueryString("id_empresa")
            Dim solo_diferencias As Boolean = IIf(Request.QueryString("solo_diferencias") = "1", True, False)

            Dim dt As DataTable = reporte.ReporteConciliacionVacaciones(id_empresa, Session("idEmpleado"), solo_diferencias).Tables(0)
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvReporte.DataSource = dv
            Funciones.TranslateGridviewHeader(Me.gvReporte)
            gvReporte.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    Protected Function RecuperaDatosReporte() As DataSet
        Dim id_empresa As String = Request.QueryString("id_empresa")
        Dim solo_diferencias As Boolean = IIf(Request.QueryString("solo_diferencias") = "1", True, False)

        If Not id_empresa Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Return reporte.ReporteConciliacionVacaciones(id_empresa, Session("idEmpleado"), solo_diferencias)
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
        Dim id_empresa As String = Request.QueryString("id_empresa")

        Dim parametros As String = ""
        If Not id_empresa Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            parametros += TranslateLocale.text("Empresa") & ": " & IIf(id_empresa = "0", TranslateLocale.text("Todas"), reporte.RecuperaEmpresaNombre(id_empresa))

        End If
        Return parametros
    End Function

End Class
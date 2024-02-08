Imports IntranetBL
Imports KrishLabs.Web.Controls
Imports System.Web.Services
Imports Intranet.LocalizationIntranet

Public Class RepDetalleSaldoVacacionesImpresion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim id_empresa As String = Request.QueryString("id_empresa")

            If Not id_empresa Is Nothing Then

                Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Me.gvReporte.DataSource = reporte.ReporteDetalleSaldoVacaciones(id_empresa, Session("idEmpleado"))
                Funciones.TranslateGridviewHeader(Me.gvReporte)
                Me.gvReporte.DataBind()
            End If

            Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = seguridad.RecuperaPermisosEmpleado(Session("idEmpleado"))

            If dt.Rows.Count > 0 Then

                Dim dr As DataRow() = dt.Select("permiso ='rep_saldo_ini_vac'")

                If dr.Length > 0 Then
                    gvReporte.Columns(11).Visible = True
                Else
                    gvReporte.Columns(11).Visible = False
                End If
            Else
                gvReporte.Columns(11).Visible = False
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

            Dim dt As DataTable = reporte.ReporteDetalleSaldoVacaciones(id_empresa, Session("idEmpleado")).Tables(0)
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvReporte.DataSource = dv
            Funciones.TranslateGridviewHeader(gvReporte)
            gvReporte.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    Protected Function RecuperaDatosReporte() As DataSet
        Dim id_empresa As String = Request.QueryString("id_empresa")

        If Not id_empresa Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Return reporte.ReporteDetalleSaldoVacaciones(id_empresa, Session("idEmpleado"))
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
            parametros += TranslateLocale.text("Empresa") & ": " & IIf(id_empresa = "0", "Todas", reporte.RecuperaEmpresaNombre(id_empresa))

        End If
        Return parametros
    End Function

    <WebMethod>
    Public Shared Function AgregaDias(ByVal id_saldo As Integer, ByVal id_empleado As Integer, ByVal dias As Decimal, ByVal fecha As String) As String
        Try

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            reporte.GuardaDiasVacaciones(id_saldo, id_empleado, dias, fecha)

            Return "Informacion Actualizada"

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Private Sub ExportToExcel1_Click(sender As Object, e As EventArgs) Handles ExportToExcel1.Click
        gvReporte.Columns(11).Visible = False
    End Sub

    Private Sub ExportToExcel1_PreExport(Sender As Object, e As EventArgs) Handles ExportToExcel1.PreExport
        gvReporte.Columns(11).Visible = False
    End Sub
End Class
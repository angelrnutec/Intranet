Imports IntranetBL
Imports KrishLabs.Web.Controls
Imports Intranet.LocalizationIntranet

Public Class RepRecibosNominaImpresion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim id_empresa As String = Request.QueryString("e")
            Dim anio As String = Request.QueryString("a")
            Dim periodo As String = Request.QueryString("p")

            If Not id_empresa Is Nothing And
                Not anio Is Nothing And
                Not periodo Is Nothing Then

                Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Me.gvReporte.DataSource = reporte.ReporteRecibosNomina(id_empresa, anio, periodo)
                Funciones.TranslateGridviewHeader(Me.gvReporte)
                Me.gvReporte.DataBind()

                If Me.gvReporte.Rows.Count = 0 Then
                    Me.lblNoRecords.Visible = True
                End If
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
            Dim dt As DataTable = reporte.ReporteRecibosNomina(Request.QueryString("e"), Request.QueryString("a"), Request.QueryString("p"))

            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvReporte.DataSource = dv
            Funciones.TranslateGridviewHeader(Me.gvReporte)
            gvReporte.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    Protected Function RecuperaDatosReporte() As DataTable
        Dim id_empresa As String = Request.QueryString("e")
        Dim anio As String = Request.QueryString("a")
        Dim periodo As String = Request.QueryString("p")

        If Not id_empresa Is Nothing And
            Not anio Is Nothing And
            Not periodo Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Return reporte.ReporteRecibosNomina(id_empresa, anio, periodo)

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
        Dim periodo As String = Request.QueryString("p")

        Dim parametros As String = ""

        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))


        parametros += TranslateLocale.text("Empresa") & ": " & reporte.RecuperaEmpresaNombre(Request.QueryString("e")) & ", "
        parametros += TranslateLocale.text("Año") & ": " & anio & ", " & TranslateLocale.text("Quincena") & ": " & periodo


        Return parametros
    End Function

End Class
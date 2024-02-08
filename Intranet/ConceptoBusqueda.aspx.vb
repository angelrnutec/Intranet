Imports IntranetBL
Imports System.Web.Services

Public Class ConceptoBusqueda
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            CargaCombos()
            Me.btnAgregar.Visible = False
            Me.trFiltroEmpresa.Visible = False

            If Not Request.QueryString("id_reporte") Is Nothing Then
                Me.ddlReporte.SelectedValue = Request.QueryString("id_reporte")
                If Request.QueryString("id_reporte") = 7 Then
                    Me.trFiltroEmpresa.Visible = True
                    Me.ddlFiltroEmpresa.SelectedValue = Request.QueryString("id_empresa")
                    Me.Busqueda()
                End If
            End If

        End If

    End Sub

    Private Sub CargaCombos()
        Try

            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = combos.RecuperaReportesConcepto()

            Me.ddlReporte.DataSource = dt
            Me.ddlReporte.DataValueField = "id_reporte"
            Me.ddlReporte.DataTextField = "nombre"
            Me.ddlReporte.DataBind()

            dt = combos.RecuperaEmpresasConcepto("")
            Me.ddlEmpresa.DataSource = dt
            Me.ddlEmpresa.DataValueField = "id_empresa"
            Me.ddlEmpresa.DataTextField = "nombre"
            Me.ddlEmpresa.DataBind()

            dt = combos.RecuperaEmpresasConcepto("T")
            Me.ddlFiltroEmpresa.DataSource = dt
            Me.ddlFiltroEmpresa.DataValueField = "id_empresa"
            Me.ddlFiltroEmpresa.DataTextField = "nombre"
            Me.ddlFiltroEmpresa.DataBind()


            dt = combos.RecuperaAnio("S")
            Me.ddlAnio.DataSource = dt
            Me.ddlAnio.DataValueField = "id_anio"
            Me.ddlAnio.DataTextField = "anio"
            Me.ddlAnio.DataBind()


            dt = combos.RecuperaMes("S")
            Me.ddlMes.DataSource = dt
            Me.ddlMes.DataValueField = "id_mes"
            Me.ddlMes.DataTextField = "mes"
            Me.ddlMes.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Protected Sub btnBuscar_Click(sender As Object, e As EventArgs) Handles btnBuscar.Click
        Me.Busqueda()
    End Sub

    Private Sub Busqueda()
        Try
            Dim id_empresa As Integer = 0

            If Me.trFiltroEmpresa.Visible = True Then
                id_empresa = Me.ddlFiltroEmpresa.SelectedValue
            End If

            Dim concepto As New Concepto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = concepto.Recupera(Me.ddlReporte.SelectedValue, id_empresa)
            Me.gvResultados.DataSource = dt
            Me.gvResultados.DataBind()

            If dt.Rows.Count > 0 Then
                Me.btnAgregar.Visible = True
            Else
                Me.btnAgregar.Visible = False
            End If

            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dtCombo As DataTable = combos.RecuperaConceptoPadre(Me.ddlReporte.SelectedValue)
            Me.ddlPadre.DataSource = dtCombo
            Me.ddlPadre.DataValueField = "id_concepto"
            Me.ddlPadre.DataTextField = "descripcion"
            Me.ddlPadre.DataBind()



        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Sub gvResultados_PageIndexChanging(sender As Object, e As GridViewPageEventArgs) Handles gvResultados.PageIndexChanging
        Me.gvResultados.PageIndex = e.NewPageIndex
        Me.Busqueda()
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

    Private Sub gvResultados_RowCommand(sender As Object, e As GridViewCommandEventArgs) Handles gvResultados.RowCommand
        Try
            If e.CommandName = "borrar" Then
                Dim concepto As New Concepto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
                concepto.Elimina(e.CommandArgument)
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Protected Sub gvResultados_Sorting(sender As Object, e As GridViewSortEventArgs) Handles gvResultados.Sorting
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
            Dim id_empresa As Integer = 0

            If Me.trFiltroEmpresa.Visible = True Then
                id_empresa = Me.ddlFiltroEmpresa.SelectedValue
            End If

            '  You can cache the DataTable for improving performance
            Dim concepto As New Concepto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            Dim dt As DataTable = concepto.Recupera(Me.ddlReporte.SelectedValue, id_empresa)
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvResultados.DataSource = dv
            gvResultados.DataBind()


        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    <WebMethod>
    Public Shared Function GuardaConcepto(ByVal id_concepto As Integer, ByVal clave As String, ByVal descripcion As String, ByVal id_reporte As Integer,
                                            ByVal orden As Integer, ByVal id_padre As Integer, ByVal resta As Boolean, ByVal formula_especial As String,
                                            ByVal permite_captura As Boolean, ByVal es_separador As Boolean, ByVal es_plan As Boolean,
                                            ByVal es_fibras As Boolean, ByVal es_hornos As Boolean, ByVal id_empresa As Integer, ByVal descripcion_2 As String,
                                            ByVal referencia As String, ByVal referencia2 As String, ByVal referencia3 As String) As String
        Try

            Dim concepto As New Concepto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            concepto.Guarda(id_concepto, clave, descripcion, id_reporte, orden, id_padre, resta, formula_especial, permite_captura, es_separador, es_plan,
                            es_fibras, es_hornos, id_empresa, descripcion_2, referencia, referencia2, referencia3)


            Return "Informacion Guardada"

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    <WebMethod>
    Public Shared Function BajaConcepto(ByVal id_concepto As Integer, ByVal anio_baja As Integer, ByVal periodo_baja As Integer) As String
        Try

            Dim concepto As New Concepto(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            concepto.Baja(id_concepto, anio_baja, periodo_baja)

            Return "Baja Guardada"

        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Protected Sub ddlReporte_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlReporte.SelectedIndexChanged
        If ddlReporte.SelectedValue = "7" Then
            Me.trFiltroEmpresa.Visible = True
        Else
            Me.trFiltroEmpresa.Visible = False
        End If
    End Sub
End Class
Imports IntranetBL
Imports System.Web.Services

Public Class EmpleadosBusqueda
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            lnkASignarJefeDirecto.Visible = False
            lnkAsignarGerente.Visible = False
            lnkAsignarJefeArea.Visible = False

            CargaCombos()
        End If

    End Sub

    Protected Sub btnBuscar_Click(sender As Object, e As EventArgs) Handles btnBuscar.Click
        Me.Busqueda()
    End Sub

    Private Sub CargaCombos()
        Try
            Dim empresa As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = empresa.RecuperaSolicitudEmpresa()

            Me.ddlEmpresa.DataSource = dt
            Me.ddlEmpresa.DataValueField = "id_empresa"
            Me.ddlEmpresa.DataTextField = "nombre"
            Me.ddlEmpresa.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub

    Private Sub Busqueda()
        Try
            Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = empleado.Recupera(Me.txtBusqueda.Text, Me.chbSoloSinJefe.Checked, Me.ddlEmpresa.SelectedValue)
            Me.gvResultados.DataSource = dt
            Me.gvResultados.DataBind()

            If dt.Rows.Count > 0 Then
                lnkASignarJefeDirecto.Visible = True
                lnkAsignarGerente.Visible = True
                lnkAsignarJefeArea.Visible = True
            Else
                lnkASignarJefeDirecto.Visible = False
                lnkAsignarGerente.Visible = False
                lnkAsignarJefeArea.Visible = False
            End If

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
            '  You can cache the DataTable for improving performance
            Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = empleado.Recupera(Me.txtBusqueda.Text, Me.chbSoloSinJefe.Checked)
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvResultados.DataSource = dv
            gvResultados.DataBind()

            If dt.Rows.Count > 0 Then
                lnkASignarJefeDirecto.Visible = True
                lnkAsignarGerente.Visible = True
                lnkAsignarJefeArea.Visible = True
            Else
                lnkASignarJefeDirecto.Visible = False
                lnkAsignarGerente.Visible = False
                lnkAsignarJefeArea.Visible = False
            End If

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    <WebMethod>
    Public Shared Function RecuperaEmpleados(ByVal nombre As String) As String
        Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Dim dt As DataTable = empleado.RecuperaBusqueda(nombre)

        If dt.Rows.Count > 0 Then
            'DataRow dr = dt.Rows[0];
            'return dr["valores"].ToString();
            Dim valores As String = ""

            For Each dRow As DataRow In dt.Rows
                valores += dRow("id_empleado").ToString() & ";" & dRow("nombre").ToString() & ";" & dRow("departamento").ToString() & ";" & dRow("email").ToString() & "||"
            Next

            If valores.Length > 0 Then
                valores = valores.Remove(valores.Length - 2)
            End If

            Return valores
        End If

        Return ""

    End Function

    <WebMethod>
    Public Shared Function ActualizaJefeEmpleado(ByVal id_jefe As Integer, ByVal id_empleados As String, tipo_asignacion As String) As String
        Try
            Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())

            id_empleados = id_empleados.Substring(0, id_empleados.Length - 1)

            Dim ids As String() = id_empleados.Split(",")

            For Each id As String In ids
                empleado.AsignaJefeDirecto(id, id_jefe, tipo_asignacion)
            Next

            If tipo_asignacion = 1 Then
                Return "Jefe Directo asignado correctamente"
            ElseIf tipo_asignacion = 2 Then
                Return "Gerente asignado correctamente"
            ElseIf tipo_asignacion = 3 Then
                Return "Jefe de Area asignado correctamente"
            End If

        Catch ex As Exception
            Throw ex
        End Try
        Return ""
    End Function

    Private Sub btnAgregar_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click
        Response.Redirect("EmpleadosEdicion.aspx")
    End Sub
End Class
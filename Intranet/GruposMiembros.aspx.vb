Imports IntranetBL

Public Class GruposMiembros
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.txtId.text = Request.QueryString("id")
            Me.CargaDatos()
        End If

    End Sub

    Private Sub CargaDatos()
        Try
            Dim grupos As New Grupo(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim ds As DataSet = grupos.RecuperaConfiguracion(Me.txtId.text)

            Dim dtGrupo As DataTable = ds.Tables(0)
            Dim esPrivado As Boolean
            If dtGrupo.Rows.Count > 0 Then
                Me.lblGrupoNombre.Text = dtGrupo.Rows(0)("nombre")
                esPrivado = dtGrupo.Rows(0)("es_privado")
            End If

            Me.lstEmpleadosPublicanDisponibles.DataSource = ds.Tables(1)
            Me.lstEmpleadosPublicanDisponibles.DataValueField = "id_empleado"
            Me.lstEmpleadosPublicanDisponibles.DataTextField = "nombre"
            Me.lstEmpleadosPublicanDisponibles.DataBind()

            Me.lstEmpleadosPublicanAsignados.DataSource = ds.Tables(2)
            Me.lstEmpleadosPublicanAsignados.DataValueField = "id_empleado"
            Me.lstEmpleadosPublicanAsignados.DataTextField = "nombre"
            Me.lstEmpleadosPublicanAsignados.DataBind()

            If Not esPrivado Then
                Me.tblDepartamentos.Visible = False
                Me.tblEmpleadosVer.Visible = False
            Else

                Me.lstEmpleadosVenDisponibles.DataSource = ds.Tables(3)
                Me.lstEmpleadosVenDisponibles.DataValueField = "id_empleado"
                Me.lstEmpleadosVenDisponibles.DataTextField = "nombre"
                Me.lstEmpleadosVenDisponibles.DataBind()

                Me.lstEmpleadosVenAsignados.DataSource = ds.Tables(4)
                Me.lstEmpleadosVenAsignados.DataValueField = "id_empleado"
                Me.lstEmpleadosVenAsignados.DataTextField = "nombre"
                Me.lstEmpleadosVenAsignados.DataBind()

                Me.lstDepartamentosVenDisponibles.DataSource = ds.Tables(5)
                Me.lstDepartamentosVenDisponibles.DataValueField = "id_departamento"
                Me.lstDepartamentosVenDisponibles.DataTextField = "nombre"
                Me.lstDepartamentosVenDisponibles.DataBind()

                Me.lstDepartamentosVenAsignados.DataSource = ds.Tables(6)
                Me.lstDepartamentosVenAsignados.DataValueField = "id_departamento"
                Me.lstDepartamentosVenAsignados.DataTextField = "nombre"
                Me.lstDepartamentosVenAsignados.DataBind()
            End If

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub

    Private Function ValoresSeleccionados(lista As ListBox) As ArrayList
        Dim array As New ArrayList
        For Each x As ListItem In lista.Items
            If x.Selected Then
                array.Add(x.Value)
            End If
        Next
        Return array
    End Function

    Protected Sub btnPublicanLeft_Click(sender As Object, e As ImageClickEventArgs) Handles btnPublicanLeft.Click
        Dim grupo As New Grupo(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim seleccionados As ArrayList = ValoresSeleccionados(Me.lstEmpleadosPublicanAsignados)
        For Each item As String In seleccionados
            grupo.EmpleadosPublicanQuitar(Me.txtId.text, item)
        Next

        Me.CargaDatos()
        Me.btnPublicanLeft.Focus()
    End Sub

    Protected Sub btnPublicanRight_Click(sender As Object, e As ImageClickEventArgs) Handles btnPublicanRight.Click
        Dim grupo As New Grupo(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim seleccionados As ArrayList = ValoresSeleccionados(Me.lstEmpleadosPublicanDisponibles)
        For Each item As String In seleccionados
            grupo.EmpleadosPublicanAgregar(Me.txtId.text, item)
        Next

        Me.CargaDatos()
        Me.btnPublicanRight.Focus()
    End Sub

    Protected Sub btnVenLeft_Click(sender As Object, e As ImageClickEventArgs) Handles btnVenLeft.Click
        Dim grupo As New Grupo(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim seleccionados As ArrayList = ValoresSeleccionados(Me.lstEmpleadosVenAsignados)
        For Each item As String In seleccionados
            grupo.EmpleadosVenQuitar(Me.txtId.text, item)
        Next

        Me.CargaDatos()
        Me.btnVenLeft.Focus()
    End Sub

    Protected Sub btnVenRight_Click(sender As Object, e As ImageClickEventArgs) Handles btnVenRight.Click
        Dim grupo As New Grupo(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim seleccionados As ArrayList = ValoresSeleccionados(Me.lstEmpleadosVenDisponibles)
        For Each item As String In seleccionados
            grupo.EmpleadosVenAgregar(Me.txtId.text, item)
        Next

        Me.CargaDatos()
        Me.btnVenRight.Focus()
    End Sub

    Protected Sub btnDepLeft_Click(sender As Object, e As ImageClickEventArgs) Handles btnDepLeft.Click
        Dim grupo As New Grupo(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim seleccionados As ArrayList = ValoresSeleccionados(Me.lstDepartamentosVenAsignados)
        For Each item As String In seleccionados
            grupo.DeptosVenQuitar(Me.txtId.Text, item)
        Next

        Me.CargaDatos()
        Me.btnDepLeft.Focus()
    End Sub

    Protected Sub btnDepRight_Click(sender As Object, e As ImageClickEventArgs) Handles btnDepRight.Click
        Dim grupo As New Grupo(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim seleccionados As ArrayList = ValoresSeleccionados(Me.lstDepartamentosVenDisponibles)
        For Each item As String In seleccionados
            grupo.DeptosVenAgregar(Me.txtId.Text, item)
        Next

        Me.CargaDatos()
        Me.btnDepRight.Focus()
    End Sub
End Class
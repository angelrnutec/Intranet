Imports IntranetBL

Public Class AutorizacionesConfig
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.CargaDatos()
        End If

    End Sub

    Private Sub CargaDatos()
        Try
            Dim autorizaciones_config As New Autorizaciones_Config(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim ds As DataSet = autorizaciones_config.Recupera()

            Me.lstEmpleadosProyectManagersDisponibles.DataSource = ds.Tables(0)
            Me.lstEmpleadosProyectManagersDisponibles.DataValueField = "id_empleado"
            Me.lstEmpleadosProyectManagersDisponibles.DataTextField = "nombre"
            Me.lstEmpleadosProyectManagersDisponibles.DataBind()

            Me.lstEmpleadosProyectManagersAsignados.DataSource = ds.Tables(1)
            Me.lstEmpleadosProyectManagersAsignados.DataValueField = "id_empleado"
            Me.lstEmpleadosProyectManagersAsignados.DataTextField = "nombre"
            Me.lstEmpleadosProyectManagersAsignados.DataBind()

            Me.lstEmpleadosContabilidadDisponibles.DataSource = ds.Tables(2)
            Me.lstEmpleadosContabilidadDisponibles.DataValueField = "id_empleado"
            Me.lstEmpleadosContabilidadDisponibles.DataTextField = "nombre"
            Me.lstEmpleadosContabilidadDisponibles.DataBind()

            Me.lstEmpleadosContabilidadAsignados.DataSource = ds.Tables(3)
            Me.lstEmpleadosContabilidadAsignados.DataValueField = "id_empleado"
            Me.lstEmpleadosContabilidadAsignados.DataTextField = "nombre"
            Me.lstEmpleadosContabilidadAsignados.DataBind()


            Me.lstEmpleadosNominasDisponibles.DataSource = ds.Tables(4)
            Me.lstEmpleadosNominasDisponibles.DataValueField = "id_empleado"
            Me.lstEmpleadosNominasDisponibles.DataTextField = "nombre"
            Me.lstEmpleadosNominasDisponibles.DataBind()

            Me.lstEmpleadosNominasAsignados.DataSource = ds.Tables(5)
            Me.lstEmpleadosNominasAsignados.DataValueField = "id_empleado"
            Me.lstEmpleadosNominasAsignados.DataTextField = "nombre"
            Me.lstEmpleadosNominasAsignados.DataBind()

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

    Protected Sub btnProyectManagersLeft_Click(sender As Object, e As ImageClickEventArgs) Handles btnProyectManagersLeft.Click
        Dim autorizaciones_config As New Autorizaciones_Config(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim seleccionados As ArrayList = ValoresSeleccionados(Me.lstEmpleadosProyectManagersAsignados)
        For Each item As String In seleccionados
            autorizaciones_config.GuardaQuita("Q", 1, item)
        Next

        Me.CargaDatos()
        Me.btnProyectManagersLeft.Focus()
    End Sub

    Protected Sub btnProyectManagersRight_Click(sender As Object, e As ImageClickEventArgs) Handles btnProyectManagersRight.Click
        Dim autorizaciones_config As New Autorizaciones_Config(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim seleccionados As ArrayList = ValoresSeleccionados(Me.lstEmpleadosProyectManagersDisponibles)
        For Each item As String In seleccionados
            autorizaciones_config.GuardaQuita("A", 1, item)
        Next

        Me.CargaDatos()
        Me.btnProyectManagersRight.Focus()
    End Sub

    Protected Sub btnContabilidadLeft_Click(sender As Object, e As ImageClickEventArgs) Handles btnContabilidadLeft.Click
        Dim autorizaciones_config As New Autorizaciones_Config(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim seleccionados As ArrayList = ValoresSeleccionados(Me.lstEmpleadosContabilidadAsignados)
        For Each item As String In seleccionados
            autorizaciones_config.GuardaQuita("Q", 2, item)
        Next

        Me.CargaDatos()
        Me.btnContabilidadLeft.Focus()
    End Sub

    Protected Sub btnContabilidadRight_Click(sender As Object, e As ImageClickEventArgs) Handles btnContabilidadRight.Click
        Dim autorizaciones_config As New Autorizaciones_Config(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim seleccionados As ArrayList = ValoresSeleccionados(Me.lstEmpleadosContabilidadDisponibles)
        For Each item As String In seleccionados
            autorizaciones_config.GuardaQuita("A", 2, item)
        Next

        Me.CargaDatos()
        Me.btnContabilidadRight.Focus()
    End Sub


    Protected Sub btnNominasLeft_Click(sender As Object, e As ImageClickEventArgs) Handles btnNominasLeft.Click
        Dim autorizaciones_config As New Autorizaciones_Config(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim seleccionados As ArrayList = ValoresSeleccionados(Me.lstEmpleadosNominasAsignados)
        For Each item As String In seleccionados
            autorizaciones_config.GuardaQuita("Q", 3, item)
        Next

        Me.CargaDatos()
        Me.btnNominasLeft.Focus()
    End Sub

    Protected Sub btnNominasRight_Click(sender As Object, e As ImageClickEventArgs) Handles btnNominasRight.Click
        Dim autorizaciones_config As New Autorizaciones_Config(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim seleccionados As ArrayList = ValoresSeleccionados(Me.lstEmpleadosNominasDisponibles)
        For Each item As String In seleccionados
            autorizaciones_config.GuardaQuita("A", 3, item)
        Next

        Me.CargaDatos()
        Me.btnNominasRight.Focus()
    End Sub
End Class
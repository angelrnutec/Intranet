Imports IntranetBL

Public Class Buscar
    Inherits System.Web.UI.Page


    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            If Not Request.QueryString("b") Is Nothing Then
                Me.txtBusqueda.Text = Request.QueryString("b")
                Call CargaResultadosPersonas()
                Call CargaResultadosContenidos()
                Me.lblTitulo.Text = "A continuacion los resultados de tu búsqueda: " & Me.txtBusqueda.Text
            Else
                Response.Redirect("/NoAutorizado.aspx")
            End If
        End If
    End Sub

    Private Sub CargaResultadosContenidos()
        Dim publicacion As New Publicacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dt As DataTable = publicacion.RecuperaPorBusqueda(Session("idEmpleado"), Me.txtBusqueda.Text)

        Me.lvBusquedaContenidos.DataSource = dt
        Me.lvBusquedaContenidos.DataBind()

    End Sub

    Private Sub CargaResultadosPersonas()
        Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dt As DataTable = empleado.RecuperaPorBusqueda(Me.txtBusqueda.Text)

        Me.lvBusquedaEmpleados.DataSource = dt
        Me.lvBusquedaEmpleados.DataBind()

    End Sub

End Class
Imports IntranetBL

Public Class VerEmp
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            If Request.QueryString("id") Is Nothing Then
                Response.Redirect("/ErrorInesperado.aspx?Msg=Consulta invalida")
            End If


            Me.CargaDatos(Request.QueryString("id"))
        End If
    End Sub

    Private Sub CargaDatos(id As Integer)
        Try
            Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = empleado.RecuperaPorId(id)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                Me.lblDepartamento.Text = dr("departamento")
                Me.lblFechaNacimiento.Text = Convert.ToDateTime(dr("fecha_nacimiento")).ToString("dd/MM/yyyy")
                Me.lblNombre.Text = dr("nombre")
                Me.lblNumero.Text = dr("numero")
                Me.lblTelefono.Text = dr("telefono")
                Me.txtFoto.Text = dr("fotografia")
                Me.lblEmail.Text = dr("email")
                Me.lblEmpresa.Text = dr("empresa")

            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Protected Function FotoEmpleado() As String
        Return "background:url('/uploads/fotos/media/" & Me.txtFoto.Text & "')"
    End Function


End Class
Imports IntranetBL
Imports System.Web.Services

Public Class EmpleadosVer
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            If Request.QueryString("id") Is Nothing Then
                Response.Redirect("/ErrorInesperado.aspx?Msg=Consulta invalida")
            End If

            Me.txtIdEmpleado.Text = Request.QueryString("id")

            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Me.ddlLocalidad.Items.Clear()
            Me.ddlLocalidad.Items.AddRange(Funciones.DatatableToList(combos.RecuperaLocalidades(), "nombre", "id_localidad"))

            Me.CargaDatos(Me.txtIdEmpleado.Text)

            If Session("esAdministrador") <> "1" Then
                Me.tblPerfiles.Visible = False
            End If
        End If
    End Sub

    Private Sub CargaDatos(id As Integer)
        Try
            Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = empleado.RecuperaPorId(id)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                Me.lblCuenta.Text = dr("cuenta")
                Me.lblCurp.Text = dr("curp")
                Me.lblDepartamento.Text = dr("departamento")
                Me.lblDireccion.Text = dr("direccion")
                Me.lblFechaAlta.Text = Convert.ToDateTime(dr("fecha_alta")).ToString("dd/MM/yyyy")
                Me.lblFechaNacimiento.Text = Convert.ToDateTime(dr("fecha_nacimiento")).ToString("dd/MM/yyyy")
                Me.lblIMSS.Text = dr("imss")
                Me.lblLocalidad.Text = dr("localidad")
                Me.lblNombre.Text = dr("nombre")
                Me.lblNumero.Text = dr("numero")
                Me.lblRFC.Text = dr("rfc")
                Me.lblTelefono.Text = dr("telefono")
                Me.lblTurno.Text = dr("turno")
                Me.txtFoto.Text = dr("fotografia")
                Me.txtEmail.Text = dr("email")
                Me.txtUsuario.Text = dr("usuario")
                Me.lblJefeDirecto.Text = dr("empleado_jefe")
                Me.chkPermitirGastosViajeCova.Checked = dr("permitir_gastos_viaje_cova") = True
                If Me.lblJefeDirecto.Text.Length > 0 Then
                    Me.lnkQuitarJefeDirecto.Visible = True
                End If

                Me.lblGerente.Text = dr("empleado_gerente")
                If Me.lblGerente.Text.Length > 0 Then
                    Me.lnkQuitarGerente.Visible = True
                End If

                Me.lblJefeArea.Text = dr("empleado_jefe_area")
                If Me.lblJefeArea.Text.Length > 0 Then
                    Me.lnkQuitarJefeArea.Visible = True
                End If

                Me.lblEmpresa.Text = dr("empresa")
                Me.ddlLocalidad.SelectedValue = dr("id_localidad")
                Me.txtNumDeudor.Text = dr("num_deudor")
                Me.txtNumAcreedor.Text = dr("num_acreedor")
                Me.txtCentroCosto.Text = dr("centro")
                Me.txtNumTarjetaGastos.Text = dr("num_tarjeta_gastos")
                Me.txtNumTarjetaGastosAMEX.Text = dr("num_tarjeta_gastos_amex")

                If dr("password") <> "" Then
                    Me.requierePassword.Text = "0"
                Else
                    Me.requierePassword.Text = "1"
                End If

                If dr("es_externo") Then
                    Me.btnEditarExterno.Visible = True
                End If
                CargaListas(id)

            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub CargaListas(ByVal id As Integer)
        Try
            Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dsPerfiles As DataSet = empleado.RecuperaEmpleadoPerfil(id)

            Me.lbOtorgados.DataSource = dsPerfiles.Tables(0)
            Me.lbOtorgados.DataTextField = "nombre"
            Me.lbOtorgados.DataValueField = "id_perfil"
            Me.lbOtorgados.DataBind()

            Me.lbDisponibles.DataSource = dsPerfiles.Tables(1)
            Me.lbDisponibles.DataTextField = "nombre"
            Me.lbDisponibles.DataValueField = "id_perfil"
            Me.lbDisponibles.DataBind()

            If Me.lbDisponibles.Items.Count > 0 Then
                Me.lbDisponibles.SelectedIndex = 0
            End If

            If Me.lbOtorgados.Items.Count > 0 Then
                Me.lbOtorgados.SelectedIndex = 0
            End If

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Protected Function FotoEmpleado() As String
        Return "background:url('/uploads/fotos/media/" & Me.txtFoto.Text & "');"
    End Function

    Private Sub btnRegresar_Click(sender As Object, e As EventArgs) Handles btnRegresar.Click
        Response.Redirect("EmpleadosBusqueda.aspx")
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Me.ValidaCaptura()

            Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            empleado.GuardaDatosUsuario(Me.txtIdEmpleado.Text, _
                                            Me.txtEmail.Text, _
                                            Me.txtUsuario.Text, _
                                            Me.txtPassword.Text,
                                            Me.ddlLocalidad.SelectedValue,
                                            Me.txtNumDeudor.Text,
                                            Me.txtNumAcreedor.Text,
                                            Me.txtCentroCosto.Text,
                                            Me.txtNumTarjetaGastos.Text,
                                            Me.txtNumTarjetaGastosAMEX.Text,
                                            Me.chkPermitirGastosViajeCova.Checked)

            If Session("esAdministrador") = "1" Then
                empleado.EliminaEmpleadoPerfil(Me.txtIdEmpleado.Text)
                For Each li As ListItem In lbOtorgados.Items
                    empleado.GuardaEmpleadoPerfil(Me.txtIdEmpleado.Text, li.Value)
                Next
            End If

            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Datos guardados con exito');</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub ValidaCaptura()
        Dim msg As String = ""
        If Me.txtEmail.Text.Trim = "" Then
            msg += " - Email\n"
        Else
            If EmailAddressCheck(Me.txtEmail.Text) = False Then
                msg += " - Email valido\n"
            End If
        End If
        If Me.txtUsuario.Text.Trim = "" Then msg += " - Usuario\n"
        If Me.requierePassword.Text = "1" And Me.txtPassword.Text.Trim = "" Then msg += " - Password\n"
        If Me.ddlLocalidad.SelectedValue = 0 Then msg += " - Localidad\n"

        'If Session("esAdministrador") = "1" Then
        '    If lbOtorgados.Items.Count = 0 Then
        '        msg += "- Debe otorgar al menos un perfil al usuario\n"
        '    End If
        'End If

        If msg.Length > 0 Then
            Throw New Exception("Favor de capturar la siguiente información:\n" & msg)
        End If
    End Sub


    Function EmailAddressCheck(ByVal emailAddress As String) As Boolean

        Dim pattern As String = "^[a-zA-Z][\w\.-]*[a-zA-Z0-9]@[a-zA-Z0-9][\w\.-]*[a-zA-Z0-9]\.[a-zA-Z][a-zA-Z\.]*[a-zA-Z]$"
        Dim emailAddressMatch As Match = Regex.Match(emailAddress, pattern)
        If emailAddressMatch.Success Then
            EmailAddressCheck = True
        Else
            EmailAddressCheck = False
        End If

    End Function

    Protected Sub btnAgregar_Click(sender As Object, e As EventArgs) Handles btnAgregar.Click

        Dim itemsToAdd As New List(Of ListItem)()
        Dim contador As Integer = 0

        For Each item As ListItem In Me.lbDisponibles.Items
            If item.Selected Then
                Dim newItem As ListItem = New ListItem()
                newItem.Value = item.Value
                newItem.Text = item.Text

                itemsToAdd.Add(newItem)
                contador += 1
            End If
        Next

        For Each item As ListItem In itemsToAdd
            lbOtorgados.Items.Add(item)
            lbDisponibles.Items.Remove(item)
        Next


        'If Not Me.lbDisponibles.SelectedItem Is Nothing Then
        '    Dim item As ListItem = New ListItem()
        '    item.Value = lbDisponibles.SelectedItem.Value
        '    item.Text = lbDisponibles.SelectedItem.Text

        '    lbOtorgados.Items.Add(item)
        '    lbDisponibles.Items.Remove(item)
        'End If
    End Sub

    Protected Sub btnQuitar_Click(sender As Object, e As EventArgs) Handles btnQuitar.Click

        Dim itemsToAdd As New List(Of ListItem)()
        Dim contador As Integer = 0

        For Each item As ListItem In Me.lbOtorgados.Items
            If item.Selected Then
                Dim newItem As ListItem = New ListItem()
                newItem.Value = item.Value
                newItem.Text = item.Text

                itemsToAdd.Add(newItem)
                contador += 1
            End If
        Next

        For Each item As ListItem In itemsToAdd
            lbDisponibles.Items.Add(item)
            lbOtorgados.Items.Remove(item)
        Next


        'If Not Me.lbOtorgados.SelectedItem Is Nothing Then
        '    Dim item As ListItem = New ListItem()
        '    item.Value = lbOtorgados.SelectedItem.Value
        '    item.Text = lbOtorgados.SelectedItem.Text

        '    lbDisponibles.Items.Add(item)
        '    lbOtorgados.Items.Remove(item)
        'End If
    End Sub

    <WebMethod>
    Public Shared Function RecuperaEmpleados(ByVal nombre As String) As String
        Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        Dim dt As DataTable = empleado.RecuperaBusqueda(nombre)

        If dt.Rows.Count > 0 Then
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
    Public Shared Function ActualizaJefeEmpleado(ByVal id_jefe As Integer, ByVal id_empleado As Integer, tipo_asignacion As String) As String
        Try
            Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
            empleado.AsignaJefeDirecto(id_empleado, id_jefe, tipo_asignacion)

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

    Private Sub lnkQuitarJefeDirecto_Click(sender As Object, e As EventArgs) Handles lnkQuitarJefeDirecto.Click
        Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        empleado.QuitarJefeDirecto(Me.txtIdEmpleado.Text)

        Response.Redirect("/EmpleadosVer.aspx?id=" & Me.txtIdEmpleado.Text)
    End Sub

    Private Sub btnEditarExterno_Click(sender As Object, e As EventArgs) Handles btnEditarExterno.Click
        Server.Transfer("/EmpleadosEdicion.aspx?id=" & Me.txtIdEmpleado.Text)
    End Sub

    Private Sub lnkQuitarGerente_Click(sender As Object, e As EventArgs) Handles lnkQuitarGerente.Click
        Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        empleado.QuitarGerente(Me.txtIdEmpleado.Text)

        Response.Redirect("/EmpleadosVer.aspx?id=" & Me.txtIdEmpleado.Text)
    End Sub

    Private Sub lnkQuitarJefeArea_Click(sender As Object, e As EventArgs) Handles lnkQuitarJefeArea.Click
        Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        empleado.QuitarJefeArea(Me.txtIdEmpleado.Text)

        Response.Redirect("/EmpleadosVer.aspx?id=" & Me.txtIdEmpleado.Text)
    End Sub
End Class
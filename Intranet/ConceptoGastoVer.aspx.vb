Imports IntranetBL
Imports System.Web.Services
Imports Intranet.LocalizationIntranet

Public Class ConceptoGastoVer
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            If Request.QueryString("id") Is Nothing Then
                Response.Redirect("/ErrorInesperado.aspx?Msg=Consulta invalida")
            End If

            Me.txtIdConceptoGasto.Text = Request.QueryString("id")
            Me.CargaDatos(Me.txtIdConceptoGasto.Text)
        End If

        Me.btnEliminar.Text = TranslateLocale.text("Eliminar")
        Me.btnGuardar.Text = TranslateLocale.text("Guardar")
        Me.btnRegresar.Text = TranslateLocale.text("Regresar")
    End Sub

    Private Sub CargaDatos(id As Integer)
        Try
            Dim concepto_gasto As New ConceptoGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = concepto_gasto.RecuperaPorId(id)

            If dt.Rows.Count > 0 Then
                Dim dr As DataRow = dt.Rows(0)

                Me.txtClave.Text = dr("clave")
                Me.txtDescripcion.Text = dr("descripcion")
                Me.txtDescripcionEn.Text = dr("descripcion_en")
                Me.ddlTipo.SelectedValue = dr("tipo")
                Me.txtClaveNB.Text = dr("nb_cuenta_clave")
                Me.txtDescripcionNB.Text = dr("nb_cuenta_desc")
                Me.txtDescripcionNBReportes.Text = dr("nb_cuenta_desc_reportes")
                Me.txtClaveNF.Text = dr("nf_cuenta_clave")
                Me.txtDescripcionNF.Text = dr("nf_cuenta_desc")
                Me.txtClaveNS.Text = dr("ns_cuenta_clave")
                Me.txtDescripcionNS.Text = dr("ns_cuenta_desc")
                Me.txtClaveNU.Text = dr("nu_cuenta_clave")
                Me.txtDescripcionNU.Text = dr("nu_cuenta_desc")

                Me.txtLimiteDiario.Text = dr("limite_diario")
                Me.chkNoDeducible.Checked = dr("es_no_deducible")
                Me.chkIvaEditable.Checked = dr("es_iva_editable")
                Me.chkPermitePropina.Checked = dr("permite_propina")

                Me.chkEsGastoViaje.Checked = dr("es_gasto_viaje")
                Me.chkEsGastoDirectivo.Checked = dr("es_gasto_directivo")
                Me.chkEsGastoCova.Checked = dr("es_gasto_viaje_cova")


                Me.btnEliminar.Visible = True
            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub btnRegresar_Click(sender As Object, e As EventArgs) Handles btnRegresar.Click
        Response.Redirect("ConceptoGastoBusqueda.aspx")
    End Sub

    Private Sub btnGuardar_Click(sender As Object, e As EventArgs) Handles btnGuardar.Click
        Try
            Me.ValidaCaptura()

            Dim concepto_gasto As New ConceptoGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            concepto_gasto.Guarda(Me.txtIdConceptoGasto.Text, Me.txtClave.Text, Me.txtDescripcion.Text, Me.txtDescripcionEn.Text, Me.ddlTipo.SelectedValue,
                                  Me.txtClaveNB.Text, Me.txtDescripcionNB.Text, Me.txtClaveNF.Text, Me.txtDescripcionNF.Text,
                                  Me.txtClaveNS.Text, Me.txtDescripcionNS.Text, Me.txtDescripcionNBReportes.Text,
                                  Me.txtLimiteDiario.Text, Me.chkNoDeducible.Checked, Me.chkIvaEditable.Checked,
                                  Me.txtClaveNU.Text, Me.txtDescripcionNU.Text, Me.chkPermitePropina.Checked,
                                  Me.chkEsGastoViaje.Checked, Me.chkEsGastoDirectivo.Checked, Me.chkEsGastoCova.Checked)


            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Datos guardados con exito');</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

    Private Sub ValidaCaptura()
        Dim msg As String = ""

        If Me.txtClave.Text.Trim = "" Then
            msg += " - Clave\n"
        End If

        If Me.txtDescripcion.Text.Trim = "" Then
            msg += " - Descripcion\n"
        End If

        If Me.txtDescripcionEn.Text.Trim = "" Then
            msg += " - Descripcion ingles\n"
        End If

        If Me.txtLimiteDiario.Text.Trim = "" Then
            Me.txtLimiteDiario.Text = 0
        End If

        If msg.Length > 0 Then
            Throw New Exception("Favor de capturar la siguiente información:\n" & msg)
        End If
    End Sub

    Private Sub btnEliminar_Click(sender As Object, e As EventArgs) Handles btnEliminar.Click
        Dim concepto_gasto As New ConceptoGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        concepto_gasto.Elimina(Me.txtIdConceptoGasto.Text)

        Response.Redirect("/ConceptoGastoBusqueda.aspx")
    End Sub
End Class
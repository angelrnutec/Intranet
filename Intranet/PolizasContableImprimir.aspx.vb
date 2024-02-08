Imports IntranetBL

Public Class PolizasContableImprimir
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
            Dim poliza_contable As New PolizaContable(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim ds As DataSet = poliza_contable.RecuperaImpresion(id)
            Dim dt As DataTable = ds.Tables(0)
            Dim dtPoliza As DataTable = ds.Tables(1)
            Dim dtPolizaDetalle As DataTable = ds.Tables(2)

            If dt.Rows.Count > 0 Then

                Dim dr As DataRow = dt.Rows(0)

                Me.lblEmpresa.Text = dr("empresa")
                Me.lblViajero.Text = dr("viajero")
                Me.lblSolicitante.Text = dr("solicitante")
                Me.lblFolio.Text = dr("folio_txt")
                Me.lblFechaSolicitud.Text = Format(dr("fecha_registro"), "dd/MM/yyyy")
                If Not IsDBNull(dr("fecha_envio_autorizacion")) Then
                    Me.lblFechaComprobacion.Text = Format(dr("fecha_envio_autorizacion"), "dd/MM/yyyy")
                End If


                'If IsDBNull(dr("fecha_autoriza_jefe")) Then
                '    Me.lblAutorizaJefe.Text = dr("jefe") & " (Pte)"
                'Else
                '    Me.lblAutorizaJefe.Text = dr("jefe") & " (" & IIf(dr("autoriza_jefe"), "Aut", "Rech") & " - " & Format(dr("fecha_autoriza_jefe"), "dd/MM/yyyy") & ")"
                'End If

                'If IsDBNull(dr("fecha_autoriza_conta")) Then
                '    Me.lblAutorizaConta.Text = dr("conta") & " (Pte)"
                'Else
                '    Me.lblAutorizaConta.Text = dr("conta") & " (" & IIf(dr("autoriza_conta"), "Aut", "Rech") & " - " & Format(dr("fecha_autoriza_conta"), "dd/MM/yyyy") & ")"
                'End If


                'If IsDBNull(dr("fecha_comprobacion_jefe")) Then
                '    Me.lblAutorizaJefeComprobacion.Text = dr("jefe") & " (Pte)"
                'Else
                '    Me.lblAutorizaJefeComprobacion.Text = dr("jefe") & " (" & IIf(dr("comprobacion_jefe"), "Aut", "Rech") & " - " & Format(dr("fecha_comprobacion_jefe"), "dd/MM/yyyy") & ")"
                'End If

                'If IsDBNull(dr("fecha_comprobacion_conta")) Then
                '    Me.lblAutorizaContaComprobacion.Text = dr("conta") & " (Pte)"
                'Else
                '    Me.lblAutorizaContaComprobacion.Text = dr("conta") & " (" & IIf(dr("comprobacion_conta"), "Aut", "Rech") & " - " & Format(dr("fecha_comprobacion_conta"), "dd/MM/yyyy") & ")"
                'End If


                Me.lblDepartamento.Text = dr("departamento")


                Dim drPoliza As DataRow = dtPoliza.Rows(0)

                If drPoliza("tipo") = "RG" Then
                    Me.tblComentarios.Visible = True
                    Me.tblFechasYMontos.Visible = False
                    Me.tblDestino.Visible = False

                    Me.lblComentarios.Text = dr("comentarios").ToString()
                Else
                    Me.tblComentarios.Visible = False
                    Me.tblFechasYMontos.Visible = True
                    Me.tblDestino.Visible = True

                    Me.lblDestino.Text = dr("destino")
                    Me.lblMotivo.Text = dr("motivo")
                    Me.lblFechaIni.Text = Format(dr("fecha_ini"), "dd/MM/yyyy")
                    Me.lblFechaFin.Text = Format(dr("fecha_fin"), "dd/MM/yyyy")
                    Me.lblMontoPesos.Text = Format(dr("monto_pesos"), "###,###,##0.00")
                    Me.lblMontoUSD.Text = Format(dr("monto_dolares"), "###,###,##0.00")
                    Me.lblMontoEuros.Text = Format(dr("monto_euros"), "###,###,##0.00")

                    Me.diasViaje.Text = DateDiff(DateInterval.Day, dr("fecha_ini"), dr("fecha_fin")) + 1
                    'Me.lblDiasViaje.Text = DateDiff(DateInterval.Day, dr("fecha_ini"), dr("fecha_fin")) + 1

                    If IsDBNull(dr("comprobacion_jefe")) = True Or
                        IsDBNull(dr("comprobacion_conta")) = True Or
                        IsDBNull(dr("autoriza_jefe")) = True Or
                        IsDBNull(dr("autoriza_conta")) = True Then

                        Me.lblPendienteAuth.Visible = True
                    End If
                End If

                Me.lblFechaDocumento.Text = Convert.ToDateTime(drPoliza("fecha_documento")).ToString("dd/MM/yyyy")
                Me.lblSociedad.Text = drPoliza("sociedad").ToString()
                Me.lblTotal.Text = Convert.ToDecimal(drPoliza("total").ToString()).ToString("###,###,##0.00")
                Me.lblReferencia.Text = drPoliza("referencia").ToString()
                Me.lblAsignacion.Text = drPoliza("asignacion").ToString()
                Me.lblDeudor.Text = drPoliza("deudor").ToString()
                Me.lblFechaEnvioSap.Text = Convert.ToDateTime(drPoliza("fecha_envio_sap").ToString()).ToString("dd/MM/yyyy")

                Me.gvPoliza.DataSource = dtPolizaDetalle
                Me.gvPoliza.DataBind()

            End If
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(ChrW(39), ChrW(34)) & "');</script>", False)
        End Try
    End Sub

End Class
Imports IntranetBL
Imports System.Web.Services
Imports SAP.Middleware.Connector
Imports Intranet.LocalizationIntranet
Imports IntranetDA

Public Class GeneraPolizasContables
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
            Me.CargaCombos()
            If Not Request.QueryString("e") Is Nothing Then
                Me.ddlPoliza.SelectedValue = Request.QueryString("tp")
                Me.ddlEmpresa.SelectedValue = Request.QueryString("e")
                MuestraPoliza(False)
            End If


            Me.btnGenerar.Text = TranslateLocale.text("Consultar Pólizas")
            Me.btnCancelar.Text = TranslateLocale.text("Salir")
            Me.btnExportarPoliza.Text = TranslateLocale.text("Enviar Póliza(s) a SAP")
            Me.btnDescargarPoliza.Text = TranslateLocale.text("Descargar Póliza(s) por corregir de SAP")

        End If

    End Sub

    Private Sub CargaCombos()
        Try
            'For i As Integer = 2013 To Now.Year Step 1
            '    Me.ddlAnio.Items.Add(i)
            'Next

            'Dim items As New List(Of ListItem)
            'items.Add(New ListItem("Enero", "1"))
            'items.Add(New ListItem("Febrero", "2"))
            'items.Add(New ListItem("Marzo", "3"))
            'items.Add(New ListItem("Abril", "4"))
            'items.Add(New ListItem("Mayo", "5"))
            'items.Add(New ListItem("Junio", "6"))
            'items.Add(New ListItem("Julio", "7"))
            'items.Add(New ListItem("Agosto", "8"))
            'items.Add(New ListItem("Septiembre", "9"))
            'items.Add(New ListItem("Octubre", "10"))
            'items.Add(New ListItem("Noviembre", "11"))
            'items.Add(New ListItem("Diciembre", "12"))
            'Me.ddlPeriodo.Items.AddRange(items.ToArray)

            'Me.ddlAnio.SelectedValue = Now.Year
            'Me.ddlPeriodo.SelectedValue = Now.Month

            Me.dtFechaIni.SelectedDate = DateTime.Now.AddDays(-8)
            Me.dtFechaFin.SelectedDate = DateTime.Now.AddDays(-1)

            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Me.ddlEmpresa.Items.Clear()
            Me.ddlEmpresa.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpresaConceptoGasto(1, Session("idEmpleado")), "nombre", "id_empresa"))


            Me.ddlEstatus.Items.Clear()
            Me.ddlEstatus.Items.Add(New ListItem(TranslateLocale.text("Pendientes de Enviar a SAP"), "0"))
            Me.ddlEstatus.Items.Add(New ListItem(TranslateLocale.text("Enviadas a SAP"), "1"))

            Me.ddlTipoConcepto.Items.Clear()
            Me.ddlTipoConcepto.Items.Add(New ListItem(TranslateLocale.text("--Seleccione--"), ""))
            Me.ddlTipoConcepto.Items.Add(New ListItem(TranslateLocale.text("Orden Interna"), "OI"))
            Me.ddlTipoConcepto.Items.Add(New ListItem(TranslateLocale.text("Centro de Costo"), "CC"))
            Me.ddlTipoConcepto.Items.Add(New ListItem(TranslateLocale.text("Elemento PEP"), "PP"))
            Me.ddlTipoConcepto.Items.Add(New ListItem(TranslateLocale.text("Reembolso Filiales"), "RF"))

            Me.ddlPoliza.Items.Clear()
            Me.ddlPoliza.Items.Add(New ListItem(TranslateLocale.text("--Seleccione--"), ""))
            Me.ddlPoliza.Items.Add(New ListItem(TranslateLocale.text("Gastos de Viaje"), "SV"))
            Me.ddlPoliza.Items.Add(New ListItem(TranslateLocale.text("Reposición de Gastos"), "RG"))
            Me.ddlPoliza.Items.Add(New ListItem(TranslateLocale.text("Anticipos de Gastos de Viaje"), "SVA"))
            Me.ddlPoliza.Items.Add(New ListItem(TranslateLocale.text("Devolución de Gastos de Viaje"), "SVD"))


            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Me.lblNombreReporte.Text = TranslateLocale.text("Pólizas Contables")




        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub


    Private Sub ValidaSeleccionReporte()
        Dim msg As String = ""

        If Me.ddlPoliza.SelectedValue = "" Then msg &= " - " & TranslateLocale.text("Tipo de Póliza") & "\n"
        If Me.ddlPoliza.SelectedValue <> "SVA" And Me.ddlPoliza.SelectedValue <> "SVD" Then
            If Me.ddlTipoConcepto.SelectedValue = "" Then msg &= " - " & TranslateLocale.text("Tipo de Concepto") & "\n"
        End If
        If Me.ddlEmpresa.SelectedValue = 0 Then msg &= " - " & TranslateLocale.text("Empresa") & "\n"

        If msg.Length > 0 Then
            Throw New Exception(TranslateLocale.text("Favor de capturar la siguiente información") & ":\n" & msg)
        End If

    End Sub

    Private Sub btnCancelar_Click(sender As Object, e As EventArgs) Handles btnCancelar.Click
        Response.Redirect("/")
    End Sub

    'Private Sub btnGenerarReporte_Click(sender As Object, e As EventArgs) Handles btnGenerarReporte.Click
    '    Try
    '        ValidaSeleccionReporte()
    '        MuestraPoliza(False)
    '    Catch ex As Exception
    '        ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
    '    End Try
    'End Sub
    'Private Sub btnGenerarOriginal_Click(sender As Object, e As EventArgs) Handles btnGenerarOriginal.Click
    '    Try
    '        ValidaSeleccionReporte()
    '        MuestraPoliza(True)
    '    Catch ex As Exception
    '        ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
    '    End Try
    'End Sub

    Private Sub btnGenerar_Click(sender As Object, e As EventArgs) Handles btnGenerar.Click
        Try
            ValidaSeleccionReporte()
            MuestraPoliza(True)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try

    End Sub


    Private Sub MuestraPoliza(sobreescribe As Boolean)
        Dim sbHtml As New StringBuilder("")
        Dim poliza As New PolizaContable(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        Dim ds As DataSet = poliza.Recupera(Me.ddlPoliza.SelectedValue, Me.ddlEmpresa.SelectedValue, Me.dtFechaIni.SelectedDate.Value.ToString("yyyyMMdd"), Me.dtFechaFin.SelectedDate.Value.ToString("yyyyMMdd"), 1, Session("idEmpleado"), Me.ddlTipoConcepto.SelectedValue, Me.ddlEstatus.SelectedValue, Me.ddlEmpleado.SelectedValue)
        Dim dtPoliza As DataTable = ds.Tables(0)
        Dim dtPolizaDetalle As DataTable = ds.Tables(1)

        Dim clase As String = ""

        sbHtml.Append("<table class='general' width='900px;' cellpadding='1' cellspacing='0' id='tblDatos' runat='server'>")
        sbHtml.Append("    <tr class='head'>")
        Dim colspan = 2
        If Me.ddlEstatus.SelectedValue = 0 Then
            sbHtml.Append("        <th align='left'>" & TranslateLocale.text("Seleccionar") & "</th>")
            colspan = 1
        End If
        sbHtml.Append("        <th align='left'>" & TranslateLocale.text("Fecha Doc") & "</th>")
        sbHtml.Append("        <th align='left'>" & TranslateLocale.text("Sociedad") & "</th>")
        sbHtml.Append("        <th align='left'>" & TranslateLocale.text("Total MXP") & "</th>")
        sbHtml.Append("        <th align='left'>" & TranslateLocale.text("Referencia") & "</th>")
        sbHtml.Append("        <th align='left'>" & TranslateLocale.text("Asignación") & "</th>")
        sbHtml.Append("        <th align='left' colspan='" & colspan & "'>" & TranslateLocale.text("Deudor") & "</th>")
        sbHtml.Append("    </tr>")
        sbHtml.Append("    <tr class='head2'>")
        sbHtml.Append("        <th align='left'>" & TranslateLocale.text("# Cuenta") & "</th>")
        sbHtml.Append("        <th align='left'>" & TranslateLocale.text("Sociedad") & "</th>")
        sbHtml.Append("        <th align='left'>" & TranslateLocale.text("Clave IVA") & "</th>")
        sbHtml.Append("        <th align='left'>" & TranslateLocale.text("Proyecto") & "</th>")
        sbHtml.Append("        <th align='left'>" & TranslateLocale.text("Importe sin IVA") & "</th>")
        sbHtml.Append("        <th align='left'>" & TranslateLocale.text("Necesidad") & "</th>")
        sbHtml.Append("        <th align='left' style='width:200px'>" & TranslateLocale.text("Descripción") & "</th>")
        sbHtml.Append("    </tr>")

        Dim i As Integer = 0
        For Each drPoliza As DataRow In dtPoliza.Rows
            i += 1
            sbHtml.Append("<tr class='even'>")
            If Me.ddlEstatus.SelectedValue = 0 Then
                sbHtml.Append(String.Format("<td><input id='checkId-{0}' type='checkbox' value='{1}' />", i, drPoliza("referencia")))
                If drPoliza("puede_editar") > 0 Then
                    sbHtml.Append(String.Format("<a href='javascript:EditarPoliza({1}{0}{1},{1}{2}{1})'>" & TranslateLocale.text("Editar") & "</a>", Trim(drPoliza("referencia")), ControlChars.Quote, Me.ddlPoliza.SelectedValue))
                End If
                sbHtml.Append("</td>")
            End If

            If Me.ddlEstatus.SelectedValue = 1 Then
                sbHtml.Append(String.Format("<td><a id='lnkImpr' runat='server' target='_blank' visible='false' href='PolizasContableImprimir.aspx?id=" & drPoliza("id").ToString() & "'><img src='/images/printer.png' border='0' width='22px' height='22px'  /></a>&nbsp;&nbsp;{0}</td>", Convert.ToDateTime(drPoliza("fecha_documento")).ToString("dd/MM/yyyy")))
            Else
                sbHtml.Append(String.Format("<td>{0}</td>", Convert.ToDateTime(drPoliza("fecha_documento")).ToString("dd/MM/yyyy")))
            End If

            sbHtml.Append(String.Format("<td>{0}</td>", drPoliza("sociedad")))
            sbHtml.Append(String.Format("<td>{0}</td>", drPoliza("total")))
            sbHtml.Append(String.Format("<td>{0}</td>", drPoliza("referencia")))
            sbHtml.Append(String.Format("<td>{0}</td>", drPoliza("asignacion")))
            sbHtml.Append(String.Format("<td colspan='" & colspan & "'>{0} - {1}</td>", drPoliza("deudor"), drPoliza("empleado")))
            sbHtml.Append("</tr>")

            Dim rows() As DataRow = dtPolizaDetalle.Select("id_solicitud=" & drPoliza("id_solicitud"))
            For Each drDetalle As DataRow In rows
                sbHtml.Append("<tr>")
                sbHtml.Append(String.Format("<td>{0}</td>", drDetalle("cuenta")))
                sbHtml.Append(String.Format("<td>{0}</td>", drDetalle("sociedad")))
                sbHtml.Append(String.Format("<td>{0}</td>", drDetalle("clave_iva")))
                sbHtml.Append(String.Format("<td>{0}</td>", drDetalle("proyecto")))
                sbHtml.Append(String.Format("<td>{0}</td>", drDetalle("importe_sin_iva")))
                sbHtml.Append(String.Format("<td>{0}</td>", drDetalle("no_necesidad")))
                sbHtml.Append(String.Format("<td>{0}</td>", drDetalle("descripcion")))
                sbHtml.Append("</tr>")
            Next
        Next
        sbHtml.Append("</table>")


        phTablaPoliza.Controls.Add(New LiteralControl(sbHtml.ToString()))
        If dtPoliza.Rows.Count > 0 Then
            Me.lblMensaje.Text = ""
            If Me.ddlEstatus.SelectedValue = 0 Then
                Me.btnExportarPoliza.Visible = True
                Me.divSeleccionaTodos.Visible = True
            End If
        Else
            Me.lblMensaje.Text = TranslateLocale.text("No se encontraron registros")
            Me.btnExportarPoliza.Visible = False
            Me.divSeleccionaTodos.Visible = False
        End If

    End Sub

    <WebMethod>
    Public Shared Function EnviarPolizas(ByVal listaPolizas As String, ByVal tipo As String, poliza As String) As String
        Try
            Dim sbResultados As New StringBuilder("")
            Dim tableSAP As New DataTable
            tableSAP.Columns.Add("id", GetType(Integer))
            tableSAP.Columns.Add("dato01", GetType(String))
            tableSAP.Columns.Add("dato02", GetType(String))
            tableSAP.Columns.Add("dato03", GetType(String))
            tableSAP.Columns.Add("dato04", GetType(String))
            tableSAP.Columns.Add("dato05", GetType(String))
            tableSAP.Columns.Add("dato06", GetType(String))
            tableSAP.Columns.Add("dato07", GetType(String))
            tableSAP.Columns.Add("dato08", GetType(String))
            tableSAP.Columns.Add("dato09", GetType(String))
            tableSAP.Columns.Add("dato10", GetType(String))
            tableSAP.Columns.Add("dato11", GetType(String))
            tableSAP.Columns.Add("dato12", GetType(String))
            tableSAP.Columns.Add("dato13", GetType(String))
            tableSAP.Columns.Add("dato14", GetType(String))




            Dim seguridad As New Seguridad(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())


            Dim polizaObj As New PolizaContable(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Dim ds As DataSet = polizaObj.RecuperaPorFolio(listaPolizas, poliza)
            Dim dtPoliza As DataTable = ds.Tables(0)
            Dim dtPolizaDetalle As DataTable = ds.Tables(1)
            'Dim dtPolizaHijos As DataTable = ds.Tables(3)

            For Each drPoliza As DataRow In dtPoliza.Rows
                Dim i As Integer = 1

                tableSAP.Rows.Clear()


                If poliza = "SVA" Then
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    '' POLIZAS SVA - ANTICIPOS
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

                    Dim valor1 As String = ""
                    Dim valor8 As String = ""
                    Dim valor9 As String = ""
                    Dim valor10 As String = ""
                    Dim dato14 As String = ""

                    Dim valor_referencia_campo_9 As String = drPoliza("referencia")

                    valor1 = "D"


                    tableSAP.Rows.Add(i, valor1, "", Convert.ToDateTime(drPoliza("fecha_documento")).ToString("dd.MM.yyyy"),
                                       "SA", drPoliza("sociedad"),
                                       Convert.ToDateTime(drPoliza("fecha_documento")).ToString("dd.MM.yyyy"),
                                       Convert.ToDateTime(drPoliza("fecha_documento")).ToString("MM"), "MXP",
                                       Left(drPoliza("referencia"), 16),
                                       Left(valor_referencia_campo_9, 25),
                                       Convert.ToDecimal(Math.Abs(drPoliza("total"))).ToString("0.00"),
                                       Left(drPoliza("deudor"), 10),
                                       Left(drPoliza("referencia"), 18), "")


                    Dim rows() As DataRow = dtPolizaDetalle.Select("id_solicitud=" & drPoliza("id_solicitud"))
                    For Each drDetalle As DataRow In rows
                        i += 1


                        dato14 = ""
                        'If tipo = "CC" Then

                        'ElseIf tipo = "OI" Then

                        'ElseIf tipo = "PP" Then
                        '    If drDetalle("proyecto") <> "" Then
                        '        dato14 = drDetalle("proyecto") + "-" + drDetalle("no_necesidad")
                        '    End If
                        'End If
                        dato14 = drDetalle("proyecto")

                        If tipo = "CC" Then
                            valor8 = ""
                            valor9 = Left(drDetalle("proyecto"), 12)
                            valor10 = ""
                        ElseIf tipo = "OI" Then
                            valor8 = Left(drDetalle("proyecto"), 12)
                            valor9 = ""
                            valor10 = ""
                        ElseIf tipo = "PP" Then
                            valor8 = ""
                            valor9 = ""
                            valor10 = Left(drDetalle("proyecto"), 12)
                        ElseIf tipo = "RF" Then
                            valor8 = ""
                            valor9 = ""
                            valor10 = ""
                        End If

                        tableSAP.Rows.Add(i,
                                          "01",
                                          "",
                                          Left(drDetalle("cuenta"), 17),
                                          Convert.ToDecimal(Math.Abs(drDetalle("importe_sin_iva"))).ToString("0.00"),
                                          drDetalle("clave_iva"),
                                          "X",
                                          Left(drPoliza("referencia"), 18),
                                          Left(drDetalle("asignacion").Replace(vbCr, "").Replace(vbLf, ""), 50),
                                          valor8,
                                          valor9,
                                          valor10,
                                          "",
                                          "",
                                          dato14)

                    Next

                    sbResultados.Append("<br/>" & drPoliza("referencia") & ": Respuesta SAP = ")
                    Try
                        Dim sap As New ConsultasSAP
                        Dim polizaSAPResult As PolizaSapResult = sap.EnviarPolizaSAP(tableSAP)
                        Dim resultadoSAP As String = polizaSAPResult.respuesta

                        seguridad.GuardaLogDatos("SAPLog: REF=" & drPoliza("referencia") & " -- " & polizaSAPResult.sap_log)

                        If Left(resultadoSAP, 3) = "000" Then
                            polizaObj.RecuperaEnviadaOK(drPoliza("referencia"), HttpContext.Current.Session("idEmpleado"), poliza)
                        End If
                        sbResultados.Append(resultadoSAP)
                    Catch ex As Exception
                        sbResultados.Append(ex.Message)
                    End Try



                ElseIf poliza = "SVD" Then
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    '' POLIZAS SVD - DEVOLUCION
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

                    Dim valor1 As String = ""
                    Dim valor8 As String = ""
                    Dim valor9 As String = ""
                    Dim valor10 As String = ""
                    Dim dato14 As String = ""

                    Dim valor_referencia_campo_9 As String = drPoliza("referencia")

                    valor1 = "E"


                    tableSAP.Rows.Add(i, valor1, "", Convert.ToDateTime(drPoliza("fecha_documento")).ToString("dd.MM.yyyy"),
                                       "SA", drPoliza("sociedad"),
                                       Convert.ToDateTime(drPoliza("fecha_documento")).ToString("dd.MM.yyyy"),
                                       Convert.ToDateTime(drPoliza("fecha_documento")).ToString("MM"), "MXP",
                                       Left(drPoliza("referencia"), 16),
                                       Left(valor_referencia_campo_9, 25),
                                       Convert.ToDecimal(Math.Abs(drPoliza("total"))).ToString("0.00"),
                                       Left(drPoliza("deudor"), 10),
                                       Left(drPoliza("referencia"), 18), "")


                    Dim rows() As DataRow = dtPolizaDetalle.Select("id_solicitud=" & drPoliza("id_solicitud"))
                    For Each drDetalle As DataRow In rows
                        i += 1


                        dato14 = ""
                        'If tipo = "CC" Then

                        'ElseIf tipo = "OI" Then

                        'ElseIf tipo = "PP" Then
                        '    If drDetalle("proyecto") <> "" Then
                        '        dato14 = drDetalle("proyecto") + "-" + drDetalle("no_necesidad")
                        '    End If
                        'End If
                        dato14 = drDetalle("proyecto")

                        If tipo = "CC" Then
                            valor8 = ""
                            valor9 = Left(drDetalle("proyecto"), 12)
                            valor10 = ""
                        ElseIf tipo = "OI" Then
                            valor8 = Left(drDetalle("proyecto"), 12)
                            valor9 = ""
                            valor10 = ""
                        ElseIf tipo = "PP" Then
                            valor8 = ""
                            valor9 = ""
                            valor10 = Left(drDetalle("proyecto"), 12)
                        ElseIf tipo = "RF" Then
                            valor8 = ""
                            valor9 = ""
                            valor10 = ""
                        End If

                        tableSAP.Rows.Add(i,
                                          "01",
                                          "",
                                          Left(drDetalle("cuenta"), 17),
                                          Convert.ToDecimal(Math.Abs(drDetalle("importe_sin_iva"))).ToString("0.00"),
                                          drDetalle("clave_iva"),
                                          "X",
                                          Left(drPoliza("referencia"), 18),
                                          Left(drDetalle("asignacion").Replace(vbCr, "").Replace(vbLf, ""), 50),
                                          valor8,
                                          valor9,
                                          valor10,
                                          "",
                                          "",
                                          dato14)

                    Next

                    sbResultados.Append("<br/>" & drPoliza("referencia") & ": Respuesta SAP = ")
                    Try
                        Dim sap As New ConsultasSAP
                        Dim polizaSAPResult As PolizaSapResult = sap.EnviarPolizaSAP(tableSAP)
                        Dim resultadoSAP As String = polizaSAPResult.respuesta

                        seguridad.GuardaLogDatos("SAPLog: REF=" & drPoliza("referencia") & " -- " & polizaSAPResult.sap_log)

                        If Left(resultadoSAP, 3) = "000" Then
                            polizaObj.RecuperaEnviadaOK(drPoliza("referencia"), HttpContext.Current.Session("idEmpleado"), poliza)
                        End If
                        sbResultados.Append(resultadoSAP)
                    Catch ex As Exception
                        sbResultados.Append(ex.Message)
                    End Try



                Else
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
                    '' POLIZAS RG Y SV
                    ''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

                    Dim valor1 As String = ""
                    Dim valor8 As String = ""
                    Dim valor9 As String = ""
                    Dim valor10 As String = ""
                    Dim dato14 As String = ""

                    Dim valor_referencia_campo_9 As String = drPoliza("referencia")

                    If tipo = "CC" Then
                        valor1 = "B"
                    ElseIf tipo = "OI" Then
                        valor1 = "C"
                    ElseIf tipo = "PP" Then
                        valor1 = "C"
                    ElseIf tipo = "RF" Then
                        valor1 = "C"
                        valor_referencia_campo_9 = drPoliza("notas")
                    End If



                    'If drPoliza("tiene_hijos") = 0 Then
                    'NO TIENE HIJOS, SE ENVIA NORMAL
                    tableSAP.Rows.Add(i, valor1, "", Convert.ToDateTime(drPoliza("fecha_documento")).ToString("dd.MM.yyyy"),
                                   "SA", drPoliza("sociedad"),
                                   Convert.ToDateTime(drPoliza("fecha_documento")).ToString("dd.MM.yyyy"),
                                   Convert.ToDateTime(drPoliza("fecha_documento")).ToString("MM"), "MXP",
                                   Left(drPoliza("referencia"), 16),
                                   Left(valor_referencia_campo_9, 25),
                                   Convert.ToDecimal(Math.Abs(drPoliza("total"))).ToString("0.00"),
                                   Left(drPoliza("deudor"), 10),
                                   Left(drPoliza("referencia"), 18), "")
                    '    Else
                    '    'SI TIENE HIJOS, SE ENVIA NORMAL
                    '    For Each drPolizaHijo As DataRow In dtPolizaHijos.Select("id_solicitud=" & drPoliza("id_solicitud"))
                    '        tableSAP.Rows.Add(i, IIf(drPolizaHijo("id_empleado") > 0, valor1, "31"), "", Convert.ToDateTime(drPolizaHijo("fecha_documento")).ToString("dd.MM.yyyy"),
                    '                       "SA", drPolizaHijo("sociedad"),
                    '                       Convert.ToDateTime(drPolizaHijo("fecha_documento")).ToString("dd.MM.yyyy"),
                    '                       Convert.ToDateTime(drPolizaHijo("fecha_documento")).ToString("MM"), "MXP",
                    '                       Left(drPolizaHijo("referencia"), 16),
                    '                       Left(valor_referencia_campo_9, 25),
                    '                       Convert.ToDecimal(Math.Abs(drPolizaHijo("total"))).ToString("0.00"),
                    '                       Left(drPolizaHijo("deudor"), 10),
                    '                       Left(drPolizaHijo("referencia"), 18), "")
                    '    Next
                    'End If


                    Dim rows() As DataRow = dtPolizaDetalle.Select("id_solicitud=" & drPoliza("id_solicitud"))
                    For Each drDetalle As DataRow In rows
                        i += 1


                        dato14 = ""
                        If tipo = "CC" Then

                        ElseIf tipo = "OI" Then

                        ElseIf tipo = "PP" Then
                            If drDetalle("proyecto") <> "" Then
                                dato14 = drDetalle("proyecto") + "-" + drDetalle("no_necesidad")
                            End If
                        End If

                        If tipo = "CC" Then
                            valor8 = ""
                            valor9 = Left(drDetalle("proyecto"), 12)
                            valor10 = ""
                        ElseIf tipo = "OI" Then
                            valor8 = Left(drDetalle("proyecto"), 12)
                            valor9 = ""
                            valor10 = ""
                        ElseIf tipo = "PP" Then
                            valor8 = ""
                            valor9 = ""
                            valor10 = Left(drDetalle("proyecto"), 12)
                        ElseIf tipo = "RF" Then
                            valor8 = ""
                            valor9 = ""
                            valor10 = ""
                        End If

                        tableSAP.Rows.Add(i,
                                          "40",
                                          "",
                                          Left(drDetalle("cuenta"), 17),
                                          Convert.ToDecimal(Math.Abs(drDetalle("importe_sin_iva"))).ToString("0.00"),
                                          drDetalle("clave_iva"),
                                          "X",
                                          Left(drPoliza("referencia"), 18),
                                          Left(drDetalle("asignacion").Replace(vbCr, "").Replace(vbLf, ""), 50),
                                          valor8,
                                          valor9,
                                          valor10,
                                          "",
                                          "",
                                          dato14)

                    Next

                    'Fin de la poliza
                    'i += 1
                    'tableSAP.Rows.Add(i,
                    '                      "99",
                    '                      "",
                    '                      "",
                    '                      "0.00",
                    '                      "",
                    '                      "X",
                    '                      Left(drPoliza("referencia"), 18),
                    '                      "",
                    '                      "",
                    '                      "",
                    '                      "",
                    '                      "",
                    '                      "",
                    '                      "")

                    sbResultados.Append("<br/>" & drPoliza("referencia") & ": Respuesta SAP = ")
                    Try
                        Dim sap As New ConsultasSAP
                        Dim polizaSAPResult As PolizaSapResult = sap.EnviarPolizaSAP(tableSAP)
                        Dim resultadoSAP As String = polizaSAPResult.respuesta

                        seguridad.GuardaLogDatos("SAPLog: REF=" & drPoliza("referencia") & " -- " & polizaSAPResult.sap_log)

                        If Left(resultadoSAP, 3) = "000" Then
                            polizaObj.RecuperaEnviadaOK(drPoliza("referencia"), HttpContext.Current.Session("idEmpleado"), poliza)
                        End If
                        sbResultados.Append(resultadoSAP)
                    Catch ex As Exception
                        sbResultados.Append(ex.Message)
                    End Try
                End If



            Next

            Return sbResultados.ToString()

        Catch ex As Exception
            Return ex.Message
        End Try



    End Function


    <WebMethod>
    Public Shared Function GuardaPolizaEncabezado(ByVal id As Integer, fecha_documento As String, sociedad As String, deudor As String,
                                                  referencia As String, asignacion As String, total As String, id_usuario As Integer) As String

        Dim poliza As New PolizaContable(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        poliza.GuardaPolizaContable(id, fecha_documento, sociedad, deudor, referencia, asignacion, total, id_usuario)

        Return ""
    End Function

    <WebMethod>
    Public Shared Function GuardaPolizaDetalle(ByVal id As Integer, cuenta As String, sociedad As String, clave_iva As String,
                                               proyecto As String, asignacion As String, importe_sin_iva As String,
                                               no_necesidad As String, descripcion As String, id_usuario As Integer) As String

        Dim poliza As New PolizaContable(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())
        poliza.GuardaPolizaContableDetalle(id, cuenta, sociedad, clave_iva, proyecto, asignacion, importe_sin_iva, no_necesidad, descripcion, id_usuario)

        Return ""
    End Function

    Private Function RemueveEnters(texto As String) As String
        Return texto.Replace(vbCr, "").Replace(vbLf, "")
    End Function


    Private Sub btnExportarPoliza_Click(sender As Object, e As EventArgs) Handles btnExportarPoliza.Click
        'Try
        '    ValidaSeleccionReporte()



        '    Dim sbTexto As New StringBuilder("")
        '    Dim poliza As New PolizaContable(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        '    Dim ds As DataSet = poliza.Recupera(Me.ddlPoliza.SelectedValue, Me.ddlEmpresa.SelectedValue, Me.dtFechaIni.SelectedDate.Value.ToString("yyyyMMdd"), Me.dtFechaFin.SelectedDate.Value.ToString("yyyyMMdd"), 1, Session("idEmpleado"), Me.ddlTipoConcepto.SelectedValue, Me.ddlEstatus.SelectedValue)
        '    Dim dtPoliza As DataTable = ds.Tables(0)
        '    Dim dtPolizaDetalle As DataTable = ds.Tables(1)

        '    For Each drPoliza As DataRow In dtPoliza.Rows

        '        If Me.ddlPoliza.SelectedValue = "RG" Then
        '            sbTexto.Append("A" & vbTab)
        '        ElseIf Me.ddlPoliza.SelectedValue = "SV" And Me.ddlTipoConcepto.SelectedValue = "CC" Then
        '            sbTexto.Append("B" & vbTab)
        '        ElseIf Me.ddlPoliza.SelectedValue = "SV" And Me.ddlTipoConcepto.SelectedValue = "OI" Then
        '            sbTexto.Append("C" & vbTab)
        '        ElseIf Me.ddlPoliza.SelectedValue = "SV" And Me.ddlTipoConcepto.SelectedValue = "PP" Then
        '            sbTexto.Append("C" & vbTab)
        '        End If

        '        sbTexto.Append(Convert.ToDateTime(drPoliza("fecha_documento")).ToString("dd.MM.yyyy") & vbTab)
        '        sbTexto.Append("SA" & vbTab)
        '        sbTexto.Append(drPoliza("sociedad") & vbTab)
        '        sbTexto.Append(Convert.ToDateTime(DateTime.Now).ToString("dd.MM.yyyy") & vbTab)
        '        sbTexto.Append(Convert.ToDateTime(DateTime.Now).ToString("MM") & vbTab)
        '        sbTexto.Append("MXP" & vbTab)
        '        sbTexto.Append(Left(drPoliza("referencia"), 16) & vbTab)
        '        sbTexto.Append(Left(drPoliza("referencia"), 25) & vbTab)            ' REUTILIZAR
        '        sbTexto.Append(Convert.ToDecimal(drPoliza("total")).ToString("0.00") & vbTab)
        '        sbTexto.Append(Left(drPoliza("deudor"), 10) & vbTab)
        '        sbTexto.AppendLine(Left(drPoliza("referencia"), 18) & vbTab)        ' REUTILIZAR

        '        Dim rows() As DataRow = dtPolizaDetalle.Select("id_solicitud=" & drPoliza("id_solicitud"))
        '        For Each drDetalle As DataRow In rows

        '            sbTexto.Append("40" & vbTab)
        '            sbTexto.Append(Left(drDetalle("cuenta"), 17) & vbTab)
        '            sbTexto.Append(Convert.ToDecimal(drDetalle("importe_sin_iva")).ToString("0.00") & vbTab)
        '            sbTexto.Append(drDetalle("clave_iva") & vbTab)
        '            sbTexto.Append("X" & vbTab)
        '            sbTexto.Append(Left(drPoliza("referencia"), 18) & vbTab)
        '            sbTexto.Append(Left(RemueveEnters(drDetalle("descripcion")), 50) & vbTab)

        '            'sbTexto.Append(drDetalle("sociedad") & vbTab)
        '            'sbTexto.Append(drDetalle("proyecto") & vbTab)
        '            'sbTexto.Append(drDetalle("asignacion") & vbTab)
        '            'sbTexto.Append(drDetalle("no_necesidad") & vbTab)
        '            'sbTexto.AppendLine(drDetalle("descripcion") & vbTab)


        '            If Me.ddlPoliza.SelectedValue = "RG" Then
        '                sbTexto.Append(vbTab)
        '                sbTexto.Append(Left(drDetalle("proyecto"), 12) & vbTab)
        '                sbTexto.AppendLine(vbTab)
        '            ElseIf Me.ddlTipoConcepto.SelectedValue = "CC" Then
        '                sbTexto.Append(vbTab)
        '                sbTexto.Append(Left(drDetalle("proyecto"), 12) & vbTab)
        '                sbTexto.AppendLine(vbTab)
        '            ElseIf Me.ddlTipoConcepto.SelectedValue = "OI" Then
        '                sbTexto.Append(Left(drDetalle("proyecto"), 10) & vbTab)
        '                sbTexto.Append(vbTab)
        '                sbTexto.AppendLine(vbTab)
        '            ElseIf Me.ddlTipoConcepto.SelectedValue = "PP" Then
        '                sbTexto.Append(vbTab)
        '                sbTexto.Append(vbTab)
        '                sbTexto.AppendLine(Left(drDetalle("proyecto"), 12) & vbTab)
        '            End If
        '        Next
        '    Next

        '    Response.Clear()
        '    Response.AddHeader("Content-disposition", "attachment; filename=Poliza_" & Me.ddlEmpresa.SelectedValue & "_" & Me.ddlPoliza.SelectedValue & "_" & Me.ddlTipoConcepto.SelectedValue & ".txt")
        '    Response.ContentType = "application/octet-stream"
        '    Response.Write(sbTexto.ToString())
        '    Response.End()

        'Catch ex As Exception
        '    ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        'End Try




    End Sub

    Protected Sub ddlEmpresa_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlEmpresa.SelectedIndexChanged
        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        Me.ddlEmpleado.Items.Clear()
        Me.ddlEmpleado.DataSource = Nothing
        Me.ddlEmpleado.DataBind()

        If Me.ddlEmpresa.SelectedValue <> "0" Then

            Me.ddlEmpleado.Items.AddRange(Funciones.DatatableToList(combos.RecuperaEmpleados(Me.ddlEmpresa.SelectedValue, ""), "nombre", "id_empleado"))
            Me.ddlEmpleado.SelectedValue = 0

        End If
    End Sub

    Protected Sub btnDescargarPoliza_Click(sender As Object, e As EventArgs) Handles btnDescargarPoliza.Click
        Try
            Dim sbResultados As New StringBuilder("")
            Dim sbError As New StringBuilder("")
            Dim poliza As New PolizaContable(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            Dim sap As New ConsultasSAP
            Dim dtPolizas As DataTable = sap.RecuperaPolizasContablesACorregir()

            If Not dtPolizas Is Nothing Then
                For Each dRow As DataRow In dtPolizas.Rows
                    Dim resultado As String = poliza.CorregirPolizaContableSap(dRow("CAMPO13").ToString(), Session("idEmpleado"))

                    If resultado.StartsWith("Error:") Then
                        sbError.Append(dRow("CAMPO13").ToString() & ", ")
                    Else
                        If resultado = "Ok" Then
                            sbResultados.Append(dRow("CAMPO13").ToString() & ", ")
                        End If

                    End If
                Next
            End If

            If ValidaOpcionesPantalla() = True Then
                MuestraPoliza(True)
            End If

            If sbError.Length > 0 Then
                If sbResultados.Length > 0 Then
                    Throw New Exception(TranslateLocale.text("No se encontraron las siguientes pólizas en el sistema") & ":\n" &
                                            sbError.ToString().Substring(0, sbError.ToString().Length - 2) &
                                            "\n\n" & TranslateLocale.text("Las siguientes pólizas fueron desbloqueadas para edición") & ":\n" &
                                            sbResultados.ToString().Substring(0, sbResultados.ToString().Length - 2))
                Else
                    Throw New Exception(TranslateLocale.text("No se encontraron las siguientes polizas en el sistema") & ":\n" & sbError.ToString().Substring(0, sbError.ToString().Length - 2))
                End If
            Else

                If sbResultados.Length > 0 Then
                    ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & (TranslateLocale.text("Las siguientes pólizas fueron desbloqueadas para edición") & ":\n" & sbResultados.ToString().Substring(0, sbResultados.ToString().Length - 2)).Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
                Else
                    ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & (TranslateLocale.text("No se encontraron pólizas a desbloquear")).Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
                End If

            End If

        Catch ex As SAP.Middleware.Connector.RfcCommunicationException
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Error al conectar a SAP');</script>", False)
        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "").Replace(vbCr, " ").Replace(vbCrLf, " ") & "');</script>", False)
        End Try
    End Sub

    Private Function ValidaOpcionesPantalla() As Boolean
        Dim msg As String = ""

        If Me.ddlPoliza.SelectedValue = "" Then msg &= " - " & TranslateLocale.text("Tipo de Póliza") & "\n"
        If Me.ddlPoliza.SelectedValue <> "SVA" And Me.ddlPoliza.SelectedValue <> "SVD" Then
            If Me.ddlTipoConcepto.SelectedValue = "" Then msg &= " - " & TranslateLocale.text("Tipo de Concepto") & "\n"
        End If

        If Me.ddlEmpresa.SelectedValue = 0 Then msg &= " - " & TranslateLocale.text("Empresa") & "\n"

        If msg.Length > 0 Then
            Return False
        Else
            Return True
        End If

    End Function

    Private Sub ddlPoliza_SelectedIndexChanged(sender As Object, e As EventArgs) Handles ddlPoliza.SelectedIndexChanged
        If ddlPoliza.SelectedValue = "SVA" Or ddlPoliza.SelectedValue = "SVD" Then
            campoTipoConcepto.Visible = False
        Else
            campoTipoConcepto.Visible = True
        End If
    End Sub
End Class

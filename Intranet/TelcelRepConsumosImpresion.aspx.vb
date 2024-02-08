Imports IntranetBL
Imports KrishLabs.Web.Controls

Public Class TelcelRepConsumosImpresion
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then

            Dim anio As String = Request.QueryString("anio")
            Dim mes As String = Request.QueryString("mes")
            Dim id_empresa As String = Request.QueryString("id_empresa")
            Dim id_empleado As String = Request.QueryString("id_empleado")
            Dim id_proveedor As String = Request.QueryString("id_proveedor")

            If Not id_empresa Is Nothing And
                Not id_empleado Is Nothing Then

                Dim telcel As New Telcel(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
                Me.gvReporte.DataSource = telcel.RepTelcelConsumos(anio, mes, id_empresa, id_empleado, Session("idEmpleado"), id_proveedor)
                Me.gvReporte.DataBind()

            End If
        End If
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

#Region "TOTALES"
    Dim renta As Decimal = 0
    Dim serv_adicionales As Decimal = 0
    Dim ta_importe As Decimal = 0
    Dim ta_min_libres_pico As Decimal = 0
    Dim ta_min_factur_pico As Decimal = 0
    Dim ta_min_libres_nopico As Decimal = 0
    Dim ta_min_factur_nopico As Decimal = 0
    Dim ta_min_tot As Decimal = 0
    Dim ld_total As Decimal = 0
    Dim ldn_importe As Decimal = 0
    Dim ldn_libres As Decimal = 0
    Dim ldn_factur As Decimal = 0
    Dim ldn_min_tot As Decimal = 0
    Dim ldi_importe As Decimal = 0
    Dim ldi_libres As Decimal = 0
    Dim ldi_factur As Decimal = 0
    Dim ldi_min_tot As Decimal = 0
    Dim ldm_importe As Decimal = 0
    Dim ldm_libres As Decimal = 0
    Dim ldm_factur As Decimal = 0
    Dim ldm_min_tot As Decimal = 0
    Dim tarn_importe As Decimal = 0
    Dim tarn_libres As Decimal = 0
    Dim tarn_factur As Decimal = 0
    Dim tarn_min_tot As Decimal = 0
    Dim ldrn_importe As Decimal = 0
    Dim ldrn_libres As Decimal = 0
    Dim ldrn_factur As Decimal = 0
    Dim ldrn_min_tot As Decimal = 0
    Dim tari_importe As Decimal = 0
    Dim tari_libres As Decimal = 0
    Dim tari_factur As Decimal = 0
    Dim tari_min_tot As Decimal = 0
    Dim ldri_importe As Decimal = 0
    Dim ldri_libres As Decimal = 0
    Dim ldri_factur As Decimal = 0
    Dim ldri_min_tot As Decimal = 0
    Dim importe_siva As Decimal = 0
    Dim fianza As Decimal = 0
    Dim descuento_tar As Decimal = 0
    Dim renta_roaming As Decimal = 0
    Dim impuestos As Decimal = 0
    Dim cargos As Decimal = 0
    Dim min_totales As Decimal = 0
#End Region

    Private Sub gvReporte_RowDataBound(sender As Object, e As GridViewRowEventArgs) Handles gvReporte.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then



            renta += e.Row.Cells(12).Text
            serv_adicionales += e.Row.Cells(13).Text
            ta_importe += e.Row.Cells(14).Text
            ta_min_libres_pico += e.Row.Cells(15).Text
            ta_min_factur_pico += e.Row.Cells(16).Text
            ta_min_libres_nopico += e.Row.Cells(17).Text
            ta_min_factur_nopico += e.Row.Cells(18).Text
            ta_min_tot += e.Row.Cells(19).Text
            ld_total += e.Row.Cells(20).Text
            ldn_importe += e.Row.Cells(21).Text
            ldn_libres += e.Row.Cells(22).Text
            ldn_factur += e.Row.Cells(23).Text
            ldn_min_tot += e.Row.Cells(24).Text
            ldi_importe += e.Row.Cells(25).Text
            ldi_libres += e.Row.Cells(26).Text
            ldi_factur += e.Row.Cells(27).Text
            ldi_min_tot += e.Row.Cells(28).Text
            ldm_importe += e.Row.Cells(29).Text
            ldm_libres += e.Row.Cells(30).Text
            ldm_factur += e.Row.Cells(31).Text
            ldm_min_tot += e.Row.Cells(32).Text
            tarn_importe += e.Row.Cells(33).Text
            tarn_libres += e.Row.Cells(34).Text
            tarn_factur += e.Row.Cells(35).Text
            tarn_min_tot += e.Row.Cells(36).Text
            ldrn_importe += e.Row.Cells(37).Text
            ldrn_libres += e.Row.Cells(38).Text
            ldrn_factur += e.Row.Cells(39).Text
            ldrn_min_tot += e.Row.Cells(40).Text
            tari_importe += e.Row.Cells(41).Text
            tari_libres += e.Row.Cells(42).Text
            tari_factur += e.Row.Cells(43).Text
            tari_min_tot += e.Row.Cells(44).Text
            ldri_importe += e.Row.Cells(45).Text
            ldri_libres += e.Row.Cells(46).Text
            ldri_factur += e.Row.Cells(47).Text
            ldri_min_tot += e.Row.Cells(48).Text
            importe_siva += e.Row.Cells(49).Text
            fianza += e.Row.Cells(50).Text
            descuento_tar += e.Row.Cells(51).Text
            renta_roaming += e.Row.Cells(52).Text
            impuestos += e.Row.Cells(53).Text
            cargos += e.Row.Cells(54).Text
            min_totales += e.Row.Cells(55).Text

        ElseIf e.Row.RowType = DataControlRowType.Footer Then
            e.Row.Cells(12).Text = Format(renta, "#,###,##0")
            e.Row.Cells(13).Text = Format(serv_adicionales, "#,###,##0")
            e.Row.Cells(14).Text = Format(ta_importe, "#,###,##0")
            e.Row.Cells(15).Text = Format(ta_min_libres_pico, "#,###,##0")
            e.Row.Cells(16).Text = Format(ta_min_factur_pico, "#,###,##0")
            e.Row.Cells(17).Text = Format(ta_min_libres_nopico, "#,###,##0")
            e.Row.Cells(18).Text = Format(ta_min_factur_nopico, "#,###,##0")
            e.Row.Cells(19).Text = Format(ta_min_tot, "#,###,##0")
            e.Row.Cells(20).Text = Format(ld_total, "#,###,##0")
            e.Row.Cells(21).Text = Format(ldn_importe, "#,###,##0")
            e.Row.Cells(22).Text = Format(ldn_libres, "#,###,##0")
            e.Row.Cells(23).Text = Format(ldn_factur, "#,###,##0")
            e.Row.Cells(24).Text = Format(ldn_min_tot, "#,###,##0")
            e.Row.Cells(25).Text = Format(ldi_importe, "#,###,##0")
            e.Row.Cells(26).Text = Format(ldi_libres, "#,###,##0")
            e.Row.Cells(27).Text = Format(ldi_factur, "#,###,##0")
            e.Row.Cells(28).Text = Format(ldi_min_tot, "#,###,##0")
            e.Row.Cells(29).Text = Format(ldm_importe, "#,###,##0")
            e.Row.Cells(30).Text = Format(ldm_libres, "#,###,##0")
            e.Row.Cells(31).Text = Format(ldm_factur, "#,###,##0")
            e.Row.Cells(32).Text = Format(ldm_min_tot, "#,###,##0")
            e.Row.Cells(33).Text = Format(tarn_importe, "#,###,##0")
            e.Row.Cells(34).Text = Format(tarn_libres, "#,###,##0")
            e.Row.Cells(35).Text = Format(tarn_factur, "#,###,##0")
            e.Row.Cells(36).Text = Format(tarn_min_tot, "#,###,##0")
            e.Row.Cells(37).Text = Format(ldrn_importe, "#,###,##0")
            e.Row.Cells(38).Text = Format(ldrn_libres, "#,###,##0")
            e.Row.Cells(39).Text = Format(ldrn_factur, "#,###,##0")
            e.Row.Cells(40).Text = Format(ldrn_min_tot, "#,###,##0")
            e.Row.Cells(41).Text = Format(tari_importe, "#,###,##0")
            e.Row.Cells(42).Text = Format(tari_libres, "#,###,##0")
            e.Row.Cells(43).Text = Format(tari_factur, "#,###,##0")
            e.Row.Cells(44).Text = Format(tari_min_tot, "#,###,##0")
            e.Row.Cells(45).Text = Format(ldri_importe, "#,###,##0")
            e.Row.Cells(46).Text = Format(ldri_libres, "#,###,##0")
            e.Row.Cells(47).Text = Format(ldri_factur, "#,###,##0")
            e.Row.Cells(48).Text = Format(ldri_min_tot, "#,###,##0")
            e.Row.Cells(49).Text = Format(importe_siva, "#,###,##0")
            e.Row.Cells(50).Text = Format(fianza, "#,###,##0")
            e.Row.Cells(51).Text = Format(descuento_tar, "#,###,##0")
            e.Row.Cells(52).Text = Format(renta_roaming, "#,###,##0")
            e.Row.Cells(53).Text = Format(impuestos, "#,###,##0")
            e.Row.Cells(54).Text = Format(cargos, "#,###,##0")
            e.Row.Cells(55).Text = Format(min_totales, "#,###,##0")
        End If
    End Sub

    Protected Sub gvReporte_Sorting(sender As Object, e As GridViewSortEventArgs) Handles gvReporte.Sorting
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

            Dim anio As String = Request.QueryString("anio")
            Dim mes As String = Request.QueryString("mes")
            Dim id_empresa As String = Request.QueryString("id_empresa")
            Dim id_empleado As String = Request.QueryString("id_empleado")
            Dim id_proveedor As String = Request.QueryString("id_proveedor")

            Dim telcel As New Telcel(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = telcel.RepTelcelConsumos(anio, mes, id_empresa, id_empleado, Session("idEmpleado"), id_proveedor)
            Dim dv As New DataView(dt)
            dv.Sort = sortExpression & direction

            gvReporte.DataSource = dv
            gvReporte.DataBind()

        Catch ex As Exception
            ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('" & ex.Message.Replace(Chr(34), "").Replace(Chr(39), "") & "');</script>", False)
        End Try
    End Sub


    'Protected Function RecuperaDatosReporte() As DataSet
    '    Dim fec_ini As String = Request.QueryString("fec_ini")
    '    Dim fec_fin As String = Request.QueryString("fec_fin")
    '    Dim id_empresa As String = Request.QueryString("id_empresa")
    '    Dim id_estatus As String = Request.QueryString("id_estatus")
    '    Dim id_empleado As String = Request.QueryString("id_empleado")
    '    Dim cancelada As String = Request.QueryString("cancelada")

    '    If Not fec_ini Is Nothing And
    '        Not fec_fin Is Nothing And
    '        Not id_empresa Is Nothing And
    '        Not id_estatus Is Nothing And
    '        Not id_empleado Is Nothing Then

    '        Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
    '        Return reporte.ReporteSolicitudVacaciones(fec_ini, fec_fin, id_empresa, id_estatus, id_empleado, cancelada, Session("idEmpleado"))
    '    End If
    '    Return Nothing
    'End Function

    Protected Function ifNullEmptyFecha(valor As Object) As String
        If IsDBNull(valor) Then
            Return ""
        Else
            Return "<br />(" & Format(CType(valor, Date), "dd/MM/yyyy HH:mm") & ")"
        End If
    End Function

    Protected Function DefinicionParametros() As String
        Dim id_empresa As String = Request.QueryString("id_empresa")
        Dim id_empleado As String = Request.QueryString("id_empleado")
        Dim anio As String = Request.QueryString("anio")
        Dim mes As String = Request.QueryString("mes")

        Dim parametros As String = ""
        If Not id_empresa Is Nothing And
            Not id_empleado Is Nothing Then

            Dim reporte As New Reporte(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

            parametros += "A&ntilde;o: " & anio & ", "
            parametros += "Mes: " & NombrePeriodo(mes) & ", "
            parametros += "Empresa: " & IIf(id_empresa = "0", "Todas", reporte.RecuperaEmpresaNombre(id_empresa)) & ", "
            parametros += "Empleado: " & IIf(id_empleado = "", "Todos", reporte.RecuperaEmpleadoNombreTelefono(id_empleado))

        End If
        Return parametros
    End Function



    Protected Function NombrePeriodo(periodo As Integer) As String
        Dim nombre As String = ""

        If periodo = 1 Then
            nombre = "Enero"
        ElseIf periodo = 2 Then
            nombre = "Febrero"
        ElseIf periodo = 3 Then
            nombre = "Marzo"
        ElseIf periodo = 4 Then
            nombre = "Abril"
        ElseIf periodo = 5 Then
            nombre = "Mayo"
        ElseIf periodo = 6 Then
            nombre = "Junio"
        ElseIf periodo = 7 Then
            nombre = "Julio"
        ElseIf periodo = 8 Then
            nombre = "Agosto"
        ElseIf periodo = 9 Then
            nombre = "Septiembre"
        ElseIf periodo = 10 Then
            nombre = "Octubre"
        ElseIf periodo = 11 Then
            nombre = "Noviembre"
        ElseIf periodo = 12 Then
            nombre = "Diciembre"
        ElseIf periodo = 13 Then
            nombre = "Enero"
        ElseIf periodo = 0 Then
            nombre = "Diciembre"
        ElseIf periodo = -1 Then
            nombre = "Noviembre"
        ElseIf periodo = -2 Then
            nombre = "Octubre"
        ElseIf periodo = -3 Then
            nombre = "Septiembre"
        ElseIf periodo = -4 Then
            nombre = "Agosto"
        ElseIf periodo = -5 Then
            nombre = "Julio"
        ElseIf periodo = -6 Then
            nombre = "Junio"
        ElseIf periodo = -7 Then
            nombre = "Mayo"
        ElseIf periodo = -8 Then
            nombre = "Abril"
        ElseIf periodo = -9 Then
            nombre = "Marzo"
        ElseIf periodo = -10 Then
            nombre = "Febrero"
        ElseIf periodo = -11 Then
            nombre = "Enero"
        End If

        Return nombre
    End Function
End Class
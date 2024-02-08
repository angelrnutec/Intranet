Imports IntranetBL

Public Class TelcelPivote_csv
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Response.Clear()

        Dim fileName As String = String.Format("dataTelcel-{0}.csv", DateTime.Now.ToString("yyyy-MMM-dd-HHmmss"))

        Response.AddHeader("cache-control", "max-age=0,no-cache")
        Response.AddHeader("expires", "0")
        Response.AddHeader("expires", "Tue, 01 Jan 1980 1:00:00 GMT")
        Response.AddHeader("pragma", "no-cache")
        Response.ContentType = "text/csv"
        Response.AddHeader("content-disposition", "filename=" + fileName)


        'Dim id_empresa As Integer = Request.QueryString("e")
        Dim fecha_ini As DateTime = New DateTime(Request.QueryString("a"), 1, 1)
        Dim fecha_fin As DateTime = New DateTime(Request.QueryString("a"), 12, 31)

        Dim telcel As New Telcel(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dt As DataTable = telcel.RecuperaPivote(fecha_ini, fecha_fin)


        Response.Write(Chr(34) & "Mes" & Chr(34) & "," _
                        & Chr(34) & "Region" & Chr(34) & "," _
                        & Chr(34) & "Padre" & Chr(34) & "," _
                        & Chr(34) & "Cuenta" & Chr(34) & "," _
                        & Chr(34) & "Razon Social" & Chr(34) & "," _
                        & Chr(34) & "Empresa" & Chr(34) & "," _
                        & Chr(34) & "Empleado" & Chr(34) & "," _
                        & Chr(34) & "Telefono" & Chr(34) & "," _
                        & Chr(34) & "Fecha Fact" & Chr(34) & "," _
                        & Chr(34) & "Factura" & Chr(34) & "," _
                        & Chr(34) & "Plan" & Chr(34) & "," _
                        & Chr(34) & "Renta" & Chr(34) & "," _
                        & Chr(34) & "Serv Ad" & Chr(34) & "," _
                        & Chr(34) & "TA Importe" & Chr(34) & "," _
                        & Chr(34) & "TA Min Libr Pico" & Chr(34) & "," _
                        & Chr(34) & "TA Min Fact Pico" & Chr(34) & "," _
                        & Chr(34) & "TA Min Libr No Pico" & Chr(34) & "," _
                        & Chr(34) & "TA Min Fact No Pico" & Chr(34) & "," _
                        & Chr(34) & "TA Min Tot" & Chr(34) & "," _
                        & Chr(34) & "LD Total" & Chr(34) & "," _
                        & Chr(34) & "LDN Importe" & Chr(34) & "," _
                        & Chr(34) & "LDN Min Libres" & Chr(34) & "," _
                        & Chr(34) & "LDN Min Fact" & Chr(34) & "," _
                        & Chr(34) & "LDN Min Tot" & Chr(34) & "," _
                        & Chr(34) & "LDI Importe" & Chr(34) & "," _
                        & Chr(34) & "LDI Min Libres" & Chr(34) & "," _
                        & Chr(34) & "LDI Min Fact" & Chr(34) & "," _
                        & Chr(34) & "LDI Min Tot" & Chr(34) & "," _
                        & Chr(34) & "LDM Importe" & Chr(34) & "," _
                        & Chr(34) & "LDM Min Libres" & Chr(34) & "," _
                        & Chr(34) & "LDM Min Fact" & Chr(34) & "," _
                        & Chr(34) & "LDM Min Tot" & Chr(34) & "," _
                        & Chr(34) & "TARN Importe" & Chr(34) & "," _
                        & Chr(34) & "TARN Min Libres" & Chr(34) & "," _
                        & Chr(34) & "TARN Min Fact" & Chr(34) & "," _
                        & Chr(34) & "TARN Min Tot" & Chr(34) & "," _
                        & Chr(34) & "LDRN Importe" & Chr(34) & "," _
                        & Chr(34) & "LDRN Min Libres" & Chr(34) & "," _
                        & Chr(34) & "LDRN Min Fact" & Chr(34) & "," _
                        & Chr(34) & "LDRN Min Tot" & Chr(34) & "," _
                        & Chr(34) & "TARI Importe" & Chr(34) & "," _
                        & Chr(34) & "TARI Min Libres" & Chr(34) & "," _
                        & Chr(34) & "TARI Min Factur" & Chr(34) & "," _
                        & Chr(34) & "TARI Min Tot" & Chr(34) & "," _
                        & Chr(34) & "LDRI Importe" & Chr(34) & "," _
                        & Chr(34) & "LDRI Min Libres" & Chr(34) & "," _
                        & Chr(34) & "LDRI Min Fact" & Chr(34) & "," _
                        & Chr(34) & "LDRI Min Tot" & Chr(34) & "," _
                        & Chr(34) & "Importe SVA" & Chr(34) & "," _
                        & Chr(34) & "Fianza" & Chr(34) & "," _
                        & Chr(34) & "Descuento TAR" & Chr(34) & "," _
                        & Chr(34) & "Renta Roaming" & Chr(34) & "," _
                        & Chr(34) & "Impuestos" & Chr(34) & "," _
                        & Chr(34) & "Cargos" & Chr(34) & "," _
                        & Chr(34) & "Min Totales" & Chr(34) & vbCrLf)


        For Each dr As DataRow In dt.Rows
            Response.Write(Chr(34) & dr("mes") & Chr(34) & "," & _
                           Chr(34) & dr("region") & Chr(34) & "," & _
                           Chr(34) & dr("padre") & Chr(34) & "," & _
                           Chr(34) & dr("cuenta") & Chr(34) & "," & _
                           Chr(34) & dr("razon_social") & Chr(34) & "," & _
                           Chr(34) & dr("empresa") & Chr(34) & "," & _
                           Chr(34) & dr("empleado") & Chr(34) & "," & _
                           Chr(34) & dr("telefono") & Chr(34) & "," & _
                           Chr(34) & dr("fecha_factura") & Chr(34) & "," & _
                           Chr(34) & dr("factura") & Chr(34) & "," & _
                           Chr(34) & dr("nombre_plan") & Chr(34) & "," & _
                           dr("renta") & "," & _
                           dr("serv_adicionales") & "," & _
                           dr("ta_importe") & "," & _
                           dr("ta_min_libres_pico") & "," & _
                           dr("ta_min_factur_pico") & "," & _
                           dr("ta_min_libres_nopico") & "," & _
                           dr("ta_min_factur_nopico") & "," & _
                           dr("ta_min_tot") & "," & _
                           dr("ld_total") & "," & _
                           dr("ldn_importe") & "," & _
                           dr("ldn_libres") & "," & _
                           dr("ldn_factur") & "," & _
                           dr("ldn_min_tot") & "," & _
                           dr("ldi_importe") & "," & _
                           dr("ldi_libres") & "," & _
                           dr("ldi_factur") & "," & _
                           dr("ldi_min_tot") & "," & _
                           dr("ldm_importe") & "," & _
                           dr("ldm_libres") & "," & _
                           dr("ldm_factur") & "," & _
                           dr("ldm_min_tot") & "," & _
                           dr("tarn_importe") & "," & _
                           dr("tarn_libres") & "," & _
                           dr("tarn_factur") & "," & _
                           dr("tarn_min_tot") & "," & _
                           dr("ldrn_importe") & "," & _
                           dr("ldrn_libres") & "," & _
                           dr("ldrn_factur") & "," & _
                           dr("ldrn_min_tot") & "," & _
                           dr("tari_importe") & "," & _
                           dr("tari_libres") & "," & _
                           dr("tari_factur") & "," & _
                           dr("tari_min_tot") & "," & _
                           dr("ldri_importe") & "," & _
                           dr("ldri_libres") & "," & _
                           dr("ldri_factur") & "," & _
                           dr("ldri_min_tot") & "," & _
                           dr("importe_siva") & "," & _
                           dr("fianza") & "," & _
                           dr("descuento_tar") & "," & _
                           dr("renta_roaming") & "," & _
                           dr("impuestos") & "," & _
                           dr("cargos") & "," & _
                           dr("min_totales") & vbCrLf)
            '            Response.Write("Hilll,Daniella,Gringotts,676.4,841.7," & Chr(34) & "Sat, 25 May 2013 00:00:00 +0000" & Chr(34) & "," & Chr(34) & "Fri, 31 May 2013 00:00:00 +0000" & Chr(34) & ",Ponte Vedra,FL,32082" & vbCrLf)
        Next

        Response.End()
    End Sub

End Class
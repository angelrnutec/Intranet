Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class RepSolicitudGastos_csv
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Response.Clear()

        Dim fileName As String = String.Format("dataSolicitudGastos-{0}.csv", DateTime.Now.ToString("yyyy-MMM-dd-HHmmss"))

        Response.AddHeader("cache-control", "max-age=0,no-cache")
        Response.AddHeader("expires", "0")
        Response.AddHeader("expires", "Tue, 01 Jan 1980 1:00:00 GMT")
        Response.AddHeader("pragma", "no-cache")
        Response.ContentType = "text/csv"
        Response.AddHeader("content-disposition", "filename=" + fileName)


        Dim sol As New SolicitudGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dt As DataTable = sol.RepSolicitudGastosPivote(Request.QueryString("a"), Request.QueryString("m"), Request.QueryString("t"))


        Response.Write(Chr(34) & TranslateLocale.text("Empresa") & Chr(34) & "," _
                        & Chr(34) & TranslateLocale.text("Tipo") & Chr(34) & "," _
                        & Chr(34) & TranslateLocale.text("Folio") & Chr(34) & "," _
                        & Chr(34) & TranslateLocale.text("Nombre") & Chr(34) & "," _
                        & Chr(34) & TranslateLocale.text("Fecha Solicitud") & Chr(34) & "," _
                        & Chr(34) & TranslateLocale.text("Fecha Comprobante") & Chr(34) & "," _
                        & Chr(34) & TranslateLocale.text("Concepto") & Chr(34) & "," _
                        & Chr(34) & TranslateLocale.text("Total Pesos") & Chr(34) & "," _
                        & Chr(34) & TranslateLocale.text("Forma Pago") & Chr(34) & "," _
                        & Chr(34) & TranslateLocale.text("Orden Interna") & Chr(34) & "," _
                        & Chr(34) & TranslateLocale.text("Necesidad") & Chr(34) & "," _
                        & Chr(34) & TranslateLocale.text("Centro Costo") & Chr(34) & "," _
                        & Chr(34) & TranslateLocale.text("Cuenta Contable") & Chr(34) & "," _
                        & Chr(34) & TranslateLocale.text("Mes") & Chr(34) & "," _
                        & Chr(34) & TranslateLocale.text("Clave IVA") & Chr(34) & "," _
                        & Chr(34) & TranslateLocale.text("Tipo Monto") & Chr(34) & vbCrLf)


        For Each dr As DataRow In dt.Rows
            Response.Write(Chr(34) & dr("empresa") & Chr(34) & "," & _
                           Chr(34) & dr("tipo") & Chr(34) & "," & _
                           Chr(34) & dr("folio_txt") & Chr(34) & "," & _
                           Chr(34) & dr("nombre") & Chr(34) & "," & _
                           Chr(34) & dr("fecha_registro") & Chr(34) & "," & _
                           Chr(34) & dr("fecha_comprobante") & Chr(34) & "," & _
                           Chr(34) & dr("concepto") & Chr(34) & "," & _
                           dr("total_pesos") & "," & _
                           Chr(34) & dr("forma_pago") & Chr(34) & "," & _
                           Chr(34) & dr("orden_interna") & Chr(34) & "," & _
                           Chr(34) & dr("necesidad") & Chr(34) & "," & _
                           Chr(34) & dr("centro_costo") & Chr(34) & "," & _
                           Chr(34) & dr("cuenta_contable") & Chr(34) & "," & _
                           Chr(34) & dr("mes") & Chr(34) & "," & _
                           Chr(34) & dr("clave_iva") & Chr(34) & "," & _
                           Chr(34) & dr("tipo_monto") & Chr(34) & vbCrLf)
        Next

        Response.End()
    End Sub

End Class
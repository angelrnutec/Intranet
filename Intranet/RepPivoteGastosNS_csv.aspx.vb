Imports IntranetBL

Public Class RepPivoteGastosNS_csv
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Response.Clear()

        Dim fileName As String = String.Format("data-{0}.csv", DateTime.Now.ToString("yyyy-MMM-dd-HHmmss"))

        Response.AddHeader("cache-control", "max-age=0,no-cache")
        Response.AddHeader("expires", "0")
        Response.AddHeader("expires", "Tue, 01 Jan 1980 1:00:00 GMT")
        Response.AddHeader("pragma", "no-cache")
        Response.ContentType = "text/csv"
        Response.AddHeader("content-disposition", "filename=" + fileName)


        Dim id_empresa As Integer = Request.QueryString("e")
        Dim mon As String = Request.QueryString("mon")
        Dim fecha_ini As DateTime = New DateTime(Request.QueryString("a"), 1, 1)
        Dim fecha_fin As DateTime = New DateTime(Request.QueryString("a"), 12, 31)

        Dim gastosNS As New GastosNS(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dt As DataTable = gastosNS.RecuperaGastos(id_empresa, fecha_ini, fecha_fin, mon, Session("idEmpleado"))


        Response.Write(Chr(34) & "Empresa" & Chr(34) & "," _
                       & Chr(34) & "Categoria" & Chr(34) & "," _
                       & Chr(34) & "Mes" & Chr(34) & "," _
                       & Chr(34) & "Fecha" & Chr(34) & "," _
                       & Chr(34) & "Clasificacion" & Chr(34) & "," _
                       & Chr(34) & "Total" & Chr(34) & "," _
                       & Chr(34) & "Centro de Costo" & Chr(34) & "," _
                       & Chr(34) & "Tipo de Costo" & Chr(34) & "," _
                       & Chr(34) & "Cuenta" & Chr(34) & "," _
                       & Chr(34) & "Denom Cuenta" & Chr(34) & "," _
                       & Chr(34) & "Num Documento" & Chr(34) & "," _
                       & Chr(34) & "Texto Cabecera" & Chr(34) & "," _
                       & Chr(34) & "Denominacion" & Chr(34) & "," _
                       & Chr(34) & "01-Ene" & Chr(34) & "," _
                       & Chr(34) & "02-Feb" & Chr(34) & "," _
                       & Chr(34) & "03-Mar" & Chr(34) & "," _
                       & Chr(34) & "04-Abr" & Chr(34) & "," _
                       & Chr(34) & "05-May" & Chr(34) & "," _
                       & Chr(34) & "06-Jun" & Chr(34) & "," _
                       & Chr(34) & "07-Jul" & Chr(34) & "," _
                       & Chr(34) & "08-Ago" & Chr(34) & "," _
                       & Chr(34) & "09-Sep" & Chr(34) & "," _
                       & Chr(34) & "10-Oct" & Chr(34) & "," _
                       & Chr(34) & "11-Nov" & Chr(34) & "," _
                       & Chr(34) & "12-Dic" & Chr(34) & vbCrLf)


        For Each dr As DataRow In dt.Rows
            Response.Write(Chr(34) & dr("empresa") & Chr(34) & "," & _
                           Chr(34) & dr("descripcion") & Chr(34) & "," & _
                           Chr(34) & dr("periodo") & Chr(34) & "," & _
                           Chr(34) & dr("fecha") & Chr(34) & "," & _
                           Chr(34) & dr("clasificacion") & Chr(34) & "," & _
                           dr("monto") & "," & _
                           Chr(34) & dr("centro_costo_desc") & Chr(34) & "," & _
                           Chr(34) & dr("tipo_costo") & Chr(34) & "," & _
                           Chr(34) & dr("cta_comp") & Chr(34) & "," & _
                           Chr(34) & dr("denom_cta_comp") & Chr(34) & "," & _
                           Chr(34) & dr("num_documento") & Chr(34) & "," & _
                           Chr(34) & dr("texto_cabecera") & Chr(34) & "," & _
                           Chr(34) & dr("denominacion") & Chr(34) & "," & _
                           dr("mes_01") & "," & _
                           dr("mes_02") & "," & _
                           dr("mes_03") & "," & _
                           dr("mes_04") & "," & _
                           dr("mes_05") & "," & _
                           dr("mes_06") & "," & _
                           dr("mes_07") & "," & _
                           dr("mes_08") & "," & _
                           dr("mes_09") & "," & _
                           dr("mes_10") & "," & _
                           dr("mes_11") & "," & _
                           dr("mes_12") & vbCrLf)
            '            Response.Write("Hilll,Daniella,Gringotts,676.4,841.7," & Chr(34) & "Sat, 25 May 2013 00:00:00 +0000" & Chr(34) & "," & Chr(34) & "Fri, 31 May 2013 00:00:00 +0000" & Chr(34) & ",Ponte Vedra,FL,32082" & vbCrLf)
        Next

        Response.End()
    End Sub

End Class
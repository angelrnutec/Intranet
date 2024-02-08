Imports IntranetBL
Imports Intranet.LocalizationIntranet
Imports System.Web.Script.Serialization

Public Class ArrendamientoCalendarioConsulta
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If

        If Not Page.IsPostBack Then


            Dim arrendamiento As New Arrendamiento(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = arrendamiento.RecuperaArrendamientosCalendario(Session("idEmpleado"), Request.Form("start"), Request.Form("end"))


            Dim myArray(dt.Rows.Count - 1) As EventosCalendario
            Dim i As Integer = 0
            For Each dr As DataRow In dt.Rows
                myArray(i) = New EventosCalendario("$ " & Convert.ToDecimal(dr("importe")).ToString("##,###,##0.00") & " " & dr("id_moneda") & " (" & dr("empresa") & ") - " & dr("arrendadora"),
                                                  Convert.ToDateTime(dr("fecha_pago")).ToString("yyyy-MM-dd") & " 12:00",
                                                  Convert.ToDateTime(dr("fecha_pago")).ToString("yyyy-MM-dd") & " 16:00")
                i += 1
            Next
            'myArray(0) = New EventosCalendario("Rigo 1", "2015-11-06 00:00", "2015-11-06 04:00")
            'myArray(1) = New EventosCalendario("Rigo 2", "2015-11-07 00:00", "2015-11-07 04:00")
            'myArray(2) = New EventosCalendario("Rigo 3", "2015-11-08 00:00", "2015-11-08 04:00")

            Dim serializer As New JavaScriptSerializer()
            Dim arrayJson As String = serializer.Serialize(myArray)


            Response.Clear()
            Response.Write(arrayJson)
            Response.End()

        End If

    End Sub


End Class

'[{"title":"Rigo Martinez > Lupita > (Corte de Pelo Caballero)","start":"2015-11-06 13:30","end":"2015-11-06 14:00","className":"bg-agenda1","cita_id":"86","startEditable":"1"},{"title":"Curso de nuevos productos","start":"2015-11-05 16:00","end":"2015-11-05 19:00","className":"bg-default","cita_id":"88","startEditable":"1"}]

Public Class EventosCalendario
    Public title As String
    Public start As String
    Public [end] As String

    Sub New(_title As String, _start As String, _end As String)
        title = _title
        start = _start
        [end] = _end
    End Sub
End Class

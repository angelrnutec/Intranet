Imports IntranetBL

Public Class cargaCentroCostos
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim tipo As String = Request.QueryString("tipo")
        Dim id_empleado As Integer = Request.QueryString("id_empleado")

        Dim cc As New CentroCosto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        Dim dt As DataTable
        If tipo = "D" Then
            dt = cc.RecuperaCentrosCostoDisponibles(id_empleado)
        Else
            dt = cc.RecuperaCentrosCostoAsignados(id_empleado)
        End If

        Response.Clear()
        Response.ContentType = "application/json; charset=utf-8"
        Response.Write(GetJson(dt))
        Response.End()
    End Sub

    Private Function GetJson(ByVal dt As DataTable) As String

        Dim serializer As System.Web.Script.Serialization.JavaScriptSerializer = New System.Web.Script.Serialization.JavaScriptSerializer()
        Dim rows As New List(Of Dictionary(Of String, Object))
        Dim row As Dictionary(Of String, Object)

        For Each dr As DataRow In dt.Rows
            row = New Dictionary(Of String, Object)
            For Each col As DataColumn In dt.Columns
                row.Add(col.ColumnName, dr(col))
            Next
            rows.Add(row)
        Next
        Return serializer.Serialize(rows)
    End Function

End Class
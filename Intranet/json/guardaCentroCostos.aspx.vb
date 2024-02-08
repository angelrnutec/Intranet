Imports IntranetBL

Public Class guardaCentroCostos
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim id_empleado As Integer = Request.Form("id_empleado")
        Dim centros As String = Request.Form("centros")

        Response.Clear()
        Try
            Dim cc As New CentroCosto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            cc.EliminaCentroCostoSeguridad(id_empleado)
            cc.GuardaCentroCostoSeguridad(id_empleado, centros)
            'Dim id_centro_costo As String() = centros.Split(",")

            'For Each id_centro In id_centro_costo
            '    If id_centro.Length > 0 Then
            '        cc.GuardaCentroCostoSeguridad(id_empleado, id_centro)
            '    End If
            'Next

            Response.Write("Datos guardados correctamente")
        Catch ex As Exception
            Response.Write(ex.Message)
        End Try
        Response.End()
    End Sub

End Class
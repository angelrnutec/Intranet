Imports IntranetBL

Public Class PolizaEditar
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Call CargaPoliza(Request.QueryString("poliza"), Request.QueryString("tipo_poliza"))
        End If
    End Sub

    Protected Sub CargaPoliza(poliza As String, tipo_poliza As String)

    End Sub

End Class
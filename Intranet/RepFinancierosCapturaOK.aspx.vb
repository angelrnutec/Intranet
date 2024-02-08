Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class RepFinancierosCapturaOK
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Page.IsPostBack Then
        End If

        Me.btnNuevo.Text = TranslateLocale.text(Me.btnNuevo.Text)

    End Sub

    Private Sub btnNuevo_Click(sender As Object, e As EventArgs) Handles btnNuevo.Click
        Response.Redirect("RepFinancierosCaptura.aspx")
    End Sub
End Class

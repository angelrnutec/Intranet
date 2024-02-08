Public Class _Default
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        If Not Request.QueryString("msg") Is Nothing Then
            If Request.QueryString("msg").Length > 0 Then
                ScriptManager.RegisterStartupScript(Me, Me.GetType, "script", "<script>alert('" & Request.QueryString("msg") & "');</script>", False)
            End If
        End If
    End Sub

End Class
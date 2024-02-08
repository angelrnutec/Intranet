Public Class CambiaIdioma
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load

        Dim cookieIdioma As HttpCookie = New HttpCookie("cookieIdioma")
        cookieIdioma.Value = Request.QueryString("i")
        cookieIdioma.Expires = DateTime.Now.AddDays(365)
        Response.Cookies.Add(cookieIdioma)

        Dim referencia As String = Request.UrlReferrer.ToString
        Response.Redirect(referencia)

    End Sub

End Class
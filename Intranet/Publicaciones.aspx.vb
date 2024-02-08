Public Class Publicaciones
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Session("idEmpleado") Is Nothing Then
            Response.Redirect("/Login.aspx?URL=" + Request.Url.PathAndQuery)
        End If
        Dim tipo As String = Request.QueryString("t")
        Dim categoria As String = Request.QueryString("c")

        If tipo Is Nothing Then
            Response.Redirect("/NoAutorizado.aspx")
        Else
            If tipo <> "Noticias" And _
                tipo <> "Eventos" And _
                tipo <> "Biblioteca" And _
                tipo <> "Vacantes" And _
                tipo <> "Avisos" Then
                Response.Redirect("/NoAutorizado.aspx")
            Else
                If tipo = "Noticias" Then
                    ucPublicacionesListado1.TipoPublicacion = 1
                ElseIf tipo = "Eventos" Then
                    ucPublicacionesListado1.TipoPublicacion = 2
                ElseIf tipo = "Biblioteca" Then
                    ucPublicacionesListado1.TipoPublicacion = 3
                ElseIf tipo = "Vacantes" Then
                    ucPublicacionesListado1.TipoPublicacion = 6
                ElseIf tipo = "Avisos" Then
                    ucPublicacionesListado1.TipoPublicacion = 7
                    ucPublicacionesListado1.Categoria = categoria
                End If
            End If
        End If
    End Sub

End Class
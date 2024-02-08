Imports System.IO

Public Class GuardaScreenshot
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        Dim dataurl = Request("image")
        Dim data = dataurl.Substring(dataurl.IndexOf(",") + 1)
        Dim newfile = Convert.FromBase64String(data)
        Dim layoutfilename = Guid.NewGuid().ToString() + "_screenshot.png"
        Dim dataFile = Server.MapPath("/uploads/" + layoutfilename)
        File.WriteAllBytes(dataFile, newfile)

        Response.Clear()
        Response.Write(layoutfilename)
        Response.End()
    End Sub

End Class
Imports IntranetBL
Imports System.Drawing.Drawing2D
Imports System.IO.Path
Imports System.Drawing.Imaging
Imports System.IO

Public Class PublicacionPortadaAgregar
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Request.QueryString("id") Is Nothing Then

            Dim savepath As String = ""
            Dim tempPath As String = ""
            tempPath = "/Uploads/"
            savepath = Context.Server.MapPath(tempPath)
            Dim filename As String = Request.QueryString("nombre")

            Try
                Dim imgOrig As Drawing.Image = RezizeImage(Drawing.Image.FromFile(savepath + filename), 90, 90)
                imgOrig.Save(savepath + "fotos/mini/" + Path.GetFileNameWithoutExtension(filename) & "." & ImageFormat.Png.ToString.ToLower(), System.Drawing.Imaging.ImageFormat.Png)
            Catch ex As Exception
            End Try


            Dim publicacion As New Publicacion(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            publicacion.AgregaDocumentoPortada(Request.QueryString("id"), Path.GetFileNameWithoutExtension(filename) & "." & ImageFormat.Png.ToString.ToLower())


            Response.Clear()
            Response.ExpiresAbsolute = DateTime.Now
            Response.Expires = -1441
            Response.CacheControl = "no-cache"
            Response.AddHeader("Pragma", "no-cache")
            Response.AddHeader("Pragma", "no-store")
            Response.AddHeader("cache-control", "no-cache")
            Response.Cache.SetCacheability(HttpCacheability.NoCache)
            Response.Cache.SetNoServerCaching()

            Response.Write("")
            Response.End()

        End If

    End Sub



    Private Function RezizeImage(img As Drawing.Image, maxWidth As Integer, maxHeight As Integer) As Drawing.Image
        If img.Height < maxHeight AndAlso img.Width < maxWidth Then
            Return img
        End If
        Using img
            Dim xRatio As [Double] = CDbl(img.Width) / maxWidth
            Dim yRatio As [Double] = CDbl(img.Height) / maxHeight
            Dim ratio As [Double] = Math.Max(xRatio, yRatio)
            Dim nnx As Integer = CInt(Math.Floor(img.Width / ratio))
            Dim nny As Integer = CInt(Math.Floor(img.Height / ratio))
            Dim cpy As New Drawing.Bitmap(nnx, nny, Drawing.Imaging.PixelFormat.Format32bppArgb)
            Using gr As Drawing.Graphics = Drawing.Graphics.FromImage(cpy)
                gr.Clear(Drawing.Color.Transparent)

                ' This is said to give best quality when resizing images
                gr.InterpolationMode = InterpolationMode.HighQualityBicubic

                gr.DrawImage(img, New Drawing.Rectangle(0, 0, nnx, nny), New Drawing.Rectangle(0, 0, img.Width, img.Height), Drawing.GraphicsUnit.Pixel)
            End Using
            Return cpy
        End Using

    End Function

    Private Function BytearrayToStream(arr As Byte()) As MemoryStream
        Return New MemoryStream(arr, 0, arr.Length)
    End Function


End Class
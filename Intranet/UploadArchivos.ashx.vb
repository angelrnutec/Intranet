Imports System.Web
Imports System.Web.Services
Imports System.IO
Imports IntranetBL
Imports System.Drawing.Drawing2D
Imports System.IO.Path
Imports System.Drawing.Imaging

Public Class UploadArchivos
    Implements System.Web.IHttpHandler

    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

        Try
            Dim tipo As String = ""
            Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())

            If context.Request.Files.Count = 0 Then
                context.Response.Write("Error=No files received.")
                context.Response.StatusCode = 200
            Else
                Dim postedFile As HttpPostedFile = context.Request.Files(0)

                Dim savepath As String = ""
                Dim tempPath As String = ""
                tempPath = "/Uploads/"

                savepath = context.Server.MapPath(tempPath)
                Dim filename As String = postedFile.FileName
                If Not Directory.Exists(savepath) Then
                    Directory.CreateDirectory(savepath)
                End If

                Dim filewithoutextension As String = Path.GetFileNameWithoutExtension(filename)
                filewithoutextension = filewithoutextension.Replace(" ", "")
                filewithoutextension = filewithoutextension.Replace(".", "")
                filewithoutextension = filewithoutextension.Replace("(", "")
                filewithoutextension = filewithoutextension.Replace(")", "")
                filewithoutextension = filewithoutextension.Replace("'", "")
                filewithoutextension = filewithoutextension.Replace("]", "")
                filewithoutextension = filewithoutextension.Replace("[", "")
                filewithoutextension = filewithoutextension.Replace("=", "")
                filewithoutextension = filewithoutextension.Replace("+", "")
                filewithoutextension = filewithoutextension.Replace("#", "")
                filewithoutextension = filewithoutextension.Replace("$", "")
                filewithoutextension = filewithoutextension.Replace("%", "")
                filewithoutextension = filewithoutextension.Replace("&", "")
                filewithoutextension = filewithoutextension.Replace("!", "")
                filewithoutextension = filewithoutextension.Replace("/", "")
                filewithoutextension = filewithoutextension.Replace("?", "")
                filewithoutextension = filewithoutextension.Replace("¡", "")
                filewithoutextension = filewithoutextension.Replace("¿", "")
                filewithoutextension = filewithoutextension.Replace("*", "")

                filename = filewithoutextension + "_" + DateTime.Now.ToString("MMddHHmmss") + Path.GetExtension(filename).ToLower()

                postedFile.SaveAs(savepath + filename)

                context.Response.Write(filename.ToLower())
                context.Response.StatusCode = 200
            End If




            'Dim tipo As String = ""
            'Dim empleado As New Empleado(System.Configuration.ConfigurationManager.AppSettings("CONEXION").ToString())

            'Dim postedFile As HttpPostedFile = context.Request.Files("Filedata")

            'Dim savepath As String = ""
            'Dim tempPath As String = ""
            'tempPath = "/Uploads/"

            'savepath = context.Server.MapPath(tempPath)
            'Dim filename As String = postedFile.FileName
            'If Not Directory.Exists(savepath) Then
            '    Directory.CreateDirectory(savepath)
            'End If

            'Dim filewithoutextension As String = Path.GetFileNameWithoutExtension(filename)
            'filewithoutextension = filewithoutextension.Replace(" ", "")
            'filewithoutextension = filewithoutextension.Replace(".", "")
            'filewithoutextension = filewithoutextension.Replace("(", "")
            'filewithoutextension = filewithoutextension.Replace(")", "")
            'filewithoutextension = filewithoutextension.Replace("'", "")
            'filewithoutextension = filewithoutextension.Replace("]", "")
            'filewithoutextension = filewithoutextension.Replace("[", "")
            'filewithoutextension = filewithoutextension.Replace("=", "")
            'filewithoutextension = filewithoutextension.Replace("+", "")
            'filewithoutextension = filewithoutextension.Replace("#", "")
            'filewithoutextension = filewithoutextension.Replace("$", "")
            'filewithoutextension = filewithoutextension.Replace("%", "")
            'filewithoutextension = filewithoutextension.Replace("&", "")
            'filewithoutextension = filewithoutextension.Replace("!", "")
            'filewithoutextension = filewithoutextension.Replace("/", "")
            'filewithoutextension = filewithoutextension.Replace("?", "")
            'filewithoutextension = filewithoutextension.Replace("¡", "")
            'filewithoutextension = filewithoutextension.Replace("¿", "")
            'filewithoutextension = filewithoutextension.Replace("*", "")

            'filename = filewithoutextension + "_" + DateTime.Now.ToString("MMddHHmmss") + Path.GetExtension(filename).ToLower()

            'postedFile.SaveAs(savepath + filename)

            'context.Response.Write(filename.ToLower())
            'context.Response.StatusCode = 200
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property



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

    Private Sub HandleImageUpload(binaryImage As Byte())
        Dim img As Drawing.Image = RezizeImage(Drawing.Image.FromStream(BytearrayToStream(binaryImage)), 103, 32)
        img.Save("IMAGELOCATION.png", System.Drawing.Imaging.ImageFormat.Gif)
    End Sub




End Class
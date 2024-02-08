Imports System.Web
Imports System.Web.Services
Imports System.IO
Imports IntranetBL
Imports System.Drawing.Drawing2D
Imports System.IO.Path
Imports System.Drawing.Imaging

Public Class UploadArrendamientos
    Implements System.Web.IHttpHandler

    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

        Try
            Dim tipo As String = ""

            Dim postedFile As HttpPostedFile = context.Request.Files(0)

            Dim savepath As String = ""
            Dim tempPath As String = ""
            tempPath = "/UploadsArrendamientos/"

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


            filename = filewithoutextension + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + Path.GetExtension(filename).ToLower()

            postedFile.SaveAs(savepath + filename)

            context.Response.Write(filename.ToLower())
            context.Response.StatusCode = 200
        Catch ex As Exception
            Throw ex
        End Try
    End Sub

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property






End Class
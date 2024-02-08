Imports System.IO
Imports System.Drawing.Drawing2D
Imports System.IO.Path
Imports System.Drawing.Imaging
Imports IntranetDA
Imports System.Net
Imports System.Security.Cryptography.X509Certificates

Module Module1


    Sub Main()

        Try
            Console.WriteLine("Inicio")

            'System.Net.ServicePointManager.CertificatePolicy = New MyPolicy()

            Dim request As New ServicioEdenred.CardGetListRequest()
            request.Security = New ServicioEdenred.SecurityDTO
            request.Security.ExternalClientId = "F29CAC08-9CDB-4558-92B7-7E751453D0C5"
            request.Security.Token = "FbMd6S54omhH9aYqJffqozc2PQ7tyFGLeSyXAvD6rnMf7aFRZEjpyFHvd0BHhU+NUB4/IJLv3icskODBwGWyNnG88KX2ComcjoUVZoHjGDzK05Z9OPsYEPOvrRuXvtSG"

            request.FilterSpecified = True
            request.Filter = ServicioEdenred.CardGetListFilter.ByCardNumber
            request.FilterValue = "5583060502540006"

            Dim cliente As New ServicioEdenred.BasicHttpBinding_ITEService
            cliente.Url = "https://services.edenred.com.mx/External/Service.svc"

            Dim respuesta As ServicioEdenred.CardGetListResponse = cliente.CardGetList(request)

            Console.WriteLine("Fin")
        Catch ex As Exception
            Console.WriteLine(ex.Message)
        End Try
        Console.ReadKey()

        'Try
        '    Dim dtPolizas As DataTable = GetTable()

        '    Dim sap As New ConsultasSAP
        '    sap.EnviarPolizaSAP(dtPolizas)
        '    'ProcesaDatos(2014, 3)

        '    Console.ReadKey()
        'Catch ex As Exception
        '    Console.WriteLine(ex.Message)
        '    Console.ReadKey()
        'End Try
    End Sub


    Private Sub ProcesaDatos(anio As Integer, periodo As Integer)


        'Dim fecha_ini As DateTime = New DateTime(anio, periodo, 1)
        'Dim fecha_fin As DateTime = fecha_ini.AddMonths(1).AddDays(-1)

        'Dim sap As New ConsultasSAP
        'Dim timestamp As DateTime = Now()
        'Console.WriteLine("INICIANDO CONSULTA = " & anio & "/" & periodo)
        'Console.WriteLine(Format(Now(), "HH:mm:ss.fff"))

        'Dim dt As DataTable = sap.RecuperaGastosNS(fecha_ini, fecha_fin)


        'Console.WriteLine("CONSULTA TERMINADA: " & dt.Rows.Count)
        'Console.WriteLine("TIEMPO: " & DateDiff(DateInterval.Second, timestamp, Now()) & " segundos")
    End Sub




    Function GetTable() As DataTable
        ' Create new DataTable instance.
        Dim table As New DataTable

        ' Create four typed columns in the DataTable.
        table.Columns.Add("id", GetType(Integer))
        table.Columns.Add("tpoli", GetType(String))
        table.Columns.Add("poliz", GetType(String))
        table.Columns.Add("bldat", GetType(String))
        table.Columns.Add("blart", GetType(String))
        table.Columns.Add("bukrs", GetType(String))
        table.Columns.Add("budat", GetType(String))
        table.Columns.Add("monat", GetType(String))
        table.Columns.Add("waers", GetType(String))
        table.Columns.Add("xblnr", GetType(String))
        table.Columns.Add("bktxt", GetType(String))
        table.Columns.Add("wrbtr", GetType(String))
        table.Columns.Add("kostl", GetType(String))
        table.Columns.Add("zuonr", GetType(String))

        ' Add five rows with those columns filled in the DataTable.
        table.Rows.Add(1, "B", "", "08.01.2015", "SA", "0600", "12.02.2015", "02", "MXP", "SV150022", "SV150022", "10447.86", "0000600984", "SV150022")
        table.Rows.Add(2, "40", "", "5200000170", "58.96", "W0", "X", "SV150022", "Propinas", "", "620851", "", "", "")
        table.Rows.Add(3, "40", "", "5200000240", "3955.33", "W0", "X", "SV150022", "Alimentos", "", "620851", "", "", "")
        table.Rows.Add(4, "40", "", "5200000240", "5328.07", "W0", "X", "SV150022", "Hospedaje", "", "620851", "", "", "")
        table.Rows.Add(5, "40", "", "5200000520", "1105.50", "W0", "X", "SV150022", "Combustible", "", "620851", "", "", "")
        Return table
    End Function






    ''Sub Main()
    ''    Try
    ''        Dim strParamas(1) As String
    ''        strParamas(0) = "BUKRS=0300"

    ''        Dim strIncluyeCols(1) As String
    ''        strIncluyeCols(0) = "AUFNR"

    ''        Dim sapHelper As New SapHelper
    ''        Dim dt As DataTable = sapHelper.GetDataTable("Z_INTRANET_OI", "T_AUFK", strParamas, strIncluyeCols)
    ''        For Each dr As DataRow In dt.Rows
    ''            For Each dc As DataColumn In dt.Columns
    ''                Console.WriteLine(dc.ColumnName & " = " & dr(dc.ColumnName))
    ''            Next
    ''        Next

    ''        Console.WriteLine("==============================================================================")
    ''        Console.WriteLine("==============================================================================")
    ''        Console.WriteLine("==============================================================================")

    ''        Console.WriteLine(Format(Now(), "HH:mm:ss fff"))
    ''        Dim strParamasIn(3) As String
    ''        strParamasIn(0) = "FCURR=USD"
    ''        strParamasIn(1) = "TCURR=MXP"
    ''        strParamasIn(2) = "FECHA=20131227"

    ''        Dim strExport(1) As String
    ''        strExport(0) = "UKURS"

    ''        Dim valores As String() = sapHelper.GetDataArray("Z_INTRANET_TC", "T_AUFK", strParamasIn, strExport)
    ''        For Each resultado As String In valores
    ''            If Not resultado Is Nothing Then
    ''                Console.WriteLine(resultado)
    ''            End If
    ''        Next

    ''        Console.WriteLine(Format(Now(), "HH:mm:ss fff"))
    ''        Dim sg As New SolicitudGasto("Server=148.235.0.26;database=intranet_nutec_qa;uid=intranet;pwd=Pa88word1;pooling=false;")
    ''        sg.ActualizaTipoCambio(1330)
    ''        Console.WriteLine(Format(Now(), "HH:mm:ss fff"))

    ''        Console.ReadKey()
    ''    Catch ex As Exception
    ''        Console.WriteLine(ex.Message)
    ''        Console.ReadKey()
    ''    End Try
    ''End Sub

    'Sub Main()
    '    Try
    '        Dim tipo As String = ""

    '        Dim savepath As String = ""

    '        savepath = "C:/Rigo/Proyectos/RespaldoServidores/Fotosnutec/"

    '        Dim filename As String = ""

    '        Dim di As New DirectoryInfo(savepath)
    '        Dim fiArr As FileInfo() = di.GetFiles()
    '        ' Display the names of the files.
    '        Dim fri As FileInfo
    '        For Each fri In fiArr

    '            If fri.Name.ToString.Contains(".png") Then
    '                Console.WriteLine(fri.Name)
    '            End If

    '            'filename = fri.Name

    '            'Try
    '            '    Dim imgOrig As Drawing.Image = RezizeImage(Drawing.Image.FromFile(savepath + filename), 380, 400)
    '            '    imgOrig.Save(savepath + Path.GetFileNameWithoutExtension(filename) & "." & ImageFormat.Png.ToString.ToLower(), System.Drawing.Imaging.ImageFormat.Png)
    '            'Catch ex As Exception
    '            'End Try

    '            'Dim imgWeb As Drawing.Image = RezizeImage(Drawing.Image.FromFile(savepath + filename), 190, 200)
    '            'imgWeb.Save(savepath + "media/" + Path.GetFileNameWithoutExtension(filename) & "." & ImageFormat.Png.ToString.ToLower(), System.Drawing.Imaging.ImageFormat.Png)

    '            'Dim imgMini As Drawing.Image = RezizeImage(Drawing.Image.FromFile(savepath + filename), 95, 100)
    '            'imgMini.Save(savepath + "mini/" + Path.GetFileNameWithoutExtension(filename) & "." & ImageFormat.Png.ToString.ToLower(), System.Drawing.Imaging.ImageFormat.Png)



    '        Next fri


    '        Console.ReadLine()

    '        'filename = Path.GetFileNameWithoutExtension(filename) + "_" + DateTime.Now.ToString("yyyyMMddHHmmss") + Path.GetExtension(filename)
    '        'filename = filename.Replace("'", "")

    '        'postedFile.SaveAs(savepath + filename)

    '        'Try
    '        '    Dim imgOrig As Drawing.Image = RezizeImage(Drawing.Image.FromFile(savepath + filename), 380, 400)
    '        '    imgOrig.Save(savepath + Path.GetFileNameWithoutExtension(filename) & "." & ImageFormat.Png.ToString.ToLower(), System.Drawing.Imaging.ImageFormat.Png)
    '        'Catch ex As Exception
    '        'End Try

    '        'Dim imgWeb As Drawing.Image = RezizeImage(Drawing.Image.FromFile(savepath + filename), 190, 200)
    '        'imgWeb.Save(savepath + "media/" + Path.GetFileNameWithoutExtension(filename) & "." & ImageFormat.Png.ToString.ToLower(), System.Drawing.Imaging.ImageFormat.Png)

    '        'Dim imgMini As Drawing.Image = RezizeImage(Drawing.Image.FromFile(savepath + filename), 95, 100)
    '        'imgMini.Save(savepath + "mini/" + Path.GetFileNameWithoutExtension(filename) & "." & ImageFormat.Png.ToString.ToLower(), System.Drawing.Imaging.ImageFormat.Png)

    '        'empleado.GuardaFotografia(context.Request.QueryString("id"),
    '        '                          Path.GetFileNameWithoutExtension(filename) & "." & ImageFormat.Png.ToString)

    '        'context.Response.Write(Path.GetFileNameWithoutExtension(filename) & "." & ImageFormat.Png.ToString)
    '        'context.Response.StatusCode = 200
    '    Catch ex As Exception
    '        Throw ex
    '    End Try

    'End Sub





    ''ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
    ''    Get
    ''        Return False
    ''    End Get
    ''End Property



    'Private Function RezizeImage(img As Drawing.Image, maxWidth As Integer, maxHeight As Integer) As Drawing.Image
    '    If img.Height < maxHeight AndAlso img.Width < maxWidth Then
    '        Return img
    '    End If
    '    Using img
    '        Dim xRatio As [Double] = CDbl(img.Width) / maxWidth
    '        Dim yRatio As [Double] = CDbl(img.Height) / maxHeight
    '        Dim ratio As [Double] = Math.Max(xRatio, yRatio)
    '        Dim nnx As Integer = CInt(Math.Floor(img.Width / ratio))
    '        Dim nny As Integer = CInt(Math.Floor(img.Height / ratio))
    '        Dim cpy As New Drawing.Bitmap(nnx, nny, Drawing.Imaging.PixelFormat.Format32bppArgb)
    '        Using gr As Drawing.Graphics = Drawing.Graphics.FromImage(cpy)
    '            gr.Clear(Drawing.Color.Transparent)

    '            ' This is said to give best quality when resizing images
    '            gr.InterpolationMode = InterpolationMode.HighQualityBicubic

    '            gr.DrawImage(img, New Drawing.Rectangle(0, 0, nnx, nny), New Drawing.Rectangle(0, 0, img.Width, img.Height), Drawing.GraphicsUnit.Pixel)
    '        End Using
    '        Return cpy
    '    End Using

    'End Function

    'Private Function BytearrayToStream(arr As Byte()) As MemoryStream
    '    Return New MemoryStream(arr, 0, arr.Length)
    'End Function

    'Private Sub HandleImageUpload(binaryImage As Byte())
    '    Dim img As Drawing.Image = RezizeImage(Drawing.Image.FromStream(BytearrayToStream(binaryImage)), 103, 32)
    '    img.Save("IMAGELOCATION.png", System.Drawing.Imaging.ImageFormat.Gif)
    'End Sub



End Module


Public Class MyPolicy
    Implements ICertificatePolicy

    Public Function CheckValidationResult1(srvPoint As ServicePoint, certificate As X509Certificate, request As WebRequest, certificateProblem As Integer) As Boolean Implements ICertificatePolicy.CheckValidationResult
        'Return True to force the certificate to be accepted.
        Return True
    End Function
End Class


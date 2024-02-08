Imports Excel
Imports System.IO

Public Class ExcelData
    Private _path As String

    Public Sub New(path As String)
        _path = path
    End Sub

    Public Function getExcelReader() As IExcelDataReader
        Dim stream As FileStream = File.Open(_path, FileMode.Open, FileAccess.Read)

        Dim reader As IExcelDataReader = Nothing
        Try
            If _path.EndsWith(".xls") Then
                reader = ExcelReaderFactory.CreateBinaryReader(stream)
            End If
            If _path.EndsWith(".xlsx") Then
                reader = ExcelReaderFactory.CreateOpenXmlReader(stream)
            End If
            Return reader
        Catch generatedExceptionName As Exception
            Throw
        End Try
    End Function

    Public Function getWorksheetNames() As IEnumerable(Of String)
        Dim reader = Me.getExcelReader()
        Dim workbook = reader.AsDataSet()
        Dim sheets = From sheet As DataTable In workbook.Tables Select sheet.TableName
        Return sheets
    End Function

    Public Function getData(sheet As String, Optional firstRowIsColumnNames As Boolean = True) As IEnumerable(Of DataRow)
        Dim reader = Me.getExcelReader()
        reader.IsFirstRowAsColumnNames = firstRowIsColumnNames
        Dim workSheet = reader.AsDataSet().Tables(sheet)
        Dim rows = From a As DataRow In workSheet.Rows Select a
        Return rows
    End Function
End Class
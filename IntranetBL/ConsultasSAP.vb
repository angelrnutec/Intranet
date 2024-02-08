Imports System.Collections.Generic
Imports System.Linq
Imports System.Text
Imports System.Data
Imports System.Data.SqlClient
Imports IntranetDA

Public Class ConsultasSAP

    Public Function RecuperaOrdenesInternas(id_empresa As Integer) As DataTable
        Try

            Dim BUKRS As String = "0300"
            If id_empresa = 6 Then
                BUKRS = "0600"
            ElseIf id_empresa = 8 Then
                BUKRS = "0800"
            End If

            Dim strParamas(1) As String
            strParamas(0) = "BUKRS=" & BUKRS

            Dim strIncluyeCols(1) As String
            strIncluyeCols(0) = "AUFNR"

            Dim sapHelper As New SapHelper
            Return sapHelper.GetDataTable("Z_INTRANET_OI", "T_AUFK", strParamas, strIncluyeCols)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function EnviarPolizaSAP(dtPolizas As DataTable) As PolizaSapResult
        Dim sapHelper As New SapHelper
        Return sapHelper.SendPoliza(dtPolizas)

    End Function

    Public Function RecuperaElementoPEP(id_empresa As Integer) As DataTable
        Try
            Dim BUKRS As String = "0300"
            If id_empresa = 6 Then
                BUKRS = "0600"
            ElseIf id_empresa = 8 Then
                BUKRS = "0800"
            End If

            Dim strParamas(1) As String
            strParamas(0) = "BUKRS=" & BUKRS

            Dim strIncluyeCols(2) As String
            strIncluyeCols(0) = "AUFNR"
            strIncluyeCols(1) = "POSKI"

            Dim sapHelper As New SapHelper
            Return sapHelper.GetDataTable("Z_INTRANET_OI", "T_PRAU", strParamas, strIncluyeCols)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaParidad(ByVal moneda As String, ByVal fecha As DateTime) As Decimal
        Try
            Dim strParamas(3) As String
            strParamas(0) = "FCURR=" & moneda
            strParamas(1) = "TCURR=MXP"
            strParamas(2) = "FECHA=" & Format(fecha, "yyyyMMdd")

            Dim strExport(1) As String
            strExport(0) = "UKURS"

            Dim sapHelper As New SapHelper
            Dim resultados As String() = sapHelper.GetDataArray("Z_INTRANET_TC", "T_AUFK", strParamas, strExport)

            Return Convert.ToDecimal(resultados(0).Split("=")(1))
        Catch ex As Exception
            Return 1
        End Try
    End Function

    Public Function RecuperaParidadDesdeHacia(ByVal moneda_desde As String, ByVal moneda_hacia As String, ByVal fecha As DateTime) As Decimal
        Try
            Dim strParamas(3) As String
            strParamas(0) = "FCURR=" & moneda_hacia
            strParamas(1) = "TCURR=" & moneda_desde
            strParamas(2) = "FECHA=" & Format(fecha, "yyyyMMdd")

            Dim strExport(1) As String
            strExport(0) = "UKURS"

            Dim sapHelper As New SapHelper
            Dim resultados As String() = sapHelper.GetDataArray("Z_INTRANET_TC", "T_AUFK", strParamas, strExport)

            Return Convert.ToDecimal(resultados(0).Split("=")(1))
        Catch ex As Exception
            Return 1
        End Try
    End Function

    Public Function RecuperaGastosNS(fecha_ini As DateTime, fecha_fin As DateTime) As DataTable
        Try
            Dim strParamas(2) As String
            strParamas(0) = "BUKRS=0600"
            strParamas(1) = "BUDAT1=" & Format(fecha_ini, "yyyyMMdd")
            strParamas(2) = "BUDAT2=" & Format(fecha_fin, "yyyyMMdd")


            Dim strIncluyeCols(11) As String
            strIncluyeCols(0) = "KOSTL"
            strIncluyeCols(1) = "KSTAR"
            strIncluyeCols(2) = "KAEP_CEKTX"
            strIncluyeCols(3) = "RKGXXX"
            strIncluyeCols(4) = "GKOAR"
            strIncluyeCols(5) = "GKONT"
            strIncluyeCols(6) = "GKONT_KTXT"
            strIncluyeCols(7) = "CO_BUDAT"
            strIncluyeCols(8) = "CO_REFBN"
            strIncluyeCols(9) = "CO_BLTXT"
            strIncluyeCols(10) = "CO_SGTXT"

            Dim sapHelper As New SapHelper
            Return sapHelper.GetDataTable("Z_INTRANET_KSB12", "T_KAEP", strParamas, strIncluyeCols)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaGastosNSPresupuesto(anio As Integer) As DataTable
        Try
            Dim strParamas(0) As String
            strParamas(0) = "I_GJAHR=" & anio.ToString()


            Dim strIncluyeCols(6) As String
            strIncluyeCols(0) = "OBJNR"
            strIncluyeCols(1) = "KOSTL"
            strIncluyeCols(2) = "KSTAR"
            strIncluyeCols(3) = "GJAHR"
            strIncluyeCols(4) = "WTG00"
            strIncluyeCols(5) = "UKURS"

            Dim sapHelper As New SapHelper
            Return sapHelper.GetDataTable("ZFIPRES", "T_ZFIPRESU", strParamas, strIncluyeCols)
        Catch ex As Exception
            Throw ex
        End Try
    End Function

    Public Function RecuperaPolizasContablesACorregir() As DataTable
        Try           
            Dim sapHelper As New SapHelper
            Return sapHelper.GetDataTable("ZFI0054POLDEL", "ZF54PDEL", Nothing, Nothing)
        Catch ex As Exception
            Throw ex
        End Try
    End Function


    '             try
    '         {
    '             RfcDestination SapRfcDestination = RfcDestinationManager.GetDestination("DEV");
    '             RfcRepository SapRfcRepository = SapRfcDestination.Repository;

    '             Console.WriteLine("--INICIANDO CONSULTA--");
    '             IRfcFunction BapiGetQuery = SapRfcRepository.CreateFunction("Z_INTRANET_KSB12");
    '             BapiGetQuery.SetValue("BUKRS", "0600");
    '             BapiGetQuery.SetValue("BUDAT1", "20130101");
    '             BapiGetQuery.SetValue("BUDAT2", "20131231");
    '             BapiGetQuery.Invoke(SapRfcDestination);
    '             Console.WriteLine("--CONSULTA EJECUTADA--");

    '             IRfcTable ResultsTable = BapiGetQuery.GetTable("T_KAEP");

    '             if (ResultsTable.RowCount > 0)
    '             {
    '                 using (System.IO.StreamWriter file = new System.IO.StreamWriter(@"C:\Rigo\Proyectos\Desarrollo\NUTEC_SAP.txt"))
    '                 {
    '                     for (int i = 0; i <= ResultsTable.RowCount - 1; i++)
    '                     {
    '                         ResultsTable.CurrentIndex = i;

    '                         //file.WriteLine("==========  FILA #" + (i + 1) + "  ==============");
    '                         //file.WriteLine("MANDT=" + ResultsTable.GetString("MANDT"));
    '                         //file.WriteLine("KSTAR=" + ResultsTable.GetString("KSTAR"));
    '                         //file.WriteLine("KAEP_CEKTX=" + ResultsTable.GetString("KAEP_CEKTX"));
    '                         //file.WriteLine("RKGXXX=" + ResultsTable.GetString("RKGXXX"));
    '                         //file.WriteLine("MBGXXX=" + ResultsTable.GetString("MBGXXX"));
    '                         //file.WriteLine("MEINB=" + ResultsTable.GetString("MEINB"));
    '                         //file.WriteLine("GKOAR=" + ResultsTable.GetString("GKOAR"));
    '                         //file.WriteLine("GKONT=" + ResultsTable.GetString("GKONT"));
    '                         //file.WriteLine("GKONT_KTXT=" + ResultsTable.GetString("GKONT_KTXT"));

    '//                         file.WriteLine(ResultsTable.GetString("KAEP_CEKTX") + "\t" + ResultsTable.GetString("RKGXXX") + "\t" + ResultsTable.GetString("MBGXXX") + "\t" + ResultsTable.GetString("MEINB") + "\t" + ResultsTable.GetString("GKOAR") + "\t" + ResultsTable.GetString("GKONT") + "\t" + ResultsTable.GetString("GKONT_KTXT"));

    '                         file.WriteLine(ResultsTable.GetString("KOSTL") + "\t" + ResultsTable.GetString("KSTAR") + "\t" + ResultsTable.GetString("KAEP_CEKTX") + "\t" + ResultsTable.GetString("RKGXXX") + "\t" + ResultsTable.GetString("GKOAR") + "\t" + ResultsTable.GetString("GKONT") + "\t" + ResultsTable.GetString("GKONT_KTXT") + "\t" + ResultsTable.GetString("CO_BUDAT") + "\t" + ResultsTable.GetString("CO_REFBN") + "\t" + ResultsTable.GetString("CO_BLTXT") + "\t" + ResultsTable.GetString("CO_SGTXT"));

    '                     }
    '                 }

    '                 //for (int i = 0; i <= ResultsTable.RowCount - 1; i++)
    '                 //{
    '                 //    ResultsTable.CurrentIndex = i;


    '                 //    Console.WriteLine(ResultsTable.GetString("MANDT") + "," + ResultsTable.GetString("KSTAR") + "," + ResultsTable.GetString("KAEP_CEKTX") + "," + ResultsTable.GetString("RKGXXX") + "," + ResultsTable.GetString("MBGXXX") + "," + ResultsTable.GetString("MEINB") + "," + ResultsTable.GetString("GKOAR") + "," + ResultsTable.GetString("GKONT") + "," + ResultsTable.GetString("GKONT_KTXT"));


    '                 //    //Console.WriteLine("");
    '                 //    //Console.Write("" + ResultsTable.GetString("MANDT"));
    '                 //    //Console.Write("," + ResultsTable.GetString("KSTAR"));
    '                 //    //Console.Write("," + ResultsTable.GetString("KAEP_CEKTX"));
    '                 //    //Console.Write("," + ResultsTable.GetString("RKGXXX"));
    '                 //    //Console.Write("," + ResultsTable.GetString("MBGXXX"));
    '                 //    //Console.Write("," + ResultsTable.GetString("MEINB"));
    '                 //    //Console.Write("," + ResultsTable.GetString("GKOAR"));
    '                 //    //Console.Write("," + ResultsTable.GetString("GKONT"));
    '                 //    //Console.Write("," + ResultsTable.GetString("GKONT_KTXT"));

    '                 //    //Console.Write("MANDT=" + ResultsTable.GetString("MANDT"));
    '                 //    //Console.Write(",KSTAR=" + ResultsTable.GetString("KSTAR"));
    '                 //    //Console.Write(",KAEP_CEKTX=" + ResultsTable.GetString("KAEP_CEKTX"));
    '                 //    //Console.Write(",RKGXXX=" + ResultsTable.GetString("RKGXXX"));
    '                 //    //Console.Write(",MBGXXX=" + ResultsTable.GetString("MBGXXX"));
    '                 //    //Console.Write(",MEINB=" + ResultsTable.GetString("MEINB"));
    '                 //    //Console.Write(",GKOAR=" + ResultsTable.GetString("GKOAR"));
    '                 //    //Console.Write(",GKONT=" + ResultsTable.GetString("GKONT"));
    '                 //    //Console.Write(",GKONT_KTXT=" + ResultsTable.GetString("GKONT_KTXT"));
    '                 //}
    '             }
    '         }
    '         catch (Exception ex)
    '         {
    '             Console.WriteLine(ex.Message);
    '         }

End Class

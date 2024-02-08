using IntranetBL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using TicketEmpresarialReporteMovimientos;
using System.IO;
using System.Text.RegularExpressions;

namespace TicketEmpresarialPruebas
{
    class Program
    {
        public static string _ExternalClientId = "F29CAC08-9CDB-4558-92B7-7E751453D0C5";
        public static string _Token = "FbMd6S54omhH9aYqJffqozc2PQ7tyFGLeSyXAvD6rnMf7aFRZEjpyFHvd0BHhU+NUB4/IJLv3icskODBwGWyNnG88KX2ComcjoUVZoHjGDzK05Z9OPsYEPOvrRuXvtSG";
        public static string _Username = "1004";
        public static string _Password = "0xRZYdMc9DpiATvuvpEx";

        public static string CleanString(string inputString)
        {
            var normalizedString = inputString.Normalize(NormalizationForm.FormD);
            var sb = new StringBuilder();
            for (int i = 0; i < normalizedString.Length; i++)
            {
                var uc = System.Globalization.CharUnicodeInfo.GetUnicodeCategory(normalizedString[i]);
                if (uc != System.Globalization.UnicodeCategory.NonSpacingMark)
                {
                    sb.Append(normalizedString[i]);
                }
            }

            inputString = sb.ToString().Normalize(NormalizationForm.FormC);
            inputString = System.Text.RegularExpressions.Regex.Replace(inputString, @"[^a-z^0-9^ ^-^_]", "_", System.Text.RegularExpressions.RegexOptions.IgnoreCase);
            inputString = inputString.Replace(' ', '_');

            RegexOptions options = RegexOptions.None;
            Regex regex = new Regex("[_]{2,}", options);
            inputString = regex.Replace(inputString, "_");

            return inputString.ToLower();
        }

        static void Main(string[] args)
        {

            //string[] fileEntries = Directory.GetFiles(@"C:\temp\OKOK");



            //using (StreamWriter sw = File.CreateText(@"C:\temp\corteacero_updates_2.sql"))
            //{
            //    foreach (string fileName in fileEntries)
            //    {
            //        DeveltecExtractUUID.DatosFactura datos_factura = DeveltecExtractUUID.ExtractUUID.GetDatosFactura(fileName);


            //        string comando = string.Format("update factura set importe={0}, iva={1}, total={2} where folio={3} and uuid='{4}'",
            //            datos_factura.subtotal,
            //            datos_factura.impuestos,
            //            datos_factura.total,
            //            datos_factura.folio,
            //            datos_factura.uuid
            //            );

            //        sw.WriteLine(comando);
            //    }
            //}	






            //string archivo = @"C:\Develtec\GoogleDrive\SAT_DEVELTEC\Respaldo\2018\2018-05\Ingresos\DSE130628RK0_497_TRA970626JM5.xml";
            string archivo = @"C:\Users\develtec\Downloads\F0000007711.xml";


            DeveltecExtractUUID.DatosFactura datos_factura = DeveltecExtractUUID.ExtractUUID.GetDatosFactura(archivo);
            if (datos_factura.error != null)
            {
                //Error: mostrar mensaje contenido en "datos_factura.error"
            }
            else if (datos_factura.tipo_comprobante != "I")
            {
                //Error: mostrar mensaje "Solo se permiten cargar comprobantes de tipo Ingreso"
            }
            else
            {
                Console.WriteLine("emisor_nombre: " + datos_factura.emisor_nombre);
                Console.WriteLine("emisor_rfc: " + datos_factura.emisor_rfc);
                Console.WriteLine("receptor_nombre: " + datos_factura.receptor_nombre);
                Console.WriteLine("receptor_rfc: " + datos_factura.receptor_rfc);
                Console.WriteLine("uuid: " + datos_factura.uuid);
                Console.WriteLine("tipo_comprobante: " + datos_factura.tipo_comprobante);
                Console.WriteLine("moneda: " + datos_factura.moneda);
                Console.WriteLine("subtotal: " + datos_factura.subtotal);
                Console.WriteLine("impuestos: " + datos_factura.impuestos);
                Console.WriteLine("total: " + datos_factura.total);
            }
            
            
            //Console.WriteLine(DeveltecExtractUUID.ExtractUUID.GetUUID(archivo));



            //return;


            //Console.WriteLine("Integración" + ":" + CleanString("Integración"));
            //Console.WriteLine("Informe  / Rinde su informe semestral al Consejo de Coordinación" + ":" + CleanString("Informe  / Rinde su informe semestral al Consejo de Coordinación"));
            //Console.WriteLine("MO-1.2 Declaratoria de incorporación" + ":" + CleanString("MO-1.2 Declaratoria de incorporación"));
            //Console.WriteLine("MO 2.3 Procedencia de recursos / 1. Recursos institucionales para la implementación de la Reforma" + ":" + CleanString("MO 2.3 Procedencia de recursos / 1. Recursos institucionales para la implementación de la Reforma"));

            //StringBuilder sb = new StringBuilder();
            //List<String> archivos = DirSearch(@"C:\temp\UUID_ANALISIS_NUTEC\");
            //foreach (string archivo in archivos)
            //{
            //    string UUID = DeveltecExtractUUID.ExtractUUID.GetUUID(archivo);
            //    string version = DeveltecExtractUUID.ExtractUUID.GetVersion(archivo);
            //    string importe = DeveltecExtractUUID.ExtractUUID.GetImporteTotal(archivo);

            //    Console.WriteLine(archivo.Replace(@"C:\temp\UUID_ANALISIS_NUTEC\", "") + "\t" + UUID + "\t" + importe);

            //    decimal outImporte;
            //    if (decimal.TryParse(importe, out outImporte))
            //    {
            //        sb.AppendLine("insert into #tempArchivos (archivo, uuid, importe) values ('" + archivo.Replace(@"C:\temp\UUID_ANALISIS_NUTEC\", "") + "','" + UUID + "','" + importe + "')");
            //    }
            //}

            //TextWriter tw = File.CreateText(@"C:\temp\UUID_ANALISIS_NUTEC.output.3.txt");
            //tw.Write(sb);
            //tw.Close();





//            Console.WriteLine("xxx: " + (Path.GetExtension("rigo.xml").ToUpper() == ".XML"));

//            string UUID = DeveltecExtractUUID.ExtractUUID.GetUUID("C:/temp/Document1.xml");
////            string UUID = DeveltecExtractUUID.ExtractUUID.GetUUID("C:/temp/DSE130628RK0_414_GUC060613AY7.xml");
//            Console.WriteLine("FIN: UUID: " + UUID);













            //string cardNumber = "00261";

            //CardGetListRequest(cardNumber);
            //CardBalanceAssignment(cardNumber, Convert.ToDecimal(1000.45));

            //CardGetListRequest(cardNumber);
            ////CardBalanceAdjustment(cardNumber, Convert.ToDecimal(100.45));

            ////CardGetListRequest(cardNumber);
            ////CardBalanceAssignment(cardNumber, Convert.ToDecimal(100.45));

            ////CardGetListRequest(cardNumber);
            //Console.WriteLine("-----------------------------------------");



            ////    MovimientosTarjeta mt = new MovimientosTarjeta("Server=148.235.0.26;database=intranet_nutec_qa2;uid=intranet;pwd=Pa88word1;pooling=false;");

            ////ProcesoRespuesta respuesta = Proceso.ImportarArchivo("C:\\temp\\NutecTicketEmpresarial\\rptWC_CardMovementsWithSpendReport.xml");

            ////foreach (string s in respuesta.mensajes)
            ////{
            ////    Console.WriteLine("Mensaje: " + s);
            ////}
            ////foreach (Movimiento m in respuesta.movimientos)
            ////{
            ////    Console.WriteLine("NumeroTarjeta: " + m.NumeroTarjeta);
            ////    Console.WriteLine("FechaMovimiento: " + m.FechaMovimiento);

            ////    Console.WriteLine("Concepto: " + m.Concepto);
            ////    Console.WriteLine("Descripcion: " + m.Descripcion);
            ////    Console.WriteLine("DescMonedaExtranjera: " + m.DescMonedaExtranjera);
            ////    Console.WriteLine("Autorizacion1: " + m.Autorizacion1);
            ////    Console.WriteLine("EstadoCuenta: " + m.EstadoCuenta);
            ////    Console.WriteLine("MonedaExtranjera: " + m.MonedaExtranjera);
            ////    Console.WriteLine("Pesos: " + m.Pesos);
            ////    Console.WriteLine("StatusTarjeta: " + m.StatusTarjeta);
            ////    Console.WriteLine("TipoComercio: " + m.TipoComercio);
            ////    Console.WriteLine("TipoValorPesos: " + m.TipoValorPesos);
            ////    Console.WriteLine("----------------------------------");

            ////    mt.Guarda("TE", m.NumeroTarjeta, m.FechaMovimiento, m.Concepto, m.Descripcion, m.TipoComercio,  m.DescMonedaExtranjera, m.Autorizacion1, m.StatusTarjeta, m.TipoValorPesos, m.MonedaExtranjera, m.Pesos, -1);

            ////}

            Console.ReadKey();
        }

        private static List<String> DirSearch(string sDir)
        {
            List<String> files = new List<String>();
            try
            {
                foreach (string f in Directory.GetFiles(sDir))
                {
                    if(Path.GetExtension(f).ToUpper() == ".XML")
                        files.Add(f);
                }
                foreach (string d in Directory.GetDirectories(sDir))
                {
                    files.AddRange(DirSearch(d));
                }
            }
            catch (System.Exception excpt)
            {
                Console.WriteLine(excpt.Message);
            }

            return files;
        }


        private static void CardGetListByEmployerRequest(string employer)
        {
            try
            {

                TicketEmpresarialService.CardGetListRequest request = new TicketEmpresarialService.CardGetListRequest();
                request.Security = new TicketEmpresarialService.SecurityDTO();
                request.Security.ExternalClientId = _ExternalClientId;
                request.Security.Token = _Token;

                request.Filter = TicketEmpresarialService.CardGetListFilter.ByEmployerId;
                request.FilterValue = employer;

                request.Paging = new TicketEmpresarialService.PagingDTO();
                request.Paging.PageNumber = 1;
                request.Paging.PageRecords = 50;


                TicketEmpresarialService.TEServiceClient client = new TicketEmpresarialService.TEServiceClient();

                client.ClientCredentials.UserName.UserName = _Username;
                client.ClientCredentials.UserName.Password = _Password;


                TicketEmpresarialService.CardGetListResponse response = client.CardGetList(request);
                if (response.Success)
                {
                    if (response.CardList != null)
                    {
                        Console.WriteLine("Card list count..." + (response.CardList.Count()));
                        foreach (TicketEmpresarialService.CardDetailDTO cardDetail in response.CardList)
                        {
                            Console.WriteLine("CardNumber: " + cardDetail.CardNumber + ", CardStatus: " + (cardDetail.CardStatus != null ? cardDetail.CardStatus.StatusDescription : "Invalid Status") + ", Amount: " + cardDetail.Amount);
                        }
                    }
                    else
                    {
                        Console.WriteLine("Sin resultado...");
                    }

                }
                else
                {
                    if (response.ErrorList != null)
                    {
                        Console.WriteLine("Error list count..." + (response.ErrorList.Count()));
                        foreach (TicketEmpresarialService.ErrorDTO error in response.ErrorList)
                        {
                            Console.WriteLine("Code: " + error.Code + ", Message: " + error.Message);
                        }
                    }
                    else
                    {
                        Console.WriteLine("Sin resultado...");
                    }

                }

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error inesperado: " + ex.Message);

            }
        }




        private static void CardGetListRequest(string cardNumber)
        {
            try
            {

                TicketEmpresarialService.CardGetListRequest request = new TicketEmpresarialService.CardGetListRequest();
                request.Security = new TicketEmpresarialService.SecurityDTO();
                request.Security.ExternalClientId = _ExternalClientId;
                request.Security.Token = _Token;

                request.Filter = TicketEmpresarialService.CardGetListFilter.ByCardNumber;
                request.FilterValue = cardNumber;

                request.Paging = new TicketEmpresarialService.PagingDTO();

                TicketEmpresarialService.TEServiceClient client = new TicketEmpresarialService.TEServiceClient();

                client.ClientCredentials.UserName.UserName = _Username;
                client.ClientCredentials.UserName.Password = _Password;


                TicketEmpresarialService.CardGetListResponse response = client.CardGetList(request);
                if (response.Success)
                {
                    if (response.CardList != null)
                    {
                        Console.WriteLine("Card list count..." + (response.CardList.Count()));
                        foreach (TicketEmpresarialService.CardDetailDTO cardDetail in response.CardList)
                        {
                            Console.WriteLine("CardNumber: " + cardDetail.CardNumber + ", CardStatus: " + cardDetail.CardStatus.StatusDescription + ", Amount: " + cardDetail.Amount);
                        }
                    }
                    else
                    {
                        Console.WriteLine("Sin resultado...");
                    }

                }
                else
                {
                    if (response.ErrorList != null)
                    {
                        Console.WriteLine("Error list count..." + (response.ErrorList.Count()));
                        foreach (TicketEmpresarialService.ErrorDTO error in response.ErrorList)
                        {
                            Console.WriteLine("Code: " + error.Code + ", Message: " + error.Message);
                        }
                    }
                    else
                    {
                        Console.WriteLine("Sin resultado...");
                    }

                }

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error inesperado: " + ex.Message);

            }
        }


        private static void CardBalanceAssignment(string cardNumber, decimal amount)
        {
            try
            {

                TicketEmpresarialService.CardBalanceAssignmentRequest request = new TicketEmpresarialService.CardBalanceAssignmentRequest();
                request.Security = new TicketEmpresarialService.SecurityDTO();
                request.Security.ExternalClientId = _ExternalClientId;
                request.Security.Token = _Token;


                TicketEmpresarialService.CardBalanceDTO[] cards = new TicketEmpresarialService.CardBalanceDTO[1];
                cards[0] = new TicketEmpresarialService.CardBalanceDTO();
                cards[0].Amount = amount;
                cards[0].CardNumber = cardNumber;

                request.CardBalanceDTOList = cards;


                TicketEmpresarialService.TEServiceClient client = new TicketEmpresarialService.TEServiceClient();

                client.ClientCredentials.UserName.UserName = _Username;
                client.ClientCredentials.UserName.Password = _Password;


                TicketEmpresarialService.CardBalanceAssignmentResponse response = client.CardBalanceAssignment(request);
                if (response.Success)
                {
                    if (response.CardBalanceDTOList != null)
                    {
                        Console.WriteLine("Card list count..." + (response.CardBalanceDTOList.Count()));
                        foreach (TicketEmpresarialService.CardBalanceDTO cardDetail in response.CardBalanceDTOList)
                        {
                            if (cardDetail.AuthorizationNumber != null && cardDetail.AuthorizationNumber != "")
                            {
                                Console.WriteLine("CardNumber: " + cardDetail.CardNumber + ", AuthorizationNumber: " + cardDetail.AuthorizationNumber + ", Amount: " + cardDetail.Amount);
                            }
                            else
                            {
                                Console.WriteLine("No autorizado, sin error");
                            }
                        }
                    }
                    else
                    {
                        Console.WriteLine("Sin resultado...");
                    }

                }
                else
                {
                    if (response.CardBalanceDTOList != null)
                    {
                        Console.WriteLine("Error list count..." + (response.ErrorList.Count()));
                        foreach (TicketEmpresarialService.ErrorDTO error in response.ErrorList)
                        {
                            Console.WriteLine("Code: " + error.Code + ", Message: " + error.Message);
                        }
                    }
                    else
                    {
                        Console.WriteLine("Sin resultado...");
                    }

                }

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error inesperado: " + ex.Message);

            }
        }


        private static void CardBalanceAdjustment(string cardNumber, decimal amount)
        {
            try
            {

                TicketEmpresarialService.CardBalanceAdjustmentRequest request = new TicketEmpresarialService.CardBalanceAdjustmentRequest();
                request.Security = new TicketEmpresarialService.SecurityDTO();
                request.Security.ExternalClientId = _ExternalClientId;
                request.Security.Token = _Token;


                TicketEmpresarialService.CardBalanceDTO[] cards = new TicketEmpresarialService.CardBalanceDTO[1];
                cards[0] = new TicketEmpresarialService.CardBalanceDTO();
                cards[0].Amount = amount;
                cards[0].CardNumber = cardNumber;

                request.CardBalanceDTOList = cards;


                TicketEmpresarialService.TEServiceClient client = new TicketEmpresarialService.TEServiceClient();

                client.ClientCredentials.UserName.UserName = _Username;
                client.ClientCredentials.UserName.Password = _Password;


                TicketEmpresarialService.CardBalanceAdjustmentResponse response = client.CardBalanceAdjustment(request);
                if (response.Success)
                {
                    if (response.CardBalanceDTOList != null)
                    {
                        Console.WriteLine("Card list count..." + (response.CardBalanceDTOList.Count()));
                        foreach (TicketEmpresarialService.CardBalanceDTO cardDetail in response.CardBalanceDTOList)
                        {
                            if (cardDetail.AuthorizationNumber != null && cardDetail.AuthorizationNumber != "")
                            {
                                Console.WriteLine("CardNumber: " + cardDetail.CardNumber + ", AuthorizationNumber: " + cardDetail.AuthorizationNumber + ", Amount: " + cardDetail.Amount);
                            }
                            else
                            {
                                Console.WriteLine("No autorizado, sin error");
                            }
                        }
                    }
                    else
                    {
                        Console.WriteLine("Sin resultado...");
                    }

                }
                else
                {
                    Console.WriteLine("Error list count..." + (response.ErrorList.Count()));
                    foreach (TicketEmpresarialService.ErrorDTO error in response.ErrorList)
                    {
                        Console.WriteLine("Code: " + error.Code + ", Message: " + error.Message);
                    }

                }

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error inesperado: " + ex.Message);

            }
        }




    }


    public class te_transaccion
    {
        public DateTime fecha { get; set; }
        public string tipo_movimiento { get; set; }
        public decimal importe { get; set; }
        public decimal saldo_anterior { get; set; }
        public decimal saldo_nuevo { get; set; }
        public string numero_autorizacion { get; set; }
        public bool exitoso { get; set; }
        public string referencia { get; set; }
        public int id_solicitud { get; set; }
        public string error { get; set; }
    }


}



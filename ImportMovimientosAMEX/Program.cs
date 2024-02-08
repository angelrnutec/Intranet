using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Security;
using System.Text;
using System.Threading.Tasks;

namespace ImportMovimientosAMEX
{
    class Program
    {
        public static WriteLog wl = new WriteLog();
        public static List<ArchivosFtp> listaArchivos;

        static void Main(string[] args)
        {
            DescargarArchivos();
            //listaArchivos = new List<ArchivosFtp>();
            //listaArchivos.Add(new ArchivosFtp() { nombre = "R865857.NUTEC.GL1025.D20170602.9.txt", ruta = @"C:\temp\Edenred" });
            //listaArchivos.Add(new ArchivosFtp() { nombre = "R865857.NUTEC.GL1025.D20170603.A.txt", ruta = @"C:\temp\Edenred" });
            //listaArchivos.Add(new ArchivosFtp() { nombre = "R865857.NUTEC.GL1025.D20170604.B.txt", ruta = @"C:\temp\Edenred" });
            //listaArchivos.Add(new ArchivosFtp() { nombre = "R865857.NUTEC.GL1025.D20170605.C.txt", ruta = @"C:\temp\Edenred" });

            ProcesarArchivos();

            //Console.ReadKey();
        }


        private static void ProcesarArchivos()
        {
            MovimientosTarjeta mt = new MovimientosTarjeta(System.Configuration.ConfigurationManager.AppSettings["CONEXION"].ToString());

            foreach (ArchivosFtp archivo in listaArchivos.Where(x => x.nombre.IndexOf("GL1025") > 0))
            {
                if (mt.ExisteArchivo(archivo.nombre) == false)
                {
                    archivo.existia = false;
                    Console.WriteLine("*********************************************************************************");
                    Console.WriteLine("*********************************************************************************");
                    Console.WriteLine(archivo.ruta + "\\" + archivo.nombre);
                    ProcesoRespuesta respuesta = Proceso.ImportarArchivo(AppDomain.CurrentDomain.BaseDirectory + "\\archivos_amex\\" + archivo.nombre);

                    foreach (string s in respuesta.mensajes)
                    {
                        Console.WriteLine("Mensaje: " + s);
                    }
                    archivo.registros_procesados = respuesta.movimientos.Count();
                    foreach (Movimiento m in respuesta.movimientos)
                    {

                        Console.WriteLine("FechaMovimiento: " + m.FechaMovimiento);
                        Console.WriteLine("NumeroTarjeta: " + m.NumeroTarjeta);
                        Console.WriteLine("EstatusTarjeta: " + m.EstatusTarjeta);
                        Console.WriteLine("Concepto: " + m.Concepto);
                        Console.WriteLine("Descripcion: " + m.Descripcion);
                        Console.WriteLine("TipoComercio: " + m.TipoComercio);
                        Console.WriteLine("RFCComercio: " + m.RFCComercio);
                        Console.WriteLine("IdMovimiento: " + m.IdMovimiento);
                        Console.WriteLine("Autorizacion: " + m.Autorizacion);
                        Console.WriteLine("NoControlEdoCuenta: " + m.NoControlEdoCuenta);
                        Console.WriteLine("Abono: " + m.Abono);
                        Console.WriteLine("ValorPesos: " + m.ValorPesos);
                        Console.WriteLine("ComisionIva: " + m.ComisionIva);
                        Console.WriteLine("ValorMonedaExtranjera: " + m.ValorMonedaExtranjera);
                        Console.WriteLine("DescMonedaExtranjera: " + m.DescMonedaExtranjera);
                        Console.WriteLine("TipoCambio: " + m.TipoCambio);
                        Console.WriteLine("----------------------------------");

                        mt.Guarda("AMEX",
                            m.FechaMovimiento,
                            m.NumeroTarjeta,
                            m.EstatusTarjeta,
                            m.Concepto,
                            m.Descripcion,
                            m.TipoComercio,
                            m.RFCComercio,
                            m.IdMovimiento,
                            m.Autorizacion,
                            m.NoControlEdoCuenta,
                            m.Abono,
                            m.ValorPesos,
                            m.ComisionIva,
                            m.ValorMonedaExtranjera,
                            m.DescMonedaExtranjera,
                            m.TipoCambio,
                            -1,
                            archivo.nombre);
                    }

                    mt.GuardaDatosArchivo("AMEX", archivo.nombre, archivo.registros_procesados);
                }
                else
                {
                    archivo.existia = true;
                }


            }
        }

        private static void DescargarArchivos()
        {
            string servidor = System.Configuration.ConfigurationManager.AppSettings["FTP_HOST"].ToString();
            string puerto = System.Configuration.ConfigurationManager.AppSettings["FTP_PORT"].ToString();
            string usuario = System.Configuration.ConfigurationManager.AppSettings["FTP_USER"].ToString();
            string password = System.Configuration.ConfigurationManager.AppSettings["FTP_PASS"].ToString();
            string carpetaLocal = AppDomain.CurrentDomain.BaseDirectory + "\\archivos_amex\\";
            string carpetaRemota = "/analisis/incoming";
            string authType = "TLS";

            if (!System.IO.Directory.Exists(carpetaLocal))
            {
                System.IO.Directory.CreateDirectory(carpetaLocal);
            }


            /* Create Object Instance */
            
            ftp ftpClient = new ftp(@"ftp://" + servidor + "/", usuario, password, authType);

            if (authType == "TLS")
            {
                System.Net.ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls12;
                ServicePointManager.ServerCertificateValidationCallback = new RemoteCertificateValidationCallback(ftpClient.AcceptAllCertificatePolicy);
            }

            wl.WriteToLogFile("==================================================");
            listaArchivos = ftpClient.listaArchivos(carpetaRemota);
            foreach (ArchivosFtp a in listaArchivos)
            {
                try
                {
                    wl.WriteToLogFile("Archivo a procesar: " + carpetaLocal + a.ruta.Substring(carpetaRemota.Length) + "/" + a.nombre);

                    bool exists = System.IO.Directory.Exists(carpetaLocal + a.ruta.Substring(carpetaRemota.Length));
                    if (!exists)
                        System.IO.Directory.CreateDirectory(carpetaLocal + a.ruta.Substring(carpetaRemota.Length));

                    ftpClient.download(a.ruta + "/" + a.nombre, carpetaLocal + a.ruta.Substring(carpetaRemota.Length) + "/" + a.nombre);
                }
                catch (Exception ex)
                {
                    wl.WriteToLogFile("A: " + ex.Message);
                }
            }
            if (listaArchivos.Count == 0)
            {
                wl.WriteToLogFile("Sin archivos a procesar");
            }
            ftpClient = null;
        }
    }
}

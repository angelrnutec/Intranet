using System;
using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Threading;
using Tamir.SharpSsh;
//using System.Threading.Tasks;
using TicketEmpresarialReporteMovimientos;

namespace ImportMovimientosEDENRED
{
    class Program
    {
        public static WriteLog wl = new WriteLog();
        public static List<ArchivosFtp> listaArchivos;


        static void Main(string[] args)
        {
            try
            {
                Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture("es-MX");
                Thread.CurrentThread.CurrentUICulture = new CultureInfo("es-MX");

                listaArchivos = new List<ArchivosFtp>();
                //Console.WriteLine("DescargarArchivos()");
                //Console.WriteLine("listaArchivos 1: " + listaArchivos.Count());
                DescargarArchivos();
                //Console.WriteLine("listaArchivos 2: " + listaArchivos.Count());
                //listaArchivos = new List<ArchivosFtp>();
                //listaArchivos.Add(new ArchivosFtp() { nombre = "0285836002_CTACON_20170810.csv", ruta = @"C:\Users\rigomc\Desktop\temp\xxxx" });

                Console.WriteLine("ProcesarArchivos()");
                ProcesarArchivos();


                foreach (ArchivosFtp archivo in listaArchivos)
                {
                    wl.WriteToLogFile("***************************");
                    wl.WriteToLogFile("***************************");
                    wl.WriteToLogFile("***************************");
                    wl.WriteToLogFile("Archivo:" + archivo.nombre);
                    wl.WriteToLogFile("Ruta:" + archivo.ruta);
                    wl.WriteToLogFile("Registros procesados:" + archivo.registros_procesados);
                    wl.WriteToLogFile("Ya existia:" + archivo.existia);
                }


                for (int i = 0; i < 20; i++)
                {
                    Console.WriteLine(".");
                    System.Threading.Thread.Sleep(500);
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
                if (ex.InnerException != null)
                {
                    Console.WriteLine("*********************");
                    Console.WriteLine(ex.InnerException.Message);
                }
                Console.ReadKey();
            }

            //Console.ReadKey();
        }


        private static void ProcesarArchivos()
        {
            Thread.CurrentThread.CurrentCulture = CultureInfo.CreateSpecificCulture("es-MX");
            Thread.CurrentThread.CurrentUICulture = new CultureInfo("es-MX");

            MovimientosTarjeta mt = new MovimientosTarjeta(System.Configuration.ConfigurationManager.AppSettings["CONEXION"].ToString());

            foreach (ArchivosFtp archivo in listaArchivos)
            {
                try
                {
                    Console.WriteLine("Archivo " + archivo.nombre);
                    Console.WriteLine("Archivo Existe" + mt.ExisteArchivo(archivo.nombre));
                    if (mt.ExisteArchivo(archivo.nombre) == false)
                    {

                        archivo.existia = false;
                        Console.WriteLine("*********************************************************************************");
                        Console.WriteLine("*********************************************************************************");
                        Console.WriteLine(archivo.ruta + "\\" + archivo.nombre);
                        ProcesoRespuesta respuesta = Proceso.ImportarArchivoCSV(AppDomain.CurrentDomain.BaseDirectory + "\\archivos_edenred\\" + archivo.nombre);
                        //ProcesoRespuesta respuesta = Proceso.ImportarArchivoCSV(archivo.ruta + "\\" + archivo.nombre);

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

                            mt.Guarda("TE",
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

                        mt.GuardaDatosArchivo("TE", archivo.nombre, archivo.registros_procesados);
                    }
                    else
                    {
                        archivo.existia = true;
                    }
                }
                catch (Exception ex)
                {
                    Console.WriteLine(ex.Message);
                    wl.WriteToLogFile(ex.Message);
                }

                


            }
        }

        private static void DescargarArchivos()
        {
            string servidor = System.Configuration.ConfigurationManager.AppSettings["FTP_HOST"].ToString();
            string puerto = System.Configuration.ConfigurationManager.AppSettings["FTP_PORT"].ToString();
            string usuario = System.Configuration.ConfigurationManager.AppSettings["FTP_USER"].ToString();
            string password = System.Configuration.ConfigurationManager.AppSettings["FTP_PASS"].ToString();
            string carpetaLocal = AppDomain.CurrentDomain.BaseDirectory + "\\archivos_edenred\\";
            string carpetaRemota = "/analisis/incoming";
            string authType = "TLS";

            Console.WriteLine("carpetaLocal:" + carpetaLocal);
            if (!System.IO.Directory.Exists(carpetaLocal))
            {
                System.IO.Directory.CreateDirectory(carpetaLocal);
            }


            //Console.WriteLine("Conectar 1...");
            //Sftp oSftp = new Sftp(servidor, usuario, password);
            //Console.WriteLine("Conectar 2...");
            //oSftp.Connect(int.Parse(puerto));
            //Console.WriteLine("Conectar 3...");
            //ArrayList FileList = oSftp.GetFileList(carpetaRemota);
            //Console.WriteLine("Conectar 4...");
            ////FileList.Remove(".");
            ////FileList.Remove("..");          //Remove . from the file list
            ////FileList.Remove("Processed");   //Remove folder name from the file list. If there is no folder name remove the code.

            //listaArchivos = new List<ArchivosFtp>();
            //for (int i = 0; i < FileList.Count; i++)
            //{
            //    Console.WriteLine("Nombre archivo...");
            //    if (!File.Exists(carpetaLocal + "/" + FileList[i]))
            //    {
            //        Console.WriteLine("Download...");
            //        oSftp.Get(carpetaRemota + "/" + FileList[i], carpetaLocal + "/" + FileList[i]);
            //        listaArchivos.Add(new ArchivosFtp() { nombre = FileList[i].ToString(), ruta=carpetaRemota });
            //        Thread.Sleep(100);
            //    }
            //}
            //oSftp.Close();


            
            SshTransferProtocolBase sshCp;
            sshCp = new Sftp(servidor, usuario);
            //sshCp.AddIdentityFile("", "");
            sshCp.Password = password;

            Console.WriteLine("Connecting...");
            sshCp.Connect(int.Parse(puerto));
            Console.WriteLine("OK");


            listaArchivos = new List<ArchivosFtp>();
            Console.WriteLine("PASO .1");
            ArrayList archivos = sshCp.GetFileList(carpetaRemota);
            Console.WriteLine("PASO .2");
            archivos.Remove(".");
            archivos.Remove("..");          //Remove . from the file list
            archivos.Remove("Processed");   //Remove folder name from the file list. If there is no folder name remove the code.

            for (int i = 0; i < archivos.Count; i++)
            {
                if (archivos[i].ToString().ToLower().Contains(".pdf"))
                {
                    if (!File.Exists(carpetaLocal + "/" + archivos[i]))
                    {
                        Console.WriteLine("Descargando... " + archivos[i]);
                        Console.WriteLine("Remoto... " + carpetaRemota + "/" + archivos[i]);
                        Console.WriteLine("Local... " + carpetaLocal + archivos[i]);

                        //sshCp.Get("/Movimientos_Nutec/0285836004_20170619.csv", @"C:\Intranet\Jobs\ImportaMovimientosEDENRED\archivos_edenred\0285836004_20170619.csv");
                        sshCp.Get(carpetaRemota + "/" + archivos[i], carpetaLocal + archivos[i]);
                    }
                    listaArchivos.Add(new ArchivosFtp() { nombre = archivos[i].ToString(), ruta = carpetaRemota });
                }
            }

            Console.WriteLine("Disconnecting...");
            sshCp.Close();
            Console.WriteLine("OK");


            ///* Create Object Instance */

            ////ftp ftpClient = new ftp(@"ftp://" + servidor + "/", usuario, password, authType);

            ////ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls;
            //ServicePointManager.ServerCertificateValidationCallback = new RemoteCertificateValidationCallback(AcceptAllCertificatePolicy);

            //wl.WriteToLogFile("==================================================");
            ////listaArchivos = ftpClient.listaArchivos(carpetaRemota);
            //listaArchivos = new List<ArchivosFtp>();
            //listaArchivos.Add(new ArchivosFtp() { nombre = "0285836004_20170619.csv", ruta = carpetaRemota });
            ////ftpClient = null;

            //foreach (ArchivosFtp a in listaArchivos)
            //{
            //    try
            //    {
            //        wl.WriteToLogFile("Archivo a descargar: " + carpetaLocal + a.ruta.Substring(carpetaRemota.Length) + "/" + a.nombre);

            //        bool exists = System.IO.Directory.Exists(carpetaLocal + a.ruta.Substring(carpetaRemota.Length));
            //        if (!exists)
            //            System.IO.Directory.CreateDirectory(carpetaLocal + a.ruta.Substring(carpetaRemota.Length));

            //        //ftpClient.download(a.ruta + "/" + a.nombre, carpetaLocal + a.ruta.Substring(carpetaRemota.Length) + "/" + a.nombre);

            //        using (var sftp = new Renci.SshNet.SftpClient(servidor, int.Parse( puerto), usuario, password))
            //        {
            //            Console.WriteLine("Paso 1");
            //            sftp.Connect();
            //            Console.WriteLine("Paso 2");

            //            using (var file = File.OpenWrite(carpetaLocal + a.ruta.Substring(carpetaRemota.Length) + "/" + a.nombre))
            //            {
            //                Console.WriteLine("Paso 3");
            //                sftp.DownloadFile(a.ruta + "/" + a.nombre, file);
            //                Console.WriteLine("Paso 4");
            //            }
            //            Console.WriteLine("Paso 5");

            //            sftp.Disconnect();
            //            Console.WriteLine("Paso 6");
            //        }

            //    }
            //    catch (Exception ex)
            //    {
            //        wl.WriteToLogFile("A: " + ex.Message);
            //    }
            //}
            //if (listaArchivos.Count == 0)
            //{
            //    wl.WriteToLogFile("Sin archivos a procesar");
            //}


            wl.WriteToLogFile("Archivos descargados...");
        }

        public static bool AcceptAllCertificatePolicy(object sender, X509Certificate certificate, X509Chain chain, SslPolicyErrors sslPolicyErrors)
        {
            return true;
        }

    }
}

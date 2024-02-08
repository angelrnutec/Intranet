using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Security;
using System.Security.Cryptography.X509Certificates;
using System.Text;
using System.Text.RegularExpressions;
//using System.Threading.Tasks;

namespace ImportMovimientosEDENRED
{
    class ftp
    {
        private string host = null;
        private string user = null;
        private string pass = null;
        private string authType = null;
        //private FtpWebRequest ftpRequest = null;
        //private FtpWebResponse ftpResponse = null;
        //private Stream ftpStream = null;
        private int bufferSize = 2048;
        private bool USE_PASSIVE = true;
        private bool KEEP_ALIVE = false;
        WriteLog wl = new WriteLog();


        //public void Dispose()
        //{
        //    // Dispose of unmanaged resources.
        //    Dispose(true);
        //    // Suppress finalization.
        //    GC.SuppressFinalize(this);
        //}

        /* Construct Object */
        public ftp(string hostIP, string userName, string password, string auth) { host = hostIP; user = userName; pass = password; authType = auth; }

        /* Download File */
        public void download(string remoteFile, string localFile)
        {
            try
            {
                //ServicePointManager.SecurityProtocol = SecurityProtocolType.Tls;
                //ServicePointManager.ServerCertificateValidationCallback = new RemoteCertificateValidationCallback(this.AcceptAllCertificatePolicy);

                /* Create an FTP Request */
                FtpWebRequest ftpRequest = (FtpWebRequest)FtpWebRequest.Create(host + remoteFile);
                /* Log in to the FTP Server with the User Name and Password Provided */
                ftpRequest.Credentials = new NetworkCredential(user, pass);
                /* When in doubt, use these options */
                ftpRequest.UseBinary = false;
                //ftpRequest.UsePassive = true;
                ftpRequest.KeepAlive = KEEP_ALIVE;
                ftpRequest.UsePassive = USE_PASSIVE;
                /* Specify the Type of FTP Request */
                ftpRequest.Method = WebRequestMethods.Ftp.DownloadFile;
                ftpRequest.Timeout = -1;
                ftpRequest.ReadWriteTimeout = -1;
                ftpRequest.Proxy = null;

                if (authType == "TLS")
                {
                    ftpRequest.EnableSsl = true;
                }

                /* Establish Return Communication with the FTP Server */
                using (var ftpResponse = (FtpWebResponse)ftpRequest.GetResponse())
                {
                    using (var ftpStream = ftpResponse.GetResponseStream())
                    {
                        FileStream localFileStream = new FileStream(localFile, FileMode.Create);
                        byte[] byteBuffer = new byte[bufferSize];
                        int bytesRead = ftpStream.Read(byteBuffer, 0, bufferSize);

                        try
                        {
                            while (bytesRead > 0)
                            {
                                localFileStream.Write(byteBuffer, 0, bytesRead);
                                bytesRead = ftpStream.Read(byteBuffer, 0, bufferSize);
                            }
                        }
                        catch (Exception ex) { Console.WriteLine(ex.ToString()); }

                        /* Resource Cleanup */
                        localFileStream.Close();
                    }
                }

                ftpRequest = null;
            }
            catch (Exception ex) { Console.WriteLine(ex.ToString()); Console.WriteLine(ex.InnerException.Message); }
            return;
        }

        public bool ftpDirectoryExists(string directoryPath)
        {
            bool IsExists = true;
            try
            {
                FtpWebRequest ftpRequest = (FtpWebRequest)WebRequest.Create(host + directoryPath);
                ftpRequest.Credentials = new NetworkCredential(user, pass);
                ftpRequest.UseBinary = true;
                ftpRequest.UsePassive = true;
                ftpRequest.KeepAlive = true;

                ftpRequest.Method = WebRequestMethods.Ftp.PrintWorkingDirectory;

                if (authType == "TLS")
                {
                    ftpRequest.EnableSsl = true;
                }

                FtpWebResponse response = (FtpWebResponse)ftpRequest.GetResponse();
            }
            catch (WebException ex)
            {
                IsExists = false;
            }
            return IsExists;
        }

        /* Upload File */
        public bool upload(string remoteFile, string localFile)
        {
            try
            {
                remoteFile = remoteFile.Replace("\\", "/").Replace("//", "/");
                localFile = localFile.Replace("\\", "/").Replace("//", "/");

                /* Create an FTP Request */
                FtpWebRequest ftpRequest = (FtpWebRequest)FtpWebRequest.Create(host + remoteFile);
                /* Log in to the FTP Server with the User Name and Password Provided */
                ftpRequest.Credentials = new NetworkCredential(user, pass);
                /* When in doubt, use these options */
                ftpRequest.UseBinary = true;
                //ftpRequest.UsePassive = true;
                ftpRequest.KeepAlive = KEEP_ALIVE;
                ftpRequest.UsePassive = USE_PASSIVE;
                /* Specify the Type of FTP Request */
                ftpRequest.Method = WebRequestMethods.Ftp.UploadFile;

                if (authType == "TLS")
                {
                    ftpRequest.EnableSsl = true;
                }

                /* Establish Return Communication with the FTP Server */
                Stream ftpStream = ftpRequest.GetRequestStream();
                /* Open a File Stream to Read the File for Upload */
                FileStream localFileStream = new FileStream(localFile, FileMode.Create);
                /* Buffer for the Downloaded Data */
                ////byte[] byteBuffer = new byte[bufferSize];
                ////int bytesSent = localFileStream.Read(byteBuffer, 0, bufferSize);
                /////* Upload the File by Sending the Buffered Data Until the Transfer is Complete */
                ////try
                ////{
                ////    while (bytesSent != 0)
                ////    {
                ////        ftpStream.Write(byteBuffer, 0, bytesSent);
                ////        bytesSent = localFileStream.Read(byteBuffer, 0, bufferSize);
                ////    }
                ////}
                ////catch (Exception ex) { Console.WriteLine(ex.ToString()); }

                try
                {
                    StreamReader sourceStream = new StreamReader(localFile);
                    byte[] fileContents = Encoding.UTF8.GetBytes(sourceStream.ReadToEnd());
                    sourceStream.Close();
                    ftpRequest.ContentLength = fileContents.Length;

                    Stream requestStream = ftpRequest.GetRequestStream();
                    requestStream.Write(fileContents, 0, fileContents.Length);
                    requestStream.Close();

                }
                catch (Exception ex) { Console.WriteLine(ex.ToString()); return false; }

                /* Resource Cleanup */
                localFileStream.Close();
                ftpStream.Close();
                ftpStream.Dispose();
                ftpStream = null;
                ftpRequest = null;
            }
            catch (Exception ex) { Console.WriteLine(ex.ToString()); return false; }
            return true;
        }

        /* Delete File */
        public void delete(string deleteFile)
        {
            try
            {
                /* Create an FTP Request */
                FtpWebRequest ftpRequest = (FtpWebRequest)WebRequest.Create(host + deleteFile);
                /* Log in to the FTP Server with the User Name and Password Provided */
                ftpRequest.Credentials = new NetworkCredential(user, pass);
                /* When in doubt, use these options */
                ftpRequest.UseBinary = true;
                //ftpRequest.UsePassive = true;
                ftpRequest.KeepAlive = true;
                ftpRequest.UsePassive = USE_PASSIVE;
                /* Specify the Type of FTP Request */
                ftpRequest.Method = WebRequestMethods.Ftp.DeleteFile;

                if (authType == "TLS")
                {
                    ftpRequest.EnableSsl = true;
                }

                /* Establish Return Communication with the FTP Server */
                FtpWebResponse ftpResponse = (FtpWebResponse)ftpRequest.GetResponse();
                /* Resource Cleanup */
                ftpResponse.Close();
//ftpResponse.Dispose();
                ftpResponse = null;
                ftpRequest = null;
            }
            catch (Exception ex) { wl.WriteToLogFile("E: " + ex.ToString()); }
            return;
        }

        /* Rename File */
        public void rename(string currentFileNameAndPath, string newFileName)
        {
            try
            {
                /* Create an FTP Request */
                FtpWebRequest ftpRequest = (FtpWebRequest)WebRequest.Create(host + currentFileNameAndPath);
                /* Log in to the FTP Server with the User Name and Password Provided */
                ftpRequest.Credentials = new NetworkCredential(user, pass);
                /* When in doubt, use these options */
                ftpRequest.UseBinary = true;
                //ftpRequest.UsePassive = true;
                ftpRequest.KeepAlive = true;
                ftpRequest.UsePassive = USE_PASSIVE;
                /* Specify the Type of FTP Request */
                ftpRequest.Method = WebRequestMethods.Ftp.Rename;

                if (authType == "TLS")
                {
                    ftpRequest.EnableSsl = true;
                }

                /* Rename the File */
                ftpRequest.RenameTo = newFileName;
                /* Establish Return Communication with the FTP Server */
                FtpWebResponse ftpResponse = (FtpWebResponse)ftpRequest.GetResponse();
                /* Resource Cleanup */
                ftpResponse.Close();
                //ftpResponse.Dispose();
                ftpResponse = null;
                ftpRequest = null;
            }
            catch (Exception ex) { Console.WriteLine(ex.ToString()); }
            return;
        }

        /* Backup File */
        public void backuplocal(string currentFileNameAndPath, string destination)
        {
            //try
            //{
            //    /* Create an FTP Request */
            //    ftpRequest = (FtpWebRequest)WebRequest.Create(host + currentFileNameAndPath);
            //    /* Log in to the FTP Server with the User Name and Password Provided */
            //    ftpRequest.Credentials = new NetworkCredential(user, pass);
            //    /* When in doubt, use these options */
            //    ftpRequest.UseBinary = true;
            //    ftpRequest.UsePassive = true;
            //    ftpRequest.KeepAlive = true;
            //    /* Specify the Type of FTP Request */
            //    ftpRequest.Method = WebRequestMethods.Ftp.Rename;

            //    if (authType == "TLS")
            //    {
            //        ftpRequest.EnableSsl = true;
            //    }

            //    /* Rename the File */
            //    ftpRequest.RenameTo = newFileName;
            //    /* Establish Return Communication with the FTP Server */
            //    ftpResponse = (FtpWebResponse)ftpRequest.GetResponse();
            //    /* Resource Cleanup */
            //    ftpResponse.Close();
            //    ftpRequest = null;
            //}
            //catch (Exception ex) { Console.WriteLine(ex.ToString()); }
            //return;
        }

        /* Create a New Directory on the FTP Server */
        public void createDirectory(string newDirectory)
        {
            try
            {
                /* Create an FTP Request */
                FtpWebRequest ftpRequest = (FtpWebRequest)WebRequest.Create(host + newDirectory);
                /* Log in to the FTP Server with the User Name and Password Provided */
                ftpRequest.Credentials = new NetworkCredential(user, pass);
                /* When in doubt, use these options */
                ftpRequest.UseBinary = true;
                //ftpRequest.UsePassive = true;
                ftpRequest.KeepAlive = true;
                ftpRequest.UsePassive = USE_PASSIVE;
                /* Specify the Type of FTP Request */
                ftpRequest.Method = WebRequestMethods.Ftp.MakeDirectory;

                if (authType == "TLS")
                {
                    ftpRequest.EnableSsl = true;
                }

                /* Establish Return Communication with the FTP Server */
                FtpWebResponse ftpResponse = (FtpWebResponse)ftpRequest.GetResponse();
                /* Resource Cleanup */
                ftpResponse.Close();
                //ftpResponse.Dispose();
                ftpResponse = null;
                ftpRequest = null;
            }
            catch (Exception ex) { Console.WriteLine(ex.ToString()); }
            return;
        }

        /* Get the Date/Time a File was Created */
        public string getFileCreatedDateTime(string fileName)
        {
            try
            {
                /* Create an FTP Request */
                FtpWebRequest ftpRequest = (FtpWebRequest)FtpWebRequest.Create(host + fileName);
                /* Log in to the FTP Server with the User Name and Password Provided */
                ftpRequest.Credentials = new NetworkCredential(user, pass);
                /* When in doubt, use these options */
                ftpRequest.UseBinary = true;
                //ftpRequest.UsePassive = true;
                ftpRequest.KeepAlive = true;
                ftpRequest.UsePassive = USE_PASSIVE;
                /* Specify the Type of FTP Request */
                ftpRequest.Method = WebRequestMethods.Ftp.GetDateTimestamp;

                if (authType == "TLS")
                {
                    ftpRequest.EnableSsl = true;
                }

                /* Establish Return Communication with the FTP Server */
                FtpWebResponse ftpResponse = (FtpWebResponse)ftpRequest.GetResponse();
                /* Establish Return Communication with the FTP Server */
                Stream ftpStream = ftpResponse.GetResponseStream();
                /* Get the FTP Server's Response Stream */
                StreamReader ftpReader = new StreamReader(ftpStream);
                /* Store the Raw Response */
                string fileInfo = null;
                /* Read the Full Response Stream */
                try { fileInfo = ftpReader.ReadToEnd(); }
                catch (Exception ex) { Console.WriteLine(ex.ToString()); }
                /* Resource Cleanup */
                ftpReader.Close();
                ftpStream.Close();
                ftpStream.Dispose();
                ftpStream = null;
                ftpResponse.Close();
                //ftpResponse.Dispose();
                ftpResponse = null;
                ftpRequest = null;
                /* Return File Created Date Time */
                return fileInfo;
            }
            catch (Exception ex) { Console.WriteLine(ex.ToString()); }
            /* Return an Empty string Array if an Exception Occurs */
            return "";
        }

        /* Get the Size of a File */
        public string getFileSize(string fileName)
        {
            try
            {
                /* Create an FTP Request */
                FtpWebRequest ftpRequest = (FtpWebRequest)FtpWebRequest.Create(host + fileName);
                /* Log in to the FTP Server with the User Name and Password Provided */
                ftpRequest.Credentials = new NetworkCredential(user, pass);
                /* When in doubt, use these options */
                ftpRequest.UseBinary = true;
                //ftpRequest.UsePassive = true;
                ftpRequest.KeepAlive = true;
                ftpRequest.UsePassive = USE_PASSIVE;
                /* Specify the Type of FTP Request */
                ftpRequest.Method = WebRequestMethods.Ftp.GetFileSize;

                if (authType == "TLS")
                {
                    ftpRequest.EnableSsl = true;
                }

                /* Establish Return Communication with the FTP Server */
                FtpWebResponse ftpResponse = (FtpWebResponse)ftpRequest.GetResponse();
                /* Establish Return Communication with the FTP Server */
                Stream ftpStream = ftpResponse.GetResponseStream();
                /* Get the FTP Server's Response Stream */
                StreamReader ftpReader = new StreamReader(ftpStream);
                /* Store the Raw Response */
                string fileInfo = null;
                /* Read the Full Response Stream */
                try { while (ftpReader.Peek() != -1) { fileInfo = ftpReader.ReadToEnd(); } }
                catch (Exception ex) { Console.WriteLine(ex.ToString()); }
                /* Resource Cleanup */
                ftpReader.Close();
                ftpStream.Close();
                ftpStream.Dispose();
                ftpStream = null;
                ftpResponse.Close();
                //ftpResponse.Dispose();
                ftpResponse = null;
                ftpRequest = null;
                /* Return File Size */
                return fileInfo;
            }
            catch (Exception ex) { Console.WriteLine(ex.ToString()); }
            /* Return an Empty string Array if an Exception Occurs */
            return "";
        }

        /* List Directory Contents File/Folder Name Only */
        public string[] directoryListSimple(string directory)
        {
            try
            {
                /* Create an FTP Request */
                FtpWebRequest ftpRequest = (FtpWebRequest)FtpWebRequest.Create(host + directory);
                /* Log in to the FTP Server with the User Name and Password Provided */
                ftpRequest.Credentials = new NetworkCredential(user, pass);
                /* When in doubt, use these options */
                ftpRequest.UseBinary = true;
                //ftpRequest.UsePassive = true;
                ftpRequest.KeepAlive = true;
                ftpRequest.UsePassive = USE_PASSIVE;
                /* Specify the Type of FTP Request */
                ftpRequest.Method = WebRequestMethods.Ftp.ListDirectory;

                if (authType == "TLS")
                {
                    ftpRequest.EnableSsl = true;
                }

                /* Establish Return Communication with the FTP Server */
                FtpWebResponse ftpResponse = (FtpWebResponse)ftpRequest.GetResponse();
                /* Establish Return Communication with the FTP Server */
                Stream ftpStream = ftpResponse.GetResponseStream();
                /* Get the FTP Server's Response Stream */
                StreamReader ftpReader = new StreamReader(ftpStream);
                /* Store the Raw Response */
                string directoryRaw = null;
                /* Read Each Line of the Response and Append a Pipe to Each Line for Easy Parsing */
                try { while (ftpReader.Peek() != -1) { directoryRaw += ftpReader.ReadLine() + "|"; } }
                catch (Exception ex) { Console.WriteLine(ex.ToString()); }
                /* Resource Cleanup */
                ftpReader.Close();
                ftpStream.Close();
                ftpStream.Dispose();
                ftpStream = null;
                ftpResponse.Close();
                //ftpResponse.Dispose();
                ftpResponse = null;
                ftpRequest = null;
                /* Return the Directory Listing as a string Array by Parsing 'directoryRaw' with the Delimiter you Append (I use | in This Example) */
                try { string[] directoryList = directoryRaw.Split("|".ToCharArray()); return directoryList; }
                catch (Exception ex) { Console.WriteLine(ex.ToString()); }
            }
            catch (Exception ex) { Console.WriteLine(ex.ToString()); }
            /* Return an Empty string Array if an Exception Occurs */
            return new string[] { "" };
        }

        /* List Directory Contents in Detail (Name, Size, Created, etc.) */
        public string[] directoryListDetailed(string directory)
        {
            try
            {
                /* Create an FTP Request */
                FtpWebRequest ftpRequest = (FtpWebRequest)FtpWebRequest.Create(host + directory);
                /* Log in to the FTP Server with the User Name and Password Provided */
                ftpRequest.Credentials = new NetworkCredential(user, pass);
                /* When in doubt, use these options */
                ftpRequest.UseBinary = true;
                //ftpRequest.UsePassive = true;
                ftpRequest.KeepAlive = true;
                ftpRequest.UsePassive = USE_PASSIVE;
                /* Specify the Type of FTP Request */
                ftpRequest.Method = WebRequestMethods.Ftp.ListDirectoryDetails;

                if (authType == "TLS")
                {
                    ftpRequest.EnableSsl = true;
                }

                /* Establish Return Communication with the FTP Server */
                FtpWebResponse ftpResponse = (FtpWebResponse)ftpRequest.GetResponse();
                /* Establish Return Communication with the FTP Server */
                Stream ftpStream = ftpResponse.GetResponseStream();
                /* Get the FTP Server's Response Stream */
                StreamReader ftpReader = new StreamReader(ftpStream);
                /* Store the Raw Response */
                string directoryRaw = null;
                /* Read Each Line of the Response and Append a Pipe to Each Line for Easy Parsing */
                try { while (ftpReader.Peek() != -1) { directoryRaw += ftpReader.ReadLine() + "|"; } }
                catch (Exception ex) { Console.WriteLine(ex.ToString()); }
                /* Resource Cleanup */
                ftpReader.Close();
                ftpStream.Close();
                ftpStream.Dispose();
                ftpStream = null;
                ftpResponse.Close();
                //ftpResponse.Dispose();
                ftpResponse = null;
                ftpRequest = null;
                /* Return the Directory Listing as a string Array by Parsing 'directoryRaw' with the Delimiter you Append (I use | in This Example) */
                try
                {
                    string[] directoryList = directoryRaw.Split("|".ToCharArray());
                    return directoryList;
                }
                catch (Exception ex) { Console.WriteLine(ex.ToString()); }
            }
            catch (Exception ex) { Console.WriteLine(ex.ToString()); }
            /* Return an Empty string Array if an Exception Occurs */
            return new string[] { "" };
        }

        /* List Directory Contents in Detail (Name, Size, Created, etc.) */
        public List<ArchivosFtp> listaArchivos(string directory)
        {
            List<ArchivosFtp> lista = new List<ArchivosFtp>();
            try
            {

                /* Create an FTP Request */
                FtpWebRequest ftpRequest = (FtpWebRequest)FtpWebRequest.Create(host + directory);
                /* Log in to the FTP Server with the User Name and Password Provided */
                ftpRequest.Credentials = new NetworkCredential(user, pass);
                /* When in doubt, use these options */
                ftpRequest.UseBinary = true;
                //ftpRequest.UsePassive = true;
                ftpRequest.KeepAlive = KEEP_ALIVE;
                ftpRequest.UsePassive = USE_PASSIVE;
                /* Specify the Type of FTP Request */
                ftpRequest.Method = WebRequestMethods.Ftp.ListDirectoryDetails;

                if (authType == "TLS")
                {
                    ftpRequest.EnableSsl = true;
                }

                string directoryRaw = null;
                /* Establish Return Communication with the FTP Server */
                using (var ftpResponse = (FtpWebResponse)ftpRequest.GetResponse())
                {
                    /* Establish Return Communication with the FTP Server */
                    using (var ftpStream = ftpResponse.GetResponseStream())
                    {
                        StreamReader ftpReader = new StreamReader(ftpStream);
                        try { while (ftpReader.Peek() != -1) { directoryRaw += ftpReader.ReadLine() + "|"; } }
                        catch (Exception ex) { wl.WriteToLogFile("B: " + ex.ToString()); }
                        /* Resource Cleanup */
                        ftpReader.Close();
                    }                    
                }
                ftpRequest = null;

                /* Return the Directory Listing as a string Array by Parsing 'directoryRaw' with the Delimiter you Append (I use | in This Example) */
                try
                {
                    if (directoryRaw != null)
                    {
                        string[] directoryList = directoryRaw.Split('|');
                        foreach (string line in directoryList)
                        {
                            string regex =
@"^" +                          //# Start of line
@"(?<dir>[\-ld])" +             //# File size          
@"(?<permission>[\-rwx]{9})" +  //# Whitespace          \n
@"\s+" +                        //# Whitespace          \n
@"(?<filecode>\d+)" +
@"\s+" +                        //# Whitespace          \n
@"(?<owner>\w+)" +
@"\s+" +                        //# Whitespace          \n
@"(?<group>\w+)" +
@"\s+" +                        //# Whitespace          \n
@"(?<size>\d+)" +
@"\s+" +                        //# Whitespace          \n
@"(?<month>\w{3})" +            //# Month (3 letters)   \n
@"\s+" +                        //# Whitespace          \n
@"(?<day>\d{1,2})" +            //# Day (1 or 2 digits) \n
@"\s+" +                        //# Whitespace          \n
@"(?<timeyear>[\d:]{4,5})" +    //# Time or year        \n
@"\s+" +                        //# Whitespace          \n
@"(?<filename>(.*))" +          //# Filename            \n
@"$";                           //# End of line


                            var split = new Regex(regex).Match(line);
                            string dir = split.Groups["dir"].ToString();
                            string filename = split.Groups["filename"].ToString();
                            bool isDirectory = dir != null && dir.Trim() != "" && dir.Equals("d", StringComparison.OrdinalIgnoreCase);

                            //Console.WriteLine("dir:" + dir);
                            //Console.WriteLine("filename:" + filename);
                            //Console.WriteLine("isDirectory:" + isDirectory);

                            if (!isDirectory && filename.Length > 0)
                            {
                                ArchivosFtp a = new ArchivosFtp();
                                a.nombre = filename;
                                a.ruta = directory;
                                lista.Add(a);
                            }

                            //if (dir.Length > 24)
                            //{
                            //    if (dir.Substring(24, 5) == "<DIR>")
                            //    {
                            //        List<ArchivosFtp> l = listaArchivos(directory + "/" + dir.Substring(dir.Length - 36));
                            //        if (l.Count > 0)
                            //        {
                            //            lista.AddRange(l);
                            //        }
                            //    }
                            //    else
                            //    {
                            //        ArchivosFtp a = new ArchivosFtp();
                            //        a.nombre = dir.Substring(dir.Length - 36);
                            //        a.ruta = directory;
                            //        lista.Add(a);
                            //    }
                            //}
                        }
                    }
                }
                catch (Exception ex) { wl.WriteToLogFile("C: " + ex.ToString()); }
            }
            catch (Exception ex) { wl.WriteToLogFile("D: " + ex.ToString()); }
            /* Return an Empty string Array if an Exception Occurs */
            return lista;
        }

        public List<ArchivosFtp> listaArchivosLocal(string directory)
        {
            List<ArchivosFtp> lista = new List<ArchivosFtp>();
            try
            {
                foreach (string f in Directory.GetFiles(directory))
                {
                    ArchivosFtp a = new ArchivosFtp();
                    a.nombre = f.Substring(directory.Length);
                    a.ruta = directory;
                    lista.Add(a);

                }
                foreach (string d in Directory.GetDirectories(directory))
                {
                    foreach (string f in Directory.GetFiles(d))
                    {
                        ArchivosFtp a = new ArchivosFtp();
                        a.nombre = f.Substring(d.Length);
                        a.ruta = d;
                        lista.Add(a);

                    }
                    listaArchivosLocal(d);
                }
            }
            catch (Exception ex) { wl.WriteToLogFile("C: " + ex.ToString()); }
            /* Return an Empty string Array if an Exception Occurs */
            return lista;
        }

    }


    public class ArchivosFtp
    {
        public string nombre;
        public string ruta;
        public int registros_procesados;
        public bool existia;
    }
}

using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
//using System.Threading.Tasks;

namespace ImportMovimientosEDENRED
{
    public class WriteLog
    {
        const int MaxLogSize = 2000000;
        const string LogName = "ImportMovimientosEDENRED";
        public void WriteToLogFile(string msg)
        {
            Console.WriteLine(msg);
            try
            {
                //check and make the directory if necessary; this is set to look in    the application folder, you may wish to place the error log in    another location depending upon the user's role and write access to    different areas of the file system
                if (!System.IO.Directory.Exists(AppDomain.CurrentDomain.BaseDirectory + "\\log\\"))
                {
                    System.IO.Directory.CreateDirectory(AppDomain.CurrentDomain.BaseDirectory + "\\log\\");
                }

                if (GetLogSize(AppDomain.CurrentDomain.BaseDirectory + "\\log\\" + LogName + ".log") > MaxLogSize)
                {
                    string FileToCopy = null;
                    string NewCopy = null;

                    FileToCopy = AppDomain.CurrentDomain.BaseDirectory + "\\log\\" + LogName + ".log";
                    NewCopy = AppDomain.CurrentDomain.BaseDirectory + "\\log\\" + LogName + "_" + System.DateTime.Now.ToString("yyyyMMddHH") + ".old.log";

                    if (System.IO.File.Exists(FileToCopy) == true)
                    {
                        System.IO.File.Copy(FileToCopy, NewCopy);
                        System.IO.File.Delete(FileToCopy);
                    }
                }

                //check the file
                FileStream fs = new FileStream(AppDomain.CurrentDomain.BaseDirectory + "\\log\\" + LogName + ".log", FileMode.OpenOrCreate, FileAccess.ReadWrite);
                StreamWriter s = new StreamWriter(fs);
                s.Close();
                fs.Close();

                //log it
                FileStream fs1 = new FileStream(AppDomain.CurrentDomain.BaseDirectory + "\\log\\" + LogName + ".log", FileMode.Append, FileAccess.Write);
                StreamWriter s1 = new StreamWriter(fs1);
                s1.WriteLine(DateTime.Now.ToString("yyyy-MM-dd HH:mm") + "\t\t" + msg);
                s1.Close();
                fs1.Close();

            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        private long GetLogSize(string filespec)
        {
            if (File.Exists(filespec))
            {
                FileInfo MyFile = new FileInfo(filespec);
                long FileSize = MyFile.Length;
                return FileSize;
            }
            else
            {
                return 1;
            }
        }
    }
}

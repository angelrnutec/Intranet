using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Text;
//using System.Threading.Tasks;

namespace ImportMovimientosEDENRED
{
    public class SendMail
    {
        private string _host = "";
        private string _usuario = "";
        private string _password = "";
        private string _puerto = "";
        public SendMail(string host, string usuario, string password, string puerto)
        {
            _host = host;
            _usuario = usuario;
            _password = password;
            _puerto = puerto;
        }

        public string Send(string @from, string to, string bcc, string subject, string message, string email_copia_1, string email_copia_2, string rutaAttachments = "", string strAttachments = "")
        {
            string mensajeResultado = "";
            try
            {
                System.Net.Mail.MailMessage correo = new System.Net.Mail.MailMessage();
                correo.From = new System.Net.Mail.MailAddress(@from);
                //correo.To.Add([to])

                to = to.Replace(",", ";");

                string[] strTo2 = to.Split(';');
                foreach (string strSplit in strTo2)
                {
                    if (strSplit.Trim().Length > 0)
                    {
                        try
                        {
                            correo.To.Add(new MailAddress(strSplit.Trim()));
                        }
                        catch (Exception ex)
                        {
                            throw new Exception(ex.Message);
                        }
                    }
                }

                if (email_copia_1.Trim().Length > 0)
                {
                    correo.CC.Add(email_copia_1);
                }
                if (email_copia_2.Trim().Length > 0)
                {
                    correo.CC.Add(email_copia_2);
                }
                if (bcc.Trim().Length > 0)
                {
                    correo.Bcc.Add(bcc);
                }
                correo.Subject = subject;
                correo.Body = message;

                correo.IsBodyHtml = true;

                if (!strAttachments.Equals(string.Empty))
                {
                    string strFile = null;
                    string[] strAttach = strAttachments.Split(',');

                    foreach (string strFile_loopVariable in strAttach)
                    {
                        strFile = strFile_loopVariable;
                        if (strFile.Trim().Length > 0)
                        {
                            correo.Attachments.Add(new Attachment(rutaAttachments + strFile.Trim()));

                        }
                    }
                }

                correo.Priority = System.Net.Mail.MailPriority.Normal;
                //System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient();
                //smtp.Host = _host;
                //smtp.Credentials = new System.Net.NetworkCredential(_usuario, _password);
                //smtp.EnableSsl = false;
                //smtp.Port = Convert.ToInt16(_puerto);

                //smtp.Send(correo);
                //smtp.Dispose();

                try
                {
                    //using (SmtpClient client = new SmtpClient())
                    //{
                    //    client.Host = _host;
                    //    client.Credentials = new System.Net.NetworkCredential(_usuario, _password);
                    //    client.EnableSsl = false;
                    //    client.Port = Convert.ToInt16(_puerto);
                    //    client.Send(correo);
                    //    client.Dispose();
                    //}
                }
                catch (Exception ex)
                {
                    mensajeResultado = ex.Message;
                }
                finally
                {
                    foreach (Attachment attachment in correo.Attachments)
                    {
                        attachment.Dispose();
                    }
                    correo.Attachments.Dispose();
                    correo = null;

                }

                mensajeResultado = "OK";
            }
            catch (Exception ex)
            {
                mensajeResultado = ex.Message;
            }
            return mensajeResultado;
        }

        public string SendAttachments(string @from, string to, string bcc, string subject, string message, string email_copia_1, string email_copia_2, string file_name, System.IO.Stream file)
        {
            try
            {
                System.Net.Mail.MailMessage correo = new System.Net.Mail.MailMessage();
                correo.From = new System.Net.Mail.MailAddress(@from);
                //correo.To.Add([to])

                string[] strTo2 = to.Split(',');
                foreach (string strSplit in strTo2)
                {
                    if (strSplit.Trim().Length > 0)
                    {
                        try
                        {
                            correo.To.Add(new MailAddress(strSplit.Trim()));
                        }
                        catch (Exception ex)
                        {
                            throw new Exception(ex.Message);
                        }
                    }
                }

                if (email_copia_1.Trim().Length > 0)
                {
                    correo.CC.Add(email_copia_1);
                }
                if (email_copia_2.Trim().Length > 0)
                {
                    correo.CC.Add(email_copia_2);
                }
                if (bcc.Trim().Length > 0)
                {
                    correo.Bcc.Add(bcc);
                }
                correo.Subject = subject;
                correo.Body = message;

                correo.IsBodyHtml = true;

                if ((file != null))
                {
                    correo.Attachments.Add(new Attachment(file, file_name));
                }

                correo.Priority = System.Net.Mail.MailPriority.Normal;
                System.Net.Mail.SmtpClient smtp = new System.Net.Mail.SmtpClient();
                smtp.Host = _host;
                smtp.Credentials = new System.Net.NetworkCredential(_usuario, _password);
                smtp.EnableSsl = false;
                smtp.Port = Convert.ToInt16(_puerto);

                smtp.Send(correo);
                return "OK";
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}

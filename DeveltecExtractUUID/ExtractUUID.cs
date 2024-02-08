using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml;
using System.Xml.XPath;

namespace DeveltecExtractUUID
{
    public class ExtractUUID
    {

        public static string GetUUID(string file)
        {
            string UUID = "";
            string version = "";

            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);


                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");
                XmlNodeList xComplemento = ((XmlElement)xComprobante[0]).GetElementsByTagName("cfdi:Complemento");
                XmlNodeList xTimbre = ((XmlElement)xComplemento[0]).GetElementsByTagName("tfd:TimbreFiscalDigital");


                foreach (XmlElement nodo in xComprobante)
                {
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "version")
                        {
                            version = a.Value;
                            break;
                        }
                    }
                }

                foreach (XmlElement nodo in xTimbre)
                {
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "uuid")
                        {
                            UUID = a.Value;
                            break;
                        }
                    }
                }

                if (version != "3.2" && version != "3.3" && version != "4.0")
                {
                    return "Error: Version de CFDI no válida";
                }

            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }

            return UUID;
        }



        public static string GetNoCertificadoSat(string file)
        {
            string no_certificado_sat = "";

            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);


                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");
                XmlNodeList xComplemento = ((XmlElement)xComprobante[0]).GetElementsByTagName("cfdi:Complemento");
                XmlNodeList xTimbre = ((XmlElement)xComplemento[0]).GetElementsByTagName("tfd:TimbreFiscalDigital");


                foreach (XmlElement nodo in xTimbre)
                {
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "nocertificadosat")
                        {
                            no_certificado_sat = a.Value;
                            break;
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }

            return no_certificado_sat;
        }


        public static string GetFechaTimbrado(string file)
        {
            string fecha = "";

            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);

                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");
                XmlNodeList xComplemento = ((XmlElement)xComprobante[0]).GetElementsByTagName("cfdi:Complemento");
                XmlNodeList xTimbre = ((XmlElement)xComplemento[0]).GetElementsByTagName("tfd:TimbreFiscalDigital");

                foreach (XmlElement nodo in xTimbre)
                {
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "fechatimbrado")
                        {
                            fecha = a.Value;
                            break;
                        }
                    }
                }

            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }

            return fecha;
        }


        public static string GetFechaFactura(string file)
        {
            string fecha = "";
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);

                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");

                foreach (XmlElement nodo in xComprobante)
                {
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "fecha")
                        {
                            fecha = a.Value;
                            break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }

            return fecha;
        }

        public static string GetNoCertificado(string file)
        {
            string no_certificado = "";
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);

                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");

                foreach (XmlElement nodo in xComprobante)
                {
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "nocertificado")
                        {
                            no_certificado = a.Value;
                            break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }

            return no_certificado;
        }

        public static string GetMetodoPago(string file)
        {
            string metodo_pago = "";
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);

                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");

                foreach (XmlElement nodo in xComprobante)
                {
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "metodopago")
                        {
                            metodo_pago = a.Value;
                            break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }

            return metodo_pago;
        }

        public static string GetVersion(string file)
        {
            string version = "";

            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);


                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");
                XmlNodeList xComplemento = ((XmlElement)xComprobante[0]).GetElementsByTagName("cfdi:Complemento");
                XmlNodeList xTimbre = ((XmlElement)xComplemento[0]).GetElementsByTagName("tfd:TimbreFiscalDigital");


                foreach (XmlElement nodo in xComprobante)
                {
                    version = nodo.GetAttribute("version");
                }

                if (version != "3.2" && version != "3.3" && version != "4.0")
                {
                    return "Error: Version de CFDI no válida";
                }

            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }

            return version;
        }

        public static string GetImporteTotal(string file)
        {
            string importe = "";
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);


                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");
                XmlNodeList xComplemento = ((XmlElement)xComprobante[0]).GetElementsByTagName("cfdi:Complemento");
                XmlNodeList xTimbre = ((XmlElement)xComplemento[0]).GetElementsByTagName("tfd:TimbreFiscalDigital");


                foreach (XmlElement nodo in xComprobante)
                {
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "total")
                        {
                            importe = a.Value;
                            break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }

            return importe;
        }

        public static string GetImporteSubTotal(string file)
        {
            string importe = "";

            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);


                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");
                XmlNodeList xComplemento = ((XmlElement)xComprobante[0]).GetElementsByTagName("cfdi:Complemento");


                foreach (XmlElement nodo in xComprobante)
                {
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "subtotal")
                        {
                            importe = a.Value;
                            break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }

            return importe;
        }

        public static string GetImporteIVA(string file)
        {
            string texto = "";
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);


                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");
                XmlNodeList xImpuestos = ((XmlElement)xComprobante[0]).GetElementsByTagName("cfdi:Impuestos");

                if (xImpuestos == null)
                {
                    return "";
                }

                foreach (XmlElement nodo in xImpuestos)
                {
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "totalimpuestostrasladados")
                        {
                            texto = a.Value;
                            break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }

            return texto;
        }

        public static string GetEmisorRFC(string file)
        {
            string texto = "";
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);


                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");
                XmlNodeList xEmisor = ((XmlElement)xComprobante[0]).GetElementsByTagName("cfdi:Emisor");

                foreach (XmlElement nodo in xEmisor)
                {
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "rfc")
                        {
                            texto = a.Value;
                            break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }

            return texto;
        }

        public static string GetEmisorNombre(string file)
        {
            string texto = "";
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);


                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");
                XmlNodeList xEmisor = ((XmlElement)xComprobante[0]).GetElementsByTagName("cfdi:Emisor");

                foreach (XmlElement nodo in xEmisor)
                {
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "nombre")
                        {
                            texto = a.Value;
                            break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }

            return texto;
        }

        public static string GetReceptorRFC(string file)
        {
            string texto = "";
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);


                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");
                XmlNodeList xReceptor = ((XmlElement)xComprobante[0]).GetElementsByTagName("cfdi:Receptor");

                foreach (XmlElement nodo in xReceptor)
                {
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "rfc")
                        {
                            texto = a.Value;
                            break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }

            return texto;
        }


        public static int GetCantidadPartidas(string file)
        {
            int resultado = 0;
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);


                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");
                XmlNodeList xConceptos = ((XmlElement)xComprobante[0]).GetElementsByTagName("cfdi:Conceptos");
                XmlNodeList xConcepto = ((XmlElement)xConceptos[0]).GetElementsByTagName("cfdi:Concepto");


                foreach (XmlElement nodo in xConcepto)
                {
                    resultado++;
                }
            }
            catch (Exception ex)
            {
                return 0;
            }

            return resultado;
        }

        public static decimal GetCantidadPiezas(string file, string[] codigo_sat)
        {
            decimal resultado = 0;
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);


                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");
                XmlNodeList xConceptos = ((XmlElement)xComprobante[0]).GetElementsByTagName("cfdi:Conceptos");
                XmlNodeList xConcepto = ((XmlElement)xConceptos[0]).GetElementsByTagName("cfdi:Concepto");


                foreach (XmlElement nodo in xConcepto)
                {
                    string ClaveProdServ = "";
                    decimal cantidad = 0;
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "cantidad")
                            cantidad = decimal.Parse(a.Value);
                        if (a.Name.ToLower() == "claveprodserv")
                            ClaveProdServ = a.Value;
                    }
                    if (codigo_sat == null || codigo_sat.Contains(ClaveProdServ))
                        resultado += cantidad;
                }
            }
            catch (Exception ex)
            {
                return 0;
            }

            return resultado;
        }

        public static string GetReceptorNombre(string file)
        {
            string texto = "";
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);


                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");
                XmlNodeList xReceptor = ((XmlElement)xComprobante[0]).GetElementsByTagName("cfdi:Receptor");

                foreach (XmlElement nodo in xReceptor)
                {
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "nombre")
                        {
                            texto = a.Value;
                            break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }

            return texto;
        }

        public static string GetMoneda(string file)
        {
            string moneda = "";
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);

                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");

                foreach (XmlElement nodo in xComprobante)
                {
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "moneda")
                        {
                            moneda = a.Value;
                            break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }

            return moneda;
        }

        public static string GetTipoComprobante(string file)
        {
            string tipodecomprobante = "";
            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);

                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");

                foreach (XmlElement nodo in xComprobante)
                {
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "tipodecomprobante")
                        {
                            tipodecomprobante = a.Value;
                            break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }

            return tipodecomprobante;
        }


        public static string GetSerie(string file)
        {
            string serie = "";

            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);

                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");

                foreach (XmlElement nodo in xComprobante)
                {
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "serie")
                        {
                            serie = a.Value;
                            break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }

            return serie;
        }

        public static string GetFolio(string file)
        {
            string serie = "";

            try
            {
                XmlDocument doc = new XmlDocument();
                doc.Load(file);

                XmlNodeList xComprobante = doc.GetElementsByTagName("cfdi:Comprobante");

                foreach (XmlElement nodo in xComprobante)
                {
                    foreach (XmlAttribute a in nodo.Attributes)
                    {
                        if (a.Name.ToLower() == "folio")
                        {
                            serie = a.Value;
                            break;
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }

            return serie;
        }


        public static DatosFactura GetDatosFactura(string file, string[] claves_sat = null)
        {
            DatosFactura df = new DatosFactura();
            try
            {
                df.emisor_nombre = GetEmisorNombre(file);
                df.emisor_rfc = GetEmisorRFC(file);
                df.receptor_nombre = GetReceptorNombre(file);
                df.receptor_rfc = GetReceptorRFC(file);
                df.tipo_comprobante = GetTipoComprobante(file);
                df.moneda = GetMoneda(file);
                df.uuid = GetUUID(file);
                df.serie = GetSerie(file);
                df.folio = GetFolio(file);
                df.no_certificado = GetNoCertificado(file);
                df.no_certificado_sat = GetNoCertificadoSat(file);
                df.metodo_pago = GetMetodoPago(file);

                string fecha_timbrado = GetFechaTimbrado(file);
                df.fecha_timbrado = new DateTime(int.Parse(fecha_timbrado.Substring(0, 4)), int.Parse(fecha_timbrado.Substring(5, 2)), int.Parse(fecha_timbrado.Substring(8, 2)), int.Parse(fecha_timbrado.Substring(11, 2)), int.Parse(fecha_timbrado.Substring(14, 2)), int.Parse(fecha_timbrado.Substring(17, 2)));

                string fecha = GetFechaFactura(file);
                df.fecha = new DateTime(int.Parse(fecha.Substring(0, 4)), int.Parse(fecha.Substring(5, 2)), int.Parse(fecha.Substring(8, 2)));

                string subtotal = GetImporteSubTotal(file);
                if (subtotal != "")
                    df.subtotal = decimal.Parse(subtotal);

                string impuestos = GetImporteIVA(file);
                if (impuestos != "")
                    df.impuestos = decimal.Parse(impuestos);

                string total = GetImporteTotal(file);
                if (total != "")
                    df.total = decimal.Parse(total);


                df.cantidad_partidas = GetCantidadPartidas(file);
                df.cantidad_piezas = GetCantidadPiezas(file, claves_sat);

            }
            catch (Exception ex)
            {
                df.error = "Error al extraer datos de la factura: " + ex.Message;
            }

            return df;
        }

    }

    public class DatosFactura
    {
        public string emisor_nombre { get; set; }
        public string emisor_rfc { get; set; }
        public string receptor_nombre { get; set; }
        public string receptor_rfc { get; set; }
        public string moneda { get; set; }
        public string tipo_comprobante { get; set; }
        public decimal subtotal { get; set; }
        public decimal impuestos { get; set; }
        public decimal total { get; set; }
        public string uuid { get; set; }
        public string serie { get; set; }
        public string folio { get; set; }
        public string error { get; set; }
        public DateTime fecha { get; set; }
        public int cantidad_partidas { get; set; }
        public decimal cantidad_piezas { get; set; }


        public string no_certificado_sat { get; set; }
        public string no_certificado { get; set; }
        public DateTime fecha_timbrado { get; set; }
        public string metodo_pago { get; set; }
    }
}

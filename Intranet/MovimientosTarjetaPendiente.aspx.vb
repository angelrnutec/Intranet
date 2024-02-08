Imports IntranetBL
Imports Intranet.LocalizationIntranet

Public Class MovimientosTarjetaPendiente
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Call CargaMovimientos(Request.QueryString("id"))
        End If
    End Sub

    Protected Sub CargaMovimientos(id As Integer)

    End Sub


    Protected Function RecuperaListadoConceptos(id_empresa As Integer, tipo_comprobacion As String, tipo_solicitud As String) As List(Of ListadoGenerico)
        Dim listado As New List(Of ListadoGenerico)

        Dim conceptos As New ConceptoGasto(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))

        Dim dt As DataTable = conceptos.Recupera(tipo_solicitud, tipo_comprobacion, id_empresa)
        For Each dr As DataRow In dt.Rows
            Dim strValor As String = dr("id_concepto") & "|" & dr("es_iva_editable") & "|" & dr("requiere_retencion") & "|" & dr("permite_propina")
            listado.Add(New ListadoGenerico(strValor, dr(TranslateLocale.text("descripcion"))))
        Next

        Return listado
    End Function


    Protected Function RecuperaListadoTipoComprobacion(id_empresa As Integer, tipo_comprobacion As String) As List(Of ListadoGenerico)
        Dim listado As New List(Of ListadoGenerico)

        If tipo_comprobacion = "CC" Then
            Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
            Dim dt As DataTable = combos.RecuperaCentroCosto(id_empresa, TranslateLocale.text("-- Seleccione --"), 0)
            For Each dr As DataRow In dt.Rows
                listado.Add(New ListadoGenerico(dr("id_centro_costo"), dr("desc_combo")))
            Next

        ElseIf tipo_comprobacion = "OI" Then
            Try
                Dim sap As New ConsultasSAP()
                Dim dtOI As DataTable = sap.RecuperaOrdenesInternas(id_empresa)
                dtOI.Rows.Add(TranslateLocale.text(" -- Seleccione --"))
                dtOI.Rows.Add(" OI Manual")
                dtOI.AcceptChanges()

                Dim dvOI As DataView = New DataView(dtOI)
                dvOI.Sort = "AUFNR"

                For Each dr As DataRow In dvOI.ToTable.Rows
                    listado.Add(New ListadoGenerico(dr("AUFNR"), dr("AUFNR")))
                Next
            Catch ex As Exception
                'ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Error al conectar con SAP. Intente mas tarde.');</script>", False)
            End Try

        ElseIf tipo_comprobacion = "PP" Then
            Try
                Dim sap As New ConsultasSAP()
                Dim dtPEP As DataTable = sap.RecuperaElementoPEP(id_empresa)
                dtPEP.Rows.Add("", TranslateLocale.text(" -- Seleccione --"))
                dtPEP.AcceptChanges()

                Dim dvEP As DataView = New DataView(dtPEP)
                dvEP.Sort = "POSKI"

                For Each dr As DataRow In dvEP.ToTable.Rows
                    listado.Add(New ListadoGenerico(dr("POSKI"), dr("POSKI")))
                Next

            Catch ex As Exception
                'ScriptManager.RegisterStartupScript(Me.Page, Me.Page.GetType, "script", "<script>alert('Error al conectar con SAP. Intente mas tarde.');</script>", False)
            End Try

        ElseIf tipo_comprobacion = "RF" Then
            listado.Add(New ListadoGenerico("0", TranslateLocale.text("--Seleccione--")))
            listado.Add(New ListadoGenerico("3", "Nutec Bickley"))
            listado.Add(New ListadoGenerico("8", "Nutec Fibratec"))
            listado.Add(New ListadoGenerico("12", "Nutec USA"))

        End If

        Return listado
    End Function

    Protected Function RecuperaListadoNecesidades(id_empresa As Integer, tipo_comprobacion As String) As List(Of ListadoGenerico)
        Dim listado As New List(Of ListadoGenerico)

        Dim combos As New Combos(System.Configuration.ConfigurationManager.AppSettings("CONEXION"))
        Dim dt As DataTable = combos.RecuperaNecesidad(id_empresa, tipo_comprobacion)
        For Each dr As DataRow In dt.Rows
            listado.Add(New ListadoGenerico(dr("id_necesidad"), dr("desc_combo")))
        Next

        Return listado
    End Function

End Class


Public Class ListadoGenerico
    Public value As String
    Public text As String

    Public Sub New(_value As String, _text As String)
        value = _value
        text = _text
    End Sub


End Class
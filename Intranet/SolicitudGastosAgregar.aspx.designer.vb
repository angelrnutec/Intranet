'------------------------------------------------------------------------------
' <generado automáticamente>
'     Este código fue generado por una herramienta.
'
'     Los cambios en este archivo podrían causar un comportamiento incorrecto y se perderán si
'     se vuelve a generar el código. 
' </generado automáticamente>
'------------------------------------------------------------------------------

Option Strict On
Option Explicit On


Partial Public Class SolicitudGastosAgregar
    
    '''<summary>
    '''Control RadScriptManager1.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents RadScriptManager1 As Global.Telerik.Web.UI.RadScriptManager
    
    '''<summary>
    '''Control lblFolio.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lblFolio As Global.System.Web.UI.WebControls.Label
    
    '''<summary>
    '''Control lblFechaSolicitud.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lblFechaSolicitud As Global.System.Web.UI.WebControls.Label
    
    '''<summary>
    '''Control lblSolicitante.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lblSolicitante As Global.System.Web.UI.WebControls.Label
    
    '''<summary>
    '''Control ddlEmpresa.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlEmpresa As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control ddlViajero.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlViajero As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control ddlDepartamento.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlDepartamento As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control ddlAutorizaJefe.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlAutorizaJefe As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control ddlAutorizaConta.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlAutorizaConta As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control txtDestino.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtDestino As Global.System.Web.UI.WebControls.TextBox
    
    '''<summary>
    '''Control txtMotivo.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtMotivo As Global.System.Web.UI.WebControls.TextBox
    
    '''<summary>
    '''Control dtFechaIni.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents dtFechaIni As Global.Telerik.Web.UI.RadDatePicker
    
    '''<summary>
    '''Control dtFechaFin.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents dtFechaFin As Global.Telerik.Web.UI.RadDatePicker
    
    '''<summary>
    '''Control diasViaje.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents diasViaje As Global.System.Web.UI.HtmlControls.HtmlGenericControl
    
    '''<summary>
    '''Control trAnticipos.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents trAnticipos As Global.System.Web.UI.HtmlControls.HtmlTableRow
    
    '''<summary>
    '''Control txtMontoPesos.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtMontoPesos As Global.Telerik.Web.UI.RadNumericTextBox
    
    '''<summary>
    '''Control txtMontoUSD.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtMontoUSD As Global.Telerik.Web.UI.RadNumericTextBox
    
    '''<summary>
    '''Control txtMontoEuro.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtMontoEuro As Global.Telerik.Web.UI.RadNumericTextBox
    
    '''<summary>
    '''Control divSeleccionTipoContabilidad.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents divSeleccionTipoContabilidad As Global.System.Web.UI.HtmlControls.HtmlGenericControl
    
    '''<summary>
    '''Control btnManejoOI.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents btnManejoOI As Global.System.Web.UI.WebControls.RadioButton
    
    '''<summary>
    '''Control btnManejoCC.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents btnManejoCC As Global.System.Web.UI.WebControls.RadioButton
    
    '''<summary>
    '''Control btnManejoPEP.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents btnManejoPEP As Global.System.Web.UI.WebControls.RadioButton
    
    '''<summary>
    '''Control btnManejoRF.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents btnManejoRF As Global.System.Web.UI.WebControls.RadioButton
    
    '''<summary>
    '''Control lblEstatus.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lblEstatus As Global.System.Web.UI.WebControls.Label
    
    '''<summary>
    '''Control tblHistAuth.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents tblHistAuth As Global.System.Web.UI.HtmlControls.HtmlTable
    
    '''<summary>
    '''Control lblAutorizaJefe.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lblAutorizaJefe As Global.System.Web.UI.WebControls.Label
    
    '''<summary>
    '''Control lblAutorizaConta.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lblAutorizaConta As Global.System.Web.UI.WebControls.Label
    
    '''<summary>
    '''Control lblAutorizaJefeComprobacion.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lblAutorizaJefeComprobacion As Global.System.Web.UI.WebControls.Label
    
    '''<summary>
    '''Control lblAutorizaContaComprobacion.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lblAutorizaContaComprobacion As Global.System.Web.UI.WebControls.Label
    
    '''<summary>
    '''Control btnRegresar.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents btnRegresar As Global.System.Web.UI.WebControls.Button
    
    '''<summary>
    '''Control btnGuardar.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents btnGuardar As Global.System.Web.UI.WebControls.Button
    
    '''<summary>
    '''Control btnCancelarSolicitud.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents btnCancelarSolicitud As Global.System.Web.UI.WebControls.Button
    
    '''<summary>
    '''Control lnkImpr.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lnkImpr As Global.System.Web.UI.HtmlControls.HtmlAnchor
    
    '''<summary>
    '''Control divSolicitudConMateriales.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents divSolicitudConMateriales As Global.System.Web.UI.HtmlControls.HtmlGenericControl
    
    '''<summary>
    '''Control lblFolioSolicitudReposicion.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lblFolioSolicitudReposicion As Global.System.Web.UI.WebControls.Label
    
    '''<summary>
    '''Control lnkSolicitudReposicion.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lnkSolicitudReposicion As Global.System.Web.UI.WebControls.HyperLink
    
    '''<summary>
    '''Control divComprobantes.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents divComprobantes As Global.System.Web.UI.HtmlControls.HtmlGenericControl
    
    '''<summary>
    '''Control lnkMovimientosPorComprobar.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lnkMovimientosPorComprobar As Global.System.Web.UI.HtmlControls.HtmlAnchor
    
    '''<summary>
    '''Control divComprobantesAlta.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents divComprobantesAlta As Global.System.Web.UI.HtmlControls.HtmlGenericControl
    
    '''<summary>
    '''Control txtNecesidad.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtNecesidad As Global.System.Web.UI.WebControls.TextBox
    
    '''<summary>
    '''Control btnConceptoCC.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents btnConceptoCC As Global.System.Web.UI.WebControls.RadioButton
    
    '''<summary>
    '''Control ddlCentroCosto.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlCentroCosto As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control btnConceptoOI.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents btnConceptoOI As Global.System.Web.UI.WebControls.RadioButton
    
    '''<summary>
    '''Control ddlOrdenInterna.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlOrdenInterna As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control txtOrdenInterna.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtOrdenInterna As Global.System.Web.UI.WebControls.TextBox
    
    '''<summary>
    '''Control btnConceptoPEP.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents btnConceptoPEP As Global.System.Web.UI.WebControls.RadioButton
    
    '''<summary>
    '''Control ddlElementoPEP.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlElementoPEP As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control txtElementoPep.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtElementoPep As Global.System.Web.UI.WebControls.TextBox
    
    '''<summary>
    '''Control btnConceptoRF.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents btnConceptoRF As Global.System.Web.UI.WebControls.RadioButton
    
    '''<summary>
    '''Control ddlElementoEmpresa.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlElementoEmpresa As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control divNecesidad.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents divNecesidad As Global.System.Web.UI.HtmlControls.HtmlGenericControl
    
    '''<summary>
    '''Control lblNecesidad.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lblNecesidad As Global.System.Web.UI.WebControls.Label
    
    '''<summary>
    '''Control ddlNecesidad.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlNecesidad As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control dtFechaConcepto.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents dtFechaConcepto As Global.Telerik.Web.UI.RadDatePicker
    
    '''<summary>
    '''Control ddlFormaPago.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlFormaPago As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control txtObservaciones.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtObservaciones As Global.System.Web.UI.WebControls.TextBox
    
    '''<summary>
    '''Control ddlNumPersonas.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlNumPersonas As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control tdEtiquetaRetencion.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents tdEtiquetaRetencion As Global.System.Web.UI.HtmlControls.HtmlTableCell
    
    '''<summary>
    '''Control tdEtiquetaRetencionResico.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents tdEtiquetaRetencionResico As Global.System.Web.UI.HtmlControls.HtmlTableCell
    
    '''<summary>
    '''Control tdEtiquetaPropina.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents tdEtiquetaPropina As Global.System.Web.UI.HtmlControls.HtmlTableCell
    
    '''<summary>
    '''Control btnAgregar.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents btnAgregar As Global.System.Web.UI.WebControls.Button
    
    '''<summary>
    '''Control ddlConcepto.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlConcepto As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control txtSubtotal.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtSubtotal As Global.Telerik.Web.UI.RadNumericTextBox
    
    '''<summary>
    '''Control ddlTipoIVA.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlTipoIVA As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control txtIvaEditado.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtIvaEditado As Global.Telerik.Web.UI.RadNumericTextBox
    
    '''<summary>
    '''Control txtOtrosImpuestos.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtOtrosImpuestos As Global.Telerik.Web.UI.RadNumericTextBox
    
    '''<summary>
    '''Control tdRetencion.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents tdRetencion As Global.System.Web.UI.HtmlControls.HtmlTableCell
    
    '''<summary>
    '''Control txtRetencion.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtRetencion As Global.Telerik.Web.UI.RadNumericTextBox
    
    '''<summary>
    '''Control tdRetencionResico.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents tdRetencionResico As Global.System.Web.UI.HtmlControls.HtmlTableCell
    
    '''<summary>
    '''Control txtRetencionResico.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtRetencionResico As Global.Telerik.Web.UI.RadNumericTextBox
    
    '''<summary>
    '''Control tdPropina.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents tdPropina As Global.System.Web.UI.HtmlControls.HtmlTableCell
    
    '''<summary>
    '''Control txtPropina.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtPropina As Global.Telerik.Web.UI.RadNumericTextBox
    
    '''<summary>
    '''Control ddlMoneda.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents ddlMoneda As Global.System.Web.UI.WebControls.DropDownList
    
    '''<summary>
    '''Control divTotal.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents divTotal As Global.System.Web.UI.HtmlControls.HtmlGenericControl
    
    '''<summary>
    '''Control gvConceptos.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents gvConceptos As Global.System.Web.UI.WebControls.GridView
    
    '''<summary>
    '''Control divTotales.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents divTotales As Global.System.Web.UI.HtmlControls.HtmlGenericControl
    
    '''<summary>
    '''Control lblTotalMXP.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lblTotalMXP As Global.System.Web.UI.WebControls.Label
    
    '''<summary>
    '''Control lblTotalMater.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lblTotalMater As Global.System.Web.UI.WebControls.Label
    
    '''<summary>
    '''Control lblTotalAjustado.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lblTotalAjustado As Global.System.Web.UI.WebControls.Label
    
    '''<summary>
    '''Control lblSaldoTexto.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lblSaldoTexto As Global.System.Web.UI.WebControls.Label
    
    '''<summary>
    '''Control lblSaldoMonto.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents lblSaldoMonto As Global.System.Web.UI.WebControls.Label
    
    '''<summary>
    '''Control btnEnviarAuth.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents btnEnviarAuth As Global.System.Web.UI.WebControls.Button
    
    '''<summary>
    '''Control txtIdSolicitudGasto.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtIdSolicitudGasto As Global.System.Web.UI.WebControls.TextBox
    
    '''<summary>
    '''Control txtIdEmpleadoSolicita.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtIdEmpleadoSolicita As Global.System.Web.UI.WebControls.TextBox
    
    '''<summary>
    '''Control txtTipoComprobantes.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtTipoComprobantes As Global.System.Web.UI.WebControls.TextBox
    
    '''<summary>
    '''Control txtIdEstatus.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtIdEstatus As Global.System.Web.UI.WebControls.TextBox
    
    '''<summary>
    '''Control txtComprobacionJefe.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtComprobacionJefe As Global.System.Web.UI.WebControls.TextBox
    
    '''<summary>
    '''Control txtComprobacionConta.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtComprobacionConta As Global.System.Web.UI.WebControls.TextBox
    
    '''<summary>
    '''Control txtDiasGraciaConceptosAnioAnterior.
    '''</summary>
    '''<remarks>
    '''Campo generado automáticamente.
    '''Para modificarlo, mueva la declaración del campo del archivo del diseñador al archivo de código subyacente.
    '''</remarks>
    Protected WithEvents txtDiasGraciaConceptosAnioAnterior As Global.System.Web.UI.WebControls.HiddenField
End Class

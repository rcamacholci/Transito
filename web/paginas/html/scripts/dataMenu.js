
// -- Deluxe Tuner Style Names
var tstylesNames=["Individual Style","Individual Style","Individual Style","Individual Style",];
var tXPStylesNames=["Individual Style",];
// -- End of Deluxe Tuner Style Names

//--- Common
var tlevelDX=20;
var texpanded=0;
var texpandItemClick=0;
var tcloseExpanded=1;
var tcloseExpandedXP=0;
var ttoggleMode=1;
var tnoWrap=1;
var titemTarget="init";
var titemCursor="pointer";
var statusString="link";
var tblankImage="../html/scripts/dataMenu.files/blank.gif";
var tpathPrefix_img="";
var tpathPrefix_link="";

//--- Dimensions
var tmenuWidth="230px";
var tmenuHeight="";

//--- Positioning
var tabsolute=0;
var tleft="20px";
var ttop="40px";

//--- Font
var tfontStyle="bold 8pt Arial";
var tfontColor=["#333333","#C0C0C0"];
var tfontDecoration=["none","none"];
var tfontColorDisabled="#ACACAC";
var tpressedFontColor="#0066CC";

//--- Appearance
var tmenuBackColor="#D2D2D2";
var tmenuBackImage="";
var tmenuBorderColor="#FFFFFF";
var tmenuBorderWidth=0;
var tmenuBorderStyle="solid";

//--- Item Appearance
var titemAlign="left";
var titemHeight=22;
var titemBackColor=["#F0F1F5","#F0F1F5"];
var titemBackImage=["",""];

//--- Icons & Buttons
var ticonWidth=21;
var ticonHeight=15;
var ticonAlign="left";
var texpandBtn=["../html/scripts/dataMenu.files/expandbtn2.gif","../html/scripts/dataMenu.files/icon3_s.gif","../html/scripts/dataMenu.files/collapsebtn2.gif"];
var texpandBtnW=9;
var texpandBtnH=9;
var texpandBtnAlign="left";

//--- Lines
var tpoints=0;
var tpointsImage="";
var tpointsVImage="";
var tpointsCImage="";
var tpointsBImage="";

//--- Floatable Menu
var tfloatable=0;
var tfloatIterations=10;
var tfloatableX=1;
var tfloatableY=1;

//--- Movable Menu
var tmoveable=0;
var tmoveHeight=12;
var tmoveColor="transparent";
var tmoveImage="../html/scripts/dataMenu.files/movepic.gif";

//--- XP-Style
var tXPStyle=1;
var tXPIterations=10;
var tXPBorderWidth=1;
var tXPBorderColor="#FFFFFF";
var tXPAlign="left";
var tXPTitleBackColor="#D8D8D8";
var tXPTitleBackImg="../html/scripts/dataMenu.files/xptitle2_s.gif";
var tXPTitleLeft="../html/scripts/dataMenu.files/xptitleleft_s.gif";
var tXPTitleLeftWidth=4;
var tXPIconWidth=30;
var tXPIconHeight=32;
var tXPMenuSpace=10;
var tXPExpandBtn=["../html/scripts/dataMenu.files/xpexpand2_s.gif","../html/scripts/dataMenu.files/xpexpand3_s.gif","../html/scripts/dataMenu.files/xpcollapse2_s.gif","../html/scripts/dataMenu.files/xpcollapse3_s.gif"];
var tXPBtnWidth=25;
var tXPBtnHeight=23;
var tXPFilter=1;

//--- Advanced
var tdynamic=0;
var tajax=0;

//--- State Saving
var tsaveState=0;
var tsavePrefix="menu1";

var tstyles = [
    ["tfontStyle=bold 8pt Tahoma","tfontColor=#FFFFFF,#E6E6E6","tfontDecoration=none,none"],
    ["tfontStyle=bold 8pt Tahoma","tfontColor=#3F3D3D,#7E7C7C","tfontDecoration=none,none"],
    ["tfontDecoration=none,none"],
    ["tfontStyle=bold 8pt Tahoma","tfontColor=#444444,#5555FF"],
];
var tXPStyles = [
    ["tXPTitleBackColor=#D9DAE2","tXPTitleBackImg=../html/scripts/dataMenu.files/xptitle2_s.gif","tXPExpandBtn=../html/scripts/dataMenu.files/xpexpand2_s.gif,../html/scripts/dataMenu.files/xpexpand3_s.gif,../html/scripts/dataMenu.files/xpcollapse2_s.gif,../html/scripts/dataMenu.files/xpcollapse3_s.gif"],
];

var tmenuItems = [
["Menu Civitrans","", "", "", "", "", "", "1", "0", "", ],
	["|Inicio","", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["|Cambiar Password","editarPassword.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
["Consultas","", "", "", "", "", "", "1", "0", "", ],
        ["|Hoja de Vida Vehiculos","consultarVehiculo.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["|Vehiculo por Guarismos","consultarGuarismos.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["|Hoja de Vida Personas","consultarPersona.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["|Consultar Datos Persona","consultarDatosPersona.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
      ["|Inscribir Persona Runt","personas/registrarPersona.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
["Comparendos","", "", "", "", "", "", "1", "0", "", ],
     ["|Adicionar Comparendo","adicionarComparendo.jsp","../html/scripts/dataMenu.files/icon1_s.gif","../html/scripts/dataMenu.files/icon1_so.gif","","","","","","",],
     ["|Consultar Comparendo","buscarComparendo.jsp","../html/scripts/dataMenu.files/icon1_s.gif","../html/scripts/dataMenu.files/icon1_so.gif","","","","","","",],
     ["|Consultar Agentes OT","consultarAgentes.jsp","../html/scripts/dataMenu.files/icon1_s.gif","../html/scripts/dataMenu.files/icon1_so.gif","","","","","","",],
     ["|Salarios Minimos","consultarSalario.jsp","../html/scripts/dataMenu.files/icon1_s.gif","../html/scripts/dataMenu.files/icon1_so.gif","","","","","","",],
     ["|Financiar Comparendo","", "", "", "", "", "","", "", "", "", ],
        ["||Crear Acuerdo de Pago","Financiacion.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["||Ver Acuerdo de Pago","consultarAcuerdosdePago.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["||Reporte Cartera General","Cartera_Comparendos_Infraccion.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
    ["|Cursos Comparendos","", "", "", "", "", "","", "", "", "", ],
        ["||Adicionar Horario","comparendos/adicionarHorarioCurso.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["||Consultar Horario","comparendos/consultarHorariosCursos.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
    ["|Liquidacion Cia Externo","generarLiquidacionCiaExterno.jsp","../html/scripts/dataMenu.files/icon1_s.gif","../html/scripts/dataMenu.files/icon1_so.gif","","","","","","",],
    ["|Ordenes de Salida","", "", "", "", "", "","", "", "", "", ],
        ["||Generar Orden","OrdenSalida.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["||Imprimir Orden","ImprimirOrdenSalida.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
   ["|Reportes","ReporteComparendos.jsp","../html/scripts/dataMenu.files/icon1_s.gif","../html/scripts/dataMenu.files/icon1_so.gif","","","","","","",],
["Liquidacion y Taquillas","", "", "", "", "", "", "1", "0", "", ],
     ["|Liquidacion","Liquidacion.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
     ["|Runt Licencias Conducc.","liquidacion/generarRecibo.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
     ["|Abrir/Cerrar Taquilla","gestionarCaja.jsp", "../html/scripts/dataMenu.files/icon1_s.gif","../html/scripts/dataMenu.files/icon1_so.gif","","","","", "", "", ],
     ["|Administrar Taquillas","administrarCaja.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif","","","","","", "", ],
     ["|Consultar Pagos","ConsultarPagos.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
     ["|Validar Pagos","reclamosPagos.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
     ["|General de Pagos","Caja_General_Pagos.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
["Distribuciones","", "", "", "", "", "", "1", "0", "", ], 
     ["|De Pagos","consultar_pagosDistribuidos.jsp", "../html/scripts/dataMenu.files/icon1_s.gif","../html/scripts/dataMenu.files/icon1_so.gif","","","","", "", "", ],
     ["|Entidades","entidades_de_distribucion.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif","","","","", "", "", ],
     ["|Configuracion","configuracion_distribucion.jsp?sec=0", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
["Solicitudes RNA","", "", "", "", "", "", "1", "0", "", ],
	["|Solicitud Tramite","seleccionTramites.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif","","", "", "", "", "", ],
	["|Consultar Solicitud","consultarRadicacion.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif","","","","","","", ],
       	["|Registrar Acta Importacion","registrarActaImportacion.jsp?tipoP=0", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["|Ingresar Linea","IngresarLinea.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
      ["|Presignaciones","", "", "", "", "", "","", "", "", "", ],
        ["||Preasignacion Placa","preasignacion.jsp?tipoP=0", "../html/scripts/dataMenu.files/icon1_s.gif","../html/scripts/dataMenu.files/icon1_so.gif","","","","","","",],
        ["||Consultar Preasignacion","consultarPreasignaciones.jsp?tipoP=0", "../html/scripts/dataMenu.files/icon1_s.gif","../html/scripts/dataMenu.files/icon1_so.gif","","","","","","",],
        ["||Presignacion publica","PresignacionPublica.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
["Solicitudes RNC","", "", "", "", "", "", "1", "0", "", ],
        ["|Registrar Persona","registrarPersona.jsp","../html/scripts/dataMenu.files/icon1_s.gif","../html/scripts/dataMenu.files/icon1_so.gif","","","", "", "", "", ],
	["|Solicitud Licencia","formularioLicencia.jsp","../html/scripts/dataMenu.files/icon1_s.gif","../html/scripts/dataMenu.files/icon1_so.gif","","","", "", "", "", ],
        ["|Consultar Solicitud","consultarRadicacionLicencias.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif","","","","","","", ],
        ["|Consultar Licencias","consultarLicencias.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif","","","","","","", ],
        ["|Estadisticas Licencias","estadisticasLicencias.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif","","","","","","", ],
["Tramites y Rangos","", "", "", "", "", "", "1", "0", "", ],
	["|Tramites","tramites.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
	["|Rangos Placas","listar_rangos.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
	["|Rangos Sustratos","listarRangosSustratos.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
["Impresiones","", "", "", "", "", "", "1", "0", "", ],
 		["|Permiso de Transito","ImprimirPermiso.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["|Imprimir Runt","impresionesRunt.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
	["|Imprimir Documentos","ImpresionDocumentos.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
["Procesos Administrativos","", "", "", "", "", "", "1", "0", "", ],
    ["|Prescripciones","", "", "", "", "", "","", "", "", "", ],
	["||Prescripcion de cartera","PrescripcionDeCartera.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
	["||Consultar Prescripcion","consultarPrescripciones.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
    ["|Titulos Valor","", "", "", "", "", "","", "", "", "", ],
        ["||Adicionar Titulo Valor","adicionarTituloValor.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
	["||Consultar Titulo Valor","consultarTituloValor.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
    ["|Notas Credito","", "", "", "", "", "","", "", "", "", ],
        ["|Notas Credito ","consultarNotasGenerales.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],
        ["|Codigo Notas Credito ","CodigoNotaCredito.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],
["Procesos Judiciales","", "", "", "", "", "", "1", "0", "", ],
	["|Registrar Oficios Embargos","GenerarOficioEmbargo.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],
	["|Consultar Oficios Embargos","consultarOficiosEmbargos.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],
		["|Imprimir Oficios Embargos","ImprimirOficioEmbargo.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],
["Reportes","", "", "", "", "", "", "1", "0", "", ],
	["|Generar Reportes","reportes.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["|Informe de Cartera","informes/verReporteCartera.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["|Generar Planos RUNT","generarPlanos.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["|Cargar Planos Polca","CargarPlanosPolca.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["|Generar Planos Hacienda","informes/generarPlanosHacienda.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["|Cargar Planos Banco","pagosExternos/seleccionarPagoExterno.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["|Consultar Auditoria","consultarAuditoria.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["|Generear Plano Contabilidad","contabilidad/generarPlanosContabilidad.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["|Prendas x Beneficiario","prendasPorBeneficiario.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["|Factura Domiciliaria","facturadomiciliaria.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["|Cantidad Vehiculos Servicio/Clase","cantidadvehiculoservicioclase.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
        ["|Cartera General Viigencia-Placa","carterageneralvigenciaplaca.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
       
["|Marca Linea Carroceria","ReporteVehiculomclc.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
["|Valores de los Tramites","ReporteTramite.jsp","../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", ],
["Archivo","", "", "", "", "", "", "1", "0", "", ],
	["|Solicitud Prestamo","prestamoCarpetas.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],	
	["|Consultar Solicitudes","consultarPrestamosCarpetas.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],	
	["|Devoluciones de Carpetas","devolucionesCarpetas.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],	
	["|Reporte de Carpetas","reporteCarpetas.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],	
	["|Consultar Archivo Inactivo","consultarGuiaCaja.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],
["Archivo II","", "", "", "", "", "", "1", "0", "", ],
	["|Reg. Solicitud Oficios","RegistrarSolicitudOficios.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],
	["|Cons. Solicitud Oficios","RadicacionSolicitudesOficios.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],	
	["|Certificado a Judiciales","CertificadoTradicionJudiciales.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],
["Perfiles de Usuarios","", "", "", "", "", "", "1", "0", "", ],
        ["|Consultas Usurios","", "", "", "", "", "","", "", "", "", ],
            ["||Consultar Usuarios","verUsuarios.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],
            ["||Perfiles del Sistema","verPerfilesUsuario.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],
        ["|Reportes Usurios","", "", "", "", "", "","", "", "", "", ],
            ["||Usuarios por Perfiles","consultarPerfilUsuario.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],
        ["|Administracion de usuarios","", "", "", "", "", "","", "", "", "", ],
            ["||Administrar Usuario","AdministrarUsuario.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "", "", "", "", "", "", "", "", ],
            ["||Administrar Caja","AdministrarCajas.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "", "", "", "", "", "", "", "", ],
            ["||Habilitar Huella","validarusutoken.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "", "", "", "", "", "", "", "", ],
            ["||Habilitar IP Usuarios","HabilitarIPUsuarios.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],
            ["||Adicionar Usuarios","adicionarUsuario.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],
            ["||Asignar Recursos","asig_recursos.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "", "", "", "", "", "", "", "", ],
            ["||Recursos del Sistema","recurso.jsp", "../html/scripts/dataMenu.files/icon1_s.gif", "../html/scripts/dataMenu.files/icon1_so.gif", "", "", "", "", "", "", "", ],

];

dtree_init();
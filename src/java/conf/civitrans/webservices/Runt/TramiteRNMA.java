/*  
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conf.civitrans.webservices.Runt;

import com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO;
import com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO;
import com.heinsohn.runt.general.identificaciones.InformacionBiometricaCiudadanoDTO;
import com.heinsohn.runt.general.personas.PropietarioRNMADTO;
import com.heinsohn.runt.general.solicitudes.LiquidacionInDTO;
import com.heinsohn.runt.general.solicitudes.RadicarSolicitudOutDTO;
import com.heinsohn.runt.general.solicitudes.RechazoOTDTO;
import com.heinsohn.runt.general.solicitudes.RegistroSolicitudDTO;
import com.heinsohn.runt.general.tramite.TramiteBasicoDTO;
import com.heinsohn.runt.general.tramite.rnma.TramiteMatriculaInicialRNMADTO;
import com.heinsohn.runt.general.tramite.rnma.TramiteRegistroMaquinariaImportacionTemporalDTO;
import java.sql.Date;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashSet;
import java.util.List;
import modelo.Aseguradora;
import modelo.Divipo;
import modelo.Empresa;
import modelo.Formulario;
import modelo.Formulario_Cupl;
import modelo.Importacion_Temporal_RNMA;
import modelo.Linea_maquinaria;
import modelo.Marcas_maquinaria;
import modelo.Model;
import modelo.Parametro;
import modelo.Persona;
import modelo.Propietario;
import modelo.Radicacion;
import modelo.Radicacion_Apoderado;
import modelo.Radicacion_Color;
import modelo.Radicacion_Dato_Vehiculo;
import modelo.Radicacion_Propietario;
import modelo.Radicacion_RNMA;
import modelo.Representante;
import modelo.Sede;
import modelo.Solicitantes;
import modelo.Tiquete;
import modelo.Usuario;
import modelo.UsuarioRunt;
import modelo.Vehiculo;
import org.ita.webservice.Pago;

/**
 *
 * @author Jefrey
 */
public class TramiteRNMA {

    private String mensaje;
    private String resultado;
    private String ruta;

    public boolean registrarTramitesRNMA(javax.servlet.http.HttpServletRequest request) throws SQLException {

        Model model = (Model) request.getSession().getAttribute("model");
        Sede sede = (Sede) request.getSession().getAttribute("sede");
        Usuario usuario = (Usuario) request.getSession().getAttribute("usuario");
        model.getCon().setAutoCommit(false);

        try {

            /*if (request.getParameter("radicacion") == null) {
             mensaje = "Radicacion obligatoria";
             return false;
             }*/
            long idradicacion = request.getParameter("radicacion") != null ? Long.parseLong(request.getParameter("radicacion")) : 0;
            int tramite = Integer.parseInt(request.getParameter("tramite"));
            Radicacion radicacion = model.consultar_Radicacion(idradicacion);

            if (radicacion == null) {
                Persona persona = model.consultarPersona(Integer.parseInt(request.getParameter("tipoDocumento")), request.getParameter("numeroDocumento"));
                Calendar calendar = Calendar.getInstance();
                int vigencia = calendar.get(Calendar.YEAR);
                int consecutivo = model.consultarConsecutivo(sede.getId_sede(), 3, vigencia);
                model.actualizarConsecutivo(sede.getId_sede(), 3, vigencia);
                model.getCon().commit();
                radicacion.setNumero(consecutivo + "");
                radicacion.setFk_persona(persona.getId_persona());
                radicacion.setFk_sede(sede.getId_sede());
                radicacion.setFk_usuario(usuario.getId_usuario());
                radicacion.setEstado(1);
                radicacion.setObservaciones(request.getParameter("observacion"));
                java.sql.Date fecha_exacta = new java.sql.Date(new java.util.Date().getTime());
                radicacion.setFecha(fecha_exacta);
                idradicacion = model.adicionarDatosRadicacion(radicacion);
            }

            Formulario formulario = new Formulario();
            Radicacion_Color radicacionColor = new Radicacion_Color();

            switch (tramite) {

                case 91: // TramiteMatriculaInicialRNMADTO				

                    /* long fk_linea = Integer.parseInt(request.getParameter("cmblineamaquinaria"));

                     Linea_maquinaria lineaM = model.getLineaMaquinaria(fk_linea);

                     if (lineaM == null) {
                     mensaje = "No se encontro linea de Maquinaria registrada";
                     return false;
                     }

                     Marcas_maquinaria marcasM = model.getMarcaMaquinaria(lineaM.getCodigo_marca());

                     if (marcasM == null) {
                     mensaje = "No se encontro Marca de Maquinaria registrada";
                     return false;
                     }*/
                    int fk_aseguradora = Integer.parseInt(request.getParameter("cmbaseguradora"));
                    long municipio = Long.parseLong(request.getParameter("cmbmunicipio"));
                    long departamento = Long.parseLong(request.getParameter("cmbdepartamento"));

                    Divipo divipo = model.consultarDvipo(departamento, municipio);

                    if (divipo == null) {
                        mensaje = "No se encontro divipo registrado";
                        return false;
                    }

                    String identificacion = request.getParameter("txtidentificacion");
                    Calendar calendar = Calendar.getInstance();
                    int vigencia = calendar.get(Calendar.YEAR);
                    int consecutivo = model.consultarConsecutivo(sede.getId_sede(), 3, vigencia);
                    model.actualizarConsecutivo(sede.getId_sede(), 3, vigencia);

                    int clase = Integer.parseInt(request.getParameter("cmbclase"));

                    String modelo = request.getParameter("txtmodelo");
                    if (modelo.trim().length() == 0) {
                        mensaje = "Campo modelo es obligatorio";
                        return false;
                    }

                    int combustible = Integer.parseInt(request.getParameter("cmbcombustible"));
                    int carroceria = Integer.parseInt(request.getParameter("cmbcarroceria"));
                    String motor = request.getParameter("txtmotor");
                    if (motor.trim().length() == 0) {
                        mensaje = "Campo motor es obligatorio";
                        return false;
                    }

                    int pais_registro_maquinaria = Integer.parseInt(request.getParameter("cmbpaisregistro"));
                    String puerto_ingreso = request.getParameter("txtpuertoingreso");
                    String nro_aceptacion = request.getParameter("txtnroaceptacion");
                    String condicion_ingreso = request.getParameter("txtcondicioningreso");
                    String resultado_revision = request.getParameter("txtresultadorevision");
                    String documento_revision = request.getParameter("txtdocumentorevision");
                    Date fecha_revision = null;
                    String entidad_revision = request.getParameter("cmbentidadrevision");
                    Date fecha_expedicion = null;
                    Date fecha_vencimiento = null;

                    int ordenEjecucion = Integer.parseInt(request.getParameter("cmbordenejecucion"));
                    String nombreTipoRegistro = request.getParameter("txtnombretiporegistro");

                    String nofacturavendedor = request.getParameter("txtnofacturavendedor");
                    Date fecha_factura = null;
                    String valorFactura = request.getParameter("txtvalorfacturavendedor");

                    int idRodaje = Integer.parseInt(request.getParameter("cmbrodaje"));
                    int idTipoCabina = Integer.parseInt(request.getParameter("cmbtipocabina"));
                    String nroSubPartidaArancelaria = request.getParameter("txtnroSubPartidaArancelaria");

                    String nroIdentificacionGPS = request.getParameter("txtnroIdentificacionGPS");

                    long idEmpresaHabilitacion = Long.parseLong(request.getParameter("txtidEmpresaHabilitacion"));

                    int tipoDocSoporte = Integer.parseInt(request.getParameter("cmbtipoDocSoporte"));
                    String nroDocSoporte = request.getParameter("txtnroDocSoporte");
                    Date fechaExpedicionSoporte = null;
                    String entExpDocSoporte = request.getParameter("entExpDocSoporte");

                    int tipo_doc_vendedor = Integer.parseInt(request.getParameter("cmbtipodocvendedor"));
                    String no_documento_vendedor = request.getParameter("txtnodocumentovendedor");

                    int motor_reg = Integer.parseInt(request.getParameter("cmbmotor_reg"));
                    String chasis = request.getParameter("txtchasis");
                    int chasis_reg = Integer.parseInt(request.getParameter("cmbchasis_reg"));
                    String serie = request.getParameter("txtserie");
                    int serie_reg = Integer.parseInt(request.getParameter("cmbserie_reg"));
                    String vin = request.getParameter("txtvin");
                    int vin_reg = Integer.parseInt(request.getParameter("cmbvin"));
                    int tipo_doc_importacion = Integer.parseInt(request.getParameter("cmbtipodocimportacion"));
                    int tipo_importacion = Integer.parseInt(request.getParameter("cmbtipoimportacion"));
                    String documento_importacion = request.getParameter("txtdocumentoimportacion");
                    int entidad_remate = Integer.parseInt(request.getParameter("cmbentidadremate"));
                    int codigo_aduana = Integer.parseInt(request.getParameter("txtcodigoaduana"));
                    Date fechaDocumento = null;
                    int servicio = Integer.parseInt(request.getParameter("cmbservicio"));
                    String nro_poliza = request.getParameter("txtnumeropoliza");
                    Date fecha_poliza = null;
                    String observaciones = request.getParameter("txtobservaciones");
                    String licencia_transito = request.getParameter("txtlicenciatransito");
                    int sede_movimiento = Integer.parseInt(request.getParameter("cmbsedemovimiento"));
                    int modalidad = Integer.parseInt(request.getParameter("cmbmodalidad"));

                    if (request.getSession().getAttribute("listCUPL") == null) {
                        mensaje = "Lista de nro de CUPL no puede ser vacia";
                        return false;
                    }

                    String nro_factura = request.getParameter("txtnrofactura");

                    String a = model.obtenerPosiblePagoTRANSITO(identificacion, tramite, nro_factura);

                    if (a.equals("")) {
                        mensaje = "No fue posible conseguir el pago del tramite";
                        return false;
                    }

                    Tiquete tiquete = model.consultarTiqueteByFactura(nro_factura);

                    if (tiquete == null) {
                        mensaje = "No se encontro tiquete para el tramite";
                        return false;
                    }

                    modelo.Pago pago = model.consultarPagoByTiquete(tiquete.getId_tiquete());

                    if (pago == null) {
                        mensaje = "No se encontro pago para el tramite";
                        return false;
                    }

                    if (pago.getEstado() != 3) {
                        mensaje = "El pago no se encuentra en estado pago";
                        return false;
                    }

                    long color = Long.parseLong(request.getParameter("idcolor"));
                    String gamaColor = request.getParameter("txtgamacolor");
                    int secuenciaColor = Integer.parseInt(request.getParameter("cmbsecuenciacolor"));

                    //formulario.setFk_linea(fk_linea);
                    formulario.setFk_aseguradora(fk_aseguradora);
                    formulario.setFk_divipo(divipo.getId_divipo());
                    formulario.setNumero(consecutivo + "");
                    formulario.setFecha_tramite(null);
                    formulario.setPlaca(identificacion);
                    formulario.setClase_vehiculo(clase);
                    formulario.setModelo(Long.parseLong(modelo));
                    formulario.setCombustible(combustible);
                    formulario.setCarroceria(carroceria);
                    formulario.setMotor(motor);
                    formulario.setMotor_reg(motor_reg);
                    formulario.setChasis(chasis);
                    formulario.setVin(vin);
                    formulario.setSerie(serie);
                    formulario.setSerie_reg(serie_reg);
                    formulario.setTipo_doc_importacion(tipo_doc_importacion);
                    formulario.setEntidad_remate(entidad_remate);
                    formulario.setCodigo_aduana(codigo_aduana);
                    formulario.setDocumento_importacion(documento_importacion);
                    formulario.setFecha_documento(fechaDocumento);
                    formulario.setServicio(servicio);
                    formulario.setNro_poliza(nro_poliza);
                    formulario.setFecha_poliza(fecha_poliza);
                    formulario.setObservaciones(observaciones);
                    formulario.setLicencia_transito(licencia_transito);
                    formulario.setSede_movimiento(sede_movimiento);
                    formulario.setFk_radicacion(idradicacion);
                    formulario.setModalidad(modalidad);
                    formulario.setFk_tramite(tramite);
                    formulario.setChasis_reg(chasis_reg);
                    formulario.setTipo_importacion(tipo_importacion);
                    //  formulario.setFk_marca(marcasM.getCodigo_marca());
                    formulario.setFk_pago(pago.getId_pago());

                    long id_formulario = model.adicionarFormulario(formulario);

                    if (request.getSession().getAttribute("listPropietarios") == null) {
                        mensaje = "No se encontro listado de propietarios";
                        return false;
                    }

                    List<Radicacion_Propietario> listRadicacion_propietario = (List<Radicacion_Propietario>) request.getSession().getAttribute("listradicacionpropietario");

                    for (int i = 0; i < listRadicacion_propietario.size(); i++) {
                        listRadicacion_propietario.get(i).setFk_formulario(id_formulario);
                        model.adicionarRadicacionPropietarios(listRadicacion_propietario.get(i));
                    }

                    if (request.getSession().getAttribute("listapoderados") != null) {
                        List<Radicacion_Apoderado> listRadicacionApoderados = (List<Radicacion_Apoderado>) request.getSession().getAttribute("listapoderados");
                        for (int i = 0; i < listRadicacionApoderados.size(); i++) {
                            listRadicacionApoderados.get(i).setFk_formulario(id_formulario);
                            model.adicionarRadicacionApoderados(listRadicacionApoderados.get(i));
                        }
                    }

                    if (request.getSession().getAttribute("listDatosVehiculo") == null) {
                        mensaje = "No se encontraron datos del vehiculo";
                        return false;
                    }

                    List<Radicacion_Dato_Vehiculo> listDatosVehiculo = (List<Radicacion_Dato_Vehiculo>) request.getSession().getAttribute("listDatosVehiculo");
                    for (int i = 0; i < listDatosVehiculo.size(); i++) {
                        listDatosVehiculo.get(i).setFk_formulario(id_formulario);
                        model.adicionarRadDatosVehiculo(listDatosVehiculo.get(i));
                    }

                    radicacionColor.setFk_color(color);
                    radicacionColor.setFk_formulario(id_formulario);
                    radicacionColor.setGama(gamaColor);
                    radicacionColor.setSequencia(secuenciaColor);

                    model.adicionarRadicacionColores(radicacionColor);

                    model.adicionarRadicacionRNMA(new Radicacion_RNMA(0, id_formulario, ordenEjecucion, nombreTipoRegistro, nofacturavendedor, fecha_factura, valorFactura, idRodaje, idTipoCabina, nroSubPartidaArancelaria, nroIdentificacionGPS, idEmpresaHabilitacion, tipoDocSoporte, nroDocSoporte, fechaExpedicionSoporte, entExpDocSoporte, tipo_doc_vendedor, no_documento_vendedor));
                    model.adicionarImportacionTemporalRNMA(new Importacion_Temporal_RNMA(0, id_formulario, pais_registro_maquinaria, puerto_ingreso, nro_aceptacion, condicion_ingreso, resultado_revision, documento_revision, fecha_revision, entidad_revision, fecha_expedicion, fecha_vencimiento));

                    List<String> listCUPL = (List<String>) request.getSession().getAttribute("listCUPL");

                    for (int i = 0; i < listCUPL.size(); i++) {
                        String nrocupl = (String) listCUPL.get(i);
                        model.adicionarFormularioCUPL(new Formulario_Cupl(0, id_formulario, 1, nrocupl, null, null));
                    }

                    break;

                case 2: // TramiteRegrabacionRNMADTO			

                    break;
            }

            ruta = "formularioTramite.jsp?radicacion=" + idradicacion + "&fecha=" + radicacion.getFecha() + "&sede=" + radicacion.getFk_sede();
            model.getCon().commit();
            mensaje = "Tramite regitrado correctamente";

            return true;

        } catch (Exception e) {
            model.getCon().rollback();
            e.printStackTrace();
            mensaje = "Ha ocurrido un error fatal en el proceso: " + e.getMessage();
        }

        return false;
    }

    public boolean radicarTramiteRunt_RNMA(javax.servlet.http.HttpServletRequest request, Radicacion radicacion) throws SQLException {

        Model model = (Model) request.getSession().getAttribute("model");
        UsuarioRunt userRunt = (UsuarioRunt) request.getSession().getAttribute("usuarioRunt");

        model.getCon().setAutoCommit(false);

        try {

            if (request.getSession().getAttribute("token2") == null) {
                mensaje = "El token se encuentra vencido, Por favor autentiquese nuevamente";
                return false;
            }

            webservices.radicacion.RadicacionServicesClient radicacionService = new webservices.radicacion.RadicacionServicesClient();
            Model.userHandler = userRunt.getCodigo();
            Model.passUserHandler = userRunt.getPassword();
            radicacionService.setUser(userRunt.getCodigo());
            radicacionService.setTokenHuellaDigital(request.getSession().getAttribute("token2").toString());

            String identificadorAT = "8634001";
            String nombreAT = "SABANAGRANDE - ATLANTICO(DPTAL)";
            String autLimitacion = "N";
            String descAutorizacion = "";
            String tipoSolicitud = "SOLICITUD_TRAMITES";

            PropietarioRNMADTO propietarioRNMA = new PropietarioRNMADTO();

            java.util.List<LiquidacionInDTO> liquidaciones = new java.util.LinkedList<LiquidacionInDTO>();
            java.util.List<TramiteBasicoDTO> tramites = new java.util.LinkedList<TramiteBasicoDTO>();
            java.util.List<InformacionBiometricaCiudadanoDTO> biometricos = new java.util.LinkedList<InformacionBiometricaCiudadanoDTO>();
            java.util.List<RechazoOTDTO> rechazos = new java.util.LinkedList<com.heinsohn.runt.general.solicitudes.RechazoOTDTO>();
            IdentificacionAutomotorDTO automotor = new IdentificacionAutomotorDTO();

            InformacionBiometricaCiudadanoDTO biometrico = new InformacionBiometricaCiudadanoDTO();
            IdentificacionPersonaDTO identificacionP = new IdentificacionPersonaDTO();

            Persona solicitante = model.consultarPersona(radicacion.getFk_persona());
            String tipoDocumento = "";
            String numeroDocumento = "";
            String tipoDocumentoApoderado = "";
            String numeroDocumentoApoderado = "";

            List lista = model.consultarFormularios(radicacion.getId_radicacion());
            for (int i = 0; i < lista.size(); i++) {
                Formulario formulario = (Formulario) lista.get(i);
                List listaSolReal = model.consultaPropietarios(formulario.getPlaca());
                if (listaSolReal.size() > 0) {
                    Propietario propSol = (Propietario) listaSolReal.get(0);
                    Persona perSol = model.consultarPersona(propSol.getFk_persona());
                    tipoDocumento = model.consultarParametro((int) solicitante.getTipo_documento(), 5).getNombreCorto();
                    numeroDocumento = solicitante.getDocumento();

                    if (perSol.getId_persona() != radicacion.getFk_persona()) {
                        tipoDocumentoApoderado = model.consultarParametro((int) solicitante.getTipo_documento(), 5).getNombreCorto();
                        numeroDocumentoApoderado = solicitante.getDocumento();
                        identificacionP.setTipoDocumento(tipoDocumentoApoderado);
                        identificacionP.setNumeroDocumento(numeroDocumentoApoderado);
                    } else {
                        identificacionP.setTipoDocumento(tipoDocumento);
                        identificacionP.setNumeroDocumento(numeroDocumento);
                    }
                } else {
                    tipoDocumento = model.consultarParametro((int) solicitante.getTipo_documento(), 5).getNombreCorto();
                    numeroDocumento = solicitante.getDocumento();
                    identificacionP.setTipoDocumento(tipoDocumento);
                    identificacionP.setNumeroDocumento(numeroDocumento);
                }
                break;
            }

            String registroSolicitud = String.valueOf("1");
            String numeroLiquidacion = "0001";

            if (request.getSession().getAttribute("listSolicitantes") != null) {
                List<Solicitantes> listSolicitantes = (List<Solicitantes>) request.getSession().getAttribute("listSolicitantes");
                for (int i = 0; i < listSolicitantes.size(); i++) {
                    Solicitantes sol = (Solicitantes) listSolicitantes.get(i);

                    identificacionP.setTipoDocumento(sol.getTipodocumento());
                    identificacionP.setNumeroDocumento(sol.getDocumento());

                    biometrico.setPersona(identificacionP);

                    String template = sol.getToken();

                    javax.xml.namespace.QName name_t = new javax.xml.namespace.QName("tokenHuellaDigital");
                    Class<String> declaredType_t = String.class;
                    Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
                    javax.xml.bind.JAXBElement<String> jaxb_t = new javax.xml.bind.JAXBElement(name_t, declaredType_t, scope_t, template);
                    biometrico.setTokenHuellaDigital(jaxb_t);
                    biometrico.setAprobacionValidacionIdentidad(null);
                    biometricos.add(biometrico);
                }
            } else {
                biometrico.setPersona(identificacionP);
                biometrico.setTokenHuellaDigital(null);
                biometrico.setAprobacionValidacionIdentidad(null);
                biometricos.add(biometrico);
            }

            long codigoTramiteRunt = 0;
            long colorRunt = 0;
            boolean continuar = true;

            for (int i = 0; i < lista.size(); i++) {
                Formulario formulario = (Formulario) lista.get(i);

                String nFactura = model.obtenerPosiblePagoTRANSITO(formulario.getPlaca(), formulario.getFk_tramite());
                if (nFactura.length() == 0) {
                    nFactura = model.consultarPagoReclamo(1, formulario.getPlaca(), formulario.getFk_tramite());
                    nFactura = nFactura != null ? nFactura : "";
                }

                if (nFactura.length() == 0) {
                    continuar = false;
                    break;
                }

                List<Formulario_Cupl> listcupls = model.listarCUPLSByFormulario(formulario.getId_formulario());

                for (int j = 0; j < listcupls.size(); j++) {
                    LiquidacionInDTO liquidacion = new LiquidacionInDTO();
                    liquidacion.setNumeroLiquidacion(listcupls.get(j).getNo_cupl());
                    liquidaciones.add(liquidacion);
                }

                switch ((int) formulario.getFk_tramite()) {

                    case 91: // TramiteMatriculaInicialRNMADTO				

                        Radicacion_RNMA radicacionRNMA = model.consultarRadicacionRNMAByFk_formulario(formulario.getId_formulario());

                        if (radicacionRNMA == null) {
                            continuar = false;
                            break;
                        }

                        Importacion_Temporal_RNMA importacion = model.consultarImportacionRNMAByFk_formulario(formulario.getId_formulario());

                        if (importacion == null) {
                            continuar = false;
                            break;
                        }

                        TramiteMatriculaInicialRNMADTO tramiteMatriculaRNMA = new TramiteMatriculaInicialRNMADTO();

                        codigoTramiteRunt = model.consultarTramiteRUNT(formulario.getFk_tramite());
                        tramiteMatriculaRNMA.setCodigoTipoTramite(codigoTramiteRunt + "");
                        tramiteMatriculaRNMA.setEstadoTramite("SOLICITADO");
                        tramiteMatriculaRNMA.setOrdenEjecucion(radicacionRNMA.getOrden_ejecucion());
                        tramiteMatriculaRNMA.setNumeroDeclaracionImportacion(formulario.getDocumento_importacion());
                        tramiteMatriculaRNMA.setNombreTipoRegistro(radicacionRNMA.getNomb_tipo_registro());

                        colorRunt = model.consultarRadicacionColor(formulario.getId_formulario());
                        tramiteMatriculaRNMA.setIdColor((int) colorRunt);
                        tramiteMatriculaRNMA.setNumeroVin(formulario.getVin());
                        tramiteMatriculaRNMA.setNumeroSerie(formulario.getSerie());
                        tramiteMatriculaRNMA.setNumeroChasis(formulario.getChasis());

                        GregorianCalendar gp = new GregorianCalendar();
                        gp.setTime(new java.sql.Date(new java.util.Date().getTime()));
                        javax.xml.datatype.XMLGregorianCalendar fecha_ingreso = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gp);

                        tramiteMatriculaRNMA.setFechaIngreso(fecha_ingreso);
                        tramiteMatriculaRNMA.setClaseMaquinaria(formulario.getClase_vehiculo());
                        tramiteMatriculaRNMA.setNumeroRegistroMotor(formulario.getMotor());
                        tramiteMatriculaRNMA.setNumeroFacturaVendedor(radicacionRNMA.getFactura());

                        gp = new GregorianCalendar(radicacionRNMA.getFecha_factura().getYear(), radicacionRNMA.getFecha_factura().getMonth(), radicacionRNMA.getFecha_factura().getDate());
                        javax.xml.datatype.XMLGregorianCalendar fecha_factura = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gp);

                        tramiteMatriculaRNMA.setFechaFacturaVendedor(fecha_factura);
                        tramiteMatriculaRNMA.setIdRodaje(radicacionRNMA.getRodaje());
                        tramiteMatriculaRNMA.setIdTipoCabina(radicacionRNMA.getTipo_cabina());
                        tramiteMatriculaRNMA.setIdTipoCombustible(formulario.getCombustible() + "");
                        tramiteMatriculaRNMA.setNroSubPartidaArancelaria(radicacionRNMA.getPartida_arancelaria());
                        tramiteMatriculaRNMA.setValorFacturaVendedor(radicacionRNMA.getValor_factura());
                        tramiteMatriculaRNMA.setTipoDocVendedor(model.consultarParametro(radicacionRNMA.getTipodoc_vendedor(), 5).getNombreCorto());
                        tramiteMatriculaRNMA.setNumeroDocVendedor(radicacionRNMA.getNo_documento_vendedor());
                        tramiteMatriculaRNMA.setNroIdentificacionGPS(radicacionRNMA.getIdentificacion_gps());
                        tramiteMatriculaRNMA.setIdEmpresaHabilitacion(radicacionRNMA.getEmpresa_habilitacion());
                        tramiteMatriculaRNMA.setTipoDocSoporte(model.consultarParametro(radicacionRNMA.getTipo_documento_soporte(), 80).getNombreCorto());
                        tramiteMatriculaRNMA.setNroDocSoporte(radicacionRNMA.getDocumento_soporte());

                        gp = new GregorianCalendar(radicacionRNMA.getFecha_soporte().getYear(), radicacionRNMA.getFecha_soporte().getMonth(), radicacionRNMA.getFecha_soporte().getDate());
                        javax.xml.datatype.XMLGregorianCalendar fecha_exp = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gp);

                        tramiteMatriculaRNMA.setFechaExpedicionSoporte(fecha_exp);
                        tramiteMatriculaRNMA.setEntidadExpideDocumentoSoporte(radicacionRNMA.getEntidad_exp_soporte());

                        TramiteRegistroMaquinariaImportacionTemporalDTO registroImportacionTemporal = new TramiteRegistroMaquinariaImportacionTemporalDTO();
                        registroImportacionTemporal.setCodigoTipoTramite(codigoTramiteRunt + "");
                        registroImportacionTemporal.setEstadoTramite("SOLICITADO");
                        registroImportacionTemporal.setOrdenEjecucion(radicacionRNMA.getOrden_ejecucion());
                        registroImportacionTemporal.setFechaSolicitud(fecha_ingreso);
                        registroImportacionTemporal.setNroUnicoIdentificacion(formulario.getPlaca());

                        java.util.List lista_propietariosRNMA = model.consultarRadicacionesPropietarios(formulario.getId_formulario());
                        for (int j = 0; j < lista_propietariosRNMA.size(); j++) {
                            Radicacion_Propietario radicacion_propietario = (Radicacion_Propietario) lista_propietariosRNMA.get(j);

                            Persona personaRNMA = (Persona) model.consultarPersona(radicacion_propietario.getFk_persona());
                            String tipDocPropRNMA = model.consultarParametro((int) personaRNMA.getTipo_documento(), 5).getNombreCorto();

                            PropietarioRNMADTO propietarioDTO = new PropietarioRNMADTO();

                            propietarioDTO.setNroRegAutomotor((long) 0);
                            propietarioDTO.setIdentPersona(null);
                            propietarioDTO.setProvindiviso(radicacion_propietario.getProIndiviso());

                            IdentificacionPersonaDTO identificacionProp = new IdentificacionPersonaDTO();
                            identificacionProp.setTipoDocumento(tipDocPropRNMA);
                            identificacionProp.setNumeroDocumento(personaRNMA.getDocumento());

                            propietarioDTO.setPersona(identificacionProp);

                            List<Radicacion_Apoderado> list_radicacion_apoderado = model.consultarRadicacionesApoderados(formulario.getId_formulario(), personaRNMA.getId_persona());

                            if (list_radicacion_apoderado != null) {
                                for (int t = 0; t < list_radicacion_apoderado.size(); t++) {
                                    Radicacion_Apoderado radicacion_apoderado = (Radicacion_Apoderado) list_radicacion_apoderado.get(t);
                                    Persona apod = model.consultarPersona(radicacion_apoderado.getFk_apoderado());

                                    identificacionP = new IdentificacionPersonaDTO();
                                    identificacionP.setTipoDocumento(model.consultarParametro(apod.getTipo_documento(), 5).getNombreCorto());
                                    identificacionP.setNumeroDocumento(apod.getDocumento());
                                    propietarioDTO.setApoderado(identificacionP);
                                }
                            } else {
                                propietarioDTO.setApoderado(null);
                            }

                            registroImportacionTemporal.getPropietariosDTO().add(propietarioDTO);
                        }

                        registroImportacionTemporal.setPaisRegistroMaquinaria(importacion.getPais_registro_maquinaria());
                        registroImportacionTemporal.setValidacionDocumental("S");
                        registroImportacionTemporal.setPuertoIngresoMaquinaria(importacion.getPuerto_ingreso());
                        registroImportacionTemporal.setNroAceptacion(importacion.getNro_aceptacion());
                        registroImportacionTemporal.setNroSerie(formulario.getSerie());
                        registroImportacionTemporal.setNroChasis(formulario.getChasis());
                        registroImportacionTemporal.setNroMotor(formulario.getMotor());
                        registroImportacionTemporal.setNroVin(formulario.getVin());
                        registroImportacionTemporal.setTipoCarroceria(model.consultarParametro(formulario.getCarroceria(), 2).getNombre());
                        registroImportacionTemporal.setColorMaquinaria(colorRunt + "");
                        registroImportacionTemporal.setCondicionIngreso(importacion.getCondicion_ingreso());
                        registroImportacionTemporal.setResultadoRevisionTecnica(importacion.getResultado_revision());
                        registroImportacionTemporal.setNroDocumentoRevision(importacion.getDocumento_revision());

                        gp = new GregorianCalendar(importacion.getFecha_revision().getYear(), importacion.getFecha_revision().getMonth(), importacion.getFecha_revision().getDate());
                        javax.xml.datatype.XMLGregorianCalendar fecha_revi = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gp);

                        registroImportacionTemporal.setFechaRevision(fecha_revi);

                        registroImportacionTemporal.setEntidadRevision(importacion.getEntidad_revision());

                        gp = new GregorianCalendar(importacion.getFecha_expedicion().getYear(), importacion.getFecha_expedicion().getMonth(), importacion.getFecha_expedicion().getDate());
                        javax.xml.datatype.XMLGregorianCalendar fecha_expim = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gp);

                        registroImportacionTemporal.setFechaExpedicion(fecha_expim);

                        gp = new GregorianCalendar(importacion.getFecha_vencimiento().getYear(), importacion.getFecha_vencimiento().getMonth(), importacion.getFecha_vencimiento().getDate());
                        javax.xml.datatype.XMLGregorianCalendar fecha_ven = javax.xml.datatype.DatatypeFactory.newInstance().newXMLGregorianCalendar(gp);

                        registroImportacionTemporal.setFechaExpedicion(fecha_ven);

                        tramiteMatriculaRNMA.setTramiteMaquinaria(registroImportacionTemporal);

                        tramites.add(tramiteMatriculaRNMA);

                        break;
                }

            }

            RadicarSolicitudOutDTO radicacionOut = radicacionService.radicarSolicitud(null, mensaje, ruta, ruta, mensaje, mensaje, mensaje, ruta, ruta, ruta, mensaje, mensaje, true, null, null, null, null, ruta, ruta, null);

            if (radicacionOut != null) {
                if (radicacionOut.getStatus() != null) {
                    mensaje = "Runt: Codigo: " + radicacionOut.getStatus().getStatusCode() + " Descripción: " + radicacionOut.getStatus().getStatusDesc();
                    if (radicacionOut.getStatus().equals("1") || radicacionOut.getStatus().equals("2")) {
                        model.actualizarEstadoRadicacion(radicacion.getId_radicacion(), 8);
                    }
                }
                resultado = "Runt: " + radicacionOut.getResultado();
            }

            model.getCon().commit();
            mensaje = "Tramite Radicado Correctamente";
            return true;

        } catch (Exception e) {
            mensaje = "Ha Ocurrido un error fatal en radicar tramite a RUNT: " + e.getMessage();
            model.getCon().rollback();
            e.printStackTrace();
        }

        return false;

    }

    public String getMensaje() {
        return mensaje;
    }

    public void setMensaje(String mensaje) {
        this.mensaje = mensaje;
    }

    public String getRuta() {
        return ruta;
    }

    public void setRuta(String ruta) {
        this.ruta = ruta;
    }

    public String getResultado() {
        return resultado;
    }

    public void setResultado(String resultado) {
        this.resultado = resultado;
    }

}

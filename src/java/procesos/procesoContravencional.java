/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package procesos;

import java.*;
import java.awt.Container;
import java.io.DataOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.JFrame;
import javax.swing.JTextField;
import modelo.Cartera;
import modelo.Citacion_Comparendo;
import modelo.Model;
import modelo.SimitComparendo;
import modelo.Usuario;
import modelo.Comparendo;
import modelo.Comparendo_Curso;
import modelo.Comparendo_publico;
import modelo.Detalle_Cartera;
import modelo.Detalle_Financiacion;
import modelo.Divipo;
import modelo.Financiacion_Cartera;
import modelo.Horario_Curso;
import modelo.Infraccion;
import modelo.Liquidacion_Cia;
import modelo.Pago;
import modelo.Persona;
import modelo.Resolucion_Comparendo;
import modelo.SimitPlano;
import modelo.SimitRecaudo;
import modelo.SimitResolucion;
import modelo.Tiquete;
import modelo.Vehiculo;

/**
 *
 * @author Administrador
 */
public class procesoContravencional {

    private String msg = "";
    private String ArchivoSimit = "";
    private String ResolucionSimit = "";
    private String RecaudoSimit = "";

    public boolean ingresarComparendo(Model model, Usuario usuario, javax.servlet.http.HttpServletRequest request) {
        try {
            if (model != null && usuario != null) {
                java.sql.Date fechaUpdate = new java.sql.Date(new java.util.Date().getTime());
                java.sql.Timestamp fechaSystem = new java.sql.Timestamp(new java.util.Date().getTime());
                String comparendo = request.getParameter("comparendo");
                String fecha = request.getParameter("fecha");
                String horas = request.getParameter("horas");
                String minutos = request.getParameter("minutos");
                String lugar = request.getParameter("lugar");
                String placa = request.getParameter("placa");
                String licenciaTransito = request.getParameter("licenciaTransito");
                String clase = request.getParameter("clase");
                String servicio = request.getParameter("servicio");
                String tipoDocumento = request.getParameter("tipoDocumento");
                String documento = request.getParameter("documento");
                String tipoInfractor = request.getParameter("tipoInfractor");
                String infraccion = request.getParameter("infraccion");
                String licenciaConduccion = request.getParameter("licenciaConduccion");
                String fechaVencimiento = request.getParameter("fechaVencimiento");
                String categoria = request.getParameter("categoria");
                String sedeExpedicion = request.getParameter("sedeExpedicion");
                String placaAgente = request.getParameter("placaAgente");
                String fuga = request.getParameter("fuga");
                String accidente = request.getParameter("accidente");
                String inmovilizacion = request.getParameter("inmovilizacion");
                String polca = "0";

                if(request.getParameter("polca")!=null){
                polca = request.getParameter("polca");

                }
                String firma = request.getParameter("firma");
                String observacion = request.getParameter("observaciones");
                String parqueaderos = request.getParameter("parqueaderos");

                long via = Long.parseLong(request.getParameter("vias"));
                System.out.println("id_via+-->"+via);
                modelo.Vias Vi = model.consultarVia(via);
                lugar = Vi.getNombre()+" "+ lugar;
                System.out.println("Lugar+-->"+lugar);
                /////////

                    Vehiculo veh = model.consultarVehiculo(placa);
                    Comparendo_publico compp = new Comparendo_publico();
                    //long serv = Long.parseLong(request.getParameter("servicio"));
                    if(veh!=null){
                    //long serv = Long.parseLong(request.getParameter("servicio"));
                    if(veh.getServicio()==2){
                        compp.setRadio_accion(Long.parseLong(request.getParameter("RA")));
                        compp.setModalidad(Long.parseLong(request.getParameter("MT")));
                        compp.setTransporte_pasajeros(Long.parseLong(request.getParameter("TP")));
                        System.out.println(request.getParameter("RA"));
                        System.out.println(request.getParameter("MT"));
                        System.out.println(request.getParameter("TP"));
                        long sw = Long.parseLong(request.getParameter("TP"));
                        if(sw==4){
                            System.out.println(request.getParameter("ES"));
                            compp.setEspecial(Long.parseLong(request.getParameter("ES")));
                        }
                        model.InsertDetCompPublico(compp);
                    }
                    }else{
                     long serv = Long.parseLong(request.getParameter("servicio"));
                    if(serv==2){
                        compp.setRadio_accion(Long.parseLong(request.getParameter("RA")));
                        compp.setModalidad(Long.parseLong(request.getParameter("MT")));
                        compp.setTransporte_pasajeros(Long.parseLong(request.getParameter("TP")));
                        System.out.println(request.getParameter("RA"));
                        System.out.println(request.getParameter("MT"));
                        System.out.println(request.getParameter("TP"));
                        long sw=Long.parseLong(request.getParameter("TP"));
                        if(sw==4){
                            System.out.println(request.getParameter("ES"));
                            compp.setEspecial(Long.parseLong(request.getParameter("ES")));
                        }
                        model.InsertDetCompPublico(compp);
                    }
                    }

                boolean paso = false;
                if (comparendo != null && fecha != null && horas != null && minutos != null && lugar != null && tipoDocumento != null && documento != null && tipoInfractor != null && infraccion != null && placaAgente != null && polca != null) {
                    if (comparendo.trim().length() > 0) {
                        if (fecha.trim().length() == 10) {
                            if (horas.length() >= 0 && minutos.length() >= 0) {
                                lugar = lugar.trim().toUpperCase();
                                if (lugar.length() > 5) {
                                    placa = placa != null ? placa.trim().toUpperCase() : "";
                                    licenciaTransito = licenciaTransito != null ? licenciaTransito.trim() : "";
                                    clase = clase != null ? clase : "";
                                    servicio = servicio != null ? servicio : "";
                                    if (placa.length() > 4 || placa.length() == 0) {
                                        if (tipoDocumento.length() > 0 && documento.trim().length() > 0) {
                                            tipoInfractor = tipoInfractor != null ? tipoInfractor : "";
                                            if (infraccion.length() > 0) {
                                                licenciaConduccion = licenciaConduccion != null ? licenciaConduccion.trim() : "";
                                                fechaVencimiento = fechaVencimiento != null ? fechaVencimiento.trim() : "";
                                                categoria = categoria != null ? categoria : "";
                                                sedeExpedicion = sedeExpedicion != null ? sedeExpedicion : "";
                                                if ((licenciaConduccion.length() > 0 && fechaVencimiento.length() == 10) || licenciaConduccion.length() == 0) {
                                                    if (placaAgente.length() > 0) {
                                                        fuga = fuga != null ? fuga : "0";
                                                        accidente = accidente != null ? accidente : "0";
                                                        inmovilizacion = inmovilizacion != null ? inmovilizacion : "0";
                                                        polca = polca != null ? polca : "0";
                                                        firma = firma != null ? firma : "0";
                                                        observacion = observacion != null ? observacion.trim().toUpperCase() : "";
                                                        parqueaderos = parqueaderos != null ? parqueaderos : "";
                                                        paso = true;
                                                    } else {
                                                        msg = "Ingrese placa del agente";
                                                    }
                                                } else {
                                                    msg = "La fecha de vencimiento de la licencia es incorrecta";
                                                }
                                            } else {
                                                msg = "Ingrese una infraccion para el comparendo";
                                            }
                                        } else {
                                            msg = "Ingrese un tipo y documento valido";
                                        }
                                    } else {
                                        msg = "Ingrese la placa, clase y servicio del vehiculo";
                                    }
                                } else {
                                    msg = "Ingrese el lugar de la infraccion";
                                }
                            } else {
                                msg = "Ingrese la hora y minuto del comparendo";
                            }
                        } else {
                            msg = "Ingrese fecha del comparendo";
                        }
                    } else {
                        msg = "Ingrese numero de comparendo";
                    }
                }

                if (paso) {
                    java.util.Calendar calendar = null;
                    String cmp = "";
                    int claseVehiculo = 0;
                    int servicioVehiculo = 0;
                    int tipo = 0;
                    String doc = "";
                    String lit = "";
                    String lic = "";
                    int tinf = 0;
                    java.sql.Date fechaV = null;
                    int placaA = 0;
                    long sedeE = 0;
                    int cf = 0;
                    int ca = 0;
                    int ci = 0;
                    int cp = 0;
                    int cr = 0;
                    long parque = 0;
                    java.sql.Timestamp fechaComparendo = null;
                    int valorAdicional = 13300;


                    try {
                        cmp = comparendo.trim();
                        fechaComparendo = new java.sql.Timestamp(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fecha).getTime());
                        fechaComparendo.setHours(Integer.parseInt(horas));
                        fechaComparendo.setMinutes(Integer.parseInt(minutos));
                        if (clase.length() > 0) {
                            claseVehiculo = Integer.parseInt(clase);
                        }
                        if (servicio.length() > 0) {
                            servicioVehiculo = Integer.parseInt(servicio);
                        }
                        tipo = Integer.parseInt(tipoDocumento);
                        doc = Long.parseLong(documento.trim()) + "";
                        if (tipoInfractor.length() > 0) {
                            tinf = Integer.parseInt(tipoInfractor);
                        }
                        if (licenciaTransito.length() > 0) {
                            lit = Long.parseLong(licenciaTransito) + "";
                        }
                        if (licenciaConduccion.length() > 0) {
                            lic = Long.parseLong(licenciaConduccion) + "";
                        }
                        if (fechaVencimiento.length() == 10) {
                            fechaV = new java.sql.Date(new java.text.SimpleDateFormat("dd/mm/yyyy").parse(fechaVencimiento).getTime());
                        }
                        placaA = Integer.parseInt(placaAgente);
                        if (sedeExpedicion.length() > 0) {
                            sedeE = Long.parseLong(sedeExpedicion);
                        }
                        cf = Integer.parseInt(fuga);
                        ca = Integer.parseInt(accidente);
                        ci = Integer.parseInt(inmovilizacion);
                        cp = Integer.parseInt(polca);
                        cr = Integer.parseInt(firma);
                        if (parqueaderos.length() > 0) {
                            parque = Long.parseLong(parqueaderos);
                        }
                    } catch (Exception exc1) {
                        msg = "Error al convertir numeros y fechas, valor invalido en " + exc1.getMessage();
                        paso = false;
                    }

                    if (paso) {
                        modelo.Comparendo c = model.consultar_Comparendo(comparendo.trim());
                        if (c == null) {
                            modelo.Persona p = model.consultarPersona(tipo, documento);
                            if (p != null) {
                                modelo.Infraccion i = model.consultarInfraccionByNumero(infraccion.trim().toUpperCase());
                                if (i != null) {
                                    modelo.Valor_Infraccion vi = model.consultarValorInfraccion(new java.sql.Date(fechaComparendo.getTime()), i.getId_infraccion());
                                    if (vi != null) {
                                        modelo.Agente a = model.consultarAgente(placaA);
                                        if (a != null) {
                                            modelo.Vehiculo v = model.consultarVehiculo(placa);
                                            if (v != null) {
                                                claseVehiculo = (int) v.getClase_vehiculo();
                                                servicioVehiculo = (int) v.getServicio();
                                                if (lit.equals("")) {
                                                    modelo.Licencia_Transito lt = model.consultarLicenciaTransito(v.getId_vehiculo());
                                                    if (lt != null) {
                                                        lit = lt.getNumero();
                                                    }
                                                }
                                            }
                                            if (lic.equals("")) {
                                                modelo.Licencia_Conduccion lc = model.consultarLicenciaIdPersona(p.getId_persona());
                                                if (lc != null) {
                                                    lic = lc.getNumeroLicencia();
                                                    categoria = lc.getCategoria();
                                                    fechaV = lc.getFechaVencimiento();
                                                    sedeE = lc.getFk_sede();
                                                }
                                            }

                                            try {
                                                //Inicia proceso de registro
                                                modelo.Cartera cartera = new modelo.Cartera();
                                                cartera.setFk_persona(p.getId_persona());
                                                cartera.setFk_sede(usuario.getFk_sede());
                                                cartera.setTipo(1);
                                                cartera.setReferencia(comparendo.trim());
                                                cartera.setFecha_creacion(fechaUpdate);
                                                cartera.setFecha_ingreso(fechaUpdate);
                                                cartera.setValor(vi.getValor());
                                                cartera.setSaldo(vi.getValor()+valorAdicional);
                                                //cartera.setSaldo(vi.getValor());
                                                cartera.setFecha_saldo(fechaUpdate);
                                                cartera.setEstado_cartera(1);
                                                cartera.setFecha_estado(fechaUpdate);
                                                cartera.setEstado_vigencia(1);
                                                cartera.setFecha_estado_vigencia(fechaUpdate);
                                                cartera.setFk_usuario(usuario.getId_usuario());
                                                cartera.setFk_concepto(12);

                                                modelo.Comparendo nc = new modelo.Comparendo();
                                                nc.setFk_persona(p.getId_persona());
                                                nc.setFk_usuario_organismo(usuario.getId_usuario());
                                                nc.setFk_sede(usuario.getFk_sede());//id_sede
                                                nc.setFk_infraccion(i.getId_infraccion());
                                                nc.setFk_agente(a.getId_agente());
                                                nc.setNumero(comparendo.trim());
                                                nc.setFecha(fechaComparendo);//fecha comparendo
                                                nc.setLugar(lugar);
                                                nc.setPlaca(placa);
                                                nc.setClase(claseVehiculo);
                                                nc.setServicio(servicioVehiculo);
                                                nc.setLicencia_transito(lit);
                                                nc.setTipo_infractor(tinf);
                                                nc.setObservaciones(observacion);
                                                nc.setFuga(cf);
                                                nc.setAccidente(ca);
                                                nc.setInmovilizacion(ci);
                                                nc.setPolca(cp);
                                                nc.setFirmado(cr);
                                                nc.setEstado(1);
                                                nc.setFecha_proceso(fechaSystem);
                                                nc.setLicencia_conduccion(lic);
                                                nc.setCategoria(categoria);
                                                nc.setFecha_vencimiento(fechaV);
                                                nc.setSede_expedicion(sedeE);
                                                nc.setFk_parqueadero(ci == 1 ? parque : 0);
                                                nc.setfk_via(via);
                                                model.getCon().setAutoCommit(false);
                                                long idCartera = model.adicionarCartera(cartera);
                                                if (idCartera != 0) {
                                                    long total = Math.round(cartera.getValor());
                                                    modelo.Detalle_Cartera detalleCartera = new modelo.Detalle_Cartera();
                                                    detalleCartera.setFk_cartera(idCartera);
                                                    detalleCartera.setReferencia(comparendo.trim());
                                                    detalleCartera.setFecha(fechaUpdate);
                                                    detalleCartera.setFecha_sistema(fechaSystem);
                                                    detalleCartera.setEstado(1);
                                                    detalleCartera.setFk_usuario(usuario.getId_usuario());
                                                    double porcentajeP = 0.90;
                                                    double porcentajeS = 0.10;
                                                    long valor = 0;
                                                     if (cp == 1) {
                                                        detalleCartera.setFk_concepto(73);
                                                        valor = Math.round(cartera.getValor() * 0.55);
                                                        total -= valor;
                                                        detalleCartera.setValor(valor);
                                                        model.adicionarDetalleCartera(detalleCartera);
                                                        porcentajeP = 0.45;
                                                        porcentajeS = 0.00;

                                                        detalleCartera.setFk_concepto(12);
                                                        valor = Math.round(cartera.getValor() * 0.45);
                                                        total -= valor;
                                                        detalleCartera.setValor(valor);
                                                        model.adicionarDetalleCartera(detalleCartera);

                                                    }else{
                                                        detalleCartera.setFk_concepto(12);
                                                        valor = Math.round(cartera.getValor() * 0.9);
                                                        total -= valor;
                                                        detalleCartera.setValor(valor);
                                                        model.adicionarDetalleCartera(detalleCartera);

                                                        detalleCartera.setFk_concepto(88);
                                                        valor = Math.round(cartera.getValor() * 0.1);
                                                        total -= valor;
                                                        detalleCartera.setValor(valor);
                                                        model.adicionarDetalleCartera(detalleCartera);

                                                    }

                                                    detalleCartera.setFk_concepto(300);
                                                    detalleCartera.setValor(valorAdicional);
                                                    model.adicionarDetalleCartera(detalleCartera);

                                                    nc.setFk_cartera(idCartera);
                                                    model.adicionarComparendo(nc);
                                                    Comparendo comp =model.consultar_Comparendo(nc.getNumero());
                                                    modelo.auditoria_comparendo aud = new modelo.auditoria_comparendo();
                                                    System.out.println("ok vamos hace esto ->"+comp.getNumero());
                                                    aud.setFk_comparendo(comp.getId_comparendo());
                                                    aud.setFk_estado(1);
                                                    aud.setFecha_proceso(comp.getFecha_proceso());
                                                    aud.setUsuario(comp.getFk_usuario_organismo());
                                                    aud.setEstado(1);
                                                    aud.setFecha_inicio(comp.getFecha_proceso());
                                                    aud.setFecha_fin(null);
                                                    model.InsertAuditoriaComparendo(aud);
                                                    if(nc.getPolca()!=1){
                                                    ingresoComparendoSimit(model, usuario, nc);
                                                    }
                                                    model.getCon().commit();
                                                    return true;

                                                } else {
                                                    model.getCon().rollback();
                                                    msg = "No se puedo crear la cartera asociada al comparendo";
                                                }
                                            } catch (Exception exc2) {
                                                model.getCon().rollback();
                                                msg = "Se ha generado una excepcion al ingresar el comparendo :" + exc2.getMessage();
                                            }
                                        } else {
                                            msg = "El numero de placa de agente no esta registrado";
                                        }
                                    } else {
                                        msg = "No se ha establecido un rango de valores para la infraccion en ese determinado tiempo";
                                    }
                                } else {
                                    msg = "El numero de la infraccion no existe o no se encuentra parametrizado";
                                }
                            } else {
                                msg = "La persona no se encuentra registrada";
                            }
                        } else {
                            msg = "El numero de comparendo ya se encuentra registrado";
                        }
                    }
                }
            } else {
                msg = "La sesion ya no se encuentra activa";
            }
        } catch (Exception exc) {
            exc.printStackTrace();
            msg = "Se ha generado una excepcion al ingresar el comparendo :" + exc.getMessage();
        }
        return false;
    }

    public boolean adicionarRecaudoPago(Model model, Usuario usuario, Tiquete tiquete, Cartera cartera, float valorComparendo) throws Exception {

        String refer = "";
        Comparendo comparendo = new Comparendo();
        if(cartera.getTipo()==3){
            Detalle_Financiacion df = model.consultarDetalleFinanciacionByFk_cartera(cartera.getId_cartera());
            Financiacion_Cartera fi = model.consultarfinanciacionCarteraByFk_financiacion(df.getFk_financiacion());
            Cartera cart = model.consultarCartera(fi.getFk_cartera());
            if(cart.getEstado_cartera()==4){
                refer = cart.getReferencia();
            }
        }else{
            refer = cartera.getReferencia();
        }
        comparendo = model.consultar_Comparendo(refer);
        if (comparendo != null) {
            if(cartera.getTipo()!=3){
            model.actualizarComparendo(cartera.getId_cartera(), 2);
            }
            Resolucion_Comparendo resolucionComparendo = model.consultarResolucionComparendo(comparendo.getId_comparendo());
            Comparendo_Curso curso = model.consultarComparendoCurso(comparendo.getId_comparendo());
            Persona persona = model.consultarPersona(comparendo.getFk_persona());
            if (persona != null) {
                String nombres = (persona.getNombre_1() + " " + (persona.getNombre_2() != null ? persona.getNombre_2() : "")).trim();
                String apellidos = (persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "")).trim();
                SimitResolucion simitResolucion = null;
                int descuento = 0;
                float valorAdicional = model.valorDetalleCarteraAtributos(cartera.getId_cartera(),cartera.getFk_sede(),7);
                if (curso != null) {
                    descuento = curso.getDescuento();
                    simitResolucion = new SimitResolucion();
                    simitResolucion.setESTADO(1);
                    simitResolucion.setFECHA_REGISTRO(new java.sql.Timestamp(new java.util.Date().getTime()));
                    //simitResolucion.setFECHA_REPORTE();
                    //simitResolucion.setRESCONSECUTIVO();
                    int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                    int numeroR = model.consultarConsecutivo(usuario.getFk_sede(), 11, vigencia);
                    String consecutivo = "R" + vigencia + ("00000".substring(0, 5 - (numeroR + "").length())) + numeroR;
                    model.actualizarConsecutivo(usuario.getFk_sede(), 11, vigencia);
                    simitResolucion.setRESNUMERO(consecutivo);
                    if (resolucionComparendo != null) {
                        simitResolucion.setRESNUMANT(resolucionComparendo.getNumero());
                        simitResolucion.setRESTIPORES("1");
                    }else{
                        simitResolucion.setRESTIPORES("23");
                    }
                    simitResolucion.setRESFECHA(new java.text.SimpleDateFormat("dd/MM/yyyy").format(tiquete.getFecha()));
                    simitResolucion.setRESFHASTA("");
                    simitResolucion.setRESCOMP(comparendo.getNumero());
                    simitResolucion.setRESCOMPF(new java.text.SimpleDateFormat("dd/MM/yyyy").format(comparendo.getFecha()));
                    simitResolucion.setRESNIPINFRAC(persona.getDocumento());
                    simitResolucion.setRESTIPODOC(((persona.getTipo_documento()==4)?3:persona.getTipo_documento())+"");
                    simitResolucion.setRESNOMBE(nombres.length() > 18 ? nombres.substring(0, 18) : nombres);
                    simitResolucion.setRESAPELLIDO(apellidos.length() > 20 ? apellidos.substring(0, 20) : apellidos);
                    modelo.Direccion direccion = model.consultarDireccion(persona.getId_persona());
                    if (direccion != null) {
                        if (direccion.getDescripcion() != null) {
                            simitResolucion.setRESDIRINFRACTOR(direccion.getDescripcion().length() > 40 ? direccion.getDescripcion().toUpperCase().substring(0, 40) : direccion.getDescripcion());
                        }
                        if (direccion.getTelefono() != null) {
                            simitResolucion.setRESTELEINFRACTOR(direccion.getTelefono().length() > 15 ? direccion.getTelefono().substring(0, 15) : direccion.getTelefono());
                        }
                        if (direccion.getFk_divipo() != 0) {
                            Divipo divipo = model.getDivipo(direccion.getFk_divipo());
                            if (divipo != null) {
                                simitResolucion.setRESIDCIUDAD((divipo.getCodigo().length() == 7 ? "0" : "") + divipo.getCodigo());
                            } else {
                                simitResolucion.setRESIDCIUDAD("08001000");
                            }
                        }
                    }else{
                        simitResolucion.setRESDIRINFRACTOR("NO REGISTRA");
                        simitResolucion.setRESIDCIUDAD("08001000");
                    }
                    simitResolucion.setRESVALOR((Math.round(cartera.getValor() * (100 - descuento) / 100)) + "");
                    simitResolucion.setRESVALAD(valorAdicional+"");
                    simitResolucion.setRESORGANISMO("08000000");
                    simitResolucion.setRESCOMPOLCA(comparendo.getPolca() == 1 ? "S" : "N");
                    Infraccion infraccion = model.consultarInfraccion(comparendo.getFk_infraccion());
                    simitResolucion.setRESINFRACCION(infraccion.getNumero());
                    simitResolucion.setRESVALINF(Math.round(cartera.getValor()) + "");
                    simitResolucion.setRESVALPAG(Math.round((cartera.getValor() * (100 - descuento) / 100)+valorAdicional) + "");
                    model.adicionarSimitResolucion(simitResolucion);
                    if (resolucionComparendo != null) {
                        model.actualizarResolucionComparendo(resolucionComparendo.getId_resolucion(), 2);
                    }
                    resolucionComparendo = new Resolucion_Comparendo();
                    resolucionComparendo.setEstado(1);
                    resolucionComparendo.setFecha(tiquete.getFecha());
                    resolucionComparendo.setFecha_proceso(new java.sql.Timestamp(new java.util.Date().getTime()));
                    resolucionComparendo.setFk_comparendo(comparendo.getId_comparendo());
                    resolucionComparendo.setFk_usuario(usuario.getId_usuario());
                    resolucionComparendo.setNumero(consecutivo);
                    resolucionComparendo.setObservacion("DESCUENTO DE COMPARENDO " + descuento + "%");
                    resolucionComparendo.setTipo(Integer.parseInt(simitResolucion.getRESTIPORES()));
                    resolucionComparendo.setValor((float) (cartera.getValor() * (100 - descuento) / 100)+valorAdicional);
                    model.adicionarResolucionComparendo(resolucionComparendo);
                }
                SimitRecaudo simitRecaudo = new SimitRecaudo();
                simitRecaudo.setESTADO(1);
                simitRecaudo.setFECHA_REGISTRO(new java.sql.Timestamp(new java.util.Date().getTime()));
                //simitRecaudo.setFECHA_REPORTE();
                //simitRecaudo.setRECCONSECUTIVO();
                simitRecaudo.setRECFAPL(new java.text.SimpleDateFormat("dd/MM/yyyy").format(tiquete.getFecha()));
                simitRecaudo.setRECHORA(new java.text.SimpleDateFormat("hh:mm").format(tiquete.getFecha_proceso()));
                simitRecaudo.setRECFTRAN(new java.text.SimpleDateFormat("dd/MM/yyyy").format(tiquete.getFecha()));
                simitRecaudo.setRECCANAL("0");
                simitRecaudo.setRECORIGEN("TAQUILLA TRANSITO");
                simitRecaudo.setRECEFECTIVO(Math.round((cartera.getValor() * (100 - descuento) / 100)+valorAdicional) + "");
                simitRecaudo.setRECCHEQUE("0");
                simitRecaudo.setRECTOTAL(Math.round((cartera.getValor() * (100 - descuento) / 100)+valorAdicional) + "");

                if (resolucionComparendo != null) {
                    if(resolucionComparendo.getTipo()==1){
                        simitRecaudo.setRECDOCUMENTO(resolucionComparendo.getNumero());
                        simitRecaudo.setRECTIPOREC("3");
                    }else{
                        simitRecaudo.setRECDOCUMENTO(comparendo.getNumero());
                        simitRecaudo.setRECTIPOREC("1");
                    }
                } else {
                    simitRecaudo.setRECDOCUMENTO(comparendo.getNumero());
                    simitRecaudo.setRECTIPOREC("1");
                }
                simitRecaudo.setRECPOLCA(comparendo.getPolca() == 1 ? "S" : "N");
                simitRecaudo.setRECNIP(persona.getDocumento());
                simitRecaudo.setRECSECRET("08000000");
                simitRecaudo.setRECNUM(tiquete.getNumero_factura());
                model.adicionarSimitRecaudo(simitRecaudo);
                return true;
            }
        }
        return false;
    }

    public String getMsg() {
        return msg;
    }

    public void ingresoComparendoSimit(Model model, Usuario usuario, Comparendo comparendo) {
        try {

            Cartera cartera = model.consultarCartera(comparendo.getFk_cartera());
            if (cartera != null) {

                modelo.Persona persona = model.consultarPersona(comparendo.getFk_persona());

                if (persona != null) {

                    SimitComparendo simitComparendo = new SimitComparendo();
                    simitComparendo.setESTADO(1);

                    simitComparendo.setFECHA_REGISTRO(new java.sql.Timestamp(new java.util.Date().getTime()));
                    //simitComparendo.setFECHA_REPORTE();
                    //simitComparendo.setCOMCONSECUTIVO();
                    simitComparendo.setCOMNUMERO(comparendo.getNumero());
                    System.out.println("NUMERO COMPARENDO:"+comparendo.getNumero());
                    simitComparendo.setCOMFECHA(new java.text.SimpleDateFormat("dd/MM/yyyy").format(comparendo.getFecha()));
                    System.out.println("FECHA COMPARENDO: "+comparendo.getFecha());
                    simitComparendo.setCOMHORA(new java.text.SimpleDateFormat("hhmm").format(comparendo.getFecha()));

                    if(comparendo.getLugar()!=null){
                    simitComparendo.setCOMDIR(comparendo.getLugar().length() > 80 ? comparendo.getLugar().substring(0, 80) : comparendo.getLugar());
                    System.out.println("LUGAR: "+comparendo.getLugar());
                    }

                    simitComparendo.setCOMDIVIPOMUNI("08001000");
                    simitComparendo.setCOMLOCALIDADCOMUNA("");
                    simitComparendo.setCOMPLACA(comparendo.getPlaca());
                    System.out.println("PLACA VEHICULO: "+comparendo.getPlaca());

                    simitComparendo.setCOMDIVIPOMATRI("");

                    if(comparendo.getClase()!= 0){
                    simitComparendo.setCOMTIPOVEHI(comparendo.getClase() + "");
                    System.out.println("CLASE: "+comparendo.getClase());
                    }

                    if(comparendo.getServicio()!=0){
                    simitComparendo.setCOMTIPOSER((comparendo.getServicio() == 1 ? 3 : comparendo.getServicio() == 3 ? 5 : comparendo.getServicio() == 4 ? 1 : comparendo.getServicio()) + "");
                    System.out.println("SERVICIO: "+comparendo.getServicio());
                    }

                    simitComparendo.setCOMCODIGORADIO("1");
                    simitComparendo.setCOMCODIGOMODALIDAD("");
                    simitComparendo.setCOMCODIGOPASAJEROS("");

                    if(persona.getDocumento()!= null){
                    simitComparendo.setCOMINFRACTOR(persona.getDocumento());
                    System.out.println("DOCUMENTO: "+persona.getDocumento());

                    if(persona.getTipo_documento()!=0){
                    System.out.println("TIPO DOCUMENTO: "+persona.getTipo_documento());
                    String tipod = ""+model.consultarParametro(persona.getTipo_documento(), 5).getCodigo()+"".trim();

                    simitComparendo.setCOMTIPODOC(tipod.equals("4")?"2":tipod.equals("5")?"4":tipod);
                    }

                    String nombres = (persona.getNombre_1() + " " + (persona.getNombre_2() != null ? persona.getNombre_2() : "")).trim();
                    String apellidos = (persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "")).trim();
                    simitComparendo.setCOMNOMBE(nombres.length() > 18 ? nombres.substring(0, 18) : nombres);
                    simitComparendo.setCOMAPELLIDO(apellidos.length() > 20 ? apellidos.substring(0, 20) : apellidos);
                    simitComparendo.setCOMEDADINFRACTOR("");
                    System.out.println("ID_PERSONA: "+persona.getId_persona());
                    modelo.Direccion direccion = model.consultarDireccion(persona.getId_persona());
                    if (direccion != null) {
                        System.out.println("DIRECCION: "+direccion.getDescripcion());
                        System.out.println("TELEFONO: "+direccion.getTelefono());
                        simitComparendo.setCOMDIRINFRACTOR(direccion.getDescripcion().length() > 40 ? direccion.getDescripcion().substring(0, 40) : direccion.getDescripcion());
                        simitComparendo.setCOMTELEINFRACTOR(direccion.getTelefono().length() > 15 ? direccion.getTelefono().substring(0, 15) : direccion.getTelefono());
                    }
                    if(persona.getEmail()!= null){
                     System.out.println("EMAIL: "+persona.getEmail());
                    simitComparendo.setCOMEMAIL(persona.getEmail().length() > 20 ? persona.getEmail().substring(0, 20) : persona.getEmail());
                    }
                    }

                    simitComparendo.setCOMIDCIUDAD("");
                    if(comparendo.getLicencia_conduccion()!= null){
                    System.out.println("LICENCIA DE CONDUCCION: "+comparendo.getLicencia_conduccion());
                    simitComparendo.setCOMLICENCIA(comparendo.getLicencia_conduccion());
                    }

                    if(comparendo.getCategoria()!=null){
                    System.out.println("CATEGORIA LICENCIA DE CONDUCCION: "+comparendo.getCategoria());
                    simitComparendo.setCOMCATEGORIA(comparendo.getCategoria());
                    }

                    if (comparendo.getSede_expedicion() != 0) {
                        System.out.println("SEDE EXPEDICION LICENCIA DE CONDUCCION: "+comparendo.getSede_expedicion());
                        simitComparendo.setCOMSECREEXPIDE(model.consultarSede(comparendo.getSede_expedicion()).getCodigo());
                        simitComparendo.setCOMDIVIPOLICEN(simitComparendo.getCOMSECREEXPIDE());
                    }

                    if (comparendo.getFecha_vencimiento() != null) {
                        System.out.println("FECHA DE VENCIMIENTO: "+comparendo.getFecha_vencimiento());
                        simitComparendo.setCOMFECHAVENCE(new java.text.SimpleDateFormat("dd/MM/yyyy").format(comparendo.getFecha_vencimiento()));
                    }

                    if(comparendo.getTipo_infractor()!=0){
                    System.out.println("TIPO INFRACTOR: "+comparendo.getTipo_infractor());
                    simitComparendo.setCOMTIPOINFRAC(comparendo.getTipo_infractor() == 2 ? "4" : comparendo.getTipo_infractor() == 3 ? "2" : comparendo.getTipo_infractor() == 4 ? "3" :comparendo.getTipo_infractor() + "");
                    }

                    if(comparendo.getLicencia_transito()!= null){
                    System.out.println("LICENCIA DE TRANSITO: "+comparendo.getLicencia_transito());
                    simitComparendo.setCOMPLICTRANSITO(comparendo.getLicencia_transito());
                    }

                    simitComparendo.setCOMIDENTIFICACION("");
                    simitComparendo.setCOMIDTIPODOCPROP("");
                    simitComparendo.setCOMNOMBREPROP("");
                    simitComparendo.setCOMNOMBREEMPRESA("");
                    simitComparendo.setCOMNITEMPRESA("");
                    simitComparendo.setCOMTARJETAOPERACION("");

                    String idagente = ""+comparendo.getFk_agente()+"".trim();
                    System.out.println("ID AGENTE: "+idagente);
                    modelo.Agente ag = model.consultarAgenteById(Integer.parseInt(idagente));
                    System.out.println("PLACA AGENTE: "+ag.getPlaca());
                    String placaagente = ""+ag.getPlaca()+"";
                    System.out.println("PLACA AGENTE2: "+placaagente);
                    simitComparendo.setCOMPPLACAAGENTE(placaagente);

                    if(comparendo.getObservaciones()!=null){
                    System.out.println("OBSERVACIONES: "+comparendo.getObservaciones());
                    simitComparendo.setCOMOBSERVA(comparendo.getObservaciones());
                    }

                    System.out.println("FUGA: "+comparendo.getFuga());
                    simitComparendo.setCOMFUGA(comparendo.getFuga() == 1 ? "S" : "N");

                    System.out.println("ACCIDENTE: "+comparendo.getAccidente());
                    simitComparendo.setCOMACCI(comparendo.getAccidente() == 1 ? "S" : "N");

                    System.out.println("INMOVILIZACION: "+comparendo.getInmovilizacion());
                    simitComparendo.setCOMINMOV(comparendo.getInmovilizacion() == 1 ? "S" : "N");

                    simitComparendo.setCOMPATIOINMOVILIZA("");
                    simitComparendo.setCOMDIRPATIOINMOVI("");
                    simitComparendo.setCOMGRUANUMERO("");
                    simitComparendo.setCOMPLACAGRUA("");
                    simitComparendo.setCOMCONSECUTIINMOVI("0");
                    simitComparendo.setCOMIDENTIFICACIONTEST("");
                    simitComparendo.setCOMNOMBRETESTI("");
                    simitComparendo.setCOMDIRECRESTESTI("");
                    simitComparendo.setCOMTELETESTIGO("");
                    String valorInfraccion = ""+(long)cartera.getValor()+"".trim();
                    System.out.println("VALOR CARTERA: "+valorInfraccion);
                    simitComparendo.setCOMVALINFRA(valorInfraccion);
                    System.out.println("ID CARTERA: "+cartera.getId_cartera());
                    System.out.println("SEDE: "+cartera.getFk_sede());
                    float valorAdicional = model.valorDetalleCarteraAtributos(cartera.getId_cartera(),cartera.getFk_sede(),7);
                    String valorAdi = ""+(long)valorAdicional+"".trim();
                    System.out.println("Valor Adicional "+valorAdi);
                    simitComparendo.setCOMVALAD(valorAdi);
                    String valorSaldo = ""+(long)cartera.getSaldo()+"".trim();
                    System.out.println("SALDO DE CARTERA: "+valorSaldo);
                    simitComparendo.setCOMVALOR(valorSaldo);
                    simitComparendo.setCOMORGANISMO("08000000");
                    simitComparendo.setCOMESTADOCOM("1");

                    System.out.println("POLCA: "+comparendo.getPolca());
                    simitComparendo.setCOMPOLCA(comparendo.getPolca() == 1 ? "S" : "N");

                    String id_infraccion = ""+comparendo.getFk_infraccion()+"".trim();
                    modelo.Infraccion inf = model.consultarInfraccion(Long.parseLong(id_infraccion));
                    String infraccion = ""+inf.getNumero()+"".trim();
                    System.out.println("INFRACCION: "+infraccion);
                    simitComparendo.setCOMINFRACCION(infraccion);
                    model.adicionarSimitComparendo(simitComparendo);
                }
            }
        }catch(Exception exc){
            exc.printStackTrace();
        }
    }

    public String getArchivoSimit() {
        return ArchivoSimit;
    }

    public String getResolucionSimit() {
        return ResolucionSimit;
    }

    public String getRecaudoSimit() {
        return RecaudoSimit;
    }

    public boolean generarPlanos(Model model, Usuario usuario,int estado) {
        try {
            if (model != null && usuario != null) {
                model.getCon().setAutoCommit(false);
                SimitPlano simitPlano = new SimitPlano();
                int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                System.out.println("***GENERAR PLANOS***");
                System.out.println(vigencia);
                System.out.println("SEDE USUARIO: "+usuario.getFk_sede());
                int numero = model.consultarConsecutivo(usuario.getFk_sede(), 13, vigencia);
                String consecutivo = vigencia + ("000000".substring(0, 6 - (numero + "").length())) + numero;
                System.out.println("CONSECUTIVO: "+consecutivo);
                model.actualizarConsecutivo(usuario.getFk_sede(), 13, vigencia);
                simitPlano.setConsecutivo(consecutivo);
                simitPlano.setEstado(1);
                simitPlano.setFechaProceso(new java.sql.Timestamp(new java.util.Date().getTime()));
                simitPlano.setFechaReporte(new java.sql.Timestamp(new java.util.Date().getTime()));
                System.out.println("ID USUARIO: "+usuario.getId_usuario());
                simitPlano.setFkUsuario(usuario.getId_usuario());
                long idSimitPlano = model.adicionarSimitPlano(simitPlano);
                System.out.println("ESTADO: "+estado);
                System.out.println("ID SIMIT PLANO"+idSimitPlano);
                String fecha = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
                System.out.println("FECHA: "+fecha);
                String dir = "C:/Civitrans/transito/build/web/paginas/data/simit/"+fecha+"/"+consecutivo;
                System.out.println("DIRECTORIO: "+dir);
                File f = new File(dir);
                if(!f.exists())
                    f.mkdirs();
                generarPlanoComparendos(model, estado, idSimitPlano, consecutivo, dir);
                generarPlanoRecaudo(model, estado, idSimitPlano,consecutivo,dir);
                generarPlanoResolucion(model, estado, idSimitPlano,consecutivo,dir);
                model.getCon().commit();
            }
        } catch (Exception exc) {
            try {
                model.getCon().rollback();
                exc.printStackTrace();
                msg = "Se ha generado una excepcion al generar los planos :" + exc.getMessage();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
        return false;
    }

    public void generarPlanoComparendos(Model model,int estado,long idSimiPlano,String oficio,String dir)  throws Exception{

        String nombrePlanoComp = "08000000comp.txt";

        java.util.Date freporte = new java.util.Date();
        System.out.println("***GENERAR PLANOS COMPARENDOS***");
        System.out.println("FECHA REPORTE: "+freporte);
        java.sql.Date fcomparendo = new java.sql.Date(freporte.getTime());
        System.out.println("FECHA COMPARENDO: "+fcomparendo);
        File f = new File(dir+"/"+nombrePlanoComp);
        if(!f.exists())
            f.createNewFile();
        FileOutputStream fos = new FileOutputStream(f);
        DataOutputStream dos = new DataOutputStream(fos);
        java.util.List<SimitComparendo> lista = model.consultarComparendosSimit(estado);
        String x = ",";
        int i = 1;
        double sumaReg = 0;
        long digitoControl = 0;

        System.out.println("***GENERACION DE PLANO - PARA***");
        for(SimitComparendo r:lista){

            sumaReg += Double.parseDouble(r.getCOMVALOR());
            String detalle = i+x+
                    c(r.getCOMNUMERO())+x+
                    c(r.getCOMFECHA())+x+
                    c(r.getCOMHORA())+x+
                    c(r.getCOMDIR())+x+
                    c(r.getCOMDIVIPOMUNI())+x+
                    c(r.getCOMLOCALIDADCOMUNA())+x+
                    c(r.getCOMPLACA())+x+
                    c(r.getCOMDIVIPOMATRI())+x+
                    c(r.getCOMTIPOVEHI())+x+
                    c(r.getCOMTIPOSER())+x+
                    c(r.getCOMCODIGORADIO())+x+
                    c(r.getCOMCODIGOMODALIDAD())+x+
                    c(r.getCOMCODIGOPASAJEROS())+x+
                    c(r.getCOMINFRACTOR())+x+
                    c(r.getCOMTIPODOC())+x+
                    c(r.getCOMNOMBE())+x+
                    c(r.getCOMAPELLIDO())+x+
                    c(r.getCOMEDADINFRACTOR())+x+
                    c(r.getCOMDIRINFRACTOR())+x+
                    c(r.getCOMEMAIL())+x+
                    c(r.getCOMTELEINFRACTOR())+x+
                    c(r.getCOMIDCIUDAD())+x+
                    c(r.getCOMLICENCIA())+x+
                    c(r.getCOMCATEGORIA())+x+
                    c(r.getCOMSECREEXPIDE())+x+
                    c(r.getCOMFECHAVENCE())+x+
                    c(r.getCOMTIPOINFRAC())+x+
                    c(r.getCOMPLICTRANSITO())+x+
                    c(r.getCOMDIVIPOLICEN())+x+
                    c(r.getCOMIDENTIFICACION())+x+
                    c(r.getCOMIDTIPODOCPROP())+x+
                    c(r.getCOMNOMBREPROP())+x+
                    c(r.getCOMNOMBREEMPRESA())+x+
                    c(r.getCOMNITEMPRESA())+x+
                    c(r.getCOMTARJETAOPERACION())+x+
                    c(r.getCOMPPLACAAGENTE())+x+
                    c(r.getCOMOBSERVA())+x+
                    c(r.getCOMFUGA())+x+
                    c(r.getCOMACCI())+x+
                    c(r.getCOMINMOV())+x+
                    c(r.getCOMPATIOINMOVILIZA())+x+
                    c(r.getCOMDIRPATIOINMOVI())+x+
                    c(r.getCOMGRUANUMERO())+x+
                    c(r.getCOMPLACAGRUA())+x+
                    c(r.getCOMCONSECUTIINMOVI())+x+
                    c(r.getCOMIDENTIFICACIONTEST())+x+
                    c(r.getCOMNOMBRETESTI())+x+
                    c(r.getCOMDIRECRESTESTI())+x+
                    c(r.getCOMTELETESTIGO())+x+
                    c(r.getCOMVALOR())+x+
                    c(r.getCOMVALAD())+x+
                    c(r.getCOMORGANISMO())+x+
                    c(r.getCOMESTADOCOM())+x+
                    c(r.getCOMPOLCA())+x+
                    c(r.getCOMINFRACCION())+x+
                    c(r.getCOMVALINFRA());
            digitoControl += getDigitoControl(detalle);
            dos.writeBytes(detalle);
            dos.writeBytes("\r\n");
            System.out.println("ID COMPARENDO: "+r.getID_SIMIT_COMPARENDO());
            System.out.println("DETALLE: "+ detalle);

            model.actualizarEstadoSimitComparendo(r.getID_SIMIT_COMPARENDO(),8,idSimiPlano);
            model.actualizarSimitRecaudo(r.getID_SIMIT_COMPARENDO(),2,idSimiPlano,i,fcomparendo);
            i++;
        }

        String check = "0000";
        if(digitoControl>=1000){
            check = (digitoControl+"").substring((digitoControl+"").length()-4,(digitoControl+"").length());
        }else
            check = ("0000").substring(0,4-(digitoControl+"").length())+(digitoControl+"");
        String pieCabeza = lista.size()+x+sumaReg+x+oficio+x+check;
        System.out.println("PIE CABEZA: "+pieCabeza);
        dos.writeBytes(pieCabeza);
        dos.close();
        fos.close();
        ArchivoSimit = dir+"/"+nombrePlanoComp;
        model.getCon().commit();
    }

    public void generarPlanoRecaudo(Model model,int estado,long idSimiPlano,String oficio,String dir) throws Exception{
        java.util.Date freporte = new java.util.Date();
        java.sql.Date frecaudo = new java.sql.Date(freporte.getTime());
        String fecha = new java.text.SimpleDateFormat("yyyyMMdd").format(freporte);
        File f = new File(dir+"/08000000rec.txt");
        if(!f.exists())
            f.createNewFile();
        FileOutputStream fos = new FileOutputStream(f);
        DataOutputStream dos = new DataOutputStream(fos);
        java.util.List<SimitRecaudo> lista = model.consultarRecaudosSimit(estado);
        String x = ",";
        int i = 1;
        String encabezado = "0"+x+hoy()+x+hoy()+x+"08000000"+x+"1";
        dos.writeBytes(encabezado);
        dos.writeBytes("\r\n");
        int sumaReg = 0;
        long digitoControl = 0;
        for(SimitRecaudo r:lista){
            sumaReg += Integer.parseInt(r.getRECTOTAL());
            String detalle = i+x+
                    c(r.getRECFAPL())+x+
                    c(r.getRECHORA())+x+
                    c(r.getRECFTRAN())+x+
                    c(r.getRECCANAL())+x+
                    c(r.getRECORIGEN())+x+
                    c(r.getRECEFECTIVO())+x+
                    c(r.getRECCHEQUE())+x+
                    c(r.getRECTOTAL())+x+
                    c(r.getRECDOCUMENTO())+x+
                    c(r.getRECPOLCA())+x+
                    c(r.getRECNIP())+x+
                    c(r.getRECTIPOREC())+x+
                    c(r.getRECSECRET())+x+
                    c(r.getRECNUM());
            digitoControl += getDigitoControl(detalle);
            dos.writeBytes(detalle);
            dos.writeBytes("\r\n");
            model.actualizarSimitRecaudo(r.getID_SIMIT_RECAUDO(),2,idSimiPlano,i,frecaudo);
            i++;
        }
        String check = "0000";
        if(digitoControl>=1000){
            check = (digitoControl+"").substring((digitoControl+"").length()-4,(digitoControl+"").length());
        }else
            check = ("0000").substring(0,4-(digitoControl+"").length())+(digitoControl+"");

        String pieCabeza = lista.size()+x+sumaReg+x+fecha+x+check;
        dos.writeBytes(pieCabeza);
        dos.close();
        fos.close();
        RecaudoSimit = dir+"/08000000rec.txt";
    }

    public void generarPlanoResolucion(Model model,int estado,long idSimiPlano,String oficio,String dir) throws Exception{
        java.util.Date freporte = new java.util.Date();
        java.sql.Date fresolucion = new java.sql.Date(freporte.getTime());
        String fecha = new java.text.SimpleDateFormat("yyyyMMdd").format(freporte);
        File f = new File(dir+"/08000000resol.txt");
        if(!f.exists())
            f.createNewFile();
        FileOutputStream fos = new FileOutputStream(f);
        DataOutputStream dos = new DataOutputStream(fos);
        java.util.List<SimitResolucion> lista = model.consultarResolucionesSimit(estado);
        String x = ",";
        int i = 1;
        int sumaReg = 0;
        long digitoControl = 0;
        for(SimitResolucion r:lista){
            sumaReg += Integer.parseInt(r.getRESVALPAG());
            String detalle = i+x+
                    c(r.getRESNUMERO())+x+
                    c(r.getRESNUMANT())+x+
                    c(r.getRESFECHA())+x+
                    c(r.getRESTIPORES())+x+
                    c(r.getRESFHASTA())+x+
                    c(r.getRESCOMP())+x+
                    c(r.getRESCOMPF())+x+
                    c(r.getRESNIPINFRAC())+x+
                    c(r.getRESTIPODOC())+x+
                    c(r.getRESNOMBE())+x+
                    c(r.getRESAPELLIDO())+x+
                    c(r.getRESDIRINFRACTOR())+x+
                    c(r.getRESTELEINFRACTOR())+x+
                    c(r.getRESIDCIUDAD())+x+
                    c(r.getRESVALOR())+x+
                    c(r.getRESVALAD())+x+
                    c(r.getRESORGANISMO())+x+
                    c(r.getRESCOMPOLCA())+x+
                    c(r.getRESINFRACCION())+x+
                    c(r.getRESVALINF())+x+
                    c(r.getRESVALPAG());
            digitoControl += getDigitoControl(detalle);
            dos.writeBytes(detalle);
            dos.writeBytes("\r\n");
            model.actualizarSimitResolucion(r.getID_SIMIT_RESOLUCION(),2,idSimiPlano,i,fresolucion);
            i++;
        }
        String check = "0000";
        if(digitoControl>=1000){
            check = (digitoControl+"").substring((digitoControl+"").length()-4,(digitoControl+"").length());
        }else
            check = ("0000").substring(0,4-(digitoControl+"").length())+(digitoControl+"");
        String pieCabeza = lista.size()+x+sumaReg+x+fecha+x+check;
        dos.writeBytes(pieCabeza);
        dos.close();
        fos.close();
        ResolucionSimit = dir+"/08000000resol.txt";
    }

    public String getF(java.util.Date d0,java.sql.Date d1,java.sql.Timestamp d2,int t){
        if(t==1||t==0)
            return new java.text.SimpleDateFormat("dd/MM/yyyy").format(t==0?d0:d1);
        else
            return new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.sql.Date(d2.getTime()));
    }

    public String hoy(){
        return getF(new java.util.Date(),null,null,0);
    }

    public long getDigitoControl(String linea){
        long ascii = 0;
        for(int i=0;i<linea.length();i++){
            ascii += (int)linea.charAt(i);
        }
        return ascii;
    }

    public String c(String c){
        return (c==null)?"":c;
    }

    public boolean adicionarHorarioCurso(Model model,Usuario usuario, javax.servlet.http.HttpServletRequest request) throws SQLException{
        try{

            if(request.getParameter("fecha")!=null&&request.getParameter("horas")!=null&&request.getParameter("minutos")!=null){
                String fecha = request.getParameter("fecha");
                String horas = request.getParameter("horas");
                String minutos = request.getParameter("minutos");
                String cupos = request.getParameter("cupos");
                if (fecha.trim().length() == 10) {
                    if (horas.length() >= 0 && minutos.length() >= 0) {
                        java.sql.Timestamp fechaCapacitacion = new java.sql.Timestamp(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fecha).getTime());
                        fechaCapacitacion.setHours(Integer.parseInt(horas));
                        fechaCapacitacion.setMinutes(Integer.parseInt(minutos));
                        if (cupos.length() > 0) {
                            int nCupos = Integer.parseInt(cupos);
                            Horario_Curso horarioCurso = new Horario_Curso();
                            horarioCurso.setFecha(fechaCapacitacion);
                            horarioCurso.setCupos(nCupos);
                            horarioCurso.setEstado(1);
                            model.getCon().setAutoCommit(false);
                            long idHorario = model.adicionarHorarioCurso(horarioCurso);
                            model.getCon().commit();
                            return idHorario!=0;
                        }
                    }
                }
            }
        }catch(Exception exc){
            this.msg = exc.getMessage();
            model.getCon().rollback();
            exc.printStackTrace();
        }
        return false;
    }

    public boolean adicionarCitacionComparendo(Model model,Usuario usuario, javax.servlet.http.HttpServletRequest request) throws SQLException{
        try{

            if(request.getParameter("idComparendo")!=null&&request.getParameter("idH")!=null){
                long idComparendo = Long.parseLong(request.getParameter("idComparendo"));
                long idH = Long.parseLong(request.getParameter("idH"));
                Comparendo comparendo = model.consultarComparendoById(idComparendo);
                Horario_Curso horarioCurso = model.consultarHorarioCurso(idH);
                Liquidacion_Cia liquidacion = model.consultarLiquidacionCIA(comparendo.getId_comparendo(),comparendo.getFk_persona());
                if(comparendo!=null&&horarioCurso!=null&&liquidacion!=null){
                    if(liquidacion.getReferencia()!=null){
                        model.getCon().setAutoCommit(false);
                        Citacion_Comparendo citacion = new Citacion_Comparendo();
                        int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
                        int numero = model.consultarConsecutivo(usuario.getFk_sede(), 14, vigencia);
                        model.actualizarConsecutivo(usuario.getFk_sede(), 14, vigencia);
                        citacion.setNumero(numero);
                        citacion.setFechaCitacion(horarioCurso.getFecha());
                        citacion.setFkPersona(comparendo.getFk_persona());
                        citacion.setFkComparendo(comparendo.getId_comparendo());
                        citacion.setFkLiquidacionCia(liquidacion.getId_liquidacion_cia());
                        citacion.setEstado(1);
                        citacion.setFkUsuario(usuario.getId_usuario());
                        citacion.setFechaProceso(new java.sql.Timestamp(new java.util.Date().getTime()));
                        citacion.setFkHorarioCurso(horarioCurso.getIdHorarioCurso());
                        model.adicionarCitacionComparendo(citacion);
                        model.getCon().commit();
                        return true;
                    }
                }
            }
        }catch(Exception exc){
            this.msg = exc.getMessage();
            model.getCon().rollback();
            exc.printStackTrace();
        }
        return false;
    }

    public boolean generarLiquidacionCiaExterno(Model model,Usuario usuario, javax.servlet.http.HttpServletRequest request) throws SQLException{
        if (model != null && usuario != null) {
            String comparendo = request.getParameter("comparendo");
            String fecha = request.getParameter("fecha");
            String tipoDocumento = request.getParameter("tipoDocumento");
            String documento = request.getParameter("documento");
            String infraccion = request.getParameter("infraccion");
            String polca = request.getParameter("polca");

            boolean paso = false;
            if (comparendo != null && fecha != null && tipoDocumento != null && documento != null && infraccion != null) {
                if (comparendo.trim().length() > 0) {
                    if (fecha.trim().length() == 10) {
                        if (tipoDocumento.length() > 0 && documento.trim().length() > 0) {
                            if (infraccion.length() > 0) {
                                polca = polca != null ? polca : "0";
                                paso = true;
                            } else {
                                msg = "Ingrese una infraccion para el comparendo";
                            }
                        } else {
                            msg = "Ingrese un tipo y documento valido";
                        }
                    } else {
                        msg = "Ingrese fecha del comparendo";
                    }
                } else {
                    msg = "Ingrese numero de comparendo";
                }
            }

            if (paso) {
                String cmp = "";
                int tipo = 0;
                String doc = "";
                java.sql.Date fechaComparendo = null;
                int valorAdicional = 13300;
                int cp = 0;

                try {
                    cmp = comparendo.trim();
                    fechaComparendo = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fecha).getTime());
                    tipo = Integer.parseInt(tipoDocumento);
                    doc = Long.parseLong(documento.trim()) + "";
                    cp = Integer.parseInt(polca);
                } catch (Exception exc1) {
                    msg = "Error al convertir numeros y fechas, valor invalido en " + exc1.getMessage();
                    paso = false;
                }

                if (paso) {
                    modelo.Comparendo c = model.consultar_Comparendo(comparendo.trim());
                    if (c == null) {
                        modelo.Persona p = model.consultarPersona(tipo, documento);
                        if (p != null) {
                            modelo.Infraccion i = model.consultarInfraccionByNumero(infraccion.trim().toUpperCase());
                            if (i != null) {
                                modelo.Valor_Infraccion vi = model.consultarValorInfraccion(new java.sql.Date(fechaComparendo.getTime()), i.getId_infraccion());
                                if (vi != null) {
                                    try {
                                        //Inicia proceso de registro
                                        float descuento = 0;
                                        java.util.Date fechaLimite = new java.text.SimpleDateFormat("dd/MM/yyyy").parse("15/03/2010");
                                        if(fechaLimite.getTime()>fechaComparendo.getTime()){
                                            descuento = (float)0.5;
                                        }else{
                                            int dias = model.consultarDiasHabiles(fechaComparendo);
                                            if(dias <= 5){
                                                descuento = (float)0.5;
                                            }else{
                                                if(dias < 21){
                                                    descuento = (float)0.25;
                                                }
                                            }
                                        }

                                        float valorDescuento = (float)(vi.getValor()*(1.0-descuento));
                                        float valorCertificado = 0;

                                        valorCertificado = (float)(valorDescuento*0.25);

                                        valorCertificado = Math.round(valorCertificado);

                                        Cartera cartera  = new Cartera();
                                        cartera.setFk_persona(p.getId_persona());
                                        cartera.setFk_sede(usuario.getFk_sede());
                                        cartera.setTipo(5);
                                        cartera.setReferencia(comparendo.trim());
                                        cartera.setFecha_creacion(fechaComparendo);
                                        cartera.setFecha_ingreso(new java.sql.Date(new java.util.Date().getTime()));
                                        cartera.setValor(valorCertificado);
                                        cartera.setSaldo(valorCertificado);
                                        cartera.setFecha_saldo(cartera.getFecha_ingreso());
                                        cartera.setEstado_cartera(1);
                                        cartera.setFecha_estado(cartera.getFecha_ingreso());
                                        cartera.setEstado_vigencia(1);
                                        cartera.setFecha_estado_vigencia(cartera.getFecha_ingreso());
                                        cartera.setFk_usuario(usuario.getId_usuario());
                                        cartera.setFk_concepto(308);
                                        long Fk_cartera = model.adicionarCartera(cartera);

                                        Detalle_Cartera detalle=new Detalle_Cartera();
                                        detalle.setFk_cartera(Fk_cartera);
                                        detalle.setReferencia(cartera.getReferencia());
                                        detalle.setFecha(cartera.getFecha_creacion());
                                        detalle.setFecha_sistema(new java.sql.Timestamp(new java.util.Date().getTime()));
                                        detalle.setFk_usuario(usuario.getId_usuario());
                                        detalle.setEstado(1);
                                        detalle.setFk_concepto(308);
                                        detalle.setValor((float)cartera.getSaldo());

                                        model.adicionarDetalleCartera(detalle);
                                        model.getCon().commit();
                                        return true;
                                    } catch (Exception exc2) {
                                        model.getCon().rollback();
                                        msg = "Se ha generado una excepcion al ingresar el comparendo :" + exc2.getMessage();
                                    }
                                } else {
                                    msg = "No se ha establecido un rango de valores para la infraccion en ese determinado tiempo";
                                }
                            } else {
                                msg = "El numero de la infraccion no existe o no se encuentra parametrizado";
                            }
                        } else {
                            msg = "La persona no se encuentra registrada";
                        }
                    } else {
                        msg = "El numero de comparendo ya se encuentra registrado";
                    }
                }
            }
        } else {
            msg = "La sesion ya no se encuentra activa";
        }

        return false;
    }


    public boolean ActulizarComparendo(Model model, Usuario usuario, javax.servlet.http.HttpServletRequest request) {
        try {
            if (model != null && usuario != null) {
                java.sql.Date fechaUpdate = new java.sql.Date(new java.util.Date().getTime());
                java.sql.Timestamp fechaSystem = new java.sql.Timestamp(new java.util.Date().getTime());
                String comparendo = request.getParameter("comparendo");
                String fecha = request.getParameter("fecha");
                String horas = request.getParameter("horas");
                String minutos = request.getParameter("minutos");
                String lugar = request.getParameter("lugar");
                String placa = request.getParameter("placa");
                String licenciaTransito = request.getParameter("licenciaTransito");
                String clase = request.getParameter("clase");
                String servicio = request.getParameter("servicio");
                String tipoDocumento = request.getParameter("tipoDocumento");
                String documento = request.getParameter("documento");
                String tipoInfractor = request.getParameter("tipoInfractor");
                String infraccion = request.getParameter("infraccion");
                String licenciaConduccion = request.getParameter("licenciaConduccion");
                String fechaVencimiento = request.getParameter("fechaVencimiento");
                String categoria = request.getParameter("categoria");
                String sedeExpedicion = request.getParameter("sedeExpedicion");
                String placaAgente = request.getParameter("placaAgente");
                String fuga = request.getParameter("fuga");
                String accidente = request.getParameter("accidente");
                String inmovilizacion = request.getParameter("inmovilizacion");
                String polca = "0";

                if(request.getParameter("polca")!=null){
                polca = request.getParameter("polca");

                }
                String firma = request.getParameter("firma");
                String observacion = request.getParameter("observaciones");
                String parqueaderos = request.getParameter("parqueaderos");

                long via = Long.parseLong(request.getParameter("vias"));
                System.out.println("id_via act+-->"+via);
                modelo.Vias Vi = model.consultarVia(via);
                lugar = Vi.getNombre()+" "+ lugar;
                System.out.println("Lugar act+-->"+lugar);
                /////////
                    Vehiculo veh = model.consultarVehiculo(placa);
                    Comparendo_publico compp = new Comparendo_publico();
                    if(veh==null){
                     long serv = Long.parseLong(request.getParameter("servicio"));
                    if(serv==2){
                        compp.setRadio_accion(Long.parseLong(request.getParameter("RA")));
                        compp.setModalidad(Long.parseLong(request.getParameter("MT")));
                        compp.setTransporte_pasajeros(Long.parseLong(request.getParameter("TP")));
                        System.out.println(request.getParameter("RA"));
                        System.out.println(request.getParameter("MT"));
                        System.out.println(request.getParameter("TP"));
                        long sw=Long.parseLong(request.getParameter("TP"));
                        if(sw==4){
                            System.out.println(request.getParameter("ES"));
                            compp.setEspecial(Long.parseLong(request.getParameter("ES")));
                        }
                        model.InsertDetCompPublico(compp);
                    }
                    }else{
                       if(veh.getServicio()==2){
                        compp.setRadio_accion(Long.parseLong(request.getParameter("RA")));
                        compp.setModalidad(Long.parseLong(request.getParameter("MT")));
                        compp.setTransporte_pasajeros(Long.parseLong(request.getParameter("TP")));
                        System.out.println(request.getParameter("RA"));
                        System.out.println(request.getParameter("MT"));
                        System.out.println(request.getParameter("TP"));
                        long sw=Long.parseLong(request.getParameter("TP"));
                        if(sw==4){
                            System.out.println(request.getParameter("ES"));
                            compp.setEspecial(Long.parseLong(request.getParameter("ES")));
                        }
                        model.InsertDetCompPublico(compp);
                    }

                    }
               //////////

                boolean paso = false;
                if (comparendo != null && fecha != null && horas != null && minutos != null && lugar != null && tipoDocumento != null && documento != null && tipoInfractor != null && infraccion != null && placaAgente != null && polca != null) {
                    if (comparendo.trim().length() > 0) {
                        if (fecha.trim().length() == 10) {
                            if (horas.length() >= 0 && minutos.length() >= 0) {
                                lugar = lugar.trim().toUpperCase();
                                if (lugar.length() > 5) {
                                    placa = placa != null ? placa.trim().toUpperCase() : "";
                                    licenciaTransito = licenciaTransito != null ? licenciaTransito.trim() : "";
                                    clase = clase != null ? clase : "";
                                    servicio = servicio != null ? servicio : "";
                                    if (placa.length() > 4 || placa.length() == 0) {
                                        if (tipoDocumento.length() > 0 && documento.trim().length() > 0) {
                                            tipoInfractor = tipoInfractor != null ? tipoInfractor : "";
                                            if (infraccion.length() > 0) {
                                                licenciaConduccion = licenciaConduccion != null ? licenciaConduccion.trim() : "";
                                                fechaVencimiento = fechaVencimiento != null ? fechaVencimiento.trim() : "";
                                                categoria = categoria != null ? categoria : "";
                                                sedeExpedicion = sedeExpedicion != null ? sedeExpedicion : "";
                                                if ((licenciaConduccion.length() > 0 && fechaVencimiento.length() == 10) || licenciaConduccion.length() == 0) {
                                                    if (placaAgente.length() > 0) {
                                                        fuga = fuga != null ? fuga : "0";
                                                        accidente = accidente != null ? accidente : "0";
                                                        inmovilizacion = inmovilizacion != null ? inmovilizacion : "0";
                                                        polca = polca != null ? polca : "0";
                                                        firma = firma != null ? firma : "0";
                                                        observacion = observacion != null ? observacion.trim().toUpperCase() : "";
                                                        parqueaderos = parqueaderos != null ? parqueaderos : "";
                                                        paso = true;
                                                    } else {
                                                        msg = "Ingrese placa del agente";
                                                    }
                                                } else {
                                                    msg = "La fecha de vencimiento de la licencia es incorrecta";
                                                }
                                            } else {
                                                msg = "Ingrese una infraccion para el comparendo";
                                            }
                                        } else {
                                            msg = "Ingrese un tipo y documento valido";
                                        }
                                    } else {
                                        msg = "Ingrese la placa, clase y servicio del vehiculo";
                                    }
                                } else {
                                    msg = "Ingrese el lugar de la infraccion";
                                }
                            } else {
                                msg = "Ingrese la hora y minuto del comparendo";
                            }
                        } else {
                            msg = "Ingrese fecha del comparendo";
                        }
                    } else {
                        msg = "Ingrese numero de comparendo";
                    }
                }

                    java.util.Calendar calendar = null;
                    String cmp = "";
                    int claseVehiculo = 0;
                    int servicioVehiculo = 0;
                    int tipo = 0;
                    String doc = "";
                    String lit = "";
                    String lic = "";
                    int tinf = 0;
                    java.sql.Date fechaV = null;
                    int placaA = 0;
                    long sedeE = 0;
                    int cf = 0;
                    int ca = 0;
                    int ci = 0;
                    int cp = 0;
                    int cr = 0;
                    long parque = 0;
                    java.sql.Timestamp fechaComparendo = null;
                    int valorAdicional = 13300;


                    try {
                        cmp = comparendo.trim();
                        fechaComparendo = new java.sql.Timestamp(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fecha).getTime());
                        fechaComparendo.setHours(Integer.parseInt(horas));
                        fechaComparendo.setMinutes(Integer.parseInt(minutos));
                        if (clase.length() > 0) {
                            claseVehiculo = Integer.parseInt(clase);
                        }
                        if (servicio.length() > 0) {
                            servicioVehiculo = Integer.parseInt(servicio);
                        }
                        tipo = Integer.parseInt(tipoDocumento);
                        doc = Long.parseLong(documento.trim()) + "";
                        if (tipoInfractor.length() > 0) {
                            tinf = Integer.parseInt(tipoInfractor);
                        }
                        if (licenciaTransito.length() > 0) {
                            lit = Long.parseLong(licenciaTransito) + "";
                        }
                        if (licenciaConduccion.length() > 0) {
                            lic = Long.parseLong(licenciaConduccion) + "";
                        }
                        if (fechaVencimiento.length() == 10) {
                            fechaV = new java.sql.Date(new java.text.SimpleDateFormat("dd/mm/yyyy").parse(fechaVencimiento).getTime());
                        }
                        placaA = Integer.parseInt(placaAgente);
                        if (sedeExpedicion.length() > 0) {
                            sedeE = Long.parseLong(sedeExpedicion);
                        }
                        cf = Integer.parseInt(fuga);
                        ca = Integer.parseInt(accidente);
                        ci = Integer.parseInt(inmovilizacion);
                        cp = Integer.parseInt(polca);
                        cr = Integer.parseInt(firma);
                        if (parqueaderos.length() > 0) {
                            parque = Long.parseLong(parqueaderos);
                        }
                    } catch (Exception exc1) {
                        msg = "Error al convertir numeros y fechas, valor invalido en " + exc1.getMessage();
                        paso = false;
                    }

                                                               try {
                                                //Inicia proceso de registro
                                                modelo.Persona p = model.consultarPersona(tipo, documento);
                                                modelo.Infraccion i = model.consultarInfraccionByNumero(infraccion.trim().toUpperCase());
                                                modelo.Agente a = model.consultarAgente(placaA);
                                                modelo.Comparendo nc = new modelo.Comparendo();
                                                nc.setFk_persona(p.getId_persona());
                                                nc.setFk_usuario_organismo(usuario.getId_usuario());
                                                nc.setFk_sede(usuario.getFk_sede());//id_sede
                                                nc.setFk_infraccion(i.getId_infraccion());
                                                nc.setFk_agente(a.getId_agente());
                                                nc.setNumero(comparendo.trim());
                                                nc.setFecha(fechaComparendo);//fecha comparendo
                                                nc.setLugar(lugar);
                                                nc.setPlaca(placa);
                                                nc.setClase(claseVehiculo);
                                                nc.setServicio(servicioVehiculo);
                                                nc.setLicencia_transito(lit);
                                                nc.setTipo_infractor(tinf);
                                                nc.setObservaciones(observacion);
                                                nc.setFuga(cf);
                                                nc.setAccidente(ca);
                                                nc.setInmovilizacion(ci);
                                                nc.setPolca(cp);
                                                nc.setFirmado(cr);
                                                nc.setEstado(1);
                                                nc.setFecha_proceso(fechaSystem);
                                                nc.setLicencia_conduccion(lic);
                                                nc.setCategoria(categoria);
                                                nc.setFecha_vencimiento(fechaV);
                                                nc.setSede_expedicion(sedeE);
                                                nc.setFk_parqueadero(ci == 1 ? parque : 0);
                                                nc.setfk_via(via);
                                               //model.adicionarComparendo(nc);
                                                System.out.println("ok vamos hace esto ->"+ request.getParameter("compAnt"));
                                                long id = Long.parseLong(request.getParameter("compAnt"));
                                                
                                                model.modificarcomaprendo(id, nc);
                                                model.getCon().commit();
                                                Comparendo comp =model.consultar_Comparendo(nc.getNumero());

                                                    modelo.auditoria_comparendo aud = new modelo.auditoria_comparendo();
                                                    
                                                    aud.setFk_comparendo(comp.getId_comparendo());
                                                    aud.setFk_estado(1);
                                                    aud.setFecha_proceso(comp.getFecha_proceso());
                                                    aud.setUsuario(comp.getFk_usuario_organismo());
                                                    aud.setEstado(1);
                                                    aud.setFecha_inicio(comp.getFecha_proceso());
                                                    aud.setFecha_fin(null);
                                                    //model.InsertAuditoriaComparendo(aud);
                                                    if(nc.getPolca()!=1){
                                                    //ingresoComparendoSimit(model, usuario, nc);
                                                    }
                                                    model.getCon().commit();
                                                    return true;


                                            } catch (Exception exc2) {
                                                model.getCon().rollback();
                                                msg = "Se ha generado una excepcion al ingresar el comparendo :" + exc2.getMessage();
                                            }
            }
        }catch (Exception exc) {
            exc.printStackTrace();
            msg = "Se ha generado una excepcion al ingresar el comparendo :" + exc.getMessage();
        }
        return false;

    }

}

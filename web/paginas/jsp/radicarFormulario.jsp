<%@ page  import = "modelo.*" import = "java.util.*" import = "java.sql.*"    %>
<%
    Model model = (Model) session.getAttribute("model");
    try {
        java.util.List tramites = (LinkedList) session.getAttribute("seleccionados");
        Vehiculo vehiculo = (Vehiculo) session.getAttribute("vehiculo");
        if (tramites.size() > 0) {
            int tramite = Integer.parseInt(tramites.get(0).toString());
            Sede sede = (Sede) session.getAttribute("sede");
            Persona persona = model.consultarPersona(Integer.parseInt(request.getParameter("tipoDocumento")), request.getParameter("numeroDocumento"));
            Usuario user = (Usuario) session.getAttribute("usuario");
            long id_rad = 0;
            Radicacion radicacion = new Radicacion();
            model.getCon().setAutoCommit(false);
            if (session.getAttribute("radicacion") == null) {
                Calendar calendar = Calendar.getInstance();
                int vigencia = calendar.get(Calendar.YEAR);
                int consecutivo = model.consultarConsecutivo(sede.getId_sede(), 3, vigencia);
                model.actualizarConsecutivo(sede.getId_sede(), 3, vigencia);
                model.getCon().commit();
                radicacion.setNumero(consecutivo + "");
                radicacion.setFk_persona(persona.getId_persona());
                radicacion.setFk_sede(sede.getId_sede());
                radicacion.setFk_usuario(user.getId_usuario());
                radicacion.setEstado(1);
                radicacion.setObservaciones(request.getParameter("observacion"));
                java.sql.Date fecha_exacta = new java.sql.Date(new java.util.Date().getTime());
                radicacion.setFecha(fecha_exacta);
                id_rad = model.adicionarDatosRadicacion(radicacion);
                session.setAttribute("radicacion", id_rad);
            } else {
                id_rad = Long.parseLong(session.getAttribute("radicacion").toString());
                radicacion = model.consultar_Radicacion(id_rad);
            }
            Formulario formulario = new Formulario();
            java.util.HashMap hash_caracteristicas = (java.util.HashMap) session.getAttribute("caracteristicas");
            java.util.HashMap hash_especificaciones = (java.util.HashMap) session.getAttribute("especificaciones");
            if (vehiculo != null) {
                formulario.setFk_linea(vehiculo.getFk_linea());
                formulario.setFk_divipo(vehiculo.getFk_divipo());//pendiente
                formulario.setPlaca(vehiculo.getPlaca());
                formulario.setClase_vehiculo((int) vehiculo.getClase_vehiculo());
                formulario.setModelo(vehiculo.getModelo());
                if (hash_caracteristicas.get("75") != null) {
                    formulario.setCombustible(Integer.parseInt(hash_caracteristicas.get("75").toString()));
                } else {
                    formulario.setCombustible(0);
                }
                if (hash_caracteristicas.get("2") != null) {
                    formulario.setCarroceria(Integer.parseInt(hash_caracteristicas.get("2") + ""));
                } else {
                    formulario.setCarroceria(0);
                }
                if (hash_caracteristicas.get("324") != null) {
                    formulario.setModalidad(Integer.parseInt(hash_caracteristicas.get("324").toString()));
                } else {
                    formulario.setModalidad(0);
                }
                if (hash_especificaciones.get("19") != null) {
                    formulario.setMotor(hash_especificaciones.get("19").toString());
                } else {
                    formulario.setMotor("");
                }
                if (hash_especificaciones.get("22") != null) {
                    formulario.setMotor_reg(Integer.parseInt(hash_especificaciones.get("22").toString()));
                } else {
                    formulario.setMotor_reg(0);
                }
                if (hash_especificaciones.get("20") != null) {
                    formulario.setChasis(hash_especificaciones.get("20").toString());
                } else {
                    formulario.setChasis("");
                }
                if (hash_especificaciones.get("23") != null) {
                    formulario.setChasis_reg(Integer.parseInt(hash_especificaciones.get("23").toString()));
                } else {
                    formulario.setChasis_reg(0);
                }
                if (hash_especificaciones.get("21") != null) {
                    formulario.setSerie(hash_especificaciones.get("21").toString());
                } else {
                    formulario.setSerie("");
                }
                if (hash_especificaciones.get("24") != null) {
                    formulario.setSerie_reg(Integer.parseInt(hash_especificaciones.get("24").toString()));
                } else {
                    formulario.setSerie_reg(0);
                }

                formulario.setTipo_importacion((int) vehiculo.getTipo_importacion());
                if (vehiculo.getTipo_importacion() == 1) {
                    formulario.setTipo_doc_importacion((int) vehiculo.getTipo_doc_importacion());
                    formulario.setEntidad_remate(0);
                } else {
                    formulario.setTipo_doc_importacion(0);
                    formulario.setEntidad_remate((int) vehiculo.getTipo_doc_importacion());
                }
                formulario.setCodigo_aduana(0);
                if (vehiculo.getDocumento_importacion() != null) {
                    formulario.setDocumento_importacion(vehiculo.getDocumento_importacion());
                } else {
                    formulario.setDocumento_importacion("");
                }
                if (vehiculo.getFecha_importacion() != null) {
                    formulario.setFecha_documento(vehiculo.getFecha_importacion());
                }
                formulario.setServicio((int) vehiculo.getServicio());
                /*
                 formulario.setNro_poliza("");
                 formulario.setFecha_poliza(new java.sql.Date(new java.util.Date().getTime()));//pendiente
                 formulario.setObservaciones("");
                 formulario.setLicencia_transito("");*/
            } else {
                vehiculo = new Vehiculo();
                formulario = model.consultarUltimoFormulario(request.getParameter("placa").toUpperCase());
                if (formulario == null) {
                    formulario = new Formulario();
                }
            }
            formulario.setFk_radicacion(id_rad);
            formulario.setFk_tramite(tramite);
            int numeroF = model.consultarConsecutivo(sede.getId_sede(), 5, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
            formulario.setNumero(numeroF + "");
            model.actualizarConsecutivo(sede.getId_sede(), 5, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
            formulario.setFecha_tramite(new java.sql.Timestamp(new java.util.Date().getTime()));
            formulario.setPlaca(request.getParameter("placa"));
            formulario.setRunt(request.getParameter("runt" + tramite));
            if ((request.getParameter("simit" + tramite) == null) || (request.getParameter("simit" + tramite).equals(""))) {
                formulario.setRunt2(request.getParameter("runt" + tramite));
            } else {
                formulario.setRunt2(request.getParameter("simit" + tramite));
            }

            if (request.getParameter("fun" + tramite).trim().length() > 0) {
                Tiquete tiquete = model.consultarTiqueteByFactura(request.getParameter("fun" + tramite));
                if (tiquete != null) {
                    Pago pago = model.consultarPagoByTiquete(tiquete.getId_tiquete());
                    if (pago != null) {
                        formulario.setFk_pago(pago.getId_pago());
                        //model.actualizarEstadoDetalleTiqueteTramite(tiquete.getId_tiquete(),formulario.getFk_tramite(),2);
                    }
                }
            }
            formulario.setObservaciones(request.getParameter("observacion"));
            long id_form = 0;
            switch (tramite) {
                //Tramite de Matricula Inicial
                case 1:
                    formulario.setFk_linea(Long.parseLong(request.getParameter("lineas")));
                    formulario.setFk_divipo(model.consultarDvipo(Long.parseLong(request.getParameter("departamentos")), Long.parseLong(request.getParameter("ciudades"))).getId_divipo());
                    formulario.setClase_vehiculo(Integer.parseInt(request.getParameter("clases")));
                    formulario.setModelo(Integer.parseInt(request.getParameter("modelo")));
                    formulario.setCombustible(Integer.parseInt(request.getParameter("combustibles")));
                    formulario.setCarroceria(Integer.parseInt(request.getParameter("carrocerias")));
                    if (!request.getParameter("modalidades").equals("0") && formulario.getClase_vehiculo() != 10 && formulario.getClase_vehiculo() != 14 && formulario.getClase_vehiculo() != 17 && formulario.getClase_vehiculo() != 18) {
                        formulario.setModalidad(Integer.parseInt(request.getParameter("modalidades")));
                    }
                    if (!request.getParameter("motor").equals("")) {
                        formulario.setMotor(request.getParameter("motor"));
                    }
                    if (!request.getParameter("chasis").equals("")) {
                        formulario.setChasis(request.getParameter("chasis"));
                    }
                    if (!request.getParameter("serie").equals("")) {
                        formulario.setSerie(request.getParameter("serie"));
                    }
                    formulario.setTipo_importacion(Integer.parseInt(request.getParameter("tiposimportaciones")));
                    if (Integer.parseInt(request.getParameter("tiposimportaciones")) == 1) {
                        formulario.setTipo_doc_importacion(Integer.parseInt(request.getParameter("tiposimpor")));
                        formulario.setEntidad_remate(0);
                    } else {
                        formulario.setTipo_doc_importacion(0);
                        formulario.setEntidad_remate(Integer.parseInt(request.getParameter("tiposentidades")));
                    }
                    if (request.getParameter("nitConc") != null) {
                        formulario.setObservaciones(request.getParameter("nitConc"));
                    }

                    if (request.getParameter("valorF") != null) {
                        formulario.setSimit(request.getParameter("valorF"));
                    }

                    if (request.getParameter("radio") != null && !request.getParameter("radio").equals("0")) {
                        formulario.setNro_poliza(request.getParameter("radio"));
                    }

                    formulario.setCodigo_aduana(0);
                    formulario.setDocumento_importacion(request.getParameter("documentoimp"));
                    formulario.setFecha_documento(new java.sql.Date(new java.util.Date(request.getParameter("fechadocumento")).getTime()));//pendiente
                    formulario.setServicio(Integer.parseInt(request.getParameter("servicios")));
                    String area = "";
                    long modser = 0;
                    //long codmun=0; por definir E42 codigominicipio
                    if (formulario.getServicio() == 2) {
                        if (request.getParameter("cmbAmetropolitana") != null) {
                            area = request.getParameter("cmbAmetropolitana");
                            formulario.setArea_metropolitana(area);
                        }
                        if (request.getParameter("cmbModServicio") != null) {
                            modser = Long.parseLong(request.getParameter("cmbModServicio"));
                            formulario.setModalidad_servicio(modser);
                        }
                        // codmun=request.getParameter("cmbModServicio")!=null?Long.parseLong(request.getParameter("dir_municipio")):0;
                        if (request.getParameter("dir_departamento") != null) {
                            formulario.setFk_departamento(Long.parseLong(request.getParameter("dir_departamento")));
                        }

                    }
                    if (request.getParameter("comboAseguradora") != null) {
                        if (request.getParameter("comboAseguradora").trim().length() > 0) {
                            formulario.setFk_aseguradora(Long.parseLong(request.getParameter("comboAseguradora")));
                        }
                    }
                    if (request.getParameter("poliza") != null) {
                        if (request.getParameter("poliza").trim().length() > 0) {
                            formulario.setNro_poliza(request.getParameter("poliza"));
                        }
                    }
                    if (request.getParameter("vence") != null) {
                        if (request.getParameter("vence").trim().length() > 0) {
                            formulario.setFecha_poliza(new java.sql.Date(new java.util.Date(request.getParameter("vence")).getTime()));//pendiente
                        }
                    }
                    id_form = model.adicionarFormulario(formulario);
                    /* if(formulario.getServicio()==2){ pendiente E42
                        model.registrarFrmAreaMetropolitana(id_form, area,codmun);
                    }*/
                    if (request.getParameter("r_color") != null) {
                        Radicacion_Color rc = new Radicacion_Color();
                        rc.setFk_formulario(id_form);
                        rc.setFk_color(Long.parseLong(request.getParameter("r_color")));
                        rc.setGama("");
                        rc.setSequencia(1);
                        model.adicionarRadicacionColores(rc);
                        session.setAttribute("colores", rc.getFk_color());
                    }
                    java.util.List lista = (java.util.List) session.getAttribute("propietarios");
                    for (int j = 0; j < lista.size(); j++) {
                        Radicacion_Propietario rp = (Radicacion_Propietario) lista.get(j);
                        rp.setFk_formulario(id_form);
                        model.adicionarRadicacionPropietarios(rp);
                        Radicacion_Apoderado ra = (Radicacion_Apoderado) session.getAttribute("apoderados" + rp.getFk_persona());
                        if (ra != null) {
                            ra.setFk_formulario(id_form);
                            ra.setFecha_inicio(new java.sql.Date(new java.util.Date().getTime()));
                            model.adicionarRadicacionApoderados(ra);
                        }
                    }
                    lista = model.listadoParametros(40);
                    hash_especificaciones = (java.util.HashMap) session.getAttribute("especificaciones");
                    for (int j = 0; j < lista.size(); j++) {
                        Parametro pm = (Parametro) lista.get(j);
                        if (pm.getCodigo() < 19 || pm.getCodigo() > 24) {
                            String valor = "";
                            if (hash_especificaciones.get(pm.getCodigo() + "") != null) {
                                valor = hash_especificaciones.get(pm.getCodigo() + "") + "";
                            }
                            Radicacion_Dato_Vehiculo rdv = new Radicacion_Dato_Vehiculo();
                            rdv.setGrupo(2);
                            rdv.setParametro((int) pm.getCodigo());
                            rdv.setValor(valor);
                            rdv.setSubgrupo(0);
                            rdv.setFk_formulario(id_form);
                            model.adicionarRadDatosVehiculo(rdv);
                        }
                    }
                    ;
                    break;
                //Tramite de Traspaso
                case 2:
                    id_form = model.adicionarFormulario(formulario);
                    lista = (java.util.List) session.getAttribute("propietarios");
                    for (int j = 0; j < lista.size(); j++) {
                        Radicacion_Propietario rp = (Radicacion_Propietario) lista.get(j);
                        rp.setFk_formulario(id_form);
                        model.adicionarRadicacionPropietarios(rp);
                        Radicacion_Apoderado ra = (Radicacion_Apoderado) session.getAttribute("apoderados" + rp.getFk_persona());
                        if (ra != null) {
                            ra.setFk_formulario(id_form);
                            ra.setFecha_inicio(new java.sql.Date(new java.util.Date().getTime()));
                            model.adicionarRadicacionApoderados(ra);
                        }
                    }
                    ;
                    break;
                //Tramite de Traslado de Cuenta
                case 3:
                case 64:
                    formulario.setLicencia_transito(request.getParameter("numeroLicencia"));
                    formulario.setSede_movimiento(Integer.parseInt(request.getParameter("organismos")));
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Radicacion de Cuenta
                case 4:
                case 65:
                case 94:

                    if (request.getParameter("lineas") != null) {
                        formulario.setFk_linea(Long.parseLong(request.getParameter("lineas")));
                    }

                    if (request.getParameter("departamentos") != null && request.getParameter("ciudades") != null) {
                        formulario.setFk_divipo(model.consultarDvipo(Long.parseLong(request.getParameter("departamentos")), Long.parseLong(request.getParameter("ciudades"))).getId_divipo());
                    }
                    if (request.getParameter("clases") != null) {
                        formulario.setClase_vehiculo(Integer.parseInt(request.getParameter("clases")));
                    }
                    if (request.getParameter("modelo") != null) {
                        formulario.setModelo(Integer.parseInt(request.getParameter("modelo")));
                    }

                    if (request.getParameter("combustibles") != null) {
                        formulario.setCombustible(Integer.parseInt(request.getParameter("combustibles")));
                    }

                    if (request.getParameter("carrocerias") != null) {
                        formulario.setCarroceria(Integer.parseInt(request.getParameter("carrocerias")));
                    }

                    if (request.getParameter("modalidades") != null) {
                        formulario.setModalidad(Integer.parseInt(request.getParameter("modalidades")));
                    }

                    if (request.getParameter("motor") != null) {
                        formulario.setMotor(request.getParameter("motor"));
                    }

                    if (request.getParameter("reg_motor") != null) {
                        formulario.setMotor_reg(Integer.parseInt(request.getParameter("reg_motor")));
                    }

                    if (request.getParameter("chasis") != null) {
                        formulario.setChasis(request.getParameter("chasis"));
                    }

                    if (request.getParameter("reg_chasis") != null) {
                        formulario.setChasis_reg(Integer.parseInt(request.getParameter("reg_chasis")));
                    }

                    if (request.getParameter("serie") != null) {
                        formulario.setSerie(request.getParameter("serie"));
                    }

                    if (request.getParameter("reg_serie") != null) {
                        formulario.setSerie_reg(Integer.parseInt(request.getParameter("reg_serie")));
                    }
                    if (request.getParameter("tiposimportaciones") != null) {
                        formulario.setTipo_importacion(Integer.parseInt(request.getParameter("tiposimportaciones")));
                    }

                    if (request.getParameter("tiposimportaciones") != null) {
                        if (Integer.parseInt(request.getParameter("tiposimportaciones")) == 1) {
                            formulario.setTipo_doc_importacion(Integer.parseInt(request.getParameter("tiposimpor")));
                            formulario.setEntidad_remate(0);
                        } else {
                            formulario.setTipo_doc_importacion(0);
                            formulario.setEntidad_remate(Integer.parseInt(request.getParameter("tiposentidades")));
                        }

                    }

                    formulario.setCodigo_aduana(0);

                    if (request.getParameter("documentoimp") != null) {
                        formulario.setDocumento_importacion(request.getParameter("documentoimp"));
                    }

                    if (request.getParameter("fechadocumento") != null) {
                        formulario.setFecha_documento(new java.sql.Date(new java.util.Date(request.getParameter("fechadocumento")).getTime()));//pendiente
                    }

                    if (request.getParameter("servicios") != null) {
                        formulario.setServicio(Integer.parseInt(request.getParameter("servicios")));
                    }

                    if (request.getParameter("comboAseguradora") != null) {
                        if (request.getParameter("comboAseguradora").trim().length() > 0) {
                            formulario.setFk_aseguradora(Long.parseLong(request.getParameter("comboAseguradora")));
                        }
                    }

                    if (request.getParameter("poliza") != null) {
                        if (request.getParameter("poliza").trim().length() > 0) {
                            formulario.setNro_poliza(request.getParameter("poliza"));
                        }
                    }

                    if (request.getParameter("vence") != null) {
                        if (request.getParameter("vence").trim().length() > 0) {
                            formulario.setFecha_poliza(new java.sql.Date(new java.util.Date(request.getParameter("vence")).getTime()));//pendiente
                        }
                    }

                    formulario.setLicencia_transito(request.getParameter("numeroLicencia"));

                    formulario.setSede_movimiento(Integer.parseInt(request.getParameter("organismos")));

                    id_form = model.adicionarFormulario(formulario);

                    if (request.getParameter("r_color") != null) {
                        Radicacion_Color rc = new Radicacion_Color();
                        rc.setFk_formulario(id_form);
                        rc.setFk_color(Long.parseLong(request.getParameter("r_color")));
                        rc.setGama("");
                        rc.setSequencia(1);
                        model.adicionarRadicacionColores(rc);
                        session.setAttribute("colores", rc.getFk_color());
                    }

                    lista = (java.util.List) session.getAttribute("propietarios");

                    for (int j = 0; j < lista.size(); j++) {
                        Radicacion_Propietario rp = (Radicacion_Propietario) lista.get(j);
                        rp.setFk_formulario(id_form);
                        model.adicionarRadicacionPropietarios(rp);
                        Radicacion_Apoderado ra = (Radicacion_Apoderado) session.getAttribute("apoderados" + rp.getFk_persona());

                        if (ra != null) {
                            ra.setFk_formulario(id_form);
                            ra.setFecha_inicio(new java.sql.Date(new java.util.Date().getTime()));
                            model.adicionarRadicacionApoderados(ra);
                        }
                    }
                    lista = model.listadoParametros(40);
                    hash_especificaciones = (java.util.HashMap) session.getAttribute("especificaciones");
                    for (int j = 0; j < lista.size(); j++) {
                        Parametro pm = (Parametro) lista.get(j);
                        if (pm.getCodigo() < 19 || pm.getCodigo() > 24) {
                            String valor = "";
                            if (hash_especificaciones.get(pm.getCodigo() + "") != null) {
                                valor = hash_especificaciones.get(pm.getCodigo() + "") + "";
                            }
                            Radicacion_Dato_Vehiculo rdv = new Radicacion_Dato_Vehiculo();
                            rdv.setGrupo(2);
                            rdv.setParametro((int) pm.getCodigo());
                            rdv.setValor(valor);
                            rdv.setSubgrupo(0);
                            rdv.setFk_formulario(id_form);
                            model.adicionarRadDatosVehiculo(rdv);
                        }
                    }

                    ;
                    break;
                //Tramite de Cambio de Color
                case 5:
                    id_form = model.adicionarFormulario(formulario);
                    if (request.getParameter("r_color") != null) {
                        Radicacion_Color rc = new Radicacion_Color();
                        rc.setFk_formulario(id_form);
                        rc.setFk_color(Long.parseLong(request.getParameter("r_color")));
                        rc.setGama("");
                        rc.setSequencia(1);
                        model.adicionarRadicacionColores(rc);
                        session.setAttribute("colores", rc.getFk_color());
                    }
                    ;
                    break;
                //Tramite de Cambio de Servicio        
                case 6:
                    formulario.setServicio(Integer.parseInt(request.getParameter("servicios")));
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Cambio de Blindaje
                case 7:
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Rematricula        
                case 8:
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Traspaso Indeterminado
                case 9:
                    id_form = model.adicionarFormulario(formulario);
                    lista = (java.util.List) session.getAttribute("propietarios");
                    for (int j = 0; j < lista.size(); j++) {
                        Radicacion_Propietario rp = (Radicacion_Propietario) lista.get(j);
                        rp.setFk_formulario(id_form);
                        model.adicionarRadicacionPropietarios(rp);
                        Radicacion_Apoderado ra = (Radicacion_Apoderado) session.getAttribute("apoderados" + rp.getFk_persona());
                        if (ra != null) {
                            ra.setFk_formulario(id_form);
                            ra.setFecha_inicio(new java.sql.Date(new java.util.Date().getTime()));
                            model.adicionarRadicacionApoderados(ra);
                        }
                    }
                    ;
                    break;
                //Tramite de Traspaso
                case 10:
                    id_form = model.adicionarFormulario(formulario);
                    lista = (java.util.List) session.getAttribute("propietarios");
                    for (int j = 0; j < lista.size(); j++) {
                        Radicacion_Propietario rp = (Radicacion_Propietario) lista.get(j);
                        rp.setFk_formulario(id_form);
                        model.adicionarRadicacionPropietarios(rp);
                        Radicacion_Apoderado ra = (Radicacion_Apoderado) session.getAttribute("apoderados" + rp.getFk_persona());
                        if (ra != null) {
                            ra.setFk_formulario(id_form);
                            ra.setFecha_inicio(new java.sql.Date(new java.util.Date().getTime()));
                            model.adicionarRadicacionApoderados(ra);
                        }
                    }
                    ;
                    break;
                //Tramite de Preasignacion de Placa
                case 11:
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Duplicado de Licencia de Transito
                case 12:
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Inscripcion de Alerta
                case 13:
                case 73:
                case 102:
                    id_form = model.adicionarFormulario(formulario);
                    Radicacion_Alerta ra = new Radicacion_Alerta();
                    ra.setFk_formulario(id_form);
                    Persona pr = model.consultarPersona(Integer.parseInt(request.getParameter("tipoDocumentoAlerta")), request.getParameter("numeroDocumentoAlerta"));
                    ra.setFk_persona(pr.getId_persona());
                    ra.setObservaciones(request.getParameter("observacionAlerta"));
                    ra.setAlerta(Integer.parseInt(request.getParameter("alertas")));
                    model.adicionarRadicacionAlerta(ra);
                    break;
                //Tramite de Levantamiento de Alerta
                case 14:
                case 74:
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Cancelacion de Matricula
                case 15:
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Cambio de Placa Reflectiva
                case 16:
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Cambio de Motor
                case 17:
                    formulario.setMotor(request.getParameter("motor"));
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Duplicado de Placa
                case 18:
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Certificado de Tradicion
                case 19:
                    formulario.setObservaciones(request.getParameter("observacion") != null ? request.getParameter("observacion") : "");
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Cambio de Carroceria
                case 20:
                    formulario.setCarroceria(Integer.parseInt(request.getParameter("carrocerias")));
                    formulario.setObservaciones(request.getParameter("observacion"));
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Cambio de Combustible
                case 21:
                    formulario.setCombustible(Integer.parseInt(request.getParameter("combustibles")));
                    formulario.setObservaciones(request.getParameter("observacion"));
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Cambio de Conjunto
                case 22:
                    formulario.setModelo(Integer.parseInt(request.getParameter("modelo")));
                    formulario.setObservaciones(request.getParameter("observacion"));
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Repotenciacion
                case 23:
                    formulario.setMotor(request.getParameter("motor"));
                    formulario.setModelo(Integer.parseInt(request.getParameter("modelo")));
                    formulario.setObservaciones(request.getParameter("observacion"));
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Regrabacion de Motor
                case 24:
                    formulario.setMotor(request.getParameter("motor"));
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Regrabacion de Chasis
                case 25:
                    formulario.setChasis(request.getParameter("chasis"));
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Regrabacion de Serie
                case 26:
                    formulario.setSerie(request.getParameter("serie"));
                    id_form = model.adicionarFormulario(formulario);
                    break;
                //Tramite de Subrogacion Prendaria
                case 27:
                    id_form = model.adicionarFormulario(formulario);
                    ra = new Radicacion_Alerta();
                    ra.setFk_formulario(id_form);
                    pr = model.consultarPersona(Integer.parseInt(request.getParameter("tipoDocumentoAlerta")), request.getParameter("numeroDocumentoAlerta"));
                    ra.setFk_persona(pr.getId_persona());
                    ra.setObservaciones(request.getParameter("observacionAlerta"));
                    ra.setAlerta(Integer.parseInt(request.getParameter("alertas")));
                    model.adicionarRadicacionAlerta(ra);
                    break;
                //Tramite de Cancelacion de Matricula por Reposicion
                case 32:
                    id_form = model.adicionarFormulario(formulario);
                    break;

                //Tramite de Matricula Inicial Maquinaria Agricola
                case 62:
                    System.out.println("Entro en el formulario de RNRYS");
                    formulario.setFk_linea(Long.parseLong(request.getParameter("lineas")));
                    formulario.setFk_marca(Long.parseLong(request.getParameter("marcas")));
                    //   formulario.setFk_divipo(model.consultarDvipo(Long.parseLong(request.getParameter("departamentos")), Long.parseLong(request.getParameter("ciudades"))).getId_divipo());
                    formulario.setClase_vehiculo(Integer.parseInt(request.getParameter("clases")));
                    formulario.setModelo(Integer.parseInt(request.getParameter("modelo")));
                    if (request.getParameter("combustibles") != null) {
                        formulario.setCombustible(Integer.parseInt(request.getParameter("combustibles")));
                    }
                    formulario.setCarroceria(Integer.parseInt(request.getParameter("carrocerias")));
                    if (request.getParameter("modalidades") != null) {
                        if (!request.getParameter("modalidades").equals("0") && formulario.getClase_vehiculo() != 10 && formulario.getClase_vehiculo() != 14 && formulario.getClase_vehiculo() != 17 && formulario.getClase_vehiculo() != 18) {
                            formulario.setModalidad(Integer.parseInt(request.getParameter("modalidades")));
                        }
                    }
                    if (request.getParameter("motor") != null) {
                        if (!request.getParameter("motor").equals("") && !request.getParameter("motor").equals("NA")) {
                            formulario.setMotor(request.getParameter("motor"));
                        }
                    }
                    if (!request.getParameter("chasis").equals("") && !request.getParameter("chasis").equals("NA")) {
                        formulario.setChasis(request.getParameter("chasis"));
                    }
                    if (!request.getParameter("serie").equals("")) {
                        formulario.setSerie(request.getParameter("serie"));
                    }
                    if (!request.getParameter("vin").equals("")) {
                        formulario.setVin(request.getParameter("vin"));
                    }

                    //  formulario.setTipo_importacion(Integer.parseInt(request.getParameter("tiposimportaciones")));
                    //      if(Integer.parseInt(request.getParameter("tiposimportaciones"))==1){
                    //            formulario.setTipo_doc_importacion(Integer.parseInt(request.getParameter("tiposimpor")));
                    //          formulario.setEntidad_remate(0);
                    //   }else{
                    //           formulario.setTipo_doc_importacion(0);
                    //           formulario.setEntidad_remate(Integer.parseInt(request.getParameter("tiposentidades")));
                    //   }
                    if (request.getParameter("nitConc") != null) {
                        formulario.setObservaciones(request.getParameter("nitConc"));
                    }

                    if (request.getParameter("valorF") != null) {
                        formulario.setSimit(request.getParameter("valorF"));
                    }

                    if (request.getParameter("radio") != null && !request.getParameter("radio").equals("0")) {
                        formulario.setNro_poliza(request.getParameter("radio"));
                    }

                    formulario.setCodigo_aduana(0);
                    //  formulario.setDocumento_importacion(request.getParameter("documentoimp"));
                    //  formulario.setFecha_documento(new java.sql.Date(new java.util.Date(request.getParameter("fechadocumento")).getTime()));//pendiente
                    if (request.getParameter("servicios") != null) {
                        formulario.setServicio(Integer.parseInt(request.getParameter("servicios")));
                    }
                    if (request.getParameter("comboAseguradora") != null) {
                        if (request.getParameter("comboAseguradora").trim().length() > 0) {
                            formulario.setFk_aseguradora(Long.parseLong(request.getParameter("comboAseguradora")));
                        }
                    }
                    if (request.getParameter("poliza") != null) {
                        if (request.getParameter("poliza").trim().length() > 0) {
                            formulario.setNro_poliza(request.getParameter("poliza"));
                        }
                    }
                    if (request.getParameter("vence") != null) {
                        if (request.getParameter("vence").trim().length() > 0) {
                            formulario.setFecha_poliza(new java.sql.Date(new java.util.Date(request.getParameter("vence")).getTime()));//pendiente
                        }
                    }
                    //        if(request.getParameter("condicionesi")!=null){
                    //             if(request.getParameter("condicionesi").trim().length()>0)
                    //               formulario.setCondicion_ingreso(request.getParameter("condicionesi"));
                    //         if(request.getParameter("condicionesi").trim().equals("SIN REGISTRO ANTES DE INICIO RNMA")){
                    //           java.sql.Date fechaIngresoRNMA = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaIngreso")).getTime());
                    //         formulario.setFecha_ingreso_rnma(fechaIngresoRNMA);
                    //   }
                    //   }
                    if (request.getParameter("rodaje") != null) {
                        formulario.setRodaje(Integer.parseInt(request.getParameter("rodaje")));
                    }
                    if (request.getParameter("tipoCabina") != null) {
                        formulario.setTipo_cabina(Integer.parseInt(request.getParameter("tipoCabina")));
                    }
                    id_form = model.adicionarFormulario(formulario);

                    /*     if(request.getParameter("r_color")!=null){
                     Radicacion_Color rc = new Radicacion_Color();
                     rc.setFk_formulario(id_form);
                     rc.setFk_color(Long.parseLong(request.getParameter("r_color")));
                     rc.setGama("");
                     rc.setSequencia(1);
                     model.adicionarRadicacionColores(rc);
                     session.setAttribute("colores",rc.getFk_color());
                     }*/
                    java.util.List lista2 = (java.util.List) session.getAttribute("propietarios");
                    for (int j = 0; j < lista2.size(); j++) {
                        Radicacion_Propietario rp = (Radicacion_Propietario) lista2.get(j);
                        rp.setFk_formulario(id_form);
                        model.adicionarRadicacionPropietarios(rp);
                        Radicacion_Apoderado ra2 = (Radicacion_Apoderado) session.getAttribute("apoderados" + rp.getFk_persona());
                        if (ra2 != null) {
                            ra2.setFk_formulario(id_form);
                            ra2.setFecha_inicio(new java.sql.Date(new java.util.Date().getTime()));
                            model.adicionarRadicacionApoderados(ra2);
                        }
                    }
                    lista = model.listadoParametros(40);
                    hash_especificaciones = (java.util.HashMap) session.getAttribute("especificaciones");
                    for (int j = 0; j < lista.size(); j++) {
                        Parametro pm = (Parametro) lista.get(j);
                        if (pm.getCodigo() < 19 || pm.getCodigo() > 24) {
                            String valor = "";
                            if (hash_especificaciones.get(pm.getCodigo() + "") != null) {
                                valor = hash_especificaciones.get(pm.getCodigo() + "") + "";
                            }
                            Radicacion_Dato_Vehiculo rdv = new Radicacion_Dato_Vehiculo();
                            rdv.setGrupo(2);
                            rdv.setParametro((int) pm.getCodigo());
                            rdv.setValor(valor);
                            rdv.setSubgrupo(0);
                            rdv.setFk_formulario(id_form);
                            model.adicionarRadDatosVehiculo(rdv);
                        }
                    }
                    ;
                    break;

                case 63:
                    id_form = model.adicionarFormulario(formulario);
                    lista = (java.util.List) session.getAttribute("propietarios");
                    for (int j = 0; j < lista.size(); j++) {
                        Radicacion_Propietario rp = (Radicacion_Propietario) lista.get(j);
                        rp.setFk_formulario(id_form);
                        model.adicionarRadicacionPropietarios(rp);
                        Radicacion_Apoderado raRNRYS = (Radicacion_Apoderado) session.getAttribute("apoderados" + rp.getFk_persona());
                        if (raRNRYS != null) {
                            raRNRYS.setFk_formulario(id_form);
                            raRNRYS.setFecha_inicio(new java.sql.Date(new java.util.Date().getTime()));
                            model.adicionarRadicacionApoderados(raRNRYS);
                        }
                    }
                    ;
                    break;
                //Tramite de Traslado de Cuenta

                //Tramite de Matricula Inicial Maquinaria Agricola
                //Aumento y disminucion de ejes
                case 82:
                    id_form = model.adicionarFormulario(formulario);
                    lista = model.listadoParametros(40);
                    hash_especificaciones = (java.util.HashMap) session.getAttribute("especificaciones");
                    for (int j = 0; j < lista.size(); j++) {
                        Parametro pm = (Parametro) lista.get(j);
                        if (pm.getCodigo() < 19 || pm.getCodigo() > 24) {
                            String valor = "";
                            if (hash_especificaciones.get(pm.getCodigo() + "") != null) {
                                valor = hash_especificaciones.get(pm.getCodigo() + "") + "";
                            }
                            Radicacion_Dato_Vehiculo rdv = new Radicacion_Dato_Vehiculo();
                            rdv.setGrupo(2);
                            rdv.setParametro((int) pm.getCodigo());
                            rdv.setValor(valor);
                            rdv.setSubgrupo(0);
                            rdv.setFk_formulario(id_form);
                            model.adicionarRadDatosVehiculo(rdv);
                        }
                    }
                    break;

                case 91:
                    System.out.println("Entro en el formulario de RNMA");
                    formulario.setFk_linea(Long.parseLong(request.getParameter("lineas")));
                    formulario.setFk_marca(Long.parseLong(request.getParameter("marcas")));
                    //   formulario.setFk_divipo(model.consultarDvipo(Long.parseLong(request.getParameter("departamentos")), Long.parseLong(request.getParameter("ciudades"))).getId_divipo());
                    formulario.setClase_vehiculo(Integer.parseInt(request.getParameter("clases")));
                    formulario.setModelo(Integer.parseInt(request.getParameter("modelo")));

                    formulario.setCombustible(Integer.parseInt(request.getParameter("combustibles")));

                    if (request.getParameter("carrocerias") != null) {
                        formulario.setCarroceria(Integer.parseInt(request.getParameter("carrocerias")));
                    } else {
                        formulario.setCarroceria(0);
                    }

                    if (!request.getParameter("modalidades").equals("0") && formulario.getClase_vehiculo() != 10 && formulario.getClase_vehiculo() != 14 && formulario.getClase_vehiculo() != 17 && formulario.getClase_vehiculo() != 18) {
                        formulario.setModalidad(Integer.parseInt(request.getParameter("modalidades")));
                    }
                    if (!request.getParameter("motor").equals("") && !request.getParameter("motor").equals("NA")) {
                        formulario.setMotor(request.getParameter("motor"));
                    }
                    if (!request.getParameter("chasis").equals("") && !request.getParameter("chasis").equals("NA")) {
                        formulario.setChasis(request.getParameter("chasis"));
                    }
                    if (!request.getParameter("serie").equals("")) {
                        formulario.setSerie(request.getParameter("serie"));
                    }
                    if (!request.getParameter("vin").equals("")) {
                        formulario.setVin(request.getParameter("vin"));
                    }

                    //  formulario.setTipo_importacion(Integer.parseInt(request.getParameter("tiposimportaciones")));
                    //      if(Integer.parseInt(request.getParameter("tiposimportaciones"))==1){
                    //            formulario.setTipo_doc_importacion(Integer.parseInt(request.getParameter("tiposimpor")));
                    //          formulario.setEntidad_remate(0);
                    //   }else{
                    //           formulario.setTipo_doc_importacion(0);
                    //           formulario.setEntidad_remate(Integer.parseInt(request.getParameter("tiposentidades")));
                    //   }
                    if (request.getParameter("nitConc") != null) {
                        formulario.setObservaciones(request.getParameter("nitConc"));
                    }

                    if (request.getParameter("valorF") != null) {
                        formulario.setSimit(request.getParameter("valorF"));
                    }

                    if (request.getParameter("radio") != null && !request.getParameter("radio").equals("0")) {
                        formulario.setNro_poliza(request.getParameter("radio"));
                    }

                    formulario.setCodigo_aduana(0);
                    //  formulario.setDocumento_importacion(request.getParameter("documentoimp"));
                    //  formulario.setFecha_documento(new java.sql.Date(new java.util.Date(request.getParameter("fechadocumento")).getTime()));//pendiente
                    formulario.setServicio(Integer.parseInt(request.getParameter("servicios")));
                    if (request.getParameter("comboAseguradora") != null) {
                        if (request.getParameter("comboAseguradora").trim().length() > 0) {
                            formulario.setFk_aseguradora(Long.parseLong(request.getParameter("comboAseguradora")));
                        }
                    }
                    if (request.getParameter("poliza") != null) {
                        if (request.getParameter("poliza").trim().length() > 0) {
                            formulario.setNro_poliza(request.getParameter("poliza"));
                        }
                    }
                    if (request.getParameter("vence") != null) {
                        if (request.getParameter("vence").trim().length() > 0) {
                            formulario.setFecha_poliza(new java.sql.Date(new java.util.Date(request.getParameter("vence")).getTime()));//pendiente
                        }
                    }
                    //        if(request.getParameter("condicionesi")!=null){
                    //             if(request.getParameter("condicionesi").trim().length()>0)
                    //               formulario.setCondicion_ingreso(request.getParameter("condicionesi"));
                    //         if(request.getParameter("condicionesi").trim().equals("SIN REGISTRO ANTES DE INICIO RNMA")){
                    //           java.sql.Date fechaIngresoRNMA = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaIngreso")).getTime());
                    //         formulario.setFecha_ingreso_rnma(fechaIngresoRNMA);
                    //   }
                    //   }
                    if (request.getParameter("rodaje") != null) {
                        formulario.setRodaje(Integer.parseInt(request.getParameter("rodaje")));
                    }
                    if (request.getParameter("tipoCabina") != null) {
                        formulario.setTipo_cabina(Integer.parseInt(request.getParameter("tipoCabina")));
                    }

                    if (request.getParameter("tipoCabina") != null) {
                        formulario.setTipo_cabina(Integer.parseInt(request.getParameter("tipoCabina")));
                        model.registrarRadicacionTramiteRUNT(id_form, 2, 65, request.getParameter("textGps"));
                    }
                    id_form = model.adicionarFormulario(formulario);

                    /*     if(request.getParameter("r_color")!=null){
                     Radicacion_Color rc = new Radicacion_Color();
                     rc.setFk_formulario(id_form);
                     rc.setFk_color(Long.parseLong(request.getParameter("r_color")));
                     rc.setGama("");
                     rc.setSequencia(1);
                     model.adicionarRadicacionColores(rc);
                     session.setAttribute("colores",rc.getFk_color());
                     }*/
                    lista2 = (java.util.List) session.getAttribute("propietarios");
                    for (int j = 0; j < lista2.size(); j++) {
                        Radicacion_Propietario rp = (Radicacion_Propietario) lista2.get(j);
                        rp.setFk_formulario(id_form);
                        model.adicionarRadicacionPropietarios(rp);
                        Radicacion_Apoderado ra2 = (Radicacion_Apoderado) session.getAttribute("apoderados" + rp.getFk_persona());
                        if (ra2 != null) {
                            ra2.setFk_formulario(id_form);
                            ra2.setFecha_inicio(new java.sql.Date(new java.util.Date().getTime()));
                            model.adicionarRadicacionApoderados(ra2);
                        }
                    }
                    lista = model.listadoParametros(40);
                    hash_especificaciones = (java.util.HashMap) session.getAttribute("especificaciones");
                    for (int j = 0; j < lista.size(); j++) {
                        Parametro pm = (Parametro) lista.get(j);
                        if (pm.getCodigo() < 19 || pm.getCodigo() > 24) {
                            String valor = "";
                            if (hash_especificaciones.get(pm.getCodigo() + "") != null) {
                                valor = hash_especificaciones.get(pm.getCodigo() + "") + "";
                            }
                            Radicacion_Dato_Vehiculo rdv = new Radicacion_Dato_Vehiculo();
                            rdv.setGrupo(2);
                            rdv.setParametro((int) pm.getCodigo());
                            rdv.setValor(valor);
                            rdv.setSubgrupo(0);
                            rdv.setFk_formulario(id_form);
                            model.adicionarRadDatosVehiculo(rdv);
                        }
                    }
                    ;
                    break;

                //Tramite de Traspaso RNMA
                case 92:
                    id_form = model.adicionarFormulario(formulario);
                    lista = (java.util.List) session.getAttribute("propietarios");
                    for (int j = 0; j < lista.size(); j++) {
                        Radicacion_Propietario rp = (Radicacion_Propietario) lista.get(j);
                        rp.setFk_formulario(id_form);
                        model.adicionarRadicacionPropietarios(rp);
                        Radicacion_Apoderado raRMA = (Radicacion_Apoderado) session.getAttribute("apoderados" + rp.getFk_persona());
                        if (raRMA != null) {
                            raRMA.setFk_formulario(id_form);
                            raRMA.setFecha_inicio(new java.sql.Date(new java.util.Date().getTime()));
                            model.adicionarRadicacionApoderados(raRMA);
                        }
                    }
                    ;
                    break;
                case 113:
                case 114:
                case 115:
                    switch (tramite) {
                        case 113:
                            formulario.setMotor(request.getParameter("motor"));
                            break;
                        case 115:
                            formulario.setSerie(request.getParameter("serie"));
                            break;
                    }
                    id_form = model.adicionarFormulario(formulario);
                    break;
            }

            vehiculo.setClase_vehiculo(formulario.getClase_vehiculo());
            vehiculo.setFk_divipo(formulario.getFk_divipo());
            vehiculo.setFk_linea(formulario.getFk_linea());
            vehiculo.setFk_sede(sede.getId_sede());
            vehiculo.setModelo(formulario.getModelo());
            vehiculo.setPlaca(formulario.getPlaca());
            vehiculo.setServicio(formulario.getServicio());
            vehiculo.setTipo_doc_importacion(formulario.getTipo_doc_importacion());
            vehiculo.setTipo_importacion(formulario.getTipo_importacion());
            vehiculo.setDocumento_importacion(formulario.getDocumento_importacion());
            vehiculo.setFecha_importacion(formulario.getFecha_documento());
            java.util.List lista = model.consultarConfiguracionTramitesRUNT(tramite);
            for (int j = 0; j < lista.size(); j++) {
                int dupla[] = (int[]) lista.get(j);
                if (request.getParameter((dupla[0] == 1 ? "caracteristica" : "especificacion") + dupla[1]) != null) {
                    if (!request.getParameter((dupla[0] == 1 ? "caracteristica" : "especificacion") + dupla[1]).trim().equals("")) {
                        if (request.getParameter((dupla[0] == 1 ? "caracteristica" : "especificacion") + dupla[1]).equals("0")) {
                            if (dupla[0] == 2) {
                                String datoRunt = request.getParameter((dupla[0] == 1 ? "caracteristica" : "especificacion") + dupla[1]);
                                model.registrarRadicacionTramiteRUNT(id_form, dupla[0], dupla[1], datoRunt);
                            }
                        } else {
                            String datoRunt = request.getParameter((dupla[0] == 1 ? "caracteristica" : "especificacion") + dupla[1]);
                            model.registrarRadicacionTramiteRUNT(id_form, dupla[0], dupla[1], datoRunt);
                        }
                    }
                }
            }
            if (request.getParameter("fthC") != null) {
                model.registrarRadicacionTramiteRUNT(id_form, 2, 3, request.getParameter("fthC"));
            }

            //entidadJ
            session.setAttribute("vehiculo", vehiculo);
            hash_caracteristicas.put("75", formulario.getCombustible() + "");
            hash_caracteristicas.put("2", formulario.getCarroceria() + "");
            hash_caracteristicas.put("324", formulario.getModalidad() + "");
            hash_especificaciones.put("19", formulario.getMotor() + "");
            hash_especificaciones.put("20", formulario.getChasis() + "");
            hash_especificaciones.put("21", formulario.getSerie() + "");

            hash_especificaciones.put("22", formulario.getMotor_reg() + "");
            hash_especificaciones.put("23", formulario.getChasis_reg() + "");
            hash_especificaciones.put("24", formulario.getSerie_reg() + "");
            session.setAttribute("caracteristicas", hash_caracteristicas);
            session.setAttribute("especificaciones", hash_especificaciones);
            tramites.remove(0);
            session.setAttribute("seleccionados", tramites);

            model.getCon().commit();
            if (tramites.size() > 0) {
                String p_placa = formulario.getPlaca();
                String p_tipo = request.getParameter("tipoDocumento");
                String p_numero = request.getParameter("numeroDocumento");%>
<jsp:forward page="formularioFUN.jsp">
    <jsp:param name="placa" value="<%=p_placa%>" />
    <jsp:param name="tip_rad" value="<%=p_tipo%>" />
    <jsp:param name="doc_rad" value="<%=p_numero%>" />
</jsp:forward>
<%
} else {%>

<jsp:forward page="formularioTramite.jsp">
    <jsp:param name="radicacion" value="<%=radicacion.getNumero()%>" />
    <jsp:param name="fecha" value="<%=radicacion.getFecha()%>" />
    <jsp:param name="sede" value="<%=radicacion.getFk_sede()%>" />
</jsp:forward>
<%
    }
} else {
    String p_placa = request.getParameter("placa").toUpperCase();
    String p_tipo = request.getParameter("tipoDocumento");
    String p_numero = request.getParameter("numeroDocumento");%>
<script>
    alert("No hay tramites asociados");
</script>
<jsp:forward page="formularioFUN.jsp">
    <jsp:param name="placa" value="<%=p_placa%>" />
    <jsp:param name="tip_rad" value="<%=p_tipo%>" />
    <jsp:param name="doc_rad" value="<%=p_numero%>" />
</jsp:forward>
<%              }
} catch (Exception exc) {
    System.out.println("Adicionar Formulario: ");
    model.getCon().rollback();
    exc.printStackTrace();%>
<script>
    alert("El tramite no pudo ser aprobado.. \n Error interno " +<%=exc.getMessage() != null ? exc.getMessage() : "Se presento algun valor Nulo"%>);
</script>
<%
    }
%>            

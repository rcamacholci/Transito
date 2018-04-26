<%@ page  import = "modelo.*" import = "java.util.*" import = "java.sql.*"    %>
<%
    boolean aprobar = true;
    Model model = (Model) session.getAttribute("model");
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    String numero = request.getParameter("radicacion");
    String fecha = request.getParameter("fecha_radicacion");
    System.out.println("Fecha Radicacion : " + fecha);
    String mensaje = "";
    try {
        Sede sede = (Sede) session.getAttribute("sede");
        java.util.HashMap tipdocs = model.crearHashParametrosAbreviatura(5);
        Radicacion radicacion = model.consultarRadicacion(numero, new java.sql.Date(new java.util.Date(fecha).getTime()), sede.getId_sede());
        if (radicacion != null) {
            Vehiculo vehiculo = null;
            if (radicacion.getEstado() == 4) {
                model.getCon().setAutoCommit(false);
                java.sql.Date fecha_actual = new java.sql.Date(new java.util.Date().getTime());
                java.util.List lista = model.consultarFormularios(radicacion.getId_radicacion());
                for (int i = 0; i < lista.size(); i++) {
                    Formulario formulario = (Formulario) lista.get(i);
                    model.actualizarLiquidacionRunt(formulario.getRunt(), formulario.getFk_tramite(), 2);
                    switch ((int) formulario.getFk_tramite()) {
                        //Tramite de Matricula Inicial
                        case 1:
                            vehiculo = new Vehiculo();
                            vehiculo.setClase_vehiculo(formulario.getClase_vehiculo());
                            vehiculo.setDocumento_importacion(formulario.getDocumento_importacion());
                            vehiculo.setEstado(1);
                            vehiculo.setFecha_importacion(formulario.getFecha_documento());
                            vehiculo.setFecha_matricula(fecha_actual);
                            vehiculo.setFk_divipo(formulario.getFk_divipo());
                            vehiculo.setFk_linea(formulario.getFk_linea());
                            Sede sede_rango = model.consultarSede(formulario.getPlaca());
                            vehiculo.setFk_sede(sede_rango.getId_sede());
                            vehiculo.setUsuario(usuario.getId_usuario());
                            vehiculo.setModelo(formulario.getModelo());
                            vehiculo.setPlaca(formulario.getPlaca());
                            vehiculo.setServicio(formulario.getServicio());
                            vehiculo.setTipo_doc_importacion(formulario.getTipo_doc_importacion());
                            vehiculo.setTipo_importacion(formulario.getTipo_importacion());
                            Vehiculo veh = model.consultarVehiculo(vehiculo.getPlaca());
                            if (veh != null) {
                                aprobar = false;
                                mensaje = "Tramite no Aprobado; Vehiculo ya registrado";
                                break;
                            }

                            model.matricularVehiculo(vehiculo);
                            vehiculo = model.consultarVehiculo(vehiculo.getPlaca());
                            if (vehiculo != null) {
                                Carpetas carpeta = new Carpetas();
                                carpeta.setEstado(1);
                                carpeta.setFk_sede(234);
                                carpeta.setFk_vehiculo(vehiculo.getId_vehiculo());
                                model.adicionarCarpeta(carpeta);
                                java.util.List lista_propietarios = model.consultarRadicacionesPropietarios(formulario.getId_formulario());
                                Radicacion_Propietario radicacion_propietario;
                                for (int j = 0; j < lista_propietarios.size(); j++) {
                                    radicacion_propietario = (Radicacion_Propietario) lista_propietarios.get(j);
                                    Propietario propietario = new Propietario();
                                    propietario.setFk_vehiculo(vehiculo.getId_vehiculo());
                                    propietario.setFk_persona(radicacion_propietario.getFk_persona());
                                    propietario.setPorcentaje((int) radicacion_propietario.getPorcentaje());
                                    propietario.setFecha_inicio(fecha_actual);
                                    propietario.setFk_usuario(usuario.getId_usuario());
                                    propietario.setTipoPropiedad(radicacion_propietario.getTipoPropiedad());
                                    propietario.setProIndiviso(radicacion_propietario.getProIndiviso().toUpperCase());
                                    model.adicionarPropietario(propietario);
                                }

                                java.util.List lista_colores = model.consultarRadicacionesColores(formulario.getId_formulario());
                                Radicacion_Color radicacion_color;
                                for (int j = 0; j < lista_colores.size(); j++) {
                                    radicacion_color = (Radicacion_Color) lista_colores.get(j);
                                    Historico_Color historico_color = new Historico_Color();
                                    historico_color.setFk_vehiculo(vehiculo.getId_vehiculo());
                                    historico_color.setFk_color(radicacion_color.getFk_color());
                                    historico_color.setGama(radicacion_color.getGama());
                                    historico_color.setSecuencia(radicacion_color.getSequencia());
                                    historico_color.setFecha_ini(fecha_actual);
                                    historico_color.setFk_usuario(usuario.getId_usuario());
                                    model.adicionarHistoricoColor(historico_color);
                                }

                                java.util.List lista_especificaciones = model.consultarRadicacionesEspecificaciones(formulario.getId_formulario());
                                Radicacion_Dato_Vehiculo radicacion_dato_vehiculo;
                                for (int j = 0; j < lista_especificaciones.size(); j++) {
                                    radicacion_dato_vehiculo = (Radicacion_Dato_Vehiculo) lista_especificaciones.get(j);
                                    DatosVehiculo datos_vehiculo = new DatosVehiculo();
                                    if (radicacion_dato_vehiculo.getValor() != null) {
                                        datos_vehiculo.setFecha_ini(fecha_actual);
                                        datos_vehiculo.setFecha_sistema(fecha_actual);
                                        datos_vehiculo.setFk_usuario(usuario.getId_usuario());
                                        datos_vehiculo.setFk_vehiculo(vehiculo.getId_vehiculo());
                                        datos_vehiculo.setGrupo_codigo(radicacion_dato_vehiculo.getGrupo());
                                        datos_vehiculo.setParam_codigo(radicacion_dato_vehiculo.getParametro());
                                        datos_vehiculo.setSub_grupo_codigo(40);
                                        datos_vehiculo.setValor(radicacion_dato_vehiculo.getValor());
                                        model.registrarDatosVehiculos(datos_vehiculo, 0);
                                    }
                                }

                                DatosVehiculo datos_vehiculo = new DatosVehiculo();
                                datos_vehiculo.setFecha_ini(fecha_actual);
                                datos_vehiculo.setFecha_sistema(fecha_actual);
                                datos_vehiculo.setFk_usuario(usuario.getId_usuario());
                                datos_vehiculo.setFk_vehiculo(vehiculo.getId_vehiculo());
                                datos_vehiculo.setGrupo_codigo(1);
                                datos_vehiculo.setParam_codigo(0);
                                datos_vehiculo.setSub_grupo_codigo(2);
                                datos_vehiculo.setValor(formulario.getCarroceria() + "");
                                model.registrarDatosVehiculos(datos_vehiculo, 0);

                                if (formulario.getModalidad() != 0) {
                                    datos_vehiculo.setParam_codigo(0);
                                    datos_vehiculo.setSub_grupo_codigo(324);
                                    datos_vehiculo.setValor(formulario.getModalidad() + "");
                                    model.registrarDatosVehiculos(datos_vehiculo, 0);
                                }
                                if (formulario.getCombustible() != 0) {
                                    datos_vehiculo.setParam_codigo(0);
                                    datos_vehiculo.setSub_grupo_codigo(75);
                                    datos_vehiculo.setValor(formulario.getCombustible() + "");
                                    model.registrarDatosVehiculos(datos_vehiculo, 0);
                                }

                                if (formulario.getMotor() != null) {
                                    datos_vehiculo.setGrupo_codigo(2);
                                    datos_vehiculo.setParam_codigo(19);
                                    datos_vehiculo.setSub_grupo_codigo(40);
                                    datos_vehiculo.setValor(formulario.getMotor());
                                    model.registrarDatosVehiculos(datos_vehiculo, 0);
                                }

                                if (formulario.getChasis() != null) {
                                    datos_vehiculo.setGrupo_codigo(2);
                                    datos_vehiculo.setParam_codigo(20);
                                    datos_vehiculo.setSub_grupo_codigo(40);
                                    datos_vehiculo.setValor(formulario.getChasis());
                                    model.registrarDatosVehiculos(datos_vehiculo, 0);
                                }

                                if (formulario.getSerie() != null) {
                                    datos_vehiculo.setGrupo_codigo(2);
                                    datos_vehiculo.setParam_codigo(21);
                                    datos_vehiculo.setSub_grupo_codigo(40);
                                    datos_vehiculo.setValor(formulario.getSerie());
                                    model.registrarDatosVehiculos(datos_vehiculo, 0);
                                }

                                Sincronizacion sincronizacion = new Sincronizacion();
                                sincronizacion.setFk_vehiculo(vehiculo.getId_vehiculo());
                                sincronizacion.setTipo(1);
                                sincronizacion.setFecha(new java.sql.Timestamp(new java.util.Date().getTime()));
                                sincronizacion.setFk_usuario(usuario.getId_usuario());
                                sincronizacion.setEstado(1);
                                sincronizacion.setResultado("Matricula Inicial");
                                model.adicionarSincronizacion(sincronizacion);

                                model.adicionarRuntVehiculo(vehiculo.getId_vehiculo(), 1, new java.sql.Timestamp(new java.util.Date().getTime()));

                                Venal venal = model.consultar_Venal(vehiculo.getPlaca(), 3);
                                if (venal != null) {
                                    venal.setEstado(2);
                                    venal.setFecha_utilizacion(new java.sql.Timestamp(new java.util.Date().getTime()));
                                    venal.setFk_radicacion(radicacion.getId_radicacion());
                                    model.actualizarVenal(venal);
                                } else {
                                    aprobar = false;
                                    mensaje = "Tramite no Aprobado; Venal no existente";
                                }
                            } else {
                                aprobar = false;
                                mensaje = "Tramite no Aprobado; Vehiculo no Existente";
                            }
                            ;
                            break;
                        //Tramite de Traspaso
                        case 2:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.finalizarPropietarios(vehiculo.getId_vehiculo(), fecha_actual, usuario.getId_usuario());
                            java.util.List lista_propietarios = model.consultarRadicacionesPropietarios(formulario.getId_formulario());
                            Radicacion_Propietario radicacion_propietario;
                            boolean newTipoP = true;
                            for (int j = 0; j < lista_propietarios.size(); j++) {
                                radicacion_propietario = (Radicacion_Propietario) lista_propietarios.get(j);
                                Propietario propietario = new Propietario();
                                propietario.setFk_vehiculo(vehiculo.getId_vehiculo());
                                propietario.setFk_persona(radicacion_propietario.getFk_persona());
                                propietario.setPorcentaje((int) radicacion_propietario.getPorcentaje());
                                propietario.setFecha_inicio(fecha_actual);
                                propietario.setFk_usuario(usuario.getId_usuario());
                                propietario.setTipoPropiedad(radicacion_propietario.getTipoPropiedad());
                                propietario.setProIndiviso(radicacion_propietario.getProIndiviso().toUpperCase());
                                model.adicionarPropietario(propietario);
                                if (vehiculo.getServicio() == 3 || vehiculo.getServicio() == 4) {
                                    Persona newPp = model.consultarPersona(radicacion_propietario.getFk_persona());
                                    if (newPp.getTipo_documento() == 2) {
                                        Empresa empresa = model.consultarEmpresa(newPp.getTipo_documento(), newPp.getDocumento());
                                        if (empresa != null) {
                                            if (empresa.getTipo_entidad() != null) {
                                                if (empresa.getTipo_entidad().equals("DIPLOMATICA")) {
                                                    newTipoP = false;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            if ((vehiculo.getServicio() == 3 || vehiculo.getServicio() == 4) && newTipoP) {
                                vehiculo.setServicio(1);
                                vehiculo.setUsuario(usuario.getId_usuario());
                                model.editarVehiculo(vehiculo, 0);
                            }
                            ;
                            break;
                        //Tramite de Traslado de Cuenta
                        case 3:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.actualizarEstadoVehiculo(vehiculo.getId_vehiculo(), 4, 0);
                            Movimiento movimiento = new Movimiento();
                            movimiento.setFk_sede(formulario.getSede_movimiento());
                            if (formulario.getLicencia_transito() != null) {
                                movimiento.setNumero_licencia(formulario.getLicencia_transito());
                            }
                            movimiento.setFk_vehiculo(vehiculo.getId_vehiculo());
                            movimiento.setFecha_movimiento(new java.sql.Timestamp(fecha_actual.getTime()));
                            movimiento.setTipo_movimiento(2);
                            movimiento.setFk_usuario_movimiento(usuario.getId_usuario());
                            movimiento.setEstado(1);
                            model.adicionarMovimientoVehiculo(movimiento);
                            Documento documentoTras = new Documento();
                            int numeroTras = model.consultarConsecutivo(sede.getId_sede(), 7, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
                            String numeroRealTras = "0000000".substring(0, 7 - String.valueOf(numeroTras).length()) + String.valueOf(numeroTras);
                            documentoTras.setNumero(numeroRealTras);
                            model.actualizarConsecutivo(sede.getId_sede(), 7, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
                            documentoTras.setEstado(1);
                            documentoTras.setReferencia("");
                            documentoTras.setFk_vehiculo(vehiculo.getId_vehiculo());
                            documentoTras.setFecha_expedicion(new java.sql.Date(new java.util.Date(fecha).getTime()));
                            documentoTras.setFk_Persona(0);
                            documentoTras.setFk_usuario(usuario.getId_usuario());
                            documentoTras.setTipo(4);
                            model.adicionarDocumento(documentoTras);

                            ;
                            break;
                        //Tramite de Radicacion de Cuenta
                        case 4:
                        case 65:
                        case 94:
                            boolean newR = true;
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            if (vehiculo == null) {
                                vehiculo = new Vehiculo();
                                newR = false;
                            }
                            vehiculo.setClase_vehiculo(formulario.getClase_vehiculo());
                            vehiculo.setDocumento_importacion(formulario.getDocumento_importacion());
                            vehiculo.setEstado(5);
                            vehiculo.setFecha_importacion(formulario.getFecha_documento());
                            vehiculo.setFecha_matricula(fecha_actual);
                            vehiculo.setFk_divipo(formulario.getFk_divipo());
                            vehiculo.setFk_linea(formulario.getFk_linea());
                            vehiculo.setFk_sede(radicacion.getFk_sede());
                            vehiculo.setUsuario(usuario.getId_usuario());
                            vehiculo.setModelo(formulario.getModelo());
                            vehiculo.setPlaca(formulario.getPlaca());
                            vehiculo.setServicio(formulario.getServicio());
                            vehiculo.setTipo_doc_importacion(formulario.getTipo_doc_importacion());
                            vehiculo.setTipo_importacion(formulario.getTipo_importacion());
                            if (newR) {
                                model.editarVehiculo(vehiculo, 0);
                            } else {
                                model.matricularVehiculo(vehiculo);
                                vehiculo = model.consultarVehiculo(vehiculo.getPlaca());
                            }
                            if (vehiculo != null) {
                                if (newR) {
                                    model.finalizarPropietarios(vehiculo.getId_vehiculo(), fecha_actual, usuario.getId_usuario());
                                    model.finalizarColores(vehiculo.getId_vehiculo(), fecha_actual, usuario.getId_usuario());
                                    model.finalizarAlertas(vehiculo.getId_vehiculo());
                                    model.finalizarEspecificaciones(vehiculo.getId_vehiculo(), fecha_actual, usuario.getId_usuario());
                                }
                                lista_propietarios = model.consultarRadicacionesPropietarios(formulario.getId_formulario());
                                for (int j = 0; j < lista_propietarios.size(); j++) {
                                    radicacion_propietario = (Radicacion_Propietario) lista_propietarios.get(j);
                                    Propietario propietario = new Propietario();
                                    propietario.setFk_vehiculo(vehiculo.getId_vehiculo());
                                    propietario.setFk_persona(radicacion_propietario.getFk_persona());
                                    propietario.setPorcentaje((int) radicacion_propietario.getPorcentaje());
                                    propietario.setFecha_inicio(fecha_actual);
                                    propietario.setFk_usuario(usuario.getId_usuario());
                                    propietario.setTipoPropiedad(radicacion_propietario.getTipoPropiedad());
                                    propietario.setProIndiviso(radicacion_propietario.getProIndiviso().toUpperCase());
                                    model.adicionarPropietario(propietario);
                                }

                                java.util.List lista_colores = model.consultarRadicacionesColores(formulario.getId_formulario());
                                Radicacion_Color radicacion_color;
                                for (int j = 0; j < lista_colores.size(); j++) {
                                    radicacion_color = (Radicacion_Color) lista_colores.get(j);
                                    Historico_Color historico_color = new Historico_Color();
                                    historico_color.setFk_vehiculo(vehiculo.getId_vehiculo());
                                    historico_color.setFk_color(radicacion_color.getFk_color());
                                    historico_color.setGama(radicacion_color.getGama());
                                    historico_color.setSecuencia(radicacion_color.getSequencia());
                                    historico_color.setFecha_ini(fecha_actual);
                                    historico_color.setFk_usuario(usuario.getId_usuario());
                                    model.adicionarHistoricoColor(historico_color);
                                }

                                java.util.List lista_especificaciones = model.consultarRadicacionesEspecificaciones(formulario.getId_formulario());
                                Radicacion_Dato_Vehiculo radicacion_dato_vehiculo;
                                for (int j = 0; j < lista_especificaciones.size(); j++) {
                                    radicacion_dato_vehiculo = (Radicacion_Dato_Vehiculo) lista_especificaciones.get(j);
                                    DatosVehiculo datos_vehiculo = new DatosVehiculo();
                                    if (radicacion_dato_vehiculo.getValor() != null) {
                                        datos_vehiculo.setFecha_ini(fecha_actual);
                                        datos_vehiculo.setFecha_sistema(fecha_actual);
                                        datos_vehiculo.setFk_usuario(usuario.getId_usuario());
                                        datos_vehiculo.setFk_vehiculo(vehiculo.getId_vehiculo());
                                        datos_vehiculo.setGrupo_codigo(radicacion_dato_vehiculo.getGrupo());
                                        datos_vehiculo.setParam_codigo(radicacion_dato_vehiculo.getParametro());
                                        datos_vehiculo.setSub_grupo_codigo(40);
                                        datos_vehiculo.setValor(radicacion_dato_vehiculo.getValor());
                                        model.registrarDatosVehiculos(datos_vehiculo, 0);
                                    }
                                }

                                DatosVehiculo datos_vehiculo = new DatosVehiculo();
                                datos_vehiculo.setFecha_ini(fecha_actual);
                                datos_vehiculo.setFecha_sistema(fecha_actual);
                                datos_vehiculo.setFk_usuario(usuario.getId_usuario());
                                datos_vehiculo.setFk_vehiculo(vehiculo.getId_vehiculo());
                                datos_vehiculo.setGrupo_codigo(1);
                                datos_vehiculo.setParam_codigo(0);
                                datos_vehiculo.setSub_grupo_codigo(2);
                                datos_vehiculo.setValor(formulario.getCarroceria() + "");
                                model.registrarDatosVehiculos(datos_vehiculo, 0);

                                datos_vehiculo.setParam_codigo(0);
                                datos_vehiculo.setSub_grupo_codigo(324);
                                datos_vehiculo.setValor(formulario.getModalidad() + "");
                                model.registrarDatosVehiculos(datos_vehiculo, 0);

                                datos_vehiculo.setParam_codigo(0);
                                datos_vehiculo.setSub_grupo_codigo(75);
                                datos_vehiculo.setValor(formulario.getCombustible() + "");
                                model.registrarDatosVehiculos(datos_vehiculo, 0);

                                if (formulario.getMotor() != null) {
                                    datos_vehiculo.setGrupo_codigo(2);
                                    datos_vehiculo.setParam_codigo(19);
                                    datos_vehiculo.setSub_grupo_codigo(40);
                                    datos_vehiculo.setValor(formulario.getMotor());
                                    model.registrarDatosVehiculos(datos_vehiculo, 0);
                                }

                                if (formulario.getChasis() != null) {
                                    datos_vehiculo.setGrupo_codigo(2);
                                    datos_vehiculo.setParam_codigo(20);
                                    datos_vehiculo.setSub_grupo_codigo(40);
                                    datos_vehiculo.setValor(formulario.getChasis());
                                    model.registrarDatosVehiculos(datos_vehiculo, 0);
                                }

                                if (formulario.getSerie() != null) {
                                    datos_vehiculo.setGrupo_codigo(2);
                                    datos_vehiculo.setParam_codigo(21);
                                    datos_vehiculo.setSub_grupo_codigo(40);
                                    datos_vehiculo.setValor(formulario.getSerie());
                                    model.registrarDatosVehiculos(datos_vehiculo, 0);
                                }

                                datos_vehiculo.setGrupo_codigo(2);
                                datos_vehiculo.setParam_codigo(22);
                                datos_vehiculo.setSub_grupo_codigo(40);
                                datos_vehiculo.setValor(formulario.getMotor_reg() + "");
                                model.registrarDatosVehiculos(datos_vehiculo, 0);

                                datos_vehiculo.setGrupo_codigo(2);
                                datos_vehiculo.setParam_codigo(23);
                                datos_vehiculo.setSub_grupo_codigo(40);
                                datos_vehiculo.setValor(formulario.getChasis_reg() + "");
                                model.registrarDatosVehiculos(datos_vehiculo, 0);

                                datos_vehiculo.setGrupo_codigo(2);
                                datos_vehiculo.setParam_codigo(24);
                                datos_vehiculo.setSub_grupo_codigo(40);
                                datos_vehiculo.setValor(formulario.getSerie_reg() + "");
                                model.registrarDatosVehiculos(datos_vehiculo, 0);

                                Radicacion_Alerta radicacion_alerta = model.consultarRadicacionAlerta(formulario.getId_formulario());
                                if (radicacion_alerta != null) {
                                    Alerta alerta = new Alerta();
                                    alerta.setFecha_ini(fecha_actual);
                                    alerta.setFk_persona(radicacion_alerta.getFk_persona());
                                    alerta.setFk_vehiculo(vehiculo.getId_vehiculo());
                                    alerta.setObservaciones(radicacion_alerta.getObservaciones());
                                    alerta.setTipo(radicacion_alerta.getAlerta());
                                    alerta.setUsuario(radicacion.getFk_usuario());
                                    alerta.setGrado(1);
                                    model.adicionarAlerta(alerta);
                                }

                                movimiento = model.ConsultarMovimientoVehiculo(vehiculo.getId_vehiculo());
                                if (movimiento != null) {
                                    movimiento.setEstado(2);
                                    model.actualizarMovimientoVehiculo(movimiento);
                                }

                                movimiento = new Movimiento();
                                movimiento.setFk_sede(formulario.getSede_movimiento());
                                if (formulario.getLicencia_transito() != null) {
                                    movimiento.setNumero_licencia(formulario.getLicencia_transito());
                                }
                                movimiento.setFk_vehiculo(vehiculo.getId_vehiculo());
                                movimiento.setFecha_movimiento(new java.sql.Timestamp(fecha_actual.getTime()));
                                movimiento.setTipo_movimiento(1);
                                movimiento.setFk_usuario_movimiento(usuario.getId_usuario());
                                movimiento.setEstado(1);
                                model.adicionarMovimientoVehiculo(movimiento);

                                Sincronizacion sincronizacion = new Sincronizacion();
                                sincronizacion.setFk_vehiculo(vehiculo.getId_vehiculo());
                                sincronizacion.setTipo(1);
                                sincronizacion.setFecha(new java.sql.Timestamp(new java.util.Date().getTime()));
                                sincronizacion.setFk_usuario(usuario.getId_usuario());
                                sincronizacion.setEstado(1);
                                sincronizacion.setResultado("Radicacion");
                                model.adicionarSincronizacion(sincronizacion);

                                model.adicionarRuntVehiculo(vehiculo.getId_vehiculo(), 1, new java.sql.Timestamp(new java.util.Date().getTime()));
                            } else {
                                aprobar = false;
                            }
                            ;
                            break;
                        //Tramite de Cambio de Color
                        case 5:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.finalizarColores(vehiculo.getId_vehiculo(), fecha_actual, usuario.getId_usuario());
                            java.util.List lista_colores = model.consultarRadicacionesColores(formulario.getId_formulario());
                            Radicacion_Color radicacion_color;
                            for (int j = 0; j < lista_colores.size(); j++) {
                                radicacion_color = (Radicacion_Color) lista_colores.get(j);
                                Historico_Color historico_color = new Historico_Color();
                                historico_color.setFk_vehiculo(vehiculo.getId_vehiculo());
                                historico_color.setFk_color(radicacion_color.getFk_color());
                                historico_color.setGama(radicacion_color.getGama());
                                historico_color.setSecuencia(radicacion_color.getSequencia());
                                historico_color.setFecha_ini(fecha_actual);
                                historico_color.setFk_usuario(usuario.getId_usuario());
                                model.adicionarHistoricoColor(historico_color);
                            }
                            ;
                            break;
                        //Tramite de Cambio de Servicio
                        case 6:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            vehiculo.setServicio(formulario.getServicio());
                            vehiculo.setUsuario(usuario.getId_usuario());
                            model.editarVehiculo(vehiculo, 0);
                            ;
                            break;
                        //Cambio de Blindaje
                        case 7:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.finalizarEspecificaciones(vehiculo.getId_vehiculo(), fecha_actual, 2, 14, 40, radicacion.getFk_usuario(), 0);
                            DatosVehiculo datos_vehiculo = new DatosVehiculo();
                            datos_vehiculo.setFecha_ini(fecha_actual);
                            datos_vehiculo.setFecha_sistema(fecha_actual);
                            datos_vehiculo.setFk_usuario(usuario.getId_usuario());
                            datos_vehiculo.setFk_vehiculo(vehiculo.getId_vehiculo());
                            datos_vehiculo.setGrupo_codigo(2);
                            datos_vehiculo.setParam_codigo(14);
                            datos_vehiculo.setSub_grupo_codigo(40);
                            String valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 31);
                            if (valorR != null) {
                                datos_vehiculo.setValor(valorR);
                            }
                            model.registrarDatosVehiculos(datos_vehiculo, 0);
                            ;
                            break;
                        //Tramite Rematricula de Vehiculo
                        case 8:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.actualizarEstadoVehiculo(vehiculo.getId_vehiculo(), 1, 0);
                            ;
                            break;
                        //Tramite de Traspaso Indeterminado
                        case 9:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.finalizarPropietarios(vehiculo.getId_vehiculo(), fecha_actual, usuario.getId_usuario());
                            lista_propietarios = model.consultarRadicacionesPropietarios(formulario.getId_formulario());
                            if (lista_propietarios.size() > 0) {
                                for (int j = 0; j < lista_propietarios.size(); j++) {
                                    radicacion_propietario = (Radicacion_Propietario) lista_propietarios.get(j);
                                    Propietario propietario = new Propietario();
                                    propietario.setFk_vehiculo(vehiculo.getId_vehiculo());
                                    propietario.setFk_persona(radicacion_propietario.getFk_persona());
                                    propietario.setPorcentaje((int) radicacion_propietario.getPorcentaje());
                                    propietario.setFecha_inicio(fecha_actual);
                                    propietario.setTipoPropiedad(radicacion_propietario.getTipoPropiedad());
                                    propietario.setProIndiviso(radicacion_propietario.getProIndiviso().toUpperCase());
                                    propietario.setFk_usuario(usuario.getId_usuario());
                                    model.adicionarPropietario(propietario);
                                }
                            } else {
                                Propietario propietario = new Propietario();
                                propietario.setFk_vehiculo(vehiculo.getId_vehiculo());
                                propietario.setFk_persona(146149);
                                propietario.setPorcentaje(100);
                                propietario.setTipoPropiedad("4");
                                propietario.setProIndiviso("N");
                                propietario.setFecha_inicio(fecha_actual);
                                propietario.setFk_usuario(usuario.getId_usuario());
                                model.adicionarPropietario(propietario);
                            }
                            Documento documentoT = new Documento();
                            int numeroT = model.consultarConsecutivo(sede.getId_sede(), 7, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
                            String numeroReal_T = "0000000".substring(0, 7 - String.valueOf(numeroT).length()) + String.valueOf(numeroT);
                            documentoT.setNumero(numeroReal_T);
                            model.actualizarConsecutivo(sede.getId_sede(), 7, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
                            documentoT.setEstado(1);
                            documentoT.setReferencia("");
                            documentoT.setFk_vehiculo(vehiculo.getId_vehiculo());
                            documentoT.setFecha_expedicion(new java.sql.Date(new java.util.Date(fecha).getTime()));
                            documentoT.setFk_Persona(0);
                            documentoT.setFk_usuario(usuario.getId_usuario());
                            documentoT.setTipo(6);
                            model.adicionarDocumento(documentoT);
                            ;
                            break;
                        //Tramite de Segundo Traspaso
                        case 10:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.finalizarPropietarios(vehiculo.getId_vehiculo(), fecha_actual, usuario.getId_usuario());
                            lista_propietarios = model.consultarRadicacionesPropietarios(formulario.getId_formulario());
                            newTipoP = true;
                            for (int j = 0; j < lista_propietarios.size(); j++) {
                                radicacion_propietario = (Radicacion_Propietario) lista_propietarios.get(j);
                                Propietario propietario = new Propietario();
                                propietario.setFk_vehiculo(vehiculo.getId_vehiculo());
                                propietario.setFk_persona(radicacion_propietario.getFk_persona());
                                propietario.setPorcentaje((int) radicacion_propietario.getPorcentaje());
                                propietario.setFecha_inicio(fecha_actual);
                                propietario.setFk_usuario(usuario.getId_usuario());
                                propietario.setTipoPropiedad(radicacion_propietario.getTipoPropiedad());
                                propietario.setProIndiviso(radicacion_propietario.getProIndiviso().toUpperCase());
                                model.adicionarPropietario(propietario);
                                if (vehiculo.getServicio() == 3 || vehiculo.getServicio() == 4) {
                                    Persona newPp = model.consultarPersona(radicacion_propietario.getFk_persona());
                                    if (newPp.getTipo_documento() == 2) {
                                        Empresa empresa = model.consultarEmpresa(newPp.getTipo_documento(), newPp.getDocumento());
                                        if (empresa != null) {
                                            if (empresa.getTipo_entidad() != null) {
                                                if (empresa.getTipo_entidad().equals("DIPLOMATICA")) {
                                                    newTipoP = false;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            if ((vehiculo.getServicio() == 3 || vehiculo.getServicio() == 4) && newTipoP) {
                                vehiculo.setServicio(1);
                                vehiculo.setUsuario(usuario.getId_usuario());
                                model.editarVehiculo(vehiculo, 0);
                            }
                            ;
                            break;
                        case 12:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            break;
                        //Tramite Inscripcion de Alerta
                        case 13:
                        case 73:
                        case 102:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            Radicacion_Alerta radicacion_alerta = model.consultarRadicacionAlerta(formulario.getId_formulario());
                            Alerta alerta = new Alerta();
                            alerta.setFecha_ini(fecha_actual);
                            alerta.setFk_persona(radicacion_alerta.getFk_persona());
                            alerta.setFk_vehiculo(vehiculo.getId_vehiculo());
                            alerta.setObservaciones(radicacion_alerta.getObservaciones());
                            alerta.setTipo(radicacion_alerta.getAlerta());
                            alerta.setUsuario(radicacion.getFk_usuario());
                            alerta.setGrado(1);
                            model.adicionarAlerta(alerta);
                            ;
                            break;
                        //Tramite Levantamiento de Alerta
                        case 14:
                        case 74:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            radicacion_alerta = model.consultarRadicacionAlerta(formulario.getId_formulario());
                            if (radicacion_alerta != null) {
                                alerta = new Alerta();
                                alerta.setFecha_ini(fecha_actual);
                                alerta.setFk_persona(radicacion_alerta.getFk_persona());
                                alerta.setFk_vehiculo(vehiculo.getId_vehiculo());
                                alerta.setObservaciones(radicacion_alerta.getObservaciones());
                                alerta.setTipo(radicacion_alerta.getAlerta());
                                alerta.setGrado(1);
                                alerta.setUsuario(radicacion.getFk_usuario());
                                model.adicionarAlerta(alerta);
                            }
                            model.finalizarAlertas(vehiculo.getId_vehiculo());
                            ;
                            break;
                        //Tramite Cancelacion de Vehiculo
                        case 15:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.actualizarEstadoVehiculo(vehiculo.getId_vehiculo(), 3, 0);
                            Documento documento = new Documento();
                            int numeroF = model.consultarConsecutivo(sede.getId_sede(), 7, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
                            String numeroReal = "0000000".substring(0, 7 - String.valueOf(numeroF).length()) + String.valueOf(numeroF);
                            documento.setNumero(numeroReal);
                            model.actualizarConsecutivo(sede.getId_sede(), 7, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
                            documento.setEstado(1);
                            documento.setReferencia("");
                            documento.setFk_vehiculo(vehiculo.getId_vehiculo());
                            documento.setFecha_expedicion(new java.sql.Date(new java.util.Date(fecha).getTime()));
                            documento.setFk_Persona(0);
                            documento.setFk_usuario(usuario.getId_usuario());
                            documento.setTipo(3);
                            valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 29);
                            if (valorR != null) {
                                documento.setObservacion(valorR);
                            }
                            model.adicionarDocumento(documento);

                            ;
                            break;

                        //Tramite Cambio de Motor
                        case 17:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.finalizarEspecificaciones(vehiculo.getId_vehiculo(), fecha_actual, 2, 19, 40, radicacion.getFk_usuario(), 0);
                            datos_vehiculo = new DatosVehiculo();
                            datos_vehiculo.setFecha_ini(fecha_actual);
                            datos_vehiculo.setFecha_sistema(fecha_actual);
                            datos_vehiculo.setFk_usuario(usuario.getId_usuario());
                            datos_vehiculo.setFk_vehiculo(vehiculo.getId_vehiculo());
                            datos_vehiculo.setGrupo_codigo(2);
                            datos_vehiculo.setParam_codigo(19);
                            datos_vehiculo.setSub_grupo_codigo(40);
                            datos_vehiculo.setValor(formulario.getMotor());
                            model.registrarDatosVehiculos(datos_vehiculo, 0);
                            ;
                            break;
                        //Tramite Cambio de Carroceria
                        case 20:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.finalizarEspecificaciones(vehiculo.getId_vehiculo(), fecha_actual, 1, 0, 2, radicacion.getFk_usuario(), 0);
                            datos_vehiculo = new DatosVehiculo();
                            datos_vehiculo.setFecha_ini(fecha_actual);
                            datos_vehiculo.setFecha_sistema(fecha_actual);
                            datos_vehiculo.setFk_usuario(usuario.getId_usuario());
                            datos_vehiculo.setFk_vehiculo(vehiculo.getId_vehiculo());
                            datos_vehiculo.setGrupo_codigo(1);
                            datos_vehiculo.setParam_codigo(0);
                            datos_vehiculo.setSub_grupo_codigo(2);
                            datos_vehiculo.setValor(formulario.getCarroceria() + "");
                            model.registrarDatosVehiculos(datos_vehiculo, 0);
                            ;
                            break;
                        //Tramite Cambio de Combustible
                        case 21:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.finalizarEspecificaciones(vehiculo.getId_vehiculo(), fecha_actual, 1, 0, 75, radicacion.getFk_usuario(), 0);
                            datos_vehiculo = new DatosVehiculo();
                            datos_vehiculo.setFecha_ini(fecha_actual);
                            datos_vehiculo.setFecha_sistema(fecha_actual);
                            datos_vehiculo.setFk_usuario(usuario.getId_usuario());
                            datos_vehiculo.setFk_vehiculo(vehiculo.getId_vehiculo());
                            datos_vehiculo.setGrupo_codigo(1);
                            datos_vehiculo.setParam_codigo(0);
                            datos_vehiculo.setSub_grupo_codigo(75);
                            datos_vehiculo.setValor(formulario.getCombustible() + "");
                            model.registrarDatosVehiculos(datos_vehiculo, 0);
                            ;
                            break;
                        //Tramite Cambio de Conjunto
                        case 22:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            vehiculo.setModelo(formulario.getModelo());
                            vehiculo.setUsuario(usuario.getId_usuario());
                            model.editarVehiculo(vehiculo, 0);
                            ;
                            break;
                        case 23:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.finalizarEspecificaciones(vehiculo.getId_vehiculo(), fecha_actual, 2, 19, 40, radicacion.getFk_usuario(), 0);
                            datos_vehiculo = new DatosVehiculo();
                            datos_vehiculo.setFecha_ini(fecha_actual);
                            datos_vehiculo.setFecha_sistema(fecha_actual);
                            datos_vehiculo.setFk_usuario(usuario.getId_usuario());
                            datos_vehiculo.setFk_vehiculo(vehiculo.getId_vehiculo());
                            datos_vehiculo.setGrupo_codigo(2);
                            datos_vehiculo.setParam_codigo(19);
                            datos_vehiculo.setSub_grupo_codigo(40);
                            datos_vehiculo.setValor(formulario.getMotor());
                            model.registrarDatosVehiculos(datos_vehiculo, 0);
                            vehiculo.setModelo(formulario.getModelo());
                            vehiculo.setUsuario(usuario.getId_usuario());
                            model.editarVehiculo(vehiculo, 0);
                            ;
                            break;
                        //Tramite Regrabacion de Motor
                        case 24:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.finalizarEspecificaciones(vehiculo.getId_vehiculo(), fecha_actual, 2, 19, 40, radicacion.getFk_usuario(), 0);
                            datos_vehiculo = new DatosVehiculo();
                            datos_vehiculo.setFecha_ini(fecha_actual);
                            datos_vehiculo.setFecha_sistema(fecha_actual);
                            datos_vehiculo.setFk_usuario(usuario.getId_usuario());
                            datos_vehiculo.setFk_vehiculo(vehiculo.getId_vehiculo());
                            datos_vehiculo.setGrupo_codigo(2);
                            datos_vehiculo.setParam_codigo(19);
                            datos_vehiculo.setSub_grupo_codigo(40);
                            datos_vehiculo.setValor(formulario.getMotor());
                            model.registrarDatosVehiculos(datos_vehiculo, 0);

                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.finalizarEspecificaciones(vehiculo.getId_vehiculo(), fecha_actual, 2, 22, 40, radicacion.getFk_usuario(), 0);
                            datos_vehiculo = new DatosVehiculo();
                            datos_vehiculo.setFecha_ini(fecha_actual);
                            datos_vehiculo.setFecha_sistema(fecha_actual);
                            datos_vehiculo.setFk_usuario(usuario.getId_usuario());
                            datos_vehiculo.setFk_vehiculo(vehiculo.getId_vehiculo());
                            datos_vehiculo.setGrupo_codigo(2);
                            datos_vehiculo.setParam_codigo(22);
                            datos_vehiculo.setSub_grupo_codigo(40);
                            datos_vehiculo.setValor("1");
                            model.registrarDatosVehiculos(datos_vehiculo, 0);
                            ;
                            break;
                        //Tramite Cambio de Chasis
                        case 25:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.finalizarEspecificaciones(vehiculo.getId_vehiculo(), fecha_actual, 2, 20, 40, radicacion.getFk_usuario(), 0);
                            datos_vehiculo = new DatosVehiculo();
                            datos_vehiculo.setFecha_ini(fecha_actual);
                            datos_vehiculo.setFecha_sistema(fecha_actual);
                            datos_vehiculo.setFk_usuario(usuario.getId_usuario());
                            datos_vehiculo.setFk_vehiculo(vehiculo.getId_vehiculo());
                            datos_vehiculo.setGrupo_codigo(2);
                            datos_vehiculo.setParam_codigo(20);
                            datos_vehiculo.setSub_grupo_codigo(40);
                            datos_vehiculo.setValor(formulario.getChasis());
                            model.registrarDatosVehiculos(datos_vehiculo, 0);

                            model.finalizarEspecificaciones(vehiculo.getId_vehiculo(), fecha_actual, 2, 23, 40, radicacion.getFk_usuario(), 0);
                            datos_vehiculo = new DatosVehiculo();
                            datos_vehiculo.setFecha_ini(fecha_actual);
                            datos_vehiculo.setFecha_sistema(fecha_actual);
                            datos_vehiculo.setFk_usuario(usuario.getId_usuario());
                            datos_vehiculo.setFk_vehiculo(vehiculo.getId_vehiculo());
                            datos_vehiculo.setGrupo_codigo(2);
                            datos_vehiculo.setParam_codigo(23);
                            datos_vehiculo.setSub_grupo_codigo(40);
                            datos_vehiculo.setValor("1");
                            model.registrarDatosVehiculos(datos_vehiculo, 0);
                            ;
                            break;
                        //Tramite Cambio de Serie
                        case 26:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.finalizarEspecificaciones(vehiculo.getId_vehiculo(), fecha_actual, 2, 21, 40, radicacion.getFk_usuario(), 0);
                            datos_vehiculo = new DatosVehiculo();
                            datos_vehiculo.setFecha_ini(fecha_actual);
                            datos_vehiculo.setFecha_sistema(fecha_actual);
                            datos_vehiculo.setFk_usuario(usuario.getId_usuario());
                            datos_vehiculo.setFk_vehiculo(vehiculo.getId_vehiculo());
                            datos_vehiculo.setGrupo_codigo(2);
                            datos_vehiculo.setParam_codigo(21);
                            datos_vehiculo.setSub_grupo_codigo(40);
                            datos_vehiculo.setValor(formulario.getSerie());
                            model.registrarDatosVehiculos(datos_vehiculo, 0);

                            model.finalizarEspecificaciones(vehiculo.getId_vehiculo(), fecha_actual, 2, 24, 40, radicacion.getFk_usuario(), 0);
                            datos_vehiculo = new DatosVehiculo();
                            datos_vehiculo.setFecha_ini(fecha_actual);
                            datos_vehiculo.setFecha_sistema(fecha_actual);
                            datos_vehiculo.setFk_usuario(usuario.getId_usuario());
                            datos_vehiculo.setFk_vehiculo(vehiculo.getId_vehiculo());
                            datos_vehiculo.setGrupo_codigo(2);
                            datos_vehiculo.setParam_codigo(24);
                            datos_vehiculo.setSub_grupo_codigo(40);
                            datos_vehiculo.setValor("1");
                            model.registrarDatosVehiculos(datos_vehiculo, 0);
                            ;
                            break;
                        //Tramite Inscripcion de Alerta
                        case 27:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.finalizarAlertas(vehiculo.getId_vehiculo());
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            radicacion_alerta = model.consultarRadicacionAlerta(formulario.getId_formulario());
                            alerta = new Alerta();
                            alerta.setFecha_ini(fecha_actual);
                            alerta.setFk_persona(radicacion_alerta.getFk_persona());
                            alerta.setFk_vehiculo(vehiculo.getId_vehiculo());
                            alerta.setObservaciones(radicacion_alerta.getObservaciones());
                            alerta.setTipo(radicacion_alerta.getAlerta());
                            alerta.setUsuario(radicacion.getFk_usuario());
                            model.adicionarAlerta(alerta);
                            ;
                            break;

                        case 32:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.actualizarEstadoVehiculo(vehiculo.getId_vehiculo(), 3, 0);
                            Documento documentoC = new Documento();
                            int numeroC = model.consultarConsecutivo(sede.getId_sede(), 7, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
                            String numeroReal_C = "0000000".substring(0, 7 - String.valueOf(numeroC).length()) + String.valueOf(numeroC);
                            documentoC.setNumero(numeroReal_C);
                            model.actualizarConsecutivo(sede.getId_sede(), 7, java.util.Calendar.getInstance().get(java.util.Calendar.YEAR));
                            documentoC.setEstado(1);
                            documentoC.setReferencia("");
                            documentoC.setFk_vehiculo(vehiculo.getId_vehiculo());
                            documentoC.setFecha_expedicion(new java.sql.Date(new java.util.Date(fecha).getTime()));
                            documentoC.setFk_Persona(0);
                            documentoC.setFk_usuario(usuario.getId_usuario());
                            documentoC.setTipo(3);
                            valorR = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 1, 151);
                            if (valorR != null) {
                                documentoC.setObservacion(valorR);
                            }
                            model.adicionarDocumento(documentoC);

                            ;
                            break;

                        case 62:
                            vehiculo = new Vehiculo();
                            vehiculo.setClase_vehiculo(formulario.getClase_vehiculo());
                            vehiculo.setDocumento_importacion(formulario.getDocumento_importacion());
                            vehiculo.setEstado(1);
                            vehiculo.setFecha_importacion(formulario.getFecha_documento());
                            vehiculo.setFecha_matricula(fecha_actual);
                            vehiculo.setFk_divipo(formulario.getFk_divipo());
                            vehiculo.setFk_linea(formulario.getFk_linea());
                            vehiculo.setFk_marca(formulario.getFk_marca());
                            Sede sede_rango2 = model.consultarSede(formulario.getPlaca());
                            vehiculo.setFk_sede(sede.getId_sede());
                            vehiculo.setUsuario(usuario.getId_usuario());
                            vehiculo.setModelo(formulario.getModelo());
                            vehiculo.setPlaca(formulario.getPlaca());
                            vehiculo.setServicio(formulario.getServicio());
                            vehiculo.setTipo_doc_importacion(formulario.getTipo_doc_importacion());
                            vehiculo.setTipo_importacion(formulario.getTipo_importacion());
                            veh = model.consultarVehiculo(vehiculo.getPlaca());
                            if (veh != null) {
                                aprobar = false;
                                mensaje = "Tramite no Aprobado; Vehiculo ya registrado";
                                break;
                            }
                            model.matricularVehiculo(vehiculo);

                            vehiculo = model.consultarVehiculo(vehiculo.getPlaca());
                            if (vehiculo != null) {
                                Carpetas carpeta = new Carpetas();
                                carpeta.setEstado(1);
                                carpeta.setFk_sede(234);
                                carpeta.setFk_vehiculo(vehiculo.getId_vehiculo());
                                model.adicionarCarpeta(carpeta);
                                java.util.List lista_propietariosRNRYS = model.consultarRadicacionesPropietarios(formulario.getId_formulario());
                                Radicacion_Propietario radicacion_propietarioRNRYS;
                                for (int j = 0; j < lista_propietariosRNRYS.size(); j++) {
                                    radicacion_propietarioRNRYS = (Radicacion_Propietario) lista_propietariosRNRYS.get(j);
                                    Propietario propietario = new Propietario();
                                    propietario.setFk_vehiculo(vehiculo.getId_vehiculo());
                                    propietario.setFk_persona(radicacion_propietarioRNRYS.getFk_persona());
                                    propietario.setPorcentaje((int) radicacion_propietarioRNRYS.getPorcentaje());
                                    propietario.setFecha_inicio(fecha_actual);
                                    propietario.setFk_usuario(usuario.getId_usuario());
                                    propietario.setTipoPropiedad(radicacion_propietarioRNRYS.getTipoPropiedad());
                                    propietario.setProIndiviso(radicacion_propietarioRNRYS.getProIndiviso().toUpperCase());
                                    model.adicionarPropietario(propietario);
                                }

                                java.util.List lista_especificaciones = model.consultarRadicacionesEspecificaciones(formulario.getId_formulario());
                                Radicacion_Dato_Vehiculo radicacion_dato_vehiculo;
                                for (int j = 0; j < lista_especificaciones.size(); j++) {
                                    radicacion_dato_vehiculo = (Radicacion_Dato_Vehiculo) lista_especificaciones.get(j);
                                    DatosVehiculo datos_vehiculoRNRYS = new DatosVehiculo();
                                    if (radicacion_dato_vehiculo.getValor() != null) {
                                        datos_vehiculoRNRYS.setFecha_ini(fecha_actual);
                                        datos_vehiculoRNRYS.setFecha_sistema(fecha_actual);
                                        datos_vehiculoRNRYS.setFk_usuario(usuario.getId_usuario());
                                        datos_vehiculoRNRYS.setFk_vehiculo(vehiculo.getId_vehiculo());
                                        datos_vehiculoRNRYS.setGrupo_codigo(radicacion_dato_vehiculo.getGrupo());
                                        datos_vehiculoRNRYS.setParam_codigo(radicacion_dato_vehiculo.getParametro());
                                        datos_vehiculoRNRYS.setSub_grupo_codigo(40);
                                        datos_vehiculoRNRYS.setValor(radicacion_dato_vehiculo.getValor());
                                        model.registrarDatosVehiculos(datos_vehiculoRNRYS, 0);
                                    }
                                }

                                DatosVehiculo datos_vehiculo2 = new DatosVehiculo();
                                datos_vehiculo2.setFecha_ini(fecha_actual);
                                datos_vehiculo2.setFecha_sistema(fecha_actual);
                                datos_vehiculo2.setFk_usuario(usuario.getId_usuario());
                                datos_vehiculo2.setFk_vehiculo(vehiculo.getId_vehiculo());
                                datos_vehiculo2.setGrupo_codigo(1);
                                datos_vehiculo2.setParam_codigo(0);
                                datos_vehiculo2.setSub_grupo_codigo(2);
                                datos_vehiculo2.setValor(formulario.getCarroceria() + "");
                                model.registrarDatosVehiculos(datos_vehiculo2, 0);

                                if (formulario.getModalidad() != 0) {
                                    datos_vehiculo2.setParam_codigo(0);
                                    datos_vehiculo2.setSub_grupo_codigo(324);
                                    datos_vehiculo2.setValor(formulario.getModalidad() + "");
                                    model.registrarDatosVehiculos(datos_vehiculo2, 0);
                                }
                                if (formulario.getCombustible() != 0) {
                                    datos_vehiculo2.setParam_codigo(0);
                                    datos_vehiculo2.setSub_grupo_codigo(75);
                                    datos_vehiculo2.setValor(formulario.getCombustible() + "");
                                    model.registrarDatosVehiculos(datos_vehiculo2, 0);
                                }

                                if (formulario.getMotor() != null) {
                                    datos_vehiculo2.setGrupo_codigo(2);
                                    datos_vehiculo2.setParam_codigo(19);
                                    datos_vehiculo2.setSub_grupo_codigo(40);
                                    datos_vehiculo2.setValor(formulario.getMotor());
                                    model.registrarDatosVehiculos(datos_vehiculo2, 0);
                                }

                                if (formulario.getChasis() != null) {
                                    datos_vehiculo2.setGrupo_codigo(2);
                                    datos_vehiculo2.setParam_codigo(20);
                                    datos_vehiculo2.setSub_grupo_codigo(40);
                                    datos_vehiculo2.setValor(formulario.getChasis());
                                    model.registrarDatosVehiculos(datos_vehiculo2, 0);
                                }

                                if (formulario.getSerie() != null) {
                                    datos_vehiculo2.setGrupo_codigo(2);
                                    datos_vehiculo2.setParam_codigo(21);
                                    datos_vehiculo2.setSub_grupo_codigo(40);
                                    datos_vehiculo2.setValor(formulario.getSerie());
                                    model.registrarDatosVehiculos(datos_vehiculo2, 0);
                                }

                                if (formulario.getVin() != null) {
                                    datos_vehiculo2.setGrupo_codigo(2);
                                    datos_vehiculo2.setParam_codigo(25);
                                    datos_vehiculo2.setSub_grupo_codigo(40);
                                    datos_vehiculo2.setValor(formulario.getVin());
                                    model.registrarDatosVehiculos(datos_vehiculo2, 0);
                                }

                                Sincronizacion sincronizacion = new Sincronizacion();
                                sincronizacion.setFk_vehiculo(vehiculo.getId_vehiculo());
                                sincronizacion.setTipo(1);
                                sincronizacion.setFecha(new java.sql.Timestamp(new java.util.Date().getTime()));
                                sincronizacion.setFk_usuario(usuario.getId_usuario());
                                sincronizacion.setEstado(1);
                                sincronizacion.setResultado("Matricula Inicial");
                                model.adicionarSincronizacion(sincronizacion);

                                model.adicionarRuntVehiculo(vehiculo.getId_vehiculo(), 1, new java.sql.Timestamp(new java.util.Date().getTime()));

                                Venal venal = model.consultar_Venal(vehiculo.getPlaca(), 3);
                                if (venal != null) {
                                    venal.setEstado(2);
                                    venal.setFecha_utilizacion(new java.sql.Timestamp(new java.util.Date().getTime()));
                                    venal.setFk_radicacion(radicacion.getId_radicacion());
                                    model.actualizarVenal(venal);
                                } else {
                                    aprobar = true;

                                }
                            } else {
                                aprobar = false;
                                mensaje = "Tramite no Aprobado; Vehiculo no Existe";
                            }
                            ;
                            break;
                        case 63:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            model.finalizarPropietarios(vehiculo.getId_vehiculo(), fecha_actual, usuario.getId_usuario());
                            java.util.List lista_propietariosRNRYS = model.consultarRadicacionesPropietarios(formulario.getId_formulario());
                            Radicacion_Propietario radicacion_propietarioRNRYS;
                            boolean newTipoPRNRYS = true;
                            for (int j = 0; j < lista_propietariosRNRYS.size(); j++) {
                                radicacion_propietarioRNRYS = (Radicacion_Propietario) lista_propietariosRNRYS.get(j);
                                Propietario propietario = new Propietario();
                                propietario.setFk_vehiculo(vehiculo.getId_vehiculo());
                                propietario.setFk_persona(radicacion_propietarioRNRYS.getFk_persona());
                                propietario.setPorcentaje((int) radicacion_propietarioRNRYS.getPorcentaje());
                                propietario.setFecha_inicio(fecha_actual);
                                propietario.setFk_usuario(usuario.getId_usuario());
                                propietario.setTipoPropiedad(radicacion_propietarioRNRYS.getTipoPropiedad());
                                propietario.setProIndiviso(radicacion_propietarioRNRYS.getProIndiviso().toUpperCase());
                                model.adicionarPropietario(propietario);
                                if (vehiculo.getServicio() == 3 || vehiculo.getServicio() == 4) {
                                    Persona newPp = model.consultarPersona(radicacion_propietarioRNRYS.getFk_persona());
                                    if (newPp.getTipo_documento() == 2) {
                                        Empresa empresa = model.consultarEmpresa(newPp.getTipo_documento(), newPp.getDocumento());
                                        if (empresa != null) {
                                            if (empresa.getTipo_entidad() != null) {
                                                if (empresa.getTipo_entidad().equals("DIPLOMATICA")) {
                                                    newTipoPRNRYS = false;
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                            if ((vehiculo.getServicio() == 3 || vehiculo.getServicio() == 4) && newTipoPRNRYS) {
                                vehiculo.setServicio(1);
                                vehiculo.setUsuario(usuario.getId_usuario());
                                model.editarVehiculo(vehiculo, 0);
                            }
                            ;
                            break;
                        case 82:
                            vehiculo = model.consultarVehiculo(formulario.getPlaca());
                            java.util.List especificaciones = model.consultarRadicacionesEspecificaciones(formulario.getId_formulario());
                            Radicacion_Dato_Vehiculo dato_vehiculo;
                            for (int j = 0; j < especificaciones.size(); j++) {
                                dato_vehiculo = (Radicacion_Dato_Vehiculo) especificaciones.get(j);
                                DatosVehiculo datos_vehiculoRNRYS = new DatosVehiculo();
                                if (dato_vehiculo.getValor() != null) {
                                    model.finalizarEspecificaciones(vehiculo.getId_vehiculo(), fecha_actual, 2, 9,40, radicacion.getFk_usuario(),0);

                                    datos_vehiculoRNRYS.setFecha_ini(fecha_actual);
                                    datos_vehiculoRNRYS.setFecha_sistema(fecha_actual);
                                    datos_vehiculoRNRYS.setFk_usuario(usuario.getId_usuario());
                                    datos_vehiculoRNRYS.setFk_vehiculo(vehiculo.getId_vehiculo());
                                    datos_vehiculoRNRYS.setGrupo_codigo(dato_vehiculo.getGrupo());
                                    datos_vehiculoRNRYS.setParam_codigo(dato_vehiculo.getParametro());
                                    datos_vehiculoRNRYS.setSub_grupo_codigo(40);
                                    datos_vehiculoRNRYS.setValor(dato_vehiculo.getValor());
                                    model.registrarDatosVehiculos(datos_vehiculoRNRYS, 0);
                                }
                            }
                            break;
                        case 91:
                            vehiculo = new Vehiculo();
                            vehiculo.setClase_vehiculo(formulario.getClase_vehiculo());
                            vehiculo.setDocumento_importacion(formulario.getDocumento_importacion());
                            vehiculo.setEstado(1);
                            vehiculo.setFecha_importacion(formulario.getFecha_documento());
                            vehiculo.setFecha_matricula(fecha_actual);
                            vehiculo.setFk_divipo(formulario.getFk_divipo());
                            vehiculo.setFk_linea(formulario.getFk_linea());
                            //sede_rango = model.consultarSede(formulario.getPlaca());
                            vehiculo.setFk_sede(sede.getId_sede());
                            vehiculo.setUsuario(usuario.getId_usuario());
                            vehiculo.setModelo(formulario.getModelo());
                            vehiculo.setPlaca(formulario.getPlaca());
                            vehiculo.setServicio(formulario.getServicio());
                            vehiculo.setTipo_doc_importacion(formulario.getTipo_doc_importacion());
                            vehiculo.setTipo_importacion(formulario.getTipo_importacion());
                            veh = model.consultarVehiculo(vehiculo.getPlaca());
                            if (veh != null) {
                                aprobar = false;
                                mensaje = "Tramite no Aprobado; Vehiculo ya registrado";
                                break;
                            }
                            model.matricularVehiculo(vehiculo);

                            vehiculo = model.consultarVehiculo(vehiculo.getPlaca());
                            if (vehiculo != null) {
                                Carpetas carpeta = new Carpetas();
                                carpeta.setEstado(1);
                                carpeta.setFk_sede(234);
                                carpeta.setFk_vehiculo(vehiculo.getId_vehiculo());
                                model.adicionarCarpeta(carpeta);
                                lista_propietarios = model.consultarRadicacionesPropietarios(formulario.getId_formulario());
                                radicacion_propietario = new Radicacion_Propietario();
                                for (int j = 0; j < lista_propietarios.size(); j++) {
                                    radicacion_propietario = (Radicacion_Propietario) lista_propietarios.get(j);
                                    Propietario propietario = new Propietario();
                                    propietario.setFk_vehiculo(vehiculo.getId_vehiculo());
                                    propietario.setFk_persona(radicacion_propietario.getFk_persona());
                                    propietario.setPorcentaje((int) radicacion_propietario.getPorcentaje());
                                    propietario.setFecha_inicio(fecha_actual);
                                    propietario.setFk_usuario(usuario.getId_usuario());
                                    propietario.setTipoPropiedad(radicacion_propietario.getTipoPropiedad());
                                    propietario.setProIndiviso(radicacion_propietario.getProIndiviso().toUpperCase());
                                    model.adicionarPropietario(propietario);
                                }

                                lista_colores = model.consultarRadicacionesColores(formulario.getId_formulario());
                                radicacion_color = new Radicacion_Color();
                                for (int j = 0; j < lista_colores.size(); j++) {
                                    radicacion_color = (Radicacion_Color) lista_colores.get(j);
                                    Historico_Color historico_color = new Historico_Color();
                                    historico_color.setFk_vehiculo(vehiculo.getId_vehiculo());
                                    historico_color.setFk_color(radicacion_color.getFk_color());
                                    historico_color.setGama(radicacion_color.getGama());
                                    historico_color.setSecuencia(radicacion_color.getSequencia());
                                    historico_color.setFecha_ini(fecha_actual);
                                    historico_color.setFk_usuario(usuario.getId_usuario());
                                    model.adicionarHistoricoColor(historico_color);
                                }

                                java.util.List lista_especificaciones = model.consultarRadicacionesEspecificaciones(formulario.getId_formulario());
                                Radicacion_Dato_Vehiculo radicacion_dato_vehiculo;
                                for (int j = 0; j < lista_especificaciones.size(); j++) {
                                    radicacion_dato_vehiculo = (Radicacion_Dato_Vehiculo) lista_especificaciones.get(j);
                                    datos_vehiculo = new DatosVehiculo();
                                    if (radicacion_dato_vehiculo.getValor() != null) {
                                        datos_vehiculo.setFecha_ini(fecha_actual);
                                        datos_vehiculo.setFecha_sistema(fecha_actual);
                                        datos_vehiculo.setFk_usuario(usuario.getId_usuario());
                                        datos_vehiculo.setFk_vehiculo(vehiculo.getId_vehiculo());
                                        datos_vehiculo.setGrupo_codigo(radicacion_dato_vehiculo.getGrupo());
                                        datos_vehiculo.setParam_codigo(radicacion_dato_vehiculo.getParametro());
                                        datos_vehiculo.setSub_grupo_codigo(40);
                                        datos_vehiculo.setValor(radicacion_dato_vehiculo.getValor());
                                        model.registrarDatosVehiculos(datos_vehiculo, 0);
                                    }
                                }

                                datos_vehiculo = new DatosVehiculo();
                                datos_vehiculo.setFecha_ini(fecha_actual);
                                datos_vehiculo.setFecha_sistema(fecha_actual);
                                datos_vehiculo.setFk_usuario(usuario.getId_usuario());
                                datos_vehiculo.setFk_vehiculo(vehiculo.getId_vehiculo());
                                datos_vehiculo.setGrupo_codigo(1);
                                datos_vehiculo.setParam_codigo(0);
                                datos_vehiculo.setSub_grupo_codigo(2);
                                datos_vehiculo.setValor(formulario.getCarroceria() + "");
                                model.registrarDatosVehiculos(datos_vehiculo, 0);

                                if (formulario.getModalidad() != 0) {
                                    datos_vehiculo.setParam_codigo(0);
                                    datos_vehiculo.setSub_grupo_codigo(324);
                                    datos_vehiculo.setValor(formulario.getModalidad() + "");
                                    model.registrarDatosVehiculos(datos_vehiculo, 0);
                                }
                                if (formulario.getCombustible() != 0) {
                                    datos_vehiculo.setParam_codigo(0);
                                    datos_vehiculo.setSub_grupo_codigo(75);
                                    datos_vehiculo.setValor(formulario.getCombustible() + "");
                                    model.registrarDatosVehiculos(datos_vehiculo, 0);
                                }

                                if (formulario.getMotor() != null) {
                                    datos_vehiculo.setGrupo_codigo(2);
                                    datos_vehiculo.setParam_codigo(19);
                                    datos_vehiculo.setSub_grupo_codigo(40);
                                    datos_vehiculo.setValor(formulario.getMotor());
                                    model.registrarDatosVehiculos(datos_vehiculo, 0);
                                }

                                if (formulario.getChasis() != null) {
                                    datos_vehiculo.setGrupo_codigo(2);
                                    datos_vehiculo.setParam_codigo(20);
                                    datos_vehiculo.setSub_grupo_codigo(40);
                                    datos_vehiculo.setValor(formulario.getChasis());
                                    model.registrarDatosVehiculos(datos_vehiculo, 0);
                                }

                                if (formulario.getSerie() != null) {
                                    datos_vehiculo.setGrupo_codigo(2);
                                    datos_vehiculo.setParam_codigo(21);
                                    datos_vehiculo.setSub_grupo_codigo(40);
                                    datos_vehiculo.setValor(formulario.getSerie());
                                    model.registrarDatosVehiculos(datos_vehiculo, 0);
                                }
                                if (formulario.getVin() != null) {
                                    datos_vehiculo.setGrupo_codigo(2);
                                    datos_vehiculo.setParam_codigo(25);
                                    datos_vehiculo.setSub_grupo_codigo(40);
                                    datos_vehiculo.setValor(formulario.getVin());
                                    model.registrarDatosVehiculos(datos_vehiculo, 0);
                                }

                                Sincronizacion sincronizacion = new Sincronizacion();
                                sincronizacion.setFk_vehiculo(vehiculo.getId_vehiculo());
                                sincronizacion.setTipo(1);
                                sincronizacion.setFecha(new java.sql.Timestamp(new java.util.Date().getTime()));
                                sincronizacion.setFk_usuario(usuario.getId_usuario());
                                sincronizacion.setEstado(1);
                                sincronizacion.setResultado("Matricula Inicial");
                                model.adicionarSincronizacion(sincronizacion);

                                model.adicionarRuntVehiculo(vehiculo.getId_vehiculo(), 1, new java.sql.Timestamp(new java.util.Date().getTime()));

                            } else {
                                aprobar = false;
                                mensaje = "Tramite no Aprobado; Vehiculo no existe";
                            }
                            ;
                            break;

                    }
                }
                model.actualizarNumeroSustrato(radicacion.getId_radicacion(), request.getParameter("sustrato"), 1);
                model.actualizarEstadoRadicacion(radicacion.getId_radicacion(), 5);
                if (vehiculo != null) {
                    Licencia_Transito licenciaTransito = model.consultarLicenciaTransitoRadicacion(radicacion.getId_radicacion());
                    if (licenciaTransito != null) {
                        if (licenciaTransito.getFk_vehiculo() == 0) {
                            model.actualizarLicenciaTransito(licenciaTransito.getId_licenciaTransito(), vehiculo.getId_vehiculo(), request.getParameter("sustrato"), new java.sql.Date(new java.util.Date().getTime()));
                        }
                    }
                }
                if (aprobar) {
                    model.getCon().commit();
                    mensaje = "Tramite ha sido aprobado correctamente";
                } else {
                    model.getCon().rollback();
                    mensaje = "Tramite no Aprobado \n " + mensaje;
                }

%>

<jsp:forward page="formularioTramite.jsp">
    <jsp:param name="radicacion" value="<%=numero%>" />
    <jsp:param name="fecha" value="<%=fecha%>" />
    <jsp:param name="msg" value="<%=mensaje%>" />
</jsp:forward>
<%      } else {

        }
    }
} catch (Exception excw) {
    excw.printStackTrace();
    model.getCon().rollback();
    mensaje = "Mensaje no pudo ser aprobado " + excw.getMessage();
%>
<jsp:forward page="formularioTramite.jsp">
    <jsp:param name="radicacion" value="<%=numero%>" />
    <jsp:param name="fecha" value="<%=fecha%>" />
    <jsp:param name="msg" value="<%=mensaje%>" />
</jsp:forward>
<%
    }
%>

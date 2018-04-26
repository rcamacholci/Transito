<%@ page  import = "modelo.*" import = "java.util.*" import = "java.sql.*" import="java.*" %>
<%
    boolean aprobar = true;
    Model model = (Model) session.getAttribute("model");
    Usuario usuario = (Usuario) session.getAttribute("usuario");
    Sede sede = (Sede) session.getAttribute("sede");
    String placa = "";
    String numA = "";
    String observacion = "";
    int tipo = 0;
    int tramite = 0;
    String mensaje = "";
    String numR = "";
    java.sql.Date fecha = null;
    if (request.getParameter("fecha") != null) {
        if (request.getParameter("fecha").trim().length() > 0) {
            fecha = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha")).getTime());

        }
    }
    if (request.getParameter("numA") != null) {
        numA = request.getParameter("numA");
    }
    if (request.getParameter("placa") != null) {
        placa = request.getParameter("placa");
    }
    if (request.getParameter("observacion") != null) {
        observacion = request.getParameter("observacion");
    }
    if (request.getParameter("tipo") != null) {
        tipo = Integer.parseInt(request.getParameter("tipo"));
    }
    if (request.getParameter("numR") != null) {
        numR = request.getParameter("numR");
    }
    if (request.getParameter("tramite") != null) {
        tramite = Integer.parseInt(request.getParameter("tramite"));
    }
    try {
        if (tipo == 1) {
            if (!placa.equals("") && !numA.equals("") && !observacion.equals("") && tipo != 0 && !numR.equals("") && tramite != 0) {

                Vehiculo vehiculo = model.consultarVehiculo(placa.toUpperCase());
                if (vehiculo != null) {
                    model.getCon().setAutoCommit(false);
                    java.sql.Date fecha_actual = new java.sql.Date(new java.util.Date().getTime());
                    Actos_Administrativos actosA = new Actos_Administrativos();
                    actosA.setNUMERO(numA);
                    actosA.setFECHA(fecha);
                    actosA.setFECHA_PROCESO(fecha_actual);
                    actosA.setESTADO(1);
                    actosA.setFK_USUARIO(usuario.getId_usuario());
                    actosA.setTIPO(tipo);
                    actosA.setFK_VEHICULO(vehiculo.getId_vehiculo());
                    Tramite tram = model.consultarTramite((long) tramite);
                    actosA.setTRAMITE(tram.getNombre());
                    actosA.setOBSERVACIONES(observacion);

                    switch (tramite) {
                        //Tramite de Matricula Inicial
                        case 1:

                                ;
                            break;
                        //Tramite de Traspaso
                        case 2:

                                ;
                            break;
                        //Tramite de Traslado de Cuenta
                        case 3:
                            Radicacion radicacionTrasl = model.consultarRadicacionPlacaTramite(numR, placa, tramite);
                            java.util.List<Formulario> temp = model.consultarFormularios(radicacionTrasl.getId_radicacion());
                            if (temp.size() > 1) {
                                Movimiento movimiento = model.ConsultarMovimientoVehiculo(vehiculo.getId_vehiculo());
                                if (movimiento != null) {
                                    movimiento.setEstado(2);
                                    model.actualizarMovimientoVehiculo(movimiento);
                                }
                                radicacionTrasl.setEstado(9);
                                Formulario fu = model.consultarFormularioByTramite(radicacionTrasl.getId_radicacion(), tramite);
                                long Idradica = model.adicionarDatosRadicacion(radicacionTrasl);
                                System.out.println("Radicado " + Idradica);
                                if (radicacionTrasl != null) {
                                    model.editarFormularioTramite(fu.getId_formulario(), Idradica);
                                }
                            } else {
                                Movimiento movimiento = model.ConsultarMovimientoVehiculo(vehiculo.getId_vehiculo());
                                if (movimiento != null) {
                                    movimiento.setEstado(2);
                                    model.actualizarMovimientoVehiculo(movimiento);
                                }
                                model.actualizarEstadoRadicacion(radicacionTrasl.getId_radicacion(), 9);
                                model.actualizarEstadoVehiculo(vehiculo.getId_vehiculo(), 1, 0);
                            }

                            ;
                            break;
                        //Tramite de Radicacion de Cuenta
                        case 4:

                                ;
                            break;
                        //Tramite de Cambio de Color
                        case 5:

                                ;
                            break;
                        //Tramite de Cambio de Servicio
                        case 6:

                                ;
                            break;
                        //Cambio de Blindaje
                        case 7:

                                ;
                            break;
                        //Tramite Rematricula de Vehiculo
                        case 8:

                                ;
                            break;
                        //Tramite de Traspaso Indeterminado
                        case 9:
                            Propietario propietario = model.getUnicoPropietarioVehiculo(vehiculo.getId_vehiculo());
                            if (propietario != null) {
                                // System.out.println("SI ENTRO Propietario");
                                if (propietario.getFk_persona() == 146149) {
                                    // System.out.println("SI ENTRO EN INDETERMINADO");
                                    List list = model.Listar_Propietarios_Anteriores(propietario.getFecha_inicio(), vehiculo.getId_vehiculo());
                                    if (list.size() != 0) {
                                        //       System.out.println("SI ENTRO LIST != 0");
                                        Iterator itt = list.iterator();
                                        while (itt.hasNext()) {

                                            Propietario propietarios = (Propietario) itt.next();
                                            propietarios.setFecha_final(null);
                                            propietarios.setPorcentaje(100);
                                            model.actualizarPropietario(propietarios);
                                            //         System.out.println("SI ENTRO EN DESPUES DE ACT");
                                        }
                                    }
                                    model.eliminarPropietarioIndeterminado(propietario.getId_propietario());
                                }
                                Radicacion radicacion = model.consultarRadicacionPlacaTramite(numR, placa, tramite);
                                if (radicacion != null) {
                                    model.actualizarEstadoRadicacion(radicacion.getId_radicacion(), 9);
                                }
                            }

                            ;
                            break;
                        //Tramite de Segundo Traspaso
                        case 10:

                                ;
                            break;
                        case 12:

                            break;
                        //Tramite Inscripcion de Alerta
                        case 13:

                                ;
                            break;
                        //Tramite Levantamiento de Alerta
                        case 14:

                                ;
                            break;
                        //Tramite Cancelacion de Vehiculo
                        case 15:


                                ;
                            break;

                        //Tramite Cambio de Motor
                        case 17:

                                ;
                            break;
                        //Tramite Cambio de Carroceria
                        case 20:

                                ;
                            break;
                        //Tramite Cambio de Combustible
                        case 21:

                                ;
                            break;
                        //Tramite Cambio de Conjunto
                        case 22:

                                ;
                            break;
                        case 23:

                                ;
                            break;
                        //Tramite Regrabacion de Motor
                        case 24:


                                ;
                            break;
                        //Tramite Cambio de Chasis
                        case 25:

                                ;
                            break;
                        //Tramite Cambio de Serie
                        case 26:


                                ;
                            break;
                        //Tramite Inscripcion de Alerta
                        case 27:

                                ;
                            break;

                        case 32:


                                ;
                            break;

                    }
                    model.adicionarActoAdministrativo(actosA);
                    model.getCon().commit(); %>
<script language="javascript" type="text/javascript">
    alert("Revocatoria ha sido aprobado correctamente");
    window.parent.document.location.href = "actosAdministrativos.jsp";
</script>

<%      }
    }
} else {
    Vehiculo vehiculo = model.consultarVehiculo(placa.toUpperCase());
    if (vehiculo != null) {
        int modif = Integer.parseInt(request.getParameter("modif"));
        model.getCon().setAutoCommit(false);
        java.sql.Date fecha_actual = new java.sql.Date(new java.util.Date().getTime());
        Actos_Administrativos actosA = new Actos_Administrativos();
        actosA.setNUMERO(numA);
        actosA.setFECHA(fecha);
        actosA.setFECHA_PROCESO(fecha_actual);
        actosA.setESTADO(1);
        actosA.setFK_USUARIO(usuario.getId_usuario());
        actosA.setTIPO(tipo);
        actosA.setFK_VEHICULO(vehiculo.getId_vehiculo());
        Tramite tram = model.consultarTramite((long) tramite);
        if (tram != null) {
            actosA.setTRAMITE(tram.getNombre());
        }
        actosA.setOBSERVACIONES(observacion);
        Vehiculo veh = null;
        switch (modif) {
            case 1:

                veh = model.consultarVehiculo(placa.toUpperCase());
                int estado = Integer.parseInt(request.getParameter("estado"));
                model.actualizarEstadoVehiculo(veh.getId_vehiculo(), estado, 1);
                actosA.setTRAMITE("Modificacion Estado");
                ;
                break;
            case 2:
                veh = model.consultarVehiculo(placa.toUpperCase());
                int tipos = Integer.parseInt(request.getParameter("tipos"));
                //System.out.println(ti);
                Propietario propietario = model.getUnicoPropietarioVehiculo(veh.getId_vehiculo());
                Persona per = model.consultarPersona((int) tipos, request.getParameter("documento").toString());
                model.UpdatePropietario(veh.getId_vehiculo(), per.getId_persona(), propietario.getFk_persona());
                actosA.setTRAMITE("Modificacion Propietario");
                ;
                break;
            case 3:

                veh = model.consultarVehiculo(placa.toUpperCase());
                int est = Integer.parseInt(request.getParameter("estado"));
                // model.actualizarEstadoVehiculo(veh.getId_vehiculo(),est,1);

                //javax.swing.JOptionPane.showMessageDialog(null, ". _ . " + est);
                model.UpdateLineas(vehiculo.getId_vehiculo(), (long) est);
                ;
                break;
            case 4:
                veh = model.consultarVehiculo(placa.toUpperCase());
                int est1 = Integer.parseInt(request.getParameter("estado"));
                // model.actualizarEstadoVehiculo(veh.getId_vehiculo(),est,1);

                actosA.setTRAMITE("Modificacion Cilindraje");
                //javax.swing.JOptionPane.showMessageDialog(null, ". _ . " + est);
                model.UpdateCilindraje(vehiculo.getId_vehiculo(), (long) est1);

                ;
                break;
            case 5:
                veh = model.consultarVehiculo(placa.toUpperCase());
                actosA.setTRAMITE("Modificacion Linea");

                ;
                break;

        }
        model.adicionarActoAdministrativo(actosA);
        model.getCon().commit();
%>
<script language="javascript" type="text/javascript">
    alert("Modificacion Realizada correctamente");
    //window.parent.document.location.href = "actosAdministrativos.jsp";
</script>

<%
        }
    } /// --
} catch (Exception excw) {
    excw.printStackTrace();
    model.getCon().rollback();
    if (tipo == 1) {
%>
<script language="javascript" type="text/javascript">
    alert("Revocatoria no pudo ser aprobada \n Error: <%=excw.getMessage()%>");
    window.parent.document.location.href = "actosAdministrativos.jsp";
</script>


<% } else {
%>
<script language="javascript" type="text/javascript">
    alert("Modificacion no pudo ser aprobada");
    window.parent.document.location.href = "actosAdministrativos.jsp";
</script>


<%
        }
    }%>
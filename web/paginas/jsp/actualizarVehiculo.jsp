<%--
    Document   : actualizar_vehiculo
    Created on : 23-feb-2010, 14:42:38
    Author     : Jorge Lopez
    Modificado :Ricardo Cantillo 22/ene/2013
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*, java.sql.Date,java.util.Calendar,java.util.Enumeration"%>

<%
            try {
                if (session.getAttribute("model") != null) {
                    boolean permisoA = ((java.util.LinkedList) session.getAttribute("permisosU")).contains("editarDatosVehiculo.jsp");
%>
<%
                    Model modelo = (Model) session.getAttribute("model");
                    Vehiculo vehiculo = (Vehiculo) session.getAttribute("vehiculo");
                    Movimiento movimiento = modelo.ConsultarMovimientoVehiculo(vehiculo.getId_vehiculo());
                    Usuario usuario = (Usuario) session.getAttribute("usuario");


                    try {
                        if (permisoA) {
                            long modelo_vehiculo = 1901;
                            if (request.getParameter("modelo").length() != 0) {
                                modelo_vehiculo = Long.parseLong(request.getParameter("modelo"));
                            }
                            if (request.getParameter("lineas") != null && request.getParameter("clases") != null && request.getParameter("tipoServicio") != null) {
                                long fk_linea = Long.parseLong(request.getParameter("lineas"));
                                long clase_vehiculo = Long.parseLong(request.getParameter("clases"));
                                long servicio = Long.parseLong(request.getParameter("tipoServicio"));
                                long estado = Long.parseLong(request.getParameter("estado"));
                                String ltransito = request.getParameter("ltransito");
                                java.sql.Date ftransito = null;
                                if (!request.getParameter("ftransito").isEmpty()) {
                                    ftransito = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("ftransito")).getTime());
                                }

                                long tipo_doc_importacion = Long.parseLong(request.getParameter("tiposimpor"));
                                long tipo_importacion = Long.parseLong(request.getParameter("tipoImportacion"));
                                String documento_importacion = request.getParameter("documentoimp");

                                java.sql.Date fecha_matricula = null;
                                if (!request.getParameter("fecha_mat").isEmpty()) {
                                    fecha_matricula = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_mat")).getTime());
                                }


                                java.sql.Date fecha_importacion = null;
                                if (!request.getParameter("fechadocumento").isEmpty()) {
                                    fecha_importacion = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechadocumento")).getTime());
                                }

                                long depto = 0;
                                long mncipio = 0;
                                if (!request.getParameter("departamentos").isEmpty()) {
                                    depto = Long.parseLong(request.getParameter("departamentos"));
                                }
                                if (!request.getParameter("ciudades").isEmpty()) {
                                    mncipio = Long.parseLong(request.getParameter("ciudades"));
                                }

                                Divipo divipo = modelo.consultarDvipo(depto, mncipio);

                                if (ltransito.length() > 0 && ftransito != null && permisoA) {
                                    Licencia_Transito licenciaTransito = modelo.consultarLicenciaTransito(vehiculo.getId_vehiculo());
                                    if (licenciaTransito != null) {
                                        licenciaTransito.setNumero(ltransito);
                                        licenciaTransito.setFecha_expedicion(ftransito);
                                        modelo.actualizarLicenciaTransito(licenciaTransito);
                                    } else {
                                        licenciaTransito = new Licencia_Transito();
                                        licenciaTransito.setEstado(1);
                                        licenciaTransito.setFecha_expedicion(ftransito);
                                        licenciaTransito.setFk_sede(vehiculo.getFk_sede());
                                        licenciaTransito.setFk_usuario(usuario.getId_usuario());
                                        licenciaTransito.setFk_vehiculo(vehiculo.getId_vehiculo());
                                        licenciaTransito.setNumero(ltransito);
                                        modelo.asociarLicenciaTransito(licenciaTransito);
                                    }
                                }

                                if(!request.getParameter("textfield").isEmpty()){
                                    String placa = request.getParameter("textfield");
                                    placa.trim();
                                    if(placa.length()>1 && placa.length()<=6){
                                        Vehiculo v = modelo.consultarVehiculo(placa);
                                        if(v==null){
                                            vehiculo.setPlaca(placa);
                                        }
                                    }
                                }

                                vehiculo.setFk_linea(fk_linea);
                                vehiculo.setClase_vehiculo(clase_vehiculo);
                                vehiculo.setServicio(servicio);
                                vehiculo.setEstado(estado);
                                vehiculo.setModelo(modelo_vehiculo);
                                vehiculo.setTipo_doc_importacion(tipo_doc_importacion);
                                vehiculo.setTipo_importacion(tipo_importacion);
                                vehiculo.setDocumento_importacion(documento_importacion);
                                vehiculo.setUsuario(usuario.getId_usuario());
                                if (!request.getParameter("fecha_mat").isEmpty()) {
                                    vehiculo.setFecha_matricula(fecha_matricula);
                                }

                                if (!request.getParameter("fechadocumento").isEmpty()) {
                                    vehiculo.setFecha_importacion(fecha_importacion);
                                }
                                if (divipo != null) {
                                    vehiculo.setFk_divipo(divipo.getId_divipo());
                                }

                                modelo.editarVehiculo(vehiculo, 1);
                            }
                        }

                        if (movimiento != null && (permisoA || modelo.tienePermiso(usuario.getId_usuario(), 137))) {

                            int estado_envio = 1;
                            if (request.getParameter("mov_estado") != null) {
                                if (request.getParameter("mov_estado").length() != 0) {
                                    estado_envio = Integer.parseInt(request.getParameter("mov_estado"));
                                }
                            }

                            java.sql.Timestamp fecha_envio = null;

                            if (request.getParameter("mov_fecha_env") != null) {
                                if (!request.getParameter("mov_fecha_env").isEmpty()) {
                                    fecha_envio = new java.sql.Timestamp(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("mov_fecha_env")).getTime());
                                }
                            }



                            java.sql.Timestamp fecha_movimiento = null;
                            if (request.getParameter("mov_fecha") != null) {
                                if (!request.getParameter("mov_fecha").isEmpty()) {
                                    fecha_movimiento = new java.sql.Timestamp(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("mov_fecha")).getTime());
                                }
                            }

                            long mov_fk_sede = 0;
                            if (request.getParameter("mov_sedes") != null) {
                                mov_fk_sede = Long.parseLong(request.getParameter("mov_sedes"));
                            }

                            String numero_guia = request.getParameter("mov_numeroguia");
                            String numero_liecncia = request.getParameter("mov_numeroLicencia");
                            String responsable_envio = request.getParameter("mov_respenvio");

                            movimiento.setEstado_envio(estado_envio);
                            out.print(estado_envio);

                            if (request.getParameter("mov_fecha_env") != null) {
                                if (!request.getParameter("mov_fecha_env").isEmpty()) {
                                    movimiento.setFecha_envio(fecha_envio);
                                }
                            }

                            if (request.getParameter("mov_fecha") != null) {
                                if (!request.getParameter("mov_fecha").isEmpty()) {
                                    movimiento.setFecha_movimiento(fecha_movimiento);
                                }
                            }

                            movimiento.setFk_sede(mov_fk_sede);
                            movimiento.setNumero_guia(numero_guia);
                            movimiento.setNumero_licencia(numero_liecncia);
                            movimiento.setResponsable_envio(responsable_envio);

                            modelo.actualizarMovimientoVehiculo(movimiento);
                        }

                        modelo.getCon().commit();
%>
<jsp:forward page="verDatosVehiculo.jsp?id=1">
    <jsp:param name="msg" value="Vehiculo actualizado correctamente"></jsp:param>
</jsp:forward>
<% } catch (Exception Error) {
                        Error.printStackTrace();%>
<jsp:forward page="verDatosVehiculo.jsp?id=1">
    <jsp:param name="msg" value="No pudo ser actualizado el vehiculo"></jsp:param>
</jsp:forward>
<% }
                } else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%    }
            } catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%            }%>
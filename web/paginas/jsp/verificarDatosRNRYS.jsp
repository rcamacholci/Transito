<%@page import="java.sql.Timestamp"%>
<%@ page  import="modelo.Vehiculo" import="modelo.*" import = "java.util.HashMap"%>
<%
    Model model = null;
    String mensajeRunt = "";
    String placaRNRYS = request.getParameter("placaRNRYS").toUpperCase();

    try {
        model = (Model) session.getAttribute("model");
        modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
        modelo.UsuarioRunt userRunt = model.consultarUsuarioRunt(usuario.getId_usuario());

        boolean paso = false;
        session.removeAttribute("informacionRNRYS");

        System.out.println("inicio verificando RNRYS");
        if (model != null) {
            webservices.consultas.ServicioConsultaRUNTClient consultasService = new webservices.consultas.ServicioConsultaRUNTClient();
            consultasService.setTokenHuellaDigital("");
            consultasService.setUser(userRunt.getCodigo());
            if (session.getAttribute("token2") != null) {
                consultasService.setTokenHuellaDigital(session.getAttribute("token2").toString());
            }
            com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO automotor = new com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO();

            //   if (request.getParameter("placaRNRYS") != null) {
            //       if (request.getParameter("placaRNRYS").trim().length() > 0) {
            //           automotor.setNumeroPlaca(request.getParameter("placaRNRYS"));
            //       }
            //   }
            if (request.getParameter("serie") != null) {
                if (request.getParameter("serie").trim().length() > 0) {
                    automotor.setNumeroSerie(request.getParameter("serie"));
                }
            }

            if (request.getParameter("vin") != null) {
                if (request.getParameter("vin").trim().length() > 0) {
                    automotor.setNumeroVIN(request.getParameter("vin"));
                }
            }

            com.heinsohn.runt.general.consultas.DetalleAutomotorOutDTO detalleAutomotorOut = consultasService.consultarVehiculosMCSV(automotor, userRunt.getCodigo(), userRunt.getPassword());

            System.out.println("verificando RNRYS --- 1");
            paso = true;

            if (detalleAutomotorOut != null) {
                System.out.println("Encontro automotor");
                com.heinsohn.runt.general.identificaciones.StatusDTO status = detalleAutomotorOut.getStatus().getValue();
                if (status != null) {
                    System.out.println("Estado Automotor: " + status.getStatusCode());
                    if (status.getStatusCode().equals("1")) {
                        java.util.List<com.heinsohn.runt.general.consultas.DetalleAutomotorDTO> listaAutomotor = detalleAutomotorOut.getAutomotores();
                        if (listaAutomotor != null) {
                            for (int i = 0; i < listaAutomotor.size(); i++) {
                                com.heinsohn.runt.general.consultas.DetalleAutomotorDTO detalleAutomotor = listaAutomotor.get(i);
                                if (detalleAutomotor != null) {
                                    System.out.println("PLACA: " + placaRNRYS);
                                    System.out.println("Clase:" + detalleAutomotor.getClase());
                                    System.out.println("Estado: " + detalleAutomotor.getEstado());
                                    System.out.println("Linea: " + detalleAutomotor.getLinea());
                                    System.out.println("Marca: " + detalleAutomotor.getMarca());
                                    System.out.println("Modelo: " + detalleAutomotor.getModelo());
                                    System.out.println("Acta importacion: " + detalleAutomotor.getNumeroActaImportacion());
                                    System.out.println("Motor: " + detalleAutomotor.getIdentificador().getNumeroMotor());
                                    System.out.println("Chasis " + detalleAutomotor.getIdentificador().getNumeroChasis());
                                    System.out.println("Serie " + detalleAutomotor.getIdentificador().getNumeroSerie());
                                    System.out.println("Vin: " + detalleAutomotor.getIdentificador().getNumeroVIN());

                                    if (detalleAutomotor.getClase().equals("24") || detalleAutomotor.getClase().equals("41")) {
                                        if (detalleAutomotor.getEstado().equals("REGISTRADO")) {
                                            model.getCon().setAutoCommit(false);
                                            Preasignacion preasignacion = model.consultarPreasignacionRNRYS(detalleAutomotor.getIdentificador().getNumeroVIN());
                                            if (preasignacion == null) {
                                                try {
                                                    Timestamp fecha = new java.sql.Timestamp(new java.util.Date().getTime());
                                                    Preasignacion p = new Preasignacion();
                                                    p.setPlaca(placaRNRYS);
                                                    p.setMotor(detalleAutomotor.getIdentificador().getNumeroMotor());
                                                    p.setChasis(detalleAutomotor.getIdentificador().getNumeroChasis());
                                                    p.setSerie(detalleAutomotor.getIdentificador().getNumeroSerie());
                                                    p.setVin(detalleAutomotor.getIdentificador().getNumeroVIN());
                                                    p.setClase(Integer.parseInt(detalleAutomotor.getClase()));
                                                    p.setEstado(1);
                                                    p.setServicio(1);
                                                    p.setFecha(fecha);
                                                    p.setMarca(Integer.parseInt(detalleAutomotor.getMarca()));
                                                    p.setLinea(Integer.parseInt(detalleAutomotor.getLinea()));
                                                    p.setModelo(Integer.parseInt(detalleAutomotor.getModelo()));
                                                    p.setActaImportacion(detalleAutomotor.getNumeroActaImportacion());
                                                    p.setEstadoAutomotor(detalleAutomotor.getEstado());
                                                    p.setFk_usuario(usuario.getId_usuario());

                                                    model.adicionarPreasignacion(p);
                                                    model.getCon().commit();
                                                    paso = true;
                                                } catch (Exception ex) {
                                                    paso = false;
                                                    model.getCon().rollback();
                                                    ex.printStackTrace();
                                                }
                                            } else {
                                                paso = true;
                                            }
                                        } else if (detalleAutomotor.getEstado().equals("ACTIVO")) {
                                            paso = true;
                                        } else {
                                            mensajeRunt = "Estado del Automotor diferente de REGISTRADO";
                                        }
                                    } else {
                                        mensajeRunt = "La clase del vehiculo no Corresponde con la Radicacion RNRYS";
                                    }
                                    session.setAttribute("informacionRNRYS", detalleAutomotor);
                                } else {
                                    mensajeRunt = "No se encontraron datos 1";
                                    out.println("Alerta: " + mensajeRunt);
                                }
                            }

                        } else {
                            mensajeRunt = "No se encontraron datos 2";
                            out.println("Alerta: " + mensajeRunt);
                        }
                    } else if (status.getStatusCode().equals("2")) {
                        paso = true;
                    } else {
                        out.println("No se encontraron datos relacionados al numero de identificación: " + placaRNRYS);
                        out.println("Alerta: " + status.getStatusDesc());
                    }
                } else {
                    out.println("Ha ocurrido un error en la consulta de la radicación RNRYS, intente nuevamente");
                }
            } else {
                System.out.println("No encontro automotor");
                mensajeRunt = "No se pudo acceder al servicio WEB";
                out.println("Alerta: " + mensajeRunt);
            }
        }

        if (paso) {
%><script>window.location.href = "seleccionTramites.jsp?rn=5&placaRN=" + '<%=placaRNRYS%>'</script><%
} else {
%><script>alert('<%=mensajeRunt%>'); document.location.href = "consultarGuarismosRNRYS.jsp";</script><%
        }

        System.out.println("fin verificando RNRYS");
    } catch (Exception exc) {
        exc.printStackTrace();
        mensajeRunt = "Se ha producido una excepcion :" + exc.getMessage();
        out.println(mensajeRunt);
    }%>
</root>


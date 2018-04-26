<%@page import="java.util.List"%>
<%@page import="com.heinsohn.runt.general.consultas.AutomotorOutDTO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page  import="modelo.Vehiculo" import="modelo.*" import = "java.util.HashMap"%>
<%
    Model model = null;
    String mensajeRunt = "";
    String placaRNMA = "";

    try {
        model = (Model) session.getAttribute("model");
        modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
        modelo.UsuarioRunt userRunt = model.consultarUsuarioRunt(usuario.getId_usuario());

        boolean paso = false;
        session.removeAttribute("informacionRNMA");

        System.out.println("inicio verificando RNMA");
        if (model != null) {
            webservices.consultas.ServicioConsultaRUNTClient consultasService = new webservices.consultas.ServicioConsultaRUNTClient();
            consultasService.setTokenHuellaDigital("");
            consultasService.setUser(userRunt.getCodigo());
            if (session.getAttribute("token2") != null) {
                consultasService.setTokenHuellaDigital(session.getAttribute("token2").toString());
            }
            com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO automotor = new com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO();

            if (request.getParameter("placaRNMA") != null) {
                if (request.getParameter("placaRNMA").trim().length() > 0) {
                    automotor.setNumeroPlaca(request.getParameter("placaRNMA"));
                }
            }

            if (request.getParameter("motor") != null) {
                if (request.getParameter("motor").trim().length() > 0) {
                    automotor.setNumeroMotor(request.getParameter("motor"));
                }
            }

            if (request.getParameter("chasis") != null) {
                if (request.getParameter("chasis").trim().length() > 0) {
                    automotor.setNumeroChasis(request.getParameter("chasis"));
                }
            }

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
            System.out.println("verificando RNMA --- 1");
            if (detalleAutomotorOut != null) {
                System.out.println("Encontro automotor");
                com.heinsohn.runt.general.identificaciones.StatusDTO status = detalleAutomotorOut.getStatus().getValue();
                System.out.println("Estado Automotor: " + status.getStatusCode());
                if (status.getStatusCode().equals("1")) {
                    java.util.List<com.heinsohn.runt.general.consultas.DetalleAutomotorDTO> listaAutomotor = detalleAutomotorOut.getAutomotores();
                    if (listaAutomotor != null) {
                        for (int i = 0; i < listaAutomotor.size(); i++) {
                            com.heinsohn.runt.general.consultas.DetalleAutomotorDTO detalleAutomotor = listaAutomotor.get(i);
                            if (detalleAutomotor != null) {
                                placaRNMA = detalleAutomotor.getIdentificador().getNumeroPlaca();
                                AutomotorOutDTO auto = consultasService.consultarDatosAutomotor(placaRNMA, "", "", "", "", userRunt.getCodigo(), userRunt.getPassword());
                                session.setAttribute("RuntRnma", auto);
                                System.out.println("Identificacion: " + detalleAutomotor.getIdentificador().getNumeroPlaca());
                                System.out.println("Clase:" + detalleAutomotor.getClase());
                                System.out.println("Estado: " + detalleAutomotor.getEstado());
                                System.out.println("Linea: " + detalleAutomotor.getLinea());
                                System.out.println("Marca: " + detalleAutomotor.getMarca());
                                System.out.println("Modelo: " + detalleAutomotor.getModelo());
                                System.out.println("Acta importacion: " + detalleAutomotor.getNumeroActaImportacion());
                                webservices.consultas.ServicioConsultaRUNTClient consultaService = new webservices.consultas.ServicioConsultaRUNTClient();

                                for (Parametro parametro : (List<Parametro>) model.listadoParametros(1)) {
                                    
                                    if (parametro.getNombreCorto().equals("4") && (parametro.getCodigo() + "").equals(detalleAutomotor.getClase())) {
                                        paso = true;
                                        break;
                                    }
                                }

                                if (!paso) {
                                    mensajeRunt = "La clase del vehiculo no Corresponde con la Radicacion RNMA";
                                }

                                session.setAttribute("informacionRNMA", detalleAutomotor);
                            } else {
                                mensajeRunt = "Automotor no encontrado";
                            }
                        }

                    } else {
                        mensajeRunt = "No se encontraron datos 2";
                    }
                } else {
                    mensajeRunt = "No se encontraron datos relacionados - Runt: " + status.getStatusDesc();
                }
            } else {
                System.out.println("No encontro automotor");
                mensajeRunt = "No se pudo acceder al servicio WEB";
            }
        }
        //paso =true;
        //placaRNMA = "MA000001";
        if (paso) {
%><script>window.location.href = "seleccionTramites.jsp?rn=4&placaRN=<%=placaRNMA%>"</script><%
} else {
%><script>alert('<%=mensajeRunt%>');
    document.location.href = "consultarGuarismosRNMA.jsp";</script><%
        }

        System.out.println("fin verificando RNMA");
    } catch (Exception exc) {
        exc.printStackTrace();
        mensajeRunt = "Se ha producido una excepcion :" + exc.getMessage();
    %><script>alert('<%=mensajeRunt%>');
        document.location.href = "consultarGuarismosRNMA.jsp";</script><%
            }%>
</root>


<%@ page import="modelo.* " %>
<%
    Model model = (Model) session.getAttribute("model");
    try {

        Usuario usuario = (Usuario) session.getAttribute("usuario");
        webservices.consultas.ServicioConsultaRUNTClient consultaService = new webservices.consultas.ServicioConsultaRUNTClient();
        consultaService.setTokenHuellaDigital(Model.userToken);
        consultaService.setUser(Model.userHandler);

        model.getCon().setAutoCommit(false) ;
        java.util.List<String> listaPlacas = model.obtenerRangoPlacas();
        for (String placa : listaPlacas) {
            com.heinsohn.runt.general.consultas.AutomotorOutDTO automotor = consultaService.consultarDatosAutomotor(placa.toUpperCase(), null, null, null, null);
            if (automotor != null) {
                if (automotor.getStatus() != null) {
                    if (automotor.getStatus().getStatusCode().equals("1")) {

                        javax.xml.bind.JAXBElement<com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO> idv = automotor.getAutomotor().getValue().getIdentificador();

                        if(idv!=null){
                            if(idv.getValue()!=null){
                                MCSVRunt mcsvRunt = new MCSVRunt();
                                mcsvRunt.setPlaca(idv.getValue().getNumeroPlaca());
                                mcsvRunt.setMarca(idv.getValue().getIdMarca()!=null?(idv.getValue().getIdMarca().getValue()):"");
                                mcsvRunt.setMotor(idv.getValue().getNumeroMotor());
                                mcsvRunt.setChasis(idv.getValue().getNumeroChasis());
                                mcsvRunt.setSerie(idv.getValue().getNumeroSerie());
                                mcsvRunt.setVin(idv.getValue().getNumeroVIN());
                                //Se adiciona el VehiculoRunt.
                                String added = model.addMCSVRunt(mcsvRunt);
                                System.out.println("PLACA    " + placa + "   " + added);
                                model.getCon().commit();
                            }
                        }

                    } else {
                        System.out.println("DEsc Status " +placa+" - "+ automotor.getStatus().getStatusDesc());
                    }
                } else {
                    System.out.println("Estatus == " + null);
                }
            } else {
                System.out.println("Automotor es null");
            }
        }
        model.getCon().commit();
    } catch (Exception ecx) {
        ecx.printStackTrace();
        model.getCon().rollback();
    }%>

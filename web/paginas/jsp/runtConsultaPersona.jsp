<%-- 
    Document   : runtConsultaPersona
    Created on : 31-ene-2012, 13:34:45
    Author     : dell
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"
        import="com.heinsohn.runt.general.personas.PersonaNaturalDTO" 
        import="com.heinsohn.runt.general.personas.DireccionDTO" 
        import="com.heinsohn.runt.general.consultas.PersonaNaturalOutDTO" 
        import="com.heinsohn.runt.general.consultas.PersonaJuridicaOutDTO" 
        import="com.heinsohn.runt.general.personas.PersonaJuridicaDTO" 
        import="java.util.List"
        import="java.util.LinkedList"
        import="modelo.*"%>
<%

    Model model = (Model) session.getAttribute("model");
    Usuario usuario = (Usuario) session.getAttribute("usuario");

    model.getCon().setAutoCommit(false);

    try {
        webservices.consultas.ServicioConsultaRUNTClient consultaService = new webservices.consultas.ServicioConsultaRUNTClient();
        consultaService.setTokenHuellaDigital(Model.userToken);
        consultaService.setUser(Model.userHandler);
        //String idP = request.getParameter("idP").toUpperCase();
        //System.out.println("IdPersona:    " + idP);
        List<String> list = model.obtenerIdsPropietarios();

        try {
            for (String idP : list) {
                PersonaNaturalOutDTO personaN = consultaService.consultarDatosPersonaNaturalByID(idP);
                boolean natural_juridico = true;
                if (personaN != null) {
                    if (personaN.getPersonaNatural() != null) {
                        if (personaN.getPersonaNatural().getValue() != null) {
                            if(personaN.getPersonaNatural().getValue().getIdentificacion()!=null){
                                if(personaN.getPersonaNatural().getValue().getIdentificacion().getValue()!=null){
                                    natural_juridico = false;
                                    PersonaNaturalDTO naturalDTO = personaN.getPersonaNatural().getValue();
                                    List<DireccionDTO> direcciones = naturalDTO.getDirecciones();

                                    String pAdded = model.addPersonaNaturalDTO(naturalDTO, 1,idP);
                                    System.out.println("AGREGAR PERSONA NATURAL  " + pAdded);

                                    if ( direcciones != null && direcciones.size()>0 ){
                                        DireccionDTO dir = direcciones.get(0);
                                        String dAdded = model.addDireccionDTO(dir, naturalDTO.getIdentificacion().getValue().getIdPersona());
                                        System.out.println("AGREGAR DIRECCION NATURAL  " + dAdded);
                                     }
                                }
                            }else {
                                System.out.println("IDENTIFICACION  NATURAL NULL");
                            }
                        } else {
                            System.out.println("VALUE  NATURAL NULL");
                        }
                    } else {
                        System.out.println("PERSONA NATURAL  NATURAL NULL");
                    }
                } else {
                    System.out.println("PERSONA  N NULL");
                }

                if (natural_juridico) {
                    PersonaJuridicaOutDTO personaJ = consultaService.consultarDatosPersonaJuridicaByID(idP);
                    if (personaJ != null) {
                        if (personaJ.getPersonaJuridica() != null) {
                            if (personaJ.getPersonaJuridica().getValue() != null) {
                                natural_juridico = false;
                                PersonaJuridicaDTO juridicaDTO = personaJ.getPersonaJuridica().getValue();
                                String pAdded = model.addPersonaJuridicaDTO(juridicaDTO, 2);
                                System.out.println("AGREGAR PERSONA JURIDICA  " + pAdded);
                            } else {
                                System.out.println("PERSONA JURIDICA VALUE NULL");
                            }
                        } else {
                            System.out.println("PERSONA JURIDICA NULL");
                        }
                    } else {
                        System.out.println("PERSONA J NULL");
                    }
                }
                
                model.getCon().commit() ;
            }
        } catch (Exception e) {
            model.getCon().rollback();
            e.printStackTrace();
        }

    } catch (Exception exc) {
        model.getCon().rollback();
        exc.printStackTrace();
    }
%>
<%@ page import="modelo.* "%>
<%
try {
    webservices.consultas.ServicioConsultaRUNTClient consultaService = new webservices.consultas.ServicioConsultaRUNTClient();
    consultaService.setTokenHuellaDigital(Model.userToken);
    consultaService.setUser(Model.userHandler);
    int cont = 0;
    String placa = request.getParameter("placa").toUpperCase();
System.out.println("FFFFF");
    while (cont < 3) {
        com.heinsohn.runt.general.consultas.AutomotorOutDTO automotor = consultaService.consultarDatosAutomotor(placa.toUpperCase(), null, null, null, null);
        System.out.println("AUTOMOTOR  " + automotor);
        if (automotor != null) {
            if (automotor.getStatus() != null) {
                if (automotor.getStatus().getStatusCode().equals("1")) {
                    String idp = automotor.getAutomotor().getValue().getPropietarios().get(0).getPersona().getValue().getIdPersona();
                    System.out.println("Carga:"+automotor.getAutomotor().getValue().getInformacion().getValue().getCapacidadCarga());
                    System.out.println("Modelo:"+automotor.getAutomotor().getValue().getModelo());
                    System.out.println("IdPersona: " + idp);
                    try {
                        System.out.println("Natural");
                        com.heinsohn.runt.general.consultas.PersonaNaturalOutDTO PERSONA = consultaService.consultarDatosPersonaNaturalByID(idp);
                        System.out.println(PERSONA.getPersonaNatural().getValue().getIdentificacion().getValue().getNumeroDocumento());
                    } catch (Exception cv) {
                        System.out.println("Juridica");
                        com.heinsohn.runt.general.consultas.PersonaJuridicaOutDTO PERSONA = consultaService.consultarDatosPersonaJuridicaByID(idp);
                        System.out.println(PERSONA.getPersonaJuridica().getValue().getIdentificacion().getNumeroDocumento());
                    }
                    break;
                } else {
                    break;
                }
            } else {
                cont++;
            }
        } else {
            cont++;
        }
    }
} catch (Exception ecx) {
    ecx.printStackTrace();
}%>

<?xml version="1.0" encoding="UTF-8"?>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<%     try{
        Model model = new Model();
        model.conectar();
        Usuario usuario = (Usuario)session.getAttribute("usuario");
        UsuarioRunt userRunt = model.consultarUsuarioRunt(usuario.getId_usuario());


System.out.println("estoy en verificar estado  token INICIO SESION");
    if (!request.getParameter("token").equals(null)){
         webservices.consultas.ServicioConsultaRUNTClient consultasService = new webservices.consultas.ServicioConsultaRUNTClient();
        consultasService.setTokenHuellaDigital(request.getParameter("token"));
       // consultasService.setUser("1045675127");
        System.out.println("Token verificar : "+request.getParameter("token"));
        String trama = "";
        consultasService.setUser(userRunt.getCodigo());
        com.heinsohn.runt.general.consultas.PersonaNaturalOutDTO personaNaturalOut = consultasService.consultarDatosPersonaNatural("C", "1045675127");
        String respuesta = "";
            if(personaNaturalOut!=null){
                if(personaNaturalOut.getStatus()!=null){
                      if(personaNaturalOut.getStatus().getStatusCode().equals("1")){
                          javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.PersonaNaturalDTO> jaxbPersonaNatural = personaNaturalOut.getPersonaNatural();
                           com.heinsohn.runt.general.personas.PersonaNaturalDTO personaNatural = jaxbPersonaNatural.getValue();
                           if(personaNatural!=null){
                               if(personaNatural.getEstadoPersona().equals("ACTIVA")){
                                   System.out.println("Verificacion : "+personaNatural.getPrimerNombrePersona()+" "+personaNatural.getPrimerApellidoPersona());
                                    respuesta = "TOKEN OK";
                                    trama = request.getParameter("token");
                                     session.removeAttribute("token2");
                                     session.setAttribute("token2",trama);
                                    %>
                                     <result>1</result>
                            <%   }
                           }
                      }
                 }
            }else{
                respuesta = "NO SE PUDO ACCEDER AL SERVICIO";
                 %>
                                     <result>2</result>
                            <%
            }
         System.out.println("Respuesta : "+respuesta);
       }else{
            System.out.println("Campos vacios");   %>
                      <result>2</result>
          <% }

          }catch(Exception e){
              e.printStackTrace();
              }
          %>
</root>
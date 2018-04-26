<?xml version="1.0" encoding="ISO-8859-1"?>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" %>
<root>
<%
modelo.Model model= (modelo.Model)session.getAttribute("model");
modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
modelo.UsuarioRunt userRunt = model.consultarUsuarioRunt(usuario.getId_usuario());
int estadoN = -1;
int estadoT = -1;
int estadoF = -1;
String datoN = "";
String datoT = "";
String datoF = "";
try{
    if (!request.getParameter("numeroDocumento").isEmpty()){
        int tipoD = Integer.parseInt(request.getParameter("tipoDocumento"));
        String tipoDocumento = model.consultarParametro(tipoD,5).getNombreCorto();
        String numeroDocumento = request.getParameter("numeroDocumento").trim();
        webservices.consultas.ServicioConsultaRUNTClient consultasService = new webservices.consultas.ServicioConsultaRUNTClient();
        consultasService.setTokenHuellaDigital("");
        consultasService.setUser(userRunt.getCodigo());
        modelo.Model.userHandler = userRunt.getCodigo();
        modelo.Model.passUserHandler = userRunt.getPassword();

      if(session.getAttribute("token2")!=null){
        consultasService.setTokenHuellaDigital(session.getAttribute("token2").toString());

        com.heinsohn.runt.general.consultas.PersonaNaturalOutDTO personaNaturalOut = consultasService.consultarDatosPersonaNatural(tipoDocumento, numeroDocumento);

        if(personaNaturalOut!=null){
            if(personaNaturalOut.getStatus()!=null){
                if(personaNaturalOut.getStatus().getStatusCode().equals("1")){
                    javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.PersonaNaturalDTO> jaxbPersonaNatural = personaNaturalOut.getPersonaNatural();
                    com.heinsohn.runt.general.personas.PersonaNaturalDTO personaNatural = jaxbPersonaNatural.getValue();
                    if(personaNatural!=null){
                        String nombre_1 = personaNatural.getPrimerNombrePersona()!=null?personaNatural.getPrimerNombrePersona():"";
                        String nombre_2 = personaNatural.getSegundoNombrePersona()!=null?personaNatural.getSegundoNombrePersona():"";
                        String apellido_1 = personaNatural.getPrimerApellidoPersona()!=null?personaNatural.getPrimerApellidoPersona():"";
                        String apellido_2 = personaNatural.getSegundoApellidoPersona()!=null?personaNatural.getSegundoApellidoPersona():"";
                        int dia = personaNatural.getFechaNacimientoPersona()!=null?personaNatural.getFechaNacimientoPersona().getDay():0; 
                        int mes = personaNatural.getFechaNacimientoPersona()!=null?personaNatural.getFechaNacimientoPersona().getMonth():0;
                        int ano = personaNatural.getFechaNacimientoPersona()!=null?personaNatural.getFechaNacimientoPersona().getYear():0;
                        String fechaN = ""+dia+"/"+mes+"/"+ano;
                        String GS = personaNatural.getGrupoSanguineoPersona()!=null?personaNatural.getGrupoSanguineoPersona():"";
                        if(personaNatural.getEstadoPersona().equals("ACTIVA")){
                             modelo.Persona persona = model.consultarPersona(tipoD,numeroDocumento);
                             if(persona==null){
                                persona = new modelo.Persona();
                                persona.setNombre_1(nombre_1);
                                if(nombre_2.trim().length()>0)
                                    persona.setNombre_2(nombre_2);
                                persona.setApellido_1(apellido_1);
                                if(apellido_2.trim().length()>0)
                                    persona.setApellido_2(apellido_2);
                                persona.setTipo_documento(tipoD);
                                persona.setDocumento(numeroDocumento);
                                long idPersona = model.adicionarPersona(persona);
                                model.getCon().commit();
                                persona.setId_persona(idPersona);
                             }
                             datoN = nombre_1+" "+nombre_2+" "+apellido_1+" "+apellido_2+"     Fecha N : "+fechaN+"   Grupo S : "+GS;
                             estadoN = 1;
                             estadoF = 1;
                             estadoT = 1;
                        }else{
                            estadoN = 0;
                        }
                    }
                }else{
                    estadoN = 0;
                }
           }
        }
      }else{
       estadoN = 3;
      }
    }
}catch(Exception exc){
    exc.printStackTrace();
}
%>
<respuesta>
    <estadoN><%=estadoN%></estadoN>
    <datoN><%=datoN%></datoN>
    <estadoT><%=estadoT%></estadoT>
    <estadoF><%=estadoF%></estadoF>
   </respuesta>
</root>
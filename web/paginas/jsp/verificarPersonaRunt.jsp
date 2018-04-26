<%@ page import="modelo.Model" %>
<%
    String result = "NO_ACCESO";
    try {
        if(request.getParameter("tipo")!=null&&request.getParameter("documento")!=null){
            if(!request.getParameter("tipo").equals("")&&!request.getParameter("documento").equals("")){
                Model model = (Model)session.getAttribute("model");
                webservices.consultas.ServicioConsultaRUNTClient consultasServices = new webservices.consultas.ServicioConsultaRUNTClient();
                consultasServices.setTokenHuellaDigital(Model.userToken);
                consultasServices.setUser(Model.userHandler);
                String nameT = model.consultarParametro(Integer.parseInt(request.getParameter("tipo")), 5).getNombreCorto();
                for(int i=0;i<3;i++){
                    com.heinsohn.runt.general.consultas.PersonaNaturalOutDTO person = consultasServices.consultarDatosPersonaNatural(nameT, request.getParameter("documento"));
                    if(person!=null){
                        if(person.getStatus()!=null){
                            if(person.getStatus().equals("1")){
                                if(person.getPersonaNatural().getValue().getEstadoPersona().equals("ACTIVA")){
                                    result = "SI_EXISTE";
                                }else{
                                    result = "NO_EXISTE";
                                }
                            }else{
                                result = "NO_EXISTE";
                            }
                        }else{
                            result = "NO_EXISTE";
                        }
                    }else{
                        result = "NO_ACCESO";
                    }
                    if(!result.equals("NO_ACCESO"))
                        break;
                }
                out.print(result);
            }
        }
    } catch (Exception exc) {
        exc.printStackTrace();
        out.println(exc.getMessage());
    }
%>



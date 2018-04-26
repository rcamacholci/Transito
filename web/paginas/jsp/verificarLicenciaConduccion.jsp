<%@ page import="modelo.Model" %>
<%
    String result = "NO_ACCESO";
    try {
          Model model = (Model)session.getAttribute("model");
                 modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                 modelo.UsuarioRunt userRunt = model.consultarUsuarioRunt(usuario.getId_usuario());

        if(request.getParameter("numero")!=null){
            if(!request.getParameter("numero").equals("")){
                webservices.consultas.ServicioConsultaRUNTClient consultasService = new webservices.consultas.ServicioConsultaRUNTClient();
                consultasService.setTokenHuellaDigital("");
                consultasService.setUser(userRunt.getCodigo());

                  if(session.getAttribute("token2")!=null){
                             consultasService.setTokenHuellaDigital(session.getAttribute("token2").toString());
                        }
                for(int i=0;i<3;i++){
                    com.heinsohn.runt.general.consultas.ConductorOutDTO datosConductor = consultasService.consultarDatosConductor(null, null, request.getParameter("numero").trim());
                    if(datosConductor!=null){
                        if(datosConductor.getStatus()!=null){
                            if(datosConductor.getStatus().getStatusCode().equals("1")){
                                result = "SI_EXISTE";
                                break;
                            }else{
                                result = "NO_EXISTE";
                                break;
                            }
                        }
                    }
                }
                out.print(result);
            }
        }
    } catch (Exception exc) {
        exc.printStackTrace();
        out.println(exc.getMessage());
    }
%>

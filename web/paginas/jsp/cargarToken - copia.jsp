<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<% Model model = (Model)session.getAttribute("model");

System.out.println("estoy en cargar TOKEN inicio");
Usuario usuario = (Usuario)session.getAttribute("usuario");
com.heinsohn.runt.general.consultas.PrevalidarTokenBiometricoOutDTO tokenOutDTO = new com.heinsohn.runt.general.consultas.PrevalidarTokenBiometricoOutDTO();
webservices.common.CommonServicesClient commonService = new webservices.common.CommonServicesClient();
    if (!request.getParameter("token").equals(null)&&!request.getParameter("usuario").equals(null) &&!request.getParameter("password").equals(null)){
        session.removeAttribute("token2");
        session.removeAttribute("usuarioRunt");
        session.removeAttribute("passRunt");
        commonService.setTokenHuellaDigital(request.getParameter("token"));
        commonService.setUser(request.getParameter("usuario"));
        Persona solicitante = model.consultarPersona(usuario.getFk_persona());
        String tipoDocumento = model.consultarParametro((int)solicitante.getTipo_documento(),5).getNombreCorto();
        String tipoPersona = "1";
        String trama =  request.getParameter("token");
        System.out.println("token 2 : "+trama);
        System.out.println("longitud token 2 : "+trama.length());
        String numeroDocumento = solicitante.getDocumento();
        String token2 = "";
        tokenOutDTO = commonService.prevalidarTokenBiometrico(tipoDocumento, numeroDocumento, tipoPersona, trama);
            if (tokenOutDTO!=null){
                  if(tokenOutDTO.getStatus()!=null){
                       //   if(tokenOutDTO.getStatus().getStatusCode().equals("1")){
                              if(tokenOutDTO.getRespuestaAutorizacion().size()>0){%>
                                   <script>
                                       alert('<%=tokenOutDTO.getStatus().getStatusDesc()%>');
                                   </script>
                            <%  com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO validacionCentralizada = null;
                                 java.util.List<com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO> list = tokenOutDTO.getRespuestaAutorizacion();
                                 java.util.Iterator it = list.iterator();
                                    while (it.hasNext()) {
                                        validacionCentralizada = (com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO)it.next();
                                        if(validacionCentralizada.isPrevalidacion()){
                                           token2 = validacionCentralizada.getTrama();
                                            session.setAttribute("token2",token2);
                                            session.setAttribute("usuarioRunt",request.getParameter("usuario"));
                                            session.setAttribute("passRunt",request.getParameter("password"));
                                            System.out.println("token valido");
                                            %>
                                                  <result>1</result>
                                            <%
                                        }else{
                                             System.out.println("token no valido");
                                             %>
                                                  <result>2</result>
                                            <%

                                        }
                                   }
                              }
                      //    }else{
                        //       System.out.println("error 1");
                         
                       //   }
                      }else{
                        %> <result>3</result> <%
                      }
            }else{
            %> <result>3</result> <%
            }
    
}else{
    %>
      <result>4</result>
            <% }%>

</root>
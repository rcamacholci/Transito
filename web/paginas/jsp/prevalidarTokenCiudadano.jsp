<?xml version="1.0" encoding="UTF-8"?>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<%     try{
        Model model = new Model();
        model.conectar();
        Usuario usuario = (Usuario)session.getAttribute("usuario");
        UsuarioRunt userRunt = model.consultarUsuarioRunt(usuario.getId_usuario());


System.out.println("estoy en prevalidar TOKEN Ciudadano");
    if (!request.getParameter("token").equals(null)&&!request.getParameter("tipoD").equals(null)&&!request.getParameter("numeroD").equals(null)){

        System.out.println("================))))))))))))))))");

        webservices.common.CommonServicesClient commonServices = new webservices.common.CommonServicesClient();
        commonServices.setTokenHuellaDigital("");
        System.out.println("================))))))))))))))))222222222222");
         if(session.getAttribute("token2")!=null){
             System.out.println("USUARIO Prevalidar Runt : "+userRunt.getCodigo());
             System.out.println("token Prevalidar Runt : "+session.getAttribute("token2").toString());
             commonServices.setTokenHuellaDigital(session.getAttribute("token2").toString());
         }
         //String trama = request.getParameter("token");
         String trama = "";
         System.out.println("================");
         String tipoDocumento = request.getParameter("tipoD");
         String numeroDocumento = request.getParameter("numeroD");
         commonServices.setUser(userRunt.getCodigo());
         Model.userHandler = userRunt.getCodigo();
         Model.passUserHandler = userRunt.getPassword();
        com.heinsohn.runt.general.consultas.PrevalidarTokenBiometricoOutDTO tokenOut = commonServices.prevalidarTokenBiometrico(tipoDocumento, numeroDocumento, "2", trama);
        int respuesta = 0;
            if(tokenOut!=null){
                if(tokenOut.getStatus()!=null){
                      if(tokenOut.getStatus().getStatusCode().equals("1")){
                           if(tokenOut.getRespuestaAutorizacion().size()>0){
                                com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO validacionCentralizada = null;
                                   java.util.List<com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO> list = tokenOut.getRespuestaAutorizacion();
                                   java.util.Iterator it = list.iterator();
                                    while (it.hasNext()) {
                                        validacionCentralizada = (com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO)it.next();
                                            if(validacionCentralizada.isPrevalidacion()){
                                               trama =  validacionCentralizada.getTrama();
                                               %> <result>1</result>
                                               <trama><%=trama%></trama>
                                                       <%
                                            }else{ %>
                                             <result>2</result>
                                            <% 
                                            }
                                       // System.out.println("token = "+trama);
                                    }
                                    
                               }else{ %>
                                <result>3</result>
                          <%     }
                           }else{
                           %>  <result>3</result> <%
                           }
                      }else{ %>
                     <result>3</result>
                  <%  }
                 
            }else{
              //  respuesta = -1;
                 %>
                                     <result>3</result>
                            <%
            }
       }else{
            System.out.println("Campos vacios");   %>
                      <result>3</result>
          <% }

          }catch(Exception e){
              e.printStackTrace();
              }
          %>
</root>
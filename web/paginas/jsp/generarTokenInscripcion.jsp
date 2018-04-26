<?xml version="1.0" encoding="UTF-8"?>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<% try{

Model model = (Model)session.getAttribute("model");
 Usuario usuario = (Usuario)session.getAttribute("usuario");
        UsuarioRunt userRunt = model.consultarUsuarioRunt2(usuario.getId_usuario());

System.out.println("estoy en generar TOKEN INSCRIPCION");
    if (!request.getParameter("tipoD").equals(null)&&!request.getParameter("documento").equals(null)&&!request.getParameter("tipo").equals(null)){
          com.heinsohn.runt.general.consultas.ConsultarTokenEnrolamientoBiometricoOutDTO validacionTokenOut = new com.heinsohn.runt.general.consultas.ConsultarTokenEnrolamientoBiometricoOutDTO();
           com.heinsohn.runt.general.consultas.ConsultarTokenValidacionBiometricaOutDTO validacionTokenAuteOut = new  com.heinsohn.runt.general.consultas.ConsultarTokenValidacionBiometricaOutDTO();
          webservices.common.CommonServicesClient commonService = new webservices.common.CommonServicesClient();
          commonService.setTokenHuellaDigital("Ing3n13r0J0h4nnGut13rr3zZ4mb4an0");
          commonService.setUser(userRunt.getCodigo());
          String tipoD = request.getParameter("tipoD");
          String documento = request.getParameter("documento");
          String trama = "";
          String biograficos = "NO";
          String huellas = "NO";
          String foto = "NO";
          String firma = "NO";
          int swFoto = 0,swHuella = 0;

          if(request.getParameter("tipo").equals("1")){
              if(request.getParameter("bidimen")!=null)
                biograficos = request.getParameter("bidimen").equals("1")?"SI":"NO";
              if(request.getParameter("huellas")!=null)
                huellas = request.getParameter("huellas").equals("1")?"SI":"NO";
              if(request.getParameter("foto")!=null)
                foto = request.getParameter("foto").equals("1")?"SI":"NO";
              if(request.getParameter("firma")!=null)
                firma = request.getParameter("firma").equals("1")?"SI":"NO";
          }else{
              if(request.getParameter("tipo").equals("2")){
                foto = "SI";
                swFoto = 1;
              }else{
                   if(request.getParameter("tipo").equals("3")){
                huellas = "SI";
                swHuella = 1 ;
              }
              }
          }

          if(!request.getParameter("tipo").equals("3")){
            validacionTokenOut = commonService.consultarParametroEnrolamientoBiometrico(tipoD, documento, biograficos, foto, huellas, firma);
                  if(validacionTokenOut!=null){ 
                     if(validacionTokenOut.getStatus()!=null){
                          if(validacionTokenOut.getStatus().getStatusCode().equals("1")){
                              if(validacionTokenOut.getToken()!=null){
                                 trama = validacionTokenOut.getToken();
                                 if(swFoto == 1){
                                 session.setAttribute("fotoSolicitante", trama); %>
                                   <tipoR>1</tipoR>
                              <%   }
                                 if(swHuella == 1){
                                    session.setAttribute("tokenSolicitante", trama); %>
                                  <tipoR>2</tipoR>
                                 <% }
                                 %>
                                  <result>1</result>
                                  <trama><%=trama%></trama>
                             <%   }else{   %>
                                <result>2</result>
                            <%   }
                          }else{
                               %> <result>2</result>  <%
                         }
                      }else{         %>    <result>2</result>    <%
                      }
                   }else{  %>  <result>2</result>   <%
                      }
            }else{

               validacionTokenAuteOut = commonService.consultarParametroValidacionBiometrica(tipoD, documento, "2");
                  if(validacionTokenAuteOut!=null){
                     if(validacionTokenAuteOut.getStatus()!=null){
                          if(validacionTokenAuteOut.getStatus().getStatusCode().equals("1")){
                               if(validacionTokenAuteOut.getRespuestaAutorizacion().size()>0){
                                    com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO validacionCentralizada = null;
                                    java.util.List<com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO> list = validacionTokenAuteOut.getRespuestaAutorizacion();
                                    java.util.Iterator it = list.iterator();
                                    while (it.hasNext()) {
                                        validacionCentralizada = (com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO)it.next();
                                        trama = validacionCentralizada.getTrama();
                                    }

                                 if(swHuella == 1){
                                    session.setAttribute("tokenSolicitante", trama); %>
                                  <tipoR>2</tipoR>
                                 <% }
                                 %>
                                  <result>1</result>
                                  <trama><%=trama%></trama>
                             <%   }else{   %>
                                <result>2</result>
                            <%   }
                          }else{
                               %> <result>2</result>  <%                }
                      }else{         %>    <result>2</result>    <%             }
                   }else{  %>  <result>2</result>   <%                     }



            }


             }else{       System.out.println("Campos vacios");   %>
                      <result>2</result>
          <% }
          }catch(Exception e){
            e.printStackTrace();
          }
          %>
</root> 
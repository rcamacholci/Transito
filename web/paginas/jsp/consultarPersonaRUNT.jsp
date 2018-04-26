<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelo.*" import="java.util.*"%>
<%
try{
    if(session.getAttribute("model")!=null){
        if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("adicionarPersona")||((java.util.LinkedList)session.getAttribute("permisosU")).contains("editarPersona")||((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarDatosRunt")||((java.util.LinkedList)session.getAttribute("permisosU")).contains("actualizarDatosRunt")||((java.util.LinkedList)session.getAttribute("permisosU")).contains("inscribirPersonaRunt")||((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarPersona.jsp")){
             Model modelo= (Model)session.getAttribute("model");
              modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
              modelo.UsuarioRunt userRunt = modelo.consultarUsuarioRunt(usuario.getId_usuario());

                try{
                    if(modelo!=null){
			session.removeAttribute("bbdd");
			session.removeAttribute("runt");
			session.removeAttribute("id_persona");
                        String nombreTipo = "";
			String numeroDocumento = "";
                        String tipoD = "";
			if(request.getParameter("tipo")!=null){
                            if(request.getParameter("tipo").length()>0){
                                if(request.getParameter("documento")!=null){
                                    if(request.getParameter("documento").length()>0){
                                        nombreTipo = modelo.consultarParametro(Integer.parseInt(request.getParameter("tipo")),5).getNombre();
                                        numeroDocumento = request.getParameter("documento").trim();
                                        tipoD = request.getParameter("tipo");
                                    }
                                }
                            }
                        }
			int paso = Integer.parseInt(request.getParameter("paso"));
			if(paso==1){
                            Persona persona = null;
                            if(tipoD.length()>0&&numeroDocumento.length()>0){
                                persona = modelo.consultarPersona(Integer.parseInt(tipoD), numeroDocumento);
                            }else{
                                if(session.getAttribute("id_persona")!=null){
                                    persona = modelo.consultarPersona(Long.parseLong(session.getAttribute("id_persona").toString()));
                                    tipoD = persona.getTipo_documento()+"";
                                    numeroDocumento = persona.getDocumento();
                                }
                            }
                            if(persona!=null){
                                    session.setAttribute("id_persona", persona.getId_persona());
                                    session.setAttribute("bbdd", persona);
                                    if(request.getParameter("bbdd")==null){ %>
                                        <jsp:forward page="inscribirPersona.jsp">
                                                <jsp:param name="paso" value="1"></jsp:param>
                                                <jsp:param name="tipo" value="<%=tipoD%>"></jsp:param>
                                                <jsp:param name="numero" value="<%=numeroDocumento%>"></jsp:param>
                                        </jsp:forward> <%
                                    }else{
                                        if(Integer.parseInt(request.getParameter("bbdd"))==1){ %>
                                            <jsp:forward page="inscribirPersona.jsp">
                                                    <jsp:param name="paso" value="1"></jsp:param>
                                                    <jsp:param name="bbdd" value="1"></jsp:param>
                                                    <jsp:param name="tipo" value="<%=tipoD%>"></jsp:param>
                                                    <jsp:param name="numero" value="<%=numeroDocumento%>"></jsp:param>
                                            </jsp:forward> <%
                                        }else{
                                            if(Integer.parseInt(request.getParameter("bbdd"))==2){ %>
                                                <jsp:forward page="inscribirPersona.jsp">
                                                        <jsp:param name="paso" value="1"></jsp:param>
                                                        <jsp:param name="bbdd" value="2"></jsp:param>
                                                        <jsp:param name="tipo" value="<%=tipoD%>"></jsp:param>
                                                        <jsp:param name="numero" value="<%=numeroDocumento%>"></jsp:param>
                                                </jsp:forward> <%
                                             }else{
                                                if(Integer.parseInt(request.getParameter("bbdd"))==3){
                                                    String msg = request.getParameter("msg"); %>
                                                    <jsp:forward page="inscribirPersona.jsp">
                                                            <jsp:param name="paso" value="1"></jsp:param>
                                                            <jsp:param name="bbdd" value="3"></jsp:param>
                                                            <jsp:param name="tipo" value="<%=tipoD%>"></jsp:param>
                                                            <jsp:param name="numero" value="<%=numeroDocumento%>"></jsp:param>
                                                            <jsp:param name="msg" value="<%=msg%>"></jsp:param>
                                                    </jsp:forward> <%
                                                 }
                                            }
                                        }
                                    }
                            }else{ %>
                                    <jsp:forward page="inscribirPersona.jsp">
                                            <jsp:param name="paso" value="2"></jsp:param>
                                            <jsp:param name="tipo" value="<%=tipoD%>"></jsp:param>
                                            <jsp:param name="numero" value="<%=numeroDocumento%>"></jsp:param>
                                    </jsp:forward> <%
                            }
			}
			if(paso==2){	
				int runt = -1;


				webservices.consultas.ServicioConsultaRUNTClient consultasService = new webservices.consultas.ServicioConsultaRUNTClient();
				consultasService.setTokenHuellaDigital("");
				consultasService.setUser(userRunt.getCodigo());
				String tipoDocumento = modelo.consultarParametro(Integer.parseInt(request.getParameter("tipo")),5).getNombreCorto();
                                if(session.getAttribute("token2")!=null){
                                        consultasService.setTokenHuellaDigital(session.getAttribute("token2").toString());
                                        System.out.println("token importacion :"+session.getAttribute("token2").toString());
                                }
                                if(Integer.parseInt(request.getParameter("tipo"))!=2){
                                 Model.userHandler = userRunt.getCodigo();
                                 Model.passUserHandler = userRunt.getPassword();
                                   com.heinsohn.runt.general.consultas.PersonaNaturalOutDTO personaNaturalOut = consultasService.consultarDatosPersonaNatural(tipoDocumento, numeroDocumento);
                                    if(personaNaturalOut!=null){
                                        if(personaNaturalOut.getStatus()!=null){
                                                if(personaNaturalOut.getStatus().getStatusCode().equals("1")){
                                                        javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.PersonaNaturalDTO> jaxbPersonaNatural = personaNaturalOut.getPersonaNatural();
                                                        com.heinsohn.runt.general.personas.PersonaNaturalDTO personaNatural = jaxbPersonaNatural.getValue();
                                                        if(personaNatural!=null){
                                                                if(personaNatural.getEstadoPersona().equals("ACTIVA")){
                                                                        //System.out.println("Persona IdRunt: "+personaNatural.getIdentificacion().getValue().getIdPersona());
                                                                        session.setAttribute("runt", personaNatural);
                                                                        String msg = request.getParameter("msg");
                                                                        runt = 1;
                                                                        %>  <jsp:forward page="inscribirPersona.jsp">
                                                                                <jsp:param name="paso" value="3"></jsp:param>
                                                                                <jsp:param name="runt" value="<%=runt%>"></jsp:param>
                                                                                <jsp:param name="tipo" value="<%=tipoD%>"></jsp:param>
                                                                                <jsp:param name="numero" value="<%=numeroDocumento%>"></jsp:param>
                                                                                 <jsp:param name="msg" value="<%=msg%>"></jsp:param>
                                                                        </jsp:forward> <%
                                                                }else{
                                                                    runt = 0;
                                                                    Persona persona = modelo.consultarPersona(Integer.parseInt(request.getParameter("tipo")), request.getParameter("documento"));
                                                                    if(persona==null){
                                                                    %>  <jsp:forward page="inscribirPersona.jsp">
                                                                            <jsp:param name="paso" value="3"></jsp:param>
                                                                            <jsp:param name="runt" value="<%=runt%>"></jsp:param>
                                                                            <jsp:param name="tipo" value="<%=tipoD%>"></jsp:param>
                                                                            <jsp:param name="numero" value="<%=numeroDocumento%>"></jsp:param>
                                                                    </jsp:forward> <%
                                                                    }else{
                                                                        session.setAttribute("bbdd", persona);
                                                                        %>  <jsp:forward page="inscribirPersona.jsp">
                                                                            <jsp:param name="paso" value="4"></jsp:param>
                                                                            <jsp:param name="runt" value="<%=runt%>"></jsp:param>
                                                                            <jsp:param name="tipo" value="<%=tipoD%>"></jsp:param>
                                                                            <jsp:param name="numero" value="<%=numeroDocumento%>"></jsp:param>
                                                                        </jsp:forward> <%
                                                                    }
                                                                }
                                                        }else{
                                                                runt = -1;
                                                        }
                                                }else{
                                                        runt = 0;
                                                        Persona persona = modelo.consultarPersona(Integer.parseInt(request.getParameter("tipo")), request.getParameter("documento"));
                                                        if(persona==null){
                                                        %>  <jsp:forward page="inscribirPersona.jsp">
                                                                <jsp:param name="paso" value="3"></jsp:param>
                                                                <jsp:param name="runt" value="<%=runt%>"></jsp:param>
                                                                <jsp:param name="tipo" value="<%=tipoD%>"></jsp:param>
                                                                <jsp:param name="numero" value="<%=numeroDocumento%>"></jsp:param>
                                                        </jsp:forward> <%
                                                        }else{
                                                            session.setAttribute("bbdd", persona);
                                                            %>  <jsp:forward page="inscribirPersona.jsp">
                                                                <jsp:param name="paso" value="4"></jsp:param>
                                                                <jsp:param name="runt" value="<%=runt%>"></jsp:param>
                                                                <jsp:param name="tipo" value="<%=tipoD%>"></jsp:param>
                                                                <jsp:param name="numero" value="<%=numeroDocumento%>"></jsp:param>
                                                            </jsp:forward> <%
                                                        }
                                                }
                                        }else{
                                                runt = -1;
                                        }
                                    }else{
                                        runt = -1;
                                    }
                                }else{
                                    Model.userHandler = userRunt.getCodigo();
                                 Model.passUserHandler = userRunt.getPassword();
                                        com.heinsohn.runt.general.consultas.PersonaJuridicaOutDTO personaJuridicaOut = consultasService.consultarDatosPersonaJuridica(tipoDocumento, numeroDocumento);
                                        if(personaJuridicaOut!=null){
                                        if(personaJuridicaOut.getStatus()!=null){
                                                if(personaJuridicaOut.getStatus().getStatusCode().equals("1")){
                                                        javax.xml.bind.JAXBElement<com.heinsohn.runt.general.personas.PersonaJuridicaDTO> jaxbPersonaJuridica = personaJuridicaOut.getPersonaJuridica();
                                                        com.heinsohn.runt.general.personas.PersonaJuridicaDTO personaJuridica = jaxbPersonaJuridica.getValue();
                                                        if(personaJuridica!=null){
                                                                if(personaJuridica.getPersonaEstado().equals("ACTIVA")){
                                                                        session.setAttribute("runt", personaJuridica);
                                                                        runt = 1;
                                                                        %>  <jsp:forward page="inscribirPersona.jsp">
                                                                                        <jsp:param name="paso" value="3"></jsp:param>
                                                                                        <jsp:param name="runt" value="<%=runt%>"></jsp:param>
                                                                                        <jsp:param name="tipo" value="<%=tipoD%>"></jsp:param>
                                                                                        <jsp:param name="numero" value="<%=numeroDocumento%>"></jsp:param>
                                                                                </jsp:forward> <%
                                                                }else{
                                                                     runt = 0;
                                                                    Persona persona = modelo.consultarPersona(Integer.parseInt(request.getParameter("tipo")), request.getParameter("documento"));
                                                                    if(persona==null){
                                                                    %>  <jsp:forward page="inscribirPersona.jsp">
                                                                            <jsp:param name="paso" value="3"></jsp:param>
                                                                            <jsp:param name="runt" value="<%=runt%>"></jsp:param>
                                                                            <jsp:param name="tipo" value="<%=tipoD%>"></jsp:param>
                                                                            <jsp:param name="numero" value="<%=numeroDocumento%>"></jsp:param>
                                                                    </jsp:forward> <%
                                                                    }else{
                                                                        session.setAttribute("bbdd", persona);
                                                                        %>  <jsp:forward page="inscribirPersona.jsp">
                                                                            <jsp:param name="paso" value="4"></jsp:param>
                                                                            <jsp:param name="runt" value="<%=runt%>"></jsp:param>
                                                                            <jsp:param name="tipo" value="<%=tipoD%>"></jsp:param>
                                                                            <jsp:param name="numero" value="<%=numeroDocumento%>"></jsp:param>
                                                                        </jsp:forward> <%
                                                                    }
                                                                }
                                                        }else{
                                                                runt = -1;
                                                        }
                                                }else{
                                                      runt = 0;
                                                        Persona persona = modelo.consultarPersona(Integer.parseInt(request.getParameter("tipo")), request.getParameter("documento"));
                                                        if(persona==null){
                                                        %>  <jsp:forward page="inscribirPersona.jsp">
                                                                <jsp:param name="paso" value="3"></jsp:param>
                                                                <jsp:param name="runt" value="<%=runt%>"></jsp:param>
                                                                <jsp:param name="tipo" value="<%=tipoD%>"></jsp:param>
                                                                <jsp:param name="numero" value="<%=numeroDocumento%>"></jsp:param>
                                                        </jsp:forward> <%
                                                        }else{
                                                            session.setAttribute("bbdd", persona);
                                                            %>  <jsp:forward page="inscribirPersona.jsp">
                                                                <jsp:param name="paso" value="4"></jsp:param>
                                                                <jsp:param name="runt" value="<%=runt%>"></jsp:param>
                                                                <jsp:param name="tipo" value="<%=tipoD%>"></jsp:param>
                                                                <jsp:param name="numero" value="<%=numeroDocumento%>"></jsp:param>
                                                            </jsp:forward> <%
                                                        }
                                                }
                                        }else{
                                                runt = -1;
                                        }
                                     }else{
                                            runt = -1;
                                    }
                                }
                            %>  <jsp:forward page="inscribirPersona.jsp">
                                    <jsp:param name="paso" value="1"></jsp:param>
                                    <jsp:param name="runt" value="<%=runt%>"></jsp:param>
                                    <jsp:param name="tipo" value="<%=tipoD%>"></jsp:param>
                                    <jsp:param name="numero" value="<%=numeroDocumento%>"></jsp:param>
                            </jsp:forward> <%
			}//fin paso 2

  }
 }catch(Exception exc){
     exc.printStackTrace();
 }
        %>
        <%  }else{ %>
			   <jsp:forward page="no_access.jsp">
				 <jsp:param name="tipo" value="1"></jsp:param>
			   </jsp:forward>
	<%  }
	}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
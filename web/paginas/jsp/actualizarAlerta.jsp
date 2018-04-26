<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/xml" pageEncoding="UTF-8"%>
<%@ page import="modelo.*"%>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("editarAlerta.jsp")){
                        modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                    %>


<root>
   <% Model modelo= (Model)session.getAttribute("model");
    try{
        modelo.getCon().setAutoCommit(false);
        int  tipo = Integer.parseInt(request.getParameter("tipodocumento")) ;
        String documento = request.getParameter("documento");
        
        int tipoembargo   = Integer.parseInt(request.getParameter("tipoalerta"));
        int grado = Integer.parseInt(request.getParameter("grado"));
        java.sql.Date  fecha_inicio = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_inicio")).getTime());

       java.sql.Date  fecha_final = null;
           if(request.getParameter("fecha_fin")!=null){
               if(!request.getParameter("fecha_fin").isEmpty())
                 fecha_final = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_fin")).getTime());
           }
        


        String observacion  =  request.getParameter("observacion");

        Alerta alerta = (Alerta)session.getAttribute("alerta");
        Persona persona = modelo.consultarPersona(tipo, documento);
        alerta.setFk_persona(persona.getId_persona());
        
        
        alerta.setTipo(tipoembargo);
        alerta.setFecha_ini(fecha_inicio);
        //if(fecha_final!=null)
            alerta.setFecha_fin(fecha_final);
        alerta.setObservaciones(observacion);
        alerta.setUsuario(usuario.getId_usuario());
        alerta.setGrado(grado);
        modelo.actualizarAlerta(alerta);

        modelo.getCon().commit();
        session.removeAttribute("alerta");
        %>
        <result>si</result>
<%  }catch(Exception ecx){
    session.removeAttribute("alerta");

        modelo.getCon().rollback();
        ecx.printStackTrace();        %>
        <result>no</result>
        <error><%=ecx.toString()%></error>
<%  }
%>

</root>

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
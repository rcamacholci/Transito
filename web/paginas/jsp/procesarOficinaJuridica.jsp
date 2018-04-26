<%-- 
    Document   : procesarOficinaJuridica
    Created on : 9/08/2012, 04:15:40 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
        if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("AgregarOficinaJuridica.jsp")){
            if(session.getAttribute("model")!=null){
                Model modelo = (Model)session.getAttribute("model");
                Usuario usuario = (Usuario)session.getAttribute("usuario");
int tip = 0;

if(request.getParameter("idoficinaJuridica")!=null && request.getParameter("oficinaJuridica")!=null){


     Oficina_Juridica oficina_juridica = new Oficina_Juridica();
    if(request.getParameter("idoficinaJuridica").equals("nuevo")){
        oficina_juridica.setNombre(request.getParameter("oficinaJuridica"));
        oficina_juridica.setFk_sede(usuario.getFk_sede());
        modelo.adicionarOficinaJuridica(oficina_juridica);
        modelo.getCon().commit();
        tip = 1;
    }else{
        String nombre = request.getParameter("oficinaJuridica");
        long id_oficina = Long.parseLong(request.getParameter("idoficinaJuridica"));
        modelo.actualizarOficinaJuridicaById(nombre,id_oficina);
        modelo.getCon().commit();
    }
    if(tip==1){
    %><script>
        alert("Oficina Juridica adicionada correctamente")
        window.location.href = "AgregarOficinaJuridica.jsp";
    </script><%
    }else{
    %><script>
        alert("Oficina Juridica actualizada correctamente")
        window.location.href = "AgregarOficinaJuridica.jsp";
    </script><%
    }
}

  }else{ %>
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

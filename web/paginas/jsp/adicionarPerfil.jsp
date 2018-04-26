<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("verPerfilesUsuario.jsp")){

%>



<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Perfiles</title>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<body>	
<%
 Model modelo= (Model)session.getAttribute("model");  
Perfil perfil = new Perfil(); 
 
String nombre        =    request.getParameter("nombre");
String descripcion   =    request.getParameter("descripcion");

perfil.setNombre(nombre);
perfil.setDescripcion(descripcion);


modelo.adicionarPerfil(perfil);

%>
<script language="javascript" type="text/javascript">
alert("Se Ha Creado El Perfil Correctamente...");
window.location.href="verPerfilesUsuario.jsp";
</script>
</body>
</html>
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

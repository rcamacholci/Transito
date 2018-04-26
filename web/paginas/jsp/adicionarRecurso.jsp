<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("recurso.jsp")){
                      
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Recursos</title>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<body>
<% 
 Model modelo= (Model)session.getAttribute("model");  
Recurso recurso = new Recurso(); 
 
String nombre        =    request.getParameter("nombre");
int modulo           =    Integer.parseInt(request.getParameter("modulo"));
String descripcion   =    request.getParameter("descripcion");
recurso.setNombre(nombre);
recurso.setDescripcion(descripcion);
recurso.setModulo(modulo);

modelo.adicionarRecurso(recurso);
%>
<script language="javascript" type="text/javascript">
alert("Se Ha Creado El Recurso Correctamente...");
window.location.href="recurso.jsp";

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


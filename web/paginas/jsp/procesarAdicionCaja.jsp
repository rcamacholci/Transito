<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, modelo.Caja, modelo.Sede, modelo.Model" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("adicionarCaja.jsp")){
                    modelo.Model modelo = (modelo.Model)session.getAttribute("model");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Adicionar Caja</title>
</head>
<body>
<%  
    java.sql.Timestamp  fechaSystem= new java.sql.Timestamp(new java.util.Date().getTime());
    Sede sede = (Sede) session.getAttribute("sede");
    String nombre    =       request.getParameter("nombre");
    if(nombre.length()>0){
        long fk_sede      =      sede.getId_sede();
        nombre = nombre.toUpperCase();
        Caja caja = new Caja();
        caja.setNombre(nombre);
        caja.setFk_sede(fk_sede);
        caja.setFecha_inicio(fechaSystem);

        modelo.adicionarCaja(caja);%>
        <script>
            alert("La caja ha sido adicionada");
            window.location.href="administrarCaja.jsp";
        </script>
<% }else{ %>
        <script>
            alert("La caja ha sido adicionada");
            window.location.href="administrarCaja.jsp";
        </script>
<% } %>
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
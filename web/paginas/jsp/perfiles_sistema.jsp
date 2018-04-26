<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("asig_recursos.jsp")){
                         Model modelo= (Model)session.getAttribute("model");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Perfil de Usuario</title>
<script language="javascript" type="text/javascript">
	function actualizar(radio){
		window.parent.frames[1].location.href = "recursos_perfil.jsp?perfil="+radio.value;
	}
</script>
<style type="text/css">
<!--
.style3 {font-size: 12px; font-weight: bold; font-family: Tahoma; }
-->
</style>
</head>

<body bgcolor="#FFFFFF">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<table width="300" border="1" align="center" cellpadding="1" cellspacing="0">
 <tr bgcolor="#CCCCCC">
	  <td width="10%" align="center" style="border:none"><span class="style3"><font color="#333333">ID</font></span></td>
	  <td width="90%" align="center" style="border:none"><span class="style3"><font color="#333333">NOMBRE</font></span></td>
          <td width="90%" align="center" style="border:none"><span class="style3"><font color="#333333">USUARIO</font></span></td>
 </tr>

  <%

         Perfil perfil = new Perfil();
         List listPerfil;

         listPerfil = modelo.listarPerfil();


         Iterator itt = listPerfil.iterator();
         while (itt.hasNext()) {
         perfil = (Perfil)itt.next();
          Usuario us = modelo.consultarUsuario(perfil.getfk_usuario());
          Persona per = modelo.consultarPersona(us.getFk_persona());

        %>
	   <tr>
		  <td ><font color="#FFFFFF" size="2" ><input type="radio" name="perfil" id="perfil" value="<%=perfil.getId_perfil()%>" onclick="actualizar(this)"/></font></td>
		  <td style="border-left:none" ><div align="center" class="style3"><font color="#333333"><%=per.getNombre_1()%> <%=per.getApellido_1()%></font></div></td>
	  	  <td style="border-left:none" ><div align="center" class="style3"><font color="#333333"><%=us.getNombre() %></font></div></td>
           </tr>

  <%}%>

</table>

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

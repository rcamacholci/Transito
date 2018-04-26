<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Asignacion de Recurso </title>


<script language="javascript" type="text/javascript">
	function add(name){
		alert(name+","+document.getElementById('recursos').value);
		var opcion=new Option(name,document.getElementById('recursos').value);
		document.getElementById('asociacion').options[document.getElementById('asociacion').options.length] = opcion;
	}	
</script>
<style type="text/css">
<!--
.Estilo1 {
	color: #333333;
	font-weight: bold;
	font-size: 14px;
}
.Estilo2 {
	font-size: 12px;
	font-weight: bold;
	color: #333333;
}
.style2 {font-size: 12px; font-weight: bold; color: #FFFFFF; }
-->
</style>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<body>
<table width="100%" border="0"  bordercolor="#FFFFFF" align="center" >
       <tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style2">ASIGNACION DE RECURSOS A PERFILES DE USUARIO</span></td>
  </tr>
        <tr>
            <td align="center" colspan="2">&nbsp;</td>
        </tr>
        <tr style="border:none; background:url(../html/images/inicio_3.png)">
            <td align="center"><span class="style2">PERFILES DE USUARIO</span></td>
            <td align="center" class="style2">RECURSOS DEL PERFIL</td>
        </tr>
	<tr>
	  <td width="50%">
	  	<iframe src="perfiles_sistema.jsp" scrolling="auto" width="100%" height="650" frameborder="0"></iframe>
	  </td>
	  <td width="50%">
	  	<iframe src="recursos_perfil.jsp" scrolling="auto" width="100%" height="650" frameborder="0"></iframe>
	  </td>
	</tr>	
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

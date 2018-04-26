<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                        Model modelo= (Model)session.getAttribute("model");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>  Tramites </title>

<script language="javascript" type="text/javascript">
   function buscarTramites(){
    	window.frames[0].location.href = "tramites_sedes.jsp?clase="+document.form.clase.value;
   }
</script>
<style type="text/css">
<!--
.Estilo2 {
	color: #0066CC;
	font-weight: bold;
}
.style2 {
	color: #333333;
	font-weight: bold;
	font-family: Tahoma;
	font-size: 12px;
}
-->
</style>
</head>

<body>

<form id="form" name="form" method="post" action="" style="width:100%">

<fieldset><div align="center">
  	<legend align="center" class="style2"><strong>PARAMETRIZACION DE TRAMITES</strong></legend>
 	</div>

  <table width="100%" border="0" align="center">
    <tr>
      <td width="40%" align="right"><span class="style2">CLASE</span></td>
      <td width="60%" align="left">
			<select name="clase" id="clase" style="font-size:10px; width:200px" onchange="buscarTramites()" >
            <% 
			 Parametro parametro= new Parametro();
			 List listclase;	
			 listclase =modelo.listadoParametros(71);
			 Iterator it = listclase.iterator(); 
			 while (it.hasNext()) {
				parametro = (Parametro)it.next();
			 %>
            <option value="<%=parametro.getCodigo()+""%>"> <%=parametro.getNombre()%></option>
         <%}%>
        </select>
   	  </td>
    </tr>
	<tr>
		<td colspan="2">&nbsp;
			
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<iframe src="tramites_sedes.jsp?clase=1" width="100%" height="400" scrolling="auto" frameborder="0"></iframe>
		</td>
	</tr>	
  </table>
  
</fieldset>
  </form>
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


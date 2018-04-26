<%-- 
    Document   : adicionarCajaInactiva
    Created on : 2/08/2011, 05:22:30 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Adicionar Caja Inactiva</title>
<style type="text/css">
<!--
.Estilo4 {color: #0066CC; font-weight: bold; }
.Estilo6 {color: #0066CC; font-weight: bold; font-size: 18px; }
.style2 {
	font-size: 12px;
	font-weight: bold;
	color: #333333;
	font-family: Tahoma;
}
-->
</style>
<script language="javascript" type="text/javascript">


   function validarNombre(nombre){
     if(nombre.value==""){
       alert("Digite el Nombre de la Caja");
       return false;
     }else return true;
   }

   function validarFormulario(form)
   {
     with(form){

         if(validarNombre(nombre)==false){
             nombre.focus();
             return false;
         }
     }
  }

  function regresar(){
		window.location.href="administrarCaja.jsp";
	}

   </script>
</head>
<body>
<center>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>

<form id="form" name="form" method="post" action="procesarAdicionarCajaInactiva.jsp" onsubmit="return validarFormulario(this)" style="width:90%">
  <table width="30%" border="0" align="center" >
     <tr>
	<td colspan="3">&nbsp;</td>
	</tr>
     </tr>
     <tr>
          <td colspan="2" align="center"><span class="style2">CAJA #</span></td>
          <td width="50%" colspan="2" align="center">
              <input type="text" name="caja" style="width:200px" />
          </td>
    </tr>
    <tr>
	<td colspan="3">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="2" align="center"><span class="style2">PLACA</span></td>
      <td width="50%" colspan="2" align="center">
          <input type="text" name="placa" style="width:200px" />
      </td>
    </tr>
    <tr>
      <td colspan="2" align="center"><span class="style2">CAJA #</span></td>
      <td width="50%" colspan="2" align="center">
          <input type="text" name="caja" style="width:200px" />
      </td>
    </tr>
	<tr>
	<td colspan="3">&nbsp;</td>
	</tr>
    <tr>
      <td colspan="23" align="center">
<button type="submit" name="Submit" >Guardar Caja <img  src="../html/images/guardar.png" width="19" height="18"/></button>
	  <!--<input type="submit" name="Submit" value="Guardar Caja" />-->
      </td>
    </tr>
  </table>
</form>
</center>
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
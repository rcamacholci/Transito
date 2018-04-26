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
<title>Recursos</title>
<style type="text/css">
<!--
.Estilo3 {
	color: #FF0000;
	font-weight: bold;
}
.Estilo4 {color: #0066CC}
.Estilo5 {color: #0066CC; font-weight: bold; }
.style2 {
	color: #333333;
	font-weight: bold;
	font-family: Tahoma;
}
.style4 {
	color: #333333;
	font-weight: bold;
	font-size: 12px;
	font-family: Tahoma;
}
-->
</style>
<script language="javascript" type="text/javascript">
   function validarNombre(nombre){
        if(nombre.value==""){
              alert("          Digite el Nombre del Recurso   ");
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
</script>


</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>

<body >


<form id="form" name="form" method="post" action="adicionarRecurso.jsp" onSubmit="return validarFormulario(this)">
<p>&nbsp;</p>
<fieldset>
 <div align="center">
   <legend class="style4" align="center">RECURSOS</legend>
 </div>
  <table width="600" border="0" align="center">
   
	 <tr>
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr>
      <td width="109"><span class="style4">NOMBRE</span></td>
      <td width="176" align="left"><span class="Estilo4">
        <label>
        <input type="text" name="nombre" />
        </label>
      </td>
      <td width="118"><span class="style4">MODULO</span></td>
      <td width="169"><span class="Estilo4">
        <label>
        <select name="modulo">
          <%
	 Parametro parametro = new Parametro();
         Model modelo= (Model)session.getAttribute("model"); 
         List  list =modelo.listadoParametros(323); 
         Iterator itt = list.iterator(); 
         while (itt.hasNext()) {
                   parametro = (Parametro)itt.next(); 
                   
		 %>
          <option   value="<%= parametro.getCodigo() %>"   ><%= parametro.getNombre() %></option>
          <%}%>
        </select>
        </label>
      </span></td>
    </tr>
    <tr>
      <td><span class="style4">DESCRIPCION</span></td>
      <td colspan="3"><span class="Estilo4">
        <label>
        <input name="descripcion" type="text" size="73" />
        </label>
      </span></td>
    </tr>
    <tr>
      <td colspan="4"><span class="Estilo4">
        <label>
        <div align="center" class="Estilo4">
          <input type="submit" name="Submit" value=" Crear Recurso " />
        </div>
        <span class="Estilo4">
        </label>
        </span></td>
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

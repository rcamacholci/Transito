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
<title>Recursos</title>

<style type="text/css">
<!--
.style1 {
	font-family: Tahoma;
	font-weight: bold;
}
.style3 {font-family: Tahoma; font-weight: bold; font-size: 12px; }
.Estilo2 {font-family: Tahoma; font-weight: bold; font-size: 10px; }
-->
</style>
<script language="javascript" type="text/javascript">
	function sombrear(tr){
		tr.style.backgroundColor="#CCCCCC";
	}
	function renovar(tr){
		tr.style.backgroundColor="#FFFFFF";
	}
        function Marcar(){

        if(document.form.marcartodo.checked){
             for (i=0;i<document.form.elements.length;i++)
                if(document.form.elements[i].type == "checkbox")
                    document.form.elements[i].checked=1
        }else{
             for (i=0;i<document.form.elements.length;i++)
                if(document.form.elements[i].type == "checkbox")
                    document.form.elements[i].checked=0
        }
          
       
        }
</script>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<body bgcolor="#FFFFFF">
<form id="form" name="form" method="post" action="adicionarRecursoPerfil.jsp">
  <table width="80%" border="1" align="center" cellpadding="1" cellspacing="0">
    
            
      <tr bgcolor="#CCCCCC">
	  <td width="5%" align="center" style="border:none"><span class="style1"><font color="#333333" size="2">ID</font></span></td>
	  <td width="95%" align="center" style="border:none"><span class="style1"><font color="#333333" size="2">NOMBRE</font></span></td>
	</tr>

        <tr>
            <td><input type="checkbox" name="marcartodo" id="marcartodo" onclick="Marcar()" /></td>
          <td style="border-left:none"><span class="Estilo2"><font color="#333333">Marcar todo</font></span></td>
      </tr>
      
     <%
     
     if(request.getParameter("perfil")!=null){
		 List list =modelo.listadoParametros(323); 
		 Iterator itt = list.iterator(); 
		 List perfilrecursos = modelo.listarRecursosByPerfil(Integer.parseInt(request.getParameter("perfil")));
		 while (itt.hasNext()) {	
			Parametro parametro = (Parametro)itt.next();%>
			<tr>
			  <td colspan="1" align="center" bgcolor="#CCCCCC"><img src="../html/scripts/dataMenu.files/icon1_s.gif" height="17" width="20" /></td>
			  <td colspan="1" align="center" background="../html/images/inicio_3.png"><span class="style3" style="color: #FFFFFF"><%=parametro.getNombre()%></span></td>
			</tr>
			<%
			List list2 =modelo.listarRecurso(Integer.parseInt(parametro.getCodigo()+""));
			Iterator itt2 = list2.iterator(); 
			while (itt2.hasNext()) {
			  Recurso recurso = (Recurso)itt2.next(); %>
			 <tr onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
				 <td align="center">
				 <input type="checkbox" name="id_recurso" value="<%=recurso.getId_recurso()%>" <%=perfilrecursos.contains(recurso.getId_recurso()+"")?"checked":""%> style="cursor:pointer"/>
				 </td>
				 <td style="border-left:none"><span class="Estilo2"><font color="#333333"><%=recurso.getNombre()%></font></span></td>
    </tr>
		  <%}
		}  %>
		<tr style="border:none">
			<td colspan="2" align="center" style="border:none">&nbsp;
	          
			</td> 
		</tr>
		<tr style="border:none">
                    <% if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("adicionarRecursoPerfil.jsp")){ %>
			<td colspan="2" align="center" style="border:none">
        	          <input type="submit" name="Submit" value="Guardar Configuracion" />
			</td>
                        <% }else{ %>
                        <td colspan="2" align="center" style="border:none">
                            <input type="submit" name="Submit" value="Guardar Configuracion" disabled />
			</td>
                        <%}%>
		</tr>	
<%	}  %>    
	<input name="id_perfil" type="hidden" value="<%=request.getParameter("perfil")%>"/>
</table>
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

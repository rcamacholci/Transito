<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" pageEncoding="ISO-8859-1" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%

try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarAcuerdosdePago.jsp")){
                   modelo.Model model = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                    modelo.Persona persona2 = model.consultarPersona(usuario.getFk_persona());
                    String nombreU = persona2.getNombre_1()+" "+persona2.getApellido_1()+" "+(persona2.getApellido_2()!=null?persona2.getApellido_2():"");
                    String fecha = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
<!--
.Estilo3 {font-size: 12px; color: #FFFFFF; }
.Estilo4 {
	color: #333333;
	font-weight: bold;
	font-size: 12px;
}
-->
        </style>
		

</head>
    <body>
            <table width="100%" border="1" cellpadding="1" cellspacing="0">
<% if(request.getParameter("excel").equals("1")){
response.setContentType ("application/vnd.ms-excel"); //Tipo de fichero.
response.setHeader ("Content-Disposition", "attachment;filename=\"PerfilPorRecursos.xls\"");
%> <tr>
<td>Generado por:</td>
<td align="left"><%=nombreU%></td>
</tr>
<tr>
<td>Fecha:</td>
<td align="left"><%=fecha%></td>
</tr>
<tr>
<td>PERFIL: </td>

<% long id_perfil = Long.parseLong(request.getParameter("perfil"));
java.util.List<Perfil> nombre = null;
nombre = model.consultarPerfilesNombre(id_perfil);
Perfil nombre2 = nombre.get(0);
%>
<td align="left"><h2><%= nombre2.getNombre() %></h2></td>
</tr>
<%
} %>
              <tr style="background:url(../html/images/inicio_3.png)">
		<th width="5%" scope="col"><span class="Estilo2">N°</span></th>
                <th width="10%" scope="col"><span class="Estilo2">NOMBRE DEL RECURSO</span></th>

              </tr>
              <%
     try{
         Sede sede = (Sede)session.getAttribute("sede");
         java.util.List<Perfil_Recurso> perfil_recurso = null;
            
          perfil_recurso = model.consultarPerfil_Recurso(Long.parseLong(request.getParameter("perfil")));
         if(perfil_recurso!=null){
                for(int i=0;i<perfil_recurso.size();i++){
                    Perfil_Recurso perfil_recurso2 = perfil_recurso.get(i);
                     %>
                        <tr>
                            <td><div align="center"><span class="Estilo4"><%=i+1%></span></div></td>
                            <td><div align="center"><span class="Estilo4"><%= perfil_recurso2.getCRNOMBRE() %></span></div></td>
                         </tr>
        <%     
                }
        }
   }catch(Exception exc){
       exc.printStackTrace();
   }  %>
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
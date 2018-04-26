<%-- 
    Document   : IpUsuario
    Created on : 24/09/2014, 11:09:00 AM
    Author     : Desarrollo
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*"  import="modelo.Parametro"  errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
try{
	if(session.getAttribute("model")!=null){
		//if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("HabilitarIPUsuarios.jsp")){
		if(1==1){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");

        long id_usuario = Long.parseLong(request.getParameter("id_usuario"));
        Usuario usuario = model.consultarUsuario(id_usuario);

%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
     <STYLE>


<!--
A.ssmItems:link		{color:black;text-decoration:none}
A.ssmItems:hover	{color:black;text-decoration:none}
A.ssmItems:active	{color:black;text-decoration:none}
A.ssmItems:visited	{color:black;text-decoration:none}
.style3 {font-size: 12px; font-family: Tahoma; }
.style6 {color: #333333; font-size: 12px; font-weight: bold; }
.Estilo32 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 12px;
}

.style5 {
	color: #333333;
	font-size: 10px;
	font-family: Tahoma;
	font-weight: bold;
}
-->
        </STYLE>
    <body>
        <form name="form" id="form" action="ActualizarIP.jsp" method="post" >
            <input type="hidden" name="id_usuario" id="id_usuario" value="<%=id_usuario%>"/>
			<table border="0" align="center">
				<tr style="border:none;background:url(../html/images/inicio_3.png)">
                                    <td colspan="2" ><span class="Estilo32">Usuario:&nbsp;<%=usuario.getNombre()%></span></td>
				</tr>
            <%
        java.util.List<UsuariosIP> ipUsuarios = null;
        long IDUsuario = usuario.getId_usuario();
        ipUsuarios  = model.consultarIPporUsuario(IDUsuario);
        UsuariosIP ip1 = new UsuariosIP();
        UsuariosIP ip2 = new UsuariosIP();
        if(ipUsuarios!=null){
        if(ipUsuarios.size()>0 && ipUsuarios.size()<2){
            ip1 = ipUsuarios.get(0); 
            ip1.getid_usuario_ip();
            %>
            <input type="hidden" name="id_dir1" id="id_dir1" value="<%=ip1.getid_usuario_ip()%>"/>
            <%
        }else if (ipUsuarios.size()>0){
            ip1 = ipUsuarios.get(0); 
            ip2 = ipUsuarios.get(1); 
              
            %>
            <input type="hidden" name="id_dir1" id="id_dir1" value="<%=ip1.getid_usuario_ip()%>"/>
            <input type="hidden" name="id_dir2" id="id_dir2" value="<%=ip2.getid_usuario_ip()%>"/>
            <%
        }
        }
 %>

				<tr>
				<td><span class="style5"> Ip 1</span>&nbsp;<input type="text" name="ip1" id="ip1" maxlength="15" value="<%=ip1.getip()!=null?ip1.getip():""%>" /></td>
				<td><span class="style5"> Ip 2</span>&nbsp;<input type="text" name="ip2" id="ip2" maxlength="15" value="<%=ip2.getip()!=null?ip2.getip():""%>" /></td>
				</tr>
                                <tr><td colspan="2"><input type="submit" name="guardar" id="guardar" value="Guardar" /></td></tr>
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
}catch(Exception mexe){
mexe.printStackTrace();
%>

    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
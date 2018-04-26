<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" errorPage="" %>

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("validarusutoken.jsp")){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
%>


<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Ver prendas por beneficiario</title>
		<STYLE>
<!--
A.ssmItems:link		{color:black;text-decoration:none;}
A.ssmItems:hover	{color:black;text-decoration:none;}
A.ssmItems:active	{color:black;text-decoration:none;}
A.ssmItems:visited	{color:black;text-decoration:none;}
.style1 {
	font-size: 12px;
	font-family: Tahoma;
}
.style5 {color: #ffffff; font-weight: bold; font-size: 17px; font-family: Tahoma; }
.Estilo11 {
	color: #0066CC;
	font-weight: bold;
	font-size: 10px;
}
-->
        </STYLE>


        <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <META http-equiv=Content-Type content="text/html; charset=windows-1252">

</head>
    <body>
        <form id="form" name="form" method="post" action="procesarusutoken.jsp">

  <table width="40%" border="1" align="center"  cellpadding="1" cellspacing="0">
  <tr bgcolor="#CCCCCC" style="border:none;background:url(../html/images/inicio_3.png)">
      <td width="90%" style="border:none"  align="center" ><span class="style5">Nombre usuario</span></td>
      <td width="10%" style="border:none" align="center"><span class="style5">Verificación</span></td>
   </tr>


        
   <%
             
        java.util.List<UsuarioRunt> usuariosToken = null;
        usuariosToken  = model.verificarUsuariosToken();
        String fecha ="";
        String ck="";
        Usuario usuario = null;
        Persona per =null;

        for(int i=0;i<usuariosToken.size();i++){
        UsuarioRunt usuarioRunt = usuariosToken.get(i);
        usuario = model.consultarUsuario(usuarioRunt.getFk_usuario());
        per = model.consultarPersona(usuario.getFk_persona());
        fecha= usuarioRunt.getFecha_ini().toString();
        fecha = fecha.substring(0,4);

       
     %>
       <tr>
      <td width="90%" align="center" class="style2" style="color:#333333; font-size:12px"><%=per.getNombre_1()%>  <%=per.getApellido_1()%></td>
      <td width="10%" align="center" class="style2" style="color:#333333; font-size:12px"><input type="checkbox" name="Ftoken" value="<%=usuarioRunt.getFk_usuario()%>" <%=fecha.equals("2010")?"checked":""%> /></td>
      </tr>

     <% 
     }
   %>
   <tr>
       <th colspan="2" align="center"><input type="submit" value="Guardar"></th>
   </tr>


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
		</script>
<%
	}
}catch(Exception mexe){
mexe.printStackTrace();
%>

    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>

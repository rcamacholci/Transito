<%-- 
    Document   : AdministrarUsuario
    Created on : 29/05/2012, 03:19:37 PM
    Author     : Jose Carreño
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" errorPage="" %>

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("AdministrarUsuario.jsp")){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
                   // javax.swing.JOptionPane.showMessageDialog(null,"lol");
%>


<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Administrar Usuario</title>
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
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
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
        <form id="form" name="form" method="post" action="ProcesarUsuarios.jsp">
            <input type="hidden" name="fecha" id="fecha" />
<script language="javascript" type="text/javascript">
var f = new Date();
//document.write(f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear());
if(f.getMonth()+1<=9){
document.form.fecha.value=f.getDate() + "/0" + (f.getMonth() +1) + "/" + f.getFullYear();
}else{
 document.form.fecha.value=f.getDate() + "/" + (f.getMonth() +1) + "/" + f.getFullYear();
}

</script>
  <table width="40%" border="1" align="center"  cellpadding="1" cellspacing="0">
  <tr bgcolor="#CCCCCC" style="border:none;background:url(../html/images/inicio_3.png)">
      <td width="40%" style="border:none"  align="center" ><span class="style5">Usuario</span></td>
      <td width="60%" style="border:none"  align="center" ><span class="style5">Nombre</span></td>
      <td width="10%" style="border:none" align="center"><span class="style5">Verificación</span></td>
   </tr>



   <%

        java.util.List<Usuario> usu = model.ListarUsuario();
        
        String fecha ="";
        Persona per =null;

        for(int i=0;i<usu.size();i++){
            Usuario info = usu.get(i);
            per = model.consultarPersona(info.getFk_persona());
            //javax.swing.JOptionPane.showMessageDialog(null,usu);
            if(info.getFechaFin()==null){
            fecha="";

            }else{
                fecha=info.getFechaFin().toString();
            }

            System.out.println(per.getNombre_1()+"-"+per.getApellido_1()+"-"+info.getNombre()+"-"+info.getFechaFin()+"\n");
        %>

      <tr>
      <td width="30%" align="center" class="style2" style="color:#333333; font-size:12px"><%=info.getNombre()%></td>
      <td width="65%" align="center" class="style2" style="color:#333333; font-size:12px"><%=per.getNombre_1()%> <%=per.getApellido_1()%></td>
      <td width="5%" align="center" class="style2" style="color:#333333; font-size:12px"><input type="checkbox" name="Fusuario" value="<%=info.getId_usuario()%>" <%=fecha.equals("")?"checked":""%> /></td>
      </tr>
   <%
     }
   %>
      <tr>
       <th colspan="3" align="center">
<button type="submit"><span class="style2">Guardar </span><img src="../html/images/guardar.png" width="19" height="18"/></button>	   
	   <!--<input type="submit" value="Guardar">--></th>
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


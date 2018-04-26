<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model" import="java.util.*" import="modelo.Parametro"  errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("HistorialRecursos.jsp")){
                    modelo.Model modelo = (modelo.Model)session.getAttribute("model");
%>


<script language="javascript" type="text/javascript">

        function edit(){
     
            window.frames[0].location.href="VerHistorialRecurso.jsp?perfil="+document.form.perfil.value;
	}
        function sombrear(tr){
		tr.style.backgroundColor="#CCCCCC";
	}
	function renovar(tr){
		tr.style.backgroundColor="#FFFFFF";
	}




</script>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Ver prendas por beneficiario</title>
        <style type="text/css">
            <!--
            .Estilo4 {
                font-weight: bold;
                font-family: "Times New Roman", Times, serif;
                color: #FFFF99;
                font-size:12px;
            }
            -->

        </style>
	    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <META http-equiv=Content-Type content="text/html; charset=windows-1252">


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
-->
<!--
.style1 {
	font-family: Tahoma;
	font-weight: bold;
	font-size: 12px;
	color: #333333;
}
.Estilo5 {	color: #333333;
	font-size: 10px;
}
.style2 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 12px;
	font-family: Tahoma;
}
.Estilo6 {font-size: 10px}
.Estilo4 {color: #333333;font-size: 14px;}
-->
        </STYLE>
</head>
    <body>
       
       <form id="form" name="form" method="post">
            <fieldset>
 <table width="30%" border="1" align="center"  cellpadding="1" cellspacing="0">
     
         <tr style="border:none; background:url(../html/images/inicio_3.png)"><th><samp class="style2"><b>HISTORIAL RECURSOS POR PERFIL</b></samp></th></tr>
         <TR>
             <TD align="center">Perfil:&nbsp;
        <select name="perfil" id="perfil">
<option value="0"> <-- General --> </option>
                  <%
         Perfil perfil = new Perfil();
         List listPerfil;

         listPerfil =modelo.listarPerfil();


         Iterator itt = listPerfil.iterator();
         while (itt.hasNext()) {
            perfil = (Perfil)itt.next();
            Usuario usu = modelo.consultarUsuario(perfil.getfk_usuario());
            Persona per = modelo.consultarPersona(usu.getFk_persona());

%>
<option value="<%=usu.getId_usuario()%>"><%=usu.getNombre()%>--<%=per.getNombre_1()%> <%=per.getApellido_1()%></option>
  
                <%}%>
        </select>&nbsp;<input type="button" value="consultar" onclick="edit()"></TD>
         </TR>
   

</table>
</fieldset>
       </form>
  
        <iframe src="pantallazo.jsp" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
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
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Vehiculo</title>
    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <LINK title=win2k-cold-1 media=all href="file:///N|/Civitrans/Civitrans14092012/transito/web/paginas/html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
		<script src="file:///N|/Civitrans/Civitrans14092012/transito/web/paginas/html/scripts/calendar.js" type="text/javascript"></script>
        <script src="file:///N|/Civitrans/Civitrans14092012/transito/web/paginas/html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="file:///N|/Civitrans/Civitrans14092012/transito/web/paginas/html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="file:///N|/Civitrans/Civitrans14092012/transito/web/paginas/html/scripts/validarFecha.js" type="text/javascript"></script>
                
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
.style5 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.Estilo11 {
	color: #0066CC;
	font-weight: bold;
	font-size: 10px;
}
-->
        </STYLE>


</head>
    <%
    Model model = null;
    try {
        model = (Model) session.getAttribute("model");
    } catch (Exception exc) {
        exc.printStackTrace();
    }
    %>
    <body> 
		<form name="form" id="form" method="post" action="" onSubmit="return validarCampos()">
	        <fieldset><div align="center">
		    <legend class="style5"  align="center">COMPARENDOS&nbsp;SANCIONADOS&nbsp;E&nbsp;IMPRESOS</legend>
		  	</div> 
			
		  </fieldset>
		  <iframe src="VerReporteReimpresionSancionados.jsp" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
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

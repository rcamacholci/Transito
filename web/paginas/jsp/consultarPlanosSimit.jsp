<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>

<%
                    modelo.Model modelo = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
%>


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Consultar Planos Simit</title>
<link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
    <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
    <link href="../html/css/page2Colum.css" rel="stylesheet" type="text/css" media="screen" />
</head>
    <body>
		<form name="form" id="form" method="post" action="verPrestamos.jsp" >
	        <fieldset>
			<table>
			<tr>
				<th>CONSULTAR PLANOS SIMIT</th>
			</tr>
                        </table>

                    <iframe src="simit/verPlanosSimitGenerados.jsp" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
                        
                        
		</fieldset>
		  
        </form>
    </body>
</html>
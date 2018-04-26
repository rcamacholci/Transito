<%-- 
    Document   : generarPlanos
    Created on : 10/11/2010, 10:54:13 AM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Civitrans</title>
        <style type="text/css">
<!--
.style1 {color: #006699}
-->
        </style>
</head>
    <body>
        <form name="form" action="procesarPlano.jsp" method="POST" enctype="multipart/form-data" target="respuesta">
			<table align="center" border="0" width="100%">
				<tr>
					<td  height="40px" align="center">
			            <h1 class="style1">Generar Planos RUNT</h1>					</td>
				</tr>
				<tr>
					<td height="40px" align="center">
			           <input type="hidden" name="filename" value="placas.txt" />
			           <input type="file" name="archivo" size="80px" value="" />
					</td>	
				</tr>
				<tr>
					<td height="40px" align="center">
			            <input type="submit" name="aceptar" value="Enviar">
					</td>
				</tr>
				<tr>
					<td height="60px" align="center">
			            &nbsp;
					</td>
				</tr>
				<tr>
					<td align="center">
			            <iframe allowtransparency="0" frameborder="0" height="300px" scrolling="no" width="400px" name="respuesta"></iframe>
					</td>
				</tr>
			</table>			
        </form>
    </body>
</html>

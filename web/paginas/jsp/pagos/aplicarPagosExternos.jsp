<%-- 
    Document   : aplicarPagosExternos
    Created on : 19/04/2011, 06:19:59 PM
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
        <form name="form" action="procesarPagosExternos.jsp" method="POST" enctype="multipart/form-data" target="respuesta">
			<table align="center" border="0" width="100%">
				<tr>
					<td  height="40px" align="center">
			            <h2 class="style1">PROCESAR PLANOS DE RECAUDO OCCIDENTE</h2>					</td>
				</tr>
				<tr>
					<td height="40px" align="center">
			           <input type="hidden" name="filename" value="re.txt" />
                                   <input type="file" name="archivo" style="width:360px" value="" />
					</td>
				</tr>
				<tr>
					<td height="40px" align="center">
			            <input type="submit" name="aceptar" value="Procesar Datos">
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

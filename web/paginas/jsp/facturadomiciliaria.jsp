<%-- 
    Document   : facturadomiciliaria
    Created on : 25/05/2012, 02:13:51 PM
    Author     : Sistemas
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1"  pageEncoding="ISO-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>


<%
    modelo.Model model = (modelo.Model)session.getAttribute("model");
    if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>

<html>
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<title>Factura Domiciliaria</title>
                <script language="javascript" type="text/javascript">
           
              function mostrar(){

               window.frames[0].location.href = "verFacturaDomiciliaria.jsp?periodo="+document.form.periodo.value;
			}

            </script>

                <style type="text/css">
<!--
.style1 {
	color: #ffffff;
	font-family: Arial;
	font-size: 14px;
	font-weight: bold;
}
.style2 {
	font-family: Arial;
	font-size: 11px;
	color: #006633;
	font-weight: bold;
}
.style3 {
	font-family: Arial;
	font-size: 11px;
	color: #003366;
	font-weight: bold;
	text-align:center;
	width:100px;
}
.style4 {
	font-family: Arial;
	font-size: 9px;
	color:#006633;
	font-weight: bold;
	text-align:center;
	width:20px;
}
.style5 {
	font-family: Arial;
	font-size: 10px;
	color:#006633;
	font-weight: bold;
	text-align:center;
	width:80px;
}

-->
        </style>
</head>


    <body>
		<form name="form" id="form" method="post" action="">
			<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0">
				<tr style="border:none; background:url(../html/images/inicio_3.png)">
                                    <td colspan="8" align="center" valign="middle" height="20%"><span class="style1">FACTURA DOMICILIARIA</span></td>
				</tr>
				<tr>
					<td align="center" colspan="8" valign="middle">&nbsp;</td>
			    </tr>
				<tr>
					<td align="center" colspan="8" valign="middle">
				        <fieldset>
                                            <legend></legend>
							<table width="40%" border="0" align="center" cellpadding="0" cellspacing="0">
			
                                                            <tr align="center" class="style2">
                                                                <td colspan="1">SELECCIONE UN PERIODO</td>
                                                                <td colspan="1">
                                                                    <select name="periodo" id="periodo">
                                                                        <option value="0">***Seleccione una opcion***</option>
                                                                        <option value="1">1</option>
                                                                        <option value="2">2</option>
                                                                        <option value="3">3</option>
                                                                    </select>
                                                                </td>
								<td colspan="1"><input id="Generar" name="Generar" type="button" value="Generar" class="style5" onClick="mostrar()"/></td>
								</tr>
							</table>
                                        </fieldset>
					</td>
				</tr>
				<tr>
					<td align="center" colspan="8" valign="middle">&nbsp;</td>
			    </tr>

                        </table>
			
					      <iframe src="#" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
			
</html>
<%  }else{ %>
       <jsp:forward page="no_access.jsp">
             <jsp:param name="tipo" value="1"></jsp:param>
       </jsp:forward>
<%  } %>
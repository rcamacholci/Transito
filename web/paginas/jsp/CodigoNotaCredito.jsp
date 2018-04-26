<%-- 
    Document   : CodigoNotaCredito
    Created on : 24/05/2012, 11:48:47 AM
    Author     : Sistemas
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" errorPage="" %>

<%
    modelo.Model model = (modelo.Model)session.getAttribute("model");
    if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){

        String fecha_hoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
        %>

<html>
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
		<title>Codigo Nota Credito</title>

                <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
		<script src="../html/scripts/calendar.js" type="text/javascript"></script>
                <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
                <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
		<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>

                <script language="javascript" type="text/javascript">

           function buscarFecha(){
				if(document.form.fechaI.value.length==10){
                    if(document.form.fechaF.value.length==10){
						window.frames[0].location.href = "verNotasGenerales.jsp?fechaI="+document.form.fechaI.value+"&fechaF="+document.form.fechaF.value;
                    }else{
                        alert("Digite la fecha Final de la Busqueda");
                    }
                }else{
                     alert("Digite la fecha Inicial de la Busqueda");
                }
			}

            function GenerarCodigo(){

             <%
                     
             %>
                    
                     
                    }
		</script>
        <style type="text/css">
<!--
.Estilo2 {color: #FFFFFF; 	font-family: Tahoma; 	font-size: 12px; 	font-weight: bold; }
.style1 {
	color: #003366;
	font-family: Arial;
	font-size: 14px;
	font-weight: bold;
}
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
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
			<table width="60%" border="0"  bordercolor="#FFFFFF" align="center">
				<tr  style="border:none; background:url(../html/images/inicio_3.png)">
					<td colspan="8" align="center" valign="middle"><span class="Estilo2">CODIGO NOTAS CREDITOS</span></td>
				</tr>
				<tr>
					<td align="center" colspan="8" valign="middle">&nbsp;</td>
			    </tr>
				<tr>
					<td align="center" colspan="8" valign="middle">
				        <fieldset>
                                            <legend></legend>
							<table width="60%" border="0" align="center" cellpadding="0" cellspacing="0">
								<tr align="center" class="style2">
									<td colspan="1">&nbsp;</td>
									<td colspan="1"><span class="style2" >Fecha Actual</span> </td>
									<td colspan="1">
                                                                            <input  id="fechaI" name="fechaI" class="style3" onKeyUp="mascara(this,'/',true)" maxlength="10" readonly value="<%=fecha_hoy%>"/>
																
									</td>
									<td colspan="1">
                                                                        <td colspan="1"><span class="style2" >Codigo generado</span> </td>
									<td colspan="1">
                                                                            <%String codigo = (Encrypt.getSecurityCode(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fecha_hoy)));%>
                                                                            <input type="text" class="style3" name="codigo_generado" value="<%=codigo%>" readonly/>
									</td>
																		
								</tr>
							</table>
		 			   </fieldset>
					</td>
				</tr>


				<tr>
					<td align="center" colspan="8" valign="middle">&nbsp;</td>
			    </tr>
				<tr>
					<td colspan="8" align="center" valign="top">
					      <iframe src="#" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
					</td>
				</tr>
			</table>
        </form>
    </body>
</html>
<%  }else{ %>
       <jsp:forward page="no_access.jsp">
             <jsp:param name="tipo" value="1"></jsp:param>
       </jsp:forward>
<%  } %>
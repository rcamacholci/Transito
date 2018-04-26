<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
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
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
		<script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
		<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">
			
			function buscarR(){
				if(document.form.razonS.value!=0){
					window.frames[0].location.href = "verPersonasJuridica.jsp?razon="+document.form.razonS.value;
				}else{
                                    alert("Digite El nombre o Razon Social");
                                }
			}
                        function buscarP(){
                            var nombre1=document.form.nombre1.value;
                            var nombre2=document.form.nombre2.value;
                            var apellido1=document.form.apellido1.value;
                            var apellido2=document.form.apellido2.value;
                            if((document.form.nombre1.value==0)&&(document.form.nombre2.value==0)&&(document.form.apellido1.value==0)&&(document.form.apellido2.value==0)){
                            alert("Digite por lo menos Un Nombre O apellido");

                            }else{
                              window.frames[0].location.href = "verPersonaNatural.jsp?nombre1="+nombre1+"&nombre2="+nombre2+"&apellido1="+apellido1+"&apellido2="+apellido2;
                            }
                        }

			function ver(){
				if(document.form.busqueda[0].checked){
					document.getElementById('tabla1').style.display = "block";
					document.getElementById('tabla2').style.display = "none";
				}else{	
					document.getElementById('tabla1').style.display = "none";
					document.getElementById('tabla2').style.display = "block";
				}	
			}
			
		</script>
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
   
    <body> 
		<form name="form" id="form" method="post" action="">
	        <fieldset><div align="center">
		    <legend class="style5"  align="center">CONSULTAR&nbsp;PERSONAS</legend>
		  	</div> 
			<table width="100%" border="0" align="center">
				<tr>
				  <td colspan="2" valign="middle" align="center" width="48%"><span class="Estilo11">
				  <input type="radio" name="busqueda" value="1" checked="checked" onClick="ver()">
				  BUSQUEDA PERSONA NATURAL </span></td>
					<td colspan="1" width="4%">&nbsp;</td>
					<td colspan="2" valign="middle" align="center" width="48%"><span class="Estilo11">
				  <input type="radio" name="busqueda" value="2" onClick="ver()">
				  BUSQUEDA PERSONA JURIDICA </span></td>				
				</tr>
				<tr>
					<td colspan="5">
						<table border="0" width="100%" id="tabla1">
							  <tr valign="middle">
								 <td width="27%" scope="col" align="right"><label style="color:#666666"><span class="style5">PRIMER&nbsp;NOMBRE</span></label>							  </td>
							     <td width="20%" scope="col" align="right"><input id="nombre1" name="nombre1" type="text" style="text-align:center;color:#333333;font:bold; width:150px"/></td>
							     <td width="14%"  align="center"><label style="color:#666666"><span class="style5">SEGUNDO&nbsp;NOMBRE </span></label>							  </td>
										
							  <td width="23%" scope="col">
							    <input id="nombre2" name="nombre2" type="text" style="text-align:center;color:#333333;font:bold; width:150px"/></td>
							  <td width="16%" scope="col"><input id="consultar22"  name="consultar22" type="button" value="Consultar" style="color:#333333; width:100px" onClick="buscarP()"/></td>
							  </tr>
							<tr valign="middle">
								 <td width="27%" scope="col" align="right"><label style="color:#666666"><span class="style5">PRIMER&nbsp;APELLIDO </span></label>							  </td>
							  <td width="20%" scope="col" align="right"><input id="apellido1" name="apellido1" type="text" style="text-align:center;color:#333333;font:bold; width:150px"/></td>
							  
							  <td width="14%"  align="center"><label style="color:#666666"><span class="style5">SEGUNDO&nbsp;APELLIDO </span></label>							  </td>
																	  <td width="23%" scope="col">
							    <input id="apellido2" name="apellido2" type="text" style="text-align:center;color:#333333;font:bold; width:150px"/></td>
							                                          <td width="16%" scope="col">&nbsp;</td>
							</tr>
							
							
							<tr>
								<td colspan="5" align="center" bgcolor="#FFFFFF">
									
									<font color="#FF0000" face="Arial" style="font-size:12px; font-weight:bold">
										<label id="mensaje">
											<%=request.getParameter("respuesta")!=null?request.getParameter("respuesta"):""%>									</label>
								  </font>							  </td>
							</tr>
						</table>
						
						<table border="0" width="100%" id="tabla2" style="display:none" >
								<tr valign="middle">
								   <td width="35%" align="right"><label style="color:#666666"><span class="style5">RAZON&nbsp;SOCIAL </span></label>
								  </td>
								  <td width="49%" scope="col" align="center"><input  id="razonS" name="razonS" style="text-align:center;color:#333333;font:bold; width:300px"  />
							     </td>
								 
								 
				<td width="16%" scope="col"><input id="consultar2"  name="consultar2" type="button" value="Consultar" style="color:#333333; width:100px" onClick="buscarR()"/></td>
				
								</tr>
						</table>
					</td>
				</tr>	
           </table>
		  </fieldset>
		  <fieldset>
            <iframe src="#" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
		</fieldset>
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

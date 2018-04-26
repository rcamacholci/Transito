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
<title>Vehiculo</title>
    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
		<script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
		<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">
			
                function buscarCaja(){
                        if(document.form.placa.value.length!=0){
                                window.frames[0].location.href = "verGuiaCaja.jsp?placa="+document.form.placa.value;
                        }else{
                    alert("Digite el numero de la placa a Buscar");
                }
			}

		</script>
		<STYLE>
<!--
A.ssmItems:link		{color:black;text-decoration:none;}
A.ssmItems:hover	{color:black;text-decoration:none;}
A.ssmItems:active	{color:black;text-decoration:none;}
A.ssmItems:visited	{color:black;text-decoration:none;}
.style5 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.Estilo11 {
	color: #0066CC;
	font-weight: bold;
	font-size: 10px;
}
.style7 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
-->
        </STYLE>


</head>

    <body> 
        <form name="form" id="form" method="post" action="verGuiaCaja.jsp" target="respuesta">
	        <fieldset>
			<table width="100%" border="0" align="center">
			<tr style="border:none; background:url(../html/images/inicio_3.png)">
				<td colspan="6" align="center" valign="middle"><span class="style7">CONSULTAR GUIA CAJA </span></td>
			</tr>
				
				<tr align="center">
					<td height="50" colspan="4" align="center" >
						
						<table border="0" width="100%" id="tabla1">
								<tr valign="middle">
								<td width="10%">&nbsp;</td>
								   <td width="20%" height="26" colspan="2" align="center"><label style="color:#333333"><span class="style5">N&ordm; PLACA </span></label></td>
								   <td width="10%">&nbsp;</td>
								   <td width="20%"  colspan="2" align="center"><input  id="placa" name="placa" style="text-align:center;color:#333333;font:bold; text-transform:uppercase; width:150px" maxlength="6" />							      </td>
								  <td width="10%">&nbsp;</td>
								  
				<td width="20%" scope="col" align="center" colspan="2"><input id="consultar"  name="consultar2" type="button" value="Consultar" style="color:#333333; width:150px" onClick="buscarCaja()"/></td>
				<td width="10%">&nbsp;</td>
								</tr>
						</table>				  </td>
				</tr>	
           </table>
		  </fieldset>
            <iframe src="#" width="100%" id="respuesta" name="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
		</form>               
    </body>
</html>
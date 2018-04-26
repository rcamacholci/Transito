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

                function buscar(){
                        var nombreAgente = 0;
                        var placa = 0; 
                        if(document.form.nombre.value.length>0){
                             nombreAgente = document.form.nombre.value;
                        }
                        if(document.form.placaA.value.length>0){
                             placa = document.form.placaA.value;
                        }
                        
                        window.frames[0].location.href = "verAgente.jsp?placa="+placa+"&nombre="+nombreAgente;
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
.Estilo12 {color: #FFFFFF}
.Estilo13 {font-family: Tahoma}
.Estilo14 {font-weight: bold; font-size: 12px; color: #333333;}
.Estilo5 {color: #333333;
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
		<form name="form" id="form" method="post" action="radicarLicencia.jsp" onSubmit="return validarCampos()">
	        <fieldset><div align="center">

		  	</div>
			<table width="100%" border="0" align="center">
			<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style3 style14 style2 Estilo28 style1 Estilo12"><strong>CONSULTAR AGENTES DE TRANSITO </strong></span></td>
    </tr>
				
				<tr>
					<td colspan="4">
						
						<table border="0" width="100%" id="tabla1">
								<tr valign="middle" >
								   <td width="23%" align="right"><label style="color:#333333"><span class="style5">NOMBRE DEL AGENTE </span></label></td>
								  <td width="21%" sco pe="col" align="center">
								  <input  id="nombre" name="nombre" style="text-align:center;color:#333333;font:bold; width:300px" value=""/>							      </td>
								 
				                  <td width="9%" scope="col" align="center"><input id="consultar"  name="consultar2" type="button" value="----- Consultar -----" style="color:#333333" onClick="buscar()"/></td>
				                  <td width="8%" scope="col" align="center">&nbsp;</td>
								</tr>
								<tr valign="middle">
								   <td width="23%" align="right"><label style="color:#333333"><span class="style5">N&deg; PLACA </span></label></td>
								  <td width="21%" scope="col" align="center">
								  <input  id="placaA" name="placaA" style="text-align:center;color:#333333;font:bold; width:150px" value=""/>							      </td>
								 
				                  <td width="9%" scope="col" align="center">&nbsp;</td>
				                  <td width="8%" scope="col" align="center">&nbsp;</td>
								</tr>
								
								<tr>
								<td colspan="5" align="center" bgcolor="#FFFFFF">

									<font color="#FF0000" face="Arial" style="font-size:12px; font-weight:bold">
										<label id="mensaje">
											<%=request.getParameter("respuesta")!=null?request.getParameter("respuesta"):""%>									</label>
								  </font>							  </td>
							</tr>
						</table>

					</td>
				</tr>
           </table>
		  </fieldset>
		  <iframe src="#" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
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

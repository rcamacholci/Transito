<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("verDatosVehiculo.jsp")){
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

                         function buscarMotor(){
                            var opcion= 1;
				if(document.form.motor.value!=0){
					window.frames[0].location.href = "mostrarGuarismos.jsp?motor="+document.form.motor.value+"&opcion="+opcion;
				}else{
                                    alert("Digite El Numero del Motor");
                                }
			}
                        function buscarChasis(){
                            var opcion= 2;
				if(document.form.chasis.value!=0){
					window.frames[0].location.href = "mostrarGuarismos.jsp?chasis="+document.form.chasis.value+"&opcion="+opcion;
				}else{
                                    alert("Digite El Numero del Chasis");
                                }
			}

                        function buscarVin(){
                            var opcion= 4;
				if(document.form.vin.value!=0){
					window.frames[0].location.href = "mostrarGuarismos.jsp?vin="+document.form.vin.value+"&opcion="+opcion;
				}else{
                                    alert("Digite El numero Vin");
                                }
			}

                        function buscarSerie(){
                            var opcion= 3;
				if(document.form.serie.value!=0){
					window.frames[0].location.href = "mostrarGuarismos.jsp?serie="+document.form.serie.value+"&opcion="+opcion;
				}else{
                                    alert("Digite El numero de Serie");
                                }
			}
                        
			function ver(){
                          
                            if(document.form.busqueda[0].checked){

					document.getElementById('tabla1').style.display = "block";
					document.getElementById('tabla2').style.display = "none";
					document.getElementById('tabla3').style.display = "none";
					document.getElementById('tabla4').style.display = "none";
				}else{
                                    if(document.form.busqueda[1].checked){
					document.getElementById('tabla1').style.display = "none";
					document.getElementById('tabla2').style.display = "none";
					document.getElementById('tabla3').style.display = "block";
					document.getElementById('tabla4').style.display = "none";
                                    }else{
                                        if(document.form.busqueda[2].checked){
                                            document.getElementById('tabla1').style.display = "none";
                                            document.getElementById('tabla2').style.display = "block";
                                            document.getElementById('tabla3').style.display = "none";
                                            document.getElementById('tabla4').style.display = "none";
                                        }else{
                                            document.getElementById('tabla1').style.display = "none";
                                            document.getElementById('tabla2').style.display = "none";
                                            document.getElementById('tabla3').style.display = "none";
                                            document.getElementById('tabla4').style.display = "block";
                                        }
                                    }
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
		    <legend class="style5"  align="center">CONSULTAR&nbsp;VEHICULO</legend>
		  	</div>
			<table width="100%" border="0" align="center">
              <tr>
                <td colspan="2" valign="middle" align="center" width="25%"><span class="Estilo11">
                  <input type="radio" name="busqueda" id="busqueda" value="1" checked="checked" onClick="ver()">
                  &nbsp;POR&nbsp;MOTOR </span></td>
                <td colspan="2" valign="middle" align="center" width="25%"><span class="Estilo11">
                  <input type="radio" name="busqueda" value="3" onClick="ver()">
                  &nbsp;POR&nbsp;CHASIS </span></td>
                <td colspan="2" valign="middle" align="center" width="25%"><span class="Estilo11">
                  <input type="radio" name="busqueda" value="2" onClick="ver()">
                  &nbsp;POR&nbsp;SERIE </span></td>
                <td colspan="2" valign="middle" align="center" width="25%"><span class="Estilo11">
                  <input type="radio" name="busqueda" value="4"  onClick="ver()">
                  &nbsp;POR&nbsp;VIN </span></td>
              </tr>
              <tr>
                <td colspan="7"><table border="0" width="100%" id="tabla1">
                    <tr valign="middle">
                      <td width="27%" scope="col"  align="right" colspan="2"><label style="color:#666666"><span class="style5">NUMERO DE MOTOR </span></label></td>
                      <td width="20%" scope="col" align="center" colspan="2"><input id="motor" name="motor" type="text" style="text-align:center;color:#333333;font:bold; width:250px"/></td>
                    
                     
                      <td width="16%" scope="col" align="center"><input id="consultar22"  name="consultar22" type="button" value="Consultar" style="color:#333333; width:100px" onClick="buscarMotor()"/></td>
                    </tr>
                    
                    
                  </table>
				
                    <table border="0" width="100%" id="tabla2" align="center"  style="display:none"  >
                      <tr valign="middle">
                        <td width="39%" align="right" colspan="2"><label style="color:#666666"><span class="style5">NUMERO DE SERIE </span></label>
                        </td>
                        <td width="39%" scope="col" align="center" colspan="2"><input  id="serie" name="serie" style="text-align:center;color:#333333;font:bold; width:250px"  />
                        </td>
                        <td width="22%" scope="col" align="center"><input id="consultar2"  name="consultar2" type="button" value="Consultar" style="color:#333333; width:100px" onClick="buscarSerie()"/></td>
                      </tr>
                  </table>
				
				  <table border="0" width="100%" id="tabla3"  align="center"   style="display:none" >
                      <tr valign="middle">
                        <td width="39%" align="right"><label style="color:#666666"><span class="style5">NUMERO DE CHASIS </span></label>
                        </td>
                        <td width="39%" scope="col" align="center"><input  id="chasis" name="chasis" style="text-align:center;color:#333333;font:bold; width:250px"  />
                        </td>
                        <td width="22%" scope="col" align="center"><input id="consultar2"  name="consultar2" type="button" value="Consultar" style="color:#333333; width:100px" onClick="buscarChasis()"/></td>
                      </tr>
                  </table>
				  
				  <table border="0" width="100%" id="tabla4" align="center" style="display:none" >
                      <tr valign="middle">
                        <td width="39%" align="right"><label style="color:#666666"><span class="style5">NUMERO DE VIN </span></label>
                        </td>
                        <td width="39%" scope="col" align="center"><input  id="vin" name="vin" style="text-align:center;color:#333333;font:bold; width:250px"  />
                        </td>
                        <td width="22%" scope="col" align="center"><input id="consultar2"  name="consultar2" type="button" value="Consultar" style="color:#333333; width:100px" onClick="buscarVin()"/></td>
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

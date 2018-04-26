<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                       modelo.Model model = (modelo.Model)session.getAttribute("model");
                       
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
			
			 function mostrarPrestadas(){
                            window.frames[0].location.href = "verReportesCarpetas.jsp?num=1&fechaI="+document.form.fechaI.value+"&fechaF="+document.form.fechaF.value;
			}

                         function mostrarNoDevueltas(){
                            window.frames[0].location.href = "verReportesCarpetas.jsp?num=2";
			}

                        
			function ver(){
				if(document.form.busqueda[0].checked){
					document.getElementById('tabla2').style.display = "block";
					document.getElementById('tabla1').style.display = "none";
                               }else{
                                        document.getElementById('tabla2').style.display = "none";
                                        document.getElementById('tabla1').style.display = "block";
                                }
                       }

			function verReporte(){
				ancho = 789;
				alto = 250;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				var dir = "/carpeta/carpetas.jasper";
			    var nombre = "reporteCarpetas";
				url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
				window.open(url, 'popUp', opciones);
			}
                         function paso(){
                            if(document.form.fechaI.value.length>0){
                                if(document.form.fechaF.value.length>0){
                                    document.form.action='reporteCarpetas.jsp'
                                    document.form.submit();
                                }else{
                                    alert("Digite la fecha final del reporte Genearal");
                                }
                            }else{
                                alert("Digite la fecha inicial del reporte General");
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
    <%
   
    try {
        model = (Model) session.getAttribute("model");
    } catch (Exception exc) {
        exc.printStackTrace();
    }

     //---------------------------- reporte de tramites -------------------------------
    if(request.getParameter("fechaI")!=null&&request.getParameter("fechaF")!=null&&!request.getParameter("fechaI").isEmpty()&&!request.getParameter("fechaF").isEmpty()){
        HashMap parameters = new java.util.HashMap();
        parameters.put("FECHA_INI",request.getParameter("fechaI"));
        parameters.put("FECHA_FIN",request.getParameter("fechaF"));
        session.setAttribute("reporteCarpetas", parameters);
%>
        <script language="javascript" type="text/javascript">
               verReporte();
        </script>

<%  } %>
    <body> 
		<form name="form" id="form" method="post" action="verPrestamos.jsp" >
	        <fieldset>
			<table width="100%" border="0" align="center">
<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="6" align="center" valign="middle"><span class="style7">REPORTE DE CARPETAS</span></td>
			</tr>
				<tr>
				  <td colspan="2" valign="middle" align="center" width="50%"><span class="Estilo11">
				  <input type="radio" name="busqueda" value="1" checked="checked" onClick="ver()">
				  PRESTADAS
				  - FECHAS </span></td>
					
					
							
				</tr>
				<tr align="center">
					<td height="50" colspan="5" align="center" >
						
						
						<table border="0" width="100%" id="tabla2"   >
								<tr valign="middle">
								   <td width="27%" align="right"><label style="color:#333333"><span class="style5">FECHA&nbsp;INICIAL</span></label>
								  </td>
                                                                    <% String fecha_hoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
								  <td width="20%" scope="col" align="center"><input  id="fechaI" name="fechaI" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy%>"/>
												 <input name="bfechaI" type="button" id="bfechaI" value="<" style="width:20px">
								  <SCRIPT type="text/javascript">
														Calendar.setup({
																inputField     :    "fechaI",
																ifFormat       :    "%d/%m/%Y",
																button         :    "bfechaI"
														});
												  </SCRIPT></td>
								  <td width="14%"  align="center"><label style="color:#333333"><span class="style5">FECHA&nbsp;FINAL</span></label>
								  </td>
								  <td width="23%" scope="col"><input  id="fechaF" name="fechaF" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy%>"/>
												 <input name="bfechaF" type="button" id="bfechaF" value="<" style="width:20px">
								  <SCRIPT type="text/javascript">
														Calendar.setup({
																inputField     :    "fechaF",
																ifFormat       :    "%d/%m/%Y",
																button         :    "bfechaF"
														});
												  </SCRIPT></td>
				<td width="8%" scope="col"><input id="consultar"  name="consultar2" type="button" value="Consultar" style="color:#333333; width:70px" onClick="mostrarPrestadas()"/></td>
				<td width="8%" scope="col" align="center">
						<input id="reporte"  name="reporte" type="button" value="Reporte" style="color:#333333; width:70px" onClick="paso()"/></td>
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
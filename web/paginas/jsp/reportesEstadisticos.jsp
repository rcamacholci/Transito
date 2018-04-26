<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("reportesEstadisticos.jsp")||true){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
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


            function paso(){
		if(document.form.fecha_ini.value.length>0){
			if(document.form.fecha_fin.value.length>0){
                                document.form.action='reportes.jsp'
				document.form.submit();
			}else{
				alert("Digite la fecha final del reporte Genearal");
			}
		}else{
			alert("Digite la fecha inicial del reporte General");
		}
           }

           function verReporte(){
                //document.form.motor.value
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width-ancho)/2 : 100;
                arriba = (document.height) ? (document.height-alto)/2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + 			ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "tramites/estadisticaTramiteServicios.jasper";
                var nombre = "estadisticaTramiteServicios";
                url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
                window.open(url, 'popUp', opciones);
            }

          	</script>
        <style type="text/css">
<!--
.style1 {
	color: #333333;
	font-weight: bold;
	font-size: 12px;
}
.style2 {color: #333333}
-->
        </style>
</head>
<%
   //---------------------------- reporte de tramites -------------------------------
    if(request.getParameter("fecha_ini")!=null&&request.getParameter("fecha_fin")!=null){
        HashMap parameters = new java.util.HashMap();
        parameters.put("USUARIO", usuario.getNombre());
        parameters.put("FECHA_INI",request.getParameter("fecha_ini"));
        parameters.put("FECHA_FIN",request.getParameter("fecha_fin"));
        session.setAttribute("estadisticaTramiteServicios", parameters);
%>
        <script language="javascript" type="text/javascript">
               verReporte();
	</script>

<%  } %>

    <body>

        <form name="form" id="form" method="post" action="">
            <table width="60%" border="0" align="center">
            	 <tr style="border:none;">
			<td colspan="5" align="center">&nbsp;</td>
		  </tr>
                  <tr>
                    <td colspan="5">
					        <fieldset>
			<legend class="style1">REPORTE TRAMITES Y SERVICIOS</legend>
			<table border="0" width="90%" id="Ttabla1" align="center">
                            <tr valign="middle">
                              <td width="15%" scope="col"  align="center" colspan="2"><span class="style7" style="font-size: 11px"><strong>
                                <label style="color:#333333">FECHA&nbsp;INICIAL </label>
                                </strong></span>                              </td>
                              <td width="30%" scope="col" align="center" colspan="2"><span class="style7" style="font-size: 11px"><span class="style7" style="font-size: 11px">
                                <input id="fecha_ini" name="fecha_ini" type="text" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333;font:bold; width:100px" value="<%=(request.getParameter("fecha_ini")!=null?request.getParameter("fecha_ini"):"")%>"/>
                                </span>&nbsp;
                              <input name="bfecha" type="button" id="bfechaIT" value="..." style="width:20px">
					    <SCRIPT type="text/javascript">
                                                        Calendar.setup({
                                                                        inputField     :    "fecha_ini",
                                                                        ifFormat       :    "%d/%m/%Y",
                                                                        button         :    "bfechaIT"
                                                        });
                                          </SCRIPT>

					  </span></td>
<td width="15%" scope="col"  align="center" colspan="2"><span class="style7 style2" style="font-size: 11px"> 
					    <label style="color:#333333"><strong>FECHA&nbsp;FIN </strong></label>
				  					      </span></td>
					  <td width="30%" scope="col" align="center" colspan="2"><span class="style7" style="font-size: 11px">
				      <input id="fecha_fin" name="fecha_fin" type="text" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333;font:bold; width:100px" value="<%=(request.getParameter("fecha_fin")!=null?request.getParameter("fecha_fin"):"")%>"/>
				      &nbsp;
                      <input name="bfechaFT" type="button" id="bfechaFT" value="..." style="width:20px">
					    <SCRIPT type="text/javascript">
                                            Calendar.setup({
                                                            inputField     :    "fecha_fin",
                                                            ifFormat       :    "%d/%m/%Y",
                                                            button         :    "bfechaFT"
                                            });
                                          </SCRIPT>

					  </span></td>


                      <td width="10%" scope="col" align="center"><input  name="generar1" type="submit" id="generar1" style="width:100px" value="Ver Reporte"/></td>
                    </tr>
                  </table>
				   </fieldset>
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

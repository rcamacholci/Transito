<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("reporteInscripciones.jsp")){
                    modelo.Model modelo = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                     String fecha_hoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());

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
                <script src="../html/scripts/personas.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">
     
            function paso(){
		if(document.form.fecha_ini.value.length>0){
			if(document.form.fecha_fin.value.length>0){
                                document.form.action='reporteInscripciones.jsp'
				document.form.submit();
			}else{
				alert("Digite la fecha final del reporte");
			}
		}else{
			alert("Digite la fecha inicial del reporte");
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
                var dir = "reportes/reporteInscripcion.jasper";
                var nombre = "REPORTE_INSCRIPCIONES";
                url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
                window.open(url, 'popUp', opciones);
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
.style7 {font-family: Tahoma; font-weight: bold; color: #333333; }
.style8 {color: #333333}
.style9 {font-size: 10px}
.style10 {
	font-size: 10px;
	color: #333333;
	font-weight: bold;
	font-family: Tahoma;
}
.style13 {font-size: 11px; color: #333333; font-weight: bold; font-family: Tahoma; }
.style14 {
	color: #FFFFFF;
	font-family: Tahoma;
	font-weight: bold;
	font-size: 12px;
}
-->
        </STYLE>


</head>
<%
   //---------------------------- reporte de tramites -------------------------------
    if(request.getParameter("fecha_ini")!=null&&request.getParameter("fecha_fin")!=null&&!request.getParameter("fecha_ini").isEmpty()&&!request.getParameter("fecha_fin").isEmpty()){
        long user = 0;

        if(request.getParameter("usuario")!=null&&!request.getParameter("usuario").equals("")){
            user = Long.parseLong(request.getParameter("usuario"));
        }

        HashMap parameters = new java.util.HashMap();
        parameters.put("FK_USUARIO", user);
        parameters.put("FECHA_INI",request.getParameter("fecha_ini"));
        parameters.put("FECHA_FIN",request.getParameter("fecha_fin"));
        session.setAttribute("REPORTE_INSCRIPCIONES", parameters);
%>
        <script language="javascript" type="text/javascript">
               verReporte();
               document.location = "reporteInscripciones.jsp";
	</script>

<%  }



%>


    <body>

		<form name="form" id="form" method="post" action="">
	        <fieldset>
			<table width="100%" border="0" align="center">
				<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="13" align="center"><span class="style2 style14">REPORTE DE INSCRIPCIONES AL RUNT</span></td>
		  </tr>
                <tr valign="middle">
                      <td scope="col"  align="center" colspan="2"><label style="color:#666666"><span class="style5"><span class="style9">FECHA&nbsp;INICIAL</span></span></label></td>
                      <td scope="col" align="center" colspan="2"><input id="fecha_ini" name="fecha_ini" value="<%=fecha_hoy%>" type="text" style="text-align:center;color:#333333;font:bold; width:100px"/>&nbsp;
                      <input name="bfechaIT" type="button" id="bfechaIT" value="..." style="width:20px">
					  <SCRIPT type="text/javascript">
													Calendar.setup({
															inputField     :    "fecha_ini",
															ifFormat       :    "%d/%m/%Y",
														button         :    "bfechaIT"
													});
											  </SCRIPT>

					  </td>
					  <td width="10%" align="center"><span class="style10">USUARIO</span></td>
					  <td width="15%"><span style="font-size: 10px">
					   <select name="usuario" id ="usuario"  style=" width:200px; color:#333333; font-size:11px">
                                               <option value="0"> -- Seleccione un Usuario -- </option>
                                           <%

                                                Usuario listU = null;
                                                java.util.List lista = modelo.ListarUsuario();
                                                java.util.Iterator iterator = lista.iterator();
                                                while (iterator.hasNext()) {
                                                    listU = (modelo.Usuario)iterator.next();
                                                    if(listU.getFechaFin()==null){ %>

                                                        <option value="<%=listU.getId_usuario()+""%>"><%=listU.getNombre()%></option>
                                              <%    }
                                                 } %>
                                         </select>
                          		  </span></td>
					  <td scope="col"  align="center" colspan="2"><label style="color:#666666"><span class="style5 style9">FECHA&nbsp;FIN </span></label></td>
                      <td width="24%" scope="col" align="center" colspan="2"><input id="fecha_fin" name="fecha_fin" value="<%=fecha_hoy%>" type="text" style="text-align:center;color:#333333;font:bold; width:100px"/>&nbsp;
                      <input name="bfechaFT" type="button" id="bfechaFT" value="..." style="width:20px">
					  <SCRIPT type="text/javascript">
													Calendar.setup({
															inputField     :    "fecha_fin",
															ifFormat       :    "%d/%m/%Y",
															button         :    "bfechaFT"
													});
											  </SCRIPT>

					  </td>
                                            <td width="20%" scope="col" align="center"><input id="generar"  name="generar" type="button" value="Generar" style="color:#333333; width:100px" onClick="paso()"/></td>



                    </tr>
             
            </table>
	        </fieldset>
		  </br>




  </br>






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

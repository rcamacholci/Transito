<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
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


            function paso(){
                                if(document.form.placa.value.length>0){
                                    document.form.action='CertificadoTradicionJudiciales.jsp'
                                    document.form.submit();
                                }else{
                                    alert("Digite Una PLaca");
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
                var dir = "certificados/RVehiculoB.jasper";
                var nombre = "tradicion";
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
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style7 {font-family: Tahoma; font-weight: bold; color: #333333; }
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
   
   
   String placa = "", mensaje = "", Propiet = "";
   Vehiculo vehiculo = null;
   if(request.getParameter("placa")!=null&&!request.getParameter("placa").isEmpty()){
       placa = request.getParameter("placa");
         vehiculo = modelo.consultarVehiculo(placa.toUpperCase());
            if(vehiculo!=null){
                Propietario propietario = modelo.getUnicoPropietarioVehiculo(vehiculo.getId_vehiculo());
                if(propietario!=null){
                    Persona persona = modelo.consultarPersona(propietario.getFk_persona());
                        if(persona!=null){
                            Propiet = persona.getNombre_1()+" "+persona.getApellido_1();
                        }
                }
                 Licencia_Transito licencia =null;
                 String licenciaTransito = "";
                 licencia = modelo.consultarLicenciaTransito(vehiculo.getId_vehiculo());
                     if(licencia!=null){
                        licenciaTransito = licencia.getNumero();
                     }
                        String clase = modelo.consultarParametroName(1,(int)vehiculo.getClase_vehiculo());
                        String servicio = modelo.consultarParametroName(3,(int)vehiculo.getServicio());
                        DatosVehiculo dvModalidad = modelo.consultarDatosVehiculo(vehiculo.getId_vehiculo(), 1, 324);
                        DatosVehiculo dvCombustible = modelo.consultarDatosVehiculo(vehiculo.getId_vehiculo(), 1, 75);
                        String modalidad = "";

                               if(dvModalidad!=null) {
                                        modalidad = modelo.consultarParametroName(324,Integer.parseInt(dvModalidad.getValor()));
                                }

                        String combustible ="";
                        if(dvCombustible!=null){
                         combustible = modelo.consultarParametroName(75,Integer.parseInt(dvCombustible.getValor()));
                        }
                        String color =  modelo.consultarColor(vehiculo.getPlaca());
                        java.util.HashMap especificaciones = modelo.listarEspecificacionesVehiculo(vehiculo.getPlaca().toUpperCase());
                        java.util.HashMap caracteristicas = modelo.listarCaracteristicasVehiculo(vehiculo.getPlaca().toUpperCase());
                        Linea linea = modelo.getLinea(vehiculo.getFk_linea());
                        Marca marca = modelo.consultaMarca(vehiculo.getPlaca());
                        String estadoV = modelo.consultarParametroName(66, (int)(vehiculo.getEstado()));
                    if(especificaciones!=null){
                         HashMap parameters = new java.util.HashMap();
                         parameters.put("PLACA",vehiculo.getPlaca());
                         parameters.put("CLASE",clase);
                         parameters.put("PROPIETARIO",Propiet);
                         parameters.put("MODELO",""+vehiculo.getModelo());
                         parameters.put("MOTOR",especificaciones.get("19")!=null?especificaciones.get("19"):"");
                         parameters.put("LINEA",linea.getNombre());
                         parameters.put("CHASIS",especificaciones.get("20")!=null?especificaciones.get("20"):"");
			 parameters.put("SERIE",especificaciones.get("21")!=null?especificaciones.get("21"):"");
                         parameters.put("TIPO",caracteristicas.get("2")!=null?modelo.consultarParametro(Integer.parseInt(caracteristicas.get("2").toString()),2).getNombre():"");
                         parameters.put("ESTADO",estadoV);
                         parameters.put("SERVICIO",servicio);
                         parameters.put("USUARIO", usuario.getNombre());
                         parameters.put("MARCA",marca.getNombre());
			 parameters.put("EJES",especificaciones.get("9")!=null?especificaciones.get("9"):"");
                         parameters.put("COMBUSTIBLE",combustible);
                         parameters.put("MODALIDAD",modalidad);
                         parameters.put("VIN",especificaciones.get("25")!=null?especificaciones.get("25"):"");
                         parameters.put("CILINDRADA",especificaciones.get("11")!=null?especificaciones.get("11"):"");
			 parameters.put("COLOR",color);
			 parameters.put("CAPACIDAD",especificaciones.get("2")!=null?especificaciones.get("2"):"");
                         if(vehiculo.getEstado()==4){
                            Movimiento mov = modelo.ConsultarMovimientoVehiculo(vehiculo.getId_vehiculo());
                            if(mov!=null){
                                Sede sedeM = modelo.consultarSede(mov.getFk_sede());
                                parameters.put("TRASLADADO",sedeM.getNombre());
                                System.out.println("fecha traslado : "+mov.getFecha_movimiento().toString());
                                parameters.put("FECHA_T",mov.getFecha_movimiento().toString());
                            }
                         }



                         session.setAttribute("tradicion", parameters);
             %>
                         <script language="javascript" type="text/javascript">
                            verReporte();
                        </script>

<%               }

            }else{%>
              <script language="javascript" type="text/javascript">
                           alert("mensaje : EL VEHICULO NO SE ENCUENTRA REGISTRADO O ESTA INACTIVO");
             </script>
               
           <% }

    }%>
 

    <body>
	 
		<form name="form" id="form" method="post" action="">
	        <fieldset>		    
			<table width="100%" border="0" align="center">
				<tr style="border:none; background:url(../html/images/inicio_3.png)">
					<td colspan="3" align="center"><span class="style2 style14">IMPRIMIR CERTIFICADOS A ENTES JUDICIALES </span></td>
		      	<tr>
					<tr valign="middle">
					<td width="33%"  align="center" scope="col" ><span class="style7" style="font-size: 11px">
                      <label style="color:#333333"><span class="style7" style="font-size: 11px"><span class="style7" style="font-size: 12px">PLACA</span></span></label>
					</span></td>
					<td width="33%" align="center">
					  <input id="placa" name="placa" type="text"  maxlength="6" style="text-align:center;color:#333333;font:bold; width:120px; text-transform:uppercase"/>
					</td>
                      <td width="33%" colspan="2"  align="center" scope="col">
<button name="generar1" type="button" id="generar1" onClick="paso()"><span class="style2">Generar Certificado</span><img src="../html/images/PDF.png"  width="19" height="18"/></button>					  <!-- <input  name="generar1" type="button" id="generar1" style="width:150px" onClick="paso()" value="Generar Certificado"/> --></td>
                     
                     
                    </tr>
					
                  </table>



                    
				 
				 	  			  
			  
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

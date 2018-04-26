<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                    modelo.Model modelo = (modelo.Model)session.getAttribute("model");
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
                      if(document.getElementById("tipo").value!=0){
                            if(document.form.fechaExp.value.length>0){
                                    if(document.form.fechaVen.value.length>0){
                                        document.form.action='ImprimirPermiso.jsp'
                                        document.form.submit();
                                    }else{
                                        alert("Digite la fecha de Vencimiento");
                                    }
                            }else{
                                    alert("Digite la fecha de Expedicion");
                            }
                       }else{
                            alert("Digite la fecha de Expedicion");
                       }
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
                var dir = "certificados/PERMISO_TRANSITO.jasper";
                var nombre = "Permiso";
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
.style7 {font-family: Tahoma; font-weight: bold; color: #333333; }
.style8 {color: #333333}
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
   String placa = "", mensaje = "", Propiet = "",tipo = "";
   Vehiculo vehiculo = null;
   if(request.getParameter("placa")!=null&&!request.getParameter("placa").isEmpty()&&request.getParameter("fechaVen")!=null&&request.getParameter("fechaExp")!=null&&request.getParameter("tipo")!=null&&!request.getParameter("fechaVen").isEmpty()&&!request.getParameter("fechaExp").isEmpty()&&!request.getParameter("tipo").isEmpty()){
       placa = request.getParameter("placa");
         vehiculo = modelo.consultarVehiculo(placa);
            if(vehiculo!=null){
                if(Integer.parseInt(request.getParameter("tipo"))==1){
                    tipo = "MATRICULA INICIAL";
                }else{
                     if(Integer.parseInt(request.getParameter("tipo"))==2){
                        tipo = "RADICACION DE CUENTA";
                     }else{
                          if(Integer.parseInt(request.getParameter("tipo"))==3){
                            tipo = "DUPLICADO DE PLACAS";
                          }
                     }
                }


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
                 System.out.println("tipo : "+tipo);
                String clase = modelo.consultarParametroName(1,(int)vehiculo.getClase_vehiculo());
                java.util.HashMap especificaciones = modelo.listarEspecificacionesVehiculo(vehiculo.getPlaca().toUpperCase());
                java.util.HashMap caracteristicas = modelo.listarCaracteristicasVehiculo(vehiculo.getPlaca().toUpperCase());
                Linea linea = modelo.getLinea(vehiculo.getFk_linea());
                Marca marca = modelo.consultaMarca(vehiculo.getPlaca());
                    if(especificaciones!=null){
                         HashMap parameters = new java.util.HashMap();
                        // parameters.put("ID_VEHICULO",vehiculo.getId_vehiculo());
                         parameters.put("LICENCIAT",!licenciaTransito.equals("")?licenciaTransito:vehiculo.getPlaca());
                         parameters.put("FECHA_EXP", request.getParameter("fechaExp"));
                         parameters.put("FECHA_VEN",request.getParameter("fechaVen"));
                         parameters.put("PLACA",vehiculo.getPlaca());
                         parameters.put("TIPO",tipo);
                         parameters.put("CLASEV",clase);
                         parameters.put("PROPIETARIO",Propiet);
                         parameters.put("MODELO",""+vehiculo.getModelo());
                         parameters.put("MOTOR",especificaciones.get("19")!=null?especificaciones.get("19"):"");
                         parameters.put("LINEA",linea.getNombre());
                         parameters.put("CHASIS",especificaciones.get("20")!=null?especificaciones.get("20"):"");
                         parameters.put("MARCA",marca.getNombre());
                         session.setAttribute("Permiso", parameters);
             %>
                         <script language="javascript" type="text/javascript">
                            verReporte();
                        </script>

<%               }

            }else{
                mensaje = "EL VEHICULO NO SE ENCUENTRA REGISTRADO O ESTA INACTIVO";
            }

    }%>
 

    <body>
	 
		<form name="form" id="form" method="post" action="">
	        <fieldset>		    
			<table width="100%" border="0" align="center">
				<tr style="border:none; background:url(../html/images/inicio_3.png)">
					<td colspan="11" align="center"><span class="style2 style14">IMPRIMIR PERMISO </span></td>
		      	<tr>
					<tr valign="middle">
					<td width="5%" colspan=""  align="center" scope="col"><span class="style7" style="font-size: 11px">
                        <label style="color:#333333"><span class="style7" style="font-size: 11px"><span class="style7" style="font-size: 11px">PLACA</span></span></label></span></td>
					<td width="11%"><span class="style7" style="font-size: 11px"><span class="style7" style="font-size: 11px"><span class="style7" style="font-size: 11px"><span class="style7" style="font-size: 11px"><span class="style7" style="font-size: 11px"><span class="style7" style="font-size: 11px">
					  <input id="placa" name="placa" type="text" style="text-align:center;color:#333333;font:bold; width:100px"/>
					</span></span></span></span></span></span></td>
					<td width="6%"><span class="style7" style="font-size: 11px">TIPO</span></td>
					<td width="16%"><span class="style7" style="font-size: 11px"><span style="font-size: 10px">
					  <select name="tipo" id="tipo"  style="width:180px; font-size:10px; color:#333333">
                        <option value="0"><<--Seleccione Documento-->></option>
                        <option value="1">Matricula Inicial</option>
                        <option value="2">Radicado de Cuenta</option>
                        <option value="3">Duplicado de Placas </option>
                       
                      </select>
					</span></span></td>
                      <td width="14%" colspan=""  align="center" s><span class="style7" style="font-size: 11px">
                        <label style="color:#333333">FECHA EXPEDICION </label>
                      </span></td>
                      <td width="16%" colspan="" align="center"><span class="style7" style="font-size: 11px"><span class="style7" style="font-size: 11px">
                        <input id="fechaExp" name="fechaExp" type="text" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333;font:bold; width:100px"/>
                      </span>&nbsp;
                      <input name="bfechaE" type="button" id="bfechaE" value="<" style="width:20px">
					    <SCRIPT type="text/javascript">
                                                        Calendar.setup({
                                                                        inputField     :    "fechaExp",
                                                                        ifFormat       :    "%d/%m/%Y",
                                                                        button         :    "bfechaE"
                                                        });
                                          </SCRIPT>
					  
					  </span></td>
					  <td width="16%" colspan=""  align="center" scope="col"><span class="style7" style="font-size: 11px">
					    <label style="color:#666666"><span class="style8">FECHA&nbsp;VENCIMIENTO </span></label>
				      </span></td>
					  <td width="16%" colspan="" align="center" scope="col"><span class="style7" style="font-size: 11px">
				      <input id="fechaVen" name="fechaVen" type="text" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333;font:bold; width:100px"/>
				      &nbsp;
                      <input name="bfechaV" type="button" id="bfechaV" value="<" style="width:20px">
					    <SCRIPT type="text/javascript">
                                            Calendar.setup({
                                                            inputField     :    "fechaVen",
                                                            ifFormat       :    "%d/%m/%Y",
                                                            button         :    "bfechaV"
                                            });
                                          </SCRIPT>
					  
					  </span></td>
                    </tr>
					 <tr valign="middle">
				  		<td scope="col"  align="center" colspan="8"><input  name="generar1" type="button" id="generar1" style="width:150px" onClick="paso()" value="Generar Permiso"/></td>
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

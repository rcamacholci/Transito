<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
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
                                if(document.form.numOficio.value.length>0){
                                      if(document.form.fechaO.value.length>0){
                                            document.form.action='ImprimirOficioEmbargo.jsp'
                                            document.form.submit();
                                      }else{
                                          alert("Digite la fecha del Oficio");
                                      }
                                }else{
                                    alert("Digite el Nro del Oficio");
                                }
           }



           function verReporte(){
            ancho = 789;
            alto = 250;
            barra = 0;
            izquierda = (document.width) ? (document.width-ancho)/2 : 100;
            arriba = (document.height) ? (document.height-alto)/2 : 100;
            opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
            var dir = "/recaudoycartera/embargos/SolicitudEmbargo.jasper";
            var nombre = "Oficios";
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
  modelo.Model modelo = (modelo.Model)session.getAttribute("model");
  modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");

   String numOficio = "",mensaje="";
   java.sql.Date fechaO;
   
   if(request.getParameter("numOficio")!=null&&!request.getParameter("numOficio").isEmpty()){
        if(request.getParameter("fechaO")!=null&&!request.getParameter("fechaO").isEmpty()){
            numOficio = request.getParameter("numOficio");
            fechaO = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaO")).getTime());
            Oficio_Embargo oficioE = modelo.consultarOficiosEmbargosByNumeroFecha(numOficio,fechaO);
            if(oficioE!=null){
                if(oficioE.getEstado()==2){ 

                HashMap parameters = new java.util.HashMap();
                Usuario usu = modelo.consultarUsuario(usuario.getId_usuario());
                    if(usu!=null){
                        Persona Per_usuario = modelo.consultarPersona(usu.getFk_persona());
                        parameters.put("USUARIO", Per_usuario.getNombre_1()+" "+Per_usuario.getApellido_1());
                    }
                Vehiculo vehiculo = modelo.consultarVehiculoById(oficioE.getFk_vehiculo());
                if(vehiculo!=null){
                    Embargo embargo = modelo.consultarEmbargo(oficioE.getFk_embargo());
                        if(embargo!=null){

                            Parametro proceso = modelo.consultarParametro(embargo.getProceso(), 23);

                            Propietario prop = modelo.getUnicoPropietarioVehiculo(vehiculo.getId_vehiculo());
                                if(prop!=null){
                                    Persona propietario = modelo.consultarPersona(prop.getFk_persona());
                                        if(propietario!=null){

                                            parameters.put("ID_OFICIO",oficioE.getId_oficio());
                                            parameters.put("PLACA",vehiculo.getPlaca());
                                            parameters.put("PROCESO",proceso.getNombre());
                                            parameters.put("DEMANDANTE", embargo.getDemandante());
                                            parameters.put("PROPIETARIO", propietario.getNombre_1()+" "+propietario.getApellido_1());
                                            session.setAttribute("Oficios", parameters);
                                           %>
                                            <script language="javascript" type="text/javascript">
                                            verReporte();
                                            </script>
                                            <%
                                            }
                                }
                       }
                    }
                }else{
                %>
                 <script language="javascript" type="text/javascript">
                     alert("La novedad aun no ha sido registrada");
                 </script>

                <%}

            }else{
            %>
             <script language="javascript" type="text/javascript">
                 alert("no se encontro registro");
             </script>
<%
            }
            
    }
        }%>


    <body>

		<form name="form" id="form" method="post" action="">
	        <fieldset>
			<table width="100%" border="0" align="center">
				<tr style="border:none; background:url(../html/images/inicio_3.png)">
					<td colspan="5" align="center"><span class="style2 style14">IMPRIMIR OFICIO DE EMBARGOS </span></td>
		      	<tr>
					<tr valign="middle">
					<td width="20%"  align="center" scope="col" ><span class="style7" style="font-size: 11px">
                      <label style="color:#333333"><span class="style7" style="font-size: 11px"><span class="style7" style="font-size: 12px">N&deg; OFICIO </span></span></label>
					</span></td>
					<td width="20%" align="center">
					  <input id="numOficio" name="numOficio" type="text"  style="text-align:center;color:#333333;font:bold; width:120px; text-transform:uppercase"/>
					</td>
					<td width="20%"  align="center" scope="col" ><span class="style7" style="font-size: 11px">
                      <label style="color:#333333"><span class="style7" style="font-size: 11px"><span class="style7" style="font-size: 12px">FECHA OFICIO </span></span></label>
					</span></td>
					<td width="20%">
						  <span class="Estilo8">
						    	<input id="fechaO" name="fechaO" type="text" value="" style=" width:100px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333; text-align:center" onKeyUp="mascara(this,'/',true)" maxlength="10"/>
					  </span>					  <input name="btfechaO" type="button" id="btfechaO" value="&lt;" style="width:20px; text-align:center"/>
					     <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fechaO",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "btfechaO"   // el id del bot?n que lanzar? el calendario
			});
		 </script>
					  </td>
                      <td width="20%"   align="center" scope="col"><input  name="generar1" type="button" id="generar1" style="width:150px" onClick="paso()" value="Generar Solicitud"/></td>


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
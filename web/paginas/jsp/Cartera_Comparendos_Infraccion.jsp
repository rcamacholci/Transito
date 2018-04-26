<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
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

<script language="javascript" type="text/javascript">
    
function paso(){
    var infrac = window.document.form.infracciones.value;
    window.document.location.href = "Cartera_Comparendos_Infraccion.jsp?tipo=1&infraccion="+infrac;
}

//function paso2(){
//var perfUsuario = window.document.form.perfilusuario.value;
//window.document.location.href = "consultarPerfilUsuario.jsp?tipo=2&usuario="+perfUsuario;
//}
			  
function verReporteInfracciones(){
    ancho = 789;
    alto = 600;
    barra = 0;
    izquierda = (document.width) ? (document.width-ancho)/2 : 100;
    arriba = (document.height) ? (document.height-alto)/2 : 100;
    opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + 			ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
    var dir = "recaudoycartera/taquillas/Cartera_Comparendos_Infraccion.jasper";
    var nombre = "carteracomparendosinfraccion";
    url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
    window.open(url, 'popUp', opciones);
}

function GenerarReporte(){
    ancho = 789;
    alto = 550;
    barra = 0;
    izquierda = (document.width) ? (document.width-ancho)/2 : 100;
    arriba = (document.height) ? (document.height-alto)/2 : 100;
    opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
    var dir = "recaudoycartera/taquillas/Caja_General_Comparendos.jasper";
    var nombre = "resportecarterageneraldepago";
    url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
    window.open(url, 'popUp', opciones);
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
<style type="text/css">
<!--
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style3 {color: #FFFFFF}
.style31 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
.Estilo2 {
	color: #FFFFFF;
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
}
-->
</style>
</head>
    <%
    Model model = null;
    Usuario usuario = new Usuario ();
     Sede sede = (Sede) session.getAttribute("sede");
     java.util.List<Infraccion> infraccion = null;
    try {
        model = (Model) session.getAttribute("model");
    } catch (Exception exc) {
        exc.printStackTrace();
    }
try{
     if(request.getParameter("tipo")!=null&&!request.getParameter("tipo").isEmpty()){
    System.out.println("tipo:"+request.getParameter("tipo").equals("1"));
    }
    if(request.getParameter("tipo").equals("1")){
   if(request.getParameter("infraccion")!=null&&!request.getParameter("infraccion").isEmpty()){
        long id_infracccion2 = Long.parseLong(request.getParameter("infraccion"));
        System.out.println("Infracción : "+id_infracccion2);
        HashMap parameters = new java.util.HashMap();
        parameters.put("INFRACCION",id_infracccion2);
        session.setAttribute("carteracomparendosinfraccion", parameters);
%>
        <script language="javascript" type="text/javascript">
              verReporteInfracciones();
	</script>

<% }
     }
%>
      

<%  
     }catch (Exception exc) {
        exc.printStackTrace();
    }
    %>

    <body> 
	<form name="form" id="form" method="post" action="" onSubmit="">
	       
		<table width="100%" border="0"  bordercolor="#FFFFFF" align="center" >
				<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="Estilo2">CONSULTAR CARTERAS POR COMPARENDOS POR INFRACCI&Oacute;N </span></td>
	    </tr>
				<tr>
					<td colspan="5">
								
				  </td>
				</tr>	
      </table>
		   <table width="100%" height="55" border="0" align="center">
				<tr>
				  <td width="50%" height="46" colspan="2" align="center" valign="middle"><span class="style2">
				  <input type="radio" name="busqueda" value="1" checked="checked" onClick="ver()">
				  CARTERA COMPARENDOS POR INFRACCION 
				  </span></td>
					<td colspan="1" valign="middle" align="center" width="50%"><span class="style2">
				  <input type="radio" name="busqueda" value="1" onClick="ver()">
				  CARTERA DE COMPARENDOS GENERAL 
					</span></td>
				</tr>
				<tr>
					
<table border="0" width="100%" id="tabla1" align="center">
  <tr  align="center" valign="middle">
         <td width="46%" scope="col" align="right"><label style="color:#333333"><span class="style2">DESCRIPCIÓN DE LA INFRACCIÓN</span></label>							  </td>
         <td width="15%" scope="col" align="left">
<select name="infracciones"  id="infracciones"   style=" width:400px; color:#333333; font-size:12px">
             <option value="0">-- Seleccione una infracción --</option>
      <%
     infraccion  = model.listarInfracciones();
 if(infraccion.size()>0){
        for(int i=0;i<infraccion.size();i++){
        Infraccion infraccion2 = infraccion.get(i);%>
     <option value="<%=infraccion2.getId_infraccion()%>"> <%=infraccion2.getDescripcion()%></option>
     <% }
  }%>
       </select>
  </td>

<td width="39%" align="right">
<button id="consultar"  name="consultar" type="button" onClick="paso()"><span class="style2">Reporte</span><img src="../html/images/PDF.png" width="19" height="18"/></button>
<!--<input id="consultar"  name="consultar" type="button" value="Consultar" style="color:#333333" onClick="paso()" /> --></td>
</tr>
</table>

<table border="0" width="100%" id="tabla2" style="display:none" align="center"> 
<tr  valign="middle" align="center">
            <td colspan="2" width="15%" scope="col" align="center">
<%
HashMap parameters = new java.util.HashMap();
parameters.put("USUARIO", usuario.getNombre());
session.setAttribute("resportecarterageneraldepago", parameters);
%>
<button d="generar"  name="generar" type="button" onClick="GenerarReporte()"><span class="style2">Reporte</span><img src="../html/images/PDF.png"  width="19" height="18"/></button>
<!-- <input id="generar"  name="generar" type="button" value="Generar" style="color:#333333; width:100px" onClick="GenerarReporte()"/>--></td>
        
        </tr>
                  </table>
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

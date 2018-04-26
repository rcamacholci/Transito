<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarAlertasVehiculo.jsp")){
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Alertas</title>
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<link rel=StyleSheet href="../html/css/msj.css" Ttype="text/css" media=screen>
<script type="text/javascript" src="../html/scripts/calendar.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
<script type="text/javascript" src="../html/scripts/alertas.js"></script>
<script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<style type="text/css">
<!--
.Estilo13 {color: #FFFFFF; font-weight: bold; }
.Estilo20 {font-size: 12px; font-weight: bold; color: #333333; }
.style1 {
	color: #333333;
	font-size: 12px;
	font-family: Tahoma;
}
.style4 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.style6 {font-size: 12px; font-weight: bold; color: #333333; }

.style3 {
	color: #333333;
	font-size: 12px;
}
.style7 {
	color: #333333;
	font-size: 12px;
	font-weight: bold;
	font-family: Tahoma;
}
.style9 {color: #333333; font-size: small; font-weight: bold; font-family: Tahoma; }
.style10 {font-size: small}
.Estilo12 {
	color: #333333;
	font-size: 10px;
}
.Estilo15 {color: #333333; font-size: 10px; font-weight: bold; font-family: Tahoma; }
.Estilo16 {font-size: 10px}



-->
</style>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
Model modelo= (Model)session.getAttribute("model"); 
String placa = "";
if(request.getParameter("id")=="0"){
	placa =  request.getParameter("placa");
}else{
	placa =  session.getAttribute("placa")+"";
}
if(placa!=null){
Vehiculo vehiculo  = new Vehiculo();
vehiculo=modelo.consultarVehiculo(placa.toUpperCase());
if (vehiculo!=null){


%>
<body>
<table width="90%" border="1" cellpadding="1" cellspacing="0">
   <tr  style="border:none; background:url(../html/images/inicio_3.png)">
    <td width="18%" style="border:none"><div align="center" class="style4">TIPO&nbsp;ALERTA </div></td>
    <td width="45%" style="border:none"><div align="center" class="style4">OBS. DEMANDANTE</div></td>
   <td width="10%" style="border:none"><div align="center" class="style4">GRADO</div></td>
    <td width="13%" style="border:none"><div align="center" class="style4">F.&nbsp;INICIO </div></td>
	<td width="14%" style="border:none"><div align="center" class="style4">F.&nbsp;FINAL</div></td>
  </tr>
  <%
  
   java.util.List lista   =  modelo.consultarAlertas(vehiculo.getId_vehiculo());
   boolean color = true;
   for(int i=0;i<lista.size();i++){
       Alerta alerta = (Alerta)lista.get(i); 
       String nombre="";
       if(alerta.getFk_persona()>0){
            Persona persona = modelo.consultarPersona(alerta.getFk_persona());
            nombre=(persona.getNombre_1()+" "+persona.getApellido_1());
       }else{
            nombre=alerta.getObservaciones();

       }


       //Persona persona = modelo.consultarPersona(alerta.getFk_persona());
       //String tipo_documento = modelo.crearHashParametrosAbreviatura(5).get(persona.getTipo_documento()+"").toString();
       //String nombres = "";
       /*if(persona.getTipo_documento()!=2){
           nombres = persona.getNombre_1()+" "+persona.getApellido_1()+" "+persona.getApellido_2();
       }else{
           nombres = persona.getNombre_1();
       }*/
       String tipo_alerta = modelo.consultarParametroName(4, alerta.getTipo());    %>
       <tr bgcolor="#FFFFFF" style="cursor:pointer" onclick="DetalleAlerta('<%=i%>','<%=alerta.getId_alerta()%>')">
                <td align="center"><span class="style6"><%=tipo_alerta%></span></td>
                <td align="center"><span class="style6"><%=nombre.toUpperCase() %></span></td>
				 <td align="center"><span class="style6"><%=alerta.getGrado()%></span></td>
                <td align="center"><span class="style6"><%=alerta.getFecha_ini()%></span></td>
                <td align="center"><span class="style6"><%=alerta.getFecha_fin()!=null?alerta.getFecha_fin():""%></span></td>
              </tr>
              <tr id="edAlerta<%=i%>" style="display:none; height:0px">
                  <td colspan="7">

                        <div class="box">

                                    <!--- box border -->
                                    <div class="lb">
                                    <div class="rb">
                                    <div class="bb"><div class="blc"><div class="brc">
                                    <div class="tb"><div class="tlc"><div class="trc">
                                    <!--  -->
                                    <div id="editarAlerta<%=i%>"  class="content"></div>
                                    <!--- end of box border -->
                                    </div></div></div></div>
                                    </div></div></div></div>
                                    <!-- -->

                        </div>
                  </td>
              </tr>
     <%  color = !color;
   }
   %>
</table>
<% }
 }        
%>
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
}catch(Exception mexe){
           mexe.printStackTrace();     %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
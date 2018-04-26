<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Taquilla</title>
<style type="text/css">
<!--
.style5 {font-family: Tahoma}
.style7 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.Estilo7 {
	font-size: 10px;
	font-weight: bold;
	color: #333333;
}
.style10 {
	font-size: 14px;
	font-weight: bold;
	color: #333333;
}
.style12 {
	font-size: 14;
	color: #333333;
	font-weight: bold;
}
-->
</style>


<script language="javascript" type="text/javascript">
	function salir(){
		window.location.href="consultar_pagosDistribuidos.jsp";
	}

        function verReporte(dir,nombre){
            ancho = 789;
            alto = 600;
            barra = 0;
            izquierda = (document.width) ? (document.width-ancho)/2 : 100;
            arriba = (document.height) ? (document.height-alto)/2 : 100;
            opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
            url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
            window.open(url, 'popUp', opciones);
        }
</script>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<body>
    <%
    Model modelo= (Model)session.getAttribute("model");
    long usuario = 0;
    if(request.getParameter("usuario")!=null)
        usuario = Long.parseLong(request.getParameter("usuario"));
    long entidad = Long.parseLong(request.getParameter("entidad"));
    long caja = Long.parseLong(request.getParameter("caja"));
    java.sql.Date inicio = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("date")).getTime());
    java.sql.Date fin = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("date2")).getTime());
    java.util.HashMap<Long,Float> lista = modelo.consultarDistribucionTotalbyFecha(inicio, fin, usuario, caja);
    HashMap parameters = new java.util.HashMap();
    parameters.put("FECHA_INI", new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date(inicio.getTime())));
    parameters.put("FECHA_FIN", new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date(fin.getTime())));
    parameters.put("USUARIO",usuario);
    parameters.put("ENTIDAD", entidad);
    parameters.put("CAJA", caja);
    session.setAttribute("reporteTaquilla", parameters);
    String direccion1 = "recaudoycartera/distribucion/distribucionGeneralEntidades.jasper";
    String nombreR1 = "reporteTaquilla";
    String direccion2 = "recaudoycartera/distribucion/distribucionCajasEntidades.jasper";
    String nombreR2 = "reporteCajas";
    session.setAttribute("reporteCajas", parameters);

     %>
        <table width="100%" border="1" align="center" cellpadding="1" cellspacing="1">
		  <tr>
            <td colspan="1" align="left">
                <img src="../html/images/reporte.png" width="22" height="22" style="cursor:pointer" onclick="verReporte('<%=direccion2%>','<%=nombreR2%>')"/><span class="Estilo7">DISTRIBUCION&nbsp;CAJAS</span>            </td>
            <td colspan="1" align="right">
                <img src="../html/images/reporte.png" width="22" height="22" style="cursor:pointer" onclick="verReporte('<%=direccion1%>','<%=nombreR1%>')"/><span class="Estilo7">DISTRIBUCION&nbsp;ENTIDADES</span>            </td>
            </tr>
          <tr bgcolor="#CCCCCC" style="border:none; background:url(../html/images/inicio_3.png)">
            <td width="70%" style="border:none"><div align="center" class="style7">NOMBRE ENTIDAD</div></td>
            <td width="25%" style="border:none"><div align="center" class="style7">VALOR</div></td>
          </tr>
 <% 
  
    Iterator<Long> it = lista.keySet().iterator();
    float suma = 0;
    while(it.hasNext()){
        long key = it.next();
        Entidad_Distribucion entidades = modelo.getEntidad_distribucion(key);
        if(entidades.getId_entidad_distribucion()==entidad||entidad==0){
            float valor = lista.get(key);
            suma += valor;
            Persona persona = modelo.consultarPersona(entidades.getFk_persona());
            String nombre = nombre=persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1();%>
              <tr>
                    <td align="left" style="font-size:11px"><span class="style5"><%= nombre %></span></td>
                    <td align="right" style="font-size:11px"><span class="style5"><%= Math.round(valor) %></span></td>
              </tr> <%
        }
    } %>
    <tr>
        <td align="left" style="font-size:11px"><div align="right"><span class="style12">TOTAL&nbsp;DISTRIBUCION</span></span></div></td>
        <td align="right" style="font-size:11px"><span class="style10"><%= suma %></span></td>
  </tr>
	</table>
</body>
</html>

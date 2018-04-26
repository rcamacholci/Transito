<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.io.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
if(session.getAttribute("usuario")!=null){
    modelo.Model model = (modelo.Model)session.getAttribute("model");
    if(model!=null){
        modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
        if(model.tienePermiso(usuario.getId_usuario(), 7)){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title> Cartera Vehiculo </title>
<style type="text/css">
<!--
.style1 {
	color: #333333;
	font-family: Tahoma;
	font-size: 12px;
}
.style2 {color: #333333; font-weight: bold; }
.style4 {
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
	color: #FFFFFF;
}
.style6 {
	font-family: Tahoma;
	font-weight: bold;
	color: #333333;
	font-size: 12px;
}
.style8 {color: #333333; font-weight: bold; font-size: 16px; }
.Estilo1 {
	font-size: 12px;
	font-weight: bold;
	color: #FFFFFF;
}
.Estilo3 {font-family: Tahoma; font-weight: bold; color: #333333; font-size: 9px; }
-->
</style>
<script language="javascript">

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

    function verDetalleCartera(id_cartera){
		if(id_cartera!=null)
        window.frames[0].location.href = "consultarDetalleCartera.jsp?id_cartera="+id_cartera;
        sombrear(id_cartera);
    }

    function verDescuCartera(){
        var ancho = 1000;
        var alto = 400;
        var barra = 0;
        var izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
        var arriba = (screen.height) ? (screen.height-alto)/2 : 100;
        var opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars='+barra+',resizable=0,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
        var url = "consultarDescuentoCartera.jsp?id=1";
        window.open(url, 'popUp2', opciones);
    }


    function sombrear(id_cartera){
        renovar();
        document.getElementById(id_cartera).style.backgroundColor="#CCCCCC";
    }
    function renovar(){
        var filas = document.getElementById('tabla').getElementsByTagName('tr');
        for(i=1;i<filas.length;i++)
            filas[i].style.backgroundColor="#FFFFFF";
    }
</script>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<body>
<%
Cartera cartera=new Cartera();

Model modelo= (Model)session.getAttribute("model");
String placa = "";
if(request.getParameter("id").equals("0")){
    placa =  request.getParameter("placa");
}else{
    placa =  session.getAttribute("placa")+"";
}
if(placa!=null){
Vehiculo vehiculo= modelo.consultarVehiculo(placa.toUpperCase().trim());

if(vehiculo!=null){
    HashMap parameters = new java.util.HashMap();
    parameters.put("VEHICULO", ""+vehiculo.getId_vehiculo());
    parameters.put("USUARIO", usuario.getNombre());
    session.setAttribute("EstadoCuenta", parameters);
    String direccion = "recaudoycartera/otros/estado_cuenta.jasper";
    String nombreR = "EstadoCuenta";

%>
<div align="center" class="style6">CARTERA VEHICULO <%=vehiculo.getPlaca()%></div>
<br/>
<table width="100%"  border="1" cellpadding="1" cellspacing="0" bordercolor="#FFFFFF" id="tabla">
<tr>
            <td colspan="7" align="right">
			<img src="../html/images/reporte.png" width="22" height="22" style="cursor:pointer" onclick="verReporte('<%=direccion%>','<%=nombreR%>')"/><span class="Estilo3">REPORTE</span></td>
  </tr>
  <tr  style="border:none; background:url(../html/images/inicio_3.png)">
    <td width="34%" style="border:none"><div align="center" class="style4">CONCEPTO</div></td>
    <td width="10%" style="border:none"><div align="center" class="style4">VIGENCIA</div></td>
    <td width="10%" style="border:none"><div align="center" class="style4">FECHA</div></td>
    <td width="10%" style="border:none"><div align="center" class="style4">ESTADO</div></td>
    <td width="9%" style="border:none"><div align="center" class="style4">VALOR</div></td>
    <td width="12%" style="border:none"><div align="center" class="style4">SALDO</div></td>
    <td width="15%" style="border:none"><div align="center" class="style4">EST. VIG</div></td>
  </tr><%

    List  cartera_vehiculo=modelo.crearListaCarteraPlaca(vehiculo.getId_vehiculo(),usuario.getId_usuario());
    Iterator itt = cartera_vehiculo.iterator();
    float total=0;
    int sw = 0;
     while (itt.hasNext()) {
        cartera = (Cartera)itt.next();
        Concepto concepto=modelo.consultarConcepto(cartera.getFk_concepto());
        Parametro parametro=modelo.consultarParametro(cartera.getEstado_cartera(),21);
        Parametro param=modelo.consultarParametro(cartera.getEstado_vigencia(),115);
        total=(float)(total+cartera.getSaldo());
        if(cartera.getReferencia().equals("2010")){
        sw = 1;
        }
      %>
      <tr id="<%=cartera.getId_cartera()%>" onclick="verDetalleCartera('<%=cartera.getId_cartera()%>')" bordercolor="#333333" style="cursor:pointer">
    <td style="font-size:12px"><span class="style2"><%=concepto.getNombre()%> </span></td>
    <td style="font-size:12px" align="center"><span class="style2"><strong><%=cartera.getReferencia()%> </strong></span></td>
    <td style="font-size:12px" align="center"><span class="style2"><strong><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(cartera.getFecha_creacion())%></strong></span></td>
    <td style="font-size:12px" align="center"><span class="style2"><strong><%=parametro.getNombre()%></strong></span></td>
    <td style="font-size:12px" align="right"><span class="style2"><strong>$&nbsp;<%=cartera.getValor()%> </strong></span></td>
    <td style="font-size:12px" align="right"><span class="style2"><strong>$&nbsp;<%=cartera.getSaldo()%> </strong></span></td>
    <td style="font-size:12px" align="center"><span class="style2"><strong><%=param.getNombre()%> </strong></span></td>
  </tr>
<%
     }// fin del while
  %>
  <tr>
    <td style="font-size:12px; border:none">&nbsp; </td>
    <td style="font-size:12px; border:none">&nbsp;</td>
    <td style="font-size:12px; border:none">&nbsp;</td>
    <td style="font-size:12px; border:none">&nbsp;</td>
    <td style="background:url(../html/images/inicio_3.png)"><div align="center" class="Estilo1">TOTAL</div></td>
    <td style="font-size:12px" align="right"><span class="style8">$&nbsp;<%=total%> </span></td>
    <td style="font-size:12px; border:none" >&nbsp;</td>
  </tr>
  <%
    long descuento = model.consultarDescuentoInternacion(vehiculo.getId_vehiculo() , 1);
    if(descuento==0){
        if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("Liquidacion.jsp")){
            if((vehiculo.getEstado()==1||vehiculo.getEstado()==5)&&sw==1){
      %>
  %>
  <tr>
      <td colspan="7" align="center">
        <input type="button" name="consultar_descu" value="Consultar Descuento" align="right" onclick="verDescuCartera()">
    </td>
</tr>
 <%
            }
        }
    }
 }
 }else{ %>
    <script>
            alert("Digite numero de placa");
            window.href="consultar_Vehiculo.jsp";
    </script>
<% }
%>

</table>
<br/>
<br/>
<iframe src="consultarDetalleCartera.jsp?id" id="detalle_cartera" name="detalle_cartera" marginwidth="0" height="280" width="100%" marginheight="0" align="top" scrolling="auto" style="border:none"></iframe>
</body>
</html>
<%
        }else{  %>
           <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="1"></jsp:param></jsp:forward>
<%        }
     }else{ %>
        <script>window.parent.document.location.href = "../../index.jsp";</script>
<%  }
 }else{ %>
     <script>window.parent.document.location.href = "../../index.jsp";</script>
<% }
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% } %>

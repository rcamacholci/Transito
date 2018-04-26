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

<script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
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

function nuevoAjax(){
	var xmlhttp= false;
	try{
		xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
	}catch(e){
		try {
			xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
		}catch(E){
			xmlhttp = false;
		}
	}

	if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
		xmlhttp = new XMLHttpRequest();
	}

	return xmlhttp;
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

    function verDetalleCartera(id_cartera){
		if(id_cartera!=null)
        window.frames[0].location.href = "consultarDetalleCartera.jsp?id_cartera="+id_cartera;
        sombrear(id_cartera);
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


function aplicarDescuento(idvehiculo,placa){
    ajax = nuevoAjax();
    ajax.open("POST", "descuentoInternacion.jsp",true);
    ajax.onreadystatechange=function() {
        if (ajax.readyState==4) {
            var docxml = ajax.responseXML;
            var sw = docxml.getElementsByTagName('sw')[0].childNodes[0].nodeValue;
            //alert("valrete= "+valrete);
            if(sw=="1"){
                    window.parent.opener.window.location.href = "consultarCarteraVehiculo.jsp?id=1&placa="+placa;
                    window.parent.close();
            }else{

            }
        }
    }
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("idveh="+idvehiculo);
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
  <tr  style="border:none; background:url(../html/images/inicio_3.png)">
    <td width="34%" style="border:none"><div align="center" class="style4">CONCEPTO</div></td>
    <td width="10%" style="border:none"><div align="center" class="style4">VIGENCIA</div></td>
    <td width="10%" style="border:none"><div align="center" class="style4">FECHA</div></td>
    <td width="10%" style="border:none"><div align="center" class="style4">ESTADO</div></td>
    <td width="9%" style="border:none"><div align="center" class="style4">VALOR</div></td>
    <td width="12%" style="border:none"><div align="center" class="style4">SALDO</div></td>
    <td width="15%" style="border:none"><div align="center" class="style4">EST. VIG</div></td>
  </tr><%
      boolean swActualizoInteres = modelo.actualizarInteresesCostasVehiculos(vehiculo.getId_vehiculo(), usuario.getId_usuario());
    if(!swActualizoInteres){
        // Colocar alerta cuando no se genero intereses
        %><script>alert('Há ocurrido un error al actualizar intereses, intente nuevamente')</script><%
    }
    List  cartera_vehiculo=modelo.crearListaCarteraPlaca(vehiculo.getId_vehiculo(),usuario.getId_usuario());
    Iterator itt = cartera_vehiculo.iterator();
    float total=0;
    while (itt.hasNext()) {
        cartera = (Cartera)itt.next();
        Concepto concepto=modelo.consultarConcepto(cartera.getFk_concepto());
        Parametro parametro=modelo.consultarParametro(cartera.getEstado_cartera(),21);
        Parametro param=modelo.consultarParametro(cartera.getEstado_vigencia(),115);

        float saldo = (float)cartera.getSaldo();
        System.out.println("Saldo antes= "+saldo);
        //String numplaca = request.getParameter("placa");
        Vehiculo veh = model.consultarVehiculo(placa);
        java.util.Date fechaActual =(new java.util.Date());
            if((new java.text.SimpleDateFormat("dd/MM/yyyy").parse(new java.text.SimpleDateFormat("dd/MM/yyyy").format(fechaActual)).getTime() <= new java.text.SimpleDateFormat("dd/MM/yyyy").parse("26/09/2013").getTime()) &&
                    (cartera.getTipo()==2) && (veh.getEstado()==1||veh.getEstado()==5) && (!cartera.getReferencia().equals("2011") && !cartera.getReferencia().equals("2012") && !cartera.getReferencia().equals("2013"))){
                modelo.Detalle_Cartera dc = model.consultarDetalleCartera(cartera.getId_cartera(), 249);
                if(dc!=null){
                    int interesR = (int)dc.getValor();
                    int interesD =(int)((interesR*80)/100);
                    saldo = saldo-interesD;
                    System.out.println("Saldo desp= "+saldo);
                }
                modelo.Detalle_Cartera dcEx = model.consultarDetalleCarteraExtempo(cartera.getId_cartera());
                if(dcEx!=null){
                    int extempoR = (int)dcEx.getValor();
                    int extempoD =(int)((extempoR*80)/100);
                    saldo = saldo-extempoD;
                    System.out.println("Saldo desp= "+saldo);
                }
            }else{
                saldo = (float)cartera.getSaldo();
            }


        total=(float)(total+saldo);
      %>
      <tr id="<%=cartera.getId_cartera()%>" onclick="verDetalleCartera('<%=cartera.getId_cartera()%>')" bordercolor="#333333" style="cursor:pointer">
    <td style="font-size:12px"><span class="style2"><%=concepto.getNombre()%> </span></td>
    <td style="font-size:12px" align="center"><span class="style2"><strong><%=cartera.getReferencia()%> </strong></span></td>
    <td style="font-size:12px" align="center"><span class="style2"><strong><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(cartera.getFecha_creacion())%></strong></span></td>
    <td style="font-size:12px" align="center"><span class="style2"><strong><%=parametro.getNombre()%></strong></span></td>
    <td style="font-size:12px" align="right"><span class="style2"><strong>$&nbsp;<%=cartera.getValor()%> </strong></span></td>
    <td style="font-size:12px" align="right"><span class="style2"><strong>$&nbsp;<%=saldo %> </strong></span></td>
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
 <%}
 }else{ %>
    <script>
            alert("Digite numero de placa");
            window.href="consultar_Vehiculo.jsp";
    </script>
<% }
%>
</table>
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

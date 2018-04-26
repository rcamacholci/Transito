<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Vehiculo" import="modelo.Sede"  import="modelo.Tramite" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Documento sin t&iacute;tulo</title>
<link title="win2k-cold-1" media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="../html/scripts/calendar.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<script src="../html/scripts/personas.js" type="text/javascript"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
 <script type="text/javascript" src="../html/scripts/consultasGenerales.js"></script>
<script language="javascript" type="text/javascript">


function revisar(){
   if(document.getElementById("salida").value.length>0){
     if(document.getElementById("comparendo").value.length>0){
         if(document.getElementById("placa").value.length>0){
            if(document.getElementById("clase").value.length>0){
                if(document.getElementById("servicio").value.length>0){
                    if(document.getElementById("marca").value.length>0){
                        if(document.getElementById("linea").value.length>0){
                            if(document.getElementById("motor").value.length>0){
                                if(document.getElementById("chasis").value.length>0){
                                    if(document.getElementById("modelo").value.length>0){
                                        if(document.getElementById("color").value.length>0){
                                            if(document.getElementById("cedPropietario").value.length>0&&!isNaN(document.getElementById("cedPropietario").value)){
                                                if(document.getElementById("nombrePropietario").value.length>0){
                                                    if(document.getElementById("cedAutorizado").value.length>0&&!isNaN(document.getElementById("cedAutorizado").value)){
                                                        if(document.getElementById("nombreAutorizado").value.length>0){
                                                             if(document.getElementById("observacion").value.length>0){
                                                                    document.form.submit();
                                                             }else{
                                                                  alert("Digite Una Observacion");
                                                             }
                                                       }else{
                                                             alert("Digite el Nombre de la Persona Autorizada");
                                                        }
                                                    }else{
                                                          alert("Error : Digite la cedula de la Persona Autorizada o el numero esta errado");
                                                    }
                                                }else{
                                                      alert("Digite el Nombre del propietario");
                                                }
                                            }else{
                                                  alert("Error: Digite la cedula del propietario o el numero esta errado");
                                            }
                                        }else{
                                              alert("Digite el color del Vehiculo");
                                        }
                                    }else{
                                          alert("Digite el modelo del vehiculo");
                                    }
                                }else{
                                     alert("Digite el numero del chasis del vehiculo");
                                }
                            }else{
                                 alert("Digite el numero del motor del vehiculo");
                            }
                        }else{
                             alert("Digite la linea del vehiculo");
                        }
                    }else{
                         alert("Digite la marca del vehiculo");
                    }
                }else{
                    alert("Digite el Servicio del vehiculo");
                }
            }else{
		alert("Digite la clase del vehiculo");
            }
	}else{
            alert("Digite la placa del Vehiculo Inmovilizado");
	}
         
         }else{
             alert("Digite el Numero del Comparendo Con el cual Fue inmovilizado el vehiculo");
         }
    }else{
	alert("Digite el Numero de la Orden de Salida");
    }
} 

function existeComparendo(input){
    var valor = input.value;
    if(!isNaN(valor)){
        var ajax = new nuevoAjax();
        ajax.open("POST", "getComparendoPatio.jsp",true);
        ajax.onreadystatechange=function() {
            if (ajax.readyState==4) {
                var docxml = ajax.responseXML;
                var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue;
                if(result=='1'){                     
                      var placa = docxml.getElementsByTagName('placa')[0].childNodes[0].nodeValue
                      var clase = docxml.getElementsByTagName('clase')[0].childNodes[0].nodeValue
                      var servicio = docxml.getElementsByTagName('servicio')[0].childNodes[0].nodeValue
                      document.getElementById("placa").value = placa
                      document.getElementById("clase").value = clase
                      document.getElementById("servicio").value = servicio
                      document.form.guardar.disabled = false;
                }else{
                    if(result=='2'){
                        alert("Ya fue generada una orden de salida Para el comparendo : "+valor);
                        document.form.guardar.disabled = true;
                    }else{
                         alert("El comparendo : "+valor+" No se encuentra registrado");
                         document.form.guardar.disabled = true;
                    }
                }
            }
        }
    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax.send("numero="+valor);
   }else{
      alert("Numero de Comparendo errado debe ser Solo Numeros");
   }
}

  
</script>
<style type="text/css">
<!--
.Estilo12 {
	font-size: 14px;
	font-weight: bold;
}
.Estilo15 {
	font-family: Tahoma;
	font-weight: bold;
	font-size: 12px;
	color: #FFFFFF;
}
.Estilo16 {font-family: Tahoma}
.Estilo26 {
	font-size: 12px;
	color: #FFFFFF;
}
.Estilo32 {font-size: 12px; font-weight: bold; font-family: Tahoma; color: #333333; }
.Estilo33 {font-family: Tahoma; font-size: 12px; color: #333333; }
.Estilo34 {font-size: 12px}
.Estilo38 {font-size: 9px}
.style1 {font-size: 10px}
.style3 {font-size: 10px; font-weight: bold; font-family: Tahoma; color: #333333; }
-->
</style>
</head>

<body>
  <%
Model modelo = (Model) session.getAttribute("model");
int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
int factura = modelo.consultarConsecutivo(234, 15, vigencia);
String consecutivo = ("000000".substring(0, 6-(factura+"").length()))+factura;

%>

<form name="form" id="form" method="post" target="Orden" action="procesarOrdenSalida.jsp">
<fieldset>
<table width="100%" border="0" align="center">
  <tr>
    <td colspan="6" background="../html/images/inicio_3.png"> <div align="center" class="Estilo15 Estilo26">INFORMACION DE LA ORDEN DE SALIDA </div></td>
  </tr>
  
  <tr>
  <td  colspan="2"class="Estilo32 Estilo34 Estilo34 style1">NUMERO DE SALIDA </td>
    
		<td colspan=""><span class="Estilo33 Estilo34 Estilo34 style1">
                        <input id="salida" name="salida" type="text"  value="<%=consecutivo%>" style="text-align:center;font:bold; width:140px; text-transform:uppercase" readonly/>
		</span></td>
		<td>&nbsp;</td>
		<td colspan=""><span class="Estilo32 Estilo34 Estilo34 style1">NUMERO DEL COMPARENDO </span></td>
		<td><input name="comparendo" type="text" id="comparendo" onBlur="existeComparendo(this)" style="text-align:center;font:bold; width:140px"/></td>
  </tr>
  <tr>
    <td colspan="2" class="Estilo32 Estilo34 Estilo34 style1">PLACA DEL VEHICULO </td>
    <td><span class="Estilo33">
            <input name="placa" type="text" id="placa" style="text-align:center;font:bold; width:140px; text-transform:uppercase" maxlength="6" readonly/>
    </span></td>
    <td colspan="" class="Estilo32 Estilo34 Estilo34 style1">&nbsp;</td>
    <td><span class="Estilo32 Estilo34 Estilo34 style1">CLASE DEL VEHICULO </span></td>
    <td colspan=""><span class="Estilo33">
            <input name="clase" type="text"  value="" id="clase" style="width:140px;text-align:center" readonly />
      </span></td>
  </tr>
  
  
  <tr>
      <td class="subtitulos" colspan="2"><span class="Estilo32 Estilo34 Estilo34 style1">SERVICIO DEL VEHICULO </span></td>
      
      <td width="21%" class="Estilo32 Estilo34 Estilo34 style1"><span class="Estilo33">
              <input name="servicio" type="text" id="servicio" style="text-align:center;font:bold; width:140px" readonly/>
      </span></td>
    <td width="5%">&nbsp;</td>
    <td width="15%" class="Estilo32 Estilo34 Estilo34 style1">MARCA DEL VEHICULO </td>
    <td width="34%"><span class="Estilo32 Estilo34 Estilo34 style1"><span class="Estilo33">
      <input name="marca" type="text" id="marca" style="width:140px;text-align:center"/>
      </span></span></td>
  </tr>
  
  
  
  <tr>
    <td colspan="2" class="Estilo32 Estilo34 Estilo34 style1">LINEA DEL VEHICULO </td>
    
    <td class="Estilo32 Estilo34 Estilo34 style1"><input name="linea" type="text" id="linea" style="text-align:center;font:bold; width:140px"/></td>
    <td>&nbsp;</td>
    <td class="Estilo32 Estilo34 Estilo34 style1">MOTOR DEL VEHICULO </td>
    <td><span class="Estilo32 Estilo34 Estilo34 style1">
      <input name="motor" type="text" id="motor" style="text-align:center;font:bold; width:140px"  value="" />
    </span></td>
  </tr>
  
  
  
   <tr>
    <td colspan="2" class="Estilo32 Estilo34 Estilo34 style1">CHASIS DEL VEHICULO </td>
    <td><span class="Estilo32 Estilo34 Estilo34 style1">
      <input name="chasis" type="text" id="chasis" style="text-align:center;font:bold; width:140px"  value="" />
      </span></td>
    <td colspan="" class="Estilo32 Estilo34 Estilo34 style1">&nbsp;</td>
    <td><span class="Estilo32 Estilo34 Estilo34 style1">MODELO DEL VEHICULO </span></td>
	<td><input name="modelo" type="text" id="modelo" style="text-align:center;font:bold; width:140px"/></td>
  </tr>
   <tr>
    <td colspan="2" class="Estilo32 Estilo34 Estilo34 style1">CEDULA PROPIETARIO </td>
    <td><input name="cedPropietario" type="text" id="cedPropietario" style="text-align:center;font:bold; width:140px"/></td>
    <td colspan="" class="Estilo32 Estilo34 Estilo34 style1">&nbsp;</td>
    <td><span class="Estilo32 Estilo34 Estilo34 style1">NOMBRE PROPIETARIO </span></td>
	<td><span class="Estilo32 Estilo34 Estilo34 style1"><span class="Estilo33">
	  <input name="nombrePropietario" type="text" id="nombrePropietario" style="text-align:center;font:bold; width:280px"/>
	</span></span></td>
  </tr>
   <tr>
    <td colspan="2" class="Estilo32 Estilo34 Estilo34 style1">CEDULA AUTORIZADO </td>
    <td><input name="cedAutorizado" type="text" id="cedAutorizado" style="text-align:center;font:bold; width:140px"/></td>
    <td colspan="" class="Estilo32 Estilo34 Estilo34 style1">&nbsp;</td>
    <td><span class="Estilo32 Estilo34 Estilo34 style1">NOMBRE AUTORIZADO </span></td>
	<td><span class="Estilo33">
	  <input name="nombreAutorizado" type="text" id="nombreAutorizado" style="text-align:center;font:bold; width:280px"/>
	</span></td>
  </tr>
   <tr>
    <td colspan="2" class="Estilo32 Estilo34 Estilo34 style1">COLOR DEL VEHICULO </td>
    <td><input name="color" type="text" id="color" style="text-align:center;font:bold; width:140px"/></td>
    <td colspan="" class="Estilo32 Estilo34 Estilo34 style1">&nbsp;</td>
    <td><span class="Estilo32 Estilo34 Estilo34 style1">OBSERVACION</span></td>
	<td><input name="observacion" type="text" id="observacion" style="text-align:center;font:bold; width:280px"/></td>
  </tr>
</table> 

  
<table align="center" width="100%" border="0">
<tr><td>&nbsp;</td>
<tr>
 	<td colspan="6"><iframe src="#" width="100%"  name="Orden" id="Orden" height="500" style="display:none"  frameborder="0" scrolling="auto"></iframe></td>
</tr>
</tr>
 <tr>
  <td colspan="6" align="center"><input name="guardar" type="button" id="guardar" value="Generar Orden de Salida" style="width:200px; text-align:center" onclick="revisar()"/></td>
  </tr>
  <tr><td>&nbsp;</td></tr>
</table>
</fieldset>
</form>
</body>
</html>

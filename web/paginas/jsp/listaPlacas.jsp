
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Documento sin t&iacute;tulo</title>
<style type="text/css">
.Estilo8 {color: #333333; font-weight: bold; font-size: 12px; }
.Estilo14 {color: #333333; font-size: 12px; }
.style1 {font-family: Tahoma}
.style2 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.Estilo18 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
</style>
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="../html/scripts/calendar.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
function revisar(){
    if(document.form.placa1.value.length >0){
        document.form.submit();
    }else{
        alert("Digite al menos 1 Placa");
    }
}

function nuevoAjax(){
    var xmlhttp= false;
    try{xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
    }catch(e){try {	xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
            }catch(E){xmlhttp = false;}
    }
    if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
            xmlhttp = new XMLHttpRequest();
    }
    return xmlhttp;
}
function GuardarPlaca(placa){
    var ni = document.form.ofi.value;
    var oficioC = document.form.oficioC.value;
    var tabla = document.getElementById('lineasdiv');
    ajax2=nuevoAjax();
    ajax2.open("POST", "guardarVehiculo.jsp",true);
        ajax2.onreadystatechange=function() {
                if (ajax2.readyState==4) {
                        tabla.innerHTML = ajax2.responseText;
                }
        }
    ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax2.send("ni="+ni+"&placa="+placa+"&oficioC="+oficioC);
}
                
</script>

</head>
<body>
    <form name="form" id="form" method="post" action="procesar_respuesta_solicitud.jsp" onsubmit="revisar()">
<table width="80%" border="0" align="center">
  <tr style="background:url(../html/images/inicio_3.png)">
    	<td colspan="6" align="center" valign="middle"><span class="Estilo18">LISTADO DE PLACAS</span></td>
  </tr>
  <tr >
    	<td colspan="6" align="center" valign="middle"><div id="lineasdiv"></div></td>
  </tr>
    <%
 int cantVeh;
 long id_oficio;
 String oficioC = "";


 if(request.getParameter("cantVeh")!=null&&!request.getParameter("cantVeh").isEmpty()){
        if(request.getParameter("oficioC")!=null){
            oficioC = request.getParameter("oficioC");
        }
        id_oficio = Long.parseLong(request.getParameter("id_oficio"));
        cantVeh = Integer.parseInt(request.getParameter("cantVeh"));%>
        <input type="hidden" id="cantidad" name="cantidad" value="<%=cantVeh%>" />
        <input type="hidden" id="idOficio" name="idOficio" value="<%=id_oficio%>" />
        <input type="hidden" id="oficioC" name="oficioC" value="<%=oficioC%>" />
        <input type="hidden" id="num" name="num" value="1" />
           <%     for(int i=1;i<=cantVeh;i++){		 %>
    <tr>
	<td width="33%" align="center"><span class="Estilo2">PLACA No. <%=i%></span></td>
	<td width="33%" align="center"><input name="placa<%=i%>" type="text" id="placa<%=i%>"  onblur="GuardarPlaca(placa=this.value)" value=""  style="text-align:center; color:#333333; font-family:Arial, Helvetica, sans-serif; width:100px; font-size:11px"/></td>
	 <td width="33%"></td>
	</tr>
			
<%	}
 }
 String ofi = request.getParameter("id_oficio");
 String cant = request.getParameter("cantVeh");
 %>
 <tr><td colspan="3" align="center">
 
 <button id="consultar"  name="consultar" type="button" onclick="revisar()"><span class="style2">Generar Respuesta al Oficio</span> <img src="../html/images/PDF.png" width="18" height="18" /></button>
 <!-- <input id="consultar"  name="consultar"  type="button" value="Generar Respuesta al Oficio" onclick="revisar()" style="color:#333333"/> --></td></tr>

 <tr style="display:none"><td><input name="ofi" id="ofi" type="text" value="<%=ofi%>"></td></tr>
 <tr style="display:none"><td><input name="cant" id="cant" type="text" value="<%=cant%>"></td></tr>
</table>
</form>
</body>
</html>

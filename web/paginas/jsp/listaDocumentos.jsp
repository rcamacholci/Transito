
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<style type="text/css">
.Estilo8 {color: #333333; font-weight: bold; font-size: 12px; }
.Estilo14 {color: #333333; font-size: 12px; }
.style1 {font-family: Tahoma}
.style2 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.Estilo18 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
</style>
<title>Documento sin t&iacute;tulo</title>
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="../html/scripts/calendar.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
    setTimeout("setFocus()",100);

function revisar(){
    if(document.form.documento1.value.length>0){
        document.form.submit();
    }else{
        alert("Digite al menos 1 Documento");
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

function setFocus(){
 document.form.tipoDoc1.focus();
}
function YYYY(td){

    return td
}
function XXX(d){
    return d
}
function GuardarPersona(nombre){
    var tido = td;
   var doc=d;
    var ni = document.form.ofi.value;
    var oficioC = document.form.oficioC.value;
    var tabla = document.getElementById('lineasdiv');
    ajax2=nuevoAjax();
    ajax2.open("POST", "guardarPersona.jsp",true);
        ajax2.onreadystatechange=function() {
                if (ajax2.readyState==4) {
                        tabla.innerHTML = ajax2.responseText;
                }
        }
    ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
    ajax2.send("ni="+ni+"&nombre="+nombre+"&doc="+doc+"&tido="+tido+"&oficioC="+oficioC);
}
</script>
<style type="text/css">
<!--
.Estilo1 {
	color: #333333;
	font-weight: bold;
	font-family: Tahoma;
	font-size: 12px;
}
.Estilo2 {
	font-family: Tahoma;
	font-size: 12px;
}
-->
</style>
</head>
<body>
     <form name="form" id="form" method="post" action="procesar_respuesta_solicitud.jsp" onsubmit="revisar()">
<table width="100%" border="0" align="center">
  <tr style="background:url(../html/images/inicio_3.png)">
    <th scope="col" colspan="7"><span class="Estilo2" style="color: #FFFFFF"><font style="font-size:11px">LISTADO DE DOCUMENTOS </font></span></th>

  </tr>
 <%
 Model modelo= (Model)session.getAttribute("model");
 Parametro parametro=new Parametro();
 int cantDoc;
 long id_oficio;
 String oficioC = "";

 if(request.getParameter("cantDoc")!=null&&!request.getParameter("cantDoc").isEmpty()){

      if(request.getParameter("oficioC")!=null){
            oficioC = request.getParameter("oficioC");
      }
      id_oficio = Long.parseLong(request.getParameter("id_oficio"));
      cantDoc = Integer.parseInt(request.getParameter("cantDoc"));%>
       <input type="hidden" id="cantidad" name="cantidad" value="<%=cantDoc%>" />
        <input type="hidden" id="idOficio" name="idOficio" value="<%=id_oficio%>" />
        <input type="hidden" id="oficioC" name="oficioC" value="<%=oficioC%>" />
        <input type="hidden" id="num" name="num" value="2" />
            <%    for(int i=1;i<=cantDoc;i++){		%>
    <tr>
	<td width="11%" align="center"><span class="Estilo1">TIPO&nbsp;DOC</span></td>
		<td width="12%" align="center"><strong>
		  <select name="tipoDoc<%=i%>" id="tipoDoc<%=i%>" onblur="YYYY(td=this.value)" style="width:150px; font-size:10px" >
             <!--  <option value="0">-- Seleccione una identificación --</option> -->
                      <%
					 List lista_id = modelo.listadoParametros(5);
					 Iterator itrtor = lista_id.iterator();
					 while (itrtor.hasNext()) {
						   parametro = (Parametro)itrtor.next();%>
            <option  value="<%=parametro.getCodigo()+""%>" ><%=parametro.getNombre()%></option>
            <%}%>
          </select>
	  </strong></td>
	  <td width="13%" align="center"><span class="Estilo1">DOCUMENTO No. <%=i%></span></td>
	<td width="9%" align="center"><input name="documento<%=i%>" type="text" id="documento<%=i%>" value="" onblur="XXX(d=this.value)" style="text-align:center; color:#333333; font-family:Arial, Helvetica, sans-serif; width:110px; font-size:11px"/></td>
	<td width="8%" align="center"><span class="Estilo1">NOMBRE</span></td>
	<td width="21%" align="center"><input name="nombre<%=i%>" type="text" id="nombre<%=i%>" onblur="GuardarPersona(nombre=this.value)" value=""  style="text-align:center; color:#333333; font-family:Arial, Helvetica, sans-serif; width:270px; font-size:11px"/></td>
      <td width="26%"><div id="lineasdiv"></div></td>
	</tr>


<%	}
 }
String ofi = request.getParameter("id_oficio");

 %>

 <tr><td colspan="7" align="center">
 <button id="consultar"  name="consultar" type="button" onclick="revisar()"><span class="style2">Generar Respuesta al Oficio</span> <img src="../html/images/PDF.png" width="18" height="18" /></button>
 <!--<input id="consultar"  name="consultar" type="button" value="Generar Respuesta al Oficio" onclick="revisar()" style="color:#333333"/> --></td></tr>
 <tr style="display:none"><td><input   name="ofi" id="ofi" type="text" value="<%=ofi%>"></td></tr>

</table>
     </form>
</body>
</html>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Vehiculo" import="modelo.Sede"  import="modelo.Tramite" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Documento sin t&iacute;tulo</title>
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="../html/scripts/calendar.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<script src="../html/scripts/personas.js" type="text/javascript"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
 <script type="text/javascript" src="../html/scripts/consultasGenerales.js"></script>
<script language="javascript" type="text/javascript">

function consultaPersona(id_tipoDoc,id_Documento,id_input_set){
	var tipo = document.getElementById(id_tipoDoc);
	var documento = document.getElementById(id_Documento) ;        
            if(documento.value.length>0){
                    var ajax= new nuevoAjax();
                    ajax.open("POST", "getPersona2.jsp",true);
                    ajax.onreadystatechange=function() {
                            if (ajax.readyState==4 && ajax.status == 200) {
                                 var docxml = ajax.responseXML
                                 var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue
                                 if(result == 'si'){
                                     var nombres = docxml.getElementsByTagName('nombre1')[0].childNodes[0].nodeValue +' '+(docxml.getElementsByTagName('nombre2')[0].childNodes[0].nodeValue!='null'?docxml.getElementsByTagName('nombre2')[0].childNodes[0].nodeValue:'')
                                     var apellidos = docxml.getElementsByTagName('apellido1')[0].childNodes[0].nodeValue + ' '+(docxml.getElementsByTagName('apellido2')[0].childNodes[0].nodeValue!='null'?docxml.getElementsByTagName('apellido2')[0].childNodes[0].nodeValue:'')
                                     
                                     document.getElementById(id_input_set).value=nombres+' '+apellidos
                                     
                                    }else{
                                        viewPersona(tipo.value,documento.value);
                                        document.getElementById(id_input_set).value=''
                                    }
                            }
                    }
                    ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                    ajax.send("documento="+documento.value+"&tipo="+tipo.value);
            }       
}

</script>
<style type="text/css">
<!--
.Estilo26 {color: #333333; font-family: Tahoma; font-weight: bold;}
.Estilo3 {color: #0066CC}
.style2 {
	color: #333333;
	font-size: 12px;
	font-family: Tahoma;
}
.style8 {font-size: 12px; font-weight: bold; font-family: Tahoma; color: #333333; }
.style10 {font-family: Tahoma; color: #333333; }
.style13 {color: #FFFFFF}
-->
</style>
</head>

<body>
 <%
Model modelo = (Model) session.getAttribute("model");
String departamentoExpedicion="";
Parametro parametro=new Parametro();
Parametro parametro2=new Parametro();
Parametro parametro3=new Parametro();
%>
<table width="70%" align="center">
  <tr>
       <td colspan="6" background="../html/images/inicio_3.png"> <div align="center" class="Estilo15 Estilo26 style2 style13">PRESCRIPCION COMPARENDO</div></td>
  </tr>
  <tr>
    <td colspan="4">&nbsp;</td>
  </tr>
  <tr>
    <td width="22%"><span class="style8">NUMERO RESOLUCION</span> </td>
	<td width="24%"><span class="Estilo26">
      <input  id="numero"name="numero" type="text" class="Estilo3" style="width:130px; text-align:center" onkeypress="return soloNumeros(event)" />
    </span></td>
    <td width="24%"><span class="style8">FECHA RESOLUCION</span></td>
	<td width="30%"> <span class="style8">
      <input type="text" name="fecha" id="fecha"  style="width:100px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10" />
      <input name="BfechaRes" type="button" id="BfechaRes" value="&lt;" style="width:20px"/>
	   <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fecha",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "BfechaRes"   // el id del bot?n que lanzar? el calendario
			});
		 </script>
    </span></td>
  </tr>
  <tr>
    <td><span class="style8">NUMERO COMPARENDO</span></td>
	<td> <span class="Estilo26">
      <input  id="numeroComp "name="numeroComp" type="text" class="Estilo3" style="width:130px; text-align:center" onkeypress="return soloNumeros(event)" />
    </span></td>
    <td><span class="style8">FECHA COMPARENDO</span></td>
	<td> <span class="style8">
      <input type="text" name="fechaComp" id="fechaComp"  style="width:100px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10" />
      <input name="BfechaComp" type="button" id="BfechaComp" value="&lt;" style="width:20px"/>
	   <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fechaComp",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "BfechaComp"   // el id del bot?n que lanzar? el calendario
			});
		 </script>
    </span></td>
  </tr>
  <tr>
  	<td><span class="style8">TIPO DOC. </span></td>
		<td><strong>
		  <select name="tipo_doc" id="tipo_doc" style="width:130px; font-size:10px" onchange="consultaPersona(this.id, 'documentoDt', 'nombreDt') ">
            <% 
             List lista_id3 = modelo.listadoParametros(5);
             Iterator itrtor3 = lista_id3.iterator();
             while (itrtor3.hasNext()) {
                       parametro3 = (Parametro)itrtor3.next();
                       if(parametro3.getCodigo()==1){
                           %>
            <option value="<%=parametro3.getCodigo()+""%>" selected="selected"><%=parametro3.getNombre()%></option>
            <%          }
              }%>
          </select>
		</strong></td>
			<td><span class="style8">NUMERO CEDULA</span></td>
		<td><span class="style10">
		  <input name="documento" type="text" id="documento" style="width:120px;text-align:center" onkeypress="return soloNumeros(event)" onblur="consultaPersona('tipo_doc', this.id, 'nombre')"/>
		</span></td>
  </tr>
  <tr>
    <td><span class="style8">NOMBRE</span></td>
    <td colspan="3"><span class="style2">
      <input name="nombre" type="text" id="nombre"  style="width:400px" readonly="readonly"/>
    </span></td>
  </tr>
  <tr>
    <td colspan="4">&nbsp;</td>
  </tr>
<tr>
    <td colspan="4"><div align="center" class="style10">
      <input name="adicionar" type="button" id="adicionar" value="GUARDAR" style="width:150px; text-align:center" onclick="revisar()"/>
    </div></td>
  </tr>
</table>
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
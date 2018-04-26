<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<META http-equiv=Content-Type content="text/html; charset=windows-1252">
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
		<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
		
<script language="javascript" type="text/javascript">
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

		
	function validarFechas(){
            ajax=nuevoAjax();
            ajax.open("POST", "validarFechas.jsp",true);
            ajax.onreadystatechange=function() {
                    if (ajax.readyState==4) {
                            if(ajax.responseText.indexOf("fechas")==-1){
                                    document.form.submit();
                            }else{
                                    alert(ajax.responseText);
                            }
                    }
            }
            ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            ajax.send("id="+document.getElementById("idv").value+"&placa="+document.getElementById("placa").value+"&fi="+document.getElementById("fecha_inicial").value+"&ff="+document.getElementById("fecha_final").value);

        }
	function revisar(){
		   if(document.getElementById("secuencia").value.length>0&&!isNaN(document.getElementById("secuencia").value)){
                            if(document.getElementById("fecha_inicial").value.length>0){
                                    if(document.getElementById("fecha_final").value.length>0){
					fecha1 = document.getElementById("fecha_inicial").value;
					fecha2 = document.getElementById("fecha_final").value;
					f1 = new Date(fecha1.substr(6,4),fecha1.substr(3,2)-1,fecha1.substr(0,2));
					f2 = new Date(fecha2.substr(6,4),fecha2.substr(3,2)-1,fecha2.substr(0,2));
					if(f2>=f1){
						validarFechas();
					}else{
						alert("Fecha final debe ser mayor o igual a la inicial");
					}
                                    }else{
					document.form.submit();
                                    }
                              }else{
                                    alert("Seleccione al menos una fecha inicial");
                              }
                     }else{
                           alert("Debe digitar la Secuencia del Color");
                     }
             
        }

	function salir(){
		document.form.action = "verColor.jsp?id=1";
		document.form.submit();
	}
</script>


<title>Adicionar Propietario</title>
<style type="text/css">
<!--
.Estilo1 {
	color: #0066CC;
	font-weight: bold;
}
.style2 {
	color: #333333;
	font-weight: bold;
	font-size: 12px;
	font-family: Tahoma;
}
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
  Parametro parametro = null;
  if(request.getParameter("idv")!=null){
	Historico_Color historico_color = modelo.consultarHistoricoColor(Long.parseLong(request.getParameter("idv")));
        Color color1 = modelo.getColor(historico_color.getFk_color());

       
        

%>
<body>
<form id="form" name="form" method="post" action="procesar_color.jsp?id=2">
<input type="hidden" name="vehiculo" id="vehiculo" value="<%=vehiculo.getId_vehiculo()%>"/>
<input type="hidden" name="placa" id="placa" value="<%=placa.toUpperCase()%>"/>
<input type="hidden" name="idv" id="idv" value="<%=request.getParameter("idv")%>"/>
 <fieldset>
 <div align="center"><legend class="style2">EDITAR</legend></div>
 <table width="60%" border="0" align="center" cellpadding="1" cellspacing="0">
    <tr>
      <td class="style2" style="border:none">COLOR</td>
      <td colspan="4" style="border:none">
          <select name="color" id="color" style="width:350px;">
          <%

             List list=modelo.listadoColores();
             Iterator it = list.iterator();
             while (it.hasNext()) {
        	 Color color = (Color)it.next();
                 if(color.getId_color()==color1.getId_color()){ %>
                    <option value="<%=color.getId_color()+""%>" selected><%=color.getNombre()%></option>
               <%  }else{ %>
                     <option value="<%=color.getId_color()+""%>"><%=color.getNombre()%></option>
          <%       }
               }%>
        </select> 
		</td>
    </tr>
    <tr>
      <td width="17%" style="border:none"><span class="style2"><span class="style2" style="border:none">SECUENCIA</span></span></td>
      <td width="31%" style="border:none"><input type="text" name="secuencia" id="secuencia" style="width:115px" value="<%=historico_color.getSecuencia()%>"/></td>
      <td width="15%" class="style2" style="border:none">GAMA</td>
      <td width="34%" colspan="2" style="border:none"><input type="text" name="gama" id="gama" value="<%=historico_color.getGama()==null?"":historico_color.getGama()%>" style="width:115px"/></td>
    </tr>
    
    <tr>
      <td style="border:none"><span class="style2" >FECHA&nbsp;INICIAL </span></td>
      <td style="border:none">
          <input  id="fecha_inicial" name="fecha_inicial"  style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; width:90px" value="<%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(historico_color.getFecha_ini())%>" onkeyup="mascara(this,'/',true)" maxlength="10"/>
         <input name="button" type="button" id="lanzador" style="width:22px; color:#000000" value="<<"/>
        <SCRIPT type="text/javascript">
           Calendar.setup({
           inputField     :    "fecha_inicial",      // id del campo de texto
           ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
           button         :    "lanzador"   // el id del botón que lanzará el calendario
          });
	    </SCRIPT>	  </td>
      <td style="border:none"><span class="style2">FECHA&nbsp;FINAL </span></td>
      <td colspan="2" style="border:none">
          <input  id="fecha_final" name="fecha_final" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat;; width:90px" value="<%=historico_color.getFecha_fin()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy").format(historico_color.getFecha_fin()):""%>" onkeyup="mascara(this,'/',true)" maxlength="10"/>
         <input name="button" type="button" id="lanzador2" style="width:22px; color:#000000" value="<<" />
        <SCRIPT type="text/javascript">
           Calendar.setup({
           inputField     :    "fecha_final",      // id del campo de texto
           ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
           button         :    "lanzador2"   // el id del botón que lanzará el calendario
          });
	    </SCRIPT> </td>
    </tr>
    
    <tr>
      <td colspan="6" align="center" style="border:none">
	  	<table width="100%" border="0">
          <tr>
            <th width="50%" scope="col" style="border:none">
			<input name="enviar" type="button" id="enviar" value="Enviar" style="width:100px; text-align:center" onclick="revisar()"/></th>
            <th width="50%" scope="col" style="border:none">
			<input name="cancelar" type="button" id="cancelar" value="Cancelar" style="width:100px; text-align:center" onclick="salir()"/></th>
          </tr>
        </table>	  </td>
    </tr>
  </table>
  </fieldset>
</form>
</body>
<%
}
 }
}
%>
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
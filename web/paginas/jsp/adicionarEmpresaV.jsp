<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Caracteristicas</title>
<style type="text/css">
<!--
.Estilo1 {
	color: #0066CC;
	font-weight: bold;
}
.Estilo2 {color: #0066CC}
-->
</style>
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="../html/scripts/calendar.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<script src="../html/scripts/consultasGenerales.js" type="text/javascript"></script>
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
    function revisar(){
        if(document.getElementById("nombre").value.length>0){
            if(document.getElementById("fecha_inicial").value.length>0){
                  if(document.getElementById("fecha_final").value.length>0){
                    fecha1 = document.getElementById("fecha_inicial").value
                    fecha2 = document.getElementById("fecha_final").value
                    f1 = new Date(fecha1.substr(6,4),fecha1.substr(3,2)-1,fecha1.substr(0,2)).getTime()
                    f2 = new Date(fecha2.substr(6,4),fecha2.substr(3,2)-1,fecha2.substr(0,2)).getTime()
                        if(f2>=f1){
                            document.form.submit()
                        }else alert("Fecha final debe ser mayor o igual a la inicial")
                  }else{
                    document.form.submit()
                  }
            }else{
              alert("Seleccione al menos una fecha inicial")
            }
        }else{
          alert("Digite un numero de identificacion valido")
        }
    }

function salir(){
        document.form.action = "verEmpresaV.jsp?id=1"
        document.form.submit()
}



</script>
<style type="text/css">
<!--
.style5 {color: #333333}
.style6 {font-family: Tahoma}
.style7 {font-size: 12px}
.style8 {
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
	color: #333333;
}
-->
</style>
</head>
<%@ page import="modelo.*"%>
<%@ page import="java.util.*"%>

<%
Model modelo= (Model)session.getAttribute("model");
String placa = "";
String fecha = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
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

%>
<body bgcolor="#FFFFFF">
<form name="form" method="post" action="procesarEmpresaV.jsp?id=1">
<input type="hidden" name="vehiculo" id="vehiculo" value="<%=vehiculo.getId_vehiculo()%>"/>
<fieldset>
 </div>
<table width="70%" align="center" border="0">
<tr class="style8" style="border:none; background:url(../html/images/inicio_3.png)">
      <td colspan="4" align="center" bgcolor="#FFFFFF"><span class="style5">ADICIONAR </span></td>
	</tr>
  <tr class="style8">

      <td width="15%" style="border:none"><span class="style2">TIPO&nbsp;DOCUMENTO </span></td>
      <td width="20%" style="border:none">
	  		<select name="tipo" id="tipo" style="width:160px; font-size:11px">
			    <%
		         List list=modelo.listadoParametros(5);
        		 Iterator it = list.iterator();
		         while (it.hasNext()) {
        	         parametro = (Parametro)it.next();
                         if(parametro.getCodigo() == 2){%>
			        <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
		        <%}
                         }%>
	  </select>	  </td>



      <td width="32%" align="center" style="border:none"><span class="style2">DOCUMENTO</span></td>
      <td colspan="2" style="border:none"><input type="text" name="documento" id="documento" onBlur="consultaPersona('tipo', 'documento', 'nombre')" style="width:150px"/></td>
    </tr>
    <tr>
      <td class="style8" style="border:none">NOMBRE&nbsp;EMPRESA </td>
      <td colspan="3" class="style8" style="border:none">
        <input type="text" name="nombre" id="nombre" style="width:450px" readonly/>
      </td>

    </tr>




    <tr>
      <td class="style8" style="border:none">FECHA &nbsp;INICIAL </td>
      <td style="border:none">
        <span class="style8">
          <input  id="fecha_inicial" name="fecha_inicial"  style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; width:120px" onkeyup="mascara(this,'/',true)" maxlength="10"/>
          <input name="button" type="button" id="lanzador" style="width:25px; color:#000000" value="<<"/>
          <SCRIPT type="text/javascript">
           Calendar.setup({
           inputField     :    "fecha_inicial",      // id del campo de texto
           ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
           button         :    "lanzador"   // el id del botón que lanzará el calendario
          });
	     </SCRIPT>
        </span></td>

      <td width="32%" class="style8" align="center" style="border:none">FECHA&nbsp;FINAL </td>
      <td width="15%" colspan="2" style="border:none">
        <span class="style8">
          <input  id="fecha_final" name="fecha_final" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; width:120px" onkeyup="mascara(this,'/',true)" maxlength="10"/>
          <input name="button" type="button" id="lanzador2" style="width:25px; color:#000000" value="<<" />
          <SCRIPT type="text/javascript">
           Calendar.setup({
           inputField     :    "fecha_final",      // id del campo de texto
           ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
           button         :    "lanzador2"   // el id del botón que lanzará el calendario
          });
	     </SCRIPT>
        </span></td>
    </tr>
    <tr>
      <td colspan="6" align="center" style="border:none">
        <table width="100%" border="0">
          <tr>
            <th width="50%" scope="col" style="border:none" >
  <button name="adicionar" type="button" id="adicionar" onclick="revisar()" class="style2">Adicionar <img src="../html/images/adicionar.png" width="19" height="18"/></button>
              <!--<input name="adicionar" type="button" id="adicionar" value="Adicionar" style="width:100px; text-align:center" onclick="revisar()"/>--></th>
            <th width="50%" scope="col" style="border:none">
  <button name="cancelar" type="button" id="cancelar" onclick="salir()" class="style2">Cancelar <img src="../html/images/cancelar.png" width="19" height="18"/></button>
  <!--			<input name="cancelar" type="button" id="cancelar" value="Cancelar" style="width:100px; text-align:center" onclick="salir()"/>--></th>
            </tr>

          </table>
        </td>
    </tr>
</table>
</fieldset>
</form>
</body>
<%
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
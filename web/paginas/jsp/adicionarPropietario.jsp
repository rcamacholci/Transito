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
        <script src="../html/scripts/motorAjax.js" type="text/javascript"></script>
        <script src="../html/scripts/adicionarPropietario.js" type="text/javascript"></script>
        <script src="../html/scripts/consultasGenerales.js" type="text/javascript"></script>
		<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<style type="text/css">
<!--
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style3 {color: #FFFFFF}
.style31 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
.Estilo2 {color: #FFFFFF; 	font-family: Tahoma; 	font-size: 12px; 	font-weight: bold; }
-->
</style>
<script language="javascript" type="text/javascript">
		
		
	
</script>


<title>Adicionar Propietario</title>

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
Parametro parametro = new Parametro(); 
%>
<body>
<form id="form" name="form" method="post" action="procesar_propietario.jsp">
<input type="hidden" name="vehiculo" id="vehiculo" value="<%=vehiculo.getId_vehiculo()%>"/>
 <fieldset>

 <table width="60%" border="0"  bordercolor="#FFFFFF" align="center"  cellpadding="1" cellspacing="0">
  <tr style="border:none; background:url(../html/images/inicio_3.png)">
      <td colspan="11" align="center"><span class="Estilo2">ADICIONAR </span></td>
	</tr>
    <tr>
	
      <td width="15%" style="border:none"><span class="style2">TIPO&nbsp;DOCUMENTO </span></td>
      <td width="21%" style="border:none">
	  		<select name="tipo" id="tipo" style="width:160px; font-size:11px">
			    <% 
		         List list=modelo.listadoParametros(5);
        		 Iterator it = list.iterator(); 
		         while (it.hasNext()) {
        	         parametro = (Parametro)it.next();%>
			        <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
		        <%}%>
	  </select>	  </td>
	  <td width="1%" style="border:none">&nbsp;</td>
      <td width="23%" style="border:none"><span class="style2">DOCUMENTO</span></td>
      <td colspan="2" style="border:none"><input type="text" name="documento" id="documento" onBlur="consultaPersona('tipo', 'documento', 'nombre')" style="width:200px"/></td>
    </tr>
    <tr>
      <td style="border:none"><span class="style2">NOMBRE&nbsp;PERSONA </span></td>
      <td colspan="3" style="border:none"><input type="text" name="nombre" id="nombre" style="width:300px" readonly/></td>
	  <td width="17%" style="border:none"><span class="style2">PORCENTAJE</span></td>
      <td width="23%" style="border:none"><select name="porcentaje" style="width:70px">
			   <% for(int i=100;i>=10;i=i-10){ %>
			        <option value="<%=i+""%>"><%=i%></option>
		        <%}%>
      		</select>
      <span class="style2" >&nbsp;%</span></td>
    </tr>
    <tr>

        <td class="style2">TIPO&nbsp;PROPIEDAD</td>
        <td>
            <%

            List listaParametros = modelo.listadoParametros(327);

%>

            <select name="tipoPropiedad">
                <%
                
                for(int i=0;i<listaParametros.size();i++){
                    parametro = (Parametro) listaParametros.get(i);
                   

                    %>
                    <option value="<%=parametro.getCodigo()%>"><%=parametro.getNombre()%></option>
                <%
                }
                %>
            </select>
        </td>
        <td></td>
        <td class="style2">PROINDIVISO</td>
        <td align="right">

              <span class="style2">Si</span><input type="radio" name="proIndiviso"  value="S">&nbsp;
            <span class="style2">No</span><input type="radio" name="proIndiviso"  value="N">        </td>
		<td>&nbsp;</td>
    </tr>




    <tr>
      <td style="border:none"><span class="style2" >FECHA &nbsp;INICIAL </span></td>
      <td style="border:none">
	     <input  id="fecha_inicial" name="fecha_inicial"  style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; width:120px" onkeyup="mascara(this,'/',true)" maxlength="10"/>
         <input name="button" type="button" id="lanzador" style="width:25px; color:#000000" value="<<"/>
        <SCRIPT type="text/javascript">
           Calendar.setup({
           inputField     :    "fecha_inicial",      // id del campo de texto
           ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
           button         :    "lanzador"   // el id del botón que lanzará el calendario
          });
	    </SCRIPT>	  </td>
	  <td style="border:none">&nbsp;</td>
      <td style="border:none"><span class="style2">FECHA&nbsp;FINAL </span></td>
      <td colspan="2" style="border:none">
	     <input  id="fecha_final" name="fecha_final" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; width:120px" onkeyup="mascara(this,'/',true)" maxlength="10"/>
         <input name="button" type="button" id="lanzador2" style="width:25px; color:#000000" value="<<" />
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
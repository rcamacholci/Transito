<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<style type="text/css">
<!--
.Estilo1 {
	color: #CC0000;
	font-weight: bold;
}
-->
</style>
<script language="javascript" type="text/javascript">
		
	function regresar(){
		window.location.href="administrarCaja.jsp";
	}			
		
   function validarFechaInicio(date){
     if(date.value==""){
       alert("       Digite Fecha de Inicio");
       return false;
     }else return true;
   }
   function validarFechaFinal(date2){
     if(date2.value==""){
       alert("       Digite Fecha Final ");
       return false;
     }else return true;
   }

   function validarFechaMayor(){     
    var dia_ini = document.form.date.value.substr(0, 2); 
    var mes_ini = document.form.date.value.substr(3, 2); 
    var ano_ini = document.form.date.value.substr(6, 4); 
    var dia_fin = document.form.date2.value.substr(0, 2); 
    var mes_fin = document.form.date2.value.substr(3, 2); 
    var ano_fin = document.form.date2.value.substr(6, 4); 
    fecha_ini = new Date(ano_ini,mes_ini-1,dia_ini).getTime();
    fecha_fin = new Date(ano_fin,mes_fin-1,dia_fin).getTime();
    if(fecha_ini<=fecha_fin){
         
    }else{
        alert("  Error, La Fecha de Inicio es Mayor ");
        return false;
    }
   }
   
   
      function validarFormulario(form)
     {
     with(form){
  
         if(validarFechaInicio(date)==false){
             date.focus();
             return false;
         }
        if(validarFechaFinal(date2)==false){
             date2.focus();
             return false;
         }
          if(validarFechaMayor()==false){
             date.focus();
             return false;
         }
		    
      }
	} 
		 </script>
<META http-equiv=Content-Type content="text/html; charset=windows-1252">
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
		<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<title>Taquilla</title>
<style type="text/css">
<!--
.Estilo3 {
	color: #0066CC;
	font-size: 14px;
}
.Estilo4 {
	color: #333333;
	font-size: 14px;
}
.Estilo5 {
	color: #333333;
	font-size: 12px;
}
.Estilo8 {font-size: 14px}
.Estilo10 {color: #333333}
.Estilo11 {color: #333333; font-size: 14px; font-weight: bold; }
.style2 {font-family: Tahoma}
.style4 {
	color: #333333;
	font-size: 12px;
	font-family: Tahoma;
}
-->
</style>
</head>

<body>
<center>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>

<form id="form" name="form" method="post" action="lista_taquillas.jsp" onsubmit="return validarFormulario(this)"   style="width:90%"  >
  <p>&nbsp;</p>
  <p>&nbsp;</p>
    <fieldset>
 <div align="center">
   <legend align="center" class="style4"><strong>CONSULTAR&nbsp;TAQUILLA</strong></legend>
 </div>
  <table width="80%" border="0" align="center">
	<tr>
      <td colspan="4">&nbsp;</td>
    </tr>
	<tr>
      <td colspan="1"><span class="Estilo1 Estilo5 style2">NOMBRE&nbsp;CAJA</span></td>
	  <td colspan="3">
	  	<input type="text" name="codigo" id="codigo" value="<%=request.getParameter("id_caja")%>" style="width:40px; text-align:center; color:#333333"  readonly/>&nbsp;
	  	<input type="text" name="nombre" id="nombre" value="<%=request.getParameter("nombre_caja")%>" style="width:300px; color:#333333" readonly/></td>
    </tr>
    <tr>
      <td width="95"><span class="Estilo1 Estilo5 style2">FECHA&nbsp;INICIAL  </span></td>
	  <%
	  String fecha = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
	  
	  %>
	 		  
      <td width="143"><input type="text" name="date" id="fecha_desde"  value="<%=fecha%>" style="width:99px; text-align:center; color:#333333" onkeyup="mascara(this,'/',true)" maxlength="10"/>
          <input name="button" type="button" id="lanzador" value="..."  style="width:22px;"/>
          <script type="text/javascript">
           Calendar.setup({
            inputField     :    "fecha_desde",      // id del campo de texto
            ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
            button         :    "lanzador"   // el id del bot&iuml;&iquest;&frac12;n que lanzar&iuml;&iquest;&frac12; el calendario
         });
        </script>
      </td>
      <td width="78"><span class="Estilo1 Estilo3"><span class="style4">FECHA&nbsp;FINAL</span></span></td>
      <td width="157"><input type="text" name="date2" id="fecha_hasta" value="<%=fecha%>" style="width:99px; text-align:center; color:#333333" onkeyup="mascara(this,'/',true)" maxlength="10"/>
          <input name="button" type="button" id="lanzador2" value="..." style="width:22px;"/>
          <script type="text/javascript">
           Calendar.setup({
            inputField     :    "fecha_hasta",      // id del campo de texto
            ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
            button         :    "lanzador2"   // el id del bot&iuml;&iquest;&frac12;n que lanzar&iuml;&iquest;&frac12; el calendario
         });
        </script>
      </td>
    </tr>
	<tr>
      <td colspan="4">&nbsp;</td>
    </tr>
    <tr>
      <td colspan="2" align="center"><input type="submit" style="width:100px" name="Submit" value="Consultar" /></td>
	  <td colspan="2" align="center"><input name="cancelar" type="button" id="cancelar" value="Atras" style="width:100px; text-align:center" onclick="regresar()"/></td> 
    </tr>
  </table>
  </fieldset>
</form>
</center>
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
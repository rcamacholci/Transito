<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>

<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                        Model modelo= (Model)session.getAttribute("model");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
          
 <link rel="SHORTCUT ICON" href="icono.ico" type="image/x-icon"    />
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


	function validarPersona(){
			valor=document.form.documento.value;
			if(valor.length>0){
				valor2=document.form.tipo.options[document.form.tipo.selectedIndex].value;
				ajax=nuevoAjax();
				ajax.open("POST", "getPersona.jsp",true);
				ajax.onreadystatechange=function() {
					if (ajax.readyState==4) {
						if(ajax.responseText.indexOf("nueva")==-1){
							document.form.nombre.value = ajax.responseText;
						}else{
							viewPersona(valor2,valor);
						}
					}
				}
				ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				ajax.send("documento="+valor+"&tipo="+valor2);
			}		
		}

 
   function validarNumInicio(documento){
       ///alert("OK-");
          if(documento.value==""){
                alert("Digite Numero de Inicio");
                  return false;
            }else return true;
   }
   function validarNumFinal(comparendo){
           //alert("OK-");
           if(comparendo.value==""){
                  alert("Digite Numero Final");
                  return false;
            }else return true;
   }
	 
   function validarResolucion(radicado){
       // alert("OK-");
        if(radicado.value==""){
              alert("Digite Resolucion");
                return false;
         }else return true;
   }

 function validarFecha(fecha){
        if(fecha.value==""){
               alert("Seleccione La Fecha de Resolucion");
                return false;
        }else return true;
   }       
	 
   function validarFormulario(){
       if(document.form.documento.value.length>0){
           if(document.form.comparendo.value.length>0){
               if(document.form.radicado.value.length>0){
                   if(document.form.fecha.value.length>9){
                      alert("funciono");
                      document.form.action="ProcesarSolicitudAudiencia.jsp";
                      document.form.submit();
                  }else{
                      alert("digite fecha");
                  }
             }else{
                 alert("digite radicado");
             }
         }else{
             alert("digite comparendo");
         }
       }else{
           alert("digite documento");
       }
   }
   
	function regresar(){
		document.form.action = "pantallazo.jsp";
		document.form.submit();
	}		
	
		</script>
		
<title></title>

<style type="text/css">
<!--
.Estilo3 {color: #000000; font-weight: bold; }
.Estilo4 {color: #000000}
.style1 {font-family: Tahoma; 	font-size: 12px; 	color: #333333;}
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style3 {	color: #333333; 	font-weight: bold; 	font-size: 12px; 	font-family: Tahoma;}
.Estilo2 {color: #FFFFFF; 	font-family: Tahoma; 	font-size: 12px; 	font-weight: bold; }
-->
</style>
</head>

<body>
<form id="form" name="form" method="post" action="" onSubmit="return validarFormulario(this)">
 <fieldset  style="width:inherit"><div align="center">
    <legend align="center" class="style2 style1"><strong></strong></legend>
 	</div>
 
  <table width="607" border="0"  bordercolor="#FFFFFF" align="center"  >
    <tr><td colspan="6"> 
	<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="Estilo2">ADICIONAR</span>
			</td> 
	</tr>
    <tr>
	  <td width="100">&nbsp;</td>
      <td width="89">&nbsp;</td>
      <td colspan="4"><span class="Estilo4">
        <label></label>
      </span></td>
    </tr>
   
    <tr>
	  <td><span class="style2">T. Documento&nbsp;<select name="tipo" style="width:100px;font-size:11px">
          <%
         Parametro parametro = new Parametro();
         List list=modelo.listadoParametros(5);
         Iterator it = null;
         it = list.iterator(); 
           while (it.hasNext()) {
                    parametro = (Parametro)it.next();
				
         %>
          <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
          <%}%>
        </select></span></td>
      <td><span class="style2">Nº&nbsp;Docuemnto</span> </td>
      <td width="120"><span class="Estilo4">
        <label>
        <input type="text" name="documento"  id="documento" onblur="validarPersona()" style="width:120px; text-align:center; font-size:11px"/>
        </label>
      </span></td>
      <td width="118"><span class="style2">Nº&nbsp;Comparendo</span> </td>
      <td colspan="2"><span class="Estilo4">
        <label>
        <input name="comparendo" type="text" onblur="" size="20%"  maxlength="20" />
        </label>
      </span></td>
    </tr>
	<Tr>
	      <td colspan="6" align="center"><span class="Estilo4">
        <label>
        <input name="nombre" type="text"  style="width:400px; text-align:center; font-size:11px" id="nombre" readonly="" />
        </label>
      </span></td>
	</Tr>
    <tr>
	<td>&nbsp;<span class="style2">RADICADO</span></td>
      <td>&nbsp;<span class="Estilo4">
        <label>
        <input type="text" size="13%" name="radicado" />
        </label>
      </span></td>
      <td>&nbsp;</td>
      <td><span class="style2">FECHA. </span></td>
      <td width="122"><input name="fecha" type="text" id="fecha" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat" size="20%" onkeyup="mascara(this,'/',true)" maxlength="10"   /></td>
      <td width="32">
	  <button name="button" type="button" id="lanzador"> <img src="../html/images/calendario.png" width="19" height="18"/></button>
	  <!--<input name="button" type="button" id="lanzador"  value="<<" />--></td>
      <script type="text/javascript">
           Calendar.setup({
            inputField     :    "fecha",      // id del campo de texto
            ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de textoh
            button         :    "lanzador"   // el id del bot&iuml;&iquest;&frac12;n que lanzar&iuml;&iquest;&frac12; el calendario
         });
        </script>
   </tr>
   <tr>
   <td colspan="6">&nbsp;</td></tr>
  </table>
  <table width="50%" border="0" align="center">
    <tr>
      <td width="25%" align="center"><label>
<button type="submit" name="Submit" class="style2">Guardar  <img  src="../html/images/guardar.png"  width="19" height="18"/></button>	  
<!--        <input type="submit" name="Submit" value="Guardar Venal" /> -->
      </label></td>
      <td width="25%" align="center"><span style="border:none">
	  <button name="cancelar" type="button" id="cancelar" onclick="regresar()" class="style2">Cancelar <img  src="../html/images/cancelar.png"  width="19" height="18"/></button>	
<!--        <input name="cancelar" type="button" id="cancelar" value="Cancelar" style="width:100px; text-align:center" onclick="regresar()"/>-->
      </span></td>
    </tr>
  </table>
  </fieldset>
  <p>&nbsp;</p>
</form>
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
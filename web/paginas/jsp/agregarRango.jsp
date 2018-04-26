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
     
     
     
     
    var digits = "0123456789"; 
    var lowercaseLetters = "abcdefghijklmnopqrstuvwxyz" 
    var uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" 
    function isLetter (c) 
    { 
    return( ( uppercaseLetters.indexOf( c ) != -1 ) || ( lowercaseLetters.indexOf( c ) != -1 ) ) 
    } 

   function isDigit (c) 
   {   return ((c >= "0") && (c <= "9")) 
   } 

// c es letra o digito 
   function isLetterOrDigit (c) 
   {   return (isLetter(c) || isDigit(c)) 
   }   
     
 function validarRangosIni(){
	  var tInicio= document.form.inicio.value;
	  var dato1 = tInicio.charAt(0);
	  var dato2 = tInicio.charAt(1);
	  var dato3 = tInicio.charAt(2);
	  var dato4 = tInicio.charAt(3);
	  var dato5 = tInicio.charAt(4);
	  var dato6 = tInicio.charAt(5);
	 
          
    if(document.form.tipo.value==1){
      if(document.form.inicio.value.length ==6 ){
         if(!((isLetter(dato1))&&(isLetter(dato2))&&(isLetter(dato3))&&(isDigit(dato4))&&(isDigit(dato5)) &&(isDigit(dato6))) ){
                alert("La Placa del vehiculo no es valida, Por Favor Verifique ");  
				return false;
          }      
     }else{
          if(document.form.inicio.value.length!=0){
             alert("La Placa del vehiculo debe tener 6 Caracteres, Por Favor Verifique "); 
			 return false;
          }
      }
    }// fin value 1
     
    if(document.form.tipo.value==2){    
       if(document.form.inicio.value.length ==6){
         if(!((isLetter(dato1))&&(isLetter(dato2))&&(isLetter(dato3))&&(isDigit(dato4))&&(isDigit(dato5))&&(isLetter(dato6)) )){
            alert("La Placa de la motocicleta no es valida, Por Favor Verifique ");  
			return false;
         }      
       }else{
         if(document.form.inicio.value.length!=0){
            alert("La Placa de la motocicleta debe tener 6 Caracteres, Por Favor Verifique "); 
			return false;
         }
       }
    }// value 2  
    
	 return true;
}//fin del metodo validar rango

function validarFin_Ini(){
	  var tInicio= document.form.inicio.value;
	  var tFinal= document.form.nfinal.value;
	  
	  var Idato1 = tInicio.charAt(0);
	  var Idato2 = tInicio.charAt(1);
	  var Idato3 = tInicio.charAt(2);
	  var Idatos = (tInicio.charAt(3)+""+tInicio.charAt(4)+""+tInicio.charAt(5));
	  var IdatosM=(tInicio.charAt(3)+""+tInicio.charAt(4));
          var IdatosM1 = tInicio.charAt(5);
	  	  
	  var Fdato1 = tFinal.charAt(0);
	  var Fdato2 = tFinal.charAt(1);
	  var Fdato3 = tFinal.charAt(2);
	  var Fdatos = (tFinal.charAt(3)+""+tFinal.charAt(4)+""+tFinal.charAt(5));
          var FdatosM= (tFinal.charAt(3)+""+tFinal.charAt(4));
	  var FdatosM1 = tFinal.charAt(5);
	 
	  if(document.form.tipo.value==1){ 
            if((Idato1==Fdato1)&&(Idato2==Fdato2)&&(Idato3==Fdato3)){
					if(Idatos>Fdatos){
						alert("El rango final no puede ser menor que el Inicial, Por Favor Verifique "); 
						alert("Idatos= "+Idatos+" Fdatos= "+Fdatos);  
						return false;
					}
	  		}else{
					alert("Los rangos no coinciden, Por Favor Verifique ");  
						return false;
			}
	 }
	 
	 if(document.form.tipo.value==2){ 
	  		if((Idato1==Fdato1)&&(Idato2==Fdato2)&&(Idato3==Fdato3)&&(IdatosM1==FdatosM1)){
					if(IdatosM>FdatosM){
						alert("El rango final no puede ser menor que el Inicial, Por Favor Verifique ");  
						return false;
					}
	  		}else{
					alert("Los rangos no coinciden, Por Favor Verifique ");  
						return false;
			}
	 }
	 return true;
}




 function validarRangosFin(){
	  var tFinal= document.form.nfinal.value;
	  var dato1 = tFinal.charAt(0);
	  var dato2 = tFinal.charAt(1);
	  var dato3 = tFinal.charAt(2);
	  var dato4 = tFinal.charAt(3);
	  var dato5 = tFinal.charAt(4);
	  var dato6 = tFinal.charAt(5);
	 
          
    if(document.form.tipo.value==1){
      if(document.form.nfinal.value.length ==6 ){
         if(!((isLetter(dato1))&&(isLetter(dato2))&&(isLetter(dato3))&&(isDigit(dato4))&&(isDigit(dato5)) &&(isDigit(dato6))) ){
                alert("La Placa del vehiculo no es valida, Por Favor Verifique ");  
				return false;
          }      
     }else{
          if(document.form.nfinal.value.length!=0){
             alert("La Placa del vehiculo debe tener 6 Caracteres, Por Favor Verifique "); 
			 return false;
          }
      }
    }// fin value 1
     
    if(document.form.tipo.value==2){    
       if(document.form.nfinal.value.length ==6){
         if(!((isLetter(dato1))&&(isLetter(dato2))&&(isLetter(dato3))&&(isDigit(dato4))&&(isDigit(dato5))&&(isLetter(dato6)) )){
            alert("La Placa de la motocicleta no es valida, Por Favor Verifique ");  
			return false;
         }      
       }else{
         if(document.form.nfinal.value.length!=0){
            alert("La Placa de la motocicleta debe tener 6 Caracteres, Por Favor Verifique "); 
			return false;
         }
       }
    }// value 2  
    validarFin_Ini();
		
	
	 return true;
	 
}//fin del metodo validar rango




   function validarNumInicio(inicio){
          if(inicio.value==""){
                alert("Digite Numero de Inicio");
                  return false;
            }else return true;
   }
   function validarNumFinal(nfinal){
           if(nfinal.value==""){
                  alert("Digite Numero Final");
                  return false;
            }else return true;
   }
	 
   function validarResolucion(resolucion){
        if(resolucion.value==""){
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
	 
   function validarFormulario(form)
   {
       with(form){
    
         if(validarNumInicio(inicio)==false){
             inicio.focus();
             return false;
         }
        if(validarNumFinal(nfinal)==false){
             nfinal.focus();
             return false;
         }
	 
	if(validarResolucion(resolucion)==false){
         resolucion.focus();
          return false;
     }
	  if(validarRangos()==false){
             document.form.inicio.focus();
             return false;
	 }	
	  if(validarFecha(fecha)==false){
		  fecha.focus();
		 return false;
	 }
	 
    }
   }
   
	function regresar(){
		document.form.action = "listar_rangos.jsp";
		document.form.submit();
	}		
	
		</script>
		
<title>Agregar Rango</title>

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
<form id="form" name="form" method="post" action="procesarRango.jsp" onSubmit="return validarFormulario(this)">
 <fieldset  style="width:inherit"><div align="center">
    <legend align="center" class="style2 style1"><strong></strong></legend>
 	</div>
 
  <table width="650" border="0"  bordercolor="#FFFFFF" align="center"  >
    <tr><td colspan="5"> 
		<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="Estilo2">ADICIONAR</span>
			</td> 
		</tr>
    <tr>
      <td><span class="style2">TIPO</span></td>
      <td colspan="4"><span class="Estilo4">
        <label></label>
        <select name="tipo"  id="tipo" style="font-size:13px; width:33%"  onfocus="setTipo()" >
          <%     

         Parametro parametro = new Parametro();
         List listParam;	
         listParam=modelo.listadoParametros(161);
         Iterator itr = listParam.iterator(); 
         while (itr.hasNext()) {
                   parametro = (Parametro)itr.next(); 
                 
         %>
          <option value="<%=parametro.getCodigo()  +""%>"><%= parametro.getNombre() %></option>
          <%}%>
        </select>
      </span></td>
    </tr>
   
    <tr>
      <td><span class="style2">Nº&nbsp;INICIAL</span> </td>
      <td><span class="Estilo4">
        <label>
        <input type="text" name="inicio"  size="30%" onblur="validarRangosIni()" maxlength="6"/>
        </label>
      </span></td>
      <td><span class="style2">Nº&nbsp;FINAL</span> </td>
      <td colspan="2"><span class="Estilo4">
        <label>
        <input name="nfinal" type="text" onblur="validarRangosFin()" size="30%"  maxlength="6" />
        </label>
      </span></td>
    </tr>
    <tr>
      <td><span class="style2">RESOLUCION</span></td>
      <td><span class="Estilo4">
        <label>
        <input type="text" size="30%" name="resolucion" />
        </label>
      </span></td>
      <td><span class="style2">FECHA&nbsp;RES. </span></td>
      <td width="144"><input name="date" type="text" id="fecha" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat" size="24%" onkeyup="mascara(this,'/',true)" maxlength="10"   /></td>
      <td width="89">
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
   <td colspan="5">&nbsp;</td></tr>
  </table>
  <table width="50%" border="0" align="center">
    <tr>
      <td width="25%" align="center"><label>
<button type="submit" name="Submit" class="style2">Guardar Venal <img  src="../html/images/guardar.png"  width="19" height="18"/></button>	  
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
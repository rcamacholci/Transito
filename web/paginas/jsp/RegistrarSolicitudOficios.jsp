<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                    modelo.Model modelo = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
        %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Vehiculo</title>
<style type="text/css">

<!--
.Estilo8 {color: #333333; font-weight: bold; font-size: 12px; }
.Estilo14 {color: #333333; font-size: 12px; }
.style1 {font-family: Tahoma}
.style2 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.Estilo18 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
-->
</style>
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="../html/scripts/calendar.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
 function revisar(){
     
		if(document.form.numOficio.value.length>0){
			if(document.form.fechaO.value.length>0){
                              if(document.form.entidad.value.length>0){
                                if(document.form.solicitante.value.length>0){
                                        if(document.form.cargo.value.length >0){
                                                if(document.form.referencia.value.length >0){
                                                        if(document.form.direccion.value.length >0){
                                                                if(document.form.municipio.value.length >0){
                                                                        if(document.form.numRadicacion.value.length >0){
                                                                                if(document.form.fechaR.value.length >0){
                                                                                     document.form.submit();
                                                                                }else{
                                                                                    alert("Digite la fecha de Radicacion");
                                                                                } 
                                                                        }else{
                                                                            alert("Digite el Numero de Radicacion");
                                                                        }
                                                                }else{
                                                                    alert("Digite el cargo del solicitante");
                                                                }
                                                        }else{
                                                            alert("Digite la direccion del solicitante");
                                                        }
                                                }else{
                                                    alert("Digitela referencia del solicitante");
                                                }
                                        }else{
                                            alert("Digite el cargo del solicitante");
                                        }
                                }else{
                                    alert("Digite el solicitante");
                                }
                              }else{
                                    alert("Digite la entidad");
                                }
			}else{
				alert("Digite la fecha del Oficio");
			}
		}else{
			alert("Digite el numero de oficio");
		}
           }
        
	</script>
<style type="text/css">
<!--
.Estilo21 {color: #333333}
-->
</style>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%



                      %>
    <body>
        <form name="form" method="post" action="procesarSolicitudOficio.jsp">
	<fieldset>
	<table width="90%" border="0" align="center">
		<tr>
		
		<td width="86%" align="center" class="style2 Estilo21">REGISTRAR SOLICITUD DE OFICIOS </td>
		</tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
	  			</tr>
               
		
		<tr>
                    <td colspan="3">
				<fieldset class="style1">
				
				
				<table width="100%" border="0" align="center">
					<tr style="border:none; background:url(../html/images/inicio_3.png)">
				<td colspan="6" align="center" valign="middle"><span class="Estilo18">DATOS DEL SOLICITANTE  </span></td>
			</tr>
			<tr><td colspan="4">&nbsp;</td></tr>
			
					<tr>
						<td width="25%"><span class="Estilo8">N&ordm; OFICIO </span></td>
						<td width="25%">
							<span class="Estilo8">
						      <input type="text" name="numOficio"  id="numOficio" value="" style="width:150px; color:#333333; text-align:center"/>
					  </span>					  </td>
						<td width="25%"><span class="Estilo8">FECHA OFICIO </span></td>
    					<td width="25%">
						  <span class="Estilo8">
						    	<input id="fechaO" name="fechaO" type="text" value="" style=" width:130px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10"/>
	<button name="btfechaO" type="button" id="btfechaO"><img src="../html/images/calendario.png"  width="18" height="18"/></button>
					  </span>				<!--	  <input name="btfechaO" type="button" id="btfechaO" value="&lt;" style="width:20px; text-align:center"/> -->
					     <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fechaO",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "btfechaO"   // el id del bot?n que lanzar? el calendario
			});
		 </script>
					  </td>
						
					</tr>
					<tr>
						<td width="16%"><span class="Estilo8">ENTIDAD</span></td>
					    <td colspan="3"><span class="Estilo8">
					  <input name="entidad" id="entidad" type="text"  value="" style=" width:420px;color:#333333; text-align:center"/></span>						</td>
						
					   
					</tr>
					<tr>
						<td width="16%"><span class="Estilo8">SOLICITANTE</span></td>
					    <td colspan="3"><span class="Estilo8">
					  <input name="solicitante" id="solicitante" type="text"  value="" style=" width:420px;color:#333333; text-align:center"/></span>						</td>
						
					   
					</tr>
					<tr>
						<td><span class="Estilo8">CARGO</span></td>
					    <td><span class="Estilo8">	
							<input name="cargo"  id="cargo" type="text"  value="" style=" width:150px;color:#333333; text-align:center" /></span>						</td>
						<td><span class="Estilo8">REFERENCIA</span></td>
					    <td><span class="Estilo14">
							<input name="referencia" id="referencia" type="text"  value="" style=" width:170px;color:#333333; text-align:center"/></span>						</td>
						
					</tr>
					<tr>
						<td><span class="Estilo8">DIRECCION</span></td>
					    <td><span class="Estilo8">
					  <input name="direccion" id="direccion" type="text"  value="" style=" width:150px;color:#333333; text-align:center"/></span>						</td>
						<td><span class="Estilo8">MUNICIPIO </span></td>
					    <td><span class="Estilo8">
							<input name="municipio" id="municipio" type="text"  value="" style=" width:170px;color:#333333; text-align:center"/></span>						</td>					    
                                               
					</tr>
					
				</table>
				</fieldset>          </td>
		</tr>
		<tr><td>&nbsp;</td></tr>
	
		<tr>
			<td colspan="3">
				<fieldset class="style1">

				<table width="100%" border="0" align="center">
				<tr style="border:none; background:url(../html/images/inicio_3.png)">
				<td colspan="6" align="center" valign="middle"><span class="Estilo18">DATOS DE LA RADICACION DEL OFICIO </span></td>
			</tr>
						<tr><td colspan="4">&nbsp;</td></tr>
				
					<tr>
						<td width="25%"><span class="Estilo8">NUMERO&nbsp;DE&nbsp;RADICACION </span></td>
 					    <td width="23%"><span class="Estilo8">
							<input  name="numRadicacion"type="text" value="" style="width:150px;color:#333333;text-align:center"/>
					  </span>						</td>
						<td width="25%"><span class="Estilo8">FECHA&nbsp;DE&nbsp;RADICACION </span></td>
					    <td width="27%"><span class="Estilo8">
							<input  id="fechaR"  name="fechaR" type="text" value="" style="width:130px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333;text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10"/>
					  </span>
	<button  name="btfechaR" type="button" id="btfechaR"><img src="../html/images/calendario.png"  width="18" height="18"/></button>				  
				    <!--  <input name="btfechaR" type="button" id="btfechaR" value="<" style="width:20px; text-align:center"/>  -->
					   <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fechaR",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "btfechaR"   // el id del bot?n que lanzar? el calendario
			});
		 </script>
					  </td>
					</tr>
				</table>
				</fieldset>		  </td>
		</tr>		
			<tr>
			<td>&nbsp;</td>
			</tr>	
		
		<tr>
			<td colspan="3" align="center">
<button name="adicionar" type="button" id="adicionar" onclick="revisar()"><span class="style2">Registrar Solicitud </span><img src="../html/images/guardar.png" width="19" height="18"/></button>			
	<!-- <input name="adicionar" type="button" id="adicionar" value="Registrar Solicitud" style="width:200px; text-align:center" onclick="revisar()"/> --></td> 
		</tr>
	</table>		
	</fieldset>  

 	
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
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){ 
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>
<html xmlns="http://www.w3.org/1999/xhtml"> 
<head>
		<META http-equiv=Content-Type content="text/html; charset=windows-1252">
        <link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script type="text/javascript" src="../html/scripts/adicionar_comparendo.js"></script>
        <script type="text/javascript" src="../html/scripts/consultasGenerales.js"></script>
		
<title>Adicionar Comparendo</title>
<style type="text/css">
<!--
.Estilo3 {color: #0066CC}
.style4 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style7 {font-size: 12px; font-weight: bold; color: #FFFFFF; font-family: Tahoma; }
.Estilo24 {
	font-family: Tahoma;
	color: #333333;
}
.Estilo25 {font-size: 10px}
.Estilo26 {color: #333333; font-family: Tahoma; font-weight: bold;}
-->
</style>
<script language="javascript" type="text/javascript">
</script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
</head>

<body onload="recargarDatos(document.form)">
<center>
<form name="form" method="post" action="procesar_comparendo.jsp" onSubmit="return validarFormulario(this)">
<% 
Model modelo= (Model)session.getAttribute("model"); 
Parametro parametro=new Parametro();
Infraccion infraccion= new Infraccion();
Sede sede=new Sede();
Categoria categoria=new Categoria();
if(modelo!=null){

%>
<fieldset>

	<table width="80%" border="0" align="center">
	<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style2 style14 style7">ADICIONAR COMPARENDOS </span></td>
	  </tr>
	  <tr><td>&nbsp;</td></tr>
		<tr>
			<td>
				<fieldset class="Estilo25">
				<table width="90%" border="0" align="center">
				<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style2 style14 style7">INFORMACION DEL COMPARENDO</span></td>
		  </tr>
				  <tr>
					<td width="15%" class="Estilo26"><div align="left">Nº&nbsp;COMPARENDO</div></td>
					<td width="28%" class="Estilo26"><input name="comparendo" type="text" class="Estilo3" style="width:150px; text-align:center" onkeypress="return soloNumeros(event)" onblur="Validar_Comparendo()"/></td>
					<td width="4%">&nbsp;</td>
					<td width="20%" align="center"><div align="left"><span class="Estilo26">HORA</span></div></td>
					<td width="33%"><strong>
					  <select name="horas" style="width:50px">
										  
						<% for(int m=0;m<24;m++){ %>
						<option><%=m%></option>
						<% } %>
					  </select>
					  <select name="minutos" style="width:50px">
						<% for(int s=0;s<60;s++){ %>
						<option><%=s%></option>
						<% } %>
					  </select>
					  <span class="Estilo26">hh:mm</span></strong></td>
				</tr>
				 <tr>
					<td><div align="left"><span class="Estilo26">FECHA </span></div></td>
					<td><strong>
					<input type="text" name="fecha_comp" id="fecha_comp"  style="width:120px; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10" />
					  <input name="Bfecha_comp" type="button" id="Bfecha_comp" value="<<" style="width:22px"/>
								  <SCRIPT type="text/javascript">
						   Calendar.setup({
						   inputField     :    "fecha_comp",      // id del campo de texto
						   ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
						   button         :    "Bfecha_comp"   // el id del botón que lanzará el calendario
						  });
						</SCRIPT>
					</strong></td>
					<td>&nbsp;</td>
					<td align="center"><div align="left"><span class="Estilo26">PLACA</span></div></td>
				   <td>
					  <strong>
					  
					  <input name="placa" type="text" style="width:150px; text-align:center" onblur="validarPlacaVehiculo()"/>
					  </strong></td>
			  </tr>
			  <tr>
				 <td><div align="left"><span class="Estilo26">LUGAR </span></div></td>
				 <td colspan="">
					<strong>
					
					<input name="lugar" type="text" class="Estilo3" style="width:150px"/>
					</strong></td>
					<td>&nbsp;</td>
					<td align="center"><div align="left"><span class="Estilo26">L.&nbsp;TRANSITO</span></div></td>
					<td><input name="licencia_transito" id="licencia_transito" type="text" style="width:150px;text-align:center"/></td>
			   </tr>
			   
			   <tr>
					<td><div align="left"><span class="Estilo26">CLASE&nbsp;VEHICULO</span></div></td>
					<td>
						<strong>
						<select name="clase"  onchange="" style="width:150px">
												<option value="0" ><<--Seleccione-->></option>
						  <%	List list=modelo.listadoParametros(1);
							Iterator it = list.iterator(); 
							while (it.hasNext()) {
								parametro = (Parametro)it.next();%>
						  <option value="<%=parametro.getCodigo()%>"> <%=parametro.getNombre() %> </option>
						  <%}%>
						</select>
						</strong></td>
					<td>&nbsp;</td>
					<td align="center"><div align="left"><span class="Estilo26">SERVICIO</span></div></td>
					<td><strong>
					  <select name="servicio" style="width:150px">
										  <option value="0" ><<--Seleccione-->></option>
						<%  List listServicio=modelo.listadoParametros(3);	
							parametro=null;		 
							Iterator itr = listServicio.iterator(); 
							while (itr.hasNext()) {
								parametro = (Parametro)itr.next();	%>
						<option value="<%=parametro.getCodigo()%>"> <%=parametro.getNombre() %> </option>
							<%}%>
					  </select>
					  
					</strong></td>
			  </tr>
			 
			</table>
			</fieldset>		</td>
	</tr>
	</br>
	<tr>
		<td>
			<fieldset class="Estilo25">
			<table width="90%" border="0" align="center"> 
			<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style2 style14 style7">INFORMACION DEL INFRACTOR </span></td>
		  </tr>
			<tr>
			  <td width="15%"><div align="left"><span class="Estilo26">&nbsp;TIPO DOC. </span></div></td>
			  <td width="28%"><strong>
                                      <select name="tipo_doc" id="tipo_doc" style="width:150px" onchange="consultaPersona(this.id, 'documento', 'nombre') ">
                               
			      <% 
					 List lista_id=modelo.listadoParametros(5);
					 Iterator itrtor = lista_id.iterator(); 
					 while (itrtor.hasNext()) {
						   parametro = (Parametro)itrtor.next();%>
			      <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
	              <%}%>
		        </select>
		      </strong> </td>
			  <td width="4%">&nbsp;</td>
			  <td width="20%"><div align="left"><span class="Estilo26">NUMERO </span></div></td>
                          <td width="33%"><input name="documento" type="text" id="documento" style="width:150px;text-align:center" onkeypress="return soloNumeros(event)" onblur="consultaPersona('tipo_doc', this.id, 'nombre');ConsultarLicenciaConduccion()"/></td>
		  </tr>
		  <tr>
			  <td><div align="left"><span class="Estilo26">NOMBRE</span></div></td>
			  <td colspan="4"  align="justify"><input name="nombre" type="text" id="nombre"  style="width:450px" readonly=""/></td>
		  </tr>
		  <tr>	  
				<td><div align="left"><span class="Estilo26">TIPO&nbsp;INFRACTOR</span></div></td>
				<td><strong>
				  <select name="tipo_infractor" id="tipo_infractor" style="width:150px">
                                      
				    <% 
					 parametro=null;		
					 List L_tipo_inf=modelo.listadoParametros(6);
					 Iterator itt = L_tipo_inf.iterator(); 
						while (itt.hasNext()) {
							parametro = (Parametro)itt.next(); %>
				    <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
		             <%}%>
			      </select>
				  </strong> </td>
				<td>&nbsp;</td>
				<td><div align="left"><span class="Estilo26">Nº&nbsp;INFRACCION </span></div></td>
				<td><input name="id_infraccion" type="text"  style="width:150px;text-align:center" onblur="seleccionarInfraccion()"/></td>
		  </tr>
		  <tr>
			 <td><div align="left"><span class="Estilo26">INFRACCION</span></div></td>
			 <td colspan="4" align="justify"><span style=""><strong>
			   <select name="infraccion" id="infraccion"  onchange="setInfraccion()" style="width:445px">
                               <option value="0"  ><<--Seleccione-->></option>
			     <% 
				 
				 List list_infr;	
				 list_infr=modelo.listarInfracciones();
				 it = list_infr.iterator(); 
				 while (it.hasNext()) {
							infraccion = (Infraccion)it.next();
						
				 %>
			     <option value="<%=infraccion.getNumero()+""%>"><%=infraccion.getDescripcion().substring(0, infraccion.getDescripcion().length() > 114?114:infraccion.getDescripcion().length()) %></option>
			     <%}%>
	         </select>
			 </strong></span></td>
		  </tr>
		  <tr>
			<td><div align="left"><span class="Estilo26">L.&nbsp;CONDUCCION</span></div></td>
                        <td><input name="lic_conduccion" type="text" id="lic_conduccion"  style="width:150px;text-align:center" /></td>
			<td>&nbsp;</td>
			<td><div align="left"><span class="Estilo26">F.&nbsp;VENCIMIENTO</span></div></td>
			<td>
			  <input name="fecha_venc" type="text" id="fecha_venc" style="width:120px; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10"/>
<button name="button" type="button" id="Bfecha_venc" ><img src="../html/images/calendario.png" width="18" height="18" /></button>			  
			<!--  <input name="button" type="button" id="Bfecha_venc" value="<<"  style="width:22px"/>	-->	</td>
		  </tr>
		  <tr>
			 <td><div align="left"><span class="Estilo26">CATEGORIA</span></div></td>
			 <td><strong>
			   <select name="categoria" id="categoria" style="width:150px">
                               <option value="0" ><<--Seleccione-->></option>
			     <% java.util.List categorias = modelo.listadoParametros(221);
						for (int i = 0; i < categorias.size(); i++) {
						   parametro = (Parametro) categorias.get(i); %>
                       <option value="<%=parametro.getNombre()%>"><%= parametro.getNombreCorto()%> </option>
                       <%  } %>
	         </select>
			   </strong> </td>
			 <td>&nbsp;</td>
			 <td><div align="left"><span class="Estilo26">SEDE&nbsp;EXPEDICION</span></div></td>
			 <td>
			   <SCRIPT type="text/javascript">
				   Calendar.setup({
				   inputField     :    "fecha_venc",      // id del campo de texto
				   ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				   button         :    "Bfecha_venc"   // el id del botón que lanzará el calendario
				  });
				</SCRIPT>	 
			   <select name="expedido_en" id="expedido_en" style="width:150px">
                               <option value="0" ><<--Seleccione-->></option>
				 <% 
				  List sedes=modelo.consultarSedes();
				  itt = sedes.iterator(); 
				  while (itt.hasNext()) {
					   sede = (Sede)itt.next();  %>
				 <option value="<%=sede.getId_sede()%>"><%=sede.getCodigo()+" - "+sede.getNombre_corto() %></option>
				 <%}%>
			   </select>			</td>
		  </tr>
		  
		  </table>
	    </fieldset>		</td>
	</tr>
	</br>
	<tr>
		<td>  
		<fieldset class="Estilo25">
		    <table width="90%" border="0" align="center"> 
			<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="11" align="center"><span class="style2 style14 style7">DATOS DEL AGENTE DE TRANSITO  </span></td>
		  </tr>
		  <tr>
			<td width="15%"><span class="Estilo26">NUMERO&nbsp;PLACA </span></td>
			<td width="23%">
			  <strong>
			  <input type="text" name="placa_agente" size="25" onblur="validarAgente()"  style="width:60px;text-align:center" onkeypress="return soloNumeros(event)" />
			  <input name="button3" type="button" id="button" value="&lt;&lt;"  style="width:20px"/>
              </strong></td>
			<td width="62%" colspan="3"  align="left"><input name="nombre_agente" type="text"  style="width:330px" readonly=""/></td>
			</tr>
		  
		   <tr>
		     <td colspan="5"><table width="100%" border="0" cellspacing="0" cellpadding="0">
               <tr>
                 <td width="20%" align="center" class="Estilo24"><strong>ACCIDENTE
                 
                     <input name="accidente" type="checkbox" id="accidente" value="1" />
                 </strong></td>
                 <td width="20%" align="center" class="Estilo24"><strong>INMOVILIZACION
                     <input name="inmovilizacion" type="checkbox" id="inmovilizacion" value="1" onclick="verParqueadero()" />
                 </strong></td>
                 <td width="20%" align="center" class="Estilo24"><strong>FUGA
                     <input name="fuga" type="checkbox"  value="1" id="fuga" />
                 </strong></td>
                 <td width="20%" align="center" class="Estilo24"><strong>POLCA
                     <input name="policia" type="checkbox" id="policia" value="1" />
                 </strong></td>
                 <td width="20%" align="center" class="Estilo24"><strong>FIRMA&nbsp;INFRACTORr
                     <input name="firma" type="checkbox" id="firma" value="1" />
                 </strong></td>
               </tr>
             </table></td>
		     </tr>
		   <tr>
			  <td><label id="lparqueadero" style="display:none; color: #333333; font-family: Tahoma;"><strong>Parqueaderos</strong></label></td>
				 <td colspan="4">				   <strong>
				   <select id="parqueaderos" name="parqueaderos" style="display:none; width:515px" >
                                       <option value="0" ><<--Seleccione-->></option>
				     <% sede = (Sede) session.getAttribute("sede");
                        java.util.List listaP = listaP=modelo.listarPatios(sede.getId_sede());
						for(int i=0;i<listaP.size();i++){
							Patio patio = (Patio)listaP.get(i);%>
				     <option  value="<%=patio.getId_patio()%>"><%=patio.getNombre()%></option>
				     <% }
					%>
			       </select>
			       </strong>				 </td>
		   </tr>
			<tr class="Estilo26">
			  <td><strong>OBSERVACIONES</strong></td>
			  <td colspan="4"  align="justify"><input name="observaciones" type="text" id="observaciones"  style="width:450px"/></td>
			</tr>
			
		 
			
		</table>
		</fieldset>		</td>
	</tr>
	</br>
	<tr>
				<td colspan="5" align="center">
<button type="submit" name="guardar" id="guardar"><span style="">Guardar Comparendo</span><img src="../html/images/guardar.png" width="18" height="18" /></button>			
				<!--<input type="submit" name="guardar" id="guardar" value="Guardar Comparendo" />--></td>
			</tr>
	</table>	
	</fieldset>
<% } %>
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


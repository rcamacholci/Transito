<%@ page  import = "modelo.*" import = "java.util.*" import = "java.sql.*"    %>
<html>
<head>
    <title>FormularioTramite</title>
    <script language="javascript" type="text/javascript">
            function anularP(){
                if(confirm("Esta seguro de anular esta radicacion?")){
                    document.form1.action = "aprobarTramiteRUNT.jsp?del=0";
                    document.form1.submit();
                }
            }
            function renovarP(){
                if(confirm("Esta seguro de renovar esta radicacion?")){
                    document.form1.action = "aprobarTramiteRUNT.jsp?ren=1";
                    document.form1.submit();
                }
            }
            function autenticarP(){
                if(confirm("Esta seguro de renovar la Autenticacion del Solicitante?")){
                    document.form1.action = "aprobarTramiteRUNT.jsp?ren=1";
                    document.form1.submit();
                }
            }

            function nuevoP(){
                document.form1.action = "seleccionTramites.jsp";
                document.form1.submit();
            }
            function consultaP(){
                document.form1.action = "consultarRadicacion.jsp";
                document.form1.submit();
            }
            function editarF(idr,idt){
		document.location.href = "editarFormulario.jsp?idRadicacion="+idr+"&idTramite="+idt;
            }
            function deshabilitar(){
                document.form1.aprobar.disabled = true;
                document.form1.aprobar.value = "Espere...";
            }
	</script>
<style type="text/css">
<!--
.Estilo1 {
	color: #0066CC;
	font-weight: bold;
}
.Estilo7 {font-size: 14px}
.Estilo9 {color: #333333}
.Estilo13 {color: #333333; font-size: 12px; }
.Estilo14 {font-size: 12px; color: #FF0000; font-weight: bold; font-style: italic; }
.Estilo15 {
	color: #0066CC;
	font-size: 14px;
}
.Estilo16 {font-size: 13px; color: #FF0000; font-weight: bold; font-style: italic; }
.Estilo18 {color: #333333; font-weight: bold; font-size: 12px; }
.Estilo20 {font-size: 12px;color: #FFFFFF;}
.style1 {color: #003399}
.style2 {
	color: #003399;
	font-size: 12px;
	font-weight: bold;
}
.Estilo21 {
	font-size: 12px;
	font-weight: bold;
	color: #00309C;
}
.style4 {font-size: 12px; color: #6365CE;}
-->
</style>
</head>
<%
   try{
        if(session.getAttribute("vehiculo")!=null){
            session.removeAttribute("vehiculo");
            session.removeAttribute("propietarios");
            session.removeAttribute("colores");
            session.removeAttribute("especificaciones");
            session.removeAttribute("caracteristicas");
            session.removeAttribute("seleccionados");
            session.removeAttribute("radicacion");
            java.util.Enumeration remA = session.getAttributeNames();
            if(remA!=null){
                while(remA.hasMoreElements()){
                    String key = remA.nextElement().toString();
                    if(key.indexOf("apoderado")!=-1){
                        session.removeAttribute(key);
                    }
                }
            }
        }
	Model model = (Model) session.getAttribute("model");
        java.util.HashMap tipdocs = model.crearHashParametrosAbreviatura(5);
	Sede sede = (Sede) session.getAttribute("sede");
        Radicacion radicacion = null;
	String numero = "";
        String fecha = "";
        if(request.getParameter("radicacion")!=null&&request.getParameter("fecha")!=null){
            numero = request.getParameter("radicacion");
            fecha = request.getParameter("fecha");
            fecha = fecha.replaceAll("-", "/");
            radicacion = model.consultarRadicacion(numero, new java.sql.Date(new java.text.SimpleDateFormat("yyyy/MM/dd").parse(fecha).getTime()), sede.getId_sede());
        }else{
            if(request.getParameter("id_radicacion")!=null){
                radicacion = model.consultar_Radicacion(Long.parseLong(request.getParameter("id_radicacion")));
                numero = radicacion.getNumero();
                fecha = new java.text.SimpleDateFormat("yyyy/MM/dd").format(radicacion.getFecha());
            }
        }
        if(radicacion!=null){
			java.util.HashMap mapaLP = new java.util.HashMap();
                String auth = request.getParameter("autenticacion");
                if(auth!=null){
                    if(auth.trim().length()>0){
                        if(auth.equals("1")){
                            model.actualizarEstadoRadicacion(radicacion.getId_radicacion(),2);
                            radicacion.setEstado(2);
                            model.getCon().commit();
                            session.setAttribute("token", request.getParameter("token"));
                        }
                    }
                }
                java.util.List listaF = model.consultarFormularios(radicacion.getId_radicacion());
                Formulario formulario = (Formulario)listaF.get(listaF.size()-1);
                String nombre = "";
                Persona radicador = model.consultarPersona(radicacion.getFk_persona());
                nombre = tipdocs.get(radicador.getTipo_documento()+"")+" "+radicador.getDocumento()+" - "+radicador.getApellido_1() + " " + (radicador.getApellido_2() != null ? radicador.getApellido_2() : "") + " " + radicador.getNombre_1();
                Usuario user = model.consultarUsuario(radicacion.getFk_usuario());
                String usuario = user.getNombre();
		String placa = "";
                if(formulario.getPlaca()!=null)
                    placa = formulario.getPlaca();
		mapaLP.put("PLACA",placa);	
                Linea line = null;
                Linea_Remolques lineR = null;
                Linea_maquinaria lineM = null;
                
                Parametro chkClasevehiculo = model.consultarParametro(formulario.getClase_vehiculo(), 1);
                
                
                
                    if(chkClasevehiculo.getNombreCorto().equals("5")){
                        lineR = model.getLineaRNRYSMarca(formulario.getFk_linea(),formulario.getFk_marca());
                    }else if(chkClasevehiculo.getNombreCorto().equals("4")){
                        lineM = model.getLineaMaquinaria(formulario.getFk_linea());
                    }else{
                        line = model.getLinea(formulario.getFk_linea());
                    }
                String linea = "";
                String marca = "";
                if(line!=null){
                    linea = line.getNombre();
                    marca = model.getMarca(line.getFk_marca()).getNombre();
                    mapaLP.put("LINEA",linea);
                    mapaLP.put("MARCA",marca);
                }else  if(lineR!=null){
                    linea = lineR.getNombre();
                    marca = model.getMarcaRNRYS(lineR.getFk_marca()).getNombre();
                    mapaLP.put("LINEA",linea);
                    mapaLP.put("MARCA",marca);
                } else if(lineM!=null){
                    linea = lineM.getDescripcion();
                    marca = model.getMarcaMaquinaria(lineM.getCodigo_marca()).getDescripcion();
                    mapaLP.put("LINEA",linea);
                    mapaLP.put("MARCA",marca);                
                }


		String modelo = formulario.getModelo()+"";
                mapaLP.put("MODELO",modelo);
                String color = "";
		String delim = "";
                java.util.List colores_ant = new java.util.LinkedList();
                java.util.List colores = new java.util.LinkedList();
                java.util.List colores2 = new java.util.LinkedList();
                java.util.List propietarios_ant = new java.util.LinkedList();
                java.util.List propietarios = new java.util.LinkedList();
                java.util.List propietarios2 = new java.util.LinkedList();
                java.util.List datos_especificaciones_ant = new java.util.LinkedList();
                java.util.List datos_especificaciones = new java.util.LinkedList();
                java.util.HashMap datos_especificaciones2 = new java.util.HashMap();
                for(int j=0;j<listaF.size();j++){
                    Formulario for_pro = (Formulario)listaF.get(j);
                    colores_ant = model.consultarRadicacionesColores(for_pro.getId_formulario());
                    if(colores_ant.size()!=0){
                        colores = colores_ant;
                    }
                    propietarios_ant = model.consultarRadicacionesPropietarios(for_pro.getId_formulario());
                    if(propietarios_ant.size()!=0){
                        propietarios = propietarios_ant;
                    }
                    datos_especificaciones_ant = model.consultarRadicacionesEspecificaciones(for_pro.getId_formulario());
                    if(datos_especificaciones_ant.size()!=0){
                        datos_especificaciones = datos_especificaciones_ant;
                    }
                }
		if(colores.size()>0){
                    for(int j = 0; j < colores.size(); j++){
                            Radicacion_Color rc = (Radicacion_Color) colores.get(j);
                            color += delim + model.getColor(rc.getFk_color()).getNombre();
                            delim = ", ";
                    }
                }else{
                    colores2 = model.consultaColor(placa);
                    for(int j = 0; j < colores2.size(); j++){
                            Color rc = (Color) colores2.get(j);
                            color += delim + model.getColor(rc.getId_color()).getNombre();
                            delim = ", ";
                    }
                }    
                if(propietarios.size()==0){
                        propietarios2 = model.consultaPropietarios(placa);
                }
                if(datos_especificaciones.size()==0){
                        datos_especificaciones2 = model.listarEspecificacionesVehiculo(placa);
                }
                mapaLP.put("COLOR", color);
                java.util.List especificaciones = model.listadoParametros(40);
		String motor = formulario.getMotor()!=null?formulario.getMotor():"";
		String reg_motor = formulario.getMotor_reg()==1?"S":"N";
		String chasis = formulario.getChasis()!=null?formulario.getChasis():"";
		String reg_chasis = formulario.getChasis_reg()==1?"S":"N";
		String serie = formulario.getSerie()!=null?formulario.getSerie():"";
		String reg_serie = formulario.getSerie_reg()==1?"S":"N";

                mapaLP.put("MOTOR", motor);
                mapaLP.put("SERIE", serie);
                mapaLP.put("CHASIS", chasis);
                mapaLP.put("REGMOTOR", reg_motor);
                mapaLP.put("REGCHASIS", reg_chasis);
                mapaLP.put("REGSERIE", reg_serie);
	
		String clase = model.consultarParametroName(1, formulario.getClase_vehiculo());
                String carroceria = model.consultarParametroName(2, formulario.getCarroceria());
                String combustible = model.consultarParametroName(75, formulario.getCarroceria());
		String servicio = model.consultarParametroName(3, formulario.getServicio());
                String modalidad = "";
                    if(formulario.getModalidad()!=0)
                        modalidad = model.consultarParametroName(324, formulario.getModalidad());

                mapaLP.put("CLASE", clase);
                mapaLP.put("CARROCERIA", carroceria);
                mapaLP.put("SERVICIO",servicio );
                mapaLP.put("MODALIDAD", modalidad);
                mapaLP.put("COMBUSTIBLE", combustible);

	%>
<body>	
    <form id="form1" name="form1" method="post" action="aprobarTramiteRUNT.jsp" onSubmit="deshabilitar()">
	  <table width="74%" border="0" align="center">
	  		<tr>
				<td colspan="2" align="center"><span class="Estilo18">RESUMEN GENERAL SOLICITUD DE TRAMITES ANTE EL RUNT </span></td>
			</tr>
			<tr>
				<td colspan="2">&nbsp;</td>
			</tr>
                         <%   if(request.getParameter("msg")!=null){ 
						 			if(request.getParameter("msg").equals("Solicitud radicada exitosamente")||request.getParameter("msg").equals("Tramite ha sido aprobado correctamente")||request.getParameter("msg").equals("Radicacion ha sido renovada")){ %>
									  <tr>
											<th colspan="2"><div align="center" class="Estilo14 Estilo15"><strong><%=request.getParameter("msg")%></strong></div></th>
									  </tr>
								<%	 }else{  %>
								 	   <tr>
											<th colspan="2"><div align="center" class="Estilo16"><%=request.getParameter("msg")%></div></th>
									  </tr>
                          <%   		 }
   						      }  %>
			<tr>
				<td colspan="2" valign="top">
					<table width="91%" border="0">
					  <tr>
						<td width="40%" valign="top">
							<fieldset>
							<legend class="Estilo13 style1"><strong>DATOS SOLICITUD </strong></legend>
							<table width="96%" border="0">
                                  <tr>
									<td><span class="Estilo18">NUMERO</span></td>
									<td><input name="radicacion" type="text" id="radicacion" style="width:120px;color:#333333;text-align:center; font-size:11px" value="<%=numero%>" readonly /></td>
									<td><span class="Estilo18">FECHA</span></td>
									<td><input name="fecha" type="text" id="fecha" style="width:150px;color:#333333;text-align:center; font-size:11px" value="<%=fecha%>" readonly="readonly"/></td>
								  </tr>
								  <tr>
									<td><span class="Estilo18">SOLICITANTE</span></td>
									<td colspan="3"><input name="Input8" type="text" id="Input8" style="width:370px;color:#333333;text-align:center; font-size:11px" value="<%=nombre%>" readonly="readonly"/></td>
								  </tr>
								  <tr>
									<td><span class="Estilo18">VEHICULO</span></td>
								    <td><input name="" type="text" id="" style="width:120px;color:#333333; text-align:center; font-size:11px" value="<%=placa%>" readonly/></td>
								<td><span class="Estilo18">USUARIO</span></td>
								<td><input name="Input6" type="text" id="Input6" style="width:150px;color:#333333;text-align:center; font-size:11px" value="<%=usuario%>" readonly="readonly"/></td>
								  </tr>
								  <tr> 
									<td colspan="4" valign="top">
										<fieldset>
										<legend class="style2">DATOS VEHICULO </legend>
										 <table width="94%" border="0">
											  <tr>
												  <td width="15%"><span class="Estilo20 Estilo1 Estilo9 Estilo7"><span class="Estilo18">CLASE</span></span></td>
												  <td width="29%"><input name="" type="text" id="" style="width:150px;color:#333333;text-align:center; font-size:11px" value="<%=clase%>" readonly/></td>
												  <td width="20%"><span class="Estilo18"><strong>SERVICIO</strong></span></td>
												  <td width="36%"><input name="Input42" type="text" id="Input42" style="width:150px;color:#333333;text-align:center; font-size:11px" value="<%=servicio%>" readonly/></td>
											  </tr>
											  <tr>
												  <td><span class="Estilo18"><strong>MARCA</strong></span></td>
												  <td><input name="" type="text" id="" style="width:150px;color:#333333;text-align:center; font-size:11px"  value="<%=marca%>" readonly/></td>
												  <td><span class="Estilo18"><strong>LINEA</strong></span></td>
												  <td><input name="Input4" type="text" id="Input4" style="width:150px;color:#333333;text-align:center; font-size:11px"  value="<%=linea%>" readonly="readonly"/></td>
											  </tr>
											  <tr>
												  <td><span class="Estilo18"><strong>MODELO</strong></span></td>
												  <td><input name="" type="text" id="" style="width:150px;color:#333333;text-align:center; font-size:11px"  value="<%=modelo%>" readonly/></td>
												  <td><span class="Estilo18"><span class="Estilo18"><strong>CARROCERIA</strong></span></span></td>
												  <td><input name="Input7" type="text" id="Input7" style="width:150px;color:#333333;text-align:center; font-size:11px" value="<%=carroceria%>" readonly/></td>
											  </tr>
											 <% if(formulario.getClase_vehiculo()!=24&&formulario.getClase_vehiculo()!=41){  %>
                                                                                          <tr>
												  <td><span class="Estilo18"><strong>COLOR</strong></span></td>
												  <td colspan="3"><input name="Input" type="text" id="Input" style="width:380px;color:#333333;text-align:center; font-size:11px" value="<%=color%>" readonly/></td>
											  </tr>
											  <%}%>
                                                                                          <% if(formulario.getClase_vehiculo()!=24&&formulario.getClase_vehiculo()!=41){  %>
											  <tr>
												  <td><span class="Estilo18"><strong>MOTOR</strong></span></td>
												  <td><input name="" type="text" id="" style="width:150px;color:#333333;text-align:center; font-size:11px" value="<%=motor%>" readonly/></td>
												  <td><input name="Input2" type="text" id="Input2" style="width:30px;color:#333333;text-align:center; font-size:11px" value="<%=reg_motor%>" readonly/></td>
												  <td>&nbsp;</td>
											  </tr>
                                                                                          <% }else{ %>
                                                                                           <tr>
												  <td><span class="Estilo18"><strong>VIN</strong></span></td>
												  <td><input name="" type="text" id="" style="width:150px;color:#333333;text-align:center; font-size:11px" value="<%=formulario.getVin() %>" readonly/></td>
                                                                                                  <td>&nbsp;</td>
												  <td>&nbsp;</td>
											  </tr>
                                                                                          <% } %>
											  <tr>
												  <td><span class="Estilo18"><strong>SERIE</strong></span></td>
												  <td><input name="" type="text" id="" style="width:150px;color:#333333;text-align:center; font-size:11px" value="<%=serie%>" readonly/></td>
												  <td><input name="Input3" type="text" id="Input3" style="width:30px;color:#333333;text-align:center; font-size:11px" value="<%=reg_serie%>" readonly/></td>
												  <td>&nbsp;</td>
											  </tr>
                                                                                          <% if(formulario.getClase_vehiculo()!=24&&formulario.getClase_vehiculo()!=41){  %>
											  <tr>
												  <td><span class="Estilo18"><strong>CHASIS</strong></span></td>
												  <td><input name="Input4" type="text" id="Input4" style="width:150px;color:#333333;text-align:center; font-size:11px" value="<%=chasis%>" readonly/></td>
												  <td><input name="Input4" type="text" id="Input4" style="width:30px;color:#333333;text-align:center; font-size:11px" value="<%=reg_chasis%>" readonly/>    </td>
												  <td>&nbsp;</td>
											  </tr>
											  <% } %>
											  <tr>
												  <td><span class="Estilo18"><strong>MODALIDAD</strong></span></td>
												  <td><input name="Input4" type="text" id="Input4" style="width:150px;color:#333333;text-align:center; font-size:11px" value="<%=modalidad%>" readonly/></td>
												  <td>&nbsp;</td>
												  <td>&nbsp;</td>
											  </tr>
											  <tr>
												<td colspan="4">												</td>
											</tr>
									  	</table>	
										</fieldset>								    </td>
								  </tr>
								  <tr>	
									<td colspan="4" valign="top">
										<fieldset><legend class="style2">PROPIETARIOS</legend>
										<table width="85%" border="0" align="center">
											  <tr style="background-image:url(../html/images/inicio_3.png); border:none" >
												<th width="7%" scope="col" style="border:none"><span class="Estilo20">T</span></th>
												<th width="18%" scope="col" style="border:none"><span class="Estilo20">DOCUMENTO</span></th>
												<th width="57%" scope="col" style="border:none"><span class="Estilo20">NOMBRE DEL PROPIETARIO</span></th>
												<th width="18%" scope="col" style="border:none"><span class="Estilo20">%</span></th>
											  </tr>
										  <% for(int i=0;i<propietarios.size();i++){
												Radicacion_Propietario propietario = (Radicacion_Propietario)propietarios.get(i);
												Persona persona = model.consultarPersona(propietario.getFk_persona()); %>
											  <tr>
													<td align="center">    
													<input name="ttipo<%=i%>" type="text" id="ttipo<%=i%>" value="<%=(persona!=null?tipdocs.get(persona.getTipo_documento()+""):"")%>" readonly="true" style="text-align:center; color:#333333; font-family:Arial, Helvetica, sans-serif; width:30px; font-size:11px"/>											</td>
													<td align="center"><input name="tdocumento<%=i%>" type="text" id="tdocumento<%=i%>" value="<%=(persona!=null?persona.getDocumento():"")%>" style="text-align:center; color:#333333; font-family:Arial, Helvetica, sans-serif; width:90px; font-size:11px" readonly="true"/></td>
													<td align="center">
														<%  if(persona!=null){%>
															<input name="tnombre<%=i%>2" type="text" id="tnombre<%=i%>2" value="<%=persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1()%>" size="60" readonly="true" style="color:#333333; font-family:Arial, Helvetica, sans-serif; width:280px; font-size:11px"/>
												<%		}else{ %>
															<input name="tnombre<%=i%>" type="text" id="tnombre<%=i%>" value="" readonly="true" style="color:#333333;font-family:Arial, Helvetica, sans-serif; width:280px; font-size:11px"/>
												<%		}%>											</td>
													<td align="center"><input name="tporcentaje<%=i%>" type="text" id="tporcentaje<%=i%>" value="<%=propietario.getPorcentaje()%>" style="text-align:center; color:#333333; font-family:Arial, Helvetica, sans-serif; width:40px; font-size:11px" readonly="true"/></td>
											  </tr>
											  <% } 
																					for(int i=0;i<propietarios2.size();i++){
												Propietario propietario = (Propietario)propietarios2.get(i);
												Persona persona = model.consultarPersona(propietario.getFk_persona()); %>
											  <tr>
													<td align="center">    
													<input name="ttipo<%=i%>" type="text" id="ttipo<%=i%>" value="<%=(persona!=null?tipdocs.get(persona.getTipo_documento()+""):"")%>" readonly="true" style="text-align:center; color:#333333; font-family:Arial, Helvetica, sans-serif; width:30px; font-size:11px"/>											</td>
													<td align="center"><input name="tdocumento<%=i%>" type="text" id="tdocumento<%=i%>" value="<%=(persona!=null?persona.getDocumento():"")%>" style="text-align:center; color:#333333; font-family:Arial, Helvetica, sans-serif; width:90px; font-size:11px" readonly="true"/></td>
													<td align="center">
														<%  if(persona!=null){%>
															<input name="tnombre<%=i%>" type="text" id="tnombre<%=i%>" value="<%=persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1()%>" readonly="true" style="color:#333333; font-family:Arial, Helvetica, sans-serif; width:280px; font-size:11px"/>
                                                                                                                 <% }else{ %>
															<input name="tnombre<%=i%>" type="text" id="tnombre<%=i%>" value="" readonly="true" style="color:#333333;font-family:Arial, Helvetica, sans-serif; width:280px; font-size:11px"/>
												<%		}%>											</td>
													<td align="center"><input name="tporcentaje<%=i%>" type="text" id="tporcentaje<%=i%>" value="<%=propietario.getPorcentaje()%>" style="text-align:center; color:#333333; font-family:Arial, Helvetica, sans-serif; width:40px; font-size:11px" readonly="true"/></td>
											  </tr>
											  <% } %>
											  <tr>
												<td colspan="4">&nbsp;</td>
											  </tr>
									    </table>									
										</fieldset>										</td>
								  </tr>
						    </table>	
							</fieldset>					
					    </td>
						<td width="40%" colspan="2" rowspan="2" valign="top" align="center">
							<table width="100%" border="0">
								<tr>
									<td><div align="center"><span class="Estilo21">ESTADO&nbsp;RADICACION</span></div></td>
									<td>
										<input type="text" name="estado" value="<%=model.consultarParametroName(52, radicacion.getEstado())%>" style="width:150px;text-align:center; font-size:12px; color:#333333"/>
									</td>
								</tr>
								<tr>
									 <td valign="top" class="Estilo13" colspan="2">
									 	<fieldset><legend class="style2">TRAMITES SOLICITADOS</legend>
										<table width="100%" border="0">
										  <tr>
											<th width="87%" scope="col" style="background-image:url(../html/images/inicio_3.png); border:none">
											<span class="Estilo20">TRAMITE</span></th>
										  </tr>
									   <% for(int i=0;i<listaF.size();i++){
                                                                                    Formulario form = (Formulario)listaF.get(i);
                                                                                    if(form.getFk_tramite()==19&&listaF.size()==1&&radicacion.getEstado()==1){
                                                                                        radicacion.setEstado(2);
                                                                                        model.actualizarEstadoRadicacion(radicacion.getId_radicacion(),2);
                                                                                        model.getCon().commit();
                                                                                    } %>
										  <tr>
											<td><input name="Input8" type="text" id="Input8" style="width:230px;text-align:center; font-size:11px" value="<%=model.consultarTramite(form.getFk_tramite()).getNombre()%>" readonly="readonly"/>
                                                                                        <% if(radicacion.getEstado()==1||radicacion.getEstado()==2||radicacion.getEstado()==3){ %>
                                                                                               <img src="../html/images/editar.png" width="18" height="18" style="cursor:pointer" onClick="editarF('<%=radicacion.getId_radicacion()%>','<%=form.getFk_tramite()%>')"/>
                                                                                        <% } %>
											</td>
										  </tr>
										  <% } %>
									   </table>	
									   </fieldset>								
									 </td>	
								</tr>
								<tr>
									<td valign="top" colspan="2">
										<fieldset><legend class="style2"><strong>PROCESOS SOLICITUD</strong></legend>
										<table width="100%" border="0" align="center" bordercolor="#333333" style="border:none" cellpadding="0" cellspacing="0">
											<tr>
												 <td align="center">&nbsp;</td>
			  							    </tr>
                                                             <% if(radicacion.getEstado()!=5&&radicacion.getEstado()!=7&&radicacion.getEstado()!=8){ %>
	<% if(radicacion.getEstado()==2){  %>
		<tr>
			<td align="center">
			<input type="submit" name="aprobar" value="Solicitud RUNT" style="width:140px;background-color:#009966; font-weight:bold; color:#FFFFFF"/>			</td>
		</tr>
                <tr>
	       <td align="center">&nbsp;

		   </td>
		</tr>
                <tr>
	       <td align="center">
		   <input type="button" name="renovar" value="Renovar Autenticacion" onClick="autenticarP()" style="width:140px;background-color:#6666CC; font-weight:bold;color:#FFFFFF"/>		   </td>
		</tr>
<%     }
	   if(radicacion.getEstado()==1){  %>
	   <tr>
		  <td align="center"><input type="submit" name="aprobar2" value="Autenticacion" style="width:140px;background-color:#FF6633; font-weight:bold; border-color:#FF6600;color:#FFFFFF"/></td>
	   </tr>
   <%   }  %>
	   <tr>
   <% if(radicacion.getEstado()==3){ %>
	   <tr>
		   <td align="center"><input type="submit" name="aprobar" value="Respuesta RUNT" style="width:140px;background-color:#003399; font-weight:bold; border-color:#003399;color:#FFFFFF"/>		   </td>
		</tr>
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
	       <td align="center">
		   <input type="button" name="renovar" value="Renovar Proceso" onClick="renovarP()" style="width:140px;background-color:#6666CC; font-weight:bold;color:#FFFFFF"/>		   </td>
		</tr>
		<tr>
  <%    }
		if(radicacion.getEstado()==4){ %>
		<tr>
			<td align="center">
			<input type="submit" name="aprobar" value="Aprobacion ITA" style="width:140px;background-color:#003399; font-weight:bold; border-color:#003399;color:#FFFFFF"/>			</td>
		</tr>	
  <%    } 
       if(radicacion.getEstado()==6){  %>
	   <tr>
	       <td align="center">
		   <input type="button" name="renovar" value="Renovar Proceso" onClick="renovarP()" style="width:140px;background-color:#6666CC; font-weight:bold;color:#FFFFFF"/>		   </td>
		</tr>
		<tr>
	       <td align="center">&nbsp;
		   		
		   </td>
		</tr>
		<tr>
	       <td align="center"><span class="style4"><%="El motivo de rechazo fue :"+radicacion.getObservaciones()%></span></td>
		</tr>
<%    }
     if(radicacion.getEstado()==1||radicacion.getEstado()==2){  %>
	   <tr>
	   	   <td>&nbsp;</td>
	   </tr>
	   <tr>
	   	   <td>&nbsp;</td>
	   </tr>
	   <tr>
	       <td align="center">
		   <input type="button" name="rechazar" value="Anular Proceso" onClick="anularP()" style="width:140px;background-color:#CC0000; font-weight:bold; border-color:#FF6666;color:#FFFFFF"/>		   </td>
		</tr>
<%    } %>
                                                              <% }else{ %>

                 <tr>
			<td align="center">
			<input type="button" name="nueva" value="Nueva Solicitud" onClick="nuevoP()" style="width:140px;background-color:#6666CC; font-weight:bold;color:#FFFFFF"/>
                        </td>
		</tr>
                 <tr>
			<td align="center">&nbsp;
                            
                        </td>
		</tr>
                 <tr>
			<td align="center">
			<input type="button" name="consultar" value="Consultar Solicitud" onClick="consultaP()" style="width:140px;background-color:#6666CC; font-weight:bold;color:#FFFFFF"/>
                        </td>
		</tr>
                                                               <%  }%>
															   <tr>
			 <td align="center">&nbsp;</td>
		</tr>
								        </table>								   
										</fieldset>
								  </td>
								</tr>
							</table>						
					    </td>
					  </tr>
					  <tr>
						<td></td>
					  </tr>
				  </table>			
				</td>
			</tr>
	  </table>
	</form>
</body>	
<% }else{ %>
		<jsp:forward page="consultarRadicacion.jsp">
		   <jsp:param name="respuesta" value="No hay resultados para la consulta" />
		</jsp:forward>
<% }

 }catch(Exception exc){
     exc.printStackTrace();
 }  %>
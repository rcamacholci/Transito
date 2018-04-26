<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="net.sf.jasperreports.engine.*" errorPage="" %>
<html>
    <head>
<style type="text/css">
<!--
.Estilo1 {
	color: #0066CC;
	font-weight: bold;
}
.Estilo2 {color: #FFFFFF}
.Estilo3 {
	color: #990000;
	font-weight: bold;
}
.Estilo4 {color: #990000; font-weight: bold; font-size: 11px; }
.Estilo5 {color: #990000; font-weight: bold; font-size: 10px; }
-->
</style>
</head>
<%
	Model model = null;
	try {
            model = (Model) session.getAttribute("model");
            model.getCon().setAutoCommit(false);
            int nvenal = Integer.parseInt(request.getParameter("venal").toString());
            String nradicacion = request.getParameter("radicacion").toString();
            long nsede = Long.parseLong(request.getParameter("sede").toString());
            String fecha = request.getParameter("fecha").toString();
            java.sql.Date nfecha = new java.sql.Date(new java.text.SimpleDateFormat("yyyy/MM/dd").parse(fecha).getTime());
            Venal venal = model.consultar_Venal(nvenal);
            String numero_venal = venal.getNumero();
            java.util.List listar = model.consultarRadicaciones(nradicacion,nfecha , nsede);
            java.sql.Date actual = new java.sql.Date(new java.util.Date().getTime());
            venal.setEstado(2);
            venal.setFecha_utilizacion(actual);
            venal.setFk_radicacion(Long.parseLong(nradicacion));
            model.actualizarVenal(venal);
            if(listar.size()>0){
                Radicacion radicacion = (Radicacion)listar.get(listar.size()-1);
                if(radicacion.getFk_tramite()!=15&&radicacion.getFk_tramite()!=3){
                    Formulario formulario = model.consultarFormulario(radicacion.getId_radicacion());
                    Licencia_Transito licencia = new Licencia_Transito();
                    licencia.setFk_radicacion(formulario.getId_formulario());
                    Vehiculo vehiculo = model.consultarVehiculo(formulario.getPlaca());
                    licencia.setFk_vehiculo(vehiculo.getId_vehiculo());
                    licencia.setNumero(venal.getNumero());
                    licencia.setFecha_expedicion(actual);
                    licencia.setFecha_captura(actual);
                    licencia.setEstado(1);
                    model.adicionarLicenciaTransito(licencia);
                    model.getCon().commit();
					String placa = vehiculo.getPlaca();
					Linea linea = model.consultaLinea(vehiculo.getPlaca());
                    String nlinea = linea!=null?linea.getNombre():"";
                    Marca marca = model.consultaMarca(vehiculo.getPlaca());
					String nmarca = marca!=null?marca.getNombre():"";
                    String clase = model.consultarParametroName(1, (int)vehiculo.getClase_vehiculo());
                    String servicio = model.consultarParametroName(3, (int)vehiculo.getServicio());
					String modelo = vehiculo.getModelo()+"";
                    //String carroceria = model.consultarParametroName(2, (int)vehiculo.get);
                    java.util.List colores = model.consultaColor(vehiculo.getPlaca());
                    String scolor = "";
                    for(int i=0;i<colores.size();i++){
                        Color color = (Color)colores.get(i);
                        scolor += color.getNombre();
                    }
                    java.util.HashMap hash_caracteristicas  = model.listarCaracteristicasVehiculo(vehiculo.getPlaca());
					java.util.HashMap hash_especificaciones = model.listarEspecificacionesVehiculo(vehiculo.getPlaca());
					String carroceria = "";
					if(hash_caracteristicas.get("2")!=null){
						carroceria = model.consultarParametroName(2,Integer.parseInt(hash_caracteristicas.get("2")+""));
					}
					int modalidad = 0;
					if(hash_caracteristicas.get("324")!=null){
						modalidad = Integer.parseInt(hash_caracteristicas.get("324")+"");
					}
                                        String npuertas = "";if(hash_especificaciones.get("8")!=null){  npuertas = hash_especificaciones.get("8")+"";}
					String motor    = "";if(hash_especificaciones.get("19")!=null){ motor      = hash_especificaciones.get("19")+"";}
					String chasis = "";if(hash_especificaciones.get("20")!=null){  chasis = hash_especificaciones.get("20")+"";}
					String serie = "";if(hash_especificaciones.get("21")!=null){  serie = hash_especificaciones.get("21")+"";}
					String rmotor    = "";if(hash_especificaciones.get("22")!=null){ rmotor      = hash_especificaciones.get("22").equals("1")?"X":"";}
					String rchasis = "";if(hash_especificaciones.get("23")!=null){  rchasis = hash_especificaciones.get("23").equals("1")?"X":"";}
					String rserie = "";if(hash_especificaciones.get("24")!=null){  rserie = hash_especificaciones.get("24").equals("1")?"X":"";}
					String cilindraje = "";if(hash_especificaciones.get("11")!=null){  cilindraje = hash_especificaciones.get("11")+"";}
					String capacidad = "";
					if(modalidad==1){  
					  	capacidad = hash_especificaciones.get("2")!=null?hash_especificaciones.get("2")+" TON":"";
					}else{
					  	if(modalidad==2){
						   capacidad = hash_especificaciones.get("1")!=null?hash_especificaciones.get("1")+" PAS":"";
						}else{
					capacidad = hash_especificaciones.get("1")!=null&&hash_especificaciones.get("2")!=null?hash_especificaciones.get("2")+"/"+hash_especificaciones.get("1"):"";
						}		 
					}	
					String peso = "";if(hash_especificaciones.get("13")!=null){  peso = hash_especificaciones.get("13")+"";}
					String voladizo_ant = "";
					String distejes = "";if(hash_especificaciones.get("6")!=null){  distejes = hash_especificaciones.get("6")+"";}
					String voladizo_post = "";if(hash_especificaciones.get("7")!=null){  voladizo_post = hash_especificaciones.get("7")+"";}
					String nejes = "";if(hash_especificaciones.get("9")!=null){  nejes = hash_especificaciones.get("9")+"";}
					String ancho = "";if(hash_especificaciones.get("3")!=null){  ancho = hash_especificaciones.get("3")+"";}
					String alto = "";if(hash_especificaciones.get("4")!=null){  alto = hash_especificaciones.get("4")+"";}
					String largo = "";if(hash_especificaciones.get("5")!=null){  largo = hash_especificaciones.get("5")+"";}
					String avaluo = "";if(hash_especificaciones.get("18")!=null){  avaluo = hash_especificaciones.get("18")+"";}
					String acta =  ""; acta = vehiculo.getTipo_doc_importacion()==1?"X":"";
                                        String declaracion = ""; declaracion = vehiculo.getTipo_doc_importacion()!=1?"X":"";
                                        String numero_import = ""; numero_import = vehiculo.getDocumento_importacion()!=null?vehiculo.getDocumento_importacion():"";
                                        String ciudad = vehiculo.getFk_divipo()!=0?model.consultarMunicipioDivipo(vehiculo.getFk_divipo()).getNombre():"";
                                        String fecha_import = vehiculo.getFecha_importacion()!=null?new java.text.SimpleDateFormat("dd-MM-yyyy").format(vehiculo.getFecha_importacion()):"";
                                        String npropietarios = "";
                                        java.util.List propietarios = model.consultaPropietarios(vehiculo.getPlaca());
                                        String delim = "";
                                        String delim2 = "";
										String delim3 = "";
                        		String cedula = "",nit = "",cextranjeria = "",otro = "";
                                        String identificacion = "";
                                        String expedicion = "";
                                        String direccion = "";
                                        String ciudad_dir = "";
                                        String telefono = "";
                                        for(int i=0;i<propietarios.size();i++){
                                            Propietario propietario = (Propietario)propietarios.get(i);
                                            if(propietario.getFecha_final()==null){
                                                Persona pp = model.consultarPersona(propietario.getFk_persona());
                                                identificacion += delim2 + pp.getDocumento();
                                                expedicion += delim2 + model.consultarMunicipioDivipo(pp.getFk_divipo()).getNombre();
                                                java.util.List direcciones = model.listado_direcciones_persona(pp.getId_persona());
                                                if(direcciones.size()>0){
                                                    direccion += delim2 + ((Direccion)direcciones.get(0)).getDescripcion();
                                                    if(((Direccion)direcciones.get(0)).getFk_divipo()!=0){
                                                        ciudad_dir += delim2 + model.consultarMunicipioDivipo(((Direccion)direcciones.get(0)).getFk_divipo()).getNombre();
                                                    }    
                                                }
                                                if(pp.getCelular()!=null){
                                                    telefono += delim3 + pp.getCelular();
													delim3 = ", ";
                                                }   
                                                npropietarios += delim + pp.getApellido_1()+" "+(pp.getApellido_2()!=null?pp.getApellido_2():"")+","+pp.getNombre_1()+" "+(pp.getNombre_2()!=null?pp.getNombre_2():"");
                                                delim = " - ";
                                                delim2 = ", ";
						if(pp.getTipo_documento()==1){
                                                    cedula = "X";
                                                }else{
                                                    if(pp.getTipo_documento()==2){
                                                        nit = "X";
                                                    }else{
                                                        if(pp.getTipo_documento()==3){
                                                            cextranjeria = "X";
                                                        }else{
                                                            otro = "X";
                                                        }
                                                    }
                                                }
                                                
                                            }    
                                        }
                                        String organismo = model.consultarSede(nsede).getNombre();
                                        String dia_exp = new java.text.SimpleDateFormat("dd").format(licencia.getFecha_expedicion());
                                        String mes_exp = new java.text.SimpleDateFormat("MM").format(licencia.getFecha_expedicion());
					String ano_exp = new java.text.SimpleDateFormat("yy").format(licencia.getFecha_expedicion());
                                        String ntramites = "";
                                        delim = "";
                                        for(int i=0;i<listar.size();i++){
                                            if(listar.size()>1){
                                                ntramites += delim + model.consultarTramite(((Radicacion)listar.get(i)).getFk_tramite()).getAbreviatura();
                                            }else{
                                                ntramites += delim + model.consultarTramite(((Radicacion)listar.get(i)).getFk_tramite()).getNombre();
                                            }        
                                            delim = ", ";
                                        }	
                                        String alerta = "";
                                        Alerta alertas = model.consultarAlerta(vehiculo.getId_vehiculo());
                                        if(alertas!=null){
                                            if(alertas.getFecha_fin()==null){
                                                Persona pp = model.consultarPersona(alertas.getFk_persona());
                                                alerta = "A FAVOR DE: "+pp.getApellido_1()+" "+pp.getApellido_2()+","+pp.getNombre_1()+" "+pp.getNombre_2();
                                            }
                                        }    
                                        String nombre_firma = "";
                                        String cargo_firma = "";
										
										java.util.HashMap parametros_licencia = new java.util.HashMap();
										parametros_licencia.put("PLACA",placa);
										parametros_licencia.put("NMARCA",nmarca);
										parametros_licencia.put("NLINEA",nlinea);
										parametros_licencia.put("CILINDRAJE",cilindraje);
										parametros_licencia.put("MODELO",modelo);
										parametros_licencia.put("CLASE",clase);
										parametros_licencia.put("SCOLOR",scolor);
										parametros_licencia.put("SERVICIO",servicio);
										parametros_licencia.put("CARROCERIA",carroceria);
										parametros_licencia.put("NPUERTAS",npuertas);
										parametros_licencia.put("MOTOR",motor);
										parametros_licencia.put("RMOTOR",rmotor);
										parametros_licencia.put("SERIE",serie);
										parametros_licencia.put("RSERIE",rserie);
										parametros_licencia.put("CHASIS",chasis);
										parametros_licencia.put("RCHASIS",rchasis);
										parametros_licencia.put("CAPACIDAD",capacidad);
										parametros_licencia.put("PESO",peso);
										parametros_licencia.put("VOLADIZO_ANT",voladizo_ant);
										parametros_licencia.put("DISTEJES",distejes);
										parametros_licencia.put("VOLADIZO_POST",voladizo_post);
										parametros_licencia.put("NEJES",nejes);
										parametros_licencia.put("ANCHO",ancho);
										parametros_licencia.put("ALTO",alto);
										parametros_licencia.put("LARGO",largo);
										parametros_licencia.put("AVALUO",avaluo);
										parametros_licencia.put("ACTA",acta);
										parametros_licencia.put("DECLARACION",declaracion);
										parametros_licencia.put("NUMERO_IMPORT",numero_import);
										parametros_licencia.put("CIUDAD",ciudad);
										parametros_licencia.put("FECHA_IMPORT",fecha_import);
										parametros_licencia.put("NPROPIETARIOS",npropietarios);
										parametros_licencia.put("CEDULA",cedula);
										parametros_licencia.put("NIT",nit);
										parametros_licencia.put("CEXTRANJERIA",cextranjeria);
										parametros_licencia.put("OTRO",otro);
										parametros_licencia.put("IDENTIFICACION",identificacion);
										parametros_licencia.put("EXPEDICION",expedicion);
										parametros_licencia.put("DIRECCION",direccion);
										parametros_licencia.put("CIUDAD_DIR",ciudad_dir);
										parametros_licencia.put("TELEFONO",telefono);
										parametros_licencia.put("NTRAMITES",ntramites);
										parametros_licencia.put("ORGANISMO",organismo);
										parametros_licencia.put("ALERTA",alerta);
										parametros_licencia.put("DIA_EXP",dia_exp);
										parametros_licencia.put("MES_EXP",mes_exp);
										parametros_licencia.put("ANO_EXP",ano_exp);
										parametros_licencia.put("NOMBRE_FIRMA",nombre_firma);
										parametros_licencia.put("CARGO_FIRMA",cargo_firma);
                                                                                parametros_licencia.put("NUMERO_VENAL", numero_venal);
										session.setAttribute("parametros_licencia",parametros_licencia);
										
					%>
<body marginheight="0" marginwidth="0">
<form action="" method="post"m name="form">
	<table width="859" border="1">
	   
	   <tr>
		 <td colspan="2" bgcolor="#0066CC"><div class="Estilo22 Estilo2" align="center"><strong>PREVISUALIZACION DE LA LICENCIA DE TRANSITO </strong></div></td>
	   </tr>
	   <tr>
		 <td width="859" height="286" colspan="2" background="../html/images/licencia.png" bgcolor="#FFFFFF" style="background-repeat:no-repeat">
		   <div class="Estilo3" style="width:87px; height:20; position:absolute; left: 328px; top: 41px;"  >
		     <div align="center"><%=numero_venal%></div>
		   </div>
		   <div class="Estilo3" style="width:87px; height:20; position:absolute; left: 13px; top: 78px;"  ><%=placa%></div>
		   <div class="Estilo4" style="width:100; height:16px; position:absolute; left: 111px; top: 80px;"><div align="center"><%=nmarca%></div></div>			 
		   <div class="Estilo5" style="width:138px; height:14px; position:absolute; left: 212px; top: 80px;"><%=nlinea+"/"+cilindraje%></div>
		   <div class="Estilo4" style="width:65px; height:16px; position:absolute; left: 350px; top: 80px;"><%=modelo%></div>
		   <div class="Estilo4" style="width:100; height:16px; position:absolute; left: 13px; top: 108px;"><%=clase%></div>
		   <div class="<%=scolor.length()>23?"Estilo5":"Estilo4"%>" style="width:203px; height:16px; position:absolute; left: 213px; top: 108px;"><%=scolor%></div>
		   <div class="Estilo4" style="width:100; height:16px; position:absolute; left: 11px; top: 136px;"><%=servicio%></div>
		   <div class="Estilo4" style="width:127px; height:16px; position:absolute; left: 148px; top: 136px;"><%=carroceria%></div>
		   <div class="Estilo4" style="width:100; height:16px; position:absolute; left: 290px; top: 136px;">
			   <div align="center"><%=npuertas%></div>
		   </div>   
		   <div class="Estilo4" style="width:160px; height:16px; position:absolute; left: 10px; top: 164px;"><%=motor%></div>
		   <div class="Estilo4" style="width:26px; height:16px; position:absolute; left: 179px; top: 164px;">
		     <div align="center"><%=rmotor%></div>
		   </div>
		   <div class="Estilo4" style="width:163px; height:16px; position:absolute; left: 214px; top: 164px;"><%=serie%></div>
		   <div class="Estilo4" style="width:28px; height:16px; position:absolute; left: 383px; top: 164px;">
		     <div align="center"><%=rserie%></div>
		   </div>
		   <div class="Estilo4" style="width:161px; height:16px; position:absolute; left: 10px; top: 193px;"><%=chasis%></div>
		   <div class="Estilo4" style="width:24px; height:16px; position:absolute; left: 180px; top: 193px;">
		     <div align="center"><%=rchasis%></div>
		   </div>
		   <div class="Estilo4" style="width:82px; height:16px; position:absolute; left: 214px; top: 193px;">
		     <div align="center"><%=capacidad%></div>
		   </div>
		   <div class="Estilo4" style="width:100; height:16px; position:absolute; left: 308px; top: 193px;">
		     <div align="center"><%=peso%></div>
		   </div>
		   <div class="Estilo4" style="width:100; height:16px; position:absolute; left: 8px; top: 220px;">
		     <div align="center"><%=voladizo_ant%></div>
		   </div>
		   <div class="Estilo4" style="width:107px; height:16px; position:absolute; left: 117px; top: 220px;">
		     <div align="center"><%=distejes%></div>
		   </div>
		   <div class="Estilo4" style="width:116px; height:16px; position:absolute; left: 232px; top: 220px;">
		     <div align="center"><%=voladizo_post%></div>
		   </div>
		   <div class="Estilo4" style="width:61px; height:16px; position:absolute; left: 352px; top: 220px;">
		     <div align="center"><%=nejes%></div>
		   </div>
		   <div class="Estilo4" style="width:97px; height:16px; position:absolute; left: 7px; top: 248px;">
		     <div align="center"><%=ancho%></div>
		   </div>
		   <div class="Estilo4" style="width:97px; height:16px; position:absolute; left: 112px; top: 248px;">
		     <div align="center"><%=alto%></div>
		   </div>
		   <div class="Estilo4" style="width:97px; height:16px; position:absolute; left: 214px; top: 248px;">
		     <div align="center"><%=largo%></div>
		   </div>
		   <div class="Estilo4" style="width:104px; height:16px; position:absolute; left: 312px; top: 248px;">
		     <div align="center"><%=avaluo%></div>
		   </div>
		   <div class="Estilo3" style="width:37px; height:16px; position:absolute; left: 10px; top: 276px;">
		     <div align="center"><%=acta%></div>
		   </div>
		   <div class="Estilo3" style="width:21px; height:16px; position:absolute; left: 105px; top: 271px;">
		     <div align="center"><%=declaracion%></div>
		   </div>
		   <div class="Estilo4" style="width:110px; height:16px; position:absolute; left: 130px; top: 276px;">
		     <div align="center"><%=numero_import%></div>
		   </div>
		   <div class="Estilo4" style="width:97px; height:16px; position:absolute; left: 241px; top: 276px;">
		     <div align="center"><%=ciudad%></div>
		   </div>
		   <div class="Estilo4" style="width:72px; height:16px; position:absolute; left: 340px; top: 276px;">
		     <div align="center"><%=fecha_import%></div>
		   </div>
		   <div class="Estilo4" style="width:401px; height:24px; position:absolute; left: 454px; top: 74px;"><%=npropietarios%></div>
		   <div class="Estilo4" style="width:35px; height:10px; position:absolute; left: 653px; top: 95px;">
		     <div align="center"><%=cedula%></div>
		   </div>
		   <div class="Estilo4" style="width:35px; height:10px; position:absolute; left: 708px; top: 94px;">
		     <div align="center"><%=nit%></div>
		   </div>
		   <div class="Estilo4" style="width:35px; height:10px; position:absolute; left: 761px; top: 95px;">
		     <div align="center"><%=cextranjeria%></div>
		   </div>
		   <div class="Estilo4" style="width:35px; height:10px; position:absolute; left: 820px; top: 94px;">
		     <div align="center"><%=otro%></div>
		   </div>
		   <div class="Estilo4" style="width:215px; height:16px; position:absolute; left: 454px; top: 123px;"><%=identificacion%></div>
		   <div class="Estilo4" style="width:183px; height:16px; position:absolute; left: 672px; top: 123px;"><%=expedicion%></div>
		   <div class="Estilo4" style="width:402px; height:16px; position:absolute; left: 454px; top: 151px;"><%=direccion%></div>
		   <div class="Estilo4" style="width:252px; height:16px; position:absolute; left: 454px; top: 181px;"><%=ciudad_dir%></div>
		   <div class="Estilo4" style="width:140px; height:16px; position:absolute; left: 715px; top: 181px;"><%=telefono%></div>
		   <div class="<%=ntramites.length()>23?"Estilo5":"Estilo4"%>" style="width:199px; height:16px; position:absolute; left: 452px; top: 205px;">
		   		<%=ntramites%>
		   </div>
		   <div class="Estilo4" style="width:197px; height:16px; position:absolute; left: 657px; top: 209px;"><%=organismo%></div>
		   <div class="Estilo4" style="width:400px; height:16px; position:absolute; left: 454px; top: 236px;"><%=alerta%></div>
		   <div class="Estilo3" style="width:32px; height:16px; position:absolute; left: 466px; top: 270px;">
		     <div align="center"><%=dia_exp%></div>
		   </div>
		   <div class="Estilo3" style="width:37px; height:16px; position:absolute; left: 521px; top: 270px;">
		     <div align="center"><%=mes_exp%></div>
		   </div>
		   <div class="Estilo3" style="width:33px; height:16px; position:absolute; left: 584px; top: 270px;">
		     <div align="center"><%=ano_exp%></div>
		   </div>
		   <div class="Estilo4" style="width:219px; height:16px; position:absolute; left: 636px; top: 265px;">
		     <div align="center"><%=nombre_firma%></div>
		   </div>
		   <div class="Estilo4" style="width:218px; height:16px; position:absolute; left: 637px; top: 283px;">
		     <div align="center"><%=cargo_firma%></div>
		   </div>
	     </td>
	   </tr>
  </table>
</form>
</body>

	 					
								
					<%
                }else{
                    
                }
            }
        } catch (Exception exc) {
            exc.printStackTrace();
            model.getCon().rollback();
	}	
%>

</html>
<%@page  import = "modelo.Model,modelo.Preasignacion" import = "java.util.*" import = "java.sql.*" %>
<script language="javascript" type="text/javascript">
function certificado(dir,nombre){
    ancho = 789;
    alto = 600;
    barra = 0;
    izquierda = (document.width) ? (document.width-ancho)/2 : 100;
    arriba = (document.height) ? (document.height-alto)/2 : 100;
    opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
    url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
    window.open(url, 'popUp', opciones);
}

function imprimirRunt(id){
        ancho = 789;
        alto = 500;
        barra = 0;
        izquierda = (document.width) ? (document.width-ancho)/2 : 100;
        arriba = (document.height) ? (document.height-alto)/2 : 100;
        opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
        url = "impresion_recibo.jsp?id="+id;
        window.open(url, 'popUp', opciones);
}

</script>
<%
     Model model = null;
     java.util.Date fechaActual =(new java.util.Date());
     String mensajeRunt = "";
     String tipoMensajeRunt = "0";
     boolean proceso = false;
     try{

         model = (Model)session.getAttribute("model");



         if(model!=null){
            if(session.getAttribute("preasignacion")!=null){
                modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                modelo.UsuarioRunt userRunt = model.consultarUsuarioRunt(usuario.getId_usuario());
                com.heinsohn.runt.general.solicitudes.RadicarSolicitudOutDTO radicarSolicitudOut = null;
                webservices.radicacion.RadicacionServicesClient radicacionService = new webservices.radicacion.RadicacionServicesClient();
                radicacionService.setTokenHuellaDigital("");
                radicacionService.setUser(userRunt.getCodigo());
                
                if(session.getAttribute("token2")!=null){
                    radicacionService.setTokenHuellaDigital(session.getAttribute("token2").toString());
                }        

                java.util.List<com.heinsohn.runt.general.solicitudes.LiquidacionInDTO> liquidaciones = new java.util.LinkedList<com.heinsohn.runt.general.solicitudes.LiquidacionInDTO>();
                java.util.List<com.heinsohn.runt.general.tramite.TramiteBasicoDTO> tramites = new java.util.LinkedList<com.heinsohn.runt.general.tramite.TramiteBasicoDTO>();
                java.util.List<com.heinsohn.runt.general.identificaciones.InformacionBiometricaCiudadanoDTO> biometricos = new java.util.LinkedList<com.heinsohn.runt.general.identificaciones.InformacionBiometricaCiudadanoDTO>();
                java.util.List<com.heinsohn.runt.general.solicitudes.RechazoOTDTO> rechazos = new java.util.LinkedList<com.heinsohn.runt.general.solicitudes.RechazoOTDTO>();
                com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO automotor = new com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO();

                String identificadorAT = "8634001";
                String nombreAT = "SABANAGRANDE - ATLANTICO(DPTAL)";
                String autLimitacion = "N";
                String descAutorizacion = "";
                String tipoSolicitud = "SOLICITUD_TRAMITES";
                boolean solTutela = false;
                String valorR = null;
                String numeroLiquidacion = "0001";
                String registroSolicitud = String.valueOf("1");

                com.heinsohn.runt.general.identificaciones.InformacionBiometricaCiudadanoDTO biometrico = new com.heinsohn.runt.general.identificaciones.InformacionBiometricaCiudadanoDTO();
                com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO identificacionP = new com.heinsohn.runt.general.identificaciones.IdentificacionPersonaDTO();
                
                
               
                com.heinsohn.runt.general.solicitudes.LiquidacionInDTO liquidacion = new com.heinsohn.runt.general.solicitudes.LiquidacionInDTO();
                //liquidaciones.add(liquidacion);
                String tipoDocumento = model.consultarParametro((int)Integer.parseInt(request.getParameter("tipodocumento")),5).getNombreCorto();
                String numeroDocumento = request.getParameter("documento");
                
                identificacionP.setTipoDocumento(tipoDocumento);
                identificacionP.setNumeroDocumento(numeroDocumento);
                biometrico.setPersona(identificacionP);
                String trama = "";
                if(request.getParameter("tokenSolicitante")!=null)
                    trama = request.getParameter("tokenSolicitante");
                
                javax.xml.namespace.QName name_t = new javax.xml.namespace.QName("tokenHuellaDigital");
                Class<String> declaredType_t = String.class;
                Class scope_t = javax.xml.bind.JAXBElement.GlobalScope.class;
                javax.xml.bind.JAXBElement<String> jaxb_t = new javax.xml.bind.JAXBElement(name_t, declaredType_t, scope_t,trama);
                biometrico.setTokenHuellaDigital(jaxb_t);
                
                biometricos.add(biometrico);
                

                com.heinsohn.runt.general.tramite.rna.TramitePreasignacionManualDTO tramitePreasignacionManual = new com.heinsohn.runt.general.tramite.rna.TramitePreasignacionManualDTO();
                
                com.heinsohn.runt.general.consultas.DetalleAutomotorDTO detalleAutomotor = (com.heinsohn.runt.general.consultas.DetalleAutomotorDTO)session.getAttribute("preasignacion");
                com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO automotorDatos = detalleAutomotor.getIdentificador();

                if(automotorDatos.getNumeroMotor()!=null) 
                    automotor.setNumeroMotor(automotorDatos.getNumeroMotor()); 

                if(automotorDatos.getNumeroChasis()!=null)
                    automotor.setNumeroChasis(automotorDatos.getNumeroChasis());

                if(automotorDatos.getNumeroSerie()!=null)
                    automotor.setNumeroSerie(automotorDatos.getNumeroSerie());

                if(automotorDatos.getNumeroVIN()!=null)
                    automotor.setNumeroVIN(automotorDatos.getNumeroVIN());

                String servicio = request.getParameter("servicio");
                String clase = request.getParameter("clase");
                String placaAsignada = null;
                if(servicio!=null&&clase!=null){
                    if(!servicio.equals("0")&&!clase.equals("0")){
                        int clase2 = model.consultarClaseTipificacionRUNT(Integer.parseInt(clase));
                        int tipo = 0;
                        if(Integer.parseInt(clase)!=14){
                            if(clase2==10){
                                tipo = 4;
                            }else{
                                switch(Integer.parseInt(servicio)){
                                    case 1:tipo = 1;break;
                                    case 2:tipo = 2;break;
                                    case 4:tipo = 3;break;
                                    default: tipo = 0;break;
                                }
                            }
                        }else{
                            if(Integer.parseInt(servicio)==1)
                                tipo = 5;
                            else
                                if(Integer.parseInt(servicio)==2)
                                    tipo = 6;
                        }
                        if(tipo!=0){
                            modelo.Sede sede = (modelo.Sede)session.getAttribute("sede");
                            placaAsignada = model.getPlacaDisponible(sede.getId_sede(), tipo,usuario.getId_usuario());
                        }else{
                            mensajeRunt = "No hay rangos para el servicio seleccionado";
                        }
                    }else{
                        mensajeRunt = "Seleccione una clase y servicio";
                    }
                }else{
                    mensajeRunt = "Seleccione una clase y servicio";
                }
                if(placaAsignada!=null){
                    System.out.println("placa Asignada1 : "+placaAsignada);
                    javax.xml.namespace.QName name_p = new javax.xml.namespace.QName("placaAsignada");
                    Class<String> declaredType_p = String.class;
                    Class scope_p = javax.xml.bind.JAXBElement.GlobalScope.class;
                    javax.xml.bind.JAXBElement<String> jaxb_p = new javax.xml.bind.JAXBElement(name_p,declaredType_p,scope_p,placaAsignada);
                    tramitePreasignacionManual.setPlacaAsignada(jaxb_p);

                    if(request.getParameter("servicio")!=null) tramitePreasignacionManual.setTipoServicio(request.getParameter("servicio"));

                    if(request.getParameter("registro")!=null) tramitePreasignacionManual.setIdOrigenRegistroVehiculo(request.getParameter("registro"));

                    tramitePreasignacionManual.setEstadoTramite("SOLICITADO");
                    tramitePreasignacionManual.setCodigoTipoTramite("119");
                    tramitePreasignacionManual.setOrdenEjecucion(1);
                    tramitePreasignacionManual.setCondicionIngreso("NUEVO");
                    
       
                    tramites.add(tramitePreasignacionManual);

                 //Model.userHandler = userRunt.getCodigo();
                 //Model.passUserHandler = userRunt.getPassword();

                    radicarSolicitudOut = radicacionService.radicarSolicitud(automotor, identificadorAT, nombreAT, tipoDocumento, numeroDocumento,tipoDocumento, numeroDocumento, autLimitacion, descAutorizacion, tipoSolicitud, numeroLiquidacion, registroSolicitud, solTutela, tramites,liquidaciones,biometricos,rechazos,userRunt.getCodigo(),userRunt.getPassword(),null);
                    if(radicarSolicitudOut!=null){
                        System.out.println("ENTRO EN RADICAR OUT DTO");
                        com.heinsohn.runt.general.identificaciones.StatusDTO status = radicarSolicitudOut.getStatus();
                        if(status!=null){
                            System.out.println("ENTRO EN STATUS");
                            System.out.println("STATUS : "+status.getStatusCode());
                           if(status.getStatusCode().equals("1")){                               
                               System.out.println("Respuesta de servicio Preasignacion OK");
                               com.heinsohn.runt.general.solicitudes.ConsultaResultadoSolicitudOUTDTO consultaResultado = radicacionService.consultaResultadosSolicitudServicio(radicarSolicitudOut.getIdSolicitud(),userRunt.getCodigo(),userRunt.getPassword());
                               if(consultaResultado!=null){
                                   status = consultaResultado.getStatus();
                                   if(status!=null){
                                       if(status.getStatusCode().equals("1")){
                                            javax.xml.bind.JAXBElement<com.heinsohn.runt.general.solicitudes.RegistroSolicitudDTO> jax_registroSolicitud = consultaResultado.getSolicitud();
                                            com.heinsohn.runt.general.solicitudes.RegistroSolicitudDTO solicitud = jax_registroSolicitud.getValue();
                                            if(solicitud.getEstadoSolicitud().equals("APROBADA")){
                                                for(int i=0;i<solicitud.getEspeciesVenalesGeneradas().size();i++){
                                                    com.heinsohn.runt.general.solicitudes.EspecieVenalDTO especieVenal = (com.heinsohn.runt.general.solicitudes.EspecieVenalDTO)solicitud.getEspeciesVenalesGeneradas().get(i);
                                                    String codigoV = "";
                                                    String nombreTipoV = "";
                                                    if(especieVenal.getCodigoTipoEspecieVenal()!=null){
                                                        codigoV = especieVenal.getCodigoTipoEspecieVenal();
                                                        nombreTipoV = model.consultarParametroRUNT("6",codigoV);
                                                    }
                                                    String rangoV = "";
                                                    if(especieVenal.getIdRangoEspecieVenal()!=null)
                                                        rangoV = especieVenal.getIdRangoEspecieVenal();
                                                    String numeroV = "";
                                                    if(especieVenal.getNumeroEspecieVenal()!=null){
                                                        numeroV = especieVenal.getNumeroEspecieVenal();
                                                    }
                                                }
                                                Preasignacion preasignacion = new Preasignacion();
                                                preasignacion.setPlaca(placaAsignada);
                                                java.sql.Date fecha_ven = model.fechaMas(new java.sql.Date(fechaActual.getTime()), 7);
                                                HashMap parametersN = new java.util.HashMap();
                                                parametersN.put("FECHA_VEN",fecha_ven);
                                                parametersN.put("USUARIO", usuario.getNombre());
                                                parametersN.put("PLACA",placaAsignada);
                                                session.setAttribute("reportePreasignacion", parametersN);
                                                String direccionN = "certificados/certificadoPreasignacion.jasper";
                                                String nombreN = "reportePreasignacion";
                                                if(automotorDatos.getNumeroMotor()!=null)
                                                    preasignacion.setMotor(automotorDatos.getNumeroMotor());
                                                if(automotorDatos.getNumeroChasis()!=null)
                                                    preasignacion.setChasis(automotorDatos.getNumeroChasis());
                                                if(automotorDatos.getNumeroSerie()!=null)
                                                    preasignacion.setSerie(automotorDatos.getNumeroSerie());
                                                if(automotorDatos.getNumeroVIN()!=null)
                                                    preasignacion.setVin(automotorDatos.getNumeroVIN());
                                                preasignacion.setServicio(Integer.parseInt(request.getParameter("servicio")));
                                                preasignacion.setOrigenRegistro(Integer.parseInt(request.getParameter("registro")));
                                                preasignacion.setTipo(2);
                                                preasignacion.setEstado(1);
                                                preasignacion.setFk_usuario(usuario.getId_usuario());
                                                modelo.Persona persona = model.consultarPersona(Integer.parseInt(request.getParameter("tipodocumento")), numeroDocumento.trim());
                                                if(persona!=null){
                                                    preasignacion.setFk_persona(persona.getId_persona());
                                                }
                                                preasignacion.setFecha(new java.sql.Timestamp(new java.util.Date().getTime()));
                                                if(detalleAutomotor.getClase()!=null)
                                                    preasignacion.setClase(Integer.parseInt(detalleAutomotor.getClase()));
                                                if(detalleAutomotor.getMarca()!=null)
                                                    preasignacion.setMarca(Integer.parseInt(detalleAutomotor.getMarca()));
                                                if(detalleAutomotor.getLinea()!=null)
                                                    preasignacion.setLinea(Integer.parseInt(detalleAutomotor.getLinea()));
                                                if(detalleAutomotor.getModelo()!=null)
                                                    preasignacion.setModelo(Integer.parseInt(detalleAutomotor.getModelo()));
                                                if(detalleAutomotor.getNumeroActaImportacion()!=null)
                                                    preasignacion.setActaImportacion(detalleAutomotor.getNumeroActaImportacion());
                                                if(detalleAutomotor.getEstado()!=null)
                                                    preasignacion.setEstadoAutomotor(detalleAutomotor.getEstado());
                                                if(solicitud.getIdSolicitud()!=null)
                                                    preasignacion.setNumeroSolicitud(solicitud.getIdSolicitud());
                                                if(solicitud.getEstadoSolicitud()!=null)
                                                    preasignacion.setEstadoSolicitud(solicitud.getEstadoSolicitud());
                                                model.getCon().setAutoCommit(false);
                                                model.adicionarPreasignacion(preasignacion);
                                                modelo.Venal venal = model.consultar_Venal(placaAsignada, 1);
                                                if(venal==null)
                                                    venal = model.consultar_Venal(placaAsignada, 5);
                                                model.actualizarEstadoVenal(venal.getId_venal(), 3,usuario.getId_usuario());
                                                model.getCon().commit();%>
                                                <script language="javascript" type="text/javascript">
                                                    alert("Placa Preasignada : "+'<%=placaAsignada%>');
                                                </script>
                                                <%
                                                if(request.getParameter("runt")!=null){
                                                    if(!request.getParameter("runt").equals("0")){
                                                        try{
                                                            webservices.liquidacion.LiquidacionServicesClient liquidacionService = new webservices.liquidacion.LiquidacionServicesClient();
                                                            liquidacionService.setUser(userRunt.getCodigo());
                                                            liquidacionService.setTokenHuellaDigital("");
                                                             if(session.getAttribute("token2")!=null){
                                                                 liquidacionService.setTokenHuellaDigital(session.getAttribute("token2").toString());
                                                             }
                                                            
                                                            String clasificacion = "";
                                                            int claseV = Integer.parseInt(clase);
                                                            String resultClase = model.consultarParametroName(1,claseV);
                                                            if(resultClase!=null)
                                                                clasificacion = (resultClase.indexOf("MOTO")!=-1)?"MOTO":"AUTOMOVIL";
                                                            java.sql.Date fecha_liquidacion = new java.sql.Date(new java.util.Date().getTime());
                                                            boolean generaPDF = true;
                                                            String id_persona = null;
                                                            String tipoLiquidacion = null;
                                                            String multiLiquidacion = "N";
                                                            double valorOT = 0;
                                                            java.util.List<String[]> tramitesL = new java.util.LinkedList();
                                                            try{
                                                                int claseTipificacion = model.consultarClaseTipificacionRUNT(claseV);
                                                                tramitesL.add(model.consultarTramiteRUNT(1,claseTipificacion));
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                if(request.getParameter("runt").equals("2"))
                                                                    tramitesL.add(model.consultarTramiteRUNT(13,claseTipificacion));
                                                            }catch(Exception texc){
                                                                tramitesL = new java.util.LinkedList();
                                                                texc.printStackTrace();
                                                            }
                                                            for(int i=0;i<tramitesL.size();i++){
                                                                String[] dupla = tramitesL.get(i);
                                                            }
                                                            int cantidadLiquidacion = 1;
                                                            String placaLiquidacion = placaAsignada;
                                                            //Model.userHandler = userRunt.getCodigo();
                                                            //Model.passUserHandler = userRunt.getPassword();

                                                            com.heinsohn.runt.general.solicitudes.LiquidacionOutDTO liquidacionOut = liquidacionService.registrarLiquidacion(placaLiquidacion,identificadorAT, nombreAT, clasificacion, fecha_liquidacion, generaPDF, id_persona, tipoDocumento, numeroDocumento, numeroLiquidacion, tipoLiquidacion, valorOT, tramitesL,cantidadLiquidacion,multiLiquidacion,userRunt.getCodigo(),userRunt.getPassword());
                                                            if(liquidacionOut!=null){
                                                                if(liquidacionOut.getStatus().getStatusCode().equals("1")){
                                                                    modelo.Liquidacion valorMT = new modelo.Liquidacion();
                                                                    try{
                                                                        java.io.File fileL = new java.io.File("C:\\Civitrans\\LiquidacionesRUNT\\"+liquidacionOut.getNumeroLiquidacion()+".pdf");
                                                                        java.io.FileOutputStream fos = new java.io.FileOutputStream(fileL.getAbsolutePath());
                                                                        fos.write(liquidacionOut.getLiquidacionPDF());
                                                                        fos.close();
                                                                    }catch(Exception fxe){
                                                                        fxe.printStackTrace();
                                                                    }
                                                                    model.registrarLiquidacionRUNT(liquidacionOut,0,placaAsignada,persona.getId_persona(),1,1,usuario.getId_usuario());
                                                                    if(request.getParameter("runt").equals("2"))
                                                                        model.registrarLiquidacionRUNT(liquidacionOut,0,placaAsignada,persona.getId_persona(),1,13,usuario.getId_usuario());
                                                                    session.setAttribute("reporteRUNT",liquidacionOut.getLiquidacionPDF());
                                                                    mensajeRunt = "RUNT: "+liquidacionOut.getStatus().getStatusDesc();
                                                                }else{
                                                                    mensajeRunt = "RUNT: "+liquidacionOut.getStatus().getStatusDesc();
                                                                }
                                                            }else{
                                                                mensajeRunt = "RUNT: Intente nuevamente";
                                                            }
                                                        }catch(Exception exr){
                                                            mensajeRunt = "No se pudo generar recibo "+exr.getMessage();
                                                        }
                                                    }
                                                }
                                                model.getCon().commit();
                                                mensajeRunt = "La preasignacion ha sido efectuada correctamente";
                                                tipoMensajeRunt = "1";
    proceso = true; %>
<html>
<head>
    <title>No</title>
<style type="text/css">
<!--
.style1 {
	color: #333333;
	font-weight: bold;
	font-size: 12px;
}
.style3 {
	color: #FFFFFF;
	font-weight: bold;
	font-family: Tahoma;
	font-size: 12px;
}
-->
</style>
</head>
<body>
	<form name="form" method="post" action="preasignacion.jsp?tipoP=0">
<table border="0" width="30%" align="center">
	<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="2" align="center"><span class="style3 style14 style7">RESULTADO PREASIGNACION </span></td>
    </tr>
	<tr>
			<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
			<td class="style1">NUMERO&nbsp;SOLICITUD </td>
			<td><input type="text" name="" value="<%=solicitud.getIdSolicitud()%>" style="font-size:12px; width:150px; color:#009900; font-weight:bold; text-align:center" readonly="true"/></td>
	</tr>
	<tr>
			<td class="style1">PLACA&nbsp;ASIGNADA </td>
			<td><input type="text" name="placa" value="<%=placaAsignada%>" style="font-size:12px; width:150px; color:#009900; font-weight:bold; text-align:center" readonly="true"/></td>
	</tr>
	<tr>
			<td class="style1">ESTADO&nbsp;PROCESO </td>
			<td><input type="text" name="estado" value="<%=solicitud.getEstadoSolicitud()%>" style="font-size:12px; width:150px; color:#333333; text-align:center" readonly="true"/></td>
	</tr>
	<tr>
			<td class="style1">ACTA&nbsp;IMPORTACION </td>
			<td><input type="text" name="acta" value="<%=detalleAutomotor.getNumeroActaImportacion()!=null?detalleAutomotor.getNumeroActaImportacion():""%>" style="font-size:12px; width:150px; color:#333333; text-align:center" readonly="true"/></td>
	</tr>
	<tr>
			<td colspan="2">&nbsp;</td>
	</tr>
	<tr>
            <td colspan="2">
                <table border="0" width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td  align="center"><input type="submit" name="NUEVA" value="NUEVO" style="font-size:11px; color:#333333"/></td>
			<td  align="center"><input type="button" name="NUEVA" value="CERTIFICADO" onclick="certificado('<%=direccionN%>','<%=nombreN%>')" style="font-size:11px; color:#333333"/></td>
                     <% if(request.getParameter("runt")!=null){
                            if(!request.getParameter("runt").equals("0")){ %>
                                <td  align="center"><input type="button" name="NUEVA" value="RECIBO RUNT" onclick="imprimirRunt(2)" style="font-size:11px; color:#333333"/></td>
                         <% }
                        } %>
                    </tr>
                </table>
            </td>

	</tr>
</table>
</form>
</body>
</html>
                                                <%
                                            }else{
                                                String motivoRechazo = "";
                                                for(int i=0;i<solicitud.getRechazosOT().size();i++){
                                                    com.heinsohn.runt.general.solicitudes.RechazoOTDTO rechazo = (com.heinsohn.runt.general.solicitudes.RechazoOTDTO)solicitud.getRechazosOT().get(i);
                                                    motivoRechazo += rechazo.getDescripcionRechazo();
                                                }
                                                mensajeRunt = "Preasignacion rechaza por "+motivoRechazo;
                                            }
                                       }else
                                           mensajeRunt = status.getStatusDesc();
                                   }else
                                       mensajeRunt = "La servicio de consulta a la respuesta de la solicitud no esta disponible";
                                }else
                                    mensajeRunt = "La consulta a la respuesta de la solicitud no produjo resultado, retorno null";
                           }else
                               mensajeRunt = status.getStatusDesc();
                        }else
                            mensajeRunt = "El estado de la solicitud no se encuentra disponible";
                    }else
                        mensajeRunt = "La solicitud de preasignacion no produjo resultados, respuesta nula";
                 }else
                     mensajeRunt = "No se encontro Placa Asignada, verifique si hay Rangos Disponibles";
             }else{
                    mensajeRunt = "No hay placas disponibles para el servicio y clase seleccionado";
             }
         }
         if(!proceso){
                 model.getCon().rollback();   %>
		 <jsp:forward page="preasignacion.jsp?tipoP=0">
			 <jsp:param name="tipoMensajeRunt" value="<%=tipoMensajeRunt%>"></jsp:param>
			 <jsp:param name="mensajeRunt" value="<%=mensajeRunt%>"></jsp:param>
		 </jsp:forward>
	<% } 
     }catch(Exception exc){
         exc.printStackTrace();
         model.getCon().rollback();
         mensajeRunt = "Se ha producido una excepcion :"+exc.getMessage();
     } %>
	 
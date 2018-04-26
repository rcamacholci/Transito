<%@ page  import = "modelo.*" import = "java.util.*" import = "java.sql.*"    %>
<html>
  <head>
      <title>&nbsp;</title>
        <style type="text/css">
        <!--
        .Estilo1 {
                color: #0066CC;
                font-weight: bold;
        }
        .Estilo4 {
                color: #333333;
                font-weight: bold;
                font-size: 14px;
        }
        .Estilo5 {
                color: #333333;
                font-size: 14px;
        }
        .Estilo6 {
                color: #333333;
                font-size: 12px;
        }
        .Estilo7 {font-size: 14px}
        .Estilo8 {
                color: #333333;
                font-size: 14px;
        }
        .Estilo9 {color: #333333}
        .Estilo10 {color: #333333}
        .Estilo11 {font-size: 14}
        .Estilo13 {color: #333333; font-size: 12px; }
.style1 {color: #333333; font-size: 12px; font-weight: bold; }
.style2 {
	color: #FF0000;
	font-weight: bold;
	font-size: 11px;
}
        -->
        </style>
		<script language="javascript" type="text/javascript">
			function renovarSolicitud(rad,fec){
                            document.location.href = "aprobarTramiteRUNT.jsp?radicacion="+rad+"&fecha="+fec+"&ren=1";
			}

                        function verificarSolicitud(rad,fec){
                            if(document.form1.usert.value!=1){
                                document.location.href = "aprobarTramiteRUNT.jsp?radicacion="+rad+"&fecha="+fec;
                            }else{
                                if(confirm("Desea volver a verificar la solicitud?")){
                                    document.location.href = "aprobarTramiteRUNT.jsp?radicacion="+rad+"&fecha="+fec;
                                }else{
                                    document.location.href = "aprobarTramiteRUNT.jsp?radicacion="+rad+"&fecha="+fec+"&ren=1";
                                }
                            }
                        }

                        function aprobarL(){
                            if(document.form.sustrato.value.length==13){
                                document.form.submit();
                            }else{
                                alert("Digite numero de sustrato valido");
                            }
                        }
		</script>
		</script>
</head>
<%
Model model = (Model) session.getAttribute("model");
Usuario usuario = (Usuario) session.getAttribute("usuario");
UsuarioRunt userRunt = model.consultarUsuarioRunt(usuario.getId_usuario());

String sustrato = "";
if(session.getAttribute("solicitud")!=null&&model!=null){
    String numero = request.getParameter("radicacion");
    String fecha = request.getParameter("fecha");
    Sede sede = (Sede) session.getAttribute("sede");
    Radicacion radicacion = null;
    if(numero!=null&&fecha!=null){
       radicacion = model.consultarRadicacion(numero, new java.sql.Date(new java.util.Date(fecha).getTime()), sede.getId_sede());
    }
    if(radicacion!=null){
        com.heinsohn.runt.general.solicitudes.RegistroSolicitudDTO solicitud = (com.heinsohn.runt.general.solicitudes.RegistroSolicitudDTO)session.getAttribute("solicitud");
        String solicitante = "";
        if(solicitud!=null){
            String tipoL = solicitud.getSolicitante().getValue().getTipoDocumento();
            int tipoN = tipoL.equals("C")?1:(tipoL.equals("N")?2:(tipoL.equals("T")?4:(tipoL.equals("E")?3:5)));
            Persona persona = model.consultarPersona(tipoN, solicitud.getSolicitante().getValue().getNumeroDocumento());
            if(persona==null){
                persona = model.consultarPersona(radicacion.getFk_persona());
            }
            String nombre = persona.getNombre_1()+" "+persona.getApellido_1()+ " "+(persona.getApellido_2()!=null?persona.getApellido_2():"");
            solicitante = solicitud.getSolicitante().getValue().getTipoDocumento()+" - "+persona.getDocumento()+" "+nombre;
        }
        String numeroS = "";
        if(solicitud.getIdSolicitud()!=null)
            numeroS = solicitud.getIdSolicitud();
        String fechaS = "";
        if(solicitud.getFechaRegistroSolicitud()!=null)
            fechaS = new java.sql.Date(solicitud.getFechaRegistroSolicitud().getYear()-1900,solicitud.getFechaRegistroSolicitud().getMonth()-1,solicitud.getFechaRegistroSolicitud().getDay())+"";
        String estado = "";
        if(solicitud.getEstadoSolicitud()!=null)
            estado = solicitud.getEstadoSolicitud();
        java.util.HashMap tipdocs = model.crearHashParametrosAbreviatura(5);
    %>
    <body>
            <form id="form1" name="form1" method="post" action="aprobarTramites.jsp">
                <input type="hidden" name="radicacion" value="<%=numero%>" />
                    <input type="hidden" name="fecha_radicacion" value="<%=fecha%>" />
                    <input type="hidden" name="usert" value="<%=usuario.getId_usuario()%>" />
                    <table width="40%" border="0" align="center">
                            <tr>
                                    <td colspan="2" align="center"><span class="Estilo4">RESULTADO SOLICITUD RUNT </span></td>
                            </tr>
                            <tr>
                                    <td colspan="2">&nbsp;</td>
                            </tr>
                            <tr>
                                    <td colspan="2" valign="top" align="center">
											<fieldset>
												<legend class="Estilo13"><strong>DATOS DE LA SOLICITUD</strong></legend>
                                                <table width="100%" border="0" align="center">
                                              <tr>
                                                    <td><span class="Estilo20 Estilo1 Estilo6"><span class="Estilo20 Estilo7 Estilo10">Numero</span></span></td>
                                                    <td><input name="solicitud" type="text" id="solicitud" style="width:120px; color:#009900; font-weight:bold; text-align:center" value="<%=numeroS%>" readonly /></td>
                                                    <td><span class="Estilo20 Estilo1 Estilo8 Estilo10">Fecha</span></td>
                                                    <td><input name="fecha" type="text" id="fecha" style="width:150px;color:#333333;text-align:center" value="<%=fechaS%>" readonly="readonly"/></td>
                                              </tr>
                                              <tr>
                                                    <td><span class="Estilo20 Estilo1 Estilo7 Estilo9 Estilo10">Solicitante</span></td>
                                                    <td colspan="3">
                                                            <input name="Input8" type="text" id="Input8" style="width:370px;color:#333333;text-align:center" value="<%=solicitante%>" readonly="readonly"/>
                                                    </td>
                                              </tr>
                                              <tr>
                                                    <td><span class="Estilo20 Estilo1 Estilo7 Estilo9 Estilo10">Vehiculo</span></td>
                                                    <%  String placa = "";
                                                        long fk_vehiculo = 0;
                                                        if(solicitud.getAutomotor()!=null){
                                                                if(solicitud.getAutomotor().getValue()!=null){
                                                                        placa = solicitud.getAutomotor().getValue().getNumeroPlaca();
                                                                        placa = placa==null?"":placa;
                                                                        if(placa.length()>0){
                                                                            Vehiculo veh = model.consultarVehiculo(placa.toUpperCase());
                                                                            if(veh!=null)
                                                                                fk_vehiculo = veh.getId_vehiculo();
                                                                        }
                                                                }
                                                        } %>
                                                <td><input name="" type="text" id="" style="width:120px;color:#333333; text-align:center" value="<%=placa%>" readonly/></td>
                                                    <td><span class="Estilo20 Estilo1 Estilo7 Estilo9 Estilo10">Estado</span></td>
                                                    <td>
                                                        <% if(solicitud.getEstadoSolicitud().equals("RECHAZADA")){ %>
                                                                <input name="Input6" type="text" id="Input6" style="width:150px;color:#006600;text-align:center;color:#FF0000; font-weight:bold;" value="<%=estado%>" readonly="readonly"/>
                                                        <% }else{%>
                                                              <input name="Input6" type="text" id="Input6" style="width:150px;color:#0066CC; font-weight:bold;text-align:center" value="<%=estado%>" readonly="readonly"/>
                                                        <% } %>
                                                    </td>
                                              </tr>
                                              <tr>
                                                    <td colspan="4" valign="top">
														<fieldset>
															<legend class="style1">TRAMITES SOLICITADOS</legend>
                                                            <table width="100%" border="0" align="center">
                                                       <% for(int i=0;i<solicitud.getTramites().size();i++){
																				com.heinsohn.runt.general.tramite.TramiteBasicoDTO tramite = (com.heinsohn.runt.general.tramite.TramiteBasicoDTO)solicitud.getTramites().get(i);
																				String nameTramite = model.consultarParametroNameRUNT("5", tramite.getCodigoTipoTramite());%>
				  <tr>
																				<td width="7%" align="center">
																				  <input name="" type="text" value="<%=nameTramite%>" readonly="true" style="color:#333333;font-family:Arial;width:470px; font-size:11px"/>
																		</td>
															  </tr>
														   <% }  %>
														   </table>
													   </fieldset>
                                                    </td>
                                              </tr>
                                              <tr>
                                                    <td colspan="4" valign="top">
														<fieldset>
                                                            <table width="100%" border="0" align="center">
                                                       <% for(int i=0;i<solicitud.getEspeciesVenalesGeneradas().size();i++){
                                                                    com.heinsohn.runt.general.solicitudes.EspecieVenalDTO venal = (com.heinsohn.runt.general.solicitudes.EspecieVenalDTO)solicitud.getEspeciesVenalesGeneradas().get(i);
                                                                    String codigoV = "";
                                                                    if(venal.getCodigoTipoEspecieVenal()!=null)
                                                                        codigoV = venal.getCodigoTipoEspecieVenal();
                                                                    String nombreTipoV = "";
                                                                    if(codigoV.length()>0)
                                                                            nombreTipoV = model.consultarParametroRUNT("6",codigoV);
                                                                    String rangoV = "";
                                                                    if(venal.getIdRangoEspecieVenal()!=null)
                                                                            rangoV = venal.getIdRangoEspecieVenal();
                                                                    String numeroV = "";

                                                                    if(venal.getNumeroEspecieVenal()!=null){
                                                                            numeroV = venal.getNumeroEspecieVenal();
                                                                            if(codigoV.equals("4")){
                                                                                Licencia_Transito lic = model.consultarLicenciaTransitoRadicacion(radicacion.getId_radicacion());
                                                                                if(lic==null){
                                                                                    Licencia_Transito licencia_transito = new Licencia_Transito();
                                                                                    licencia_transito.setFk_radicacion(radicacion.getId_radicacion());
                                                                                    licencia_transito.setNumero(numeroV.trim());
                                                                                    licencia_transito.setFecha_expedicion(new java.sql.Date(new java.util.Date().getTime()));
                                                                                    licencia_transito.setEstado(1);
                                                                                    if(fk_vehiculo!=0){
                                                                                        model.actualizarLicenciaTransitoAnteriores(fk_vehiculo,2);
                                                                                        licencia_transito.setFk_vehiculo(fk_vehiculo);
                                                                                    }
                                                                                    licencia_transito.setFk_sede(sede.getId_sede());
                                                                                    licencia_transito.setFk_usuario(usuario.getId_usuario());


                                                                                    model.adicionarLicenciaTransito(licencia_transito);
                                                                                    java.sql.Timestamp fechaR = (new java.sql.Timestamp(new java.util.Date().getTime()));
                                                                                    model.actualizarSustrato(2,numeroV.trim() , fechaR, radicacion.getId_radicacion(), sustrato,usuario.getId_usuario());
                                                                                }
                                                                            }
                                                                    }%>
      <tr>
                  <td width="33%" align="center"><span class="style1">ESPECIES VENALES</span></td>
                                                                    <td width="33%" align="center">
                                                                      <input name="" type="text" value="<%=nombreTipoV%>" readonly="true" style="color:#006600;font-family:Arial;width:150px; font-size:11px; font-weight:bold; text-align:center"/>
            </td>
                                                                    <td width="33%" align="center">
                                                                      <input name="" type="text" value="<%=numeroV%>" readonly="true" style="color:#006600;font-family:Arial;width:150px; font-size:12px; font-weight:bold; text-align:center"/>
                                                                </td>
                                                              </tr>
                                                       <% }  %>
                                                       </table>
													   </fieldset>
                                                    </td>
                                              </tr>

                                              <tr>
                                              <td colspan="4" valign="top">
                                               <table width="100%" border="0" align="center">
                                                    <td colspan="2"  align="center" class="style1">Nº&nbsp;SUSTRATO</td>
                                                    <td width="34%" colspan=""><input name="sustrato" id="sustrato" maxlength="13" type="text" value=""  style="color:#006600;font-family:Arial;width:150px; font-weight:bold; font-size:11px; text-align:center"/></td>
                                                    <td width="33%" colspan="">&nbsp;</td>
                                                    </table>
                                                    </td>
                                              </tr>

                                              <tr>
                                                    <td colspan="4" valign="top">
														<fieldset>
															<legend class="style1">MOTIVOS DE RECHAZO</legend>
                                                            <table width="100%" border="0" align="center">
																<tr>
																<td width="7%" align="center">
                                                       <% String resultadoSol = "";
                                                          for(int i=0;i<solicitud.getRechazosOT().size();i++){
                                                                com.heinsohn.runt.general.solicitudes.RechazoOTDTO rechazo = (com.heinsohn.runt.general.solicitudes.RechazoOTDTO)solicitud.getRechazosOT().get(i);
                                                                resultadoSol += rechazo.getDescripcionRechazo(); %>
                                                              
																 <span class="style2"><%=rechazo.getDescripcionRechazo()%>																 </span><br>
                                                       <% }  %>
														   </td>
                                                              </tr>
                                                       </table>
													   </fieldset>
                                                    </td>
                                              </tr>
											  <tr>
                                                      <%
                                                            if(solicitud.getEstadoSolicitud().equals("APROBADO")||solicitud.getEstadoSolicitud().equals("APROBADA")||solicitud.getEstadoSolicitud().equals("AUTORIZADA")||solicitud.getEstadoSolicitud().equals("ENTREGADA")){
                                                                model.actualizarEstadoRadicacion(radicacion.getId_radicacion(),4);
                                                                java.util.List formularios = model.consultarFormularios(radicacion.getId_radicacion());
                                                                  for(int f=0;f<formularios.size();f++){
                                                                      Formulario formulario = (Formulario)formularios.get(f);
                                                                      Pago pago = model.consultarPago(formulario.getFk_pago());
                                                                        if(pago!=null)
                                                                            model.actualizarEstadoDetalleTiqueteTramite(pago.getFk_tiquete(), formulario.getFk_tramite(), 2);
                                                                  }
                                                             %> <td align="center" colspan="4"><input type="submit" name="aprobar" value="Aprobacion ITA" style="width:120;background-color:#003399; font-weight:bold; border-color:#003399;color:#FFFFFF"/></td> <%
                                                            }else{
                                                                if(solicitud.getEstadoSolicitud().equals("REGISTRADA")){
                                                                    com.heinsohn.runt.general.solicitudes.ConsultaResultadoSolicitudOUTDTO consultaResultado = null;
                                                                    webservices.radicacion.RadicacionServicesClient radicacionService = new webservices.radicacion.RadicacionServicesClient();
                                                                    com.heinsohn.runt.general.solicitudes.AprobarRevisionDocumentalOutDTO AprobacionOutDTO = null ;

                                                                    radicacionService.setTokenHuellaDigital("");
                                                                    radicacionService.setUser(userRunt.getCodigo());
                                                                    String mensajeRespuesta = "";

                                                                     if(session.getAttribute("token2")!=null){
                                                                          radicacionService.setTokenHuellaDigital(session.getAttribute("token2").toString());
                                                                     }
                                                                        Model.userHandler = userRunt.getCodigo();
                                                                        Model.passUserHandler = userRunt.getPassword();

                                                                    AprobacionOutDTO = radicacionService.aprobacionRevisionDocumentalSolicitud(solicitud.getIdSolicitud());
                                                                     if (AprobacionOutDTO != null) {
                                                                            if (AprobacionOutDTO.getStatus() != null) {
                                                                                if (AprobacionOutDTO.getStatus().getStatusCode().equals("1")) {
                                                                                    mensajeRespuesta = AprobacionOutDTO.getStatus().getStatusDesc();
                                                                                     //aqui agregar resultado y estado de las solicitudes runt.
                                                                                   // session.setAttribute("solicitud", registroSolicitud);

                                                                                } else {
                                                                                        mensajeRespuesta = "RUNT: " + AprobacionOutDTO.getStatus().getStatusDesc();
                                                                                    }
                                                                                } else {
                                                                                    mensajeRespuesta = "No fue posible realizar la Aprobacion de la solicitud, intente nuevamente";
                                                                                }
                                                                                } else {
                                                                                mensajeRespuesta = "No fue posible realizar la consulta de la solicitud, intente nuevamente o token vencido";
                                                                                }
                                                                    System.out.println("mensaje respuesta Aprobacion documental : "+mensajeRespuesta);

                                                                    if(solicitud.getEspeciesVenalesGeneradas().size()>0){
                                                                        model.actualizarEstadoRadicacion(radicacion.getId_radicacion(),4);
                                                                        java.util.List formularios = model.consultarFormularios(radicacion.getId_radicacion());
                                                                         for(int f=0;f<formularios.size();f++){
                                                                              Formulario formulario = (Formulario)formularios.get(f);
                                                                              Pago pago = model.consultarPago(formulario.getFk_pago());
                                                                                if(pago!=null)
                                                                                    model.actualizarEstadoDetalleTiqueteTramite(pago.getFk_tiquete(), formulario.getFk_tramite(), 2);
                                                                         }
                                                                        %> <td align="center" colspan="4"><input type="button" name="aprobar" value="Aprobacion ITA" style="width:120;background-color:#003399; font-weight:bold; border-color:#003399;color:#FFFFFF" onClick="aprobarL()"/></td> <%
                                                                    }else{
                                                                        %> <td align="center" colspan="4"><input type="button" name="renovar" value="Verificar Respuesta" style="width:180;background-color:#6666CC; font-weight:bold; border-color:#003399;color:#FFFFFF" onClick="verificarSolicitud('<%=numero%>','<%=fecha%>')"/></td> <%
                                                                    }
                                                                }else{
                                                                    model.actualizarEstadoRadicacion(radicacion.getId_radicacion(),6); %>
                                                                 %> <td align="center" colspan="4"><input type="button" name="nuevo" value="Renovar Solicitud" onClick="renovarSolicitud('<%=numero%>','<%=fecha%>')"/></td>  <%
                                                                }
                                                            }
                                                            model.getCon().commit();%>
                                              </tr>
                                            </table>
										</fieldset>	
                                    </td>
                              </tr>
                    </table>
            </form>
        </body>
<%      }
   }else{  %>
      <p>No existe solicitud</p>
<% }
 %>	
</html>


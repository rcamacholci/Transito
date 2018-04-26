<%@ page  import = "modelo.*" import = "java.util.*" import = "java.sql.*"    %>
<html>
  <head>
      <title>&nbsp;</title>
        <style type="text/css">
        <!--
.style1 {color: #333333; font-size: 12px; font-weight: bold; }
.style2 {
	color: #FF0000;
	font-weight: bold;
	font-size: 11px;
}
.Estilo14 {                color: #0066CC;
                font-weight: bold;
}
.Estilo14 {	color: #333333;
	font-size: 12px;
	font-family: "Segoe Script";
	font-weight: bold;
}
        -->
        </style>
		<script language="javascript" type="text/javascript">
			function verificarSolicitud(rad){
			   document.location.href = "aprobarLicencia.jsp?radicacionl="+rad;
			}
                        function aprobarL(){
                            if(document.form.sustrato.value.length==13){
                                document.form.submit();
                            }else{
                                alert("Digite numero de sustrato valido");
                            }
                        }
		</script>
</head>
<%
Model model = (Model) session.getAttribute("model");
if(session.getAttribute("solicitudl")!=null){
    String numero = request.getParameter("radicacionl");
    Sede sede = (Sede) session.getAttribute("sede");
    Radicacion_Licencia radicacionLicencia = null;
    Formulario_Licencia formularioLicencia = null;
    if(numero!=null){
        radicacionLicencia = model.consultar_RadicacionLicencia(Long.parseLong(request.getParameter("radicacionl")));

    }
    if(radicacionLicencia!=null){
        formularioLicencia = model.consultarFormularioLicencia(radicacionLicencia.getId_radicacion_licencia());
        com.heinsohn.runt.general.solicitudes.RegistroSolicitudDTO solicitud = (com.heinsohn.runt.general.solicitudes.RegistroSolicitudDTO)session.getAttribute("solicitudl");
        String solicitante = "";
        if(solicitud!=null){
            String tipoL = solicitud.getSolicitante().getValue().getTipoDocumento();
            int tipoN = tipoL.equals("C")?1:(tipoL.equals("N")?2:(tipoL.equals("T")?4:(tipoL.equals("E")?3:5)));
            Persona persona = model.consultarPersona(tipoN, solicitud.getSolicitante().getValue().getNumeroDocumento());
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
       <form name="form" method="post" action="aprobarLicencia.jsp" onSubmit="deshabilitar()">
            <input type="hidden" name="radicacionl" value="<%=radicacionLicencia.getId_radicacion_licencia()%>" />
		            <table border="0" width="" cellpadding="0" cellspacing="0" align="center">
                        <tr bgcolor="#F6F3F0">
							<td colspan="2">
  							    <fieldset>
								<div align="center">
								  <legend class="style1">RESUMEN SOLICITUD TRAMITE DE LICENCIAS</legend>
							    </div>
								<table border="0" width="" cellpadding="0" cellspacing="0" align="center">
								  <tr>
										<td colspan="2">&nbsp;</td>
								  </tr>
                                  <tr>
                                    <td width="77"><label class="Estilo14">Solicitud:&nbsp;</label></td>
                                    <td width="257"><input type="text" name="numero" style="font-size:11px;color:#333333;text-align:center" value="<%=numeroS %>" readonly/>                                    </td>
                                  </tr>
                                  <tr>
                                    <td width="77"><label class="Estilo14">Fecha:&nbsp;</label></td>
                                    <td width="257"><input type="text" name="fecha" style="font-size:11px;color:#333333;text-align:center" value="<%= fechaS %>" readonly/></td>
                                  </tr>
                                  <tr>
                                    <td colspan="2">&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td colspan="1"><label class="Estilo14">Solicitante:</label></td>
                                    <td colspan="1"><input type="text" name="sol" style="font-size:11px;color:#333333; width:250px" value="<%= solicitante%>" readonly/>                                    </td>
                                  </tr>
                                  <tr>
                                    <td colspan="2">&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <td colspan="1"><label class="Estilo14">Tramite:</label></td>
                                    <td colspan="1"><% for(int i=0;i<solicitud.getTramites().size();i++){
												com.heinsohn.runt.general.tramite.TramiteBasicoDTO tramite = (com.heinsohn.runt.general.tramite.TramiteBasicoDTO)solicitud.getTramites().get(i);
												String nameTramite = model.consultarParametroNameRUNT("5", tramite.getCodigoTipoTramite());%>
                                        <input name="Input" type="text" value="<%=nameTramite%>" readonly style="color:#333333;width:250px;font-size:11px"/>
                                        <% }  %>                                    </td>
                                  </tr>
                                  <tr>
                                    <td><label class="Estilo14">Estado:&nbsp;</label></td>
                                    <td><% if(!(solicitud.getEstadoSolicitud().equals("APROBADO")||solicitud.getEstadoSolicitud().equals("APROBADA")||solicitud.getEstadoSolicitud().equals("REGISTRADA")||solicitud.getEstadoSolicitud().equals("AUTORIZADA"))){%>
                                        <input name="Input6" type="text" id="Input6" style="font-size:11px;color:#006600;text-align:center;color:#FF0000" value="<%=estado%>" readonly="readonly"/>
                                        <%  
                                        }else{
                                            Pago pago = model.consultarPago(formularioLicencia.getFk_pago());
                                            if(pago!=null)
                                                model.actualizarEstadoDetalleTiqueteTramite(pago.getFk_tiquete(), formularioLicencia.getFk_tramite(), 2); %>
                                        <input name="Input6" type="text" id="Input6" style="font-size:11px;color:#0066CC;text-align:center" value="<%=estado%>" readonly="readonly"/>
                                        <% } %>                                    </td>
                                  </tr>
                                  <tr>
                                    <td colspan="2"><fieldset>
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
                                            String sustrato = "";
                                            if(venal.getNumeroEspecieVenal()!=null){
                                                numeroV = venal.getNumeroEspecieVenal();
                                            if(codigoV.equals("1")){
                                                    Usuario usuario = (Usuario)session.getAttribute("usuario");
                                                    Licencia_Conduccion licenciaConduccion = new Licencia_Conduccion();
                                                    licenciaConduccion.setNumeroLicencia(numeroV.trim());
                                                    licenciaConduccion.setFechaRegistro(new java.sql.Timestamp(new java.util.Date().getTime()));
                                                    licenciaConduccion.setFk_sede(sede.getId_sede());
                                                    sustrato = model.asignarSustrato(2);
                                                    licenciaConduccion.setNumeroSustrato(sustrato);
                                                    licenciaConduccion.setFk_usuario(radicacionLicencia.getFk_usuario());
                                                    licenciaConduccion.setFk_tramite(formularioLicencia.getFk_tramite());
                                                    licenciaConduccion.setCategoria(formularioLicencia.getCategoria());
                                                    licenciaConduccion.setEstadoLicencia(1);
                                                    licenciaConduccion.setFk_persona(radicacionLicencia.getFk_persona());
                                                    licenciaConduccion.setFk_radicacionLicencia(radicacionLicencia.getId_radicacion_licencia());
                                                    model.adicionarLicencia(licenciaConduccion);
                                                    java.sql.Timestamp fecha = (new java.sql.Timestamp(new java.util.Date().getTime()));
                                                    model.actualizarSustrato(2,numeroV.trim(),fecha,radicacionLicencia.getId_radicacion_licencia(), sustrato,usuario.getId_usuario());
                                            } 
                                             
                                         }%>
                                        <tr>
                                          <td width="33%" align="left"><span class="Estilo14"> Licencia&nbsp;Conduccion</span></td>
                                          <td width="33%" align="center"><input name="Input" type="text" value="<%=numeroV%>" readonly="true" style="color:#006600;font-family:Arial;width:180px; font-size:12px; font-weight:bold; text-align:center"/>                                          </td>
                                        </tr>
					<tr>
                                          <td width="33%" align="left"><span class="Estilo14"> Numero&nbsp;Sustrato</span></td>
                                          <td width="33%" align="center">
                                              <input name="sustrato" type="text" value="<%=sustrato%>" style="color:#006600;width:180px;font-size:12px;font-weight:bold;text-align:center"/>                                          </td>
                                        </tr>
                                        <% }  %>
										
                                      </table>
                                    </fieldset></td>
                                  </tr>
                                  <tr>
                                    <td colspan="2"><fieldset>
                                      <legend class="style1">Motivo de Rechazo</legend>
                                      <table width="100%" border="0" align="center">
                                        <tr>
                                          <td width="7%" align="center"><% String resultadoSol = "";
											  for(int i=0;i<solicitud.getRechazosOT().size();i++){
													com.heinsohn.runt.general.solicitudes.RechazoOTDTO rechazo = (com.heinsohn.runt.general.solicitudes.RechazoOTDTO)solicitud.getRechazosOT().get(i);
													resultadoSol += rechazo.getDescripcionRechazo(); %>
                                              <span class="style2"><%=rechazo.getDescripcionRechazo()%> </span><br />
                                              <% }  %>                                          </td>
                                        </tr>
                                      </table>
                                    </fieldset></td>
                                  </tr>
                                  <tr>
                                    <td colspan="2">&nbsp;</td>
                                  </tr>
                                  <tr>
                                    <%
                                                            if(solicitud.getEstadoSolicitud().equals("APROBADO")||solicitud.getEstadoSolicitud().equals("APROBADA")||solicitud.getEstadoSolicitud().equals("AUTORIZADA")){
                                                                model.actualizarEstadoRadicacionLicencia(radicacionLicencia.getId_radicacion_licencia(),4);
                                                             %>
                                    <td align="center" colspan="2"><input type="button" name="aprobar" value="Aprobacion ITA" style="width:100px; font-size:11px;background-color:#6666CC; font-weight:bold; border-color:#003399;color:#FFFFFF" onClick="aprobarL()"/></td>
                                    <%
                                                            }else{
                                                                if(solicitud.getEstadoSolicitud().equals("REGISTRADA")){
                                                                    if(solicitud.getEspeciesVenalesGeneradas().size()>0){
                                                                        model.actualizarEstadoRadicacionLicencia(radicacionLicencia.getId_radicacion_licencia(),4);
                                                                        %>
                                    <td align="center" colspan="2"><input type="button" name="aprobar" value="Aprobacion ITA" style="width:100px; font-size:11px;background-color:#6666CC; font-weight:bold; border-color:#003399;color:#FFFFFF" onClick="aprobarL()"/></td>
                                    <%
                                                                    }else{
                                                                        %>
                                    <td align="center" colspan="2"><input type="button" name="renovar" value="Verificar" style="width:100px; font-size:11px;background-color:#6666CC; font-weight:bold; border-color:#003399;color:#FFFFFF" onClick="verificarSolicitud('<%=radicacionLicencia.getId_radicacion_licencia()%>')"/></td>
                                    <%
                                                                    }
                                                                }else{
                                                                    model.actualizarEstadoRadicacionLicencia(radicacionLicencia.getId_radicacion_licencia(),6);
                                                                 %>
                                    <%
                                                                }
                                                            }
                                                            model.getCon().commit();%>
                                  </tr>
                                </table>
								</fieldset>							</td>
						</tr>		
                </table>
    </form>
</body>
<%      }
   }else{  %>
      <p>No existe solicitud</p>
<% } %>
</body>
</html>

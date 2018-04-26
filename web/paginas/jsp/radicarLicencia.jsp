<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html;charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<%@page import = "modelo.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Licencias de Conduccion</title>
<style>
.Estilo1 {
	color: #333333;
	font-size: 12px;
	font-family: "Segoe Script";
	font-weight: bold;
}
.Estilo4 {
	color: #FE9900;
	font-weight: bold;
	font-size: 12px;
}
.Estilo6 {
	font-family: Arial;
	font-weight: bold;
	font-size: 12px;
	color: #FFFFFF;
}
.Estilo10 {font-family: Arial; font-size: 10px; }
.Estilo11 {color: #333333; font-size: 10px; font-family: Arial; font-weight: bold; }
</style>
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

          function huella(input){
            var valor = input;
           if(valor.length>0){
                var ajax = new nuevoAjax();
                ajax.open("POST", "getHuella.jsp",true);
                ajax.onreadystatechange=function() {
                    if (ajax.readyState==4) {
                        var docxml = ajax.responseXML;
                        var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue;
                        if(result=='1'){
                              alert("Huella Eliminada con Exito");
                        }else{
                             if(result=='2'){
                                alert("No se encontro registro de Huella para Eliminar");
                             }
                        }
                    }
                }
           }
            ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            ajax.send("idPersona="+valor);
         //  }else{
           //   alert("Numero de Comparendo errado debe ser Solo Numeros");
           //}
        }

      function pago(input){
            var valor = input;
           if(valor.length>0){
                var ajax = new nuevoAjax();
                ajax.open("POST", "desbloquearPago.jsp",true);
                ajax.onreadystatechange=function() {
                    if (ajax.readyState==4) {
                        var docxml = ajax.responseXML;
                        var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue;
                        var num_Pago = docxml.getElementsByTagName('numPago')[0].childNodes[0].nodeValue;
                        if(result=='1'){
                              alert("Pago numero : "+num_Pago+" Desbloqueado Correctamente");
                        }else{
                             if(result=='2'){
                                alert("El pago no pudo ser Desbloqueado, Comuniquele al Administrador");
                             }
                        }
                    }
                }
           }
            ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            ajax.send("idRadicacionL="+valor);
         //  }else{
           //   alert("Numero de Comparendo errado debe ser Solo Numeros");
           //}
        }







	function deshabilitar(){
            document.getElementById("enviar").disabled = true;
	}

	function renovarP(){
                if(confirm("Esta seguro de renovar esta radicacion?")){
                    document.form.action = "aprobarLicencia.jsp?ren=1";
                    document.form.submit();
                }
            }
			function anularP(){
                if(confirm("Esta seguro de anular esta radicacion?")){
                    document.form.action = "aprobarLicencia.jsp?del=0";
                    document.form.submit();
                }

           
            }

                 function editarF(opcion){
                    document.location.href = "editarFormularioLicencia.jsp?id_radicacionL="+opcion;
                }





</script>
</head>
<body>
<%
Model model = (Model)session.getAttribute("model");
try{
        Sede sede = (Sede)session.getAttribute("sede");
        Usuario user = (Usuario)session.getAttribute("usuario");
        Radicacion_Licencia radicacionLicencia = null;
        Tramite tramite = null;
        Persona persona = null;
        String nombreD = "";
        String nombreP = "";
        String numero = "";
        String fecha = "";
        int huellaT = 2;
        if(request.getParameter("radicacion")!=null&&request.getParameter("fecha")!=null){
            numero = request.getParameter("radicacion");
            fecha = request.getParameter("fecha");
            fecha = fecha.replaceAll("-", "/");
            radicacionLicencia = model.consultarRadicacionLicencia(numero, new java.sql.Date(new java.text.SimpleDateFormat("yyyy/MM/dd").parse(fecha).getTime()), sede.getId_sede());
        }else{
            if(request.getParameter("radicacionl")!=null){
                radicacionLicencia = model.consultar_RadicacionLicencia(Long.parseLong(request.getParameter("radicacionl")));
            }
        }
        if(radicacionLicencia!=null){
            Formulario_Licencia formularioL = model.consultarFormularioLicencia(radicacionLicencia.getId_radicacion_licencia());
            tramite = model.consultarTramite(formularioL.getFk_tramite());
            persona = model.consultarPersona(radicacionLicencia.getFk_persona());
            nombreD = model.consultarParametro(persona.getTipo_documento(), 5).getNombreCorto();
            nombreP = persona.getNombre_1()+" "+(persona.getNombre_2()!=null?persona.getNombre_2():"")+" "+persona.getApellido_1()+" "+(persona.getApellido_2()!=null?persona.getApellido_2():"");
        }
        if(tramite==null){
            persona = model.consultarPersona(Integer.parseInt(request.getParameter("tipoDocumento")), request.getParameter("numeroDocumento").trim());
            nombreD = model.consultarParametro(Integer.parseInt(request.getParameter("tipoDocumento")), 5).getNombreCorto();
            nombreP = persona.getNombre_1()+" "+(persona.getNombre_2()!=null?persona.getNombre_2():"")+" "+persona.getApellido_1()+" "+(persona.getApellido_2()!=null?persona.getApellido_2():"");

            if(request.getParameter("pago")!=null){
                if(request.getParameter("pago").trim().length()>0){
                    Tiquete tiquete = model.consultarTiqueteByFactura(request.getParameter("pago"));
                    if(tiquete!=null){
                        Pago pago = model.consultarPagoByTiquete(tiquete.getId_tiquete());
                        if(pago!=null){
                            model.getCon().setAutoCommit(false);
                            long id_tramite = Long.parseLong(request.getParameter("tramite"));
                            tramite = model.consultarTramite(id_tramite);
                            Calendar calendar = Calendar.getInstance();
                            int vigencia = calendar.get(Calendar.YEAR);
                            int consecutivo = model.consultarConsecutivo(sede.getId_sede(), 6, vigencia);
                            model.actualizarConsecutivo(sede.getId_sede(), 6, vigencia);
                            radicacionLicencia = new Radicacion_Licencia();
                            radicacionLicencia.setNumero(consecutivo+"");
                            radicacionLicencia.setFk_persona(persona.getId_persona());
                            radicacionLicencia.setFk_sede(sede.getId_sede());
                            radicacionLicencia.setFk_usuario(user.getId_usuario());
                            radicacionLicencia.setEstado(1);
                            radicacionLicencia.setObservaciones("");
                            java.sql.Date fecha_exacta = new java.sql.Date(new java.util.Date().getTime());
                            radicacionLicencia.setFecha(fecha_exacta);
                            long id_rad = model.adicionarDatosRadicacionLicencia(radicacionLicencia);
                            radicacionLicencia.setId_radicacion_licencia(id_rad);

                            
                            if(request.getParameter("huellaT").equals("1")){
                                huellaT = 1;
                            }
                            System.out.println("huella T : "+huellaT);


                            Formulario_Licencia formularioLicencia = new Formulario_Licencia();
                            formularioLicencia.setFk_radicacion(id_rad);
                            formularioLicencia.setFk_tramite(tramite.getId_tramite());
                            formularioLicencia.setFk_persona(persona.getId_persona());
                            if(request.getParameter("categoria")!=null)
                                formularioLicencia.setCategoria(request.getParameter("categoria"));
                            if(request.getParameter("categoriaAn")!=null)
                                formularioLicencia.setCategoria_anterior(request.getParameter("categoriaAn"));
                            if(request.getParameter("runt")!=null)
                                formularioLicencia.setRunt(request.getParameter("runt"));
                          
                        //    if(request.getParameter("simit")!=null)
                          //      formularioLicencia.setSimit(request.getParameter("simit"));
                            if(request.getParameter("simit")!=null){
                                formularioLicencia.setRunt2(request.getParameter("simit"));
                            }else{
                                formularioLicencia.setRunt2(request.getParameter("runt"));

                            }


                            formularioLicencia.setFechaProceso(new java.sql.Timestamp(new java.util.Date().getTime()));
                            if(request.getParameter("licencia")!=null)
                                formularioLicencia.setLicencia_anterior(request.getParameter("licencia").trim());

                            formularioLicencia.setFk_pago(pago.getId_pago());
                            model.adicionarFormularioLicencia(formularioLicencia);

                            if(request.getParameter("tokenSolicitante")!=null&&request.getParameter("fotoSolicitante")!=null){
                              session.setAttribute("tokenSolicitante",request.getParameter("tokenSolicitante"));
                              session.setAttribute("fotoSolicitante",request.getParameter("fotoSolicitante"));
                            }
                            model.getCon().commit();
                        }
                    }
                }
            }
        }
        String estadoR = model.consultarParametroName(52, radicacionLicencia.getEstado()); %>
        <form name="form" method="post" action="aprobarLicencia.jsp" onsubmit="deshabilitar()">
            <input type="hidden" name="radicacionl" value="<%=radicacionLicencia.getId_radicacion_licencia()%>" />
             <input type="hidden" name="huellaT" value="<%=huellaT %>" />
	<fieldset>
								  <legend>
								<div align="center">
            <table border="0" width="" cellpadding="0" cellspacing="0" align="center">
						<tr>
							<td colspan="2">
								
								  <table border="0" width=""  align="center">
                                    <tr style="border:none; background:url(../html/images/inicio_3.jpg)">
                                      <td colspan="11" align="center"><span class="Estilo6">RESUMEN SOLICITUD TRAMITE DE LICENCIA </span></td>
                                    </tr>
									<tr>
									<td colspan="2"col>&nbsp;</td>
									</tr>

                                    <tr>
                                      <td width="87"><label class="Estilo1"><span class="Estilo10">RADICACION</span></label></td>
                                      <td width="250"><input type="text" name="numero" style="font-size:11px;color:#333333; text-align:center" value="<%=radicacionLicencia.getNumero() %>" readonly/></td>
                                    </tr>
                                    <tr>
                                      <td width="87"><label class="Estilo1"><span class="Estilo10">FECHA</span>&nbsp;</label></td>
                                      <td width="250"><input type="text" name="fecha" style="font-size:11px;color:#333333; text-align:center" value="<%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(radicacionLicencia.getFecha()) %>" readonly/></td>
                                    </tr>
                                    <tr>
                                      <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                      <td colspan="1"><label class="Estilo1"><span class="Estilo10">SOLICITANTE</span></label></td>
                                      <td colspan="1"><input type="text" name="sol" style="font-size:11px;color:#333333" value="<%= nombreD+" "+persona.getDocumento()%>" readonly/>                                      </td>
                                    </tr>
                                    <tr>
                                      <td colspan="1"><label class="Estilo11">NOMBRE</label></td>
                                      <td colspan="1"><input type="text" name="nombre" style="font-size:11px;color:#333333;width:250px" value="<%=nombreP%>" readonly/></td>
                                    </tr>
                                    <tr>
                                      <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                      <td colspan="1"><label class="Estilo11">TRAMITE</label></td>
                                      <td colspan="1"><input type="text" name="tramite" style="font-size:11px;color:#333333; width:250px" value="<%= tramite.getNombre() %>" readonly/></td>
                                    </tr>
                                    <tr>
                                      <td><label class="Estilo11">ESTADO</label></td>
                                      <td><input type="text" name="estado" style="font-size:11px;color:#333333" value="<%=estadoR%>" readonly/></td>
                                    </tr>
                                    <tr>
                                      <td><label class="Estilo1"><span class="Estilo10">RESULTADO</span>&nbsp;</label></td>
                                      <td><table border="0" align="center" width="100%">
                                          <tr>
                                            <td><label><span class="Estilo4"><%= (request.getParameter("msg")!=null?request.getParameter("msg"):"") %></span></label>                                            </td>
                                          </tr>
                                      </table></td>
                                    </tr>
									 <tr>
                                      <td><span class="Estilo11">LIMPIAR HUELLA</span></td>
                                        <td><span class="Estilo11">&nbsp; <span class="Estilo1">
                                                    <img src="../html/images/editar.png" width="18" height="18" style="cursor:pointer" onclick="huella('<%=radicacionLicencia.getFk_persona()%>')"/></span></span></td>
                                    </tr>
                                    <tr>
									
                                         <% if(radicacionLicencia.getEstado()==1||radicacionLicencia.getEstado()==2){ %>
                                         <td width="80%" align="left"><label class="Estilo1"><span class="Estilo11">EDITAR</span></label></td>
                                         <td><span class="Estilo11">&nbsp; <span class="Estilo1"><img src="../html/images/editar.png" width="18" height="18" style="cursor:pointer" onclick="editarF('<%=radicacionLicencia.getId_radicacion_licencia()%>')"/></span></span></td>
                                        <% } %>
                                    </tr>  
									 <tr>
									
                                         <% if(radicacionLicencia.getEstado()==1||radicacionLicencia.getEstado()==2||radicacionLicencia.getEstado()==8){ %>
                                         <td width="80%" align="left"><label class="Estilo1"><span class="Estilo11">DESBLOQUEAR&nbsp;PAGO</span></label></td>
                                         <td><span class="Estilo11">&nbsp; <span class="Estilo1"><img src="../html/images/editar.png" width="18" height="18" style="cursor:pointer" onclick="pago('<%=radicacionLicencia.getId_radicacion_licencia()%>')"/></span></span></td>
                                        <% } %>
                                    </tr>
									
                                    <tr>
                                      <td colspan="2">&nbsp;</td>
									  
                                    </tr>
									
                                    <tr>
                                      <% if(radicacionLicencia.getEstado()==1){ %>
                                      <td colspan="2" align="center"><input type="submit" name="enviar" id="enviar" value="Solicitar" onclick="" style="width:100px; font-size:11px;background-color:#FE9900; font-weight:bold; border-color:#FE9900;color:#FFFFFF" /></td>
                                      <% }
                                         if(radicacionLicencia.getEstado()==3){ %>
                                      <td colspan="2" align="center"><input type="submit" name="enviar" id="enviar" value="Verificar" onclick="" style="width:100px; font-size:11px;background-color:#006600; font-weight:bold; border-color:#FE9900;color:#FFFFFF" /></td>
                                      <% }
					 if(radicacionLicencia.getEstado()==5){ %>
                                      <td width="100" colspan="2" align="center"><input type="submit" name="enviar" id="enviar" value="Nueva Solicitud" onclick="" style="width:100px; font-size:11px;background-color:#FF6633; font-weight:bold; border-color:#FE9900;color:#FFFFFF" /></td>
                                      <% }
                                         if(radicacionLicencia.getEstado()==6||radicacionLicencia.getEstado()==3){ %>
                                      <td width="100" colspan="2" align="center"><input type="button" name="enviar" id="enviar" value="Renovar Proceso" onclick="renovarP()" style="width:120px; font-size:11px;background-color:#6666CC; font-weight:bold; border-color:#FE9900;color:#FFFFFF" /></td>
                                      </tr>
                                      <% }
                                        if(radicacionLicencia.getEstado()==1||radicacionLicencia.getEstado()==2||radicacionLicencia.getEstado()==3){  %>
                                           <tr>
                                                   <td colspan="2">&nbsp;</td>
                                           </tr>
                                           <tr>
                                                   <td colspan="2">&nbsp;</td>
                                           </tr>
                                           <tr>
                                           <td  colspan="2"align="center">
                                               <input type="button" name="rechazar" value="Anular Proceso" onClick="anularP()" style="width:100px; font-size:11px;background-color:#CC0000; font-weight:bold; border-color:#FE9900;color:#FFFFFF"/>		   </td>
                                            </tr>
                                    <%    } %>

                                  </table>

                                                        </td>
						</tr>
                </table>
                                    </fieldset>
        </form>
<%
}catch(Exception exc){
    model.getCon().rollback();
    exc.printStackTrace();%>
    <script>
            alert("La licencia no pudo ser generada");
    </script>
    <%
}
%>
</body>
</html>

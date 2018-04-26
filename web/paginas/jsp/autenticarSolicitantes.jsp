<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Documento sin t&iacute;tulo</title>
<style type="text/css">
<!--
.Estilo10 {color: #333333; font-size: 12px; font-weight: bold; }
.Estilo11 {
font-size: 14px;
font-weight: bold;
color: #333333;
}
.Estilo16 {color: #333333; font-size: 12px; }
.style1 {color: #FFFFFF}
.style2 {color: #FFFFFF; font-size: 12px; font-weight: bold; }
.style3 {color: #000000}
-->
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


         function verificarTokenGenerado(tok,id,td,nd){
           var tokn = tok;
          // alert("jejeje");
           var ajax = new nuevoAjax();
                ajax.open("POST", "prevalidarTokenCiudadano.jsp",true);
                ajax.onreadystatechange=function() {
                    if (ajax.readyState==4) {
                        var docxml = ajax.responseXML;
                        var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue;
                        if(result=='1'){
                            alert("Autenticacion del Ciudadano Correcta");
                            document.form.token.value = tok;
                            eval("document.form.estado"+id+".value='AUTENTICADO'");
                            eval("document.form.autenticar"+id+".disabled = true");
                            n = parseInt(document.form.cantidad.value);
                                acceso = true;
                                for(i=0;i<n;i++){
                                    if(eval("document.form.estado"+i+".value")!="AUTENTICADO"&&eval("document.form.estado"+i+".value")!="SIN HUELLA"){
                                        acceso = false;
                                        break;
                                    }
                                }
                                    if(acceso){
                                        document.form.continuar.disabled = false;
                                        document.form.autenticacion.value = "1";
                                    }

                           
                        }else{
                             if(result=='2'){
                                 alert("Autenticacion Incorrecta");
                                 //document.location = "autenticarUsuario.jsp";

                            }else{
                                 alert("No se puedo acceder al Servicio de Prevalidacion de Huellas");
                            }
                        }
                    }
                }
            ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            ajax.send("token="+tokn+"&tipoD="+td+"&numeroD"+nd);
        }


        function AUTENTICAR(td,nd,id,tmp) {
            var rta = "";
            var template_R = tmp;
            var obj = new ActiveXObject("IEActiveRUNT.IEActiveRUNT");
            rta = obj.Autenticar_Ciudadano(template_R);
            //verificarTokenGenerado(rta,id,td,nd);
             alert("Autenticacion del Ciudadano Correcta");
                            document.form.token.value = rta;
                            eval("document.form.estado"+id+".value='AUTENTICADO'");
                            eval("document.form.autenticar"+id+".disabled = true");
                            n = parseInt(document.form.cantidad.value);
                                acceso = true;
                                for(i=0;i<n;i++){
                                    if(eval("document.form.estado"+i+".value")!="AUTENTICADO"&&eval("document.form.estado"+i+".value")!="SIN HUELLA"){
                                        acceso = false;
                                        break;
                                    }
                                }
                                    if(acceso){
                                        document.form.continuar.disabled = false;
                                        document.form.autenticacion.value = "1";
                                    }

        }

        function actualizar(){
            n = parseInt(document.form.cantidad.value);
            acceso = true;
            for(i=0;i<n;i++){
                if(eval("document.form.estado"+i+".value")!="AUTENTICADO"&&eval("document.form.estado"+i+".value")!="SIN HUELLA"){
                    acceso = false;
                    break;
                }
            }
            if(acceso){
                document.form.continuar.disabled = false;
                document.form.autenticacion.value = "1";
            }
        }
</script>
</head>

<body onload="actualizar()">
<%
    try{
        Model model = (Model) session.getAttribute("model");
	Sede sede = (Sede) session.getAttribute("sede");
        Usuario usuario = (Usuario)session.getAttribute("usuario");
        UsuarioRunt userRunt = model.consultarUsuarioRunt2(usuario.getId_usuario());
	String numero = request.getParameter("radicacion");
	String fecha = request.getParameter("fecha");
	Radicacion radicacion = model.consultarRadicacion(numero, new java.sql.Date(new java.util.Date(fecha).getTime()), sede.getId_sede());%>
    <form name="form" method="post" action="formularioTramite.jsp">
        <input type="hidden" name="token" id="token" value="" />
        <input type="hidden" name="autenticacion" id="autenticacion" value="0" />
        <input type="hidden" name="radicacion" id="radicacion" value="<%=numero%>" />
        <input type="hidden" name="fecha" id="fecha" value="<%=fecha%>" />
    <table width="90%" border="0" align="center">
	  <tr style="border:none; background:url(../html/images/inicio_3.png)">
		<td colspan="6"><div align="center" class="style2" id="text">AUTENTICACIONES&nbsp;SOLICITANTES</div></td>
	  </tr>
	  <tr>
		<td colspan="6">&nbsp;</td>
	  </tr>
	   <tr style="border:none; background:url(../html/images/inicio_3.png)">
		<th width="16%" scope="col"><div align="center" class="Estilo10 style1">TIPO&nbsp;SOLICITANTE </div></th>
		<th width="8%" scope="col"><div align="center" class="style2">TIPO&nbsp;DOC</div></th>
		<th width="13%" scope="col"><div align="center" class="style2">NUMERO&nbsp;DOC </div></th>
		<th width="37%" scope="col"><div align="center" class="style2">NOMBRE&nbsp;SOLICITANTE </div></th>
		<th width="14%" scope="col"><div align="center" class="style2">ESTADO</div></th>
		<th width="12%" scope="col"><div align="center" class="style2">ACCION</div></th>
	 </tr>
	 <%
	  modelo.Persona solicitante = model.consultarPersona(radicacion.getFk_persona());
	  String tipoDocumento = model.consultarParametro((int)solicitante.getTipo_documento(),5).getNombreCorto();
	  int tipoD = (int)solicitante.getTipo_documento();
	  String numeroDocumento = solicitante.getDocumento();
	  String nombre = solicitante.getNombre_1()+" "+solicitante.getApellido_1();
	  String tipoSolicitante = "SOLICITANTE";
	  com.heinsohn.runt.general.consultas.ConsultarTokenValidacionBiometricaOutDTO templateOut = null;
	  webservices.common.CommonServicesClient commonService = new webservices.common.CommonServicesClient();
	  commonService.setTokenHuellaDigital("1ng3n13r0J0h4nnGt13rr3zZ4mb4no");
	  commonService.setUser(userRunt.getCodigo());
	  String estado = "SIN ACCESO";
          int n= 0;
          java.util.List formularios = model.consultarFormularios(radicacion.getId_radicacion());
          boolean poseeA = false;
          for(int i=0;i<formularios.size();i++){
              Formulario formulario = (Formulario)formularios.get(i);
              java.util.List apoderados = model.consultarRadicacionesApoderados(formulario.getId_formulario(),solicitante.getId_persona());
              if(apoderados.size()!=0){
                  poseeA = true;
                  break;
              }
          }

             Model.userHandler = userRunt.getCodigo();
              Model.passUserHandler = userRunt.getPassword();

          if(!poseeA){
              String templateU = "";
             
                  templateOut = commonService.consultarParametroValidacionBiometrica(tipoDocumento, numeroDocumento, "2");
                  if(templateOut!=null){
                      if(templateOut.getStatus()!=null){
                          if(templateOut.getStatus().getStatusCode().equals("1")){
                              if(templateOut.getRespuestaAutorizacion().size()>0){
                                   com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO validacionCentralizada = null;
                                   java.util.List<com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO> list = templateOut.getRespuestaAutorizacion();
                                   java.util.Iterator it = list.iterator();
                                    while (it.hasNext()) {
                                        validacionCentralizada = (com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO)it.next();
                                        templateU = validacionCentralizada.getTrama();
                                       // System.out.println("token = "+trama);
                                    }
                                  estado = "SIN AUTENTICAR";
                                
                              }else{                                 
                                  estado = "SIN HUELLA";
                                 
                                  templateU = "";
                              }
                          }else{
                                  estado = "NO INSCRITO";
                          }
                      }
                   }
              %>
	  <tr>
		<td align="center"><span class="Estilo16"><%=tipoSolicitante%></span></td>
		<td align="center"><span class="Estilo16"><%=tipoDocumento%></span></td>
		<td align="center"><span class="Estilo16"><%=numeroDocumento%></span></td>
		<td align="center"><span class="Estilo16"><%=nombre%></span></td>
        <td><input name="estado0" type="text" id="estado0" style="width:120px; color:#333333; text-align:center; font-size:12px; font-weight:bold" value="<%=estado%>" readonly onblur="actualizar()"/></td>
		<td align="center"><input name="autenticar<%=n%>" type="button" id="autenticar<%=n%>" onclick="AUTENTICAR(<%=tipoD%>,<%=numeroDocumento%>,<%=n%>,'<%=templateU%>')" value="Autenticar" style="color:#333333" <%=estado.equals("SIN AUTENTICAR")?"":"disabled"%> /></td>
	  </tr>
      <%  n++;
         }
             for(int i=0;i<formularios.size();i++){
                 Formulario formulario = (Formulario)formularios.get(i);
                 if(formulario.getFk_tramite()==2){
                     java.util.List propietarios = model.consultarRadicacionesPropietarios(formulario.getId_formulario());
                     for(int j=0;j<propietarios.size();j++){
                          Radicacion_Propietario radicacion_propietario = (Radicacion_Propietario)propietarios.get(j);
                          Persona persona = model.consultarPersona(radicacion_propietario.getFk_persona());
                          if(persona.getId_persona()!=solicitante.getId_persona()){//pasar esto de aqui a otro lado...
                              tipoDocumento = model.consultarParametro((int)persona.getTipo_documento(),5).getNombreCorto();
                              tipoD = (int)persona.getTipo_documento();
                              numeroDocumento = persona.getDocumento();
                              nombre = ((int)persona.getTipo_documento())==2?(persona.getNombre_1()):(persona.getNombre_1()+" "+persona.getApellido_1());
                              tipoSolicitante = "PROPIETARIO";
                              estado = "SIN ACCESO";
                              String templateU = "";
                             
                                  templateOut = commonService.consultarParametroValidacionBiometrica(tipoDocumento, numeroDocumento,"2");
                                  if(templateOut!=null){
                                      if(templateOut.getStatus()!=null){
                                          if(templateOut.getStatus().getStatusCode().equals("1")){
                                               if(templateOut.getRespuestaAutorizacion().size()>0){
                                                   com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO validacionCentralizada = null;
                                                   java.util.List<com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO> list = templateOut.getRespuestaAutorizacion();
                                                   java.util.Iterator it = list.iterator();
                                                    while (it.hasNext()) {
                                                        validacionCentralizada = (com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO)it.next();
                                                        templateU = validacionCentralizada.getTrama();
                                                       // System.out.println("token = "+trama);
                                                    }
                                                  estado = "SIN AUTENTICAR";
                                                
                                               }else{
                                                  estado = "SIN HUELLA";
                                                  templateU = "";
                                              }
                                          }else{
                                                  estado = "NO INSCRITO";
                                          }
                                      }
                                   }
                             
                               java.util.List apoderados = model.consultarRadicacionesApoderados(formulario.getId_formulario(),persona.getId_persona());
                               if(apoderados.size()==0){ %>
                                  <tr>
                                        <td align="center"><span class="Estilo16"><%=tipoSolicitante%></span></td>
                                        <td align="center"><span class="Estilo16"><%=tipoDocumento%></span></td>
                                        <td align="center"><span class="Estilo16"><%=numeroDocumento%></span></td>
                                        <td align="center"><span class="Estilo16"><%=nombre%></span></td>
                                        <td><input name="estado<%=n%>" type="text" id="estado<%=n%>" style="width:120px; color:#333333; text-align:center; font-size:12px; font-weight:bold" value="<%=estado%>" readonly onblur="actualizar()"/></td>
                                        <td align="center"><input name="autenticar<%=n%>" type="button" id="autenticar<%=n%>" onclick="AUTENTICAR(<%=tipoD%>,<%=numeroDocumento%>,<%=n%>,'<%=templateU%>')" value="Autenticar" style="color:#333333" <%=estado.equals("SIN AUTENTICAR")?"":"disabled"%> /></td>
                                 </tr>
                <%                n++;
                              }else{
                                     for(int k=0;k<apoderados.size();k++){
                                          Radicacion_Apoderado radicacion_apoderado = (Radicacion_Apoderado)apoderados.get(k);
                                          Persona apoderado = model.consultarPersona(radicacion_apoderado.getFk_apoderado());
                                          if(apoderado.getId_persona()!=solicitante.getId_persona()){
                                              tipoDocumento = model.consultarParametro((int)apoderado.getTipo_documento(),5).getNombreCorto();
                                              tipoD = (int)apoderado.getTipo_documento();
                                              numeroDocumento = apoderado.getDocumento();
                                              nombre = ((int)apoderado.getTipo_documento())==2?(apoderado.getNombre_1()):(apoderado.getNombre_1()+" "+apoderado.getApellido_1());
                                              tipoSolicitante = "APODERADO";
                                              estado = "SIN ACCESO";
                                              templateU = "";
                                             
                                                  templateOut = commonService.consultarParametroValidacionBiometrica(tipoDocumento, numeroDocumento,"2");
                                                  if(templateOut!=null){
                                                      if(templateOut.getStatus()!=null){
                                                          if(templateOut.getStatus().getStatusCode().equals("1")){
                                                             if(templateOut.getRespuestaAutorizacion().size()>0){
                                                               com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO validacionCentralizada = null;
                                                               java.util.List<com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO> list = templateOut.getRespuestaAutorizacion();
                                                               java.util.Iterator it = list.iterator();
                                                                while (it.hasNext()) {
                                                                    validacionCentralizada = (com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO)it.next();
                                                                    templateU = validacionCentralizada.getTrama();
                                                                   // System.out.println("token = "+trama);
                                                                }
                                                               estado = "SIN AUTENTICAR";
                                                                 
                                                              }else{
                                                                estado = "SIN HUELLA";
                                                              
                                                                  templateU = "";
                                                              }
                                                          }else{
                                                                  estado = "NO INSCRITO";
                                                          }
                                                      }
                                                  }
                                            %>
                                              <tr>
                                                    <td align="center"><span class="Estilo16"><%=tipoSolicitante%></span></td>
                                                    <td align="center"><span class="Estilo16"><%=tipoDocumento%></span></td>
                                                    <td align="center"><span class="Estilo16"><%=numeroDocumento%></span></td>
                                                    <td align="center"><span class="Estilo16"><%=nombre%></span></td>
                                                    <td><input name="estado<%=n%>" type="text" id="estado<%=n%>" style="width:120px; color:#333333; text-align:center; font-size:12px; font-weight:bold" value="<%=estado%>" readonly onblur="actualizar()"/></td>
                                                    <td align="center"><input name="autenticar<%=n%>" type="button" id="autenticar<%=n%>" onclick="AUTENTICAR(<%=tipoD%>,<%=numeroDocumento%>,<%=n%>,'<%=templateU%>')" value="Autenticar" style="color:#333333" <%=estado.equals("SIN AUTENTICAR")?"":"disabled"%> /></td>
                                              </tr>
                            <%              n++;
                                       }
                                 }
                            }
                       }
                    }
                }
            }
        %>
            <input type="hidden" name="cantidad" id="cantidad" value="<%=n%>" />
            
            <tr>
                <td align="center" colspan="6">
<button type="submit" name="continuar" id="continuar" disabled="disabled" class="style2"><span class="style3">Continuar</span> <img  src="../html/images/siguiente.png" width="19" height="18"/></button>
	<!--<input type="submit" name="continuar" id="continuar" value="Continuar" disabled/>-->
				</td>
            </tr>
         <%
        }catch(Exception exc){
            exc.printStackTrace();
        }
%>
	</table>
</form>	
</body>
</html>

<%@ page  language="java" import="java.sql.*" import="modelo.*" errorPage="" %>
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
.style4 {color: #000000; font-size: 12px; font-weight: bold; }
-->
</style>
<script language="javascript" type="text/javascript">
	
        
        function AUTENTICAR(td,nd,id,tmp) {
                var rta = "";
                var template_R = tmp;
                var TIPO = "C";
                if(td==3)
                TIPO = "E";
                if(td==4)
                TIPO = "T";
                if(td==5)
                TIPO = "P";
                var ID = nd;
                var obj = new ActiveXObject("IEActiveRUNT.IEActiveRUNT");
                rta = obj.Autenticar_Ciudadano(template_R);
                document.form.token.value = rta;
                
                alert("rta : "+rta);
                if(rta.indexOf("<>"+ID+"<><>"+TIPO+"<><>")==-1){
                    eval("document.form.estado"+id+".value='AUTENTICADO'");
                    eval("document.form.autenticar"+id+".disabled = true");

                                    document.form.continuar.disabled = false;
                         eval("document.form.estado"+id+".value='AUTENTICADO'");
                    eval("document.form.autenticar"+id+".disabled = true");
                                       document.form.autenticacion.value = "1";
                }
 }

</script>
</head>

<body>
<%
    try{
        Model model = (Model) session.getAttribute("model");
        session.setAttribute("waitmodel", model);
        session.removeAttribute("model");
	Sede sede = (Sede) session.getAttribute("sede");
	Usuario usuario = (Usuario)session.getAttribute("usuario"); %>
    <form name="form" method="post" action="inicio.jsp">
        <input type="hidden" name="autenticacion" id="autenticacion" value="0" />
        <input type="hidden" name="token" id="token" value="" />
    <table width="90%" border="0" align="center">
	  <tr style="border:none; background:url(../html/images/inicio_3.png)">
		<td colspan="6"><div align="center" class="style2" id="text">AUTENTICAR&nbsp;USUARIO</div></td>
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
	  modelo.Persona solicitante = model.consultarPersona(usuario.getFk_persona());
	  String tipoDocumento = model.consultarParametro((int)solicitante.getTipo_documento(),5).getNombreCorto();
	  int tipoD = (int)solicitante.getTipo_documento();
	  String numeroDocumento = solicitante.getDocumento();
	  String nombre = solicitante.getNombre_1()+" "+solicitante.getApellido_1();
	  String tipoSolicitante = "USUARIO SISTEMA";
	 // com.heinsohn.runt.general.consultas.ConsultarTemplateHuellaDigitalOutDTO templateOut = null;
          com.heinsohn.runt.general.consultas.ConsultarTokenValidacionBiometricaOutDTO validacionTokenOut = new com.heinsohn.runt.general.consultas.ConsultarTokenValidacionBiometricaOutDTO();
          webservices.common.CommonServicesClient commonService = new webservices.common.CommonServicesClient();
          commonService.setTokenHuellaDigital("324234jjlfkndjlfndsjfknlsjkfnsajkfnlwerw");
          commonService.setUser("1045675127");

         
	  String estado = "SIN ACCESO";
          int n= 0;
          boolean poseeA = false;
          if(!poseeA){
              String trama = "";
              String tipoPersona = "1";
            //  if(tempAnt==null){
                  //templateOut = commonService.consultarTemplateHuellaDigitalUsuario(tipoDocumento, numeroDocumento);
                   validacionTokenOut = commonService.consultarParametroValidacionBiometrica(tipoDocumento, numeroDocumento,tipoPersona);
                  if(validacionTokenOut!=null){// AQUI HAGO EL LLAMADO DE ESA FUNCION Q ESTAN EN LA CLASE
                     // System.out.println("no es nulo");
                      if(validacionTokenOut.getStatus()!=null){
                          if(validacionTokenOut.getStatus().getStatusCode().equals("1")){
                              if(validacionTokenOut.getRespuestaAutorizacion().size()>0){%>
                                   <script>
                                    alert('<%=validacionTokenOut.getStatus().getStatusDesc()%>');
                                </script>
                            <%     com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO validacionCentralizada = null;
                                 java.util.List<com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO> list = validacionTokenOut.getRespuestaAutorizacion();
                                 java.util.Iterator it = list.iterator(); 
                                    while (it.hasNext()) {
                                        validacionCentralizada = (com.heinsohn.runt.general.consultas.ValidacionCentralizadaOutDTO)it.next();
                                        trama = validacionCentralizada.getTrama();
                                       // System.out.println("token = "+trama);
                                    }%>

                                <input type="hidden" name="temp<%=n%>" id="temp<%=n%>" value="<%=trama%>"/> <%
                                  session.setAttribute("template"+solicitante.getId_persona(), trama);
                                  estado = "SIN AUTENTICAR";
                                  try{
                                      Biometrico biometrico = new Biometrico();
                                      biometrico.setId_persona(solicitante.getId_persona());
                                      biometrico.setTemplate(trama.getBytes());
                                      model.actualizarBiometrico(biometrico);
                                      model.getCon().commit();
                                  }catch(Exception excb){excb.printStackTrace();}
                              }else{
                                  %> <input type="hidden" name="temp<%=n%>" id="temp<%=n%>" value=""/> <%
                                  estado = "SIN HUELLA";
                                  session.setAttribute("template"+solicitante.getId_persona(),"");
                                  trama = "";
                              }
                          }else{
                                  estado = "NO INSCRITO";
                          }

                        
                      }
                   }else{%>
                    <script>
                                    alert("Validacion Is null");
                                </script>
                           <%}       %>
             
	  <tr>
		<td align="center"><span class="Estilo16"><%=tipoSolicitante%></span></td>
		<td align="center"><span class="Estilo16"><%=tipoDocumento%></span></td>
		<td align="center"><span class="Estilo16"><%=numeroDocumento%></span></td>
		<td align="center"><span class="Estilo16"><%=nombre%></span></td>
        <td><input name="estado0" type="text" id="estado0" style="width:120px; color:#333333; text-align:center; font-size:12px; font-weight:bold" value="<%=estado%>" readonly/></td>
	<%  System.out.println("trama enviada al metodod :  = "+trama);%>
        <td align="center"><input name="autenticar<%=n%>" type="button" id="autenticar<%=n%>" onclick="AUTENTICAR(<%=tipoD%>,<%=numeroDocumento%>,<%=n%>,'<%=trama%>')" value="Autenticar" style="color:#333333" <%=estado.equals("SIN AUTENTICAR")?"":"disabled"%> /></td>
	  </tr>
      <% } %>
            <input type="hidden" name="cantidad" id="cantidad" value="<%=n%>" />

            <tr>
                <td align="center" colspan="6">
	<button type="submit" name="continuar" id="continuar" disabled="disabled"><span class="style4">Continuar</span><img src="../html/images/siguiente.png" width="19" height="18"/></button>
				<!--<input type="submit" name="continuar" id="continuar" value="Continuar" disabled/>--></td>
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

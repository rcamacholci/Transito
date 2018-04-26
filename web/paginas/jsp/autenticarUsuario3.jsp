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
        
          function verificarTokenGenerado(){
           var rta = "";
            eval("document.form.autenticar.disabled = true");

          // alert("jejeje");
           var ajax = new nuevoAjax();
                ajax.open("POST", "verificarToken.jsp",true);
                ajax.onreadystatechange=function() {
                    if (ajax.readyState==4) {
                        var docxml = ajax.responseXML;
                        var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue;
                        if(result=='1'){
                            var trama = docxml.getElementsByTagName('trama')[0].childNodes[0].nodeValue;
                            var obj = new ActiveXObject("IEActiveRUNT.IEActiveRUNT");
                            rta = obj.Autenticar_Ciudadano(trama);
                            document.form.token.value = rta;
                            alert("Autenticacion  Correcta");
                            eval("document.form.estado.value='AUTENTICADO'");
                            eval("document.form.autenticar.disabled = true");
                            document.form.continuar.disabled = false;
                            eval("document.form.estado.value='AUTENTICADO'");
                            eval("document.form.autenticar.disabled = true");
                            document.form.autenticacion.value = "1";

                           // verificarEstadoTok(rta);
                          
                        }else{
                             if(result=='2'){ 
                                 alert("Token No Pudo ser Generado...");
                                 document.location = "autenticarUsuario.jsp";

                            }
                        }
                    }
                }
            ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            ajax.send("Validacion=1");
        }


        function AUTENTICAR(tmp) {
            var rta = "";
            var template_R = tmp;
            var obj = new ActiveXObject("IEActiveRUNT.IEActiveRUNT");
            rta = obj.Autenticar_Ciudadano(template_R);
            document.form.token.value = rta;
            // alert("rta : "+rta);
            verificarTokenGenerado(rta);
       }

        function verificarEstadoTok(tok){
        var  token = tok;
         var ajax = new nuevoAjax();
                ajax.open("POST", "verificarEstadoToken.jsp",true);
                ajax.onreadystatechange=function() {
                    if (ajax.readyState==4) {
                        var docxml = ajax.responseXML;
                        var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue;
                        if(result=='1'){
                            alert("Autenticacion  Correcta");
                            eval("document.form.estado.value='AUTENTICADO'");
                            eval("document.form.autenticar.disabled = true");
                            document.form.continuar.disabled = false;
                            eval("document.form.estado.value='AUTENTICADO'");
                            eval("document.form.autenticar.disabled = true");
                            document.form.autenticacion.value = "1";
                        }else{
                             if(result=='2'){
                                 alert("Token No válido, Por Favor vuelva Autenticarse");
                                 document.location = "autenticarUsuario.jsp";

                            }
                        }
                    }
                }
            ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            ajax.send("token="+token);
        }



 function editarPassRunt(){
                    var ancho = 650;
                    var alto = 200;
                    var izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
                    var arriba = (screen.height) ? (screen.height-alto)/2 : 100;
                    var opciones = 'toolbar=no,location=no,directories=no,status=no,menubar=no,scrollbars=no,resizable=no,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
                    var url = "editarpasswordRunt.jsp";
                    var ventana = window.open(url, 'popUp', opciones);
                }

</script>
</head>

<body>
<%
    try{
        Model model = (Model) session.getAttribute("model");
        session.setAttribute("waitmodel", model);
      //  session.removeAttribute("model");
	Sede sede = (Sede) session.getAttribute("sede");
	Usuario usuario = (Usuario)session.getAttribute("usuario");
        UsuarioRunt userRunt = model.consultarUsuarioRunt2(usuario.getId_usuario());
        %>
    <form name="form" method="post" action="inicio.jsp">
        <input type="hidden" name="autenticacion" id="autenticacion" value="0" />
        <input type="hidden" name="token" id="token" value="" />
    <table width="90%" border="0" align="center">
	  <tr style="border:none; background:url(../html/images/inicio_3.png)">
		<td colspan="7"><div align="center" class="style2" id="text">AUTENTICAR&nbsp;USUARIO</div></td>
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
                <th width="12%" scope="col"><div align="center" class="style2">ACCION RUNT</div></th>
	 </tr>
	 <%
	  modelo.Persona solicitante = model.consultarPersona(usuario.getFk_persona());
	  String tipoDocumento = model.consultarParametro((int)solicitante.getTipo_documento(),5).getNombreCorto();
	 
	  String numeroDocumento = solicitante.getDocumento();
	  String nombre = solicitante.getNombre_1()+" "+solicitante.getApellido_1();
	  String tipoSolicitante = "USUARIO SISTEMA";
	  com.heinsohn.runt.general.consultas.ConsultarTokenValidacionBiometricaOutDTO validacionTokenOut = new com.heinsohn.runt.general.consultas.ConsultarTokenValidacionBiometricaOutDTO();
          webservices.common.CommonServicesClient commonService = new webservices.common.CommonServicesClient();
          commonService.setTokenHuellaDigital("1ng3n13r0J0h4nnGut13rr3zZ4mbr4n0");
          commonService.setUser(userRunt.getCodigo());
	  String estado = "SIN AUTENTICAR";
          int n= 0;
          boolean poseeA = false;
          if(!poseeA){
             ;%>

             
	  <tr>
		<td align="center"><span class="Estilo16"><%=tipoSolicitante%></span></td>
		<td align="center"><span class="Estilo16"><%=tipoDocumento%></span></td>
		<td align="center"><span class="Estilo16"><%=numeroDocumento%></span></td>
		<td align="center"><span class="Estilo16"><%=nombre%></span></td>
        <td><input name="estado" type="text" id="estado" style="width:120px; color:#333333; text-align:center; font-size:12px; font-weight:bold" value="<%=estado%>" readonly/></td>
	
        <td align="center"><input name="autenticar" type="button" id="autenticar" onclick="verificarTokenGenerado()" value="Autenticar Funcionario" style="color:#333333" <%=estado.equals("SIN AUTENTICAR")?"":"disabled"%> /></td>
        <td><input type="button" name="runt" id="runt" onclick="editarPassRunt()" value="Actualizar Contraseña"></td>
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

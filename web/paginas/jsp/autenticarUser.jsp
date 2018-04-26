<%--
    Document   : autenticarUsuarioRunt
    Created on : 17/04/2013, 04:43:38 PM
    Author     : Sistemas
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">


<%

if(request.getParameter("id")!=null){

}
Model model = (Model)session.getAttribute("model");
Usuario usuario = (Usuario)session.getAttribute("usuario");

Persona solicitante = model.consultarPersona(usuario.getFk_persona());
String nombreU = solicitante.getNombre_1()+" "+solicitante.getApellido_1()+" "+(solicitante.getApellido_2()!=null?solicitante.getApellido_2():"");

UsuarioRunt userRunt = model.consultarUsuarioRunt2(usuario.getId_usuario());

if(userRunt!=null){
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
        <script type="text/javascript" src="../html/scripts/autenticarUsuario.js"></script>

        <script language="javascript" type="text/javascript">

          function verificarTokenGenerado(){
           var rta = "";
            eval("document.form.autenticar.disabled = true");

          //alert("jejeje");
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
                            //verificarEstadoTok(rta);
                            alert("Autenticacion  Correcta");
                            eval("document.form.estado.value='AUTENTICADO'");
                            eval("document.form.autenticar.disabled = true");
                            document.form.continuar.disabled = false;
                            eval("document.form.estado.value='AUTENTICADO'");
                            eval("document.form.autenticar.disabled = true");
                            document.form.autenticacion.value = "1";

                        }else{
                             if(result=='2'){
                                 alert("Token No Pudo ser Generado...");
                                 document.location = "autenticarUser.jsp";

                            }
                        }
                    }
                }
            ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            ajax.send("Validacion=1");
        }

function ActivarToken(){
           document.form.action="autenticarUser.jsp"
           document.form.submit();
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
                                 document.location = "autenticarUser.jsp";

                            }
                        }
                    }
                }
            ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            ajax.send("token="+token);
        }


        </script>

        <title>Autenticar Usuario Runt</title>
    </head>
    <body>

        <form name="form" method="post" action="" >

    <fieldset>
        <div>
			<table>
            <tr>
            	<th><%=nombreU %></th>
            </tr>
            </table>
        	<fieldset><center>
        	  <img src="../html/images/huella.jpg" width="139" height="143">
        	</center></fieldset>
      </div>
        <div>
            <%
	  Persona solicitante2 = model.consultarPersona(usuario.getFk_persona());
	  String tipoDocumento = model.consultarParametro((int)solicitante2.getTipo_documento(),5).getNombreCorto();

	  String numeroDocumento = solicitante2.getDocumento();
	  String nombre = solicitante2.getNombre_1()+" "+solicitante2.getApellido_1();
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
         <td><input name="estado" type="text" id="estado" style="width:120px; color:#333333; text-align:center; font-size:12px; font-weight:bold" value="<%=estado%>" readonly/></td>
        <td align="center"><input name="autenticar" type="button" id="autenticar" onclick="verificarTokenGenerado()" value="Autenticar" style="color:#333333" <%=estado.equals("SIN AUTENTICAR")?"":"disabled"%> /></td>
        <input name="continuar" type="button" id="continuar" value="Continuar" disabled onclick="ActivarToken()"/>
        </div>
      </fieldset>

        <input type="hidden" name="token" value="" >
        <input type="hidden" id="documento" name="documento" value="<%=userRunt.getCodigo()%>" >
        <input type="hidden" id="password" name="password" value="<%=userRunt.getPassword()%>">
<% } %>
</form>
    </body>
</html>
<%
String fecha ="";
      String token = "";
        if(request.getParameter("token")!=null&&!request.getParameter("token").isEmpty()){
         token = request.getParameter("token");
         session.setAttribute("token2", token);
         %><script>
    window.close();
    </script><%
        }
%>
<%}else{
%><script>alert("Usted no posee usuario RUNT")
    window.close();
    </script>
<%}%>


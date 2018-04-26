
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                     Model modelo= (Model)session.getAttribute("model");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Adicionar Usuario</title>
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


	function validarPersona(){
			valor=document.form.documento.value;
			if(valor.length>0){
				valor2=document.form.tipo.options[document.form.tipo.selectedIndex].value;
				ajax=nuevoAjax();
				ajax.open("POST", "getPersona.jsp",true);
				ajax.onreadystatechange=function() {
					if (ajax.readyState==4) {
						if(ajax.responseText.indexOf("nueva")==-1){
							document.form.nombre.value = ajax.responseText;
						}else{
							viewPersona(valor2,valor);
						}
					}
				}
				ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
				ajax.send("documento="+valor+"&tipo="+valor2);
			}
		}

      function viewPersona(tipo,numero){
            var ancho = 689;
            var alto = 250;
            var barra = 0;
            var izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
            var arriba = (screen.height) ? (screen.height-alto)/2 : 100;
            var opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars='+barra+',resizable=0,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
            var url = "adicionarPersona.jsp?tipo="+tipo+"&documento="+numero;
            window.open(url, 'popUp', opciones);
    }

    function habilitar(){
		if(document.form.runt.checked){
			document.form.usernameR.disabled = false;
			document.form.passwordR.disabled = false;
			document.form.conf_passwordR.disabled = false;
			document.form.template.disabled = false;
		}else{
			document.form.usernameR.value = "";
			document.form.usernameR.disabled = true;
			document.form.passwordR.value = "";
			document.form.passwordR.disabled = true;
			document.form.conf_passwordR.value = "";
			document.form.conf_passwordR.disabled = true;
			document.form.template.value = "Sin capturar";
			document.form.template.disabled = true;
		}
	}

	function validarCampos(){
		if(document.form.nombre.value.length>0){
			var userN = document.form.username.value.replace(' ','');
			if(userN.length>5){
				if(document.form.password.value.length>5){
					if(document.form.password.value==document.form.conf_password.value){
						if(document.form.runt.checked){
							if(document.form.usernameR.value.length==8){
								if(!isNaN(document.form.usernameR.value)){
									if(document.form.passwordR.value.length>=8){
										if(document.form.passwordR.value==document.form.conf_passwordR.value){
											if(document.form.template.value!="Sin capturar"){
												document.form.submit();
											}else{
												alert("Falta capturar la huella digital");
											}
										}else{
											alert("El password y la confirmacion del runt no coinciden");
											document.form.conf_passwordR.value = "";
										}
									}else{
										alert("Usuario runt, debe ser de 8 o mas caracteres");
									}
								}else{
									alert("No se permiten valores alfabeticos");
								}
							}else{
								alert("Usuario runt, debe ser de 8 digitos");
							}
						}else{
                                                    document.form.submit();
                                                }
					}else{
						alert("El password y la confirmacion no coinciden");
						document.form.conf_password.value = "";
					}
				}else{
					alert("Su password debe ser igual o mayor a 6 carateres");
				}
			}else{
				alert("Su nombre de usuario debe ser igual o mayor a 6 carateres");
			}
		}else{
			alert("Ingrese una persona como usuario");
		}
	}

	function Biometria()
	{
		var obj
		var rta = ""
		var ID = document.form.documento.value;

		var TIPO = "CC";
		if(document.form.tipo.value==3)
			TIPO = "CE";
		if(document.form.tipo.value==4)
			TIPO = "TI";
		if(document.form.tipo.value==5)
			TIPO = "PP";

		obj = new ActiveXObject("Identica_Runt.Bio_Main")
		rta = obj.Enrolar(ID,TIPO,'','','','','','',0,0,0,1);
		if(rta.indexOf("<>"+ID+"<><>"+TIPO+"<><>1<><>")!=-1){
		   document.form.huella.value = obj.RTemplate;
		   document.form.template.value = "Capturada";
		   alert("Huella Capturada");
		}else{
			document.form.biometric.value = "0";
			document.form.excepcion.value = obj.R_Excepcion;
			alert(obj.R_Excepcion);
		}
	}
</script>


<style type="text/css">
<!--
.Estilo4 {color: #0066CC}
.style2 {
	color: #333333;
	font-weight: bold;
	font-size: 11px;
	font-family: Tahoma;
}
.Estilo6 {
	color: #FFFFFF;
	font-weight: bold;
	font-size: 12px;
}
.Estilo7 {
	font-size: 12px;
	font-weight: bold;
	color: #333333;
}
-->
</style>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%

   Parametro parametro=new Parametro();

java.sql.Date fecha=new java.sql.Date(new java.util.Date().getTime());
%>
<body >

<form id="form" name="form" method="post" action="procesarUsuario.jsp">
<table border="0" width="30%" align="center">
	<tr>
		<td>
  <fieldset>
  <table width="100%" border="0" align="center">
  <tr>
	<td colspan="2" background="../html/images/inicio_3.png"><div align="center"><span class="Estilo6">NUEVO USUARIO</span></div></td>
  </tr>
    <tr>
	<td colspan="2">&nbsp;</td>
  </tr>
    <tr>
      <td width="22%"><span class="style2">TIPO&nbsp;DOCUMENTO </span></td>
      <td width="33%">
        <select name="tipo" style="width:160px;font-size:11px">
          <%
         List list=modelo.listadoParametros(5);
         Iterator it = null;
         it = list.iterator();
           while (it.hasNext()) {
                    parametro = (Parametro)it.next();

         %>
          <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
          <%}%>
        </select>
      </td>
      </tr>
    <tr>
      <td><span class="style2">DOCUMENTO</span></td>
      <td><span class="Estilo4">
        <input type="text" name="documento"  id="documento" onblur="validarPersona()" style="width:160px; text-align:center; font-size:11px"/>
      </span></td>
    </tr>
    <tr>
      <td><span class="style2">NOMBRE</span></td>
      <td><span class="Estilo4">
        <label>
        <input name="nombre" type="text"  style="width:160px; text-align:center; font-size:11px" id="nombre" readonly="" />
        </label>
      </span></td>
    </tr>
    <tr>
      <td><span class="style2">USER-NAME </span></td>
      <td><span class="Estilo4">
        <label>
            <input type="text" name="username" id="username" maxlength="15" style="width:160px; text-align:center; font-size:11px"/>
        </label>
      </span></td>
      </tr>
    <tr>
      <td><span class="style2">PASSWORD</span></td>
      <td><span class="Estilo4">
              <input type="password" name="password" id="password" maxlength="40" style="width:160px; text-align:center; font-size:11px"/>
      </span></td>
      </tr>
    <tr>
      <td><span class="style2">REPITA&nbsp;PASSWORD </span></td>
      <td><span class="Estilo4">
        <label></label>
        <input type="password" name="conf_password" style="width:160px; text-align:center; font-size:11px"/>
      </span></td>
      </tr>

      <tr>
      <td><span class="style2">DESCRIPCION FUNCIONES</span></td>
      <td><span class="Estilo4">
        <label>
        <input type="text" name="descripcion" id="descripcion" style="width:160px; text-align:center; font-size:11px"/>
        </label>
      </span></td>
      </tr>

      <tr>
	<td colspan="2">&nbsp;</td>
	</tr>
        <tr>
	<td colspan="2" background="../html/images/inicio_3.png"><div align="center"><span class="Estilo6">CARGO</span></div></td>
        </tr>
        <tr>
       <td><span class="style2">GRUPO </span></td>
      <td><span class="Estilo4">
        <label>
        <select name="grupoC" id="grupoC" style="font-size:11px; width:130px">
                            <%
                                java.util.List tipos = modelo.listadoParametros(358);
                                for (int j = 0; j < tipos.size(); j++) {
                                    Parametro param = (Parametro) tipos.get(j);
                            %>
                            <option value="<%=param.getCodigo()%>"><%=param.getNombre()%></option>
                            <%	 }
                            %>
                        </select>
        </label>
      </span></td>
      </tr>
<tr>
       <td><span class="style2">CARGO </span></td>
      <td><span class="Estilo4">
        <label>
        <select name="cargo" id="cargo" style="font-size:11px; width:130px">
                            <%
                                java.util.List tipos2 = modelo.listadoParametros(359);
                                for (int j = 0; j < tipos2.size(); j++) {
                                    Parametro param = (Parametro) tipos2.get(j);
                            %>
                            <option value="<%=param.getCodigo()%>"><%=param.getNombre()%></option>
                            <%	 }
                            %>
                        </select>
        </label>
      </span></td>
      </tr>
        <tr>
        <td colspan="2">&nbsp;</td>
	</tr>

	 <tr>
	<td colspan="2" background="../html/images/inicio_3.png"><div align="center"><span class="Estilo6">CAJAS DE RECAUDO</span></div></td>
        </tr>
      <% Sede sede = (Sede)session.getAttribute("sede");
         java.util.List cajas = modelo.listarCajaBySede(sede.getId_sede());
           for(int i=0;i<cajas.size();i++){
               Caja caja = (Caja)cajas.get(i);%>
               <tr>
                   <td colspan="2" width="100%"><input type="checkbox" name="cajas" id="cajas" value="<%=caja.getId_caja()%>" />
                     <span class="Estilo7"><%= caja.getNombre().toUpperCase() %></span></td>
               </tr>
      <%   } %>
      <tr>
	<td colspan="2">&nbsp;</td>
	</tr>
	 <tr>
	<td colspan="2" background="../html/images/inicio_3.png"><div align="center"><span class="Estilo6">USUARIO RUNT</span></div></td>
        </tr>
      <tr>
          <td colspan="2" align="center"><input type="checkbox" name="runt" id="runt" style="font-size:11px" value="1" onclick="habilitar()"/>
            <span class="Estilo7">Posee usuario Runt</span></td>
      </tr>
      <tr>
      <td><span class="style2">USUARIO </span></td>
      <td><span class="Estilo4">
        <label>
        <input type="text" name="usernameR" id="usernameR" style="width:160px; text-align:center; font-size:11px" disabled="disabled"/>
        </label>
      </span></td>
      </tr>
    <tr>
      <td><span class="style2">PASSWORD</span></td>
      <td><span class="Estilo4">
        <input type="password" name="passwordR" id="passwordR" style="width:160px; text-align:center; font-size:11px" disabled="disabled"/>
      </span></td>
      </tr>
    <tr>
      <td><span class="style2">REPITA&nbsp;PASSWORD </span></td>
      <td><span class="Estilo4">
        <label></label>
        <input type="password" name="conf_passwordR" style="width:160px; text-align:center; font-size:11px" disabled="disabled"/>
      </span></td>
      </tr>
	  <tr>
      <td><span class="style2">HUELLA&nbsp;DIGITAL </span></td>
      <td><span class="Estilo4">
        <label></label>
		<input type="hidden" name="huella" value=""/>
		<button type="button" name="template" disabled="disabled" onclick="Biometria()"><span class="style2">Sin capturar </span></button>
       <!-- <input type="button" name="template" style="width:160px; text-align:center; font-size:11px" value="Sin capturar" disabled="disabled" onclick="Biometria()"/>-->
      </span></td>
      </tr>
	  <tr>
	<td colspan="2">&nbsp;</td>
	</tr>
    <tr>
        <td colspan="2" align="center">
<button type="button" name="Submit" onclick="validarCampos()"><span class="style2">Crear Usuario </span><img src="../html/images/Usuario.gif" width="19" height="18"/></button>
		 <!--<input type="button" name="Submit" value="Crear Usuario" onclick="validarCampos()"/> --></td>
    </tr>
  </table>
  </fieldset>
  </td>
  </tr>
 </table>

</form>

</body>
</html>
        <%  }else{ %>
			   <jsp:forward page="no_access.jsp">
				 <jsp:param name="tipo" value="1"></jsp:param>
			   </jsp:forward>
	<%  }
	}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>

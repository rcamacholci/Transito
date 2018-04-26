
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
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
			valor=document.form.persona.value;
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
                    if(document.form.placa.value.length>0){
                        if(document.form.motor.value.length>0){
                            if(document.form.servicio.value!=0){
                                document.form.submit();
                            }else{
                                alert("Falat El Servicio");
                            }
                        }else{
                            alert("Falta El Motor");
                        }
                    }else{
                        alert("Falta La Placa");
                    }
                }else{
                    alert("Faltan Campos Por Rellenar");
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

<form id="form" name="form" method="post" action="asignarPreasignacion.jsp">
<table border="0" width="30%" align="center">
	<tr>
		<td>
  <fieldset>
  <table width="100%" border="0" align="center">
  <tr>
	<td colspan="2" background="../html/images/inicio_3.png"><div align="center"><span class="Estilo6">PRESIGNACION PUBLICA</span></div></td>
  </tr>
    <tr>
	<td colspan="2">&nbsp;</td>
  </tr>
    <tr>
      <td width="22%"><span class="style2">TIPO&nbsp;DOCUMENTO </span></td>
      <td width="33%">
        <select name="tipo" style="width:170px;font-size:11px">
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
        <input type="text" name="persona"  id="persona" onblur="validarPersona()" style="width:170px; text-align:center; font-size:11px"/>
      </span></td>
    </tr>
    <tr>
      <td><span class="style2">NOMBRE</span></td>
      <td><span class="Estilo4">
        <label>
        <input name="nombre" type="text"  style="width:170px; text-align:center; font-size:11px" id="nombre" readonly="" />
        </label>
      </span></td>
    </tr>
    <tr>
      <td><span class="style2">SERVICIO</span></td>
      <td>
       <select name="servicio"  id="servicio"   style=" width:170px; color:#333333; font-size:12px">
           <option value="0">-- Seleccione una Clase --</option>
          <%
         list=modelo.listadoParametros(3);
         it = null;
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
      <td><span class="style2">PLACA</span></td>
      <td><span class="Estilo4">
              <input type="text" name="placa" id="placa" style="width:170px; text-align:center; font-size:11px; text-transform:uppercase;" maxlength="6" />
      </span></td>
      </tr>
    <tr>
      <td><span class="style2">NUMERO&nbsp;DE&nbsp;MOTOR </span></td>
      <td><span class="Estilo4">
        <label></label>
        <input type="motor" name="motor" style="width:170px; text-align:center; font-size:11px"/>
      </span></td>
      </tr>

	  <tr>
	<td colspan="2">&nbsp;</td>
	</tr>
    <tr>
        <td colspan="2" align="center">     <input type="button" name="Submit" value="Presignar" onclick="validarCampos()"/></td>
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

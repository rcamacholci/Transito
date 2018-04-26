<%--
    Document   : verReciboExcedente
    Created on : 10/01/2013, 02:24:45 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            try {
                if (session.getAttribute("model") != null) {
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("aplicarReciboExcedente.jsp")) {
                        Model modelo = (Model) session.getAttribute("model");
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Ver Recibo Excedente</title>
    </head>
    <style type="text/css">
        <!--
        .style1 {
            font-size: 10px;
            font-family: Tahoma;
            font-weight: bold;
            color: #333333;
        }
        .style3 {font-weight: bold}
        .style4 {color: #333333}
        .style4 {color: #333333; font-size:10px; text-align:center}
        .Estilo1 {color: #FFFFFF}
        .Estilo3 {font-size: 10px; font-family: Tahoma; font-weight: bold; color: #333333; }
        .Estilo4 {font-size: 10px}
        .Estilo5 {color: #333333; font-size: 10px; }
        .Estilo6 {font-size: 10px; color:#333333;}
        .Estilo7 {color:#333333;}
        .Estilo8 {font-size: 14px; color:#333333;}
        -->
    </style>

    <script>
        function validar(){
            if(document.form.ranterior.value.length>0){
                if(document.form.rnuevo.value.length>0){
                    window.frames[0].location.href = "tiqueteAnterior.jsp?reciboV="+document.form.ranterior.value+"&reciboN="+document.form.rnuevo.value;
                    window.frames[1].location.href = "tiqueteNuevo.jsp?norecibo="+document.form.rnuevo.value;
                    document.form.aplicar.disabled = false;
                }else{
                    alert("Digite Recibo Nuevo");
                }
            }else{
                alert("Digite Recibo Anterior");
            }
        }

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

         function consultaTiquetes(){
		r1 = document.form.ranterior.value ;
		r2 = document.form.rnuevo.value ;
		if(r1!=null&&r2!=null){
			tipoDoc = tipo.options[tipo.options.selectedIndex].value
			ajax=nuevoAjax();
			ajax.open("POST", "getTiquetes.jsp",true);
			ajax.onreadystatechange=function() {
				if (ajax.readyState==4) {
					var respuesta = "" ;
					for(var i = 0; i < ajax.responseText.length ; i++){
						if(isNaN(ajax.responseText.charAt(i)))
							respuesta += ajax.responseText.charAt(i);
					}
					if(respuesta == "nueva"){
						viewPersona(tipoDoc,documento);
					}else{
						document.getElementById("nombreRadicador").value = ajax.responseText;
					}
				}
			}
			ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			ajax.send("documento="+documento+"&tipo="+tipoDoc);
		}
	}
    </script>

    <body>
        <form name="form" method="post" action="procesarReciboExcedente.jsp">
            <fieldset>
            <table align="center" border="0">
                <tr style="border:none; background:url(../html/images/inicio_3.png)" align="center">
                    <td colspan="5"><span class="style2 style14 Estilo32">Excedentes de recibos</span></td>
                </tr>
                <tr>
                    <td colspan="2" align="center">Recibo Anterior<hr></td>
                    <td width="10%">&nbsp;</td>
                    <td colspan="2" align="center">Recibo Nuevo<hr></td>
                </tr>
                <tr>
                    <td>Numero&nbsp;Recibo</td>
                    <td><input type="text" maxlength="8" name="ranterior" id="ranterior" style="text-transform:uppercase"></td>
                    <td>&nbsp;</td>
                    <td>Numero Recibo</td>
                    <td><input type="text" maxlength="8" name="rnuevo" id="rnuevo" style="text-transform:uppercase"></td>
                </tr>
                <tr>
                    <td colspan="2"><iframe src="#" id="ReciboAnterior" name="ReciboAnterior" marginwidth="0" height="250" width="100%" marginheight="0" align="top"  style="border:none" frameborder="0"></iframe></td>
                    <td>&nbsp;</td>
                    <td colspan="2"><iframe src="#" id="ReciboNuevo" name="ReciboNuevo" marginwidth="0" height="250" width="100%" marginheight="0" align="top"  style="border:none" frameborder="0"></iframe></td>
                </tr>
                <tr>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td>&nbsp;</td>
                    <td colspan="2" align="right"><input type="button" value="Consultar" onclick="validar()" align="right"></td>
                </tr>
            </table>
                </fieldset>
        </form>
    </body>
</html>
<%  } else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }
        } else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%    }
} catch (Exception mexe) {
mexe.printStackTrace();
%>

<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
            }%>
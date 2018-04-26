<%--
    Document   : Auditoria_Comparendo
    Created on : 21/02/2013, 08:09:47 AM
    Author     : acer
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="webservices.liquidacion.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
try{
	if(session.getAttribute("model")!=null){
		//if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                if(1==1){
                  Model model= (Model)session.getAttribute("model");
                    %>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Liquidacion de Carteras</title>
        <style type="text/css">
            <!--
            .Estilo4 {
                font-weight: bold;
                font-family: "Times New Roman", Times, serif;
                color: #FFFF99;
                font-size:12px;
            }

            -->

        </style>
	    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->

        <META http-equiv=Content-Type content="text/html; charset=windows-1252">
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="../html/css/lineaVertical.css" rel="stylesheet" type="text/css" media="screen" />
        <link href="../html/css/3pestanas.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
        <link href="../html/css/page2Colum.css" rel="stylesheet" type="text/css" media="screen" />
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">

        function edit(){
        if(document.form.fechaInR.value.length==10 && document.form.fechaFnR.value.length==10){
         if(document.form.numero.value.length>0){                
                window.frames[0].location.href="Auditoria_Comparendo.jsp?Numero="+document.form.numero.value+"&Usuario="+document.form.Lperfil.value+"&fi="+document.form.fechaInR.value+"&ff="+document.form.fechaFnR.value;
            }else{                
                window.frames[0].location.href="Auditoria_Comparendo.jsp?Numero=0&Usuario="+document.form.Lperfil.value+"&fi="+document.form.fechaInR.value+"&ff="+document.form.fechaFnR.value;
            }
            }else{
            alert("Digite fechas");
            }
            		
	}
        	function verReporte(){

                                ancho = 789;
				alto = 250;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				var dir = "reportes/Auditoria_comparendo.jasper";
                                 var nombre = "Auditoria";
				url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
				window.open(url, 'popUp', opciones);
			}

</script>
        <style type="text/css">




<!--
.Estilo7 {color: #006699}
.Estilo10 {
	color: #333333;
	font-weight: bold;
	font-size: 14px;
}
.Estilo15 {
	color: #003399;
	font-size: 16px;
}
.Estilo16 {color: #333333}
.Estilo19 {
	font-size: 12px;
	font-weight: bold;
	color: #333333;
}
.Estilo20 {
	font-size: 13px;
	font-weight: bold;
	color: #0066CC;
}
-->
        </style>
</head>
 <body>
 <form name="form" method="post" action="">
 <table width="200" border="1">
  <tr>
    <th scope="col" colspan="10"><h2>AUDITORIA COMPARENDOS</h2></th>
  </tr>
  <tr>
    <th scope="col">NUMERO</th>
    <td scope="col"><input type="text" id="numero" name="numero" onKeyPress="return soloNumeros(event)"/>&nbsp;</td>
    <th scope="col">USUARIO</th>
    <td scope="col"><select id="Lperfil" name="Lperfil" style="width:150px">
            <option value="0" selected="selected">--- Seleccionar Usuario ---</option>
       <%
                 Perfil perfil = new Perfil();
            //-----------------------//
            java.util.List listPerfil = model.listarPerfil();

         for(int i = 0;i<listPerfil.size();i++){
            perfil = (Perfil)listPerfil.get(i);
            Usuario usu = model.consultarUsuario(perfil.getfk_usuario());
            Persona per = model.consultarPersona(usu.getFk_persona());
%>
<option value="<%=usu.getId_usuario()%>"><%=usu.getNombre()%> - - <%=per.getNombre_1()%> <%=per.getApellido_1()%></option>
                <%}%>
        </select></td>
    <th>FECHA&nbsp;INICIAL</th>
          <%String fecha_hoy24 = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
          <td><input  id="fechaInR" name="fechaInR" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy24%>"/>&nbsp;<input name="bfechaInR" type="button" id="bfechaInR" value="..." style="width:30px">
          <SCRIPT type="text/javascript">
                                                        Calendar.setup({
                                                                        inputField     :    "fechaInR",
                                                                        ifFormat       :    "%d/%m/%Y",
                                                                        button         :    "bfechaInR"
                                                        });
                                          </SCRIPT></td>
          <th>FECHA&nbsp;FINAL</th>
          <%String fecha_hoy25 = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());%>
          <td><input  id="fechaFnR" name="fechaFnR" style="text-align:center;color:#333333;font:bold; width:100px" onKeyUp="mascara(this,'/',true)" maxlength="10" value="<%=fecha_hoy25%>"/>&nbsp;<input name="bfechaFnR" type="button" id="bfechaFnR" value="..." style="width:30px">
          <SCRIPT type="text/javascript">
                                                        Calendar.setup({
                                                                        inputField     :    "fechaFnR",
                                                                        ifFormat       :    "%d/%m/%Y",
                                                                        button         :    "bfechaFnR"
                                                        });
                                          </SCRIPT></td>
    <th scope="rowgroup"><input type="button" value="consultar" onclick="edit()"></th>
    <th scope="col"><input type="button" value="Reporte" onclick="verReporte()"></th>

  </tr>
  <tr><td colspan="10"><iframe src="" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe></td></tr>
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

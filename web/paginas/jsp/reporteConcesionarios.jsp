<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("reporteConcesionarios.jsp")){
                    modelo.Model modelo = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");

    %>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Vehiculo</title>
    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
		<script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
		<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
                <script src="../html/scripts/personas.js" type="text/javascript"></script>
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

       function consultaPersona(){
        var documento = document.getElementById("NitConcesionario");
        if(!isNaN(documento.value)&&documento.value.length>0){
                var tipoDoc = "2";
                var ajax2=nuevoAjax();
                ajax2.open("POST", "getPersona.jsp",true);
                ajax2.onreadystatechange=function() {
                        if (ajax2.readyState==4) {
                                var respuesta = "" ;
                                for(var i = 0; i < ajax2.responseText.length ; i++){
                                        if(isNaN(ajax2.responseText.charAt(i))||ajax2.responseText.charAt(i)==' ')
                                                respuesta += ajax2.responseText.charAt(i);
                                }
                                if(respuesta.indexOf("nueva")!=-1){
                                        viewPersona(tipoDoc,documento.value);
                                }else{
                                  document.form.nombreConcesionario.value = respuesta;
                                }
                        }
                }
                ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                ajax2.send("documento="+documento.value+"&tipo="+tipoDoc);
        }
    }




            function paso(){
		if(document.form.fecha_ini.value.length>0){
			if(document.form.fecha_fin.value.length>0){
                                document.form.action='reporteConcesionarios.jsp'
				document.form.submit();
			}else{
				alert("Digite la fecha final del reporte");
			}
		}else{
			alert("Digite la fecha inicial del reporte");
		}
           }


            function verReporte(){
                //document.form.motor.value
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width-ancho)/2 : 100;
                arriba = (document.height) ? (document.height-alto)/2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + 			ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "concesionarios/Concesionarios.jasper";
                var nombre = "tramiteGeneral";
                url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
                window.open(url, 'popUp', opciones);
            }

		</script>
		<STYLE>
<!--
A.ssmItems:link		{color:black;text-decoration:none;}
A.ssmItems:hover	{color:black;text-decoration:none;}
A.ssmItems:active	{color:black;text-decoration:none;}
A.ssmItems:visited	{color:black;text-decoration:none;}
.style5 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.Estilo11 {
	color: #0066CC;
	font-weight: bold;
	font-size: 10px;
}
.style7 {font-family: Tahoma; font-weight: bold; color: #333333; }
.style8 {color: #333333}
.style9 {font-size: 10px}
.style10 {
	font-size: 10px;
	color: #333333;
	font-weight: bold;
	font-family: Tahoma;
}
.style13 {font-size: 11px; color: #333333; font-weight: bold; font-family: Tahoma; }
.style14 {
	color: #FFFFFF;
	font-family: Tahoma;
	font-weight: bold;
	font-size: 12px;
}
-->
        </STYLE>


</head>
<%
   //---------------------------- reporte de tramites -------------------------------
    if(request.getParameter("fecha_ini")!=null&&request.getParameter("fecha_fin")!=null&&!request.getParameter("fecha_ini").isEmpty()&&!request.getParameter("fecha_fin").isEmpty()){
        String conse = "0";
        
        if(request.getParameter("NitConcesionario")!=null&&!request.getParameter("NitConcesionario").equals("")){
            conse = request.getParameter("NitConcesionario");
        }

        HashMap parameters = new java.util.HashMap();
        parameters.put("USUARIO", usuario.getNombre());
        parameters.put("FECHA_INI",request.getParameter("fecha_ini"));
        parameters.put("FECHA_FIN",request.getParameter("fecha_fin"));
        parameters.put("CONCESIONARIO", conse);
        parameters.put("CLASE", request.getParameter("claseV"));
        session.setAttribute("tramiteGeneral", parameters);
%>
        <script language="javascript" type="text/javascript">
               verReporte();
               document.location = "reporteConcesionarios.jsp";
	</script>

<%  }
  


%>


    <body>

		<form name="form" id="form" method="post" action="">
	        <fieldset>
			<table width="100%" border="0" align="center">
				<tr style="border:none; background:url(../html/images/inicio_3.png)">
			<td colspan="12" align="center"><span class="style2 style14">REPORTE POR CONCESIONARIOS</span></td>
		  </tr>
                <tr valign="middle">
                      <td scope="col"  align="center" colspan="2"><label style="color:#666666"><span class="style5"><span class="style9">FECHA&nbsp;INICIAL</span></span></label></td>
                      <td scope="col" align="center" colspan="2"><input id="fecha_ini" name="fecha_ini" type="text" style="text-align:center;color:#333333;font:bold; width:100px"/>&nbsp;
                      <input name="bfechaIT" type="button" id="bfechaIT" value="..." style="width:20px">
					  <SCRIPT type="text/javascript">
													Calendar.setup({
															inputField     :    "fecha_ini",
															ifFormat       :    "%d/%m/%Y",
														button         :    "bfechaIT"
													});
											  </SCRIPT>

					  </td>
					  <td width="14%" align="center"><span class="style10">CLASE</span></td>
					  <td width="15%"><span style="font-size: 10px">
					   <select name="claseV" id="claseV"  style="width:120px; font-size:10px; color:#333333">
                                            <option value="0"><<-- Seleccione Clase -->></option>
                                            <option value="1">Vehiculos</option>
                                            <option value="10">Motocicletas</option>
                                           
                                           </select>
                          		  </span></td>
					  <td scope="col"  align="center" colspan="2"><label style="color:#666666"><span class="style5 style9">FECHA&nbsp;FIN </span></label></td>
                      <td width="24%" scope="col" align="center" colspan="2"><input id="fecha_fin" name="fecha_fin" type="text" style="text-align:center;color:#333333;font:bold; width:100px"/>&nbsp;
                      <input name="bfechaFT" type="button" id="bfechaFT" value="..." style="width:20px">
					  <SCRIPT type="text/javascript">
													Calendar.setup({
															inputField     :    "fecha_fin",
															ifFormat       :    "%d/%m/%Y",
															button         :    "bfechaFT"
													});
											  </SCRIPT>

					  </td>


                      
                    </tr>
              <tr>
               <td align="center"  colspan="2" class="style10">NUMERO NIT</td>
			<td align="center" colspan="3"><input name="NitConcesionario" type="text" id="NitConcesionario"  style="width:150px; font-size:10px; color:#333333; text-align:center" onBlur="consultaPersona()"/></td>
			<td colspan="3" align="center"><span class="Estilo6">&nbsp;
	            <input id="nombreConcesionario" name="nombreConcesionario" type="text"  style="width:400px; font-size:10px; color:#333333; text-align:center" readonly/>
			</span></td>
            <td width="24%" scope="col" align="center"><input id="generar"  name="generar" type="button" value="Generar" style="color:#333333; width:100px" onClick="paso()"/></td>
              </tr>
            </table>
	        </fieldset>
		  </br>
		   

		

  </br>






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

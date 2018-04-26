
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            try {

              if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("revocatoria_tram_traslado.jsp")) {
                    if (session.getAttribute("model") != null) {
                        Model model = (Model) session.getAttribute("model");
                        modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
            <style type="text/css">
		<!--
.Estilo7 { 	color: #333333; 	font-size: 12px; 	font-weight: bold; }
.Estilo8 {	font-size: 14px; 	color: #333333; 	font-weight: bold; }
.Estilo11 {color: #DE2021}
.style9 {font-size: 14px; color: #FFFFFF; font-weight: bold; }
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
-->
            </style>
        <script language="javascript" type="text/javascript">

            function GenerarReporte(){
                //document.form.motor.value
                ancho = 789;
                alto = 550;
                barra = 0;
                izquierda = (document.width) ? (document.width-ancho)/2 : 100;
                arriba = (document.height) ? (document.height-alto)/2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + 			ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "revocatoriaTramite/reporte_rev_traslado.jasper";
                var nombre = "reporte_rev_traslado";
                url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
                window.open(url, 'popUp', opciones);
            }
        </script>
    </head>
    <body>
        <fieldset>

            <table width="100%" height="68" border="0" align="center" cellpadding="1" cellspacing="0">
			 <tr style="border:none; background:url(../html/images/inicio_3.png)">
<td colspan="11" align="center" class="style9">REPORTE REVOCATORIA DE TRAMITES </td>
			 </tr>
                <tr >

                    <th>

						<!-- <td width="20%"><input id="consultar"  name="consultar" type="button" value="    Consultar    " style="color:#333333" onClick="paso()" /></td> -->
                  <td width="20%" align="center">
					  <%
                        HashMap parameters = new java.util.HashMap();
                      //parameters.put("USUARIO", usuario.getNombre());
                        session.setAttribute("reporte_rev_traslado", parameters);
			           %>
<button id="generar"  name="generar" type="button" onClick="GenerarReporte()"><span class="style2">Generar </span><img src="../html/images/PDF.png"  width="19" height="18"/></button>
<!-- <input id="generar"  name="generar" type="button" value="Generar" style="color:#333333; width:100px" onClick="GenerarReporte()"/> --></td>
					 </th>
                </tr>
        </table>
    </fieldset>
		  <iframe src="#" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>
        </fieldset>
    </body>
</html>

        <%  } else {%>
        <jsp:forward page="../no_access.jsp">
            <jsp:param name="tipo" value="1"></jsp:param>
        </jsp:forward>
        <%  }
        }else {%>
            <script>
                window.parent.document.location.href = "../../index.jsp";
            </script>  <%
        }
    }catch(Exception mexe){ %>
        <jsp:forward page="../no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% } %>
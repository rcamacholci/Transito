<%-- 
    Document   : verReporteCartera
    Created on : 13/07/2011, 11:50:41 AM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            try {
                if (session.getAttribute("model") != null) {
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("verReporteCartera.jsp")) {
                        Model model = (Model) session.getAttribute("model");
                        modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
            <!--
            .Estilo3 {font-size: 12px; color: #FFFFFF; }
            .Estilo4 {
                color: #333333;
                font-weight: bold;
                font-size: 12px;
            }
            .style2 {font-weight: bold; color: #333333;}
            .style3 {font-size: 11px}
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
                var dir = "informes/reporteServicioVigencias.jasper";
                var nombre = "reporteServicioVigencias";
                url = "../verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
                window.open(url, 'popUp', opciones);
            }

        </script>

    </head>
    <body>
        <fieldset>
            <legend class="Estilo4"  align="center">GENERAR INFORME DE CARTERA GENERAL A FECHA ACTUAL</legend>
            <table width="100%" border="1" cellpadding="1" align="center" cellspacing="0">
                <tr style="background:url(../html/images/inicio_3.png); border:none">
                    <th>
                        <%
                        HashMap parameters = new java.util.HashMap();
                        parameters.put("USUARIO", usuario.getNombre());
                        session.setAttribute("reporteServicioVigencias", parameters);
                        %>
                        <input id="generar"  name="generar" type="button" value="Generar" style="color:#333333; width:100px" onClick="GenerarReporte()"/>
                    </th>
                </tr>
            </table>
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
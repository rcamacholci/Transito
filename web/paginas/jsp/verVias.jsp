<%-- 
    Document   : consultarHorariosCursos
    Created on : 30/05/2011, 02:35:58 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
    try {
        if (session.getAttribute("model") != null) {
            //if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
            if(1==1){
             modelo.Model model = (modelo.Model) session.getAttribute("model");
              modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
             //long op=Long.parseLong(request.getParameter("doc"));%>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listado de Horarios Cursos-Comparendos</title>
        <style type="text/css">
            .label {font-size: 11px; color:#666666; text-align:center ; font-family:Arial; font-weight:bold ; width:110px}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold }
            .date {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; width:100px }
            .bdate {font-size: 10px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .select {font-size: 11px; color:#003366; text-align:left ; font-family:Arial; font-weight:bold; width:120px }
            .input { width:130px }
            .check { font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; }
            .title {font-size: 12px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; text-transform:uppercase}
        </style>
        <script language="javascript" type="text/javascript">
            function sombrear(tr){
		tr.style.backgroundColor="#CCCCCC";
            }
            function renovar(tr){
                tr.style.backgroundColor="#FFFFFF";
            }
            function verReporte(){
				ancho = 789;
				alto = 700;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				var dir = "reportes/ViasGeneral.jasper";
                                 var nombre = "vias";
				url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
				window.open(url, 'popUp', opciones);
			}
           // function show(opcion){
		//document.location.href = "programarCitacionComparendo.jsp?id="+opcion.id;
            //}
        </script>
    </head>
    <body>
       <%
    java.sql.Date inicio = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fi")).getTime());
    java.sql.Date fin = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("ff")).getTime());
    HashMap parameters = new java.util.HashMap();
    parameters.put("FECHA_INI", new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date(inicio.getTime())));
    parameters.put("FECHA_FIN", new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date(fin.getTime())));
    parameters.put("USUARIO",usuario.getNombre());
    //parameters.put("VIA", "entidad");
   // parameters.put("CAJA", 123);
                           session.setAttribute("vias", parameters);


        %>
        <script>
            verReporte();
        </script>
    </body>
</html>
            <%}else {%>
                    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="1"></jsp:param></jsp:forward>
            <% }
          }else {%>
                <script>    window.parent.document.location.href = "../../index.jsp";</script>
      <%  }
    } catch (Exception mexe) {%>
        <jsp:forward page="no_access.jsp">
            <jsp:param name="tipo" value="2"></jsp:param>
            <jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param>
        </jsp:forward>
<%  }%>
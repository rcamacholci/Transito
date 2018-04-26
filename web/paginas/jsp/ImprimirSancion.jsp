<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("Comparendos_Sancionados.jsp")){

                 System.out.println(request.getParameter("imp"));
                    if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("Reimprimir") || request.getParameter("imp").equals("0")){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                    String usu = usuario.getNombre();
                    long ind = Long.parseLong(request.getParameter("ind"));
                    System.out.println(ind);
                        model.getCon().setAutoCommit(false);
                        model.actualizarImpresionSancion(ind);
                        model.getCon().commit();

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
-->
        </style>


		<script language="javascript" type="text/javascript">

                   function ver(){
                           window.location.href = "VerReporteSamcionados.jsp"
			}


                       function verR(){
                                ancho = 789;
				alto = 250;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				var dir = "resolucion/ResolucionSancion.jasper";
			        var nombre = "Resolucion";
                                //sancionalert (dir+"--"+nombre);
				url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
				window.open(url, 'popUp', opciones);
			}

			function sombrear(tr,color){
				tr.style.backgroundColor = color;
			}
			function renovar(tr){
				tr.style.backgroundColor = "#FFFFFF";
			}

                      

                        function verI(td){
                            var comparendo = td.id;
                            alert(comparendo);
                                ancho = 789;
				alto = 250;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				
			        var nombre = document.form.hidden.value;
                                alert(nombre);
				url = "consultarComparendo.jsp?id=0&comparendo="+comparendo;
				window.open(url, 'popUp', opciones);
                        }
                          
                        
		</script>
		
</head>
    <body>
        <%
                           HashMap parameters = new java.util.HashMap();
                           parameters.put("id_sancion",ind);
                           session.setAttribute("Resolucion", parameters);
       %>
       <script>
             verR();
             ver();
       </script>
       <%  }else{
        %>
       <script>
                          alert("La Sancion ya ha sido impresa o no posee permiso de reimpresion");
                          window.location.href = "Comparendos_Reimprimir_Sancionados.jsp"
       </script>
        <%}%>
    </body>
</html>

             <%}else{ %>
			   <jsp:forward page="no_access.jsp">
				 <jsp:param name="tipo" value="1"></jsp:param>
			   </jsp:forward>
	<%  }
	}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){

%>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
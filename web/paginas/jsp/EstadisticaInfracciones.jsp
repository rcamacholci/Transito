<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarRadicacion.jsp")){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
   
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
                         function verR(){
                              
				ancho = 789;
				alto = 250;
				barra = 0;
				izquierda = (document.width) ? (document.width-ancho)/2 : 100;
				arriba = (document.height) ? (document.height-alto)/2 : 100;
				opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
				var dir = "comparendos/reporteInfraccionAnual/Infraccion_anual.jasper";
                                 var nombre = "Comparendos";
				url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
				window.open(url, 'popUp', opciones);
                                
			}
			function renovar(tr){
				tr.style.backgroundColor = "#FFFFFF";
			}
		</script>
		
</head>
    <body>

              <%
     try{
     
	                
                        String fechaI = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fi")));
                        String fechaF = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("ff")));
                        String inf = request.getParameter("infrac");
                        HashMap parameters = new java.util.HashMap();
                           parameters.put("NUM",inf);
                           parameters.put("FECHAI",fechaI);
                           parameters.put("FECHAF",fechaF);
                           session.setAttribute("Comparendos", parameters);
                           %>
                           <script language="javascript" type="text/javascript">
                            verR();
                            window.location.href="pantallazo.jsp";
                           </script>
                           <%

                 
	 }catch(Exception exc){
       exc.printStackTrace();
   }  %>
          </table>
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
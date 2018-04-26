<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*"  import="modelo.Parametro"  import="java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("Novedades.jsp")){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                    modelo.Persona persona2 = model.consultarPersona(usuario.getFk_persona());
                    String nombreU = persona2.getNombre_1()+" "+persona2.getApellido_1()+" "+(persona2.getApellido_2()!=null?persona2.getApellido_2():"");
                   

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
				var dir = "tramites/Novedades.jasper";
                                 var nombre = "Novedades";
				url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
				window.open(url, 'popUp', opciones);
                                
			}
			function sombrear(tr,color){
				tr.style.backgroundColor = color;
			}
			function renovar(tr){
				tr.style.backgroundColor = "#FFFFFF";
			}
		</script>
		
</head>
    <body>
             <%
                try{
                                java.util.Date  fechaI = new java.util.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fi")).getTime());
                                java.util.Date  fechaF = new java.util.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("ff")).getTime());
				/*java.sql.Date FechaI = new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fi"));
				 java.sql.Date FechaF = new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("ff"));
				*/
					long fk_usu = usuario.getId_usuario();
					   
                      
                          HashMap parameters = new java.util.HashMap();
                           parameters.put("FK_USUARIO",fk_usu);
			   parameters.put("NOM_USUARIO", nombreU);
                           parameters.put("FECHA_INI",fechaI);
                           parameters.put("FECHA_FIN",fechaF);
                           session.setAttribute("Novedades", parameters);
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
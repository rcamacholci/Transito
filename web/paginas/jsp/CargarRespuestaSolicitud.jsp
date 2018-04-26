 <% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="procesos.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
	if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("RadicacionSolicitudesOficios.jsp")){
        modelo.Model model = (modelo.Model)session.getAttribute("model");
        modelo.Usuario usuario =(modelo.Usuario)session.getAttribute("usuario");
        
        if(model!=null){
            new RespuestaSolicitud(request,model,usuario);
        }
  %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Archivos Planos</title>
        <style type="text/css">
<!--
.style4 {
	color: #006699;
	font-weight: bold;
}
-->
        </style>
</head>
    <body>
        <table border="0" width="50%" align="center">
            <tr>
                <td height="40" align="center" bgcolor="#CCCCCC" class="style4">Archivo cargado Correctamente</td>
            </tr>

    </table>
        
    <iframe src="" width="100%" id="respuesta" height="500"  frameborder="0" scrolling="auto"></iframe>

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
}catch(Exception mexe){
mexe.printStackTrace();
%>

    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
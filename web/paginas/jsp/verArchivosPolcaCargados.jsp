<%-- 
    Document   : verArchivosPolcaCargados
    Created on : 12/07/2012, 12:50:54 PM
    Author     : digitalizacion
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="ISO-8859-1" import="modelo.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("CargarPlanosPolca.jsp")){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
                    %>

<%

response.setContentType ("application/vnd.ms-excel"); //Tipo de fichero.
response.setHeader ("Content-Disposition", "attachment;filename=\"Comparendos Generados.xls\"");

%>
<html>
    <head>
        <meta>
        <title>Archivos Polca Cargados</title>
    </head>
    <body>
        <table>
            <tr>
                <th>No</th>
                <th>Numero Comparendo</th>
            </tr>

           
        <tr>
                <%
        java.util.List<Archivos_Polca> ArchivoPolca = null;
        
        ArchivoPolca  = model.consultarArchivoPolca();
        for(int i=0;i<ArchivoPolca.size();i++){
        Archivos_Polca archivoPolca = ArchivoPolca.get(i);

                %> 
                <td><%=i+1%></td>
                <td><%=archivoPolca.getnum_comparendo()%></td> 
             </tr>
            <%}%>

        </table>

      <%

    model.eliminarComparendoArchivoPolca();
    model.getCon().commit();
%>

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
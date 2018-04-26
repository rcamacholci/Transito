<%--
    Document   : consultarPagosOnline
    Created on : 26/06/2013, 11:00:09 AM
    Author     : jjpadillag
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
try{
	if(session.getAttribute("model")!=null){
		if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
        <link href="../html/css/pagosonline.css" rel="stylesheet" type="text/css" media="screen" />
        <title>Pagos Online</title>
    </head>
    <body>
        <table>
            <tr>
                <th>PAGOS ONLINE</th>
            </tr>
        </table>
        <fieldset>
            <div id="div-border"></div>
        <div id="principal">

            <div class="tabs">
   <div class="tab">
       <input type="radio" id="tab-1" name="tab-group-1" checked>
       <label for="tab-1">Pagos Online</label>
       <div class="content">
           <iframe src="verPagosOnline.jsp" id="verPagosOnline" name="verPagosOnline" marginwidth="0" height="100%" width="100%" marginheight="0" align="top" scrolling="auto" style="border:none"></iframe>
       </div>
   </div>
   <!--<div class="tab">
       <input type="radio" id="tab-2" name="tab-group-1">
       <label for="tab-2">Reporte Pagos Online</label>
       <div class="content">
           <iframe src="listarFormasdepago.jsp" id="verTiposdePago" name="verTiposdePago" marginwidth="0" height="100%" width="100%" marginheight="0" align="top" scrolling="auto" style="border:none"></iframe>
       </div>
   </div>
    <div class="tab">
       <input type="radio" id="tab-3" name="tab-group-1">
       <label for="tab-3">Conceptos</label>
       <div class="content">
           <iframe src="listarConceptos.jsp" id="verConceptos" name="verConceptos" marginwidth="0" height="100%" width="100%" marginheight="0" align="top" scrolling="auto" style="border:none"></iframe>
       </div>
   </div>-->
</div>


        </fieldset>


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
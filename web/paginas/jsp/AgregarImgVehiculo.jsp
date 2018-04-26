
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
try{
	if(session.getAttribute("model")!=null){
		 if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                    modelo.Model model = (modelo.Model)session.getAttribute("model");

                    String placa = request.getParameter("placa");

%>



<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <title>Agregar Imagenes Vehiculo</title>

        <script type="text/javascript" language="javascript">
            
        </script>

    </head>
    <body>

        <form name="form" method="post" action="">

            <table cellspacing=1 cellpadding=4 bgcolor="#ffffff" align="center" width="70%">

                <tr>
                    <td>
                        &nbsp;
                    </td>
                </tr>

            </table>

        </form>

    </body>
</html>

<% }else{ %>
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
<%}%>
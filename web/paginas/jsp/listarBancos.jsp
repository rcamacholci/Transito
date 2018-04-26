<%-- 
    Document   : listarBancos
    Created on : 13/02/2013, 02:24:48 PM
    Author     : Jefrey
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("adicionarBancos.jsp")){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");
%>
<html>
    <head>
        <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Refresh" content="15">
        <title>Listado de bancos</title>
    </head>
    <body>
       <table width="200" border="1">
                <tr>
                    <th colspan="2" scope="col">LISTADO DE BANCOS DEL SISTEMA</ th>
                </tr>

            <% java.util.List listarBanco = model.listarBanco();
                for(int i=0;i<listarBanco.size();i++){
                Banco banco = (Banco)listarBanco.get(i);
            %>
                <tr>
                    <td width="74%" colspan="2" scope="row"><%=banco.getNombre() %></td>
                </tr>
            <%}%>

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
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%
modelo.Model model = (modelo.Model)session.getAttribute("model");
if(model!=null){
    model.getCon().setAutoCommit(false);
    model.getCon().commit();
    model.getCon().close();
}
java.util.Enumeration enu = session.getAttributeNames();
while(enu.hasMoreElements()){
	String campo = enu.nextElement().toString();
	session.removeAttribute(campo);
}
session.invalidate();
%>
<script language="javascript" type="text/javascript">
    document.location.href = "../../index.html";
</script>
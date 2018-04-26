<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, modelo.Caja, modelo.Sede, modelo.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("adicionarBancos.jsp")){
                    modelo.Model modelo = (modelo.Model)session.getAttribute("model");
                    modelo.getCon().setAutoCommit(false);
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Adicionar Banco</title>
</head>
<body>
<%
    if(request.getParameter("NombreTipoPago")!=null){
    String nombre = request.getParameter("NombreTipoPago");
    nombre = nombre.toUpperCase();
    try{
        if(nombre.length()>0){
        long codigo = modelo.consultarCodigoByFk_grupo(301);
        long numero = codigo + 1;
        modelo.adicionarTipoPago(nombre,numero,301);
        modelo.getCon().commit();
        %>
        <script>
            alert("El Tipo de pago ha sido adicionado");
            window.parent.close();
        </script>
        <%
        }else{
        %>
            <script>
            alert("Error al adicionar Tipo de pago");
            window.parent.close();

            </script>
        <%
        }
        }catch(Exception ex){
        modelo.getCon().rollback();
        }
    } %>



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
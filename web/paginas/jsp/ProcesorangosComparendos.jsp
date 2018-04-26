<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, modelo.Caja, modelo.Sede, modelo.Model" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("adicionarRangoComparendo.jsp")){
                    modelo.Model modelo = (modelo.Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Adicionar Caja</title>
</head>
<body>
<%
    java.sql.Date  fechaSystem= new java.sql.Date(new java.util.Date().getTime());
    String nombre    =       request.getParameter("nombre");
    String num_i = request.getParameter("num_i");
    String num_f = request.getParameter("num_f");
    String num_resolucion = request.getParameter("num_resolucion");
    java.sql.Date fechap= new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaI")).getTime());
    if(num_i.length()>0 && num_f.length()>0 && num_resolucion.length()>0 && fechap!=null){
    modelo.Rangos_Comparendos rango = new modelo.Rangos_Comparendos();
        long ln = 1;
        rango.SetEstado(ln);
        System.out.println(rango.GetEstado());
        rango.SetNum_Inicial(num_i);
        System.out.println(rango.GetNum_Inicial());
        rango.SetNum_Final(num_f);
        System.out.println(rango.GetNum_Final());
        rango.Setfecha_Proceso(fechaSystem);
        System.out.println(rango.GetFecha_Proceso());
        rango.SetNum_resolucion(num_resolucion);
        System.out.println(rango.GetNum_resolucion());
        rango.Setfecha_Resolucion(fechap);
        System.out.println(rango.GetFecha_Resolucion());
        rango.SetFk_usuario(usuario.getId_usuario());
        System.out.println(rango.GetFk_usuario());
        modelo.adicionarRangoComparendos(rango);


        %>
        <script>
            alert("El Rango ha sido adicionado");
            window.location.href="RangoComparendos.jsp";
        </script>
<% }else{ %>
        <script>
            alert("El Rango no ha sido adicionada");
            window.location.href="adicionarRangoComparendo.jsp";
        </script>
<% } %>
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

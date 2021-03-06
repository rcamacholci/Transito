<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("editarPropietario.jsp")){
                        Model modelo= (Model)session.getAttribute("model");
                    %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Adicionar Propietario</title>
</head>

<body>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
    try{
        Propietario propietario = (Propietario) session.getAttribute("propietario");
        if(propietario!=null){
            modelo.getCon().setAutoCommit(false);
            int  porcentaje =  Integer.parseInt(request.getParameter("porcentaje"));
            java.sql.Date  fecha_inicial = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_inicial")).getTime());
            java.sql.Date  fecha_final = null;
            if(request.getParameter("fecha_final")!=null){
                    if(!request.getParameter("fecha_final").isEmpty()){
                            fecha_final = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_final")).getTime());
                    }
            }
            String tipoPropiedad = request.getParameter("tipoPropiedad");
            String proIndiviso = request.getParameter("proIndiviso");

            propietario.setPorcentaje(porcentaje);
            propietario.setFecha_inicio(fecha_inicial);
           
            propietario.setFecha_final(fecha_final);
            propietario.setPorcentaje(porcentaje);
            propietario.setTipoPropiedad(tipoPropiedad);
            propietario.setProIndiviso(proIndiviso);
            Usuario usuario = (Usuario)session.getAttribute("usuario");
            propietario.setFk_usuario(usuario.getId_usuario());
            modelo.actualizarPropietario(propietario);
            modelo.getCon().commit();

                        %>
		    <script language="javascript" type="text/javascript">document.location.href = "verPropietarios.jsp?id=1";</script>
	<%
        }else{
        %>
		    <script>
        		alert("El propietario no existe, por favor Verifique... ");
		    </script>
    <%  }
	}catch(Exception ecx){
		modelo.getCon().rollback();
		ecx.printStackTrace();        %>
		<script language="javascript" type="text/javascript">
			alert("Propietario no pudo ser actualizado");
			document.location.href = "adicionarPropietario.jsp?id=1";
		</script>		
<%  }
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
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
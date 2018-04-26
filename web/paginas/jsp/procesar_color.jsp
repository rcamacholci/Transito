<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("adicionarColor.jsp")||((java.util.LinkedList)session.getAttribute("permisosU")).contains("editarColores.jsp")){
                        Model modelo= (Model)session.getAttribute("model");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Adicionar Color</title>
</head>

<body>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%


try{
    modelo.getCon().setAutoCommit(false);
    java.sql.Date  fecha_inicial = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_inicial")).getTime());

    int color=  Integer.parseInt(request.getParameter("color"));
    int secuencia=  Integer.parseInt(request.getParameter("secuencia"));
    String  gama =  request.getParameter("gama");

    java.sql.Date  fecha_final = null;
    if(request.getParameter("fecha_final")!=null){
            if(request.getParameter("fecha_final").trim().length()>0){
                    fecha_final = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_final")).getTime());
            }
    }
    long vehiculo = Long.parseLong(request.getParameter("vehiculo"));
    Historico_Color historico_color=new Historico_Color();

    historico_color.setFk_color(color);
    historico_color.setFk_vehiculo(vehiculo);
    historico_color.setSecuencia(secuencia);
    historico_color.setGama(gama);
    historico_color.setFecha_ini(fecha_inicial);
    Usuario usuario = (Usuario)session.getAttribute("usuario");
    historico_color.setFk_usuario(usuario.getId_usuario());
    if(fecha_final!=null){
         historico_color.setFecha_fin(fecha_final);
    }

    if(request.getParameter("id").equals("1")){
        modelo.finalizarColores(vehiculo, fecha_inicial,usuario.getId_usuario());
        modelo.adicionarHistoricoColor(historico_color);
        modelo.getCon().commit();
        %>
        <script language="javascript" type="text/javascript">
			alert("Color ingresado con exito");
        </script>
  <%  }else{
        long id=Long.parseLong(request.getParameter("idv"));
        historico_color.setId_historico(id);
        modelo.actualizarHistoricoColor(historico_color);
        modelo.getCon().commit();
        %>
            <script language="javascript" type="text/javascript">
			alert("Color actualizado con exito");
            </script>
        <% }
    %>
		    <script language="javascript" type="text/javascript">document.location.href = "verColor.jsp?id=1";</script>
	
		   
    <%  
	}catch(Exception ecx){
		modelo.getCon().rollback();
		ecx.printStackTrace();        %>
		<script language="javascript" type="text/javascript">
			alert("Color no pudo ser ingresado");
			document.location.href = "adicionarColor.jsp?id=1";
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
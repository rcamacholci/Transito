<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Adicionar Color</title>
</head>

<body>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%

Model modelo= (Model)session.getAttribute("model");
Usuario usuario = (Usuario)session.getAttribute("usuario");
long rangoS = 0;

try{
        if((request.getParameter("estado")!=null)&&(request.getParameter("idSustrato")!=null)&&(request.getParameter("observacion")!=null)&&(request.getParameter("rangoS")!=null)){
            modelo.getCon().setAutoCommit(false);
                rangoS = Long.parseLong(request.getParameter("rangoS"));
                long id_sustrato =  Integer.parseInt(request.getParameter("idSustrato"));
                int estado =   Integer.parseInt(request.getParameter("estado"));
                String observacion = request.getParameter("observacion");
                modelo.actualizarEstadoSustrato(estado, usuario.getId_usuario(), observacion,id_sustrato);
                modelo.getCon().commit(); %>
                 <script language="javascript" type="text/javascript">
			alert("Sustrato Actualizado con exito");
                 </script> 
      <%  }else{ %>
                <script language="javascript" type="text/javascript">
			alert("Sustrato no pudo ser actualizado");
                 </script>
                 
       <% } %>
     <script language="javascript" type="text/javascript">window.location.href="listar_sustratos.jsp?rangoS="+<%=rangoS%>+"&id=0&n=1";</script>


    <%
	}catch(Exception ecx){
		modelo.getCon().rollback();
		ecx.printStackTrace();        %>
		<script language="javascript" type="text/javascript">
			alert("Venal no puedo ser Actualizada");
			window.location.href="listar_sustratos.jsp?rangoS="+<%=rangoS%>+"&id=0&n=1";
		</script>
<%  }
%>
</body>
</html>

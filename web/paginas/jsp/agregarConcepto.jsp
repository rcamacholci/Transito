<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, modelo.Caja, modelo.Sede, modelo.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("adicionarBancos.jsp")){
                    modelo.Model modelo = (modelo.Model)session.getAttribute("model");
                    modelo.Sede sede = (modelo.Sede)session.getAttribute("sede");
                    modelo.getCon().setAutoCommit(false);
                    Concepto concepto = new Concepto();
                    Sede_concepto sede_concepto = new Sede_concepto();
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Adicionar Concepto</title>
</head>
<body>
<%
    if(request.getParameter("NombreConcepto")!=null && request.getParameter("clase")!=null){
        
        String nombre = request.getParameter("NombreConcepto");
        int tipo = 2;
        int clase = Integer.parseInt(request.getParameter("clase"));
        int prioridad = 1;
        java.sql.Date fecha_actual = new java.sql.Date(new java.util.Date().getTime());
        nombre = nombre.toUpperCase();
        
    try{
        if(nombre.length()>0){
            
            concepto.setNombre(nombre);
            concepto.setTipo(tipo);
            concepto.setClase(clase);
            concepto.setPrioridad(prioridad);
            System.out.println("ID CONCEPTO ="+concepto.getNombre());
            System.out.println("ID CONCEPTO ="+concepto.getTipo());
            System.out.println("ID CONCEPTO ="+concepto.getClase());
            System.out.println("ID CONCEPTO ="+concepto.getPrioridad());

            modelo.adicionarConcepto(concepto);
            long id_concepto = modelo.consultarConceptoAgregado();
            sede_concepto.setFk_sede(sede.getId_sede());
            sede_concepto.setFk_concepto(id_concepto);
            sede_concepto.setFecha_inicio(fecha_actual);
            modelo.adicionarSedeConcepto(sede_concepto);
            modelo.getCon().commit();

        %>
        <script>
            alert("El Concepto ha sido adicionado");
            window.parent.close();
        </script>
        <%
        }else{
        %>
            <script>
            alert("Error al adicionar concepto");
            window.parent.close();

            </script>
        <%
        }
        }catch(Exception ex){
        System.out.println("Error: "+ex);
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
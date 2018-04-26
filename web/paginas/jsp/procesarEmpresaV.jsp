<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelo.*"%>
<%

try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("adicionarEmpresaV.jsp")||((java.util.LinkedList)session.getAttribute("permisosU")).contains("editarCaracteristicas.jsp")){
                        Model modelo= (Model)session.getAttribute("model");
    try{
        modelo.getCon().setAutoCommit(false);
        String documento = request.getParameter("documento");
        long vehiculo = Long.parseLong(request.getParameter("vehiculo"));
        java.sql.Date  fecha_inicial = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_inicial")).getTime());
        java.sql.Date  fecha_final = null;
        if(request.getParameter("fecha_final")!=null){
                if(request.getParameter("fecha_final").trim().length()>0){
                        fecha_final = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_final")).getTime());
                }
        }
        if(!documento.equals("")&&documento!=null&&vehiculo!=0){
            Persona persona = modelo.consultarPersona(2, documento);
            Empresa_Vinculadora empresaV = new Empresa_Vinculadora();
            empresaV.setFecha_inicio(fecha_inicial);
            if(fecha_final!=null){
                empresaV.setFecha_fin(fecha_final);
            }
            empresaV.setFk_vehiculo(vehiculo);
            empresaV.setFk_persona(persona.getId_persona());

                if(request.getParameter("id").equals("1")){
                    modelo.adicionarEmpresaV(empresaV);
                    modelo.getCon().commit();
                }else{
                    if(request.getParameter("id").equals("2")){
                        long idEmpresa = Long.parseLong(request.getParameter("idEmpresa"));
                        empresaV.setId_empresa_vinculadora(idEmpresa);
                        modelo.actualizarEmpresaV(empresaV);
                        modelo.getCon().commit();
                    }
                } %>
                <script language="javascript" type="text/javascript">
                    alert("Empresa vinculadora Registrada con Exito");
                    document.location.href = "verEmpresaV.jsp?id=1";
                </script>
       <% }else{ %>
        <script language="javascript" type="text/javascript">
            alert("Empresa vinculadora no pudo ser Registrada");
            document.location.href = "verEmpresaV.jsp?id=1";
        </script>
     <% }
         %>

<%  }catch(Exception ecx){
        modelo.getCon().rollback();
        ecx.printStackTrace();        %>
        <script language="javascript" type="text/javascript">
			alert("Empresa vinculadora no pudo ser ingresada");
			document.location.href = "adicionarEmpresaV.jsp?id=1";
		</script>
<%  }
                         }else{ %>
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
        
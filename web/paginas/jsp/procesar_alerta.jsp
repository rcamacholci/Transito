

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelo.*"%>
<%

try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("adicionarAlerta.jsp")){
                        Model modelo= (Model)session.getAttribute("model");
    try{
        modelo.getCon().setAutoCommit(false);
        int  tipo        =       Integer.parseInt(request.getParameter("tipodocumento")) ;
        String documento    =     request.getParameter("documento");
        long vehiculo          = Long.parseLong(request.getParameter("vehiculo"));
        int tipoembargo   = Integer.parseInt(request.getParameter("tipoalerta"));
        int grado = Integer.parseInt(request.getParameter("grado"));
        java.sql.Date  fecha_inicio = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_inicio")).getTime());

       java.sql.Date  fecha_final = null;
           if(request.getParameter("fecha_fin")!=null){
               if(!request.getParameter("fecha_fin").equals(""))
                 fecha_final = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_fin")).getTime());
           }
        


        String observacion  =  request.getParameter("observacion");

        Alerta alerta = new Alerta();
        Persona persona = modelo.consultarPersona(tipo, documento);
        alerta.setFk_persona(persona.getId_persona());
        Usuario user = (Usuario)session.getAttribute("usuario");
        alerta.setUsuario(user.getId_usuario());
        alerta.setTipo(tipoembargo);
        alerta.setFecha_ini(fecha_inicio);
        if(fecha_final!=null)
            alerta.setFecha_fin(fecha_final);
        alerta.setObservaciones(observacion);
        alerta.setFk_vehiculo(vehiculo);
        alerta.setGrado(grado);
        modelo.adicionarAlerta(alerta);
        modelo.getCon().commit(); %>
        <script language="javascript" type="text/javascript">document.location.href = "verAlertas.jsp?id=1";</script>
<%  }catch(Exception ecx){
        modelo.getCon().rollback();
        ecx.printStackTrace();        %>
                <script language="javascript" type="text/javascript">alert("La alerta no pudo ser ingresado");document.location.href = "adicionarAlerta.jsp?id=1";</script>		
<%  } %>
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
      
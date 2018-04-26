

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="modelo.*"%>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("adicionarEmbargo.jsp")){
                        Model modelo= (Model)session.getAttribute("model");
    try{
        modelo.getCon().setAutoCommit(false);
        int  tipo         =       Integer.parseInt(request.getParameter("tipodocumento")) ;
        String documento    =     request.getParameter("documento");
        int departamento =     Integer.parseInt(request.getParameter("departamento"));
        int municipio    =     Integer.parseInt(request.getParameter("municipio"));
        long vehiculo          = Long.parseLong(request.getParameter("vehiculo"));
        long oficina          = Long.parseLong(request.getParameter("oficina"));
        int tipoembargo   = Integer.parseInt(request.getParameter("tipoembargo"));
        int proceso  =  Integer.parseInt(request.getParameter("proceso"));
        String numero_oficio = request.getParameter("numero_oficio");
        java.sql.Date  fecha_oficio = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_oficio")).getTime());   
        String observacion  =  request.getParameter("observacion");
        String demandante = request.getParameter("demandante");
        String numero_radicacion = request.getParameter("numero_radicacion");
       java.sql.Date fecha_radicacion = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_radicacion")).getTime());

        long consecutivo = (modelo.Ultimo_Embargo()+1);
        Embargo embargo =  new Embargo();
        Persona persona = modelo.consultarPersona(tipo, documento);
        embargo.setFk_persona(persona.getId_persona());
        Usuario user = (Usuario)session.getAttribute("usuario");
        embargo.setFk_usuario(user.getId_usuario());
        embargo.setProceso(proceso);
        embargo.setTipo(tipoembargo);
        embargo.setFecha_oficio(fecha_oficio);
        embargo.setOficio(numero_oficio);
        embargo.setObservaciones(observacion);
        embargo.setDemandante(demandante);
        embargo.setFecha_proceso(new java.sql.Timestamp(new java.util.Date().getTime()));
        embargo.setFk_oficina(oficina);
        embargo.setFk_vehiculo(vehiculo);
        Sede sede = (Sede)session.getAttribute("sede");
        embargo.setFk_sede(sede.getId_sede());
        Divipo div= modelo.consultarDvipo(departamento, municipio);
        embargo.setFk_divipo(div.getId_divipo());
        embargo.setNro_radicacion(numero_radicacion);
        embargo.setFecha_radicacion(fecha_radicacion);
        embargo.setId_embargo(consecutivo);
        modelo.adicionarEmbargo(embargo);
        modelo.actualizarOficioIdEmbargo(consecutivo,numero_oficio , fecha_oficio);
        modelo.getCon().commit(); %>
        <script language="javascript" type="text/javascript">document.location.href = "verEmbargos.jsp?id=1";</script>
<%  }catch(Exception ecx){
        modelo.getCon().rollback();
        ecx.printStackTrace();        %>
                <script language="javascript" type="text/javascript">alert("El embargo no pudo ser ingresado");document.location.href = "adicionarEmbargo.jsp?id=1";</script>		
<%  }%>
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
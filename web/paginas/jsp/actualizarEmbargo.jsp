<?xml version="1.0" encoding="UTF-8"?>
<%--
    Documento   : actualizar_embargo
    Creado      : 04-mar-2010, 16:39:17
    Autor       : Desarrollo
    Modificado  : Ricardo Cantillo C.
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/xml" pageEncoding="UTF-8" import="modelo.*,java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("editarEmbargo.jsp")){
%>



<root>
    <%
        Model modelo = (Model)session.getAttribute("model");
        Embargo embargo =(Embargo) session.getAttribute("embargo");
        Usuario usuario = (Usuario) session.getAttribute("usuario");


    if(embargo!=null){
        try{
            modelo.getCon().setAutoCommit(false);
            int  tipo = Integer.parseInt(request.getParameter("tipodocumento")) ;
            String documento = request.getParameter("documento");
            int departamento = Integer.parseInt(request.getParameter("departamento"));
            int municipio = Integer.parseInt(request.getParameter("municipio"));
            long oficina = Long.parseLong(request.getParameter("oficina"));
            int tipoembargo = Integer.parseInt(request.getParameter("tipoembargo"));
            int proceso = Integer.parseInt(request.getParameter("proceso"));
            String numero_oficio = request.getParameter("numero_oficio");
            java.sql.Date fecha_levantamiento = null;

            if(request.getParameter("fecha_oficio")!=null&&!request.getParameter("fecha_oficio").equals("")){
                java.sql.Date fecha_oficio = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_oficio")).getTime());
                embargo.setFecha_oficio(fecha_oficio);
            }
            String observacion = request.getParameter("observacion");
            String demandante = request.getParameter("demandante");

            String numero_levantamiento = request.getParameter("numero_levantamiento");

            if(request.getParameter("fecha_levantamiento")!=null&&!request.getParameter("fecha_levantamiento").equals("")){
                fecha_levantamiento = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_levantamiento")).getTime());
                embargo.setFecha_levantamiento(fecha_levantamiento);
            }

            String numero_radicacion = request.getParameter("numero_radicacion");

            if(request.getParameter("fecha_radicacion")!=null&&!request.getParameter("fecha_radicacion").equals("")){
               java.sql.Date fecha_radicacion = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_radicacion")).getTime());
               embargo.setFecha_radicacion(fecha_radicacion);
            }



            Persona persona = modelo.consultarPersona(tipo, documento);
            if(persona!=null)
                embargo.setFk_persona(persona.getId_persona());
            else embargo.setFk_persona(0);

            embargo.setProceso(proceso);
            embargo.setTipo(tipoembargo);

            embargo.setOficio(numero_oficio);
            embargo.setObservaciones(observacion);
            embargo.setFk_oficina(oficina);

            embargo.setNro_levantamiento(numero_levantamiento);
            embargo.setNro_radicacion(numero_radicacion);

            embargo.setDemandante(demandante);

            Sede sede = (Sede)session.getAttribute("sede");
            embargo.setFk_sede(sede.getId_sede());
            Divipo div= modelo.consultarDvipo(departamento, municipio);
            embargo.setFk_divipo(div.getId_divipo());
            embargo.setFk_usuario(usuario.getId_usuario());

            modelo.actualizarEmbargo(embargo);
            modelo.actualizarOficioIdEmbargo(embargo.getId_embargo(), numero_levantamiento, fecha_levantamiento);
            modelo.getCon().commit();

        %>
            <script language="javascript" type="text/javascript">
                 alert("Embargo actualizado con exito");
            </script>
<%


            %>


            <%
             %><result>si</result><%
        }catch(Exception e){
             modelo.getCon().rollback();
            %>
            <result>no</result>
            <error><%=e.toString()%></error>
            <%

        }
    %>



    <%}else{%>
    <result>no</result>
    <error>Embargo NULO</error>
    <%}%>


</root>
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
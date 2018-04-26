<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Untitled Document</title>
</head>

<body>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%

Model modelo= (Model)session.getAttribute("model");
modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
String mensaje ="";
long numero_interno = 0;
try{
    modelo.getCon().setAutoCommit(false);
    Solicitud_Oficios solicitudO = new Solicitud_Oficios();
    String numOficio = "",municipio = "";
    java.sql.Date fechaO, fechaR;
    String solicitante = "",cargo = "",direccion = "", referencia = "",numRadicacion = "", entidad = "";
    java.sql.Timestamp fechaSystem= new java.sql.Timestamp(new java.util.Date().getTime());

        if((request.getParameter("numOficio")!=null)&&(request.getParameter("fechaO")!=null)){
            numOficio =  request.getParameter("numOficio");
            solicitudO.setNum_oficio(numOficio);

            fechaO = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaO")).getTime());
            solicitudO.setFecha_oficio(fechaO);

            if(request.getParameter("municipio")!=null){
                municipio = request.getParameter("municipio");
                solicitudO.setMunicipio(municipio);
            }

            if(request.getParameter("entidad")!=null){
                entidad = request.getParameter("entidad");
                solicitudO.setEntidad(entidad);
            }

            solicitudO.setEstado(1);
            solicitudO.setFecha_proceso(fechaSystem);
            solicitudO.setFk_usuario(usuario.getId_usuario());

            if(request.getParameter("solicitante")!=null){
                solicitante = request.getParameter("solicitante");
                solicitudO.setSolicitante(solicitante);
            }

            if(request.getParameter("cargo")!=null){
                cargo = request.getParameter("cargo");
                solicitudO.setCargo(cargo);
            }
            
             if(request.getParameter("direccion")!=null){
                direccion = request.getParameter("direccion");
                solicitudO.setDireccion(direccion);
            }
            
             if(request.getParameter("referencia")!=null){
                referencia = request.getParameter("referencia");
                solicitudO.setReferencia(referencia);
            }
            if(request.getParameter("numRadicacion")!=null){
                numRadicacion = request.getParameter("numRadicacion");
                solicitudO.setNum_radicacion(numRadicacion);
            }

            if(request.getParameter("fechaR")!=null){
                fechaR = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaR")).getTime());
                solicitudO.setFecha_radicacion(fechaR);
            }
            numero_interno = (modelo.UltimaSolicitudOficio()+1);
            if(numero_interno!=0){
                solicitudO.setNumero_interno(numero_interno);
                modelo.adicionarSolicitudOficio(solicitudO);
                mensaje = "1";
                modelo.getCon().commit();
            }
            
           
    }else{
           mensaje= "SOlicitud de Oficio No pudo ser Ingresada";
    }
%>


    <%
	}catch(Exception ecx){
		modelo.getCon().rollback();
		ecx.printStackTrace();        %>
		<script language="javascript" type="text/javascript">
			alert("Solicitud No pudo Ser Realizada");
			document.location.href = "RegistrarSolicitudOficios.jsp";
		</script>
<%  }

    if(mensaje.equals("1")){
        %>
        <script language="javascript" type="text/javascript">
            alert("Mensaje : Solicitud Realizada con Exito");
            document.location.href = "RadicacionSolicitudesOficios.jsp?numero_interno="+(<%=numero_interno%>);
	</script>
   <% }else{
     %>
        <script language="javascript" type="text/javascript">
            alert("Mensaje : <%=mensaje%>");
            document.location.href = "RegistrarSolicitudOficios.jsp";
	</script>
   <%

        }


%>


</body>
</html>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
                        Model modelo= (Model)session.getAttribute("model");
                        modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                    
%>
      
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Procesar Cupo</title>
</head>

<body>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%

    Resolucion_Cupo resolucionC = new Resolucion_Cupo();
   	String mensaje = "";

   	
       try{             
          java.sql.Date fecha = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha")).getTime());
          resolucionC.setFECHA(fecha);
          if(request.getParameter("mt")!=null){
          	String mt = request.getParameter("mt");
          	resolucionC.setMT(mt);
          }
          
          if(request.getParameter("consecutivo")!=null){
          	String consecutivo = request.getParameter("consecutivo");
          	resolucionC.setCONSECUTIVO(consecutivo);
          }
          
           	String resolucion = request.getParameter("resolucion");
          	resolucionC.setRESOLUCION(resolucion);
          
          if(request.getParameter("tipoDocumento")!=null&&request.getParameter("numeroSolicitante")!=null){
          	int tipoDoc = Integer.parseInt(request.getParameter("tipoDocumento"));
          	String numero = request.getParameter("numeroSolicitante");
          	Persona persona = modelo.consultarPersona(tipoDoc,numero);
          	resolucionC.setSOLICITANTE(persona.getId_persona());
          }
          
          if(request.getParameter("tipoDocumentos2")!=null&&request.getParameter("numeroAseguradora")!=null){
          	int tipoDoc2 = Integer.parseInt(request.getParameter("tipoDocumentos2"));
          	String numeroA = request.getParameter("numeroAseguradora");
          	Persona aseguradora = modelo.consultarPersona(tipoDoc2,numeroA);
          	resolucionC.setASEGURADORA(aseguradora.getId_persona());
          }
          
          if(request.getParameter("poliza")!=null){
          	String poliza = request.getParameter("poliza");
          	resolucionC.setNUMERO_POLIZA(poliza);
          }
          
          if(request.getParameter("clase")!=null){
          	String clase = request.getParameter("clase");
          	resolucionC.setCLASE(clase);
          }
          if(!request.getParameter("modelo").isEmpty()){
             long mod = Long.parseLong(request.getParameter("modelo"));
                   resolucionC.setMODELO(mod);
          }
          if(!request.getParameter("motor").isEmpty()){
              resolucionC.setMOTOR(request.getParameter("motor"));
          }
          
          if(!request.getParameter("chasis").isEmpty()){
              resolucionC.setCHASIS(request.getParameter("chasis"));
          }
          
          if(!request.getParameter("serie").isEmpty()&& request.getParameter("serie")!=null){
              resolucionC.setSERIE(request.getParameter("serie"));
          }
          
          if(!request.getParameter("observacion").isEmpty()&& request.getParameter("observacion")!=null){
              resolucionC.setOBSERVACION(request.getParameter("observacion"));
          }
                      
          if(!request.getParameter("lineas").isEmpty()){
              resolucionC.setFK_LINEA(Long.parseLong(request.getParameter("lineas")));
          }
          
          if(!request.getParameter("servicios").isEmpty()){
             int servicio = Integer.parseInt(request.getParameter("servicios"));
                   resolucionC.setSERVICIO(servicio);
          }
          if(!request.getParameter("pbv").isEmpty()){
             long pbv = Long.parseLong(request.getParameter("pbv"));
                   resolucionC.setPBV(pbv);
          }
          
          resolucionC.setFK_USUARIO(usuario.getId_usuario());
          resolucionC.setESTADO(1);
          resolucionC.setFECHA_REGISTRO(new java.sql.Timestamp(new java.util.Date().getTime()));
		  modelo.registrarResolucionCupo(resolucionC);
		  modelo.getCon().commit();
		  mensaje = "Resolucion de Cupo Registrada con Exito";
		
               
	}catch(Exception ecx){		
		modelo.getCon().rollback();
		ecx.printStackTrace(); 
		mensaje =""+ecx.getMessage();
	
      } 
	  
	  if(!mensaje.equals("")){ %>
	  	   <script language='javascript' type='text/javascript'>
             alert('<%=mensaje%>');
      	   </script>
		<% } %>
    
</body>
</html>

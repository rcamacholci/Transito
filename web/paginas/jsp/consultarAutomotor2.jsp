}<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
            Model modelo= (Model)session.getAttribute("model");
            modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
            
 %>

      
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>####</title>
</head>

<body>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%

    Acta_Importacion actaImportacion = new Acta_Importacion();
   String pais = "999";
   String mensaje = "jeje";
   int sw=0;
       try{              
               java.sql.Date fechaL = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaLevantamiento")).getTime());
               actaImportacion.setFecha_levante(fechaL);
               java.sql.Date fechaM = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaManifiesto")).getTime());
               actaImportacion.setFecha_manifiesto(fechaM);
               String numero_PersonaImport = request.getParameter("numeroImportador");
               Persona persona = modelo.consultarPersona(2, numero_PersonaImport);
               actaImportacion.setFk_persona_importador(persona.getId_persona());
               String tipoDoc_PersonaImport = "N";
               String Num_Manifiesto =  request.getParameter("numeroManifiesto");
               actaImportacion.setNumeroManifiesto(Num_Manifiesto);
               String Num_Levante = request.getParameter("numeroLevante");
               actaImportacion.setNumeroLevante(Num_Levante);
               if(!request.getParameter("pais").isEmpty()){
                    pais =  (request.getParameter("pais"));
                    actaImportacion.setPaisOrigen(pais);
               }               
               String tipo_Registro = request.getParameter("tipoRegistro");
               actaImportacion.setTipoRegistro(tipo_Registro);
               String municipio = request.getParameter("municipio");
               actaImportacion.setFk_divipo(Long.parseLong(municipio));
               com.heinsohn.runt.general.registroinformacion.InformacionVehiculoActaImportacionDTO info_Vehiculo = new  com.heinsohn.runt.general.registroinformacion.InformacionVehiculoActaImportacionDTO();
               double capacidad = 0;
               

               
               if(!request.getParameter("capacidadCarga").isEmpty() && request.getParameter("capacidadCarga")!=null){
                    info_Vehiculo.setCapacidadCarga(Double.parseDouble(request.getParameter("capacidadCarga"))); 
               }else{
                    info_Vehiculo.setCapacidadCarga(capacidad); 
               }

               if(!request.getParameter("cilindraje").isEmpty() && request.getParameter("cilindraje")!=null){
                    info_Vehiculo.setCilindraje(request.getParameter("cilindraje"));
                    actaImportacion.setCilindraje(request.getParameter("cilindraje"));
               }
             if(!request.getParameter("clases").isEmpty()){
                    info_Vehiculo.setIdClaseVehiculo( request.getParameter("clases"));
                    actaImportacion.setClase(request.getParameter("clases"));
             }
             if(!request.getParameter("lineas").isEmpty()){
                    info_Vehiculo.setIdLinea(request.getParameter("lineas"));
                    actaImportacion.setFk_linea(Long.parseLong(request.getParameter("lineas")));
             }
             if(!request.getParameter("marcas").isEmpty()){
                    info_Vehiculo.setIdMarca(request.getParameter("marcas"));
                    actaImportacion.setFk_marca(Long.parseLong(request.getParameter("marcas")));
             }
             if(!request.getParameter("carrocerias").isEmpty()){
                    info_Vehiculo.setIdTipoCarroceria( request.getParameter("carrocerias"));
                    actaImportacion.setCarroceria(request.getParameter("carrocerias"));
             }
             if(!request.getParameter("combustibles").isEmpty()){
                    info_Vehiculo.setIdTipoCombustible( request.getParameter("combustibles"));
                    actaImportacion.setCombustible(request.getParameter("combustibles"));
             }
             if(!request.getParameter("modelo").isEmpty()){
                    info_Vehiculo.setModelo(request.getParameter("modelo"));
                    actaImportacion.setModelo(request.getParameter("modelo"));
             }
             if(!request.getParameter("chasis").isEmpty()){
                    info_Vehiculo.setNumeroChasis(request.getParameter("chasis"));
                    actaImportacion.setChasis(request.getParameter("chasis"));
             }
             if(!request.getParameter("ejes").isEmpty()&& request.getParameter("ejes")!=null){
                    info_Vehiculo.setNumeroEjes(Integer.parseInt(request.getParameter("ejes")));
                    actaImportacion.setEjes(request.getParameter("ejes"));
             }
             if(!request.getParameter("fichaHomologacion").isEmpty()){
                    info_Vehiculo.setNumeroFichaHomologacion( request.getParameter("fichaHomologacion"));
                    actaImportacion.setFichaHomologacion(request.getParameter("fichaHomologacion"));
             }
             if(!request.getParameter("motor").isEmpty()){
                 if(!request.getParameter("motor").equals("-")){
                    info_Vehiculo.setNumeroMotor( request.getParameter("motor"));
                    actaImportacion.setMotor(request.getParameter("motor"));
                    }
             }
             if(!request.getParameter("pasajeros").isEmpty()){
                    info_Vehiculo.setNumeroPasajerosSentados(Integer.parseInt(request.getParameter("pasajeros")));
                    actaImportacion.setPasajeros(Integer.parseInt(request.getParameter("pasajeros")));
             }
             if(!request.getParameter("puertas").isEmpty()){
                    info_Vehiculo.setNumeroPuertas(Integer.parseInt(request.getParameter("puertas")));
                    actaImportacion.setPuertas(Integer.parseInt(request.getParameter("puertas")));
             }
             if(!request.getParameter("serie").isEmpty()&& request.getParameter("serie")!=null){
                    info_Vehiculo.setNumeroSerie(request.getParameter("serie"));
                    actaImportacion.setSerie(request.getParameter("serie"));
              }
             if(!request.getParameter("pesoBruto").isEmpty()){
                    info_Vehiculo.setPesoBrutoVehicular(Double.parseDouble(request.getParameter("pesoBruto")));
                    actaImportacion.setPesoBruto(request.getParameter("pesoBruto"));
             }
             if(!request.getParameter("tipoAutomotor").isEmpty()){
                    info_Vehiculo.setTipoAutomotor(request.getParameter("tipoAutomotor"));
                    actaImportacion.setTipoAutomotor(request.getParameter("tipoAutomotor"));
             }
             if(!request.getParameter("vin").isEmpty()&& request.getParameter("vin")!=null){
                    info_Vehiculo.setVin(request.getParameter("vin"));
                    actaImportacion.setVin(request.getParameter("vin"));
              }
             if(!request.getParameter("origenVehiculo").isEmpty()){
                    info_Vehiculo.setOrigenVehiculo(request.getParameter("origenVehiculo"));
                    
                    actaImportacion.setOrigen(request.getParameter("origenVehiculo"));
                }



               
               actaImportacion.setFk_usuario(usuario.getId_usuario());
               actaImportacion.setFecha_reg(new java.sql.Timestamp(new java.util.Date().getTime()));
               
               webservices.registrar.RegistrarInformacionServiceClient registrarServices = new webservices.registrar.RegistrarInformacionServiceClient();
               registrarServices.setUser("");
               String us = "";
               String pss = "";
               String ok = "";
               modelo.Persona per = modelo.consultarPersona(1, us);
               modelo.Usuario user = modelo.consultarPerfilByPersona(per.getId_persona());
               modelo.UsuarioRunt userR = modelo.consultarUsuarioRunt(user.getId_usuario());
               
               registrarServices.setTokenHuellaDigital(ok);
       

       //       registrarServices.setUser("32636517");
         //     String us = "32636517";
           //   String pss = "diego1234";

         

        //      registrarServices.setUser("22638261");
          //   String us = "22638261";
      //  String pss = "Brasilmundial2014";

        //         registrarServices.setUser("8631168");
          //       String us = "8631168";
            //     String pss = "maira960";
                 
                 




                //System.out.println("ok ok ok ok ok ok ok ok ok ok ok o ko ko ko k ok o");
               com.heinsohn.runt.general.identificaciones.StatusDTO status = registrarServices.registrarActadeImportacionDetalleVehiculo(fechaL, fechaM, numero_PersonaImport, tipoDoc_PersonaImport, Num_Manifiesto, Num_Levante, pais, tipo_Registro,info_Vehiculo,us,pss);
               System.out.println(" hehehehehehehehehehehehehehehehehehe ehehe ehe ehe he he");
               if(status!=null){
                   System.out.println("status : "+status.getStatusDesc());
                    if(status.getStatusCode().equals("1")){
                        modelo.getCon().commit();
                        sw=1;                                  %>
                            <script language="javascript" type="text/javascript">
                            alert("Ok...");
                            window.parent.document.location.href = "consultarAutomotor.jsp?";
                            </script>
                  <%  }else{ 
				  		sw=0;
                        mensaje = "Error :"+status.getStatusDesc();
                    }
               }else{
               mensaje = "Servicio Null";


               }
	}catch(Exception ecx){		
		modelo.getCon().rollback();
		ecx.printStackTrace(); 
		mensaje =""+ecx.getMessage();
	
      } 
	  
	  if(sw!=1){ %>
	  	   <script language='javascript' type='text/javascript'>
             alert('<%=mensaje%>');
      	   </script>
		<% 
		sw=0;
		   } %>
    
</body>
</html>
<% 	}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		//if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("registrarActaImportacion.jsp")){
                        Model modelo= (Model)session.getAttribute("model");
                        modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");


                    %>



<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Procesar Importacion</title>
</head>

<body>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%



   String mensaje = "";
   int sw=0;
//ss008515
//           ss009407
   //ss009477
//ss008515


       try{
              com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO info_Vehiculo = new  com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO();


               java.sql.Date fechaL = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse("29/09/2011").getTime());


               java.sql.Date fechaM = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse("29/09/2011").getTime());

               java.sql.Date fechaR = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse("29/09/2011").getTime());

               String numero_PersonaImport = "800197268";
               String tipoDoc_PersonaImport = "N";
               String Num_Manifiesto =  null;
               String Num_Levante = null;
             //  String Num_Manifiesto =  "482014000282361";
              // String Num_Levante = "482014000217929";

 int capacidad = 0;
 info_Vehiculo.setNumeroVIN("9F5A15038AYC09812P");
 info_Vehiculo.setNumeroSerie("9812");
 int modeloV = 2015;
 int marca = 27;
 int lineaV = 0;
 int clase = 41;
 int ejes = 3;
 int llantas = 12;
 String carroceria = "0";
 String condicionM = "NORMAL";
 String origenV = "N";
 String fichaT = "SS1149";
 String certificadoR = "S00000744";


               webservices.registrar.RegistrarInformacionServiceClient registrarServices = new webservices.registrar.RegistrarInformacionServiceClient();

         //      registrarServices.setTokenHuellaDigital("");
          //     registrarServices.setUser(userRunt.getCodigo());

         //       if(session.getAttribute("token2")!=null){
         //           registrarServices.setTokenHuellaDigital(session.getAttribute("token2").toString());
          //          System.out.println("token importacion :"+session.getAttribute("token2").toString());
          //      }


                registrarServices.setUser("");
                String us = "";
                modelo.Persona per = modelo.consultarPersona(1, us);
                modelo.Usuario user = modelo.consultarPerfilByPersona(per.getId_persona());
                modelo.UsuarioRunt userR = modelo.consultarUsuarioRunt(user.getId_usuario());
               String pss = "";

               String linea ;
               String ok = "";
               
               //ok = "";
               registrarServices.setTokenHuellaDigital(ok);


            //     registrarServices.setUser("8631168");
             //    String us = "8631168";
              //   String pss = "vilma956";




               //Model.userHandler = userRunt.getCodigo();
               //Model.passUserHandler = userRunt.getPassword();



                 com.heinsohn.runt.general.identificaciones.StatusDTO status = registrarServices.registrarCertificadoRegistroRNRYS(fechaL, fechaM, numero_PersonaImport, tipoDoc_PersonaImport, Num_Manifiesto, Num_Levante, info_Vehiculo, modeloV, marca, lineaV, clase, ejes, llantas, carroceria, condicionM, origenV, fichaT,capacidad,certificadoR,fechaR,us, pss);
               if(status!=null){
                    if(status.getStatusCode().equals("1")){
                        //modelo.registrarActaImportacion(actaImportacion);
                      modelo.getCon().commit();
                                    sw=1;

%>
		 					<script language="javascript" type="text/javascript">
							alert("Acta de Importacion Registrada");
							window.parent.document.location.href = "registrarActaImportacion.jsp?";
							</script>
                  <%  }else{
				  		sw=0;
                        mensaje = "Error :"+status.getStatusDesc();
                        System.out.println("error : "+status.getStatusDesc());
                    }
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
<%
}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
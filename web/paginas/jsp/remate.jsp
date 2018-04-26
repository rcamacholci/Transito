<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
            Model modelo= (Model)session.getAttribute("model");
            modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
            modelo.UsuarioRunt userRunt = modelo.consultarUsuarioRunt(usuario.getId_usuario());

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

  
   String mensaje = "jeje";
   int sw=0;
       try{
               java.sql.Date fechaAdj = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse("02/07/2013").getTime());

               java.sql.Date fechaEnt = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse("05/07/2013").getTime());
               
               com.heinsohn.runt.general.personas.PersonaDTO  adjundicador = new com.heinsohn.runt.general.personas.PersonaDTO();
               com.heinsohn.runt.general.personas.PersonaDTO  nuevoProp = new com.heinsohn.runt.general.personas.PersonaDTO();
               com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO automotor = new com.heinsohn.runt.general.identificaciones.IdentificacionAutomotorDTO();
               
               automotor.setNumeroChasis("1HD1HAZ192K808383");
               automotor.setNumeroMotor("HAZ2808383");
               automotor.setNumeroSerie("1HD1HAZ192K808383");
               automotor.setNumeroVIN("1HD1HAZ192K808383");
               automotor.setNumeroPlaca("AKX97");



               adjundicador.setTipoDocumento("N");
               adjundicador.setNumeroDocumento("899999095");
               adjundicador.setNombreORazonSocial("DIAN"); 

               nuevoProp.setTipoDocumento("C");
               nuevoProp.setNumeroDocumento("31855019");
               nuevoProp.setNombreORazonSocial("MARIA APARICIO");

               String numeroActa = "21051329";
               String numeroLote = "170580";

               String marca = "60"; 
               String lineaV = "9836";
               String modeloV = "2002";
               String claseV = "10";
               String color = "28";
               String cilindraje = "1130";
               String unidadCilindraje = "1";
               String carroceria = "0";
               String combustible = "1";
               int pasajeros = 2;
               int puertas = 0;
               double valorAdjudicado = 870000;
               String medidaCarga = "1";
               double capacidadCarga = 0;


               webservices.registrar.RegistrarInformacionServiceClient registrarServices = new webservices.registrar.RegistrarInformacionServiceClient();

         //      java.io.FileInputStream fs = new java.io.FileInputStream("C:/app/in2.txt");
          //     java.io.DataInputStream en = new java.io.DataInputStream(fs);
          //     java.io.BufferedReader bf = new java.io.BufferedReader(new java.io.InputStreamReader(en));

            //   String linea;
            //   String ok = "";
            //   while((linea = bf.readLine())!= null){
             //   ok = linea;
             //  }
               registrarServices.setTokenHuellaDigital("");
               registrarServices.setUser(userRunt.getCodigo());
               
              // registrarServices.setTokenHuellaDigital("PGpIbUIydHNGTXdYWjJnRmd3MUY1M2tyUnZyZ003STNTeTlyUVJhRmJnZUJMSXE0T3hPaWNINTZUa1lhZTRSUkwrRkxkaUY3KzZ6NlNZS05KY0lPSmJOcHE1a1lYYzdFVEVhZjhGbGpoVWl2TWE0WlcxQkU0dWxOVWl1dFJsNWh6ZndlRXV5S2RPVUlheGllNmFDN01SZDloVUd3NXpXMS9WcHJiTXg0eThkWHZoSEJsSjU3RUtkdy93OXVidVorWU14UWsrMTVDcFpSczdRMkhDK3FkdDZoRlFJMjVqODFYblQreFpkanowM0JwMXU4L1ZCbklKZzQybFNKUEoxeDFrUmk2ZHdBdk1sTmdscUtXV1Z5NFB6MEQzZXY5V0VkVVBzMERsZUdLMjdPaVBOZ29pSXc4ZWJ3M1BJQUdVcU5PTlg0UDBCZkNaVEFJanBzMXVPRnRCSjlGYnJWaHFRYkhXOHJTMmpxTzhBdnFvQTkyM1pwMnJhRC9GVXNMdUJoS3FJemNHWS9ibmNxRHk4VVVjOFZ3cm1McjZBTGNRTG9TdVRDZ2dxOWFKc1c4V3VvOFBlV0RoRnB5cTJ4RmZONG5EVU9ZSmFtNXhXQldDNzBXaU4rNUNNNFRhMHNXSzBjYUY0MFd5ZXk5a1lRUlVUMXo2MnIzN0NiamRsbTNibUJ1ZnFaNkttalptQVZQM2FjVTdPbDhrTTVMd24rRXh5NGRLM2NzMWQvcEoyY3RVTVY4REtDajV6U2lYWmZnYVc5MVoxMXNwR1ZJbW5adXJsVWR6YkVSSjRqZ2VYUUZYZXcvR3o5bWZJMjF0djVZRi9nODlxN3UySmxRcUlhdW5sNFdlRTF2V2RFM0tiVHVod1FvOUp0RWZ0d1BDaVdyWVBvMFplWE9tZzVkU0l2d1N2cGxKc1ZEV2tKQ21KemhSOWFaVGZxeHg2eFY1OUx5MGt0S3R2Tkh4WG9vSXEveEtGd3lqNVpjT29ncE5hdkFKdHNCQ3lNRTIxMkg3M1JvcU5mektSdVlKcXZzRFlxeXg1d0dQbEllQzFPVFkwQW5rRWZvMlNOYzIrNXdkVzJzeWtwZmxxOVIwR0tiNzMzSmk3WGdzTW01RnpHRk1uVXNrYVFRSXJra29sRmFxTjNZaWs3ZlhwenVGQThubi9RbWJqVGdiSTJnMEx1RkxPSm9BeTN6ZjI3ZndXdk1uSVJ0NFc3cDVHR0FtYXdEMjRsTG1wMk10SFBJZDMxa3JkVnNZMHlCSG9OZ0NLOHlvR2ZIZnlsRnNHU05aRWc4QjFPcytzSnpwTDdhYjdFOVVsN0o3QnhjQmJCelVoanhkbTc3OEhmbzNVNUV6eU1oTkJvY1hCUlllVEVkaHZsejNVYTNhL2hud0tGRVUwd0NhZFJtaUxQWmlQN1VGR0pzQ2lCV0xubWJSVzRnaUxDTnNWdmd5NndMOHY4OFlVdzJ6cmFUQlRGZjFnVS9OSjNvK0llU1UzM1hJcmo4cTBQRzM4ZE91T3lHcWlXZWRtdlpqdWRiWjVYMjNMZXYxTU9OZGNRc002NnpwOFh4SEwrNUY4N1ZDUzBtZ1dPU1lyaDZnMFpZbGE5VkdXVzhxZVlma1RPR1drbXIxUHhPYWN0dHZVRDE0cjE3eERRZURDcUU3ZHk0VnNIaHIyMk03dis0SWc3K3pEamV2eHAxUnM4M05reTQ5dld0TU1JSXVORkhCUE5BUUpuVXJydjF4SXIwc1I3MnhOQmhZRU9QNWc2N0VtZVYzL2xXOXROWjE2VzlXZVc4NWpINitOT1B3T09UV1paWVJPcmJsb3VqL3NJenhHaTdDNldsNC9vK0RHd3NtaElOQmo4ZmJFQXZQaHdiNzRYMnNEdmhiYmprVkZVdEtiRERzWDE2dVErKzVOUUtHQWcwYkVycXU4Q05ZYVBwekFXQWNXckoyeFVHSGt6VmIzT0NGQjY1Unl0MHBUZ0dOclg2dkZydjVVS2h1NW1yNFVqbS91L2ZwQjU5eTRtZ3ZkbkQrUkpHcGY1MWtRbWpBdlNBQzFnUHJ0UUt5dDUrY3R4MytiNld2TkVDbGVwc3g0cTFZQ1FWbzZ0ZkQ2dDNpZXZYdlV5VDRsRDIyblB1WTZ2cVI0T21kc1VYTFR6eGNDTHlDdEZOTk50ekcyNkZWOW9lSUdiMGhtMmM4SzR0bEdZaFN4TVlsdmZLTzRVcytJMWVEQXY0SjRaaStqbERPSnRpS1ZVTU9kM09sRTJ0Y3hrZEhIREp5NWJHbU1obytVaVM2aVNMMUFpa0NsQ3ZVSlkrQjRPdm92WEpOUkJicDRJRzEwWFFyVURxa1N0c0duV3pPUER0bHA0bkg1cnZabURDTXhHMlJqbDJIcHJiTlZ0d1VMc2N5MTIxZVpmbGRiTjE0Sjk1MjJjZDNlNlBvSzNya2lsa3k1SWZqNDhpdE5MalM0cFV6USs0U3h0L0JWMnU1Yms2U2pWTHRoM3FaRVdUYnRMUFRTUy9YajlsVFJQSmxJTjhYRTcwSWRJbVRWNFQwWEpFWlRCTDUwbVJUN1VKc0dPRUVqQUhZMm95UDVVYStiYTZqZml4Yzh0SnArSnBxMWY2NXFseDBqTVZ1Wm89Pjx1OHhHVmJYNUZnVU1uOTB5aW1EK29PTkVoT3lpYXJrYUplSWduVWNyUXJXTHZ2aFRwR1JuTmNwZld0NGM4NWZwNGgrU3kwUVlpb083RWdzM0YxcWs0UjdwZEwzUFJyY2k5c00rZEkwRHltTm9Ka1VZeGhoSk1YOUc0YmpIUklqeVlua2ZENHFFQVJidTl4Ymg0NVhaVzlFcnpTaGluSEswQjdLVXM0Qlcwczh3bHFPUldkOEZMdHVyZytFNURDNUxZOFM0dHl3M3JzbklTU3RPWWNQcWJQK3dWaWxnaHRBYWJobmtDMk1tSTB2K3Q5alIwSmZETjFaOGxESG4vWDd0cVU5aTk3eFlsNUUrWGFRaHJnZ1ZRUWk0clA2S0dpNHJIMmczT3FBUkR0M0x6YXlGaE14TjBGR0VnSUtaWjQwVWNQamFWZnQ2TkQrS01NbUlCTEM1MWc9PT4=");
                
               if(session.getAttribute("token2")!=null){
                    registrarServices.setTokenHuellaDigital(session.getAttribute("token2").toString());
                    System.out.println("token importacion :"+session.getAttribute("token2").toString());
                }

      //         registrarServices.setUser("22432963");
        //        String us = "22432963";
          //      String pss = "saudy124";



               //    registrarServices.setUser("1045675127");
               //    String usu = "1045675127";
                //   String pas = "morro10012009";

                //System.out.println("ok ok ok ok ok ok ok ok ok ok ok o ko ko ko k ok o");
               com.heinsohn.runt.general.identificaciones.StatusDTO status = registrarServices.registrarActadeRemateAdjudicacion(automotor, adjundicador, nuevoProp, numeroActa, fechaAdj, fechaEnt, numeroLote, marca, lineaV, modeloV, claseV, color, cilindraje, unidadCilindraje, carroceria, combustible, pasajeros, puertas, valorAdjudicado,capacidadCarga, medidaCarga, userRunt.getCodigo(), userRunt.getPassword());
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
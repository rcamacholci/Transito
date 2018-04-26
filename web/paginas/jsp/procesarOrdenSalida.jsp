<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%

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
   int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
   String mensaje = "";
   int sw=0;
   COMPARENDO_PATIO comparendoP = new COMPARENDO_PATIO();
       try{
           String numero_salida = request.getParameter("salida");
           if(!numero_salida.equals("")&&!numero_salida.equals(null)){
               comparendoP.setNUMERO_SALIDA(numero_salida);
               comparendoP.setESTADO(2);
               comparendoP.setFECHA_SALIDA(new java.sql.Date(new java.util.Date().getTime()));
               comparendoP.setFK_USUARIO(usuario.getId_usuario());
               
               String comparendo = request.getParameter("comparendo");
               if(!comparendo.equals("")&&!comparendo.equals(null)){
                    Comparendo comp = modelo.consultar_Comparendo(comparendo);
                    if(comp!=null){
                     comparendoP.setFK_COMPARENDO(comp.getId_comparendo());
                    }
               }

               String placa = request.getParameter("placa");
               if(!placa.equals("")&&!placa.equals(null)){
                    comparendoP.setPLACA(placa);
               }
               
               String clase = request.getParameter("clase");
               if(!clase.equals("")&&!clase.equals(null)){
                    comparendoP.setCLASE(clase);
               }

               String servicio = request.getParameter("servicio");
               if(!servicio.equals("")&&!servicio.equals(null)){
                    comparendoP.setSERVICIO(servicio);
               }

               String marca = request.getParameter("marca");
               if(!marca.equals("")&&!marca.equals(null)){
                    comparendoP.setMARCA(marca);
               }

               String linea = request.getParameter("linea");
               if(!linea.equals("")&&!linea.equals(null)){
                    comparendoP.setLINEA(linea);
               }

               String motor = request.getParameter("motor");
               if(!motor.equals("")&&!motor.equals(null)){
                    comparendoP.setMOTOR(motor);
               }

               String chasis = request.getParameter("chasis");
               if(!chasis.equals("")&&!chasis.equals(null)){
                    comparendoP.setCHASIS(chasis);
               }

               String Modelo = request.getParameter("modelo");
               if(!Modelo.equals("")&&!Modelo.equals(null)){
                    comparendoP.setMODELO(Modelo);
               }

               String color = request.getParameter("color");
               if(!color.equals("")&&!color.equals(null)){
                    comparendoP.setCOLOR(color);
               }

               String cedPropietario = request.getParameter("cedPropietario");
               if(!cedPropietario.equals("")&&!cedPropietario.equals(null)){
                    comparendoP.setCED_PROPIETARIO(cedPropietario);
               }

               String nombrePropietario = request.getParameter("nombrePropietario");
               if(!nombrePropietario.equals("")&&!nombrePropietario.equals(null)){
                    comparendoP.setNOMBRE_PROPIETARIO(nombrePropietario);
               }

               String cedAutorizado = request.getParameter("cedAutorizado");
               if(!cedAutorizado.equals("")&&!cedAutorizado.equals(null)){
                    comparendoP.setCED_AUTORIZADO(cedAutorizado);
               }

               String nombreAutorizado = request.getParameter("nombreAutorizado");
               if(!nombreAutorizado.equals("")&&!nombreAutorizado.equals(null)){
                    comparendoP.setNOMBRE_AUTORIZADO(nombreAutorizado);
               }

                String observacion = request.getParameter("observacion");
               if(!observacion.equals("")&&!observacion.equals(null)){
                    comparendoP.setOBSERVACION(observacion);
               }
                modelo.actualizarComparendoPatio(comparendoP);
                modelo.actualizarConsecutivo(234, 15, vigencia);
                modelo.getCon().commit();
                sw=1;
%>
            <script language="javascript" type="text/javascript">
                alert("Orden de salida registrada con exito");
                window.parent.document.location.href = "OrdenSalida.jsp?";
            </script>
<%
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

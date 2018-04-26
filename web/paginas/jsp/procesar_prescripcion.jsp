<%--
    Document   : procesar_comparendo.jsp
    Created on : 05-ene-2009, 18:33:30
    Author     : Javier
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<html>
   <head>
        <title>Procesar&nbsp;Comparendo</title>
   </head>
   <body>
   <%

    Model modelo= (Model)session.getAttribute("model");
    Sede sede = (Sede)session.getAttribute("sede");
    
    try{
         Vehiculo vehiculo = null;
        modelo.getCon().setAutoCommit(false);
        Usuario usuario=(Usuario)session.getAttribute("usuario");
        java.sql.Timestamp fechaSystem= new java.sql.Timestamp(new java.util.Date().getTime());
        Prescripcion prescripcion = new Prescripcion();

        prescripcion.setFecha_proceso(fechaSystem);
        String  numero="";
        if(request.getParameter("numero")!=null){
            numero = request.getParameter("numero");
            Prescripcion prescp = modelo.consultarPrescripcion(numero);
            
            if(prescp ==null){
                prescripcion.setNumero(numero);
                java.sql.Date  fecha = null;
                    if(request.getParameter("fecha")!=null){
                        fecha = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha")).getTime());
                        prescripcion.setFecha(fecha);
                    }
                    String placa = "";
                    if(request.getParameter("placa")!=null){
                        placa = request.getParameter("placa");
                        vehiculo = modelo.consultarVehiculo(placa.toUpperCase());
                        prescripcion.setFk_vehiculo(vehiculo.getId_vehiculo());
                    }
                    int  tipo_doc;
                    String documento ="";
                    if((request.getParameter("tipo_doc")!=null)&&(request.getParameter("documento")!=null)){
                        documento = request.getParameter("documento");
                        tipo_doc = Integer.parseInt(request.getParameter("tipo_doc"));
                        Persona persona = modelo.consultarPersona(tipo_doc, documento);
                        if(persona!=null)
                            prescripcion.setFk_persona(persona.getId_persona());
                    }
                    int vigenciaI = 0;
                    if(request.getParameter("vigenciaI")!=null){
                        vigenciaI = Integer.parseInt(request.getParameter("vigenciaI"));
                        prescripcion.setVigencia_inicial(vigenciaI);
                    }
                    int vigenciaF = 0;
                    if(request.getParameter("vigenciaF")!=null){
                        vigenciaF = Integer.parseInt(request.getParameter("vigenciaF"));
                        prescripcion.setVigencia_final(vigenciaF);
                    }
                    String observacion = "";
                    if(request.getParameter("observaciones")!=null){
                        observacion = request.getParameter("observaciones");
                        prescripcion.setObservaciones(observacion);
                    }

                    if(usuario!=null){
                        prescripcion.setFk_usuario(usuario.getId_usuario());
                    }

                    prescripcion.setEstado(1);
                    modelo.adicionarPrescripcion(prescripcion);
                    Cartera cartera  = null;
                    Prescripcion presc = modelo.consultarPrescripcion(numero);
                    List  vigencias = modelo.listadoVigencias(vehiculo.getId_vehiculo(),""+vigenciaI,""+vigenciaF);
                    Iterator itrtor = vigencias.iterator();
                    while (itrtor.hasNext()) {
                        cartera = (Cartera)itrtor.next();
                        modelo.actualizarCarteraPrescripcion(cartera.getId_cartera());
                        modelo.adicionarPrescripcionCartera(presc.getId_prescripcion(), cartera.getId_cartera(), fechaSystem);
                    }
                    modelo.getCon().commit();
%>
				<script language="javascript"  type="text/javascript">
        	               alert(" Prescripcion realizada con exito ");
                               location.href='PrescripcionDeCartera.jsp';
                                </script>

                       
<%	}else{
                %>
                <script language="javascript"  type="text/javascript">
        	       alert(" Numero de Prescripcion ya existe");
                       location.href='PrescripcionDeCartera.jsp';
                </script>
                
        <%
            modelo.getCon().rollback();
        }
        }
}catch(Exception exc){
    exc.printStackTrace();
    System.out.println(exc.toString());

	modelo.getCon().rollback();
}	%>
    </body>
</html>

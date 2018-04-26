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

            Model modelo = (Model) session.getAttribute("model");
            Sede sede = (Sede) session.getAttribute("sede");


            System.out.println("1");
            try {
                Vehiculo vehiculo = null;
                modelo.getCon().setAutoCommit(false);
                Usuario usuario = (Usuario) session.getAttribute("usuario");
                java.sql.Timestamp fechaSystem = new java.sql.Timestamp(new java.util.Date().getTime());
                Prescripcion prescripcion = new Prescripcion();

                prescripcion.setFecha_proceso(fechaSystem);
                String numero = "";

                //String[] carteras = (request.getParameterValues("chkcar") != null) ? request.getParameterValues("chkcar") : null;

                String vigenciaI = (request.getParameter("vigenciaI") != null) ? request.getParameter("vigenciaI") : "";
                String vigenciaF = (request.getParameter("vigenciaF") != null) ? request.getParameter("vigenciaF") : "";


                if (!"".equals(vigenciaI) && !"".equals(vigenciaF)) {

                    System.out.println("2");



                    if (request.getParameter("numero") != null) {
                        numero = request.getParameter("numero");
                        Prescripcion prescp = modelo.consultarPrescripcion(numero);



                        if (prescp == null) {
                            prescripcion.setNumero(numero);
                            java.sql.Date fecha = null;
                            if (request.getParameter("fecha") != null) {
                                fecha = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha")).getTime());
                                prescripcion.setFecha(fecha);
                            }

                            System.out.println("3");

                            String placa = "";
                            if (request.getParameter("placa") != null) {
                                placa = request.getParameter("placa");
                                vehiculo = modelo.consultarVehiculo(placa.toUpperCase());
                                prescripcion.setFk_vehiculo(vehiculo.getId_vehiculo());
                            }
                            int tipo_doc;
                            String documento = "";
                            if ((request.getParameter("tipo_doc") != null) && (request.getParameter("documento") != null)) {
                                documento = request.getParameter("documento");
                                tipo_doc = Integer.parseInt(request.getParameter("tipo_doc"));
                                Persona persona = modelo.consultarPersona(tipo_doc, documento);
                                if (persona != null) {
                                    prescripcion.setFk_persona(persona.getId_persona());
                                }
                            }

                            System.out.println("4");

                            prescripcion.setVigencia_inicial(Integer.parseInt(vigenciaI));
                            prescripcion.setVigencia_final(Integer.parseInt(vigenciaF));


                            String observacion = "";
                            if (request.getParameter("observaciones") != null) {
                                observacion = request.getParameter("observaciones");
                                prescripcion.setObservaciones(observacion);
                            }

                            System.out.println("5");

                            if (usuario != null) {
                                prescripcion.setFk_usuario(usuario.getId_usuario());
                            }

                            prescripcion.setEstado(1);
                            modelo.adicionarPrescripcion(prescripcion);
                            Cartera cartera = null;
                            Prescripcion presc = modelo.consultarPrescripcion(numero);

                            List carteras = modelo.listadoVigencias(vehiculo.getId_vehiculo(), vigenciaI, vigenciaF);

                            if (carteras != null) {

                                for (int i = 0; i < carteras.size(); i++) {

                                    cartera = (Cartera) carteras.get(i);

                                    //cartera = modelo.consultarCartera(    idCartera);
                                    if (cartera != null) {

                                        modelo.actualizarCarteraPrescripcion(cartera.getId_cartera());
                                        modelo.adicionarPrescripcionCartera(presc.getId_prescripcion(), cartera.getId_cartera(), fechaSystem);

                                    }
                                }
                            }

                            modelo.actualizarVigenciaPrescripcionCartera(presc.getId_prescripcion(), Integer.parseInt(vigenciaI), Integer.parseInt(vigenciaF));

                            /*List vigencias = modelo.listadoVigencias(vehiculo.getId_vehiculo(), "" + vigenciaI, "" + vigenciaF);
                            Iterator itrtor = vigencias.iterator();
                            while (itrtor.hasNext()) {
                            cartera = (Cartera) itrtor.next();
                            modelo.actualizarCarteraPrescripcion(cartera.getId_cartera());
                            modelo.adicionarPrescripcionCartera(presc.getId_prescripcion(), cartera.getId_cartera(), fechaSystem);
                            }*/
                            modelo.getCon().commit();
        %>
        <script language="javascript"  type="text/javascript">
            alert(" Prescripcion realizada con exito ");
            location.href='prescripcionCarteraVehiculo.jsp';
        </script>


        <%	} else {
        %>
        <script language="javascript"  type="text/javascript">
            alert(" Numero de Prescripcion ya existe");
            location.href='prescripcionCarteraVehiculo.jsp';
        </script>

        <%
                    modelo.getCon().rollback();
                }
            } // Fin Número.
        } else {
        %>
        <script language="javascript"  type="text/javascript">
            alert(" Error! no se ha seleccionado cartera para prescribir");
            location.href='consultarCarteraPrescripcion.jsp';
        </script>

        <%    }
            } catch (Exception exc) {
                exc.printStackTrace();
                System.out.println(exc.toString());

                modelo.getCon().rollback();
            }%>
    </body>
</html>

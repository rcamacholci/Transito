<%--
    Document   : procesar_comparendo.jsp
    Created on : 05-ene-2009, 18:33:30
    Author     : Javier
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="modelo.*"%>
<html>
   <head>
        <title>Procesar&nbsp;Comparendo</title>
   </head>
   <body>
   <%

    Model modelo= (Model)session.getAttribute("model");
    Sede sede = (Sede)session.getAttribute("sede");
    modelo.getCon().setAutoCommit(false);
    try{
        Persona persona=new Persona();
        Cartera cartera= new Cartera();
        Comparendo comparendo;
        Vehiculo vehiculo = null;

        Valor_Infraccion valor_infraccion= new Valor_Infraccion();
        modelo.getCon().setAutoCommit(false);
        Usuario usuario=(Usuario)session.getAttribute("usuario");

        java.sql.Date fechaUpdate = new java.sql.Date(new java.util.Date().getTime());
        java.sql.Timestamp fechaSystem= new java.sql.Timestamp(new java.util.Date().getTime());

        String  num_comp = request.getParameter("comparendo");


        java.sql.Timestamp fecha_comparendo = new java.sql.Timestamp(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_comp")).getTime());

        fecha_comparendo.setHours(Integer.parseInt( request.getParameter("horas")));
        fecha_comparendo.setMinutes( Integer.parseInt( request.getParameter("minutos")) );
        String lugar = request.getParameter("lugar").toUpperCase();

        String placa = !request.getParameter("placa").isEmpty()?request.getParameter("placa").toUpperCase():"";

        String licencia_transito = request.getParameter("licencia_transito");

        int clase = request.getParameter("clase")!=null?!request.getParameter("clase").isEmpty()?Integer.parseInt(request.getParameter("clase")):0:-1;

        int servicio = request.getParameter("servicio")!=null?!request.getParameter("servicio").isEmpty()?Integer.parseInt(request.getParameter("servicio")):0:-1;


        int tipo_doc = Integer.parseInt(request.getParameter("tipo_doc"));
        String documento = request.getParameter("documento");




        int tipo_infractor = Integer.parseInt(request.getParameter("tipo_infractor"));

        long infraccion = modelo.consultarInfraccionByNumero(request.getParameter("infraccion")).getId_infraccion();

        String lic_conduccion = request.getParameter("lic_conduccion") ;
        
        int expedido_en = 0;

        if(request.getParameter("lic_conduccion")!=null){
            if(!request.getParameter("lic_conduccion").isEmpty())
                expedido_en = request.getParameter("expedido_en")!=null?Integer.parseInt(request.getParameter("expedido_en")):0;
        }
        String categoria  = "";
        if(request.getParameter("lic_conduccion")!=null){
            if(!request.getParameter("lic_conduccion").isEmpty())
                categoria = request.getParameter("categoria")!=null?request.getParameter("categoria"):"";
        }
        java.sql.Date  fecha_venc =   null;
        if(request.getParameter("fecha_venc")!=null){
                if(!request.getParameter("fecha_venc").isEmpty()){
                        fecha_venc = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_venc")).getTime());
                }
        }
        if(!placa.isEmpty() && servicio==-1 && clase==-1){
            vehiculo = modelo.consultarVehiculo(placa);
            servicio = (int) vehiculo.getServicio();
            clase = (int) vehiculo.getClase_vehiculo();
        }


            int placa_agente  =   Integer.parseInt(request.getParameter("placa_agente"));
            int fuga = request.getParameter("fuga")!=null?Integer.parseInt(request.getParameter("fuga")):0;
            int accidente = request.getParameter("accidente")!=null?Integer.parseInt(request.getParameter("accidente")):0;
	    int inmovilizacion = request.getParameter("inmovilizacion")!=null?Integer.parseInt(request.getParameter("inmovilizacion")):0;
	    int policia = request.getParameter("policia")!=null?Integer.parseInt(request.getParameter("policia")):0;
	    int firma = request.getParameter("firma")!=null?Integer.parseInt(request.getParameter("firma")):0;

	    String  observaciones = !request.getParameter("observaciones").isEmpty()?request.getParameter("observaciones").toUpperCase():"";

            long parqueaderos = Long.parseLong(request.getParameter("parqueaderos"));

		comparendo=modelo.consultar_Comparendo(num_comp);
		if(comparendo==null){
                    comparendo = new Comparendo();

			persona=  modelo.consultarPersona(tipo_doc, documento);
			Agente agente=modelo.consultarAgente(placa_agente);
			cartera.setFk_persona(persona.getId_persona());
			cartera.setFk_sede(sede.getId_sede());
			cartera.setTipo(1);
			cartera.setReferencia(num_comp);
			cartera.setFecha_creacion(fechaUpdate);
			cartera.setFecha_ingreso(fechaUpdate);

			valor_infraccion = modelo.consultarValorInfraccion(new java.sql.Date(fecha_comparendo.getTime()), infraccion);
			if(valor_infraccion!=null){
				cartera.setValor(valor_infraccion.getValor());
				cartera.setSaldo(valor_infraccion.getValor());
				cartera.setFecha_saldo(fechaUpdate);
				cartera.setEstado_cartera(1);
				cartera.setFecha_estado(fechaUpdate);
				cartera.setEstado_vigencia(1);
				cartera.setFecha_estado_vigencia(fechaUpdate);
				cartera.setFk_usuario(usuario.getId_usuario());
				cartera.setFk_concepto(12);


                                long Fk_cartera = modelo.adicionarCartera(cartera);
                                long id_licencia = 0;
                                Licencia_Conduccion licenciaC = modelo.consultarLicenciaIdPersona(persona.getId_persona());
                                if(licenciaC!=null){
                                            //comparendo.setFk_licencia(licenciaC.getIdLicenciaConduccion());
                                }

                                if(vehiculo!=null){
                                    Licencia_Transito licenciaT = modelo.consultarLicenciaTransito(vehiculo.getId_vehiculo());
                                    if(licenciaT!=null){
                                        comparendo.setLicencia_transito(licenciaT.getNumero());
                                    }
                                }

                                //if(lic_conduccion!=null){
                                   // if(!lic_conduccion.isEmpty()){
                                    //    Licencia_Conduccion lc = modelo.consultarLicencia(lic_conduccion);
                                        
                                        //Licencia_Conduccion licenciaConduccion = new Licencia_Conduccion();
                                        //licenciaConduccion.setNumeroLicencia(lic_conduccion);
                                        //licenciaConduccion.setCategoria(categoria);
                                        //licenciaConduccion.setFechaVencimiento(fecha_venc);
                                        //licenciaConduccion.setFk_sede(expedido_en);
                                        //licenciaConduccion.setFk_persona(persona.getId_persona());
                                        //licenciaConduccion.setFk_usuario(usuario.getId_usuario());
                                        //licenciaConduccion.setFechaRegistro(new java.sql.Timestamp(new java.util.Date().getTime()));
                                        //licenciaConduccion.setEstadoLicencia(1);
                                        //pendiente
                                       //Consultar licencia de conduccion para ver si existe y tomar el ID
				 //  }
				//}

				comparendo.setFk_persona(persona.getId_persona());
				comparendo.setFk_usuario_organismo(usuario.getId_usuario());
                               //verificar en model
				  
                               
				comparendo.setFk_sede(sede.getId_sede());//id_sede
				comparendo.setFk_infraccion(infraccion);
				comparendo.setFk_agente(agente.getId_agente());
				comparendo.setNumero(num_comp);
				comparendo.setFecha(fecha_comparendo);//fecha comparendo
				comparendo.setLugar(lugar);
				comparendo.setPlaca(placa);
				comparendo.setClase(clase);
				comparendo.setServicio(servicio);
				comparendo.setTipo_infractor(tipo_infractor);
				comparendo.setObservaciones(observaciones);
				comparendo.setFuga(fuga);
				comparendo.setAccidente(accidente);
				comparendo.setInmovilizacion(inmovilizacion);
				comparendo.setPolca(policia);
				comparendo.setFirmado(firma);
				comparendo.setEstado(1);
				comparendo.setFecha_proceso(fechaSystem);
				comparendo.setFk_cartera(Fk_cartera);
				
                                //--------------SimitComp----------------
                               java.util.List direcciones = modelo.listado_direcciones_persona(persona.getId_persona());
                                    if(direcciones.size()>0){
                                        Direccion direccionP = (Direccion)direcciones.get(0);
                                            if(direccionP!=null){
                                            }
                                    }
                                


                                Infraccion infracc = modelo.consultarInfraccion(infraccion);
                                modelo.adicionarComparendo(comparendo);
				comparendo=modelo.consultar_Comparendo(num_comp);
				if(inmovilizacion==1)
                                    modelo.adicionarComparendoPatio(comparendo.getId_comparendo(), parqueaderos, fechaUpdate, 1,1,persona.getId_persona(),1);

                                Detalle_Cartera detalle=new Detalle_Cartera();
                                detalle.setFk_cartera(Fk_cartera);
                                detalle.setReferencia(num_comp);
                                detalle.setFecha(fechaUpdate);
                                detalle.setFecha_sistema(fechaSystem);
                                detalle.setFk_usuario(usuario.getId_usuario());
                                detalle.setEstado(1);
				detalle.setFk_concepto(88);
                                detalle.setValor((float)(cartera.getSaldo()*0.10));
                                modelo.adicionarDetalleCartera(detalle);

                                if(policia!=0){
                                    detalle.setFk_concepto(73);
                                    detalle.setValor((float)(cartera.getSaldo()*0.45));
                                    modelo.adicionarDetalleCartera(detalle);
                                    detalle.setFk_concepto(12);
                                    detalle.setValor((float)(cartera.getSaldo()*0.45));
                                    modelo.adicionarDetalleCartera(detalle);
                                }else{
                                    detalle.setFk_concepto(12);
                                    detalle.setValor((float)(cartera.getSaldo()*0.90));
                                    modelo.adicionarDetalleCartera(detalle);
                                }
					
                                modelo.actualizarValoresCartera(Fk_cartera);
				modelo.getCon().commit();
                        	    //session.setAttribute("comparendo",comparendo);%>
				<script language="javascript"  type="text/javascript">
        	               alert("El Comparendo se ha Registrado Correctamente  ! ");
                               location.href='adicionar_Comparendo.jsp';
                                </script>
<%
                        }else{
				modelo.getCon().rollback();
		   	%>
				<script language="javascript"  type="text/javascript">
                                   alert("No se creo cartera al comparendo");
                                   history.back()
                               </script>
<%		   }

	}
}catch(Exception exc){
    exc.printStackTrace();
    	modelo.getCon().rollback();
}	%>
    </body>
</html>

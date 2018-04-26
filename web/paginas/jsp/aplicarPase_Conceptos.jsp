<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="modelo.*" %>
<root>
<%
Model modelo= (Model)session.getAttribute("model");
Sede sede= (Sede)session.getAttribute("sede");
Usuario usuario= (Usuario)session.getAttribute("usuario");
modelo.getCon().setAutoCommit(false);
System.out.println("Aplixar concrpto");
try{
	
	if(request.getParameter("id_configuracion")!=null && request.getParameter("porcentaje")!=null && request.getParameter("fecha_inicial")!=null && request.getParameter("fecha_final")!=null && request.getParameter("fecha_resolucion")!=null && request.getParameter("noresolucion")!=null && request.getParameter("id_tramite")!=null && request.getParameter("valor")!=null){
            
            java.sql.Date  fechaSystem = new java.sql.Date(new java.util.Date().getTime());
            long id_conf_desc = Long.parseLong(request.getParameter("id_configuracion"));
            float porcentaje = Float.parseFloat(request.getParameter("porcentaje"));
            java.sql.Date fecha_inicial = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_inicial")).getTime());
            java.sql.Date fecha_final = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_final")).getTime());
            String resolucion = request.getParameter("noresolucion");
            java.sql.Date fecha_resolucion = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_resolucion")).getTime());
            String id_tramite = request.getParameter("id_tramite");
            long valor = Long.parseLong(request.getParameter("valor"));

            System.out.println(request.getParameter("valor"));

                //modelo.actualizarEstadoConfiguracionDesc(2, id_conf_desc);
            Configuracion_descuentos conf = modelo.consultarConf_Decuento(id_conf_desc);
            Configuracion_descuentos configuracion_descuentos = new Configuracion_descuentos();
            java.util.List<Valor_conceptos_tramite> st = modelo.listarTramiteByConcepto(conf.getFk_concepto(), sede.getId_sede());
            for(int i=0;i<st.size();i++){
            Valor_conceptos_tramite vct = st.get(i);
            Sede_tramite_concepto sed = modelo.consultarSedeTramiteConc(vct.getFk_concepto(),vct.getFk_tramite(), conf.getFk_sede());
            Sede_tramite_concepto sedetc = new Sede_tramite_concepto();
            sedetc.setFk_concepto(sed.getFk_concepto());
            sedetc.setFecha_ini(fecha_inicial);
            sedetc.setResolucion(resolucion);
            sedetc.setFecha_resol(fecha_resolucion);
            sedetc.setValor(valor);
            sedetc.setFk_sede(sed.getFk_sede());
            sedetc.setFk_tramite(sed.getFk_tramite());
            modelo.actualizarSedeTraConcepto(fecha_inicial,vct.getFk_concepto(),vct.getFk_tramite(), conf.getFk_sede());
            modelo.adicionarSedeTramiteConc(sedetc);
            }//next
/*
            Sede_tramite_concepto sed = modelo.consultarSedeTramiteConc(conf.getFk_concepto(),Long.parseLong(id_tramite), conf.getFk_sede());
            Sede_tramite_concepto sedetc = new Sede_tramite_concepto();
            sedetc.setFk_concepto(sed.getFk_concepto());
            sedetc.setFecha_ini(fecha_inicial);
            sedetc.setResolucion(resolucion);
            sedetc.setFecha_resol(fecha_resolucion);
            sedetc.setValor(valor);
            sedetc.setFk_sede(sed.getFk_sede());
            sedetc.setFk_tramite(sed.getFk_tramite());
            modelo.actualizarSedeTraConcepto(fecha_inicial,conf.getFk_concepto(),Long.parseLong(id_tramite), conf.getFk_sede());
            modelo.adicionarSedeTramiteConc(sedetc);*/
            
           /*float totalP = porcentaje - conf.getPorcentaje();

            configuracion_descuentos.setFk_sede(sede.getId_sede());
            configuracion_descuentos.setFk_entidad_distribucion(1);
            configuracion_descuentos.setFk_concepto(conf.getFk_concepto());
            configuracion_descuentos.setPorcentaje(Math.abs(totalP));
            configuracion_descuentos.setFecha_ini(fecha_inicial) ;
            configuracion_descuentos.setFecha_fin(fecha_final);
            configuracion_descuentos.setEstado(1);
            configuracion_descuentos.setResolucion(resolucion);
            configuracion_descuentos.setFecha_resolucion(fecha_resolucion);
            configuracion_descuentos.setFk_tramite(Long.parseLong(id_tramite));

            modelo.adicionarDescuentoConcepto(configuracion_descuentos);
            long id_conf = modelo.consultarMaxIdDescuento();
            
            Historial_descuento_concepto historial_descuento_concepto = new Historial_descuento_concepto();
            historial_descuento_concepto.setFk_conf_descuento(id_conf);
            historial_descuento_concepto.setFk_usuario(usuario.getId_usuario());
            historial_descuento_concepto.setFecha_proceso(fechaSystem);
            modelo.adicionarHisDescuentoConc(historial_descuento_concepto);*/

            %><result>si</result><%
            modelo.getCon().commit();
        }else{%>
                <result>no</result>
            <%}
}catch(Exception exc){
System.out.println(exc);
modelo.getCon().rollback();
}%>
</root>

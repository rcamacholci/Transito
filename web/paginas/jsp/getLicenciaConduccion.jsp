<?xml version="1.0" encoding="UTF-8"?>
<%-- 
    Documento   : getLicenciaConduccion
    Creado      : 16-mar-2010, 13:08:44
    Autor       : Jorge Lopez
--%>
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/xml" import="modelo.*,java.util.*" %>
<root>
    <%
    Model modelo = (Model) session.getAttribute("model");
    String numero = request.getParameter("numero");
    String documento = "";
    int tipo =0;
    Licencia_Conduccion licenciaConduccion = null ;

    
    if(request.getParameter("tipo")!=null){
        if(!request.getParameter("tipo").isEmpty()){
            tipo= Integer.parseInt(request.getParameter("tipo"));
        }
    }
    if(request.getParameter("documento")!=null){

        documento = request.getParameter("documento");
    }
    
    if(numero!=null){
        if(!numero.isEmpty()) licenciaConduccion = modelo.consultarLicencia(numero);
    }
    if(tipo!=0 && !documento.isEmpty()){
            Persona persona = modelo.consultarPersona(tipo, documento);
            if(persona!=null) licenciaConduccion = modelo.consultarLicenciaIdPersona(persona.getId_persona());

   }

        if(licenciaConduccion!=null){
            
            %>
            <result>si</result>
            <numero><%=licenciaConduccion.getNumeroLicencia()%></numero>
            <categoria><%=licenciaConduccion.getCategoria()%></categoria>
            <sede_exp_id><%=licenciaConduccion.getFk_sede()%></sede_exp_id>
            <fecha_venc><%=licenciaConduccion.getFechaVencimiento()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy").format((licenciaConduccion.getFechaVencimiento())):"null"%></fecha_venc>
    <%

        }else{
            %>
            <result>no</result>
            <%

        }
    


%>
</root>



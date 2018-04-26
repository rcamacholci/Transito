<%--
    Document   : Adicionar Certificado Comparendo
    Created on : 09-nov-2010, 18:33:30
    Author     : Walter
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="modelo.*"%>
<html>
   <head>
        <title>Procesar&nbsp;Certificado</title>
   </head>
   <body>
   <%

    Model model = (Model)session.getAttribute("model");
    Sede sede = (Sede)session.getAttribute("sede");
    try{
        Comparendo comparendo = model.consultar_Comparendo(request.getParameter("textfield1"));

        java.sql.Date fecha = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha_comp")).getTime());
        int lugar = Integer.parseInt(request.getParameter("lugar"));
        int certificado = Integer.parseInt(request.getParameter("certificado"));
        Comparendo_Curso cc = new Comparendo_Curso();
        cc.setCertificado(certificado);
        cc.setFk_persona(comparendo.getFk_persona());
        cc.setFk_comparendo(comparendo.getId_comparendo());
        cc.setEstado(1);
        cc.setValor(0);
        cc.setFecha(fecha);
        cc.setLugar(lugar);
        model.adicionarComparendoCurso(cc);
   %>
        <script language="javascript"  type="text/javascript">
            alert("El Certificado se ha Registrado Correctamente");
            location.href='adicionar_Comparendo.jsp';
        </script>
<%  }catch(Exception exc){
        exc.printStackTrace();
    }	%>
    </body>
</html>

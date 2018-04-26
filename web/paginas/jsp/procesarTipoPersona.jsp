<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>

<root>
<%
Model modelo = (Model)session.getAttribute("model");

String sw = "0";

try{
    modelo.getCon().setAutoCommit(false);
    Usuario usuario = (Usuario)session.getAttribute("usuario");
    if(request.getParameter("idpersona")!=null && request.getParameter("tipo")!=null){
       long id_per = Long.parseLong(request.getParameter("idpersona"));
       long tipo = Long.parseLong(request.getParameter("tipo"));
         modelo.InsertarTipopersona(tipo, id_per, (int)usuario.getId_usuario());
       if(tipo==2){
         sw = "1";
       }else{
         sw = "2";
       }
    }
    modelo.getCon().commit();

}catch(Exception ex){
    modelo.getCon().rollback();
    System.out.println("/*-"+ex+"*/");
}
%>
<sw><%=sw %></sw>

</root>
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">

<%
Model modelo= (Model)session.getAttribute("model");
Sede sede= (Sede)session.getAttribute("sede");
Usuario usuario= (Usuario)session.getAttribute("usuario");
modelo.getCon().setAutoCommit(false);
try{

    java.util.List lista = modelo.listarConfDescVencidos();
        for(int i = 0;i<lista.size();i++){
        Configuracion_descuentos conf = (Configuracion_descuentos)lista.get(i);
        
        }

}catch(Exception ex){
System.out.println(ex);
}
%>
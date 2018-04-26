<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html;charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" errorPage="" %>
 <%
 try{
    Model model = (Model)session.getAttribute("model");
    if(model!=null){
        String name = "C:\\Civitrans\\webinsData\\"+request.getParameter("file")+".data";
        inscripcion.deserializarPersonas deserializer = new inscripcion.deserializarPersonas(model, name);
    }
}catch(Exception mexe){
    mexe.printStackTrace();

} %>

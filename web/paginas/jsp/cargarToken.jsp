<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<% Model model = (Model)session.getAttribute("model");

System.out.println("estoy en cargar TOKEN inicio");
    if (!request.getParameter("token").equals(null)&&!request.getParameter("usuario").equals(null) &&!request.getParameter("password").equals(null)){
        session.removeAttribute("token2");
        session.removeAttribute("usuarioRunt");
        session.removeAttribute("passRunt");
        String trama =  request.getParameter("token");
        System.out.println("token 2 : "+trama);
        System.out.println("longitud token 2 : "+trama.length());
        session.setAttribute("token2",trama);
        session.setAttribute("usuarioRunt",request.getParameter("usuario"));
        session.setAttribute("passRunt",request.getParameter("password"));
        System.out.println("token valido");
        %>
                   <result>1</result>
        <%
        }else{
                                             System.out.println("token no valido");
                                             %>
                                                  <result>2</result>
                                            <%

                                        }%>
                            

</root> 

<%@page import = "modelo.Model" import = "modelo.Persona"%>

<%
            java.util.HashMap hash_especificaciones = (java.util.HashMap)session.getAttribute("especificaciones");
            String codigo = request.getParameter("codigo");
            String valor = request.getParameter("valor");
            hash_especificaciones.put(codigo, valor);
            session.setAttribute("especificaciones",hash_especificaciones);
            out.print("OK");        
%>
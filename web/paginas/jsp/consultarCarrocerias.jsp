<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
Model modelo = (Model) session.getAttribute("model");
String clase = "";
if(request.getParameter("clase")!=null){
    clase = request.getParameter("clase");
     java.util.List lista = modelo.listadoParametros(2);
     Iterator it = lista.iterator();%>
     <option value="0"><<--Seleccione Carroceria-->></option>
 <%  while (it.hasNext()) {
        Parametro parametro = (Parametro)it.next();
        if(parametro.getNombreCorto().equals(clase)){ %>
            <option value="<%=parametro.getCodigo()%>"><%=parametro.getNombre()%></option>
    <%  }
    }
} %>


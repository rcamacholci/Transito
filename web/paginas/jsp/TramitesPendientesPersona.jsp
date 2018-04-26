<?xml version="1.0" encoding="ISO-8859-1"?>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" %>
<root>
<%
modelo.Model model= (modelo.Model)session.getAttribute("model");
int estadoN = -1;

try{
    if (!request.getParameter("numeroDocumento").isEmpty()){
        int tipoD = Integer.parseInt(request.getParameter("tipoDocumento"));
        String numeroDocumento = request.getParameter("numeroDocumento").trim();
        modelo.Persona persona = model.consultarPersona(tipoD,numeroDocumento);
        if(persona!=null){
            modelo.Radicacion_Licencia rl = model.consultarRadicacionByfkPersona(persona.getId_persona());
            if(rl!=null){
                estadoN = 1;
            }else{
                estadoN = 2;
            }
        }
    }
}catch(Exception exc){
    exc.printStackTrace();
}
%>
<respuesta>
    <estadoN><%=estadoN%></estadoN>
   
</respuesta>
</root>
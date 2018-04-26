<?xml version="1.0" encoding="ISO-8859-1"?>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" %>
<root>
<%
modelo.Model model= (modelo.Model)session.getAttribute("model");
int estadoN = -1;
int estadoT = -1;
int estadoF = -1;
String datoN = "";
String datoT = "";
String datoF = "";
try{
    if (!request.getParameter("numeroDocumento").isEmpty()){
        int tipoD = Integer.parseInt(request.getParameter("tipoDocumento"));
        String tipoDocumento = model.consultarParametro(tipoD,5).getNombreCorto();
        String numeroDocumento = request.getParameter("numeroDocumento").trim();
        modelo.Persona personaL = model.consultarPersona(tipoD, numeroDocumento);

        if(personaL!=null){
                    
                        String nombre_1 = personaL.getNombre_1()!=null?personaL.getNombre_1():"";
                        String nombre_2 = personaL.getNombre_2()!=null?personaL.getNombre_2():"";
                        String apellido_1 = personaL.getApellido_1()!=null?personaL.getApellido_1():"";
                        String apellido_2 = personaL.getApellido_2()!=null?personaL.getApellido_2():"";
       
                             datoN = nombre_1+" "+nombre_2+" "+apellido_1+" "+apellido_2;

                             estadoN = 1;
                             estadoT = 1;
                             estadoF = 1;

                             datoT = "MAYORADIESDIGITOSDEBESERPARAQUEFUNCIONESTOMUYBIEN";
                             datoF = "../data/fotosLicencias/Foto"+personaL.getId_persona()+".jpg";
                    
        }
    }
}catch(Exception exc){
    exc.printStackTrace();
}
%>
<respuesta>
    <estadoN><%=estadoN%></estadoN>
    <datoN><%=datoN%></datoN>
    <estadoT><%=estadoT%></estadoT>
    <datoT><%=datoT%></datoT>
    <estadoF><%=estadoF%></estadoF>
    <datoF><%=datoF%></datoF>
</respuesta>
</root>
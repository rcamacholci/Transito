<%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
    <%
            try {
                Model modelo = (Model) session.getAttribute("model");
                long IdColor = 0;
                if(request.getParameter("id_color")!=null&&!request.getParameter("id_color").isEmpty()){
                    IdColor =Integer.parseInt(request.getParameter("id_color"));
                }                
                String NombreColor = request.getParameter("nombre_color").toUpperCase().trim();
                modelo.getCon();
                boolean ext = modelo.ExisteColor(IdColor,NombreColor);
                if (IdColor != 0 && !NombreColor.equals("") && ext) {
                    modelo.getCon().setAutoCommit(false);
                    modelo.EditarColor(IdColor, NombreColor);
                    modelo.getCon().commit();%>
    <result>1</result>
    <mensaje>Guardado Correctamente</mensaje>
    <%} else {%>
    <result>2</result>
    <%    if (!ext) {%>
    <mensaje>Id Color  o Nombre del color ya existe</mensaje>
    <%} else if (NombreColor.equals("")) {%>
    <mensaje>Nombre Del Color Vacio</mensaje>
    <%}
                }
            } catch (Exception e) {
                %><result>3</result>
                <mensaje>Se ha producido un error durante el ingreso del color por favor comuniquece con Soporte Tecnico 
                Error: <%=e%> </mensaje>
                
                
                <%
                e.printStackTrace();
            }

    %>
</root>
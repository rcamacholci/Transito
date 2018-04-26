<%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<%
try{ 
Model modelo = (Model)session.getAttribute("model");
modelo.conectar();
modelo.getCon().setAutoCommit(false);
Concepto con = new Concepto();
String cconcepto ="";
String tconcepto ="";
String prioridad ="";
String nombre ="";
String id=request.getParameter("id");

if(request.getParameter("c_concepto")!=null&&!request.getParameter("c_concepto").isEmpty()){
       cconcepto = request.getParameter("c_concepto");
       con.setClase(Integer.parseInt(cconcepto));
}  
if(request.getParameter("t_concepto")!=null&&!request.getParameter("t_concepto").isEmpty()){
       tconcepto = request.getParameter("t_concepto");
           con.setTipo(Integer.parseInt(tconcepto));
}  
if(request.getParameter("prioridad")!=null&&!request.getParameter("prioridad").isEmpty()){
       prioridad = request.getParameter("prioridad");
       con.setPrioridad(Integer.parseInt(prioridad));
}  
if(request.getParameter("nombre")!=null&&!request.getParameter("nombre").isEmpty()){
       nombre = request.getParameter("nombre").trim().toUpperCase();
       con.setNombre(nombre);
}
con.setId_concepto(Long.parseLong(id));
modelo.Actulizarconcepto(con);
modelo.getCon().commit();

%>
<result>1</result>
<msg>El concepto ha sido Actulizado exitosamente!</msg>
<%
}catch(Exception ex){
%>
<result>2</result>
<msg>Se ha producido un error durante la Actulizacion del Conpceto  por favor comuniquece con Soporte Tecnico 
                Error: <%=ex%> </msg>
<%    
ex.printStackTrace();
}
%>
</root>

    

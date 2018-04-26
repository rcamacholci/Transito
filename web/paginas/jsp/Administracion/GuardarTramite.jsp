<%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<%
try{
Model modelo = (Model)session.getAttribute("model");Sede sede = (Sede)session.getAttribute("sede");modelo.conectar();
modelo.getCon().setAutoCommit(false);Concepto con = new Concepto();Tramite tra = new Tramite();String cconcepto ="";
String tconcepto ="";String prioridad ="";String nombre ="";

if(request.getParameter("Abreviatura")!=null&&!request.getParameter("Abreviatura").isEmpty()){
       cconcepto = request.getParameter("Abreviatura");
       tra.setAbreviatura(cconcepto);
}  
if(request.getParameter("Descripcion")!=null&&!request.getParameter("Descripcion").isEmpty()){
       cconcepto = request.getParameter("Descripcion");
       tra.setDescripcion(cconcepto);
}else{
    tra.setDescripcion("");
}  
if(request.getParameter("Ctramite")!=null&&!request.getParameter("Ctramite").isEmpty()){
       tconcepto = request.getParameter("Ctramite");
           tra.setClase_tramite(Integer.parseInt(tconcepto));
}  
if(request.getParameter("prioridad")!=null&&!request.getParameter("prioridad").isEmpty()){
       prioridad = request.getParameter("prioridad");
       tra.setPeso(Integer.parseInt(prioridad));
}  
if(request.getParameter("Nombre")!=null&&!request.getParameter("Nombre").isEmpty()){
       nombre = request.getParameter("Nombre").trim().toUpperCase();
       tra.setNombre(nombre);
}
tra.setGra_codigo(104);
modelo.AgregarTramite(tra);
tra = modelo.consultarTramite(nombre);
modelo.AgregarSedeTramite(tra.getId_tramite(),sede.getId_sede());
modelo.getCon().commit();
/*modelo.adicionarConcepto(con);con = modelo.consultarConcepto(nombre);Sede_concepto seco = new Sede_concepto();seco.setFk_concepto(con.getId_concepto());
Sede sede = (Sede)session.getAttribute("sede");seco.setFk_sede(sede.getId_sede());
java.sql.Date fecha_actual=new java.sql.Date(new java.util.Date().getTime());
seco.setFecha_inicio(fecha_actual);modelo.adicionarSedeConcepto(seco);modelo.getCon().commit();*/
%>
<result>1</result>
<msg>El Tramite ha sido ingresado exitosamente!</msg>
<%
}catch(Exception ex){
%>
<result>2</result>
<msg>Se ha producido un error durante el ingreso del color por favor comuniquece con Soporte Tecnico 
                Error: <%=ex%> </msg>
<%    
System.out.println("Error Guardar tramite "+ex);
}
%>
</root>
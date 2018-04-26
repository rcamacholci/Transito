<%@page import="org.apache.naming.java.javaURLContextFactory"%>
<%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<%
try{ 
Model model = (Model)session.getAttribute("model");
model.conectar();
model.getCon().setAutoCommit(false);
long id = Long.parseLong(request.getParameter("id"));
long valor = Long.parseLong(request.getParameter("valor"));
String resolucion = request.getParameter("resolucion");
Sede sede =(Sede)session.getAttribute("sede");
java.sql.Date fechaActual = new java.sql.Date(new java.util.Date().getTime());
java.sql.Date fechaReso = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha")).getTime());
long tramite = Long.parseLong(request.getParameter("tramite"));
modelo.Sede_tramite_concepto stc =new modelo.Sede_tramite_concepto();
stc.setFecha_ini(fechaActual);
stc.setFecha_resol(fechaReso);
stc.setFk_concepto(id);
stc.setFk_sede(sede.getId_sede());
stc.setResolucion(resolucion);
stc.setValor(valor);
if(tramite==0){
java.util.List<modelo.Sede_tramite_concepto> listtra = model.ListaTramitebyconcepto(id,sede.getId_sede());
for(int i=0;i<listtra.size();i++){
    modelo.Tramite tra = model.consultarTramite(listtra.get(i).getFk_tramite());
    stc.setFk_tramite(tra!=null?tra.getId_tramite():0);
    model.actualizarSedeTraConcepto(fechaActual,stc.getFk_concepto(), stc.getFk_tramite(),stc.getFk_sede());
    
    model.adicionarSedeTramiteConc(stc);
   
}
}else{
    stc.setFk_tramite(tramite);
    model.actualizarSedeTraConcepto(fechaActual,stc.getFk_concepto(), stc.getFk_tramite(),stc.getFk_sede());
    model.adicionarSedeTramiteConc(stc);
}
model.getCon().commit();
%>
<result>1</result>
<msg>El concepto ha sido Configurado exitosamente!</msg>
<%
}catch(Exception ex){
%>
<result>2</result>
<msg>Se ha producido un error durante la Configuracion del Conpceto  por favor comuniquece con Soporte Tecnico Error: <%=ex%> </msg>
<%    
ex.printStackTrace();
}
%>
</root>

    

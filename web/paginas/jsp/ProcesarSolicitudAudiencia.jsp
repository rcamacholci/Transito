<%-- 
    Document   : ProcesarSolicitudAudiencia
    Created on : 4/03/2013, 03:53:58 PM
    Author     : acer
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="modelo.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
Model model = new Model();
model.conectar();
try{
java.sql.Date fecha = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha")).getTime());
Sede sede = (Sede)session.getAttribute("sede");
String radicado = request.getParameter("radicado");
String documento = request.getParameter("documento");
String numero = request.getParameter("comparendo");
Usuario usuario = (Usuario)session.getAttribute("usuario");
Persona per = model.consultarPersona(1, documento);
Comparendo comp = model.consultar_Comparendo(numero);
if(comp!=null){
System.out.println("/*"+comp.getId_comparendo()+"*/");
Solicitud_Audiencia temp = model.ConsultarSA(comp.getId_comparendo());
//System.out.println("/*"+temp.getFk_comaprendo()+"*/");
if(temp==null){
int vigencia = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
int factura=0;
String consecutivo="";
factura = model.consultarConsecutivo(sede.getId_sede(), 19, vigencia);
consecutivo = "J"+("0000".substring(0, 4-(factura+"").length()))+factura;
model.actualizarConsecutivo(sede.getId_sede(),19, vigencia);
System.out.println("/*"+consecutivo+"*/");
Solicitud_Audiencia aud = new Solicitud_Audiencia();
aud.setFecha(fecha);
aud.setFk_persona(per.getId_persona());
aud.setFk_usuario(usuario.getId_usuario());
aud.setFk_comaprendo(comp.getId_comparendo());
aud.setConsecutivo(consecutivo);
aud.setRadicacion(radicado);
aud.setEstado((long)1);
model.InsertSolicitudes_audiencia(aud);
java.sql.Timestamp fechaSystem = new java.sql.Timestamp(new java.util.Date().getTime());
long estado=9;
modelo.auditoria_comparendo com = new modelo.auditoria_comparendo();
//System.out.println("ok vamos hace esto ->"+());
//modelo.Comparendo temp = model.consultar_Comparendo(c.getReferencia());
model.UpdateAditoriaComparendo(fechaSystem,aud.getFk_comaprendo());
com.setFk_comparendo(aud.getFk_comaprendo());
com.setFk_estado(1);
com.setFecha_proceso(fechaSystem);
com.setUsuario(usuario.getId_usuario());
com.setEstado(estado);
com.setFecha_inicio(fechaSystem);
com.setFecha_fin(null);
model.InsertAuditoriaComparendo(com);
%>
<script>
    alert("Comparendo <%=numero%> -> Solicitud registrada");
    document.location.href="AdicionarSolicitudAuditoria.jsp";
</script>
<%
}else{
%>
<script>
    alert("Comparendo <%=numero%> ya tiene una solicitud de audiencia");
    document.location.href="AdicionarSolicitudAuditoria.jsp";
</script>
<%
}


}else{
%>
<script>
    alert("Comparendo <%=numero%> no exite");
    document.location.href="AdicionarSolicitudAuditoria.jsp";
</script>
<%
}

model.getCon().commit();
}catch (Exception e){
model.getCon().rollback();
System.out.println("Error Procesar--->"+e);
}

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    <script type="text" language="text/javascript">
        alert("Solicitud Realizada Correctamente");
        document.location.href="AdicionarSolicitudAuditoria.jsp"
    </script>
    </head>
    <body>
        
    </body>
</html>

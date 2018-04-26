<%-- 
    Document   : RadicarTramite
    Created on : 28/11/2015, 10:45:41 AM
    Author     : Jefrey
--%>

<%@page import="java.util.List"%>
<%@page import="conf.civitrans.webservices.Runt.TramiteRNMA"%>
<%@page import="modelo.Model"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="procesos.*"%>
<%@page import="modelo.*"%>

<%
TramiteRNMA tramiteRNMA = new TramiteRNMA();

if(tramiteRNMA.registrarTramitesRNMA(request)){
out.println(tramiteRNMA.getMensaje());
List<Tramite> listramite = (List<Tramite>)session.getAttribute("listtramite");
listramite.remove(0);
session.setAttribute("listramite",listramite);
String p_placa = request.getParameter("hddnregistro").toUpperCase();
String p_tipo = request.getParameter("hddndocumento");
String p_numero = request.getParameter("hddntipodocumento");%>
%>
<jsp:forward page="FormularioRNMA.jsp">
    <jsp:param name="txtnumeromaquinaria" value="<%=p_placa%>"></jsp:param>
    <jsp:param name="txtdocumento"        value="<%=p_numero%>" ></jsp:param>
    <jsp:param name="cmdtipodocumento"    value="<%=p_tipo%>"></jsp:param>
</jsp:forward>
<%
}else{
out.println(tramiteRNMA.getMensaje()+" /* "+tramiteRNMA.getResultado()!=null?"":tramiteRNMA.getResultado());
}
%>

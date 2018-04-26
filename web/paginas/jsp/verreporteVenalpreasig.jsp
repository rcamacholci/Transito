<%--
    Document   : verreporteVenalpreasig
    Created on : 25/06/2013, 11:28:18 AM
    Author     : jjpadillag
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html"  pageEncoding="UTF-8" import="modelo.*,java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
Model model= (Model)session.getAttribute("model");
long id_rango=Long.parseLong(request.getParameter("rango")) ;
Rango rango=model.consultar_Rango(id_rango);
Parametro p=model.consultarParametro(rango.getTipo(), 161);
String placa = "";
if(request.getParameter("np")!=null){
            placa = request.getParameter("np").toUpperCase();
}
String estado = "0";
if(request.getParameter("est")!=null){
            estado = request.getParameter("est");
}%>
%>
<%

response.setContentType ("application/vnd.ms-excel"); //Tipo de fichero.
response.setHeader ("Content-Disposition", "attachment;filename=\"Reporte Placas Preasignadas.xls\"");

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
       <table width="90%" border="1" align="center" id="tabla_detalle" cellpadding="1" cellspacing="0">

  <tr bgcolor="#CCCCCC" style="border:none;background:url(../html/images/inicio_3.png)">
    <td width="10%" style="color:#000000;border:none"><div align="center" class="style3 style4"><strong>NUMERO</strong></div></td>
    <td width="30%" style="color:#000000;border:none"><div align="center" class="style5">ESTADO</div></td>
    <td width="30%" style="color:#000000;border:none"><div align="center" class="style5"><strong>RADICACION</strong></div></td>
    <td width="30%" style="color:#000000;border:none"><div align="center" class="style5"><strong>FECHA&nbsp;UTILIZADA</strong></div></td>
    <td width="30%" style="color:#000000;border:none"><div align="center" class="style5"><strong>FECHA&nbsp;PREASIGNADA</strong></div></td>
  </tr>

 <%
  List listaVenales = model.listarVenales(rango.getId_rango(),placa,estado);
  int cr = 10;//Cantidad Registros
  int id = Integer.parseInt(request.getParameter("id"));

  int size = listaVenales.size();
  for(int i=0;i<listaVenales.size();i++){
      Venal venal = (Venal)listaVenales.get(i);
      Parametro parametro = model.consultarParametro(venal.getEstado(), 162);
      String numeroRadicacion = "";
        String ultimoTramite = "";



     if(venal.getFk_radicacion()!=0){
         Radicacion radicacion = model.consultar_Radicacion(venal.getFk_radicacion());
         numeroRadicacion = radicacion.getNumero();
//		 ultimoTramite = model.consultarTramite(radicacion.getFk_trami
      }
     %>
      <%if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("editar_venal.jsp")){ %>
         <tr bgcolor="#FFFFFF" class="style3" id="<%=venal.getId_venal()%>"   ondblclick="ver_venales(this)"  >
        <%}else{%>
        <tr bgcolor="#FFFFFF" class="style3" id="<%=venal.getId_venal()%>" >
        <%}%>

        <td align="center" style="color:#000000"><div class="style2" style="font-size:12px"><%= venal.getNumero() %></div></td>
        <td align="center" style="color:#000000"><div class="style2" style="font-size:12px"><%= parametro.getNombre() %></div></td>
        <td align="center" style="color:#000000"><div class="style2" style="font-size:12px"><%=numeroRadicacion %></div></td>
        <td align="center" style="color:#000000"><div class="style2" style="font-size:12px"><%= venal.getFecha_utilizacion()==null?"": new java.text.SimpleDateFormat("dd/MM/yyyy").format(venal.getFecha_utilizacion())%></div></td>
        <%
        Venal_preasignacion venp = model.consultarVenalPreasignacionByVenal(venal.getId_venal());
        if(venp!=null){
        %>
        <td align="center" style="color:#000000"><div class="style2" style="font-size:12px"><%= venp.getFecha_ini()==null?"": venp.getFecha_ini()%></div></td>
        <% }else{ %>
        <td align="center" style="color:#000000"><div class="style2" style="font-size:12px">&nbsp;</div></td>
        <% } %>
     </tr>
<%}%>
</table>
    </body>
</html>

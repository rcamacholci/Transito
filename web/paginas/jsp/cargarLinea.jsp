<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<style type="text/css">
<!--
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
-->
</style>
<%  Model modelo = (Model) session.getAttribute("model");
try{
Preasignacion p = null;
String placa = request.getParameter("placa");
p=modelo.consultarPreasignacion(placa);
Integer linea=null;
if(p!=null){
linea = p.getLinea();
}else{
%>
<script>
    alert("La pacla no exite en la Preasignacion Runt");
</script>
<%
}

%>
 <span class="style2">NOMBRE DE LINEA:&nbsp;</span><input type="text" id="Flinea" name="Flinea" value="<%=linea%>" style="width:100px; text-align:center; font-size:11px; text-transform:uppercase;" readonly/>
 <%
 }catch (Exception e){
    javax.swing.JOptionPane.showMessageDialog(null,"no funciona--->"+e);
 }
 %>
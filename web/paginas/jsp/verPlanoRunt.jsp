<%--
    Document   : generarArchivoPlanoComparendos
    Created on : 16/07/2012, 10:10:30 AM
    Author     : digitalizacion
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
                        Model model = (Model) session.getAttribute("model");
%>
<html>
    <head>
        <title>Planos Comparendos</title>
      <style type="text/css">
<!--
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.style3 {color: #FFFFFF}
.style31 {color: #333333; font-size: 12px; font-weight: bold; font-family: Tahoma; }
.Estilo2 {
	color: #FFFFFF;
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
}
-->
</style>
        <meta http-equiv=Content-Type content="text/html; charset=windows-1252"/>
        <script type="text/javascript" src="../html/scripts/adicionarComparendo.js"></script>
        <script type="text/javascript">

        </script>
    </head>

<%
String fechaA = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.sql.Date(new java.util.Date().getTime()));
String nombre = "999999999CIA999"+fechaA;

response.setContentType ("application/vnd.ms-excel"); //Tipo de fichero.
response.setHeader ("Content-Disposition", "attachment;filename=\""+nombre+".xls\"");
%>

    <body>
        <div align="center">
            <div align="center" >
                <table border="1">
  <tr>
    <th scope="col">consecutivo</th>
    <th scope="col">creacion</th>
    <th scope="col">nit empresa</th>
    <th scope="col">numero de certificado o ACTA DE COMPROMISO</th>
    <th scope="col">tipo de documento</th>
    <th scope="col">numero de documento</th>
    <th scope="col">nombre</th>
    <th scope="col">apellido</th>
    <th scope="col">tipo de sancion</th>
    <th scope="col">numero de comparendo</th>
    <th scope="col">fecha de comparendo</th>
    <th scope="col">divipo</th>
    <th scope="col">codigo del departamento</th>
    <th scope="col">fecha del curso</th>
    <th scope="col">hora de inicio</th>
    <th scope="col">hora final</th>
    <th scope="col">valor del curso</th>
    <th scope="col">estado</th>
  </tr>
  <%

  java.util.List lista = model.consultarComparendoCiat();
  for(int i=0;i<lista.size();i++){
    Runt_Comparendos_Ciat rc = (Runt_Comparendos_Ciat)lista.get(i);
%>
  <tr>
    <td scope="col"><%=i+1%></td>
    <td scope="col"><%=rc.getCreacion() %></td>
    <td scope="col"><%= rc.getNit_empresa() %></td>
    <td scope="col"><%= rc.getNactacompromiso() %></td>
    <td scope="col"><%=rc.getTipod_doc() %></td>
    <td scope="col"><%=rc.getDocumento() %></td>
    <td scope="col"><%=rc.getNombres() %></td>
    <td scope="col"><%=rc.getApellidos() %></td>
    <td scope="col"><%=rc.getTipo_sancion() %></td>
    <td scope="col"><%=rc.getNumero_comparendo() %></td>
    <td scope="col"><%=rc.getFecha_comparendo() %></td>
    <td scope="col"><%=rc.getDivipo_comparendo() %></td>
    <td scope="col"><%=rc.getCodigo_departamento() %></td>
    <td scope="col"><%=rc.getFecha_curso() %></td>
    <td scope="col"><%=rc.getHora_ini() %></td>
    <td scope="col"><%=rc.getHora_fin() %></td>
    <td scope="col"><%=rc.getValor_Curso()  %></td>
    <td scope="col"><%=rc.getEstado_curso() %></td>
  </tr>
<%}%>
</table>

            </div>
        </div>
    </body>
</html>

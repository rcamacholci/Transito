<%-- 
    Document   : consultarHorariosCursos
    Created on : 30/05/2011, 02:35:58 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" pageEncoding="ISO-8859-1" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
    try {
        if (session.getAttribute("model") != null) {
            //if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
            if(1==1){
             modelo.Model model = (modelo.Model) session.getAttribute("model");
             long op=Long.parseLong(request.getParameter("doc"));
                    //model = (modelo.Model) session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                    modelo.Persona persona2 = model.consultarPersona(usuario.getFk_persona());
                    String nombreU = persona2.getNombre_1()+" "+persona2.getApellido_1()+" "+(persona2.getApellido_2()!=null?persona2.getApellido_2():"");
                    String fecha = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());        
             ;%>



<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listado de Horarios Cursos-Comparendos</title>
        <style type="text/css">
            .label {font-size: 11px; color:#666666; text-align:center ; font-family:Arial; font-weight:bold ; width:110px}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold }
            .date {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; width:100px }
            .bdate {font-size: 10px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .select {font-size: 11px; color:#003366; text-align:left ; font-family:Arial; font-weight:bold; width:120px }
            .input { width:130px }
            .check { font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; }
            .title {font-size: 12px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; text-transform:uppercase}
        </style>
        <script language="javascript" type="text/javascript">
            function sombrear(tr){
		tr.style.backgroundColor="#CCCCCC";
            }
            function renovar(tr){
                tr.style.backgroundColor="#FFFFFF";
            }
           // function show(opcion){
		//document.location.href = "programarCitacionComparendo.jsp?id="+opcion.id;
            //}
        </script>
    </head>
    <body>
        <div align="center">
            <div align="center" style="width:800px">
                <form name="form" method="post" action="javascript:validarFormulario()">
                    <fieldset>
                        <legend></legend>
                        <table border="0" align="center" width="790px" cellpadding="1" cellspacing="1">
                            <%    if(request.getParameter("excel").equals("1")){
response.setContentType ("application/vnd.ms-excel"); //Tipo de fichero.
response.setHeader ("Content-Disposition", "attachment;filename=\"AcuerdosDePagoFecha.xls\"");
%> <tr>
<td>Generado por:</td>
<td align="left"><%=nombreU%></td>
</tr>
<tr>
<td>Fecha:</td>
<td align="left"><%=fecha%></td>
</tr><%
} %>
                            <tr>
                                <td align="center" class="title">LISTADO DE REINCIDENTES</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    <table border="1" align="center" width="790px" cellpadding="0" cellspacing="0">
                                        <tr class="label">
                                            <%if(op==1){%>
                                            <td>#</td>
                                            <td>Docuemnto</td>
                                            <td>Nombre</td>
                                            <td>Apellido</td>
                                            <td>Seg Apellido</td>
                                            <td>Cantidad</td>
                                            <%}else{%>
                                            <td>#</td>
                                            <td>Placa</td>
                                            <td>Docuemnto</td>
                                            <td>Nombre</td>
                                            <td>Apellido</td>
                                            <td>Cantidad</td>
                                            <%}%>

                                        </tr>
                                        <%
                                            //java.sql.Date inicio = new java.sql.Date(new java.util.Date().getTime());
                                            //java.sql.Date fin = new java.sql.Date(new java.util.Date("12/12/2012").getTime());
                                            //java.util.List<modelo.Horario_Curso> horarios = model.consultarHorariosCursos(inicio,fin);
                                            //java.util.HashMap estados = model.crearHashParametros(351);
                                            //java.util.List aud = model.ListadoComparendo("01/01/2012","31/12/2012");
                                            //java.util.List<modelo.Comparendo> comp = model.ListadoComparendo(fi, ff);
                                            
                                            String fi = request.getParameter("fi");
                                            String ff = request.getParameter("ff");

                                            java.util.List<modelo.Rein> tempc = model.ListadoComparendo(fi,ff,op);

                                            int x=0;
                                            for(int i = 0;i<tempc.size();i++){
                                            modelo.Rein rein = tempc.get(i);
                                            modelo.Persona per = null;
                                            modelo.Vehiculo veh =null;
                                            java.util.List<modelo.Comparendo> comp=null;
                                            if(op==1){
                                            comp = model.listadoreincidentes(Long.parseLong(rein.getRein()),fi,ff);
                                            per = model.consultarPersona(Long.parseLong(rein.getRein()));
                                            }else{
                                            comp = model.listadoreincidentesbyplaca(rein.getRein(),fi,ff);
                                            //veh=model.consultarVehiculo(rein.getRein());
                                            modelo.Comparendo temp = comp.get(0);
                                            per = model.consultarPersona(temp.getFk_persona());
                                            }
                                            
                                            if(comp.size()>1){
                                                x+=1;
                                                if(op==1){
                                                                                %>
                                            <tr id="<%=rein.getRein()%>" class="text" ondblclick="show(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)" style="cursor:pointer">
                                                    <td><%=x%></td>
                                                    <td><%=per.getDocumento()%></td>
                                                    <td><%=per.getNombre_1()%></td>
                                                    <td><%=per.getApellido_1()%></td>
                                                    <td><%=per.getApellido_2()==null?"-----":per.getApellido_2()%></td>
                                                    <td><%=comp.size()%></td>
                                                    </tr>
                                              <%   }else{
                                                                               %>
                                            <tr id="<%=rein.getRein()%>" class="text" ondblclick="show(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)" style="cursor:pointer">
                                                    <td><%=x%></td>
                                                    <td><%=rein.getRein()%></td>
                                                    <td><%=per.getDocumento()%></td>
                                                    <td><%=per.getNombre_1()%></td>
                                                    <td><%=per.getApellido_1()%></td>
                                                    <td><%=comp.size()%></td>
                                                    </tr>
                                              <%   }
                                                   }
                                                }
                                            %>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </form>
            </div>
        </div>
    </body>
</html>
            <%}else {%>
                    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="1"></jsp:param></jsp:forward>
            <% }
          }else {%>
                <script>    window.parent.document.location.href = "../../index.jsp";</script>
      <%  }
    } catch (Exception mexe) {%>
        <jsp:forward page="no_access.jsp">
            <jsp:param name="tipo" value="2"></jsp:param>
            <jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param>
        </jsp:forward>
<%  }%>
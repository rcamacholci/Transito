<%-- 
    Document   : consultarHorariosCursos
    Created on : 30/05/2011, 02:35:58 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                modelo.Model model = (modelo.Model) session.getAttribute("model"); %>
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
            function show(opcion){
		document.location.href = "programarCitacionComparendo.jsp?id="+opcion.id;
            }
        </script>
    </head>
    <body>
        <div align="center">
            <div align="center" style="width:800px">
                <form name="form" method="post" action="javascript:validarFormulario()">
                    <fieldset>
                        <legend></legend>
                        <table border="0" align="center" width="790px" cellpadding="1" cellspacing="1">
                            <tr>
                                <td align="center" class="title">LISTADO DE HORARIOS PARA CURSOS DISPONIBLES</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    <table border="1" align="center" width="790px" cellpadding="0" cellspacing="0">
                                        <tr class="label">
                                            <td>#</td>
                                            <td>Fecha</td>
                                            <td>Hora</td>
                                            <td>Cupos</td>
                                            <td>Libres</td>
                                            <td>Estado</td>
                                        </tr>
                                        <%
                                            java.sql.Date inicio = new java.sql.Date(new java.util.Date().getTime());
                                            java.sql.Date fin = new java.sql.Date(new java.util.Date("12/12/2011").getTime());
                                            java.util.List<modelo.Horario_Curso> horarios = model.consultarHorariosCursos(inicio,fin);
                                            java.util.HashMap estados = model.crearHashParametros(351);
                                            for(modelo.Horario_Curso horarioCurso:horarios){ %>
                                            <tr id="<%=horarioCurso.getIdHorarioCurso() %>" class="text" ondblclick="show(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)" style="cursor:pointer">
                                                    <td><%=horarioCurso.getIdHorarioCurso() %></td>
                                                    <td><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(horarioCurso.getFecha()) %></td>
                                                    <td><%=new java.text.SimpleDateFormat("hh:mm").format(horarioCurso.getFecha()) %></td>
                                                    <td><%=horarioCurso.getCupos() %></td>
                                                    <td><%=0 %></td>
                                                    <td><%=estados.get(horarioCurso.getEstado()+"")%></td>
                                                </tr>
                                       <%   }
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
            <% } else {%>
                    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="1"></jsp:param></jsp:forward>
            <% }
          } else {%>
                <script>    window.parent.document.location.href = "../../index.jsp";</script>
      <%  }
    } catch (Exception mexe) {%>
        <jsp:forward page="no_access.jsp">
            <jsp:param name="tipo" value="2"></jsp:param>
            <jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param>
        </jsp:forward>
<%  }%>
<%-- 
    Document   : programarCitacionComparendo
    Created on : 30/05/2011, 03:46:03 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                if(request.getParameter("id")!=null){
                    modelo.Model model = (modelo.Model) session.getAttribute("model"); %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Listado de Horarios Cursos-Comparendos</title>
        <style type="text/css">
            .label {font-size: 11px; color:#666666; text-align:center ; font-family:Arial; font-weight:bold ; width:80px}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; width:80px}
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
            
        </script>
    </head>
    <body>
        <div align="center">
            <div align="center" style="width:800px">
                <form name="form" method="post" action="adicionarCitacionComparendo.jsp">
                    <fieldset>
                        <legend></legend>
                        <table border="0" align="center" width="790px" cellpadding="1" cellspacing="1">
                            <tr>
                                <td align="center" class="title">LISTADO DE CUPOS PARA EL CURSO</td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                            <%
                            long idHorarioCurso = Long.parseLong(request.getParameter("id"));
                            modelo.Horario_Curso horario = model.consultarHorarioCurso(idHorarioCurso);
                            if(horario!=null){
                                String fechaH = new java.text.SimpleDateFormat("dd/MM/yyyy").format(horario.getFecha());
                                String horaH = new java.text.SimpleDateFormat("hh:mm").format(horario.getFecha());
                                String estadoH = model.consultarParametroName(351, horario.getEstado());
                            %>
                            <tr>
                                <td>
                                    <table align="center" border="0" cellpadding="1" cellspacing="1" width="70%">
                                        <tr>
                                            <td class="label">Fecha</td>
                                            <td class="label">Hora</td>
                                            <td class="label">Cupos</td>
                                            <td class="label">Libres</td>
                                            <td class="label">Estado</td>
                                            <td class="label">&nbsp;</td>
                                            <td class="label">&nbsp;</td>
                                        </tr>
                                        <tr>
                                            <td align="center">
                                                <input type="hidden" name="idH" value="<%=horario.getIdHorarioCurso()%>"
                                                <input type="text" class="text" name="fecha" value="<%=fechaH%>" readonly/>
                                            </td>
                                            <td align="center"><input type="text" class="text" name="hora" value="<%=horaH%>" readonly/></td>
                                            <td align="center"><input type="text" class="text" name="cupos" value="<%=horario.getCupos()%>" readonly/></td>
                                            <td align="center"><input type="text" class="text" name="libre" value="<%=0%>" readonly/></td>
                                            <td align="center"><input type="text" class="text" name="estado" value="<%=estadoH%>" readonly/></td>
                                            <td align="center">&nbsp;</td>
                                            <td align="center"><input type="submit" class="text" name="agragar" value="Nueva"/></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>
                                    <table border="1" align="center" width="790px" cellpadding="0" cellspacing="0">
                                        <tr>
                                            <td class="label">Numero</td>
                                            <td class="label">Fecha</td>
                                            <td class="label">Hora</td>
                                            <td class="label">Documento</td>
                                            <td class="label" style="width:200px">Nombres</td>
                                            <td class="label">Comparendo</td>
                                            <td class="label">Pago CIA</td>
                                            <td class="label">Estado</td>
                                        </tr>
                                        <%
                                            java.util.List<modelo.Citacion_Comparendo> citaciones = model.consultarCitacionesComparendos(idHorarioCurso);
                                            java.util.HashMap estados = model.crearHashParametros(352);
                                            java.util.HashMap tipos = model.crearHashParametrosAbreviatura(5);
                                            for(modelo.Citacion_Comparendo citacion:citaciones){
                                                modelo.Persona persona = model.consultarPersona(citacion.getFkPersona());
                                                modelo.Comparendo comparendo = model.consultarComparendoById(citacion.getFkComparendo());
                                                modelo.Liquidacion_Cia liquidacion = model.consultarLiquidacionCIA(citacion.getFkComparendo(), citacion.getFkPersona());
                                                %>
                                                <tr id="<%=citacion.getIdCitacionComparendo()%>" class="text" ondblclick="show(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                                                    <td><%=citacion.getNumero() %></td>
                                                    <td><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(citacion.getFechaCitacion()) %></td>
                                                    <td><%=new java.text.SimpleDateFormat("hh:mm").format(citacion.getFechaCitacion()) %></td>
                                                    <td><%=tipos.get(persona.getTipo_documento())+" "+persona.getDocumento() %></td>
                                                    <td><%=persona.getNombre_1()+" "+persona.getApellido_1() %></td>
                                                    <td><%=comparendo.getNumero()%></td>
                                                    <td><%=liquidacion.getReferencia()%></td>
                                                    <td><%=estados.get(citacion.getEstado()) %></td>
                                                </tr>
                                       <%   }
                                        %>
                                    </table>
                                </td>
                            </tr>
                            <%
                            }
                             %>
                        </table>
                    </fieldset>
                </form>
            </div>
        </div>
    </body>
</html>
            <% }
                } else {%>
                    <jsp:forward page="../no_access.jsp"><jsp:param name="tipo" value="1"></jsp:param></jsp:forward>
            <% }
          } else {%>
                <script>    window.parent.document.location.href = "../../index.jsp";</script>
      <%  }
    } catch (Exception mexe) {%>
        <jsp:forward page="../no_access.jsp">
            <jsp:param name="tipo" value="2"></jsp:param>
            <jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param>
        </jsp:forward>
<%  }%>
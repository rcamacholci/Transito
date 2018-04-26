<%-- 
    Document   : adicionarHorarioCurso
    Created on : 30/05/2011, 04:13:43 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
            try {
                if (session.getAttribute("model") != null) {
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                        Model modelo = (Model) session.getAttribute("model");
                        Parametro parametro = new Parametro();
                        Sede sede = new Sede();
                        if (modelo != null) {
%>
<html>
    <head>
        <title>Adicionar Horario Curso Comparendo</title>
        <style type="text/css">
            .label {font-size: 11px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold ; width:110px}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ;  text-transform:uppercase}
            .date {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; width:100px }
            .bdate {font-size: 10px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .select {font-size: 11px; color:#003366; text-align:left ; font-family:Arial; font-weight:bold; width:120px }
            .input { width:130px }
            .check { font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; }
        </style>
        <link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script type="text/javascript">
            function validarDatos(){
                
            }
        </script>
    </head>
    <body>
        <div align="center">
            <div align="center" style="width:560px">
                <form name="form" method="post" action="javascript:validarDatos()">
                    <fieldset>
                        <legend></legend>
                        <table border="0" align="center" width="550px" cellpadding="1" cellspacing="1">
                            <tr>
                                <td align="center"><div class="text">ADICIONAR HORARIO CURSO</div></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                                <td>

                                    <table border="0" align="center" width="550px" cellpadding="1" cellspacing="2" style="border:none">
                                        <tr>
                                            <td class="label">Fecha</td>
                                            <td class="input"><input type="text" name="fecha" id="fecha" class="date"  style="background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onKeyUp="mascara(this,'/',true)" maxlength="10" />
                                                <input name="bfecha" type="button" id="bfecha" class="bdate" value="<<"/>
                                                <script type="text/javascript">
                                                    Calendar.setup({
                                                        inputField     :    "fecha",      // id del campo de texto
                                                        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                                        button         :    "bfecha"   // el id del botón que lanzará el calendario
                                                    });
                                                </script>
                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Hora&nbsp;<label class="label" style="font-size:9px; color:#003366">(hh:mm)</label></td>
                                            <td class="input">
                                                <select name="horas" class="select" style="width:45px">
                                                    <option>< - ></option>
                                                    <% for (int m = 0; m < 24; m++) {%>
                                                    <option><%=m%></option>
                                                    <% }%>
                                                </select>
                                                <select name="minutos" class="select" style="width:45px">
                                                    <option>< - ></option>
                                                    <% for (int s = 0; s < 60; s=s+10) {%>
                                                    <option><%=s%></option>
                                                    <% }%>
                                                </select>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">Numero de Cupos</td>
                                            <td class="input"><select name="cupos" class="select">
                                                    <option value="0" ><-Seleccione-></option>
                                                    <%  for(int i=1;i<=20;i++){ %>
                                                            <option value="<%=i%>"> <%=i%> </option>
                                                      <%}%>
                                                </select>
                                            </td>
                                            <td colspan="3">&nbsp;</td>
                                        </tr>
                                    </table></td>
                            </tr>
                            <tr>
                                <td colspan="5" align="center">
                                    <input type="submit" name="guardar" id="guardar" class="check" value="Guardar" />
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </form>
            </div>
        </div>
    </body>
</html>
<%   }
                    } else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<% }
                } else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%            }
            } catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="2"></jsp:param>
    <jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param>
</jsp:forward>
<%  }%>


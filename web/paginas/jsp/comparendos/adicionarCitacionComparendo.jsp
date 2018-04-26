<%-- 
    Document   : adicionarCitacionComparendo
    Created on : 30/05/2011, 06:09:49 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
            try {
                if (session.getAttribute("model") != null) {
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                        Model model = (Model) session.getAttribute("model");
                        if (model != null) {
%>
<html>
    <head>
        <title>Adicionar Horario Curso Comparendo</title>
        <style type="text/css">
            .label {font-size: 11px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold ; width:60px}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ;  text-transform:uppercase}
            .date {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; width:80px}
            .bdate {font-size: 10px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .name {font-size: 11px; color:#003366; text-align:left ; font-family:Arial; font-weight:bold; width:362px }
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
                if(document.form.comparendo.value.length>0){
                    document.form.action = "adicionarCitacionComparendo.jsp";
                    document.form.submit();
                }else{
                    alert("Digite numero del comparendo");
                }
            }

            function asignarC(){
                if(document.form.idComparendo.value!=0&&document.form.idH.value!=0){
                    document.form.action = "procesarCitacionComparendo.jsp";
                    document.form.submit();
                }
            }
        </script>
    </head>
    <body>
        <div align="center">
            <div align="center" >
                <form name="form" method="post" action="javascript:validarDatos()">
                    <fieldset>
                        <legend></legend>
                        <table border="0" align="center" width="480px" cellpadding="1" cellspacing="1">
                            <tr>
                                <td align="center"><div class="text">ASIGNACION DE CITACION PARA CURSO</div></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                            <%
                            long idHorarioCurso = Long.parseLong(request.getParameter("idH"));
                            modelo.Horario_Curso horario = model.consultarHorarioCurso(idHorarioCurso);
                            if(horario!=null){
                                String fechaH = new java.text.SimpleDateFormat("dd/MM/yyyy").format(horario.getFecha());
                                String horaH = new java.text.SimpleDateFormat("hh:mm").format(horario.getFecha());
                                String estadoH = model.consultarParametroName(351, horario.getEstado());
                            %>
                            <tr>
                                <td>
                                    <table align="center" border="0" cellpadding="1" cellspacing="1" width="100%">
                                        <tr>
                                            <td class="label" align="center">Fecha</td>
                                            <td class="label" align="center">Hora</td>
                                            <td class="label" align="center">Cupos</td>
                                            <td class="label" align="center">Libres</td>
                                            <td class="label" align="center">Estado</td>
                                        </tr>
                                        <tr>
                                            <td align="center"><input type="text" class="date" name="fecha" value="<%=fechaH%>" readonly/></td>
                                            <td align="center"><input type="text" class="date" name="hora" value="<%=horaH%>" readonly/></td>
                                            <td align="center"><input type="text" class="date" name="cupos" value="<%=horario.getCupos()%>" readonly/></td>
                                            <td align="center"><input type="text" class="date" name="libre" value="<%=0%>" readonly/></td>
                                            <td align="center"><input type="text" class="date" name="estado" value="<%=estadoH%>" readonly/></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                            <%
                                long idC = 0;
                                long idH = 0;
                                Comparendo comparendo = null;
                                String fecha = "";
                                String valor = "";
                                String nombres = "";
                                String reciboCia = "";
                                String valorCia = "";
                                if(request.getParameter("comparendo")!=null&&request.getParameter("idH")!=null){
                                    comparendo = model.consultar_Comparendo(request.getParameter("comparendo").trim());
                                    if(comparendo!=null){
                                        idC = comparendo.getId_comparendo();
                                        idH = Long.parseLong(request.getParameter("idH"));
                                        fecha = new java.text.SimpleDateFormat("dd/MM/yyyy").format(comparendo.getFecha());
                                        Cartera cartera = model.consultarCartera(comparendo.getFk_cartera());
                                        if(cartera!=null)
                                            valor = cartera.getSaldo()+"";
                                        Persona persona = model.consultarPersona(comparendo.getFk_persona());
                                        if(persona!=null){
                                            nombres = model.crearHashParametrosAbreviatura(5).get(persona.getTipo_documento()+"")+" "+persona.getDocumento()+" - "+persona.getNombre_1()+" "+persona.getApellido_1();
                                        }
                                        Liquidacion_Cia liquidacion = model.consultarLiquidacionCIA(comparendo.getId_comparendo(), comparendo.getFk_persona());
                                        if(liquidacion!=null){
                                            reciboCia = liquidacion.getReferencia();
                                            valorCia = liquidacion.getValor()+"";
                                        }
                                    }
                                } %>
                            <tr>
                                <td>

                                    <table border="0" align="center" width="480px" cellpadding="1" cellspacing="2" style="border:none">
                                        <tr>
                                            <td class="label">Comparendo</td>
                                            <td class="input">
                                                <input name="comparendo"  type="text" class="text"/>
                                                <input name="idComparendo" type="hidden" value="<%=idC%>"/>
                                                <input name="idH" type="hidden" value="<%=idH%>"/>

                                            </td>
                                            <td class="label" colspan="1">&nbsp;</td>
                                            <td class="label" colspan="1" align="center">
                                                <input name="buscar" class="check" type="submit" id="buscar" value="Buscar Comparendo"/>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">Fecha</td>
                                            <td class="input"><input name="fecha" type="text" class="text" value="<%=fecha%>" readonly/></td>
                                            <td class="label">Valor</td>
                                            <td class="input"><input name="valor" id="valor" type="text"  class="text" value="<%=valor%>" readonly/></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Persona</td>
                                            <td colspan="4"><input name="persona" type="text" class="name" value="<%=nombres%>" readonly/></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Recibo CIA</td>
                                            <td class="input"><input name="reciboCia" type="text" class="text" value="<%=reciboCia%>" readonly/>
                                            </td>
                                            <td class="label">Valor CIA</td>
                                            <td class="input"><input name="valorCia" type="text"  class="text" value="<%=valorCia%>" readonly/></td>
                                        </tr>
                                    </table></td>
                            </tr>
                            <tr>
                             <% if(comparendo!=null){ %>
                                    <td colspan="5" align="center">
                                        <input type="button" name="asignar" id="asignar" class="check" value="Asignar" onclick="asignarC()"/>
                                    </td>
                             <% } 
                            } %>
                            </tr>
                        </table>
                    </fieldset>
                </form>
            </div>
        </div>
    </body>
</html>
<%
}
        } else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<% }
                } else {%>
                <script type="text/javascript">
    window.parent.document.location.href = "../../index.jsp";
</script>  <%            }
            } catch (Exception mexe) {
mexe.printStackTrace(); %>
<jsp:forward page="../no_access.jsp">
    <jsp:param name="tipo" value="2"></jsp:param>
    <jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param>
</jsp:forward>
<%  }%>


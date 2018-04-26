<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
            try {
                if (session.getAttribute("model") != null) {
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("RangoComparendos.jsp")) {
                        Model modelo = (Model) session.getAttribute("model");
                         modelo.getCon().setAutoCommit(false);
                        Parametro parametro = new Parametro();
                        Sede sede = new Sede();
                        if (modelo != null) {
                            long id_rango = Long.parseLong(request.getParameter("idrango"));
                            
                            Rangos_Comparendos ran = modelo.consultarRangoComparendoByid_rango(id_rango);
                            long ini = Long.parseLong(ran.GetNum_Inicial());
                            long fin = Long.parseLong(ran.GetNum_Final());
                            long rango = fin-ini;

                            java.util.List temp = modelo.ListarRangosAgentesByrango(id_rango);
                            long x =temp.size();
                            if(temp!=null){                               
                                System.out.println("-->"+x);
                                rango=rango-x;
                            }
                            if(rango==x){
                               %>
                <script>
                    alert(" Los Usuarios se Actualizon Correctamente...");
                    window.location.href="RangoComparendos.jsp";
                </script>
                                <%
                            }
%>
<html>
    <head>
        <title>Adicionar Comparendo</title>
        <style type="text/css">
            .label {font-size: 11px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold ; width:110px}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; width:120px; text-transform:uppercase}
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
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script type="text/javascript" src="../html/scripts/adicionarComparendo.js"></script>
        <script type="text/javascript" src="../html/scripts/consultasGenerales.js"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
    </head>
    <body>
        <div align="center">
            <div align="center" style="width:560px">
                <form name="form" method="post" action="GuardarRangoAgentes.jsp">
                    <fieldset>
                        <legend></legend>
                      <table border="0" align="center" width="550px" cellpadding="1" cellspacing="1">
                            <tr>
                                <td align="center"><div class="text">ASIGNAR&nbsp;RANGOS&nbsp;Comparendos</div></td>
                            </tr>
                            <tr align="center">
                                <td  class="label" colspan="">Disponible:&nbsp;</td>
                             </tr>
                             <tr>
                             <td colspan="2"><input type="text" id="Faltante" name="Faltante" value="<%=rango%>"disabled class="text"/></td>
                             <input type="hidden" id="idrango" name="idrango" value="<%=id_rango%>">
                             </tr>
                            <tr>
                                <td>

                                    <table border="0" align="center" width="550px" cellpadding="1" cellspacing="2" style="border:none">
                                        
                                        <tr>
                                            <td colspan="5">
                                                <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                                    <tr>
                                                        <td class="label">Placa Agente </td>
                                                        <td><input type="text" name="placaAgente" onBlur="buscarAgente(this)" class="text"/></td>
                                                        <td colspan="3"><input name="nombreAgente" type="text" class="text" readonly onKeyPress="return soloNumeros(event)" style="width:300px"/></td>
                                                    </tr>
                                                    <tr>
                                                      <td class="label">
                                                    Numero de comparendos
                                                    </td>
                                                    <td>
                                                    <input type="text" id="Rangos" name="Rangos"  class="text"/>
                                                    </td>
                                                    <td><input type="submit" name="guardar" id="guardar" class="check" value="Guardar Rangos de Comparendos" />
                                                    
                                                    </td>
                                                    </tr>
                                                    
                                                </table></td>
                                        </tr>
                                        
                                    </table></td>
                            </tr>
                            <tr>
                                <td colspan="5" align="center"><iframe src="#" name="proceso" id="proceso" style="display:none"></iframe>
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
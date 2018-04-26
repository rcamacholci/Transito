<%-- 
    Document   : registrarPersonaSinHuella
    Created on : 12/11/2015, 12:15:51 PM
    Author     : Jefrey
--%>

<%@page import="com.heinsohn.runt.general.solicitudes.RegistrarAutorizacionSinHuellaOutDTO"%>
<%@page import="com.heinsohn.runt.autorizador.RadicacionService"%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*" import="java.util.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../html/scripts/motivossinhuella.js" type="text/javascript"></script>
        <style type="text/css">
            <!--
            .Estilo6 {
                font-family: Tahoma;
                font-size: 12px;
                font-weight: bold;
                color: #FFFFFF;
            }
            .Estilo9 {font-family: Tahoma; font-weight: bold; color: #333333; font-size: 12px; }
            -->
        </style>
        <title>Registrar Personas sin Huella</title>
    </head>
    <%
        Model model = (Model) session.getAttribute("model");
        Usuario usuario = (Usuario) session.getAttribute("usuario");
    %>
    <body>
        <form name="form" id="form" method="post" action="procesarRegistrarSinHuella.jsp">
            <fieldset>
                <table width="100%" border="0" align="center">

                    <tr style="border:none; background:url(../html/images/inicio_3.png)">
                        <td colspan="6" align="center"><span class="style2 style14 style3 Estilo6">REGISTRAR DATOS DE PERSONA</span></td>
                    </tr>
                    <tr>
                        <td width="17%"><span class="Estilo9">Tipo Documento</span></td>
                        <td>
                            <select name="tipoD" id="tipoD" style=" width:180px; color:#333333; font-size:11px">
                                <%
                                    List list = model.listadoParametros(5);
                                    Iterator it = list.iterator();
                                    while (it.hasNext()) {
                                        Parametro parametro = (Parametro) it.next();%>
                                <option value="<%=parametro.getNombreCorto()%>"><%=parametro.getNombre()%></option>
                                <%}%>
                            </select>	  
                        </td>
                        <td><div align="center" class="Estilo9">Documento</div></td>
                        <td><input type="text" name="documento" style="color:#333333; width:100px; text-align:center" /></td>
                        <td><div align="center" class="Estilo9">Nombres</div></td>
                        <td><input type="text" name="nombres" style="color:#333333; width:100px; text-align:center" /></td>
                    </tr>

                    <tr>
                        <th>Motivo</th>
                        <td>
                            <select name="cmbmotivo" id="cmbmotivo" onchange="listadoTramitesByMotivo()" onfocus="listadoTramitesByMotivo()" style=" width:180px; color:#333333; font-size:11px">
                                <option value="0">Seleccione</option>
                                <%
                                    List listDocumento = model.listadoParametros(331);
                                    for (int i = 0; i < listDocumento.size(); i++) {
                                        Parametro tipoD = (Parametro) listDocumento.get(i);
                                %>
                                <option value="<%=tipoD.getCodigo()%>"><%=tipoD.getNombre()%></option>
                                <%}%>
                            </select>
                        </td>
                        <td><div align="center" class="Estilo9">Entidad que certifica</div></td>
                        <td><input type="text" name="txtentidad" id="txtentidad"></td>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                    <tr>
                        <td><div align="center" class="Estilo9">Seleccione Tramite</div></td>
                        <td colspan="4">
                            <div id="cmbtramites">
                                <select name="cmbtramite" id="cmbtramite" style=" width:180px; color:#333333; font-size:11px">
                                    <option value="0">Seleccione</option>
                                </select>
                            </div>
                        </td>
                        <td><input type="submit" value="Enviar"></td>
                    </tr>

                </table>
            </fieldset>
        </form>
    </body>
</html>

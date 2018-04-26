<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Documento sin t&iacute;tulo</title>
        <script language="javascript" type="text/javascript">
            function nuevoAjax() {
                var xmlhttp = false;
                try {
                    xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
                } catch (e) {
                    try {
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                    } catch (E) {
                        xmlhttp = false;
                    }
                }

                if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
                    xmlhttp = new XMLHttpRequest();
                }

                return xmlhttp;
            }

            function actualizarEspecificaciones(cod, valor) {
                ajax = nuevoAjax();
                ajax.open("POST", "actualizarEspecificacion.jsp", true);
                ajax.onreadystatechange = function () {
                    if (ajax.readyState == 4) {
                        document.getElementById("valor" + cod).value = valor;
                    }
                }
                ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                ajax.send("codigo=" + cod + "&valor=" + valor);
            }

            function evaluar(espc, cod) {
                var salida = espc.value;
                if (isNaN(espc.value) && espc.value.length > 0) {
                    salida = "";
                    for (i = 0; i < espc.value.length; i++) {
                        if (!isNaN(espc.value.charAt(i))) {
                            salida += espc.value.charAt(i);
                        }
                    }
                }
                actualizarEspecificaciones(cod, salida);
            }
        </script>
        <style type="text/css">
            <!--
            .Estilo1 {
                color: #333333;
                font-size: 12px;
            }
            .Estilo3 {color: #333333; font-size: 12px; font-weight: bold; }
            .Estilo4 {color: #0066CC; font-size: 12px; font-weight: bold; }
            -->
        </style>
    </head>
    <%
        Model model = (Model) session.getAttribute("model");
        java.util.List especificaciones = model.listadoParametrosOrderByCodigo(40);
        java.util.HashMap hash_especificaciones = (java.util.HashMap) session.getAttribute("especificaciones");
        boolean enable = true;//model.isEnable((List) session.getAttribute("seleccionados"),5);
        String state = enable ? "" : "disabled";
        int id_tramite = Integer.parseInt(request.getParameter("id"));
    %>
    <input type="hidden" id="nespc" value="<%=especificaciones.size()%>" />
    <select name="codespc" id="codespc" style="display:none">
        <%   for (int i = 0; i < especificaciones.size(); i++) {
        Parametro parametro = (Parametro) especificaciones.get(i);%>
        <option value="<%=parametro.getCodigo()%>"><%=parametro.getCodigo()%></option>
        <%	} %>
    </select>
    <body>
        <table width="100%" border="0" style="border:none" align="center">
            <tr>
                <td width="45%">
                    <table width="100%" border="0" style="border:none">
                        <tr style="background:url(../html/images/inicio_3.png)">
                            <th width="41" scope="col"><span style="color: #FFFFFF"><font style="font-size:11px">COD.</font></span></th>
                            <th width="130" scope="col"><span style="color: #FFFFFF"><font style="font-size:11px">ESPECIFICACION</font></span></th>
                            <th width="118" scope="col"><span style="color: #FFFFFF"><font style="font-size:11px">VALOR</font></span></th>
                        </tr>
                        <%
                            for (int i = 0; i < 3; i++) {
                                Parametro parametro = (Parametro) especificaciones.get(i);
                                  String styleR = parametro.getNombreCorto() == null ? "Estilo3" : ((parametro.getNombreCorto().trim().length() == 0) ? "Estilo3" : "Estilo4");%>
                        <tr style="border-width:thick">
                            <th scope="row" style="border:none"><span class="<%=styleR%>"><%=parametro.getCodigo()%></span></th>
                            <td style="border:none"><span class="<%=styleR%>"><%=parametro.getNombre()%></span></td>
                            <td style="border:none">
                                <input name="valor<%=parametro.getCodigo()%>" type="text" id="valor<%=parametro.getCodigo()%>" value="<%=hash_especificaciones.get(parametro.getCodigo() + "") != null ? hash_especificaciones.get(parametro.getCodigo() + "") : ""%>" size="8" style="text-align:center; color:#0066CC; font-family:Arial, Helvetica, sans-serif;font-size:11px" onblur="evaluar(this,<%=parametro.getCodigo()%>)" <%=state%>/>
                            </td>
                            <input name="obligado<%=parametro.getCodigo()%>" type="hidden" id="obligado<%=parametro.getCodigo()%>" value="<%=(parametro.getNombreCorto() == null) ? 0 : ((parametro.getNombreCorto().trim().length() == 0) ? 0 : 1)%>"/>
                        </tr>
                        <%}%>
                    </table>
                </td>
                <td>&nbsp;</td>
                <td width="45%">
                    <table width="100%" border="0" style="border:none">
                        <tr style="background:url(../html/images/inicio_3.png)">
                            <th width="41" scope="col"><span style="color: #FFFFFF"><font style="font-size:11px">COD.</font></span></th>
                            <th width="130" scope="col"><span style="color: #FFFFFF"><font style="font-size:11px">ESPECIFICACION</font></span></th>
                            <th width="118" scope="col"><span style="color: #FFFFFF"><font style="font-size:11px">VALOR</font></span></th>
                        </tr>
                        <%
                            for (int i = 3; i < 7; i++) {
                                Parametro parametro = (Parametro) especificaciones.get(i);
                                String styleR = parametro.getNombreCorto() == null ? "Estilo3" : ((parametro.getNombreCorto().trim().length() == 0) ? "Estilo3" : "Estilo4");

                                if (id_tramite != 82) {
                        %>
                        <tr style="border-width:thick">
                            <th scope="row" style="border:none"><span class="<%=styleR%>"><%=parametro.getCodigo()%></span></th>
                            <td style="border:none"><span class="<%=styleR%>"><%=parametro.getNombre()%></span></td>
                            <td style="border:none"><input name="valor<%=parametro.getCodigo()%>" type="text" id="valor<%=parametro.getCodigo()%>" value="<%=hash_especificaciones.get(parametro.getCodigo() + "") != null ? hash_especificaciones.get(parametro.getCodigo() + "") : ""%>" size="8" style="text-align:center; color:#0066CC; font-family:Arial, Helvetica, sans-serif;font-size:11px" onblur="evaluar(this,<%=parametro.getCodigo()%>)" <%=state%>/></td>
                            <input name="obligado<%=parametro.getCodigo()%>" type="hidden" id="obligado<%=parametro.getCodigo()%>" value="<%=(parametro.getNombreCorto() == null) ? 0 : ((parametro.getNombreCorto().trim().length() == 0) ? 0 : 1)%>"/>
                        </tr>
                        <%  } else if(parametro.getCodigo()==9) {
                                %>
                        <tr style="border-width:thick">
                            <th scope="row" style="border:none"><span class="<%=styleR%>"><%=parametro.getCodigo()%></span></th>
                            <td style="border:none"><span class="<%=styleR%>"><%=parametro.getNombre()%></span></td>
                            <td style="border:none"><input name="valor<%=parametro.getCodigo()%>" type="text" id="valor<%=parametro.getCodigo()%>" value="<%=hash_especificaciones.get(parametro.getCodigo() + "") != null ? hash_especificaciones.get(parametro.getCodigo() + "") : ""%>" size="8" style="text-align:center; color:#0066CC; font-family:Arial, Helvetica, sans-serif;font-size:11px" onblur="evaluar(this,<%=parametro.getCodigo()%>)" <%=state%>/></td>
                            <input name="obligado<%=parametro.getCodigo()%>" type="hidden" id="obligado<%=parametro.getCodigo()%>" value="<%=(parametro.getNombreCorto() == null) ? 0 : ((parametro.getNombreCorto().trim().length() == 0) ? 0 : 1)%>"/>
                        </tr>
                                <%
                                }//end if;;
                            }%>
                    </table>
                </td>
            </tr>
        </table>

    </body>
</html>

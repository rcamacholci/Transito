<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("consultarFinanciacion_imp.jsp")) {
                modelo.Model model = (modelo.Model) session.getAttribute("model");
                modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
                response.setContentType("application/vnd.ms-excel"); //Tipo de fichero.
                response.setHeader("Content-Disposition", "attachment;filename=\"ReporteFinanciacionesImpuestos.xls\"");

%>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
            <!--
            .Estilo3 {font-size: 12px; color: #FFFFFF; }
            .Estilo4 {
                color: #333333;
                font-weight: bold;
                font-size: 12px;
            }
            -->
        </style>
        <script language="javascript" type="text/javascript">
            function verR(idr) {
                document.location.href = "verFinanciacion_Imp.jsp?idFinanciacion=" + idr + "&opcion=1";
            }
            function sombrear(tr, color) {
                tr.style.backgroundColor = color;
            }
            function renovar(tr) {
                tr.style.backgroundColor = "#FFFFFF";
            }
        </script>

    </head>
    <body>
        <table width="100%" border="1" cellpadding="1" cellspacing="0">
            <tr style="background:url(../html/images/inicio_3.png)">
                <th scope="col" width="5%"><span class="Estilo3">NUMERO</span></th>
                <th scope="col" width="15%"><span class="Estilo3">FINANCIACION </span></th>
                <th scope="col" width="35%"><span class="Estilo3">PERSONA</span></th>
                <th scope="col" width="15%"><span class="Estilo3">FECHA </span></th>
                <th scope="col" width="15%"><span class="Estilo3">VALOR</span></th>
                <th scope="col" width="10%"><span class="Estilo3">CUOTAS</span></th>
                <th scope="col" width="5%"><span class="Estilo3">VER</span></th>
            </tr>
            <%                  try {
                    Sede sede = (Sede) session.getAttribute("sede");
                    java.util.List<Financiacion_Imp> financiacion_Imps = null;
                    if (request.getParameter("fi") != null && request.getParameter("ff") != null) {
                        String fechaI = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.text.SimpleDateFormat("yyyy/MM/dd").parse(request.getParameter("fi")));
                        String fechaF = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.text.SimpleDateFormat("yyyy/MM/dd").parse(request.getParameter("ff")));
                        financiacion_Imps = model.consultarFinanciacionesFechas_Imp(fechaI, fechaF);
                        HashMap parameters = new java.util.HashMap();
                        parameters.put("USUARIO", usuario.getId_usuario() + "");
                        parameters.put("FECHA_INI", fechaI);
                        parameters.put("FECHA_FIN", fechaF);
                        session.setAttribute("reporteTramiteLicencias", parameters);
                    }
                    if (financiacion_Imps != null) {
                        for (int i = 0; i < financiacion_Imps.size(); i++) {
                            Financiacion_Imp financiacion_imp = financiacion_Imps.get(i);
                            Persona persona = model.consultarPersona(financiacion_imp.getFk_persona());
                            String tipoD = model.consultarParametro(persona.getTipo_documento(), 5).getNombreCorto();
                            String numeroD = persona.getDocumento();
                            String nombrePersona = persona.getNombre_1() + " " + persona.getApellido_1();
                            String color = "#FFFFFF";
                            switch (financiacion_imp.getEstado()) {
                                case 2:
                                    color = "#FFB366";
                                    break;
                                case 3:
                                    color = "#C0C0C0";
                                    break;
                                case 4:
                                    color = "#8AFF8A";
                                    break;
                                case 5:
                                    color = "#3C9DFF";
                                    break;
                                case 6:
                                    color = "#FF6F6F";
                                    break;
                            }
            %>
            <tr>
                <td><div align="center"><span class="Estilo4"><%=i + 1%></span></div></td>
                <td><div align="center"><span class="Estilo4"><%=financiacion_imp.getNumero()%></span></div></td>
                <td><div align="center"><span class="Estilo4"><%=tipoD + "  " + numeroD + "  -  " + nombrePersona%></span></div></td>
                <td><div align="center"><span class="Estilo4"><%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(financiacion_imp.getFecha())%></span></div></td>
                <td><div align="center"><span class="Estilo4"><%=financiacion_imp.getValor()%></span></div></td>
                <td><div align="center"><span class="Estilo4"><%=financiacion_imp.getCuotas()%></span></div></td>
                <td onMouseOver="sombrear(this, '<%=color%>')" onMouseOut="renovar(this)"><div align="center"><img src="../html/images/editar.png" height="16" width="16" onClick="verR('<%=financiacion_imp.getId_financiacion_Imp()%>')" style="cursor:pointer"/></div></td>
            </tr>
            <%          }
                    }
                } catch (Exception exc) {
                    exc.printStackTrace();
        }  %>
        </table>
    </body>
</html>
<%  } else { %>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }
        } else { %>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%
                    }
                } catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
    }%>
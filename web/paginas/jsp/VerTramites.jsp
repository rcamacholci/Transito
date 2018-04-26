<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("ReporteTramite.jsp")) {
                modelo.Model model = (modelo.Model) session.getAttribute("model");
                modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
                modelo.Persona persona = model.consultarPersona(usuario.getFk_persona());
                String nombreU = persona.getNombre_1() + " " + persona.getApellido_1();
                //////////
                long clase = Long.parseLong(request.getParameter("clase"));
                String titulo = "";
                if (clase == 1) {
                    titulo = "tramites de vehiculos";
                } else if (clase == 10) {
                    titulo = "tramites de motocicletas";
                } else if (clase == 4) {
                    titulo = "tramites de RNMA";
                } else {
                    titulo = "tramites de RNRYS";
                }

                titulo = titulo.toUpperCase();


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


        </script>

    </head>
    <body>
        <table width="60%" border="1" cellpadding="1" cellspacing="0" align="center">
            <tr style="background:url(../html/images/inicio_3.png)"><th class="Estilo3" colspan="2"><%=titulo%></th></tr>
            <tr style="background:url(../html/images/inicio_3.png)">
                <th width="70%" scope="col"><span class="Estilo3">TRAMITE</span></th>
                <th width="30%" scope="col"><span class="Estilo3">VALOR</span></th>

            </tr>
            <%
                try {
                    int x = titulo.length();
                    titulo = titulo.substring(12, x);
                    System.out.println(titulo);
                    long tramite = clase == 1 || clase == 10 ? 1 : clase;
                    clase = clase == 1 || clase == 10 ? clase : 1;
                    HashMap parameters = new java.util.HashMap();
                    parameters.put("USUARIO", nombreU);
                    parameters.put("CLASE", clase);
                    parameters.put("TRAMITE",tramite);
                    parameters.put("NOMBRE", titulo);

                    session.setAttribute("ReporteTramite", parameters);
                    TramiteValor tram = null;
                    java.util.List<TramiteValor> info = null;
                    info = model.Listatramites(clase, tramite);
                    x = info.size();
                    for (int i = 0; i < x; i++) {
                        tram = info.get(i);
            %>
            <tr>
                <td width="70%"><div align="center"><span class="Estilo4"><%=tram.getNombret()%></span></div></td>
                <td width="30%"><div align="center"><span class="Estilo4">$ <%=tram.getValor()%></span></div></td>
            </tr>

            <%
                }
            %>
        </table>
        <%
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
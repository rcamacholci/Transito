<%-- 
    Document   : mclc
    Created on : 4/05/2012, 05:35:37 PM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*"  import="modelo.Parametro"  import="java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<%
    System.out.println(".........................");
   
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("consultarRadicacion.jsp")) {
                modelo.Model model = (modelo.Model) session.getAttribute("model");
                modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");

%>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <style type="text/css">
        <!--
        .style1 {
            font-family: Tahoma;
            font-weight: bold;
            font-size: 12px;
            color: #333333;
        }
        .Estilo5 {	color: #333333;
                   font-size: 10px;
        }
        .style2 {
            color: #FFFFFF;
            font-weight: bold;
            font-size: 12px;
            font-family: Tahoma;
        }
        .Estilo3 {font-size: 12px; color: #FFFFFF; }
        .Estilo6 {font-size: 10px}
        .Estilo4 {color: #333333;font-size: 14px;}
        -->
    </style>
</head>
<body>
    <img style="float:right;" src="../html/images/reporte.png" alt="reporte" height="25" width="25" onclick="verReporte()"/>
    <table id="tvh" class="table table-striped table-bordered" style="width:100%">
        <thead align="center"> 
        <tr>
            <th>PLACA</th>
            <th>CLASE</th>
            <th>SERVICIO</th>
            <th>MARCA</th>
            <th>LINEA</th>
            <th>CARROCERIA</th>
            <th>PROPIETARIO</th>
        </tr>
       </thead>   
        <%                  try {
                long cl = Long.parseLong(request.getParameter("clase"));
                long mr = Long.parseLong(request.getParameter("marcas"));
                long ln = Long.parseLong(request.getParameter("lineas"));
                long ca = Long.parseLong(request.getParameter("carrocerias"));

                // javax.swing.JOptionPane.showMessageDialog(null,ca+" "+cl+" "+mr+" "+ln);
                HashMap parameters = new java.util.HashMap();
                parameters.put("CARROCERIA", ca);
                parameters.put("LINEA", ln);
                parameters.put("MARCA", mr);
                parameters.put("CLASE", cl);
                session.setAttribute("ReporteMclc", parameters);

                java.util.List<Mclc> info = model.consultaMclc(cl, ca, mr, ln);
                for (int i = 0; i < info.size(); i++) {
                    Mclc mc = info.get(i);
        %>
        <tr>
            <td><div align="center"><span class="Estilo4"><%=mc.getPlaca()%></span></div></td>
            <td><div align="center"><span class="Estilo4"><%=mc.getClase()%></span></div></td>
            <td><div align="center"><span class="Estilo4"><%=mc.getServicio()%></span></div></td>
            <td><div align="center"><span class="Estilo4"><%=mc.getMarca()%></span></div></td>
            <td><div align="center"><span class="Estilo4"><%=mc.getLinea()%></span></div></td>
            <td><div align="center"><span class="Estilo4"><%=mc.getCarroceria()%></span></div></td>
            <td><div align="center"><span class="Estilo4"><%=mc.getPropietario()%></span></div></td>
        </tr>
        <%

                    }

                } catch (Exception exc) {
                    exc.printStackTrace();
                }
            }

        %>
    </table>

</body>
</html>

<%  } else { %>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }
        } catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
    }%>

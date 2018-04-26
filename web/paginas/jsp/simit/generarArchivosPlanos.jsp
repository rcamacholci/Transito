<%-- 
    Document   : generarArchivosPlanos
    Created on : 25/03/2011, 09:41:36 AM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
  try{
     if(session.getAttribute("model") != null) {
        if (true ||((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
            modelo.Model model = (modelo.Model) session.getAttribute("model"); %>

<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Generar Planos</title>
        <style type="text/css">
            .title{font-size:16px;font-weight:bold;font-family:Arial;color:#003366;text-align:center}
            .label{font-size:12px;font-weight:bold;font-family:Arial;color:#666666;}
            .select{font-size:12px;font-weight:bold;font-family:Arial;color:#003366;}
            .button{font-size:12px;font-weight:bold;font-family:Arial;color:#003366;}
        </style>
    </head>
    <body>
        <div>
            <div>
                <form action="verArchivosPlanos.jsp" method="post" name="form" target="visual">
                    <table align="center" width="750px" border="1" cellpadding="1" cellspacing="0">
                        <tr>
                            <td colspan="4" align="center">
                                <label class="title">REPORTE DE ARCHIVOS PLANOS SIMIT</label>
                            </td>
                        </tr>
                        <tr>
                            <td width="240px">
                                <label class="label">Seleccione Plano Simit</label>
                            </td>
                            <td width="240px">
                                <select class="select" name="plano">
                                    <option value="1">Planos Comparendos</option>
                                    <option value="2">Planos Recaudos</option>
                                    <option value="3">Planos Resoluciones</option>
                                </select>
                            </td>
                            <td width="140px">
                                <select class="select" name="estado">
                                    <%  java.util.List lista = model.listadoParametrosOrderByCodigo(7);
                                    for(int i=0;i<lista.size();i++){
                                        modelo.Parametro parametro = (modelo.Parametro)lista.get(i); %>
                                        <option value="<%=parametro.getCodigo()%>"><%=parametro.getNombre()%></option>
                                <%  } %>
                                </select>
                            </td>
                            <td width="130px">
                                <input type="submit" class="button" name="consultar" value="Consultar Registros"/>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <iframe name="visual" frameborder="0" src="verArchivosPlanos.jsp" scrolling="auto" width="750px" height="400px"></iframe>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </body>
</html>
        <%     } else {%>
                    <jsp:forward page="no_access.jsp">
                        <jsp:param name="tipo" value="1"></jsp:param>
                    </jsp:forward>
            <% }
           } else {%>
              <script>
                   window.parent.document.location.href = "../../../index.jsp";
              </script>
  <%        }
      } catch (Exception mexe) {
        mexe.printStackTrace(); %>
        <jsp:forward page="no_access.jsp">
            <jsp:param name="tipo" value="2"></jsp:param>
            <jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param>
        </jsp:forward>
<%  }%>

<%--
    Document   : tiqueteAnterior
    Created on : 28/01/2014, 10:00:16 AM
    Author     : Administrador
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            try {
                if (session.getAttribute("model") != null) {
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("aplicarReciboExcedente.jsp")) {
                        Model model = (Model) session.getAttribute("model");
                        Usuario usuario = (Usuario) session.getAttribute("usuario");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
            <!--
            .style1 {
                font-size: 10px;
                font-family: Tahoma;
                font-weight: bold;
                color: #333333;
            }
            .style3 {font-weight: bold}
            .style4 {color: #333333}
            .style4 {color: #333333; font-size:10px; text-align:center}
            .Estilo1 {color: #FFFFFF}
            .Estilo3 {font-size: 10px; font-family: Tahoma; font-weight: bold; color: #333333; }
            .Estilo4 {font-size: 10px}
            .Estilo5 {color: #333333; font-size: 10px; }
            .Estilo6 {font-size: 10px; color:#333333;}
            .Estilo7 {color:#333333;}
            .Estilo8 {font-size: 14px; color:#333333;}
            -->
        </style>
        <script language="javascript" type="text/javascript">
           function guardarCambios(){
               alert(document.form.valor1.value);
               document.form.submit();
           }
        </script>
    </head>
    <body>
        <form name="form" method="post" action="procesarReciboExcedente.jsp">
            <input type="hidden" name="reciboN" id="reciboN" value="<%=request.getParameter("reciboN").toUpperCase() %>" />
            <input type="hidden" name="reciboV" id="reciboV" value="<%=request.getParameter("reciboV").toUpperCase() %>" />
            <table>
                <tr class="style1" style="border:none; background:url(../html/images/inicio_3.png)">
                    <th style="border:none"><span class="Estilo1 Estilo4" width="40">COD.</span></th>
                    <th style="border:none"><span class="Estilo1 Estilo4" width="50">CANT.</span></th>
                    <th style="border:none"><span class="Estilo1 Estilo4" width="110">CONCEPTO</span></th>
                    <th style="border:none"><span class="Estilo1 Estilo4" width="76">VALOR</span></th>
                    <th style="border:none"><span class="Estilo1 Estilo4" width="76">&nbsp;</span></th>
                </tr>
                <%
                                    if (request.getParameter("reciboV") != null) {
                                        Tiquete tiq = model.consultarTiqueteByFactura(request.getParameter("reciboV").toUpperCase());
                                        java.util.List list = model.CrearListaTiquetes(tiq.getId_tiquete());
                                        session.setAttribute("listadoConceptos", list);
                                        for (int i = 0; i < list.size(); i++) {
                                            ReciboExcedente re = (ReciboExcedente) list.get(i);
                %>
                <tr>
                    <td align="center"><span class="Estilo6"><%=re.getCodigo()%></span></td>
                    <td align="center"><span class="Estilo6"><%=re.getCantidad()%></span></td>
                    <td align="center" ><span class="Estilo6"><%=re.getConcepto()%></span></td>
                    <td align="center" ><span class="Estilo6">$<%=re.getValor()%></span></td>
                    <td align="center" ><span class="Estilo6"><input value="<%=re.getCodigo()%>" type="checkbox" name="valor1" id="valor1" checked></span></td>
                </tr>
                <%}
                    }%>
                    <tr>
                        <td colspan="5" align="left"><input type="submit" value="Aplicar" ></td>
                    </tr>
            </table>
        </form>
    </body>
</html>

<%  } else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }
        } else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%    }
} catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%            }%>
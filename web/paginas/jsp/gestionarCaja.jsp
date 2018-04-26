<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                Model modelo = (Model) session.getAttribute("model");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Abrir Caja</title>
        <style type="text/css">
            <!--
            .style1 {
                font-size: 12px;
                font-family: Tahoma;
                color: #333333;
            }
            .Estilo1 {
                color: #333333;
                font-weight: bold;
                font-size: 12px;
            }
            .button {
                background-color: #008CBA; /* Green */
                border: none;
                color: white;
                padding: 2px 15px;
                text-align: center;
                text-decoration: none;
                display: inline-block;
                font-size: 15px;
            }
            -->
        </style>

        <script language="javascript" type="text/javascript">
            function abrirCaja(icu) {
                document.form.action = "procesarCaja.jsp?id=1&icu=" + icu;
                document.form.submit();
            }
            function cerrarCaja(icu) {
                document.form.action = "procesarCaja.jsp?id=2&icu=" + icu;
                document.form.submit();
            }
        </script>
    </head>

    <body>
        <center>
            <%@ page import="modelo.*"%>
            <%@page import="java.util.*"%>
            <form id="form" name="form" method="post" action="procesarCaja.jsp" style="width:60%">
                <p>&nbsp;  </p>
                <fieldset><div align="center">
                        <legend align="center" class="style2 style1"><strong>APERTURA Y CIERRE DE CAJAS DE LIQUIDACION </strong></legend>
                    </div>
                    <table width="57%" border="0" align="center">
                        <td>&nbsp; </td>

                        <%
                            Usuario user = (Usuario) session.getAttribute("usuario");
                            java.util.List lista = modelo.consultarCajasUsuario(user.getId_usuario());
                            int taquillaP = -1;
                            Taquilla taq = modelo.TaquillasSinDistribuirByUsuario(user.getId_usuario());

                            if (taq != null) {
                                Caja box = modelo.consultarCaja(taq.getFk_caja());

                        %>
                        <tr>
                            <td><div align="center" class="Estilo1">USTED POSEE UNA TAQUILLA PENDIENTE POR DISTRIBUIR DEL DIA <%=new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm").format(taq.getFecha_ini())%>!! </div></td>
                        </tr>
                        <tr>
                            <td align="Center">
                                <a class="button" href="lista_taquillas.jsp?codigo=<%=box.getId_caja()%>&nombre=<%=box.getNombre().trim()%>&date=<%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(taq.getFecha_ini())%>&date2=<%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date())%>"> Distribuir Aqui! </a>
                            </td>
                        </tr>
                        <%
                        } else {

                            for (int i = 0; i < lista.size(); i++) {
                                UsuarioCaja usuarioCaja = (UsuarioCaja) lista.get(i);
                                Taquilla taquilla = modelo.consultar_Taquilla(usuarioCaja.getFk_caja(), usuarioCaja.getFk_sede(), usuarioCaja.getFk_usuario());
                                if (taquilla != null) {
                                    if (taquilla.getEstado() == 1) {
                                        String fechaA = new java.text.SimpleDateFormat("MM/dd/yyyy").format(new java.sql.Date(taquilla.getFecha_ini().getTime()));
                                        String fechaB = new java.text.SimpleDateFormat("MM/dd/yyyy").format(new java.sql.Date(new java.util.Date().getTime()));
                                        if (!fechaA.equals(fechaB)) {
                                            taquilla.setEstado(3);
                                            float total = modelo.consultarValorTaquilla(taquilla.getId_taquilla());
                                            taquilla.setValor_nota_debito(total);
                                            taquilla.setValor_taquilla(total);
                                            taquilla.setFecha_ini(new java.sql.Timestamp(new java.util.Date().getTime()));
                                            modelo.actualizarTaquilla(taquilla, taquilla.getId_taquilla());
                                            modelo.getCon().commit();
                                        } else {
                                            taquillaP = i;
                                            break;
                                        }
                                    }
                                }
                            }

                            for (int i = 0; i < lista.size() && user.getId_usuario() != 1000; i++) {
                                UsuarioCaja usuarioCaja = (UsuarioCaja) lista.get(i);
                                Taquilla taquilla = modelo.consultar_Taquilla(usuarioCaja.getFk_caja(), usuarioCaja.getFk_sede(), usuarioCaja.getFk_usuario());
                                Caja caja = modelo.consultarCaja(usuarioCaja.getFk_caja());
                                if (caja.getFecha_fin() == null) {
                                    boolean estadoTaquilla = taquilla != null ? (taquilla.getEstado() == 1 ? true : false) : false;
                                    String habilitarTaquilla = (taquillaP != i && taquillaP != -1) ? "disabled" : ""; %>
                        <tr>
                            <td align="center">
                                <div align="center">
                                    <% if (estadoTaquilla) {%>
                                    <input type="button" style="width:400px" name="Submit" value="CERRAR <%=caja.getNombre()%>"  onclick="cerrarCaja('<%=usuarioCaja.getId_usuarioCaja()%>')" <%=habilitarTaquilla%>/>
                                    <% } else {%>
                                    <input type="button" style="width:400px" name="Submit" value="ABRIR <%=caja.getNombre()%>"  onclick="abrirCaja('<%=usuarioCaja.getId_usuarioCaja()%>')" <%=habilitarTaquilla%>/>
                                    <% } %>
                                </div>
                            </td>
                        </tr>
                        <tr>
                            <td>&nbsp;</td>
                        </tr>

                        <% }
                                }
                            }

                            if (lista.size() == 0 && taq == null) { %>
                        <tr>
                            <td><div align="center" class="Estilo1">USTED NO POSEE CAJAS ASIGNADAS!! </div></td>
                        </tr>
                        <% } %>
                    </table>
                </fieldset>
            </form>

        </center>
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

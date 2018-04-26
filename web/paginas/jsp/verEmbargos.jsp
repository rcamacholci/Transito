<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("consultarEmbargosVehiculo.jsp")) {
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Especificaciones</title>
        <script type="text/javascript" src="../html/scripts/embargos.js"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>

        <link title="win2k-cold-1" media="all" href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet" />
        <link rel="stylesheet" href="../html/css/msj.css" type="text/css" media="screen"/>
        <script type="text/javascript" src="../html/scripts/calendar.js"></script>
        <script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
        <script type="text/javascript" src="../html/scripts/calendar-es.js"></script>

        <style type="text/css">
            <!--

            .style5 {color: #333333}
            .style6 {
                font-family: Tahoma;
                font-size: 12px;
            }
            .style7 {font-family: Tahoma}
            .style9 {
                color: #333333;
                font-family: Tahoma;
                font-size: 12px;
                font-weight: bold;
            }
            .style10 {font-family: Tahoma; font-size: 12px; font-weight: bold; }
            .Estilo3 {font-size: 10px}
            .Estilo4 {font-family: Tahoma; font-size: 10px; font-weight: bold; }
            .Estilo6 {color: #333333; font-size: 10px; }
            .Estilo7 {color: #333333; font-family: Tahoma; font-size: 10px; font-weight: bold; }





            .Estilo13 {color: #FFFFFF; font-weight: bold; }
            .Estilo20 {font-size: 11px; font-weight: bold; color: #666666; }
            .style4 {color: #FFFFFF; font-weight: bold; font-size: 11px; font-family: Tahoma; }
            .style8 {font-size: 11px; font-weight: bold; color: #333333; font-family: Tahoma; }
            -->
        </style>





    </head>
    <%@ page import="modelo.*"%>
    <%@page import="java.util.*"%>

    <%
        Model modelo = (Model) session.getAttribute("model");
        String placa = "";
        if (request.getParameter("id") == "0") {
            placa = request.getParameter("placa");
        } else {
            placa = session.getAttribute("placa") + "";
        }
        if (placa != null) {
            Vehiculo vehiculo = new Vehiculo();
            vehiculo = modelo.consultarVehiculo(placa.toUpperCase());
            if (vehiculo != null) { %>
    <body>
        <table width="100%" border="1"  cellpadding="1" cellspacing="0">
            <tr style="border:none; background:url(../html/images/inicio_3.png)">
                <td width="30%" style="border:none"><div align="center" class="style4">OFICINA</div></td>
                <td width="40%" style="border:none"><div align="center" class="style4">DEMANDANTE</div></td>
                <td width="10%" style="border:none"><div align="center" class="style4">TIPO </div></td>
                <td width="5%" style="border:none"><div align="center" class="style4">F.&nbsp;OFICIO</div></td>
                <td width="5%" style="border:none"><div align="center" class="style4">N&ordm;&nbsp;OFICIO</div></td>
                <td width="5%" style="border:none"><div align="center" class="style4">F.&nbsp;LEVANTE</div></td>
                <td width="5%" style="border:none"><div align="center" class="style4">N&ordm;&nbsp;LEVANTE</div></td>
                <td width="5%" style="border:none"><div align="center" class="style4">F.&nbsp;INGRESO</div></td>
            </tr>
            <%java.util.List lista = modelo.consultarEmbargos(vehiculo.getId_vehiculo());
                boolean color = true;

                for (int i = 0; i < lista.size(); i++) {
                    Embargo embargo = (Embargo) lista.get(i);
                    Oficina_Juridica oficina_juridica = modelo.consultarOficinaJuridica(embargo.getFk_oficina());
                    String nombre = "";
                    if (embargo.getDemandante() != null) {
                        nombre = embargo.getDemandante();
                    }
                    /*String nombres = "";
                  if(persona.getTipo_documento()!=2){
                      nombres = persona.getNombre_1()+" "+persona.getApellido_1()+" "+persona.getApellido_2();
                  }else{
                      nombres = persona.getNombre_1();
                  }*/
                    String tipo_embargo = modelo.consultarParametroName(341, embargo.getTipo());
            %>
            <tr bgcolor="#FFFFFF" style="cursor:pointer "  onclick="EditarEmb('<%=i%>', '<%=embargo.getId_embargo()%>')">
                <%if (oficina_juridica != null) {%>
                <td align="center"><span class="style8"><%=oficina_juridica.getNombre()%></span></td>
                    <% } else {%>
                <td align="center"><span class="style8">NO REGISTRA</span></td>
                <%}%>
                <td align="center"><span class="style8"><%=nombre.toUpperCase()%></span></td>
                <td align="center"><span class="style8"><%=tipo_embargo%></span></td>
                <td align="center"><span class="style8"><%out.print(embargo.getFecha_oficio() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(embargo.getFecha_oficio()) : "");%></span></td>
                <td align="center"><span class="style8"><%=embargo.getOficio()%></span></td>
                <td align="center"><span class="style8"><%=embargo.getFecha_levantamiento() != null ? embargo.getFecha_levantamiento() : ""%></span></td>
                <td align="center"><span class="style8"><%=embargo.getNro_levantamiento() != null ? embargo.getNro_levantamiento() : ""%></span></td>
                <td align="center"><span class="style8"><%=embargo.getFecha_proceso() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(embargo.getFecha_proceso()) : ""%></span></td>
            </tr><tr id="edEmb<%=i%>" style="display:none; height:0px">
                <td colspan="7">
                    <div class="box">
                        <div id="editarEmbargo<%=i%>" class="content"></div>
                    </div>
                </td>
            </tr>
            <%  color = !color;
                }
            %>
        </table>
        <% }
            }
        %>
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
                } catch (Exception mexe) {
                    mexe.printStackTrace();%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
    }%>
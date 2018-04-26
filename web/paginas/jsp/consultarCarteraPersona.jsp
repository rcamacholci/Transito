<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.io.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
        if(session.getAttribute("model")!=null){
                if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title> Cartera Vehiculo </title>
        <style type="text/css">
            <!--
            .Estilo2 {color: #FFFFFF; font-weight: bold; }
            .Estilo4 {color: #333333; font-weight: bold; }
            .style1 {
                color: #333333;
                font-family: Tahoma;
                font-size: 12px;
            }
            .style2 {color: #333333; font-weight: bold; }
            .style4 {
                font-family: Tahoma;
                font-size: 12px;
                font-weight: bold;
                color: #333333;
            }
            .style6 {
                font-family: Tahoma;
                font-weight: bold;
                color: #333333;
                font-size: 12px;
            }
            .style8 {color: #333333; font-weight: bold; font-size: 16px; }
            .style9 {color: #FFFFFF}
            .style10 {font-family: Tahoma; font-size: 12px; font-weight: bold; color: #FFFFFF; }
            -->
        </style>
        <script language="javascript">
            function verDetallecartera(cartera){
                window.frames[0].location.href = "consultarDetalleCartera.jsp?id_cartera="+cartera;
                sombrear(cartera);
            }
            function sombrear(cartera){
                //renovar();
                cartera.style.backgroundColor="#CCCCCC";
            }
            function renovar(){
                var filas = document.getElementById('tabla').getElementsByTagName('tr');
                for(i=1;i<filas.length;i++){
                    filas[i].style.backgroundColor="#FFFFFF";
                }
            }
        </script>
    </head>
    <%@ page import="modelo.*"%>
    <%@page import="java.util.*"%>
    <body>
        <%
                            Cartera cartera = new Cartera();

                            Model modelo = (Model) session.getAttribute("model");
                            String id_persona = "";
                            if (request.getParameter("id").equals("0")) {
                                id_persona = request.getParameter("id_persona");
                            } else {
                                if (session.getAttribute("id_persona") != null) {
                                    id_persona = session.getAttribute("id_persona").toString();
                                }
                            }
                            if (!id_persona.equals("")) {
                                Persona persona = modelo.consultarPersona(Long.parseLong(id_persona));
                                if (persona != null) {
        %>
        <div align="center" class="style6">INFORMACION DE CARTERA PARA <%=persona.getNombre_1() + " " + (persona.getNombre_2() != null ? persona.getNombre_2() : "") + " " + persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "")%></div>
        <br/>
        <fieldset><div align="center">
                <legend class="style6"  align="center">COMPARENDOS</legend>
            </div>
            <table width="100%"  border="1" cellpadding="1" cellspacing="0" bordercolor="#FFFFFF" id="tabla">
                <tr bgcolor="#CCCCCC" bordercolor="#333333" style="border:none; background:url(../html/images/inicio_3.png)">
                    <td width="30%" style="border:none"><div align="center" class="Estilo2 style1 style9">CONCEPTO</div></td>
                    <td width="25%" style="border:none"><div align="center" class="style10">TIPO CARTERA</div></td>
                    <td width="9%" style="border:none"><div align="center" class="style10">REFERENCIA</div></td>
                    <td width="8%" style="border:none"><div align="center" class="style10">FECHA</div></td>
                    <td width="10%" style="border:none"><div align="center" class="style10">ESTADO</div></td>
                    <td width="9%" style="border:none"><div align="center" class="style10">VALOR</div></td>
                    <td width="9%" style="border:none"><div align="center" class="style10">SALDO</div></td>
                </tr><%
                  //modelo.actualizarInteresesVehiculos(vehiculo.getId_vehiculo(),usuario.getId_usuario());
                  //modelo.actualizarCostasVehiculos(vehiculo.getId_vehiculo(),usuario.getId_usuario());
                  List cartera_persona = modelo.crearListaCarteraPersona(persona.getId_persona());
                  Iterator itt = cartera_persona.iterator();
                  float total = 0;
                  while (itt.hasNext()) {
                      cartera = (Cartera) itt.next();
                      Concepto concepto = modelo.consultarConcepto(cartera.getFk_concepto());
                      Parametro parametro = modelo.consultarParametro(cartera.getEstado_cartera(), 21);
                      Parametro param = modelo.consultarParametro(cartera.getTipo(), 25);
                      total = (float) (total + cartera.getSaldo());
                %>
                <tr id="<%=cartera.getId_cartera()%>" onclick="verDetallecartera('<%=cartera.getId_cartera()%>')" bordercolor="#333333" style="cursor:pointer">
                    <td style="font-size:12px"><span class="style2"><%=concepto.getNombre()%> </span></td>
                    <td style="font-size:12px" align="center"><span class="style2"><strong><%=param.getNombre()%> </strong></span></td>
                    <td style="font-size:12px" align="center"><span class="style2"><strong><%=cartera.getReferencia()%> </strong></span></td>
                    <td style="font-size:12px" align="center"><span class="style2"><strong><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(cartera.getFecha_creacion())%></strong></span></td>
                    <td style="font-size:12px" align="center"><span class="style2"><strong><%=parametro.getNombre()%></strong></span></td>
                    <td style="font-size:12px" align="right"><span class="style2"><strong>$&nbsp;<%=cartera.getValor()%> </strong></span></td>
                    <td style="font-size:12px" align="right"><span class="style2"><strong>$&nbsp;<%=cartera.getSaldo()%> </strong></span></td>
                </tr>
                <%
    }// fin del while
%>
                <tr>
                    <td style="font-size:12px; border:none">&nbsp; </td>
                    <td style="font-size:12px; border:none">&nbsp;</td>
                    <td style="font-size:12px; border:none">&nbsp;</td>
                    <td style="font-size:12px; border:none">&nbsp;</td>
                    <td style="font-size:12px; border:none" >&nbsp;</td>
                    <td bgcolor="#CCCCCC" style="background:url(../html/images/inicio_3.png)"><div align="center" class="style4 style9">TOTAL</div></td>
                    <td style="font-size:12px" align="right"><span class="style8">$&nbsp;<%=total%> </span></td>
                </tr>
                <%}
} else {%>
                <script>
                    alert("Digite numero de documento");
                    window.href="consultar_persona.jsp";
                </script>
                <% }
                %>
            </table>
        </fieldset>
        <br/>
        <br/>
        <iframe src="consultarDetalleCartera.jsp?id" id="detalle_cartera" name="detalle_cartera" marginwidth="0" height="280" width="100%" marginheight="0" align="top" scrolling="auto" style="border:none"></iframe>

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
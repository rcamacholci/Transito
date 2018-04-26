<%--
    Document   : verCarteraLiquidacion
    Created on : 03-ene-2009, 16:12:36
    Author     : WALTER E
--%>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*"  import="modelo.Parametro" import="modelo.Vehiculo" import="modelo.Cartera" import="modelo.Concepto"  import="modelo.Propietario"  import="modelo.Persona"  import="modelo.Liquidacion" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<html>
    <head>
        <title></title>
        <script src="../html/scripts/financiacion_Imp.js" type="text/javascript"></script>
        <script language="javascript" type="text/javascript">
            function sombrear(tr){
                tr.style.backgroundColor="#CCCCCC";
            }
            function renovar(tr){
                tr.style.backgroundColor="#FFFFFF";
            }
        </script>
        <style type="text/css">
            .Estilo1{
                font-size: 11px;
                color:#003366;
                text-align:center ;
                font-family:Arial;
                font-weight:bold ;
            }
            .label {font-size: 11px; color:#333333; text-align:center ; font-family:Arial; font-weight:bold ;}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ;}
        </style>
    </head>
    <body>
        <%
                    if (request.getParameter("id").equals("1")) {//cartera por placa
                        String placa = request.getParameter("placa").toUpperCase();
                        try {
                            Model model = (Model) session.getAttribute("model");
                            Usuario usuario = (Usuario) session.getAttribute("usuario");
                            Vehiculo vehiculo = model.consultarVehiculo(placa);

                            if (vehiculo != null) {
                                java.util.LinkedList carteras = model.crearListaCarteraPlaca(vehiculo.getId_vehiculo(), usuario.getId_usuario());
                                boolean posible = true;

                                for (int i = 0; i < carteras.size(); i++) {
                                    Cartera cartera = (Cartera) carteras.get(i);
                                    if (cartera.getTipo() == 3 && cartera.getEstado_cartera() == 1) {
                                        posible = false;
                                        break;
                                    }
                                }
                                if (carteras.size() > 0) {
                            if (posible) {%>
        <table width="100%" border="1" cellpadding="1" cellspacing="0" id="tabla">
            <thead style="position: relative;">
                <tr>
                    <td width="4%" scope="col">&nbsp;</td>
                    <td width="14%" scope="col" class="label">PLACA</td>
                    <td width="50%" scope="col" class="label">CONCEPTO</td>
                    <td width="15%" scope="col"  class="label">REFERENCIA</td>
                    <td width="14%" scope="col" class="label">VALOR</td>
                </tr>
            </thead>
            <tbody>
                <%
                          for (int i = 0; i < carteras.size(); i++) {
                              Cartera cartera = (Cartera) carteras.get(i);
                              if (cartera.getEstado_cartera() == 1 /*&& !cartera.getReferencia().equals("2012") && !cartera.getReferencia().equals("2013")*/) {
                                            Concepto concepto = model.consultarConcepto(cartera.getFk_concepto());%>
                <tr  id="<%=cartera.getId_cartera()%>" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                    <td style="cursor:pointer;">
                        <input style="cursor:pointer;" type="checkbox" onclick="actualizarTipoF(this)" name="valor_cartera" id="<%=cartera.getId_cartera()%>" value="<%=cartera.getSaldo()%>"/></td>
                    <td class="text"><%=vehiculo.getPlaca()%></td>
                    <td class="text"><%=concepto.getNombre()%></td>
                    <td class="text"><%=cartera.getReferencia()%></td>
                    <td class="text"><%=cartera.getSaldo()%></td>
                </tr>
                <%   }
                  }
                %>
            </tbody>
        </table>
        <%
} else {
        %>
        <label>
            <span class="Estilo1">YA POSEE FINANCIACIONES PENDIENTES</span>&nbsp;<%=placa%></label>
            <%
}
} else {
            %>
        <label>
            <span class="Estilo1">NO POSEE CARTERAS ACTIVAS&nbsp;<%=placa%></span>
        </label>
        <%
}
} else {
        %>
        <label>
            <span class="Estilo1">VEHICULO NO POSEE REGISTROS DE CARTERA&nbsp;<%=placa%></span>
        </label>
        <%
}
} catch (Exception exc) {
out.println("No Conectado a Oracle");
}
} else {
if (request.getParameter("id").equals("2")) {//cartera de persona
String tipo = request.getParameter("tipo");
String documento = request.getParameter("documento");
try {
Model model = (Model) session.getAttribute("model");
Persona persona = model.consultarPersona(Integer.parseInt(tipo), documento);
if (persona != null) {
java.util.LinkedList carteras = model.crearListaCarteraPersona(persona.getId_persona());
boolean posible = true;
for (int i = 0; i < carteras.size(); i++) {
    Cartera cartera = (Cartera) carteras.get(i);
    if (cartera.getTipo() == 3 && cartera.getEstado_cartera() == 1) {
        posible = false;
        break;
    }
}
if (carteras.size() > 0) {
                     if (posible) {%>
        <table width="100%" border="1" id="tabla" cellpadding="1" cellspacing="0">
            <tr>
                <td width="4%" scope="col">&nbsp;</td>
                <td width="64%" scope="col" class="label">CONCEPTO</td>
                <td width="15%" scope="col"  class="label">REFERENCIA</td>
                <td width="14%" scope="col" class="label">VALOR</td>
            </tr>
            <%
java.util.HashMap tiposAbr = model.crearHashParametrosAbreviatura(5);
for (int i = 0; i < carteras.size(); i++) {
  Cartera cartera = (Cartera) carteras.get(i);
                                                if (cartera.getEstado_cartera() == 1) {
                                                    Concepto concepto = model.consultarConcepto(cartera.getFk_concepto());%>
            <tr id="<%=cartera.getId_cartera()%>" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                <td align="center" style="cursor:pointer;">
                    <input style="cursor:pointer;" type="checkbox" onclick="actualizarTipoF(this)" name="valor_cartera" id="<%=cartera.getId_cartera()%>" value="<%=cartera.getSaldo()%>"/></td>
                <td class="text"><%=concepto.getNombre()%></td>
                <td class="text"><%=cartera.getReferencia()%></td>
                <td class="text"><%=cartera.getSaldo()%></td>
            </tr>
            <%   }
                                            }%>
        </table>
        <%				 } else {
        %>
        <label>
            <span class="Estilo1">PERSONA YA POSEE FINANCIACIONES PENDIENTES POR CANCELAR</span></label>
            <%                                    }
} else {
            %>
        <label>
            <span class="Estilo1">NO POSEE CARTERAS ACTIVAS</span>
        </label>
        <%                             }
} else {
        %>
        <label>
            <span class="Estilo1">PERSONA NO POSEE REGISTROS DE CARTERA</span>
        </label>
        <%                        }
} catch (Exception exc) {
out.println("No Conectado a Oracle");
}
}
}
        %>
    </body>
</html>

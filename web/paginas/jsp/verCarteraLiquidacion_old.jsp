<%--
    Document   : verCarteraLiquidacion
    Created on : 03-ene-2009, 16:12:36
    Author     : WALTER E
--%>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.Calendar" import="modelo.Model"  import="modelo.Parametro" import="modelo.Vehiculo" import="modelo.Cartera" import="modelo.Concepto"  import="modelo.Propietario"  import="modelo.Persona"  import="modelo.Liquidacion" errorPage="" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%
            try {
                if (session.getAttribute("usuario") != null) {
                    modelo.Model model = (modelo.Model) session.getAttribute("model");
                    if (model != null) {
                        modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
                        if (model.tienePermiso(usuario.getId_usuario(), 54) || model.tienePermiso(usuario.getId_usuario(), 55)) {
%>
<html>
    <head>
        <title>Cartera</title>
        <script language="javascript" type="text/javascript">
            function adicionarVEH(id,placa){
                var tabla = document.getElementById('tabla');
                var trs = tabla.getElementsByTagName('tr') ;
                for(var i = 0; i<trs.length ; i++){
                    if(trs[i].id == id){
                        if(i==1){
                            window.parent.frames[4].location.href = "verLiquidacion.jsp?id="+id+"&tipo=1&placa="+placa;
                            tabla.deleteRow(i);
                        }else{
                            //if(i==trs.length-2){
                            //    window.parent.frames[4].location.href = "verLiquidacion.jsp?id="+id+"&tipo=1";
                            //    tabla.deleteRow(i);
                            //}else{
                            alert("Seleccione desde la primera vigencia");
                            //}
                        }
                        break;
                    }
                }
            }

            function adicionarPER(id){
                var tabla = document.getElementById('tabla');
                var trs = tabla.getElementsByTagName('tr') ;
                for(var i = 0; i<trs.length ; i++){
                    if(trs[i].id == id){
                        window.parent.frames[4].location.href = "verLiquidacion.jsp?id="+id+"&tipo=1";
                        tabla.deleteRow(i);
                        break;
                    }
                }
            }

            function sombrear(tr){
                tr.style.backgroundColor="#CCCCCC";
            }
            function renovar(tr){
                tr.style.backgroundColor="#FFFFFF";
            }
        </script>
        <style type="text/css">
            <!--
            .Estilo8 {
                font-size: 12px;
                font-weight: bold;
                color: #333333
            }
            .Estilo11 {font-size: 10px; font-weight: bold;color: #333333 }
            .Estilo12 {font-size: 12px;color: #FFFFFF}
            .Estilo18 {font-size: 12px;color: #FFFFFF}
            -->
        </style>
        <style type="text/css">
            body,html{background-color:transparent;}
            .Estilo13 {font-size: 12px}
            .Estilo17 {font-size: 10px}
        </style>
    </head>

    <%
                java.util.List listaLiquidacion = (java.util.List) session.getAttribute("listaLiquidacion");
                boolean permiso1 = model.tienePermiso(usuario.getId_usuario(), 54);
                boolean permiso2 = model.tienePermiso(usuario.getId_usuario(), 55);
                boolean verCartera = ((java.util.LinkedList) session.getAttribute("permisosU")).contains("aplicarPagosTransito");
                if (verCartera) {
                    if (request.getParameter("id").equals("1") && permiso1) {
                        String placa = request.getParameter("referencia").toUpperCase();
                        try {

                            Vehiculo vehiculo = model.consultarVehiculo(placa);
                            if (vehiculo != null) {
                                java.util.LinkedList carteras = model.crearListaCarteraPlaca(vehiculo.getId_vehiculo(), usuario.getId_usuario());
                                model.getCon().commit();
                                float totalCartera = 0;
                                if (carteras.size() > 0) {
    %>
    <input type="hidden" name="placa" value="<%=request.getParameter("referencia") %>">
    <table width="100%" border="1" id="tabla" cellpadding="1" cellspacing="0">
        <tr style="border:none; background:url(../html/images/inicio_3.png)">
            <th width="2%" scope="col" style="border:none"><span class="Estilo12 Estilo18">
                    <label>X</label>
                </span></th>
            <th width="48%" scope="col" style="border:none"><span class="Estilo12 Estilo18">
                    <label>CONCEPTO</label>
                </span></th>
            <th width="18%" scope="col" style="border:none"><span class="Estilo12 Estilo18">
                    <label>REFERENCIA</label>
                </span></th>
            <th width="18%" scope="col" style="border:none"><span class="Estilo12 Estilo18">
                    <label>FECHA</label>
                </span></th>
            <th width="14%" scope="col" style="border:none"><span class="Estilo12 Estilo18">
                    <label>VALOR</label>
                </span></th>
        </tr>
        <%
       boolean color = true;
       for (int i = 0; i < carteras.size(); i++) {
           Cartera cartera = (Cartera) carteras.get(i);
           boolean posible = true;
           if (listaLiquidacion != null) {
               for (int j = 0; j < listaLiquidacion.size(); j++) {
                   Liquidacion liquidacion = (Liquidacion) listaLiquidacion.get(j);
                   if (liquidacion.getTipo() == 1 && liquidacion.getId_liquidacion() == cartera.getId_cartera()) {
                       posible = false;
                       break;
                   }
               }
           }
           if (posible) {
               Concepto concepto = model.consultarConcepto(cartera.getFk_concepto());

        %>
        <tr id="<%=cartera.getId_cartera()%>" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
            <td align="center" style="cursor:pointer;">
                <img src="../html/images/adicionar.png" width="19" height="19" onClick="adicionarVEH(<%=cartera.getId_cartera()%>,'<%=placa %>')"/>							</td>
            <td align="center"><span class="Estilo11"><font face="Arial, Helvetica, sans-serif"><%=concepto.getNombre()%></font></span></td>
            <td align="center"><span class="Estilo8"><font face="Arial, Helvetica, sans-serif"><%=cartera.getReferencia()%></font></span></td>
            <td align="center"><span class="Estilo8"><font face="Arial, Helvetica, sans-serif"><%=cartera.getFecha_creacion()%></font></span></td>
            <td align="right"><span class="Estilo8"><font face="Arial, Helvetica, sans-serif"><%=cartera.getSaldo()%></font></span></td>
        </tr>
        <%    totalCartera += cartera.getSaldo();
           }
       }
        %>
        <tr bgcolor="#CCCCCC">
            <td colspan="4"><div align="right"><span class="Estilo8">TOTAL</span></div></td>
            <td align="right"><span class="Estilo8"><font face="Arial, Helvetica, sans-serif"><%=totalCartera%></font></span></td>
        </tr>
    </table>
    <%
 } else {
    %>
    <label><h3><center>
                <span class="Estilo8">NO EXISTE CARTERA ASOCIADA AL VEHICULO&nbsp;<%=placa%></span>
            </center></h3>
    </label>
    <%
  }
} else {
    %>
    <label><h3><center>
                <span class="Estilo8">NO EXISTE CARTERA ASOCIADA AL VEHICULO&nbsp;<%=placa%></span>
            </center>
        </h3>
    </label>
    <%
}
} catch (Exception exc) {
out.println("No Conectado a Oracle");
}
} else {
if (request.getParameter("id").equals("2") && permiso2) {
String placa = request.getParameter("referencia").toUpperCase();
try {
    Vehiculo vehiculo = model.consultarVehiculo(placa);
    if (vehiculo != null) {

        java.util.LinkedList propietarios = model.crearListaPropietarios(vehiculo.getId_vehiculo());
                 if (propietarios.size() > 0) {%>
    <table width="100%" border="1" id="tabla" cellpadding="1" cellspacing="0">
        <tr style="border:none; background:url(../html/images/inicio_3.png)">
            <th width="4%" scope="col" style="border:none"><span class="Estilo12 Estilo18">
                    <label>X</label>
                </span></th>
            <th width="14%" scope="col" style="border:none"><span class="Estilo12 Estilo18">
                    <label>DOCUMENTO</label>
                </span></th>
            <th width="33%" scope="col" style="border:none"><span class="Estilo12 Estilo18">
                    <label>CONCEPTO</label>
                </span></th>
            <th width="15%" scope="col" style="border:none"><span class="Estilo12 Estilo18">
                    <label>REFERENCIA</label>
                </span></th>
            <th width="15%" scope="col" style="border:none"><span class="Estilo12 Estilo18">
                    <label>FECHA</label>
                </span></th>
            <th width="14%" scope="col" style="border:none"><span class="Estilo12 Estilo18">
                    <label>VALOR</label>
                </span></th>
        </tr>
        <%
                              boolean color = true;
                              for (int j = 0; j < propietarios.size(); j++) {
                                  Propietario propietario = (Propietario) propietarios.get(j);
                                  Persona persona = model.consultarPersona(propietario.getFk_persona());
                                  java.util.HashMap mapa = model.crearHashParametrosAbreviatura(5);
                                  java.util.LinkedList carteras = model.crearListaCarteraPersona(propietario.getFk_persona());
                                  if (carteras.size() > 0) {
                                      for (int i = 0; i < carteras.size(); i++) {
                                          Cartera cartera = (Cartera) carteras.get(i);
                                          boolean posible = true;
                                          if (listaLiquidacion != null) {
                                              for (int k = 0; k < listaLiquidacion.size(); k++) {
                                                  Liquidacion liquidacion = (Liquidacion) listaLiquidacion.get(k);
                                                  if (liquidacion.getTipo() == 1 && liquidacion.getId_liquidacion() == cartera.getId_cartera()) {
                                                      posible = false;
                                                             break;
                                                         }
                                                     }
                                                 }
                                                 if (posible) {
                                                     Concepto concepto = model.consultarConcepto(cartera.getFk_concepto());%>
        <tr  class="Estilo11" id="<%=cartera.getId_cartera()%>"   onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
            <td align="center" style="cursor:pointer;"><img src="../html/images/adicionar.png" width="19" height="19" onClick="adicionarVEH(<%=cartera.getId_cartera()%>,'<%=placa %>')"/> </td>
            <td align="center" class="Estilo8"><span class="Estilo8"><font face="Arial, Helvetica, sans-serif"><%=mapa.get(persona.getTipo_documento() + "") + "&nbsp;" + persona.getDocumento()%></font></span></td>
            <td align="center"><font face="Arial, Helvetica, sans-serif" class="Estilo11"><%=concepto.getNombre()%></font></td>
            <td align="center" class="Estilo8"><span class="Estilo8 Estilo13"><font face="Arial, Helvetica, sans-serif"><%=cartera.getReferencia()%></font></span></td>
            <td align="center" class="Estilo8"><span class="Estilo8"><font face="Arial, Helvetica, sans-serif"><%=cartera.getFecha_creacion()%></font></span></td>
            <td align="right" class="Estilo8"><span class="Estilo8"><font face="Arial, Helvetica, sans-serif"><%=cartera.getSaldo()%></font></span></td>
        </tr>
        <%  	}
                                      }
                                  }
                              }
        %>
    </table>
    <%
                        } else {
    %>
    <label><h3><center>
                <span class="Estilo8">NO EXISTEN PROPIETARIOS ASOCIADOS AL VEHICULO<strong>&nbsp;</strong><%=placa%></span>
            </center>
        </h3>
    </label>
    <%
      }
  } else {
    %>
    <label><h3><center>
                <span class="Estilo8">NO EXISTEN PROPIETARIOS ASOCIADOS AL VEHICULO&nbsp;<%=placa%></span>
            </center>
        </h3>
    </label>
    <%
}
} catch (Exception exc) {
out.println("No Conectado a Oracle");
}
} else {
             if (request.getParameter("id").equals("3")) {%>
    <label><h3><center>
                <span class="Estilo8">PANEL CARTERA DE VEHICULOS</span>
            </center></h3></label>
            <%} else {
                 if (request.getParameter("id").equals("4") && permiso2) {
                     String tipo = request.getParameter("tipo");
                     String documento = request.getParameter("referencia");
                     try {
                         Persona persona = model.consultarPersona(Integer.parseInt(tipo), documento);
                         if (persona != null) {
                             java.util.HashMap mapa = model.crearHashParametrosAbreviatura(5);
                             String textDoc = mapa.get(persona.getTipo_documento() + "").toString();
                             java.util.LinkedList carteras = model.crearListaCarteraPersona(persona.getId_persona());
                                 if (carteras.size() > 0) {%>
    <table width="100%" border="1" id="tabla" cellpadding="1" cellspacing="0">
        <tr style="border:none; background:url(../html/images/inicio_3.png)">
            <th width="4%" scope="col" style="border:none"><span class="Estilo12 Estilo18">
                    <label>X</label>
                </span></th>
            <th width="14%" scope="col" style="border:none"><span class="Estilo12 Estilo18">
                    <label>DOCUMENTO</label>
                </span></th>
            <th width="33%" scope="col" style="border:none"><span class="Estilo12 Estilo18">
                    <label>CONCEPTO</label>
                </span></th>
            <th width="15%" scope="col" style="border:none"><span class="Estilo12 Estilo18">
                    <label>REFERENCIA</label>
                </span></th>
            <th width="15%" scope="col" style="border:none"><span class="Estilo12 Estilo18">FECHA</span></th>
            <th width="14%" scope="col" style="border:none"><span class="Estilo12 Estilo18">
                    <label>VALOR</label>
                </span></th>
        </tr>
        <%
          boolean color = true;
          for (int i = 0; i < carteras.size(); i++) {
              Cartera cartera = (Cartera) carteras.get(i);
              boolean posible = true;
              if (listaLiquidacion != null) {
                  for (int j = 0; j < listaLiquidacion.size(); j++) {
                      Liquidacion liquidacion = (Liquidacion) listaLiquidacion.get(j);
                      if (liquidacion.getTipo() == 1 && liquidacion.getId_liquidacion() == cartera.getId_cartera()) {
                          posible = false;
                          break;
                      }
                  }
              }
              if (posible) {
                                                                    Concepto concepto = model.consultarConcepto(cartera.getFk_concepto());%>
        <tr  id="<%=cartera.getId_cartera()%>"  onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
            <td align="center" style="cursor:pointer;">
                <img src="../html/images/adicionar.png" width="19" height="19" onClick="adicionarPER(<%=cartera.getId_cartera()%>)"/>											</td>
            <td align="center" class="Estilo8"><span class="Estilo8"><font face="Arial, Helvetica, sans-serif"><b><%=textDoc + " " + persona.getDocumento()%></b></font></span></td>
            <td align="center"><font face="Arial, Helvetica, sans-serif" class="Estilo11 Estilo17"><b><%=concepto.getNombre()%></b></font></td>
            <td align="center" class="Estilo8"><span class="Estilo8"><font face="Arial, Helvetica, sans-serif"><b><%=cartera.getReferencia()%></b></font></span></td>
            <td align="center" class="Estilo8"><span class="Estilo8"><font face="Arial, Helvetica, sans-serif"><b><%=cartera.getFecha_creacion()%></b></font></span></td>
            <td align="right" class="Estilo8"><span class="Estilo8"><font face="Arial, Helvetica, sans-serif"><b><%=cartera.getSaldo()%></b></font></span></td>
        </tr>
        <%    }
                                                            }%>
    </table>
    <%    } else {
    %>
    <label><h3><center>
                <span class="Estilo8">NO EXISTEN CARTERAS ASOCIADAS A PERSONA&nbsp;<%=persona.getDocumento()%></span>
            </center></h3></label>
            <%
        }
    } else {
            %>
    <label><h3><center>
                <span class="Estilo8">EL DOCUMENTO INGRESADO NO ESTA REGISTRADO</span>
            </center></h3></label>
            <%                                }
} catch (Exception exc) {
 exc.printStackTrace();
 out.println("No Conectado a Oracle");
}
}
}
}
            }
        }else{ %>
            <label><h3><center>
                    <span class="Estilo8">INFORMACION NO REQUERIDA POR SU USUARIO</span>
                    </center></h3>
            </label>
    <%    } %>
</html>
<%      } else {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="1"></jsp:param></jsp:forward>
<%        }
        } else {%>
<script>window.parent.parent.document.location.href = "../../index.jsp";</script>
<%  }
    } else {%>
<script>window.parent.parent.document.location.href = "../../index.jsp";</script>
<% }
    }catch  (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% }%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Vehiculo" import="modelo.Sede"  import="modelo.Tramite" errorPage="" %>
<%
            try {
                if (session.getAttribute("model") != null) {
                    if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("seleccionTramites.jsp")) {

%>
<html>
    <head>
        <TITLE></TITLE>
        <script language="javascript" type="text/javascript">
            function adicionar(id,tramite){
                if(tramite==1){
                    confirm("");
                }
                window.parent.frames[1].location.href = "tramitesSeleccionados.jsp?id="+id+"&tramite="+tramite+"&placa="+document.form.placa.value+"&tipo="+document.form.tipo.value+"&documento="+document.form.documento.value;
                document.location.href = "tramitesDisponibles.jsp?id="+id+"&placa="+document.form.placa.value+"&tipo="+document.form.tipo.value+"&documento="+document.form.documento.value;
            }
            function actualizar(id){
                window.parent.frames[1].location.href = "tramitesSeleccionados.jsp?id="+id+"&placa="+document.form.placa.value+"&tipo="+document.form.tipo.value+"&documento="+document.form.documento.value;
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
            .Estilo3 {color: #333333}
            .Estilo11 {color: #333333; font-size: 12px; }
            .Estilo12 {color: #FFFFFF; font-size: 12px; }
            .Estilo14 {font-size: 12px; color: #0066CC; font-weight: bold; }
            -->
        </style>
    </head>
    <body>
        <form name="form" action="#" method="post">
            <% try {

                                    Model model = (Model) session.getAttribute("model");
                                    String placa ="";
                                    placa = request.getParameter("placa").toUpperCase();
                                    boolean pagoAnterior = false;//model.ValidarPagosAnterior(placa);
                                    boolean revicion =false;
                                    int ti = 0;
                                    Sede sede = (Sede) session.getAttribute("sede");
                                    String radicacion = (String) session.getAttribute("rn");
                                    System.out.println("Radicacion J: " + radicacion);
                                    modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
                                    java.util.List<Integer> permitidos = new java.util.LinkedList<Integer>();
                                    java.util.List<Integer> restriccion = new java.util.LinkedList<Integer>();
                                    java.util.List<Tramite> tramites = new java.util.LinkedList<Tramite>();
                                    java.util.List<Integer> seleccionados = new java.util.LinkedList<Integer>();
                                    Vehiculo ve = model.consultarVehiculo(placa);
                                    if(ve!=null){
                                    java.util.List<modelo.Alerta> temp = model.consultarAlertas(ve.getId_vehiculo());
                                    if(temp!=null){
                                    for(int i =0;i<temp.size();i++){
                                          int tipo =  temp.get(i).getTipo();
                                          if(tipo==7 && temp.get(i).getFecha_fin()==null){
                                              revicion=true;
                                              ti=7;
                                              break;
                                          }else{
                                            if(tipo==8 && temp.get(i).getFecha_fin()==null){
                                              revicion=true;
                                              ti=8;
                                              break;
                                            }
                                          }
                                    }//next
                                    }//temp
                                    }//ve
                                    if(!revicion){
                                    if(!pagoAnterior){ 
                                    if (session.getAttribute("seleccionados") != null) {
                                        seleccionados = (java.util.LinkedList) session.getAttribute("seleccionados");
                                    }
                                    if (request.getParameter("tramite") != null) {
                                        if (request.getParameter("tramite").length() > 0) {
                                            if (seleccionados.contains(Integer.parseInt(request.getParameter("tramite")))) {
                                                seleccionados.remove(Integer.valueOf(request.getParameter("tramite")));
                                                if (Integer.valueOf(request.getParameter("tramite")) == 14) {
                                                    for (int i = 1; i <= 32; i++) {
                                                        if (i != 12 && i != 18 && i != 19 && i != 14) {
                                                            seleccionados.remove(Integer.valueOf(i));
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                    //String placa = "";
                                    String tipo = "";
                                    String documento = "";
                                    boolean pendienteT = false;
                                    boolean pendienteS = false;
                                    boolean pendienteE = false;
                                    if (request.getParameter("id") != null) {
                                        if (!request.getParameter("id").equals("")) {
                                            if (request.getParameter("id").equals("1") 
                                             || request.getParameter("id").equals("3") 
                                             || request.getParameter("id").equals("4") 
                                             || request.getParameter("id").equals("5")) {
                                                if (request.getParameter("placa") != null) {
                                                    placa = request.getParameter("placa").toUpperCase();
                                                    pendienteT = model.consultarTramitesPlaca(placa);
                                                    if (!pendienteT) {
                                                        if (radicacion.equals("1")) { //RADICACION RNA - REGISTRO AUTOMOTORES
                                                            System.out.println("Sysok 1");
                                                            tramites = model.consultarTramites(1, sede.getId_sede());
                                                            String result = model.verificarPlaca(placa);
                                                            System.out.println("Result: "+result);
                                                            if (result.equals("00")) {
                                                                permitidos.add(4);
                                                                restriccion.add(1);
                                                                restriccion.add(3);
                                                                restriccion.add(8);
                                                                restriccion.add(15);
                                                                restriccion.add(11);
                                                            } else if (result.equals("01")) {
                                                                permitidos.add(1);
                                                                restriccion.add(4);
                                                                restriccion.add(8);
                                                            } else if (result.equals("10") || result.equals("11")) {
                                                                Vehiculo veh = model.consultarVehiculo(placa);
                                                                if (veh.getEstado() == 1 || veh.getEstado() == 5) {
                                                                    
                                                                    if(!pendienteS){
                                                                        System.out.println("!pendienteS "+ pendienteS);
                                                                     //if (model.consultarSincronizacion(1, veh.getId_vehiculo()) != null) {
                                                                        if (!model.tieneEmbargos(veh.getId_vehiculo())) {
                                                                            restriccion.add(1);
                                                                            restriccion.add(4);
                                                                            restriccion.add(11);
                                                                            if (veh != null) {
                                                                                if (veh.getEstado() == 1 || veh.getEstado() == 5) {
                                                                                    restriccion.add(8);
                                                                                    if (model.tieneAlertas(veh.getId_vehiculo())) {
                                                                                        if (!seleccionados.contains(14)) {
                                                                                            for (int i = 1; i <= 32; i++) {
                                                                                                if (i != 12 && i != 18 && i != 19 && i != 14) {
                                                                                                    restriccion.add(i);
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    } else {
                                                                                        if (!seleccionados.contains(13)) {
                                                                                            restriccion.add(14);

                                                                                        }
                                                                                    }
                                                                                } else {
                                                                                    permitidos.add(8);
                                                                                }
                                                                            }
                                                                        } else {
                                                                            for (int i = 1; i <= 32; i++) {
                                                                                if (i != 12 && i != 18 && i != 19 && i != 14) {
                                                                                    restriccion.add(i);

                                                                                }
                                                                            }
                                                                        }
                                                                    } else {
                                                                        tramites = new java.util.LinkedList<Tramite>();
                                                                        pendienteS = true;
                                                                    }
                                                                } else {
                                                                    if (veh.getEstado() == 3) {
                                                                        permitidos.add(8);
                                                                        restriccion.add(1);
                                                                    } else {
                                                                        if (veh.getEstado() == 4) {
                                                                            permitidos.add(4);
                                                                            restriccion.add(1);
                                                                            restriccion.add(8);
                                                                        } else {
                                                                            tramites = new java.util.LinkedList<Tramite>();
                                                                            pendienteE = true;
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }else if (radicacion.equals("5")) { //RADICACION RNRYS - REMOLQUE Y SEMIREMOLQUE
                                                            System.out.println("Sysok 5");
                                                            tramites = model.consultarTramites(5, sede.getId_sede());
                                                            String result = model.verificarPlacaRN(placa);
                                                            if (result.equals("00")) {
                                                                //permitidos.add(65);
                                                                //permitidos.add(62);
                                                                //restriccion.add(62);
                                                                restriccion.add(64);
                                                                restriccion.add(69);
                                                                restriccion.add(75);
                                                                restriccion.add(11);
                                                            } else if (result.equals("01")) {
                                                                permitidos.add(62);
                                                                restriccion.add(65);
                                                                restriccion.add(69);
                                                            } else if (result.equals("10") || result.equals("11")) {
                                                                Vehiculo veh = model.consultarVehiculo(placa);
                                                                if (veh.getEstado() == 1 || veh.getEstado() == 5) {
                                                                    if (model.consultarSincronizacion(1, veh.getId_vehiculo()) != null) {
                                                                        if (!model.tieneEmbargos(veh.getId_vehiculo())) {
                                                                            restriccion.add(62);
                                                                            restriccion.add(65);
                                                                            if (veh != null) {
                                                                                if (veh.getEstado() == 1 || veh.getEstado() == 5) {
                                                                                    restriccion.add(69);
                                                                                    if (model.tieneAlertas(veh.getId_vehiculo())) {
                                                                                        if (!seleccionados.contains(74)) {
                                                                                            for (int i = 62; i <= 88; i++) {
                                                                                                if (i != 72 && i != 78 && i != 79 && i != 74 && i != 82) {
                                                                                                    restriccion.add(i);
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    } else {
                                                                                        if (!seleccionados.contains(73)) {
                                                                                            restriccion.add(74);

                                                                                        }
                                                                                    }
                                                                                } else {
                                                                                    permitidos.add(69);
                                                                                }
                                                                            }
                                                                        } else {
                                                                            for (int i = 62; i <= 88; i++) {
                                                                                if (i != 72 && i != 78 && i != 79 && i != 74) {
                                                                                    restriccion.add(i);

                                                                                }
                                                                            }
                                                                        }
                                                                    } else {
                                                                        tramites = new java.util.LinkedList<Tramite>();
                                                                        pendienteS = true;
                                                                    }
                                                                } else {
                                                                    if (veh.getEstado() == 3) {
                                                                        permitidos.add(69);
                                                                        restriccion.add(62);
                                                                    } else {
                                                                        if (veh.getEstado() == 4) {
                                                                            permitidos.add(65);
                                                                            restriccion.add(62);
                                                                            restriccion.add(69);
                                                                        } else {
                                                                            tramites = new java.util.LinkedList<Tramite>();
                                                                            pendienteE = true;
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }else if (radicacion.equals("4")) { //RADICACION RNMA
                                                            tramites = model.consultarTramites(4, sede.getId_sede());
                                                            String result = model.verificarPlacaRN(placa);

                                                            if (result.equals("00")) {
                                                                //permitidos.add(91);
                                                                //permitidos.add(94);
                                                                //restriccion.add(91);
                                                                restriccion.add(93);
                                                                restriccion.add(98);
                                                                restriccion.add(104);
                                                                restriccion.add(11);
                                                            } else if (result.equals("01")) {
                                                                permitidos.add(91);
                                                                restriccion.add(94);
                                                                restriccion.add(98);
                                                            } else if (result.equals("10") || result.equals("11")) {
                                                                Vehiculo veh = model.consultarVehiculo(placa);
                                                                if (veh.getEstado() == 1 || veh.getEstado() == 5) {
                                                                    if (model.consultarSincronizacion(1, veh.getId_vehiculo()) != null) {
                                                                        if (!model.tieneEmbargos(veh.getId_vehiculo())) {
                                                                            restriccion.add(91);
                                                                            restriccion.add(94);
                                                                            restriccion.add(11);
                                                                            if (veh != null) {
                                                                                if (veh.getEstado() == 1 || veh.getEstado() == 5) {
                                                                                    restriccion.add(98);
                                                                                    if (model.tieneAlertas(veh.getId_vehiculo())) {
                                                                                        if (!seleccionados.contains(14)) {
                                                                                            for (int i = 91; i <= 117; i++) {
                                                                                                if (i != 101 && i != 107 && i != 108 && i != 103) {
                                                                                                    restriccion.add(i);
                                                                                                }
                                                                                            }
                                                                                        }
                                                                                    } else {
                                                                                        if (!seleccionados.contains(102)) {
                                                                                            restriccion.add(103);

                                                                                        }
                                                                                    }
                                                                                } else {
                                                                                    permitidos.add(98);
                                                                                }
                                                                            }
                                                                        } else {
                                                                            for (int i = 91; i <= 117; i++) {
                                                                                if (i != 101 && i != 107 && i != 108 && i != 103) {
                                                                                    restriccion.add(i);

                                                                                }
                                                                            }
                                                                        }
                                                                    } else {
                                                                        tramites = new java.util.LinkedList<Tramite>();
                                                                        pendienteS = true;
                                                                    }
                                                                } else {
                                                                    if (veh.getEstado() == 3) {
                                                                        permitidos.add(98);
                                                                        restriccion.add(91);
                                                                    } else {
                                                                        if (veh.getEstado() == 4) {
                                                                            permitidos.add(94);
                                                                            restriccion.add(91);
                                                                            restriccion.add(98);
                                                                        } else {
                                                                            tramites = new java.util.LinkedList<Tramite>();
                                                                            pendienteE = true;
                                                                        }
                                                                    }
                                                                }
                                                            }
                                                        }//fin
                                                    } else {
                                                    }

                                                }
                                            } else {
                                                if (request.getParameter("tipo") != null && request.getParameter("documento") != null) {
                                                    tramites = model.consultarTramites(2, sede.getId_sede());
                                                }
                                }
                            }
                        }
                        if (tramites.size() > 0) {                            %>
            <input type="hidden" name="placa" id="placa" value="<%=placa%>"/>
            <input type="hidden" name="tipo" id="tipo" value="<%=tipo%>"/>
            <input type="hidden" name="documento" id="documento" value="<%=documento%>"/>
            <table width="100%" border="1" id="tabla" cellpadding="1" cellspacing="0">
                <tr style="border:none; background:url(../html/images/inicio_3.png)">
                    <th width="4%" class="Estilo12" style="border:none" scope="col">X</th>
                    <th width="10%" class="Estilo12" style="border:none" scope="col">CODIGO</th>
                    <th width="84%" class="Estilo12" style="border:none" scope="col">NOMBRE&nbsp;TRAMITE</th>
                </tr>
                <%

          for (int i = 0; i < permitidos.size(); i++) {
              if (!seleccionados.contains(permitidos.get(i))) {
                  seleccionados.add(permitidos.get(i));
              }
          }
          /*
          Tramite init = tramites.get(0);
          java.util.List ordenT = model.consultarTramites(init.getClase_tramite(), sede.getId_sede());
          java.util.List listaOrden = new java.util.LinkedList();
          for(int t=0;t<ordenT.size();t++){
          Tramite torden = (Tramite)ordenT.get(t);
          if(seleccionados.contains((int)torden.getId_tramite())){
          listaOrden.add((int)torden.getId_tramite());
          }}seleccionados = new java.util.LinkedList<Integer>();For(int t=0;t<listaOrden.size();t++);
          seleccionados.add(Integer.parseInt(listaOrden.get(t).toString()));*/
          session.setAttribute("seleccionados", seleccionados);
          int d = 0;
          for (int i = 0; i < tramites.size(); i++) {
              Tramite tramite = tramites.get(i);
              if (usuario.getId_usuario() != 0 ||
                      (usuario.getId_usuario() == 14 && (tramite.getId_tramite() == 32 ||
                      tramite.getId_tramite() == 15 ||
                      tramite.getId_tramite() == 1 ||
                      tramite.getId_tramite() == 13))) {
                  if (!restriccion.contains((int) tramite.getId_tramite()) && !seleccionados.contains((int) tramite.getId_tramite())) {
                        d++;                        %>
                <tr id="<%=tramite.getId_tramite()%>" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                    <td align="center" style="cursor:pointer">
                        <img src="../html/images/adicionar.png" width="19" height="19" class="Estilo3" onClick="adicionar(<%=request.getParameter("id")%>,<%=tramite.getId_tramite()%>)"/>                           </td>
                    <td align="center"><span class="Estilo11"><%=tramite.getId_tramite()%></span></td>
                    <td align="left"><span class="Estilo11"><%=tramite.getNombre()%></span></td>
                </tr>
                <%  }
                }
            }//next
            if (d == 0) {                %>
                <tr>
                    <td colspan="3" align="center" class="Estilo14">NO EXISTEN TRAMITES DISPONIBLES </td>
                </tr>
                <%    }            %>
                <script>actualizar(<%=request.getParameter("id")%>);</script>
            </table>
            <%  } else {
            if (pendienteS) {                %>
            <div align="center">
                <img src="../html/images/info.png" width="47" height="48">
                <p class="Estilo14">ESTE VEHICULO NO HA SIDO SINCRONIZADO AL RUNT!! </p>
            </div>
            <%  } else if (pendienteT) {                  %>
            <div align="center">
                <img src="../html/images/info.png" width="47" height="48">
                <p class="Estilo14">ESTE VEHICULO POSEE TRAMITES PENDIENTES, FINALICELOS!! </p>
            </div>
            <%      } else {
                    if (pendienteE) {                        %>
            <div align="center">
                <img src="../html/images/info.png" width="47" height="48">
                <p class="Estilo14">ESTADO DEL VEHICULO RESTRINGIDO</p>
            </div>
            <%                  } else {
            %>
            <div align="center">
                <img src="../html/images/info.png" width="47" height="48">
                <p class="Estilo14">NO EXISTEN TRAMITES DISPONIBLES </p>
            </div>
            <%     }
                         }
                     }
                                    }else{
                                    %>
                                    <script language="javascript" type="text/javascript">
                                        alert("El vehiculo Tiene un Pago Relacionado a Tramites de un año anterior, Por favor Aplicar el excedente!");
                                    </script>
                                    <%
                                    }
                 } else {
                    if(ti==7){
           %>
            <div align="center">
                <img src="../html/images/info.png" width="47" height="48">
                <p class="Estilo14">VEHICULO EN REVISION, COMUNIQUESE CON EL EL AREA DE SISTEMAS </p>
            </div>
            <%
                    }else{
           %>
            <div align="center">
                <img src="../html/images/info.png" width="47" height="48">
                <p class="Estilo14">VEHICULO EN REVICION POR POSIBLE FRAUDE, COMUNIQUESE CON EL EL AREA DE SISTEMAS INMEDIATAMENTE </p>
            </div>
            <%
                    }
                 }
                 } catch (Exception exc) {
                     exc.printStackTrace();
                    }%>
        </form>
    </body>
</html>
<%  } else {                    %>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }
        } else {            %>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%
}
} catch (Exception mexe) {    %>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
            }            %>


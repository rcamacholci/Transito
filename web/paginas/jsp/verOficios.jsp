<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.DatosVehiculo" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Prestamos</title>
        <style type="text/css">
            <!--
            .style9 {color: #FFFFFF; font-weight: bold; font-family: Tahoma; font-size: 12px; }
            .style17 {color: #333333; font-size: 11px; font-family: Tahoma; font-weight: bold; }
            .Estilo22 {font-family: Tahoma}
            .Estilo23 {font-size: 12px}
            .Estilo24 {color: #333333}
            .Estilo25 {color: #FFFFFF}
            .Estilo26 {
                font-family: Tahoma;
                font-size: 12px;
                font-weight: bold;
                color: #333333;
            }
            -->
        </style>
        <script language="javascript" type="text/javascript">


            function verReporte() {
                //document.form.motor.value
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width - ancho) / 2 : 100;
                arriba = (document.height) ? (document.height - alto) / 2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "solicitudes/solicitudV.jasper";
                var nombre = "solicitud";
                url = "verReportes.jsp?nombreReporte=" + nombre + "&dirReporte=" + dir;
                window.open(url, 'popUp', opciones);
            }


            function GenerarPlaca() {
                if (document.form.oficioComercial.value.length > 0) {
                    var cant = document.form.cantVeh.value;
                    var idOficio = document.form.id_oficio.value;
                    var oficioC = document.form.oficioComercial.value;
                    var bus = 0;
                    if (document.form.busqueda[0].checked) {
                        bus = 1;
                    } else {
                        bus = 2;
                    }
                    //var bus = document.getElementById("busqueda").value;
                    //window.frames[0].location.href = "ProcesarRespuestaSolicitud.jsp?cantVeh="+cant+"&id_oficio="+idOficio+"&oficioC="+oficioC+"&busqueda=1";
                    window.frames[0].location.href = "ProcesarRespuestaSolicitud.jsp?cantDoc=" + cant + "&id_oficio=" + idOficio + "&oficioC=" + oficioC + "&busqueda=" + bus;
                } else {
                    alert("Favor digite el No de Oficio Comercial");
                }
            }

            function GenerarDocumento() {
                if (document.form.oficioComercial.value.length > 0) {
                    var cant = document.form.cantDoc.value;
                    var idOficio = document.form.id_oficio.value;
                    var oficioC = document.form.oficioComercial.value;
                    window.frames[0].location.href = "ProcesarRespuestaSolicitud.jsp?cantDoc=" + cant + "&id_oficio=" + idOficio + "&oficioC=" + oficioC;
                } else {
                    alert("Favor digite el No de Oficio Comercial");
                }
            }


            function ver() {
                if (document.form.busqueda[0].checked) {
                    document.getElementById('tabla1').style.display = "block";
                    document.getElementById('tabla2').style.display = "none";

                } else {
                    document.getElementById('tabla1').style.display = "none";
                    document.getElementById('tabla2').style.display = "block";

                }

            }

        </script>
    </head>
    <%@ page import="modelo.*"%>
    <%@page import="java.util.*"%>

    <%
        try {
            Model modelo = (Model) session.getAttribute("model");
    %>
    <body>
        <form name="form" id="form" method="post" action="">    
            <table width="100%" border="1" cellpadding="1" cellspacing="0">
                <tr style="border:none; background:url(../html/images/inicio_3.png)">
                    <td width="10%"  style="border:none"><div align="center" class="style9">No&nbsp;OFICIO </div></td>
                    <td width="10%" style="border:none"><div align="center" class="style9">FECHA&nbsp;OFICIO</div></td>
                    <td width="10%" style="border:none"><div align="center" class="style9">No&nbsp;RADICACION</div></td>
                    <td width="15%" style="border:none"><div align="center" class="style9">F.RADICACION </div></td>
                    <td width="15%" style="border:none"><div align="center" class="style9">SOLICITANTE</div></td>
                    <td width="10%" style="border:none"><div align="center" class="style9">ENTIDAD</div></td>
                </tr>
                <%
                    if (request.getParameter("numero_interno") != null) {
                        Solicitud_Oficios solicitudO = modelo.consultarOficioNumeroInterno(Integer.parseInt(request.getParameter("numero_interno")));
                        if (solicitudO != null) {
                            if (solicitudO.getEstado() != 3) {

                %>

                <tr bgcolor="#FFFFFF" id="<%= solicitudO.getId_oficio()%>" >
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= solicitudO.getNum_oficio()%></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= solicitudO.getFecha_oficio() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(solicitudO.getFecha_oficio()) : ""%></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%= solicitudO.getNum_radicacion()%></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= solicitudO.getFecha_radicacion() != null ? new java.text.SimpleDateFormat("dd/MM/yyyy").format(solicitudO.getFecha_radicacion()) : ""%></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= solicitudO.getSolicitante()%></span></td>
                    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%= solicitudO.getEntidad()%></span></td>
                </tr>
            </table>
            <%

                if (solicitudO.getEstado() != 2) {%>
            <table width="100%" border="0" align="center">
                <tr>
                    <td colspan="4" align=""><input  id="id_oficio" name="id_oficio" value="<%=solicitudO.getId_oficio()%>" style="width:50px ; display:none"  /></td>
                </tr>
                <tr>
                    <td colspan="2" align="right"><span class="Estilo26">NUMERO OFICIO COMERCIAL </span></td>
                    <td colspan="2" align="left"><input  id="oficioComercial" name="oficioComercial"  style="width:150px "></td>
                </tr>
                <tr style="border:none; background:url(../html/images/inicio_3.png)">
                    <td colspan="4" align="center" valign="middle"><span class="Estilo23 Estilo22 style7 Estilo25"><strong>CONSULTA POR </strong></span></td>
                </tr>
                <tr>
                    <td  align="center" width="25%"><span class="Estilo23 Estilo22 Estilo11 Estilo24"><strong>
                                <input type="radio" name="busqueda" value="1" checked="checked" onclick="GenerarPlaca()">
                                    VEHICULO
                            </strong></span></td>
                    <td  align="center" width="25%">
                        <table border="0" width="100%" id="tabla1" style=" display:none">
                            <tr valign="middle">
                                <td width="32%" height="26" align="right"><label style="color:#333333"><span class="Estilo23 Estilo22 style5"><strong>CANTIDAD</strong></span></label>								  </td>
                                <td width="24%" scope="col" align="right"><input  id="cantVeh" name="cantVeh" style="text-align:center;color:#333333;font:bold; width:50px" onblur="GenerarPlaca()" maxlength="6" />							      </td>

                                <td width="17%" scope="col"></td>

                            </tr>
                        </table>			

                    </td>
                    <td align="center" width="25%"><span class="Estilo23 Estilo22 Estilo11 Estilo24"><strong>
                                <input type="radio" name="busqueda" value="2" onclick="GenerarPlaca()">
                                    PERSONA </strong></span></td>
                    <td  align="center" width="25%">
                        <table border="0" width="100%" id="tabla2" style=" display:none">
                            <tr valign="middle">
                                <td width="32%" height="26" align="right"><label style="color:#333333"><span class="Estilo23 Estilo22 style5"><strong>CANTIDAD</strong></span></label>								  </td>
                                <td width="24%" scope="col" align="right"><input  id="cantDoc" name="cantDoc" style="text-align:center;color:#333333;font:bold; width:50px" maxlength="6" onblur="GenerarDocumento()" />							      </td>

                                <td width="17%" scope="col"></td>

                            </tr>
                        </table>	
                    </td>
                </tr>

            </table>
            <fieldset>
                <iframe src="#" width="100%"  id="respuesta" height="200"  frameborder="0" scrolling="auto"></iframe>
            </fieldset>


            <%   } else {
            %>
            <script language="javascript" type="text/javascript">
                if (confirm("La respuesta A este Oficio ya fue Generada, Desea Reimprimir el Documento ?")) {
                <%
                    Respuesta_Solicitud resS = modelo.consultarRespuestaSolicitudByFkOfico(solicitudO.getId_oficio());
                    Usuario usu = modelo.consultarUsuario(solicitudO.getFk_usuario());
                    if (usu != null) {
                        HashMap parameters = new java.util.HashMap();
                        Persona usuario = modelo.consultarPersona(usu.getFk_persona());
                        if (usuario != null) {
                            Cargo cargo = modelo.consultarCargoByUsuario(usu.getId_usuario());
                            if(usu.getId_usuario()==20){
                                cargo= new Cargo();
                                cargo.setCargo(2);
                                cargo.setGrupo_cargo(6);
                            }
                            if (cargo != null) {
                                Parametro grupo = modelo.consultarParametro((int) cargo.getGrupo_cargo(), 358);
                                Parametro carg = modelo.consultarParametro((int) cargo.getCargo(), 359);
                                parameters.put("GRUPOCARGO", grupo.getNombre());
                                parameters.put("CARGO", carg.getNombre());
                                parameters.put("USUARIO", usuario.getNombre_1() + " " + usuario.getApellido_1());
                                parameters.put("ID_OFICIO", solicitudO.getId_oficio());
                                parameters.put("OFICIO_COMERCIAL", resS.getOficio_comercial());
                                parameters.put("FECHA_OFICIO_RESPUESTA", resS.getFecha_oficioRespuesta());
                                session.setAttribute("solicitud", parameters);
                %>verReporte();<%
                    }else{
                            throw new Exception("No se encontro Cargo para el Usuario");
                            }
                    
                        }
                    }%>
                    }
            </script>
            <%

                }
            } else {%>
            <script language="javascript" type="text/javascript">
                alert("Esta solicitud se encuentra anulada");
            </script>
            <%   }
            } else {
            %>
            <script language="javascript" type="text/javascript">
                alert("No se encontraron registros");
            </script>		


            <% }
                }
            } catch (Exception e) {
            %>
            <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=e.getMessage()%>"></jsp:param></jsp:forward>
            <%
                }
            %>   
        </form>
    </body>
</html>

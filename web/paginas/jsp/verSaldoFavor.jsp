<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script type="text/javascript" src="../html/scripts/calendar.js"></script>
        <script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
        <script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <title>Vehiculo</title>
        <style type="text/css">
            <!--
            .Estilo8 {color: #333333; font-weight: bold; font-size: 12px; }
            .Estilo13 {color: #333333}
            .Estilo14 {color: #333333; font-size: 12px; }
            .style1 {font-family: Tahoma}
            .style2 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
            .Estilo18 {
                color: #FFF;
                font-weight: bold;
                font-size: 12px;
                font-family: Tahoma;
            }
            .Estilo19 {color: #FF0000}
            .Estilo15 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
            .Estilo16 {color: #000000; font-weight: bold; font-size: 12px; font-family: Tahoma; }
            -->
        </style>
        <script language="javascript" type="text/javascript">
            function nuevoAjax(){
                var xmlhttp= false;
                try{
                    xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
                }catch(e){
                    try {
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                    }catch(E){
                        xmlhttp = false;
                    }
                }

                if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
                    xmlhttp = new XMLHttpRequest();
                }

                return xmlhttp;
            }

            function registrarDev(){
                if(document.form.resolucion.value.length>0){
                    if(document.form.fecha.value.length>0){
                        if(document.form.observacion.value.length>0){
                            document.form.submit();
                        }else{
                            alert("Ingrese algun dato de observacion");
                        }
                    }else{
                        alert("Ingrese la fecha de la resolucion");
                    }
                }else{
                    alert("Ingrese el numero de la resolucion");
                }
            }
        </script>
    </head>
    <%@ page import="modelo.*"%>
    <%@page import="java.util.*"%>
    <%
            Model modelo = (Model) session.getAttribute("model");
            modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
            long id_saldo;
            if (request.getParameter("id_saldo") != null) {
                id_saldo = Long.parseLong(request.getParameter("id_saldo"));
                Saldo_Favor saldoF = modelo.consultarSaldoFavor(id_saldo);

                if (saldoF != null) {
                    Persona persona = modelo.consultarPersona(saldoF.getFk_persona());
                    if (persona != null) {
                        Parametro doc = modelo.consultarParametro(persona.getTipo_documento(), 5);
                        Usuario usuarioSaldo = modelo.consultarUsuario(saldoF.getFk_usuario());
                        Parametro estado = modelo.consultarParametro(saldoF.getEstado(), 346);
                        Parametro tipoS = modelo.consultarParametro(saldoF.getTipo(), 347);
    %>
    <body>
        <form method="post" name="form" action="procesarDevolucionSaldo.jsp">
            <table width="70%" border="0" align="center">
                <tr>
                    <td colspan="3">
                        <fieldset class="style1">
                            <table width="100%" border="0" align="center">
                                <tr style="border:none; background:url(../html/images/inicio_3.png)">
                                    <td colspan="6" align="center" valign="middle"><span class="Estilo18">DATOS DEL SALDO </span></td>
                                </tr>

                                <tr>
                                    <td width="16%"><span class="Estilo8">NUMERO</span></td>
                                    <td width="22%">
                                        <span class="Estilo8">
                                            <input type="hidden" name="idsaldo" value="<%=saldoF.getId_saldo_favor()%>"/>
                                            <input type="text" name="textfield" value="<%=saldoF.getNumero()%>" style="width:150px; color:#333333; text-align:center" readonly/>
                                        </span>					  </td>
                                    <td width="15%"><span class="Estilo8">DOCUMENTO</span></td>
                                    <td width="47%">
                                        <span class="Estilo8">
                                            <input name="" type="text" value="<%=doc.getNombreCorto() + " " + persona.getDocumento()%>" style=" width:170px;color:#333333; text-align:center" readonly/>
                                        </span>					  </td>
                                </tr>
                                <tr>
                                    <td width="16%"><span class="Estilo8">NOMBRE</span></td>
                                    <td colspan="3"><span class="Estilo8">
                                            <input name="" type="text"  value="<%=persona.getNombre_1() + " " + persona.getApellido_1()%>" style=" width:460px;color:#333333; text-align:center" readonly/></span>						</td>

                                </tr>
                                <tr>
                                    <td><span class="Estilo8">TIPO</span></td>
                                    <td><span class="Estilo8">
                                            <input name="" type="text"  value="<%=tipoS != null ? tipoS.getNombre() : ""%>" style=" width:150px;color:#333333; text-align:center" readonly/></span>						</td>
                                    <td><span class="Estilo8">REFERENCIA</span></td>
                                    <td><span class="Estilo14">
                                            <input name="" type="text"  value="<%=saldoF.getReferencia()%>" style=" width:170px;color:#333333; text-align:center" readonly/></span>						</td>
                                </tr>
                                <tr>
                                    <td><span class="Estilo8">VALOR</span></td>
                                    <td><span class="Estilo8">
                                            <input name="" type="text"  value="<%=saldoF.getValor()%>" style=" width:150px;color:#333333; text-align:center" readonly/></span>						</td>
                                    <td><span class="Estilo8">FECHA </span></td>
                                    <td><span class="Estilo8">
                                            <input name="" type="text"  value="<%= saldoF.getFecha() != null ? (new java.text.SimpleDateFormat("dd/MM/yyyy").format(saldoF.getFecha())) : ""%>" style=" width:170px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333; text-align:center" readonly/></span>						</td>
                                </tr>
                                <tr>
                                    <td><span class="Estilo8">USUARIO</span></td>
                                    <td><span class="Estilo8">
                                            <input name="" type="text"  value="<%=usuarioSaldo.getNombre()!=null?usuarioSaldo.getNombre():""%>" style=" width:150px;color:#333333; text-align:center" readonly/></span>						</td>
                                    <td><span class="Estilo8">ESTADO </span></td>
                                    <td><span style="font-size: 11px">
                                            <input name="" type="text"  value="<%=modelo.consultarParametroName(346, saldoF.getEstado())%>" style=" width:150px;color:#333333; text-align:center" readonly/>
                                        </span></td>
                                </tr>

                            </table>
                        </fieldset>          </td>
                </tr>
                <%  String read = saldoF.getEstado() != 1?"readonly":"";%>
                <tr>
                    <td colspan="3">
                        <fieldset class="style1">

                            <table width="100%" border="0" align="center">
                                <tr style="border:none; background:url(../html/images/inicio_3.png)">
                                    <td colspan="6" align="center" valign="middle"><span class="Estilo18">DATOS DE LA RESOLUCION</span></td>
                                </tr>


                                <tr>
                                    <td width="16%"><span class="Estilo8">N. RESOLUCION</span></td>
                                    <td width="29%"><span class="Estilo8">
                                            <input type="text" name="resolucion" value="<%=saldoF.getResolucion() != null ? saldoF.getResolucion() : ""%>" <%=read%> style="width:170px;color:#333333;text-align:center"/>
                                        </span>						</td>
                                    <td width="20%"><span class="Estilo8">FECHA RES.</span></td>
                                    <td width="35%"><span class="Estilo8">
                                            <input type="text" name="fecha" value="<%=saldoF.getFecha_resolucion() != null ? (new java.text.SimpleDateFormat("dd/MM/yyyy").format(saldoF.getFecha_resolucion())) : ""%>" <%=read%> onkeyup="mascara(this,'/',true)" maxlength="10" style="width:130px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333;text-align:center"/>
                                            <input name="fechadoc" type="button" id="fechadoc" value="&gt;" <%=(read.equals("readonly")?"disabled":"")%> style="width:35px"/>
                                            <script type="text/javascript">
                                                Calendar.setup({
                                                    inputField     :    "fecha",      // id del campo de texto
                                                    ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                                    button         :    "fechadoc"   // el id del bot?n que lanzar? el calendario
                                                });
                                            </script>
                                        </span>						</td>

                                </tr>
                                <tr>
                                    <td width="16%"><span class="Estilo8">OBSERVACION</span></td>
                                    <td colspan="3"><span class="Estilo8">
                                            <input type="text" name="observacion" value="<%=saldoF.getObservacion() != null ? saldoF.getObservacion() : ""%>"  <%=read%> style="width:460px;color:#333333;text-align:center" />
                                        </span>						</td>


                                </tr>

                            </table>
                        </fieldset>		  </td>
                </tr>
                <% if(!read.equals("")){ %>
                <tr>
                    <td colspan="3">
                        <fieldset class="style1">
                            <table width="100%" border="0" align="center">
                                <tr style="border:none; background:url(../html/images/inicio_3.png)">
                                    <td colspan="6" align="center" valign="middle"><span class="Estilo18">DATOS DE LA DEVOLUCION</span></td>
                                </tr>
                                <tr>
                                    <td width="16%"><span class="Estilo8">USUARIO</span></td>
                                    <td width="29%"><span class="Estilo8">
                                            <% Usuario UsuarioDev = modelo.consultarUsuario(saldoF.getFk_usuario_devolucion());%>
                                            <input type="text" value="<%=UsuarioDev.getNombre()!=null? UsuarioDev.getNombre() : ""%>" readonly style="width:170px;color:#333333;text-align:center"/>
                                        </span>						</td>
                                    <td width="20%"><span class="Estilo8">FECHA DEV.</span></td>
                                    <td width="35%"><span class="Estilo8">
                                            <input type="text" value="<%=saldoF.getFecha_devolucion() != null ? (new java.text.SimpleDateFormat("dd/MM/yyyy").format(saldoF.getFecha_devolucion())) : ""%>" readonly style="width:130px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333;text-align:center"/>
                                        </span>						</td>

                                </tr>

                            </table>
                        </fieldset>
                    </td>
                </tr>
                <% } %>
                <tr>

                    <td colspan="3">
                        &nbsp;
                    </td>
                </tr>
                <% if(read.equals("")){ %>
                <tr>

                    <td colspan="3" align="center">
                        <input type="button" name="enviar" value="Registrar Devolucion" onclick="registrarDev()"/>
                    </td>
                </tr>
                <% } %>
            </table>
        </form>
    </body>
    <%     }
    }
}%>
</html>

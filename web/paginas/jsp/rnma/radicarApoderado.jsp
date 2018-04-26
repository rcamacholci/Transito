<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="java.util.*"%>
<%@page import="modelo.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Radicar Apoderado</title>
        <%
            try {
                if (session.getAttribute("model") != null) {
                    // if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                    if (1 == 1) {
                        String sccn = "";
                        Parametro parametro = new Parametro();
                        Model model = (Model) session.getAttribute("model");
                        int index = Integer.parseInt(request.getParameter("indexpropietario"));
                        List<Propietario> tempropietario = (List<Propietario>) session.getAttribute("listpropietarios");
                        Propietario propietario = tempropietario.get(index);
                        Persona persona = model.consultarPersona(propietario.getFk_persona());
                        String txtnombre = "";
                        if (persona != null) {
                            txtnombre = persona.getNombre_1() + " " + persona.getApellido_1();
                             sccn = "listradicacionapoderados"+persona.getId_persona()+"";
                        }

        %>    
    </head>
    <link rel=stylesheet href="../../html/css/Style.css" type="text/css" media=screen></link>
    <script type="text/javascript" src="../../html/scripts/motorAjax.js"></script>
    <script type="text/javascript" src="../../html/scripts/personas.js"></script>
    <script type="text/javascript">
        function consultaPersona(campoP) {
            if (!isNaN(campoP.value) && campoP.value.length > 0) {
                tipo = document.getElementById("cmdtipodocumento");
                tipoDoc = tipo.options[tipo.options.selectedIndex].value
                ajax = nuevoAjax();
                ajax.open("POST", "../getPersona.jsp", true);
                ajax.onreadystatechange = function () {
                    if (ajax.readyState == 4) {
                        var respuesta = "";
                        for (var i = 0; i <= ajax.responseText.length + 1; i++) {
                            if (isNaN(ajax.responseText.charAt(i)))
                                document.getElementById("txtnombres").value = respuesta;
                                respuesta += ajax.responseText.charAt(i);
                                document.getElementById("txtnombres").disabled = true;
                        }
                        if (respuesta == "nueva") {
                            document.getElementById("txtnombres").value = "";
                            viewPersona(tipoDoc, campoP.value);
                        } else {
                            //consultaCartera(id,ajax.responseText,tipoDoc,campoP.value);
                        }
                    }
                }
                ajax.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                ajax.send("documento=" + campoP.value + "&tipo=" + tipoDoc);
            }
        }
        function Back() {
            document.location.href = "ListarPropietario.jsp?nuevo=S";
        }
        function Agregar(){
 if (document.form.txtdocumento.value.length > 0) {
                document.form.op.value = "agregar";
                document.form.action = "radicarApoderado.jsp";
                document.form.submit();
            } else {
                if (document.form.txtdocumento.value.length == 0) {
                    document.getElementById("txtdocumento").focus();
                    alert("el Campo documento no puede ser vacio");
                } 
            }
        }
    </script>
    <% if (request.getParameter("op") != null) {
            if (request.getParameter("op").equals("agregar")) {
                List<Radicacion_Apoderado> listradicaionapoderado = new LinkedList<Radicacion_Apoderado>();
                Radicacion_Apoderado radicacion = new Radicacion_Apoderado();
                if (session.getAttribute("listradicacionapoderados"+persona.getId_persona()) != null) {
                    listradicaionapoderado = (List<Radicacion_Apoderado>) session.getAttribute("listradicacionapoderados"+persona.getId_persona());
                }
                String fecha = (new SimpleDateFormat("dd/MM/yyyy")).format(new java.util.Date());
                java.sql.Date fecha_actual = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fecha).getTime());
                radicacion.setFecha_inicio(fecha_actual);
                long fk_propietario = Long.parseLong(request.getParameter("propietario"));
                int tipo = Integer.parseInt(request.getParameter("cmdtipodocumento"));
                String documento = request.getParameter("txtdocumento");
                Persona per = model.consultarPersona(tipo, documento);
                radicacion.setFk_apoderado(per.getId_persona());// fk_apoderado es el id_persona de quien sera apoderado del propietario.
                radicacion.setFk_propietario(fk_propietario);
                listradicaionapoderado.add(radicacion);
                session.setAttribute(sccn, listradicaionapoderado);
            }
        }else{
                //session.removeAttribute("listradicacionapoderados"+persona.getId_persona());
        }
    %>
    <body>
        <form id="form" name="form"/>
        <input type="hidden" id="indexpropietario" name="indexpropietario" value="<%=index%>"></input>
        <input type="hidden" id="propietario" name="propietario" value="<%=persona.getId_persona()%>"></input>
        <input type="hidden" id="op" name="op"/>
        <fieldset>
            <legend class="label" align="center" style="width: auto">Apoderado De <%=txtnombre%></legend>
            <table border="0" align="left">
                <tr >
                    <tr class="labelTr"  style="background:url(../../html/images/inicio_3.png);color: #ffffff">
                        <th width="97" scope="col"><b>&nbsp;Tipo&nbsp;documento</b></th>
                        <th width="124" scope="col"><b>&nbsp;Documento</b></th>
                        <th width="320" scope="col"><b>&nbsp;Nombres</b></th>
                        <th width="124" scope="col"><b>&nbsp;Accion</b></th>
                    </tr>
                    <%if (session.getAttribute(sccn) != null) {
                            List<Radicacion_Apoderado> listradicaion = (List<Radicacion_Apoderado>) session.getAttribute(sccn);
                            int ind = 0;
                            for (Radicacion_Apoderado pro : listradicaion) {
                                Persona pe = model.consultarPersona(pro.getFk_apoderado());
                    %>
                    <tr>
                        <td>&nbsp;<select id="cmdtipodocumento" name="cmdtipodocumento" style="width:auto" class="select" disabled>
                                <%
                                    List tipos = model.listadoParametros(5);
                                    for (int j = 0; j < tipos.size(); j++) {
                                        Parametro param = (Parametro) tipos.get(j);
                                        if (param.getCodigo() == pe.getTipo_documento()) {
                                %>					
                                <option value="<%=param.getCodigo()%>"><%=param.getNombreCorto()%></option>
                                <%
                                        }//if
                                    }//next
                                    //}//next 
                                %>
                            </select>		
                            </select></td>
                        <td>&nbsp;<input type="text" class="text"  id="txtdocumento<%=ind%>" name="txtdocumento<%=ind%>" style="width: 60%"value="<%=pe.getDocumento()%>" disabled /></td>
                        <td>&nbsp;<input type="text" class="text"  id="txtnombres<%=ind%>" name="txtnombres<%=ind%>" value="<%=pe.getNombre_1() + " " + (pe.getNombre_2() != null ? pe.getNombre_2() : "") + " " + pe.getApellido_1() + " " + (pe.getApellido_2() != null ? pe.getApellido_2() : "")%>" style="width: 90%"  disabled /></td>
                        <td>&nbsp;<input type="button" class="text" value="Eliminar" id="eliminar<%=ind%>" name="elimiar<%=ind%>" onclick="Eliminar('<%=ind%>')" style="width: 90%" /></td>
                    </tr>
                    <%
                            ind++;
                        }//next
                    }else{
                    %>
                    <td>&nbsp;<select id="cmdtipodocumento" name="cmdtipodocumento" style="width:auto" class="select">
                            <%
                                List tipos = model.listadoParametros(5);
                                for (int j = 0; j < tipos.size(); j++) {
                                    Parametro param = (Parametro) tipos.get(j);
                            %>					
                            <option value="<%=param.getCodigo()%>"><%=param.getNombreCorto()%></option>
                            <%
                                } %>
                        </select>		
                        </select></td>
                    <td>&nbsp;<input type="text" class="text"  id="txtdocumento" name="txtdocumento" style="width: 60%"onblur="consultaPersona(this)" /></td>
                    <td>&nbsp;<input type="text" class="text" id="txtnombres" name="txtnombres" style="width:90%" disabled /></td>

                    <td>&nbsp;<input type="button"  class="text" id="agregar" name="agregar" value="Agregar" onclick="Agregar()" style="width: 90%" /></td>
                </tr>
                <%}%>
                <tr>
                    <td align="left" colspan="4">&nbsp;<input type="button"  class="text" id="atras" name="atras" value="Atras" onclick="Back()" style="width: 7%" /></td>
                </tr>
            </table>
            <form>
                </body>
                <%  
                    } else { %>
                <jsp:forward page="no_access.jsp">
                    <jsp:param name="tipo" value="1"></jsp:param>
                </jsp:forward>
                <%  }
        } else { %>
                <script>
                    window.parent.document.location.href = "../../../index.jsp";
                </script>  <%
                    }
                } catch (Exception mexe) {%>
                <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
                <%
            }%>
                </html>

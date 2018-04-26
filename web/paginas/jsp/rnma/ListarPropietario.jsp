<%@page import="java.text.SimpleDateFormat"%>
<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <%
        try {
            if (session.getAttribute("model") != null) {
                // if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                if (1 == 1) {
                    Parametro parametro = new Parametro();
                    Model model = (Model) session.getAttribute("model");
                    int porcentajetotal =0;
    %>    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>Propietarios</title>
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
                            document.getElementById("txtporcentaje").disabled = false;

                        }
                        if (respuesta == "nueva") {
                            document.getElementById("txtnombres").value = "";
                            document.getElementById("txtporcentaje").disabled = true;
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

        function validarPorcentaje(input) {
            if (input.value > 100) {
                input.value = 0;
                alert("no se debe colocar una sifra mayor a 100");
            } else {
                return true;
            }
        }
        function modificaion(index) {
            document.form.index.value = index;
            document.form.nuevo.value = "modificar";
            var por = document.getElementById("txtporcentaje" + index).value;
            if (por.length > 0 && por <101) {
                document.form.accion = "ListarPropietario.jsp";
                document.form.submit();
            } else {
                alert("El pocerntaje de propiedad debe ser mayor a 0 (cero) o igual 100 (cien) ")
                document.getElementById("txtporcentaje" + index).focus();
            }
        }
        function Agregar() {

            if (document.form.txtdocumento.value.length > 0 && document.form.txtporcentaje.value.length > 0) {
                document.form.nuevo.value = "agregar";
                document.form.action = "ListarPropietario.jsp";
                document.form.submit();
            } else {
                if (document.form.txtdocumento.value.length == 0) {
                    document.getElementById("txtdocumento").focus();
                    alert("el Campo documento no puede ser vacio");
                } else {
                    alert("El campo Porcentaje es aobligatorio");
                    document.form.txtporcentaje.focus();
                    document.form.txtporcentaje.style.border = "inset";

                }
            }
        }

        function Eliminar(id) {
            if (document.getElementById("txtdocumento" + id).value.length > 0) {
                document.form.nuevo.value = "eliminar";
                document.form.index.value = id;
                document.form.action = "ListarPropietario.jsp";
                document.form.submit();
            }
        }
function Rapoderado(index){
    alert(index)
    document.form.index.value=index;
    document.location.href="radicarApoderado.jsp?indexpropietario="+index;
}
    </script>
    <body>
        <%
            if (request.getParameter("nuevo") != null) {
                if (request.getParameter("nuevo").equals("agregar")) {
                    boolean Sw = true;
                    int Sun = 0;
                    Propietario propietario = new Propietario();
                    List<Propietario> listpropietario = new LinkedList<Propietario>();
                    List<Radicacion_Propietario> listradicacionpropietario = new LinkedList<Radicacion_Propietario>();
                    Persona per = model.consultarPersona(Integer.parseInt(request.getParameter("cmdtipodocumento")), request.getParameter("txtdocumento"));
                    if (session.getAttribute("listpropietarios") != null && session.getAttribute("listradicacionpropietario") != null) {
                        listpropietario = (List<Propietario>) session.getAttribute("listpropietarios");
                        listradicacionpropietario = (List<Radicacion_Propietario>) session.getAttribute("listradicacionpropietario");
                        for (Propietario po : listpropietario) {
                            if (po.getFk_persona() == per.getId_persona()) {
                                Sw = false;
                            }//If 
                            Sun += po.getPorcentaje();

                        }//Next 
                        Sun = Sun + Integer.parseInt(request.getParameter("txtporcentaje"));
                        Sw = Sun <= 100 && Sw == true ? true : false;
                    }

                    String fecha = (new SimpleDateFormat("dd/MM/yyyy")).format(new java.util.Date());
                    java.sql.Date fecha_actual = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fecha).getTime());
                    propietario.setFecha_inicio(fecha_actual);
                    propietario.setFk_persona(per.getId_persona());
                    propietario.setPorcentaje(Integer.parseInt(request.getParameter("txtporcentaje")));
                    propietario.setProIndiviso(request.getParameter("cmdproindiviso"));
                    propietario.setTipoPropiedad(request.getParameter("cmdtipopropiedad"));
                    if (Sw) {
                        listpropietario.add(propietario);
                    } else {
                        if (!(Sun > 100)) {
        %>
        <script type="text/javascript">
            alert("La persona con documento <%=per.getDocumento()%>  ya esta en la lista");
        </script>
        <%
        } else {
        %>
        <script type="text/javascript">
            alert("La Suma del porcentaje de propiedad de ser 100%");
        </script>
        <%
                        }
                    }

                    Radicacion_Propietario radicacion_Propietario = new Radicacion_Propietario();
                    radicacion_Propietario.setFk_persona(per.getId_persona());
                    radicacion_Propietario.setPorcentaje(propietario.getPorcentaje());
                    radicacion_Propietario.setProIndiviso(propietario.getProIndiviso());
                    radicacion_Propietario.setTipoPropiedad(propietario.getTipoPropiedad());
                    session.setAttribute("listpropietarios", (List<Propietario>) listpropietario);
                    listradicacionpropietario.add(radicacion_Propietario);
                    session.setAttribute("listradicacionpropietario", (List<Radicacion_Propietario>) listradicacionpropietario);
                } else {
                    if (request.getParameter("nuevo").equals("eliminar")) {
                        System.out.println("eliminar");
                        List<Propietario> listpropietario = (List<Propietario>) session.getAttribute("listpropietarios");
                        List<Radicacion_Propietario> listradicacionpropietario = (List<Radicacion_Propietario>) session.getAttribute("listradicacionpropietario");
                        long id = Long.parseLong(request.getParameter("index"));
                        System.out.println("antes /*" + listpropietario.size());
                        listpropietario.remove(listpropietario.get((int) id));
                        listradicacionpropietario.remove(listradicacionpropietario.get((int) id));
                        System.out.println(" /*" + listpropietario.size());
                        if (listpropietario.size() > 0) {
                            session.setAttribute("listpropietarios", (List<Propietario>) listpropietario);
                            session.setAttribute("listradicacionpropietario", (List<Radicacion_Propietario>) listradicacionpropietario);
                        } else {
                            session.removeAttribute("listpropietarios");
                            session.removeAttribute("listradicacionpropietario");
                        }
                    } else if (request.getParameter("nuevo").equals("modificar")) {
                        Propietario propietario = new Propietario();
                        List<Propietario> listpropietario = new LinkedList<Propietario>();
                        List<Radicacion_Propietario> listradicacionpropietario = new LinkedList<Radicacion_Propietario>();
                        listpropietario = (List<Propietario>) session.getAttribute("listpropietarios");
                        int index = Integer.parseInt(request.getParameter("index"));
                        int porcentaje = Integer.parseInt(request.getParameter("txtporcentaje" + index));
                        //**//
                        boolean Sw = false;
                        int Sun = 0;
                        int ind = 0;
                       for (Propietario po : listpropietario) {
                            Sun += po.getPorcentaje();
                        }//Next 
                        //Sun = Sun + (Integer.parseInt(request.getParameter("txtporcentaje"+index)));
                        //**//
                        if(Sun<=100){
                            if((porcentaje+Sun)<=100){
                        listpropietario.get(index).setPorcentaje(porcentaje); 
                        session.setAttribute("listpropietarios", listpropietario);
                        listradicacionpropietario = (List<Radicacion_Propietario>) session.getAttribute("listradicacionpropietario");
                        listradicacionpropietario.get(index).setPorcentaje(porcentaje);
                        session.setAttribute("listradicacionpropietario", (List<Radicacion_Propietario>) listradicacionpropietario);
                            }else{
                        Sun =100-Sun;
                        listpropietario.get(index).setPorcentaje(Sun); 
                        session.setAttribute("listpropietarios", listpropietario);
                        listradicacionpropietario = (List<Radicacion_Propietario>) session.getAttribute("listradicacionpropietario");
                        listradicacionpropietario.get(index).setPorcentaje(Sun);
                        session.setAttribute("listradicacionpropietario", (List<Radicacion_Propietario>) listradicacionpropietario);
                        
                        }
                        }
                    }
                }
            } else {
                session.removeAttribute("listpropietarios");
                session.removeAttribute("listradicacionpropietario");
                session.removeAttribute("listradicacionapoderados");
            }
        %>
        <form id="form" name="form" method="post">
            <input id="nuevo" name="nuevo" type="hidden"/>
            <input id="index" name="index" type="hidden"/>
            <table  border="0" cellspacing="1" cellpadding="1">
                <tr class="labelTr"  style="background:url(../../html/images/inicio_3.png);color: #ffffff">
                    <th width="97" scope="col"><b>&nbsp;Tipo&nbsp;documento</b></th>
                    <th width="124" scope="col"><b>&nbsp;Documento</b></th>
                    <th width="340" scope="col"><b>&nbsp;Nombres</b></th>
                    <th width="145" scope="col"><b>&nbsp;Tipo&nbsp;propiedad</b></th>
                    <th width="52" scope="col"><b>&nbsp;PI</b></th>
                    <th width="55" scope="col"><b>&nbsp;Porcentaj</b>e</th>
                    <th width="101" scope="col"><b>&nbsp;Apoderado</b></th>
                    <th width="124" scope="col"><b>&nbsp;Guardar</b></th>
                </tr>
                <!--listsession-->
                <%
            List<Propietario> listpropietario = new LinkedList<Propietario>();
                    if (session.getAttribute("listpropietarios") != null) {
                        listpropietario = (List<Propietario>) session.getAttribute("listpropietarios");
                        int ind = 0;
                        for (Propietario pro : listpropietario) {
                            Persona pe = model.consultarPersona(pro.getFk_persona());
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
<td>&nbsp;<select id="cmdtipopropiedad<%=ind%>" name="cmdtipopropiedad<%=ind%>" class="select" style="width:90%" disabled>
                            <%
                                java.util.List tipospropiedades = model.listadoParametros(327);
                                for (int j = 0; j < tipospropiedades.size(); j++) {
                                    Parametro param = (Parametro) tipospropiedades.get(j);
                                    if (("" + param.getCodigo()).equals(pro.getTipoPropiedad())) {%>
                            <option value="<%=param.getCodigo()%>"><%=param.getNombre()%></option>
                            <%
                                    }//if
                                }//next %>
                        </select>
                    </td>
                                <td>&nbsp;<select id="cmdproindiviso<%=ind%>" name="cmdproindiviso<%=ind%>" class="select" style="width: auto" disabled>
                            <%if (pro.getProIndiviso().equals("S")) {%>
                            <option value="S">SI</option>
                            <%} else {%>
                            <option value="N">NO</option>
                            <%}%>
                        </select>
                    </td>
                            <td class="text">&nbsp;<input type="text" class="text"  id="txtporcentaje<%=ind%>" name="txtporcentaje<%=ind%>" style="width: 30%" onblur="modificaion('<%=ind%>')" maxlength="3" value="<%=pro.getPorcentaje()%>" /> % </td>
                            <td align="center" class="text">
                                <input type="button" value="+" class="text" style="width:10%;text-align: center" onclick="Rapoderado('<%=ind%>')" />
                    </td>
                            <td>&nbsp;<input type="button" class="text" value="Eliminar" id="eliminar<%=ind%>" name="elimiar<%=ind%>" onclick="Eliminar('<%=ind%>')" style="width: 90%" /></td>
                </tr>
                <%
                porcentajetotal +=pro.getPorcentaje();
                            ind++;
                        }//next
                    } if (porcentajetotal<100){
                %>
                <!--fin list session-->
                <tr >
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
                        <td>&nbsp;<select id="cmdtipopropiedad" name="cmdtipopropiedad" class="select" style="width: 90%">
                            <%
                                java.util.List tipospropiedades = model.listadoParametros(327);
                                for (int j = 0; j < tipospropiedades.size(); j++) {
                                    Parametro param = (Parametro) tipospropiedades.get(j);
                            %>
                            <option value="<%=param.getCodigo()%>"><%=param.getNombre()%></option>
                            <%
                                } %>
                        </select>
                    </td>
                        <td>&nbsp;<select id="cmdproindiviso" name="cmdproindiviso" class="select" style="width: auto">
                            <option value="S">SI</option>
                            <option value="N">NO</option>
                        </select>
                    </td>
                        <td class="text">&nbsp;<input type="text" class="text"  id="txtporcentaje" name="txtporcentaje" style="width: 30%" maxlength="3" onblur="validarPorcentaje(this)"  /> % </td>
                        <td align="center" class="text">
                        <input type="button" value="+" disabled class="label"  style="width:10%"/>
                    </td>
                        <td>&nbsp;<input type="button"  class="text" id="agregar" name="agregar" value="agregar" onclick="Agregar()" style="width: 90%" /></td>
                </tr>
                        <%}%>
            
            </table>
            <input type="hidden" name="hdpropietarios" id="hdpropietarios" value="<%=listpropietario.size()%>" />
            <input type="hidden" name="sumap" id="sumap" value="<%=porcentajetotal%>" />
        </form>

        <%  } else { %>
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
    </body>   
</html> 


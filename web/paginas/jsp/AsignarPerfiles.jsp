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
        <title>Recursos</title>

        <style type="text/css">
            <!--
            .style3 {
                font-family: Tahoma;
                font-weight: bold;
                font-size: 12px;
                color: #FFFFFF;
            }
            .style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
            .Estilo2 {font-family: Tahoma; font-weight: bold; font-size: 10px; }
            .style5 {color: #333333}
            .style6 {font-family: Tahoma; font-weight: bold; font-size: 12px; color: #333333; }
            -->
        </style>
        <script language="javascript" type="text/javascript">
            function sombrear(tr) {
                tr.style.backgroundColor = "#CCCCCC";
            }
            function renovar(tr) {
                tr.style.backgroundColor = "#FFFFFF";
            }
            function volver() {
                document.location.href = "verUsuarios.jsp";
            }

            function nuevoAjax() {
                var xmlhttp = false;
                try {
                    xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
                } catch (e) {
                    try {
                        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
                    } catch (E) {
                        xmlhttp = false;
                    }
                }

                if (!xmlhttp && typeof XMLHttpRequest != 'undefined') {
                    xmlhttp = new XMLHttpRequest();
                }

                return xmlhttp;
            }

            function resetear(user) {
                if (confirm("Esta usted seguro de resetear el password del usuario")) {
                    resetPassword(user);
                }
            }
            function resetearRunt(user) {
                if (confirm("Esta usted seguro de resetear el password Runt del usuario")) {
                    resetPasswordRunt(user);
                }
            }

            function resetPassword(user) {
                ajax2 = new nuevoAjax();
                ajax2.open("POST", "resetPassword.jsp", true);
                ajax2.onreadystatechange = function() {
                    if (ajax2.readyState == 4) {
                        var respuesta = ajax2.responseText;
                        alert(respuesta);
                    }
                }
                ajax2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                ajax2.send("usuario=" + user);
            }

            function resetPasswordRunt(user) {
                ajax2 = new nuevoAjax();
                ajax2.open("POST", "ResetPasswordRunt.jsp", true);
                ajax2.onreadystatechange = function() {
                    if (ajax2.readyState == 4) {
                        var respuesta = ajax2.responseText;
                        alert(respuesta);
                    }
                }
                ajax2.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                ajax2.send("usuario=" + user);
            }

           function editarUsuario(){
               document.getElementById('cargoActual').style.display = 'none';
               document.getElementById('editarC').style.display = 'block';
               window.frames[0].location.href = "editarCargos.jsp?id_usuario="+document.form.id_usuario.value;
           }

        </script>
    </head>
    <%@ page import="modelo.*"%>
    <%@page import="java.util.*"%>



    <%
        long id_usuario = Long.parseLong(request.getParameter("id_usuario"));

        Usuario usuario = modelo.consultarUsuario(id_usuario);


    %>




    <body bgcolor="#FFFFFF">
        <form id="form" name="form" method="post" action="procesarUsuarioPerfil.jsp">
            <input name="id_usuario" type="hidden" value="<%= usuario.getId_usuario()%>"/>

            <fieldset><legend align="center" class="style3 style5">Información usuarios</legend>
                <table width="60%" border="0" align="center" cellpadding="1" cellspacing="0">
                    <tr><td colspan="4">&nbsp;</td></tr>
                    <tr class="style3">
                        <td colspan="4" align="center"><span class="style6">USUARIO : <%= usuario.getNombre()%></span></td>
                    </tr>
                    <tr><td colspan="4">&nbsp;</td></tr>
                    <tr  style="border:none; background:url(../html/images/inicio_3.png)">
                        <th colspan="2" style="border:none; color: white"><span class="Estilo1 Estilo4">Nombre Perfil</span></th>
                        <th style="border:none; color: white"><span class="Estilo1 Estilo4">Grupo Cargo</span></th>
                        <th style="border:none; color: white"><span class="Estilo1 Estilo4">Cargo</span></th>
                        <th>&nbsp;</th>
                    </tr>
                    <%
                        List perfilSel = modelo.listarPerfilesUsuarioByFkUusario(id_usuario);
                        List perfiles = modelo.listarPerfil();
                        Iterator itt = perfiles.iterator();
                        Cargo cargo = modelo.consultarCargoByUsuario(id_usuario);
                        while (itt.hasNext()) {
                            Perfil perfil = (Perfil) itt.next();
                            Usuario usu = modelo.consultarUsuario(perfil.getfk_usuario());

                            if (usu.getFechaFin() == null) {
                                if (perfilSel.contains(perfil.getId_perfil() + "")) {
                    %>
                    <tr class="style6">
                        <td colspan="1" width="5%"><span class="style5">
                                <input type="checkbox" name="perfiles"  disabled value="<%=perfil.getId_perfil()%>" <%=perfilSel.contains(perfil.getId_perfil() + "") ? "checked" : ""%> /></span>
                        </td>
                        <td><%= usu.getNombre().toUpperCase()%></td>
                        <div style="display: block;" id="cargoActual">
                            <% if(cargo!=null){
                            Parametro parametro = modelo.consultarParametro((int)cargo.getGrupo_cargo(), 358);
                            Parametro parametro2 = modelo.consultarParametro((int)cargo.getCargo(),359);
                            %>
                            <td><%=parametro.getNombre() %></td>
                            <td><%=parametro2.getNombre() %></td>
                            <td><img src="../html/images/editar.png"  width="22" height="22"  style="cursor:pointer" onclick="editarUsuario()"/><span class="style2">EDITAR</span></td>
                            <%}else{%>
                            <td colspan="2" align="right">&nbsp;</td>
                            <td><div align="center"><img src="../html/images/adicionar.gif" alt="Nueva" name="adicionarCargo" width="22" height="22" id="adicionarCargo" style="cursor:pointer" onclick="editarUsuario()"/>&nbsp;<span class="style4">AÑADIR NUEVO CARGO</span></div></td>
                            <%}%>
                        </div>

                    </tr>
                        <tr>
                            <td colspan="5"><div id="editarC" style="display: none">
                                <iframe src="" id="editarCargos" name="editarCargos" marginwidth="0" height="150" width="100%" marginheight="0" align="top" scrolling="auto" style="border:none"></iframe>
                                </div>
                            </td>
                        </tr>
                    <%}
                            }

                        }
%>
                    <tr>
                        <td colspan="2">&nbsp;</td>
                    </tr>
                    <tr style="border:none">
                        <td colspan="2" align="center" style="border:none">
                            <table border="0" width="70%" align="center">
                                <tr>
                                    <!---   	<td width="31%" align="center">
                                             <button  disabled type="submit" name="Submit"><span class="style2">Guardar</span></button>
                                    <!--<input type="submit" name="Submit" value="Guardar" style="width:100px" />-->
                                    <!---	    </td> ---->
                                    <td width="31%" align="center">
                                        <button type="button"  style="width:150px" name="Cancelar" onclick="volver()"><span class="style2">Cancelar </span><img src="../html/images/cancelar.png" width="19" height="18"/></button>					<!-- <input  type="button" name="Cancelar" value="Cancelar" style="width:100px" onclick="volver()" />-->
                                    </td>
                                    <td width="38%" align="center">
                                        <button  type="button" name="Resetear" style="width:150px" onclick="resetear('<%=usuario.getId_usuario()%>')" /><span class="style2">Reset Password&nbsp;</span><img src="../html/images/guardar.png" width="19" height="18"/></button>
                                    </td>
                                    <%
                                    UsuarioRunt usrunt = modelo.consultarUsuarioRunt(usuario.getId_usuario());
                                    if(usrunt!=null){
                                    %>
                                    <td width="50%" align="center">
                                        <button  type="button" name="ResetearRunt" style="width:170px" onclick="resetearRunt('<%=usuario.getId_usuario()%>')" /><span class="style2">Reset&nbsp;Password&nbsp;Runt</span><img src="../html/images/guardar.png" width="19" height="18"/></button>
                                    </td>
                                    <% } %>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </fieldset>
        </form>
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
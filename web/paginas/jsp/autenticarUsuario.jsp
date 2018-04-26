<%--
    Document   : autenticarUsuario
    Created on : 24/04/2015, 03:33:06 PM
    Author     : Jefrey
--%>

<%@page import="modelo.Persona"%>
<%@page import="modelo.UsuarioRunt"%>
<%@page import="modelo.Usuario"%>
<%@page import="modelo.Model"%>
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html lang="en">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <script src="../../script/script.js" type="text/javascript"></script>
        <link href="../../css/styles.css" rel="stylesheet" type="text/css"/>
        <script src="../html/scripts/runt.js" type="text/javascript"></script>
        <title>Autenticar Usuario Runt</title>
    </head>
    <%
        try {

            if (session.getAttribute("model") != null) {
                if (((java.util.LinkedList) session.getAttribute("permisosU")).contains("inicio.jsp")) {
                    Model model = (Model) session.getAttribute("model");
                    Usuario usuario = (Usuario) session.getAttribute("usuario");
                    UsuarioRunt userRunt = (UsuarioRunt) session.getAttribute("usuarioRunt");
                    session.setAttribute("waitmodel", model);
    %>
    <body>
        <form method="POST" name="form" action="prevalidar.jsp">
            <div id="apDiv1"></div>
            <div id="apDiv5">
                <input type="hidden" name="token" id="token" />
                <table width="95%" height="560px">
                    <tr>
                        <td scope="col" width="58%" align="center" valign="center"><img src="../../images/ministeriotransporte.png" width="560" height="180" align="middle"><p><div align="center"><img src="../../images/logo_runt.png" width="390" height="120" align="middle"></div></td>
                        <td width="1%">&nbsp;</td>
                        <td scope="col" width="41%" align="center" valign="center">

                            <fieldset>
                                <%
                                    Persona solicitante = model.consultarPersona(usuario.getFk_persona());
                                    String tipoDocumento = model.consultarParametro((int) solicitante.getTipo_documento(), 5).getNombre();
                                    String numeroDocumento = solicitante.getDocumento();
                                    String nombre = solicitante.getNombre_1() + " " + solicitante.getApellido_1();
                                %>
                                <div align="center" id="titulo">AUTENTICAR USUARIO RUNT</div><hr><p>

                                <div align="center" id="titulo"><img src="../../images/user.png" width="71" height="73">&nbsp;<img src="../../images/sch.jpg" width="98" height="73"><br><%=nombre%><br><label><%=tipoDocumento%>&nbsp;<%=numeroDocumento%></label></div><p>
                                <div class="progress" id="line-container"></div>
                                <p>
                                <div align="center" class="contenido" >
                                    <table width="343" border="0">
                                        <tr>
                                            <th>Estado</th>
                                            <td align="center"><span id="estado">SIN AUTENTICAR</span></td>
                                        </tr>

                                    </table>
                                    <p>
                                    <div style="text-align: center">
                                        <table align="center">
                                            <tr>
                                                <td>
                                                    <a href="" onclick="editarPassRunt()">Actualizar Contraseña Runt</a>&nbsp;&nbsp;&nbsp;
                                                </td>
                                                <td>
                                                    <input type="button" value="Autenticar" name="autenticar" id="autenticar" onclick="verificarTokenGenerado()" />
                                                </td>
                                                <td>
                                                    <input type="submit" value="Prevalidar" name="prevalidar" id="prevalidar" style="display: none;" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </fieldset>
                        </td>
                    </tr>
                </table>
            </div>
            <div id="apDiv4"><br>&copy; La Civica Impresores SAS</div>
        </form>
    </body>
    <%} else {
    %>
    <script language="javascript" type="text/javascript">
        document.location.href = "cerrarSesion.jsp";
    </script>
    <%
        }
    } else {
    %>
    <script language="javascript" type="text/javascript">
        alert("Su usuario no tiene permisos para este recurso.")
        document.location.href = "cerrarSesion.jsp";
    </script>
    <%
            }
        } catch (Exception ex) {
            System.out.println("Error En Prevalidacion : \n "+ex);
            ex.printStackTrace();
        }
    %>
</html>
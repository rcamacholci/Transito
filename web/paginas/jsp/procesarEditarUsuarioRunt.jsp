<%--
    Document   : procesarUsuarioRunt
    Created on : 30/04/2010, 06:18:18 PM
    Author     : Administrador
--%>

<%@ page  import = "modelo.*" import = "java.util.*" import = "java.sql.*" %>
<%
	Model model = (Model) session.getAttribute("model");
        Usuario user = (Usuario)session.getAttribute("usuario");
    try{
        model.getCon().setAutoCommit(false);
        if(request.getParameter("usuario")!=null && request.getParameter("contrasena")!=null && request.getParameter("newpassword")!=null){
        UsuarioRunt usuarioRunt = model.consultarUsuarioRunt(user.getId_usuario());
        String pass = request.getParameter("newpassword");

        if(usuarioRunt!=null){
            UsuarioRunt userr = model.consultarUsuarioRuntpass(Long.parseLong(request.getParameter("usuario")), request.getParameter("contrasena"), user.getId_usuario());
            if(userr!=null){
                model.editarPasswordRunt(pass, user.getId_usuario());
                model.getCon().commit();
            }else{   %>
                <script>
                        alert("El usuario y/o la contraseña son incorrectos");
                        document.location.href="editarpasswordRunt.jsp";
                </script>
<%
            }
        }

        }
        model.getCon().commit(); %>
                <script>
                        alert("Password cambiado Exitosamente");
                        window.close();
                </script>
<%

    }catch(Exception exc){
        model.getCon().rollback();
        exc.printStackTrace();%>
        <script>
                alert("Error al cambiar password Usuario Runt");
        </script>
        <%
    }
%>


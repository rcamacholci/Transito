<%--
    Document   : procesarUsuarioRunt
    Created on : 30/04/2010, 06:18:18 PM
    Author     : Administrador
--%>

<%@ page  import = "modelo.*" import = "java.util.*" import = "java.sql.*"    %>
<%
	Model model = (Model) session.getAttribute("model");
        Usuario user = (Usuario)session.getAttribute("usuario");
    try{
        model.getCon().setAutoCommit(false);
        if(request.getParameter("usuario")!=null && request.getParameter("contrasena")!=null){
        UsuarioRunt usuarioRunt = new UsuarioRunt();


        usuarioRunt.setFk_usuario(user.getId_usuario());
        usuarioRunt.setCodigo(request.getParameter("usuario"));
        usuarioRunt.setPassword(request.getParameter("contrasena"));
        usuarioRunt.setTemplate("");
        java.sql.Date  fecha = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fecha")).getTime());
        usuarioRunt.setFecha_ini(fecha);

        model.adicionarUsuarioRunt(usuarioRunt);
        model.getCon().commit();
        }
        model.getCon().commit(); %>
                <script>
                        alert("Usuario adicionado correctamente..");
                        window.close();
                </script>
<%

    }catch(Exception exc){
        model.getCon().rollback();
        exc.printStackTrace();%>
        <script>
                alert("Error al adicionar Usuario Runt");
        </script>
        <%
    }
%>


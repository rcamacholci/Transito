<%@ page  import="modelo.Usuario" import="modelo.Model"%>
<%@page import="Cifrado.*" %>
<%
    try {
        if(request.getParameter("usuario")!=null){
            if(!request.getParameter("usuario").equals("")){
                Model model = (Model) session.getAttribute("model");
                Usuario usuario = model.consultarUsuario(Long.parseLong(request.getParameter("usuario")));
                model.getCon().setAutoCommit(false);
                model.editarPassword(usuario.getId_usuario(),KeyStore.Encriptar(usuario.getNombre()));
                model.getCon().commit();
                out.print("Proceso exitoso");
            }
        }
    } catch (Exception exc) {
        out.print("Proceso NO Exitoso: "+exc.getMessage());
    }
%>

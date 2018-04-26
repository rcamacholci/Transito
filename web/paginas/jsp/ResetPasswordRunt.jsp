<%@ page  import="modelo.*" import="modelo.Model"%>
<%
    try {
        if (request.getParameter("usuario") != null) {
            if (!request.getParameter("usuario").equals("")) {
                Model model = (Model) session.getAttribute("model");
                Usuario usuario = model.consultarUsuario(Long.parseLong(request.getParameter("usuario")));
                model.getCon().setAutoCommit(false);
// model.editarPassword(usuario.getId_usuario(),usuario.getNombre());
                Persona persona = model.consultarPersona(usuario.getFk_persona());
                model.editarPasswordRunt(persona.getDocumento(), usuario.getId_usuario());
                model.getCon().commit();
                out.print("Proceso exitoso");
            }
        }
    } catch (Exception exc) {
        out.print("Proceso NO Exitoso: " + exc.getMessage());
    }
%>

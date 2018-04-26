<%@page import="modelo.*"%>
<%//GeneralDistribucion
    Model model = (Model) session.getAttribute("model");
    Sede sede = (Sede) session.getAttribute("sede");
    modelo.Usuario user = (modelo.Usuario) session.getAttribute("usuario");
    if (request.getParameter("caja") != null) { %>
<select name="usuario" id="usuario" style="color:#333333; width:150px">
    <%
        if (model.tienePermiso(user.getId_usuario(), 136)) {
    %>
    <option value="0">--General--</option>
    <%
        }

        long caja = Long.parseLong(request.getParameter("caja"));
        if (caja != 0) {
            java.util.List lista = model.consultarUsuariosCaja(caja);
            for (int i = 0; i < lista.size(); i++) {
                UsuarioCaja usuarioCaja = (UsuarioCaja) lista.get(i);
                if (usuarioCaja.getFechaFin() == null && usuarioCaja.getFk_usuario() == user.getId_usuario()) {
                    Usuario usuario = model.consultarUsuario(usuarioCaja.getFk_usuario());%>
    <option value="<%=usuario.getId_usuario()%>"><%=usuario.getNombre()%></option>
    <%}
     }
    }else {
        java.util.List usuarios = model.listarUsuarios(sede.getId_sede());
        for (int i = 0; i < usuarios.size(); i++) {
            Usuario usuario = (Usuario) usuarios.get(i);
            if (model.consultarCajaUsuario(usuario.getId_usuario()) != null && usuario.getId_usuario() == user.getId_usuario()) {%>
    <option value="<%=usuario.getId_usuario()%>"><%=usuario.getNombre()%></option>
    <%	 }
            }
        } %>
</select>
<%   }%>



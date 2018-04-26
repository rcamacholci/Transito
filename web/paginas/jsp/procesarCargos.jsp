<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*"%>
<%
Model model = (Model) session.getAttribute("model");
Usuario usuario = (Usuario) session.getAttribute("usuario");
model.getCon().setAutoCommit(false);
try{

if(!request.getParameter("id_usuario").equals("")){
    long id_usuario = Long.parseLong(request.getParameter("id_usuario"));
    int GrupoCargo = Integer.parseInt(request.getParameter("grupoC"));
    int carg = Integer.parseInt(request.getParameter("cargo"));
    Cargo cargo = model.consultarCargoByUsuario(id_usuario);

    Cargo c = new Cargo();
    c.setFk_usuario(id_usuario);
    c.setGrupo_cargo(GrupoCargo);
    c.setCodigo("0");
    c.setCargo(carg);
    c.setFk_usuario_proceso(usuario.getId_usuario());

    if(cargo!=null){
        model.actualizarCargoUsuario(usuario.getId_usuario(),id_usuario);
        model.ingresarCargosUsuario(c);
    }else{
        model.ingresarCargosUsuario(c);
    }
    model.getCon().commit();
    %>
    <script>alert("Proceso exitoso");document.href = "editarCargos.jsp";</script>
    <%
}
    }catch(Exception ex){
        %><script>alert("Error en el proceso");document.href = "editarCargos.jsp";</script><%
        ex.printStackTrace();
        model.getCon().rollback();
}
%>

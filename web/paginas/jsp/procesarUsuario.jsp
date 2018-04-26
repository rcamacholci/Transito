<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="Cifrado.*" errorPage="" %>
<%
Model modelo= (Model)session.getAttribute("model");
Usuario userSession = (Usuario)session.getAttribute("usuario");
try{
    if(session.getAttribute("model")!=null){
        if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("adicionarUsuario.jsp")){
            Sede sede = (Sede)session.getAttribute("sede");
            modelo.getCon().setAutoCommit(false);
            java.sql.Date fechaSystem = new java.sql.Date(new java.util.Date().getTime());
            int  tipo           =       Integer.parseInt(request.getParameter("tipo")) ;
            String documento    =       request.getParameter("documento");
            String username     =       request.getParameter("username");
            String password     =       request.getParameter("password");
            String p2="0";
            String p3="0";
            long cont=1;
            username = username.toUpperCase();
            Persona p=  modelo.consultarPersona(tipo, documento);
            if(p!=null){
                Usuario usuario=new Usuario();
                usuario.setFk_persona(p.getId_persona());
                usuario.setNombre(username);
                usuario.setPassword(KeyStore.Encriptar(password));
                usuario.setFechaInicio(fechaSystem);
                usuario.setFk_sede(sede.getId_sede());


                long idUsuario = modelo.adicionarUsuario(usuario);

                //Añadir Cargo

                int GrupoCargo = Integer.parseInt(request.getParameter("grupoC"));
                int carg = Integer.parseInt(request.getParameter("cargo"));

                Cargo c = new Cargo();
                c.setFk_usuario(idUsuario);
                c.setGrupo_cargo(GrupoCargo);
                c.setCodigo("0");
                c.setCargo(carg);
                c.setFk_usuario_proceso(userSession.getId_usuario());

                modelo.ingresarCargosUsuario(c);

                modelo.adicionarHUsuario(idUsuario, KeyStore.Encriptar(password), p2, p3, cont);
                modelo.adicionarHIS_PAS_USUARIO(idUsuario,KeyStore.Encriptar(password));

                String[] cajas = request.getParameterValues("cajas");
                if(cajas!=null){
                    for(int i=0; i<cajas.length;i++){
                        UsuarioCaja usuarioCaja = new UsuarioCaja();
                        usuarioCaja.setFk_usuario(idUsuario);
                        usuarioCaja.setFk_caja(Long.parseLong(cajas[i]));
                        usuarioCaja.setFk_sede(sede.getId_sede());
                        System.out.println(sede.getId_sede());
                        usuarioCaja.setFechaInicio(fechaSystem);
                        modelo.adicionarUsuarioCaja(usuarioCaja);
                    }
                }
                if(request.getParameter("runt")!=null){
                    if(request.getParameter("runt").equals("1")){
                        UsuarioRunt usuarioRunt = new UsuarioRunt();
                        usuarioRunt.setFk_usuario(idUsuario);
                        usuarioRunt.setCodigo(request.getParameter("usernameR"));
                        usuarioRunt.setPassword(request.getParameter("passwordR"));
                        usuarioRunt.setTemplate(request.getParameter("huella"));
                        usuarioRunt.setFecha_ini(fechaSystem);
                        modelo.adicionarUsuarioRunt(usuarioRunt);

                        byte[] tempAnt = modelo.consultarBiometricoTipoByte(p.getId_persona(),"TEMPLATE");
                        if(tempAnt==null){
                            Biometrico biometrico = new Biometrico();
                            biometrico.setId_persona(p.getId_persona());
                            biometrico.setTemplate(request.getParameter("huella").getBytes());
                            modelo.actualizarBiometrico(biometrico);
                        }
                    }
                }


                Perfil perfil = new Perfil();

                String descripcion = request.getParameter("descripcion");
                modelo.adicionarPerfilUsuarios(idUsuario, descripcion);

                perfil = modelo.consultarPerfilByUsuario(idUsuario);

                modelo.adicionarPerfilUsuario(idUsuario, perfil.getId_perfil());

                modelo.getCon().commit();

                %>
                <script>
                    alert("  El Usuario se Registro Correctamente...");
                    window.location.href="recursos_perfil.jsp?perfil="+<%=perfil.getId_perfil()%>;
                </script>
         <% }else{ %>
                <script>
                    alert("  Error, Es posible que la Persona no Exista ...");
                </script>
         <% }
        }else{ %>
               <jsp:forward page="no_access.jsp">
                     <jsp:param name="tipo" value="1"></jsp:param>
               </jsp:forward>
<%      }
    }else{ %>
            <script>
                    window.parent.document.location.href = "../../index.jsp";
            </script>  <%
    }
}catch(Exception mexe){
    mexe.printStackTrace();
     modelo.getCon().rollback();       %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>


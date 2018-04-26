<%@ page  import="modelo.Vehiculo" import="modelo.Model" import = "java.util.HashMap"%>
<%
    String result = "NO_ACCESO";
    try {
        if(request.getParameter("runt")!=null){
            if(!request.getParameter("runt").equals("")){
                Model model = (Model)session.getAttribute("model");
                 modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                 modelo.UsuarioRunt userRunt = model.consultarUsuarioRunt(usuario.getId_usuario());
                if(model!=null){
                        webservices.bancos.BancosServicesClient bancosServices = new webservices.bancos.BancosServicesClient();
                        bancosServices.setTokenHuellaDigital("");
                        bancosServices.setUser(userRunt.getCodigo());
                         Model.userHandler = userRunt.getCodigo();
                                    Model.passUserHandler = userRunt.getPassword();

                         if(session.getAttribute("token2")!=null){
                             bancosServices.setTokenHuellaDigital(session.getAttribute("token2").toString());
                        }
                        for(int i=0;i<3;i++){
                            result = bancosServices.consultarLiquidacionCUPL(request.getParameter("runt"));
                            if(!result.equals("NO_ACCESO"))
                                break;
                        }
                }
                out.print(result);
            }
        }
    } catch (Exception exc) {
        exc.printStackTrace();
        out.println(exc.getMessage());
    }
%>



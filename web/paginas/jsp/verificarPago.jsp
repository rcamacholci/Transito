<%@ page  import="modelo.Persona" import="modelo.Model" import = "java.util.HashMap"%>
<%
    try {
        if(request.getParameter("tramite")!=null&&request.getParameter("tipo")!=null&&request.getParameter("documento")!=null){
            if(!request.getParameter("tramite").equals("")&&!request.getParameter("tipo").equals("")&&!request.getParameter("documento").equals("")){
                Model model = (Model) session.getAttribute("model");
                if(model!=null){
                    Persona persona = model.consultarPersona(Integer.parseInt(request.getParameter("tipo")), request.getParameter("documento").trim());
                    long tramite = Long.parseLong(request.getParameter("tramite"));
                    String factura = model.obtenerPosiblePagoTRANSITO(persona.getId_persona(), tramite);
                    if(factura.length()==0){
                        factura = model.consultarPagoReclamo(2,persona.getId_persona()+"", tramite);
                        factura = factura!=null?factura:"";
                   }
                    out.print("&"+factura+"&");
                }
            }
        }
    } catch (Exception exc) {
        exc.printStackTrace();
    }
%>

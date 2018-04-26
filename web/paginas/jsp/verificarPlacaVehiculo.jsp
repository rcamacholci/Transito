<%@ page import="modelo.Model, modelo.Sede "%>
<%
    try{
        if(request.getParameter("placa")!=null){
             Model model = (Model)session.getAttribute("model");
             if(model!=null){
                 String placa = request.getParameter("placa").toUpperCase();
                 long idv = Long.parseLong(request.getParameter("idv"));
                 String respuesta = model.existeVehiculoRUNT(idv, placa);
                 out.print(respuesta);
             }
        }
    }catch(Exception ecx){
            ecx.printStackTrace();
            //REJ254
    }  %>

<?xml version="1.0" encoding="UTF-8"?>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/xml" import="java.util.*,modelo.*" %>

<root>
<%
Model modelo = (Model)session.getAttribute("model");

String sw = "0";
String valortim = "0";
String num_fact = "";
double vrete;

try{
    modelo.getCon().setAutoCommit(false);
    Usuario usuario = (Usuario)session.getAttribute("usuario");
    if(request.getParameter("idvehi")!=null && request.getParameter("vtim")!=null && request.getParameter("vigen")!=null){
        if(request.getParameter("nfact")!=null){
            num_fact = request.getParameter("nfact");
            long id_veh = Long.parseLong(request.getParameter("idvehi"));
            long valor_tim = Long.parseLong(request.getParameter("vtim"));
            String num = modelo.consultarFacturaTimbre(num_fact);
            long vig = Long.parseLong(request.getParameter("vigen"));
            int anoactual = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
            if(num==null){
                if(vig==anoactual){
                    modelo.InsertarValorTimbre(num_fact, valor_tim, id_veh, (int)usuario.getId_usuario(), vig);
                    sw = "1";
                    vrete = valor_tim*0.01;
                    valortim= ""+Math.round(vrete);
                }else{
                    sw = "3";
                }
            }else{
                sw = "2";
            }
        }else{
           long id_veh = Long.parseLong(request.getParameter("idvehi"));
           long valor_tim = Long.parseLong(request.getParameter("vtim"));
           String num = "";
           long vig = Long.parseLong(request.getParameter("vigen"));
           int anoactual = java.util.Calendar.getInstance().get(java.util.Calendar.YEAR);
               if(vig==anoactual){
                    modelo.InsertarValorTimbre(num_fact, valor_tim, id_veh, (int)usuario.getId_usuario(), vig);
                    sw = "1";
                    vrete = valor_tim*0.01;
                    valortim= ""+Math.round(vrete);
                }else{
                    sw = "3";
                }
        }
  }
    modelo.getCon().commit();

}catch(Exception ex){
    modelo.getCon().rollback();
    System.out.println("/*-"+ex+"*/");
}
%>
<valorti><%=valortim %></valorti>
<sw><%=sw %></sw>

</root>
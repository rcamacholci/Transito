<?xml version="1.0" encoding="UTF-8"?>

<%@ page contentType="text/xml" import="java.util.*,modelo.*" %>
<root>
<%

    if (request.getParameter("tipoD") != null && request.getParameter("numeroD") != null && session.getAttribute("listSolicitantes") != null && request.getParameter("token") != null) {
        
        Model model = (Model)session.getAttribute("model");
        
        List<Solicitantes> listSolicitantes = (List<Solicitantes>) session.getAttribute("listSolicitantes");
        boolean sw = false;
        
        for (int i = 0; i < listSolicitantes.size(); i++) {
            Solicitantes sol = (Solicitantes) listSolicitantes.get(i);
            Parametro par = model.consultarParametro(Integer.parseInt(request.getParameter("tipoD")), 5);
            if (sol.getTipodocumento().equals(par.getNombreCorto()) && sol.getDocumento().equals(request.getParameter("numeroD"))) {
                listSolicitantes.get(i).setToken(request.getParameter("token"));
                sw = true;
                break;
            }
        }
        
        session.setAttribute("listSolicitantes", listSolicitantes);
        
        System.out.println("Tipo Documento, Documento, Token");
        for(int i=0;i<listSolicitantes.size();i++){
            System.out.println(listSolicitantes.get(i).getTipodocumento()+","+listSolicitantes.get(i).getDocumento()+","+listSolicitantes.get(i).getToken());
        }
        
        if(sw){
            %><result>1</result><%
        }else{
            %><result>2</result><%
        }
    }
%>

</root>
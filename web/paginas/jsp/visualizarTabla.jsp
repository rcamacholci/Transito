<%@ page language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>VISUALIZACION DE TABLA PARAMETROS</title>
</head>
<body>
<%
    modelo.Model model = null;
    try {
        model = (modelo.Model) session.getAttribute("model");
        webservices.parametrizacion.DatosParametricosServicesClient parametrosClient = new webservices.parametrizacion.DatosParametricosServicesClient();
        parametrosClient.setUser(modelo.Model.userHandler);
        parametrosClient.setTokenHuellaDigital(modelo.Model.userToken);
        //java.util.List<com.heinsohn.runt.general.param.TablaParametricaDTO> listaT = parametrosClient.consultarTablasParametricas();
        java.util.List<com.heinsohn.runt.general.param.ParametroDTO> listaP = parametrosClient.consultarTabla(request.getParameter("id"));
        if(listaP!=null){
            out.println("TABLA:"+request.getParameter("id"));
                
            for(int j=0;j<listaP.size();j++){
                com.heinsohn.runt.general.param.ParametroDTO parametro = listaP.get(j);
                out.println("<br>"+parametro.getId()+ " - "+parametro.getDescripcion()+"</br>");
                //model.adicionarParametroRunt(request.getParameter("id"), parametro.getId(), parametro.getDescripcion());
            }
        }
        /*if(listaT!=null){
            out.print("Son en total "+listaT.size()+" Tablas");
            for(int i=0;i<listaT.size();i++){
                com.heinsohn.runt.general.param.TablaParametricaDTO tablap = listaT.get(i);
                if(tablap!=null){
                    out.print("Ingresar Tabla : "+tablap.getId());
                    model.adicionarTablaRunt(tablap.getId(), tablap.getDescripcion());
                    java.util.List<com.heinsohn.runt.general.param.ParametroDTO> listaP = parametrosClient.consultarTabla(tablap.getId());
                    if(listaP!=null){
                        for(int j=0;j<listaP.size();j++){
                            com.heinsohn.runt.general.param.ParametroDTO parametro = listaP.get(j);
                            model.adicionarParametroRunt(tablap.getId(), parametro.getId(), parametro.getDescripcion());
                        }
                    }
                }
            }
        }*/
        out.print("Proceso finalizado..");
    } catch (Exception exc) {
        exc.printStackTrace();
    }
%>
</body>
</html>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Procesar Rango</title>
</head>

<body>
 <%

    Model modelo= (Model)session.getAttribute("model");
    try{
        modelo.getCon().setAutoCommit(false);
        Rango rango = new Rango();

        int  tipo         =       Integer.parseInt(request.getParameter("tipo")) ;

        String inicio     =       request.getParameter("inicio");
        String nfinal     =       request.getParameter("nfinal");
        String resolucion =       request.getParameter("resolucion");
        java.sql.Date  fecha_res  = new java.sql.Date(new java.util.Date(request.getParameter("date")).getTime());
        java.sql.Date  fechaUpdate = new java.sql.Date(new java.util.Date().getTime());
        java.sql.Timestamp  fechaSystem= new java.sql.Timestamp(new java.util.Date().getTime());
        inicio           =             inicio.toUpperCase();
        nfinal           =             nfinal.toUpperCase();
        Sede sede = (Sede) session.getAttribute("sede");
        rango.setFk_sede(sede.getId_sede());
        rango.setNumero_ini(inicio);
        rango.setNumero_fin(nfinal);
        rango.setResolucion(resolucion);
        rango.setFecha_resolucion(fecha_res);
        rango.setFecha_proceso(fechaUpdate);
        rango.setEstado(1);
        rango.setTipo(tipo);
        modelo.adicionarRango(rango);

        long id_rango=modelo.consultarMaxRango();

        Vector rangos_placas = null;
        if(tipo!=5&&tipo!=6)
            rangos_placas = modelo.RangosPlacas(inicio, nfinal, tipo);
        else
            rangos_placas = modelo.RangosPlacasInvertido(inicio, nfinal, tipo);
        for(int i=0; i<rangos_placas.size() ; i++){
            Venal venal= new Venal();
              venal.setFk_rango(id_rango);
              String rangos= (String)rangos_placas.elementAt(i);
              venal.setNumero(rangos);
              venal.setEstado(1);
              modelo.adicionarVenal(venal);

        }
        %>

           <script language="javascript" type="text/javascript">
              alert("Rango a sido ingresado correctamente");
          </script>
<%
    modelo.getCon().commit();
}catch(Exception exc){
    exc.printStackTrace();
    modelo.getCon().rollback();
    %>
           <script language="javascript" type="text/javascript">
              alert("No pudo ser ingresado el rango");
          </script>
<%
}
    %>
   
</body>
</html>

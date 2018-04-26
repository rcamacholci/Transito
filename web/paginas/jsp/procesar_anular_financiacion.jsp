<%--
    Document   : procesar_comparendo.jsp
    Created on : 05-ene-2009, 18:33:30
    Author     : Javier
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">

<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<html>
    <head>
        <title></title>
    </head>
    <body>
        <%

            Model modelo = (Model) session.getAttribute("model");
            Usuario usuario = (Usuario) session.getAttribute("usuario");

            try {
                modelo.getCon().setAutoCommit(false);                
                java.sql.Timestamp fechaSystem = new java.sql.Timestamp(new java.util.Date().getTime());
                Financiacion_Anulada finanA = new Financiacion_Anulada();
                
                long idF = 0;
                if(request.getParameter("idFinanciacion")!=null){
                    idF = Long.parseLong(request.getParameter("idFinanciacion"));
                }                
                if (idF!=0) {
                    Financiacion finanC = modelo.consultarFinanciacion(idF);
                    if (finanC!=null) {
                        finanA.setFECHA_PROCESO(fechaSystem);
                        finanA.setESTADO(1);
                        finanA.setFK_USUARIO(usuario.getId_usuario());
                        finanA.setOBSERVACION(request.getParameter("observaciones"));
                        finanA.setFK_FINANCIACION(idF);
                        modelo.adicionarFinanciacionAnulada(finanA);

                        Detalle_Financiacion df = new Detalle_Financiacion();
                        java.util.List  listaD = modelo.listarDetalleFinanciacion(idF);
                        Iterator itt = listaD.iterator();
                        while (itt.hasNext()) {
                           df = (Detalle_Financiacion)itt.next();
                           Cartera cartera = modelo.consultarCartera(df.getFk_cartera());
                           modelo.actualizarCartera(cartera.getId_cartera(), 0, 3, 0, cartera.getFecha_saldo(), cartera.getFecha_estado(),3);
                           modelo.actualizarDetalleFinanciacion(cartera.getId_cartera(), 3);
                           modelo.actualizarFinanciacion(cartera.getId_cartera(), 3);
                        }
                        java.util.List<Financiacion_Cartera> listaC = modelo.consultarCarterasFinanciadas(idF);  
                        
                        for(Financiacion_Cartera dc:listaC){
                            Cartera carteraF = modelo.consultarCartera(dc.getFk_cartera());
                            modelo.actualizarCartera(carteraF.getId_cartera(), 0, 1, 0, carteraF.getFecha_saldo(), carteraF.getFecha_estado(),3);
                        }                        
                         
                        modelo.getCon().commit();
        %>
        <script language="javascript"  type="text/javascript">
            alert(" Acuerdo de Pago Anulado Correctamente :D ");
            window.location.parent.href='consultarFinanciacion.jsp';
        </script>


        <%	} else {
        %>
        <script language="javascript"  type="text/javascript">
           alert(" Error! no se encontrado financiacion a eliminar");
            location.href='consultarFinanciacion.jsp';
        </script>

        <%
                    modelo.getCon().rollback();
                }
            
        } else {
        %>
        <script language="javascript"  type="text/javascript">
            alert(" Error! en el proceso");
            location.href='consultarFinanciacion.jsp';
        </script>

        <%    }
            } catch (Exception exc) {
                exc.printStackTrace();
                System.out.println(exc.toString());

                modelo.getCon().rollback();
            }%>
    </body>
</html>

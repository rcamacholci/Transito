<%-- 
    Document   : ProcesarTipoPago
    Created on : 12/06/2012, 03:54:34 PM
    Author     : acer
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" errorPage="" import="java.text.SimpleDateFormat"%>
<%
        try{
        Model modelo= (Model)session.getAttribute("model");
        modelo.getCon().setAutoCommit(false);        
        String fecha=request.getParameter("fecha");
        long fcaja = Long.parseLong(request.getParameter("cj"));
        Long usu = Long.parseLong(request.getParameter("usu"));
        java.util.LinkedList par = modelo.listadoParametros(301);
        java.util.LinkedList imf = modelo.consultarTipoPagoByUsuario(usu,fcaja);
        boolean swith =true;
        long es =0;
        if((request.getParameterValues("Fcaja")!=null)){
                 String[] caja = request.getParameterValues("Fcaja");
                int f09[]= new int[1000];
                long tpg[]= new long[1000];
                if(caja!=null){
                 for(int i=0;i<caja.length;i++){
                     long ln =Long.parseLong(caja[i]);
                   for(int x =0;x<par.size();x++){
                       Parametro imfo =(Parametro) par.get(x);
                       TipoPagos tp = modelo.consultarTipopago(usu, fcaja,ln);
                        if(imfo.getCodigo()==ln){
                          if(tp==null){
                            es =1;
                            System.out.println(usu+"-"+fcaja+"-"+ln+"-"+es);
                            modelo.AdicionarUsuTipoPago(usu,fcaja,ln,es);
                        }else{
                            es=1;
                          modelo.ActualizarTipoPago(es,usu,fcaja,ln);
                          }
                         f09[x]=1;
                        }else{
                            if(f09[x]!=1){
                                f09[x]=0;
                                tpg[x]=imfo.getCodigo();
                            }
                        }
                       }//next
                   }//next
                 }//IF
                     for(int j=0;j<par.size();j++){
                         TipoPagos tp = modelo.consultarTipopago(usu, fcaja,tpg[j]);
                             if(f09[j]==0 && tp!=null){
                                System.out.println("atualizar>>"+es+"-"+usu+"-"+fcaja+"-"+tpg[j]);
                                  es=2;
                                  modelo.ActualizarTipoPago(es,usu,fcaja,tpg[j]);
                             }
                          }
               //ENDIF
                modelo.getCon().commit();
                %>
                <script>
                    alert(" Los Usuarios se Actualizon Correctamente...");
                    window.location.href="AdministrarCajas.jsp";
                </script>
         <%
         }else{
        try{
           if(swith==true){
            for(int i=0;i<par.size();i++){
                Parametro temp = (Parametro)par.get(i);
                TipoPagos tp = modelo.consultarTipopago(usu, fcaja,temp.getCodigo());
                if(tp!=null){
                //System.out.println("atualizar>>"+es+"-"+usu+"-"+fcaja+"-"+tpg[j]);
                es=2;
                modelo.ActualizarTipoPago(es,usu,fcaja,temp.getCodigo());
                  }
                }
                            modelo.getCon().commit();
                %>
                <script>
                    alert(" Los Usuarios se Actualizon Correctamente...");
                    window.location.href="AdministrarCajas.jsp";
                </script>
         <%
                }
            }catch(Exception ex){
                ex.printStackTrace();
           }
         }
         %>
                <script>
                    alert("  Los Usuarios No Puden ser Actualizados");
               window.location.href="pantallazo.jsp";
                </script>
<%
  
                }catch(Exception ex){
                ex.printStackTrace();

}%>

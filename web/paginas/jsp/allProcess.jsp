<%@page  import="modelo.*" import="java.util.*" %>
<%

        Model model = (Model) session.getAttribute("model") ;
        float valor = 0 ;
        if ( model!=null ){
            
            List<Pago> list = model.obtenerPagosaAProcesar() ;
            
            
            if ( list!=null ){
                model.getCon().setAutoCommit(false) ;
                
                for(Pago p:list){
                    valor += p.getValor_total() ;
                    model.aplicarPago(p) ;
                }
                model.getCon().commit();
            }
            
            
        }
        
        

out.print("<H1>VALOR APLICADO:" + valor + "<H1>") ;

%>

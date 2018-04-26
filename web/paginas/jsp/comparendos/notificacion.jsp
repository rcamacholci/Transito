<%
    modelo.Model m = (modelo.Model) session.getAttribute("model") ;
    modelo.Usuario u = (modelo.Usuario) session.getAttribute("usuario") ;
    long fkCmp = ( request.getParameter("fkc")!=null ) ? Long.parseLong(request.getParameter("fkc")) : 0 ;
    
    modelo.Comparendo c = m.consultarComparendoById(fkCmp) ;
    
    procesos.procesoContravencional p = new procesos.procesoContravencional() ;
    
    boolean n = p.generarNotificacion(m, u, c) ;
    System.out.println("NOTIFICACION GENERADA  " + n);
    


%>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" errorPage="" import="java.text.SimpleDateFormat"%>
<%
        try{
        Model modelo= (Model)session.getAttribute("model");
        Sede sede = (Sede)session.getAttribute("sede");
        java.sql.Date fechaUp = null;
        modelo.getCon().setAutoCommit(false);
        java.util.List ca = modelo.listarCaja();
        java.util.List<UsuarioCaja> temp = modelo.ListarUsuarioCajas();
        UsuarioCaja cinfo=null;
        String fecha = request.getParameter("fecha");
        Long usu = Long.parseLong(request.getParameter("usu"));
        cinfo=null;
        boolean swith =true;
        UsuarioCaja im=null;
        cinfo = modelo.consultarCajaUsuario(usu);
            if((request.getParameterValues("Fcaja")!=null)){
                String[] caja = request.getParameterValues("Fcaja");
                int f09[]= new int[1000];
                if(caja!=null){
                 for(int i=0;i<caja.length;i++){
                    long ln = Long.parseLong(caja[i]);
                    for(int j=0;j<ca.size();j++){
                     Caja imf = (Caja)ca.get(j);                     
                     UsuarioCaja k = modelo.consultarCajaUsuarioById_caja(ln, usu);
                        if(imf.getId_caja()==ln){
                         swith=false;
                         if(k == null){                         
                         fechaUp = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fecha).getTime());
                         UsuarioCaja usucaja = new UsuarioCaja();
                         usucaja.setFk_caja(ln);
                         usucaja.setFk_usuario(usu);
                         usucaja.setFk_sede(sede.getId_sede());
                         usucaja.setFechaInicio(fechaUp);
                         modelo.adicionarUsuarioCaja(usucaja);
                         modelo.getCon().commit();
                         }else{
                            System.out.println("actualizar a >> "+fechaUp+"-"+cinfo.getFk_usuario()+"-"+ln);
                            fechaUp = null;
                            modelo.HabilitarCaja(fechaUp,cinfo.getFk_usuario(),ln);
                         }
                           f09[j]=1;
                          }else{
                            if(f09[j]!=1){
                                f09[j]=0;                            
                            }//if
                          }//if
                    }//next
                      }//NEXTT
                     
                     for(int j=0;j<ca.size();j++){
                          UsuarioCaja k = modelo.consultarCajaUsuario(usu);
                          Caja caj = (Caja) ca.get(j);
                             if(f09[j]==0 && k.getFechaFin()==null){
                                fechaUp = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fecha).getTime());
                                System.out.println("cj>>"+caj.getId_caja()+"-"+fechaUp+""+k.getFk_usuario());
                                modelo.HabilitarCaja(fechaUp,k.getFk_usuario(),caj.getId_caja());
                             }
                          }
                }//ENDIF*/
                modelo.getCon().commit();
                %>
                <script>
                    alert(" Los Usuarios se Actualizon Correctamente...");
                    window.location.href="AdministrarCajas.jsp";
                </script>
         <%
         }
            try{
            if(swith==true){
            for(int i=0;i<ca.size();i++){
            Caja info = (Caja) ca.get(i);
                if(info.getFecha_fin()==null){
                System.out.println("<->"+i);
                fechaUp = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(fecha).getTime());
                modelo.HabilitarCaja(fechaUp,usu,info.getId_caja());
                }
                }
            }
            }catch(Exception ex){
                ex.printStackTrace();
           }
         
 

  
            }catch(Exception e){
                e.printStackTrace();
              %>
                <script>
                    alert("  Los Usuarios No Puden ser Actualizados");
               window.location.href="pantallazo.jsp";
                </script>
<%
  
}%>


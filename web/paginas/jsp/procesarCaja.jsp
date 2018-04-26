<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" import="modelo.*" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
if(session.getAttribute("usuario")!=null){
    modelo.Model model = (modelo.Model)session.getAttribute("model");
    if(model!=null){
        modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
        if(model.tienePermiso(usuario.getId_usuario(), 65)){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Caja</title>
</head>
<body>
<%
  int icu = Integer.parseInt(request.getParameter("icu"));
  int id = Integer.parseInt(request.getParameter("id"));
  java.sql.Timestamp fecha= new java.sql.Timestamp(new java.util.Date().getTime());
  Taquilla taquilla= new Taquilla();
  UsuarioCaja usuarioCaja = model.getCajaUsuario(icu);
  if(id==1){
        Taquilla taq = model.consultar_Taquilla(usuarioCaja.getFk_caja(),usuarioCaja.getFk_sede(),usuarioCaja.getFk_usuario());
        if(taq==null){
              taquilla.setEstado(1);
              taquilla.setFk_sede(usuarioCaja.getFk_sede());
              taquilla.setFk_caja(usuarioCaja.getFk_caja());
              taquilla.setFk_usuario(usuarioCaja.getFk_usuario());
              taquilla.setFecha_ini(fecha);
              model.adicionarTaquilla(taquilla);
              model.getCon().commit(); %>
             <script>alert("   La Caja se ha Abierto Correctamente  ");
                      window.location="gestionarCaja.jsp";
             </script> 
    <%  }else { %>
             <script>
                   alert("  Ya exiten Caja abiertas  ");
                   window.location="gestionarCaja.jsp";
             </script> 
    <%  }
  }else 
    if(id==2){
       taquilla = model.consultar_Taquilla(usuarioCaja.getFk_caja(),usuarioCaja.getFk_sede(),usuarioCaja.getFk_usuario());
       java.util.List<Tiquete> tiquete = model.consultarTiquetePreliquidados(1, taquilla.getId_taquilla(), usuario.getId_usuario());

       if(taquilla!=null){

           //if (tiquete==null){

           float valor_taquilla = model.consultarValorTaquilla(taquilla.getId_taquilla());
           taquilla.setValor_nota_debito(valor_taquilla);
           taquilla.setValor_taquilla(valor_taquilla);
           taquilla.setEstado(3);
           taquilla.setFecha_fin(fecha);
           model.actualizarTaquilla(taquilla,taquilla.getId_taquilla());
           model.getCon().commit();
           taquilla = model.consultarTaquillaById(taquilla.getId_taquilla());
           if(taquilla.getEstado()!=1){ %>
               <script>
                    alert("   La Caja se ha Cerrado Correctamente  ");
                    window.location="gestionarCaja.jsp";
               </script>
   <%     }
    
            //}else{
    %>
           <script>
                /*alert("  Existen pagos preliquidados activos  ");
                window.location="gestionarCaja.jsp";*/
          </script>
   <%
   // }

        }else{ %>
           <script>
                alert("  No Existen Cajas Abiertas  ");
                window.location="gestionarCaja.jsp";
          </script> 
   <%  }
   
    }
%>
</body>
</html>
<%
        }else{  %>
           <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="1"></jsp:param></jsp:forward>
<%        }
     }else{ %>
        <script>window.parent.document.location.href = "../../index.jsp";</script>
<%  }
 }else{ %>
     <script>window.parent.document.location.href = "../../index.jsp";</script>
<% }
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% } %>
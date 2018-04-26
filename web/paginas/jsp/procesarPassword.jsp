<%@page  import = "modelo.Model,modelo.Preasignacion" import = "java.util.*" import = "java.sql.*"   %>
<%@ page import="modelo.*"%>
<%@ page import="Cifrado.*"%>
<%@ page import="java.util.Date"%>

<%

 Model model = null;
     java.util.List<HIS_PAS_USUARIO> historial = null;
    //Calendar ahoraCal = Calendar.getInstance();
     String msg = "";
     int id = 0;
     int p=0;
try{
  model = (Model)session.getAttribute("model");
 if(model!=null){
    if((request.getParameter("anterior")!=null&&request.getParameter("nuevo")!=null&&request.getParameter("nuevo2")!=null) || (request.getParameter("nuevo")!=request.getParameter("nuevo2"))){
            modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
            //historial  = model.consultarHUsuario(usuario.getId_usuario());
            System.out.println(usuario.getId_usuario());
            historial = model.consultarHIS_PAS_USUARIO(usuario.getId_usuario());

        if(historial.size()>0){
            for(int i=0;i<historial.size();i++){
                HIS_PAS_USUARIO historial2 = historial.get(i);
                if(historial2.getPASSWORD1()==null){historial2.setPASSWORD1("0");}
                 if(historial2.getPASSWORD1().equals(KeyStore.Encriptar(request.getParameter("nuevo")))){
                          p=0;
                    }else{
                          p=1;
                  }
             }
        }

        if(usuario.getPassword().equals(KeyStore.Encriptar(request.getParameter("anterior")))){
                if(p==0){
                      %><script> alert("Por razones de seguridad le recomendamos no utilizar password anteriores"); </script><%
                }else{
                    String nv = request.getParameter("nuevo");
                    model.editarPassword(usuario.getId_usuario(),KeyStore.Encriptar(nv));
                    //java.sql.Date fecha=new java.sql.Date(new java.util.Date().getTime());
                    model.adicionarHIS_PAS_USUARIO(usuario.getId_usuario(),KeyStore.Encriptar(request.getParameter("anterior")));
                    Usuario usu = model.consultarUsuario(usuario.getId_usuario());
                    msg = "El password ha sido cambiado exitosamente.";
                    id=1;
                    model.getCon().commit();
                 }
         }else{
             msg = "El password anterior coincide con el actual.";
         }
      }else{
            msg = "Digite todos los password correctamente";
      }

 }
}catch(Exception exc){
         exc.printStackTrace();
         model.getCon().rollback();
}
 if(request.getParameter("tipo").equals("1")){
      if(id==0){ %>
            <script>  alert('<%=msg%>'); window.parent.parent.document.location.href = "../../editarpasswordobligatoria.jsp"; </script>
      <% }else{ %>
            <script>  alert('<%=msg%>'); window.parent.parent.document.location.href = "../../index.jsp"; </script>
      <% }
  }
     if(request.getParameter("tipo").equals("0")){
       if(id==0){ %>
            <script>  alert('<%=msg%>'); document.location.href = "editarPassword.jsp"; </script>
       <%}else{%>
            <script>  alert('<%=msg%>'); window.parent.parent.document.location.href = "../../index.jsp"; </script>
       <%}
}
%>



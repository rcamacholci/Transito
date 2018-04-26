formu<%-- 
    Document   : ActualizarIP
    Created on : 6/06/2012, 02:09:50 PM
    Author     : Sistemas
--%>

<%@page import="sun.font.Script"%>
<%@page import="oracle.sql.OPAQUE"%>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*"  import="modelo.Parametro"  errorPage="" %>
<%

try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("HabilitarIPUsuarios.jsp")){
                    modelo.Model model = (modelo.Model)session.getAttribute("model");

 try{

    
    String direccion_ip = request.getParameter("ip1");
    long id_usuario = Long.parseLong(request.getParameter("id_usuario"));

        java.util.List<UsuariosIP> ipUsuarios = null;
        //long IDUsuario = usuario.getId_usuario();
        ipUsuarios  = model.consultarIPporUsuario(id_usuario);
            if(request.getParameter("id_dir1")!=null&&!request.getParameter("id_dir1").isEmpty()){
            long id_ipusuario = Long.parseLong(request.getParameter("id_dir1"));
            direccion_ip = request.getParameter("ip1");
            if(direccion_ip!=""){
             model.ActualizarDireccionIP(direccion_ip, id_ipusuario); 
             model.getCon().commit();
            }else{
             model.EliminarDireccionIP(id_ipusuario);
             model.getCon().commit();
            }             
            if(request.getParameter("id_dir2")!=null&&!request.getParameter("id_dir2").isEmpty()){
            id_ipusuario = Long.parseLong(request.getParameter("id_dir2"));
            direccion_ip = request.getParameter("ip2");
            if(direccion_ip!=""){
             model.ActualizarDireccionIP(direccion_ip, id_ipusuario); 
             model.getCon().commit();
            }else{
             model.EliminarDireccionIP(id_ipusuario);
             model.getCon().commit();
            }            
            }
            if(request.getParameter("id_dir2")==null){
            direccion_ip = request.getParameter("ip2");    
            if(id_usuario>0&&!direccion_ip.isEmpty()){             
             model.AdicionarDireccionIP(id_usuario, direccion_ip);
             model.getCon().commit();
             }                
            }
                
            }else{
            for(int i = 0;i<2;i++){ 
                //UsuariosIP uip = ipUsuarios.get(i);
                    if(id_usuario>0){
                        int op = 1+i;
                        if(request.getParameter("ip"+op)!=null&&!request.getParameter("ip"+op).isEmpty()){
                            direccion_ip=request.getParameter("ip"+op);
                            model.AdicionarDireccionIP(id_usuario, direccion_ip);
                        }
                    model.getCon().commit();
                    }
    
            }          
            }

        %>
        <script> 
            alert("Actulizado Correctamente");
            window.document.location.href = "HabilitarIPUsuarios.jsp";
        
        </script><%
}catch(Exception exe){
    %><%=exe%><%
    }

%><%  }else{ %>
			   <jsp:forward page="no_access.jsp">
				 <jsp:param name="tipo" value="1"></jsp:param>
			   </jsp:forward>
	<%  }
	}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
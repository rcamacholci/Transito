<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
if(session.getAttribute("usuario")!=null){
    modelo.Model model = (modelo.Model)session.getAttribute("model");
    if(model!=null){
        modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
        if(model.tienePermiso(usuario.getId_usuario(), 17)||model.tienePermiso(usuario.getId_usuario(), 75)){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title></title>
</head>

<body>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%

Model modelo= (Model)session.getAttribute("model");
try{
    modelo.getCon().setAutoCommit(false);
    
    long nit= Long.parseLong(request.getParameter("documento"));
    long id_banco = Long.parseLong(request.getParameter("bancos"));
    int defecto= Integer.parseInt(request.getParameter("defecto")==null?"0":"1");
    
   
      Banco bancos = model.get_banco(id_banco);

            if (bancos!= null) {
                Entidad_Distribucion entidad_distribucion = new Entidad_Distribucion();
                Persona persona = model.consultarPersona(2,""+nit);
                entidad_distribucion.setFk_persona(persona.getId_persona());
                entidad_distribucion.setFk_banco(bancos.getId_banco());
                entidad_distribucion.setCuenta(request.getParameter("cuenta"));
                entidad_distribucion.setDefecto(defecto);
                model.adicionar_entidad_distribucion(entidad_distribucion);
                modelo.getCon().commit();
                %>


        
        <script language="javascript" type="text/javascript">
			alert("Entidad registrada con exito");
        </script>
        <%

            }
        %>
            
     
		    <script language="javascript" type="text/javascript">document.location.href = "entidades_de_distribucion.jsp";</script>
	
		   
    <%  
	}catch(Exception ecx){
		modelo.getCon().rollback();
		ecx.printStackTrace();        %>
		<script language="javascript" type="text/javascript">
			alert("Entidad no pudo ser ingresada");
			document.location.href = "entidades_de_distribucion.jsp";
		</script>		
<%  }
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
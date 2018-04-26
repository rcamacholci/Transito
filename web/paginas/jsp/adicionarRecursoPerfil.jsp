<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                         Model modelo= (Model)session.getAttribute("model");
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Recurso Perfil</title>
</head>
<body>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%

   modelo.getCon().setAutoCommit(false);
   try{
        java.sql.Date fechaSystem = new java.sql.Date(new java.util.Date().getTime());
        long id_perfil=Long.parseLong(request.getParameter("id_perfil"));
        String[] id_recurso=request.getParameterValues("id_recurso");
        java.util.List listaR = modelo.listarRecursosByPerfil((int)id_perfil);
        java.util.List Temp = modelo.listarRecursosByPerfil((int)id_perfil);

        for(int i=0;i<id_recurso.length;i++){
            System.out.println("pero que pasa "+id_recurso[i]);
            if(!Temp.contains(id_recurso[i])){
                System.out.println("agregar a tabla"+id_recurso[i]);
                Recurso_Perfil recurso_perfil= new Recurso_Perfil();
                recurso_perfil.setFk_perfil(id_perfil);
                recurso_perfil.setFk_recurso(Long.parseLong(id_recurso[i]));
                recurso_perfil.setFecha_inicio(fechaSystem);
                modelo.adicionarRecursoPerfil2(recurso_perfil);
            }else{
                Recurso_Perfil temp = modelo.consultarHistoRecurso(Long.parseLong(id_recurso[i]), id_perfil);
                if(temp.getFecha_final()==null){
                System.out.println("remover de Temp"+id_recurso[i]);
                Temp.remove(id_recurso[i]);
                }else{
                System.out.println("ELSE ---adicionar"+id_recurso[i]);
                Recurso_Perfil recurso_perfil= new Recurso_Perfil();
                recurso_perfil.setFk_perfil(id_perfil);
                recurso_perfil.setFk_recurso(Long.parseLong(id_recurso[i]));
                recurso_perfil.setFecha_inicio(fechaSystem);
                modelo.adicionarRecursoPerfil2(recurso_perfil);
                }
            }
        }

        for(int i=0;i<Temp.size();i++){
            System.out.println(id_perfil+"Actualizar"+Long.parseLong(Temp.get(i).toString()));
            modelo.actualizarPerfilRecurso2(id_perfil, Long.parseLong(Temp.get(i).toString()));
        }


        modelo.EliminarPerfilesRecurso(id_perfil);

        for(int i=0;i<id_recurso.length;i++){
            if(!listaR.contains(id_recurso[i])){
                Recurso_Perfil recurso_perfil= new Recurso_Perfil();
                recurso_perfil.setFk_perfil(id_perfil);
                recurso_perfil.setFk_recurso(Long.parseLong(id_recurso[i]));
                recurso_perfil.setFecha_inicio(fechaSystem);
                modelo.adicionarRecursoPerfil(recurso_perfil);
            }else{
                listaR.remove(id_recurso[i]);
            }
        }

        for(int i=0;i<listaR.size();i++){
            modelo.actualizarPerfilRecurso(id_perfil, Long.parseLong(listaR.get(i).toString()));
        }

        modelo.getCon().commit(); %>
        <script language="javascript" type="text/javascript">
            alert("El perfil ha sido actualizado..");
            window.location.href="recursos_perfil.jsp";
        </script>
<% }catch(Exception e){
        e.printStackTrace();
        modelo.getCon().rollback(); %>
        <script language="javascript" type="text/javascript">
            alert("El perfil no pudo ser actualizado");
            window.location.href="recursos_perfil.jsp";
        </script>
<% }
%>


</body>
</html>
<%  }else{ %>
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
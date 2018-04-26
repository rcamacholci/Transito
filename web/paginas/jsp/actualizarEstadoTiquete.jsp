<?xml version="1.0" encoding="UTF-8"?>
<%-- 
    Documento   : actualizarEstadoTiquete
    Creado      : 10-mar-2010, 10:22:11
    Autor       : Jorge Lopez
--%>
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/xml" pageEncoding="UTF-8" import="modelo.*,java.util.List,java.util.Iterator"%>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>

<root>
    <%
    long id_tiquete=0;
    int estado = 0;
    Model modelo = (Model)session.getAttribute("model");
    if(request.getParameter("id_tiquete")!=null){
        if(!request.getParameter("id_tiquete").isEmpty()){
            if(request.getParameter("cod_estado")!=null){
                if(!request.getParameter("cod_estado").isEmpty()){
                    if(modelo!=null){
                        id_tiquete = Long.parseLong(request.getParameter("id_tiquete"));
                        estado= Integer.parseInt(request.getParameter("cod_estado").toString());

                        if(estado!=0 && id_tiquete!=0){
                            try{
                                if(estado==1){//Para aplicar
                                    Tiquete tiquete = new Tiquete();
                                    tiquete.setEstado(estado);
                                    tiquete.setId_tiquete(id_tiquete);
                                    modelo.actualizarEstadoTiquete(tiquete);
                                    modelo.getCon().commit();
                                }else{
                                    if(estado == 2){ //Para anular
                                    }
                                }
                                %>
                                <result>si</result>
                                <%
                            }catch(Exception e){
                                %><result>no</result>
                                <error><%=e.toString()%></error>
                                <%
                            }
                        }else{
                            %><result>no</result>
                            <error>cod_estado=<%=estado%> : id_tiquete=<%=id_tiquete%></error>
                            <%
                        }                        
                    }else{
                        %>
                        <result>no</result>
                        <error>No hay conexion a DB</error>
                        <%
                    }

                }else{
                    %>
                        <result>no</result>
                        <error>cod_estado= [vacio]</error>
                    <%
                }
            }else{
               %>
                <result>no</result>
                <error>cod_estado=NULL</error>
                <%
            }
        }else{%>
            <result>no</result>
            <error>id_tiquete=[VACIO]</error>
            <%
        }
    }else{
       %>
       <result>no</result>
       <error>id_tiquete=NULL</error>
        <%
    }
%>


</root>
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
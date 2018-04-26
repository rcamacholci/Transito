<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html; charset=iso-8859-1" language="java"  
        import="java.sql.*" import="java.util.List" import="java.util.LinkedList" import="modelo.Model" import="modelo.Grupo" errorPage="" %>
<%
	/*try{
		if(session.getAttribute("model")!=null){
			if(((java.util.LinkedList)session.getAttribute("permisosU")).
				 contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
						   modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario"); */
				List	grupos	=	( request.getAttribute("grupos") != null )	?	(List) request.getAttribute("grupos")	:	new LinkedList() ;
                                 System.out.println("TAMAÑO DE LISTA EN VISTA" + grupos.size()) ;
%>

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title>****CIVITRANS****</title>
		<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/paginas/html/css/sorter.css" />
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/paginas/html/scripts/jquery-1.4.2.min.js"></script>
        <script language="javascript" type="text/javascript" src="<%=request.getContextPath()%>/paginas/html/scripts/jquery.tablesorter.min.js"></script>
       
        <script type="text/javascript" language="javascript">
                $(document).ready(loadPage) ;
                //window.onload= loadPage ;

                function loadPage(){
                    alert("1") ;
                  $("#table").tablesorter() ;
                }
        </script>
    </head>

    <body>
        <form action="" method="post" name="form" id="form">
            <div align="center">
                <table id="table" class="tablesorter" style="width:65%">
                    
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Grupo</th>        	
                        </tr>
                    </thead>
                    <tbody> 
                        <%
                            for ( int i=0; i<grupos.size(); i++ ){
                                Grupo grupo	=	( Grupo )	grupos.get(i) ;
                        %>
                                    <tr>
                                        <td> <%= grupo.getId_grupo() %> </td>
                                        <td> <%= grupo.getNombre() %> </td>
                                    </tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </form>
    </body>
</html>


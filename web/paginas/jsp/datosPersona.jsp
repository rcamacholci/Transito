<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
try{
        System.out.println("Persona 1") ;
      	if(session.getAttribute("model")!=null){
            System.out.println("Persona 2") ;
		//if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                 modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
                 Model modelo= (Model)session.getAttribute("model");

                 String documento = ( request.getParameter("documento")!=null ) ? request.getParameter("documento") : "" ;
                 String tipo = ( request.getParameter("tipo")!=null ) ? request.getParameter("tipo") : "" ;
                 long id_persona = 0 ;
                 Persona persona = null ;

                 if ( !documento.equals("") )
                 {
                       if ( session.getAttribute("id_persona")!=null )
                       {
                           session.removeAttribute("id_persona");
                       }
                       
                       persona      =   modelo.consultarPersona(Integer.parseInt(tipo), documento);

                       if ( persona != null ){
                            session.setAttribute("id_persona" , persona.getId_persona());
                       }
                 }

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" type="text/css" href='../html/css/tabs-style.css' />
<link rel="stylesheet" href="../html/css/jquery.ui.all.css"/>
<script src="../html/scripts/jquery-1.4.2.min.js"></script>
<script src="../html/scripts/jquery.ui.core.js"></script>
<script src="../html/scripts/jquery.ui.widget.js"></script>
<script type="text/javascript" language="javascript">

    $(document).ready(loadPage) ;

    function loadPage(){
        goPage('consultarPersonaRUNT.jsp?paso=1&tipo=<%= tipo %>&documento=<%= documento %>') ;
    }

    function goPage(page){
        window.frames[0].document.location.href = page ;
    }
</script>

<title>Vehiculo</title>
</head>
    <body>
             <div id="tabs" class="tabs" style="height:'100%'">
                <ul id="menu">
                    <li> <a href="javascript:goPage('consultarPersonaRUNT.jsp?paso=1&tipo=<%= tipo %>&documento=<%= documento %>')"  >Hoja de Vida</a>
                   <!-- <li> <a href="javascript:goPage('consultarCEVehiculo.jsp?id=0&placa=< placa %>')">Caracteristicas</a></li> -->
                        <ul id="submenu">
                            <li> <a href="javascript:goPage('consultarPersonaRUNT.jsp?paso=1&tipo=<%= tipo %>&documento=<%= documento %>')">General</a></li>
                            <li> <a href="javascript:goPage('consultarCarteraPersona.jsp?id=1')">Carteras</a></li>
                            <li> <a href="javascript:goPage('consultarVehiculosPersona.jsp?id=1')">Vehiculos</a></li>
                            <li> <a href="javascript:goPage('consultarComparendosPersona.jsp?id=1')">Comparendos</a></li>
                            <li> <a href="javascript:goPage('consultarFinanciacionesPersona.jsp')">Financiera</a></li>
                            <li> <a href="javascript:goPage('consultarPagosPersona.jsp')">Pagos</a></li>
                            <li> <a href="javascript:goPage('consultarSaldosFavor.jsp')">Saldos</a></li>

                        </ul>
                    </li>
                </ul>
                <iframe  frameborder="0" width="100%" height="500" id="contents"></iframe>
             </div>
    </body>
</html>
<% // }else{ %>

	<%  //}
	}else{ %>
		<script>
			window.parent.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){
    mexe.printStackTrace(); %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
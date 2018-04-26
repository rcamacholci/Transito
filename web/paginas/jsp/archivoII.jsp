<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
try{
	if(session.getAttribute("model")!=null){
		/*if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){*/
                 modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");

                 String placa = ( request.getParameter("placa")!=null ) ? request.getParameter("placa") : "" ;
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
		goPage('RegistrarSolicitudOficios.jsp');
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
                    <li> <a href="javascript:goPage('RegistrarSolicitudOficios.jsp')"  >Archivo II</a>
                   <!-- <li> <a href="javascript:goPage('consultarCEVehiculo.jsp?id=0&placa=< placa %>')">Caracteristicas</a></li> -->
                        <ul id="submenu">
                            <li> <a href="javascript:goPage('RegistrarSolicitudOficios.jsp')">Reg. Solicitud Oficios</a></li>
                            <li> <a href="javascript:goPage('RadicacionSolicitudesOficios.jsp')">Cons. Solicitud Oficios</a></li>
                            <li> <a href="javascript:goPage('CertificadoTradicionJudiciales.jsp')">Certificado a Judiciales</a></li>
                       </ul>
                    </li>
                </ul>
                </br>
                <iframe  frameborder="0" width="95%" height="800" id="contents"></iframe>
        </div>
    </body>
</html>
<% // }else{ %>
			 <!--  jsp:forward page="no_access.jsp">
				 jsp:param name="tipo" value="1">/jsp:param>
			   /jsp:forward> -->
	<% // }
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
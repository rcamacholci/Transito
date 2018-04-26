<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
    try {
        if (session.getAttribute("model") != null) {
            //if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
            modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");

            String comparendo = (request.getParameter("comparendo") != null) ? request.getParameter("comparendo") : "";
            
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
                goPage('consultarComparendo.jsp?id=0&comparendo=<%= comparendo%>') ;
            }

            function goPage(page){
                window.frames[0].document.location.href = page ;
                window.frames[0].style.height = $("#divFrame").css("width") ;
            }
        </script>

        <title>Vehiculo</title>
    </head>
    <body>
        <div id="tabs" class="tabs" style="margin: auto">
            <ul id="menu">
                <li> <a href="javascript:goPage('consultarComparendo.jsp?id=0&comparendo=<%= comparendo%>')">Datos Comparendo</a>
                    <ul id="submenu">
                        <li> <a href="javascript:goPage('consultarComparendo.jsp?id=0&comparendo=<%= comparendo%>')">General</a></li>
                        <li> <a href="javascript:goPage('consultarCarteraComparendo.jsp?id=0&comparendo=<%= comparendo%>')">Cartera</a></li>
                        <li> <a href="javascript:goPage('PrescripcionComparendo.jsp?id=0&comparendo=<%= comparendo%>')">Resoluciones</a></li>
                        <li> <a href="javascript:goPage('formularioDescuentoComparendo.jsp?id=0&comparendo=<%=comparendo%>')">Descuentos</a></li>
                        <!-- <li> <a href="javascript:goPage('consultarPropietariosVehiculo.jsp?id=0&comparendo=<%= comparendo%>')">Prescripcion</a></li> 
                        <li> <a href="javascript:goPage('comparendos/sancionarComparendo.jsp?id=0&numeroComparendo=<%= comparendo%>')">Sancionar</a></li> !-->
                        <li> <a href="javascript:goPage('comparendos/procesoContravencional.jsp?numeroComparendo=<%= comparendo%>')">Proceso</a></li>
                        <li> <a href="#">Imagen</a></li>
                        <li> <a href="#">Alertas</a></li>
                    </ul>
                </li>
            </ul>

            <iframe  frameborder="0" id="contents" width="100%" height="3000px" scrolling="no"  style="overflow:hidden;"></iframe>
        </div>
    </body>
</html>
<% // }else{ %>

<%  //}
} else {%>
<script>
    window.parent.parent.document.location.href = "../../index.jsp";
</script>  <%                    }
} catch (Exception mexe) {
    mexe.printStackTrace();%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
    }%>
<%-- 
    Document   : cargarPlanosFestivos
    Created on : 06-dic-2017, 16:06:40
    Author     : acadrasco
--%>

<%@page import="modelo.Sede"%>
<%@page import="modelo.Model"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                Model modelo = (Model) session.getAttribute("model");
                String fecha_hoy = new java.text.SimpleDateFormat("dd/MM/yyyy").format(new java.util.Date());
                Sede sede = (Sede) session.getAttribute("sede");


%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Planos Festivos</title>
        <style type="text/css">
            <!--
            .style1 {color: #006699}
            -->
        </style>
        <script src="../../estilos/bootstrap/js/bootstrap.min.js" type="text/javascript"></script>
        <link href="../../estilos/bootstrap/css/bootstrap.min.css" rel="stylesheet" type="text/css"/>        
        <link title=win2k-cold-1 media=all href="../html/css/calendar-green.css" rel="stylesheet" type="text/css"/>   
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script src="../../estilos/js/jquery-3.2.1.js" type="text/javascript"></script>        
        <script src="../html/scripts/motorAjax_1.js" type="text/javascript"></script>
        <script src="../html/scripts/motorAjax.js" type="text/javascript"></script>
        <script>
            $(function () {
                $("#formuploadajax").on("submit", function (e) {
                    //alert("hi");
                    e.preventDefault();
                    var f = $(this);
                    var formData = new FormData(document.getElementById("formuploadajax"));
                    formData.append("dato", "valor");
                    //formData.append(f.attr("name"), $(this)[0].files[0]);
                    $.ajax({
                        url: "../../procesarPlanoFestivos",
                        type: "post",
                        dataType: "html",
                        data: formData,
                        cache: false,
                        contentType: false,
                        processData: false
                    })
                            .done(function (res) {                                
                                $("#mensaje").html(res);
                                $("#archivo1").val('');
                            });
                });
            });
        </script>

    </head>
    <body>


        <form enctype="multipart/form-data" id="formuploadajax" method="post">
            <table align="center" border="0" width="50%">
                <tr>
                    <td  height="40px" align="center">
                        <h6 class="style1" align="center">Cargar Calendario Dias Festivos</h6>					</td>
                </tr>
                <tr>
                    <td height="40px" align="center">
                        <input  type="file" id="archivo1" name="archivo1"/>

                    </td>
                    <td height="40px" align="center">
                        <input type="submit" value="Subir archivo"/>
                    </td>
                </tr>               

            </table>	
        </form><br>
        <div id="mensaje"></div>





    </body>
</html>
<%  } else { %>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }
} else { %>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%
    }
} catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
    }%>
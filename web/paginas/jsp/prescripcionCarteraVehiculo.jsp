<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.io.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    try {
        if (session.getAttribute("usuario") != null) {
            modelo.Model model = (modelo.Model) session.getAttribute("model");
            if (model != null) {
                if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                    modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
                    if (model.tienePermiso(usuario.getId_usuario(), 7)) {

%>



<head>
    <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
    <title>Vehiculo</title>
    <link rel="stylesheet" type="text/css" href='../html/css/style.css' />
    <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
    <style type="text/css">
        .label {font-size: 11px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold ; width:110px}
        .text {font-size: 11px; color:#000000; text-align:center ; font-family:Arial; font-weight:bold ; width:120px; text-transform:uppercase}
        .date {font-size: 11px; color:#000000; text-align:center ; font-family:Arial; font-weight:bold; width:100px }
        .bdate {font-size: 10px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
        .select {font-size: 11px; color:#000000; text-align:left ; font-family:Arial; font-weight:bold; width:120px }
        .input { width:130px }
        .check { font-size: 11px; color:#000000; text-align:center ; font-family:Arial; font-weight:bold; }
    </style>

    <script type="text/javascript" language="javascript">

    </script>
</head> 
<body>
    <div align="center">
        <div align="center" style="width:810px">
            <form name="form1" method="post" action="consultarCarteraPrescripcion.jsp" target="frameCartera">
                <fieldset>
                    <legend></legend>
                    <table border="0" align="center" width="800px">
                        <tr style="border-bottom:#666666 double 2px">
                            <td width="9%" class="label" >PLACA:</td> 
                            <td width="91%" align="left"><label for="placa"></label>
                                <input name="placa" type="text" class="text" id="placa" maxlength="6"/>
                                <input name="enviar" type="submit" class="check" value="Buscar"/></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <iframe align="center" width="100%"
                                        frameborder="0" height="580"
                                        name="frameCartera" id="frameCartera">
                                </iframe>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </form>
        </div>
    </div>
</body>
<%} else {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="1"></jsp:param></jsp:forward>
<%        }
%>

<%  } else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }
        } else {%>
<script>window.parent.document.location.href = "../../index.jsp";</script>
<%  }
} else {%>
<script>window.parent.document.location.href = "../../index.jsp";</script>
<% }
} catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% }%>

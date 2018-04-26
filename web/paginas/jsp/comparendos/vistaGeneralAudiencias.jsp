<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
    try {
        if (session.getAttribute("model") != null) {
            System.out.println("LISTA " + ((java.util.LinkedList) session.getAttribute("permisosU")));
            System.out.println("PATH  " + request.getServletPath());
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                Model model = (Model) session.getAttribute("model");
                Parametro parametro = new Parametro();
                Sede sede = (Sede) session.getAttribute("sede");
                if (model != null) {
                    
                    String fechaA = ( request.getParameter("fechaAudiencia")!=null ) ? request.getParameter("fechaAudiencia") : null ;
                    
                    
                    System.out.println("fechaA" + fechaA);
                    SystemParams param = null;
                    List lDias = model.listadoParametros(param.DIA_DE_LA_SEMANA.getValue());
                    
                    java.sql.Date dFecha = null ;
                    
                    if ( fechaA == null ){
                        dFecha = new java.sql.Date(Calendar.getInstance().getTimeInMillis()) ;
                        fechaA = new java.text.SimpleDateFormat("dd/MM/YYYY").format(Calendar.getInstance().getTime()) ;
                    }else{
                        dFecha = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/YYYY").parse(fechaA).getTime()) ;
                    }
                    
                    
                    System.out.println("DFECHA  " + dFecha);
                    List<Audiencia> lAudiencias = model.listarAudienciasXFecha(dFecha, 1);
                    System.out.println("AUDIENCIAS  " + lAudiencias);
                    if ( lAudiencias != null ){
                        for ( Audiencia a : lAudiencias ){
                            System.out.println("AUDIENCIA N°  " +  a.getIdAudiencia());
                        }
                    }

%>
<html>
    <head>
        <title>Ver Arhivos Planos</title>
        <link rel="stylesheet" type="text/css" href='../../html/css/style.css' />
        <style type="text/css">
            .label {font-size: 11px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold ; width:110px}
            .text {font-size: 11px; color:#000000; text-align:center ; font-family:Arial; font-weight:bold ; width:120px; text-transform:uppercase}
            .date {font-size: 11px; color:#000000; text-align:center ; font-family:Arial; font-weight:bold; width:100px }
            .bdate {font-size: 10px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .select {font-size: 11px; color:#000000; text-align:left ; font-family:Arial; font-weight:bold; width:120px }
            .input { width:130px }
            .check { font-size: 11px; color:#000000; text-align:center ; font-family:Arial; font-weight:bold; }
        </style>
       
        <link title="win2k-cold-1" media="all" href="../../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../../html/scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
        <script src="../../html/scripts/generalFunctions.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar-setup.js" type="text/javascript"></script>
        
        <script type="text/javascript" language="Javascript">
            
            function consultarAudiencias(){
                
                $("#form").attr("action" , "vistaGeneralAudiencias.jsp") ;
                $("#form").submit() ;
                
            }
            
        </script>
        
    </head>
    <body>
        <form name="form" id="form" method="POST" action="">
            <table name="parentT" border="0" width="60%" align= "center">
                <tr>
                    <td colspan="3" class="title_" align="center"> PROGRAMACION DE AUDIENCIAS </td>
                </tr>
                <tr>
                    <td align="left" width="10%"><div style="font-weight: bold; font-size: 12px">Fecha:</div></td>
                    <td><div align="left"><input type="text" value="<%=fechaA%>" name="fechaAudiencia" id="fechaAudiencia" class="date"  style="background-image:url(../../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onKeyUp="mascara(this,'/',true)" maxlength="10" />
                            <span class="input">
                                <input name="bfechaAudiencia" type="button" id="bfechaAudiencia" class="bdate" value="&lt;&lt;"/>
                                <script type="text/javascript">
                                    Calendar.setup({
                                        inputField     :    "fechaAudiencia",      // id del campo de texto
                                        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                        button         :    "bfechaAudiencia"   // el id del botón que lanzará el calendario
                                    });
                                </script>
                            </span></div>
                    </td>
                    <td>
                        <input type="button" name="consultar" id="consultar" value="Consultar" class="button_" onclick="consultarAudiencias()"/>
                    </td>

                </tr>
            </table>
        </form>
    </body>
</html>
<%   }
} else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<% }
} else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%            }
} catch (Exception mexe) {
    System.out.println("EXCEPCION  " + mexe);%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="2"></jsp:param>
    <jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param>
</jsp:forward>
<%  }%>


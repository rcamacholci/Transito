<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>

<%
try{
    if(session.getAttribute("model")!=null){
        if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarAcuerdosdePago.jsp")){
            modelo.Model model = (modelo.Model)session.getAttribute("model");
%>
<html>
    <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>JSP Page</title>
    <style type="text/css">
    <!--
    .Estilo7 {
    color: #333333;
    font-size: 12px;
    font-weight: bold;
    }
    .Estilo8 {
    font-size: 14px;
    color: #333333;
    font-weight: bold;
    }
    .style2 {font-size: 12px; color: #333333; font-weight: bold; font-family: Tahoma; }
    .style3 {font-size: 11px}
    .style5 {font-size: 10px}
    .style8 {color: #333333; font-size: 11px; font-weight: bold; font-family: Tahoma; }
    .style9 {color: #FFFFFF}
    .style10 {color: #FFFFFF; font-size: 11px; font-weight: bold; }
    .Estilo11 {color: #DE2021}

    -->
    </style>
    </style>
    <script language="javascript" type="text/javascript">
    </script>
    </head>
        <body>
            <table width="100%" border="1" align="center" cellpadding="1" cellspacing="0" id="tabla1">
                <tr style="border:none; background:url(../html/images/inicio_3.png)">
                 <td colspan="11" align="center">TOTAL DE VEHICULOS POR SERVICIO</td>
                <tr>
                <tr style="border:none; background:url(../html/images/inicio_3.png)">
                 <%
                if(request.getParameter("servicio")!=null||request.getParameter("clase")!=null){
                long servicio = Integer.parseInt(request.getParameter("servicio"));
                long clase = Integer.parseInt(request.getParameter("clase"));

                HashMap parameters = new java.util.HashMap();
                parameters.put("CLASE", clase);
                parameters.put("SERVICIO", servicio);
              
                session.setAttribute("cantidad", parameters);
               //   System.out.println("TOTAL VEHICULOS: "+ parameters);
                java.util.List<Vehiculo> list = model.consultarVehiculosServicio(servicio,clase);
                 %>
                <tr bordercolor="#FFFFFF" class="style2" style="cursor:pointer">
                    <td align="center" colspan="10" style="font-size:11px"><span class="style5"><%=list.size() %></span></td>
                 </tr>
                <% }
                  // Vehiculo vehiculo = null;
                //  vehiculo = list.get(0);
                //   long total=0;
                //for(int i=0; i<list.size(); i++){
                //   System.out.println("TOTAL VEHICULOS: "+ list.size()); }
                // vehiculo total+=i;
                // vehiculo=list.get(i); %>
                </tr>

            </table>
        </body>
</html>
<% } else{ %>
    <jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
    </jsp:forward>
<%} }else{ %>
<script>
    wndow.parent.document.location.href = "../../index.jsp";
</script>

<% }
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% } %>

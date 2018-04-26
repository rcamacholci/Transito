<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=utf-8" language="java" 
         import="java.sql.*"
         import="java.util.List" 
         import="java.util.Calendar"
         import="java.util.LinkedList" 
         import="modelo.Model" 
         import="modelo.Comparendo" 
         import="procesos.procesoContravencional" 
         import="modelo.Infraccion" 
         import="modelo.Valor_Infraccion" 
         import="modelo.Agente"
         import="modelo.ProcesoComparendo"
         import="modelo.Persona"
         import="modelo.Cartera"
         import="utility.Proceso"
         import="utility.ConfiguracionProceso"
         import="java.sql.Timestamp"
         errorPage="" %>

<%
    try {
        if (session.getAttribute("model") != null) {
            if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                Model model = (Model) session.getAttribute("model");
                String msg = (request.getParameter("msg") != null) ? request.getParameter("msg") : "";

                long idPersona = (request.getParameter("id_persona") != null) ? Long.parseLong(request.getParameter("id_persona")) : 0;
                Persona persona = model.consultarPersona(idPersona);

                List<Comparendo> lComparendos = model.listarComparendosEnSancionXPersona(persona.getId_persona());
                int F_START = 0;
                int L_SIZE = lComparendos.size();
%> 

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Civitrans</title>
        <link rel="stylesheet" type="text/css" href='../../html/css/style.css' />
        <style type="text/css">
            .dataTable{
                border: outset 1px #000 ;
            }
        </style>
        <link title="win2k-cold-1" media="all" href="../../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../../html/scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
        <script src="../../html/scripts/generalFunctions.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script type="text/javascript" language="javascript">
			
            $(document).ready(loadedPage) ;            
                        
            function loadedPage(){
                var msg = "<%= msg%>" ;
                if ( Trim(msg).length>0){
                    alert(msg) ;
                }
            }
        </script>
        <style type="text/css">
            .bdate {font-size: 10px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .input {width:130px }
        </style>
    </head>
    &nbsp;&nbsp;&nbsp;&nbsp;
    <body bgcolor="#FFFFFF">
        <form id="form" name="form" method="post" >
            <table width="75%" align="center">
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td><div align="center">
                            <table width="100%" class="dataTable">
                                <tr>
                                    <td colspan="2"><div align="center" class="title_">Cobro Preventivo</div></td>
                                </tr>
                                <tr>
                                    <td><div align="left" style="font-size:12px;font-weight: bold">Resolucion:</div></td>
                                    <td><div align="left">
                                            <input type="text" name="resolucion" id="resolucion" style="width:50%" title="Resolucion" required="true" />
                                        </div></td>
                                </tr>
                                <!--  <tr>
                                      <td width="15%"><div align="left"  style="font-weight: bold">Valor:</div></td>
                                      <td width="85%"><div align="left">
                                              <label for="textfield"></label>
                                              <input type="text" name="valor" id="valor" onkeypress="return validNumber(event);"  />
                                          </div>
                                      </td>
                                  </tr> !-->
                                <tr> 
                                    <td><div align="left" style="font-size:12px;font-weight: bold">Observacion</div></td>
                                    <td><div align="left">
                                            <input type="text" name="observacion" id="observacion" style="width:90%" />
                                        </div></td>
                                </tr>
                            </table>
                        </div>  
                    </td>
                </tr> 
                <tr>
                    <td>&nbsp;</td>
                </tr>
                <tr>
                    <td><div align="center">
                            <table width="100%" class="dataTable">
                                <thead>
                                    <tr class="title_">
                                        <th>&nbsp;</th>
                                        <th>N&uacute;mero</th>
                                        <th>Fecha</th>
                                        <th>Infracci&oacute;n</th>
                                        <th>Valor</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        for (int i = F_START; i < L_SIZE; i++) {
                                            Comparendo comp = lComparendos.get(i);
                                            Infraccion infra = model.consultarInfraccion(comp.getFk_infraccion());
                                            Valor_Infraccion valorI = model.consultarValorInfraccion(new java.sql.Date(comp.getFecha().getTime()), infra.getId_infraccion());
                                            Cartera car = model.consultarCartera(comp.getFk_cartera());

                                    %>
                                    <tr>
                                        <td align="center">
                                            <input type="checkbox"
                                                   name="chkComparendos" 											 											 id="<%= comp.getId_comparendo()%>"
                                                   />
                                        </td>
                                        <td align="center" style="font-size: 12px " >
                                            <%= comp.getNumero()%>
                                        </td>
                                        <td align="center" style="font-size: 12px" >
                                            <%=  new java.text.SimpleDateFormat("dd-MM-yyyy").format(comp.getFecha())%>
                                        </td>
                                        <td align="center" style="font-size: 12px" >
                                            <%= infra.getNumero()%>
                                        </td>
                                        <td align="center" style="font-size: 12px">
                                            <%= valorI.getValor()%>
                                        </td>

                                    </tr>
                                    <%
                                        }
                                    %>
                                </tbody>
                            </table>
                        </div>  
                    </td>
                </tr>
                <tr>
                    <td>
                        <div align="center">
                            <input type="submit" 
                                   name="enviar" value="enviar"/>
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </body>
</html>

<%
} else {%>
<jsp:forward page="../../no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<%  }
} else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%                                    }
} catch (Exception mexe) {
    System.out.println("ERROR   " + mexe);%>
<jsp:forward page="../no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
    }%>	
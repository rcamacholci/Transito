<%-- 
    Document   : detalleProcesoContravencional
    Created on : 27-ene-2012, 12:40:16
    Author     : Administrador
--%>

<%@page import="controladores.comparendos.proceso.ProcesoContravencionalAction"%>
<%@page import="modelo.ProcesoComparendo" import="modelo.Comparendo" import="java.util.*"%>
<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%
    long idPersona = (request.getParameter("id_persona") != null) ? Long.parseLong(request.getParameter("id_persona")) : 0;
    System.out.println("DETALLE PROC");

%>


<% try {%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href='../../html/css/style.css' />
        <title>JSP Page</title>
        <script type="text/javascript">
            
            function print(){
                ancho = 789;
                alto = 250;
                barra = 0;
                izquierda = (document.width) ? (document.width-ancho)/2 : 100;
                arriba = (document.height) ? (document.height-alto)/2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + 			ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                var dir = "comparendos/proceso/sancion.jasper";
                var nombre = "sancion";
                url = "../verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
                window.open(url, 'popUp', opciones);
            }
            
            function verM(){
                var idp = <%= idPersona%> ;
            }
            
            function goToProcess(process,link,nextStep,idConfig){
                //alert(link+"?id=1&idp="+process+"&ns="+nextStep+"&cfg=" + idConfig);
                window.parent.document.location.href = link+"?id=1&idp="+process+"&ns="+nextStep+"&cfg=" + idConfig + "&id_persona=" + <%= idPersona%>;
            }
        </script>
    </head>
    <body >
        <div>
            <table style="width:230px" cellspacing="3" cellpadding="5" align="center">
                <% modelo.Model model = (modelo.Model) session.getAttribute("model");
                    if (model != null) {

                        ProcesoComparendo procesoComparendo = null;
                        if (request.getParameter("idProcesoComparendo") != null) {
                            int idProcesoComparendo = Integer.parseInt(request.getParameter("idProcesoComparendo"));
                            procesoComparendo = model.consultarProcesoComparendo(idProcesoComparendo);
                            if (procesoComparendo != null) {
                                Comparendo comparendo = model.consultarComparendoById(procesoComparendo.getFkComparendo());
                                if (procesoComparendo.getEstado() == 1) {
                                    controladores.comparendos.proceso.ProcesoContravencionalAction action = new controladores.comparendos.proceso.ProcesoContravencionalAction();
                                    utility.Proceso currentP = model.consultarProceso(procesoComparendo.getFkProceso());

                                    java.util.List<utility.ConfiguracionProceso> lista = action.getPossibleNextProcess(currentP, comparendo, model);
                                    //java.util.List<utility.ConfiguracionProceso> lista = model.listarProcesos(procesoComparendo.getFkProceso());
                                    if (lista != null && lista.size() > 0) {
                                        for (utility.ConfiguracionProceso cp : lista) {
                                            utility.Proceso proceso = model.consultarProceso(cp.getFkProximo());
                                            if (proceso != null) {
                %>

                <tr>
                    <td class="botonItemMenu"
                        onmouseover="this.style.color='#CC0000';this.style.cursor='pointer'" 
                        onmouseout="this.style.color='#000';this.style.cursor='default'"
                        onclick="goToProcess('<%=procesoComparendo.getIdProcesoComparendo()%>','<%=proceso.getEnlace()%>','<%=proceso.getIdProceso()%>','<%= cp.getIdConfiguracionProceso()%>')">
                        <%=proceso.getNombre()%>
                    </td>
                </tr>
                <%
                        }
                    }
                } else {%>
                <tr>
                    <td>
                        No hay procesos pendientes!!
                    </td>
                </tr>
                <%  }
                    } /*else {
                    java.util.HashMap parameters = new java.util.HashMap();
                    modelo.Comparendo comparendo = model.consultarComparendoById(procesoComparendo.getFkComparendo());
                    modelo.ConfProcesoReporte confProc = model.consultarConfProcesoReporteXFk(procesoComparendo.getFkProceso());
                    parameters.put("NUM_COMPARENDO", comparendo.getNumero());
                    parameters.put("TIPO_RES", procesoComparendo.getFkProceso());
                    session.setAttribute(confProc.getNombre().toLowerCase(), parameters);    */%>



                <%
                                //}
                            }
                        }
                    }
                %>        
            </table>
        </div>    
    </body>
</html>


<% } catch (Exception e) {
        e.printStackTrace();
    }%>
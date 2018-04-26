<%@page import="utility.Proceso"%>
<%@page import="java.util.Calendar"%>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=utf-8" language="java" 
         import="java.sql.*"
         import="java.util.List" 
         import="java.util.LinkedList" 
         import="modelo.Model" 
         import="modelo.Comparendo" 
         import="procesos.procesoContravencional" 
         import="modelo.Infraccion"
         import="modelo.Agente"
         import="modelo.Persona"
         import="modelo.Parametro"
         import="modelo.Usuario"
         import="modelo.ProcesoComparendo"
         import="java.sql.Timestamp"
         import="java.sql.Date"
         errorPage="" %> 

<%
    Model model = (Model) session.getAttribute("model");
    Usuario usuario = (Usuario) session.getAttribute("usuario");


    if (model != null) {

        String msg = (request.getParameter("msg") != null) ? request.getParameter("msg") : "";
        //String numeroComparendo = request.getParameter("numeroComparendo");


        if (request.getParameter("idC") != null) {

            long idComparendo = (request.getParameter("idC") != null) ? Long.parseLong(request.getParameter("idC")) : 0;
            //Comparendo comparendo = model.consultar_Comparendo(numeroComparendo);
            Comparendo comparendo = model.consultarComparendoById(idComparendo);

            if (comparendo != null) {

                boolean appCaducidad = false;
                boolean appSancion = false;
                boolean appPrescripcion = false;

                /*int dias = model.consultarDiasHabiles(new java.sql.Date(comparendo.getFecha().getTime()));
                if (dias >= 30) {
                if (comparendo.getEstado() == 1) {*/
                Persona persona = model.consultarPersona(comparendo.getFk_persona());
                Infraccion infraccion = model.consultarInfraccion(comparendo.getFk_infraccion());
                Agente agente = model.consultar_Agente_PorId(comparendo.getFk_agente());
                modelo.Valor_Infraccion valorI = model.consultarValorInfraccion(new java.sql.Date(comparendo.getFecha().getTime()), infraccion.getId_infraccion());
                modelo.Cartera cartera = model.consultarCartera(comparendo.getFk_cartera());
                Parametro parametro;

                procesos.procesoContravencional procesoC = new procesos.procesoContravencional();

                /* Verificacion de Imposicion de Sancion */
                //int dias = model.consultarDiasHabiles(new java.sql.Date(comparendo.getFecha().getTime()));
                int dias = utility.Util.daysAfter(Calendar.getInstance().getTimeInMillis(), comparendo.getFecha().getTime());
                //System.out.println("DIAS ");


                java.sql.Date fecha = new java.sql.Date(Calendar.getInstance().getTimeInMillis());

                if (comparendo.getEstado() != 5) {

                    // AUDIENCIA.
                    /*if (dias > 11 && dias < 30) {
                    
                    long iduP = model.obtenerUltimoProcesoComparendo(comparendo.getId_comparendo(), 1);
                    ProcesoComparendo ultimoP = model.consultarProcesoComparendo(iduP);
                    
                    int update = model.modificarProcesoComparendo(ultimoP.getIdProcesoComparendo(),
                    new Date(Calendar.getInstance().getTimeInMillis()),
                    2, ultimoP.getValor(), ultimoP.getTipo(), ultimoP.getObservacion());
                    
                    //procesoC.realizarAperturaAudiencia(model, usuario, comparendo, resolucion, fecha, valor, observacion, fkProceso);
                    
                    }*/


                    java.sql.Date fechaComparendo = new java.sql.Date(comparendo.getFecha().getTime());
                    Calendar fechaAux = Calendar.getInstance();

                    // Se comprueban los 30 dias para sancion.
                    fechaAux.set(fechaAux.DATE, fechaAux.get(Calendar.DATE) - 30);
                    //System.out.println("FECHA -30 DIAS  "  + new java.text.SimpleDateFormat("dd 'de' MMMMM 'de' YYYY").format(fechaAux.getTime()));
                    if (fechaComparendo.getTime() <= fechaAux.getTimeInMillis()) { // SANCION
                        appSancion = true;
                    }


                    // Se comprueban los 6 meses para caducidad.
                    fechaAux = Calendar.getInstance();
                    fechaAux.set(fechaAux.MONTH, fechaAux.get(Calendar.MONTH) - 6);
                    //System.out.println("FECHA -6 MESES  "  + new java.text.SimpleDateFormat("dd 'de' MMMMM 'de' YYYY").format(fechaAux.getTime()));
                    if (fechaComparendo.getTime() <= fechaAux.getTimeInMillis()) { // SANCION
                        appCaducidad = true;
                    }

                    // Se comprueban los 3 años para prescripcion.
                    fechaAux = Calendar.getInstance();
                    fechaAux.set(fechaAux.YEAR, fechaAux.get(Calendar.YEAR) - 3);
                    //System.out.println("FECHA -3 AÑOS  "  + new java.text.SimpleDateFormat("dd 'de' MMMMM 'de' YYYY").format(fechaAux.getTime()));
                    if (fechaComparendo.getTime() <= fechaAux.getTimeInMillis()) { // SANCION
                        appPrescripcion = true;
                    }

                }

                /* long iduP = model.obtenerUltimoProcesoComparendo(comparendo.getId_comparendo(), 1);
                modelo.Sancion sancion = model.consultarSancionXComparendo(comparendo.getId_comparendo(), 1);
                
                if (sancion == null) {
                
                ProcesoComparendo ultimoP = model.consultarProcesoComparendo(iduP);
                
                /*  int update = model.modificarProcesoComparendo(ultimoP.getIdProcesoComparendo(),
                new Date(Calendar.getInstance().getTimeInMillis()),
                2, ultimoP.getValor(), ultimoP.getTipo(), ultimoP.getObservacion()); 
                
                
                if (ultimoP.getTipo() == 1) {
                //procesoC.adicionarSimitResolucionXSancion(model, usuario, comparendo, "", fecha, valorI.getValor(), "SANCION AUTOMATICA", 6);
                procesoC.adicionarSimitResolucionXSancion(model, usuario, comparendo, "", fecha, (float) cartera.getSaldo(), "SANCION AUTOMATICA", 5);
                }
                } 
                }*/


                long currentP = 0;
                List<ProcesoComparendo> list = model.listarProcesosXComparendo(comparendo.getId_comparendo());
                if (list == null) {
                    list = new LinkedList<ProcesoComparendo>();
                }


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <title>Civitrans</title>
        <link rel="stylesheet" type="text/css" href='../../html/css/style.css' />
        <link rel="stylesheet" type="text/css" href='../../html/css/tabs-style.css' />
        <script src="../../html/scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
        <script src="../../html/scripts/generalFunctions.js" type="text/javascript"></script>
        <script type="text/javascript" language="javascript">
            
            $(document).ready(loadedPage) ;            
                        
            function loadedPage(){
                var msg = "<%= msg%>" ;
                if ( Trim(msg).length>0){
                    alert( msg) ;
                }
            }
            
            function goToDetail(param){
                window.frames[0].location.href="detalleProcesoContravencional.jsp?idProcesoComparendo=" +  param + "&id_persona=" + <%=persona.getId_persona()%> ;
            }
            
            
            function verReporte( idComparendo , idProceso ){
                document.forms[0].action = "<%= request.getContextPath()%>/paginas/jsp/comparendos/verReporteProceso.jsp?idc=" + idComparendo + "&idp=" + idProceso;
                document.forms[0].target = "_blank" ;
                document.forms[0].submit() ;
            }
            
            function getNextProcesses(){
                var currentProcess = $("#current").val() ;
                goToDetail(currentProcess) ;
            }
            
        </script>
        <style type="text/css">
            .dataTable{
                border: outset 1px #000 ;
            }
        </style>
    </head>
    <body onload="getNextProcesses()">
        <form name="form" id="form" method="post" action="procesarSancionComparendo.jsp">
            <div align="center">
                
                <table width="85%" id="content">
                    <tr>
                        <td width="100%" valign="top">
                            <div> 
                                <table width="100%" class="dataTable">
                                    <tr>
                                        <td colspan="4"><div align="center" class="title_">Datos Comparendo</div></td>
                                    </tr>
                                    <tr>
                                        <td width="13%"><div align="left" style="font-weight: bold">Número: </div></td>
                                        <td width="17%">
                                            <div align="left" style="font-size: 11px">
                                                <%= comparendo.getNumero()%>
                                            </div>
                                        </td>
                                        <td width="10%"><div align="left" style="font-weight:bold">Fecha:</div></td>
                                        <td width="60%">
                                            <div align="left" style="font-size: 11px">
                                                <%= comparendo.getFecha()%>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="13"><div align="left" style="font-weight: bold">Infracción: </div></td>
                                        <td width="17%">
                                            <div align="left" style="font-size: 11px">
                                                <%= infraccion.getNumero()%>
                                            </div>
                                        </td>
                                        <td width="10%"><div align="left" style="font-weight: bold">Estado</div></td>
                                        <td width="60%">
                                            <div align="left" style="font-size: 11px">

                                                <%
                                                    parametro = model.consultarParametro(comparendo.getEstado(), 67);
                                                    if (parametro != null) {
                                                        out.print(parametro.getNombre());
                                                    } else {
                                                        out.print("");
                                                    }
                                                %>
                                            </div>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div><table id="procesos" width="100%" class="dataTable" border="1" cellpadding="0" cellspacing="0">
                                    <thead>
                                        <tr>    
                                            <th style="font-weight:bold">Paso</th>
                                            <th style="font-weight:bold">Desde</th>
                                            <th style="font-weight:bold">Hasta</th>
                                            <th style="font-weight:bold">Observacion</th>
                                            <th style="font-weight:bold">Funcionario</th>
                                            <th style="font-weight:bold">&nbsp;</th>
                                        </tr>
                                    </thead>
                                    <tbody >
                                        <% for (int i = 0; i < list.size(); i++) {
                                                ProcesoComparendo procesoComparendo = list.get(i);
                                                Proceso proceso = model.consultarProceso(procesoComparendo.getFkProceso());
                                        %>
                                        <tr id="<%= procesoComparendo.getIdProcesoComparendo()%>"
                                            onmouseover="this.style.backgroundColor='#CCC';this.style.cursor='pointer'" 
                                            onmouseout="this.style.backgroundColor='#FFF';this.style.cursor='default'"
                                            <% if (procesoComparendo.getEstado() == 1) {%>
                                            <% }%>
                                            >
                                            <td align="center" onclick="goToDetail('<%= procesoComparendo.getIdProcesoComparendo()%>')"><%= proceso.getNombre()%></td>
                                            <td align="center" onclick="goToDetail('<%= procesoComparendo.getIdProcesoComparendo()%>')" ><%= (procesoComparendo.getFechaInicial() != null) ? procesoComparendo.getFechaInicial() : ""%></td>
                                            <td align="center" onclick="goToDetail('<%= procesoComparendo.getIdProcesoComparendo()%>')"><%= (procesoComparendo.getFechaFinal() != null) ? procesoComparendo.getFechaFinal() : ""%></td>
                                            <td align="left"   onclick="goToDetail('<%= procesoComparendo.getIdProcesoComparendo()%>')"><%= (procesoComparendo.getObservacion() != null) ? procesoComparendo.getObservacion() : ""%></td>
                                            <td align="center" onclick="goToDetail('<%= procesoComparendo.getIdProcesoComparendo()%>')"><%= (usuario.getNombre() != null) ? usuario.getNombre() : ""%></td>
                                            <% if (proceso.getInforme() != null && !proceso.getInforme().equals("")) {%>
                                            <td align="center">
                                                <img title="Imprimir" width="22px" height="22px" alt="ver reporte" src="../../html/images/reporte.png" onclick="javascript:verReporte('<%= comparendo.getId_comparendo()%>' , '<%=procesoComparendo.getIdProcesoComparendo()%>')"
                                        </td>
                                        <% } else {%>
                                        <td align="center">&nbsp;</td>
                                        <% }%>

                                    </tr>
                                    <%
                                            if (i == list.size() - 1) {
                                                currentP = procesoComparendo.getIdProcesoComparendo();
                                            }

                                        }%>
                                </tbody>
                            </table>
                        </div>
                    </td>
                    <td>
                        <table width="100%" class="dataTable" cellpadding="0" cellspacing="0" border="0">
                            <tr>
                                <td>
                                    <div align="center" class="title_">Procesos Siguientes</div>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <div style="width:260px;height:300px">
                                        <iframe name="detalle" id="detalle" width="100%" height="100%px" frameborder="0"></iframe>
                                    </div>
                                </td>
                            </tr>
                        </table>       
                    </td>
                </tr>                    
            </table>
        </div>

        <input type="hidden" name="idComparendo" id="idComparendo" value="<%= comparendo.getId_comparendo()%>" />
        <input type="hidden" name="current" id="current" value="<%= currentP%>" />
    </form>	
</body>
</html>
<%
            }
        }
        /*    }
        }*/
    }%>

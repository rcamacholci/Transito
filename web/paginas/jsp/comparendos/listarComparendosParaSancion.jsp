<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=utf-8" language="java"
         import="java.sql.*" 
         import="java.util.List" 
         import="java.util.LinkedList" 
         import="modelo.Model" 
         import="modelo.Comparendo" 
         import="modelo.Persona" 
         import="modelo.Infraccion" 
         import="modelo.Cartera" 
         import="procesos.procesoContravencional" errorPage="" %>

<%
    Model model = (Model) session.getAttribute("model");


    if (model != null) {
        String msg = (request.getParameter("msg") != null) ? request.getParameter("msg") : "";
        List<Comparendo> listComparendos = model.listarComparendosParaSancion(1);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>    
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <link title="win2k-cold-1" media="all" href="../../html/css/style.css" type="text/css" rel="stylesheet"/>
        <link title="win2k-cold-1" media="all" href="../../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../../html/scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
        <script src="../../html/scripts/generalFunctions.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <title>Civitrans</title>
        <script type="text/javascript" language="javascript">
            
            $(document).ready(loadedPage) ;                    
            function loadedPage(){
                var msg = "<%= msg%>" ;
                if ( Trim(msg).length>0){
                    alert(msg) ;
                }
            }
            
            function validForm(){
                var arrChecked = $(":checked") ;
                if ( arrChecked.length == 0){
                    alert( "Debe seleccionar por lo menos un comparendo a sancionar" ) ;
                    return false ;
                }
                return true ;
            }
            
        </script>
    </head>
    <body>
        <form name="form" id="form" action="procesarSancionListadoComparendos.jsp" method="post" onsubmit=" return validForm()">
            <div align="center">  
                <div style="width: 95%;" align="left">
                    <table width="99%" border="1">
                        <tr>
                            <td class="title_" colspan="2">SANCIONAR COMPARENDOS</td>
                        </tr>
                        <!-- <tr>
                             <td style="font-weight: bold">Resolucion: </td>
                             <td>
                                 <input type="text" name="resolucion" id="resolucion"/>
                             </td>
                         </tr>
                         <tr>
                             <td style="font-weight: bold">Fecha </td>
                             <td>
                                 <input type="text" name="fechaResolucion" id="fechaResolucion" class="date"  style="background-image:url(../../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onKeyUp="mascara(this,'/',true)" maxlength="10" />
                                 <span class="input">
                                     <input name="bfechaResolucion" type="button" id="bfechaResolucion" class="bdate" value="&lt;&lt;"/>
                                     <script type="text/javascript">
                                         Calendar.setup({
                                             inputField     :    "fechaResolucion",      // id del campo de texto
                                             ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                             button         :    "bfechaResolucion"   // el id del botón que lanzará el calendario
                                         });
                                     </script>
                                 </span>
                             </td>
                         </tr>!-->
                        <tr>
                            <td style="font-weight: bold" width="15%">Valor: </td>
                            <td>
                                <input type="text" name="valor" id="valor" style="width:35%"/>
                            </td>
                        </tr>
                        <tr>
                            <td style="font-weight: bold">Observacion: </td>
                            <td>
                                <input type="text" name="observacion" id="observacion" style="width:85%"/>
                            </td>
                        </tr>
                    </table>
                    <table id="tableHeaderComparendos" width="99%" border="1">
                        <thead>
                            <tr class="title_">
                                <th align="center">&nbsp;</th>
                                <th align="center">Numero</th>
                                <th align="center">Infraccion</th>
                                <th align="center">Nombre</th>
                                <th align="center">Valor</th>
                            </tr>
                        </thead>

                        <tbody   >
                            <%
                                for (Comparendo comparendo : listComparendos) {
                                    Persona persona = model.consultarPersona(comparendo.getFk_persona());
                                    Infraccion infraccion = model.consultarInfraccion(comparendo.getFk_infraccion());
                                    Cartera cartera = model.consultarCartera(comparendo.getFk_cartera());

                                    //modelo.SolicitudAudiencia s = model.consultarSolicitudAudienciaXComparendo(comparendo.getId_comparendo(), 1);

                                    if (comparendo.getEstado() == 1) {

                            %>
                            <tr>
                                <td align="center"><input type="checkbox" name="chkIdComparendo" value="<%= comparendo.getId_comparendo()%>"/></td>    
                                <td align="center"><%= comparendo.getNumero()%></td>
                                <td align="center"><%= infraccion.getNumero()%></td>
                                <td><%= persona.getNombreCompleto()%></td>
                                <td align="right"><%= cartera.getValor()%></td>
                            </tr>
                            <%
                                    }
                                }
                            %>
                        </tbody>
                    </table>
                </div>
            </div>
            <input type="submit" value="enviar" class="boton_"/>
        </form>	
    </body>
</html>
<%}%>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=utf-8" language="java" 
         import="java.sql.*"
         import="java.util.List" 
         import="java.util.Calendar"
         import="java.util.LinkedList" 
         import="modelo.Model" 
         import="modelo.Comparendo" 
         import="procesos.procesoContravencional" 
         import="modelo.Infraccion" 
         import="modelo.Agente"
         import="modelo.ProcesoComparendo"
         import="modelo.Persona"
         import="modelo.Cartera"
         import="utility.Proceso"
         import="utility.ConfiguracionProceso"
         import="java.sql.Timestamp"
         errorPage="" %>

<%
    Model model = (Model) session.getAttribute("model");

    if (model != null) {
        String msg = (request.getParameter("msg") != null) ? request.getParameter("msg") : "";
        if (request.getParameter("idp") != null && request.getParameter("ns") != null) {
            if (request.getParameter("cfg") != null && request.getParameter("cfg") != null) {
                System.out.println("ID_CONFIGURACION  "  +  request.getParameter("cfg"));
                //ConfiguracionProceso configuracionProceso = model.consultarConfiguracionProceso(Long.parseLong(request.getParameter("cfg"))) ;
                long idProcesoComparendo = Long.valueOf(request.getParameter("idp"));
                long nextStep = Long.valueOf(request.getParameter("ns"));
                ProcesoComparendo procesoComparendo = model.consultarProcesoComparendo(idProcesoComparendo);

                if (procesoComparendo != null) {
                    long idProceso = procesoComparendo.getFkProceso();

                    //ConfiguracionProceso config = model.;
                    long idComparendo = procesoComparendo.getFkComparendo();
                    Comparendo comparendo = model.consultarComparendoById(idComparendo);
                    
                    java.sql.Date fchCmp = new java.sql.Date(comparendo.getFecha().getTime()) ;
                    
                    Calendar currentDate = Calendar.getInstance() ;
                    currentDate.set(currentDate.YEAR, (currentDate.get(Calendar.YEAR) - 3));
                    
                    if (comparendo != null) {
                      

                        Persona persona = model.consultarPersona(comparendo.getFk_persona());
                        Infraccion infraccion = model.consultarInfraccion(comparendo.getFk_infraccion());
                        Agente agente = model.consultar_Agente_PorId(comparendo.getFk_agente());
                        Cartera cartera = model.consultarCartera(comparendo.getFk_cartera());


%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

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
            
            function validNumber(event)
            {
                //Validar la existencia del objeto event
                    
                //Extraer el codigo del caracter de uno de los diferentes grupos de codigos*/
                var charCode = (event.charCode) ? event.charCode : ((event.keyCode) ? event.keyCode : ((event.which) ? event.which : 0));

                //Predefinir como valido
                var respuesta = true;

                //Validar si el codigo corresponde a los NO aceptables
                if (charCode > 31 && (charCode < 48 || charCode > 57))
                {
                    //Asignar FALSE a la respuesta si es de los NO aceptables
                    respuesta = false;
                }

                //Regresar la respuesta
                return respuesta;
                    
            }
            
            function validForm(){
                var rqs = $("[required=true]");
                if( rqs.length > 0){
                    for( var i=0 ; i<rqs.length; i++){
                        var value = rqs[i].value ;
                        if ( value=="" ){
                            if ( rqs[i].title ){
                                alert("El campo " + rqs[i].title + " no puede estar vacio") ;
                            }else{
                                alert("El campo " + rqs[i].name + " no puede estar vacio") ;
                            }
                            rqs[i].focus() ;
                            return false ;
                        }
                    }
                    return true ;
                }
            }
            
            
        </script>
        <style type="text/css">
            .bdate {font-size: 10px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .input {width:130px }
        </style>
    </head>
    <body>
        <form name="form" id="form" method="post" action="procesarPreescripcionComparendo.jsp" onsubmit="return validForm();">
            <div align="center">
                <table width="75%">
                    <tr>
                        <td colspan="5">&nbsp;</td>
                    </tr>
                    <tr>
                        <td><div align="center">
                                <table width="100%" class="dataTable">
                                    <tr>
                                        <td colspan="4"><div align="center" class="title_">Datos Comparendo</div></td>
                                    </tr>
                                    <tr>
                                        <td width="15%"><div align="left" style="font-weight: bold">Comparendo:</div></td>
                                        <td width="18%">
                                            <div align="left">
                                                <%= comparendo.getNumero()%>
                                            </div>
                                        </td>
                                        <td width="14%"><div align="left" style="font-weight:bold">Fecha</div></td>
                                        <td width="53%"><div align="left"><%= comparendo.getFecha()%></div></td>
                                    </tr>
                                    <tr>
                                        <td><div align="left" style="font-weight: bold">Documento:</div></td>
                                        <td><div align="left"> <%= persona.getDocumento()%> </div></td>
                                        <td><div align="left" style="font-weight:bold">Infractor</div></td>
                                        <td><div align="left"><%= persona.getNombre_1() + ((persona.getNombre_2() != null) ? " " + persona.getNombre_2() : "") + " " + persona.getApellido_1() + ((persona.getApellido_2() != null) ? " " + persona.getApellido_2() : "")%></div></td>
                                    </tr>
                                    <tr>
                                        <td><div align="left" style="font-weight: bold">Infracción:</div></td>
                                        <td>
                                            <div align="left">
                                                <%= infraccion.getNumero()%>
                                            </div>
                                        </td>
                                        <td><div align="left" style="font-weight: bold">Valor&nbsp;Actual:</div></td>
                                        <td><div align="left"> <%= cartera.getValor()%></div></td>
                                    </tr>
                                </table>
                            </div></td>
                    </tr>
                    <tr>
                        <td><div align="center">
                                <table width="100%" class="dataTable">
                                    <tr>
                                        <td colspan="2"><div align="center" class="title_">Preescripcion</div></td>
                                    </tr>
                                    <tr>
                                        <td><div align="left" style="font-weight: bold">Resolucion:</div></td>
                                        <td><div align="left">
                                                <input type="text" name="resolucion" id="resolucion" style="width:50%" title="Resolucion"  />
                                            </div></td>
                                    </tr>
                                    <tr>
                                        <td><div align="left" style="font-weight: bold">Fecha:</div></td>
                                        <td><div align="left"><input type="text" required="true" name="fechaResolucion" id="fechaResolucion" class="date"  style="background-image:url(../../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onKeyUp="mascara(this,'/',true)" maxlength="10" />
                                                <span class="input">
                                                    <input name="bfechaResolucion" type="button" id="bfechaResolucion" class="bdate" value="&lt;&lt;"/>
                                                    <script type="text/javascript">
                                                        Calendar.setup({
                                                            inputField     :    "fechaResolucion",      // id del campo de texto
                                                            ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                                            button         :    "bfechaResolucion"   // el id del botón que lanzará el calendario
                                                        });
                                                    </script>
                                                </span></div></td>
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
                                        <td><div align="left" style="font-weight: bold">Observacion</div></td>
                                        <td><div align="left">
                                                <input type="text" name="observacion" id="observacion" style="width:90%" />
                                            </div></td>
                                    </tr>
                                </table>
                            </div>  
                        </td>
                    </tr> 
                    <tr>
                        <td>
                            <div align="center">
                                <input type="submit" name="enviar" value="enviar"/>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            <input type="hidden" name="idComparendo" id="idComparendo" value="<%= comparendo.getId_comparendo()%>" />
            <input type="hidden" name="fkProceso" id="fkProceso" value="<%= nextStep%>" />     
        </form>	
    </body>
</html>
<%

                    }
                }
            }
        }
    }%>
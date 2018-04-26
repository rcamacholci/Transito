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
         import="modelo.Audiencia"
         import="utility.ConfiguracionProceso"
         import="java.sql.Timestamp"
         errorPage="" %>

<%@ taglib uri="/WEB-INF/tlds/tagsForm.tld" prefix="TagForm" %>

<%
    Model model = (Model) session.getAttribute("model");

    if (model != null) {
        String msg = (request.getParameter("msg") != null) ? request.getParameter("msg") : "";
        if (request.getParameter("idp") != null && request.getParameter("ns") != null) {
            if (request.getParameter("cfg") != null && request.getParameter("cfg") != null) {
                System.out.println("ID_CONFIGURACION  " + request.getParameter("cfg"));
                //ConfiguracionProceso configuracionProceso = model.consultarConfiguracionProceso(Long.parseLong(request.getParameter("cfg"))) ;
                long idProcesoComparendo = Long.valueOf(request.getParameter("idp"));
                long nextStep = Long.valueOf(request.getParameter("ns"));
                System.out.println("NS  " + nextStep);
                ProcesoComparendo procesoComparendo = model.consultarProcesoComparendo(idProcesoComparendo);

                if (procesoComparendo != null) {
                    long idProceso = procesoComparendo.getFkProceso();

                    //ConfiguracionProceso config = model.;
                    long idComparendo = procesoComparendo.getFkComparendo();
                    Comparendo comparendo = model.consultarComparendoById(idComparendo);

                    if (comparendo != null) {

                        Persona persona = model.consultarPersona(comparendo.getFk_persona());
                        Infraccion infraccion = model.consultarInfraccion(comparendo.getFk_infraccion());
                        Agente agente = model.consultar_Agente_PorId(comparendo.getFk_agente());
                        Cartera cartera = model.consultarCartera(comparendo.getFk_cartera());

                        Audiencia audiencia = model.consultarAudienciaXComparendo(comparendo.getId_comparendo(), 1);
                        System.out.println("AUDIENCIA COMP  " + audiencia.getIdAudiencia());
                        
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
            
            function adicionarDocumentoAdjunto(){
                if ( confirm("Seguro desea agregar el documento a este proceso")) {
                    document.form2.submit() ;
                }
            }
            
            function guardarAudiencia(){
                if ( confirm("Seguro desea guardar los datos de la audiencia")) {
                    document.form.submit() ;
                }
            }
            
            
            
        </script>
        <style type="text/css">
            .bdate {font-size: 10px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .input {width:130px }
        </style>
    </head>
    <body>
        <div align="center" style="width:1000px">
            <!--<form name="form" id="form" method="post" action="procesarAudienciaComparendo.jsp" onsubmit="return validForm();" style="align:center">!-->
            <div align="center" style="width:1000px">
                <table width="75%" align="center">
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
                                <form name="form" id="form" method="post" action="procesarAudienciaComparendo.jsp" onsubmit="return validForm();" style="align:center">
                                    <table width="100%" class="dataTable">
                                        <tr>
                                            <td colspan="4"><div align="center" class="title_">Audiencia&nbsp;Publica</div></td>
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
                                            <td width="10%"><div align="left" style="font-weight: bold">Fecha:</div></td>
                                            <td width="17%">&nbsp;</td>
                                            <td width="13%"><div align="left" style="font-weight: bold">Asistencia:</div></td>
                                            <td width="60%"><div style="font-weight: bold">
                                                    <input type="radio" name="asistencia" id="asistencia" value="1" checked/>
                                                    Asistio
                                                    <input type="radio" name="asistencia" id="asistencia" value="0" />
                                                    No Asistio</div></td>
                                        </tr>
                                        <tr>
                                            <td><div align="left" style="font-weight: bold">Observacion</div></td>
                                            <td colspan="3"><div align="left">
                                                    <label for="observacion"></label>
                                                    <input type="text" name="observacion" id="observacion" size="70" />
                                                    <input type="hidden" name="idComparendo" id="idComparendo" value="<%= idComparendo%>" />
                                                    <input type="hidden" name="fkProceso" id="fkProceso" value="<%= nextStep%>" />     

                                                </div></td>
                                        </tr>
                                        <tr>
                                            <td colspan="4"><hr /></td>
                                        </tr>
                                    </table>
                                    <input type="hidden" name="idAudiencia"  id="idAudiencia" value="<%=audiencia.getIdAudiencia() %>"/>
                                </form>
                            </div>
                            <tr>
                                <td colspan="4">
                                    <div align="center">
                                        <form name="form2" enctype="multipart/form-data" id="form2" method="post" action="adicionarDocumentoAdjuntoProcess.jsp" target="frameDocumentos" >
                                            <table width="100%" border="0" 
                                                   style="border-bottom:solid 1px;border-left:solid 1px;
                                                   border-top:solid 1px; border-right:solid 1px;">

                                                <tr class="dataTable">
                                                    <td colspan="4"><div align="left" style="font-weight: bold">
                                                            <div align="center" style="background:#CCC">DOCUMENTACION</div>
                                                        </div>
                                                        <div align="left" style="font-weight: bold"></div>
                                                        <div align="left" style="font-weight: bold"></div></td>
                                                </tr>
                                                <tr class="dataTable">
                                                    <td><div align="left" style="font-weight: bold">Tipo:</div></td>
                                                    <td><div align="left">
                                                            <TagForm:Select
                                                            model="<%= model%>"
                                                                table="Parametros"
                                                                name="tipo"
                                                                clase="modelo.Parametro"
                                                                filter="fk_grupo=360 order by 1"
                                                                valueField="codigo" 
                                                                dataField="nombre"
                                                            value='<%= ""%>'
                                                            estado='<%= ""%>'
                                                                />  
                                                        </div></td> 
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr class="dataTable">
                                                    <td><div align="left" style="font-weight: bold">Identificador</div></td>
                                                    <td colspan="3"><div align="left">
                                                            <label for="identificador"></label>
                                                            <input type="text" name="identificador" id="identificador" size="50" />
                                                        </div></td>
                                                </tr>
                                                <tr>
                                                    <td ><div align="left">
                                                            <div align="left" style="font-weight: bold">Archivo</div>
                                                        </div></td>
                                                    <td ><div align="left">
                                                            <input type="file" name="archivo" size="50" id="archivo"/>
                                                        </div></td>
                                                    <td>&nbsp;</td>
                                                    <td>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td colspan="4"><div align="center">
                                                            <input type="button" name="adicionar_documento" id="adicionar_documento" value="Adicionar" onclick="adicionarDocumentoAdjunto()" />
                                                        </div></td>
                                                </tr>
                                            </table>
                                            <input type="hidden" name="id_comparendo" id="id_comparendo" value="<%= idComparendo%>" />
                                        </form>
                                    </div></td>
                            </tr>
                            <tr>
                                <td colspan="4"><div align="center" style="vertical-align:top">
                                        <iframe name="frameDocumentos" id="frameDocumentos" frameborder="1" src="listadoDocumentosComparendos.jsp?fk_audiencia=<%= audiencia.getIdAudiencia()%>" scrolling="auto" width="100%" height:"400px"  ></iframe>
                                    </div></td>
                            </tr>
                            <tr>
                                <td colspan="4"><hr /></td>
                            </tr>
                            </table>
                            <!--</div>  -----------------955352!-->
                        </td>
                    </tr> 
                    <tr>
                        <td>
                            <div align="center">
                                <input type="button" name="enviar" value="enviar" onclick="guardarAudiencia()"/>
                            </div>
                        </td>
                    </tr>
                </table>
            </div>
            
            <!--</form>	!-->
        </div>
    </body>
</html>
<%

                    }
                }
            }
        }
    }%>
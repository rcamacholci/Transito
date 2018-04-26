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
<%@include file="/paginas/jsp/general/Context.jsp"  %>

<%


    Model model = (Model) session.getAttribute("model");
    if (model != null) {
        String msg = (request.getParameter("msg") != null) ? request.getParameter("msg") : "";
        if (request.getParameter("idp") != null && request.getParameter("ns") != null) {
            if (request.getParameter("cfg") != null && request.getParameter("cfg") != null) {
                System.out.println("ID_CONFIGURACION  " + request.getParameter("cfg"));
                ConfiguracionProceso configuracionProceso = model.consultarConfiguracionProceso(Long.parseLong(request.getParameter("cfg")));
                long idProcesoComparendo = Long.valueOf(request.getParameter("idp"));
                long nextStep = Long.valueOf(request.getParameter("ns"));
                ProcesoComparendo procesoComparendo = model.consultarProcesoComparendo(idProcesoComparendo);

                if (procesoComparendo != null) {
                    long idProceso = procesoComparendo.getFkProceso();

                    //ConfiguracionProceso config = model.;
                    long idComparendo = procesoComparendo.getFkComparendo();
                    Comparendo comparendo = model.consultarComparendoById(idComparendo);

                    int dias = 0;
                    if (comparendo != null) {

                        long tr = Calendar.getInstance().getTime().getTime() - comparendo.getFecha().getTime();
                        if (tr >= 0) {
                            dias = (int) (tr / 86400000);
                            dias = dias + 1;
                        }

                        System.out.println("FECHA COMPARENDO " + dias + ">=" + configuracionProceso.getDias());
                        System.out.println("HEY MACHUCHO  " + (dias <= configuracionProceso.getDias()));
                        if (dias > configuracionProceso.getDias()) {%>
<jsp:forward page="procesoContravencional.jsp">
    <jsp:param name="idC" value="<%= comparendo.getId_comparendo()%>"/>
    <jsp:param name="msg" value="El comparendo no cumple con el requisito de tiempo para este proceso"/>
</jsp:forward>
<%
    }

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
        <link rel="stylesheet" type="text/css" href='../../html/css/ui/dialog-form-style.css' />
        <link rel="stylesheet" type="text/css" href='../../html/css/design/page-style.css' />
        <link rel="stylesheet" type="text/css" href='../../html/css/ui/ui.style.css' />
        

        <style type="text/css">
            .dataTable{ 
                border: outset 1px #000 ;
            }
        </style>

        <script src="../../html/scripts/jquery-1.8.3.min.js" type="text/javascript"></script>
        <script src="../../html/scripts/jquery-ui-1.9.2.custom.min.js" type="text/javascript"></script>
        <script src="../../html/scripts/generalFunctions.js" type="text/javascript"></script>
        <script src="../../html/scripts/comparendos/proceso/audiencia/impugnacionComparendo.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../../html/scripts/calendar-setup.js" type="text/javascript"></script>

        <script type="text/javascript" language="javascript">
			
            $(document).ready(loadedPage) ;            
                        
            function loadedPage(){
				
                configDialog("dialog-form") ;
				
                var msg = "<%= msg%>" ;
                if ( Trim(msg).length>0){
                    alert(msg) ;
                }
            }
			
			
            function showDialogForm(){
                $( "#dialog-form" ).dialog( "open" );
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
            .input {width:130px;}   


        </style>
    </head> 


    <body>

        <div id="dialog-form" title="Adicionar Documento" class ="dialog-form">

            <form name="attachFileForm" enctype="multipart/form-data" id="attachFileForm" method="post" action="http://localhost:8084/transito/upload"  >
                <fieldset>
                    <label for="identificador"> Identificador </label>
                    <input type="text" name="identificador" id="identificador"/>
                    <label for="archivo"> Ruta </label>
                    <input type="file" name="archivo" id="archivo"/>
                </fieldset>
            </form>
        </div>


        <div align="center" style="width:1000px" id="div-content">
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
                                <table width="100%" class="dataTable">
                                    <tr>
                                        <td colspan="5"><div align="center" class="title_">Impugnación</div></td>
                                    </tr>
                                    <tr>
                                        <td width="21%"><div align="left" style="font-weight: bold">Numero&nbsp;Radicaci&oacute;n</div></td>
                                        <td width="27%"><div align="left">
                                                <input type="text" name="numero_radicacion" id="numero_radicacion" style="width:50%" />
                                            </div></td>
                                        <td width="19%"><div align="left" style="font-weight: bold">Fecha&nbsp;Radicacion</div></td>
                                        <td width="22%"><div align="left">
                                                <input type="text" name="fecha" id="fecha" class="date"  style="background-image:url(../../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10" />
                                                <span class="input">
                                                    <input name="bfecha" type="button" id="bfecha" class="bdate" value="&lt;&lt;"/>
                                                </span>                                                <span class="input"><script type="text/javascript">
                                                    Calendar.setup({
                                                        inputField     :    "fecha",      // id del campo de texto
                                                        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                                        button         :    "bfecha"   // el id del botón que lanzará el calendario
                                                    });
                                                    </script>
                                                </span></div></td>
                                        <td width="11%">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td><div align="left" style="font-weight: bold">Archivo</div></td>
                                        <td colspan="4"><div align="left">
                                                <input type="file" name="ruta" id="ruta" size="45px"/>
                                            </div></td>
                                    </tr>
                                    <tr>
                                        <td><div align="left" style="font-weight: bold">Observacion</div></td>
                                        <td colspan="4"><div align="left">
                                                <input type="text" name="observacion" id="observacion" style="width:80%" />
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
                                </table>
                            </div></td>   
                        <tr>
                            <td colspan="4">
                                <div align="center">
                                    <table width="100%" border="0" 
                                           style="border-bottom:solid 1px;border-left:solid 1px;
                                           border-top:solid 1px; border-right:solid 1px;">

                                        <tr class="dataTable">
                                            <td><div align="left" style="font-weight: bold">
                                                    <div align="center" style="background:#CCC">DOCUMENTACION</div>
                                                </div>
                                                <div align="left" style="font-weight: bold"></div>
                                                <div align="left" style="font-weight: bold"></div></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <div align="right">
                                                    <button id="dialog-button" name="dialog-button" onclick="showDialogForm()">+</button> 
                                                </div></td>
                                        </tr>
                                        <tr>
                                            <td>
                                                <table id="table_attached" border="0" width="100%">
                                                    <thead>
                                                        <tr>
                                                            <th> Identificador </th>
                                                            <th> Archivo </th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                    </tbody>
                                                </table>
                                            </td>
                                        </tr>
                                    </table>

                                    <div id="hiddenFieldsDiv">
                                        <input type="hidden" name="id_comparendo" id="id_comparendo" value="<%= comparendo.getId_comparendo()%>" />
                                        <input type="hidden" name="fk_proceso" id="fkProceso" value="<%= nextStep%>" />
                                        <input type="hidden" name="cfg" id="cfg" value="<%= request.getParameter("cfg")%>" />
                                        <input type="hidden" name="idp" id="idp" value="<%= request.getParameter("idp")%>" />
                                        <input type="hidden" name="id_comparendo" id="id_comparendo" value="<%= idComparendo%>" />
                                    </div>

                                </div></td>
                        </tr>
                        <tr>
                            <td colspan="4"><div align="center" style="vertical-align:top">
                                    <iframe name="frameDocumentos" id="frameDocumentos" frameborder="1" src="" scrolling="auto" width="100%" height:"400px"  ></iframe>
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

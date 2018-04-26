<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=utf-8" language="java" 
         import="java.sql.*"
         import="java.util.List" 
         import="java.util.Calendar"
         import="java.util.LinkedList" 
         import="java.util.Iterator" 
         import="modelo.Model" 
         import="modelo.Comparendo" 
         import="modelo.Departamento" 
         import="modelo.Municipio" 
         import="modelo.Divipo" 
         import="modelo.Direccion" 
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
                ProcesoComparendo procesoComparendo = model.consultarProcesoComparendo(idProcesoComparendo);

                if (procesoComparendo != null){
                    
                    long idProceso = procesoComparendo.getFkProceso();

                    //ConfiguracionProceso config = model.;
                    long idComparendo = procesoComparendo.getFkComparendo();
                    Comparendo comparendo = model.consultarComparendoById(idComparendo);                                                         
                    
                                                                                                                                    
                    
                    Persona persona = model.consultarPersona(comparendo.getFk_persona());
                    Infraccion infraccion = model.consultarInfraccion(comparendo.getFk_infraccion());
                    Agente agente = model.consultar_Agente_PorId(comparendo.getFk_agente());
                    Cartera cartera = model.consultarCartera(comparendo.getFk_cartera());

                    String departamentoId = "";
                    String municipioId = "";
                    String departamento = "";
                    String dir = "";
                    String tel = "";
                    String fax = "";

                    Municipio municipio = null;

                    java.util.List direcciones = model.listado_direcciones_persona(persona.getId_persona());


                    Direccion direccionP = null;

                    if (direcciones.size() > 0) {
                        direccionP = (Direccion) direcciones.get(0);
                        if (direccionP.getFk_divipo() != 0) {
                            Divipo divipo = model.getDivipo(direccionP.getFk_divipo());
                            if (divipo != null) {
                                
                                departamentoId = divipo.getFk_departamento() + "";

                                municipio = model.consultarMunicipioDivipo(divipo.getId_divipo());
                                System.out.println("");

                            }
                        }
                        
                        if (direccionP.getDescripcion() != null) {
                            dir = direccionP.getDescripcion();
                        }
                        
                        if (direccionP.getTelefono() != null) {
                            tel = direccionP.getTelefono();
                        }
                                                
                        if (direccionP.getFax() != null) {
                            fax = direccionP.getFax();
                        }
                        
                    }

                    System.out.println("MUNICIPIOXX " + municipio!=null);

                    /*List<modelo.Direccion> list = model.listado_direcciones_persona(persona.getId_persona());
                    modelo.Direccion dir = null;
                    
                    if (list != null && list.size() > 0) {
                    dir = (modelo.Direccion) list.get(0);
                    }*/

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
                cargarMunicipios() ;                                
            }
            
            
            function cargarMunicipios( ){
                var fkDepartamento = $("#departamento").val() ;
                $("#divMunicipios").load("../cargarMunic_dir.jsp",{param:1,fk_dpto:fkDepartamento}) ;
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
        <form name="form" id="form" method="post" action="procesarNotificacionComparendo.jsp" onsubmit="return validForm();">
            <div align="center">
                <table width="75%">
                    <tr>
                        <td colspan="5">&nbsp;</td>
                    </tr>
                    <tr>
                        <td><div align="center">
                                <table width="85%" class="dataTable">
                                    <tr>
                                        <td colspan="4" class="title_" align="center">Notificacion</td>
                                    </tr>
                                    <tr>
                                        <td colspan="4"><div align="center" style="background-color:#EEE; font-weight:bold">Datos Comparendo</div></td>
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
                                <table width="85%" class="dataTable">
                                    <tr>
                                        <td colspan="5" align="center" style="background-color:#EEE; font-weight:bold">
                                            Datos Residencia                                        </td>
                                    </tr>
                                    <tr>
                                        <td width="5%">&nbsp;</td>
                                        <td><div align="left" style="font-weight: bold">Departamento:</div></td>
                                        <td width="29%">
                                            <div align="left">
                                                <select name="departamento" id="departamento" style="width:180px" onchange="cargarMunicipios(); return false" onblur=	"buscarDirMunicipios2(); return false">
                                                    <% List listaDepar_per = model.crearListaDpto();
                                                        Iterator it_dep_per = listaDepar_per.iterator();
                                                        while (it_dep_per.hasNext()) {
                                                            Departamento dpto = (Departamento) it_dep_per.next();
                                                            if (departamentoId.equals(dpto.getId_departamento() + "")) {%>
                                                    <option value="<%=dpto.getId_departamento() + ""%>" selected><%=dpto.getNombre()%></option>
                                                    <% } else {%>
                                                    <option value="<%=dpto.getId_departamento() + ""%>"><%=dpto.getNombre()%></option>
                                                    <% }
                                                        }%>
                                                </select>
                                            </div>
                                        </td>
                                        <td width="13%"><div align="left">
                                                <div align="left" style="font-weight: bold">Municipio:</div>
                                            </div></td>
                                        <td width="35%">
                                            <div align="left" id="divMunicipios">
                                                <select name="dir_municipio" id="dir_municipio" style="width:180px">
                                                    <% if (departamento.length() > 0) {
                                                            java.util.List lista = model.crearListaMunicipios(Integer.parseInt(departamento));
                                                            for (int i = 0; i < lista.size(); i++) {
                                                                Municipio mun = (Municipio) lista.get(i);
                                                                System.out.println(municipio.getNombre() + ":" + municipio.getCodigo() + "==" + mun.getCodigo());
                                                                if ((municipio != null && (municipio.getCodigo() + "").equals(mun.getCodigo() + ""))) {%>
                                                    <option value="<%=mun.getCodigo() + ""%>" selected><%=mun.getNombre()%></option>
                                                    <% } else {%>
                                                    <option value="<%=mun.getCodigo() + ""%>"><%=mun.getNombre()%></option>
                                                    <%	        }
                                                            }
                                                        }%>
                                                </select>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td><div align="left" style="font-weight: bold">Direccion:</div></td>
                                        <td colspan="3"><div align="left">
                                                <input type="text" name="direccion" id="direccion" value="<%=((dir != null) ? dir : "")%>" style="width:80%; text-transform: uppercase" title="Direccion"  />
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
                                        <td>&nbsp;</td>
                                        <td width="18%"><div align="left" style="font-weight: bold">Telefono:</div></td>
                                        <td><div align="left">
                                                <input type="text" name="telefono" id="telefono" value="<%=((direccionP != null && direccionP.getTelefono() != null) ? direccionP.getTelefono() : "")%>" style="width:80%" />
                                            </div></td>
                                        <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td colspan="5" align="center" style="background-color:#EEE; font-weight:bold"> Datos Complementarios</td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td><div align="left" style="font-weight: bold">Celular:</div></td>
                                        <td colspan="3"><div align="left">
                                                <input type="text" name="celular" id="celular" value="<%=((persona.getCelular() != null) ? persona.getCelular() : "")%>" style="width:80%" />
                                            </div></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td><div align="left" style="font-weight: bold">Email:</div></td>
                                        <td colspan="3"><div align="left">
                                                <input type="text" name="email" id="email" title="Correo"  value="<%=((persona.getEmail() != null) ? persona.getEmail() : "")%>" style="width:60%;text-transform: uppercase" />
                                            </div></td>
                                    </tr>
                                    <tr>
                                        <td>&nbsp;</td>
                                        <td><div align="left" style="font-weight: bold">Observacion</div></td>
                                        <td colspan="3"><div align="left">
                                                <input type="text" name="observacion" id="observacion" title="Correo"  value="" style="width:80%;text-transform: uppercase" />
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
%>
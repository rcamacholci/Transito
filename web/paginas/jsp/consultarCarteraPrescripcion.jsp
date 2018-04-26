<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*, java.io.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
    try {
        if (session.getAttribute("usuario") != null) {
            modelo.Model modelo = (modelo.Model) session.getAttribute("model");
            if (modelo != null) {
                modelo.Usuario usuario = (modelo.Usuario) session.getAttribute("usuario");
                if (modelo.tienePermiso(usuario.getId_usuario(), 7)) {
                    SystemParams params = null;
                    int VIG_PRESCRIPCION = params.VIGENCIA_PRESC_CARTERA.getValue();

%>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
        <title> Cartera Vehiculo </title>
        <link rel="stylesheet" type="text/css" href='../html/css/style.css' />
        <link rel="stylesheet" type="text/css" href='../../html/css/style.css' />
        <link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>

        <style type="text/css">
            <!--
            .style1 {
                color: #333333;
                font-family: Tahoma;
                font-size: 12px;
            }
            .style2 {color: #333333; font-weight: bold; }
            .style4 {
                font-family: Tahoma;
                font-size: 12px;
                font-weight: bold;
                color: #FFFFFF;
            }
            .style6 {
                font-family: Tahoma;
                font-weight: bold;
                color: #333333;
                font-size: 12px;
            }
            .style8 {color: #333333; font-weight: bold; font-size: 16px; }
            .Estilo1 {
                font-size: 12px;
                font-weight: bold;
                color: #FFFFFF;
            }
            .Estilo3 {font-family: Tahoma; font-weight: bold; color: #333333; font-size: 9px; }

            .label {font-size: 11px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold ; width:110px}
            .text {font-size: 11px; color:#000000; text-align:center ; font-family:Arial; font-weight:bold ; width:120px; text-transform:uppercase}
            .date {font-size: 11px; color:#000000; text-align:center ; font-family:Arial; font-weight:bold; width:100px }
            .bdate {font-size: 10px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .select {font-size: 11px; color:#000000; text-align:left ; font-family:Arial; font-weight:bold; width:120px }
            .input { width:130px }
            .check { font-size: 11px; color:#000000; text-align:center ; font-family:Arial; font-weight:bold; }
            .label1 {font-size: 11px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold ; width:110px}
            .Estilo26 {color: #333333; font-family: Tahoma; font-weight: bold;}
            .Estilo31 {color:#000000}

            -->
        </style>

        <script src="../html/scripts/jquery-1.4.2.min.js" type="text/javascript"></script>
        <script src="../html/scripts/generalFunctions.js" type="text/javascript"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script type="text/javascript" src="../html/scripts/consultasGenerales.js"></script>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>

        <script language="javascript">
            
            
            
            function validSend(){
                 
                var vigenciaI = $("#vigenciaI").val() ;
                var vigenciaF = $("#vigenciaF").val() ;
                
                if ( vigenciaF > 0 && vigenciaI > 0 ){
                    if ( vigenciaF >= vigenciaI ){
                        $("#btnsbm").css("display" , "block") ;
                        return true ;
                    }else{
                        $("#btnsbm").css("display" , "none") ;
                        alert("La vigencia inicial no puede ser mayor a la final") ;
                    }
                }else{
                    $("#btnsbm").css("display" , "none") ;
                }
                
                return false ;
            }
            
            function validFields(){
                
                if ( Trim($("#numero").val()).length > 0 ){
                    if ( Trim($("#fecha").val()).length > 0 ){
                        if ( Trim($("#documento").val()).length > 0 ){
                            if ( Trim($("#nombre").val()).length > 0 ){
                                            
                                return true ;
                                                
                            }else{
                                alert("El campo nombre no puede estar vacio") ;
                            }
                        }else{
                            alert("El campo documento no puede estar vacio") ;
                        }
                    }else{
                        alert("El campo fecha no puede estar vacio") ;
                    }
                }else{
                    alert("El campo numero no puede estar vacio") ;
                }
                
                return false ;
            }
            
            function procesarPrescripcionCartera(){
                
                if ( validFields() ) {
                    
                    if( confirm("Esta seguro de realizar el prceso de prescripcion") ){
                        document.form.target = "_parent" ;
                        document.form.action = "procesarPrescripcionCartera.jsp" ;
                        document.form.submit() ;   
                    }
                    
                }
                
            }
            

            function verReporte(dir,nombre){
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width-ancho)/2 : 100;
                arriba = (document.height) ? (document.height-alto)/2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
                window.open(url, 'popUp', opciones);
            }
        
        
            function printPazYSalvo(dir,nombre){
            
                ancho = 789;
                alto = 600;
                barra = 0;
                izquierda = (document.width) ? (document.width-ancho)/2 : 100;
                arriba = (document.height) ? (document.height-alto)/2 : 100;
                opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars=' + barra + ',resizable=0,width=' + ancho + ',height=' + alto + ',left=' + izquierda + ',top=' + arriba + '';
                url = "verReportes.jsp?nombreReporte="+nombre+"&dirReporte="+dir;
                window.open(url, 'popUp', opciones);
            }
        
	
            function verDetalleCartera(id_cartera){
                if(id_cartera!=null)
                    window.frames[0].location.href = "consultarDetalleCarteraPrescripcion.jsp?id_cartera="+id_cartera;
                sombrear(id_cartera);
            }
            function sombrear(id_cartera){
                renovar();
                document.getElementById(id_cartera).style.backgroundColor="#CCCCCC";
            }
            function renovar(){
                var filas = document.getElementById('tabla').getElementsByTagName('tr');
                for(i=1;i<filas.length;i++)
                    filas[i].style.backgroundColor="#FFFFFF";
            }
            
            
            function selectAll(check){
                $(":checkbox[prescribe='true']").attr("checked" , check) ;
                document.form.submit();
            }
            
            function getDetail(){
                
                if ( validSend() ){
                    
                    document.form.target = "detalle_cartera" ;
                    document.form.action = "consultarDetalleCarteraPrescripcion.jsp" ;
                    document.form.submit() ;
                    
                }
                
            }
            
            
            
            
            
        </script>
    </head>
    <%@ page import="modelo.*"%>
    <%@page import="java.util.*"%>
    <body>
        <%


            Cartera cartera = new Cartera();
            String placa = "";

            placa = request.getParameter("placa");
            if (placa != null) {
                Vehiculo vehiculo = modelo.consultarVehiculo(placa.toUpperCase().trim());

                if (vehiculo != null) {
                    HashMap parameters = new java.util.HashMap();

                    Persona persona = modelo.consultarPersona(usuario.getFk_persona());

                    if (persona != null) {

                        String nombre = persona.getNombreCompleto();
                        parameters.put("FIRMANTE", nombre);


                    }

                    parameters.put("PLACA", vehiculo.getPlaca());
                    parameters.put("VEHICULO", "" + vehiculo.getId_vehiculo());
                    parameters.put("USUARIO", usuario.getNombre());

                    session.setAttribute("EstadoCuenta", parameters);
                    session.setAttribute("certificadoPazYSalvo", parameters);

                    String direccion = "recaudoycartera/otros/estado_cuenta.jasper";
                    String nombreR = "EstadoCuenta";

                    String direccionPZ = "certificados/certificadoPazYSalvoReport.jasper";
                    String nombrePZ = "certificadoPazYSalvo";

                    System.out.println("Carteras  " + vehiculo.getId_vehiculo());

                    List cartera_vehiculo = modelo.crearListaCarteraPlaca(vehiculo.getId_vehiculo(), usuario.getId_usuario());


        %>    
        <br/><br/>
        <body> 
            <form name="form" id="form" method="post" >
                <table id="content" border="0" width="100%" cellspacing="0" align="center">
                    <tr>
                        <td align="center">
                            <fieldset>
                                <legend>Datos Generales</legend>
                                <table width="70%" border="0">
                                    <tr>
                                        <td align="left" class="label"><div align="left">Numero</div></td>
                                        <td><div align="left"><span class="Estilo26">
                                                    <input  id="numero" name="numero" type="text" class="Estilo31" style="width:150px; text-align:center" />
                                                </span></div></td>
                                        <td><div align="left"><span class="label1">Fecha</span></div></td>
                                        <td><div align="left"><strong>
                                                    <input type="text" class="check" name="fecha" id="fecha"  style="width:100px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10" />
                                                    <input name="Bfecha_comp" class="check" type="button" id="Bfecha_comp" value="&lt;" style="width:20px"/>
                                                    <script type="text/javascript">
                                                        Calendar.setup({
                                                            inputField     :    "fecha",      // id del campo de texto
                                                            ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                                            button         :    "Bfecha_comp"   // el id del bot&oacute;n que lanzar&aacute; el calendario
                                                        });
                                                    </script>
                                                </strong></div></td>
                                    </tr>
                                    <tr>
                                        <td width="110" align="left" class="label">Tipo&nbsp;Documento</td>
                                        <td width="187"><div align="left"><strong>
                                                    <select class="check" name="tipo_doc" id="tipo_doc" style="width:150px" onchange="consultaPersona(this.id, 'documento', 'nombre') ">
                                                        <%
                                                            List lista_id = modelo.listadoParametros(5);
                                                            Iterator itrtor = lista_id.iterator();
                                                            while (itrtor.hasNext()) {
                                                                modelo.Parametro parametro = (modelo.Parametro) itrtor.next();%>
                                                        <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                                        <%}%>
                                                    </select>
                                                </strong></div></td>
                                        <td width="110"><div align="left" class="label">Documento</div></td>
                                        <td width="525"><div align="left">
                                                <input class="check" name="documento" type="text" id="documento" style="width:120px;text-align:center" onkeypress="return soloNumeros(event)" onblur="consultaPersona('tipo_doc', this.id, 'nombre')"/>
                                            </div></td>
                                    </tr>
                                    <tr>
                                        <td><div align="left" class="label">Solicitante</div></td>
                                        <td colspan="3"><div align="left">
                                                <input name="nombre"  class="check"type="text" id="nombre"  style="width:450px" readonly="readonly"/>
                                            </div></td>
                                    </tr>
                                    <tr>
                                        <td class="colon"><div align="left" class="label1" style="vertical-align:top">Observaciones</div>

                                        </td>
                                        <td colspan="3"><input name="observaciones" type="text" id="observaciones"  style="width:450px; height:50px; font-size:10px"/>

                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="left" valign="top"><div align="left" class="label">Vigencia&nbsp; Inicial</div></td>
                                        <td align="left" valign="top"><div align="left"><strong>
                                                    <select class="check" name="vigenciaI" id="vigenciaI" style="width:150px" onchange="getDetail()" >
                                                        <option value="0" selected> >> Seleccionar << </option>
                                                        <%
                                                            for (int i = 0; i < cartera_vehiculo.size(); i++) {
                                                                String disabled = "";
                                                                cartera = (Cartera) cartera_vehiculo.get(i);
                                                                if (Integer.parseInt(cartera.getReferencia()) > VIG_PRESCRIPCION) {
                                                                    disabled = "";
                                                                }%>
                                                        <option value="<%=cartera.getReferencia()%>" <%= disabled%>><%=cartera.getReferencia()%></option>
                                                        <%}%>
                                                    </select>
                                                </strong></div></td>
                                        <td align="left" valign="top"><div align="left" class="label">Vigencia&nbsp;Final</div></td>
                                        <td align="left" valign="top"><div align="left"><strong>
                                                    <select class="check" name="vigenciaF" id="vigenciaF" style="width:150px" onchange="getDetail()" >
                                                        <option value="0" selected>  >> Seleccionar << </option>
                                                        <%
                                                            for (int i = 0; i < cartera_vehiculo.size(); i++) {
                                                                String disabled = "";
                                                                cartera = (Cartera) cartera_vehiculo.get(i);
                                                                if (Integer.parseInt(cartera.getReferencia()) > VIG_PRESCRIPCION) {
                                                                    disabled = "";
                                                                }%>
                                                        <option value="<%=cartera.getReferencia()%>" <%= disabled %>><%=cartera.getReferencia()%></option>
                                                        <%}%>
                                                    </select>
                                                </strong></div></td>
                                    </tr>
                                </table>
                            </fieldset></td>
                    </tr>
                    <tr> 
                        <td align="left">&nbsp;</td>
                    </tr>
                    <tr>
                        <td valign="top"></fieldset>
                            <fieldset> 
                                <legend> Detalle Cartera </legend>
                                <iframe src="consultarDetalleCartera.jsp?id" id="detalle_cartera" name="detalle_cartera" marginwidth="0" height="280" width="100%" marginheight="0" align="top" scrolling="auto" style="border:none"></iframe>
                                <div align="center"></div>
                            </fieldset>
                        </td>
                    </tr>
                    <tr>
                        <td align="center">
                            <input type="button" id="btnsbm" class="boton_" value ="Enviar" onclick="javascript:procesarPrescripcionCartera()" style="display:none"/>
                        </td>
                    </tr>
                </table>
                <input type="hidden" name="placa" id="placa" value="<%= placa%>" />
            </form>
        </body> 
        <%}
        } else {%>
        <script>
            alert("Digite numero de placa");
            window.href="consultar_Vehiculo.jsp";
        </script>
        <% }
        %>
</html>
<%
} else {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="1"></jsp:param></jsp:forward>
<%        }
} else {%>
<script>window.parent.document.location.href = "../../index.jsp";</script>
<%  }
} else {%>
<script>window.parent.document.location.href = "../../index.jsp";</script>
<% }
} catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% }%>

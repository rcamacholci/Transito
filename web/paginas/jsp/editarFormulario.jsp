<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html;charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" errorPage="" %>
<%@page import = "modelo.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Documento sin t&iacute;tulo</title>
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="../html/scripts/calendar.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<script src="../html/scripts/personas.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
	function nuevoAjax(){
		var xmlhttp= false;
		try{
			xmlhttp = new ActiveXObject("Msxml2.XMLHTTP");
		}catch(e){
			try {
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}catch(E){
				xmlhttp = false;
			}
		}

		if (!xmlhttp && typeof XMLHttpRequest!='undefined') {
			xmlhttp = new XMLHttpRequest();
		}

		return xmlhttp;
	}

            function consultaPersona2(){
        var documento = document.getElementById("nitConc");
        if(!isNaN(documento.value)&&documento.value.length>0){

                var tipoDoc = 2;
                var ajax2=nuevoAjax();
                ajax2.open("POST", "getPersona.jsp",true);
                ajax2.onreadystatechange=function() {
                        if (ajax2.readyState==4) {
                                var respuesta = "" ;
                                for(var i = 0; i < ajax2.responseText.length ; i++){
                                        if(isNaN(ajax2.responseText.charAt(i))||ajax2.responseText.charAt(i)==' ')
                                                respuesta += ajax2.responseText.charAt(i);
                                }
                                if(respuesta.indexOf("nueva")!=-1){
                                        viewPersona(tipoDoc,documento.value);
                                }else{
                                  document.form.nombreConcesionario.value = respuesta;
                                }
                        }
                }
                ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                ajax2.send("documento="+documento.value+"&tipo="+tipoDoc);
        }
    }


    function consultaPersona(){
		tipo = document.getElementById("tipoDocumento") ;
		documento = document.getElementById("numeroDocumento").value ;
                if(documento.length>0&&!isNaN(documento)){
			tipoDoc = tipo.options[tipo.options.selectedIndex].value
			ajax=nuevoAjax();
			ajax.open("POST", "getPersona.jsp",true);
			ajax.onreadystatechange=function() {
				if (ajax.readyState==4) {
					var respuesta = "" ;
					for(var i = 0; i < ajax.responseText.length ; i++){
						if(isNaN(ajax.responseText.charAt(i)))
							respuesta += ajax.responseText.charAt(i);
					}
					if(respuesta == "nueva"){
                                            document.getElementById("nombreRadicador").value = "";
                                            viewPersona(tipoDoc,documento);
					}else{
						document.getElementById("nombreRadicador").value = ajax.responseText;
					}
				}
			}
			ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
			ajax.send("documento="+documento+"&tipo="+tipoDoc);
		}else{
                    document.getElementById("nombreRadicador").value = "";
                }
	}

	function newP(){
   		window.frames[0].location.href = "editarRadicacionPropietarios.jsp?tipo=1&tipopropiedad=1&proindiviso=N";
        }

	function validar(tramite){
           var placa = document.getElementById("placa").value;
	   var runt = document.getElementById("runt").value;
           if(runt.length == 0){
                alert("Digite Numero Liquidacion RUNT del Tramite");
                return false;
           }
           if(tramite==1||tramite==2||tramite==4){
                 var npropietarios = window.frames['prop'].document.getElementById("nprop").value;
                 var sumap = window.frames['prop'].document.getElementById("sumap").value;
                 for(i=0;i<npropietarios;i++){
                    if(window.frames['prop'].document.getElementById("tnombre"+i).value.length==0){
                            alert("Ingrese un propietario valido, no deben existir campos en blanco");
                            return false;
                    }
                 }
                 if(npropietarios==0){
                    alert("Debe ingresar por lo menos un propietario al vehiculo");
                    return false;
                 }
                 if(sumap!=100){
                    alert("Los porcentajes de propiedad deben ser igual a 100%");
                    return false;
                 }
           }
           if(tramite==1||tramite==4||tramite==17){
                motor = document.getElementById("motor");
                if(motor.value.length>0||motor.disabled){
                    chasis = document.getElementById("chasis");
                    if(chasis.value.length>0||chasis.disabled){
                        serie = document.getElementById("serie");
                        return true;
                    }else{
                        alert("Digite el numero de chasis del vehiculo");
                    }
                }else{
                    alert("Digite el numero de motor del vehiculo");
                }
  	   }
	}

	function evaluar(){
		var placa = document.getElementById("placa").value;
                var motor = "";
		if(document.getElementById("motor")!=null)
                    motor = document.getElementById("motor").value;
                var chasis = "";
		if(document.getElementById("chasis")!=null)
                    chasis = document.getElementById("chasis").value;
                var serie = "";
            	if(document.getElementById("serie")!=null)
                    serie = document.getElementById("serie").value;
                var runt = document.getElementById("runt").value;
                if(runt.length == 0){
                        alert("Digite Numero RUNT del Tramite");
                        return false;
                }
                ajax3=new nuevoAjax();
                ajax3.open("POST", "verificarDatos.jsp",true);
                ajax3.onreadystatechange=function() {
                    if (ajax3.readyState==4) {
                        if(ajax3.responseText.indexOf("existe")==-1){
                                        document.form.submit();
                                        return true;
                        }else{
                                        alert(ajax3.responseText);
                                        return false;
                        }
                    }
                }
                ajax3.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                ajax3.send("placa="+placa+"&motor="+motor+"&chasis="+chasis+"&serie="+serie+"&tramite="+document.form.tramite.value);
	}

    function revisarL(lq){
        lq.style.color = "#333333";
        lq.value = '600000000000000000'.substr(0, 18-lq.value.length)+lq.value;
        if(lq.value.length==18){
            if(isNaN(lq.value)){
                alert("Digite solo valores numericos.");
            }else{
                ajax2=new nuevoAjax();
                ajax2.open("POST", "verificarLiquidacion.jsp",true);
                ajax2.onreadystatechange=function() {
                    if (ajax2.readyState==4) {
                        var respuesta = ajax2.responseText;
                        if(respuesta.indexOf("PAGADO")==-1)
                            lq.style.color = "#FF0000";
                        else
                            if(respuesta.indexOf("NO_ACCESO")!=-1)
                                lq.style.color = "#333333";
                            else
                                lq.style.color = "#006699";
                    }
                }
                ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                ajax2.send("runt="+lq.value);
            }
        }else{
                lq.style.color = "#FF0000";
        }
    }

    function cancelar(){
        document.location.href = "formularioTramite.jsp?id_radicacion="+document.form.rad.value;
    }
</script>
<style type="text/css">
<!--
.Estilo1 {color: #FE9900}
.Estilo2 {font-size: 12px}
.Estilo3 {
	font-size: 14px;
	color: #333333;
}
.Estilo4 {color: #333333}
.Estilo5 {
	color: #333333;
	font-size: 12px;
}
.Estilo6 {color: #333333}
.Estilo7 {font-size: 24px}
.Estilo9 {
	color: #333333;
	font-weight: bold;
	font-size: 12px;
}
.Estilo11 {color: #FFFFFF; font-size: 12px; }
.Estilo12 {
	font-size: 14px;
	font-weight: bold;
	color: #FE9900;
}
.Estilo13 {color: #FFFFFF}
.Estilo61 {font-size: 10px}
-->
</style>
</head>
<%
try {
	Model model = (Model) session.getAttribute("model");
	Radicacion radicacion = model.consultar_Radicacion(Long.parseLong(request.getParameter("idRadicacion")));
        Formulario formulario = model.consultarFormularioByTramite(radicacion.getId_radicacion(), Long.parseLong(request.getParameter("idTramite")));
        String fichaT = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(), 2, 3);
%>
<body>
<table width="80%" border="0" align="center">
  <tr>
    <td width="87%" height="26" align="center"><strong><span class="Estilo1 Estilo3">EDITAR DATOS  DEL FORMULARIO </span></strong></td>
 </tr>
  <tr>
    <td height="481" align="center" valign="top">
	<form name="form" id="form" method="post" action="procesarEditarFormulario.jsp">
            <input type="hidden" name="rad" id="rad" value="<%=radicacion.getId_radicacion()%>">
            <input type="hidden" name="formulario" id="formulario" value="<%=formulario.getId_formulario()%>">
 	 <fieldset>
	 <legend><span class="Estilo9">INFORMACION SOLICITANTE </span></legend>
	 <table width="100%" border="0" align="center" id="panelTramites" style="display:block">
       <tr>
         <th colspan="6" scope="col">&nbsp;</th>
       </tr>
       <tr>
         <th colspan="6" scope="col"><span class="Estilo12"><%=formulario.getPlaca()%></span></th>
       </tr>
       <tr>
         <th colspan="6" scope="col">&nbsp;</th>
       </tr>
       <tr>
         <td width="8%" align="left"><span class="Estilo5">
           <label><font face="Arial, Helvetica, sans-serif"><b>Solicitante</b></font></label>
         </span></td>
         <td width="17%" align="left"><span class="Estilo5">
           <select  name="tipoDocumento" id="tipoDocumento" style="width:150px; font-size:10px; color:#006699">
             <% java.util.List tipoDocumentos = model.listadoParametros(5);
                Persona solicitante = model.consultarPersona(radicacion.getFk_persona());
                int tipoS = solicitante.getTipo_documento();
                String docS = solicitante.getDocumento();
                String nombreS = solicitante.getNombre_1()+" "+(solicitante.getNombre_2()!=null?solicitante.getNombre_2():"")+" "+solicitante.getApellido_1()+" "+(solicitante.getApellido_2()!=null?solicitante.getApellido_2():"");
                for (int i = 0; i < tipoDocumentos.size(); i++) {
                    Parametro parametro = (Parametro) tipoDocumentos.get(i);
		    if(parametro.getCodigo()==tipoS){ %>
                       <option value="<%=parametro.getCodigo()%>" selected="selected"><%= parametro.getNombre()%> </option>
                <%  }else{ %>
                       <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
                <%  }
               } %>
           </select>
         </span> </td>
         <td width="10%" align="center"><span class="Estilo5">
           <label><font face="Arial, Helvetica, sans-serif"><b>Documento</b></font></label>
         </span></td>
         <td width="17%" align="left"> 
		 <input name="numeroDocumento" type="text" id="numeroDocumento"  onblur="consultaPersona()" value="<%=docS%>" style="width:140px; text-align:center; font-size:12px; color:#006699"/></td>
         <td width="11%" align="left"><span class="Estilo5">
           <label><font face="Arial, Helvetica, sans-serif"><b>Nombre</b></font></label>
         </span></td>
         <td width="37%" align="left">
             <input name="nombreRadicador" type="text" id="nombreRadicador" style="width:300px; font-size:10px; color:#006699" value="<%=nombreS%>" readonly="true"/>
         </td>
       </tr>
       <tr>
         <td colspan="6"><table width="99%" border="0">
           <tr style="background:url(../html/images/inicio_3.jpg)">
             <th width="5%" scope="col"><span class="Estilo11">
               <label><font face="Arial, Helvetica, sans-serif"><b>ID</b></font></label>
               <label></label>
             </span></th>
             <th width="50%" scope="col"><span class="Estilo11">
               <label><font face="Arial, Helvetica, sans-serif"><b>NOMBRE TRAMITE</b></font></label>
               <label></label>
             </span></th>
             <th width="15%" scope="col"><span class="Estilo11">
               <label><font face="Arial, Helvetica, sans-serif"><b>RECIBO RUNT</b></font></label>
               <label></label>
             </span></th>
           </tr>
           <% modelo.Tramite tramite  = model.consultarTramite(formulario.getFk_tramite()) ;%>
           <input type="hidden" name="tramite" id="tramite" value="<%=tramite.getId_tramite()%>">
           <tr style="color:#333333">
             <td align="center"><span class="Estilo5">
               <label><font face="Arial, Helvetica, sans-serif"><b><%=tramite.getId_tramite()%></b></font></label>
             </span></td>
             <td align="center"><span class="Estilo5">
               <label><font face="Arial, Helvetica, sans-serif"><b><%=tramite.getNombre()%></b></font></label>
             </span></td>
             <td align="center"><input name="runt" type="text"  maxlength="18" id="runt" style="text-align:center; color:#006699; font-size:13px" value="<%= formulario.getRunt() %>"  onblur="revisarL(this)"/>
             <input name="runt2" type="text"  maxlength="18" id="runt2" style="text-align:center; color:#006699; font-size:13px" value="<%= formulario.getRunt2()!=null?formulario.getRunt2():"" %>"  onblur="revisarL(this)"/></td>
           </tr>
         </table></td>
       </tr>
       <tr>
         <th colspan="6" scope="col">&nbsp;</th>
       </tr>
       <tr>
         <th colspan="6" scope="col">
             <% if(tramite.getId_tramite()==1||tramite.getId_tramite()==2||tramite.getId_tramite()==4){
                    java.util.List listaRp = model.consultarRadicacionesPropietarios(formulario.getId_formulario());
                    session.setAttribute("editarPropietarios",listaRp);
                    for(int p=0; p < listaRp.size(); p++){
                        Radicacion_Propietario rp = (Radicacion_Propietario)listaRp.get(p);
                        java.util.List listaRa = model.consultarRadicacionesApoderados(rp.getFk_formulario(),rp.getFk_persona());
                        if(listaRa.size()>0)
                            session.setAttribute("editarApoderados"+rp.getFk_persona(), listaRa.get(0));
                    }
                     %>
             <table width="100%" border="0" id="panelPropietarios" style="display:block" align="center" cellpadding="0" cellspacing="0">
             <tr>
               <td width="100%" align="center"><table width="100%" border="0" align="center">
                   <tr>
                     <td width="95%" align="center"><span class="Estilo5">
                       <label><font face="Arial, Helvetica, sans-serif"><b>LISTADO DE PROPIETARIOS DEL VEHICULO</b></font></label>
                     </span></td>
                     <td width="5%" align="center"><span class="Estilo5">
                         <img src="../html/images/adicionar2.png" alt="Nuevo Propietario" width="16" height="16" style="cursor:pointer" onclick="newP()" id="adicionarPropietario"/>
                         </span></td>
                   </tr>
                   <tr>
                     <td colspan="2" valign="top" align="center"><iframe src = "editarRadicacionPropietarios.jsp" id="prop" name="prop" marginwidth="0" height="150" width="775" marginheight="0" scrolling="auto" style="border:none" frameborder="0"></iframe></td>
                   </tr>
               </table></td>
            </tr>
            </table>
            <% }
                if(tramite.getId_tramite()==1||tramite.getId_tramite()==4){
                    java.util.List listaRdv = model.consultarRadicacionesEspecificaciones(formulario.getId_formulario());
                    HashMap mapaEspecificaciones = new HashMap();
                    for(int p=0; p < listaRdv.size(); p++){
                        Radicacion_Dato_Vehiculo rdv = (Radicacion_Dato_Vehiculo)listaRdv.get(p);
                        mapaEspecificaciones.put(rdv.getParametro()+"",rdv.getValor());
                    }
                    session.setAttribute("editarEspecificaciones",mapaEspecificaciones);%>
                    <table width="100%" border="0" id="panelEspecificaciones" align="center">
                       <tr style="background:url(../html/images/inicio_3.jpg)">
                         <th><span class="Estilo5 Estilo13"><font face="Arial">DETALLE DE ESPECIFICACIONES DEL VEHICULO</font></span></th>
                       </tr>
                       <tr>
                         <th><label><font size="2" face="Arial, Helvetica, sans-serif" >&nbsp;</font></label></th>
                       </tr>
                       <tr>
                         <td width="100%" align="center"><iframe src = "editarRadicacionEspecificaciones.jsp" id="espc" name="espc" marginwidth="0" height="150" width="800" marginheight="0" scrolling="auto" style="border:none"></iframe></td>
                       </tr>
              </table>
            <% }
               if(tramite.getId_tramite()==1||tramite.getId_tramite()==4||tramite.getId_tramite()==17||tramite.getId_tramite()==23){ %>
            <table width="100%" border="0" id="panelCaracteristicas" style="display:block">
               <tr style="background:url(../html/images/inicio_3.jpg)">
                 <th colspan="6"><span class="Estilo5 Estilo13"><font face="Arial">CARACTERISTICAS DEL VEHICULO</font></span></th>
               </tr>
               <tr>
                 <th colspan="6"><label><font size="2" face="Arial, Helvetica, sans-serif" >&nbsp;</font></label></th>
               </tr>
               <tr align="left">
                 <td width="12%"><span class="Estilo6"> <span class="Estilo2">
                   <label><font face="Arial, Helvetica, sans-serif"><b>Motor</b></font></label>
                 </span> </span></td>
                 <td width="35%" colspan="2">
               <% String motor = "";
		  if (formulario.getMotor() != null){
                      motor = formulario.getMotor();
		  } %>
                  <input name="motor" type="text" id="motor" style="width:200px;color:#333333; text-align:center" value="<%=motor%>"/></td>
                  <td width="14%"><span class="Estilo6"> <span class="Estilo2">
                  <label><font face="Arial, Helvetica, sans-serif"><b>Chasis</b></font></label>
                  </span> </span></td>
                  <td width="39%" colspan="2">
                  <% String chasis = "";
		  if (formulario.getChasis() != null){
		      chasis = formulario.getChasis();
		  } %>
                  <input name="chasis" type="text" id="chasis" style="width:200px;color:#333333; text-align:center" value="<%=chasis%>"/></td>
               </tr>
               <tr align="left">
                 <td><span class="Estilo2"> <span class="Estilo6">
                   <label><font face="Arial, Helvetica, sans-serif"><b>Serie</b></font></label>
                 </span> </span></td>
                 <td colspan="2">
                 <% String serie = "";
		  if (formulario.getSerie() != null){
		      serie = formulario.getSerie();
		  } %>
                  <input name="serie" type="text" id="serie" style="width:200px;color:#333333; text-align:center" value="<%=serie%>"/></td>
                 <td>Nit Concesionario </td>
                 <td colspan="2"><input name="nitConc" type="text" value="<%=formulario.getObservaciones() %>" id="nitConc"  style="width:200px; color:#333333; text-align:center" onblur="consultaPersona2()"/></td>
               </tr>
			   <tr>
			   <td  align="center" colspan="5"><span class="Estilo61">
			     <input id="nombreConcesionario" name="nombreConcesionario" type="text"  style="width:600px; color:#333333; text-align:center" readonly="readonly"/>
			   </span></td>
			   </tr>
             </table>
            <% }
           if(tramite.getId_tramite()==1||tramite.getId_tramite()==2||tramite.getId_tramite()==3||tramite.getId_tramite()==4||tramite.getId_tramite()==5||tramite.getId_tramite()==7||tramite.getId_tramite()==8||tramite.getId_tramite()==13||tramite.getId_tramite()==15||tramite.getId_tramite()==16||tramite.getId_tramite()==17||tramite.getId_tramite()==18||tramite.getId_tramite()==20||tramite.getId_tramite()==23||tramite.getId_tramite()==24||tramite.getId_tramite()==25||tramite.getId_tramite()==26||tramite.getId_tramite()==27||tramite.getId_tramite()==32){ %>
           <table width="100%" border="0" id="panelRunt" style="display:block" align="center">
      	     <tr style="background:url(../html/images/inicio_3.jpg)">
                 <th colspan="6"><span class="Estilo5 Estilo13"><font face="Arial">INFORMACION ADICIONAL DEL RUNT</font></span></th>
               </tr>
		   	  <tr>
                 <td width="100%" align="center">
                    <table width="100%" border="0" align="center">
                    <%  java.util.List listaRunt = model.consultarRadicacionesTramitesRUNT(formulario.getId_formulario(),tramite.getId_tramite());
                        for(int i=0;i<listaRunt.size();i++){
                            String triple[] = (String[])listaRunt.get(i);
                            triple[2] = triple[2]==null?"":triple[2];
                            String nombreIndice = "";
                            if(triple[0].equals("1")){
                                nombreIndice = model.consultarTablaRUNT(Integer.parseInt(triple[1]));
                            }else{
                                nombreIndice = model.consultarEspecificacionRUNT(Integer.parseInt(triple[1]));
                            }   %>
                            <tr>
                            <td width="60%" align="left">
                               <span class="Estilo2"><label><font face="Arial, Helvetica, sans-serif"><b><%=nombreIndice%></b></font></label></span>					   		</td>
                            <td width="40%" align="left">
                          <span class="Estilo2">
                              <%  if(triple[0].equals("1")){ %>
                                <select name="caracteristica<%=triple[1]%>" id="caracteristica<%=triple[1]%>" style="width:200px;color:#333333; size:12px">
                                  <option value="0"><<--Seleccione Parametro-->></option>
                              <%	java.util.List listaParametrosRunt = model.consultarParametrosRUNT(Integer.parseInt(triple[1]));
                                        for (int j = 0; j < listaParametrosRunt.size(); j++) {

                                           String[] parametro = (String[]) listaParametrosRunt.get(j);%>
                                           <option value="<%=parametro[0]%>" <%=triple[2].equals(parametro[0])?"selected":""%> ><%=parametro[1]%></option>
                                   <%    } %>
                                </select>
                           <% }
                              if(triple[0].equals("2")){ %>
                                 <input name="especificacion<%=triple[1]%>" type="text" id="especificacion<%=triple[1]%>" style="width:200px;color:#333333" value="<%=triple[2]%>"/>
                        <%    }
                              if(triple[0].equals("3")){ %>
                                <select name="especificacion<%=triple[1]%>" id="especificacion<%=triple[1]%>" style="width:200px;color:#333333">
                                  <option value="0"><<--Seleccione Parametro-->></option>
                                  <option value="S" <%=triple[2].equals("S")?"selected":""%>>SI</option>
                                  <option value="N" <%=triple[2].equals("N")?"selected":""%>>NO</option>
                                </select>
                   <%         }
                              if(triple[0].equals("4")){  %>
                                 <input name="boton<%=triple[1]%>" type="button" id="boton<%=triple[1]%>" value="&gt;" style="width:30px"/>
                                 <input type="text" name="especificacion<%=triple[1]%>" id="especificacion<%=triple[1]%>" onkeyup="mascara(this,'/',true)" maxlength="10" style="width:155px;color:#333333; text-align:center" value="<%=triple[2]%>"/>
                                 <script type="text/javascript">
                                        Calendar.setup({
                                                inputField     :    "especificacion<%=triple[1]%>",      // id del campo de texto
                                                ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                                button         :    "boton<%=triple[1]%>"   // el id del bot?n que lanzar? el calendario
                                        });
                                 </script>
                     <%      } %>
                      </span></td>
            </tr>
                      <% } %>
					   <tr>
					  	<td>Ficha Tecnica de Homologacion del Chasis </td>
											  	<td><span class="Estilo2">
											  	  <input type="text" name="fichaT" id="fichaT"  style="width:155px;color:#333333; text-align:center" value="<%=fichaT%>"/>
											  	</span></td>
					  </tr>
					  <tr>
					  	<td>Valor de la Factura </td>
											  	<td><span class="Estilo2">
											  	  <input type="text" name="valorFactura" id="valorFactura"  style="width:155px;color:#333333; text-align:center" value="<%=formulario.getSimit()%>"/>
											  	</span></td>
					  </tr>
                    </table>
                 </td>
               </tr>
             </table>
           <% } %>
           <table width="100%" border="0" id="panelBotones" style="display:block" align="center">
               <tr>
                 <td width="50%" align="center">
                     <input type="button" name="salir" id="salir" value="Cancelar" style="width:150px; display:collapse" onclick="cancelar()"/>
                 </td>
                 <td width="50%" align="center">
                       <input type="submit" name="guardar" id="guardar" value="Guardar" style="width:150px; display:collapse"/>
                 </td>
               </tr>
           </table></th>
       </tr>
     </table>
	 </fieldset>
	</form>	</td>
  </tr>
  <tr>
    <td height="21">&nbsp;</td>
  </tr>
</table>
</body>
<%
	 }catch(Exception exc){
        exc.printStackTrace();
    }    %>
</html>

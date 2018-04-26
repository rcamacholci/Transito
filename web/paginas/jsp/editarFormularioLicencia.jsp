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

    function cancelar(radicacion){
        document.location.href = "radicarLicencia.jsp?radicacionl="+radicacion;
    }
</script>
<style type="text/css">
<!--
.Estilo5 {
	color: #333333;
	font-size: 12px;
}
.Estilo11 {color: #FFFFFF; font-size: 12px; }
.Estilo13 {color: #333333; font-size: 12px; font-family: Tahoma; }
.Estilo14 {
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
	color: #FFFFFF;
}
.Estilo15 {
	font-family: Tahoma;
	font-weight: bold;
	font-size: 12px;
	color: #333333;
}
-->
</style>
</head>
<%  
try {
	Model model = (Model) session.getAttribute("model");
	Radicacion_Licencia radicacionL = model.consultar_RadicacionLicencia(Long.parseLong(request.getParameter("id_radicacionL")));
            if (radicacionL!=null){
                Formulario_Licencia formularioL = model.consultarFormularioLicencia(radicacionL.getId_radicacion_licencia());
                Persona persona = model.consultarPersona(radicacionL.getFk_persona());
                    if(persona!=null){
%>
<body>
<table width="80%" border="0" align="center">
  
  <tr>
    <td height="481" align="center" valign="top">
	<form name="form" id="form" method="post" action="procesarEditarFormularioLicencia.jsp">
            <input type="hidden" name="rad" id="rad" value="<%=request.getParameter("id_radicacionL")%>">
            <input type="hidden" name="formulario" id="formulario" value="<%=formularioL.getIdFormularioLicencia()%>">
 	 <fieldset>
	 
	 <table width="100%" border="0" align="center" id="panelTramites" style="display:block">
      	<tr>
            <td align="center"><span class="Estilo15">EDITAR INFORMACION DE LA RADICACION N°&nbsp;<%=radicacionL.getNumero()%></span></td>
		</tr>
	   <tr>
	   	<td colspan="4" align="center">
		<fieldset>
		<table width="100%" border="0" align="center">
		<tr style="background:url(../html/images/inicio_3.png)">
			<td colspan="4" align="center"><span class="Estilo14">DATOS DEL SOLICITANTE</span></td>
		</tr>
			 <td width="10%" align="center"><span class="Estilo13">
           <label><b>DOCUMENTO</b></label>
         </span></td>
         <td width="17%" align="center">
             <input name="numeroDoc" type="text" id="numeroDoc" value="<%=persona.getDocumento()%>"  readonly  style="width:140px; text-align:center; color:#006699"/></td>
         <td width="11%" align="CENTER"><span class="Estilo13">
           <label><b>NOMBRE</b></label>
         </span></td>
         <td width="37%" align="center">
             <input name="nombre" type="text" id="nombre"  readonly value="<%=persona.getNombre_1()+" "+persona.getApellido_1()%>" style="width:300px; color:#006699"/>         </td>
		</table>
		</fieldset>
		</td>
	   </tr>
	   <tr><td>&nbsp;</td></tr>
              <tr>
         <td colspan="6">
		 
		 <fieldset>
		 <table width="99%" border="0">
           <tr style="background:url(../html/images/inicio_3.png)">
             <th width="12%" scope="col"><span class="Estilo11">
               <label><font face="Arial, Helvetica, sans-serif"><b>ID</b></font></label>
               <label></label>
             </span></th>
             <th width="60%" scope="col"><span class="Estilo11">
               <label><font face="Arial, Helvetica, sans-serif"><b>NOMBRE TRAMITE</b></font></label>
               <label></label>
             </span></th>
             <th width="15%" scope="col"><span class="Estilo11">
               <label><font face="Arial, Helvetica, sans-serif"><b>RECIBO RUNT</b></font></label>
               <label></label>
             </span></th>
			   <th width="20%" scope="col"><span class="Estilo11">
               <label><font face="Arial, Helvetica, sans-serif"><b>CATEGORIA</b></font></label>
               <label></label>
             </span></th>
              <th width="20%" scope="col"><span class="Estilo11">
                      <label><font face="Arial, Helvetica, sans-serif"><b>CATEGORIA&nbsp;ANTERIOR</b></font></label>
               <label></label>
             </span></th>
           </tr>
           <% modelo.Tramite tramite  = model.consultarTramite(formularioL.getFk_tramite()) ;%>
           <input type="hidden" name="tramite" id="tramite" value="">
           <tr style="color:#333333">
             <td align="center"><span class="Estilo5">
               <label><font face="Arial, Helvetica, sans-serif"><b></b></font></label>
               <input name="codigoT" type="text" readonly  maxlength="18" id="codigoT" style="text-align:center; color:#006699; font-size:13px ; width:80px" value="<%=tramite.getId_tramite()%>" />
             </span></td>
             <td align="center"><span class="Estilo5">
               <label><font face="Arial, Helvetica, sans-serif"><b></b></font></label>
               <input name="tramite" type="text"  maxlength="18" id="tramite" style="text-align:center; color:#006699; font-size:13px; width:400px" value="<%=tramite.getNombre()%>"  readonly />
             </span></td>
             <td align="center"><input name="runt" type="text"  maxlength="18" id="runt" style="text-align:center; color:#006699; font-size:13px; width:170px" value="<%=formularioL.getRunt()%>"  onblur="revisarL(this)"/>			 </td>
             <td align="center"><input name="categoria" type="text"  maxlength="18" id="categoria" style="text-align:center; color:#006699; font-size:13px; width:80px" value="<%=formularioL.getCategoria()%>" />			 </td>
           <td align="center"><input name="categoriaA" type="text"  maxlength="18" id="categoriaA" style="text-align:center; color:#006699; font-size:13px; width:80px" value="<%=formularioL.getCategoria_anterior()%>" />			 </td>
           </tr>
         </table>
		 </fieldset>
		 		 </td>
       </tr>
       <tr><td>&nbsp;</td></tr>
       <tr>
         <th colspan="6" scope="col">
           <table width="100%" border="0" id="panelBotones" style="display:block" align="center">
               <tr>
                 <td width="50%" align="center">
                     <input type="button" name="salir" id="salir" value="Cancelar" style="width:150px; display:collapse" onclick="cancelar('<%=radicacionL.getId_radicacion_licencia()%>')"/>                 </td>
                 <td width="50%" align="center">
                       <input type="submit" name="guardar" id="guardar" value="Guardar" style="width:150px; display:collapse"/>                 </td>
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
    }
                }
	 }catch(Exception exc){
        exc.printStackTrace();
    }    %>
</html>

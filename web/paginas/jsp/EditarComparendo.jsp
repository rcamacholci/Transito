<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
            try {
                if (session.getAttribute("model") != null) {
                   // if (((java.util.LinkedList) session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/") + 1, request.getServletPath().length()))) {
                    if(1==1){
                      Model modelo = (Model) session.getAttribute("model");
                        //long num = Long.parseLong(request.getParameter("numero"));
                        String num = "101111";
                        Persona per = new Persona();
                        Parametro parametro = new Parametro();
                        Sede sede = new Sede();
                        Comparendo Ecomp = modelo.consultar_Comparendo(num);
                        
                        if (modelo != null) {
%>
<html>
    <head>
        <title>Adicionar Comparendo</title>
        <style type="text/css">
            .label {font-size: 11px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold ; width:110px}
            .text {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold ; width:120px; text-transform:uppercase}
            .date {font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; width:100px }
            .bdate {font-size: 10px; color:#666666; text-align:left ; font-family:Arial; font-weight:bold; width:20px }
            .select {font-size: 11px; color:#003366; text-align:left ; font-family:Arial; font-weight:bold; width:120px }
            .input { width:130px }
            .check { font-size: 11px; color:#003366; text-align:center ; font-family:Arial; font-weight:bold; }
        </style>
        <link title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
        <script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
        <script t
        ype="text/javascript" src="../html/scripts/adicionarComparendo.js"></script>
        <script type="text/javascript" src="../html/scripts/consultasGenerales.js"></script>
        <script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
        <script type="text/javascript" language="javascript">
            function activarFechaNoti(check){
    document.form.fechanoti.disabled = !check.checked;
    document.form.bfechanoti.disabled = !check.checked;
    document.form.horasnoti.disabled = !check.checked;
    document.form.minutosnoti.disabled = !check.checked;
}

 function Cargarok(){
 //alert("si");
    if(document.form.infraccion.value=="E03"){
 //   alert("E03");
        document.getElementById('alm').style.display = "";
        document.getElementById('alm1').style.display = "";
        document.getElementById('alm2').style.display = "";
        document.getElementById('alm3').style.display = "";
        document.getElementById('alm4').style.display = "";
        document.getElementById('alm5').style.display = "";
        document.getElementById('alm6').style.display = "";
        document.getElementById('alm7').style.display = "";
        document.getElementById('alm8').style.display = "";
        document.getElementById('alm9').style.display = "";
        document.getElementById('alm0').style.display = "";
        document.getElementById('alm01').style.display = "";
        document.getElementById('alm02').style.display = "";
        CargarPub()
       }else{
	document.getElementById('alm').style.display = "none";
        document.getElementById('alm1').style.display = "none";
        document.getElementById('alm2').style.display = "none";
        document.getElementById('alm3').style.display = "none";
        document.getElementById('alm4').style.display = "none";
        document.getElementById('alm5').style.display = "none";
        document.getElementById('alm6').style.display = "none";
        document.getElementById('alm7').style.display = "none";
        document.getElementById('alm8').style.display = "none";
        document.getElementById('alm9').style.display = "none";
        document.getElementById('alm0').style.display = "none";
        document.getElementById('alm01').style.display = "none";
        document.getElementById('alm02').style.display = "none";
        CargarPub()
   //     alert("No E03");
   }
}

 function CargarPub(){
 //alert("si");
    if(document.form.servicio.value=="2"){
 //   alert("E03");
        document.getElementById('pub').style.display  = "";
        document.getElementById('pub1').style.display = "";
        document.getElementById('pub2').style.display = "";
        document.getElementById('pub3').style.display = "none";

       }else{
	document.getElementById('pub').style.display  = "none";
        document.getElementById('pub1').style.display = "none";
        document.getElementById('pub2').style.display = "none";
        document.getElementById('pub3').style.display = "none";
   //     alert("No E03");
   }
}

 function CargarEs(){
// alert("si "+document.form.TP[03].checked);
    if(document.form.TP[03].checked){
//  alert("E03");
        document.getElementById('pub').style.display  = "";
        document.getElementById('pub1').style.display = "";
        document.getElementById('pub2').style.display = "";
        document.getElementById('pub3').style.display = "";

       }else{
	
        document.getElementById('pub3').style.display = "none";

   }
}

     function buscarPropietario(){
        var placaS = document.getElementById('placa').value;        
        ajax2=nuevoAjax();
        ajax2.open("POST", "getPropietario.jsp",true);
        ajax2.onreadystatechange=function() {
                if (ajax2.readyState==4) {
                        var docxml = ajax2.responseXML;
                        var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue
                        if(result =='1'){
                            
                            var pers = docxml.getElementsByTagName('persona')[0].childNodes[0].nodeValue
                            var pers1 = docxml.getElementsByTagName('persona1')[0].childNodes[0].nodeValue                             
                            var Td = docxml.getElementsByTagName('tdocumento')[0].childNodes[0].nodeValue
                            var Doc = docxml.getElementsByTagName('documento')[0].childNodes[0].nodeValue
                            alert(pers1+"-"+Td+"-"+Doc+"")
                            document.form.nombresp.value=pers1;
                            document.form.documentop.value=Doc;
                            document.form.documentop.disabled = true;
                            document.form.tipoDocumentop.value=Td;
                            document.form.tipoDocumentop.disabled = true;
                           //document.getElementById("propietario").value = pers
                           //document.getElementById("documentop").value = Doc
                           // document.form.documentop.readonly=true;
                           // document.getElementById("nombresp").value = pers1
                           // document.tipodocumentop.Td.check




                        }else{
                            if(result == '2'){
                                alert("No existe informacion del Propietario");
                                 document.getElementById("propietario").value = "";
                            }else{
                                alert("Vehiculo no Registrado en la Base de Datos");
                                 document.getElementById("propietario").value = "";
                            }
                        }
                }
        }
        ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        ajax2.send("placa="+placaS);
	}

function consultaPersonaP(id_tipoDoc,id_Documento,id_input_set){
    var tipo = document.getElementById(id_tipoDoc);
    var documento = document.getElementById(id_Documento) ;
    if(documento.value.length>0){
        var ajax= new nuevoAjax();
        ajax.open("POST", "getPersona2.jsp",true);
        ajax.onreadystatechange=function() {
            if (ajax.readyState==4 && ajax.status == 200) {
                var docxml = ajax.responseXML
                var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue
                if(result == 'si'){
                    var nombres = docxml.getElementsByTagName('nombre1')[0].childNodes[0].nodeValue +' '+(docxml.getElementsByTagName('nombre2')[0].childNodes[0].nodeValue!='null'?docxml.getElementsByTagName('nombre2')[0].childNodes[0].nodeValue:'')
                    var apellidos = docxml.getElementsByTagName('apellido1')[0].childNodes[0].nodeValue + ' '+(docxml.getElementsByTagName('apellido2')[0].childNodes[0].nodeValue!='null'?docxml.getElementsByTagName('apellido2')[0].childNodes[0].nodeValue:'')
                    document.getElementById(id_input_set).value=nombres+' '+apellidos
                }else{
                    viewPersona(tipo.value,documento.value);
                    document.getElementById(id_input_set).value=''
                }
            }
        }
        ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
        ajax.send("documento="+documento.value+"&tipo="+tipo.value);
    }
}


function Alcoholemia(){
    var gl1 = document.form.GL1.value;
    var gl2 = document.form.GL2.value;

    var alc1 = (gl1*4.8*0.8)/100;
    var alc2 = (gl2*4.8*0.8)/100;
    var alc = (alc1+alc2)/2;
    document.form.GA.value=alc;
}

function CargarFisico(){
    ancho = 500;
    alto = 250;
    barra = 0;
    izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
    arriba = (screen.height) ? (screen.height-alto)/2 : 100;
    opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars='+barra+',resizable=0,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
    url = "CargarFisico.jsp?comparendo="+document.form.comparendo.value;
    window.open(url, 'popUp', opciones);
}
        </script>


    </head>
    <body>
        <div align="center">
            <div align="center" style="width:560px">
                <form name="form" method="post" action="javascript:validarFormulario()">
                   
                    <fieldset> 
                        <legend></legend>
                        <input type="hidden" name="filename" value="okok.pdf" />
                        <input type="hidden" name="compAnt" id="compAnt" value="<%=Ecomp.getId_comparendo()%>" />
                        <table border="0" align="center" width="550px" cellpadding="1" cellspacing="1">
                            <tr>
                                <td align="center"><div class="text">INGRESO&nbsp;DE&nbsp;COMPARENDOS</div></td>
                            </tr>
                            <tr>
                                <td>&nbsp;</td>
                            </tr>
                            <tr>
                              <td>

                                    <table border="0" align="center" width="550px" cellpadding="1" cellspacing="2" style="border:none">
                                        <tr>
                                            <td class="label"># Comparendo</td>
                                            <td class="input"><input name="comparendo" autocomplete="off"  type="text" class="text" value="<%=Ecomp.getNumero()%>"/></td>
                                            <td>&nbsp;</td>
                                            <td class="label" colspan="2">Si el comparendo posee los numeros 9999999900000, debe ingresarlos!</td>
                                        </tr>
                                        <tr>
                                            <td class="label">Fecha</td>
                                            <td class="input"><input type="text"  name="fecha" id="fecha" class="date"  style="background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onKeyUp="mascara(this,'/',true)" maxlength="10" />
<button name="bfecha" type="button" id="bfecha" class="bdate" ><img src="../html/images/calendario.png" width="19" height="18"/></button>
                                          <!--      <input name="bfecha" type="button" id="bfecha" class="bdate" value="<<"/> -->
                                                <script type="text/javascript">
                                                    Calendar.setup({
                                                        inputField     :    "fecha",      // id del campo de texto
                                                        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                                        button         :    "bfecha"   // el id del botón que lanzará el calendario
                                                    });
                                                </script>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Hora&nbsp;<label class="label" style="font-size:9px; color:#003366">(hh:mm)</label></td>
                                            <td class="input">
                                                <select name="horas" class="select" style="width:45px">
                                                    <option>< - ></option>
                                                    <% for (int m = 0; m < 24; m++) {%>
                                                    <option><%=m%></option>
                                                    <% }%>
                                                </select>
                                                <select name="minutos" class="select" style="width:45px">
                                                    <option>< - ></option>
                                                    <% for (int s = 0; s < 60; s=s+10) {%>
                                                    <option><%=s%></option>
                                                    <% }%>
                                                </select>                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">Lugar</td>
                                            <td colspan="4">                        <select id="vias" name="vias" style="width:130px;text-align:center" class="select">
                                                                                    <%
                                                                                    java.util.List<Vias> Vi = modelo.listarVias();
                                                                                    for(int i=0;i<Vi.size();i++){
                                                                                        Vias temp = Vi.get(i);
                                                                                            if(temp.getId_Via()==Ecomp.getfk_via()){
                                                                                                %>
                                                                                                <option value="<%=temp.getId_Via()%>"><%=temp.getNombre()%></option>
                                                                                                <%
                                                                                            }else{
                                                                                                %>
                                                                                                <option value="<%=temp.getId_Via()%>"><%=temp.getNombre()%></option>
                                                                                                <%
                                                                                            }
                                                                                     %>
                                                                                     
                                                                                    <%}%>

										  </select>
										  <input name="lugar" autocomplete="off" type="text" onKeyPress="javascript: return BloquearComa(event)" class="text" style="width:290px"/></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Placa</td>
                                            <td class="input"><input name="placa" id="placa" type="text" onKeyPress="javascript: return BloquearComa(event)" maxlength="6"  class="text" onBlur="buscarPlaca(this)" value="<%=Ecomp.getPlaca()%>"/>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Licencia Transito</td>
                                            <td class="input"><input name="licenciaTransito" id="licenciaTransito" type="text"  class="text" onKeyPress="return soloNumeros(event)" onClick="buscarPropietario()"/></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Clase Vehiculo </td>
                                            <td class="input"><select name="clase" class="select">
                                                    <option value="0" ><-Seleccione-></option>
                                                    <% List list = modelo.listadoParametros(1);
                            Iterator it = list.iterator();
                            while (it.hasNext()) {
                                parametro = (Parametro) it.next();%>
                                                    <option value="<%=parametro.getCodigo()%>"> <%=parametro.getNombre()%> </option>
                                                    <%}%>
                                                </select>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Servicio Vehiculo</td>
                                            <td class="input"><select name="servicio" class="select" id="servicio" onBlur="CargarPub()">
                                                    <option value="0" ><-Seleccione-></option>
                                                    <%  List listServicio = modelo.listadoParametros(3);
                            Iterator itr = listServicio.iterator();
                            while (itr.hasNext()) {
                                parametro = (Parametro) itr.next();%>
                                                    <option value="<%=parametro.getCodigo()%>"> <%=parametro.getNombre()%> </option>
                                                    <%}%>
                                                </select>                                            </td>
                                        </tr>
                                        <tr id="pub">
    <td colspan="2" class="label">Radio De Accion</td>
    <td  class="check">Municipal&nbsp;
      <input type="radio" id="RA" name="RA" value="1" checked="checked"/></td>
    <td  class="check">Nacional&nbsp;&nbsp;
       <input type="radio" id="RA" name="RA" value="2" /></td>
		<td colspan="1">&nbsp;</td>
                                  
                                        </tr>
                                        <tr id="pub1">
      <td colspan="2" class="label">Modalidad De Transporte</td>
    <td  class="check">Pasajero&nbsp;
      <input type="radio" id="MT" name="MT" value="1" checked="checked"/></td>
    <td  class="check">Mixto&nbsp;&nbsp;&nbsp;
      <input type="radio" id="MT" name="MT" value="2" /></td>
         <td  class="check">Carga&nbsp;
           <input type="radio" id="MT" name="MT" value="3" /></td>
		<td colspan="2">&nbsp;</td>
                                  
                                        </tr>

<tr id="pub2">
    <td colspan="1" class="label">Transporte de Pasajeros</td>
    <td  class="check">Colectivo&nbsp;
      <input type="radio" id="TP" name="TP" value="1" checked="checked" onClick="CargarEs()" /></td>
    <td  class="check">Individual&nbsp;
      <input type="radio" id="TP" name="TP" value="2" onClick="CargarEs()"  /></td>

            <td  class="check">Pasajeros&nbsp;
              <input type="radio" id="TP" name="TP" value="3" onClick="CargarEs()"  /></td>

            <td  class="check">Especial&nbsp;
                <input type="radio" id="TP" name="TP" value="4" onClick="CargarEs()" /></td>
		<td colspan="1">&nbsp;</td>
                                  
                                        </tr>
<tr id="pub3">
    <td colspan="1" class="label">Especial</td>
    <td  class="check">Escolar&nbsp;
      <input type="radio" id="ES" name="ES" value="41" checked="checked"/></td>
    <td  class="check">Asalariado&nbsp;
      <input type="radio" id="ES" name="ES" value="42" /></td>

            <td  class="check">De Turismo&nbsp;
              <input type="radio" id="ES" name="ES" value="43" /></td>

            <td  class="check">Ocasional&nbsp;
              <input type="radio" id="ES" name="ES" value="44" /></td>
		<td colspan="1">&nbsp;</td>                                
                                      </tr>
                                        <tr>
                                            <td colspan="5" align="center">
                                                <label style="font-size:9px; text-align:center; color:#FFFFFF">---------------------------------------------------------------</label></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Tipo Documento </td>
                                            <td class="input"><select name="tipoDocumento" id="tipoDocumento" class="select" onChange="consultaPersona(this.id, 'documento', 'nombres')">
                                                    <% 
                                                    
                                                    per = modelo.consultarPersona(Ecomp.getFk_persona());

                            List lista_id = modelo.listadoParametros(5);
                            Iterator itrtor = lista_id.iterator();
                            while (itrtor.hasNext()) {
                                parametro = (Parametro) itrtor.next();  
                                                if(parametro.getCodigo()==per.getTipo_documento()){
                                                    %>
                                                    <option selected value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                                    <%
                                                }else{
                                                    %>
                                                    <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                                    <%
                                                }
                                               }%>
                                                </select>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Numero Documento</td>
                                            <td class="input"><input name="documento" type="text" id="documento" value="<%=per.getDocumento()%>" class="text" onKeyPress="return soloNumeros(event)" onBlur="consultaPersona('tipoDocumento', this.id, 'nombres');buscarLicenciaConduccion()"/>                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">Nombre y Apellido </td>
                                            <td colspan="4"><input name="nombres" type="text" id="nombres" class="text" style="width:420px" readonly/></td>
                                        </tr>
                                        <tr>
                                            <td class="label">Tipo Infractor </td>
                                            <td class="input"><select name="tipoInfractor" id="tipoInfractor" class="select">
                                                    <% List L_tipo_inf = modelo.listadoParametros(6);
                            Iterator itt = L_tipo_inf.iterator();
                            while (itt.hasNext()) {
                                parametro = (Parametro) itt.next();%>
                                                    <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                                    <%}%>
                                                </select>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Numero Codigo</td>
                                            <td class="input">
                                                <input name="infraccion" id="infraccion" type="text" class="date" readonly/>
                                                <input name="button" type="button" id="binfraccion" class="bdate" value="<<" onClick="listaInfraccion()" onBlur="Cargarok()"/>
                                               </td>
                                        </tr>
                                        <tr>
                                            <td class="label">Nombre Infraccion </td>
                                            <td colspan="4"><textarea rows="5" name="nombreInfraccion" type="text" class="text" readonly style="font-size:11px; width:420px; height:50px"></textarea>                                            </td>
                                        </tr>
                                        <tr id="alm" style="dysplay:none">
										<td class="label">Nivel De Alcolimetria</td>
										<td colspan="5" class="select">
										    <select name="Alm" class="select" id="Alm" >
											<option value="1" selected="selected">1</option>
											<option value="2">2</option>
											<option value="3">3</option>
											<option value="4">4</option>
											<option value="5">5</option>
											<option value="6">6</option>
											<option value="7">7</option>
											<option value="8">8</option>
											<option value="9">9</option>
											<option value="10">10</option>
											<option value="11">11</option>
											<option value="12">12</option>											
										  </select></td>
										</tr>
 <tr id="alm1">
  <td colspan="2">&nbsp;</td>
  <td class="text" align="center">si</td>
  <td class="text" align="center">no</td>
  	<td colspan="2">&nbsp;</td>
  </tr>								<!--/////////////////////////////////-->
 <tr id="alm2">
    <td colspan="2" class="label">&nbsp;Prueba de alcolemia</td>
    <td  class="check">&nbsp;<input type="radio" id="C1" name="C1" value="si" checked="checked"/></td>
    <td  class="check">&nbsp;<input type="radio" id="C1" name="C1" value="no" /></td>
		<td colspan="2">&nbsp;</td>
    </tr>

  <tr id="alm3">
    <td colspan="2" class="label">&nbsp;Detencion preventiva de licencia </td>
    <td  class="check">&nbsp;<input type="radio" id="C2" name="C2" value="si" checked/></td>
    <td  class="check">&nbsp;<input type="radio" id="C2" name="C2" value="no" /></td>
		<td colspan="2">&nbsp;</td>
  </tr>
    <tr id="alm4">
    <td colspan="2" class="label">&nbsp;Acta de Consentimiento</td>
    <td  class="check">&nbsp;<input type="radio" id="C3" name="C3" value="si" checked/></td>
    <td  class="check">&nbsp;<input type="radio" id="C3" name="C3" value="no" /></td>
		<td colspan="2">&nbsp;</td>
  </tr >
    <tr id="alm5">
    <td colspan="6">&nbsp;</td>
  </tr>
  <tr id="alm6">
    <td colspan="2"  class="label">&nbsp;Colilla prueba n&deg; 1 </td>
    <td  class="text">&nbsp;<input type="text" id="C4" name="C4" maxlength="10" style="width:70px"/></td>
    <td  class="label">&nbsp;G/L</td>
		<td colspan="2"><span class="text">
		  <input type="text" id="GL1" name="GL1" maxlength="4" style="width:50px"/>
		</span></td>
  </tr>
  <tr id="alm7">
    <td colspan="2" class="label">&nbsp;Colilla prueba n&deg; 2 </td>
    <td  class="text">&nbsp;<input type="text" id="C5" name="C5" maxlength="10" style="width:70px"/></td>
    <td  class="label">&nbsp;G/L</td>
		<td colspan="2"><span class="text">
                        <input type="text" id="GL2" name="GL2" maxlength="4" style="width:50px" onBlur="Alcoholemia()"/>
		</span></td>
  </tr>
  <tr id="alm8">
    <td colspan="6">&nbsp;</td>
  </tr>

  <tr id="alm9">
   <td colspan="2"  class="label">&nbsp;Grado de alcolemia </td>
   <td>&nbsp;<input type="text" id="GA" name="GA" readonly/></td>
    <td>&nbsp;</td>
		<td colspan="2">&nbsp;</td>
  </tr>
  <tr id="alm0">
    <td colspan="6">&nbsp;</td>
     </tr>
  <tr id="alm01">
    <td colspan="2"  class="label">&nbsp;Tiempo de suspencion licencia </td>
    <td>&nbsp;</td>
    <td  class="text">&nbsp;Meses</td>
		<td colspan="2">&nbsp;</td>
  </tr>
  <tr id="alm02">
  	<td colspan="6">&nbsp;</td>
  </tr>
									<!--/////////////////////////////////-->
                                        <tr>
                                            <td class="label">Lic.Conduccion</td>
                                            <td class="input"><input name="licenciaConduccion" type="text" id="lic_conduccion" class="text" onKeyPress="return soloNumeros(event)"/></td>
                                            <td>&nbsp;</td>
                                            <td class="label">Fecha Vencimiento </td>
                                            <td class="input"><input name="fechaVencimiento" type="text" id="fechaVencimiento" class="date" style="background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onKeyUp="mascara(this,'/',true)" maxlength="10"/>
                                                <input name="button" type="button" id="bfechaVencimiento" class="bdate" value="<<"/>
                                                <script type="text/javascript">
                                                    Calendar.setup({
                                                        inputField     :    "fechaVencimiento",      // id del campo de texto
                                                        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                                        button         :    "bfechaVencimiento"   // el id del botón que lanzará el calendario
                                                    });
                                                </script>                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">Categoria</td>
                                            <td class="input"><select name="categoria" id="categoria" class="select">
                                                    <option value="0" ><<--Seleccione-->></option>
                                                    <% java.util.List categorias = modelo.listadoParametros(221);
                            for (int i = 0; i < categorias.size(); i++) {
                                parametro = (Parametro) categorias.get(i);%>
                                                    <option value="<%=parametro.getNombre()%>"><%= parametro.getNombreCorto()%> </option>
                                                    <%  }%>
                                                </select>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Sede Expedicion </td>
                                            <td class="input"><select name="sedeExpedicion" id="sedeExpedicion" class="select">
                                                    <option value="0" ><<--Seleccione-->></option>
                                                    <%  List sedes = modelo.consultarSedes();
                            itt = sedes.iterator();
                            while (itt.hasNext()) {
                                sede = (Sede) itt.next();%>
                                                    <option value="<%=sede.getId_sede()%>"><%=sede.getCodigo() + " - " + sede.getNombre_corto()%></option>
                                                    <%}%>
                                                </select>                                            </td>
                                        </tr>
<tr>
                               <td align="center" colspan="5"><div class="text">Datos&nbsp;Del&nbsp;Pripietario</div></td>
                                                    </tr><tr>
                                            <td class="label">Tipo Documento </td>
                                            <td class="input"><select name="tipoDocumentop" id="tipoDocumentop" class="select" onChange="consultaPersonaP(this.id, 'documentop', 'nombresp')">
                            <%  List lista_id1 = modelo.listadoParametros(5);
                            Iterator itrtor1 = lista_id1.iterator();
                            while (itrtor1.hasNext()) {
                                parametro = (Parametro) itrtor1.next();%>
                                                    <option value="<%=parametro.getCodigo() + ""%>"><%=parametro.getNombre()%></option>
                                                    <%  }%>
                                                </select>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Numero Documento</td>
                                            <td class="input"><input name="documentop" type="text" id="documentop" class="text"  onKeyPress="return soloNumeros(event)" onBlur="consultaPersonaP('tipoDocumentop', this.id, 'nombresp');buscarLicenciaConduccion()"/>                                            </td>
                                        </tr>
                                        <tr>
                                            <td class="label">Nombre y Apellido </td>
                                            <td colspan="4"><input name="nombresp" type="text" id="nombresp" class="text" style="width:420px" readonly/></td>
                                        </tr>
                                        <tr>
                                            <td colspan="5" align="center">
                                                <label style="font-size:9px; text-align:center; color:#FFFFFF">---------------------------------------------------------------</label></td>
                                        </tr>
                                        <tr>
                                            <td colspan="5">
                                                <table width="100%" border="0" cellspacing="1" cellpadding="1">
                                                
                                                    <tr>
                                                        <td class="label">Placa Agente </td>
                                                        <%
                                                            Agente ag = modelo.consultar_Agente_PorId(Ecomp.getFk_agente());
                                                        %>
                                                        <td><input type="text" name="placaAgente" value="<%=ag.getPlaca()%>" onKeyPress="return soloNumeros(event)" onBlur="buscarAgente(this)" class="text"/></td>
                                                        <td colspan="3"><input name="nombreAgente" type="text" class="text" readonly autocomplete="off" style="width:300px"/></td>
                                                    </tr>
                                                    <tr>
                                                        <td width="20%" align="center" class="check"> Accidente
                                                            <input name="accidente" type="checkbox" id="accidente" value="1" />                                                        </td>
                                                        <td width="20%" align="center" class="check"> Inmovilizacion
                                                            <input name="inmovilizacion" type="checkbox" id="inmovilizacion" value="1" onClick="activarParqueadero(this)" />                                                        </td>
                                                        <td width="20%" align="center" class="check"> Fuga
                                                            <input name="fuga" type="checkbox"  value="1" id="fuga" />                                                        </td>
                                                        <td width="20%" align="center" class="check">Polca
                                                            <input name="polca" type="checkbox" id="polca" value="1" checked/>                                                        </td>
                                                        <td width="20%" align="center" class="check">Firmado
                                                            <input name="firma" type="checkbox" id="firma" value="1" checked/>
                                                        <td width="20%" align="center" class="check">Electronico
    <input name="electronico" type="checkbox"  value="SI" id="electronico" onClick="activarFechaNoti(this)"/>                                                                                               </tr>
                                                </table></td>
                                        </tr>
										<tr>
                                            <td class="label">Fecha&nbsp;Notificacion</td>
                                            <td class="input"><input type="text" disabled name="fechanoti" id="fechanoti" class="date"  style="background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onKeyUp="mascara(this,'/',true)" maxlength="10" />
<button name="bfechanoti" type="button" id="bfechanoti" disabled class="bdate" ><img src="../html/images/calendario.png" width="19" height="18"/></button>
                                          <!--      <input name="bfecha" type="button" id="bfecha" class="bdate" value="<<"/> -->
                                                <script type="text/javascript">
                                                    Calendar.setup({
                                                        inputField     :    "fechanoti",      // id del campo de texto
                                                        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
                                                        button         :    "bfechanoti"   // el id del botón que lanzará el calendario
                                                    });
                                                </script>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label">Hora&nbsp;<label class="label" style="font-size:9px; color:#003366">(hh:mm)</label></td>
                                            <td class="input">
                                                <select name="horasnoti" class="select" disabled style="width:45px">
                                                    <option>< - ></option>
                                                    <% for (int m = 0; m < 24; m++) {%>
                                                    <option><%=m%></option>
                                                    <% }%>
                                                </select>
                                                <select name="minutosnoti" class="select" disabled style="width:45px">
                                                    <option>< - ></option>
                                                    <% for (int s = 0; s < 60; s=s+10) {%>
                                                    <option><%=s%></option>
                                                    <% }%>
                                                </select>                                            </td>
                                        </tr>												   <tr>
		   	<td colspan="5" align="center" class="label">CARGAR IMAGEN COMPARENDO FISICO&nbsp;&nbsp;&nbsp;<input name="button" type="button" id="binfraccion" class="bdate" value="<<" onClick="CargarFisico()"/></td>

                        
		   </tr>
                                        <tr>
                                            <td class="label">Parqueadero</td>
                                            <td colspan="4">
                                                <select id="parqueaderos" name="parqueaderos" class="select" disabled style="width:420px" >
                                                   <option value="0" ><- Seleccione Parqueadero -></option>
                                                    <% sede = (Sede) session.getAttribute("sede");
                                                       java.util.List listaP = listaP = modelo.listarPatios(sede.getId_sede());
                                                       for (int i = 0; i < listaP.size(); i++) {
                                                           Patio patio = (Patio) listaP.get(i);%>
                                                           <option  value="<%=patio.getId_patio()%>"><%=patio.getNombre()%></option>
                                                    <% }%>
                                                </select>                                            </td>
                                        </tr>
<tr>
                                            <td class="label">Patio No</td>
                                            <td class="input"><input name="Npatio" id="Npatio" type="text" onKeyPress="javascript: return BloquearComa(event)" maxlength="6"  class="text" onBlur="buscarPlaca(this)"/>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label" colspan="1">Direccion<span class="input">                                              
                                            </span></td>
                                            <td class="input"><input name="Dpatio" id="Dpatio" type="text"  class="text" /></td>
                                      </tr>
                                        <tr>
                                            <td class="label">Grua No</td>
                                            <td class="input"><input type="text" id="GruaN" name="GruaN"></td>
                                            <td>&nbsp;</td>
                                            <td class="label">Placa Grua</td>
                                            <td class="input"><input type="text" id="Gplaca" name="Gplaca"></td>
                                        </tr>
<tr>
                                            <td class="label">Consecutivo No</td>
                                            <td class="input"><input name="Npatio" id="Npatio" type="text" onKeyPress="javascript: return BloquearComa(event)" maxlength="6"  class="text" onBlur="buscarPlaca(this)"/>                                            </td>
                                            <td>&nbsp;</td>
                                            <td class="label" colspan="1"><span class="input">                                              
                                            </span></td>
                                            <td class="input">&nbsp;</td>
                                      </tr>
                                        <tr>
                                            <td class="label"> Observaciones</td>
                                            <td colspan="4"><input name="observaciones" onKeyPress="javascript: return BloquearComa(event)" type="text" id="observaciones" class="text" style="width:420px"/></td>
                                        </tr>
                                    </table></td>
                            </tr>
                            <tr>
                                <td colspan="5" align="center">
<button type="submit" name="guardar" id="guardar" class="check">Guardar Comparendo <img src="../html/images/guardar.png" width="19" height="18"/></button>
                            <!--        <input type="submit" name="guardar" id="guardar" class="check" disabled value="Guardar Comparendo" />  -->
                                    <iframe src="#" name="proceso" id="proceso" style="display:none"></iframe>
                                </td>
                            </tr>
                        </table>
                    </fieldset>
                </form>
            </div>
        </div>
    </body>
</html>
<%   }
                    } else {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="1"></jsp:param>
</jsp:forward>
<% }
                } else {%>
<script>
    window.parent.document.location.href = "../../index.jsp";
</script>  <%            }
            } catch (Exception mexe) {%>
<jsp:forward page="no_access.jsp">
    <jsp:param name="tipo" value="2"></jsp:param>
    <jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param>
</jsp:forward>
<%  }%>


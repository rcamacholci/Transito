<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Vehiculo" import="modelo.Sede"  import="modelo.Tramite" errorPage="" %>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
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
        <script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
 <script type="text/javascript" src="../html/scripts/consultasGenerales.js"></script>
<script language="javascript" type="text/javascript">

function consultaPersona(id_tipoDoc,id_Documento,id_input_set){
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

 function revisarL(lq){
            lq.style.color = "#FF0000";
            lq.value = 'A'+lq.value;
 }

function viewPersona(tipo,numero){
    if(!isNaN(numero)){
        ancho = 689;
        alto = 250;
        barra = 0;
        izquierda = (screen.width) ? (screen.width-ancho)/2 : 100;
        arriba = (screen.height) ? (screen.height-alto)/2 : 100;
        opciones = 'toolbar=0,location=0,directories=0,status=0,menubar=0,scrollbars='+barra+',resizable=0,width='+ancho+',height='+alto+',left='+izquierda+',top='+ arriba;
        url = "adicionarPersona.jsp?tipo="+tipo+"&documento="+numero;
        window.open(url, 'popUp', opciones);
    }
}
function revisar(){
	if(document.getElementById("numero").value.length>0){
		if(document.getElementById("fecha").value.length>0){
			if(document.getElementById("municipio").value.length>0){
                               
                                    document.form.submit();
                              

			}else{
				alert("seleccione un municip[io");
			}
		}else{
			alert("Seleccione fecha del titulo valor");
		}
	}else{
		alert("Digite el numero del titulo valor");
	}
}


  
  
  
  function ver(){

                    if(document.form.busqueda[0].checked){
			document.form.busqueda.value = '1';
                      //  alert("value : "+document.form.busqueda.value);
                    }else{
                        if(document.form.busqueda[1].checked){
                           document.form.busqueda.value = '2';
                         //  alert("value : "+document.form.busqueda.value);
                        }else{
                            if(document.form.busqueda[2].checked){
                                document.form.busqueda.value = '3';
                              //  alert("value : "+document.form.busqueda.value);
                            }else{
                                if(document.form.busqueda[3].checked){
                                    document.form.busqueda.value = '4';
                                   // alert("value : "+document.form.busqueda.value);
                                }else{
                                    if(document.form.busqueda[4].checked){
                                        document.form.busqueda.value = '5';
                                     //   alert("value : "+document.form.busqueda.value);
                                    }
                                }//
                           }
                       }
                  }
              }

        function ver2(){
              if(document.form.confirmacion[0].checked){
        		document.form.confirmacion.value = 'TELEFONICA';
                        alert("value : "+document.form.confirmacion.value);
              }else{
                        if(document.form.confirmacion[1].checked){
                           document.form.confirmacion.value = 'PERSONAL';
                           alert("value : "+document.form.confirmacion.value);
                        }
              }
        }

  function buscarMunicipios(){
		tabla = document.getElementById('municipios');
		document.getElementById('municipio').style.display = 'none';
		valor=document.form.departamentos.options[document.form.departamentos.selectedIndex].value;
		ajax=nuevoAjax();
		ajax.open("POST", "cargarMunicipiosActa.jsp",true);
		ajax.onreadystatechange=function() {
			if (ajax.readyState==4) {
				tabla.innerHTML = ajax.responseText
			}
		}
		ajax.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
		ajax.send("fk_dpto="+valor)

	}

</script>
<style type="text/css">
<!--
.Estilo12 {
	font-size: 14px;
	font-weight: bold;
}
.Estilo15 {
	font-family: Tahoma;
	font-weight: bold;
	font-size: 12px;
	color: #FFFFFF;
}
.Estilo16 {font-family: Tahoma}
.Estilo26 {
	font-size: 12px;
	color: #FFFFFF;
}
.style2 {font-size: 12px; font-weight: bold; color: #333333; font-family: Tahoma; }
.Estilo32 {font-size: 12px; font-weight: bold; font-family: Tahoma; color: #333333; }
.Estilo33 {font-family: Tahoma; font-size: 12px; color: #333333; }
.Estilo34 {font-size: 12px}
.Estilo38 {font-size: 9px}
.style1 {font-size: 10px}
.style3 {font-size: 10px; font-weight: bold; font-family: Tahoma; color: #333333; }
-->
</style>
</head>

<body>
  <%
Model modelo = (Model) session.getAttribute("model");
String departamentoExpedicion="";
Parametro parametro=new Parametro();
Parametro parametro2=new Parametro();
Parametro parametro3=new Parametro();
%>

<form name="form" id="form" method="post" action="procesarTituloValor.jsp">
<fieldset>
<table width="90%" border="0" align="center">
  <tr>
    <td colspan="6" background="../html/images/inicio_3.png"> <div align="center" class="Estilo15 Estilo26">TITULO VALOR</div></td>
  </tr>
  
  <tr class="style2">
  <td  colspan="2"class="style2">N&deg;</td>
    
		<td colspan=""><span class="Estilo33 Estilo34 Estilo34">
		  <input id="numero" name="numero" type="text" onblur="revisarL(this) " style="text-align:center;font:bold; width:140px; text-transform:uppercase"/>
		</span></td>
		<td>&nbsp;</td>
		<td><span class="subtitulos"><span class="style2">FECHA</span></span></td>
		<td><span class="Estilo32 Estilo34 Estilo34 style1"><span class="Estilo33 Estilo34 Estilo34 style1">
		  <input  id="fecha" name="fecha" style="text-align:center; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333;font:bold; width:110px" onkeyup="mascara(this,'/',true)" maxlength="10" value=""/>
		  <input name="bfecha" type="button" id="bfecha" value="&lt;" style="width:20px" />
		  <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fecha",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "bfecha"   // el id del bot?n que lanzar? el calendario
			});
		 </script>
		</span></span></td>
  </tr>
  <tr>
    <td colspan="2" class="style2">DEPARTAMENTO</td>
    <td>
	 <select name="departamentos" id="departamentos" style="width:140px; font-size:10px; color:#333333"  onchange="buscarMunicipios(); return false" >
                <% List listaDepar_per = modelo.crearListaDpto();

		   Iterator it_dep_per = listaDepar_per.iterator();
                       while (it_dep_per.hasNext()) {
                        	Departamento dpto = (Departamento)it_dep_per.next();
                                if(dpto.getId_departamento()==5){
                                
                %>
                       <option value="<%=dpto.getId_departamento()+""%>" selected="selected"><%=dpto.getNombre()%></option>
                       <%   }
                      
                   }%>
        </select>	</td>
    <td colspan="" class="Estilo32 Estilo34 Estilo34 style1">&nbsp;</td>
    <td><span class="style2">MUNICIPIO</span></td>
    <td colspan=""><div class="Estilo4" id="municipios">
			  <select name="municipio" id="municipio" style="width:140px; font-size:10px; color:#333333">
                <%
			 //if(departamentoExpedicion.length()>0){
                                java.util.List lista = modelo.crearListaMunicipios(5);
				for (int i = 0; i < lista.size(); i++) {
				Municipio municipio = (Municipio) lista.get(i);
                                 if(municipio.getCodigo()==146){
				%>
                                <option value="<%=municipio.getCodigo() + ""%>" selected="selected"><%=municipio.getNombre()%></option>
                     <%         
                                }
                         } %>
              </select>
              </div></td>
  </tr>
  
  
  <tr>
      <td class="subtitulos" colspan="2"><span class="style2">OFICINA&nbsp;PAGADORA</span></td>
      
      <td width="16%" class="Estilo32 Estilo34 Estilo34 style1"><span class="Estilo33 Estilo34 Estilo34 style1">		
          <input name="oficinaP" type="text" id="oficinaP" value="BARRANQUILLA"  readonly style="text-align:center;font:bold; width:140px"/>
      </span></td>
    <td width="3%">&nbsp;</td>
    <td width="14%" class="style2">TITULO&nbsp;JUDICIAL&nbsp;No</td>
    <td width="39%"><input name="tituloJ" type="text" id="tituloJ" style="text-align:center;font:bold; width:140px"/></td>
  </tr>
  
  
  
  <tr>
    <td colspan="2" class="style2">NOMBRE&nbsp;JUZGADO</td>
    
    <td class="Estilo32 Estilo34 Estilo34 style1"><input name="nombreJuz"  value="ITA" readonly type="text" id="nombreJuz" style="text-align:center;font:bold; width:140px"/></td>
    <td>&nbsp;</td>
    <td class="style2">CODIGO&nbsp;JUZGADO</td>
    <td><span class="Estilo32 Estilo34 Estilo34 style1">
      <input name="codigoJuz" type="text" id="codigoJuz" value="80019196055"  readonly style="text-align:center;font:bold; width:140px"/>
    </span></td>
  </tr>
  
  <tr>
    <td colspan="2" class="style2">NOMBRE O RAZON SOCIAL DEL CONSIGNANTE </td>
    <td colspan="5" align="justify"><input name="consignante" type="text" id="consignante" style="text-align:center;font:bold; width:500px"/></td>
  </tr>
  
   <tr>
    <td colspan="2" class="style2">NUMERO&nbsp;DE&nbsp;EXPEDIENTE</td>
    <td><input name="numExp" type="text" id="numExp" style="text-align:center;font:bold; width:140px"/></td>
    <td colspan="" class="Estilo32 Estilo34 Estilo34 style1">&nbsp;</td>
    <td><span class="style2">VALOR $ </span></td>
	<td><input name="valor" type="text" id="valor" style="text-align:center;font:bold; width:140px"/></td>
  </tr>
   <tr>
    <td colspan="2" class="style2">CLASE DE DEPOSITO Y CONCEPTO </td>
    <td colspan="5"><input name="claseDeposito"  type="text" id="claseDeposito" style="text-align:center;font:bold; height:30px;width:500px" value="JUDICIALES - AUTOR. POLICIA / ENTE COACTIVOS"  readonly/></td>
  </tr>
  <tr><td colspan="6">&nbsp;</td></tr>
</table> 

  
 <fieldset style="width:auto" >
	<table width="90%" align="center">
      <tr>
        <td width="9%" class="style2"><strong>TIPO DOC.  </strong></td>
        <td width="20%" class="Estilo33"><strong>
          <select name="tipo_docDt" id="tipo_docDt" style="width:150px; font-size:10px" onchange="consultaPersona(this.id, 'documentoDt', 'nombreDt') ">
            <% 
             List lista_id3 = modelo.listadoParametros(5);
             Iterator itrtor3 = lista_id3.iterator();
             while (itrtor3.hasNext()) {
                       parametro3 = (Parametro)itrtor3.next();
                       if(parametro3.getCodigo()==2){
                           %>
                           <option value="<%=parametro3.getCodigo()+""%>" selected="selected"><%=parametro3.getNombre()%></option>
            <%          }
              }%>
          </select>
        </strong>
        </td>
        <td width="8%" class="style2">NUMERO</td>
        <td width="16%" class="Estilo33"><input name="documentoDt" type="text"  value="8190046467" id="documentoDt" style="width:120px;text-align:center"  onblur="consultaPersona('tipo_docDt', this.id, 'nombreDt')"/></td>
        <td width="11%" class="style2">DEMANDANTE</td>
        <td width="36%" class="Estilo33"><input name="nombreDt" type="text" id="nombreDt" style="text-align:center;font:bold; width:280px"/></td>
      </tr>
	   <tr>
          <td width="9%" class="style2"><strong>TIPO  DOC. </strong></td>
          <td width="20%" class="style2"><strong>
            <select name="tipo_docDo" id="tipo_docDo" style="width:150px; font-size:10px" onchange="consultaPersona(this.id, 'documentoDo', 'nombreDo') ">
              <% 
					 List lista_id2 = modelo.listadoParametros(5);
					 Iterator itrtor2 = lista_id2.iterator();
					 while (itrtor2.hasNext()) {
						   parametro2 = (Parametro)itrtor2.next();%>
              <option value="<%=parametro2.getCodigo()+""%>"><%=parametro2.getNombre()%></option>
              <%}%>
            </select>
          </strong></td>
          <td width="8%" class="style2">NUMERO</td>
          <td width="16%" class="Estilo33"><input name="documentoDo" type="text" id="documentoDo" style="width:120px;text-align:center" onblur="consultaPersona('tipo_docDo', this.id, 'nombreDo')"/></td>
          <td width="11%" class="style2">DEMANDADO</td>
          <td width="36%" class="Estilo33"><input name="nombreDo" type="text" id="nombreDo" style="text-align:center;font:bold; width:280px"/></td>
	   </tr>
    </table>
 </fieldset>

  
<table align="center" width="90%" border="0">
<tr><td>&nbsp;</td></tr>
 <tr>
  <td colspan="6" align="center">
<button name="adicionar" type="button" id="adicionar" onclick="revisar()"><span class="style2">Adicionar Titulo Valor </span><img src="../html/images/adicionar.png" width="19" height="18"/></button>
 <!-- <input name="adicionar" type="button" id="adicionar" value="Adicionar Titulo Valor" style="width:150px; text-align:center" onclick="revisar()"/>--></td>
  </tr>
  <tr><td>&nbsp;</td></tr>
</table>
</fieldset>
</form>
</body>
</html>

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" errorPage="" %>

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("GenerarOficioEmbargo.jsp")){

                String placaX = request.getParameter("placa");
                String numOficio = request.getParameter("numOficio");
                                       %>



<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Vehiculo</title>
<style type="text/css">

<!--
.Estilo8 {color: #333333; font-weight: bold; font-size: 12px; }
.Estilo14 {color: #333333; font-size: 12px; }
.style1 {font-family: Tahoma}
.style2 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.Estilo18 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
-->
</style>

<style type="text/css">
<!--

.style5 {color: #333333}
.style6 {
	font-family: Tahoma;
	font-size: 12px;
}
.style7 {font-family: Tahoma}
.style9 {
	color: #333333;
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
}
.style10 {font-family: Tahoma; font-size: 12px; font-weight: bold; }
.Estilo3 {font-size: 10px}
.Estilo4 {font-family: Tahoma; font-size: 10px; font-weight: bold; }
.Estilo6 {color: #333333; font-size: 10px; }
.Estilo7 {color: #333333; font-family: Tahoma; font-size: 10px; font-weight: bold; }





.Estilo13 {color: #FFFFFF; font-weight: bold; }
.Estilo20 {font-size: 11px; font-weight: bold; color: #666666; }
.style4 {color: #FFFFFF; font-weight: bold; font-size: 11px; font-family: Tahoma; }
.style8 {font-size: 11px; font-weight: bold; color: #333333; font-family: Tahoma; }
-->
</style>


<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="../html/scripts/calendar.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript"></script>
<script type="text/javascript" src="../html/scripts/embargos.js"></script>
<script type="text/javascript" src="../html/scripts/motorAjax.js"></script>



<script language="javascript" type="text/javascript">
     setTimeout ("VerSeleccion(i)", 100);

    function mostrarOcultarTablas(embargo, consultarembargos){

        var novedad = document.form.novedad.value;
        elem = document.getElementById(embargo);
        elem1 = document.getElementById(consultarembargos);
        if(novedad==3||novedad==5||novedad==1){
          elem.style.display='block';
          elem1.style.display='none';
        }else{
            if(document.form.placa.value.length >0){
            elem1.style.display='block';
            }else{
            elem1.style.display='none';
            }
            elem.style.display='none';
          }
        }


function VerSeleccion(i, id){
    if (id == null){
    var id_embargo = document.form.radio[i].value;
    document.form.idembargo.value = id_embargo;
    }else{
        document.form.idembargo.value = id;
       }
    }

 function revisar(embargo){

        elem = document.getElementById(embargo);
        var novedad = document.form.novedad.value;

        		if(document.form.numOficio.value.length>0){
                            if(document.form.fechaO.value.length>0){
                              if(document.form.entidad.value.length>0){
                                if(document.form.solicitante.value.length>0){
                                        if(document.form.cargo.value.length >0){
                                                    if(document.form.direccion.value.length >0){
                                                                if(document.form.municipio.value.length >0){
                                                                      if(document.form.placa.value.length >0){
                                                                          if(document.getElementById("novedad").value!=0){
                                                                                if(document.form.numRadicacion.value.length >0){
                                                                                    if(document.form.fechaR.value.length >0){
                                                                                        if(novedad==3||novedad==5||novedad==1){
                                                                                            document.form.proc.value = 1;
                                                                                            if(document.form.demandante.value.length >0){
                                                                                            document.form.submit();
                                                                                            }else{
                                                                                             alert("Digite el demandante");
                                                                                            }
                                                                                            }else{
                                                                                               if (document.form.embargosalevantar.value == "0"){
                                                                                                document.form.NoOficio.value = document.form.NoOficio.value;
                                                                                                document.form.submit();
                                                                                                    }else{
                                                                                                        alert("No existen Oficios a levantar")
                                                                                                    }
                                                                                           }
                                                                                        
                                                                                    }else{
                                                                                        alert("Digite la fecha de Radicacion");
                                                                                    }
                                                                                }else{
                                                                                    alert("Digite el Numero de Radicacion");
                                                                                }
                                                                          }else{
                                                                               alert("Seleccione alguna Novedad");
                                                                          }
                                                                      }else{
                                                                           alert("Digite el Numero de Placa");
                                                                      }
                                                                }else{
                                                                    alert("Digite el municipio del solicitante");
                                                                }
                                                        }else{
                                                            alert("Digite la direccion del solicitante");
                                                        }
                                               
                                        }else{
                                            alert("Digite el cargo del solicitante");
                                        }
                                }else{
                                    alert("Digite el solicitante");
                                }
                              }else{
                                    alert("Digite la entidad");
                                }
			}else{
				alert("Digite la fecha del Oficio");
			}
		}else{
			alert("Digite el numero de oficio");
		}
           }


        
	</script>



<style type="text/css">
<!--
.Estilo21 {color: #333333}
-->
</style>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
Model modelo= (Model)session.getAttribute("model");
modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
Parametro parametro = new Parametro();


if(placaX!=null){
		Vehiculo vehiculo  = new Vehiculo();
                placaX = placaX.toUpperCase();
		vehiculo= modelo.consultarVehiculo(placaX);
                if(vehiculo==null){
%><script>alert("La placa no se encuentra registrada");
document.location.href = "GenerarOficioEmbargo.jsp";
</script>><%
                }
        }


%>

<body onload="mostrarOcultarTablas('embargos','consultarembargos')">
        <form name="form" method="post" action="procesarOficioEmbargo.jsp">
        <input type="hidden" id="proc" name="proc" value="0"/>
        <input type="hidden" id="num" name="num" value="1" />
	<fieldset>
	<table width="90%" border="0" align="center">
	
            

            <tr>
		
		<td width="86%" align="center" class="style2 Estilo21">REGISTRAR SOLICITUD DE OFICIOS DE EMBARGOS O PLEITOS </td>
		</tr>
                <tr>
                    <td colspan="3">&nbsp;</td>
	  			</tr>
               
		
		<tr>
                    <td colspan="3">
				<fieldset class="style1">
				
				
				<table width="100%" border="0" align="center">
					<tr style="border:none; background:url(../html/images/inicio_3.png)">
				<td colspan="6" align="center" valign="middle"><span class="Estilo18">DATOS DEL SOLICITANTE  </span></td>
			</tr>
			<tr><td colspan="4">&nbsp;</td></tr>
			
					<tr>
						<td width="25%"><span class="Estilo8">N&ordm; OFICIO </span></td>
						<td width="25%">
							<span class="Estilo8">
                                                            <input type="hidden" name="NoOficio" id="NoOficio" value="<%=numOficio%>"/>
                                                            <input type="text" readonly name="numOficio"  id="numOficio" value="<%=numOficio%>" style="width:150px; color:#333333; text-align:center"/>
					  </span>					  </td>
						<td width="25%"><span class="Estilo8">FECHA OFICIO </span></td>
    					<td width="25%">
						  <span class="Estilo8">

                                                      <input id="fechaO" name="fechaO" type="text" value="" style=" width:130px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10"/>
					  </span>					  <input name="btfechaO" type="button" id="btfechaO" value="&lt;" style="width:20px; text-align:center"/>
					     <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fechaO",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "btfechaO"   // el id del bot?n que lanzar? el calendario
			});
		 </script>					  </td>
					</tr>
					<tr>
						<td width="16%"><span class="Estilo8">ENTIDAD</span></td>
					    <td colspan="3"><span class="Estilo8">
					  <input name="entidad" id="entidad" type="text"  value="" style=" width:420px;color:#333333; text-align:center"/></span>						</td>
					</tr>
					<tr>
						<td width="16%"><span class="Estilo8">SOLICITANTE</span></td>
					    <td colspan="3"><span class="Estilo8">
					  <input name="solicitante" id="solicitante" type="text"  value="" style=" width:420px;color:#333333; text-align:center"/></span>						</td>
					</tr>

                                            <tr>

                                    <td><span class="Estilo8">DEPARTAMENTO</span></td>
    <td><span class="style10" style="color: #333333">
      <select name="departamento" id="departamento" onchange="buscarMunicipios()" style="width:180px;font-size:12px">
        <% List list= modelo.crearListaDpto();
			Iterator it = list.iterator();
			while (it.hasNext()) {
				Departamento dpto = (Departamento)it.next();%>
        <option value="<%=dpto.getId_departamento()+""%>"><%=dpto.getNombre()%></option>
          <%}%>
      </select>
    </span> </td>
   
    <td><span class="Estilo1 style5 style7"><span class="Estilo8">MUNICIPIO</span></span></td>
    <td><div class="Estilo4" style="width:180px" name="municipios" id="municipios"><span class="style5"></span></div></td>
	<script language="javascript" type="text/javascript">document.getElementById('departamento').selectedIndex = 2;buscarMunicipios()</script>
  </tr>

					<tr>
						<td><span class="Estilo8">CARGO</span></td>
					    <td><span class="Estilo8">	
							<input name="cargo"  id="cargo" type="text"  value="" style=" width:150px;color:#333333; text-align:center" /></span>						</td>
						<td><span class="Estilo8">REFERENCIA</span></td>
					    <td><span class="Estilo14">
							<input name="referencia" id="referencia" type="text"  value="" style=" width:170px;color:#333333; text-align:center"/></span>						</td>
					</tr>
					<tr>
						<td><span class="Estilo8">DIRECCION</span></td>
                                                <td colspan="3"><span class="Estilo8">
					  <input name="direccion" id="direccion" type="text"  value="" style=" width:450px;color:#333333; text-align:center"/></span>						</td>
                                        </tr>
					<tr>
						<td><span class="Estilo8">PLACA</span></td>
					    <td><span class="Estilo8">
                                                    <input name="placa" id="placa" readonly type="text" value="<%=placaX%>"  maxlength="6" style="text-align:center; color:#333333; font:bold; text-transform:uppercase; width:150px;"/>
					    </span></td>
						<td><span class="Estilo8">NOVEDAD</span></td>
					    <td><strong>
                              <select name="novedad" id="novedad" style="width:170px; font-size:11px" onchange="mostrarOcultarTablas('embargos','consultarembargos')" >
                            <% 
                                        List lista_id3 = modelo.listadoParametros(344);
                                        Iterator itrtor3 = lista_id3.iterator();
                                        while (itrtor3.hasNext()) {
                                        parametro = (Parametro)itrtor3.next();
                       
                           %>
                            <option value="<%=parametro.getCodigo()+""%>" selected="selected"><%=parametro.getNombre()%></option>
                            <%        
              }%>
                          </select>
					    </strong></td>					    
					</tr>
				</table>
				</fieldset>          </td>
		</tr>
		<tr><td>&nbsp;</td></tr>
	
		<tr>
			<td colspan="3">
				<fieldset class="style1">

				<table width="100%" border="0" align="center">
				<tr style="border:none; background:url(../html/images/inicio_3.png)">
				<td colspan="6" align="center" valign="middle"><span class="Estilo18">DATOS DE LA RADICACION DEL OFICIO </span></td>
                                </tr>
						<tr><td colspan="4">&nbsp;</td></tr>
				
					<tr>
						<td width="25%"><span class="Estilo8">NUMERO&nbsp;DE&nbsp;RADICACION </span></td>
 					    <td width="23%"><span class="Estilo8">
							<input  name="numRadicacion"type="text"  maxlength="20" value="" style="width:150px;color:#333333;text-align:center"/>
					  </span>						</td>
						<td width="25%"><span class="Estilo8">FECHA&nbsp;DE&nbsp;RADICACION </span></td>
					    <td width="27%"><span class="Estilo8">
							<input  id="fechaR"  name="fechaR" type="text" value="" style="width:130px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; color:#333333;text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10"/>
					  </span>
				      <input name="btfechaR" type="button" id="btfechaR" value="<" style="width:20px; text-align:center"/>
					   <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fechaR",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "btfechaR"   // el id del bot?n que lanzar? el calendario
			});
		 </script>
					  </td>
					</tr>
				</table>
                                    
                                  

                                  
                                    
				</fieldset>
                </td>
                            </tr>
			<tr>
			<td>&nbsp;</td>
			</tr>
<!--Segundo-->
            <tr>
                <td colspan="3">
                        <div id="embargos" style="display: none">
                    <fieldset class="style1">
                               
				<table width="100%" border="0" align="center">
				<tr style="border:none; background:url(../html/images/inicio_3.png)">
				<td colspan="6" align="center" valign="middle"><span class="Estilo18">EMBARGO</span></td>
                                </tr>
                                                            <tr><td colspan="4">&nbsp;</td></tr>
                            
  <tr>
    <td><span class="style5"></span></td>
    <td><span class="style5"></span></td>
    <td><span class="style5"></span></td>
    <td><span class="style5"></span></td>
    <td><span class="style5"></span></td>
  </tr>
  <!--<<tr>
    <td><span class="Estilo1 style5 style7"><span class="style8">TIPO&nbsp;DOCUMENTO </span></span></td>
    <td><span class="style10" style="color: #333333">
      <select name="tipodocumento" id="tipodocumento" style="width:180px;font-size:12px">
        <% 
		list=modelo.listadoParametros(5);
		it = list.iterator(); 
		while (it.hasNext()) {
			parametro = (Parametro)it.next(); %> 
        <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
          <%}%>
      </select>
    </span></td>
    <td><span class="style5"></span></td>
    <td><span class="Estilo1 style5 style7"><span class="style8">NUMERO&nbsp;DOCUMENTO </span></span></td>
    <td><input name="documento" id="documento" style="width:180px; text-align:center" onblur="consultaPersona()"/></td>
  </tr>
  <tr>
    <td><span class="Estilo1 style5 style7"><span class="style8">NOMBRE&nbsp;PERSONA </span></span></td>
    <td colspan="4"><input name="nombres" id="nombres" style="width:530px;text-transform:uppercase" readonly/></td>
  </tr>-->
  <tr>
    <td><span class="Estilo1 style5 style7"><span class="Estilo8">DEMANDANTE </span></span></td>
    <td colspan="4"><input name="demandante" id="demandante"  style="width:530px;text-transform:uppercase"  /></td>
  </tr>
  <tr>
    <td><span class="style5"></span></td>
    <td><span class="style5"></span></td>
    <td><span class="style5"></span></td>
    <td><span class="style5"></span></td>
    <td><span class="style5"></span></td>
  </tr>
  <tr>
    <td><span class="Estilo1 style5 style7"><span class="Estilo8">OFICINA&nbsp;JURIDICA </span></span></td>
    <td colspan="4"><span class="style10" style="color: #333333">
      <select name="oficina" id="oficina" style="width:530px;font-size:12px">
        <%
	   list=modelo.consultarOficinasJuridicas();
	   it = list.iterator(); 
		while (it.hasNext()) {
			Oficina_Juridica oficina = (Oficina_Juridica)it.next(); %> 
        <option value="<%=oficina.getId_oficina()+""%>"><%=oficina.getNombre()%></option>
          <%}%>
      </select>
    </span></td>
  </tr>
  <tr>
    <td><span class="Estilo1 style5 style7"><span class="Estilo8">TIPO&nbsp;EMBARGO</span></span></td>
    <td><span class="style10" style="color: #333333">
      <select name="tipoembargo" id="tipoembargo" style="width:180px;font-size:12px">
        <% 
		list=modelo.listadoParametros(341);
		it = list.iterator(); 
		while (it.hasNext()) {
			parametro = (Parametro)it.next(); %> 
        <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
          <%}%>
      </select>
    </span></td>
    <td><span class="style5"></span></td>
    <td><span class="Estilo1 style5 style7"><span class="Estilo8">PROCESO</span></span></td>
    <td><span class="style10" style="color: #333333">
      <select name="proceso" id="proceso" style="width:180px;font-size:12px">
        <% 
		list=modelo.listadoParametros(23);
		it = list.iterator(); 
		while (it.hasNext()) {
			parametro = (Parametro)it.next(); %>
        <option value="<%=parametro.getCodigo()+""%>"><%=parametro.getNombre()%></option>
        <%}%>
      </select>
    </span></td>
  </tr>


 <!-- <tr>
    <td><span class="Estilo1 style5 style7"><span class="style8">NUMERO&nbsp;OFICIO </span></span></td>
    <td><input name="numero_oficio" id="numero_oficio" style="width:180px; text-align:center"/></td>
    <td><span class="style5"></span></td>
    <td><span class="Estilo1 style5 style7"><span class="style8">FECHA&nbsp;OFICIO </span></span></td>
    <td>
         <span class="style9">
         <input type="text" name="fecha_oficio" id="fecha_oficio" style="width:140px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10"/>
         <input name="fecha" type="button" id="fecha" value="<<" style="width:25px; text-align:center"/>     
		 <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fecha_oficio",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "fecha"   // el id del bot?n que lanzar? el calendario
			});
		 </script>
         </span></td>
  </tr>
  <tr>
    <td><span class="Estilo1 style5 style7"><span class="style8">NUMERO&nbsp;RAD. </span></span></td>
    <td><input name="numero_radicacion" id="numero_radicacion" style="width:180px; text-align:center"/></td>
    <td><span class="style5"></span></td>
    <td><span class="Estilo1 style5 style7"><span class="style8">FECHA&nbsp;RADICACION </span></span></td>
    <td>
         <span class="style9">
         <input type="text" name="fecha_radicacion" id="fecha_radicacion" style="width:140px; background-image:url(../html/images/mascara.png); background-position:center; background-repeat:no-repeat; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10"/>
         <input name="fecha" type="button" id="fecha" value="<<" style="width:25px; text-align:center"/>     
		 <script type="text/javascript">
			Calendar.setup({
				inputField     :    "fecha_oficio",      // id del campo de texto
				ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
				button         :    "fecha"   // el id del bot?n que lanzar? el calendario
			});
		 </script>
         </span></td>
  </tr>-->
  <tr>
    <td height="58"><span class="Estilo1 style5 style7"><span class="Estilo8">OBSERVACIONES</span></span></td>
    <td colspan="4"><span class="style10" style="color: #333333">
      <textarea name="observacion" id="observacion" style="width:530px; height:70px"></textarea>
    </span></td>
  </tr>
  
  
  <tr>
   

                                </tr>

                                </table>

     
                        </fieldset>
 </div>

                        </td>
		</tr>		
			<tr>
			<td>&nbsp;</td>
			</tr>	
		
                       
                        <!--editar Comparendos existentes-->

             <tr>
                <td colspan="3">
                        <div id="consultarembargos" style="display: none">
                    <fieldset class="style1">
                               
				<table width="100%" border="0" align="center" >
				<tr style="border:none; background:url(../html/images/inicio_3.png)">
				<td colspan="6" align="center" valign="middle"><span class="Estilo18">Consultar Embargos</span></td>
                                </tr>
                                                            <tr><td colspan="4">&nbsp;</td></tr>
               <tr style="display:none">
                  <td><input type="text" id="idembargo" name="idembargo" value=""/></td>
              </tr>

              <tr style="display:none">
                  <td><input type="text" id="embargosalevantar" name="embargosalevantar" value=""/></td>
              </tr>

                    <tr>
                        <td>

<% 
if(placaX!=null){
Vehiculo vehiculo  = new Vehiculo();
vehiculo=modelo.consultarVehiculo(placaX.toUpperCase());
if (vehiculo!=null){ %>

               

<table width="100%" border="1"  cellpadding="1" cellspacing="0">
   <tr style="border:none; background:url(../html/images/inicio_3.png)">
    <td width="30%" style="border:none"><div align="center" class="style4">OFICINA</div></td>
    <td width="40%" style="border:none"><div align="center" class="style4">DEMANDANTE</div></td>
    <td width="10%" style="border:none"><div align="center" class="style4">TIPO </div></td>
    <td width="5%" style="border:none"><div align="center" class="style4">F.&nbsp;OFICIO</div></td>
    <td width="5%" style="border:none"><div align="center" class="style4">N&ordm;&nbsp;OFICIO</div></td>
    <td width="5%" style="border:none"><div align="center" class="style4">F.&nbsp;LEVANTE</div></td>
    <td width="5%" style="border:none"><div align="center" class="style4">N&ordm;&nbsp;LEVANTE</div></td>
        <td width="5%" style="border:none"><div align="center" class="style4">&nbsp;</div></td>
  </tr>
 <%java.util.List lista   =  modelo.consultarEmbargosaLevantar(vehiculo.getId_vehiculo());
   boolean color = true;

   if(lista.size()==0){
 %><script>
     document.form.embargosalevantar.value = "1"
 </script><%
   }else{
   %><script>
     document.form.embargosalevantar.value = "0"
 </script><%
   }

   for(int i=0;i<lista.size();i++){
       Embargo embargo = (Embargo)lista.get(i);
       Oficina_Juridica oficina_juridica = modelo.consultarOficinaJuridica(embargo.getFk_oficina());
       String nombre="";
       if(embargo.getDemandante()!=null){
             nombre=embargo.getDemandante();
       }
       /*String nombres = "";
       if(persona.getTipo_documento()!=2){
           nombres = persona.getNombre_1()+" "+persona.getApellido_1()+" "+persona.getApellido_2();
       }else{
           nombres = persona.getNombre_1();
       }*/
       String tipo_embargo = modelo.consultarParametroName(341, embargo.getTipo());


 %>
        <tr bgcolor="#FFFFFF" style="cursor:pointer " >
            
                <td align="center"><span class="style8"><%=oficina_juridica.getNombre()%></span></td>
                <td align="center"><span class="style8"><%=nombre.toUpperCase() %></span></td>
                <td align="center"><span class="style8"><%=tipo_embargo%></span></td>
                <td align="center"><span class="style8"><%out.print(embargo.getFecha_oficio()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy").format(embargo.getFecha_oficio()):"");%></span></td>
                <td align="center"><span class="style8"><%=embargo.getOficio()%></span></td>
                <td align="center"><span class="style8"><%=embargo.getFecha_levantamiento()!=null?embargo.getFecha_levantamiento():""%></span></td>
                <td align="center"><span class="style8"><%=embargo.getNro_levantamiento()!=null?embargo.getNro_levantamiento():""%></span></td>
                <td align="center"><span class="style8" onclick="VerSeleccion(<%=i%>)" ><input type="radio" id="radio" value="<%=embargo.getId_embargo()%>" checked name="radio"/></span></td>
                <script>VerSeleccion(<%=i%>, <%=embargo.getId_embargo()%>)</script>
        </tr>
              
     <%  color = !color;
   }
   %>
</table>
<% }
 }
%>

                        </td>
                    </tr>
 
                                </table>

     
                        </fieldset>
 </div>

                        </td>
		</tr>		
			<tr>
			<td>&nbsp;</td>
			</tr>

                        
                        
                         <!--Fin Editar Comparendos-->

                        
		<tr>
			<td colspan="3" align="center"><input name="adicionar" type="button" id="adicionar" value="Registrar Solicitud" style="width:200px; text-align:center" onclick="revisar('embargos')"/></td>
		</tr>
	</table>		
	</fieldset>  

 	
        </form>
</body>

</html>
<%  }else{ %>
			   <jsp:forward page="no_access.jsp">
				 <jsp:param name="tipo" value="1"></jsp:param>
			   </jsp:forward>
	<%  }
	}else{ %>
		<script>
			window.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}

}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
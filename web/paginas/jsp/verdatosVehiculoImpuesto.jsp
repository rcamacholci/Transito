<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java"  errorPage="" %>

<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("cargarImpuestos.jsp")){
                 modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Vehiculo</title>
        <link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />
        <script type="text/javascript" src="../html/scripts/tablecloth.js"></script>
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
	function editarV(){
		window.parent.frames[0].location.href = "editarDatosVehiculo.jsp?id=1";
	}

	        function datosPersona(doc,tipo){
                            var documento = doc;
                            var paso = 1;
                            var tipoDoc = tipo;
				 window.location.href = "consultarPersonaRUNT.jsp?paso="+paso+"&documento="+documento+"&tipo="+tipoDoc;
			}

	 function ActualizarEstado(placa){

        //alert("estoy aqui: "+ placa)
         window.location.href = "procesarSincronizacion.jsp?placa="+placa;
    }

        function consultaPlacaRunt(placa,idv){
            ajax2=new nuevoAjax();
            ajax2.open("POST", "verificarPlacaVehiculo.jsp",true);
            ajax2.onreadystatechange=function() {
                if (ajax2.readyState==4) {
                    var respuesta = ajax2.responseText;
                    if(respuesta.indexOf("Vehiculo SI")!=-1){
						if(navigator.appName=="Microsoft Internet Explorer"){
							document.getElementById("trrunt").style.display = "block";
						}else{
							document.getElementById("trrunt").style.display = "table-row";
						}
						document.getElementById("trrunt").style.backgroundColor = "#009933";
                        document.getElementById("respuestarunt").innerHTML = "<div class='Estilo15'>"+respuesta+".</div>";
                    }else
                        if(respuesta.indexOf("Vehiculo NO")!=-1){
	                        if(navigator.appName=="Microsoft Internet Explorer"){
								document.getElementById("trrunt").style.display = "block";
							}else{
								document.getElementById("trrunt").style.display = "table-row";
							}
							document.getElementById("trrunt").style.backgroundColor = "#FFCC33";
							document.getElementById("respuestarunt").innerHTML = "<div class='Estilo16'>"+respuesta+"</div>";
                        }else{
                            document.getElementById("trrunt").style.display = "none";
                        }
                }
            }
            ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            ajax2.send("placa="+placa+"&idv="+idv);
	}

	function actualizarV(idv){
		document.getElementById("actualizar").disabled = true;
		document.location.href = "actualizarVehiculoRunt.jsp?vehiculo="+idv;
	}
	</script>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%
Model modelo= (Model)session.getAttribute("model");
String placa = "";
if(request.getParameter("id")!=null){
	if(request.getParameter("id").equals("0")){
            placa =  request.getParameter("placa");
	}else{
            placa =  session.getAttribute("placa")+"";
	}
	if(placa!=null){
		Vehiculo vehiculo  = new Vehiculo();
                placa = placa.toUpperCase();
		vehiculo= modelo.consultarVehiculo(placa);
                if(vehiculo.getServicio()==2){
                if(vehiculo==null){
                    if(placa.length()==6){
                        if(Character.isLetter(placa.charAt(2))){
                            if(placa.charAt(2)<='J'){
                                int newDgto = (((int)placa.charAt(2))-64)%10;
                                placa = new StringBuffer(placa).replace(2, 3, newDgto+"").toString();
                                vehiculo=modelo.consultarVehiculo(placa);
                            }
                        }else{
                            char newChar = (char)(74-((10-Integer.valueOf((placa.charAt(2)+"")))%10));
                            placa = new StringBuffer(placa).replace(2, 3, newChar+"").toString();
                            vehiculo=modelo.consultarVehiculo(placa);
                        }
                    }
                }
		if (vehiculo!=null){
			session.setAttribute("placa",vehiculo.getPlaca());
			Sede sede= modelo.consultarSede(vehiculo.getFk_sede());
			java.util.HashMap caract=modelo.listarCaracteristicasVehiculo(vehiculo.getPlaca().toUpperCase());
			java.util.HashMap especif=modelo.listarEspecificacionesVehiculo(vehiculo.getPlaca().toUpperCase());
			String carroceria= caract.get("2")!=null ? modelo.consultarParametro(Integer.parseInt(caract.get("2").toString()),2).getNombre():"";
			Parametro param  = modelo.consultarParametro(Integer.parseInt(vehiculo.getClase_vehiculo()+""),1);
			Parametro param2 = modelo.consultarParametro(Integer.parseInt(vehiculo.getServicio()+""),3);
			Parametro param3 = modelo.consultarParametro(Integer.parseInt(vehiculo.getEstado()+""),66);
			String modalidad = "";
                        boolean swActualizoInteres = modelo.actualizarInteresesCostasVehiculos(vehiculo.getId_vehiculo(), usuario.getId_usuario());
                        if(!swActualizoInteres){
                            // Colocar alerta cuando no se genero intereses
                            %><script>alert('Há ocurrido un error al actualizar intereses, intente nuevamente')</script><%
                        }
                        String carteraSum=modelo.consultarCarteraTotal(vehiculo.getId_vehiculo());
                        String periodo = modelo.consultarPeriodo(vehiculo.getId_vehiculo());

                        if(caract.get("324")!=null){
			   modalidad = modelo.consultarParametroName(324, Integer.parseInt(caract.get("324").toString()));
			}
			java.util.List lista_colores = modelo.lista_historico_color(vehiculo.getPlaca());
			String color = "";
			for(int l=0;l<lista_colores.size();l++){
			    Historico_Color hc = (Historico_Color)lista_colores.get(l);
			    if(hc.getFecha_fin()==null){
			        Color cl = modelo.getColor(hc.getFk_color());
			        color += cl.getNombre();
			    }
			}

                        Licencia_Transito licenciaTransito = modelo.consultarLicenciaTransito(vehiculo.getId_vehiculo());
                        String numeroLt = "";
                        if(licenciaTransito!=null)
                            numeroLt = licenciaTransito.getNumero();
                        Linea linea = modelo.consultaLinea(vehiculo.getPlaca().toUpperCase());
			Marca  marca= modelo.consultaMarca(vehiculo.getPlaca().toUpperCase());
                        String estadoLegal = ""; %>
    <body>
        <form name="form" method="post">
        <%
        long ev = vehiculo.getEstado();
        if(ev==1||ev==5||ev==6){ %>
            <script language="javascript" type="text/javascript"> consultaPlacaRunt("<%=placa%>","<%=vehiculo.getId_vehiculo()%>");</script>
        <% } %>

        <table border="1">
		<tr>
                    <th colspan="3" align="center">INFORMACION GENERAL DEL VEHICULO<span style="position:absolute; right:5px;"></span>
		</tr>
                </table>
                <% if(vehiculo.getEstado()==6||vehiculo.getEstado()==7||vehiculo.getEstado()==8){ %>

                <table>
    <tr>
                  <td colspan="3">
                    <div align="center" >EL VEHICULO SE ENCUENTRA ACTUALMENTE EN ESTADO&nbsp;<%=param3.getNombre() %></div>                  </td>
      </tr>
                <% } %>
                <tr id="trrunt" style="display:none">
                    <td colspan="3" align="center"><div id="respuestarunt"></div></td>
	  </tr>
          </table>

                        <table border="1" >
                            <tr>
                            <%   boolean haveA = modelo.tieneAlertas(vehiculo.getId_vehiculo());
                                 boolean haveE = modelo.tieneEmbargos(vehiculo.getId_vehiculo());
                                 int haveP = (haveA?1:0)+(haveE?1:0);
                                 estadoLegal = haveE?(haveA?"EMBARGADO/PIGNORADO":"EMBARGADO"):(haveA?"PIGNORADO":"NORMAL");
                                 if(haveE){ %>
                                    <td width="<%=100/haveP%>%" bgcolor="#FF0000"><div align="center"><span style="color:red; font-size:12px; font-weight:bold">EXISTEN EMBARGOS PENDIENTES A LA FECHA </span></div></td>
                              <% }
                                 if(haveA){ %>
                                    <td width="<%=100/haveP%>%" bgcolor="#FF6600"><div align="center"><span style="color:red; font-size:12px; font-weight:bold">EXISTEN ALERTAS PENDIENTES A LA FECHA </span></div></td>
                              <% } %>
                          </tr>
                        </table>


		<div>		<fieldset>


				<table border="1" align="center">
					<tr style="border:none; background:url(../html/images/inicio_3.png)">
				<th colspan="6" align="center" valign="middle">DATOS DEL VEHICULO</th>
                                </tr>

					<tr>
						<td width="7%">PLACA</td>
						<td>
                                                    <input type="text" name="textfield" value="<%=vehiculo.getPlaca() %>" style="width:150px; color:#333333; text-align:center" readonly/>
                                                    <script>
                                                        window.parent.frames[0].location.href = "verImpuestoVehiculo.jsp?placa="+document.form.textfield.value;
                                                    </script>
   						</td>
						<td>MARCA</td>
    					<td width="26%">
						<input name="" type="text" value="<%=marca.getNombre() %>" style=" width:170px;color:#333333; text-align:center" readonly/>
                                        </td>
					<td>LINEA</td>
					    <td>
						      <input name="Input" type="text"  value="<%=linea.getNombre() %>" style=" width:170px;color:#333333; text-align:center" readonly/>
					 </td>
					</tr>
					<tr>
                                            <td>CLASE</td>
					    <td>
						<input name="" type="text"  value="<%= param.getNombre()  %>" style=" width:150px;color:#333333; text-align:center" readonly/>						</td>
						<td>SERVICIO</td>
					    <td>
								<input name="" type="text" value="<%=param2.getNombre() %>" style=" width:170px;color:#333333; text-align:center" readonly/>						</td>
					    <td>ESTADO</td>
					    <td>
							<input name="" type="text"  value="<%=param3.getNombre() %>" style=" width:170px;color:#333333; text-align:center" readonly/>						</td>
					</tr>
					<tr>
						<td>MODELO</td>
					    <td>
							<input name="" type="text"  value="<%=vehiculo.getModelo() %>" style=" width:150px;color:#333333; text-align:center" readonly/>						</td>
						<td>COLOR</td>
					    <td>
							<input name="" type="text"  value="<%=color%>" style=" width:170px;color:#333333; text-align:center" readonly/>						</td>
						<td>CARROCERIA</td>
					    <td>
							<input name="" type="text"  value="<%=carroceria%>" style=" width:170px;color:#333333; text-align:center" readonly/>						</td>
					</tr>
					<tr>
						<td>L.&nbsp;TRANSITO</td>
					    <td>
							<input name="" type="text"  value="<%= numeroLt %>" style=" width:150px;color:#333333; text-align:center" readonly/>						</td>
						<td>F.&nbsp;MATRICULA </span></td>
					    <td>
							<input name="" type="text"  value="<%= vehiculo.getFecha_matricula()!=null?(new java.text.SimpleDateFormat("dd/MM/yyyy").format(vehiculo.getFecha_matricula())):""%>" style=" width:170px;color:#333333; text-align:center" readonly/>						</td>
                                                <td>CARTERA&nbsp;<%=periodo%></td>
                                                <td>
							<input name="" type="text"  value="<%=carteraSum%>" style=" width:170px;color:#FF0000;font-weight:bold; text-align:center" readonly/>						</td>
					</tr>

				</table>
				</fieldset>
		</div>

		<tr>
			<td colspan="3">
				<fieldset>

				<table width="100%" border="0" align="center">
				<tr>
				<th colspan="6" align="center" valign="middle">CARACTERISTICAS DEL VEHICULO</th>
			</tr>


					<tr>
						<td width="7%">MOTOR</td>
 					    <td width="26%">
							<input type="text" value="<%=especif.get("19")!=null?especif.get("19"):""%>" style="width:170px;color:#333333;text-align:center" readonly/>
													</td>
						<td width="7%">CHASIS</td>
					    <td width="26%">
							<input type="text" value="<%=especif.get("20")!=null?especif.get("20"):""%>" style="width:170px;color:#333333;text-align:center" readonly/>
													</td>
						<td width="7%">SERIE</td>
					    <td width="27%">
							<input type="text" value="<%=especif.get("21")!=null?especif.get("21"):""%>" style="width:170px;color:#333333;text-align:center" readonly/>
												</td>
					</tr>
					<tr>
						<td width="7%">CILINDRAJE</td>
					    <td width="26%">
							<input type="text" value="<%=especif.get("11")!=null?especif.get("11"):""%>" style="width:170px;color:#333333;text-align:center" readonly/>
													</td>
						 <td>PASAJEROS</td>
					     <td>
						 	<input type="text" value="<%=especif.get("1")!=null?especif.get("1"):""%>" style="width:170px;color:#333333; text-align:center" readonly/>
												</td>
						<td>TONELADAS</td>
    					<td>
							<input type="text" value="<%=especif.get("2")!=null?especif.get("2"):""%>" style="width:170px;color:#333333;text-align:center" readonly/>
												</td>
					</tr>
                                        <%
                                            Movimiento movimiento = modelo.ConsultarMovimientoVehiculo(vehiculo.getId_vehiculo());

                                            String NoGuia="";
                                            String ResponsableEnvio = "";
                                            String FechaEnvio = "";
                                            String traslado= "";
                                            String f_traslado = "";
                                            String radicado = "";
                                            String f_radicado = "";

                                            try{

                                            NoGuia = movimiento.getNumero_guia();
                                            FechaEnvio = new java.text.SimpleDateFormat("dd/MM/yyyy").format(movimiento.getFecha_envio());
                                            ResponsableEnvio = movimiento.getResponsable_envio();

                                            }catch(Exception mexe){

                                            }

                                            if(movimiento!=null){
                                                if(movimiento.getEstado()==1){
                                                    if(movimiento.getTipo_movimiento()==1){
                                                        radicado = modelo.consultarSede(movimiento.getFk_sede()).getNombre_corto();
                                                        f_radicado = new java.text.SimpleDateFormat("dd/MM/yyyy").format(movimiento.getFecha_movimiento());
                                                    }else{
                                                        traslado = modelo.consultarSede(movimiento.getFk_sede()).getNombre_corto();
                                                        f_traslado = new java.text.SimpleDateFormat("dd/MM/yyyy").format(movimiento.getFecha_movimiento());
                                                    }
                                                }
                                            }


    %>
					<tr>
						<td width="7%">D.&nbsp;IMPORTACION</td>
					    <td>
							<input name="" type="text"  value="<%= vehiculo.getDocumento_importacion()!=null?vehiculo.getDocumento_importacion():"" %>" style=" width:170px;color:#333333; text-align:center" readonly/>						</td>
						<td>TRASLADO&nbsp;A</td>
					    <td>
							<input type="text" value="<%=traslado%>" style="width:170px;color:#333333;text-align:center" readonly/>
													</td>
						<td>RADICADO.&nbsp;DE</td>
    					<td>
							<input type="text" value="<%=radicado%>" style="width:170px;color:#333333; text-align:center" readonly/>
													</td>
					</tr>
					<tr>
						<td>F.&nbsp;IMPORTACION</td>
					    <td>
							<input name="" type="text"  value="<%= vehiculo.getFecha_importacion()!=null?(new java.text.SimpleDateFormat("dd/MM/yyyy").format(vehiculo.getFecha_importacion())):""%>" style=" width:170px;color:#333333; text-align:center" readonly/></span>						</td>
						<td>F.&nbsp;TRASLADO</td>
                                                <td><input type="text" name="textfield3" style=" width:170px;color:#333333; text-align:center" value="<%=f_traslado%>" readonly/></td>
						<td>F..&nbsp;RADICADO</td>
                                                <td><input type="text" name="textfield4" style=" width:170px;color:#333333; text-align:center" value="<%=f_radicado%>" readonly/></td>
					</tr>

                                        <tr>
						<td>No.&nbsp;GUIA</td>
                                                <td><input type="text" name="textfield3" style=" width:170px;color:#333333; text-align:center" value="<%=NoGuia%>" readonly/></td>
						<td>FECHA&nbsp;ENVIO</td>
                                                <td><input type="text" name="textfield3" style=" width:170px;color:#333333; text-align:center" value="<%=FechaEnvio%>" readonly/></td>
						<td>RESPONSABLE&nbsp;ENVIO</td>
                                                <td><input type="text" name="textfield4" style=" width:170px;color:#333333; text-align:center" value="<%=ResponsableEnvio%>" readonly/></td>
					</tr>

				</table>
				</fieldset>		  </td>
		</tr>

		<tr>
			<td colspan="3">
				<fieldset>
				<table width="100%" border="1" align="center">
                                    <tr>
				<th colspan="6" align="center" valign="middle">PROPIETARIOS DEL VEHICULO</th>
			</tr>





			<%      Propietario propietario= new Propietario();
				java.util.List  listapropietario=modelo.crearListaPropietarios(vehiculo.getId_vehiculo());
				Iterator itt = listapropietario.iterator();
				java.util.HashMap listaTipos = modelo.crearHashParametrosAbreviatura(5);
				while (itt.hasNext()) {
					propietario = (Propietario)itt.next();
					Persona persona=modelo.consultarPersona(propietario.getFk_persona()); %>
					<tr>
						<td>DOCUMENTO</td>
						<td>
							<input name="" type="text"  ondblclick="datosPersona('<%=persona.getDocumento()%>','<%=persona.getTipo_documento()%>')" value="<%=listaTipos.get(persona.getTipo_documento() + "")+" "+persona.getDocumento()%>" style=" width:170px;color:#333333; text-align:center" readonly/></span>					  </td>
						<td>NOMBRE</td>
						<td>
						<input type="text"  value="<%=persona.getNombre_1()+" "+(persona.getNombre_2()!=null?persona.getNombre_2():"")+" "+persona.getApellido_1()+" "+(persona.getApellido_2()!=null?persona.getApellido_2():"")%>"  style=" width:420px;color:#333333; text-align:center" readonly/>

                      </td>
					</tr>
			  <% } %>

			    </table>
			  </fieldset>		  </td>
		</tr>
                <tr>
				<td colspan="6" width="7%" align="center" style="border:none; background:url(../html/images/inicio_3.png)">
				<% if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("habilitarSincronizacion")){ %>
                                    <input id="estadorunt"  name="estadorunt" type="button" value="Actualizar Runt Sincronización" title="Acción con restricciones" onclick="ActualizarEstado(this.placa='<%=placa%>')" />
                                      <%
                               }else{ %>
                                 <input id="estadorunt"  name="estadorunt" type="button" value="Actualizar Runt Sincronización" title="Acción con restricciones" disabled onclick="ActualizarEstado(this.placa='<%=placa%>')" />
                                      <% } %>
				</td>
				</tr>

			  </fieldset>		  </td>
		</tr>
		<tr>
			<td colspan="3">
                            <div align="center">
                            <%
                            try{
                                Sincronizacion sincronizacion = modelo.consultarSincronizacion(1, vehiculo.getId_vehiculo());
                               String textB = "";
                               int actId = 0;
                               if(sincronizacion!=null){
                                   if(sincronizacion.getEstado()==1){
                                       textB = "Actualizado "+new java.text.SimpleDateFormat("dd/MM/yyy hh:mm:ss aa").format(sincronizacion.getFecha());
                                       actId = 1;
                                   }
                               }else{
                                   textB = "Actualizar Vehiculo RUNT";
                               }
                               if(actId==0){
                                    if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("actualizarVehiculoRunt.jsp")){ %>
        				  <input type="button" name="actualizar" id="actualizar" value="<%=textB%>" style="background-color:#009966; font-weight:bold; color:#FFFFFF" onclick="actualizarV(<%= vehiculo.getId_vehiculo()%>)"/>
                            <%      }
                               }else{ %>
                                  <input type="button" name="actualizar" id="actualizar" style="background-color:#003399; font-weight:bold; border-color:#003399;color:#FFFFFF" value="<%=textB%>" disabled/>
                            <% }
                            }catch(Exception exc){
                                exc.printStackTrace();
                                }%>
		        </div>
          </td>
		</tr>
	</table>
<%     }else{
		   session.removeAttribute("placa");		%>
		   <script>
			  alert("El vehiculo no se encuentra Registrado  <%=placa%>");
			  window.href="consultar_Vehiculo.jsp";
	  	   </script>
	<% }
                }else{%>
                    <script>
		alert("El servicio del vehiculo debe ser Publico");
		window.href="consultar_Vehiculo.jsp";
	</script>
<%
                }
   }else{ %>
 	<script>
		alert("Digite numero de placa");
		window.href="consultar_Vehiculo.jsp";
	</script>
<% }
}
%>
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
			window.parent.parent.document.location.href = "../../index.jsp";
		</script>  <%
	}
}catch(Exception mexe){
    mexe.printStackTrace(); %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
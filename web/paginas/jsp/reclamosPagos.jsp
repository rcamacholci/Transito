<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Parametro"  errorPage="" %>
<%@page import = "modelo.*" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){

%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
        <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Vehiculo</title>
    <!-- filter: alpha(opacity=85);-moz-opacity:0.85; -->
        <LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
		<script src="../html/scripts/calendar.js" type="text/javascript"></script>
        <script src="../html/scripts/calendar-es.js"ol type="text/javascript"></script>
        <script src="../html/scripts/calendar-setup.js" type="text/javascript"></script>
        <script src="../html/scripts/motorAjax.js" type="text/javascript"></script>
        
		<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
		<script language="javascript" type="text/javascript">

                   function validarCampos(){
				if(document.form.pago.value.length>0){
					if(document.form.tramite.value.length>0){
						if(document.form.tipoPago.value.length>0){
                                                    if(document.form.observacion.value.length>0){
                                                            if(document.form.tipoPago.value=='LICENCIA'){
                                                                    if(document.form.documento.value.length>0&&document.form.nombre.value.length>0){
                                                                        document.form.submit();
                                                                    }else{
                                                                        alert("Favor Digite la persona a la que se le va asociar el pago");
                                                                    }
                                                            }else{
                                                                if(document.form.tipoPago.value=='VEHICULO'){
                                                                    if(document.form.placa.value.length>0){
                                                                        document.form.submit();
                                                                    }else{
                                                                        alert("Favor Digite la placa a la que se le va asociar el pago");
                                                                    }
                                                                }
                                                            }
                                                    }else{
                                                        alert("digite alguna observacion");
                                                    }
						}else{
							alert("falta tipo de Pago");
						}
					}else{
						alert("Falta tramite");
					}
				}else{
					alert("Ingrese numero del Pago");
				}
				return false;
			}



        function buscar(input){
            var valor = input.value;
           if(valor.length>0){
                var ajax2 = new nuevoAjax2();
                ajax2.open("POST", "getPago.jsp",true);
                ajax2.onreadystatechange=function() {
                    if (ajax2.readyState==4) {
                        var docxml = ajax2.responseXML;
                        var result = docxml.getElementsByTagName('result')[0].childNodes[0].nodeValue;
                        if(result=='1'){
                              var pers = docxml.getElementsByTagName('persona')[0].childNodes[0].nodeValue;
                              var tipoP = docxml.getElementsByTagName('tipoPago')[0].childNodes[0].nodeValue;
                              var tram = docxml.getElementsByTagName('tramite')[0].childNodes[0].nodeValue;
                              var sw = docxml.getElementsByTagName('sw')[0].childNodes[0].nodeValue;
                              var cod = docxml.getElementsByTagName('tramiteCod')[0].childNodes[0].nodeValue;
                              document.getElementById("personaA").value = pers;
                              document.getElementById("tramite").value = tram;
                              document.getElementById("tipoPago").value = tipoP;
                              document.getElementById("tramiteCod").value = cod;
                              if(sw=='1'){
                                  document.getElementById('persona').style.display = "block";
                                  document.getElementById('tabla1').style.display = "block";
                                  document.getElementById('vehiculo').style.display = "none";
                                  document.getElementById('tabla2').style.display = "none";

                              }else{
                                  document.getElementById('persona').style.display = "none";
                                  document.getElementById('tabla1').style.display = "none";
                                  document.getElementById('vehiculo').style.display = "block";
                                  document.getElementById('tabla2').style.display = "block";

                              }
                        }else{
                            if(result=='2'){
                                alert("El pago ya esta Utilizado");

                            }else{
                                alert("El pago no se Encuentra Registrado");
                            }
                        }
                    }
                }
           }
            ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
            ajax2.send("pago="+valor);
         
        }


        function consultarPersona(){
        var documento = document.getElementById("documento");
        if(!isNaN(documento.value)&&documento.value.length>0){
                var tipos = document.getElementById("tipoDocumento");
                var tipoDoc = tipos.options[tipos.options.selectedIndex].value
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
                                  document.form.nombre.value = respuesta;
                                }
                        }
                }
                ajax2.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                ajax2.send("documento="+documento.value+"&tipo="+tipoDoc);
        }
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


		</script>
<link href="../html/css/tablecloth.css" rel="stylesheet" type="text/css" media="screen" />

</head>
    <%
    Model model = null;
    try {
        model = (Model) session.getAttribute("model");
        Usuario usuario = (Usuario) session.getAttribute("usuario");
        } catch (Exception exc) {
        exc.printStackTrace();
    }

    %>
    <body>
		<form name="form" id="form" method="post" action="procesarReclamosPago.jsp" onSubmit="validarCampos(); return false">
                    <input type="hidden" name="tramiteCod"  id="tramiteCod" value="" />
                     <fieldset><div align="center">

		  	</div>
			<table width="100%" border="0" align="center">
			<tr style="border:none;">
			<th colspan="11" align="center"><span class="style3 style14 style2 Estilo28 style1 Estilo12"><strong>VALIDAR PAGOS</strong></span></th>
    </tr>

				<tr>
				  <td colspan="5">

						<table border="0" width="100%" id="tabla">
						<tr>
							<td colspan="5">
							<fieldset>
							<legend ><span class="style7">DATOS DEL PAGO</span> </legend>
							<table border="0" width="100%" id="tabla">
									<tr valign="middle">
							      <td width="20%" ><label style="color:#333333"><span class="style5">N. PAGO </span></label></td>
								  <td width="20%" scope="col" ><input  id="pago" name="pago"  maxlength="7" style="text-align:center;text-transform:uppercase;color:#333333;font:bold; width:120px"  onBlur="buscar(this)"  /></td>

								     <td height="26"  colspan="2" align="left"><label style="color:#333333"><span class="style5">TRAMITE</span></label></td>
							      <td width="43%" scope="col" ><input  id="tramite" name="tramite"  style="text-align:center;text-transform:uppercase;color:#333333;font:bold; width:300px" readonly/></td>
					  	  </tr>

								<tr>
									<td><span class="style5">TIPO PAGO  </span></td>
									<td><input  id="tipoPago" name="tipoPago"    readonly style="text-align:center;text-transform:uppercase;color:#333333;font:bold; width:120px"  /></td>
									<td colspan="2"><span class="style5">PERSONA ACTUAL </span></td>

									<td><input  id="personaA" name="personaA"  style="text-align:center;text-transform:uppercase;color:#333333;font:bold; width:300px" readonly/></td>
								</tr>
							</table>
							</fieldset>
							</td>
						</tr>

								<tr>
									<td colspan="5">
									<fieldset id="persona" style="display:none">
									<legend ><span class="style7">DATOS DE LA PERSONA ASOCIADA</span></legend>
									<table width="100%"  id="tabla1" style="display:none">
									<tr valign="middle">

								<td width="8%" ><span class="style5">T.&nbsp;DOCUMENTO</span></td>
													 		<td width="16%" ><span class="Estilo13">
																  <select  name="tipoDocumento" id="tipoDocumento" style="width:200px; font-size:10px; color:#333333">
                                                                    <% java.util.List tipoDocumentos = model.listadoParametros(5);
		   for (int i = 0; i < tipoDocumentos.size(); i++) {
			   Parametro parametro = (Parametro) tipoDocumentos.get(i);

                                %>
                                                                    <option value="<%=parametro.getCodigo()%>" selected="selected"><%= parametro.getNombre()%> </option>
                                                                    <%

                  } %>
                                                                  </select>
								  </span></td>
								  								  <td width="8%" align="center"><span style="font-family: Tahoma"><span class="Estilo14">DOCUMENTO</span></span></td>
								  								  <td width="18%" align="center"><span style="font-family: Tahoma">
								  								    <input name="documento"  id="documento" onBlur="consultarPersona()" style="text-align:center;color:#333333;font:bold; width:150px" value=""/>
								  								  </span></td>
								                                <td width="8%" align="center" ><span style="font-family: Tahoma">
								                                  <label style="color:#333333"></label>
								                                </span>
	                                  <p style="font-family: Tahoma"><span class="Estilo14">NOMBRE</span></p></td>
									  <td width="42%"><span style="font-family: Tahoma">
									    <input name="nombre"  id="nombre" style="text-align:center;color:#333333;font:bold; width:300px" value=""/>
									  </span></td>
						  </tr>
									</table>
									</fieldset>
									<fieldset  id="vehiculo" style="display:none">
									<legend><span class="style7">DATOS DEL VEHICULO ASOCIADO </span></legend>
									<table width="100%" id="tabla2" style="display:none">
									<tr valign="middle">

								  <td width="40%"  align="right"><span style="font-family: Tahoma"><span class="Estilo14">PLACA</span></span></td>
								  <td width="5%">&nbsp;</td>
								  <td width="40%" align="left"><span style="font-family: Tahoma">
								    <input name="placa"  id="placa" style="text-align:center;color:#333333;font:bold; width:150px" value=""/>
								  								  </span></td>

						  </tr>
									</table>
									</fieldset>
									</td>

								</tr>



						  <tr valign="middle">						  </tr>
						  <tr>
							<td width="26%" align="right"><span class="style5">OBSERVACION</span></td>
							  <td width="74%" colspan="4" align="center" ><label>
							    <textarea name="observacion" id="observacion" style="width:500px;"></textarea>
							  </label></td>
						  </tr>
							<tr>
							  <td colspan="5" align="center" ><input id="consultar"  name="consultar" type="submit" value="--- Validar Pago ---" style="color:#333333" onClick="buscarPago()"/></td>
							</tr>
						</table>



				  </td>
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

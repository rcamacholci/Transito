<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.DatosVehiculo" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Prestamos</title>
<style type="text/css">
<!--
.Estilo13 {color: #FFFFFF; font-weight: bold; }
.Estilo20 {font-size: 12px; font-weight: bold;  }
.style18 {
	color: #FFFFFF;
	font-family: Tahoma;
	font-weight: bold;
	font-size: 12px;
}
.style19 {font-family: Tahoma}
.style20 {font-size: 12px}
.style26 {color: #333333}
.style27 {font-family: Tahoma; font-size: 12px; font-weight: bold; color: #333333; }
-->
</style>
<LINK title=win2k-cold-1 media=all href="../html/scripts/calendar-green.css" type="text/css" rel="stylesheet"/>
<script type="text/javascript" src="../html/scripts/calendar.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-setup.js"></script>
<script type="text/javascript" src="../html/scripts/calendar-es.js"></script>
<script src="../html/scripts/validarFecha.js" type="text/javascript"></script>
<script language="javascript" type="text/javascript">
	
	function volver(){
            window.parent.document.location.href = "consultarOficiosEmbargos.jsp";
	}

        function enviar(){
            if(document.form.numOficio.value.length>0){
                if(document.form.fechaO.value.length>0){
                    if(document.form.entidad.value.length>0){
                         if(document.form.solicitante.value.length>0){
                                if(document.form.cargo.value.length>0){
                                    if(document.form.municipio.value.length>0){
                                        if(document.form.placa.value.length>0){
                                            if(document.getElementById("novedad").value!=0){
                                                if(document.getElementById("novedad").value!=0){
                                                    if(document.getElementById("novedad").value!=0){
                                                        document.form.submit();
                                                    }else{
                                                        alert("el campo fecha de radicacion no puede quedar vacio");
                                                    }
                                                }else{
                                                     alert("el campo N° de radicacion no puede quedar vacio");
                                                }
                                            }else{
                                                alert("Seleccione un tipo de novedad");
                                            }
                                        }else{
                                            alert("el campo placa no puede quedar Vacio");
                                        }
                                    }else{
                                        alert("el campo municipio no puede quedar Vacio");
                                    }
                                }else{
                                    alert("el campo cargo no puede quedar Vacio");
                                }
                         }else{
                            alert("el campo nombre solicitante no puede quedar Vacio");
                        }
                    }else{
                        alert("el campo Entidad no puede quedar Vacio");
                    }
                }else{
                    alert("el campo fecha del Oficio no puede quedar Vacio");
                }
            }else{
                alert("el campo N° del Oficio no puede quedar Vacio");
            }
	}
	
	function editar(sw){
		document.getElementById("numOficio").disabled=sw
		document.getElementById("fechaO").disabled=sw
		document.getElementById("entidad").disabled=sw
		document.getElementById("solicitante").disabled=sw
		document.getElementById("cargo").disabled=sw
		document.getElementById("referencia").disabled=sw
		document.getElementById("direccion").disabled=sw
		document.getElementById("municipio").disabled=sw
                document.getElementById("placa").disabled=sw
		document.getElementById("novedad").disabled=sw
		document.getElementById("numRadicacion").disabled=sw
		document.getElementById("fechaR").disabled=sw
                document.getElementById("btactualizar").disabled=sw
        }
	
</script>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
Model modelo= (Model)session.getAttribute("model"); 
String numOficio = "";
java.sql.Date fechaO;

%>
<body>

  <%
 if(request.getParameter("numOficio")!=null&&!request.getParameter("numOficio").isEmpty()){
    if(request.getParameter("fechaO")!=null&&!request.getParameter("fechaO").isEmpty()){
         numOficio = request.getParameter("numOficio");
         fechaO = new java.sql.Date(new java.text.SimpleDateFormat("dd/MM/yyyy").parse(request.getParameter("fechaO")).getTime());
         Oficio_Embargo oficioE = modelo.consultarOficiosEmbargosByNumeroFecha(numOficio,fechaO);
            if(oficioE!=null){
              Vehiculo vehiculo = modelo.consultarVehiculoById(oficioE.getFk_vehiculo());

%>
<fieldset>
 <form name="form" method="post" action="procesarOficioEmbargo.jsp">
     <input type="hidden" id="num" name="num" value="2" />
     <input type="hidden" id="id_oficio" name="id_oficio" value="<%=oficioE.getId_oficio()%>" />
<table align="center" width="100%">
    <tr style="border:none; background:url(../html/images/inicio_3.png)">
	<td colspan="6" align="center" valign="middle"><span class="style7 style18">INFORMACION DEL OFICIO </span></td>
    </tr>
        <tr>
                        <td width="25%"><span class="style20 style19 Estilo8 style26"><strong>N&ordm; OFICIO </strong></span></td>
                        <td width="25%">
                                <span class="style20 style19 Estilo8 style26"><strong>
                              <input type="text" name="numOficio"  id="numOficio" value="<%=oficioE.getNum_oficio()%>" style="width:150px; color:#333333; text-align:center"  disabled/>
                        </strong></span>					  </td>
                        <td width="25%"><span class="style20 style19 Estilo8 style26"><strong>FECHA OFICIO </strong></span></td>
                <td width="25%">
                          <span class="style20 style19 Estilo8 style26"><strong>
                                <input id="fechaO" disabled name="fechaO" type="text" value="<%=oficioE.getFecha_oficio()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy").format(oficioE.getFecha_oficio()):""%>" style=" width:130px;color:#333333; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10" />
                      </strong></span>					  <span class="style27">
                      <input name="btfechaO" type="button" id="btfechaO" value="&lt;" style="width:20px; text-align:center"/>
                      <script type="text/javascript">
Calendar.setup({
        inputField     :    "fechaO",      // id del campo de texto
        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
        button         :    "btfechaO"   // el id del bot?n que lanzar? el calendario
});
          </script>
  </span></td>
                </tr>
                <tr>
                        <td width="16%"><span class="style20 style19 Estilo8 style26"><strong>ENTIDAD</strong></span></td>
                    <td colspan="3"><span class="style20 style19 Estilo8 style26"><strong>
                    <input name="entidad" id="entidad" type="text"  value="<%=oficioE.getEntidad()!=null?oficioE.getEntidad():""%>" style=" width:420px;color:#333333; text-align:center" disabled/>
              </strong></span>						</td>
                </tr>
                <tr>
                        <td width="16%"><span class="style20 style19 Estilo8 style26"><strong>SOLICITANTE</strong></span></td>
                    <td colspan="3"><span class="style20 style19 Estilo8 style26"><strong>
                    <input name="solicitante" id="solicitante" disabled type="text"  value="<%=oficioE.getSolicitante()!=null?oficioE.getSolicitante():"" %>" style=" width:420px;color:#333333; text-align:center"/>
              </strong></span>						</td>
                </tr>
                <tr>
                        <td><span class="style20 style19 Estilo8 style26"><strong>CARGO</strong></span></td>
                    <td><span class="style20 style19 Estilo8 style26"><strong>
                                <input name="cargo" disabled id="cargo" type="text"  value="<%=oficioE.getCargo() %>" style=" width:150px;color:#333333; text-align:center" />
                    </strong></span>						</td>
                        <td><span class="style20 style19 Estilo8 style26"><strong>REFERENCIA</strong></span></td>
                    <td><span class="style20 style19 Estilo14 style26"><strong>
                                <input name="referencia" disabled id="referencia" type="text"  value="<%= oficioE.getReferencia()!=null?oficioE.getReferencia():""%>" style=" width:170px;color:#333333; text-align:center"/>
					    </strong></span>						</td>
					</tr>
        <tr>
                <td><span class="style20 style19 Estilo8 style26"><strong>DIRECCION</strong></span></td>
            <td><span class="style20 style19 Estilo8 style26"><strong>
            <input name="direccion" id="direccion"  disabled type="text"  value="<%=oficioE.getDireccion()!=null?oficioE.getDireccion():"" %>" style=" width:150px;color:#333333; text-align:center"/>
      </strong></span>						</td>
                <td><span class="style20 style19 Estilo8 style26"><strong>MUNICIPIO </strong></span></td>
            <td><span class="style20 style19 Estilo8 style26"><strong>
                        <input name="municipio" disabled id="municipio" type="text"  value="<%=oficioE.getMunicipio()!=null?oficioE.getMunicipio():"" %>" style=" width:170px;color:#333333; text-align:center"/>
            </strong></span>						</td>
        </tr>
        <tr>
                <td><span class="style20 style19 Estilo8 style26"><strong>PLACA</strong></span></td>
            <td><span class="style20 style19 Estilo8 style26"><strong>
              <input name="placa" id="placa" disabled type="text"  value="<%=vehiculo!=null?vehiculo.getPlaca():""%>" maxlength="6" style=" width:150px;color:#333333; text-align:center"/>
            </strong></span></td>
                <td><span class="style20 style19 Estilo8 style26"><strong>NOVEDAD</strong></span></td>
            <td><span class="style27">
              <select name="novedad" disabled id="novedad" style="width:170px; font-size:11px" >
                <%
             List lista_id = modelo.listadoParametros(344);
             Iterator itrtor = lista_id.iterator();
             while (itrtor.hasNext()) {
                 String Selected="";
                     Parametro  parametro = (Parametro)itrtor.next();
                             if(oficioE.getNovedad()==(int)parametro.getCodigo())
                                Selected = "selected";
                            else Selected ="";
                       
                           %>
		 <option value="<%=parametro.getCodigo()+""%>"  <%=Selected%> ><%=parametro.getNombre()%></option>
					        <%        
              }%>
                  </select>
                    </span></td>
                </tr>
                <tr>
                        <td width="25%"><span class="style20 style19 Estilo8 style26"><strong>N&ordm; RADICACION </strong></span></td>
                        <td width="25%">
                                <span class="style20 style19 Estilo8 style26"><strong>
                              <input type="text" disabled name="numRadicacion"  id="numRadicacion" value="<%=oficioE.getNum_radicacion() %>" style="width:150px; color:#333333; text-align:center"/>
                        </strong></span>					  </td>
                        <td width="25%"><span class="style20 style19 Estilo8 style26"><strong>FECHA RADICACION </strong></span></td>
                <td width="25%">
                          <span class="style20 style19 Estilo8 style26"><strong>
                                <input id="fechaR" disabled name="fechaR" type="text" value="<%=oficioE.getFecha_radicacion()!=null?new java.text.SimpleDateFormat("dd/MM/yyyy").format(oficioE.getFecha_radicacion()):""%>" style=" width:130px;color:#333333; text-align:center" onkeyup="mascara(this,'/',true)" maxlength="10"/>
                      </strong></span>					  <span class="style27">
                      <input name="btfechaR" type="button" id="btfechaR" value="&lt;" style="width:20px; text-align:center"/>
                      <script type="text/javascript">
Calendar.setup({
        inputField     :    "fechaR",      // id del campo de texto
        ifFormat       :    "%d/%m/%Y",       // formato de la fecha, cuando se escriba en el campo de texto
        button         :    "btfechaR"   // el id del bot?n que lanzar? el calendario
});
          </script>
  </span></td>
                </tr>
				<tr>
					<td colspan="6"> 
						<table align="center" width="100%">
							<tr>
								<td align="center" width="33%"><input name="beditar" type="button" id="beditar" value="Editar" style="width:130px; text-align:center" onclick="editar(false)"/></td>
								<td align="center" width="33%"><input name="btactualizar" disabled type="button" id="btactualizar" value="Actualizar" style="width:130px; text-align:center" onclick="enviar()"/></td>
								<td align="center" width="33%"><input name="beditar3" type="button" id="beditar3" value="Cancelar" style="width:130px; text-align:center" onclick="volver()"/></td>
							</tr>
						</table>
					</td>
				</tr>
					
					
</table>   
</form>         
</fieldset> 

     <%
                                                  
                                            
                                    
            }
     }
  }
   %>

</body>
</html>

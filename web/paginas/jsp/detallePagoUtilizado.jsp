<%-- 
    Documento   : detalleTaquilla
    Creado      : 10-mar-2010, 11:41:22
    Autor       : Desarrollo
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8" import="modelo.*,java.util.*" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%
//modelo.Model model = null;

try{
	if(session.getAttribute("model")!=null){
		//if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
if(1==1){
                 Model modelo= (Model)session.getAttribute("model");
                        Usuario usuario = (Usuario)session.getAttribute("usuario");
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
        <style type="text/css">

<!--
.style1 {
	font-size: 12px;
	font-family: Tahoma;
	font-weight: bold;
	color: #333333;
}
.style3 {font-weight: bold}
.style4 {color: #333333}
.style4 {color: #333333; font-size:10px; text-align:center}
.Estilo1 {color: #FFFFFF}
.Estilo3 {font-size: 10px; font-family: Tahoma; font-weight: bold; color: #333333; }
.Estilo4 {font-size: 10px}
.Estilo5 {color: #333333; font-size: 10px; }
.Estilo6 {font-size: 10px; color:#333333;}
-->
        </style>
</head>
    <body>
        <fieldset>
            <legend><span class="Estilo3">DETALLE TIQUETE</span></legend>
    <%  long id_tiquete = 0;

        if(request.getParameter("id_tiquete")!=null){
            id_tiquete=Long.parseLong(request.getParameter("id_tiquete"));
            System.out.println("tiquete : "+id_tiquete);
            Persona persona = new Persona();
            Parametro param = new Parametro();
            Parametro pmetro = new Parametro();
            java.util.HashMap listaTipos = modelo.crearHashParametrosAbreviatura(5);
            String nombre="";
            String observacion = "";          
            
    	    Tiquete tiq = modelo.consultarTiquetePorID(id_tiquete);
            Taquilla taq = modelo.consultarTaquillaActivaByUsuario(usuario.getId_usuario());
            persona = modelo.consultarPersona(tiq.getFk_persona());
            nombre=persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1();
            java.util.HashMap parameters = new java.util.HashMap();            
            Persona personaUsuario = modelo.consultarPersona(usuario.getFk_persona());
          

            String placa = "";
            if(tiq.getFk_vehiculo()!=0){
               placa  =  modelo.consultarVehiculoById(tiq.getFk_vehiculo()).getPlaca();
            }else{
               placa = tiq.getDescripcion();
            }
            
            String readonly = "";
            if(tiq!=null){
                if(1==1){
                    Pago pago = modelo.consultarPagoByTiquete(tiq.getId_tiquete());
                    if(pago!=null){
                        observacion = pago.getObservacion()!=null?pago.getObservacion():"";
                        readonly = "readonly";
                    }
                }
            }            
            param=  modelo.consultarParametro(tiq.getTipo_pago(),301);
            pmetro= modelo.consultarParametro(tiq.getEstado(),77);
           %>
   		<table width="100%" align="center">
		  <tr bordercolor="#FFFFFF" class="style1">
			<th width="78" align="center"><div align="center" class="Estilo7 style3 Estilo4">TIPO&nbsp;PAGO </div></th>
			<td width="149" align="left" style="font-size:11px"><input readonly class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%= param.getNombre()%>" ></td>
			<th width="63" align="center"><div align="center" class="Estilo5">FACTURA</div></th>
			<th width="144" align="left" style="font-size:11px"><input readonly  class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%= tiq.getNumero_factura()%>" ></th>
			<th width="43" ><div align="center" class="Estilo5">PLACA</div></th>
			<td width="154" align="left" style="font-size:11px"><input class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%= placa!=null?placa:""%>" readonly ></td>
		  </tr>
		  <tr class="style1">
		    <th ><div align="center" class="Estilo5">DOCUMENTO</div></th>
		    <td align="left" style="font-size:11px"><input name="Input2" readonly class="style5" style="font-size:10px; text-align:center; color:#333333" value = "<%=listaTipos.get(persona.getTipo_documento() + "")+" "+persona.getDocumento()%>"></td>
			<th ><div align="center" class="Estilo5">NOMBRE</div></th>
			<td align="left" style="font-size:11px" colspan="3"><input name="Input3" readonly class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%=nombre %>" size="70" ></td>
          </tr>
          <tr class="style1">
			<th ><div align="center" class="Estilo5">ESTADO</div></th>
			<td align="left" style="font-size:11px"><input readonly class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%= pmetro.getNombre() %>"></td>
			<td ><div align="center" class="Estilo5">VALOR</div></td>
			<td align="left" style="font-size:11px"><input readonly class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%= tiq.getValor_total() %>"></td>
			<td><span class="Estilo5">FECHA</span></td>
			<td align="left"><span style="font-size:11px">
		  <input name="Input" readonly class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(tiq.getFecha())%>" >
			</span></td>
<%
             /***/
             int Sw = 0;
             long exc = modelo.consultarRecivoExedente(tiq.getId_tiquete());
             Pago p = null;

             if(exc!=0){
                 p = modelo.consultarPagoByTiquete(exc);
             }else{
                 p = modelo.consultarPagoByTiquete(tiq.getId_tiquete());
             }             
             System.out.println(p.getId_pago());
             java.util.List<Formulario> tempf = modelo.listarFormulariosByPagos(p.getId_pago());
                if(tempf.size()>0){
                    %>
<tr class="style1">
    <td colspan="6"><div align="center" class="Estilo5" >&nbsp;</td>
</tr>
<tr class="style1">
		  	<td colspan="6"><div align="center" class="Estilo5" >RADICACION VEHICULO</div></td>
</tr>
<tr class="style1">
    <td colspan="6"><div align="center" class="Estilo5" >&nbsp;</td>
</tr>
                    <%
                    for(int i = 0;i<tempf.size();i++){
                       Formulario form = tempf.get(i);
                       Radicacion rad = modelo.consultar_Radicacion(form.getFk_radicacion());
                    if(rad.getEstado()==4 ||rad.getEstado()==5 || rad.getEstado()==9){
                        Vehiculo veh = modelo.consultarVehiculo(form.getPlaca());
                        Parametro estado = modelo.consultarParametro(rad.getEstado(),52);
                        observacion =
                       "Radicacion numero: "+rad.getNumero()+" Fecha: "+rad.getFecha()+" " +
                                "Persona: ";
                        
                        Sw=1;

                        %>

		  <tr class="style1">
		  	<td colspan="1"><div align="center" class="Estilo5">NUMERO RADICACION</div></td>
		  	<td align="left" style="font-size:11px" colspan="1">
				<input id="PlacaU" name="PlacaU" <%=readonly%> class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%=rad.getNumero()%>" size="20" >
			</td>
<td colspan="1"><div align="center" class="Estilo5">ESTADO RADICACION</div></td>
		  	<td align="left" style="font-size:11px" colspan="1">
				<input id="PlacaU" name="PlacaU" <%=readonly%> class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%=estado.getNombre()%>" size="20" >
			</td>
<td colspan="1"><div align="center" class="Estilo5">FECHA RADICACION</div></td>
		  	<td align="left" style="font-size:11px" colspan="1">
				<input id="PlacaU" name="PlacaU" <%=readonly%> class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%=new java.text.SimpleDateFormat("dd/MM/yyyy").format(rad.getFecha())%>" size="40" >
			</td>
		  </tr>
<tr class="style1">
		  	<td colspan="1"><div align="center" class="Estilo5">PRESONA RADICACION</div></td>
		  	<td align="left" style="font-size:11px" colspan="2">
				<input id="PlacaU" name="PlacaU" <%=readonly%> class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%=persona.getNombre_1() +" "+ persona.getApellido_1()%>" size="75" >
			</td>
<td colspan="1"><div align="center" class="Estilo5">PLACA RADICACION</div></td>
		  	<td align="left" style="font-size:11px" colspan="2">
				<input id="PlacaU" name="PlacaU" <%=readonly%> class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%= veh.getPlaca()%>" size="20" >
			</td>
		  </tr>
<tr class="style1">
    <td colspan="6"><div align="center" class="Estilo5" >&nbsp;</td>
</tr>
                        <%
                    }else{
                        observacion = "Radicacion no registrada";

                        Sw=0;
                    }
                    }
                    if(Sw==0){
                        %>
	      </tr>
		  <tr class="style1">
		  	<td colspan="1"><div align="center" class="Estilo5">OBSERVACION</div></td>
		  	<td align="left" style="font-size:11px" colspan="5">
				<input id="observacion" name="observacion" <%=readonly%> class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%=observacion %>" size="120" >
			</td>
		  </tr>
                       <%
                    }
                }else{
                    Formulario_Licencia fl = modelo.consultarFormularioLicenciabyFkPago(p.getId_pago());
                    if(fl!=null){
                    Radicacion_Licencia rlic = modelo.consultar_RadicacionLicencia(fl.getFk_radicacion());
                    
                                        %>
<tr class="style1">
		  	<td colspan="6"><div align="center" class="Estilo5" >RADICACION LICENCIA</div></td>
</tr>
                    <%
                    if(rlic.getEstado()==4 ||rlic.getEstado()==5 || rlic.getEstado()==9){
                        observacion ="Radicacion de Licencia numero:"+rlic.getNumero()+" Fecha: "+rlic.getFecha()+"" +
                                " Persona: "+persona.getNombre_1() +" "+persona.getApellido_1();
                        Sw=2;
                        %>

		  <tr class="style1">
		  	<td colspan="1"><div align="center" class="Estilo5">PERSONA UTILIZADO</div></td>
		  	<td align="left" style="font-size:11px" colspan="5">
				<input id="PersoanaU" name="PersoanaU" <%=readonly%> class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%=observacion%>" size="120" >
			</td>
		  </tr>

                        <%
                    }else{
                        Sw=0;
                        observacion = "Radicacion de licencia no registrada";
                        %>	      </tr>
		  <tr class="style1">
		  	<td colspan="1"><div align="center" class="Estilo5">OBSERVACION</div></td>
		  	<td align="left" style="font-size:11px" colspan="5">
				<input id="observacion" name="observacion" <%=readonly%> class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%=observacion %>" size="120" >
			</td>
		  </tr><%
                    }
                  }else{
                        observacion = exc!=0?"Recibo Validado Ha Numero de factura : "+ p.getNumero_factura():"";
                  %>
                    <tr class="style1">
		  	<td colspan="1"><div align="center" class="Estilo5">OBSERVACION</div></td>
		  	<td align="left" style="font-size:11px" colspan="5">
				<input id="observacion" name="observacion" <%=readonly%> class="style5" style="font-size:10px; text-align:center; color:#333333" value="<%=observacion %>" size="120" >
			</td>
		  </tr>
                  <%

                  }
                }            /***/
%>


		   <tr>
		  	<td colspan="6">
				<table align="center" cellpadding="1" cellspacing="0" border="1" width="100%">
		           <tr class="style1" style="border:none; background:url(../html/images/inicio_3.png)">
        	           <th style="border:none"><span class="Estilo1 Estilo4">CODIGO</span></th>
					 <th style="border:none"><span class="Estilo1 Estilo4">CANTIDAD</span></th>
 					 <th style="border:none"><span class="Estilo1 Estilo4">CONCEPTO</span></th>
					 <th style="border:none"><span class="Estilo1 Estilo4">REFERENCIA</span></th>
					 <th style="border:none"><span class="Estilo1 Estilo4">VALOR</span></th>
                  </tr>
				  <% 
			       List<java.util.HashMap> det_tiquete = modelo.listarDetalleTiquete(tiq.getId_tiquete());
					for (java.util.HashMap hash : det_tiquete ) { %>
						 <tr>
							 <td align="center"><span class="Estilo6"><%=hash.get("CODIGO")%></span></td>
							 <td align="center"><span class="Estilo6"><%=hash.get("CANTIDAD")%></span></td>
							 <td align="left"><span class="Estilo6"><%=hash.get("CONCEPTO")%></span></td>
							 <td align="center"><span class="Estilo6"><%=hash.get("REFERENCIA")%></span></td>
							 <td align="right"><span class="Estilo6"><%=hash.get("VALOR")%></span></td>
					   </tr>
				   <%}%>
		        </table>			</td>
		  </tr>
		 <!-- <tr>
			 <td align="center" colspan="3">
                             <%if(0==1){ %>
                                      <input type="button"  style="width:100px; font-size:10px" value="Re-Imprimir" onclick="verReportePago()">
                                <%}else{%>
                                <input type="button"  style="width:100px; font-size:10px" value="Re-Imprimir" onclick="verReportePago()" disabled>
                                <%}%>
                               
              		 </td>

                         <td align="center" colspan="3">
                           <%if(1==0){ %>
                                   <input type="button" value="Anular"  style="width:100px; font-size:10px" onclick="anularPago('<%=id_tiquete%>')"></td>
                           <%}else{%>
                  <input type="button" value="Anular"  style="width:100px; font-size:10px" onclick="anularPago('<%=id_tiquete%>')" disabled></td>
                           <%}%>  


		  </tr>-->
		</table>
	<%  modelo.getCon().commit();
         } %>
        </fieldset>
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
}catch(Exception mexe){
    mexe.printStackTrace();
%>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
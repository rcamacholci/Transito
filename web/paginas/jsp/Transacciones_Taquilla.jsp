<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
                modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Taquilla</title>
<script type="text/javascript" src="../html/scripts/motorAjax.js"></script>
<script type="text/javascript" src="../html/scripts/transaccionesTaquilla.js"></script>
<link rel=StyleSheet href="../html/css/msj.css" Ttype="text/css" media=screen/>

<style type="text/css">
<!--
.Estilo7 {
	color: #333333;
	font-size: 12px;
	font-weight: bold;
}
.Estilo8 {
	font-size: 14px;
	color: #333333;
	font-weight: bold;
}
.style2 {font-size: 12px; color: #333333; font-weight: bold; font-family: Tahoma; }
.style3 {font-size: 11px}
.style5 {font-size: 10px}
.style8 {color: #333333; font-size: 11px; font-weight: bold; font-family: Tahoma; }
.style9 {color: #FFFFFF}
.style10 {color: #FFFFFF; font-size: 11px; font-weight: bold; }
.Estilo11 {color: #DE2021}

-->
</style>

</head>
<%@page import="modelo.*"%>
<%@page import="java.util.*"%>
<body>
<%  
try{
  Model modelo= (Model)session.getAttribute("model"); 
  Taquilla taquilla= new Taquilla();
  Tiquete tiquete = new Tiquete();
  Parametro parametro = new Parametro();
	
  long id_taquilla   =   Long.parseLong(request.getParameter("id_taquilla")) ;
  taquilla = modelo.consultarTaquillaById(id_taquilla);
  usuario = modelo.consultarUsuario(taquilla.getFk_usuario());
  parametro = modelo.consultarParametro(taquilla.getEstado(),18);
  HashMap parameters = new java.util.HashMap();
  parameters.put("TAQUILLA", taquilla.getId_taquilla());
  session.setAttribute("reporteTaquilla", parameters);
  String direccion = "recaudoycartera/taquillas/tiquetesTaquillaReport.jasper";
  String nombreR = "reporteTaquilla";
  
  HashMap parametersN = new java.util.HashMap();
  parametersN.put("FECHA_INI", new java.sql.Date(taquilla.getFecha_ini().getTime()));
  parametersN.put("FECHA_FIN", new java.sql.Date(taquilla.getFecha_ini().getTime()));
  parametersN.put("FK_USUARIO", usuario.getId_usuario());
  parametersN.put("NOM_USUARIO", usuario.getNombre());
  session.setAttribute("reporteNovedad", parametersN);
  String direccionN = "tramites/Novedades.jasper";
  String nombreN = "reporteNovedad";



   %>

   <input type="hidden" name="nombre" id="nombre" value="<%=request.getParameter("nombre")%>" />
   <input type="hidden" name="codigo" id="codigo" value="<%=request.getParameter("codigo")%>"/>
   <input type="hidden" name="date" id="date" value="<%=request.getParameter("date")%>"/>
  <input type="hidden" name="date2" id="date2" value="<%=request.getParameter("date2")%>"/>
  <fieldset>
  <table width="100%" border="0" align="center">
	<tr>
       <td colspan="6"><div align="center"><span class="style2">TAQUILLA CAJA <%=request.getParameter("nombre")%></span></div></td>
	</tr>
	<tr>
	   <td colspan="6">&nbsp;</td>
       
	</tr>
	
	<tr class="style2">
	   <td width="10%"><span class="style2">TAQUILLA</span></td>
	   <td width="23%"><input name="taquilla" id="taquilla" type="text" size="20" value="<%=taquilla.getId_taquilla()%>" style="color:#333333;text-align:center" readonly/></td>
	   <td width="10%" class="Estilo7">USUARIO</td>
	   <td width="23%"><input name="usuario" type="text" size="20"  value="<%= usuario.getNombre()%>" style="color:#333333;text-align:center" readonly/></td>
	   <td width="10%" class="Estilo7">ESTADO</td>
	   <td width="23%"><input name="estado" id="estado" type="text" size="20" value="<%= parametro.getNombre() %>"  style="color:#333333;text-align:center" readonly/></td>
    </tr>
	 <tr class="style2">
	   <td class="Estilo7">FECHA&nbsp;INICIO</td>
	   <td><input name="fecha_inicio" type="text" size="20" value="<%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(taquilla.getFecha_ini())%>" style="color:#333333;text-align:center" readonly/>	   </td>
	   <td class="Estilo7">HORA&nbsp;INICIO</td>
	   <td><input name="hora_inicio" type="text" size="20"  value="<%= new java.text.SimpleDateFormat("HH:mm:ss").format(taquilla.getFecha_ini())%>" style="color:#333333;text-align:center" readonly/>	   </td>
	   <td class="Estilo7">HORA&nbsp;CIERRE</td>
	   <td><input name="hora_cierre" type="text" size="20" value="<%=taquilla.getFecha_fin()!=null?new java.text.SimpleDateFormat("HH:mm:ss").format(taquilla.getFecha_fin()):""%>" style="color:#333333;text-align:center" readonly/>	   </td>
        </tr>
  	 <tr class="style2">
	    <td class="Estilo7">VALOR&nbsp;TOTAL</td>
    	<td><input name="valor_total" id="valor_total" type="text" size="20"  value="<%= 0.0%> " style="color:#333333;text-align:center" readonly/></td>
<% String estado1=parametro.getNombre().equals("CERRADA")?"DISTRIBUIR TAQUILLA":parametro.getNombre();
   String estado2=parametro.getNombre().equals("CERRADA")?"":"disabled"; %> 
	    <td>&nbsp;</td>
            <%
            Taquilla taq = modelo.consultarTaquillaById(taquilla.getId_taquilla());

            if(taq.getFecha_fin()!=null){ %>
            <td colspan="" align="left"><input name="accion" type="button" size="20" id="accion" value="<%=estado1%>" onclick="procesarTaquilla()" <%=estado2%> readonly/></td>
             <%}else{%>
            <td colspan="" align="left"><input name="accion" type="button" size="20" id="accion" disabled value="<%=estado1%>" onclick="procesarTaquilla()" <%=estado2%> readonly/></td>
            <%}%>
                <td class="Estilo7">&nbsp;</td>
	    <td><input name="cancelar" type="button" id="cancelar" value="Atras" style="width:100px; text-align:center" onclick="atras()"/></td>
    </tr>
	
			<tr><td colspan="6">&nbsp;</td></tr>
		
	  <tr>
	  	<td colspan="6">
			<table width="100%" border="0" align="center">
				<tr>
					<td width="100%" align="center">
					   <table width="100%" border="1" align="center" cellpadding="1" cellspacing="0" id="tabla1">
						 
						 <tr style="border:none" >
						   <td height="38" colspan="7" bordercolor="#FFFFFF" class="Estilo8" style="border:none"><div align="center" class="style2">LISTADO DE PAGOS EN TAQUILLA</div>	
				           </td>
						  <td colspan="1">
						  <img src="../html/images/reporte.png" width="22" height="22" style="cursor:pointer" onclick="verReporte('<%=direccion%>','<%=nombreR%>')"/> <span class="style5 style15 Estilo11"><strong>TAQUILLA</strong></span>
						  </td>	 
						   <td colspan="1">
						  <img src="../html/images/reporte.png" width="22" height="22" style="cursor:pointer" onclick="verReporteNovedades('<%=direccionN%>','<%=nombreN%>')"/> <span class="style5 style15 Estilo11"><strong>NOVEDADES</strong></span>
						  </td>	  
						</tr>
						
						  <tr style="border:none; background:url(../html/images/inicio_3.png)">
                                                       <td width="2%"><div align="center" class="Estilo7 style3 style9">#</div></td>
							<td width="12%"><div align="center" class="Estilo7 style3 style9">TIPO PAGO </div></td>
							<td width="8%"><div align="center" class="style10">FACTURA</div></td>
							<td width="8%"><div align="center" class="style10">PLACA</div></td>
							<td width="8%"><div align="center" class="style10">FECHA</div></td>
							<td width="12%"><div align="center" class="style10">DOCUMENTO</div></td>
							<td width="30%"><div align="center" class="style10">NOMBRE&nbsp;PERSONA </div></td>
							<td width="8%"><div align="center" class="style10">ESTADO</div></td>
							<td width="11%"><div align="center" class="style10">VALOR</div></td>
						 </tr>
					  <%
							 
							  Persona persona = new Persona();
						   tiquete            =   modelo.consultarTiquete(taquilla.getId_taquilla());
						   Parametro param = new Parametro();
						   Parametro pmetro = new Parametro();
						   java.text.SimpleDateFormat   sdf  =new java.text.SimpleDateFormat("dd/MM/yyyy");
						   String fecha_tiquete= sdf.format(taquilla.getFecha_ini());
						   List list =modelo.listarTiquete(taquilla.getId_taquilla());
						   java.util.HashMap listaTipos = modelo.crearHashParametrosAbreviatura(5);
						   String nombre="";
						   double total=0;
						   for(int i=0;i<list.size();i++){
							   Tiquete tiq = (Tiquete)list.get(i);
							   param=  modelo.consultarParametro(tiq.getTipo_pago(),301);
							   pmetro= modelo.consultarParametro(tiq.getEstado()!=4?tiq.getEstado():tiq.getEstado_preliquidacion(),tiq.getEstado() != 4?77:355);
							   persona=modelo.consultarPersona(tiq.getFk_persona());
											  if(tiq.getEstado()==3)
													total=total+tiq.getValor_total();
							   String placaV = "";
							   if(tiq.getFk_vehiculo()!=0){
                                                               placaV = modelo.consultarVehiculoById(tiq.getFk_vehiculo()).getPlaca();
							   }else{
                                                               if(tiq.getDescripcion()!=null)
                                                                   placaV = tiq.getDescripcion().toUpperCase();
                                                           }
							   nombre=persona.getApellido_1() + " " + (persona.getApellido_2() != null ? persona.getApellido_2() : "") + " " + persona.getNombre_1();
												%>
                                                                <%if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("detallePago.jsp")){ %>
                                                                        <tr bordercolor="#FFFFFF" class="style2" style="cursor:pointer" ondblclick="DetalleTiquete('<%=tiq.getId_tiquete()%>')"  onMouseOver="sombrear(this)" onMouseOut="renovar(this)"   >
								<%}else{%>
                                                                        <tr bordercolor="#FFFFFF" class="style2" style="cursor:pointer" onMouseOver="sombrear(this)" onMouseOut="renovar(this)"   >
                                                                <%}%>
                                                                            <td align="center" style="font-size:11px"><span class="style5"><%= (i+1) %></span></td>
                                                                            <td align="center" style="font-size:11px"><span class="style5"><%= param.getNombre() %></span></td>
                                                                            <td align="center" style="font-size:11px"><span class="style5"><%= tiq.getNumero_factura() %></span></td>
                                                                            <td align="center" style="font-size:11px"><span class="style5"><%= placaV%></span></td>
                                                                            <td align="center" style="font-size:11px"><span class="style5"><%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(tiq.getFecha())%></span></td>
                                                                            <td align="center" style="font-size:11px"><span class="style5"><%=listaTipos.get(persona.getTipo_documento() + "")+" "+persona.getDocumento()%></span></td>
                                                                            <td align="center" style="font-size:11px"><span class="style5"><%=nombre%></span></td>
                                                                            <td align="center" style="font-size:11px"><span class="style5"><%= pmetro.getNombre() %></span></td>
                                                                            <td align="right" style="font-size:11px"><span class="style5"><%= tiq.getValor_total() %></span></td>
                                                                        </tr>
					   <% } %>
                                           <script language="javascript" type="text/javascript">document.getElementById("valor_total").value = <%=total%>;</script>
					</table>
				</td>
			</tr>
			<tr>
				<td width="100%" align="center">		
					<table width="100%" border="0" align="center" cellpadding="0" cellspacing="0" id="tabla2" style="display:none">
						<tr>			
										<td width="10%" align="center" colspan="6">&nbsp;
											
										</td>
										<td width="80%" align="center" colspan="6">
											<iframe frameborder="0" src="detallePago.jsp" width="700" height="300" id="detalle"></iframe>
										</td>
										<td width="10%" align="center" colspan="6">
											<input type="button" name="cerrar" value="Cerrar" onclick="cerrar()"> 
										</td>										
						</tr>
					</table>
				</td>
			</tr>
		</table>			
		</td>
	  </tr>
	  <tr>
	  <td colspan="6">&nbsp;</td>
	  </tr>
  </table>
</fieldset>
<% }catch(Exception ex){
     ex.printStackTrace();
  } %>
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
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.*" import="java.util.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){
%>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title></title>
<style type="text/css">
<!--
.style7 {color: #FFFFFF; font-size: 12px; font-family: Tahoma; font-weight: bold; }
.style21 {
	font-family: Tahoma;
	font-size: 12px;
	font-weight: bold;
	color: #333333;
}
.Estilo7 {font-family: Tahoma; font-size: 11px; color: #333333; }
-->
</style>
<script language="javascript" type="text/javascript">
	function mostrar(tr){
		document.location.href = "formularioTramite.jsp?id_radicacion="+tr.id;
	}
	function sombrear(tr){
		tr.style.backgroundColor="#CCCCCC";
	}
	function renovar(tr){
		tr.style.backgroundColor="#FFFFFF";
	}

</script>



</head>
<body>
<%
	Model modelo= (Model)session.getAttribute("model");
	String placa = "";
	if(request.getParameter("id")=="0"){
		placa =  request.getParameter("placa");
	}else{
		placa =  session.getAttribute("placa")+"";
	}
	Tramite tramite= new Tramite();
	Formulario formulario=new Formulario();
	Vehiculo vehiculo  = new Vehiculo();
	vehiculo=modelo.consultarVehiculo(placa.toUpperCase());
        //System.out.println(" Placa "+placa);
        placa = placa.toUpperCase();
        //System.out.println("placa "+ placa);
   //Vehiculo temp = model.consultarVehiculo(placa);
        if(placa.length()==6 && vehiculo!=null){
                if(Character.isLetter(placa.charAt(2))){
                    if(placa.charAt(2)<='J'){
                        int newDgto = (((int)placa.charAt(2))-64)%10;
                        placa = new StringBuffer(placa).replace(2, 3, newDgto+"").toString();
                        //vehiculo=modelo.consultarVehiculo(placa);
                    }
                }else{
                        char newChar = (char)(74-((10-Integer.valueOf((placa.charAt(2)+"")))%10));
                        placa = new StringBuffer(placa).replace(2, 3, newChar+"").toString();
                       //vehiculo=modelo.consultarVehiculo(placa);
                }
            }


	if(placa!=null){
%>

<p align="center" class="style21">TRAMITES</p>
	<div align="center">
	  <table width="90%" border="1" cellpadding="1" cellspacing="0" align="center">

		<tr style="border:none; background:url(../html/images/inicio_3.png)">
		  <th width="10%" style="border:none" scope="col"><span class="style7">NUMERO</span></th>
		  <th width="22%" style="border:none" scope="col"><span class="style7">FECHA</span></th>
		  <th width="10%" style="border:none" scope="col"><span class="style7">SOLICITUD</span></th>
		  <th width="35%" style="border:none" scope="col"><span class="style7">TRAMITE</span></th>
		  <th width="15%" style="border:none" scope="col"><span class="style7">VENAL</span></th>
		  <th width="20%" style="border:none" scope="col"><span class="style7">ESTADO</span></th>
		  </tr>
	<%
                List list=modelo.consultar_Formularios(placa);

          Formulario formu = modelo.consultarUltimoFormulario(placa);
              if(formu==null){
                if(Character.isLetter(placa.charAt(2))){
                    if(placa.charAt(2)<='J'){
                        int newDgto = (((int)placa.charAt(2))-64)%10;
                        placa = new StringBuffer(placa).replace(2, 3, newDgto+"").toString();
                        //vehiculo=modelo.consultarVehiculo(placa);
                        list=modelo.consultar_Formularios(placa);
                    }
                }else{
                        char newChar = (char)(74-((10-Integer.valueOf((placa.charAt(2)+"")))%10));
                        placa = new StringBuffer(placa).replace(2, 3, newChar+"").toString();
                        //vehiculo=modelo.consultarVehiculo(placa);
                        list=modelo.consultar_Formularios(placa);
                }
            }

                Iterator it = list.iterator();
		while (it.hasNext()) {
                    formulario = (Formulario)it.next();
                    tramite=modelo.consultarTramite(formulario.getFk_tramite());
                    Radicacion radicacion = modelo.consultar_Radicacion(formulario.getFk_radicacion());
                    String estado = modelo.consultarParametroName(52,radicacion.getEstado());
                    String  solicitud = modelo.consultarSolicitudRadicacionRUNT(radicacion.getId_radicacion(),1);
                    Licencia_Transito venal = modelo.consultarLicenciaTransitoRadicacion(radicacion.getId_radicacion());
		%>
      <tr bgcolor="#FFFFFF" onMouseOver="sombrear(this)"  style="cursor:pointer" onclick="mostrar(this)"  onMouseOut="renovar(this)" id="<%=radicacion.getId_radicacion()%>" >
	   <th scope="col"><span class="Estilo7"><%=radicacion.getNumero()%></span></th>
      <th scope="col"><span class="Estilo7"><%=new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm:ss").format(formulario.getFecha_tramite())%></span></th>
      <th scope="col"><span class="Estilo7"><%=solicitud!=null?solicitud:""%></span></th>
      <th scope="col"><span class="Estilo7"><%=tramite.getNombre()%></span></th>
	   <th scope="col"><span class="Estilo7"><%=venal!=null?venal.getNumero():""%></span></th>
	    <th scope="col"><span class="Estilo7"><%=estado%></span></th>
    </tr>
	<% }
		list=modelo.consultarTramitesAsociados(vehiculo.getId_vehiculo());
		it = list.iterator();
		while (it.hasNext()) {
			java.util.HashMap mapa = (HashMap)it.next();  %>
			<tr bgcolor="#FFFFFF" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
			   <th scope="col"><span class="Estilo7">&nbsp;</span></th>
			  <th scope="col"><span class="Estilo7"><%=new java.text.SimpleDateFormat("dd/MM/yyyy hh:mm:ss").format(mapa.get("FECHA"))%></span></th>
			  <th scope="col"><span class="Estilo7">&nbsp;</span></th>
			  <th scope="col"><span class="Estilo7"><%=mapa.get("TRAMITE")%></span></th>
			   <th scope="col"><span class="Estilo7">&nbsp;</span></th>
				<th scope="col"><span class="Estilo7"><%=mapa.get("ESTADO")%></span></th>
			</tr>
	<% }  %>
  </table>
 <% }
%>
</div>
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
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Venales</title>
<style type="text/css">
<!--
.Estilo2 {
	font-size: 12px;
	font-weight: bold;
}
.Estilo4 {
	color: #FFCC00;
	font-weight: bold;
}
.Estilo8 {
	color: #000000;
	font-weight: bold;
}
.Estilo9 {color: #000000}
.Estilo10 {color: #EFEBDE}
.style1 {
	font-size: 12px;
	font-family: Tahoma;
	color: #333333;
}
.style2 {color: #333333}
.style3 {
	color: #333333;
	font-weight: bold;
	font-size: 12px;
	font-family: Tahoma;
}
.style4 {color: #FFFFFF}
.style5 {color: #FFFFFF; font-weight: bold; font-size: 12px; font-family: Tahoma; }
-->
</style>
<script language="javascript" type="text/javascript">



    function addFila(){

    var miTabla = document.getElementById("cuerpoTabla");
    var fila = document.createElement("tr");
    var celda1 = document.createElement("td");
    var celda2 = document.createElement("td");
    celda1.innerHTML = "hola b" + (miTabla.getElementsByTagName("tr").length + 1).toString();
    celda2.innerHTML = "hola c" + (miTabla.getElementsByTagName("tr").length + 1).toString() + "<input type=checkbox>";
    fila.appendChild(celda1);
    fila.appendChild(celda2);
    miTabla.appendChild(fila);



	}

	function ver_venales(tr){
		//window.frames[0].location.href = "listar_venales.jsp?rango="+id+"&id=0&n=0";
                  window.location.href="editar_venal.jsp?venal="+tr.id;

	}
	function regresar(){
		window.location.href="listar_rangos.jsp";
	}


	function ver(n,id,r,c,t,np,est){
		if(n==0){
			document.location = "listar_venales.jsp?rango="+r+"&id=0&np="+np+"&est="+est;
		}else{
			if(n==2){
				if((id+c)<t){
					id = id + c;
					document.location = "listar_venales.jsp?rango="+r+"&id="+id+"&np="+np+"&est="+est;
				}
			}else{
				if(n==1){
					if((id-c)>=0){
						id = id - c;
						document.location = "listar_venales.jsp?rango="+r+"&id="+id+"&np="+np+"&est="+est;
					}
				}else{
					id = (t/c)*c-1;
					document.location = "listar_venales.jsp?rango="+r+"&id="+id+"&np="+np+"&est="+est;
				}
			}
		}
	}
	function buscarPlaca(r){
            var np = document.getElementById("placa").value;
            var est = document.getElementById("estado").value;
            document.location = "listar_venales.jsp?rango="+r+"&id=0&np="+np+"&est="+est;
        }

        function reportePreasignacion(r){
            var np = null;
            var est = 3;
            document.location = "verreporteVenalpreasig.jsp?rango="+r+"&id=0&est="+est;
        }

</script>
</head>

<body>
<%
Model model= (Model)session.getAttribute("model");
long id_rango=Long.parseLong(request.getParameter("rango")) ;
Rango rango=model.consultar_Rango(id_rango);
Parametro p=model.consultarParametro(rango.getTipo(), 161);
String placa = "";
if(request.getParameter("np")!=null){
            placa = request.getParameter("np").toUpperCase();
}
String estado = "0";
if(request.getParameter("est")!=null){
            estado = request.getParameter("est");
}%>
<fieldset  style="width:inherit"><div align="center">
  	<legend align="center" class="style2 style1"><strong>DETALLE DEL VENAL</strong></legend>
 	</div>
<table width="80%" border="0" align="center">
  <tr class="style3">
    <td width="12%"  style="color:#000000"><span class="style3">Nº&nbsp;INICIAL </span></td>
    <td width="21%"><span class="Estilo9">
      <label>
      <input name="ninicial"  style="text-align:center" type="text" readonly="" id="ninicial" value="<%= rango.getNumero_ini() %>" />
      </label>
    </span></td>
    <td colspan="4"><div align="center" class="style3 style2"><strong>NUMERO&nbsp;FINAL</strong></div></td>
    <td width="20%"><span class="Estilo9">
      <input name="textfield" type="text" style="text-align:center" value="<%=rango.getNumero_fin() %>"  readonly=""/>
    </span></td>
    <td width="11%"  style="color:#000000"><strong class="style3">RESOLUCION</strong></td>
    <td width="21%"><span class="Estilo9">
      <label></label>
      <input name="resolucion" type="text" id="resolucion" style="text-align:center" value="<%=rango.getResolucion() %>"  readonly=""/>
    </span></td>
  </tr>
  <tr class="style3">
    <td  style="color:#000000"><span class="style3"><strong>TIPO&nbsp;PLACA </strong></span></td>
    <td><span class="Estilo9">
      <label>
      <input name="tipo_venal" style="text-align:center; font-size:12px; width:140px" type="text" id="tipo_venal"  readonly="" value="<%=p.getNombre()%>"/>
      </label>
    </span></td>
    <td colspan="4"><div align="center" class="style3"><strong>F.&nbsp;RESOLUCION </strong></div></td>
    <td><input name="textfield3" type="text"  style="text-align:center" value="<%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(rango.getFecha_resolucion())%>"  readonly=""/></td>
    <td  style="color:#000000"><span class="style3"><strong>F.&nbsp;CAPTURA</strong></span></td>
    <td><span class="Estilo9">
      <label>
      <input type="text" name="textfield2"  readonly="" style="text-align:center" value="<%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(rango.getFecha_proceso())%>"/>
      </label>
    </span></td>
  </tr>
</table>
</fieldset>
<fieldset  style="width:inherit"><div align="center">
  	<legend align="center" class="style2 style1"><strong>FILTRO DE BUSQUEDA DE PLACAS </strong></legend>
 	</div>
<table width="80%" border="0" align="center">
  <tr class="style3">
    <td width="12%"  style="color:#000000"><span class="style3">Nº&nbsp;PLACA </span></td>
    <td width="21%"><span class="Estilo9">
      <label>
      <input name="placa"  style="text-align:center" type="text" id="placa" value="<%=placa%>" />
      </label>
    </span></td>
    <td colspan="4"><div align="center" class="style3 style2"><strong>ESTADO</strong></div></td>
    <td width="20%"><span class="Estilo9">
      <select  name="estado" id="estado" style="width:140px">
          <option value="0" selected="selected">----Todos----</option>
        <% java.util.List estados = model.listadoParametros(162);
             for (int i = 0; i < estados.size(); i++) {
                Parametro parametro = (Parametro) estados.get(i);
                if(String.valueOf(parametro.getCodigo()).equals(estado)){ %>
                   <option value="<%=parametro.getCodigo()%>" selected><%= parametro.getNombre()%> </option>
         <%     }else{ %>
                    <option value="<%=parametro.getCodigo()%>"><%= parametro.getNombre()%> </option>
           <%   }
             } %>
       </select>
    </span></td>
    <td width="11%"  style="color:#000000">&nbsp;</td>
    <td width="21%"><span class="Estilo9">
      <label></label>
      <input name="buscar" type="button" id="buscar" style="text-align:center" value="Buscar Placa" onclick="buscarPlaca(<%=id_rango%>)"/>
    </span></td>
    <td width="21%"><span class="Estilo9">
      <label></label>
      <input name="Reporte" type="button" id="reporte" style="text-align:center" value="Reporte preasignacion" onclick="reportePreasignacion(<%=id_rango%>)"/>
    </span></td>
  </tr>
</table>
</fieldset>
<fieldset  style="width:inherit"><div align="center">
  	<legend align="center" class="style2 style1"><strong>LISTADO DE RANGOS DE PLACAS</strong></legend>
 	</div>
<table width="90%" border="1" align="center" id="tabla_detalle" cellpadding="1" cellspacing="0">

  <tr bgcolor="#CCCCCC" style="border:none;background:url(../html/images/inicio_3.png)">
    <td width="10%" style="color:#000000;border:none"><div align="center" class="style3 style4"><strong>NUMERO</strong></div></td>
    <td width="30%" style="color:#000000;border:none"><div align="center" class="style5">ESTADO</div></td>
    <td width="30%" style="color:#000000;border:none"><div align="center" class="style5"><strong>RADICACION</strong></div></td>
    <td width="30%" style="color:#000000;border:none"><div align="center" class="style5"><strong>FECHA&nbsp;UTILIZADA</strong></div></td>
    <td width="30%" style="color:#000000;border:none"><div align="center" class="style5"><strong>FECHA&nbsp;PREASIGNADA</strong></div></td>
  </tr>

 <%
  List listaVenales = model.listarVenales(rango.getId_rango(),placa,estado);
  int cr = 10;//Cantidad Registros
  int id = Integer.parseInt(request.getParameter("id"));

  int size = listaVenales.size();
  for(int i=id;i<(id+cr)&&i<listaVenales.size();i++){
      Venal venal = (Venal)listaVenales.get(i);
      Parametro parametro = model.consultarParametro(venal.getEstado(), 162);
      String numeroRadicacion = "";
        String ultimoTramite = "";



     if(venal.getFk_radicacion()!=0){
         Radicacion radicacion = model.consultar_Radicacion(venal.getFk_radicacion());
         numeroRadicacion = radicacion.getNumero();
//		 ultimoTramite = model.consultarTramite(radicacion.getFk_trami
      }
     %>
      <%if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("editar_venal.jsp")){ %>
         <tr bgcolor="#FFFFFF" class="style3" id="<%=venal.getId_venal()%>"   ondblclick="ver_venales(this)"  >
        <%}else{%>
        <tr bgcolor="#FFFFFF" class="style3" id="<%=venal.getId_venal()%>" >
        <%}%>

        <td align="center" style="color:#000000"><div class="style2" style="font-size:12px"><%= venal.getNumero() %></div></td>
        <td align="center" style="color:#000000"><div class="style2" style="font-size:12px"><%= parametro.getNombre() %></div></td>
        <td align="center" style="color:#000000"><div class="style2" style="font-size:12px"><%=numeroRadicacion %></div></td>
        <td align="center" style="color:#000000"><div class="style2" style="font-size:12px"><%= venal.getFecha_utilizacion()==null?"": new java.text.SimpleDateFormat("dd/MM/yyyy").format(venal.getFecha_utilizacion())%></div></td>
        <%
        Venal_preasignacion venp = model.consultarVenalPreasignacionByVenal(venal.getId_venal());
        if(venp!=null){
        %>
        <td align="center" style="color:#000000"><div class="style2" style="font-size:12px"><%= venp.getFecha_ini()==null?"": venp.getFecha_ini()%></div></td>
        <% }else{ %>
        <td align="center" style="color:#000000"><div class="style2" style="font-size:12px">&nbsp;</div></td>
        <% } %>
     </tr>
<%}%>
</table>

<table width="90%" border="0" align="center">
  <tr>
      <td colspan="6">&nbsp;</td></tr>
  <tr>
<% if(cr<size){%>
      <td align="center"><input type="button" id="inicio" value="Inicio"  style="width:100px" onclick="ver(0,<%=id%>,<%=id_rango%>,<%=cr%>,<%=size%>,'<%=placa%>',<%=estado%>)"/></td>
<%  }else{ %>
        <td align="center"><input type="button" id="inicio" value="Inicio"  style="width:100px" disabled="disabled"/></td>
<%  }
   if((id-cr)>=0){ %>
	 <td align="center"><input type="button" id="anterior" value="Anterior" style="width:100px" onclick="ver(1,<%=id%>,<%=id_rango%>,<%=cr%>,<%=size%>,'<%=placa%>',<%=estado%>)"/></td>
 <% }else{ %>
	 <td align="center"><input type="button" id="anterior" value="Anterior"  style="width:100px" disabled="disabled"/></td>
<% }
   if((id+cr)<size){ %>
 <td align="center"><input type="button" id="siguiente" value="Siguiente" style="width:100px" onclick="ver(2,<%=id%>,<%=id_rango%>,<%=cr%>,<%=size%>,'<%=placa%>',<%=estado%>)"/></td>
<% }else{ %>
    <td align="center"><input type="button" id="siguiente" value="Siguiente" style="width:100px" disabled="disabled"/></td>
<% }
    if(cr<size){%>
        <td align="center"><input type="button" id="fin" value="Final" style="width:100px" onclick="ver(3,<%=id%>,<%=id_rango%>,<%=cr%>,<%=size%>,'<%=placa%>',<%=estado%>)"/></td>
<%  }else{ %>
        <td align="center"><input type="button" id="fin" value="Final" style="width:100px"  disabled="disabled"/></td>
<%  } %>
  </tr>
  <tr><td colspan="6">&nbsp;</td></tr>
  <tr><td colspan="6" align="center"><span style="border:none">
    <input name="cancelar" type="button" id="cancelar" value="Atras" style="width:100px; text-align:center" onclick="regresar()"/>
  </span></td>
  </tr>
</table>
</fieldset>

</body>
</html>

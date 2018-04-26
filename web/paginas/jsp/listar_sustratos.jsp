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

	function ver_sustratos(tr){
		//window.frames[0].location.href = "listar_venales.jsp?rango="+id+"&id=0&n=0";
                  window.location.href="editar_Sustrato.jsp?sustrato="+tr.id;
                       
	}
	function regresar(){
		window.location.href="listarRangosSustratos.jsp";
	}	
	
	
	function ver(n,id,r,c,t,np,est){
		if(n==0){
			document.location = "listar_sustratos.jsp?rangoS="+r+"&id=0&np="+np+"&est="+est;
		}else{
			if(n==2){
				if((id+c)<t){
					id = id + c;
					document.location = "listar_sustratos.jsp?rangoS="+r+"&id="+id+"&np="+np+"&est="+est;
				}
			}else{
				if(n==1){
					if((id-c)>=0){
						id = id - c;
						document.location = "listar_sustratos.jsp?rangoS="+r+"&id="+id+"&np="+np+"&est="+est;
					}
				}else{
					id = (t/c)*c-1;
					document.location = "listar_sustratos.jsp?rangoS="+r+"&id="+id+"&np="+np+"&est="+est;
				}
			}
		}	
	}
	function buscarPlaca(r){
            var np = document.getElementById("sustrato").value;
            var est = document.getElementById("estado").value;
            document.location = "listar_sustratos.jsp?rangoS="+r+"&id=0&np="+np+"&est="+est;
        }
	
</script>
</head>

<body>
<%
Model model= (Model)session.getAttribute("model");  
long id_rangoS=Long.parseLong(request.getParameter("rangoS")) ;
Rango_Sustratos rangoS = model.consultar_Rango_Sustratos(id_rangoS);
Parametro p = model.consultarParametro(rangoS.getTipo(), 338);
String sustrato = "";
if(request.getParameter("np")!=null){
            sustrato = request.getParameter("np").toUpperCase();
}
String estado = "0";
if(request.getParameter("est")!=null){
            estado = request.getParameter("est");
}%>
<fieldset  style="width:inherit"><div align="center">
  	<legend align="center" class="style2 style1"><strong>DETALLE DEL SUSTRATO </strong></legend>
 	</div>
<table width="80%" border="0" align="center">
  <tr class="style3">
    <td width="18%"  style="color:#000000"><span class="style3">Nº&nbsp;INICIAL </span></td>
    <td width="30%"><span class="Estilo9">
      <label>
      <input name="ninicial"  style="text-align:center; width:160px" type="text" readonly="" id="ninicial" value="<%= rangoS.getNum_inicio() %>" />
      </label>
    </span></td>
    <td colspan="3"><div align="center" class="style3 style2"><strong>NUMERO&nbsp;FINAL</strong></div></td>
    <td width="32%" colspan="2"><span class="Estilo9">
      <input name="textfield" type="text" style="text-align:center; width:160px" value="<%=rangoS.getNum_fin() %>"  readonly=""/>
    </span></td>
    
  </tr>
  <tr class="style3">
    <td  style="color:#000000"><span class="style3"><strong>TIPO&nbsp;LIC. </strong></span></td>
    <td><span class="Estilo9">
      <label>
      <input name="tipo_venal" style="text-align:center; font-size:12px; width:160px" type="text" id="tipo_venal"  readonly="" value="<%=p.getNombre()%>"/>
      </label>
    </span></td>
    <td colspan="3"><div align="center" class="style3"><span><strong>F.&nbsp;CAPTURA</strong></span></div></td>
    <td colspan="3"><span class="Estilo9">
      <input type="text" name="textfield2"  readonly="" style="text-align:center; width:160px" value="<%= new java.text.SimpleDateFormat("dd/MM/yyyy").format(rangoS.getFecha_proceso())%>"/>
    </span></td>
    
  </tr>
</table>
</fieldset>
<fieldset  style="width:inherit"><div align="center">
  	<legend align="center" class="style2 style1"><strong>FILTRO DE BUSQUEDA DE PLACAS </strong></legend>
 	</div>
<table width="80%" border="0" align="center">
  <tr class="style3">
    <td width="12%"  style="color:#000000"><span class="style3">Nº&nbsp;SUSTRATO</span></td>
    <td width="21%"><span class="Estilo9">
      <label>
      <input name="sustrato"  style="text-align:center" type="text" id="sustrato" value="<%=sustrato%>" />
      </label>
    </span></td>
    <td colspan="4"><div align="center" class="style3 style2"><strong>ESTADO</strong></div></td>
    <td width="20%"><span class="Estilo9">
      <select  name="estado" id="estado" style="width:140px">
          <option value="0" selected="selected">----Todos----</option>
        <% java.util.List estados = model.listadoParametros(339);
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
      <input name="buscar" type="button" id="buscar" style="text-align:center" value="Buscar Sustrato" onclick="buscarPlaca(<%=id_rangoS%>)"/>
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
  </tr>
    
 <%
  List listaSustratos = model.listarSustratos(rangoS.getId_rango_sustrato(),sustrato,estado);
  int cr = 10;//Cantidad Registros
  int id = Integer.parseInt(request.getParameter("id"));
  
  int size = listaSustratos.size();
  for(int i=id;i<(id+cr)&&i<listaSustratos.size();i++){
      Sustratos Sustra = (Sustratos)listaSustratos.get(i);
      Parametro parametro = model.consultarParametro(Sustra.getEstado(), 339);
      String numeroRadicacion = "";
  	  String ultimoTramite = "";
     if(Sustra.getFk_radicacion()!=0){
         Rango_Sustratos rango_sustrato = model.consultar_Rango_Sustratos(Sustra.getFk_rango_sustrato());
         if(rango_sustrato!=null){
            if(rango_sustrato.getTipo()==1){
             Radicacion radicacion = model.consultar_Radicacion(Sustra.getFk_radicacion());
             numeroRadicacion = radicacion.getNumero();
             }else{
             Radicacion_Licencia radicacionL = model.consultar_RadicacionLicencia(Sustra.getFk_radicacion());
             numeroRadicacion = radicacionL.getNumero();
              }
    //		 ultimoTramite = model.consultarTramite(radicacion.getFk_trami
      }
         }
     %>
      <%if(((java.util.LinkedList)session.getAttribute("permisosU")).contains(request.getServletPath().substring(request.getServletPath().lastIndexOf("/")+1,request.getServletPath().length()))){ %>
         <tr bgcolor="#FFFFFF" class="style3" id="<%=Sustra.getId_sustrato()%>"   ondblclick="ver_sustratos(this)"  >
        <%}else{%>
        <tr bgcolor="#FFFFFF" class="style3" id="<%=Sustra.getId_sustrato()%>" >
        <%}%>

        <td align="center" style="color:#000000"><div class="style2" style="font-size:12px"><span class="style2" style="font-size:12px"><%= Sustra.getNumero() %></span></div></td>
        <td align="center" style="color:#000000"><div class="style2" style="font-size:12px"><%= parametro.getNombre() %></div></td>
        <td align="center" style="color:#000000"><div class="style2" style="font-size:12px"><%=numeroRadicacion %></div></td>
        <td align="center" style="color:#000000"><div class="style2" style="font-size:12px"><%= Sustra.getFecha_utilizacion()==null?"": new java.text.SimpleDateFormat("dd/MM/yyyy").format(Sustra.getFecha_utilizacion())%></div></td>
    </tr>
<%}%>
</table>

<table width="90%" border="0" align="center">

  <tr>
      <td colspan="6">&nbsp;</td></tr>
  <tr>
<% if(cr<size){%>
      <td align="center"><input type="button" id="inicio" value="Inicio"  style="width:100px" onclick="ver(0,<%=id%>,<%=id_rangoS%>,<%=cr%>,<%=size%>,'<%=sustrato%>',<%=estado%>)"/></td>
<%  }else{ %>
        <td align="center"><input type="button" id="inicio" value="Inicio"  style="width:100px" disabled="disabled"/></td>
<%  }
   if((id-cr)>=0){ %>
	 <td align="center"><input type="button" id="anterior" value="Anterior" style="width:100px" onclick="ver(1,<%=id%>,<%=id_rangoS%>,<%=cr%>,<%=size%>,'<%=sustrato%>',<%=estado%>)"/></td>
 <% }else{ %>
	 <td align="center"><input type="button" id="anterior" value="Anterior"  style="width:100px" disabled="disabled"/></td>
<% }
   if((id+cr)<size){ %>
 <td align="center"><input type="button" id="siguiente" value="Siguiente" style="width:100px" onclick="ver(2,<%=id%>,<%=id_rangoS%>,<%=cr%>,<%=size%>,'<%=sustrato%>',<%=estado%>)"/></td>
<% }else{ %>
    <td align="center"><input type="button" id="siguiente" value="Siguiente" style="width:100px" disabled="disabled"/></td>
<% }
    if(cr<size){%>
        <td align="center"><input type="button" id="fin" value="Final" style="width:100px" onclick="ver(3,<%=id%>,<%=id_rangoS%>,<%=cr%>,<%=size%>,'<%=sustrato%>',<%=estado%>)"/></td>
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

<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Tramite" import="modelo.Liquidacion" errorPage="" %>
<%
try{
if(session.getAttribute("usuario")!=null){
    modelo.Model model = (modelo.Model)session.getAttribute("model");
    if(model!=null){
        modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");
        if(model.tienePermiso(usuario.getId_usuario(), 56)){
%>
<html>
<head>
    <TITLE></TITLE>
	<script language="javascript" type="text/javascript">
        function adicionar(id){
            var placa = document.getElementById('placa').value;
            var valCheck = document.getElementById('valorCheck').value;
            window.parent.parent.frames[4].location.href = "verLiquidacion.jsp?id="+id+"&tipo=2&valor1="+document.getElementById('valor1').value+"&valor2="+document.getElementById('valor2').value+"&sede="+document.getElementById('sede').value+"&placa="+placa+"&check="+valCheck;
            var tabla = document.getElementById('tabla');
            trs = tabla.getElementsByTagName('tr');
            for(var i = 0; i<trs.length ; i++){
                if(trs[i].id == id){
                    tabla.deleteRow(i);
                }
            }
	}
		function sombrear(tr){
			tr.style.backgroundColor="#CCCCCC";
		}
		function renovar(tr){
			tr.style.backgroundColor="#FFFFFF";
		}
	</script>
<style type="text/css">
<!--
.Estilo1 {font-size: 12px}
.Estilo3 {color: #333333}
.Estilo4 {font-size: 11px}
.Estilo5 {font-size: 12px; color: #FFFFFF; }
.Estilo7 {font-size: 12px; color: #333333; font-weight: bold; }
-->
</style>
</head>
<body>
<% try{
        if (!request.getParameter("sede").equals("")) {
             if(request.getParameter("clase")!=null){
                 if(request.getParameter("clase").equals("1")||request.getParameter("clase").equals("4")||request.getParameter("clase").equals("5")){
                    session.setAttribute("claseV",request.getParameter("valor1"));
                    session.removeAttribute("claseL");
                 }else
                 if(request.getParameter("clase").equals("2")){
                    session.setAttribute("claseL",request.getParameter("valor1"));
                    session.removeAttribute("claseV");
                 }
             }
             if((request.getParameter("clase").equals("1")&&!request.getParameter("valor1").equals("0")&&!request.getParameter("valor2").equals("0"))||
                (request.getParameter("clase").equals("4")&&!request.getParameter("valor1").equals("0")&&!request.getParameter("valor2").equals("0"))||
                (request.getParameter("clase").equals("5")&& !request.getParameter("valor1").equals("0") && request.getParameter("valor2") != null)||
                (request.getParameter("clase").equals("2")&&!request.getParameter("valor1").equals("0"))||
                 request.getParameter("clase").equals("3")||
                 request.getParameter("clase").equals("6")){
                 java.util.List tramites = model.consultarTramites(Integer.parseInt(request.getParameter("clase")),Integer.parseInt(request.getParameter("sede")));
                 if(tramites.size()>0){  %>

                    <input type="hidden" id="valor1" value="<%=request.getParameter("valor1")%>"/>
                    <input type="hidden" id="valor2" value="<%=request.getParameter("valor2")%>"/>
                    <input type="hidden" id="sede" value="<%=request.getParameter("sede")%>"/>
                    <input type="hidden" id="placa" value="<%=request.getParameter("placa")%>"/>
                    <input type="hidden" id="valorCheck" value="<%=request.getParameter("check")%>"/>
                    <table width="100%" border="1" id="tabla" cellpadding="1" cellspacing="0">
                      <tr style="border:none; background:url(../html/images/inicio_3.png)">
                        <th width="4%" class="Estilo3" scope="col" style="border:none"><span class="Estilo5 Estilo1">
                          <label>X</label>
                        </span></th>
                        <th width="10%" class="Estilo3" scope="col" style="border:none"><span class="Estilo5 Estilo1">
                          <label>CODIGO</label>
                        </span></th>
                        <th width="84%" class="Estilo3" scope="col" style="border:none"><span class="Estilo5 Estilo1">
                          <label>NOMBRE TRAMITE </label>
                        </span></th>
                      </tr>
                      <%
                              java.util.List listaLiquidacion = (java.util.List)session.getAttribute("listaLiquidacion");
                              String placa = request.getParameter("placa");
                              placa = (placa!=null)?placa.toUpperCase():"";
                             // boolean poseeC = model.tieneCarteraActiva(placa);
                              boolean poseeC = false;
                              modelo.Vehiculo vehEstado = model.consultarVehiculo(placa);
                              boolean estadoT = false;
                              boolean estadoC = false;
                              boolean estadoA = false;
                              boolean estadoPG = false;
                              if(vehEstado!=null){
                                  estadoT = vehEstado.getEstado()==4;
                                  estadoC = vehEstado.getEstado()==3;
                                  estadoA = vehEstado.getEstado()==1||vehEstado.getEstado()==5;
                                  estadoPG = vehEstado.getEstado()==7||vehEstado.getEstado()==8;
                              }
                              if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("aplicarPagosRunt")&&!((java.util.LinkedList)session.getAttribute("permisosU")).contains("aplicarPagosTransito"))
                                  poseeC = false;
                              for(int i=0;i<tramites.size();i++){
                                   Tramite tramite = (Tramite)tramites.get(i);
                                   if((poseeC&&tramite.getId_tramite()==19)||
                                      (estadoT&&tramite.getId_tramite()==4)||
                                      (estadoT&&tramite.getId_tramite()==19)||
                                      (estadoC&&tramite.getId_tramite()==8)||
                                      (estadoC&&tramite.getId_tramite()==19)||
                                      (estadoC&&tramite.getId_tramite()==33)||
                                      (estadoPG&&tramite.getId_tramite()==3)||
                                      (estadoPG&&tramite.getId_tramite()==19)||
                                      (estadoA&&!poseeC)||
                                      (vehEstado==null)){
                                        boolean posible = true;
                                        if(listaLiquidacion!=null){
                                            for(int j=0;j<listaLiquidacion.size();j++){
                                                Liquidacion liquidacion = (Liquidacion)listaLiquidacion.get(j);
                                                if(liquidacion.getTipo()==2&&liquidacion.getId_liquidacion()==tramite.getId_tramite()){
                                                    posible = false;
                                                    break;
                                                }
                                           }
                                        }
                                        if(posible){%>
                                          <tr id="<%=tramite.getId_tramite()%>" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                                                <td align="center" style="cursor:pointer">
                                                        <img src="../html/images/adicionar.png" width="19" height="19" onClick="adicionar(<%=tramite.getId_tramite()%>)"/></td>
                                                <td align="center">
                                                  <span class="Estilo7 Estilo3 Estilo4"><font face="Arial, Helvetica, sans-serif"><%=tramite.getId_tramite()%></font></span></td>
                                                <td align="left">
                                                  <span class="Estilo7 Estilo3 Estilo4"><font face="Arial, Helvetica, sans-serif"><%=tramite.getNombre()%></font></span></td>
                                          </tr>
                                      <%
                                      }
                                   }
                                }
                               %>
    </table>
                      <%
                 }else{
               %>
<label><div align="center"><span class="Estilo7">NO EXISTEN TRAMITES ASOCIADOS</span></div></label>
                  <% }
               }else{
                 %>
               <label>
                 <div align="center"><span class="Estilo7">SELECCIONES PARAMETROS</span></div>
                 </label>
                  <%
                }
         }
 } catch (Exception exc) {

 }%>
</body>
 </html>
<%
        }else{  %>
           <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="1"></jsp:param></jsp:forward>
<%        }
     }else{ %>
        <script>window.parent.document.location.href = "../../index.jsp";</script>
<%  }
 }else{ %>
     <script>window.parent.document.location.href = "../../index.jsp";</script>
<% }
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<% } %>
<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.Model"  import="modelo.Vehiculo" import="modelo.Sede"  import="modelo.Tramite" errorPage="" %>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("seleccionTramites.jsp")){

%>
<html>
<head>
    <TITLE></TITLE>
	<script language="javascript" type="text/javascript">
        function retirar(id,tramite){
            window.parent.frames[0].location.href = "tramitesDisponibles.jsp?id="+id+"&tramite="+tramite+"&placa="+document.form.placa.value+"&tipo="+document.form.tipo.value+"&documento="+document.form.documento.value;
            document.location.href = "tramitesSeleccionados.jsp?id="+id+"&placa="+document.form.placa.value+"&tipo="+document.form.tipo.value+"&documento="+document.form.documento.value;
        }
        function sombrear(tr){
                tr.style.backgroundColor="#CCCCCC";
        }
        function renovar(tr){
                tr.style.backgroundColor="#FFFFFF";
        }
        function habilitar(){
            if(parseInt(document.form.cantidad.value)>0){
                if(parseInt(window.parent.document.form.nombre.value.length)>0){
                    window.parent.document.form.enviar.disabled = false;
                }else{
                    window.parent.document.form.enviar.disabled = true;
                }
            }else{
                window.parent.document.form.enviar.disabled = true;
            }
        }
	</script>
<style type="text/css">
<!--
.Estilo3 {color: #333333}
.Estilo7 {font-size: 12px; color: #333333; font-weight: bold; }
.Estilo11 {color: #333333; font-size: 12px; }
.Estilo12 {color: #FFFFFF; font-size: 12px; }
-->
</style>
</head>
<body onload="habilitar()">
<form name="form" action="#" method="post">
<% try{
        Model model = (Model) session.getAttribute("model");
        Sede sede = (Sede)session.getAttribute("sede");
        java.util.List<Integer> seleccionados = new java.util.LinkedList<Integer>();
        String radicacion = (String) session.getAttribute("rn");
        if(session.getAttribute("seleccionados")!=null){
            seleccionados = (java.util.LinkedList)session.getAttribute("seleccionados");
        }
        String placa = "";
        String tipo = "";
        String documento = "";
        if(request.getParameter("id")!=null){
            if(request.getParameter("id").length()>0){
                if(request.getParameter("id").equals("1")||request.getParameter("id").equals("3")||request.getParameter("id").equals("4")){
                    if(request.getParameter("placa")!=null){
                       placa = request.getParameter("placa").toUpperCase();
                    }
                }else{
                    if(request.getParameter("tipo")!=null&&request.getParameter("documento")!=null){
                    }
                }
                if(request.getParameter("tramite")!=null){
                    if(request.getParameter("tramite").length()>0){
                        if(!seleccionados.contains(Integer.parseInt(request.getParameter("tramite")))){
                            seleccionados.add(Integer.parseInt(request.getParameter("tramite")));
                        }
                    }
                }
            }
        }
        %>
        <input type="hidden" name="cantidad" id="cantidad" value="<%=seleccionados.size()%>"/>
<%      if(seleccionados.size()>0){  %>
             <input type="hidden" name="placa" id="placa" value="<%=placa%>"/>
             <input type="hidden" name="tipo" id="tipo" value="<%=tipo%>"/>
             <input type="hidden" name="documento" id="documento" value="<%=documento%>"/>
             <input type="hidden" name="radicacion" id="radicacion" value="<%=radicacion%>"/>
             <table width="100%" border="1" id="tabla" cellpadding="1" cellspacing="0">
                  <tr  style="border:none; background:url(../html/images/inicio_3.png)">
                       <th width="4%" class="Estilo12" style="border:none" scope="col">X</th>
                       <th width="10%" class="Estilo12" style="border:none" scope="col">CODIGO</th>
                       <th width="84%" class="Estilo12" style="border:none" scope="col">NOMBRE&nbsp;TRAMITE</th>
                  </tr>
                  <%
                  Tramite tramite = model.consultarTramite(seleccionados.get(0));
                  java.util.List ordenT = model.consultarTramites(tramite.getClase_tramite(), sede.getId_sede());
                  for(int t=0;t<ordenT.size();t++){
                      tramite = (Tramite)ordenT.get(t);
                      if(seleccionados.contains((int)tramite.getId_tramite())){ %>
                        <tr id="<%=tramite.getId_tramite()%>" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                           <td align="center" style="cursor:pointer">
                               <img src="../html/images/remover.png" width="19" height="19" class="Estilo3" onClick="retirar(<%=request.getParameter("id")%>,<%=tramite.getId_tramite()%>)"/>                           </td>
                           <td align="center"><span class="Estilo11"><%=tramite.getId_tramite()%></span></td>
                           <td align="left"><span class="Estilo11"><%=tramite.getNombre()%></span></td>
                        </tr>
                  <%  }
                   } %>
            </table>
            <script language="javascript" type="text/javascript">habilitar();</script>
     <%  }
 } catch (Exception exc) {
        exc.printStackTrace();
 }%>
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

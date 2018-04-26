<% request.setCharacterEncoding("UTF-8"); %> <%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="modelo.DatosVehiculo" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("consultarAcuerdosdePago.jsp")){
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Prestamos</title>
<style type="text/css">
<!--
.Estilo13 {color: #FFFFFF; font-weight: bold; }
.Estilo20 {font-size: 12px; font-weight: bold;  }
.style9 {color: #FFFFFF; font-weight: bold; font-family: Tahoma; font-size: 12px; }
.style17 {color: #333333; font-size: 11px; font-family: Tahoma; font-weight: bold; }
-->
</style>
<script language="javascript" type="text/javascript">
	function verArchivosPlanos(opcion){
            elem = document.getElementById(opcion);
            if(elem.style.display=='none'){
              elem.style.display='block';
            }else{
              elem.style.display='none';
            }  
        }
	function sombrear(tr){
		tr.style.backgroundColor="#CCCCCC";
	}
	function renovar(tr){
		tr.style.backgroundColor="#FFFFFF";
	}
        function DescargarPlano(id_plano,tipoplano){
            if(tipoplano==1){
                document.location.href = "../descargarSimitComparendo.jsp?id_plano_simit="+id_plano;
            }
            if(tipoplano==2){
                document.location.href = "../descargarSimitRecaudo.jsp?id_plano_simit="+id_plano;
            }
            if(tipoplano==3){
                document.location.href = "../descargarSimitResolucion.jsp?id_plano_simit="+id_plano;
            }

        }

</script>
</head>
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>

<%
Model modelo= (Model)session.getAttribute("model");
Sede sede= (Sede)session.getAttribute("sede");



%>
<body>
<fieldset>
<table width="100%" border="1" cellpadding="1" cellspacing="0">
  <tr style="border:none; background:url(../../html/images/inicio_3.png)">
    <td width="10%"  style="border:none"><div align="center" class="style9">NO</div></td>
    <td width="10%" style="border:none"><div align="center" class="style9">CONSECUTIVO</div></td>
    <td width="35%" style="border:none"><div align="center" class="style9">FECHA GENERACION </div></td>
    <td width="15%" style="border:none"><div align="center" class="style9">ESTADO</div></td>
    <td width="15%" style="border:none"><div align="center" class="style9">USUARIO</div></td>

  </tr>
  <%
   java.util.List lista = new java.util.LinkedList();
   if(request.getParameter("id_plano_simit")!=null){
           lista =  modelo.listarPlanoSimit(Long.parseLong(request.getParameter("id_plano_simit")));
   }else{
           lista =  modelo.listarPlanosSimit();
   }

   for(int i=0;i<lista.size();i++){
    SimitPlano simitplano = (SimitPlano)lista.get(i);
    Parametro parametro = modelo.consultarParametro(simitplano.getEstado(), 342);
    Usuario usuario = modelo.consultarUsuario(simitplano.getFkUsuario());
    
%>

<tr bgcolor="#FFFFFF" id="<%= simitplano.getIdSimitPlano() %>" onclick="verArchivosPlanos('<%= simitplano.getConsecutivo() %>')" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=i+1 %></span></td>
    <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%=simitplano.getConsecutivo() %></span></td>
    <td align="center" style=" border-color:#CCCCCC"><span class="style17" ><%=simitplano.getFechaReporte() %></span></td>
    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=parametro.getNombre() %></span></td>
    <td align="center" style=" border-color:#CCCCCC"><span class="style17"><%=usuario.getNombre() %></span></td>
  </tr>
  <tr>
      <td colspan="2">
           <div id="<%=simitplano.getConsecutivo() %>" style="display:none">
               <table>

                  <tr bgcolor="#FFFFFF" id="<%= usuario.getId_usuario() %>"   ondblclick="edit(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                      <td align="left" colspan="3" width="300px" style=" border-color:#CCCCCC"><span class="style17">Simit Comparendos</span></td>
                      <td align="right" style=" border-color:#CCCCCC" onclick="DescargarPlano('<%=simitplano.getIdSimitPlano() %>','1')"><span class="style17">Descargar</span></td>
                  </tr>

                  <tr bgcolor="#FFFFFF" id="<%= usuario.getId_usuario() %>"   ondblclick="edit(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                    <td align="left" colspan="3" width="300px" align="center" style=" border-color:#CCCCCC"><span class="style17">Simit Resoluciones</span></td>
                    <td align="right" style=" border-color:#CCCCCC" onclick="DescargarPlano('<%=simitplano.getIdSimitPlano() %>','3')"><span class="style17">Descargar</span></td>
                  </tr>

                  <tr bgcolor="#FFFFFF" id="<%= usuario.getId_usuario() %>"   ondblclick="edit(this)" onMouseOver="sombrear(this)" onMouseOut="renovar(this)">
                    <td align="left" colspan="3" width="300px" align="center" style=" border-color:#CCCCCC"><span class="style17">Simit Recaudos</span></td>
                    <td align="right" style=" border-color:#CCCCCC" onclick="DescargarPlano('<%=simitplano.getIdSimitPlano() %>','2')"><span class="style17">Descargar</span></td>
                  </tr>
                  
               </table>
           </div>

      </td>
 </tr>

<%
   }
%>
</table>
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
}catch(Exception mexe){ %>
    <jsp:forward page="no_access.jsp"><jsp:param name="tipo" value="2"></jsp:param><jsp:param name="msgError" value="<%=mexe.getMessage()%>"></jsp:param></jsp:forward>
<%
} %>
<%-- 
    Document   : gestion_caja
    Created on : 25-ene-2009, 12:47:17
    Author     : Javier
--%>

<% request.setCharacterEncoding("UTF-8"); %> <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
   "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="modelo.*"%>
<%@page import="java.util.*"%>
<%@page import="javax.*"%>
<%
try{
	if(session.getAttribute("model")!=null){
		if(((java.util.LinkedList)session.getAttribute("permisosU")).contains("RangoComparendos.jsp")){
                    Model modelo= (Model)session.getAttribute("model");
                    modelo.Usuario usuario = (modelo.Usuario)session.getAttribute("usuario");

%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Caja</title>
        <style type="text/css">
<!--
.Estilo1 {
	color: #CC0000;
	font-weight: bold;
}
.Estilo4 {
	color: #333333;
	font-size: 12px;
}
.Estilo5 {
	color: #333333;
	font-weight: bold;
	font-size: 12px;
}
.Estilo7 {
	font-size: 14px;
	font-weight: bold;
	color: #333333;
}
.style1 {font-family: Tahoma}
.style2 {color: #333333; font-weight: bold; font-size: 12px; font-family: Tahoma; }
.style4 {color: #333333; font-weight: bold; font-size: 10px; font-family: Tahoma; }
-->
        </style>
		<script language="javascript" type="text/javascript">
			function ver_Taquilla(id,name){
				window.location.href = "consultar_taquilla.jsp?id_caja="+id+"&nombre_caja="+name+"&id=0&n=0";
	        }
			function sombrear(tr){
				tr.style.backgroundColor="#CCCCCC";
			}
			function renovar(tr){
				tr.style.backgroundColor="#FFFFFF";
			}
        function edit(tr){
		document.location.href = "AsignarRangosAgentes.jsp?&idrango="+tr.id;
	}
			
		</script>
</head>
    <body>
	<center>
	<p>&nbsp;</p>
	
	  <fieldset>
 <div align="center">
   <legend class="style2" align="center">ADMINISTRAR RANGOS COMPARENDOS</legend>
 </div>
 
  <table width="100%" border="0" align="center" >
      <tr>
	  <td colspan="4"><p>&nbsp;</p></td>        
            <!--<td width="4%" align="right" valign="middle"><div align="center"><img src="../html/images/adicionar.gif" alt="Nueva" name="" width="22" height="22" id="" style="cursor:pointer" onclick="newC()"/><span class="style4">&nbsp;NUEVO</span></div></td>-->
          </tr>
</table>
    <table width="100%" border="1" align="center" cellpadding="1" cellspacing="0" >
	  
      <tr bgcolor="#CCCCCC" style="border:none;  background:url(../html/images/inicio_3.png)"  >
        <td width="" style="border:none"><div align="center" class="Estilo1 Estilo4 style1">ID</div></td>
        <td width="" style="border:none"><div align="center" class="style2">Numero inicial</div></td>
        <td width="" style="border:none"><div align="center" class="style2">Numero final</div></td>
        <td width="" style="border:none"><div align="center" class="style2">Fecha proceso</div></td>
        <td width="" style="border:none"><div align="center" class="style2">Estado</div></td>
        <td width="" style="border:none"><div align="center" class="style2">Disponibles</div></td>
        <td width="" style="border:none"><div align="center" class="style2">Utilizados</div></td>
        <td width="" style="border:none" colspan="2"><div align="center" class="style2">%&nbsp;Asignado</div></td>
        <td width="" style="border:none"><div align="center" class="style2">Numero Resolucion</div></td>
        <td width="" style="border:none"><div align="center" class="style2">Fecha Resolucion</div></td>
      </tr>
      <%
      java.util.List rang = null;
      rang=modelo.ConsultaRangosComparendos();
      java.util.List<Detalle_Rango_Comparendo> det =null;
      Parametro par =null;
      for(int i = 0;i<rang.size();i++){
      Rangos_Comparendos temp = (Rangos_Comparendos)rang.get(i);
      long rango =0;
      long in=Long.parseLong(temp.GetNum_Inicial());
      long fin=Long.parseLong(temp.GetNum_Final());
      rango=fin-in;
      long porc;
      det = modelo.ListarRangosAgentesByrango(temp.GetIdRango());
                            long x =det.size();
                            String color="#00FF00";
                            if((det==null) || (det.size()==0)){
                               porc=0;
                            }else{
                                 porc=(x*100)/rango;
                                 if(porc>=80){
                                     color="#f00000";
                                 }else{
                                    if(porc>=40 && porc<=79){
                                        color="#FFFF00";										
                                    }
                                 }
                            }

                            if(det!=null){
                             rango=rango-x;
                            }



        %>
       <tr id="<%=temp.GetIdRango()%>" onMouseOver="sombrear(this)" onMouseOut="renovar(this)" style="cursor:pointer" ondblclick="edit(this)">
        <td align="center" ><span class="Estilo5 style1"><%=temp.GetIdRango()%></span></td>
        <td align="center"><span class="Estilo5 style1"><%=temp.GetNum_Inicial()%></span></td>
        <td align="center"><span class="Estilo5 style1"><%=temp.GetNum_Final()%></span></td>
        <td align="center"><span class="Estilo5 style1"><%=temp.GetFecha_Proceso()%></span></td>
        <td align="center"><span class="Estilo5 style1"><%=temp.GetEstado()%></span></td>
        <td style="border:"><div align="center" class="style2"><%=rango%></div></td>
        <td style="border:"><div align="center" class="style2"><%=x%></div></td>
        <td style="border:none"><div align="center" class="style2"><progress id="progress" max="100" value="<%=porc%>" title="<%=porc%>%" style="width:100px;"></progress></div></td>
        <td style="border:none"><div align="center" class="style2"><div><font color="<%=color%>"><%=porc%>%</font></div></td>
        <td align="center"><span class="Estilo5 style1"><%=temp.GetNum_resolucion()%></span></td>
        <td align="center" ><span class="Estilo5 style1"><%=temp.GetFecha_Resolucion()%></span></td>
      </tr>
      <%
      }
      %>
    </table>
	  </fieldset>
	  </center>
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